Return-Path: <linux-kernel+bounces-109071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85588881448
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A884281EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F82D50A64;
	Wed, 20 Mar 2024 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfbTrSDJ"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12154AEE0;
	Wed, 20 Mar 2024 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947620; cv=none; b=MrEn5JKa9OapHPwKZ/iy/7EyEVzMWDoXlD/R7GSsDiOD+vgkSVtzOmYq2zMwYln+fCJFOEE2DeZojuHq5gpQgKQLuOzvhneHbZ/tD/ML9SQ+MmpheUb630cUUM09YK2fQ9k261vEiEvdifo+kBKfqdcYQ78ODFUCoDk/+Z9/FXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947620; c=relaxed/simple;
	bh=oy82jAS+K4od7iotYUGirBmOwTU3OjjkQ24oDK3Gggo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3jEW8Cz3h9BlLliD8kWyzhfiA9IUGTbHANa8vEoOUwx0qx/pcDvJgz5g76/b48O3wDci/DjRH27U7fe58uaVMrqq1udU7tiW1yEqZCujx8g+0k7CGwbGUYCEMMMbcZ2djJv10YnDxU7q/Ya6eSJmAe7ax4SiWOcra3qiNYx0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfbTrSDJ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so4810724a12.0;
        Wed, 20 Mar 2024 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710947618; x=1711552418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Zk229qIBmp/wvP5+MV0xaelmWuyFuEIb+JQ53jj9Us=;
        b=BfbTrSDJE33iHub1tX1W9kuQ8kuXv+PDpBg2JFMthTwb+rBrQ7Zn04wPYcc7YSOSeW
         n3e41+2AiunQknG0V7OSTjp9gtDjeMDOinEw5Xp3IcVZlnpXFpNtZIDbl5KlJv8CVxL8
         jWo8NEOxkfMc0mr21u6wQ2f9v/OtIhgM3nuFDbsLRiLi4CYk0dRF5ODH116CvjxwHv1J
         r+Z8HSNl671M30el7dlr+/QE3tY+i3Q4I4o6wpqBK4AgD/lG5eeAPfZvcmVtxRkT4Yo5
         cGmJ4CJyYbZkQRrkfYYGhEPxciSujjZdi97qWMklQsmjzr4OrmhYKHViJUPtVnLFVgKj
         KAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710947618; x=1711552418;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Zk229qIBmp/wvP5+MV0xaelmWuyFuEIb+JQ53jj9Us=;
        b=QSwmjbPcKSZB+yfXe7JEoUrQ2xNgneE7l35dZMpNo3q8kXNoU/nQ83U5IaZYodHjkN
         a0FrhzZRUTvsseQGKk9P8SuUOmcgkwswwgq1qBRrLCNhqhofjmNgFfd1syXS7AdtdDk7
         6atqvX7V0z00XncFWIthaZ0wSAa17TlJ8lw6FzZShhVk5quL5qz2lViQZCJe7AxAmOPU
         5lKFm4f3WpLgcXSi6MbogaDof3jPMHOYb/UUdDT9Tk2mdF2SGItCd1dCNov82FA9AVXR
         GcuuQTs6PzN7tJJhqmqZMpp8BxrrDji0Pqj508DUDEzonUmpE5d9s1vrl+bbVvA+vzS1
         ZLTg==
X-Forwarded-Encrypted: i=1; AJvYcCXKDp27edH3akmO25vlGq6p6pnAHgziricYgCivdJDfAJG/D2g4bpQQQP4P0LysAAvJ4fo108JW4GvQddC7pvg9eFEuecxZEdTR4EimXV2r6PUdz90ZE8LiqDf2Q4as6tJD0yc2
X-Gm-Message-State: AOJu0YydzfCoQUpgvA9uXWZhUJSz14/im+wbrM1BKMPKCVsEnSPxjc2F
	JnmtAn9uHez95NfVIxzu337P5iPXcDJ/zf1vZMbHAkDSX4st2uAs
X-Google-Smtp-Source: AGHT+IGrD0aXXfZpU9oVG+P0sZtycKsNubS2M4dRG+WlicIxDnYTj8+aj0jMHU7/7dvZyFIM4UdfEg==
X-Received: by 2002:a17:902:fc84:b0:1de:f74c:2e08 with SMTP id mf4-20020a170902fc8400b001def74c2e08mr17502347plb.29.1710947617815;
        Wed, 20 Mar 2024 08:13:37 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e20300b001dcb654d1a5sm13758815plb.21.2024.03.20.08.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 08:13:37 -0700 (PDT)
