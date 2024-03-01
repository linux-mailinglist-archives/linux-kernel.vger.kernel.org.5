Return-Path: <linux-kernel+bounces-88667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D5886E503
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B0B281E4E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054B770CA2;
	Fri,  1 Mar 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FXa9jwDd"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9695A41C7A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309386; cv=none; b=HVhI0AibMXVUIRLJ0hTho3CGvo3l31j4XGOQS+TlfuZqoT6Z6dqkXhBNnYIMujUncR3Kq1jTTOFZByTlUR9u7Bkj13v3HRSy4MwooOpgxmYDornp2gOUreaaafZjUalaHegGkz0zrM/i4flqZiSIXsptoAYoviBdOeAIPvuck0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309386; c=relaxed/simple;
	bh=wuaOF7NM7A52qdXVIffLyq03NktimzJGcxFU0cLJJV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf4sDF+DGZU8AibVi/bYCUVWTlwPPjKCyibh6wBjqcdNxEMaSdFyrarvIqyVoq6HQOY9UZ5ZmRn39/yxAsJ+qo2XBcd7MvO57Vq9VjKeZlrHZDbc8KOXzjB8WbULMXE/E7sKX2mMxSO00rrxno6hApOHNnMOUJyI7JVVTmVQIMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FXa9jwDd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BB4F740E016C;
	Fri,  1 Mar 2024 16:09:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HvQrcp6GYxZS; Fri,  1 Mar 2024 16:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709309378; bh=aKVoLLI39CDmvAETXr4vvNP2F5orRZdabZkOxPl3r2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FXa9jwDdUJpUQZb6+EGIoDwZZRyUUjUxnKfB+skNdcoYBqVORFa8IFSRC7LhQj0iO
	 KYJgTOHYTAuzaVygBGWFjUKA+eIMeOnpLRHZrDPAZWX1yqgQN5zZ838UKuG3moz2lZ
	 OEv1lfR1VjNSJZYo2oVAsIp6JdWlJ/PeLByFE9sejPH/UY/rhyoVWYzK4PRvIaAIoF
	 LzYO1LpTGVc/DcaJzKETo9/ZuJYSgDl1tI2GzcBFek8QxQS7IZemAI/2Dg+5+eEyJM
	 3wlY/kdhhrdzvYEorJhDDfw4zpEULxgEBbJP4UfczKcHQEJlMhBvHGR4hGNTKqIrzd
	 BpEY42ogGn3jNz35lFYGv3IxLwHqw07o+Wpb8gJa0sjZidiTncHV0ARqPtaSkANeoS
	 EvQXqOONfHKQZQyH21KJiFfyh70UaiH6XQZxLDuJclUr1hpPvUUop5hCwDw0z3ixv+
	 vyqJCJLN04jiB/KwumUnUfrjQa4esJHISZ5jvGtBy1eTQEXZ+HROLbSseMSV8bI8F1
	 Efg1x+paT0UykSehmFo6+2OTe9pr2x+xBcg7mh5EtxmIyvbGeUFYwbZ2+sUOxJyBnV
	 KhKc2XEvzlWtGH4DHLq21Rd+gQupPtfG6XpjVBdmcDjBCaq7DRjYRqexMr0CxIoKHS
	 V63bw0o6FUpLQsH4CT2lG/bQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F49F40E00B2;
	Fri,  1 Mar 2024 16:09:27 +0000 (UTC)
Date: Fri, 1 Mar 2024 17:09:21 +0100
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
Subject: Re: [PATCH v7 2/9] x86/startup_64: Defer assignment of 5-level
 paging global variables
Message-ID: <20240301160921.GBZeH9sZhp73xX40ze@fat_crate.local>
References: <20240227151907.387873-11-ardb+git@google.com>
 <20240227151907.387873-13-ardb+git@google.com>
 <20240228205540.GIZd-dzFYIBbtfIAo3@fat_crate.local>
 <CAMj1kXGhZU+FE2gE262Q8_vZEFHicsRtVPzXT-dhhCvBuiMjUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGhZU+FE2gE262Q8_vZEFHicsRtVPzXT-dhhCvBuiMjUA@mail.gmail.com>

On Fri, Mar 01, 2024 at 11:01:33AM +0100, Ard Biesheuvel wrote:
> The scenario that I have not managed to test is entering from EFI with
> 5 levels of paging enabled, and switching back to 4 levels (which
> should work regardless of CONFIG_X86_5LEVEL). However, no firmware in
> existence actually supports that today, and I am pretty sure that this
> code has never been tested under those conditions to begin with. (OVMF
> patches are under review atm to allow 5-level paging to be enabled in
> the firmware)

Aha.

> I currently don't have access to real hardware with LA57 support so
> any additional coverage there is highly appreciated (same for the last
> patch in this series)

Right, I'm sure dhansen could dig up such a machine. We'll ask him
nicely to test when the set is ready.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

