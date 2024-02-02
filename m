Return-Path: <linux-kernel+bounces-49538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F04846BA0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189DF1C22DAB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C8577650;
	Fri,  2 Feb 2024 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="TxRDHImx"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED661768E6;
	Fri,  2 Feb 2024 09:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865141; cv=none; b=NG49GrUUca0qrYEG9e00DsHuCIgmN9FJijnmUSEJNskw0tjnd+BiZ4zfWGrO3Oc5zfMKAmAboFxKpRYnx+0tC1Y8QXYClGh5Se1IC1PDQIzm99tuUgd4HOzLapHFDpWm6ZXoIZWOH8yOp9Qn79ZjkLYBdGkIrTovhc2zhM6SmVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865141; c=relaxed/simple;
	bh=mKbj4nrp4DysHu5ieaVdYJT9MXIIya9/e61lxx3xm20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3NqJO03e17sOCxNl8AIWGknb9Vq2gcH2HTjRsxQ2Bqib+BwRAOya03Fd4T2bw3L50YIU9I3GDcoCbT9rfRGGZjs8JZvHmxqW6j2wJ/z2FE4OIEaouBy5+Vtbmn0Tzd1w5vkIIhlxnI3n+Z9dA291rTQz0gQ/rw8FrmhsZsFa9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=TxRDHImx; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: from relay7-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::227])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 7CCF6C4EBC;
	Fri,  2 Feb 2024 09:11:47 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6671420011;
	Fri,  2 Feb 2024 09:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1706865105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1NoW9zhjmqcQuUi6KkawAZpHX7sdUmwFKBiyO/7PKA=;
	b=TxRDHImxBW1jNI5WVNtiHiElYu6N+plp8XivTZ6hMBaX315Na0NYYCaDzb66WoE7Cllpb4
	ru8QC2pbYn+6vFyUANVu4eby5xhX3DrlOAzs3PJQy66gwpVnCp8pqMtI5RCYO83Bl9CPHM
	7DlGNwhhEwwi5oBsuaGeqAtiAq0yPmOfeug6FBlujbTRFrzrs6j50z5TNOmVmdUH+BNATZ
	DR6FygpLkPFRWJGxxLg0sTl2eJ4zUBjADblDxwLXOT4FR6bv+eR6P5Xt/ouJbQ5RmbKoez
	/0K0bQ/uTyBgEZN/MO8qc4GnT6J+xg6AYPPOmr3HEMzU+rVvcSskEvG/+h/JXA==
Message-ID: <1f0e67ba-edd7-4998-bc20-1de86bd53a68@arinc9.com>
Date: Fri, 2 Feb 2024 12:11:37 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net RFC] net: dsa: mt7530: fix link-local frames that
 ingress vlan filtering ports
To: Vladimir Oltean <olteanv@gmail.com>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
 Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, tools@kernel.org
References: <65bbf40d.170a0220.a87f4.becdSMTPIN_ADDED_BROKEN@mx.google.com>
 <20240201225943.abphuuavp7bkbrt6@skbuf>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240201225943.abphuuavp7bkbrt6@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 2.02.2024 01:59, Vladimir Oltean wrote:
> On Thu, Feb 01, 2024 at 10:13:39PM +0300, Arınç ÜNAL via B4 Relay wrote:
>> base-commit: 4e192be1a225b7b1c4e315a44754312347628859
>> change-id: 20240201-b4-for-net-mt7530-fix-link-local-that-ingress-vlan-filtering-ports-6a2099e7ffb3
>>
>> Best regards,
>> -- 
>> Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> You sent this patch 3 times. What happened, b4 didn't work so well?

Odd, I've received only a single email of this patch.

Looking at lore.kernel.org, it looks like the b4 web endpoint properly
submitted the patch to the b4-sent mailing list but for some reason changed
the Message-Id before submitting it to the netdev mailing list.

This is the email with what the Message-Id should be, which only exists on
the b4-sent mailing list:

https://lore.kernel.org/all/20240201-b4-for-net-mt7530-fix-link-local-that-ingress-vlan-filtering-ports-v1-1-881c1c96b27f@arinc9.com/

This is the email with changed Message-Id that was submitted to the netdev
mailing list:

https://lore.kernel.org/all/=%3Futf-8%3Fq%3F=3C20240201-b4-for-net-mt7530-fix-link-local-that-ingr%3F=%20=%3Futf-8%3Fq%3Fess-vlan-filtering-ports-v1-1-881c1c96b27f=40arinc9=2Ecom=3E%3F=/

There're no brackets enclosing the Message-Id. That must be why Gmail
modified it with the SMTPIN_ADDED_BROKEN disclaimer added for you. I can't
come up with a theory as to why you've received it thrice though.

Konstantin, could you take a look at what happened here?

Arınç

