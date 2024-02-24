Return-Path: <linux-kernel+bounces-79536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E0F8623C5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C244283A43
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE10B2511F;
	Sat, 24 Feb 2024 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XCyJB4bB"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1D824B33
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765981; cv=none; b=JpP4NmLY87b+5By/nVju8T1GSJvE8FK5xPGGypwvAwRlHctkHqGxHHJipZblFGBSQENW7UzxW8dyVIgsLb29lfiCMWyzkdrbRwnpbX1+tnffNpgextzV/VyJONmEI8mMVgdDFe6Nnhlo6k6fZHUuTjOVj28/4/l2SMA9nAAlUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765981; c=relaxed/simple;
	bh=AnS3pRKxOMVcDD2fhVFFwI7/t9DJI7DBCNJiJb7KH+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kw4Cxo41Ywn7bcXSJMxd04N1gWVJfKIhebdQTwriwJkfRdB7Ci1nyk7aGn8TFER5eCMwha9hfsYuFGVnY+jlS030Gu0fG/oDDMZiRMHxF7Io0+uhnxZqT8fgMMCLjEVUjETPKVFtx6URR5Lu1wdAyz3dyQZXToA9GN+wiQNWKsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XCyJB4bB; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 24 Feb 2024 09:12:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708765977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3GLNrkFf3ykGmJw0n0IUAe88Zkm3rjaHg8xG3pDz7GY=;
	b=XCyJB4bBBQj2QNwO3xKwi5smVMJZuOVHPrN2ZevIE4owYqj8sKbyIqPCHs0UcGVyX6aENS
	Tw63+n2br2qV4quJEw5CZN9WILsUOClQVfcob9/XGokQQhbmkd6IfdRdoGaHZqYvRqcFdZ
	T1qVEk3NpILeda/t9wO6DFO4FKU/OfM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH 5/8] KVM: arm64: Fix typos
Message-ID: <ZdmzE_Yg4EAv8cAn@linux.dev>
References: <20240103231605.1801364-1-helgaas@kernel.org>
 <20240103231605.1801364-6-helgaas@kernel.org>
 <2cd87332-b3f9-e415-6458-57eb3615c43e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd87332-b3f9-e415-6458-57eb3615c43e@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 24, 2024 at 12:39:34PM +0800, Zenghui Yu wrote:
> On 2024/1/4 07:16, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Fix typos, most reported by "codespell arch/arm64".  Only touches comments,
> > no code changes.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Zenghui Yu <yuzenghui@huawei.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: kvmarm@lists.linux.dev
> 
> Oliver, mind taking it into 6.9?

Thanks for the nudge!

-- 
Thanks,
Oliver

