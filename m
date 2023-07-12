Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321EA75109E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjGLShj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjGLShg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:37:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF231BF6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:37:34 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e99584adaso2892085a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689187053; x=1691779053;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0s9AVrwvJhGSx93BJTbDW7raDKnHpStgjFNTeCDWn8w=;
        b=rP2Klxzbi/EuA5qsJgC8ytKYfAMla3iZ0eWBSb5EBM4L8T1Dul0j03DlG8xLvmPl5L
         bJLXyuYMMyR98c1BQdobFUjwh0G8E8x1UpKLrHNfwOYa2dznRV3I9blZgivmOg3LvU+2
         ErWSvWmSs6hlGb5xzkqoHy+b/oC0/LltSIk8UZ02+Mo+XMRV4CEFYiBo2AgQBjj39sTm
         byYRw5wdnDhd12VBzXFIJ7UbDuV7x1v1N2GS69SR9ds17vfdOWhliQ+MFElXnQ4YehVV
         GsiAJdnNRXjofEVGUQUmWZa3vQ7FJ2+auYqGalES08/4AEMjEl1r1rgZW8QRm3MdcHqn
         76Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689187053; x=1691779053;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0s9AVrwvJhGSx93BJTbDW7raDKnHpStgjFNTeCDWn8w=;
        b=ZLDWcopVY8BXP06SY16RGKo55g8r/0E4GCG5Tz6E7Hcq9uM88tLq8ur8+rzlUNeCr+
         gUgBOpUCYNSrMqQP7HK4Efaqe0x1gJTLZDqS+PNdR3OlFEAjuWdnSOskglaU7UkQxrZY
         /b8KQwt71WEUSaOLUqCzZZWKz3NTU5coOWuu6RYm8+s9DxKT2lA25zQ7xvDX+BmMu/uR
         4b0PZBlZ4nlps0WbF0G0DqlCEgwQcqRpoZm+oAxaqt58fXJPAGBg7utf3V3YPdMDCO+E
         6jsvBBTJxNgqJvtOPJiqAGKrvl53nmGRTVAm1qF92DSEoUU/IQtlkt3yAko19AD2h68o
         7xNw==
X-Gm-Message-State: ABy/qLb+SkASoWrLPodnrpy0MYNNy2vGYDBNC+DTlmCe8KzbsxmjZqBD
        1ZmczNVMGmOudCsBaNuErVCJhQ==
X-Google-Smtp-Source: APBJJlFLs94mH7MJMkWZXx8jcwo2aK1ntgyVhGxyQ7+jcYnGxxo8ee0VGoc03m8K8CQ7P4lYSFiW5w==
X-Received: by 2002:aa7:d544:0:b0:51d:982d:cb77 with SMTP id u4-20020aa7d544000000b0051d982dcb77mr18371800edr.33.1689187053037;
        Wed, 12 Jul 2023 11:37:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id be25-20020a0564021a3900b00514a5f7a145sm3114169edb.37.2023.07.12.11.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 11:37:32 -0700 (PDT)
Message-ID: <1ac2fb68-02e0-ddfe-87aa-fcd093779009@linaro.org>
Date:   Wed, 12 Jul 2023 20:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/7] arm64: dts: imx8ulp-evk: added nxp secure enclave
 firmware
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, clin@suse.com,
        conor+dt@kernel.org, pierre.gondois@arm.com, ping.bai@nxp.com,
        xiaoning.wang@nxp.com, wei.fang@nxp.com, peng.fan@nxp.com,
        haibo.chen@nxp.com, festevam@gmail.com, linux-imx@nxp.com,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-3-pankaj.gupta@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230712121219.2654234-3-pankaj.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 14:12, Pankaj Gupta wrote:
> Added support for NXP secure enclave called EdgeLock Enclave
> firmware (se-fw) for imx8ulp-evk.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index 3ddc0f3125b3..10ed31974a6f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -114,7 +114,7 @@ sosc: clock-sosc {
>  		#clock-cells = <0>;
>  	};
>  
> -	sram@2201f000 {
> +	sram0: sram@2201f000 {
>  		compatible = "mmio-sram";
>  		reg = <0x0 0x2201f000 0x0 0x1000>;
>  
> @@ -161,6 +161,16 @@ s4muap: mailbox@27020000 {
>  			#mbox-cells = <2>;
>  		};
>  
> +		ele_fw: se-fw {
> +			compatible = "fsl,imx-ele";
> +			mboxes = <&s4muap 0 0 &s4muap 1 0>;
> +			mbox-names = "tx", "rx";
> +			fsl,mu-did = <7>;
> +			fsl,mu-id = <2>;
> +			sram-pool = <&sram0>;

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			status = "okay";

It's by default.

Best regards,
Krzysztof

