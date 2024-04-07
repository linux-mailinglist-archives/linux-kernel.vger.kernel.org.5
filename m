Return-Path: <linux-kernel+bounces-134637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D8889B3FA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3591A1C20C74
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD24436D;
	Sun,  7 Apr 2024 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="cAvcni4B"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ADC40840;
	Sun,  7 Apr 2024 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712521014; cv=none; b=Qofk3OG6UDz27yhi4+4nc5K6sfAy33T5SwTqrUzHXOgWENnbuKJGA9i9/T1xWnUoo2jfHDcTQLVOtDXeo1D6wYJth0kH/mDvgyOLCDrfsc0W3ePbCkz8pUd7I+UKRazofznXLMY1Zju7dFmEWFrRHoYcbBZXxN01p6RDBqopFoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712521014; c=relaxed/simple;
	bh=u6lvcNf8aLRzamE1e6To7/ZeIwnzKB5LaO3iyTsfXkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9Ks06dDGp9tkM/vPYNJPSCzToiI7WqZC9uTSEGypYUxZS2aMlKFTstW8VaGSRTTJ7fxJfSZBQ6nGzhiRnEx9m8+yWQwYps4fcXjZyMBvjNLHzA2hIze4zS/vjZE0O7nYLOFMPZtFJEukhJAAPCpBsyLkOxwlvboL//dZVowa8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=cAvcni4B; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5D18E240003;
	Sun,  7 Apr 2024 20:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1712521003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqPFMxPYby+J6LOpNiRlS3fZk7myPWtR33WdlGfj4Uk=;
	b=cAvcni4BP60iaVFboWrtOxvXFE9l8ZvLvSqszuZod4vOtTDQ+Py69N1RbOk84057wVe+6H
	bDWabimDbsWqoPILMaiu8UNZKP6vQJo/UTRsCj0nh5nJQ44CeH+2T6c2SLgGYlT8SKMbeW
	kuZioa0klbBnL1aElnHIrGB8suCni9h/BEozAnxz2u3hSgHYhoFm+bLxG3LNgYkVWjQHoz
	oTyZNruV8wtBGJgwv5ls3rsEydy0FV+xBg7Knew5NdLQLv74/f2YBaww5/pff3NVacHzk9
	/FoTP6RgQg2/M/y0MlgAbZEtk+rxEtc1v5HE8a29Vwz5vhQLiF403bavyUltRQ==
Message-ID: <9b604134-0787-40cc-a6e2-34efb757478a@arinc9.com>
Date: Sun, 7 Apr 2024 23:16:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: mt7530: trap link-local frames regardless
 of ST Port State
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240407-b4-for-net-mt7530-fix-link-local-when-stp-discarding-v1-1-b4b20ac93457@arinc9.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240407-b4-for-net-mt7530-fix-link-local-when-stp-discarding-v1-1-b4b20ac93457@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 7.04.2024 21:11, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> In Clause 5 of IEEE Std 802-2014, two sublayers of the data link layer
> (DLL) of the Open Systems Interconnection basic reference model (OSI/RM)
> are described; the medium access control (MAC) and logical link control
> (LLC) sublayers. The MAC sublayer is the one facing the physical layer.

I forgot to add a Fixes: tag. I'll send v2 in a few days.

Arınç

