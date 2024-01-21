Return-Path: <linux-kernel+bounces-32078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EF0835639
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24241F22E1E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEFA374FE;
	Sun, 21 Jan 2024 15:07:39 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B362628C;
	Sun, 21 Jan 2024 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705849659; cv=none; b=QwSMA+LM3dzLLNDGghxD0XjhOaezfF5tvYkaa/JODC4Ovut13MQvRbZGXB5FSyTCLdCTPnawKl5pcIYsKQ87jJnwP15I0DB4fYsyMSWkXBkkAbhqIaBpQN8anINKK9mN/nY5SbzlZ/HGVLqIijniOc/LPiI/3FDvGX8OsrHeJcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705849659; c=relaxed/simple;
	bh=0vf7nfJn7HrAvHOdgIzLADBW0X0/fBnQZXV99GsYa28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdvGtpdH3a/lQ3458lwPnn2upS575sA1TNNRklx5x0CuGQvD79qby1wFkK5BH5p1+CS79zNhDVsVCPgxq28Bbh37m53B/32PHp5u+TmwJHCze/GyEl3gHIp9p+tCqllppUDwnLzZNl0+HRQFJdXb/5mhz0i6QAt+dk/2SwFmVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 4374282E39;
	Sun, 21 Jan 2024 16:07:31 +0100 (CET)
From: Duje =?utf-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/3] leds: ktd2692: move ExpressWire code to library
Date: Sun, 21 Jan 2024 16:06:53 +0100
Message-ID: <5747658.DvuYhMxLoT@radijator>
In-Reply-To:
 <CACRpkdZJyY9oYMt3TvDEGthN-Wvz3t_40t9P-VsgTKCJQaD=pw@mail.gmail.com>
