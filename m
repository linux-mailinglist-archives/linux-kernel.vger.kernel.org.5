Return-Path: <linux-kernel+bounces-141930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989388A2534
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33CBC1F21FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C42BA33;
	Fri, 12 Apr 2024 04:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="LZ4SAqsk"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AD9A41;
	Fri, 12 Apr 2024 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712896591; cv=none; b=ku9qjstmhSDytO2vofnDzAWEkyvfPDJGcK59IFs1NgE/+eTnhsPnZqsG/VTL+gVi0vkwpaCNYXjXAD1DhXXQ2QsL65Pv9e3Zj6AxqTffM65d8FzMi5zNnAYA8xgSr09eHxR1ySDFR8LU9lXZeS5Enrn64eQJCPhyBG6kwlvx9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712896591; c=relaxed/simple;
	bh=/qeKVjTPz0dZGSJMwwnYKBtSCPzNT4a7ETHeFAOMW8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z4DhxFuSPi3q/wJ34kp1F+13Ds+18q6pPWhR64uvE2cOKhyEFTrwWvu9iDk5HemeZbcdESk7rRD8UwGEZZ6A7AJL2Lg2/PYl94Sx6KQng/EATHgqI10YsF3B/EuxA4v0NHYZgR1UE4c7Cre4UkzWISI6EOnUkUSkREHinP24TZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=LZ4SAqsk; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712896586;
	bh=knRQtJ7kQMDSJLodYLmrJSnjcAkp2nMWpieNQrKmKPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LZ4SAqskdbrQ2uJm/VBr9YtTV03OFQdqdm4oNMjenFZWh7YP7YzFh+NwhToU4MzE0
	 B0xwSsXc4VHePvvMjCNX0PDXo+47FdqTiHFO8D7LxZVTK9nyxErUUcAAfaIW1Kz+Ri
	 ynUHF6c4doYK3pnfRFPj6hk/VST31HZB4PXyh7DvZuza0thH9TC8xNfsiwZ13+bMS9
	 PI9wdWgGVGPkNysHzTazXT8GkcI0D2GGsi2aLqYN/zttw0osT+YbCLA2lMT+6fmKP4
	 KgkrK6/KSI1G83OrtdoieohcnRZ9kAe1VFudTvNLhAo2U5VqLYYEznemR+JCGneOII
	 Rx0bFCKrewuag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VG3fy0nT8z4wnr;
	Fri, 12 Apr 2024 14:36:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>
Cc: PowerPC <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the driver-core.current tree
In-Reply-To: <20240412084310.035f018d@canb.auug.org.au>
References: <20240412084310.035f018d@canb.auug.org.au>
Date: Fri, 12 Apr 2024 14:36:25 +1000
Message-ID: <87mspzci46.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> The following commit is also in the powerpc-fixes tree as a different
> commit (but the same patch):
>
>   156539fd6501 ("Documentation: embargoed-hardware-issues.rst: Add myself for Power")
>
> This is commit
>
>   36627111b568 ("Documentation: embargoed-hardware-issues.rst: Add myself for Power")
>
> in the powerpc-fixes tree.

I can drop my version easily enough.

cheers

