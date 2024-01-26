Return-Path: <linux-kernel+bounces-40288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A851683DDAB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C899B21569
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CEF1CFBE;
	Fri, 26 Jan 2024 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="ZNQ6O6b4"
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EDC1CFB6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283602; cv=none; b=kWrKVuszpDMYLJs5nCnfCYqtUhPQ97OvGa/+xJCCG4DDlr4v8pKCnhRIDwxNHU6ibTSIgc7jnU4Re0eKjjKnngZicxG3OzsQhx2vKvo5bQ7cZv4LILfqetqSxd6bM3dJ6uNRc0jadct/SpmxW6z4sh39puESfTuyJ0be0ou26Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283602; c=relaxed/simple;
	bh=zBCpP/8P5unyNO74Or9XNCmXRLENo8U5VyimSHB3VpM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Ggt/7NYSRDHLUzuVFMJIMQVNMKgCtl34ElxAohjcHwrx7qEBlPJM21Vojq1eDwq3YrviW7dURL06hvTys4kPuycTt2VFtiRI+9Rdcv+5r1paiFxAdfJxFo09rNdKA7tVAen/CKPqKdNNlLxEvzv+KZq76IPo9sbY6qT8ak0G3WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=ZNQ6O6b4; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id E6FDE8284F1B;
	Fri, 26 Jan 2024 09:39:59 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ky2a-k1hCssy; Fri, 26 Jan 2024 09:39:59 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id D322782854B8;
	Fri, 26 Jan 2024 09:39:58 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com D322782854B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1706283598; bh=OoH5zbIDpJ396eDy00lpvlhmn5YGipLNWyOVCXIxgwA=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=ZNQ6O6b4mOaP6wy15ucg53rS7Hz3n8WNMxH9tAlODg32Ac+qNaqLgx5lQ0DTT8rdh
	 t2LEG8qSuyTGN4ZIA2ajj6NaCNvubCswJRn6u6jlUux0bR3RwCuxeTeRrRVYbmmdTQ
	 94Q4APuxwOswDXRHPHiNP/t48za48GveP4oVJVA8=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uQvmigmfI0wM; Fri, 26 Jan 2024 09:39:58 -0600 (CST)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 8E9328284F1B;
	Fri, 26 Jan 2024 09:39:58 -0600 (CST)
Date: Fri, 26 Jan 2024 09:39:56 -0600 (CST)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Timothy Pearson <tpearson@raptorengineering.com>, 
	Shivaprasad G Bhat <sbhat@linux.ibm.com>, 
	iommu <iommu@lists.linux.dev>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, npiggin <npiggin@gmail.com>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	aneesh kumar <aneesh.kumar@kernel.org>, 
	naveen n rao <naveen.n.rao@linux.ibm.com>, jroedel <jroedel@suse.de>, 
	aik <aik@amd.com>, bgray <bgray@linux.ibm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	gbatra <gbatra@linux.vnet.ibm.com>, vaibhav <vaibhav@linux.ibm.com>
Message-ID: <1453449220.10126352.1706283596477.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <20240126153806.GA50608@ziepe.ca>
References: <170618450592.3805.8216395093813382208.stgit@ltcd48-lp2.aus.stglab.ibm.com> <170618451433.3805.9015493852395837391.stgit@ltcd48-lp2.aus.stglab.ibm.com> <20240125155017.GW50608@ziepe.ca> <b825dd04-3d32-4fbd-91e3-523ddf96fc7a@linux.ibm.com> <20240126151701.GZ50608@ziepe.ca> <392247278.10124607.1706282995795.JavaMail.zimbra@raptorengineeringinc.com> <20240126153806.GA50608@ziepe.ca>
Subject: Re: [PATCH 1/2] powerpc: iommu: Bring back table group
 release_ownership() call
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC112 (Linux)/8.5.0_GA_3042)
Thread-Topic: powerpc: iommu: Bring back table group release_ownership() call
Thread-Index: LjsszU7HTiVuL5lSzea+joNjeMRWPw==



----- Original Message -----
> From: "Jason Gunthorpe" <jgg@ziepe.ca>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "Shivaprasad G Bhat" <sbhat@linux.ibm.com>, "iommu" <iommu@lists.linux.dev>, "linuxppc-dev"
> <linuxppc-dev@lists.ozlabs.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "Michael Ellerman"
> <mpe@ellerman.id.au>, "npiggin" <npiggin@gmail.com>, "christophe leroy" <christophe.leroy@csgroup.eu>, "aneesh kumar"
> <aneesh.kumar@kernel.org>, "naveen n rao" <naveen.n.rao@linux.ibm.com>, "jroedel" <jroedel@suse.de>, "aik"
> <aik@amd.com>, "bgray" <bgray@linux.ibm.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "gbatra"
> <gbatra@linux.vnet.ibm.com>, "vaibhav" <vaibhav@linux.ibm.com>
> Sent: Friday, January 26, 2024 9:38:06 AM
> Subject: Re: [PATCH 1/2] powerpc: iommu: Bring back table group release_ownership() call

> On Fri, Jan 26, 2024 at 09:29:55AM -0600, Timothy Pearson wrote:
>> > On Fri, Jan 26, 2024 at 08:43:12PM +0530, Shivaprasad G Bhat wrote:
>> >> > Also, is there any chance someone can work on actually fixing this to
>> >> > be a proper iommu driver? I think that will become important for power
>> >> > to use the common dma_iommu code in the next year...
>> >> We are looking into it.
>> > 
>> > Okay, let me know, I can possibly help make parts of this happen
>> > 
>> > power is the last still-current architecture to be outside the modern
>> > IOMMU and DMA API design and I'm going to start proposing things that
>> > will not be efficient on power because of this.
>> 
>> I can get development resources on this fairly rapidly, including
>> testing.  We should figure out the best way forward and how to deal
>> with the VFIO side of things, even if that's a rewrite at the end of
>> the day the machine-specific codebase isn't *that* large for our two
>> target flavors (64-bit PowerNV and 64-bit pSeries).
> 
> I have a feeling the way forward is to just start a power driver under
> drivers/iommu/ and use kconfig to make the user exclusively select
> either the legacy arch or the modern iommu.
> 
> Get that working to a level where dma_iommu is happy.
> 
> Get iommufd support in the new driver good enough to run your
> application.
> 
> Just forget about the weird KVM and SPAPR stuff, leave it under the
> kconfig of the old code and nobody will run it. Almost nobody already
> runs it, apparently.

We actually use QEMU/KVM/VFIO extensively at Raptor, so need the support and need it to be performant...

> Remove it in a few years
> 
> From what I remember the code under the arch directory is already very
> nearly almost an iommu driver. I think someone could fairly quickly
> get to something working and using dma_iommu.c. If s390 is any
> experience there is some benchmarking and tweaking to get performance
> equal to the arch's tweaked dma_iommu copy.
> 
> Jason

