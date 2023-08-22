Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAE87845AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbjHVPfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjHVPfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:35:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79503CD1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:35:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99d937b83efso596631666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692718517; x=1693323317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBBAz2Sbh3/AyWRq5Eivx4ALvagiWhpYuPWoNQwDqMo=;
        b=xiRvIqhaM/mc1I4/wofmBZV1t2EPqbDli0W20iry9VlRsbxH+mbu7AdQhOPlF3hJJz
         iBUx8jFDanTEjZ5vJt3Rbr3tl7Ow3tKXEWXU8mbln9qKmBw+MYk8ghrRRYSRG/tTYJfM
         XHVUtASrKmZjcHXFd10Rr57wGnHwaMR6JBK9nTqKNiJo3KELHv5CmLL6T6p3XGMNZ4LO
         RP2qwBvMiM34C0i6WzYe9kBUPxMNfP1lnxy59NwWcO1mSuPMcXWCARERMPsEVin62mg5
         tv+BrPeWegPwfmMnA20y97s5bjgCV9WWPt2n/42FmUpyifIMKRK6MHmXlVnHB6Hl+nrb
         fW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718517; x=1693323317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBBAz2Sbh3/AyWRq5Eivx4ALvagiWhpYuPWoNQwDqMo=;
        b=A15Ixt5MdBfRM44gXjREWV2Ov4oFZi1LHEt4tebtyVRfx6IkfwaFHGiVUubwoqcFCD
         OA8gINahV8T2BqpoQg4yUbB62AS99erIO7ziAmWllEwTQC3tfOL/hrT1lolZk6nmADYq
         n6RdIRIh+F1u3ePixb+hmurD+8QdNKr/kGTkDyKl/8EjmbiYZvJPVvaldNGTPtQMChaH
         WyuJkYgm+zWmrjJFT17nP7pPbcDOVKgnACbrHGNLHeeU9Tivdss6REuM1cOTzctWRdJq
         vHA79c+7yHPNykEfVAJlqBcg2lNon0Y8cQWpJULsGxOCxGAEDJPeEU2yeeDr6e2cr7RN
         O+rQ==
X-Gm-Message-State: AOJu0Yy8yvya5/iCzysIYYjtcZb7nBzdDdE/bqBFpOwfxRQekKxTeiNz
        LWVnCUm+Jke7e89gpSyjhaojIw==
X-Google-Smtp-Source: AGHT+IFpoEhtk+EkY8eWIWmBJpHq11sTfT8uhgXHGhJOooXX6JISfp6PUCg2khvbrqE/iB95kppWoQ==
X-Received: by 2002:a17:906:5385:b0:99c:55c0:ad15 with SMTP id g5-20020a170906538500b0099c55c0ad15mr7999829ejo.38.1692718517015;
        Tue, 22 Aug 2023 08:35:17 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709064f1000b0099297c99314sm7445462eju.113.2023.08.22.08.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 08:35:16 -0700 (PDT)
Message-ID: <e33cd680-eeca-ac4b-ee4a-4c0a1d6cd00c@linaro.org>
Date:   Tue, 22 Aug 2023 17:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 1/2] extcon: add Realtek DHC RTD SoC Type-C driver
Content-Language: en-US
To:     Stanley Chang <stanley_chang@realtek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230822102846.4683-1-stanley_chang@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230822102846.4683-1-stanley_chang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 12:28, Stanley Chang wrote:
> This patch adds the extcon driver for Realtek DHC (digital home center)
> RTD SoCs type-c module. This can be used to detect whether the port is
> configured as a downstream or upstream facing port. And notify the status
> of extcon to listeners.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
>  drivers/extcon/Kconfig             |    9 +
>  drivers/extcon/Makefile            |    1 +
>  drivers/extcon/extcon-rtk-type-c.c | 1799 ++++++++++++++++++++++++++++
>  3 files changed, 1809 insertions(+)
>  create mode 100644 drivers/extcon/extcon-rtk-type-c.c
> 


> +static struct platform_driver extcon_rtk_type_c_driver = {
> +	.probe		= extcon_rtk_type_c_probe,
> +	.remove_new	= extcon_rtk_type_c_remove,
> +	.driver		= {
> +		.name	= "extcon-rtk-type_c",
> +		.of_match_table = extcon_rtk_type_c_match,
> +		.pm = DEV_PM_OPS,
> +	},
> +};
> +
> +module_platform_driver(extcon_rtk_type_c_driver);
> +
> +MODULE_DESCRIPTION("Realtek Extcon Type C driver");
> +MODULE_ALIAS("platform:extcon-rtk-type-c");

Drop alias. You have something really missing here if you need it.

> +MODULE_AUTHOR("Stanley Chang <stanley_chang@realtek.com>");
> +MODULE_LICENSE("GPL");

Best regards,
Krzysztof

