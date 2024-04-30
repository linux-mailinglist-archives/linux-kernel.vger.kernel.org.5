Return-Path: <linux-kernel+bounces-164767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A7F8B829B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E051C225E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DCE1BF6DE;
	Tue, 30 Apr 2024 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctJcNEnZ"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A741802D8;
	Tue, 30 Apr 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714514949; cv=none; b=TrmTne3xE73BDdyb28d0uofyCNRt4HSy44DJ/k27gT2Ua1pDvtcEdgYX98y3e+Za5b/vKt2u2NpRFbUkNX4PbDMT/hvY2NiMJPqC+F3GB9F8q5/lTDFfXPh2UFI/uOJQfAFR+6R5oEhfoK2eXe8vVfcBX5YM06r3Cg5l69PmYiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714514949; c=relaxed/simple;
	bh=PY7/U7D+zkIldkMZivC3RRKTl3KMSW9GXuCN+mx5/LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nXO80rX5wD6gCygbBsF5878HLDvF+YubcHny3/vYVLT5Q7NFwjWmHTm+SDqvRlBH0PkP96lsWC4dNQenZo5D6YzI6DdMoX8jDeV76U5iQ6TJlzK8BdCf2Jygv3zF//WNBZClromA9qO+UsCshOzhls/9MQu3F3RTfBO04eXHkdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctJcNEnZ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c8641b41e7so1615288b6e.3;
        Tue, 30 Apr 2024 15:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714514947; x=1715119747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D8EYHlaCPYFs75yPvIGT4CAnZPHT++WuY82kIU/tKN4=;
        b=ctJcNEnZruZKTDjaqPN12nqdaGEn2Ls5xjsu34BV3OIteyvV+6HAfysP2oOuEWgN/S
         WuAty8yrgLyeoJQ9xMDeokfh89RmMACRljYvBBYT7QM5IZJpRMsYwXHy31esDRZwuXzZ
         ysxqpv/hM8pgScHQXHlqG/FCu45YTV9KA2BJxJh2GAB4uTPlyHdapl0dSe0r81bP3Gp+
         eMTlUwKd/nll4u/g9q4lBScuTCAP83jU76fEAc+587Y5UBTz/iDd07HY4mewumT3QC8S
         BSBJNRkHHyUc+OVfyC7BGBczD8OLTlN86EIbcyV0NXMoyf+Vj1gfij68DYjKgy7Rm5ta
         PKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714514947; x=1715119747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8EYHlaCPYFs75yPvIGT4CAnZPHT++WuY82kIU/tKN4=;
        b=E8RwQ5uQS5v4Y0J4OIJSFa9fKPkMmoTU/Nkew+yrniHXl9rqCSoUJopJNy2REAzcLd
         eBF3BcRT/EQsokA0pue6ko18PnTCnKzwKHhJNIJejNvKu2LM7U/GALWSGqhdswymzzmm
         hip7NM6w7fkYxmU36JOXOlZD7rMnIAGbAm2JiA8fWouaGAmnLaaQZlqxz4FAhBn37zgy
         XnXTIQmWutu4WJexyKUpwDZ3iiOIM/xJ+10mVLjlaDl3Pzctyh1njfumBgFh5FCpAW9M
         k3r8ZDw5yk5GLSlqhwOXFZ1Z2VmTvKAiiJzRW6wKv6Pw3lVnu9WmMWHcwHNi/7j1B7sp
         un3w==
X-Forwarded-Encrypted: i=1; AJvYcCUfp6YVYbHhg6Df9KEu2YVn/qfCPNOZu15Bs92rv5isF0HEZzqoBIzWoFm44KK/zZaTeobIW1Umzb0U9+brTzMWR9PVIgixstdj0GPUoi02gEeOBIhAv2oSsHb3g3QFpldkzwgRMqnn9visI+8SjLdcpjz/bsnktwl+pE1D0u9vwQ==
X-Gm-Message-State: AOJu0Ywz2fVcAEQ6BnS3aCMNAReZzTvYFYkVnriVYpTkewZw/+336+qa
	J9LE00fRSVCav4N2MyJ81RgDzbLmtrJPRzedjOxaCtF8H1IchTLz
