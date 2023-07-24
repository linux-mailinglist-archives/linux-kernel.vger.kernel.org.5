Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3AA75F90E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjGXN5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjGXN5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:57:43 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC897125
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:57:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991fe70f21bso707805666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690207060; x=1690811860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fe9z2wVqi4uXGGhmuKhfL0klCprqpJzundzw8QwfPx8=;
        b=PzlIqRLwuxOwrOmnzKC5SEgl3Num/V5AZPJDYdGGhoF9PVf6bjoo6VmZXIuIlWr2GB
         xcVLooJ5K9BnBiGmqf/sQfBFabAc5koX/8Ek0YH7zW8hECNFwDedsydHcAF1K94n813v
         Z8Ld9ELjs851FTTxPV9H9w3RKXWRYsyR4v707faZdkUFV/agDLo8h54bwKvzVFz8Hmu+
         fj8cbqjiN8KmaRAqdo2lRHe8zWnWc5btQtDviP9+6m4UbeDnIc1AZBbbBz6CwSk6oPmJ
         AI7ZEfoMJX5VXI+7Yl4bqoJs4hmdM8oHE337Zi3+uEXRLgblbWmlDSMPRSIftCeAfTv9
         4Cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690207060; x=1690811860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fe9z2wVqi4uXGGhmuKhfL0klCprqpJzundzw8QwfPx8=;
        b=g69n89G/8+Cg21sPLZUEYQaOd/v7DVlVbUg5PG1/8cz36jsfOml4m6FibcihjNtm+5
         7pfNgJPrzPwwc556CnYXr2QPR6dzZYPorAGeifHgUygxsgxvGH3B3YEBm+5EAomwt9WL
         JtaHSpg+/eLP2hVEsOKoGCR8U8HTOFXy7qI/QYzCVJksi+I6hGd93fEn9feltD5oVtxM
         b4J2qbg62H7AIgyGYlaF9UaDBOcFkY5yNETRxGcCRv4OiuncQFmdrNa8h09teiUgbYS8
         f7bqbLtXyu3ulHD/15d6284PLbikMTi067bYZBhpfTjeZBeVak6EOqYEn6UutFapGi7X
         L9IA==
X-Gm-Message-State: ABy/qLbr/4VBdX47/SsMER5aK57IDhm5W4xok1Oandgg6ajPvclaon47
        gZKRw2ey879Szr1yz2chd97PxQ==
X-Google-Smtp-Source: APBJJlGgULAF3ZxrMoEL/wR2lRhASSflOgtg/XiNIrK3NnKBr0/YS1pVFSmzzglEcIPM/j9U1dwutQ==
X-Received: by 2002:a17:906:2253:b0:973:d1ce:dbe8 with SMTP id 19-20020a170906225300b00973d1cedbe8mr9946894ejr.46.1690207060358;
        Mon, 24 Jul 2023 06:57:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id bi3-20020a170906a24300b00992ae4cf3c1sm6707106ejb.186.2023.07.24.06.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 06:57:39 -0700 (PDT)
Message-ID: <c907c3aa-84b8-c667-e8ea-dd7e5bd4a54b@linaro.org>
Date:   Mon, 24 Jul 2023 15:57:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a7-sk: Enable dual role support
 for Type-C port
Content-Language: en-US
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, nm@ti.com,
        vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rogerq@kernel.org
References: <20230724115133.2226-1-r-gunasekaran@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230724115133.2226-1-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 13:51, Ravi Gunasekaran wrote:
> USB0 is interfaced with a Type-C DRP connector and is managed via a
> USB PD controller. Add support for the Type-C port with dual data
> and power sink role.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 33 +++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index d2cca6182738..b478b794de00 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -226,6 +226,24 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_i2c0_pins_default>;
>  	clock-frequency = <400000>;
> +
> +	typec_pd0:tps6598x@3f {

Missing space after:

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


Best regards,
Krzysztof

