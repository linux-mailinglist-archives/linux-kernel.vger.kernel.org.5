Return-Path: <linux-kernel+bounces-111726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7848887009
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7601F214EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6D55917D;
	Fri, 22 Mar 2024 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bkVeCRkP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6425059163;
	Fri, 22 Mar 2024 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122558; cv=none; b=r8wCUjkcofAmtv7tiB312z3KVbXLT+SfIYadY7Auz2HWkzYFTwchzuSxRaKNpwh2SAr5hVJdJUyUIgoLDn6U2ivEMsNc+KfL8j+cfwOGczDwtH5nl+K1hJlJA/RhfsYY+ogaGIcsh+TvTnEmfDOQPNDJeoXGk15o+hy1h/XL+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122558; c=relaxed/simple;
	bh=SH0nqNuxhZgHCsVr9BNRBW8W8DQKuuRqCpmLlgkB5Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjPeN9YPiTHOip3QuRCb2HPNzHXRurYnKaa/offmmmNKx/XexUGv+tEDpAfjeXAhILPVCy+Z0rT+R0/HfMRohRyCCPbiXpN0GzWwF0nPnPIByTwzElZcvJUfgnOYFFCh1MQXtQlc8j0fEPyDX44I+iz+C5WRtnaLlL/pf31BwIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bkVeCRkP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jgLIHqFNuXkHH5HYUZp2KdJbY2+i8m+EoWOC10J0nag=; b=bkVeCRkPeYKdrjZ5+hPC7Nr9sL
	IfWGLwhWrYUKy+NEb/c6mBu52TNd5wQyVd9q3dVq3okHbLg90PDZriwdohrJUJC8yJAe2DsMZsqAL
	St+0Cj3f2QU5LvRKgSjAmGAZ8Z/pvyF0g0PGEvmLEStsbrQ0M3qPuEgjFbaMrkpOeuzA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnh8n-00AyBo-5d; Fri, 22 Mar 2024 16:49:09 +0100
Date: Fri, 22 Mar 2024 16:49:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Message-ID: <a22e7861-c140-4f34-97be-a1f4e435b44b@lunn.ch>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-2-711127a409ae@solid-run.com>
 <e24e78a6-852c-4458-987c-3601908a71f0@lunn.ch>
 <0d1afbcc-948e-4aff-8296-42f7166d318d@solid-run.com>
 <4fff2165-c3cc-41d8-b541-6e69ce4d98ac@lunn.ch>
 <748753a6-9fde-4d4f-8fee-5b93dbb532f0@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <748753a6-9fde-4d4f-8fee-5b93dbb532f0@solid-run.com>

> I (currently) can't put in the led node e.g.
> linux,default-trigger = "link100|link1000|tx|rx";
> Right?

No. The trigger will be 'netdev'. Or 'heartbeat', or
'kbd-numlock'. They are just LEDs, they can be used for
anything. While testing some of this code i had the keyboard numlock
indicating network packets, since it easier to see than the RJ45
socket... The same applies the other way. The RJ45 LEDs are just Linux
LEDs, they can be used for anything...

I do have some code adding additional properties for the blink
reason. However, it is very debatable if it belongs in DT. DT
describes hardware, not configuration of hardware.

Do you actually have labels on the case indicating what the LEDs mean?
It could be we describe the label, which is hardware, not the
configuration of the LED, which is policy from user space.

   Andrew

