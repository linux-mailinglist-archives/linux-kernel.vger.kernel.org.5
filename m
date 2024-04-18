Return-Path: <linux-kernel+bounces-150133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C958A9ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748B32843EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5884384D02;
	Thu, 18 Apr 2024 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c2SdpSPf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="43Uwr8Sp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8627D3F4;
	Thu, 18 Apr 2024 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445645; cv=none; b=f8zyn86hkTPL8MJVFi5/evi52xgShcZLyz1FmsTpys6viWbc3x8f0vtstUmZ+kgnWUn3tXDVOEQge9teK2Ik0fAqYmcHLswIpZ1nWXGf0tNfnJvb+GFlWInvFIWJTMYVpI6b9/mbKLvNdmQUjgumHDuOWFwhxtr4xyh1BgRV7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445645; c=relaxed/simple;
	bh=1v4N5EsQsjae7OpqL2Q9UvstpG6p/njXQau7/gZ2zuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTExTHl+18RSnbcyZGWqPaVbzqkcktKByPYohiaRpy3Ma2jl6kH9MpyxQC5+M4ucNAwh8NjtIc8iRk5NEDjkKcIBlkKXf/qdKSRBxeauAVQIcBi3LIXu/VDi5qExI0pyi0OG+h7Y6UNIp6/73NogJ77QrydjR2Xysm/3NPPgE0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c2SdpSPf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=43Uwr8Sp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Apr 2024 15:07:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713445642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jvo4IB9EX2vgtvJVoBdjCViGeeUjaKsOvZ3vCy38w78=;
	b=c2SdpSPfmg8garIOwBGnXvJv+xZ574a6J0d+i6DmmczkYNsWCT1YJnHLNMguhg/C2xkOXx
	cCdeYwnJmftxBmq8OOHCS1zzpnMSxVrb/84exI26N/KDpVKbTVRvBAi6Dnty/SzPQFkZxh
	Aj63zVR9bT2z8Wo+8PiOBaDZQ6XU82YW6AbudIXj4FNLOXwH8bhvwSBmv6zeDMAOUli0KN
	NzlpiBoi7ShRCggyBm2Vp+wrXAL7QFHbGNa79vLUwtTvaVvXtbKYASJCMeIrb+DjyKj3hU
	b5UpUIYtpPLOjMIeAvlaVGH8G65L+TKxTROEHUR3i8gcPZ2bCtB6MlXc8UEvfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713445642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jvo4IB9EX2vgtvJVoBdjCViGeeUjaKsOvZ3vCy38w78=;
	b=43Uwr8Spr789PRY19/kpBrkAVJmwqG6R+wfHSCcTUl4PAEWCZfc2pvl7hw6yFtOqkJyayk
	MQvkZ6u8hA2H+IDQ==
From: Nam Cao <namcao@linutronix.de>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Andreas Dilger <adilger@dilger.ca>,
 linux-riscv@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, "ndesaulniers @ google . com"
 <ndesaulniers@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Ingo
 Molnar <mingo@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Tejun Heo <tj@kernel.org>, Krister Johansen <kjlx@templeofstupid.com>,
 Changbin Du <changbin.du@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Geert
 Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] init: fix allocated page overlapping with PTR_ERR
Message-ID: <20240418150721.25d0e82b@namcao>
In-Reply-To: <20240418150148.6a0b4664@namcao>
References: <20240418102943.180510-1-namcao@linutronix.de>
	<20240418131238.636bee2c@namcao>
	<87edb2sv0d.fsf@all.your.base.are.belong.to.us>
	<20240418150148.6a0b4664@namcao>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-04-18 Nam Cao wrote:
> > Mike hints that's *not* the case
> > (https://lore.kernel.org/linux-riscv/ZiAkRMUfiPDUGPdL@kernel.org/).
> > memblock_reserve() should disallow allocation as well, no?
> 
> He said it can't be removed if we set max_low_pfn instead of using
> memblock_reserve()
> 
> If max_low_pfn() is used, then it can be removed:
     ^ I mean memblock_reserve()

> https://lore.kernel.org/linux-riscv/Zh6n-nvnQbL-0xss@kernel.org
> 
> Best regards,
> Nam
> 


