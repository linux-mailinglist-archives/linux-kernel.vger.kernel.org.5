Return-Path: <linux-kernel+bounces-66268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A081E855985
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0337DB27A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466576FB0;
	Thu, 15 Feb 2024 03:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="cjQTs2Lu"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710BEB660;
	Thu, 15 Feb 2024 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707968207; cv=none; b=TC5mlZK/dxGqTS3XVDz0X7Byou/wSvvh64hWSMEFdgV0aEn9siVUUM4R1DLdSzna9yCsqplhUsHMx7YeQnG6STArF6PXR/y0TUs28awKvKrMRbV9gYEJw7eZl59gPbqy1S39UHkYHL93Wx0mR7LuUG2N3vIAcZIVvobCwD1X65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707968207; c=relaxed/simple;
	bh=uBVWc3WnQiSE73f2SM93QqQjzcXOnbEklnqmtdVl140=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vFQs7DwV811fojiNUFEhtoj9zBYczat34D0tvmd4utnihjw6TwRowX3m0f3I9FnqIVpjKMe3/c5wQmCens8fhoLhcCR2nAq9BWyMWcKU90dt224EORFlDaCM/Vk0huU8l4xqUE8nCXOQOV7Q6DHBKYhq1qcVcyyI/ghaVoj5p94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=cjQTs2Lu; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1707968201;
	bh=s71VglVzXMHExQHV0flXdlMkL0Er5JOLuJrclNyZ2YU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cjQTs2LumNQvps0w1v9ahJISdsxPzj0e6mQz9zzTwySFqnU8I+6KL4Q/lm609CWco
	 /71QVSEkdXue7HIPavkyUqbFSTskV3H32oYe8Fw2xFlwSe/8gdtDf3QidhKtPwVqz5
	 DQjGPi8tRyygya1FfuaPpxDs2N4v2Lgu9ulVOOHzx/F2UrpaZEN+NIgHkoq5Vz7Zs0
	 J2566AhsAZOR0kre8HKjn1OxEOmd8Y7iniRdfcWfTQ4ED30GRX/iW+iXM/4OMavMyp
	 HKwobuQXiN8IxYHYIy7GpK1P9NCb6plTcoPwXYTog8Nb2IG3+r+MnBXk4RXbCu+iRj
	 Fg10tpZIFsqxA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tb12K1Jrjz4wcN;
	Thu, 15 Feb 2024 14:36:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gaurav Batra
 <gbatra@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: Tree for Feb 14
 (arch/powerpc/platforms/pseries/pci_dlpar.o)
In-Reply-To: <c501ff0a-170b-42a8-a5b7-623ebb6c7fba@infradead.org>
References: <20240214151426.0a398cf0@canb.auug.org.au>
 <c501ff0a-170b-42a8-a5b7-623ebb6c7fba@infradead.org>
Date: Thu, 15 Feb 2024 14:36:41 +1100
Message-ID: <8734tu760m.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:
> On 2/13/24 20:14, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Changes since 20240213:
>> 
>
> on powerpc64:
> when CONFIG_IOMMU_API is not set.
>
>
> powerpc64-linux-ld: arch/powerpc/platforms/pseries/pci_dlpar.o: in function `init_phb_dynamic':
> pci_dlpar.c:(.text+0xc4): undefined reference to `ppc_iommu_register_device'
> powerpc64-linux-ld: arch/powerpc/platforms/pseries/pci_dlpar.o: in function `remove_phb_dynamic':
> pci_dlpar.c:(.text+0x248): undefined reference to `ppc_iommu_unregister_device'

I'm pretty sure I reverted the commit causing that, the revert will be
in today's linux-next.

cheers

