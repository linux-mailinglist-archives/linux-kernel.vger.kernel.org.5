Return-Path: <linux-kernel+bounces-120278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B2988D541
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5737C1C23F88
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9CA22EFD;
	Wed, 27 Mar 2024 03:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2+sBsB0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318BD1BF31
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711511636; cv=none; b=quj0b3f25aylqAnnJ/oZXHy1ttDDZPvP7gXOq4MkQSZFoTA7S6lWFuMRbDT/JpZJXRE2xI8E7hkduPwe6IPAtkRb6ylVi5QKa8sGkIm+80JsvW2WCfxzWI5LWxjsyVfmnOPvYZFHGhwa+JfV3+CkXxQ/zFNHxg81elxIB1CY2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711511636; c=relaxed/simple;
	bh=ulvcpLx+NFREbJcC6mgnYfcNd9XXhjYFOTNXexXblnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MabRlXETaMFOHscVuXOv7Z+RfAFhh6vj60GslrLWbxAk+XO9cvQLJeKJgLVl81fMIKP70eBWbAKksA/OEnT6Q0B1Kwc/byLQhCheUBuo9zL5kU+fzG2gT3uMR/QkUaGoDP/g2993ebVcWRfkDpjgpKjjgz9RdKcCJiJQdFEnBEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2+sBsB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3A9C433F1;
	Wed, 27 Mar 2024 03:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711511635;
	bh=ulvcpLx+NFREbJcC6mgnYfcNd9XXhjYFOTNXexXblnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2+sBsB0xMtY8p5K3dNLUlO+HXVhB17rEhtLEjhtbkjM/rzaw9tzkyDKQpeVfA4Y/
	 vVd97axWQEiV2b/o8CWhLqw+mKdtiNn7a+xMd2OVyLbNeO4fwiVV/rgveXW+zK4i3l
	 rPb+LVrV3wuElxqHr4Wm+Rf9W5y6K9YCG7OYduqN+BQw4iLY93RPp3CYo/iG6kUOTu
	 CzmDTlwiTdH60P3HhBwmVyO2oJ7ghs2LO+AXDBUVIukfBE/2PkIbzrsiHPHX7vfxAq
	 iBCtiyAPo0cnhHC3EzacTzcxsetsljU/B+KqC85lxAub7JVbrdRCVX1kcoIuFToOLo
	 kXVsSUjDmnvQw==
Date: Wed, 27 Mar 2024 11:40:37 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Charles Lohr <lohr85@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, cleger@rivosinc.com,
	Conor Dooley <conor@kernel.org>, samuel.holland@sifive.com,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>, ajones@ventanamicro.com,
	dlemoal@kernel.org, Bjorn Topel <bjorn@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH] riscv: deprecate CONFIG_MMU=n
Message-ID: <ZgOVNYkmXbXVCReV@xhacker>
References: <a49546e8-6749-4458-98da-67fd37b7df18@rivosinc.com>
 <mhng-a3b495e6-aca6-4137-a3c1-8fcacafd8596@palmer-ri-x1c9a>
 <ZfLxip96o5MVjHAF@xhacker>
 <ZfL1buKdDI-p5b9X@xhacker>
 <ZgGteKG_a3KGn5wV@xhacker>
 <CAGu26P_tUpSvXqdSz3pOdPNHbe6MyEYJ2XCHo8pD8jeE5pT+_Q@mail.gmail.com>
 <ZgNzBwsmeibHMjvc@xhacker>
 <CAGu26P-CqdsQzNTNDidBUg=pxU3vs7QhNEajokGKe7p8M2sLBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGu26P-CqdsQzNTNDidBUg=pxU3vs7QhNEajokGKe7p8M2sLBA@mail.gmail.com>

On Tue, Mar 26, 2024 at 06:34:09PM -0700, Charles Lohr wrote:
> Sorry, if you don't mind clarifying, do you know which version you
> used, where you got it, and if you had to apply any patches?

Hi,

rv32 uclibc toolchain is based on gcc12.2, while rv64 uclibc is based on
gcc13.2

I built them with the mainline buildroot, and rv32 toolchain was built
a year ago, I forget whether there was patches applied. I may apply
patches from your mini-rv32ima repo. The rv64 toolchain was built a
month ago, no patch is applied.

Thanks
> 
> Charles
> 
> On Tue, Mar 26, 2024 at 6:28 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > On Tue, Mar 26, 2024 at 01:25:08PM -0700, Charles Lohr wrote:
> > > Jisheng, are you using musl or uclibc? I've been having difficulty
> > > getting new versions of each working with the newer kernels with
> > > system calls not lining up.
> >
> > Hi Charles,
> >
> > I tested nommu linux with uclibc, both rv32 and rv64
> >
> > Thanks
> >
> > >

