Return-Path: <linux-kernel+bounces-153158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA5B8ACA69
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CECF9B211ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7620813E401;
	Mon, 22 Apr 2024 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vz2COdOy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g3URnho3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B5E13D50F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781093; cv=none; b=N+8TP69cG1ayZ31Sw+c2doQnaUIkmJ/O2kVJ3+ksS1OpYKZkN1tPfy2+VNMfpZP1YsNlUw2ikNhY1mAhXkn9jGY4OEjb0ECtfmcszMLKMjbEVTdDAexj4JsoqoMvinYc0ZeLdGbX1dUR8wy4BC0SwXsB5a6XqzudI10haXjwyCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781093; c=relaxed/simple;
	bh=5fri6Do1LWefKjpdkdFuwWYG08OOrxumneX2LJURZpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7WjSJYZQT/ZGRLjYjJjcgc9xnfWTlzX03Am4dCfrCYxoEtVYonDNa/ruYgss91sWjW0XpErRStVzbsPSgcdYdQRhLpairbnX7fgxKdbeDO7A+XHskhKEXQ+h9YCaJYkLxUpOMuI4DM1qXA/J8X+gd32DzOhUUBWOGgIl6D5eWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vz2COdOy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g3URnho3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 12:18:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713781090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SEGi5jSmbFvcJ6rHkzMa/iw5xUvXREz8Fj3igLvZIDo=;
	b=Vz2COdOyzc+1o2jJr+YAgI0Rycu3v4MdsLKfW4ILm+Gd0861D+fGU1NpwDflGutA9bHMiV
	8R2RkB6JLbkigRAtvztHmQjxGDd5CaSc9Bs2X6Pw6IrwRWOA007Ah5OkHq2Cug/7XxnpR/
	iSygOCbqsVOryYTogK+YJnRpJIcKWFpC6IpMaqkw31+zFvp1HVLxEJ0IWTw06vt2+g3v9e
	pTn8bZtFKa+pPTjcGGpIn+u5mMT41jVOBzNaafwE/nVIOtuERIS1VOEHkfNjoY1G3CwCe9
	tBDBjAikSZaziPbkhPbdHFHMo4wUvU9w5L1FkMzWk8Bw6iYYiL/U+K/WSAq/Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713781090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SEGi5jSmbFvcJ6rHkzMa/iw5xUvXREz8Fj3igLvZIDo=;
	b=g3URnho3e2OuY0PBfqEYJ+v/Dml5TfM0Zc12WW8MjB11O/bwt/LFJImI0ygj8v2X3b7ttV
	1hIgZ2AXb/KkVwCA==
From: Nam Cao <namcao@linutronix.de>
To: Mike Rapoport <rppt@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Andreas Dilger <adilger@dilger.ca>, Arnd Bergmann <arnd@arndb.de>,
	Changbin Du <changbin.du@huawei.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ingo Molnar <mingo@kernel.org>,
	Krister Johansen <kjlx@templeofstupid.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [init]  b8de39bd1b:
 BUG:kernel_failed_in_early-boot_stage,last_printk:early_console_in_setup_code
Message-ID: <20240422101806.NkNd2Ksz@linutronix.de>
References: <202404221524.4954a009-oliver.sang@intel.com>
 <20240422082942.B750cniQ@linutronix.de>
 <ZiYrdnbw5z1ajeRw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiYrdnbw5z1ajeRw@kernel.org>

On Mon, Apr 22, 2024 at 12:18:46PM +0300, Mike Rapoport wrote:
> The kernel config here has CONFIG_DEBUG_VIRTUAL=y, so __pa translates to
> __phys_addr() in arch/x86/mm/physaddr.c and __pa(-PAGE_SIZE) triggers
> 
> 		VIRTUAL_BUG_ON(y >= KERNEL_IMAGE_SIZE);

RISCV also has a similar thing when CONFIG_DEBUG_VIRTUAL=y

> 
> x86 has __pa_nodebug() that does not do bounds check, but it cannot be used
> in generic code because no other arch except s390 define it.
> 
> For now I don't have ideas how to make this work in the general case, so
> probably we should only fix riscv for now.

Agree, let's just fix riscv for now. This time I will cook up something
safer, no more __pa() on a potentially invalid address.

Best regards,
Nam

