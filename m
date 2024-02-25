Return-Path: <linux-kernel+bounces-80010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02EC862998
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 08:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAD5282292
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 07:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C805DDA8;
	Sun, 25 Feb 2024 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="Rfu2PQZ3";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="NunEaSdb"
Received: from mailrelay1-1.pub.mailoutpod3-cph3.one.com (mailrelay1-1.pub.mailoutpod3-cph3.one.com [46.30.211.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5F6D520
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708844995; cv=none; b=Toyym1S+p7+vYOooXYoUUnFxQ1TxrS0xqFbdhXYZ279846Szy9v4m7BJk127wsh0yX1i+FIjIo8imqY+gGl3P2Nl1Yj9GNRy/0jGMmtLtxsjFgkVHH9gQgFEfqw6qwJHuSu0tEmgd9gSoa4coanvy+I0RAHVlpRMTCUz8NKYrFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708844995; c=relaxed/simple;
	bh=0FUFsz4uDZAK1Sl12+biTMRPK7VhZ7JHdp3gkoGj7DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZETBcbMnOnZ8qO9gKvKwQpK6EZShGsgk2r/XolLCd6Vo9LsCi4pmGC6QEQ/noxAgc8MF1OK721U0VfRV/sWXT38BzPgh8JLyrM9hLaRH5wnVmjGCafIpkdcm/Tw8YLB95YNjy10ieiU8vm1MOOw446EpjHjrPB5bE7NEs80UpCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=Rfu2PQZ3; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=NunEaSdb; arc=none smtp.client-ip=46.30.211.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=Cin/Uf9ak7PCvyqTlXlZCVpDcwmQDiV7m8pTpIkBwqs=;
	b=Rfu2PQZ3AL9NJAJ9EhzNSO7Xpbk3RyB+i1ZJBnflhgNjZkwpYlWA9UzkTVPA+6HmPZepQgp9pI4D3
	 C658nJLv7LYCeajqJg+LfMSMpmDXwhBKRdo83wzjihaSx0/RGBYmXvddJE3+WySd8Odgnvh9UWEAi8
	 zL1/5N3UNJ6nmvCRP5iuU8C1MHT0q6p4eryB5ztKEcKiwsqiaaWeVmm+L+z4vT7Kf+56ADrPSjgKwL
	 9FkUNvp9IiMDUKUlsofaTb/MTTud026wLL9ysz+X7dLj3X/emg0sMTs5lkWJkS/xdivNBTZKM1Wwht
	 6AspWQ+ZylLqIPKeYRaF0OGXHJEHdcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=Cin/Uf9ak7PCvyqTlXlZCVpDcwmQDiV7m8pTpIkBwqs=;
	b=NunEaSdby6jDWWB8FMh4cOjuWmQn3EMG0buvjl9UhcLT+auOBzcLO9Xy9Tiq6v/VXGtlfqhX5sZ71
	 oevCq8QBg==
X-HalOne-ID: b2acc480-d3ac-11ee-934f-1ff1563c5748
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay1.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id b2acc480-d3ac-11ee-934f-1ff1563c5748;
	Sun, 25 Feb 2024 07:08:40 +0000 (UTC)
Date: Sun, 25 Feb 2024 08:08:39 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-parport@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] sparc32: Do not select ZONE_DMA
Message-ID: <20240225070839.GA3364529@ravnborg.org>
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
 <alpine.DEB.2.21.2402250054030.36563@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2402250054030.36563@angie.orcam.me.uk>

On Sun, Feb 25, 2024 at 12:57:42AM +0000, Maciej W. Rozycki wrote:
> On Sat, 24 Feb 2024, Sam Ravnborg via B4 Relay wrote:
> 
> > sparc32 has no limited DMA zone so there is no need to select ZONE_DMA.
> > 
> > Based on analysis from Marciej:
> 
>  Can you please use the correct spelling of my name in change descriptions 
> (and preferably everywhere)?  Thank you.

Sorry, will fix in v3.

	Sam

