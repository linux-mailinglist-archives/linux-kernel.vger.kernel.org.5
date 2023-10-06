Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599217BB2E0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjJFIP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjJFIP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:15:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C5ACA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 01:15:53 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b29186e20aso320875366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 01:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1696580151; x=1697184951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Q4ogW5qK+Q378NkfT1zOIAJT8Si53eTLHFpy5FKWHo=;
        b=FGsMHtwNuqnzH+0OJTD1sAHiTRyRAeGEAJNAKDOY3ap/krbfPK3B9NYzzv7tOoFCr/
         nZzFF5Or6TkWbbZiLh8ZeRtdEQytmEf8blzVjfPaQxfjkKbw0hfJZCIqSCADfRQ3GjUm
         T2nS6oQE8FUrHvmTuSIl9RIIg3s8UsQ5cpoUM8zE1QHsj/ugwhAmOfHEqim22yHfVhJW
         HNZ6U5egbTOsmTJgCXeb/F9oaqil+OAv4bxvOxAQDjHS2UuNN71qqMvDtKWtx9Yycv1M
         +y+Xih6uhBOHcSFGlkWwfEO8x6cwh4LH8oR9MW1uaPRy5y8Es8M3qKzfqB8R6bW/pAx9
         wdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696580151; x=1697184951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Q4ogW5qK+Q378NkfT1zOIAJT8Si53eTLHFpy5FKWHo=;
        b=Df+xB/r3NaoNn2YK5CMAT358/jt/fMqu0pCCfMcp2Xz2g26f2VAiCr0vS8O3/3jdY7
         2P0QcttJA6ATr9+UGSIGi4RQD1EC3xoR2JhXeHx055EwVU7rK4VgwwKcATsJW4/A4Yrx
         5n9u+FKGr6Ro7xeGKlkWKDH3dZGk2Q66MAk1mKAm1Lc4O5jZEM7gKGVisU13vcWjtGGr
         6A/c3dNvCWHfcglMBCUiIH4FMz1ZcQdhJldSS89kwbcoP+0gNZaklOZKylen5TqWKf21
         WOYOZhor1oLZDW62SwxVRXz9Y3hnldCKSRn040hc2vV3aicRg8JZ8lTplFDkFRdJVkjW
         xK9w==
X-Gm-Message-State: AOJu0YzGJ5g/iMYqJroPzRtCNn6ilJ9QoGY7nRDQABiy3DaShvpvlMgp
        C54QYgtkMWOAWZExNQqODRemefRWw/2lLHid89PEmQ==
X-Google-Smtp-Source: AGHT+IHx7vWRRaIlV+MbmK9HGuC0ATNajWSAjh9i4FniEi//WJSktM1fK/O0jVOy5c+VOae07boNNA==
X-Received: by 2002:a17:906:1097:b0:9ae:4878:1172 with SMTP id u23-20020a170906109700b009ae48781172mr6986670eju.7.1696580151445;
        Fri, 06 Oct 2023 01:15:51 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.24])
        by smtp.gmail.com with ESMTPSA id l12-20020a170906230c00b009920e9a3a73sm2474516eja.115.2023.10.06.01.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 01:15:51 -0700 (PDT)
Message-ID: <070a6f48-20a4-4e26-a071-0600a6ecea36@tuxon.dev>
Date:   Fri, 6 Oct 2023 11:15:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ARM: dts: at91: sama5d3_eds: remove TDES use
To:     nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        jerry.ray@microchip.com
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
References: <20230928145655.215481-1-nicolas.ferre@microchip.com>
Content-Language: en-US
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230928145655.215481-1-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nicolas, Jerry,

On 28.09.2023 17:56, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> TDES doesn't probe because of lack of DMA channels left on this
> controller. As we don't need TDES HW engine, we prefer to keep DMA
> channels for other usage.
> Disable TDES for this board.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
> Hi,
> 
> Tell me what you think about this move. I think it makes sense but tell me if
> application could suffer from this lack of TDES engine.

It anyway fails to probe. I have nothing against unless its probing could
be fixed. Jerry, are you good with applying this?

Thank you,
Claudiu Beznea

> 
> Regards,
>   Nicolas
> 
>  arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts b/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts
> index c287b03d768b..fddd786f8483 100644
> --- a/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sama5d3_eds.dts
> @@ -284,6 +284,10 @@ timer1: timer@1 {
>  	};
>  };
>  
> +&tdes {
> +	status = "disabled";
> +};
> +
>  &usb0 {	/* USB Device port with VBUS detection. */
>  	atmel,vbus-gpio = <&pioE 9 GPIO_ACTIVE_HIGH>;
>  	pinctrl-names = "default";
