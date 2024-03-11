Return-Path: <linux-kernel+bounces-99585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB77878A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F99281EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE07357307;
	Mon, 11 Mar 2024 21:59:13 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527F356B63;
	Mon, 11 Mar 2024 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194353; cv=none; b=g5z9FNj/QKdv6bqkZRoRT/LXXftLP5Er93FCd7vCVdu7Zcjsh61SHam8AEIb3U1SJFc5H/vsk4uf/tK3fqrg1vGWXkFMHvql3OsJ4KiteMt48L5Rr366kLbfgkdedkTwg+WzXlELOG60snTlgq5Rn8Dwfl5dfmtBipQtJpP2S4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194353; c=relaxed/simple;
	bh=sTG2XFQ2KYK7RVyLq4QyS0pByj6YUcGmkE+qM/HjAUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYsl5LdI5mmL797I2YBkyRwzvcxPhgf3cZyFm5kH8KYJFCCxWAXOmzmQCM/LoX5ahcss7zjhhATw2HzIerSp7GMkM3S+9T2T/VC6Tr26ssvIUUNcIecM3/plRReYSihcAy0Ghu6uEOtbzlgSWyyCm5ktp3gYh96VuILxmNaxOTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rjnfa-0001zA-0X;
	Mon, 11 Mar 2024 21:58:54 +0000
Date: Mon, 11 Mar 2024 21:58:50 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: patchwork-bot+netdevbpf@kernel.org,
	Justin Swartz <justin.swartz@risingedge.co.za>, dqfext@gmail.com,
	sean.wang@mediatek.com, andrew@lunn.ch, f.fainelli@gmail.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: dsa: mt7530: disable LEDs before reset
Message-ID: <Ze9-mp269h43WGD3@makrotopia.org>
References: <20240305043952.21590-1-justin.swartz@risingedge.co.za>
 <171019143163.14853.15330891015381229970.git-patchwork-notify@kernel.org>
 <2d206dbb-a27b-4139-a49e-331797d8ba34@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d206dbb-a27b-4139-a49e-331797d8ba34@arinc9.com>

On Tue, Mar 12, 2024 at 12:22:48AM +0300, Arınç ÜNAL wrote:
> Why was this applied? I already explained it did not achieve anything.

I agree that we were still debating about it, however, I do believe
Justin that he truely observed this problem and the fix seemed
appropriate to me.

I've explained this in my previous email which you did not notice
or at least haven't repied to:

https://patchwork.kernel.org/project/netdevbpf/patch/20240305043952.21590-1-justin.swartz@risingedge.co.za/#25753421

In the end it probably depends on the electric capacity of the circuit
connecting each LED, so it may not be reproducible on all boards and/or
under all circumstances (temperature, humindity, ...).

Disabling the LEDs and waiting for around 1mS before reset seems like
a sensible thing to do, and I'm glad Justin took care of it.


> 
> Arınç
> 
> On 12.03.2024 00:10, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> > 
> > This patch was applied to netdev/net-next.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> > 
> > On Tue,  5 Mar 2024 06:39:51 +0200 you wrote:
> > > Disable LEDs just before resetting the MT7530 to avoid
> > > situations where the ESW_P4_LED_0 and ESW_P3_LED_0 pin
> > > states may cause an unintended external crystal frequency
> > > to be selected.
> > > 
> > > The HT_XTAL_FSEL (External Crystal Frequency Selection)
> > > field of HWTRAP (the Hardware Trap register) stores a
> > > 2-bit value that represents the state of the ESW_P4_LED_0
> > > and ESW_P4_LED_0 pins (seemingly) sampled just after the
> > > MT7530 has been reset, as:
> > > 
> > > [...]
> > 
> > Here is the summary with links:
> >    - net: dsa: mt7530: disable LEDs before reset
> >      https://git.kernel.org/netdev/net-next/c/2920dd92b980
> > 
> > You are awesome, thank you!

