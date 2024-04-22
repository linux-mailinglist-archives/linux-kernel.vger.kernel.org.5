Return-Path: <linux-kernel+bounces-154012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864EC8AD61A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E961C20B76
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036601BC53;
	Mon, 22 Apr 2024 20:50:06 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708FA1B964;
	Mon, 22 Apr 2024 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819005; cv=none; b=O3eYnWTCkh01Bk3p8wOhZxDYXwEgDZaPYRtC8EXRLyOl5oiWx9llEx4H49bpIdd7ZRjuEaOerEpFS3xAAM88eYMVbykUEy/VfCNoNKo8WT3O5bueGYIfsUuyHfTNKP5NR9Aq+Hz5EBBwH8W7/mx99AbwG3X5yaSbvCRDQ/hX0Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819005; c=relaxed/simple;
	bh=i6bdLCbDlUXhfBU62pSTidBdeKEWGuacTmR/v6dTwFc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZmCH117n61gqP4jVfTj6BEB5TUeDQfylE845nHhKfZd29sRgwo/XS9WsSpfoQOg05k4kIhT3uf1jIZAHrpcvKptqV4jINkZ9fUPw0GEuYLoqKMKXnFNvllodxbrZ1YInPLZ4gpTG8N4wCAojdxPffqu11UgZZuiOt/vZNfk4OGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 78689608F445;
	Mon, 22 Apr 2024 22:50:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id aLFQ3ulMU7v4; Mon, 22 Apr 2024 22:50:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id CDCF6609B3C4;
	Mon, 22 Apr 2024 22:50:00 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gIB3UWmMAyCg; Mon, 22 Apr 2024 22:50:00 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9E120608F445;
	Mon, 22 Apr 2024 22:50:00 +0200 (CEST)
Date: Mon, 22 Apr 2024 22:50:00 +0200 (CEST)
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
Message-ID: <714170984.15180.1713819000411.JavaMail.zimbra@nod.at>
In-Reply-To: <CAJuCfpFsrQxa2CX66xQtxp=Y-=R5_YkJMMX9VQ-g32rdCrukeg@mail.gmail.com>
References: <20240326073750.726636-1-surenb@google.com> <95819052.15033.1713816660761.JavaMail.zimbra@nod.at> <CAJuCfpHnM6L-7s8cd90XKiawhw9LZaRfMfeDm54OshLQdV5YmA@mail.gmail.com> <1375034928.15114.1713817899712.JavaMail.zimbra@nod.at> <CAJuCfpFsrQxa2CX66xQtxp=Y-=R5_YkJMMX9VQ-g32rdCrukeg@mail.gmail.com>
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
Thread-Index: UBGj77MW+AtEVaScQFoqg8K21PqsYg==

----- Urspr=C3=BCngliche Mail -----
> Von: "Suren Baghdasaryan" <surenb@google.com>
>> > It's in mm-unstable under dc26c7e79daf2fc11169b23c150862f0e878ee5a. I
>> > think it just didn't reach Linus' tree yet.
>>
>> Hmm, so we better postpone this path until said commit hits Linus tree,
>> or you carry it together with the commit in mm-unstable.
>=20
> Oh, sorry, I didn't realize you were talking about the `Fixes:
> 576477564ede` part... Yeah, unfortunately SHAs in mm-unstable are
> unstable, so the change being fixed is under
> edf0a25633bda1e5b7844478dd13b4326a3d5d09 now. I think Andrew placed
> this fix right after the change it fixes with intention to merge them
> together later on.

Ah, the patch itself goes via Andrew's tree, works for me!
Let me note this in the uml patchwork system.

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

