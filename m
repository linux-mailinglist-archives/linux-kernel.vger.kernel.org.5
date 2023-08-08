Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6EB77424F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjHHRlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHHRks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:40:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433B523372
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:17:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so26985a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511436; x=1692116236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yvh066U7kamHwMstcxLV5PbPWX/RDQ9l/CouVe/EHBo=;
        b=Q51H4su7Q/letXHqAgy8sOHAwgyePtHKWtad+Ai3aTMaC+N5kCvg+Z/T8Cd7LttgEb
         MtX5N2nCveqsZo4o4TXHTpeh/zpKx8iDUDipGgPGvqD9hAidd8+qLZugmefwSxvqKLO9
         8kn5oQ5cQxENh+Bk79F3iC5PhNf4gzyJgWVZzbcOMZrEeMm2TneVsNztkugI5aW+y5yA
         u+W50GL9TTb+6w6U1nlN3ijRu0fK8fR4XhIxAOHcm/cVjnpv+CZpxDWCOyMUpIy0sbnB
         PFo6RO+bZ9MmL1RVY0pT1nsDhFWrlr8hxl5hgcv1fYmGHYt6DKquw9adg/EAufzaeaNZ
         b9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511436; x=1692116236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yvh066U7kamHwMstcxLV5PbPWX/RDQ9l/CouVe/EHBo=;
        b=j8x4CdCQjFZlovKWvo3NASiu+YyQXRWzlHEAwCYTZURk8jv1mksiTAuDoROt3MkriF
         fjkSAmhZA6D36xpcHk0PNPfAdYcBOcgm6i4kuGmGHVCMGbZRRRUE8h/Na/L2K/87moRk
         mgKRAQ3ZsHGC7vvASBgZ64K/MpHEeasHFveAzl6lISONPU6hpoFlVakZQaG45G7wiE6u
         wGp8cLvX0tJ2pWjE5HFPy6/CFdC3iH0+rK9W2B5/EPbwa+CEWZWzO85FgW7UWbKKC2Gw
         Xyjfh71WmHJeMZzoGNiBkK9hvPQhViIq84nT8wT7rEDVLN60kUs1XanWwqL4pE8aDuSR
         SGMA==
X-Gm-Message-State: AOJu0YyJBg4yZd3yIbq8EDWRPcHh2wkxoCSDMNC/buf07HMwjRzV/SLe
        a6TfEBrCdXL0Y8zkikAZZOWLYbwgA0pU6M1JD/I=
X-Google-Smtp-Source: AGHT+IEu0ccUzH7lApjEP28rWQ/D0b3cym+2k803TQ1oV+KLYehusJTAaXq8Tjyjub1CfGObHwqzrg==
X-Received: by 2002:a17:906:769a:b0:99b:cb59:79b3 with SMTP id o26-20020a170906769a00b0099bcb5979b3mr9677048ejm.1.1691483865199;
        Tue, 08 Aug 2023 01:37:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id re15-20020a170906d8cf00b009886aaeb722sm6285193ejb.137.2023.08.08.01.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 01:37:44 -0700 (PDT)
Message-ID: <4eadaf03-7378-93a0-b1c0-a640f9ae306c@linaro.org>
Date:   Tue, 8 Aug 2023 10:37:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 9/9] i2c: synquacer: Use dev_err_probe in probe
 function
Content-Language: en-US
To:     Liao Chang <liaochang1@huawei.com>, andi.shyti@kernel.org,
        florian.fainelli@broadcom.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        yangyicong@hisilicon.com, aisheng.dong@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, kblaiech@nvidia.com,
        asmaa@nvidia.com, loic.poulain@linaro.org, rfoss@kernel.org,
        ardb@kernel.org, gcherian@marvell.com
Cc:     linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230808012954.1643834-1-liaochang1@huawei.com>
 <20230808012954.1643834-10-liaochang1@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808012954.1643834-10-liaochang1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 03:29, Liao Chang wrote:
> Use the dev_err_probe function instead of dev_err in the probe function
> so that the printed messge includes the return value and also handles
> -EPROBE_DEFER nicely.
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>


>  	i2c->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(i2c->base))
> @@ -582,10 +578,8 @@ static int synquacer_i2c_probe(struct platform_device *pdev)
>  
>  	ret = devm_request_irq(&pdev->dev, i2c->irq, synquacer_i2c_isr,
>  			       0, dev_name(&pdev->dev), i2c);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "cannot claim IRQ %d\n", i2c->irq);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "cannot claim IRQ %d\n", i2c->irq);
>  

I don't think this is needed:
https://lore.kernel.org/all/20230721094641.77189-1-frank.li@vivo.com/

Best regards,
Krzysztof