Message-ID: <a5b2d1df-cf6e-42b6-8ccf-122be672db24@gmail.com>
Date: Wed, 20 Mar 2024 08:13:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: mv88e6xxx: add warning for truncated mdio bus
 id
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240320-mv88e6xxx-truncate-busid-v1-1-cface50b2efb@solid-run.com>
 <Zfrt_dlYvBzlxull@nanopsycho>
 <c76c95af-71cb-4eb6-b3af-846ae318d18d@solid-run.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <c76c95af-71cb-4eb6-b3af-846ae318d18d@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/20/2024 7:33 AM, Josua Mayer wrote:
> Am 20.03.24 um 15:09 schrieb Jiri Pirko:
>> Wed, Mar 20, 2024 at 02:48:55PM CET, josua@solid-run.com wrote:
>>> mv88e6xxx supports multiple mdio buses as children, e.g. to model both
>>> internal and external phys. If the child buses mdio ids are truncated,
>>> they might collide which each other leading to an obscure error from
>>> kobject_add.
>>>
>>> The maximum length of bus id is currently defined as 61
>>> (MII_BUS_ID_SIZE). Truncation can occur on platforms with long node
>>> names and multiple levels before the parent bus on whiich the dsa switch
>> s/whiich/which/
>>
>>
>>> sits such as on CN9130 [1].
>>>
>>> Test whether the return value of snprintf exceeds the maximum bus id
>>> length and print a warning.
>>>
>>> [1]
>>> [    8.324631] mv88e6085 f212a200.mdio-mii:04: switch 0x1760 detected: Marvell 88E6176, revision 1
>>> [    8.389516] mv88e6085 f212a200.mdio-mii:04: Truncated bus-id may collide.
>>> [    8.592367] mv88e6085 f212a200.mdio-mii:04: Truncated bus-id may collide.
>>> [    8.623593] sysfs: cannot create duplicate filename '/devices/platform/cp0/cp0:config-space@f2000000/f212a200.mdio/mdio_bus/f212a200.mdio-mii/f212a200.mdio-mii:04/mdio_bus/!cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi'
>>> [    8.785480] kobject: kobject_add_internal failed for !cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi with -EEXIST, don't try to register things with the same name in the same directory.
>>> [    8.936514] libphy: mii_bus /cp0/config-space@f2000000/mdio@12a200/ethernet-switch@4/mdi failed to register
>>> [    8.946300] mdio_bus !cp0!config-space@f2000000!mdio@12a200!ethernet-switch@4!mdi: __mdiobus_register: -22
>>> [    8.956003] mv88e6085 f212a200.mdio-mii:04: Cannot register MDIO bus (-22)
>>> [    8.965329] mv88e6085: probe of f212a200.mdio-mii:04 failed with error -22
>>>
>>> Signed-off-by: Josua Mayer <josua@solid-run.com>
>> This is not bug fix, assume you target net-next. Please:
>> 1) Next time, indicate that in the patch subject like this:
>>     [patch net-next] xxx
>> 2) net-next is currently closed, repost next week.
> Correct, thanks - will do.
> Just for future reference for those occasional contributors -
> is there such a thing as an lkml calendar?

There is this: https://patchwork.hopto.org/net-next.html

>>
>>> ---
>>> drivers/net/dsa/mv88e6xxx/chip.c | 6 ++++--
>>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
>>> index 614cabb5c1b0..1c40f7631ab1 100644
>>> --- a/drivers/net/dsa/mv88e6xxx/chip.c
>>> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
>>> @@ -3731,10 +3731,12 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
>>>
>>> 	if (np) {
>>> 		bus->name = np->full_name;
>>> -		snprintf(bus->id, MII_BUS_ID_SIZE, "%pOF", np);
>>> +		if (snprintf(bus->id, MII_BUS_ID_SIZE, "%pOF", np) >= MII_BUS_ID_SIZE)
>>> +			dev_warn(chip->dev, "Truncated bus-id may collide.\n");
>> How about instead of warn&fail fallback to some different name in this
>> case?
> Duplicate could be avoided by truncating from the start,
> however I don't know if that is a good idea.
> It affects naming of paths in sysfs, and the root cause is
> difficult to spot.
>>> 	} else {
>>> 		bus->name = "mv88e6xxx SMI";
>>> -		snprintf(bus->id, MII_BUS_ID_SIZE, "mv88e6xxx-%d", index++);
>>> +		if (snprintf(bus->id, MII_BUS_ID_SIZE, "mv88e6xxx-%d", index++) >= MII_BUS_ID_SIZE)
>> How exactly this may happen?
> It can happen on switch nodes at deep levels in the device-tree,
> while describing both internal and external mdio buses of a switch.
> E.g. Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml

We should consider moving these types of checks into the MDIO bus core, 
or at least introduce a helper function such that it embeds the check in it.
-- 
Florian

