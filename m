Return-Path: <linux-kernel+bounces-112653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1D8887C96
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891B0B2107F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E584179AB;
	Sun, 24 Mar 2024 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="bpzbnkW+"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAEC7F9;
	Sun, 24 Mar 2024 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711280722; cv=none; b=nl/A3qi2Cn2r9aLUbzMy8xNMtbZhO6u3y4CwpaAm9+nvYHiq5gZ/uJfHo+/xxMBNvXHnvQdEAvVtCcyIe1Ms/du0kSeFu3au4GpRT4L/orbc+wzz56SCEYhv0so8T/61mGZKpQuCtZc7RRnL62KAew6nASfhvI0wbRN+X2DTbnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711280722; c=relaxed/simple;
	bh=jd+UbPt7tUCSxeIh9tTddpbwhPczChNxIGuCykK8/Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPI8rzMDi51gqNRo23iPq82d4ZTLKzf1LMpmKULI7ZjxNLio8C3/DWgemoEIrcAFnTKRZ74DkRRF89F68DUL0y/1Mpbo3LLL5dKetavao2TUkytSDgD13Uu9FZKkXYQWLyAe3PuninAwLThJQu4ItyrWHYAaWi9pNKv/QzvTtps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=bpzbnkW+; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F374F40005;
	Sun, 24 Mar 2024 11:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1711280717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHd06vSLOzCjmoLwufibD7173gHP8W2NTfMUYQWalTM=;
	b=bpzbnkW+EWJftWZQUvb7X+yE7kOgudmqCMAGz9gTfHD8MP9UhA3pt9hXoju4h7iZQU6n8N
	WuzWRoFQvg3dhQCl9IoZlpcsomANxCZyClQw9a4ty5iYVHJFcDk2dp6cz2KQSAVVtkWlaZ
	h1/cJ/dqh7RGlekrYdfRlnLnFx3AGQqD6+vEMOLdugXKLLmgjHqIfl1PF9UafOVlzd1JAn
	LZq6kL1/ry7H4AfLzpOfwuh1q8smC8NbaeUOzXo+6mlgiF/08sBUkA/nF3MmXntk5+5aM7
	vfYrY1+OOwbZ2kOO4ruLevXHWCPRJoqa53doSxGBFptLMhC+3sUq0qFbTiRMpg==
Message-ID: <6db6a339-e402-472f-b640-523ced553354@arinc9.com>
Date: Sun, 24 Mar 2024 14:45:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v>
 <ZfnYkuzuvwLepIfC@makrotopia.org>
 <00ec9779-19ce-4005-83f0-f4abf37350fc@arinc9.com>
 <6cb585f6-6da8-45a2-a28b-2fb556f95672@lunn.ch>
 <Zfn1DxkEa3u-f7l2@makrotopia.org>
 <38798882-c033-4949-9446-4c6f15c25ebe@gmail.com>
 <0fbe7ba2-6529-4118-b050-8ea76d28b712@arinc9.com>
 <11b2a4d1-66d8-4bcf-b1a8-20a635b99cc4@gmail.com>
 <5a4c0436-cd78-419f-af14-9c4e0c0435e3@arinc9.com>
 <ZgAQ4Ihsn6RCk7xx@shell.armlinux.org.uk>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZgAQ4Ihsn6RCk7xx@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 24.03.2024 14:39, Russell King (Oracle) wrote:
> On Sun, Mar 24, 2024 at 12:47:08PM +0300, Arınç ÜNAL wrote:
>> I've tested with switch ports interfaces' tx-timer from 0 to 40, same
>> tx-timer for both interfaces. Loss is still there.
> 
> EEE implementations tend to be a mess in the way drivers implement the
> API, so one can't at the moment rely on what ethtool says about the
> status. Sadly, this is what happens when driver authors are left to
> their own ends. :(
> 
>> I suppose the MT7531 switch PHYs need calibration for EEE that is currently
>> missing from the mediatek-ge driver.
> 
> EEE is quite simple from the software point of view. There is software
> negotiation of the modules that EEE supports, and then there is are
> one or more timers that affect the behaviour of EEE. The LPI timer is
> "how long the link needs to be idle for before _this_ end signals that
> it _can_ enter low power state". The link only enters low power state
> when *both* ends of the link signal that they can enter low power
> state.
> 
> What calibration would be necessary?

Check out mt798x_phy_eee() on drivers/net/phy/mediatek-ge-soc.c.

Arınç

