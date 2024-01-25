Return-Path: <linux-kernel+bounces-38327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDE783BDDB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA31A295B82
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C171B1CA8E;
	Thu, 25 Jan 2024 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Xv9q88tE"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0021CA81;
	Thu, 25 Jan 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176175; cv=none; b=bbcZ/0j7wIRUDOtF3xwuN4XvP2g9zQA6P4sz6Y9Bj7LXWbRkvfT2TQG7qZbS4DKKsfT/1ebkGMvP7KXuFL49iRbVk2YlGhDX7zoi/aXHwClCOSu/jcsLmLKutUzTijd+f28g3G/oYaKx8toNHfl80oVcNYc8GFXr9G/MDtc7dRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176175; c=relaxed/simple;
	bh=JodpOLAPwczmZ4a6VZMuVd4PZAjoFOUygw/5EqMMmN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0uEholvpEwy6atden4mMixSpSaINeiJiw4ke0dXpd9Rt/YwlRfO+7Qo6LOtapsurMow3ufJVXSqCT8VbsqMkxKnhjTkpWtOgUWUdyYqVYOPTmU0hwSCmMDxndn7yBpbQ0lJ86HpLTTSlHmTC2U29rgRHyczzkikrJFD5jfWVME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=Xv9q88tE; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B8F14000D;
	Thu, 25 Jan 2024 09:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1706176164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4spzynnZLzSXpZvD9M1NQEXqK2+5EzKlAxOSnoAYggE=;
	b=Xv9q88tEhpXwElHUBolfyOODB7HD7meHv1GR2s55oHM7A4OEjiWUqYzOFj8ciEdBzd44cO
	7DtlbABxYZ2vHFqx+n2QG0dgRKKIXy+iQ3u5T1hYXKi3aILRBwZEmjlN52xaLEikx9OOkS
	I2rRUS8pg6d7naLcCKGAVX8UVslHemONhgc8dqjmMqumdHGfhwQvyofeXBUOod+b54YSah
	bh7oM53p3eRvj8tG/acVjEZ2+A5lU3yYfebD8Kj2YnwUOPUyPjfYBq7vmhCh07/AnwYwtN
	ulNUGSGzpXLZXyALFeCVlleyTW5HYZdDQqImSNiGSJBP9NAkHB3jqZVwxsmcGA==
Message-ID: <accda24c-9f12-4cfe-b532-a9c60ec97fca@arinc9.com>
Date: Thu, 25 Jan 2024 12:49:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: mt7530: fix 10M/100M speed on MT7988 switch
Content-Language: en-GB
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: John Crispin <john@phrozen.org>
References: <a5b04dfa8256d8302f402545a51ac4c626fdba25.1706071272.git.daniel@makrotopia.org>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <a5b04dfa8256d8302f402545a51ac4c626fdba25.1706071272.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 24/01/2024 08:17, Daniel Golle wrote:
> Setup PMCR port register for actual speed and duplex on internally
> connected PHYs of the MT7988 built-in switch. This fixes links with
> speeds other than 1000M.
> 
> Fixes: ("110c18bfed414 net: dsa: mt7530: introduce driver for MT7988 built-in switch")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>

I'm wondering why we manually set speed and duplex for these interface
modes in the first place. I don't how it works for
PHY_INTERFACE_MODE_INTERNAL but, at least for PHY_INTERFACE_MODE_TRGMII and
802.3z interfaces, phylink should already supply proper speed and duplex.

Arınç

