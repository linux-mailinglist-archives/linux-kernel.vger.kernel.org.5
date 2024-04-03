Return-Path: <linux-kernel+bounces-130349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DA189770A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E611F2AD69
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC7E16D320;
	Wed,  3 Apr 2024 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KXqNSoa9"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB89F16D305
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164802; cv=none; b=nONVla2+78LPDg8S+ekwL75M3jgg1N4COVO7XxkkrdYbpJnskavCHMTQG0KaZ1Ja40BYWKZsCeJATOMj2XKZQbwlIvRqC+h9q0qAFM7jC4q0MGxGs4FP/G6dZaMHV7qV5Eb145MCui4JnwCXO4wMKsuMxJ5Wwoi9QA1fyn/+fjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164802; c=relaxed/simple;
	bh=QtPevCIjXX7QFZ7K/qtZMwdmegWLWhnyNKJMKwQ2Ygs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZ/7VRclOHmu1CCHLUP1WRehd59kYHgsQ/idFR6BkOm2T8jFbKy9uaBkUzrCSDTfVhJCz7kmUdGuHsANqBYen8vbG14MjPsLmc/swaNGmdB/3r+M191x7iouW7pnFCW1YGThu9G8dvlRuGgleX5JaywZeuBrv7ELRF7w8fOJUls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KXqNSoa9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 70B5C40E0192;
	Wed,  3 Apr 2024 17:19:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CiA-8tlRc43u; Wed,  3 Apr 2024 17:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712164793; bh=L9P14lLCj/u1byUIgCVreo3oA9YudOj2hiQ5myfUpjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KXqNSoa9dKJtj7zYDfUL3TVDefqBbSNUq9G3PRC7meXfg5MM5LaR/JMBG4W4jY6Y7
	 E5QiGbggMafPWfFDFK9wpZUyXnvouNx89aemcHH0zojC2Dm/dCVIbkFgTHvlb53tF+
	 KDdOdyZx4cBRt/2pjionvKgNRQZ2Uv7fo+SaiNHFlwzeR/l2XASFbBhYbYxGxQ30kr
	 TYVvy6oOIX5+V1PzsFr9qls0m8P2djUCiGDyLfPw4ngj5ko2ExJkcornRpWlPOHr00
	 ActQFmexmM9iJB7KkAgdHPSRiKvjhxByEK8+edY1P3ydMQJpE5wF/zTuecjL/249yu
	 b9++1Y3xCobxQ+hR/9PxUihTS6jl2NrPB3NrrnXRo4RPrw1IcvuY1cRwYkIMnvEuFD
	 RWxqNJJUeery/TTYdDgQNR1iOG96Te7iDSMD5uEkbM4lVVsPDpL/b6aASfcRXBC4be
	 +pqVze2g5QytDsCGug9dVYg1UdGcbswHLEwSQbIgZQVpC+86p2UrA1iz4JQrFiTVTs
	 5H6qvhomt0OEbenBkhmG2mzb6ZQueKqrF3OATRwc2/LA8a1siEzu8/n517GaYihM/z
	 QkeTgwi/PVJF8hmPGokz9jPGtSg9xp12rz8YKiDARvQPSjH3cvstoV6d1QdQz4FBfI
	 dsErIwdq62kR0JCWBWmhllpw=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1002740E00F4;
	Wed,  3 Apr 2024 17:19:47 +0000 (UTC)
Date: Wed, 3 Apr 2024 19:19:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/retpoline: Fix a missing return thunk warning (was:
 Re: [linus:master] [x86/bugs] 4535e1a417:
 WARNING:at_arch/x86/kernel/alternative.c:#apply_returns)
Message-ID: <20240403171941.GIZg2PrcsShYQS4eDn@fat_crate.local>
References: <202404020901.da75a60f-oliver.sang@intel.com>
 <20240403122350.GEZg1KVvsyc-Z3bwro@fat_crate.local>
 <CAHk-=wj+Q_LXV0Y5+kBvv-5sTxT3Y7E=8wJ2sX4vzWksd3LWzA@mail.gmail.com>
 <20240403170534.GHZg2MXmwFRv-x8usY@fat_crate.local>
 <CAHk-=wjernNvgonRC-W=_OF116facZf--vaYZ+QUnOkXm99M9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjernNvgonRC-W=_OF116facZf--vaYZ+QUnOkXm99M9Q@mail.gmail.com>

On Wed, Apr 03, 2024 at 10:13:14AM -0700, Linus Torvalds wrote:
> On Wed, 3 Apr 2024 at 10:05, Borislav Petkov <bp@alien8.de> wrote:
> >
> > Can you pls replace it with the below one?
> 
> Ok, done.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

