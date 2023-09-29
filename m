Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EE67B39BB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjI2SKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2SKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:10:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5420C136
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:10:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso1337853166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1696011034; x=1696615834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ppKsMWQvsuSQ1SRESoyX6XeM6gP0AaLkiyEIrn/Nro=;
        b=aT5Igy3SsPIOD2W6Jzmj2+8a3wrmq7en90VyHbm+yPYgVXmDEoCFGCbHto/hvvvwLj
         Lkk1YWtw9/lePYMudeWwPwG0FloIdd1Xpp25O3Dp+tl6SIQ9AImXL35adtssa8tmoNx2
         Zow56rz0DM6uLBRop8l1C/3Zr4U42MRW3buYwE/OjJBI9b/ifb1MDxIaxt4s/hQJuv94
         pi0RixjUGQNkBxPiWgnhVXaBkT5ydU0ej6oVPR8mF275ERh0Vz4h/IadzajrvPDThX4I
         sijn8DlkE854F9bIjwQKrOplf0rR+i2OfJjaKEZArPXtblsyUfKAFPphgVjolbL4K7Mf
         9yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696011034; x=1696615834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ppKsMWQvsuSQ1SRESoyX6XeM6gP0AaLkiyEIrn/Nro=;
        b=oFb08ami1KIGrMY8gi5Y0Gpg7/JWluFrKBBcd+HPAvMtbWlMZgOk38PK+lb6AMDh4I
         vU72GYtSHIkqNUagjNtnty3A7ck4c8EJHdSybZlI7lmRc0NeIGQarM6WgLkW383tV7rC
         9mW1TmXZoo+pjxejvgnCJeJokAwdnAdplVekI56LiHK02yaHg8vnc7XqwS0gz1fQOh0n
         hVsjh68oObLIo5epR2l27EnjorQIwnGu0Ajw+n44LN4HwWXGDLFe9ezf5asjX6vkfoCg
         /a3BwDjg6pHubGND6MuxAWPbrUvWmAjLjm12XmQ80jR1/Dz6iph8kEn4WyuY1VcYZBnt
         u8mQ==
X-Gm-Message-State: AOJu0YzOXGtEks5OtZ9LOX+d35GIMMCUedxwCJ2B1kIUQUCSY+fq35iJ
        eMV7emj6bfgZTJMZqTitywq+lQ==
X-Google-Smtp-Source: AGHT+IGiq7ExCeYG0J5fb3V2IvkxXcEeyUKIotNecF7rVcqTfC0jgClQ6p9IyfmvcVKjRXSRIFGU5w==
X-Received: by 2002:a17:906:535e:b0:9ad:c89b:482d with SMTP id j30-20020a170906535e00b009adc89b482dmr4750078ejo.33.1696011033762;
        Fri, 29 Sep 2023 11:10:33 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.190])
        by smtp.gmail.com with ESMTPSA id ep14-20020a1709069b4e00b009a168ab6ee2sm12186108ejc.164.2023.09.29.11.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 11:10:33 -0700 (PDT)
Message-ID: <67392eaa-518e-6e04-676c-ba991ada1753@tuxon.dev>
Date:   Fri, 29 Sep 2023 21:10:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ARM: dts: at91: sam9x60_curiosity: Add mandatory dt
 property for RTT
Content-Language: en-US
To:     nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
References: <20230928143644.208515-1-nicolas.ferre@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230928143644.208515-1-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.09.2023 17:36, nicolas.ferre@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> atmel,rtt-rtc-time-reg is a mandatory property and encodes the GPBR
> register used to store the time base when the RTT is used as an RTC.
> Align the RTT with what's currently done for sam9x60ek and sama7g5ek,
> and enable it by default even if RTC is also enabled.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> [nicolas.ferre@microchip.com: adapt to newer kernel]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied to at91-dt, thanks!
