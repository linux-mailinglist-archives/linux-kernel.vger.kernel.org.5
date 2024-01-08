Return-Path: <linux-kernel+bounces-19402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69A1826C6F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3607FB21E6D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F56014A97;
	Mon,  8 Jan 2024 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8f9VfFC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF8814288;
	Mon,  8 Jan 2024 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2a225e9449so141871466b.0;
        Mon, 08 Jan 2024 03:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704712710; x=1705317510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oubx1nXjvpasYUDXx1K/HSxnBXOhuFpwaiFEMhm9n7w=;
        b=l8f9VfFC8uQNkUiboES4MJVJnAfcYFLYvSflcL4P5en32qjjTXmuGftKbGIOpzLJLD
         YV98xhpzmwsIvsi46L+j8IchlfwtpkQq8Mewa4LCTvf/uv7L+7+9T5hIRtGz306iE1t1
         v6OWz95bZAi/EAHm3lDBryyBRR+fLzEkt6duw3vd0Lf9Ok1lzvNvUJ37iPZrPcEPEEUk
         nJBuq1lzv4fgDK3o1+/LevIQAIqAZoJJ+OTpt1yTHjMAKd8+3IzRDf7edJM9wSs7zurt
         47s9XPB9bz4NT66XFbM7aVQyq8RmnvTNxgV6ZsjGel4tMrzB4KqsZa1ZR6sfdKaRbaa2
         aHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704712710; x=1705317510;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oubx1nXjvpasYUDXx1K/HSxnBXOhuFpwaiFEMhm9n7w=;
        b=eJv/8U5CrX+snhdW8HhYoFpJJozl/IeA0/WVFaYrbFCrSVWtqoLjts8f5Pg8Rf6MyO
         81zf48f0wqBghgON4ceaIpF9Et9LHkg//ImbmmoY1vc95pP4IK7tFULZvOjY0zjAiVuO
         Wj3GvN9DD52kImhFiOnfgRyI79HNYldxUHW+1edR97y2PgaCCMD+sfGHuQP362bNxOtM
         QRHNtsqOQoQhgmZeSPS3xxL/jIH1k/akF+8fZNhc74PVs7k0p/2iN5b9QZfkMSqVwehJ
         jeR1mt41ovIrPITHs4IV9Q49MEztItNTB2EE2i6x23iDwrmkOEGpdJsqormw1LYATfaI
         m2gA==
X-Gm-Message-State: AOJu0Yzd8QGJC6fN0OBhc8vwV4qWI7liWJ4Zul9MaOCzPiP98SFWG4Q9
	zFM3J2u0rmwSnKXJFrUDzfU=
X-Google-Smtp-Source: AGHT+IFnUe1QwnBp1PDuXxhyjgShXu1oS7MQyJps9UWxQ84y7mXpaDB9+t+aKcXBL6dkw2dNkSo1OA==
X-Received: by 2002:a17:906:74c1:b0:a28:808a:81fb with SMTP id z1-20020a17090674c100b00a28808a81fbmr1710878ejl.7.1704712710166;
        Mon, 08 Jan 2024 03:18:30 -0800 (PST)
Received: from ?IPV6:2a01:c22:6f31:8f00:9009:65a0:ed7:b9d? (dynamic-2a01-0c22-6f31-8f00-9009-65a0-0ed7-0b9d.c22.pool.telefonica.de. [2a01:c22:6f31:8f00:9009:65a0:ed7:b9d])
        by smtp.googlemail.com with ESMTPSA id oq8-20020a170906cc8800b00a293280c16csm3693633ejb.223.2024.01.08.03.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 03:18:29 -0800 (PST)
Message-ID: <bb44432d-0cde-47cd-a44c-be5e3f11afab@gmail.com>
Date: Mon, 8 Jan 2024 12:18:30 +0100
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
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
In-Reply-To: <20240108093702.13476-1-dima.fedrau@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08.01.2024 10:36, Dimitri Fedrau wrote:
> Changes in v2:
> 	- used defines MDIO_CTRL1_LPOWER and MDIO_PMA_CTRL1_SPEED1000
> 	  in mv88q222x_config_aneg_preinit
> 	- use genphy_c45_loopback
> 	- mv88q2xxx_read_status reads speed, master or slave state when
> 	  autonegotiation is enabled
> 	- added defines for magic values in mv88q222x_get_sqi
> 
> Changes in v3:
> 	- mv88q2xxx_read_status includes autonegotiation case
> 	- add support for 100BT1 and 1000BT1 linkmode advertisement
> 	- use mv88q2xxx_get_sqi and mv88q2xxx_get_sqi_max, remove
> 	  mv88q222x_get_sqi and mv88q222x_get_sqi_max
> 	- fix typo: rename mv88q2xxxx_get_sqi and mv88q2xxxx_get_sqi_max to
> 	  mv88q2xxx_get_sqi and mv88q2xxx_get_sqi
> 	- add define MDIO_MMD_PCS_MV_RX_STAT for magic value 0x8230, documented
> 	  in latest datasheets for both PHYs
> 
> Changes in V4:
> 	- clean up init sequence
> 	- separate patch for fixing typos in upstreamed code
> 
> Dimitri Fedrau (5):
>   net: phy: Add BaseT1 auto-negotiation constants
>   net: phy: Support 100/1000BT1 linkmode advertisements
>   net: phy: c45: detect 100/1000BASE-T1 linkmode advertisements
>   net: phy: marvell-88q2xxx: fix typos
>   net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
> 
>  drivers/net/phy/marvell-88q2xxx.c | 234 +++++++++++++++++++++++++++---
>  drivers/net/phy/phy-c45.c         |   3 +-
>  include/linux/marvell_phy.h       |   1 +
>  include/linux/mdio.h              |   8 +
>  include/uapi/linux/mdio.h         |   2 +
>  5 files changed, 230 insertions(+), 18 deletions(-)
> 
net-next is closed. Let's see whether the maintainers still accept your series.
Otherwise you may have to resubmit once net-next opens again.


