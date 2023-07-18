Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395317573B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjGRGL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjGRGLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:11:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1927DE70
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:11:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e5da802afso7539197a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689660674; x=1692252674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c7CORbZbL1CJ4lcrQu82rGQOGmmLscmGh8S9udXQn2k=;
        b=qDnjEVJOSZ5wf6mLTENKLsm+G/tbyEd3ZYE3zj7NOr+UvecUR5THynxr4HFTte0VPJ
         2mltfQdcELoppCTUxj1LAvOz34Stj28FLM8j88TT7rvNK15zOmu4qkDNsrVP1KHehdul
         HIhAAdvbVmg3n+uLfiUDNmSU3uj4LZiYlbfpGqOK5hhJHlH1A2QHEb5EbFN2VV0iEjzh
         wSmTrKuaimvCkg4GKQyM/Ph+eWYihR79BKg2RTFBOaI96PHZQ0TxUVJD6hlWOfbSiG9Y
         jzXK28uzwQMceUcOvy+bvoe4aSPlDpyP0CmU4Bh8/Em4JtkfWA0lqcnRIvPGCfBBLwTm
         U1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689660674; x=1692252674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7CORbZbL1CJ4lcrQu82rGQOGmmLscmGh8S9udXQn2k=;
        b=jkuEqyygr9DQwqBz7Fg4mkhxNQrb0/vYPnU8vrJZ8fYofy0BOrgzUYj6o/+TenT5om
         MPzbfM3uYiEEYJUypM+dDee2VccyLU06RdLpIXLuCsxxjz5H/9MNQOB6scA4zsh+T0Az
         G/KHA1aMW1wbefwBgZ1IZYCqK8N9XuMKZyW+f+ydHtvGcUaJUesEf8zaA5ODra+BT7GG
         Q8rX69P9Q4Nr32mRmCxykeqWqsxWIesWGVwFPOAKP/AbiNCQ7Z24fbzfrIAUrwMNJYmL
         rJ36tV8uizXfPbwsAplRrEPetHLbTLz4C+yKwQ6H20M+jSQ9GPj8aNdmI9gd+nwHBBGW
         PqSg==
X-Gm-Message-State: ABy/qLbjLhsaURNhXK90BDFYCbdex+IG8VJDUcDdF3hIyh5KqTzjywi9
        xlLf7ptzzGP7iQTwW1LU5CH6sw==
X-Google-Smtp-Source: APBJJlFxHH/p4YdYLQncHZKMTqB3MNpMLyBHRgEj3fOz3zOiWt648ZOJqrbNvMFjrTm3f1q1uwtKXA==
X-Received: by 2002:a05:6402:b33:b0:514:9934:de96 with SMTP id bo19-20020a0564020b3300b005149934de96mr13167801edb.26.1689660674598;
        Mon, 17 Jul 2023 23:11:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id a18-20020aa7d752000000b00521953ce6e0sm686924eds.93.2023.07.17.23.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 23:11:14 -0700 (PDT)
Message-ID: <78b06bf0-ab71-acdf-5799-1f6d849e7ead@linaro.org>
Date:   Tue, 18 Jul 2023 08:11:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] usb: dwc2: add new compatible for Intel SoCFPGA Stratix10
 platform
Content-Language: en-US
To:     Meng Li <Meng.Li@windriver.com>, dinguyen@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230718030851.2014306-1-Meng.Li@windriver.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718030851.2014306-1-Meng.Li@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 05:08, Meng Li wrote:
> Intel Stratix10 is very the same with Agilex platform, the DWC2 IP on
> the Stratix platform also does not support clock-gating. The commit
> 3d8d3504d233("usb: dwc2: Add platform specific data for Intel's Agilex")
> had fixed this issue. So, add the essential compatible to also use the
> specific data on Stratix10 platform.
> 
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index ea788a920eab..b8dd5509c214 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> @@ -490,7 +490,7 @@ usbphy0: usbphy@0 {
>  		};
>  
>  		usb0: usb@ffb00000 {
> -			compatible = "snps,dwc2";
> +			compatible = "intel,socfpga-agilex-hsotg", "snps,dwc2";

You miss SoC specific compatible.

Best regards,
Krzysztof

