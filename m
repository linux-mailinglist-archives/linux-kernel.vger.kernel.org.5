Return-Path: <linux-kernel+bounces-118927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9061788C14D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C28AB222CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE286EB59;
	Tue, 26 Mar 2024 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="gpRgXg4K"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFFC6CDCC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454126; cv=none; b=ZuX6xn8FvKp/0SJWVYpAXBHi3p52teln4UlG0i31W8l1Fp6u4gUtD7zCUEybU6b90tW3y5pprInHCb2RjWnQGj1bM8/aSsTItdo/Hh3NhpV7VNOBEEk0hhbBVne7vbnXIQJWUYWiikd6D/v5MtHaz4UCRJlhlW23wDYOPRBaG8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454126; c=relaxed/simple;
	bh=3JXq7xfw33BAjKe2vrE7FVmkKyrZz+2pN3PkS293FPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D//CzhmVa/CyX8Y+49QPNy3X/oU1st64SyBYVCv4qXWz1f/rXampf1ClqpWSBOl0/3yAqruTlGkPd5SryJgVzqtmqYME0ql012rsTd0d8XHqpMriPdr4r84vvYVNUWk8LCK4dZwMHuHNxxlPTnb40sktR2O/WTzGg9ERndEZkZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=gpRgXg4K; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-b985-910f-39e1-703f.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:b985:910f:39e1:703f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 427CD1AFFC5;
	Tue, 26 Mar 2024 12:55:14 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1711454114; bh=/T963m0awUECKjS5oYbqzSukhasYP4dIjzgrxQhicCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gpRgXg4KcQ7JdPeLOOim7ujdCjsdB3qiwce2opq+4AkFkPepCJrcb1Nr0LjvS8DC5
	 gES3mxyskqKxZGxhAn2g2+TSYGGWz5mDDqF2lfJJzlkLqNO+XJqyzn8f3Il1Mi9Xcl
	 XWb2OL6v0AIoIiqI5bDBjj3R6r2Al843f/gY2MgpCx0YHbBMAF/6e+RFMYyECBgmHq
	 +ZFXJlcE1JUh6uQcZhTLlyL6b2M6wx+5oNHzvKRddLZ39vjCThDcQkiu2lxdnyqkyL
	 JTTknh+l3kArFYHWYOZ1uYl4xLc7cHogmFwEkUn1BWQ57d580S6lbVPUGJvSHHOh1Q
	 qNu3m8vPqLZPA==
Date: Tue, 26 Mar 2024 12:55:12 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Michael Kelley
 <mhklinux@outlook.com>, Will Deacon <will@kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v4 2/2] bug: introduce ASSERT_VAR_CAN_HOLD()
Message-ID: <20240326125512.430c1ed0@meshulam.tesarici.cz>
In-Reply-To: <20240326075606.GA10489@lst.de>
References: <20240325083105.658-1-petrtesarik@huaweicloud.com>
	<20240325083105.658-3-petrtesarik@huaweicloud.com>
	<20240326075606.GA10489@lst.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 08:56:06 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Mar 25, 2024 at 09:31:05AM +0100, Petr Tesarik wrote:
> > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > 
> > Introduce an ASSERT_VAR_CAN_HOLD() macro to check at build time that a
> > variable can hold the given value.  
> 
> This really should be run past whoever maintains build_bug.h and
> also cc linux-kernel.  Please also split the addition and the user
> in swiotlb into separate patches.
> 
> I plan to pick up patch 1 for now, and wait for the discussion on
> this addition.

Fair enough. The use in swiotlb depends on patch 1 from this series,
but you're right, I can send the macro addition as a separate patch to
get some feedback.

Thank you!
Petr T

