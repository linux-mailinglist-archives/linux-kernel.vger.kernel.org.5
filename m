Return-Path: <linux-kernel+bounces-16000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2B98236D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBFE287689
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5FA1D554;
	Wed,  3 Jan 2024 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4X7C9t8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E001D545;
	Wed,  3 Jan 2024 20:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB4FC433C7;
	Wed,  3 Jan 2024 20:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704315309;
	bh=3q+VwmOix6aQg6CQ0wgCt1OP44XfMfdBlSVNaMA1U3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4X7C9t85BwGuaYvwuaQPhWFFthcoV7xZGi+Dlkl8CsBytn2DLNGjOtaGE2hcrHRi
	 hJ9gNpiSLPYmHo+3zrtb1+9xWD1nQGObr11KxXHWi7I2ktNsgpERYXiTnfOk4KbHgv
	 Uaj+WM4EvHellN3pglhCqyRrq/Da4HdATZn3euwUoIdHC/H8aavTGWW95ApB7rMzeF
	 xk8usk/S94bHwmcr8jaZwWJmzrhTThpGwQmudRggVPvKm8tUXjgPFf5DcnoggNvVJe
	 n3CP/14znA+hYRORHt42ZAAd42CZ7p/cYYP90HCIOC89oad7xZbUpw+cU2b+GPC6K+
	 3uldmw+GUS2TQ==
Date: Wed, 3 Jan 2024 13:55:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] x86/tools: objdump_reformat.awk: Skip bad instructions
 from llvm-objdump
Message-ID: <20240103205506.GA152662@dev-arch.thelio-3990X>
References: <20231205-objdump_reformat-awk-handle-llvm-objdump-bad_expr-v1-1-b4a74f39396f@kernel.org>
 <20240103181542.GA629234@dev-arch.thelio-3990X>
 <20240103181852.GDZZWlDJMVvqAZdpfV@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103181852.GDZZWlDJMVvqAZdpfV@fat_crate.local>

On Wed, Jan 03, 2024 at 07:18:52PM +0100, Borislav Petkov wrote:
> On Wed, Jan 03, 2024 at 11:15:42AM -0700, Nathan Chancellor wrote:
> > Ping? I am still seeing this issue.
> 
> Does this need a Fixes tag and needs to go to Linus now or are you fine
> with 6.8-rc0?

This is only needed due to the recent changes from Sam and myself in
x86/build, so no need to rush it to Linus. I just wanted to make sure it
was not lost before the chaos of the merge window.

Cheers,
Nathan

