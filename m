Return-Path: <linux-kernel+bounces-16171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D93823A0D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 705D3B248BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AC115C8;
	Thu,  4 Jan 2024 01:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eI1+1OYp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125DA29
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IZ7ZWMEa2sCdjlCjcCNyaKulwBAzz/h89Zn0dO8kaI0=; b=eI1+1OYpiEQqQ+kxi8uWVRES77
	bxB/5SKHsU8LifP8OAvkWyjKFzoKFysPt5AQ/NuTC3n4x6tSlAfpI2qwHKhEPn0o6zYZes14R9G2P
	dpjJNtuAgCZhPB975KIOIs9aDnlgKELpFHDSlwnXhmvHyShuEryqBl/F83LiIRq63nHinZeMLbFa+
	6Ww7l1+ZImPhxqq3ij/LpNl2Gr4FqQgR7sWmLiyJTkMb2ZqRDiKe4GjHkht5daEHE0fnR4hiCm6cu
	Kf8BQxI30HbQixaxg3HzOU5ZBncvUsMYkMddSDVjo16mPfOi9wXtPtloC0cn1IWOjDSGx+4xDDgUr
	chQ2xAJw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLCBu-00CY4a-0K;
	Thu, 04 Jan 2024 01:06:34 +0000
Message-ID: <c583752d-c968-4955-894f-547515dd733c@infradead.org>
Date: Wed, 3 Jan 2024 17:06:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] arm64: Fix typos
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
References: <20240103231605.1801364-1-helgaas@kernel.org>
 <20240103231605.1801364-4-helgaas@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240103231605.1801364-4-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/3/24 15:16, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos, most reported by "codespell arch/arm64".  Only touches comments,
> no code changes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/Kconfig                  | 2 +-
>  arch/arm64/include/asm/assembler.h  | 4 ++--
>  arch/arm64/include/asm/cpufeature.h | 4 ++--
>  arch/arm64/include/asm/pgtable.h    | 2 +-
>  arch/arm64/include/asm/suspend.h    | 2 +-
>  arch/arm64/include/asm/traps.h      | 4 ++--
>  arch/arm64/kernel/acpi.c            | 2 +-
>  arch/arm64/kernel/cpufeature.c      | 6 +++---
>  arch/arm64/kernel/entry-common.c    | 2 +-
>  arch/arm64/kernel/entry-ftrace.S    | 2 +-
>  arch/arm64/kernel/entry.S           | 2 +-
>  arch/arm64/kernel/ftrace.c          | 2 +-
>  arch/arm64/kernel/machine_kexec.c   | 2 +-
>  arch/arm64/kernel/probes/uprobes.c  | 2 +-
>  arch/arm64/kernel/sdei.c            | 2 +-
>  arch/arm64/kernel/smp.c             | 2 +-
>  arch/arm64/kernel/traps.c           | 2 +-
>  17 files changed, 22 insertions(+), 22 deletions(-)

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
#Randy

