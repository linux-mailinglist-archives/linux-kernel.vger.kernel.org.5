Return-Path: <linux-kernel+bounces-153986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD6E8AD5B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4321C20D29
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94229155A50;
	Mon, 22 Apr 2024 20:11:07 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA51553A3;
	Mon, 22 Apr 2024 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816667; cv=none; b=VubCmGMOHrVDdjLOR4vpFRap5QrPO2TrA5RZVJCEnoUH7RZd7kphb8Dz7BfhGrvDHcD4by5Chuw4eKsw3gQ31Al+obuc/aNrcr+DHcCVoRnTlZ2eMAkYSA54kOFoBbQG79O2In4b2qtybnMp3APC/xPI0+8pdi8//gRo8WwU9nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816667; c=relaxed/simple;
	bh=4JpIgXCB9jUQPkFUGAI31NP5EjtRLupEYrFT1gtqbDU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZsyV8WlcNro1ATU34Dqs/Yc0fBcib2u+tLiF6wbEvJ22pwhSZ15x5IN+7QRZzVumNysYWnRkFIwCRQNKptc2kJasm+UmhXdXCyaRcJErMHtLQ5rH0YQ8IjtIarNtPWXMIAmXJi35nOaTVZTGzVLT8W/kaq+OkpDA+BwI3frb3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8788D647A82A;
	Mon, 22 Apr 2024 22:11:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fvDzHBxSevvb; Mon, 22 Apr 2024 22:11:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 10A4F647A80D;
	Mon, 22 Apr 2024 22:11:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rBhDvx3ZBnCr; Mon, 22 Apr 2024 22:11:00 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id CEF3A609B3C4;
	Mon, 22 Apr 2024 22:11:00 +0200 (CEST)
Date: Mon, 22 Apr 2024 22:11:00 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, 
	kent overstreet <kent.overstreet@linux.dev>, 
	SeongJae Park <sj@kernel.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-mm <linux-mm@kvack.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <95819052.15033.1713816660761.JavaMail.zimbra@nod.at>
In-Reply-To: <20240326073750.726636-1-surenb@google.com>
References: <20240326073750.726636-1-surenb@google.com>
Subject: Re: [PATCH 1/1] arch/um: fix forward declaration for vmalloc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: arch/um: fix forward declaration for vmalloc
Thread-Index: VhMS7jUdUYDlNrao2e2bRQ6VhbmZJA==

----- Urspr=C3=BCngliche Mail -----
> Von: "Suren Baghdasaryan" <surenb@google.com>
> Betreff: [PATCH 1/1] arch/um: fix forward declaration for vmalloc

> Patch [1] replaced vmalloc() function with a new definition but it did
> not adjust the forward declaration used in UML architecture. Change it
> to act as before.
> Note that this prevents the vmalloc() allocations in __wrap_malloc()
> from being accounted. If accounting here is critical, we will have
> to remove this forward declaration and include vmalloc.h, however
> that would pull in more dependencies and would require introducing more
> architecture-specific headers, like asm/bug.h, asm/rwonce.h, etc.
> This is likely the reason why this forward declaration was introduced
> in the first place.
>=20
> [1] https://lore.kernel.org/all/20240321163705.3067592-31-surenb@google.c=
om/
>=20
> Fixes: 576477564ede ("mm: vmalloc: enable memory allocation profiling")

This commit id is not in Linus tree.
Do I miss something?

Thanks,
//richard