References:
 <20240120-ktd2801-v3-0-fe2cbafffb21@skole.hr>
 <20240120-ktd2801-v3-1-fe2cbafffb21@skole.hr>
 <CACRpkdZJyY9oYMt3TvDEGthN-Wvz3t_40t9P-VsgTKCJQaD=pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Autocrypt: addr=duje.mihanovic@skole.hr;
 keydata=
 mQINBGBhuA8BEACtpIbYNfUtQkpVqgHMPlcQR/vZhB7VUh5S32uSyerG28gUxFs2be//GOhSHv+
 DilYp3N3pnTdu1NPGD/D1bzxpSuCz6lylansMzpP21Idn3ydqFydDTduQlvY6nqR2p5hndQg6II
 pmVvNZXLyP2B3EE1ypdLIm6dJJIZzLm6uJywAePCyncRDJY0J7mn7q8Nwzd6LG74D8+6+fKptFS
 QYI8Ira7rLtGZHsbfO9MLQI/dSL6xe8ZTnEMjQMAmFvsd2M2rAm8YIV57h/B8oP5V0U4/CkHVho
 m+a2p0nGRmyDeluQ3rQmX1/m6M5W0yBnEcz5yWgVV63zoZp9EJu3NcZWs22LD6SQjTV1X8Eo999
 LtviIj2rIeCliozdsHwv3lN0BzTg9ST9klnDgY0eYeSY1lstwCXrApZCSBKnz98nX9CuuZeGx0b
 PHelxzHW/+VtWu1IH5679wcZ7J/kQYUxhhk+cIpadRiRaXgZffxd3Fkv4sJ8gP0mTU8g6UEresg
 lm9kZKYIeKpaKreM7f/WadUbtpkxby8Tl1qp24jS1XcFTdnjTo3YB2i2Rm9mAL2Bun9rNSwvDjE
 fjMt5D5I+CIpIshaQwAXwRTBJHHAfeEt62C1FQRQEMAksp4Kk1s2UpZkekZzNn48BnwWq75+kEj
 tuOtJIQGWTEHBgMG9dBO6OwARAQABtClEdWplIE1paGFub3ZpxIcgPGR1amUubWloYW5vdmljQH
 Nrb2xlLmhyPokCTgQTAQgAOAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBFPfnU2cP+EQ+
 zYteJoRnrBCLZbhBQJg01LLAAoJEJoRnrBCLZbhMwoQAJBNKdxLxUBUYjLR3dEePkIXmY27++cI
 DHGmoSSTu5BWqlw9rKyDK8dGxTOdc9Pd4968hskWhLSwmb8vTgNPRf1qOg2PROdeXG34pYc2DEC
 0qfzs19jGE+fGE4QnvPCHBe5fkT2FPCBmNShxZc1YSkhHjpTIKHPAtX1/eIYveNK2AS/jpl23Uh
 hG9wsR2+tlySPNjAtYOnXxWDIUex8Vsj2a2PBXNVS3bRDeKmtSHuYo7JrQZdDc0IJiRm0BiLEOI
 ehTtcYqYr1Ztw7VNN2Mop/JG2nlxXNaQmyaV6kF/tuaqn1DJQcb0OxjAXEUMaICYJOwS9HSt26n
 uwo8dUiUPLQTih/wm6tyu2xrgMwqVT5jiKIssSS+7QNTsmldubRSYjFT49vwkVoUQ6Z3UO6BVdd
 f3OG4meE0S5uQc7Moebq67ILxfQ8XsDvdvEliVuHh89GAlQOttTpc6lNk8gCWQ+LFLvS66/6LFz
 mK1X4zC7K/V6B2xlP4ZIa3IC9QIGuQaRsVBbbiGB3CNgh0Sabsfs4cDJ7zzG1jE7Y4R9uYvdSFj
 Liq5SFlaswQ+LRl9sgzukEBTmNjdDVhufMY2jxtcMtck978E1W1zrg94iVl5E0HQZcpFHCZjRZX
 Fa42yPsvVkFwy4IEht9UJacMW9Hkq5BFHsdToWmg7RY8Mh04rszTiQJUBBMBCAA+AhsDBQsJCAc
 CBhUKCQgLAgQWAgMBAh4BAheAFiEEU9+dTZw/4RD7Ni14mhGesEItluEFAmCVBxAFCQXW6YEACg
 kQmhGesEItluFXIg//QnqY5RrQ1pLw2J51UwFec4hFMFJ6MixI9/YgizsRd2QLM7Cyi+ljkaHFQ
 mO4O5p0RsbF/2cc4u1D+MhQJGl6Ch6bdHoiWFrNUexgBUmflr4ekpI+GIFzikl6JTYHcRfkjobj
 0Tmr8zWoxzcdFhrzGn5/6AH3GxudpUr6WQD5iDSe43T7ZcY8zHfD+9zcsZ2LHhRhpHU0q+ERQw+
 Rnh7C3urXlrAlFzuKuPh2tHT76glRaledJ8cK34vHNi73TYpsFy4tfhAPhHwBogtjBf63jBOd/E
 S6wuYpKwcfNXo9EuEpJzJOitFwOvAra5AbCE+N/C/IOu2aFeOyu2SbHro06+Eyf/jy1A2t+LgLb
 E5cZu5ETyicfpN8L7m7wTTXTSx0NhETNWfgV95RUI6WIW5N4OCOVo8d/GOMVEYqMoDZndQin9B3
 lDgojyagdzhXljP2BqavKdnPWbcKQ+JViR+e7EjLWVifgZkAvEhyirbTKYsgKkaRxoQP68U0bEy
 ukygDZRdzBmWaZPqBOzA5AH+OYiYVzzFqdBAHr2+z4mTN6W0td7CFDRAS2RzQApO3B1QH408Ke9
 Oy69HwG+gdlfwloN6JTvgr5vQc8T6e3iC3Be/guLyW5UbLPxyFHimznVOizDYbZO1QSZMqk4G9I
 gA8e05P8dxEQJUsdZFtDdNPOYm5Ag0EYGG4DwEQAMD0bO0u9apmI1WOk41IdU1Hc76HLUA9jsiB
 ffA9yZ1OpnFEIAwSeUO8PFK7W5YPdRreNsUvMmBiLJid9y0tW5sACjSrH+amCQl0hJ3KlEkr+Vu
 Wga1a+Ye0qzg87bQae769RhwzEPvQvvNoTxTtvT5Alg2p3JSv5d/wC2Tu9IoFKkDAIoCFsvytuZ
 r2LuH3oK57oThhbEogYXR7YJ0JIwVg7nOQXnqpUTzxkh/73FKN6Bx01m37pB3wTe8w3w8r8WOip
 oRU+aPWhafDNFrdyBfSVOAw3fmX9yAfFfZo4w9OTdkrLLdK6SmX7mqiMstoZnvZIpLRk/L0ZNrJ
 8fAVD+fEcpUiCoKwiiY0QFCWumMXITeD4zlo/Y6lQKhUp6EY0kcjG1D7n5sBR5oQcsC9PlH9a12
 L+tNIfljayiEVobmkPwGf5p3sxOqeks6WWoB9+ZIk888kQdI/b7VA/86QvsTqubpJtr5uVNtyyj
 ZYTBHFnEGcA5+Rs2K/8TWFYDEBZiybfpCxrYT2RdTF7ef2wQZAiNZhzaEwxr7S4YTFuCwwqaKLt
 vckGv2fsFUy3qe28tw93oCNQxSqgOq6RD0HfblViXeioyP1nWVLAx6paS7d38TT6cz0HJCtOMFn
 S+UpJDv2x3gReCPBoqRx7LV4aYMyGy4pzwes+yO87hxULtw/ABEBAAGJAjYEGAEIACAWIQRT351
 NnD/hEPs2LXiaEZ6wQi2W4QUCYGG4DwIbDAAKCRCaEZ6wQi2W4de4D/0aCxE4dTmO1xQ6BDXlKp
 DCegk8dIqrxK8Edbdq9/WGSO6Js0QfIL50IHAR739FbScT4+oSObeg0ap9kCGfW0AXGZaU82Ed1
 5u+MzgksHE+t8cgULTKjqqt+PXq0yxZfLwI9itTa3zE2d6Uxd4Vzq77jjQuDL6o3zM6BQTJGYxx
 S6mELElcnMlo9lIZKzCAHaIkkMlMNBfvm8Q92aCuQ75xjWhis9K9lyV9cQZfu8AyP4zMGFk50Z5
 tEF2UFylqKu+v8FZiezviwu9NsZegIY4DRaPWF5GWmFhYU4e9gBFG5xhEoIlO+etu1nSE1UJk+r
 mvJL20uKNUPnhXTJaQTzACpA1/2FqDnOUUx8qOYqmHMlFuy2qUh/QHShjc2AtngTFZrzAnGz6ni
 lRl32b7p8N+KaO4u2UGmGOwd/CuCzr2DxGomUSyCwOta7vOxator+NPK48roa417gBZ6ZFRplma
 ExicLFSnwBdGC3NnDa+yoRHKXHVSDfkb/FEhWuN/1tTZ96uxVYtHcln+snB2N6/hwmrOon2cHNu
 UeTLcrVyqI0Qz8JT4ksGxkxziO2L/e0O/xUp9mLAswixWt8+BMz/3sIJbdAPBVyt5QbHzWR6aID
 B5cQ1aQwZB8n7yt8B0sd/uIQItYu2urJ9gVAJkaEDms8+vbtOM4totXk5swwGxRg==
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, January 21, 2024 3:35:46 PM CET Linus Walleij wrote:
> > +extern void expresswire_power_off(struct expresswire_common_props 
*props);
> > +extern void expresswire_enable(struct expresswire_common_props *props);
> > +extern void expresswire_start(struct expresswire_common_props *props);
> > +extern void expresswire_end(struct expresswire_common_props *props);
> > +extern void expresswire_set_bit(struct expresswire_common_props *props,
> > bool bit);
> I would skip the keyword "extern" since it is default I think even
> checkpatch complains about it these days?

Doesn't seem to, I tried it myself:

$ git format-patch HEAD~3
0001-leds-ktd2692-move-ExpressWire-code-to-library.patch
0002-dt-bindings-backlight-add-Kinetic-KTD2801-binding.patch
0003-backlight-Add-Kinetic-KTD2801-backlight-support.patch
$ ./scripts/checkpatch.pl 0001-leds-ktd2692-move-ExpressWire-code-to-
library.patch            
total: 0 errors, 0 warnings, 291 lines checked

0001-leds-ktd2692-move-ExpressWire-code-to-library.patch has no obvious style 
problems and is ready for submission.

I'll keep that in mind if a v4 is needed though.

Regards,
--
Duje




