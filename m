Return-Path: <linux-kernel+bounces-74129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F229885D045
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63CC1F2442C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FED39FF2;
	Wed, 21 Feb 2024 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKlplEh9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF76339FE0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708495970; cv=none; b=QZNp3cOFAU/qDoCa2jqWbd12qnVur165/ZmQfFpeA2UwUsdBWxEePMnRnFWTVkOOVpLGOcsCo9BNVqStO3EBudLB99gNR52fyV/40wD1+HlN+7DdYiIKbuRmSlpPBHfZCLS2jX0q73u022FiHYGn2zvL68WtHePLknyCpBBMRow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708495970; c=relaxed/simple;
	bh=+a2TXUHgHx9ewr828yRhngPu0FUo2wmIaOoxSHyJyc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrFYs6f2y+9RVn1WovljA9IITUm49wo9NUYFMrkT17KUgkHCy6+BdkEgjWHnv3e+RWF2d8zNu0W6gntCRhm34k/A7rkOTrZf6mTySYg2j8Cj0JtNYBIbJD0Y97cIcxS/bJaba7ew306HpeUD7nmiQPc9t11Hsssox6zOPY3DL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKlplEh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131CCC433C7;
	Wed, 21 Feb 2024 06:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708495970;
	bh=+a2TXUHgHx9ewr828yRhngPu0FUo2wmIaOoxSHyJyc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OKlplEh9sLMQmx9Hl2i/IucT2jZPkZkqUmKau+bypPFQXCBJkoU0q84nYqYGkAkne
	 RM8+aCtQ4agCD/1XSIyO/NFouZXnFYphrGuBsB3Ft83cCfPWCGLvmMgaZO+bSzIS5R
	 E8a6NWAxNuwFRgxZ0836adTGyJW5Vg2JsOxRNLdx5z5Q8RNnSmWtqnSCQdTWGwYG8T
	 /tDxNQcgSfbneLqAQXjL9BlLJQAt/jZv97L3DsZPyGXGSwLoaHbEqkN1oX7oLItycf
	 yHTwKYU84FMuamlGIj9BKTQj7icxsI85MGWE+idKBePbMRuii+DX4dpKes+uQn483V
	 E+ybak4gkvBLw==
Date: Wed, 21 Feb 2024 08:12:14 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	gregkh@linuxfoundation.org, rafael@kernel.org,
	pierre.gondois@arm.com, mingo@redhat.com,
	dave.hansen@linux.intel.com, luto@kernel.org,
	teng.ma@linux.alibaba.com
Subject: Re: [PATCH v1 0/2] support NUMA emulation for genertic arch
Message-ID: <ZdWUPlqsxC_y3YFM@kernel.org>
References: <20231012024842.99703-1-rongwei.wang@linux.alibaba.com>
 <20240220113602.6943-1-rongwei.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220113602.6943-1-rongwei.wang@linux.alibaba.com>

On Tue, Feb 20, 2024 at 07:36:00PM +0800, Rongwei Wang wrote:
> A brief introduction
> ====================
> 
> The NUMA emulation can fake more node base on a single
> node system, e.g.

.. 
 
> Lastly, it seems not a good choice to realize x86 and other genertic
> archs separately. But it can indeed avoid some architecture related
> APIs adjustments and alleviate future maintenance.

Why is it a good choice? Copying 1k lines from x86 to a new place and
having to maintain two copies does not sound like a good choice to me.

> The previous RFC link see [1].
> 
> Any advice are welcome, Thanks!
> 
> Change log
> ==========
> 
> RFC v1 -> v1
> * add new CONFIG_NUMA_FAKE for genertic archs.
> * keep x86 implementation, realize numa emulation in driver/base/ for
>   genertic arch, e.g, arm64.
> 
> [1] RFC v1: https://patchwork.kernel.org/project/linux-arm-kernel/cover/20231012024842.99703-1-rongwei.wang@linux.alibaba.com/
> 
> Rongwei Wang (2):
>   arch_numa: remove __init for early_cpu_to_node
>   numa: introduce numa emulation for genertic arch
> 
>  drivers/base/Kconfig          |   9 +
>  drivers/base/Makefile         |   1 +
>  drivers/base/arch_numa.c      |  32 +-
>  drivers/base/numa_emulation.c | 909 ++++++++++++++++++++++++++++++++++
>  drivers/base/numa_emulation.h |  41 ++
>  include/asm-generic/numa.h    |   2 +-
>  6 files changed, 992 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/base/numa_emulation.c
>  create mode 100644 drivers/base/numa_emulation.h
> 
> -- 
> 2.32.0.3.gf3a3e56d6
> 
> 

-- 
Sincerely yours,
Mike.

