Return-Path: <linux-kernel+bounces-152976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D45828AC701
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6297E281BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820A85029D;
	Mon, 22 Apr 2024 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R82zOWov";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I5N49lT2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951F4F215
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774597; cv=none; b=Q14a+uEPFSMm9nzvKLVid2R38MtspwPaDaOzYDgmOVssyrUEbwYvLkQkSg6nmxjkJRLL/T/9x+OMOLkL0YL+hkxLBneVgVPUzMjnARJZ3MhvHSbsBSRRDAJj7REi9H4q6NtAv2MisTYUbIZ7BisKp3CHyF3rTgyNoc9d+RAhsnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774597; c=relaxed/simple;
	bh=2Q+GsI81RxBSh5dAPRCFKaQzKFMmpan/FzWbPRpm2tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqHQb38Z9aEPWssB6YwZSDypPRLIiti/K1CG+QCnAPQaqkR0qkCLfP1w0PaDxz48qPckZ775G/sTvTbp5l2ZEe68VFrTXvEEDq6F1iwAPMBQGA3FAdi85nfdjx9hjBV0TRJhhKISJK0m4OX7/PF1laP71b217+4H0l2rfuSyzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R82zOWov; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I5N49lT2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 10:29:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713774588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UZ3vNrg6LkJmCfd4kbrlbAp8FYYBh2MPW5kt0SJRSDQ=;
	b=R82zOWovpLq3J+CAZxZbzTag20ooCoG31dk2EEH4hd8xPvX6ZZQKlqNxkhimxnuEjnTpzO
	bNyy70TKiqu097w7KMyqglEpYw/G/ZLzK30kyHS83wF+RFw1iR7+wvEf29vXdHQBG9TP+M
	ZHlRojnwKZuz+Q1q+4n2fpwakwsL0GohjVoHaFPPhS73SGvdu71bRx8G5NvYHqGmn+6OAp
	Q/DiCFLThwBSB+dl/evUOJl8hpwYH4z3JvckjbpNJGYLsqsBk63annj9yQlBdx0V3iIOvV
	KRJs0hf6cGNlti8fwbytEOqPMmhMHNNThuOwvF9iOWvhEWraE4fwqWUCqpXp6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713774588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UZ3vNrg6LkJmCfd4kbrlbAp8FYYBh2MPW5kt0SJRSDQ=;
	b=I5N49lT2OByVQT1BKPOQsV0nwclJE64EgGPSLEe3PVISINltbgol0SNxArVLDuai5ErU6b
	reYFnpMyqv3BUVAA==
From: Nam Cao <namcao@linutronix.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Mike Rapoport <rppt@kernel.org>, Andreas Dilger <adilger@dilger.ca>,
	Arnd Bergmann <arnd@arndb.de>, Changbin Du <changbin.du@huawei.com>,
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
Message-ID: <20240422082942.B750cniQ@linutronix.de>
References: <202404221524.4954a009-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404221524.4954a009-oliver.sang@intel.com>

On Mon, Apr 22, 2024 at 03:45:00PM +0800, kernel test robot wrote:
> kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_printk:early_console_in_setup_code" on:
> 
> commit: b8de39bd1b76faffe7cd91e148a6d7d9bf4e38f7 ("init: fix allocated page overlapping with PTR_ERR")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

I can reproduce the problem. I rebased this commit onto v6.8.7, I can still
observe the problem.

No immediate idea what is the problem. Backtrace from gdb goes crazy:

(gdb) bt
#0  0xffffffffb2074ded in ?? ()
#1  0x00000000000000a1 in ?? ()
#2  0x00000000000000a1 in ?? ()
#3  0x000000007ffff000 in ?? ()
#4  0x00000000543ff000 in ?? ()
#5  0x0000000000000000 in ?? ()

@akpm: drop this commit until this is figured out?

Best regards,
Nam

