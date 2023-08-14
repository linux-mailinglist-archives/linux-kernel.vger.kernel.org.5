Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD3677B2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjHNHpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbjHNHpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:45:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DA210C0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:45:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bed101b70so545836566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691999123; x=1692603923;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i0RzompxTvywufBTvryBAp+xHgguon69NM49gXVj2tY=;
        b=YU/OXGa3oNljg0ndQEhTRYyn7MKCIiEGORXQvQTmuL+1L7+uL0Qu3Ep7Pis9Az4L5i
         lgHyZNsED0f6S5fGxgn2lFZuORLXAKvW4QRson98YbYnfkGyk4aga/ypBfFxlK/Tyoma
         cW5jJtCp44+I8ty9JeRv3jZgG3s0Hv8h8TL8I4P4xhAhsqpNq8BOjW4QhRdxIDr8wz6L
         g66xq8VwJPsRF/vXvJD9oe+eVhda9TEbOwLb/sl+jNJ4q6yjFNyB33vQUK+fyo7DsjzY
         wOHb2jDzTHkGtBstgQt6ti1KCBXcNTo6g2K1XxMf+k+GZCuiWJ3AAcW+50v6wxrfAufC
         WbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691999123; x=1692603923;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0RzompxTvywufBTvryBAp+xHgguon69NM49gXVj2tY=;
        b=N05NFxsGnEf5jMSRMTPL2KxW0qPl9sEfDeLI0vg3cNj4qQsXF0pqgG/ez9Z+KU1wwF
         PV7q5Od7+p6dHlJwFEvv+f8iSaSW53JfdJHAoHRjqPryNppRgX/7J687PArcrFMZtSlB
         0Ns+JM8E4vCO3GFA4RpmUfuYHQpqwm9fJ/1IxCx7uutFPfheiVx51TYLS7duuSfDSqX7
         ZdmpTqV/++ni5nugQkDltmjhFH0opewNfYsvhlUffzB5Z92xXM02xRNFtFn6L1KqcHK5
         GUBW80yJuzKwFVkZvaSZMt/cqCNdDoxKQvOLHBQMaz0rt807liRCNvL10PJ8679r2VAo
         xCJg==
X-Gm-Message-State: AOJu0YybjpwkBZUUMOrUq9MH5oRXykf9NC4gojeOJFyfbhLO44CIfEJi
        vpmOVsCy+q7ZTAxiHXZSMg4tWA==
X-Google-Smtp-Source: AGHT+IHWdwKpTqcFMWzaLZxzjqDug8Tt6bFNAgMUiArQu9WAUJbthnZRqnuQi/uOsAjWPq2c70hVWQ==
X-Received: by 2002:a17:906:1041:b0:99c:ae35:8cd with SMTP id j1-20020a170906104100b0099cae3508cdmr7472922ejj.43.1691999122978;
        Mon, 14 Aug 2023 00:45:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id kk9-20020a170907766900b0099cc36c4681sm5360241ejc.157.2023.08.14.00.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 00:45:22 -0700 (PDT)
Message-ID: <8b41456e-3394-9b5d-1f94-a257a443dfd6@linaro.org>
Date:   Mon, 14 Aug 2023 09:45:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] phy: amlogic: meson-g12a-usb2: fix
 Wvoid-pointer-to-enum-cast warning
Content-Language: en-US
To:     neil.armstrong@linaro.org, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>
References: <20230810091310.70231-1-krzysztof.kozlowski@linaro.org>
 <13491021-d849-da84-f1a2-a94401118de6@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <13491021-d849-da84-f1a2-a94401118de6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 09:43, Neil Armstrong wrote:
> On 10/08/2023 11:13, Krzysztof Kozlowski wrote:
>> 'soc_id' is an enum, thus cast of pointer on 64-bit compile test with
>> W=1 causes:
>>
>>    phy-meson-g12a-usb2.c:322:17: error: cast to smaller integer type 'enum meson_soc_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   drivers/phy/amlogic/phy-meson-g12a-usb2.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
>> index a628c59e5cf0..0e0b5c00b676 100644
>> --- a/drivers/phy/amlogic/phy-meson-g12a-usb2.c
>> +++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
>> @@ -319,7 +319,7 @@ static int phy_meson_g12a_usb2_probe(struct platform_device *pdev)
>>   	if (IS_ERR(base))
>>   		return PTR_ERR(base);
>>   
>> -	priv->soc_id = (enum meson_soc_id)of_device_get_match_data(&pdev->dev);
>> +	priv->soc_id = (uintptr_t)of_device_get_match_data(&pdev->dev);
>>   
>>   	priv->regmap = devm_regmap_init_mmio(dev, base,
>>   					     &phy_meson_g12a_usb2_regmap_conf);
> 
> I believe the net-next is wrong here, but whatever:

Yes, it's a history-copy-paste mistake.

> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks.

Best regards,
Krzysztof

