Return-Path: <linux-kernel+bounces-15622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CE4822EFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F48B22F28
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C55F1A27F;
	Wed,  3 Jan 2024 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1RTFgGi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A6B19BBB;
	Wed,  3 Jan 2024 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3367632ce7bso8968495f8f.2;
        Wed, 03 Jan 2024 05:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704290192; x=1704894992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5wZdZQIqJWcF+FrruC3VdnNr+XtKnxzsHjM0hBgcsrk=;
        b=k1RTFgGiCjMOe11FSEOzwkY2O/wCubgsPArA0u0yA/KMgNTz6KBIKzRTdRrLa0VYX3
         NVtzgV4yONDM6qRzQ13lr7mRt3E5k4OF9UNzLTdWDaNZFgdYspnluJF03o5m465nJAKD
         kR/RGkdau/q626NGKIceUZMkMJx9tH/ziekastqHGOgGkuHroZoMe0nDBlefrHBjlLxW
         +qRPl5+5QX0dNnbDp/GPHBLEdro/LZqO5aqIrARH5gs6i7LosGmyvR+uDUt0BbPv3rYb
         XZSa3GbpCL1gZjbq7gRgN24GfE968gDRudp7wQz3Y3MP1HugyYedNUizwdOGo1mb6It0
         wqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704290192; x=1704894992;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wZdZQIqJWcF+FrruC3VdnNr+XtKnxzsHjM0hBgcsrk=;
        b=krQWWmvDc1DRcl88USHEqT4Fksgm+VYaSd1uvZTj9UZsKSLCmwgRZfNVVUYEH2QVkN
         gnaGp5p1GbxSGECCiuX1KE/CwEH9cBU5YPTmvLZBu+ZolgbAGID76PlJFPfY0n2vjhot
         JNyipc9+XUVGh7norVejozl/IXPS4i5mmPWfOUn3oOMIxT/EAArZjZbk/4LAHblW0JLc
         42s6MKoJb5AuycsK5uQSNmRv9w05WzRF6+k9SH/FtimXervw+IZQqWee93gqjIkf5Jj/
         FwtdF5iQHw5KUGeg2Ay0U3luI3QNiuVUs4J+f5sF2gMuoyXisWHPL1xHBMTKQNbVIh/y
         vBwA==
X-Gm-Message-State: AOJu0YyHKXEFDWZj7ljQghuyuczRijrBJX49mjlZTFF7ZgHsI7ydaraF
	3z1HN2sjPG0JDTwzlCdIo6Y=
X-Google-Smtp-Source: AGHT+IHLFTbgVFdxcVt9YhZQNQNrjIK2zX+NW/PYeJPxOjKf1xQBMe3f72mYI/Mn0yUep8sj2VsDsA==
X-Received: by 2002:adf:f8d1:0:b0:336:73d6:413b with SMTP id f17-20020adff8d1000000b0033673d6413bmr8190262wrq.44.1704290191796;
        Wed, 03 Jan 2024 05:56:31 -0800 (PST)
Received: from ?IPV6:2a01:c22:7399:5700:b8cf:27e9:e910:c205? (dynamic-2a01-0c22-7399-5700-b8cf-27e9-e910-c205.c22.pool.telefonica.de. [2a01:c22:7399:5700:b8cf:27e9:e910:c205])
        by smtp.googlemail.com with ESMTPSA id b7-20020a5d45c7000000b00336c6b77584sm21701987wrs.91.2024.01.03.05.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 05:56:31 -0800 (PST)
Message-ID: <e427f944-f95f-47a4-b745-362b6516e6e8@gmail.com>
Date: Wed, 3 Jan 2024 14:56:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: fix building with CONFIG_LEDS_CLASS=m
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
 Lee Jones <lee@kernel.org>
References: <20240103102630.3770242-1-arnd@kernel.org>
 <5b0a6150-8043-4de7-980f-54020a3e7981@gmail.com>
 <b310230b-f20b-489a-97ed-908df193a942@app.fastmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <b310230b-f20b-489a-97ed-908df193a942@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03.01.2024 13:45, Arnd Bergmann wrote:
