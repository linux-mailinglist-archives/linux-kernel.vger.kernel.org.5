Return-Path: <linux-kernel+bounces-153996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CCE8AD5D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1E41F2170A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552A118C38;
	Mon, 22 Apr 2024 20:31:44 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61021EAF1;
	Mon, 22 Apr 2024 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713817903; cv=none; b=hmR7uHxGtNEon0ojt9+Pj/DMzDvSRDjOYQrminkxGqtfXYzWyMF34dPd8+h2/eWFcFmkc0ZEpldMtkhS1CfdwLhFAzz2jE+fZkAcwOqV8SCuspKVmegQjtsOQZclakvuNz4n8FmPNu2ZjhlAmdX6zDxgfH2hqOz9fWRLvO+d+l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713817903; c=relaxed/simple;
	bh=DY4ANjXW+IeF+DYmL4TMInJWjnTHMwJVJqNPVqlFGDQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=cBERoORWzRpDd5Y/jBW+nNnhKgVS1ftQpPXcuwtXqouSQ2eHDFuHWQQ4j2wwFiBL99qwV/h332Y/l3Tib3RftFdkA8Yc3KwAVUFRxa9t9ikl+bWcO6LAJHXfXVmUOVQ/cPVNZwlCK7rmKvsEUC/uHdC8p5F5RYuMkm6FNIQQq7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 61C54608F445;
	Mon, 22 Apr 2024 22:31:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id lISoQ8qWT-Eb; Mon, 22 Apr 2024 22:31:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 097CA609B3C4;
	Mon, 22 Apr 2024 22:31:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YFngM_8nOgmK; Mon, 22 Apr 2024 22:31:39 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id D0AFF608F445;
	Mon, 22 Apr 2024 22:31:39 +0200 (CEST)
Date: Mon, 22 Apr 2024 22:31:39 +0200 (CEST)
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
Message-ID: <1375034928.15114.1713817899712.JavaMail.zimbra@nod.at>
In-Reply-To: <CAJuCfpHnM6L-7s8cd90XKiawhw9LZaRfMfeDm54OshLQdV5YmA@mail.gmail.com>
References: <20240326073750.726636-1-surenb@google.com> <95819052.15033.1713816660761.JavaMail.zimbra@nod.at> <CAJuCfpHnM6L-7s8cd90XKiawhw9LZaRfMfeDm54OshLQdV5YmA@mail.gmail.com>
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
Thread-Index: n1ihtpuFBj2UP0//vEBjnw1r03B3Wg==

----- Urspr=C3=BCngliche Mail -----
> Von: "Suren Baghdasaryan" <surenb@google.com>
>> > Fixes: 576477564ede ("mm: vmalloc: enable memory allocation profiling"=
)
>>
>> This commit id is not in Linus tree.
>> Do I miss something?
>=20
> It's in mm-unstable under dc26c7e79daf2fc11169b23c150862f0e878ee5a. I
> think it just didn't reach Linus' tree yet.

Hmm, so we better postpone this path until said commit hits Linus tree,
or you carry it together with the commit in mm-unstable.

Thanks,
//richard

