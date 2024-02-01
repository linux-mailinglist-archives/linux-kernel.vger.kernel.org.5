Return-Path: <linux-kernel+bounces-48816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D516E8461F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C961F2525A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E7E17BD2;
	Thu,  1 Feb 2024 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dq/YUIlZ"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD1926AD5
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819470; cv=none; b=HFBNgakF0HY1ilxjkn9gEFiDkUS7OW3oWhOXNCA3LT7xtoZI2lQk1aYNznEC2u0cC0zRIwsxmRL59paAdaSNOl1Zs1K4qClkwSPtczLupMH9USRMRxIOD26jbWFrVKma/G9aM+eX/KOZajQfp1ChrFuGt0Vd6A+ySaW6Dy2m0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819470; c=relaxed/simple;
	bh=pl01XxJvCSr905362CLcoeAKt0+bHnRT0ALDhya3/yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jf3qtHiur+1ZM6Q0x0WxFCgyawVUkO3pAz838Vfcnjgc62UXnFNiqqoxHTRBPHVWgnU7Oj7b5ixjSOtsMLlL0lO+cc9DFIAwbP+YjHaykTiyKghd4QWVKMlDQCLstRL5kgAQI1Cimt+ZZeJmsp5Ef9sJVquHh9V/EiXW76I2I18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dq/YUIlZ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706819466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwP6DcVMHmam3R5gLofRFfJeh4GcrsoYje2BNlcsz5k=;
	b=dq/YUIlZ0XRTWoXuyrgAiNJkKdu4Bet/xKIqTO3mSElVcEBmCHVNqwQEQ7d1WdMnQY7wvD
	uMMWlyrB5CemYCsknlVxTDBvU2fstX/weM/r3bTinQjj+npQibyJ1VyTD8YCh9o86Iz3Wf
	Za9FRTRTdMVuKfBOoR5PkZ9QelMapIE=
From: Oliver Upton <oliver.upton@linux.dev>
To: Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Will Deacon <will@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	kvmarm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 00/10] KVM: arm64: fix many kernel-doc warnings
Date: Thu,  1 Feb 2024 20:30:19 +0000
Message-ID: <170681941355.2769902.10865128203340654876.b4-ty@linux.dev>
In-Reply-To: <20240117230714.31025-1-rdunlap@infradead.org>
References: <20240117230714.31025-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 17 Jan 2024 15:07:04 -0800, Randy Dunlap wrote:
> Fix a bunch of kernel-doc warnings in arch/arm64/kvm/.
> 
>  [PATCH 01/10] KVM: arm64: debug: fix kernel-doc warnings
>  [PATCH 02/10] KVM: arm64: guest: fix kernel-doc warnings
>  [PATCH 03/10] KVM: arm64: hyp/aarch32: fix kernel-doc warnings
>  [PATCH 04/10] KVM: arm64: vhe: fix a kernel-doc warning
>  [PATCH 05/10] KVM: arm64: mmu: fix a kernel-doc warning
>  [PATCH 06/10] KVM: arm64: PMU: fix kernel-doc warnings
>  [PATCH 07/10] KVM: arm64: sys_regs: fix kernel-doc warnings
>  [PATCH 08/10] KVM: arm64: vgic-init: fix a kernel-doc warning
>  [PATCH 09/10] KVM: arm64: vgic-its: fix kernel-doc warnings
>  [PATCH 10/10] KVM: arm64: vgic: fix a kernel-doc warning
> 
> [...]

Applied to kvmarm/next, thanks!

[01/10] KVM: arm64: debug: fix kernel-doc warnings
        https://git.kernel.org/kvmarm/kvmarm/c/c4d15f841570
[02/10] KVM: arm64: guest: fix kernel-doc warnings
        https://git.kernel.org/kvmarm/kvmarm/c/39db66e6b404
[03/10] KVM: arm64: hyp/aarch32: fix kernel-doc warnings
        https://git.kernel.org/kvmarm/kvmarm/c/bc13610b4240
[04/10] KVM: arm64: vhe: fix a kernel-doc warning
        https://git.kernel.org/kvmarm/kvmarm/c/aa96af24f320
[05/10] KVM: arm64: mmu: fix a kernel-doc warning
        https://git.kernel.org/kvmarm/kvmarm/c/ffd9eaffa34d
[06/10] KVM: arm64: PMU: fix kernel-doc warnings
        https://git.kernel.org/kvmarm/kvmarm/c/2a00f0855530
[07/10] KVM: arm64: sys_regs: fix kernel-doc warnings
        https://git.kernel.org/kvmarm/kvmarm/c/8ce783927268
[08/10] KVM: arm64: vgic-init: fix a kernel-doc warning
        https://git.kernel.org/kvmarm/kvmarm/c/dd609a574a02
[09/10] KVM: arm64: vgic-its: fix kernel-doc warnings
        https://git.kernel.org/kvmarm/kvmarm/c/f779d2c0176c
[10/10] KVM: arm64: vgic: fix a kernel-doc warning
        https://git.kernel.org/kvmarm/kvmarm/c/e634ff9598a4

--
Best,
Oliver

