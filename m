Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AEB7F5BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344244AbjKWKHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbjKWKHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:07:17 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F13810CF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:07:21 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507c5249d55so944183e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1700734039; x=1701338839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmXvLPzPw+DEwAZx7VriDTykjMFvpksI53NUtYqCnkc=;
        b=iwnceLNnY/+gvIFj4IJ4gzgyXO1+KoTx7bQXYQOgXIfd3D+240n9InocZrpWqgqmCQ
         UYAGhy/4pa7FeS1qGQc8nAXySdP5QeWK/uecfFwsMXfEFDbvGvzVNYVV6102XV/jLl6Q
         H+6yoLHF2C2TVZ9fimeOR5g8cXJX76fVwKpn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700734039; x=1701338839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmXvLPzPw+DEwAZx7VriDTykjMFvpksI53NUtYqCnkc=;
        b=fDW+0VK151ZFiTmZy6yEjt9QPFL11S+IFMe/t+w2tAVEeZiVcScZg5NQ7e7ghYBABL
         gOG6oOiUqCjp93Ih4rhWS9nw+duQAm81dExgZAhgba7FbsRX2BFijSlxxpUVN7wrcHrr
         OsNiLRf7Jt4jTt5R3WmQ7MrPrPEXi/ZNx6B4uwpCYYVCkSPpF+tDrCVkF6ScHpvzngGk
         ItbXc1wRboLCWvmORf+JmgjP7l7wKOUqGKSaAU6rLtuwGxM/n6hIPPFIJiZetdpYRTle
         Jm+4Y73+0N8imPyv+4N++kHc2SGxVtjljxm33LGiyGXnJZb6ZZA/NNsqiA8L73yH+3qa
         AOZQ==
X-Gm-Message-State: AOJu0YwBkS+wLGprGfRJOlGbX8+hsH6B/Vqm5zQfdDpRCje1VZ9ZPmAE
        ZXAixOjB17aDGZtIly/Nk11FPQ==
X-Google-Smtp-Source: AGHT+IFP1CDX33ugDyxbihJtdfr48gqh31qpKq2fPD9a+2KIHJNpdkp3yd0K2LQKWo1VGhaYFEBEOw==
X-Received: by 2002:a05:6512:2385:b0:504:3c1f:cbd1 with SMTP id c5-20020a056512238500b005043c1fcbd1mr2496310lfv.12.1700734039096;
        Thu, 23 Nov 2023 02:07:19 -0800 (PST)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id e6-20020a196906000000b0050a5f6b5b46sm146397lfc.225.2023.11.23.02.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 02:07:18 -0800 (PST)
Message-ID: <e731c0a9-7a5c-41c3-87aa-d6937b99d01a@rasmusvillemoes.dk>
Date:   Thu, 23 Nov 2023 11:07:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Content-Language: en-US, da
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20231122145344.GA18949@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2023 15.53, Lukas Wunner wrote:
> On Mon, Nov 20, 2023 at 04:10:54PM +0100, Rasmus Villemoes wrote:
>> Some boards are capable of both rs232 and rs485, and control which
>> external terminals are active via a gpio-controlled mux. Allow
>> describing that gpio in DT so that the kernel can transparently handle
>> the proper setting when the uart is switched between rs232 and rs485
>> modes.
> 
> Crescent CY Hsieh (+cc) is in parallel trying to add an RS-422 mode bit
> to struct serial_rs485:
> 
> https://lore.kernel.org/all/20231121095122.15948-1-crescentcy.hsieh@moxa.com/
> 
> I don't know whether that makes sense at all (I had thought RS-422 is
> the same as RS-485 with full-duplex, i.e. SER_RS485_ENABLED plus
> SER_RS485_RX_DURING_TX).

No, that latter case is as I understand it usually called "4-wire
rs485", while rs-422 is an entirely different animal, and the wiring is
in some sense actually closer to rs-232. rs-422 is full-duplex, with all
the slave device's tx-lines connected to the master's rx, and the
master's tx connected to the slaves' rx (ok, it uses differential
signalling, so there are four wires involved and not two as in rs-232).
But I'm no expert, and there doesn't seem to be entirely consistent
terminology.

> 
> But if that patch gets accepted, we'd have *three* different modes:
> RS-232, RS-485, RS-422.  A single GPIO seems insufficient to handle that.
> You'd need at least two GPIOs.

I don't see Crescent introducing any new gpio that needs to be handled.
In fact, I can't even see why from the perspective of the software that
rs422 isn't just rs232; there's no transmit enable pin that needs to be
handled. But maybe the uart driver does something different in rs422
mode; I assume he must have some update of some driver, since otherwise
the new rs422 bit should be rejected by the core. So I can't really see
the whole picture of that rs422 story.

>> --- a/Documentation/devicetree/bindings/serial/rs485.yaml
>> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
>> @@ -61,6 +61,11 @@ properties:
>>        the active state enables RX during TX.
>>      maxItems: 1
>>  
>> +  rs485-mux-gpios:
>> +    description: GPIO pin to control muxing of the SOC signals to the RS485
>> +      transceiver.
>> +    maxItems: 1
> 
> The description doesn't really add much to the name "rs485-mux-gpios".
> 
> Suggestion:
> 
>     description: selects whether the UART is connect to an RS-232 driver (low)
>       or an RS-485 transceiver (high)

Indeed, I wasn't really able to come up with a good description. Thanks,
that's much better.

Rasmus

