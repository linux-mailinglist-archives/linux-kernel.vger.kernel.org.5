Return-Path: <linux-kernel+bounces-16148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DFF8239AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1032871F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5687641;
	Thu,  4 Jan 2024 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ikxh+Mtb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F83364
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=TIrs4SVN4sRDCoR2FH1y2ydUgyXfkIj7iu/mUg4qpdk=; b=Ikxh+Mtbz4GAUdOd1bXxWWLrlB
	pGSr9SZaGlzzVkrssTh0BnOyVHZoapyzpE5XBIamNL8v45hj/wCVhQzr8Pr8ZCiQN4aP5MZvJa1uH
	B6AWmGpbuip67N10bR60c/8xmEx6101/vB/+b2M74ksqusrgD7jRMHapo2gkpODYvyRHRjJ7EcSQG
	bvpto/NSjrsJatdFEnMlBeEiWFUdWx4IrLf47b/t8HOHEPnShXnFnVF4UdHWbyHvELHS8YfGI4l5i
	pCJwfhx/sP6+69Z+51bWTSnRl9vKC3SvSSXkWBaTIv/cM/Q2vnE5ghdX5/Dfcqpj08Tua9zOgBJNY
	pyvbuIzQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLBjK-00CV87-0P;
	Thu, 04 Jan 2024 00:37:02 +0000
Message-ID: <e3dcf2f8-85dc-4adc-b917-af494a829499@infradead.org>
Date: Wed, 3 Jan 2024 16:37:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] powerpc: Fix typos
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.ozlabs.org
References: <20240103231605.1801364-1-helgaas@kernel.org>
 <20240103231605.1801364-8-helgaas@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240103231605.1801364-8-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/3/24 15:16, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos, most reported by "codespell arch/powerpc".  Only touches
> comments, no code changes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/boot/Makefile                   |  4 ++--
>  arch/powerpc/boot/dts/acadia.dts             |  2 +-
>  arch/powerpc/boot/main.c                     |  2 +-
>  arch/powerpc/boot/ps3.c                      |  2 +-
>  arch/powerpc/include/asm/io.h                |  2 +-
>  arch/powerpc/include/asm/opal-api.h          |  4 ++--
>  arch/powerpc/include/asm/pmac_feature.h      |  2 +-
>  arch/powerpc/include/asm/uninorth.h          |  2 +-
>  arch/powerpc/include/uapi/asm/bootx.h        |  2 +-
>  arch/powerpc/kernel/eeh_pe.c                 |  2 +-
>  arch/powerpc/kernel/fadump.c                 |  2 +-
>  arch/powerpc/kernel/misc_64.S                |  4 ++--
>  arch/powerpc/kernel/process.c                | 12 ++++++------
>  arch/powerpc/kernel/ptrace/ptrace-tm.c       |  2 +-
>  arch/powerpc/kernel/smp.c                    |  2 +-
>  arch/powerpc/kernel/sysfs.c                  |  4 ++--
>  arch/powerpc/kvm/book3s_xive.c               |  2 +-
>  arch/powerpc/mm/cacheflush.c                 |  2 +-
>  arch/powerpc/mm/nohash/kaslr_booke.c         |  2 +-
>  arch/powerpc/platforms/512x/mpc512x_shared.c |  2 +-
>  arch/powerpc/platforms/cell/spufs/sched.c    |  2 +-
>  arch/powerpc/platforms/maple/pci.c           |  2 +-
>  arch/powerpc/platforms/powermac/pic.c        |  2 +-
>  arch/powerpc/platforms/powermac/sleep.S      |  2 +-
>  arch/powerpc/platforms/powernv/pci-sriov.c   |  4 ++--
>  arch/powerpc/platforms/powernv/vas-window.c  |  2 +-
>  arch/powerpc/platforms/pseries/vas.c         |  2 +-
>  arch/powerpc/sysdev/xive/common.c            |  4 ++--
>  arch/powerpc/sysdev/xive/native.c            |  2 +-
>  29 files changed, 40 insertions(+), 40 deletions(-)

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
#Randy

