Return-Path: <linux-kernel+bounces-153085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A408AC8CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866EF1C209E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29C556B62;
	Mon, 22 Apr 2024 09:21:46 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1590353E22
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777706; cv=none; b=anObE1G4EOg02/+LFhz9Drq9PWTQHXAgn1H0qCUQAPCbFpwbHIQYOkAhLZusQw4LDJEaCwfcZ1giPytz8Fd+ZuqJuLka5H09tz2T9a1uF+vdJf4zwDspgyOI3CKkgHpqGlUs6iaaQNsDqqx++i2wyAFfIh52TKr2qQmf0ou6lXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777706; c=relaxed/simple;
	bh=lHsQk24LRFF+sQ1P0elf4sGSVBGC2K+0eBMqlc8Ojfo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XDfhlFGZUY9CAEm8H2glpd1D+KGzElcW5O5SoKHaU/LLTCcy/iZnLPlFxOfVqs8TLETXGS4/Cnt53v+uDvw4gOtMosWFeKIH9ScfVzDuQG78sBZjNtu+ct8Y/kOCNg4zW5/LXgHUA1itKoe/l/hjoJLli0FK97P/YLGcv6TAZYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNKWV1Crdz4wyp;
	Mon, 22 Apr 2024 19:21:42 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, jgg@ziepe.ca, jroedel@suse.de, tpearson@raptorengineering.com, aik@amd.com, bgray@linux.ibm.com, gregkh@linuxfoundation.org, gbatra@linux.vnet.ibm.com, vaibhav@linux.ibm.com, venkat88@linux.vnet.ibm.com
In-Reply-To: <170800513841.2411.13524607664262048895.stgit@linux.ibm.com>
References: <170800513841.2411.13524607664262048895.stgit@linux.ibm.com>
Subject: Re: [PATCH] powerpc/iommu: Refactor spapr_tce_platform_iommu_attach_dev()
Message-Id: <171377768067.1735812.11531947951932765598.b4-ty@ellerman.id.au>
Date: Mon, 22 Apr 2024 19:21:20 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 07:52:32 -0600, Shivaprasad G Bhat wrote:
> The patch makes the iommu_group_get() call only when using it
> thereby avoiding the unnecessary get & put for domain already
> being set case.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/iommu: Refactor spapr_tce_platform_iommu_attach_dev()
      https://git.kernel.org/powerpc/c/5bd31ab5f79eb6e3bdfa0ca0b57650f9d1604062

cheers

