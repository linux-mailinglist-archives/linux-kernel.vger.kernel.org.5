Return-Path: <linux-kernel+bounces-103548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8BB87C0FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF7AB21FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B285173512;
	Thu, 14 Mar 2024 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bze+eO38"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A15E6F08A;
	Thu, 14 Mar 2024 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432538; cv=none; b=BYAdD+hPkZBvz9dBxpmnoMlkG33BwzSP8ol7S0eZXr1vRGCknpRiqeeAYCKhR2QfKtb6/9vR6q5Fct66UPRynRgTTeb/pKbnmWuyzqX1uTpL/Ne3wJNpPPg7ZFzR/lg/JZcVFSOlFpitPXll5q1uxCy/LRs5e27ZOSZS4LCUOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432538; c=relaxed/simple;
	bh=qU8tcwpg4kZZ303+/A6tP9KvoLsZ4rzx3+wZQQtMyBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBt5h7Mtm6FD4ne/mEZVHhvq/xdLpNpxg8xKpYecHbdrba8Gz3CocJhThTKsVcs+/RO5gVhiHcEQVZ6/YcP9mIWNrGc/DUyWQFQumbs32YbtcJWOlXaZ1M3fPK1TOr5gA1z5dznn4nmcOIfQLeKJ6bnB2GuYHun9aW/aNfanuZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bze+eO38; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5C86C40E0174;
	Thu, 14 Mar 2024 16:08:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iYKy3ge94Yhi; Thu, 14 Mar 2024 16:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710432529; bh=u9nhnnVER2MqsEuiHVV7b+N5w2oLrVMSD1KImKcyqYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bze+eO38mtey/oQO9TE6rC5QYszyNbYqihUCyAmz11U2l0FLDWmeQPh5nSkRVWj5k
	 kk4fvAou9Jyo3bqFZ6YpVfG9krfdXdzSoBinA8p31jm5UlcR1msjpGMg+cS7AJf5A6
	 7PVMNux62VHqCC5m7RwuaMB6Rgb9gOYkZn7UQSIG+ubfDOl8AnOrbXL/c8ViFddWb3
	 GrrcM/2Ixna9slmgbPm9YZNiwdhcquWhH4EnirZ3J9fS97AhzLytZpk+6Lf5ZaJLi7
	 XVdAAAA9rhi5YSsd2j3SELHTdDpuOFrzPnyD5KpR/CdH4m8K631xoNVqMJpCeRw/t7
	 w/w/GnVNFedMNGAYomASXyifuPryU2Uzol8DNgCY2b6H7jeAOenl4LudLjPgmxfMOF
	 fkdSsZwbXuqtj9YX+Cl2gN6Pyt6BMKR+JBat4rA23IqfY1xccD5PdYvUCrB7x8lhGc
	 0t3irVSUWS9nB9v2ZghpQJLQWoHSBItDxoqoowoAs7qjVzwCmRlPHRyHFWKbO4PD3h
	 LgUcyEdUkROWhUtJjXRWRD65NenDiHrfu3rJ/YJW962Yy7ESPU3QNwb0JhDFyuGJzX
	 4BgPdTyWV6Qoeb89EDGC4H2/fFnY8bizj/OV2JfM88ofm2ZAuhxVv7sqtI+1kUaVoS
	 +iuAAdBOEGllWwDoaofW4c2g=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8744640E0028;
	Thu, 14 Mar 2024 16:08:29 +0000 (UTC)
Date: Thu, 14 Mar 2024 17:08:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Vignesh Balasubramanian <vigbalas@amd.com>,
	linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com,
	ebiederm@xmission.com, keescook@chromium.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, bpetkov@amd.com,
	jinisusan.george@amd.com, matz@suse.de, binutils@sourceware.org,
	jhb@freebsd.org, felix.willgerodt@intel.com
Subject: Re: [PATCH 1/1] x86/elf: Add a new .note section containing
 Xfeatures information to x86 core files
Message-ID: <20240314160824.GDZfMg-J1VOyjxIMiV@fat_crate.local>
References: <20240314112359.50713-1-vigbalas@amd.com>
 <20240314112359.50713-2-vigbalas@amd.com>
 <dd54d6de-0bcc-4b2e-a420-b1a429b06246@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd54d6de-0bcc-4b2e-a420-b1a429b06246@intel.com>

On Thu, Mar 14, 2024 at 08:37:09AM -0700, Dave Hansen wrote:
> This is pretty close to just a raw dump of the XSAVE CPUID leaves.
> Rather than come up with an XSAVE-specific ABI that depends on CPUID
> *ANYWAY* (because it dumps the "flags" register aka. ECX), maybe we
> should just bite the bullet and dump out (some of) the raw CPUID space.

Funny you should say that. This was what they had done originally but if
you dump CPUID and you want to add another component in the future which
is *not* described by CPUID, your scheme breaks.

So the idea is to have a self-describing buffers layout, independent
from any x86-ism. You can extend this in a straight-forward way then
later.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

