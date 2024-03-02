Return-Path: <linux-kernel+bounces-89464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAAC86F0B1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230892834E5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D07517BD3;
	Sat,  2 Mar 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LO/1jTjv"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA61119A
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709391089; cv=none; b=XwLdUXWeDuVJXSuzxqiC2RfeCiNIzukG+cS8QeueDDXi1tEMHu0yjbUuoCrJkRpaIc0kvUwfcZE4+EYbkTlNxs8hmhNjQmYjD+pglmzUsuuk9t6LCa4WRZo+k/NQXHl/sWbkD0iW6YUWyR76S2ap9AIYnVNqEPzABhifD7ZlY+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709391089; c=relaxed/simple;
	bh=vCjOYdZrlow9Fh9Eo5hPpoetgcXRQ+wgnMSRa8HLqyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRrPfWRqN08E4VcUdoyTngo1yV6hHWxpZeLmeL1hLnBYX3E5d9NuDR1PRx1IUeyBvO0kYaX1LPXHCe2B2qY6YOfcZbY/CNQpZhzGWGibZCwPlwuI+gR+RzfobxyoqvaROxmSmeGeBa+LL4i8gaPGgQAOeXn6KPLY/edMuU6i3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LO/1jTjv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 54CF940E0196;
	Sat,  2 Mar 2024 14:51:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8duGGvQcoF7b; Sat,  2 Mar 2024 14:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709391081; bh=6WUfrxKv6mHowLI4AAR+hzZkx4Uudlh3Fp7Bv1CiWNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LO/1jTjvqHtpHJJoTibVH85FoweayWeRVbS35i8mjLpuOEtcAsaMJGiY+cLRrHYJQ
	 F9InVfcZZ9cGcKSzad4NjfvW/VDQ3ZJP5LkpiclJ8dL7ilUkOK6nB+wnOTUsvGoOBT
	 Jd9ipymrD1LvsNieq2ISzvQZeKRutYO2fAlg+jqk2+x5t3DuyNgKzqsyd6TUK1O+c9
	 QPQ2+TareHk//USpbOmd0foNVC3JqVn7v0A7g8pQWSJcNQeY/Uic67IeMpMwyn4eHe
	 OE8QtgdDjyU3dJ6eNo/JYOflb59drubGTVVLt95ir36KLHStBZfKsbiVBCJgdztlI1
	 t6zR/Gwre0F4zEhxcWwuQbE30X3KF7bcxEjPlyl2iXETRjt1Zmf6jTVgLGykKBJR1M
	 zNOYetk0BkeAliN7ZxP4O2v4R6CMEnPRKz8SiaazFv9v+V0zeqRE0FkNWgOVMNVjx5
	 WfNkbM/ktBn2KRqAWMmtiOdjQ5VBkdw2zeqyamIa7Uiw8oXBRZA5K86gqzPwrnI7sW
	 UaF8abNnwUXjcSmaxMvdvm84lXk0QYTszE3AWQSKHgXTUCU3DDJA6M9g/T00UDPAf2
	 J0tr0toA27Qm8hkAXvJCtKQg43nvx5tB1veMIpfLrBMfB29fkoUukHkJIehcUx5Olx
	 c+AeB76DzVVw+MUymaoa+074=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C30F840E016B;
	Sat,  2 Mar 2024 14:51:09 +0000 (UTC)
Date: Sat, 2 Mar 2024 15:51:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v7 6/9] x86/boot: Move mem_encrypt= parsing to the
 decompressor
Message-ID: <20240302145103.GBZeM81zHoBy922BhE@fat_crate.local>
References: <20240227151907.387873-11-ardb+git@google.com>
 <20240227151907.387873-17-ardb+git@google.com>
 <20240301191640.GNZeIpmAU3iM1EIg4S@fat_crate.local>
 <CAMj1kXHnXRBke1P5nqLwuprJzyKk36bZQPNfwSerAYunvPAzMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHnXRBke1P5nqLwuprJzyKk36bZQPNfwSerAYunvPAzMA@mail.gmail.com>

On Sat, Mar 02, 2024 at 12:46:06AM +0100, Ard Biesheuvel wrote:
> Yeah that seems unnecessary to me. They are only used by kexec, and
> only for cases where you want to kexec a [much] older kernel that
> cannot deal with 5-level paging at all. AFAICT 5-level support was
> added in v4.13.

Yeah, I can't imagine a use case where you'd do two different kernels
- one for normal boot and one for kexec and they'd differ in the .config
and one would support 5level pagetables and the other wouldn't...

> So I think we might be able to drop these entirely, no?

Yeah:

https://lore.kernel.org/r/20240301185618.19663-1-bp@alien8.de


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

