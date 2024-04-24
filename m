Return-Path: <linux-kernel+bounces-157629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0378B13CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7B2283D99
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66A013B59F;
	Wed, 24 Apr 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iIf1iLAc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C1313A864
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988339; cv=none; b=d+YkVuugBc54trPvoXrfwbyaUTr9hoeXFCEJEamPYOrRVpGjYWSeTrY1KGzug+xSbYKFgyHPgS1FIj1a/oeHlvSbwJojgMt4c9sjx8stBsxPOK2Ipr/E0TLg1Rn38fMdok+E4SKe6wnlgcc2o+y7CQ2kk2mWO9xsXw3YO1U9fc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988339; c=relaxed/simple;
	bh=OEUC2mG2HoVkCMpXGy6hcCMCUEUM1JF3EnAfQaO8yb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT5mioDXZH3jIjkeIAXzv6ip5HnUyc0F6FTuBAwqdWvudKKQe0bOdCxYVYagwzGpCx+62ebtOfWDERptbqs5ZhWTer1FJ6zCAaAnYEncjlaK84vKvCmLV8PFfLe2Cvsx7CZFZzfpfPEe0ztVXZcQDJBu/3QmlkU2XcOu23UiAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iIf1iLAc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 24B7A40E0249;
	Wed, 24 Apr 2024 19:52:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bWou7kdspDYi; Wed, 24 Apr 2024 19:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713988330; bh=76E5+GlxOaXqSLlg3LeqXjnwLuK+EterfPATQfb8pYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iIf1iLAcv0qrRNjafwCjeSkVr5q8TcZsE7rY70geQkkVCzL/+WjqHVoDLfXv4rF1Y
	 2HG1XLotN8mblmcWo9kFtQ4rqdbfYIhnQOIIBbRU6IjmAc2/4ON43Tr7ZCiSr62tn/
	 Six/He7bGAwzKYmXjeIwYi4YMuDzBjegK39Io1zVUVzWWbuuXV5Lx9kr8XFmFKuv4R
	 qkSKHicMTwbK9W6aMYaKQwFWOS58JjJAOSbJ0DDWhxQo+wKpcwQ1/5ddt4zGTKiwL9
	 lfycIX/s+tRbyRDAE46+LcjDdG+W8KidbAWXrqRW4hDNIwQ7aQvK0giD3ICyKpFRPq
	 ZF2kxXQJ1DhIyDrcaMDb8gDt8mrqmmqKr9KMzeA4yA/XgY/fLVpi8GRTt8QTIRDzGK
	 w95Ren6nBN/MqQPUwnWskMGVOpuKIQ9D6Xlm3bryD/YIVkOcLpjzIVqbqqOPp+nsrd
	 GI6zK7yMzkqHTcbZt6fZ4GIMw/rjCBPPFujdk2eO38CTb+bKEu6G4JM509lXMpflPR
	 OPCxDHB/WKExaSZU+4oz9cyR959Vykuh5CoaSCDp15EFizjWowfKa570J8gHBVpb0v
	 FHJt7T6M4M3nhdBTmbvmCb/eIYDysKqfz6MqOrxt/A5625avyqu7k7JRYTjECQsVJG
	 kU0v4kkgrmMfObO9u18Fc/Fw=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E7FE940E016B;
	Wed, 24 Apr 2024 19:52:02 +0000 (UTC)
Date: Wed, 24 Apr 2024 21:51:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Paul Gortmaker <paulg@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: Intermittent Qemu boot hang/regression traced back to INT 0x80
 changes
Message-ID: <20240424195157.GGZili3b-AxmUDlipA@fat_crate.local>
References: <20240424185806.GB101235@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240424185806.GB101235@kernel.org>

On Wed, Apr 24, 2024 at 02:58:06PM -0400, Paul Gortmaker wrote:
..
> pci 0000:00:1d.0: [8086:2934] type 00 class 0x0c0300 conventional PCI endpoint
> pci 0000:00:1d.0: BAR 4 [io  0xc080-0xc09f]
> pci 0000:00:1d.1: [8086:2935] type 00 class 0x0c0300 conventional PCI endpoint
> pci 0000:00:1d.1: BAR 4 [io  0xc0a0-0xc0bf]
> pci 0000:00:1d.2: [8086:2936] type 00 class 0x0c0300 conventional PCI endpoint
> <hang - not always exactly here, but always in this block of PCI printk>

How would those commits have anything to do with such an early hang?!

Nothing that early is issuing INT80 32-bit syscalls, is it?

Btw, can you checkout the Linus tree at...

f35e46631b28 Merge tag 'x86-int80-20231207' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
f4116bfc4462 x86/tdx: Allow 32-bit emulation by default


<-- here and test that commit as the top one?

55617fb991df x86/entry: Do not allow external 0x80 interrupts 

which reminds me - that hang could be actually that guest kernel
panicking but the panic not coming out to the console.

When it hangs, can you connect with gdb to qemu and dump stack and
registers?

Make sure you have DEBUG_INFO enabled in the guest kernel.

Is this even a guest?

I know you had guests last time you reported the alternatives issue.

Right, and then test the tree checked out at this commit:

be5341eb0d43 x86/entry: Convert INT 0x80 emulation to IDTENTRY

The others should be unrelated...

b82a8dbd3d2f x86/coco: Disable 32-bit emulation by default on TDX and SEV

Hmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

