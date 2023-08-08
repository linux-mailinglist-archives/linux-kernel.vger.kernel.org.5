Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BCB774040
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjHHRBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjHHRAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:00:30 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201726EA1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:00:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe1344b707so9166979e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510404; x=1692115204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RE7wtMExHdhFwKLLqjqt4LfjR7+37ThDsOcCDy3qTQQ=;
        b=PwDjsnZPpEOON21XmhMp+u0sisjWLyBSPad9QxaLPGHW7nSgAhPQ1LjU8UOwI1vfor
         45ifcbnWH1NYoLzcAuTvGv4NZkjNtXLa5B6BV17UibKiSQyTh8i/wDL3p27vY8Fzo7LU
         2DEQiC1nO0B/mkA/afSZBymtADJ2geddDbPz+lpTZHxbRYPlKJt/uJyqkdm0ZOS0AgRE
         dqIS/yf3dlUwkL0lvfcDs237LoV3SHlzAVxCBlRku/R4G1vjxTgUuTCzfA7xkw1lOL54
         7mdiOer0rm7E2e6f1jzUu1hGB8TrtXdhr+55sG74Fhwm+KDUGQGjkteDF4AXRAFFw/fg
         sv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510404; x=1692115204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RE7wtMExHdhFwKLLqjqt4LfjR7+37ThDsOcCDy3qTQQ=;
        b=AZ5G99jH1G9ZUZFbP/+p9yS+9OPshqm4ica+vM0/POU7Vo5uwjPA51+QwH/OtMPGXu
         DDY3MkQGEw1ChHI40BEPOR1G4YC5Zae1CitC6tfjyGMavCQdCv99oZZcwiH+tLx4zeBL
         +6DY0w9c9N0bg9iaaA8uDDtb49JJbDjlfxV7IaOoBU1dqydJOPtZra1pTotAS26vYtGd
         wkYyG0VB7i4p7hxhvbcbIFqAYX9wjK9ScNhfgPf4NFhtORdUMqdC5hqVjldyqxG6ELiB
         ph+KXn6Zw/piOHF49+HEZocmHfzPhD/dPSKteuNLxWxQst5pYqh5mTpc/mgT4r3tRgAN
         Kz1A==
X-Gm-Message-State: AOJu0YwtHa6XSDD2wZe/CYhXCYQg/oqmkbs9oNqmfmvvH3+bTJSgvPtR
        YTu2cHmLRMySXxZHxZY1rvUV+w==
X-Google-Smtp-Source: AGHT+IHbksfzqPLdhw5/yCLJTbCZEOgLAM2KQI/YGEb2WX3hUJsxDJkD4J/0HYLK1y1YsVgSMdIzhA==
X-Received: by 2002:ac2:4850:0:b0:4fe:56d8:631d with SMTP id 16-20020ac24850000000b004fe56d8631dmr8327458lfy.25.1691510404500;
        Tue, 08 Aug 2023 09:00:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id j18-20020aa7c0d2000000b0052239012c65sm6837797edp.82.2023.08.08.09.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 09:00:03 -0700 (PDT)
Message-ID: <f85df327-c321-8c1e-2043-c60210fbed56@linaro.org>
Date:   Tue, 8 Aug 2023 18:00:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] i3c: ast2600: Add reset deassertion for global
 registers
Content-Language: en-US
To:     Dylan Hung <dylan_hung@aspeedtech.com>, jk@codeconstruct.com.au,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@aj.id.au, p.zabel@pengutronix.de,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com, kobedylan@gmail.com
References: <20230808154241.749641-1-dylan_hung@aspeedtech.com>
 <20230808154241.749641-4-dylan_hung@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808154241.749641-4-dylan_hung@aspeedtech.com>
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

On 08/08/2023 17:42, Dylan Hung wrote:
> Add missing reset deassertion of the I3C global control registers.
> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> ---
>  drivers/i3c/master/ast2600-i3c-master.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/i3c/master/ast2600-i3c-master.c b/drivers/i3c/master/ast2600-i3c-master.c
> index 09ed19d489e9..5d9d060134e0 100644
> --- a/drivers/i3c/master/ast2600-i3c-master.c
> +++ b/drivers/i3c/master/ast2600-i3c-master.c
> @@ -11,6 +11,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
>  
>  #include "dw-i3c-master.h"
>  
> @@ -128,6 +129,7 @@ static int ast2600_i3c_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct of_phandle_args gspec;
>  	struct ast2600_i3c *i3c;
> +	struct reset_control *rst;
>  	int rc;
>  
>  	i3c = devm_kzalloc(&pdev->dev, sizeof(*i3c), GFP_KERNEL);
> @@ -156,6 +158,13 @@ static int ast2600_i3c_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "invalid sda-pullup value %d\n",
>  			i3c->sda_pullup);
>  
> +	rst = devm_reset_control_get_shared(&pdev->dev, "global_rst");
> +	if (IS_ERR(rst)) {
> +		dev_err(&pdev->dev, "missing of invalid reset entry");
> +		return PTR_ERR(rst);

return dev_err_probe

Best regards,
Krzysztof

