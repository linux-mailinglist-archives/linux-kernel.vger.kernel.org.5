Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDCA7F276A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjKUI1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKUI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:27:10 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B87ED
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:27:06 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507e85ebf50so6888782e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1700555224; x=1701160024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqky3k19T0P2MCRPH6CIBr7V91/rccfoXJK3y1NnIu8=;
        b=RXoBwfehoJeAAb/T8P5AZOycCs9u/0JqoVsUak2sN+0067mnfQ1AfKWpPoA0h2H/Wm
         Gvqyv3IyRTjhWIzM+gyO3nnHGti4jUUqtPlXs6db13IBlyDO8kBVTooXalGTarVC3Wtm
         OzV47uDPgoZ7NUNZQMEvbkRHZNr0TdGXtnwZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700555224; x=1701160024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqky3k19T0P2MCRPH6CIBr7V91/rccfoXJK3y1NnIu8=;
        b=Tymy/ughdEAOEV9mtXDIrJREoWocE73RxR+e0nAuSvVJrcHJvy43NdqWukobTs+xhw
         BNYcqEUlILccXp6E/zvhjm+BdrHdJ5LwkxvcGTFqZX/LQ1bRnIoLCdacBOrYX7cR6y+/
         6BBbos1FD5GE+yckR5cblVl4E/WFrFkMrOywRWFWovrDhBsI/yGnuJ3LYZe2G3jw3f5w
         wm983m8GXaonYKUMc1jsCILqVQ+kkrIYreV013Za5RmG+ZuGy5qjn45XgLxOnp0BV8hA
         dcogWumJHDEL26RAyNi6qeU8MwbfUaSyJ9nRNrYz5dPS7qIefX/EoBSn16jTHrwkHN6i
         c0Ew==
X-Gm-Message-State: AOJu0Yw9n30KXkrFiXWE0P0CkgMQAzdkust+pImF/wckX4rrNXCS+TcS
        b3QYjjTx3A9EAJdwn9eCBRCd/Q==
X-Google-Smtp-Source: AGHT+IG7PzEFDvOVbc3ydtu7vTECnzCAornzVcTrO06lZCCYRpGCSSlBQv14R0Tk5YeOTa04wIdxgQ==
X-Received: by 2002:a19:f60d:0:b0:50a:5df2:f322 with SMTP id x13-20020a19f60d000000b0050a5df2f322mr7380823lfe.13.1700555224253;
        Tue, 21 Nov 2023 00:27:04 -0800 (PST)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id fc14-20020a056512138e00b0050aa8602e7dsm970575lfb.181.2023.11.21.00.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 00:27:03 -0800 (PST)
Message-ID: <1c016987-da88-47f2-bc1b-fcbe4c71a5c9@rasmusvillemoes.dk>
Date:   Tue, 21 Nov 2023 09:27:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Content-Language: en-US, da
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <fd5c7d9f-a52b-4abb-a0d4-f5bdf2a669de@linaro.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <fd5c7d9f-a52b-4abb-a0d4-f5bdf2a669de@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 08.52, Krzysztof Kozlowski wrote:
> On 20/11/2023 16:10, Rasmus Villemoes wrote:
>> Some boards are capable of both rs232 and rs485, and control which
>> external terminals are active via a gpio-controlled mux. Allow
>> describing that gpio in DT so that the kernel can transparently handle
>> the proper setting when the uart is switched between rs232 and rs485
>> modes.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  Documentation/devicetree/bindings/serial/rs485.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
>> index 9418fd66a8e9..e8136c7d22ed 100644
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
> Aren't you duplicating
> https://lore.kernel.org/all/3Nk.ZZrp.5w3Yn0Ecy5C.1bMzDp@seznam.cz/ ?

Hadn't seen that, but no, this is not at all the same. That patch seems
to define an input pin to tell whether to enable rs485 mode or not (sort
of early run-time version of the linux,rs485-enabled-at-boot-time).

> Anyway, similar comments: this does not look like generic RS485
> property. Are you saying that standard defines such GPIO?

No, I'm saying that several boards that exist in the wild have the
RX/TX/CTS etc. pins routed to a multiplexer, which in turn routes those
signals to either a rs485 transceiver or an rs232 driver (and those in
turn are connected to different screw terminals). So no, it's not a
property of the rs485 protocol itself, but very much related to making
use of rs485 (and rs232, though of course not simultaneously) on such
boards.

Would a link to a schematic help?

Rasmus

