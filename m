Return-Path: <linux-kernel+bounces-117946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B03888B1A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA656320141
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D695339E;
	Mon, 25 Mar 2024 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eeG3wfkz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993251BF31;
	Mon, 25 Mar 2024 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399053; cv=none; b=HzNiHIq7/1kV3E1aG+j4pC0wtDQgUWAOJtb7ZGkjemSSreKlp69l865+MdH0tseFmoud4KVxp5zx3xqQFXE+cD2ap3yRpIqmtwpHeo6yepZlJJWhpu29OI6w3yBUmJ4C5ivrx02zYXf01iuavr09Qmq4IjvTx77dbySIWK3+Rto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399053; c=relaxed/simple;
	bh=VVdQBIh0vlq9StzgBVjD7qCHwBE7R/5l6ZifiUQINeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g54eeuU8yIVryZqV8J/akWGW2Vt+YYjpIZwKjN0B0XmdTDmAD44z5CqOTW7wWb3tKQ+mp2XqDadRmOwwE6hR5fTdbnOI2V5qMN36LqQDjyZz6Qle+H1m3CmpQwGf4ujTpZfQZ8acgusJIqXUnTGDtQEB3BeuQeYn7sJJ6TQQjnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eeG3wfkz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6BC2140E024C;
	Mon, 25 Mar 2024 20:37:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Vo3ELXsGEisO; Mon, 25 Mar 2024 20:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711399045; bh=U0G1eMa6Cvy7/sunjtYCvGXSPvh8B0E6dDV8JnTaH1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eeG3wfkzBYG+9uJzmka8Da6RCICi5rC529Bbuh1aqh0NOV11kJAVJdjpif4LY0c3m
	 QsI9wVDEwA+c4BZ8Hvgnaplrsn0x7/lj+rXS9KSm8Wlj7uFtcY8ZL4qQNXMfkjcNDh
	 Kxcxbo9UlIsTJ3fW2SCSg1bvqTVxzJy1y2omch5rc9BbpaAGZJQLlPw8Z+BqvncbE0
	 XFL+RiX4/h9nzbfEFBiQn2hKdzkHKGioEXqIstzhbAN1frJDFX+taBaiEW4rMFgjMF
	 Guh3Hfo43JA6JiLrGyiiQBDXcTbkiduG+55XX0WJGzXtO/hlYOiT0MBOtJK1hKe7a4
	 QgdUJ56Cg/2NGZciGAte1v4dyQbjdMzBA6gKgNQZN61mAJbznaq7gu2zoo3NMXx3af
	 9kEASC/DLRx/WIT5z5bEydvTlExyxWZjC0VjQimdWRtG4JLgqUauFMxMfPdTCaMPbm
	 RRJOG+5F6nDDFRDYSD3TtqCYRDZ1G5oUp1aES3jchJdJSIwSUNqGgq436pc8UGtXEs
	 xozEr20AqlbwUuYAuwomA4Z8UdGV6TeYVvhUxO8O8fUE7kmTq300UmHAa49OkLXOEX
	 QInykCpxtvs2FS8xU7cX+pf02Mfxk7Zq6S/qVEiq0h3mgr8Rl7S68CMlsqG4wnVVva
	 2sVlSioM75+0pPJe3x2tcqWQ=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3771840E016C;
	Mon, 25 Mar 2024 20:37:15 +0000 (UTC)
Date: Mon, 25 Mar 2024 21:37:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "V, Narasimhan" <Narasimhan.V@amd.com>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"Aithal, Srikanth" <Srikanth.Aithal@amd.com>,
	Dawei Li <dawei.li@shingroup.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yury Norov <yury.norov@gmail.com>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: Boot failure with kernel BUG at mm/usercopy.c on next-20240325
Message-ID: <20240325203714.GJZgHgem2TR1aVAVlU@fat_crate.local>
References: <DM4PR12MB5086E76CF24A39017DA8567189362@DM4PR12MB5086.namprd12.prod.outlook.com>
 <20240325125017.GBZgFzCXVxeF50uGVE@fat_crate.local>
 <20240325113433.e04c2b508ac325630cd113c8@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240325113433.e04c2b508ac325630cd113c8@linux-foundation.org>

On Mon, Mar 25, 2024 at 11:34:33AM -0700, Andrew Morton wrote:
> Thanks, I'll just drop the patch.  It didn't receive a very favorable
> review reception anyway.

See here:

https://lore.kernel.org/all/DM4PR12MB5086B9BDBF32D53DF226CBF489362@DM4PR12MB5086.namprd12.prod.outlook.com/

folks still need to learn email. :-)

Anyway, apparently there's some fix there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

