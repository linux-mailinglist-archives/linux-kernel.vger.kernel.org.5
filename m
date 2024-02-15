Return-Path: <linux-kernel+bounces-66938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE058563D2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0ECA1F261CB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B506C12F39F;
	Thu, 15 Feb 2024 12:59:51 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F314E12AAF7
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001991; cv=none; b=P1j+mHKi4dhEe8F9zoYD6crR3u6JSWvtlm7MjZJWKewtoFRueFXdvit18/F343dBf5BOf0dk7I9D+eQJFPmt/515UiaBdNrV+Lz2Qi7fy35N1C6fZOz6ZIbPbI5+rGlLrnDxz6n5+2EAYhXlXzXr1bDUhdykV2YLCGymtiRE7vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001991; c=relaxed/simple;
	bh=BeseEII+BLc7HUJKKJ15XTbIZgrYNFV6oOVv+Y6dKCw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZxTpkaZZ73gzLmNJfFqtuQ6PrV2Qankoi/HnHIHxh15yNv5Ne4NM10Hk6zfy58bU9TAiB1TLJYPpxb9B0eH/t6hpjKaDbWyRNOyHJdwqxAGDEtJM1rOe1Is1bGvxCePG3iA1wx3Gy43C35Yp4CPnvIfbdIr+s3d+fubxOjGs5Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TbFX04KqWz4wcl;
	Thu, 15 Feb 2024 23:59:44 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240123125148.2004648-1-arnd@kernel.org>
References: <20240123125148.2004648-1-arnd@kernel.org>
Subject: Re: [PATCH 1/2] powerpc: udbg_memcons: mark functions static
Message-Id: <170800185782.599237.10144713450060322836.b4-ty@ellerman.id.au>
Date: Thu, 15 Feb 2024 23:57:37 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 13:51:41 +0100, Arnd Bergmann wrote:
> ppc64_book3e_allmodconfig has one more driver that triggeres a
> few missing-prototypes warnings:
> 
> arch/powerpc/sysdev/udbg_memcons.c:44:6: error: no previous prototype for 'memcons_putc' [-Werror=missing-prototypes]
> arch/powerpc/sysdev/udbg_memcons.c:57:5: error: no previous prototype for 'memcons_getc_poll' [-Werror=missing-prototypes]
> arch/powerpc/sysdev/udbg_memcons.c:80:5: error: no previous prototype for 'memcons_getc' [-Werror=missing-prototypes]
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc: udbg_memcons: mark functions static
      https://git.kernel.org/powerpc/c/5c84bc8b617bf90e722cc57d447abd9a468d3a52
[2/2] powerpc: 85xx: mark local functions static
      https://git.kernel.org/powerpc/c/1c57b9f63ab34f01b8c73731cc0efacb5a9a2f16

cheers

