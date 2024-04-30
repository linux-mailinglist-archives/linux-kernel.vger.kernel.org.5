Return-Path: <linux-kernel+bounces-164697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9538B812F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F9928429B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730D5199EA6;
	Tue, 30 Apr 2024 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="SkBYcRS+"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA243308A;
	Tue, 30 Apr 2024 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507770; cv=none; b=M+rpZ4V37nAEKTQZEkjeSp0L5vxhx+oz1N3Gah3PPqaEXuTf9MTypKEWnTXtTCmCIClo2K0vEIHbL5ANb/Myha11eatA5w34INGzuqcLjJghYbBsT+PEuOyp7XMKZy3fA8f/gAuMIzjRY8NnyJxhyywkFQMyZtFXrGjwyK3D98E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507770; c=relaxed/simple;
	bh=+W073mdtgIFOzLF3pLZOnqWa4SW4FX7ciIxPNHIMnjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujFekWfdeyddk2a7S6a7fjy9zTUyYCNeni1bFomisMpRog8AAC5OdVpeFl8fqvwCiI9qgm1D7SxfhbyYjEeTHvKq1Ka8GM2N6l541Kpao+vJuSedL7eZIfliclvuZYqxp094wPyDTpCqMY9ewIAsFRGRUqrVpVjHuPIcZjGwi/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=SkBYcRS+; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 2B35B1B33AB;
	Tue, 30 Apr 2024 22:09:25 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1714507765; bh=9hVpNf0UpME2ZAq2VVrOWX05zjm2iYyBWxgQpaSqhEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SkBYcRS+1DgzItYu4znKOQOwyrc0mqUDVbLVI5/da2r4YcYoqFL2jY0tNX/XsifwQ
	 pQo2swe5T4NzzIX4WvCuOmGx2SxBkFY3T/1/N5hKNoh7z7Rz9RK0VLUdHTOjOtrgc2
	 jrcEThrVOWriPcwS7+eM7weKDs6dobPEuUI/lZrV15/LSo4p7FDvYBVx8ETBuqKQgV
	 d4ntvnWsjczfUiEbqqknTdYxwh+JQIU/SdHYIwt4OTEFuYeqB9fPhrDpqkMMX4Q/+i
	 u/ZRIUAG3u5OxFASbqiWpGtuQNEKfazFHC86gvBHWstoyK2bvxBUfR8nhGxTOoGj31
	 8HZ139QUNghkw==
Date: Tue, 30 Apr 2024 22:09:24 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "mhkelley58@gmail.com" <mhkelley58@gmail.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "corbet@lwn.net"
 <corbet@lwn.net>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v3 1/1] Documentation/core-api: Add swiotlb
 documentation
Message-ID: <20240430220924.3d0446f7@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB41579F43DD1ACB401EEC9E7AD41A2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240429151337.1069470-1-mhklinux@outlook.com>
	<20240430132413.69797af1@mordecai>
	<SN6PR02MB41579F43DD1ACB401EEC9E7AD41A2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Apr 2024 15:48:42 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Tuesday, April 30, =
2024 4:24 AM
> > >
> > > +Usage Scenarios
> > > +---------------
> > > +swiotlb was originally created to handle DMA for devices with addres=
sing
> > > +limitations. As physical memory sizes grew beyond 4 GiB, some device=
s could
> > > +only provide 32-bit DMA addresses. By allocating bounce buffer memor=
y below
> > > +the 4 GiB line, these devices with addressing limitations could stil=
l work and
> > > +do DMA. =20
> >=20
> > IIRC the origins are even older and bounce buffers were used to
> > overcome the design flaws inherited all the way from the original IBM
> > PC. These computers used an Intel 8237 for DMA. This chip has a 16-bit
> > address register, but even the early 8088 CPUs had a 20-bit bus. So IBM
> > added a separate 74LS670 4-by-4 register file chip to provide the high 4
> > bits for each of the 4 DMA channels. As a side note, these bits were not
> > updated when the 8237 address register was incrementing from 0xffff, so
> > DMA would overflow at every 64K address boundary. PC AT then replaced
> > these 4 bits with an 8-bit DMA "page" register to match the 24-bit
> > address bus of an 80286. This design was not changed for 32-bit CPUs
> > (i.e. 80386).
> >=20
> > In short, bounce buffers were not introduced because of 64-bit CPUs.
> > They were already needed on 386 systems.
> >=20
> > OTOH this part of the history need not be mentioned in the
> > documentation (unless you WANT it). =20
>=20
> I knew there was some even earlier history, but I didn't know the
> details. :-(  I'll add some qualifying wording about there being multiple
> DMA addressing limitations during the history of the x86 PCs, with
> the 32-bit addressing as a more recent example.  But I won't try to
> cover the details of what you describe.

Yes, this sounds like a good level of detail.

> > > +
> > > +More recently, Confidential Computing (CoCo) VMs have the guest VM's=
 memory
> > > +encrypted by default, and the memory is not accessible by the host h=
ypervisor
> > > +and VMM. For the host to do I/O on behalf of the guest, the I/O must=
 be
> > > +directed to guest memory that is unencrypted. CoCo VMs set a kernel-=
wide option
> > > +to force all DMA I/O to use bounce buffers, and the bounce buffer me=
mory is set
> > > +up as unencrypted. The host does DMA I/O to/from the bounce buffer m=
emory, and
> > > +the Linux kernel DMA layer does "sync" operations to cause the CPU t=
o copy the
> > > +data to/from the original target memory buffer. The CPU copying brid=
ges between
> > > +the unencrypted and the encrypted memory. This use of bounce buffers=
 allows
> > > +existing device drivers to "just work" in a CoCo VM, with no modific=
ations
> > > +needed to handle the memory encryption complexity. =20
> >=20
> > This part might be misleading. It sounds as if SWIOTLB would not be
> > needed if drivers were smarter. =20
>=20
> I'm not sure I understand the point you are making. It is possible for a
> driver to do its own manual bounce buffering to handle encrypted memory.
> For example, in adding support for CoCo VMs, we encountered such a
> driver/device with complex DMA and memory requirements that already
> did some manual bounce buffering. When used in a CoCo VM, driver
> modifications were needed to handle encrypted memory, but that was
> the preferred approach because of the pre-existing manual bounce
> buffering. In that case, indeed swiotlb was not needed by that driver/dev=
ice.
> But in the general case, we don't want to require driver modifications for
> CoCo VMs. swiotlb bounce buffering makes it all work in the exactly the
> situation you describe where the buffer memory could have originated
> in a variety of places.
>=20
> Could you clarify your point?  Or perhaps suggest alternate wording
> that would help avoid any confusion?

Ah, I wasn't aware that some drivers implement their own bounce
buffers. I can't say I'm really happy about it, because such drivers
must inevitably deal with all the complexities like IOMMU, decrypting,
etc. But you're right - bounce buffers can be implemented by individual
drivers.

I have now read the sentence again, and the problematic wording is
"existing device drivers". I know it's not the same as "legacy device
drivers", but it still leaves some doubt whether "future device drivers"
should make use of SWIOTLB. So either remove "existing" or be more
explicit and say "existing and future device drivers". Then it sounds
fine to me.

HTH
Petr T

