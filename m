Return-Path: <linux-kernel+bounces-1980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0108156A5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9461F257AF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E5B20E5;
	Sat, 16 Dec 2023 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uDNlc6XJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4D1C2E;
	Sat, 16 Dec 2023 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=82zrwmhR+WSiATGxdjlJ/weNn8hF4wqGpOHi1ZYIwKQ=; b=uDNlc6XJ0X228zT/xquoAARLOF
	sANu+rBpE5uDGhRWW3UoX1zU8sIdolDXCmFP53G/O21Znj0CpMJL6/OzMv5iUs+Plz1GS8jq1yWCy
	tcp06U6YPs5+1C1g6FCH5XbprT3eXZgTjsOJrowM8OmfE9qH147Arv326CvNaQMO6Vjw1wLA6Ln3b
	UGjnfFHDsWFBvCh1aivmKYBQbC5ZPfohQ2J/QBa5os4n+JyWvbX/oNdomVnBFYdvKedjQVUfj4WU4
	6iAbyXteqbBZf31B432TskxPNNCNA4XWJHb2tggasC31ebbE8K1p3qsl6vVgsncj9/nD+DD3mtOBa
	MuqG7wVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEL6t-0062u3-Dx; Sat, 16 Dec 2023 03:13:03 +0000
Date: Sat, 16 Dec 2023 03:13:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: filemap.c:(.text+0x4960): relocation truncated to fit:
 R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
Message-ID: <ZX0Vv3IyOi+Bp10Q@casper.infradead.org>
References: <202312161000.zSaZMSRO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312161000.zSaZMSRO-lkp@intel.com>

On Sat, Dec 16, 2023 at 10:11:04AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3bd7d748816927202268cb335921f7f68b3ca723
> commit: 2580d554585c52a644839864ef9238af5b030ebc mm: use folio_xor_flags_has_waiters() in folio_end_writeback()
> date:   8 weeks ago
> config: csky-buildonly-randconfig-r002-20220807 (https://download.01.org/0day-ci/archive/20231216/202312161000.zSaZMSRO-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161000.zSaZMSRO-lkp@intel.com/reproduce)

This seems like a general problem with (some configurations of?) csky.
I don't think I've made anything worse.  I don't intend to investigate
this further.

> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312161000.zSaZMSRO-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    mm/filemap.o: in function `folio_end_writeback':
> >> filemap.c:(.text+0x4960): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    filemap.c:(.text+0x4978): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    filemap.c:(.text+0x4990): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    filemap.c:(.text+0x49a2): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    filemap.c:(.text+0x49b8): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    filemap.c:(.text+0x49d2): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    filemap.c:(.text+0x49f2): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    filemap.c:(.text+0x4a0c): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    filemap.c:(.text+0x4a4a): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    filemap.c:(.text+0x4a50): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
>    filemap.c:(.text+0x4a66): additional relocation overflows omitted from the output
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

