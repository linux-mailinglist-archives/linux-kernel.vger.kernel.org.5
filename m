Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1F47D8185
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344759AbjJZLHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344710AbjJZLHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:07:02 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741021AD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:06:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507c91582fdso1069401e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698318417; x=1698923217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=toXNFfzr2zB8FMnlgacjGM+iESEOfHX27uyQ115+fBQ=;
        b=TN96z3710cpyTAQ6Rb7vg5fw1uiBvBg/oRZW/FNtUR6HIo677vG3qVWnB0INPeRCyO
         vSWZoZGpCXMd4SV4BCWgueqFFwiE+v0lCnO/gdGpSILDUSSJ3N4zWHYKNawCH8Mq7nVW
         2wQ0OIIel85rbSq/sOkjkP52URI5V6lVxH2Jq7vTbx4Oq28aweutw4vLkbNdxAhmRj5s
         fiELeDG23ZG34+a6X7ozL8nqHMwFRQDG3l96Y4t3zb3JT3OnJlhQ80txXqE7fToOKY7U
         5TiiVCd36OkXp+JwF/My/+ZtBSaMIzt8kvAEConK8tyT053FZfpGBgEtQeLokcxOsJpS
         4CTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698318417; x=1698923217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toXNFfzr2zB8FMnlgacjGM+iESEOfHX27uyQ115+fBQ=;
        b=LquhrpmZRyadEG6NsKRE5BRVKoWB+tXHItXt/BG28iuFjcj+7QgS0yeQ1FLznitUdy
         rCezNdkiK+/ESIMxRWgoA66o/B/BL/9m1z0tJmgjvzzqAYyyvxNx8cT8J4+NRnijSF3Z
         Re8qV49YnWpPNi/427joggRtnYjZ4xNrKrY6XplGDCdGDM1elDv1TST8xekBkMSUBK/g
         4g5uviuSP+fL8q/zwXVZgMPUy97p1scKPQ4Xd/fezTCqrE2j00JvebjWwWw4tTe7dnne
         7/rXbLIIq3cH6C2fOUykP3PSNgCSir6BeK5TCqCaL/4JM4yk8HLIAWmjrduEE0afKGZ3
         DuKw==
X-Gm-Message-State: AOJu0YzpALBlp7oOBwBSsDAMoOoNVz6u6wB+qqFepiSofguzwejHN2bG
        dG6gZyaXliGaUALs6S4kR58Y3g==
X-Google-Smtp-Source: AGHT+IF1GzRZLlCAOCTP0Lt45qDT8HQJ8XqHwpM351pN08WUKAOM3A/n2rhSXw93342t0EeqkpEuUw==
X-Received: by 2002:ac2:485a:0:b0:500:a08e:2fcf with SMTP id 26-20020ac2485a000000b00500a08e2fcfmr11101260lfy.47.1698318416705;
        Thu, 26 Oct 2023 04:06:56 -0700 (PDT)
Received: from [172.30.204.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q9-20020a056512210900b005079691360csm2978277lfr.49.2023.10.26.04.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 04:06:56 -0700 (PDT)
Message-ID: <8dc48acb-46f0-47fa-bf7f-ee2d09eebcb3@linaro.org>
Date:   Thu, 26 Oct 2023 13:06:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] clk: qcom: Add Global Clock controller (GCC) driver
 for SC8380XP
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     agross@kernel.org, conor+dt@kernel.org, quic_tdas@quicinc.com,
        quic_rjendra@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, quic_tsoni@quicinc.com
References: <20231025133320.4720-1-quic_sibis@quicinc.com>
 <20231025133320.4720-3-quic_sibis@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231025133320.4720-3-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 15:33, Sibi Sankar wrote:
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
> 
> Add support for the global clock controller found on SC8380XP
> based devices.
> 
> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
[...]

> +static int gcc_sc8380xp_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = qcom_cc_map(pdev, &gcc_sc8380xp_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
> +				       ARRAY_SIZE(gcc_dfs_clocks));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Keep the critical clock always-On
> +	 * gcc_camera_ahb_clk, gcc_camera_xo_clk, gcc_disp_ahb_clk,
> +	 * gcc_disp_xo_clk, gcc_gpu_cfg_ahb_clk, gcc_video_ahb_clk,
> +	 * gcc_video_xo_clk
> +	 */
> +	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
Please inline the clock names, like so:

regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0)); /* gcc_camera_ahb_clk */

LGTM otherwise

Konrad