> On Wed, Jan 3, 2024, at 12:33, Heiner Kallweit wrote:
>> On 03.01.2024 11:26, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> When r8169 is built-in but the LED support is a loadable module, the
>>> new code to drive the LED now causes a link failure:
>>>
>>> ld: drivers/net/ethernet/realtek/r8169_leds.o: in function `rtl8168_init_leds':
>>> r8169_leds.c:(.text+0x36c): undefined reference to `devm_led_classdev_register_ext'
>>>
>>> Add a Kconfig dependency to prevent the broken configuration but still
>>> allow having the network code built-in as long as CONFIG_LEDS_TRIGGER_NETDEV
>>> is disabled, regardless of CONFIG_LEDS_CLASS.
>>>
>> The proposed change is more of a workaround IMO. A proper fix (in LED 
>> subsystem)
>> has been submitted, but it's not reviewed/applied yet. And I don't 
>> think building
>> r8169 should depend on support for an optional feature.
>> This fix would also allow to remove Kconfig dependencies similar to the 
>> one
>> proposed here from other drivers. Link to submitted fix:
>>
>> https://lore.kernel.org/linux-leds/0f6f432b-c650-4bb8-a1b5-fe3372804d52@gmail.com/T/#u
> 
> I think that is a much worse workaround, as this just leads to
> a feature silently not working even when it is enabled (as loadable
> module), and hiding other dependency problems where drivers
> actually require the LED support to do something useful.
> 
Whether implicit dependency detection is considered a bad thing,
may depend on personal taste. However I see your point.

> IS_REACHABLE() is pretty much always a bad idea because of this.
> 
> If you want the LED support in r8169_leds to be optional, I would
> suggest adding a separate Kconfig symbol for that, either user
> visible or hidden, and have the correct Kconfig dependencies
> for the new symbol, something like the change below (untested).
> 
Sounds good, as this would also allow to omit compiling r8169_leds.c
if LEDS_CLASS isn't reachable. I'll give it a try.

>      Arnd
> 
Heiner

> 8<---
> diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
> index fd3f18b328de..b54aae30b3c1 100644
> --- a/drivers/net/ethernet/realtek/Kconfig
> +++ b/drivers/net/ethernet/realtek/Kconfig
> @@ -114,4 +114,9 @@ config R8169
>           To compile this driver as a module, choose M here: the module
>           will be called r8169.  This is recommended.
>  
> +config R8169_LEDS
> +       def_bool y
> +       depends on LEDS_TRIGGER_NETDEV && R8169
> +       depends on !(R8169=y && LEDS_CLASS=m)
> +
>  endif # NET_VENDOR_REALTEK
> diff --git a/drivers/net/ethernet/realtek/Makefile b/drivers/net/ethernet/realtek/Makefile
> index adff9ebfbf2c..635491d8826e 100644
> --- a/drivers/net/ethernet/realtek/Makefile
> +++ b/drivers/net/ethernet/realtek/Makefile
> @@ -6,8 +6,6 @@
>  obj-$(CONFIG_8139CP) += 8139cp.o
>  obj-$(CONFIG_8139TOO) += 8139too.o
>  obj-$(CONFIG_ATP) += atp.o
> -r8169-objs += r8169_main.o r8169_firmware.o r8169_phy_config.o
> -ifdef CONFIG_LEDS_TRIGGER_NETDEV
> -r8169-objs += r8169_leds.o
> -endif
> +r8169-y += r8169_main.o r8169_firmware.o r8169_phy_config.o
> +r8169-$(CONFIG_R8169_LEDS) += r8169_leds.o
>  obj-$(CONFIG_R8169) += r8169.o
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 05ba5f743af2..f3321299b2fa 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5356,11 +5356,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>         if (rc)
>                 return rc;
>  
> -#if IS_REACHABLE(CONFIG_LEDS_CLASS) && IS_ENABLED(CONFIG_LEDS_TRIGGER_NETDEV)
> -       if (tp->mac_version > RTL_GIGA_MAC_VER_06 &&
> +       if (IS_ENABLED(CONFIG_R8169_LEDS) &&
> +           tp->mac_version > RTL_GIGA_MAC_VER_06 &&
>             tp->mac_version < RTL_GIGA_MAC_VER_61)
>                 rtl8168_init_leds(dev);
> -#endif
>  
>         netdev_info(dev, "%s, %pM, XID %03x, IRQ %d\n",
>                     rtl_chip_infos[chipset].name, dev->dev_addr, xid, tp->irq);


