Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDF77E805E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344135AbjKJSJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345986AbjKJSHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:07:04 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6440731E52
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:49:52 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32dff08bbdbso1228855f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699616991; x=1700221791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dnsyLuQheg+/3cWckMMZhRJ3W+3u+GfGV4x7we92iDA=;
        b=V1Jdl+C3z4Ec8wywSBc6E+1wXihOjgXL/Iz/T/GMZ6cLpRixVCxiyWky1gk59OGJ2q
         v1ZQf+mY9woTb3Ep2xvBvZj1slICFKcCAeouE5zljf5DJUHQ6V6/gRS92Tt5OsNXS1N3
         fVUvWY60uNZxgoJwnBOWAKeuH+YF17T41GWcG41lKHXXiyQi3wu2ek7m3wnZFnQsi7H4
         HMjz8pkp4UzamXsf/eBzbp9NosjhjOmy6mgTOCvXF6PyUXo2ym2qWww7SOsKZawneZDc
         nYcOspBTIIGpE4i3mSV5XZX2sEcLxdFEg63aTahg0Tcq5vSoE+zsAXkzPiWtm02HoBKM
         XRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699616991; x=1700221791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnsyLuQheg+/3cWckMMZhRJ3W+3u+GfGV4x7we92iDA=;
        b=i3bST+CGdeuBQ9m/jI/qc1vF3l8yLl/eTHfbeeJAu5DL/zIFR+rF/zwNw2ma/qgOss
         vXSVO7+XxwwzQvZBY1vJYFj742Z/Pfx4D/ceHGi7yY6w2Z+Y7BLld0OeuW0Vysx197h+
         yNOxR5eeheDTzPLC5w2d1C6UPlGlMwx0/rt9sV9u/ozXIlw+czMLqwVTCgc5C7oVGZUP
         COKNc7ZgOQPZSpDj8ltKk8JTZ1IDmVN/e7RmVvZdadxC9yb6/9WjzwHbzNnwo3We7EbP
         vE/70NX5zKpRksgrjIvhM8LWFc8b3B1hZvc0veMXCZgP8f6meyeUdP/jx1oEG+VMJuWT
         MURg==
X-Gm-Message-State: AOJu0YwgfApnYnwLwegPhBM3F5XofffmLIDxsDIPI56EU/SRtGpFgkD/
        qs8RxuH2YJliDIaXBS6jSV/yEA==
X-Google-Smtp-Source: AGHT+IFx+qOZ4g+ruh09/Sbp8yByrjwyQHAeeoLBHucqNe+XW9cf4CGy5NlDwW37k1ZjtwdvqHRvpw==
X-Received: by 2002:a05:6000:18ae:b0:32d:c09d:6ec9 with SMTP id b14-20020a05600018ae00b0032dc09d6ec9mr6686800wri.7.1699616990814;
        Fri, 10 Nov 2023 03:49:50 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d45cf000000b003313069be5dsm1751210wrs.46.2023.11.10.03.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 03:49:50 -0800 (PST)
Message-ID: <31dac823-cc46-401e-85f8-d04544bd38c3@linaro.org>
Date:   Fri, 10 Nov 2023 11:49:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] clk: qcom: videocc-sm8150: Update the videocc resets
Content-Language: en-US
To:     Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20231110065029.2117212-1-quic_skakitap@quicinc.com>
 <20231110065029.2117212-3-quic_skakitap@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231110065029.2117212-3-quic_skakitap@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2023 06:50, Satya Priya Kakitapalli wrote:
> Add all the available resets for the video clock controller
> on sm8150.
> 
> Fixes: 5658e8cf1a8a ("clk: qcom: add video clock controller driver for SM8150")
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>   drivers/clk/qcom/videocc-sm8150.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/qcom/videocc-sm8150.c b/drivers/clk/qcom/videocc-sm8150.c
> index 1afdbe4a249d..6a5f89f53da8 100644
> --- a/drivers/clk/qcom/videocc-sm8150.c
> +++ b/drivers/clk/qcom/videocc-sm8150.c
> @@ -214,6 +214,10 @@ static const struct regmap_config video_cc_sm8150_regmap_config = {
>   
>   static const struct qcom_reset_map video_cc_sm8150_resets[] = {
>   	[VIDEO_CC_MVSC_CORE_CLK_BCR] = { 0x850, 2 },
> +	[VIDEO_CC_INTERFACE_BCR] = { 0x8f0 },
> +	[VIDEO_CC_MVS0_BCR] = { 0x870 },
> +	[VIDEO_CC_MVS1_BCR] = { 0x8b0 },
> +	[VIDEO_CC_MVSC_BCR] = { 0x810 },

Are you sure this shouldn't be

+	[VIDEO_CC_INTERFACE_BCR] = { 0x9ac },
+	[VIDEO_CC_MVS0_BCR] = { 0x870 },
+	[VIDEO_CC_MVS1_BCR] = { 0x8b0 },
+	[VIDEO_CC_MVSC_BCR] = { 0x810 },

?

---
bod

