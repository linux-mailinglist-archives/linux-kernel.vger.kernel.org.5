Return-Path: <linux-kernel+bounces-99182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D9878492
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0898B213D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A1847F7F;
	Mon, 11 Mar 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="TlqipGJ1"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393EA4597C;
	Mon, 11 Mar 2024 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173131; cv=none; b=JOtItSpdC0VHBh4DuWcK4iiYCGhjL4oHRli0rFg0vhkzrkICOodJIk+Oi6xRL4Zy6siXtdY0ALg02T6dXyRBCkphBWXTAZ60Bk6ITmsM4QsNfiJ3W1LITfdXWenzK4ANlK7wkvCxAdQB++f3DUAtT5WlM1ttFVlVLzPl52rjlO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173131; c=relaxed/simple;
	bh=P7nvosDKIXaYzFECdhZZyUrOF4mJgzGjiwhQVEGTMaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIjqTOOdz0zkW4C1WBYAcBgaQGg5HLaO0ubTnCZQIyT9Ud8bpWfiIrGepDu/sDlB9R/2sd1YzhY6myH458uxmJIU9TeHHj2Wt4y+j0Z4uRvm8GHp2pBYik+EvThUneIlr+tTxInbz1XqEnVh7rxw+De17TuBUr/Oe1RO0UFYVTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=TlqipGJ1; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 718E324000C;
	Mon, 11 Mar 2024 16:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710173121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7nvosDKIXaYzFECdhZZyUrOF4mJgzGjiwhQVEGTMaA=;
	b=TlqipGJ1rEEaJ3ox6Xp5LvcDJPWE1VQXzp+62p2VfdX53SAoRyfXXnb+2JDMIYSkEnVNhz
	zLN7IBvZlq7TFV8BRmuaJpHSFibS+2fZqWehPuyxOTSFFTiE5dZ2K8twesfTtAV4ESMUvL
	OAtmEezXDDRtyOWm5ep/s9+uTJHYz15cXP9rFRWJ5mSOm0VPLXGskMqlnLWikRmfZ+1gnG
	LHX/m2AbV7KO/WK7fMpDGGvy1AjIrEcs2KYAWPTxaroxAz6i49h1UvOe8TKnOATcf/GG0r
	zIrXoviPlgyVAqI4jwFgWDmjZmQ7Q4H6xQbJRwcukPt/Ny3igRyrgC0zoBmbng==
Message-ID: <d6dbc174-50bd-46dc-8da2-910d36782d60@arinc9.com>
Date: Mon, 11 Mar 2024 19:05:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: dsa: mt7530: fix link-local frames that
 ingress vlan filtering ports
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
 Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240311-b4-for-net-mt7530-fix-link-local-vlan-v1-0-d67e6cc31af2@arinc9.com>
 <20240311-b4-for-net-mt7530-fix-link-local-vlan-v1-1-d67e6cc31af2@arinc9.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240311-b4-for-net-mt7530-fix-link-local-vlan-v1-1-d67e6cc31af2@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

I'll add the "Fixes:" trailer after I receive reviews.

Arınç

