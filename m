Return-Path: <linux-kernel+bounces-19430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 637AC826CC7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1EB1C21F11
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD5725102;
	Mon,  8 Jan 2024 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3GuYmbr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAE124A16;
	Mon,  8 Jan 2024 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e7abe4be4so1929367e87.2;
        Mon, 08 Jan 2024 03:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704713334; x=1705318134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=34+Hh1uk9VxtvZ2GfRjoXGwErtXBneQsLCS3zgd7mFU=;
        b=R3GuYmbrcV/lEG2tQO50Omd2Vk58f5fUQ2WM+zWfVd6Zw9+d9dx1hzKSMEQP5l8Qhc
         kfY6Db7Gp4u3AHWOXYYe8Bvvfdr059ximHZ82I5gS9ghrI0AbYSYpPAjc2/Z8IG7qCPR
         dKQtiziWtznUg4a9RL0PmvW2VDsGJQV4K2RL8/B3Kq6P3Rw7DOoSSkZif96ib9ld0FZW
         /QptZfp826eXPr40nJW68VIxAY2H4bqdF6PJwDukZDDzK189WBKKHZ9EJY7VvhFW03Uc
         3Z/RScpO041ZJ3nuOS5nAtP8ZiS1i2Uj1b4JRd1x7VZzvn+kFxY443ujx/xYD6Voi1Z1
         T2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704713334; x=1705318134;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34+Hh1uk9VxtvZ2GfRjoXGwErtXBneQsLCS3zgd7mFU=;
        b=VBRY+kM4cYBz/Ko7eWJc9qvuYBq3bu4zMHN4sRFcPaSOtcFZ7V3zeMxW0G1lsqSXkO
         ILwuVPg9fNx7XSwEnuEQzM2stGCmFUKsX+RvaseKti7Y3d8ci6Ztg8RWX2KWIVjjN5wo
         U+0eXTtYkNwYG1lLxf97wQDr2kurf7/Yc1FivqFrChHtacImiU4EbPyM6wFaoa4Jwash
         an2mO93O1y34p1p439Foyg0Oiyt1VvVHv7pjTN8JniE+cZyDK/LmaP1zaGFvoO7IT50U
         rsuHnLhrffPZ7Tet0R1/MVuM9e+6j2PHJpsnIYML75ztG06WXKKAgYb8ykqj5TrTJRZx
         IP9g==
X-Gm-Message-State: AOJu0YwlsM+uhmK8ZZ+hk2yUNZm75YUNcAd3t6miK0cCnEpW1u41VonY
	0I0Ai0D26cj5/bKaq33ezLo=
X-Google-Smtp-Source: AGHT+IGn/2vZPSk/8n6rmWmLg+R5k7+IUkawAqpMXWY+zlyCYCX3GaqtEIYati7VBNCGFPGHA0vAaw==
X-Received: by 2002:ac2:48a6:0:b0:50e:beb0:5f96 with SMTP id u6-20020ac248a6000000b0050ebeb05f96mr930361lfg.46.1704713334145;
        Mon, 08 Jan 2024 03:28:54 -0800 (PST)
Received: from ?IPV6:2a01:c22:6f31:8f00:9009:65a0:ed7:b9d? (dynamic-2a01-0c22-6f31-8f00-9009-65a0-0ed7-0b9d.c22.pool.telefonica.de. [2a01:c22:6f31:8f00:9009:65a0:ed7:b9d])
        by smtp.googlemail.com with ESMTPSA id lc8-20020a170906dfe800b00a2b09bfb648sm113600ejc.5.2024.01.08.03.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 03:28:53 -0800 (PST)
Message-ID: <01f4cadb-fdf2-4cc9-a5db-4e0fa2636159@gmail.com>
Date: Mon, 8 Jan 2024 12:28:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 0/5] net: phy: marvell-88q2xxx: add driver for
 the Marvell 88Q2220 PHY
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240108093702.13476-1-dima.fedrau@gmail.com>
 <bb44432d-0cde-47cd-a44c-be5e3f11afab@gmail.com>
 <20240108112418.GA30325@debian>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240108112418.GA30325@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08.01.2024 12:24, Dimitri Fedrau wrote:
> Am Mon, Jan 08, 2024 at 12:18:30PM +0100 schrieb Heiner Kallweit:
>> On 08.01.2024 10:36, Dimitri Fedrau wrote:
>>> Changes in v2:
>>> 	- used defines MDIO_CTRL1_LPOWER and MDIO_PMA_CTRL1_SPEED1000
>>> 	  in mv88q222x_config_aneg_preinit
>>> 	- use genphy_c45_loopback
>>> 	- mv88q2xxx_read_status reads speed, master or slave state when
>>> 	  autonegotiation is enabled
>>> 	- added defines for magic values in mv88q222x_get_sqi
>>>
>>> Changes in v3:
>>> 	- mv88q2xxx_read_status includes autonegotiation case
>>> 	- add support for 100BT1 and 1000BT1 linkmode advertisement
>>> 	- use mv88q2xxx_get_sqi and mv88q2xxx_get_sqi_max, remove
>>> 	  mv88q222x_get_sqi and mv88q222x_get_sqi_max
>>> 	- fix typo: rename mv88q2xxxx_get_sqi and mv88q2xxxx_get_sqi_max to
>>> 	  mv88q2xxx_get_sqi and mv88q2xxx_get_sqi
>>> 	- add define MDIO_MMD_PCS_MV_RX_STAT for magic value 0x8230, documented
>>> 	  in latest datasheets for both PHYs
>>>
>>> Changes in V4:
>>> 	- clean up init sequence
>>> 	- separate patch for fixing typos in upstreamed code
>>>
>>> Dimitri Fedrau (5):
>>>   net: phy: Add BaseT1 auto-negotiation constants
>>>   net: phy: Support 100/1000BT1 linkmode advertisements
>>>   net: phy: c45: detect 100/1000BASE-T1 linkmode advertisements
>>>   net: phy: marvell-88q2xxx: fix typos
>>>   net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
>>>
>>>  drivers/net/phy/marvell-88q2xxx.c | 234 +++++++++++++++++++++++++++---
>>>  drivers/net/phy/phy-c45.c         |   3 +-
>>>  include/linux/marvell_phy.h       |   1 +
>>>  include/linux/mdio.h              |   8 +
>>>  include/uapi/linux/mdio.h         |   2 +
>>>  5 files changed, 230 insertions(+), 18 deletions(-)
>>>
>> net-next is closed. Let's see whether the maintainers still accept your series.
>> Otherwise you may have to resubmit once net-next opens again.
>>
> Hi Heiner,
> 
> thanks for the information, next time I will check if net-next is
> closed.
> 
https://lwn.net/Articles/727558/

> Best regards,
> Dimitri Fedrau


