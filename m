Return-Path: <linux-kernel+bounces-112012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2D0887428
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C35A1F23A01
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE9E7F7D4;
	Fri, 22 Mar 2024 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="NMA5VK3e";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="NMA5VK3e"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3401E56B78;
	Fri, 22 Mar 2024 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711139062; cv=none; b=Q61yQ0aJoTKb7MNc8+M0J3ReaP34+5Jj71LKgsbv+YEjAVWPAN7JByLqvd5Ld8iliEXJQLmW1rbMG9xBrp4j9EpogafpYRIUoRhPqBCpqeFk+7rLdtX68dRi+nuHLpmwrGH0FOwHZp1D0NI5++xwNGMlAIL4cNcT7ziYDZc6oIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711139062; c=relaxed/simple;
	bh=1rNmkICy0RsIlEZQj84nE8h6DjeWYi5zek97NTIVO44=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TrGkyWN6gDrRKeOd9kG//jDoNOml/pIxd/bIDCaNDUkGHbeD7Ex1i8n+YPuIccGBuIc6Y8l6WNJcPxHtaMymAtp5CXPuoyHNAj9U3ytvtbR3xUL2hEbr2Svymn4EBtoshDUVyL87rZcaE/+V+euiurYgvjxAse+1FDvwZBWEBgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=NMA5VK3e; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=NMA5VK3e; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1711139059;
	bh=1rNmkICy0RsIlEZQj84nE8h6DjeWYi5zek97NTIVO44=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=NMA5VK3eSL8t6oa4iSqjullmlTy6eCiZZiZjnAZU9DKx78Vf7pa/Rh2egG2Dvc6cG
	 Xbga+XglGVqf+CROA7+uO4tXNhvG96bXbr4PEDEmHW9mncW0V9bW7Z3ZLIb0ALGJ77
	 2+O6rwCb45+3VhhOWodRqGls3yaSbLN70tP4uL+0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6C3E71286D39;
	Fri, 22 Mar 2024 16:24:19 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Is9O2Zz0E7am; Fri, 22 Mar 2024 16:24:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1711139059;
	bh=1rNmkICy0RsIlEZQj84nE8h6DjeWYi5zek97NTIVO44=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=NMA5VK3eSL8t6oa4iSqjullmlTy6eCiZZiZjnAZU9DKx78Vf7pa/Rh2egG2Dvc6cG
	 Xbga+XglGVqf+CROA7+uO4tXNhvG96bXbr4PEDEmHW9mncW0V9bW7Z3ZLIb0ALGJ77
	 2+O6rwCb45+3VhhOWodRqGls3yaSbLN70tP4uL+0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C918A1286BAC;
	Fri, 22 Mar 2024 16:24:18 -0400 (EDT)
Message-ID: <3b5f3404bc63d59f4093e02c2cbb426a88d0bc70.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] SCSI postmerge updates for the 6.8+ merge window
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi
	 <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Date: Fri, 22 Mar 2024 16:24:17 -0400
In-Reply-To: <CAHk-=wg9pvT5YEo_kGo2QGjbC-eRaaQNOZuJYCsM1zaxj+rnug@mail.gmail.com>
References: 
	<3b789eacddd6265921be9da6e15257908f29b186.camel@HansenPartnership.com>
	 <CAHk-=wg9pvT5YEo_kGo2QGjbC-eRaaQNOZuJYCsM1zaxj+rnug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-03-22 at 12:55 -0700, Linus Torvalds wrote:
> On Fri, 22 Mar 2024 at 12:12, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > Eleven patches that are based on the rw_hint branch of the vfs tree
> > which contained the base block and fs changes needed to support
> > this. 8 patches are in the debug driver and 3 in the core.
> 
> Please people - the number of patches involved is entirely
> immaterial.
> 
> I want my merge messages to say what those patches *do*?
> 
> This whole "how many patches" thing is a disease. It's not even
> remotely interesting. I see the size of the patch in the diffstat,
> and that actually has some meaning in the sense of "how much does
> this pull actually change", whether it's in one patch or a hundred.
> 
> I have absolutely *zero* idea what the above pull request actually
> asks me to pull.
> 
> So I won't.

OK, try this (I've updated the scsi-misc tag with it as well)

The vfs has long had a write lifetime hint mechanism that gives the
expected longevity on storage of the data being written.  f2fs was the
original consumer of this and used the hint for flash data placement
(mostly to avoid write amplification by placing objects with similar
lifetimes in the same erase block).  More recently the SCSI based UFS
(Universal Flash Storage) drivers have wanted to take advantage of this
as well, for the same reasons as f2fs, necessitating plumbing the write
hints through the block layer and then adding it to the SCSI core.  The
vfs write_hints pull you've already taken plumbs this as far as block
and this pull request completes the SCSI core enabling based on a
recently agreed reuse of the old write command group number.  The
additions to the scsi_debug driver are for emulating this property so
we can run tests on it in the absence of an actual UFS device.

James


