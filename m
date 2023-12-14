Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AE481300B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573021AbjLNM2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573006AbjLNM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:28:22 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8253E121
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:28:28 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bee606265so8605866e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702556907; x=1703161707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/SrKS8sNndZYrnlsn4fMxH+Flx5ifwJNGo41U7qtLxA=;
        b=mfRO33HWZcrgi0JPXd5VtF7Fm5RVVIEGrgB/9UAs7w9BPZkEBZlVkiaqK+biWuVfBI
         4lB/HqbydvA+Pnorrzbreu5xPwY45YSjx5nDjd8Hl4RkDqOha7q/GqjIYhkTEIp+XOtq
         IvFuo86n0bM5Ibqa/sq7O/eRSm39ENaAAXuBWKENX9sQnkj0DSrEX4lEKvn55ENCx5dz
         QlZfAzK0LR+3vuRTV1lzEecvIfdTjAfmNxTiH9qjUtZVZo108LJglUKemSnAqkeMJVFU
         Yq9Aq8lY25HCrEHbIkMQx0N7HCmlzvr1FmzEZhNqySaL58jJHgypANCW6VZyH5IJby0+
         uKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702556907; x=1703161707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SrKS8sNndZYrnlsn4fMxH+Flx5ifwJNGo41U7qtLxA=;
        b=IwXEamuQwTclLkfBiX/yvx+hcWo9D8+BPYbt9h3sgDCxNwccSxtpQM3lLcdnobBFO/
         BDUSIi3MZO0AFwvvCty5wdWXtGEk0g46FqcKT+bpMlne0i+moDVDH4iSLlj+juS4hqny
         gtmNHRR7Su+s9vWwWYyLO4V/avYwjaEWtiIJ53khp0rGtcax1NPHvoTm7zzDTckfcvc5
         I59VeejJgBmln+WPj8tpQOixMvcOnwwqlBzW+4/zftOCcyUPUacz9liCnOVjCusqKufR
         i/oYiz/k+J+51T+9OailbAArajcdxGBcDba+GXa0kDCYNQ84Y4o41BK/bx5s1RQXckov
         Ge+w==
X-Gm-Message-State: AOJu0YzYc/8gOkqD0OEaAMkHKm0AotjK3dF69rIKgIFlghhhbjZQA3O1
        D4V2jn7LV/J5Ze4ZoKLZGG6vqw==
X-Google-Smtp-Source: AGHT+IEc2xeJ2bxmQEsNmBXPvCBklzXK0KxVyhLrYpwUDVNLVkrMerE/xbpMua2vjlu7W84TBH1H1Q==
X-Received: by 2002:ac2:5b50:0:b0:50b:eca9:fa18 with SMTP id i16-20020ac25b50000000b0050beca9fa18mr4267592lfp.118.1702556906677;
        Thu, 14 Dec 2023 04:28:26 -0800 (PST)
Received: from [172.30.204.158] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k4-20020a05651210c400b0050bef21a012sm1871880lfg.191.2023.12.14.04.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 04:28:26 -0800 (PST)
Message-ID: <b505443a-f51c-4557-b874-97b992d2ace6@linaro.org>
Date:   Thu, 14 Dec 2023 13:28:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sdm670: fix USB SS wakeup
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
References: <20231214074319.11023-1-johan+linaro@kernel.org>
 <20231214074319.11023-3-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231214074319.11023-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/23 08:43, Johan Hovold wrote:
> The USB SS PHY interrupt needs to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states.
> 
> Fixes: 07c8ded6e373 ("arm64: dts: qcom: add sdm670 and pixel 3a device trees")
> Cc: stable@vger.kernel.org      # 6.2
> Cc: Richard Acayan <mailingradian@gmail.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
