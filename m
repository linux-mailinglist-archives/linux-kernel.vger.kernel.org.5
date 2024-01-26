Return-Path: <linux-kernel+bounces-40286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D89C83DD9E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41081F2391D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B6C1CFAC;
	Fri, 26 Jan 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="RJyHoW22"
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87381D540
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283408; cv=none; b=FghSJsVAOR0v7O+CgXJmLohrR16513+EBXEn8Cnt4fFAZV7fPHP6/Ju+x83CAyb4und5Jv9piTCgJDc7t4o7Dn3B2eWyeVLL3oMsrjn1I+gCuknbnr6C+foqGxuS/Fr5sgUv4+N+WhgNr6oQ3AhlEsH4DX2RxgcC7j7dYK9EdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283408; c=relaxed/simple;
	bh=a0C7dY4YzMHGcQ7i8kF3thKZT23LiPNWR3wj3Bxv2vM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Ap4aV5OnQwa4AXUcqwPbhBHEZxJhOTMLRRpg48UCBm627+pxnJ/UnJtr04wB5aFWZsgxA6zHYA/KkVd9848To+qYbNNytbjwTg2EX99zRCw9m1jCsxTw8geus0hmJcRIiEugkILmhOean+YM1na+DY4To6AcAElQODNiX3/6QgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=RJyHoW22; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 1E346828564A;
	Fri, 26 Jan 2024 09:29:57 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Z4Bl9NmigOym; Fri, 26 Jan 2024 09:29:56 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 29B658285898;
	Fri, 26 Jan 2024 09:29:56 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 29B658285898
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1706282996; bh=fTWP5W9iG5QwHlage5ElLeYnTs1G1oJw4CN9sU4XTVk=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=RJyHoW22j6T7Bj4DC8orxCYKkaCSZusi8O1gZHUpIGJIhxHflzHPU559T+rrrzzUS
	 JhXngyRdJ45kGSDwzbdsjuGyowgEjj2vMy2z0r0tsQn/ayuqOMpp1dDgAz4X890yt5
	 tnL/UykXiv2oGwwc3JAbs0x1c1JFxSSnSl7Q63CE=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iyprsa7HK8WJ; Fri, 26 Jan 2024 09:29:55 -0600 (CST)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id D610E828564A;
	Fri, 26 Jan 2024 09:29:55 -0600 (CST)
Date: Fri, 26 Jan 2024 09:29:55 -0600 (CST)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>, iommu@lists.linux.dev, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, npiggin <npiggin@gmail.com>, 
	christophe leroy <christophe.leroy@csgroup.eu>, 
	aneesh kumar <aneesh.kumar@kernel.org>, 
	naveen n rao <naveen.n.rao@linux.ibm.com>, jroedel@suse.de, 
	Timothy Pearson <tpearson@raptorengineering.com>, aik@amd.com, 
	bgray@linux.ibm.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	gbatra@linux.vnet.ibm.com, vaibhav@linux.ibm.com
Message-ID: <392247278.10124607.1706282995795.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <20240126151701.GZ50608@ziepe.ca>
References: <170618450592.3805.8216395093813382208.stgit@ltcd48-lp2.aus.stglab.ibm.com> <170618451433.3805.9015493852395837391.stgit@ltcd48-lp2.aus.stglab.ibm.com> <20240125155017.GW50608@ziepe.ca> <b825dd04-3d32-4fbd-91e3-523ddf96fc7a@linux.ibm.com> <20240126151701.GZ50608@ziepe.ca>
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
Thread-Index: BFoIxDhAfBmdu+WWYcEeQbWvy98cLw==



----- Original Message -----
> From: "Jason Gunthorpe" <jgg@ziepe.ca>
> To: "Shivaprasad G Bhat" <sbhat@linux.ibm.com>
> Cc: iommu@lists.linux.dev, "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "Michael Ellerman" <mpe@ellerman.id.au>, "npiggin" <npiggin@gmail.com>, "christophe
> leroy" <christophe.leroy@csgroup.eu>, "aneesh kumar" <aneesh.kumar@kernel.org>, "naveen n rao"
> <naveen.n.rao@linux.ibm.com>, jroedel@suse.de, "Timothy Pearson" <tpearson@raptorengineering.com>, aik@amd.com,
> bgray@linux.ibm.com, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, gbatra@linux.vnet.ibm.com,
> vaibhav@linux.ibm.com
> Sent: Friday, January 26, 2024 9:17:01 AM
> Subject: Re: [PATCH 1/2] powerpc: iommu: Bring back table group release_ownership() call

> On Fri, Jan 26, 2024 at 08:43:12PM +0530, Shivaprasad G Bhat wrote:
>> > Also, is there any chance someone can work on actually fixing this to
>> > be a proper iommu driver? I think that will become important for power
>> > to use the common dma_iommu code in the next year...
>> We are looking into it.
> 
> Okay, let me know, I can possibly help make parts of this happen
> 
> power is the last still-current architecture to be outside the modern
> IOMMU and DMA API design and I'm going to start proposing things that
> will not be efficient on power because of this.

I can get development resources on this fairly rapidly, including testing.  We should figure out the best way forward and how to deal with the VFIO side of things, even if that's a rewrite at the end of the day the machine-specific codebase isn't *that* large for our two target flavors (64-bit PowerNV and 64-bit pSeries).

> I think a basic iommu driver using the dma API would not be so hard.
> 
> I don't know what to do about the SPAPR VFIO mess though. :(
> 
> Jason

