Return-Path: <linux-kernel+bounces-16154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AAC8239BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7AEA287569
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ADA15D4;
	Thu,  4 Jan 2024 00:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2yfrW4Vb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B049A2A;
	Thu,  4 Jan 2024 00:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=TiAiB9M8YbD3b3cX1GLPOOGA6GWJVMdF5A+A3H+oiXA=; b=2yfrW4VbADGreKNe//5WhmlTBz
	5i2DJJTzLwfl3AB+YT21IS4lFtcdUbab6CUXwB3VDec3N5dwTkhqUZiXjR0P8Bk9XWsHvJ2sbQQLG
	DDfgjSEaEC23drpk7mta+gNr9Te527r6nsmVFOyp4pkqb15/GL3kjNw1LiNtoHe5SGp2JKnplwy1/
	hbjbo6poeDfONG0sv4zqdX930WpLWva1O9EeCF+fWVc1ph+1tCBqW7cNw8jY1ZaggCbsySeKGniIg
	Hyxdmjzy8P4Q7RgiuTjytFgSf0VlkTCFJeuGem18ntT+eiBzUM4nf27wTNDxMz4J99f6eCV8haRbd
	bF2tMiWQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLBny-00CVgF-2l;
	Thu, 04 Jan 2024 00:41:50 +0000
Message-ID: <7ed59e89-8222-42b8-a6ce-c104d06b7f32@infradead.org>
Date: Wed, 3 Jan 2024 16:41:49 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] sparc: Fix typos
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, "David S . Miller"
 <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 sparclinux@vger.kernel.org
References: <20240103231605.1801364-1-helgaas@kernel.org>
 <20240103231605.1801364-9-helgaas@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240103231605.1801364-9-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/3/24 15:16, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos, most reported by "codespell arch/sparc".  Only touches
> comments, no code changes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: sparclinux@vger.kernel.org
> ---
>  arch/sparc/include/asm/hypervisor.h     | 6 +++---
>  arch/sparc/include/asm/ldc.h            | 2 +-
>  arch/sparc/include/asm/mmu_context_64.h | 4 ++--
>  arch/sparc/include/asm/switch_to_64.h   | 2 +-
>  arch/sparc/kernel/irq_64.c              | 2 +-
>  arch/sparc/kernel/kprobes.c             | 2 +-
>  arch/sparc/kernel/ldc.c                 | 2 +-
>  arch/sparc/kernel/leon_pci_grpci2.c     | 2 +-
>  arch/sparc/kernel/of_device_64.c        | 2 +-
>  arch/sparc/kernel/pci.c                 | 2 +-
>  arch/sparc/kernel/pci_impl.h            | 4 ++--
>  arch/sparc/kernel/pci_schizo.c          | 4 ++--
>  arch/sparc/kernel/perf_event.c          | 2 +-
>  arch/sparc/kernel/prom_irqtrans.c       | 2 +-
>  arch/sparc/kernel/psycho_common.c       | 2 +-
>  arch/sparc/kernel/signal_32.c           | 2 +-
>  arch/sparc/kernel/signal_64.c           | 2 +-
>  arch/sparc/mm/srmmu.c                   | 2 +-
>  arch/sparc/mm/tsb.c                     | 2 +-
>  arch/sparc/net/bpf_jit_comp_32.c        | 6 +++---
>  20 files changed, 27 insertions(+), 27 deletions(-)
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
#Randy

