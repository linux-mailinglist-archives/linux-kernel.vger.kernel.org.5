Return-Path: <linux-kernel+bounces-52885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A7F849DD3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2DC1F23DE8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1353A8F9;
	Mon,  5 Feb 2024 15:19:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07313A1A6
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146398; cv=none; b=tVCooiJdUYk6VFTf42xY5i9StF2xEkpxg9vKNVQzU91g52QxO/6jdfymbJWNYXszMdxb6O82z5XGHZUtDKfq/vYrnAlxwyi/cyhoNpjfeW7jppC8UmH3DV3Tv0kQyFG4J8ynaWvxGMEOjR0vz2U+vK7Smo1VpNs3Imp198oBfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146398; c=relaxed/simple;
	bh=Tp9mtZuUMtWUy7r01PjjTtYAHa5CzgjrkHr/jKLUm0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUpq3IjI6i1pSHYYRIwVRQ7QkSxitbxwOf/hlPVaqhUQif+GoFxSsiMXtYv07FlYKOTyms9YG//ZYNNUvVajJuWwa6zwe+qsDCemfZRFJjGrieq6DoXSasMF5/oRlLRRKGhrd1JRR+s98sQn+jVyLHANEIpJStU/ZpJSAs+pAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9E541FB;
	Mon,  5 Feb 2024 07:20:38 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 065833F5A1;
	Mon,  5 Feb 2024 07:19:54 -0800 (PST)
Date: Mon, 5 Feb 2024 15:19:47 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Fangrui Song <maskray@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>,
	Peter Smith <peter.smith@arm.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: jump_label: use constraints "Si" instead of "i"
Message-ID: <ZcD8k2UTs3wyk9Dx@e133380.arm.com>
References: <20240201223545.728028-1-maskray@google.com>
 <Zb0Qu5lR0iZUqImb@e133380.arm.com>
 <CAMj1kXGSQ4Xq68Cmq6BH37FPJ+R+N5cOfrdC+aVML4sGaNDopg@mail.gmail.com>
 <Zb0eRogn3rjkeDAs@e133380.arm.com>
 <20240202225104.f4dsagfwf6gcnddy@google.com>
 <CAMj1kXGN-nKSzxJoyM9peBTDevuPkH-+P2UzH746P-F913Dg-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGN-nKSzxJoyM9peBTDevuPkH-+P2UzH746P-F913Dg-g@mail.gmail.com>

On Sat, Feb 03, 2024 at 10:50:44AM +0100, Ard Biesheuvel wrote:
> On Fri, 2 Feb 2024 at 23:51, Fangrui Song <maskray@google.com> wrote:

[...]

> > "Si" is fine for GCC and Clang.
> > "i" is fine for Clang but not for GCC PIC.
> >
> >      https://maskray.me/blog/2024-01-30-raw-symbol-names-in-inline-assembly#aarch64
> >
> >      In gcc/config/aarch64, LEGITIMATE_PIC_OPERAND_P(X) disallows any symbol
> >      reference, which means that "i" and "s" cannot be used for PIC. Instead,
> >      the constraint "S" has been supported since the initial port (2012) to
> >      reference a symbol or label.
> >
> > I am also not familiar with
> > https://gcc.gnu.org/onlinedocs/gcc/Multi-Alternative.html (comma in a
> > constraint string). Thankfully we don't need this powerful construct:)

Ack, I had thought that this was relevant, but it is not,
and "Si" seems right.

[...]

> > I am convinced by Ard' argument that two inputs (key, branch) deserve
> > two operands.
> > The existing "i"(&((char *)key)[branch]) is kinda ugly and also longer:)
> 
> If it helps clarify things, we might do something like
> 
> ".quad  (%[key]  - .) + %[bit0]"
> 
> : : [key]"Si"(key), [bit0]"i"(branch) :  : l_yes);

I don't have a strong opinion on the naming, but something like this
seems fine.

Cheers
---Dave

