Return-Path: <linux-kernel+bounces-104558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC9C87CFD8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C030A1C22934
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919BB3CF75;
	Fri, 15 Mar 2024 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="vO5BaKxl"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB213BBCD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515381; cv=none; b=CMXmk3XRHKUP40wFsrATSTzv7CdS2jv+dkZjZUJbe75vyb/qC4cU1IsA3wEBq/0j32BqmW9HbBV9cxk0bm1RTTHn53fM2PZWuaqk50R2zUUrFBeGm2zTZga5C5ZnQBvXlucAJVISpp0BYiwyvpzVzuuO1Hj048ZYDEohEDYtAlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515381; c=relaxed/simple;
	bh=uysj4L8dszCTthjgDSnBVbbbyoveIsByuEO6DJzqfWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YT8hkpCurp35FrYn4kt8RRXM1B4hsXHv/SmYMF2kP3FsnAnAX/Zra9LJ6KuoKZv5z/++mzQnckiXJjGeTdt4uQ4l/fCVJXWDUzM1AYeDROoVwqIqVMX9PIcdoNTr7IEewV0FP19p7jhE3yhHdCouzk+VjeeSK2WL5RCfds/ZkOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=vO5BaKxl; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 0AE88196E57;
	Fri, 15 Mar 2024 16:09:33 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1710515373; bh=6T0BIzOuPE5LuqB1wHjUl+/fIgb/2kuGQnVeMY/YX2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vO5BaKxl3e9SUXW4uSTkVJ11QsDMqP5wxHIeZ5KyjOkM5TxkPkgVN8VeO79q2Hkm1
	 GToh2cK9Y420JuptkfHcSrQcnACwXCZGkFjEK21DH9GZzrfK9vyf1tg122+Iusj5T7
	 qarBmwhEsb9gFrRNOlecDMXTCTO3kNQ9AeUuM/Y4G6rGX0Trr2bbq7jPdkKyPrlGFx
	 B0u/f3KMD20HASGWHOtoZPcxknDMVDdVCbPKtDoQphH6zE3Ck4QZ7k5eCZkcwcgCPR
	 LTuOYimvDog3ULTKdBMXnQM8wxblsXCLnZ/hjCFd1ElBwOAnqGzG1A8avc+C85Gw3b
	 oLaXbdIwyEJ9g==
Date: Fri, 15 Mar 2024 16:09:31 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, Christoph Hellwig
 <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Nicolin Chen
 <nicolinc@nvidia.com>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, Roberto
 Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH 1/1] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
Message-ID: <20240315160931.48879f5c@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB41574FB8FF2FA08C26682EC1D4282@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240312134149.497-1-petrtesarik@huaweicloud.com>
	<SN6PR02MB4157FB27CD890E9F29408926D4282@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240315132613.5a340a69@meshulam.tesarici.cz>
	<SN6PR02MB41574FB8FF2FA08C26682EC1D4282@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Mar 2024 14:59:08 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Friday, March 15, 2=
024 5:26 AM
> >=20
> > On Fri, 15 Mar 2024 02:53:10 +0000
> > Michael Kelley <mhklinux@outlook.com> wrote:
> >  =20
> > > From: Petr Tesarik <petrtesarik@huaweicloud.com> Sent: Tuesday, March=
 12, 2024 6:42 AM =20
> > > > =20
>=20
> [snip]
>=20
> > > > @@ -1349,6 +1353,15 @@ phys_addr_t swiotlb_tbl_map_single(struct de=
vice *dev, phys_addr_t orig_addr,
> > > >  		return (phys_addr_t)DMA_MAPPING_ERROR;
> > > >  	}
> > > >
> > > > +	/*
> > > > +	 * Calculate buffer pre-padding within the allocated space. Use i=
t to
> > > > +	 * preserve the low bits of the original address according to dev=
ice's
> > > > +	 * min_align_mask. Limit the padding to alloc_align_mask or slot =
size
> > > > +	 * (whichever is bigger); higher bits of the original address are
> > > > +	 * preserved by selecting a suitable IO TLB slot.
> > > > +	 */
> > > > +	offset =3D orig_addr & dma_get_min_align_mask(dev) &
> > > > +		(alloc_align_mask | (IO_TLB_SIZE - 1));
> > > >  	index =3D swiotlb_find_slots(dev, orig_addr,
> > > >  				   alloc_size + offset, alloc_align_mask, &pool);
> > > >  	if (index =3D=3D -1) {
> > > > @@ -1364,6 +1377,12 @@ phys_addr_t swiotlb_tbl_map_single(struct de=
vice *dev, phys_addr_t orig_addr,
> > > >  	 * This is needed when we sync the memory.  Then we sync the buff=
er if
> > > >  	 * needed.
> > > >  	 */
> > > > +	padding =3D 0;
> > > > +	while (offset >=3D IO_TLB_SIZE) {
> > > > +		pool->slots[index++].orig_addr =3D INVALID_PHYS_ADDR;
> > > > +		pool->slots[index].padding =3D ++padding;
> > > > +		offset -=3D IO_TLB_SIZE;
> > > > +	} =20
> > >
> > > Looping to fill in the padding slots seems unnecessary.
> > > The orig_addr field should already be initialized to
> > > INVALID_PHYS_ADDR, and the padding field should already
> > > be initialized to zero. =20
> >=20
> > Ack.
> >  =20
> > > The value of "padding" should be just
> > > (offset / IO_TLB_SIZE), and it only needs to be stored in the
> > > first non-padding slot where swiotlb_release_slots() will
> > > find it. =20
> >=20
> > This is also right. I asked myself the question what should happen if
> > somebody passes a padding slot's address to swiotlb_tbl_unmap_single().
> > Of course, it's an invalid address, but as a proponent of defensive
> > programming, I still asked what would be the best response? If I store
> > padding in each slot, the whole block is released. If I store it only
> > in the first non-padding slot, some slots may leak.
> >=20
> > On a second thought, the resulting SWIOTLB state is consistent either
> > way, and we don't to care about leaking some slots if a driver is
> > buggy. Maybe it's even better, because the leak will be noticed.
> >=20
> > In short, I agree, let's keep the code simple.
> >  =20
>=20
> One other thought:  Fundamentally, fixing the core problem
> requires swiotlb_tbl_unmap_single() to have some information
> it doesn't have in the current code.  It needs to know the
> number of padding slots, so that it can free them correctly.
> Your solution is to store the # of padding slots in the
> io_tlb_slot array.
>=20
> Another approach would be to have callers pass the
> alloc_align_mask as an argument to swiotlb_tbl_unmap_single().
> It can then calculate the offset and the number of padding
> slots just like swiotlb_tbl_map_single() does.  Nothing
> additional would need to be stored in the io_tlb_slot array.
> The IOMMU code is the only caller than uses a non-zero
> alloc_align_mask.  From a quick look at that code, the
> unmap path has the iova_mask() available, so that would
> work.  Other callers would pass zero, just like they do for
> swiotlb_tbl_map_single().
>=20
> I don't immediately have a strong opinion either way, but
> it's something to think about a bit more.

I believe it's slightly more robust to store how the buffer was
actually allocated than to rely on the caller. It seems to me that this
was also a design goal of the original author. For example, note that
swiotlb_tbl_unmap_single() uses mapping_size only to do the final
buffer sync, but not to determine how many slots should be released.
This information is taken from struct io_tlb_slot.alloc_size.

Petr T

