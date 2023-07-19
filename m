Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A81758F37
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjGSHjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGSHjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:39:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0381BE3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:39:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9891c73e0fbso107939166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689752352; x=1692344352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66DW8LCflFn2Wi0RjI0bBr8dmu2ZyOhIYX9UKbHY2/o=;
        b=SQF9Gs0cOrOlV3FiuNVhG4/lkVp3mHe6KNsCW53/nxQ+z2PJ8pZ+1LVan7ATcz51Vy
         ZatYmS11LNzZLB1xYUMC2PIjsfk80Ry1iUgPjeQAF/RkFH6mZOzGzEliX8TmJDdfBgjs
         24RJvq4jMgI6DExKuyY7SPudx6GcCVFYJMdWu+vUlvLac11vf8NwtNPGb00gD0X2KF9n
         WfHR0eqZs9eBcxDP8PoWLfhTHsiJ4rktSJIUXaAZpZzSGuUKF7IvpBMxRFDmEsWUN6CJ
         LDCHwki4f3mDCPyYyh3b4933uFMFXpQt8mZ3VYENYDtemstx8eE4d8cPzWxpQzB/y0Wo
         sZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689752352; x=1692344352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66DW8LCflFn2Wi0RjI0bBr8dmu2ZyOhIYX9UKbHY2/o=;
        b=J0rls16/SEJtPoQ5MzB+HxB6ftDDq2OczMuvsHFI8eLsElWqYSEbWyXWpqo0NHEeJ1
         xtUJ89V/he/jfdx8wM5bUK1QnAZeJFqkPsi870tlBHA4ZxInrMBWBpADWPTLZue74OiB
         JSZtfelr7KSc/i7dVpgz2W3KclbFAYHJpXDCY7NAe0FHv5x5HEDVP2DVYDvIVt05iKgK
         2Rif5Cc5hZgsufoPE3LNnq5GM3LedtEBrIy/ORT2T5aKwxe7Fy8DTkRK2G9Bqceu1jzf
         LzVRZUyCfbYy7cD4lMru1tn3rjtvxQ9OcMrlpqXwCq7vhtZTpJRcrd5F44aiIDldbrOU
         ctQg==
X-Gm-Message-State: ABy/qLbqmlW1hkSldNtO7p7wR4QkAjf1za3M+mYB1JTKkJKDwtQG+l/n
        NGKj5pyxvVJtxq0mrAWc/G0p7Q==
X-Google-Smtp-Source: APBJJlEr6NCzCOKisjOedVChiNya0k5zFijtDepBYyoBAyhTJkcmXFQ8FTPvA0H/hQQbxTXvq05Zmg==
X-Received: by 2002:a17:906:3f56:b0:99b:4210:cc76 with SMTP id f22-20020a1709063f5600b0099b4210cc76mr678766ejj.28.1689752352214;
        Wed, 19 Jul 2023 00:39:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id bq5-20020a170906d0c500b0098748422178sm1981554ejb.56.2023.07.19.00.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 00:39:11 -0700 (PDT)
Message-ID: <9e38d2f5-6da4-089e-1c70-a89069708909@linaro.org>
Date:   Wed, 19 Jul 2023 09:39:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: qcom: sdm630: remove refs to nonexistent
 clocks
Content-Language: en-US
To:     Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230719073520.2644966-1-alexeymin@postmarketos.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719073520.2644966-1-alexeymin@postmarketos.org>
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

On 19/07/2023 09:35, Alexey Minnekhanov wrote:
> Since commit d6edc31f3a68 ("clk: qcom: smd-rpm: Separate out
> interconnect bus clocks") rpmcc-sdm660 no longer provides
> RPM_SMD_AGGR2_NOC_CLK and RPM_SMD_AGGR2_NOC_A_CLK clocks.
> Remove them to fix various probe failures and get devices
> booting again.

So that commit broke DTS?

> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 038ec7a41412..8bea611b246b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -638,10 +638,6 @@ anoc2_smmu: iommu@16c0000 {
>  			compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
>  			reg = <0x016c0000 0x40000>;
>  
> -			assigned-clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
> -			assigned-clock-rates = <1000>;
> -			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
> -			clock-names = "bus";

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof

