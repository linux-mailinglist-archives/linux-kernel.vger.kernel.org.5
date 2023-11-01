Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BE17DE4EF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjKAQ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKAQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:57:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535B910F;
        Wed,  1 Nov 2023 09:57:52 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9d267605ceeso393366b.2;
        Wed, 01 Nov 2023 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698857871; x=1699462671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Sn6xBYx2DalfFZhDl/aI5XV9Hmv1XDDj4chPbF8qFs0=;
        b=WKD+d4VwDGvXkwbZtczTmG9T01GVwkx3KPgMBLuRWFKyA17xs9Ycmo1gglcbnXHidy
         qHC7molFd/k/hlmv1MI7H1fTuBXhRfzI7Z8r0l85OWmpfw9XZh2nl0Ve7s43VREhbBaB
         Ky79XAdzuihexy0NHCmwUGTIERYvtKgqGOCfM797OEyWPKEw1WSz9bGkRUqPbe38mO3M
         L5r56S7M0/oIl0DDcKK6M0GGu2izVTfOJ08Cm/4LH2KXenA/5gmrxJMp48MiSVKvdJ7t
         /qfIPkE+a4dEtgedXAtmfCxxpEiUZU6RW7+fwtR9FkRc+IOEiMNadKBcgwvME/92Z4uG
         7vOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698857871; x=1699462671;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sn6xBYx2DalfFZhDl/aI5XV9Hmv1XDDj4chPbF8qFs0=;
        b=aUdsv/OovyC5WyAzwp91G7Gj1RoHh2KoqrqY93zG8FiUpofxBhUWfFjo8t41Ojvvx1
         ebTmBQ9lbtUi0HfauyclNWitGUpKPJpvAZSkuMfiZOuomcg3jALY8S/iytHI5VxUMAN6
         4Dt6UmXO9fFsgCoLRwh5tyFb8j1/6FJy0QXnErVZ7Rpt0AWgep6mZssEBy2NI2UHWz6i
         NCso3YrvzR0CJq97hQaFLmHrE9b6HFTnBaWy9P/fyGdzXDz2S5ub1D1gFvvBmkBqXkZP
         nRKFeFT5J3NUJoC3dW8nzc8yKFwIwbRYjKbFXs6jpj+GnLXf2HzjqY0EGKXajEh7pEnf
         hsJg==
X-Gm-Message-State: AOJu0YzlXxCCGw7pib7hffj8MuOLtAzhS5Eio1O1Sz1lBGOkQghgSjfk
        TnF95xTLCOkLxOQuxpE21ZIRYFd0n9o=
X-Google-Smtp-Source: AGHT+IE2AzkdqRVh1pF7LSqeEwqf2m49EyXKhmuvBMNOr4KrVkn8m+KHfkU3P4arqosZ27//ryBgoQ==
X-Received: by 2002:a17:907:eab:b0:9bf:5df1:38c9 with SMTP id ho43-20020a1709070eab00b009bf5df138c9mr2530757ejc.9.1698857870436;
        Wed, 01 Nov 2023 09:57:50 -0700 (PDT)
Received: from ?IPV6:2a01:c22:6f25:5100:302f:4dfd:b45b:b65a? (dynamic-2a01-0c22-6f25-5100-302f-4dfd-b45b-b65a.c22.pool.telefonica.de. [2a01:c22:6f25:5100:302f:4dfd:b45b:b65a])
        by smtp.googlemail.com with ESMTPSA id x27-20020a170906135b00b009a5f1d15644sm135256ejb.119.2023.11.01.09.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 09:57:50 -0700 (PDT)
Message-ID: <f5f72cc3-0435-4ba0-8291-30d1ec2633a0@gmail.com>
Date:   Wed, 1 Nov 2023 17:57:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v2 1/2] net: phy: aquantia: add firmware load
 support
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>
References: <20231101123608.11157-1-ansuelsmth@gmail.com>
 <5af21f93-bb2d-42b1-b4d4-ee4443ffaff9@gmail.com>
 <65424cd9.5d0a0220.20d9a.fe0f@mx.google.com>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <65424cd9.5d0a0220.20d9a.fe0f@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.11.2023 13:57, Christian Marangi wrote:
> On Wed, Nov 01, 2023 at 02:01:33PM +0100, Heiner Kallweit wrote:
>> On 01.11.2023 13:36, Christian Marangi wrote:
>>> From: Robert Marko <robimarko@gmail.com>
>>>
>>> Aquantia PHY-s require firmware to be loaded before they start operating.
>>> It can be automatically loaded in case when there is a SPI-NOR connected
>>> to Aquantia PHY-s or can be loaded from the host via MDIO.
>>>
>>> This patch adds support for loading the firmware via MDIO as in most cases
>>> there is no SPI-NOR being used to save on cost.
>>> Firmware loading code itself is ported from mainline U-boot with cleanups.
>>>
>>> The firmware has mixed values both in big and little endian.
>>> PHY core itself is big-endian but it expects values to be in little-endian.
>>> The firmware is little-endian but CRC-16 value for it is stored at the end
>>> of firmware in big-endian.
>>>
>>> It seems the PHY does the conversion internally from firmware that is
>>> little-endian to the PHY that is big-endian on using the mailbox
>>> but mailbox returns a big-endian CRC-16 to verify the written data
>>> integrity.
>>>
>>> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>> Changes v2:
>>> - Move out of RFC
>>> - Address sanity check for offsets
>>> - Add additional comments on firmware load check
>>> - Fix some typo
>>> - Capitalize CRC in comments
>>> - Rename load_sysfs to load_fs
>>>
>>
>> To make the driver better maintainable: can the firmware handling code
>> be placed in a separate source code file, similar to what has been done
>> for the hwmon part?
>> If yes, then this could also be the right time to move the aquantia
>> driver to an own subdirectory.
>>
> 
> Sure! Np for me just is it really worth it? hwmod is a bigger one but
> this is really a few functions.
> 
r8169_firmware.c is even smaller and I've never regretted having it factored
out. Whether it makes sense depends on how much you share with the main module
and how the API is structured that you provide to the main module.
So I don't say you have to do it, I'm just saying it's worth considering it.

> Anyway if requested, I will move in v3 the driver to a dedicated
> directory and move the function to a separate file!
> 

