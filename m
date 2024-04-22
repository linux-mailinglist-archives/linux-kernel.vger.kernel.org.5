Return-Path: <linux-kernel+bounces-153793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726AD8AD33D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1406D1F21676
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EFE153BE0;
	Mon, 22 Apr 2024 17:20:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F71B153BC6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713806454; cv=none; b=rhzKandtA29EKhhmcJbS/Lluo5ATSkg0G5QnGFts/NboBTTW+Jx2DEH091GyChkrWRkHRyO2lDeJqmQMeP4WKA1tNUbSAXATwbbFQoQcjBD6CVFVD2NGS2c+58kqJtRrUi9AUZxmgNRz9XsqpoWOsNZY2DX0pwLE5yfPKdXmsrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713806454; c=relaxed/simple;
	bh=SlBuGJp6e/gb0sFXKn8EphsybjLeLJHUNFFHJmU3Qeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNvqObFsO/obyWge2xx1cRnYQxfchZ6+6/6MZLSuOx5cfH7qa8SnwE2sZR2Us7rofNIEFKovG7nqFnmQCNuQK+IIzAMrXr2Cq/xPheWhwnTgpkCGnWzqwXsWxSp6yoFkxSroarz2zbIuDiyI4hchqLb8yaJ0+kGLYQCY7kbT44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5DCD339;
	Mon, 22 Apr 2024 10:21:19 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9CDA3F7BD;
	Mon, 22 Apr 2024 10:20:49 -0700 (PDT)
Date: Mon, 22 Apr 2024 18:20:40 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Anders Roxell <anders.roxell@linaro.org>,
	Marc Zyngier <maz@kernel.org>, joey.gouly@arm.com,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: gcc-8: arm64/kvm/pauth.: Error: unknown architectural extension
 `pauth'
Message-ID: <ZiacX2iNP_bI884s@FVFF77S0Q05N>
References: <CA+G9fYsCL5j-9JzqNH5X03kikL=O+BaCQQ8Ao3ADQvxDuZvqcg@mail.gmail.com>
 <ZiYqV-5BWmPwgqbU@FVFF77S0Q05N>
 <cd172d05-15f6-427c-b6e3-d68fc746b940@app.fastmail.com>
 <ZiYwkKLRVgvrQrnK@FVFF77S0Q05N>
 <df782e40-95bf-4f8e-96c8-355ff0109e3a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df782e40-95bf-4f8e-96c8-355ff0109e3a@app.fastmail.com>

On Mon, Apr 22, 2024 at 02:11:05PM +0200, Arnd Bergmann wrote:
> On Mon, Apr 22, 2024, at 11:40, Mark Rutland wrote:
> > On Mon, Apr 22, 2024 at 11:25:25AM +0200, Arnd Bergmann wrote:
> >> On Mon, Apr 22, 2024, at 11:13, Mark Rutland wrote:
> >> > On Mon, Apr 22, 2024 at 02:04:43PM +0530, Naresh Kamboju wrote:
> >> > Given the minimum supported toolchain comes with an assembler that doesn't
> >> > necessarily support ARMv8.3, I reckon we'll either have to make NV pauth
> >> > support depend upon AS_HAS_ARMV8_3, or manually assemble the PACGA instruction.
> >> >
> >> > I suspect the latter is the better option.
> >> 
> >> The .config linked from the report shows
> >> 
> >> CONFIG_AS_VERSION=23101
> >> CONFIG_ARM64_PTR_AUTH_KERNEL=y
> >> CONFIG_AS_HAS_ARMV8_3=y
> >> 
> >> So it gets detected as supporting ARMv8.3. Is this the wrong
> >> conditional to check, or does it get misdetected for an unsupported
> >> assembler?
> >
> > I suspect that means the 'pauth' arch extension was added after armv8.3
> > support, and the assembler supports `-march=armv8.3-a` but does not support
> > `.arch_extension pauth`. So for this code, it'd be wrong to check for
> > AS_HAS_ARMV8_3, unless we used `.march armv8.3-a`, but even then that'd still
> > mean configurations where we couldn't support this code.
> >
> > I reckon manually assembing the PACGA is the best thing to do; that sidesteps
> > the need for either `.arch_extension pauth` or `.march armv8.3-a`, and aligns
> > with what we do for CONFIG_ARM64_PTR_AUTH=y generally.
> >
> > Elsewhere in the kernel where we check for CONFIG_AS_HAS_ARMV8_3, we rely on
> > ARM64_ASM_PREAMBLE containing `.arch armv8.3-a` or a later version that implies
> > the presence of ARMv8.3-A instructions, and so pauth usage elsewhere is fine.
> 
> I tested with the old binutils versions I have here and found
> that anything that supports v8.3 also understands pacga, but
> '.arch_extension pauth' only works in binutils-2.35 and higher,
> presumably because it started out as a v8.3+ feature but was
> later turned into an optional extension for all versions.
> 
> Since there is a Kconfig check for armv8.3-a support already, I think
> it's safe to just drop the .arch_extension pauth.

That'll be safe, but it does mean that we'd need to *not* support pointer auth
for nested virt when we have a toolchain for which CONFIG_AS_HAS_ARMV8_3=n,
unless our minimum supported AS supports ARMv8.3.

If our minimum supported AS *doesn't* support ARMv8.3, then we'd either need a
new Kconfig symbol for NV_PAUTH support, or make CONFIG_ARM64_PTR_AUTH depend
upon CONFIG_AS_HAS_ARMV8_3.

AFAICT our options are:

(a) Manually assembly PACGA

(b) Change CONFIG_ARM64_PTR_AUTH to depend upon CONFIG_AS_HAS_ARMV8_3=y

(c) Add and use new Kconfig symbol for NV PAUTH, dependent upon
    CONFIG_AS_HAS_ARMV8_3=y

(d) Bump the minimum supported version of AS so that we can depend upon ARMv8.3
    support, and just open-code the ".arch armv8.3-a" in the NV pauth code.

.. and maybe some variations on that.

Mark.

