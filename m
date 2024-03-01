Return-Path: <linux-kernel+bounces-89203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 601BC86EBF1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B90B8B223DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0390E5EE69;
	Fri,  1 Mar 2024 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGAFU10i"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823533EA62;
	Fri,  1 Mar 2024 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709332709; cv=none; b=tlkaST7I3mj5fQswV+eMKHUTmrxMPr2Gebh9NRMWgun2HRR2lkQDPhgJ6/v82MtzZiH3de4ngtDZf+2Jbe1aHlXKvp+erQ8AlrttWWo/h+C6UDGj/6DuKeelX2E7RblEgdyx5LlaJ73fC5/H99R/ZjOQxRKFUFbPHw2R6Z/nCFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709332709; c=relaxed/simple;
	bh=2oeqnbNEqj1XEOfW41kuxYwPr4UUYPr+qKlxU04e4HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5wuqL5kS+STHo7ZM7cgR4Oxyq7N4P4a236vNgpislssIk7kS4L2e+J60WgbRUpE+YaRd3ojkqEaw2XRyTC1ziyWp2bUTRtQh771cqbNQ09r0Cop0ghyErNzZbDv583g7obnhonXMcbWxiXc1Fj2J1J4msqrUUYgbFDmdS/gKZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGAFU10i; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a293f2280c7so499938766b.1;
        Fri, 01 Mar 2024 14:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709332706; x=1709937506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uO3CRciM37ySQLH+bP8aVuiLzTJXs/5kknVLP7OhEWI=;
        b=XGAFU10i3YnUfJ8E1jSIYTc3GsqoKEAzqokTzgYu9YF3mzeMT7jI/MaZbuRu+boJcp
         6wLoWJYxDIox4cLpFy/ubbGApJHbqFOxiRaUxZoN7H+Xj3OWZzTUyYcWGysJTqzUG/KF
         nx/wels9gJ8O78g/TJTAk2Mt0JgvAEUjRdO64xScTvpbkV6F44Pc7CDcC3RRscyeWsb9
         ZQvAEzbi/ctiu2Io5G6rkv5pro2jMHmQF3PkG6ECwSG77ND+8bEZk31HXaSUpIsRKlA1
         eqI4ydjPTKvYEKgQGjD9F+vJIY2ssddrr/v7+NSUcdn5TCjBc3VHbjeEvIal+ZxOAiFb
         YDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709332706; x=1709937506;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uO3CRciM37ySQLH+bP8aVuiLzTJXs/5kknVLP7OhEWI=;
        b=RNE3bdPYLYg9auFzjBgcKtPUVbOwqtPI1/uaR9hOquQ7hClI3iXEddI1sE7A2whAPe
         bBKc+fGBYZxV0VcD8K/mQO0qKjvPt3kX2IHdCEb8ZhMXXxIQuxJzatCvZWoD3psBcYge
         YHazLaxZPcH78k2EoXDnKosLqRsYJXuqfIOmP7F+0v083a8B8U/uU1S4GkzK/dqITG0k
         iWCehao2QRklPiRheHHveGvnEMRE5FqLrryrml0YnUbEsxFV4veylDZ3lob4y/L/BBC5
         Adho9gKdyQbFAVpDVDcdzGBB8768EPWuAq4F+uMNtqEMAlx+sYcQ6N/DhWypIrRZaDyn
         rpFA==
X-Forwarded-Encrypted: i=1; AJvYcCUSWI0cHuFlbPx9oSa7QDYFqWEsgh5O3R6lz4p64f7xP9xV3q1v3i7Mx05SE7Ty/kaXNbe4LDelHS6+gc2x2inzIrelzNlbd4iLeAlX/Q7zK50ZUhenGi1j09Ks6ERnTh7gcnYs
X-Gm-Message-State: AOJu0YwokfII4dNc8E5v+tVYDqMtrNu0pJVUCvvWWeFhvun5nSaQw41T
	NKLVzln74xjE4UBkyicBQ6KjNiUUcfjZH5GMhzVCOmG60bGZeETN
X-Google-Smtp-Source: AGHT+IFcy2FAcdpg5IQZZRhIvXtOOrEb8mqFM0982fqdsBhgvBp9IDzYCcZcSgIiQe1AFrOHM/4uHQ==
X-Received: by 2002:a17:906:3db:b0:a44:3f8d:dcbc with SMTP id c27-20020a17090603db00b00a443f8ddcbcmr2162753eja.60.1709332705529;
        Fri, 01 Mar 2024 14:38:25 -0800 (PST)
Received: from ?IPV6:2a01:c22:77e1:5100:1895:caa1:5e59:18ee? (dynamic-2a01-0c22-77e1-5100-1895-caa1-5e59-18ee.c22.pool.telefonica.de. [2a01:c22:77e1:5100:1895:caa1:5e59:18ee])
        by smtp.googlemail.com with ESMTPSA id b16-20020a1709062b5000b00a44bc229148sm430812ejg.40.2024.03.01.14.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 14:38:25 -0800 (PST)
Message-ID: <99a4fbb3-0204-4a96-bc38-9a76817a326a@gmail.com>
Date: Fri, 1 Mar 2024 23:38:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 1/8] net: add helpers for EEE configuration
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
 Florian Fainelli <florian.fainelli@broadcom.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 NXP Linux Team <linux-imx@nxp.com>
References: <20240301100153.927743-1-o.rempel@pengutronix.de>
 <20240301100153.927743-2-o.rempel@pengutronix.de>
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
In-Reply-To: <20240301100153.927743-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01.03.2024 11:01, Oleksij Rempel wrote:
> From: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Add helpers that phylib and phylink can use to manage EEE configuration
> and determine whether the MAC should be permitted to use LPI based on
> that configuration.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  include/net/eee.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 include/net/eee.h
> 
> diff --git a/include/net/eee.h b/include/net/eee.h
> new file mode 100644
> index 0000000000000..1232658b32f40
> --- /dev/null
> +++ b/include/net/eee.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _EEE_H
> +#define _EEE_H
> +
> +#include <linux/types.h>
> +
> +struct eee_config {
> +	u32 tx_lpi_timer;
> +	bool tx_lpi_enabled;
> +	bool eee_enabled;
> +};
> +
> +static inline bool eeecfg_mac_can_tx_lpi(const struct eee_config *eeecfg)
> +{
> +	/* eee_enabled is the master on/off */
> +	if (!eeecfg->eee_enabled || !eeecfg->tx_lpi_enabled)
> +		return false;
> +
> +	return true;
> +}
> +
> +static inline void eeecfg_to_eee(const struct eee_config *eeecfg,
> +			  struct ethtool_keee *eee)
> +{
Typically the argument order is f(dst, src), like for string functions.
Any specific reason handle it differently here?

> +	eee->tx_lpi_timer = eeecfg->tx_lpi_timer;
> +	eee->tx_lpi_enabled = eeecfg->tx_lpi_enabled;
> +	eee->eee_enabled = eeecfg->eee_enabled;
> +}
> +
> +static inline void eee_to_eeecfg(const struct ethtool_keee *eee,
> +				 struct eee_config *eeecfg)
> +{
> +	eeecfg->tx_lpi_timer = eee->tx_lpi_timer;
> +	eeecfg->tx_lpi_enabled = eee->tx_lpi_enabled;
> +	eeecfg->eee_enabled = eee->eee_enabled;
> +}
> +
> +#endif


