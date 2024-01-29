Return-Path: <linux-kernel+bounces-43400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2898B84135F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70AD288637
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E446F080;
	Mon, 29 Jan 2024 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="UJeR+Nt0"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADACA657A8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556386; cv=none; b=gz8q6rc4p+RWMGlxYg+RzzHw/r47FtQnWArYIos7R+VhKPHpn69I6h4EjL4xH06wA7ofB1gPMUi0TRB94OFjkI62OJ9jQ0v16Rt7P20GAgKGlPBiq9iZma+9VGkPZO7f0yV+FTIEBcxBaD4n89DF5zUgXzkdAoLm/SwKL5s/Gbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556386; c=relaxed/simple;
	bh=eRPRewGUYrmJB7VHNVS88AqNYzIaeHgFC2AnrKWWbtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGG6tgTVqPIgmwskbbJuduoKTtjwvZf27ETcVdyNXRbbCWFdP8x8W2rNAxb2EKNvHRCdRS3KtmwbqsZp7juTR6Fdfwug40gvLLoPzdV/dTf3k5gnhk8VkekoPmO4mjGmOPI8xPKrsiwMhHgHvVxoTb1eiEpR+Bl1joNY7CEZNGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=UJeR+Nt0; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 26A9619A629;
	Mon, 29 Jan 2024 20:26:21 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1706556381; bh=eRPRewGUYrmJB7VHNVS88AqNYzIaeHgFC2AnrKWWbtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UJeR+Nt0DKoETJWrxdRAiyM+J2e/o9p+yX33ckYyEr8foaq6h/iqk49xDD5wY1o73
	 TOoE9f9UM4Eb6Fai5OB2pvYXq1CXCyQ+uWMgncQjJuogOkW8kor58smy3fc9nw9WfG
	 9XajgC+9R1MweY7RZjUvPxXTktk0GtGgBEulK+G00D1GVr0c4mry4oj3r5dWIPyL2f
	 6XiK30IvAedqtMWiP5JE6EruLql3lv+MslXQlz3HCmB0WY9XNhHYc3uBOQs948QDEp
	 HS7lbubyUCoi0H9zn1wHXDHA8A2mFoWrkGtZhJOOflBSqhk40TciR5sZlujSklBC8Z
	 eIqL0S7QG/FhA==
Date: Mon, 29 Jan 2024 20:26:19 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Dexuan Cui
 <decui@microsoft.com>
Subject: Re: [PATCH 0/2] Fix double allocation in swiotlb_alloc()
Message-ID: <20240129202619.69178dea@meshulam.tesarici.cz>
In-Reply-To: <20240129184255.GA12631@willie-the-truck>
References: <20240126151956.10014-1-will@kernel.org>
	<20240126172059.48ad7b9f@meshulam.tesarici.cz>
	<20240129184255.GA12631@willie-the-truck>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jan 2024 18:42:55 +0000
Will Deacon <will@kernel.org> wrote:

> On Fri, Jan 26, 2024 at 05:20:59PM +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > On Fri, 26 Jan 2024 15:19:54 +0000
> > Will Deacon <will@kernel.org> wrote:
> >  =20
> > > Hi folks,
> > >=20
> > > These two patches fix a nasty double allocation problem in swiotlb_al=
loc()
> > > and add a diagnostic to help catch any similar issues in future. This=
 was
> > > a royal pain to track down and I've had to make a bit of a leap at the
> > > correct alignment semantics (i.e. iotlb_align_mask vs alloc_align_mas=
k). =20
> >=20
> > Welcome to the club. I believe you had to re-discover what I described =
here:
> >=20
> >   https://lore.kernel.org/linux-iommu/20231108101347.77cab795@meshulam.=
tesarici.cz/ =20
>=20
> Lucky me...
>=20
> > The relevant part would be this:
> >=20
> >   To sum it up, there are two types of alignment:
> >=20
> >   1. specified by a device's min_align_mask; this says how many low
> >      bits of a buffer's physical address must be preserved,
> >=20
> >   2. specified by allocation size and/or the alignment parameter;
> >      this says how many low bits in the first IO TLB slot's physical
> >      address must be zero. =20
> >=20
> > Fix for that has been sitting on my TODO list for too long. :-( =20
>=20
> FWIW, it did _used_ to work (or appear to work), so it would be good to
> at least get it back to the old behaviour if nothing else.

Yes, now that I look at the code, it was probably misunderstanding on
my side as to how the three different alignment requirements are
supposed to work together.

AFAICT your patch addresses everything that has ever worked. The rest
needs some more thought, and before I touch this loop again, I'll write
a proper test case.

Petr T

> Anyway, cheers for reviewing the patches. I'll go through your
> comments now...
>=20
> Will