X-Google-Smtp-Source: AGHT+IETt7byCjYF1N0xP05blWct8RPmwdPPW9i2/XgFWBAcrVKgQp4kr0uqKdBa1O0p2bnnZSWcaw==
X-Received: by 2002:a54:4e8d:0:b0:3c8:4970:70a7 with SMTP id c13-20020a544e8d000000b003c8497070a7mr919659oiy.0.1714514946863;
        Tue, 30 Apr 2024 15:09:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w15-20020a0ce10f000000b0069b6e19090csm11790925qvk.10.2024.04.30.15.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 15:09:06 -0700 (PDT)
Message-ID: <ba140a7b-0627-4d73-8267-8721f6ce1c63@gmail.com>
Date: Tue, 30 Apr 2024 15:08:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dsa: mt7530: fix impossible MDIO address and
 issue warning
To: Daniel Golle <daniel@makrotopia.org>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>, Felix Fietkau <nbd@nbd.name>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Landen Chao <Landen.Chao@mediatek.com>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <11f5f127d0350e72569c36f9060b6e642dfaddbb.1714514208.git.daniel@makrotopia.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <11f5f127d0350e72569c36f9060b6e642dfaddbb.1714514208.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 15:01, Daniel Golle wrote:
> The MDIO address of the MT7530 and MT7531 switch ICs can be configured
> using bootstrap pins. However, there are only 4 possible options for the
> switch itself: 7, 15, 23 and 31. As in MediaTek's SDK the address of the
> switch is wrongly stated in the device tree as 0 (while in reality it is
> 31), warn the user about such broken device tree and make a good guess
> what was actually intended.
> 
> This is imporant also to not break compatibility with older device trees
> as with commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of
> switch from device tree") the address in device tree will be taken into
> account.
> 
> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> Changes since v1:
>   - use FW_WARN as suggested.
>   - fix build on net tree which doesn't have 'mdiodev' as member of the
>     priv struct. Imho including this patch as fix makes sense to warn
>     users about broken firmware, even if the change introducing the
>     actual breakage is only present in net-next for now.
> 
>   drivers/net/dsa/mt7530-mdio.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
> index fa3ee85a99c1..3c21c8d074c7 100644
> --- a/drivers/net/dsa/mt7530-mdio.c
> +++ b/drivers/net/dsa/mt7530-mdio.c
> @@ -193,6 +193,19 @@ mt7530_probe(struct mdio_device *mdiodev)
>   			return PTR_ERR(priv->io_pwr);
>   	}
>   
> +	/* Only MDIO bus address 7, 15, 23 and 31 are valid options */
> +	if (~(mdiodev->addr & 0x7) & 0x7) {
> +		/* If the address in DT must be wrong, make a good guess about
> +		 * the most likely intention, and issue a warning.
> +		 */
> +		int correct_addr = ((((mdiodev->addr - 7) & ~0x7) % 0x20) + 7) & 0x1f;

0x20 -> PHY_MAX_ADDR
0x1F -> PHY_MAX_ADDR - 1

> +
> +		dev_warn(&mdiodev->dev, FW_WARN
> +			 "impossible switch MDIO address in device tree: %d, assuming %d\n",
> +			 mdiodev->addr, correct_addr);
> +		mdiodev->addr = correct_addr;

Sorry for not jumping on this earlier on, there is a mixture of 
hexadecimal and decimal numbers being used which IMHO just makes this 
more difficult to read than needed. It seems like the requirement is for 
the switch's MDIO device address to have the lower 3 bits set, so can we 
give it a name like MT7530_MDIO_ADDR_VALID_MASK?	
-- 
Florian


