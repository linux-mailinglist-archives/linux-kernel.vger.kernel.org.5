Return-Path: <linux-kernel+bounces-6390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F0881984A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58EB1C2515F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD993101CC;
	Wed, 20 Dec 2023 05:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXkdEhAx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED01FBE1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 05:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703051067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1d5+ro+lqpJiHMWS3NTjfotG8YhvP95BegVyQFgf8g=;
	b=CXkdEhAxjyI8x2D8Fz1qmrJBFcsPryC0wl5FzhhJzdvgksEh2ptIiBAD/Yy36Epc9oUeW2
	HE8Tl77Zz74VHMPTgvAKa+TM+GAiNwLreHJP1NcYj2PqaRdLr7QLU/I5w8wkvrg2M3k+LT
	Q333IhOw2MOQOXQvE62jk4XbCmbyWgY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-yEduL3uBPv-to6JrmQGr1A-1; Wed, 20 Dec 2023 00:44:23 -0500
X-MC-Unique: yEduL3uBPv-to6JrmQGr1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83C5C8350E3;
	Wed, 20 Dec 2023 05:44:23 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 85DE03C25;
	Wed, 20 Dec 2023 05:44:22 +0000 (UTC)
Date: Wed, 20 Dec 2023 13:44:19 +0800
From: Baoquan He <bhe@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: arch/sh/kernel/relocate_kernel.S:38: Error: invalid operands for
 opcode
Message-ID: <ZYJ/M1HZ9ITfs4qe@MiWiFi-R3L-srv>
References: <202312182200.Ka7MzifQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312182200.Ka7MzifQ-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 12/18/23 at 10:55pm, kernel test robot wrote:
> Hi Baoquan,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ceb6a6f023fd3e8b07761ed900352ef574010bcb
> commit: d70c27b728b8da1ab9c3b7ca117ee1c99dc86d29 sh, kexec: fix the incorrect ifdeffery and dependency of CONFIG_KEXEC
> date:   6 days ago
> config: sh-randconfig-r002-20220124 (https://download.01.org/0day-ci/archive/20231218/202312182200.Ka7MzifQ-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312182200.Ka7MzifQ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312182200.Ka7MzifQ-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    arch/sh/kernel/relocate_kernel.S: Assembler messages:
> >> arch/sh/kernel/relocate_kernel.S:38: Error: invalid operands for opcode
>    arch/sh/kernel/relocate_kernel.S:41: Error: invalid operands for opcode
>    arch/sh/kernel/relocate_kernel.S:126: Error: invalid operands for opcode
>    arch/sh/kernel/relocate_kernel.S:129: Error: invalid operands for opcode

I reproduced this error, haven't got why and a way to fix it, will come
back later if I have fix.

> 
> vim +38 arch/sh/kernel/relocate_kernel.S
> 
> 9d44190eae97ad4 kogiidena   2006-01-16   13  
> 9d44190eae97ad4 kogiidena   2006-01-16   14  		.globl relocate_new_kernel
> 9d44190eae97ad4 kogiidena   2006-01-16   15  relocate_new_kernel:
> 9d44190eae97ad4 kogiidena   2006-01-16   16  	/* r4 = indirection_page   */
> 9d44190eae97ad4 kogiidena   2006-01-16   17  	/* r5 = reboot_code_buffer */
> 9d44190eae97ad4 kogiidena   2006-01-16   18  	/* r6 = start_address      */
> 9d44190eae97ad4 kogiidena   2006-01-16   19  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   20  	mov.l	10f, r0		/* PAGE_SIZE */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   21  	add	r5, r0		/* setup new stack at end of control page */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   22  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   23  	/* save r15->r8 to new stack */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   24  	mov.l	r15, @-r0
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   25  	mov	r0, r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   26  	mov.l	r14, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   27  	mov.l	r13, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   28  	mov.l	r12, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   29  	mov.l	r11, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   30  	mov.l	r10, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   31  	mov.l	r9, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   32  	mov.l	r8, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   33  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   34  	/* save other random registers */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   35  	sts.l	macl, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   36  	sts.l	mach, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   37  	stc.l	gbr, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  @38  	stc.l	ssr, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   39  	stc.l	sr, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   40  	sts.l	pr, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   41  	stc.l	spc, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   42  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   43  	/* switch to bank1 and save r7->r0 */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   44  	mov.l	12f, r9
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   45  	stc	sr, r8
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   46  	or	r9, r8
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   47  	ldc	r8, sr
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   48  	mov.l	r7, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   49  	mov.l	r6, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   50  	mov.l	r5, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   51  	mov.l	r4, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   52  	mov.l	r3, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   53  	mov.l	r2, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   54  	mov.l	r1, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   55  	mov.l	r0, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   56  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   57  	/* switch to bank0 and save r7->r0 */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   58  	mov.l	12f, r9
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   59  	not	r9, r9
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   60  	stc	sr, r8
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   61  	and	r9, r8
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   62  	ldc	r8, sr
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   63  	mov.l	r7, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   64  	mov.l	r6, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   65  	mov.l	r5, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   66  	mov.l	r4, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   67  	mov.l	r3, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   68  	mov.l	r2, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   69  	mov.l	r1, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   70  	mov.l	r0, @-r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   71  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   72  	mov.l	r4, @-r15	/* save indirection page again */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   73  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   74  	bsr	swap_pages	/* swap pages before jumping to new kernel */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   75  	 nop
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   76  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   77  	mova	11f, r0
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   78  	mov.l	r15, @r0	/* save pointer to stack */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   79  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   80  	jsr	@r6		/* hand over control to new kernel */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   81  	 nop
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   82  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   83  	mov.l	11f, r15	/* get pointer to stack */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   84  	mov.l	@r15+, r4	/* restore r4 to get indirection page */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   85  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   86  	bsr	swap_pages	/* swap pages back to previous state */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   87  	 nop
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   88  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   89  	/* make sure bank0 is active and restore r0->r7 */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   90  	mov.l	12f, r9
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   91  	not	r9, r9
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   92  	stc	sr, r8
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   93  	and	r9, r8
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   94  	ldc	r8, sr
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   95  	mov.l	@r15+, r0
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   96  	mov.l	@r15+, r1
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   97  	mov.l	@r15+, r2
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   98  	mov.l	@r15+, r3
> b7cf6ddc13186f9 Magnus Damm 2009-03-18   99  	mov.l	@r15+, r4
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  100  	mov.l	@r15+, r5
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  101  	mov.l	@r15+, r6
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  102  	mov.l	@r15+, r7
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  103  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  104  	/* switch to bank1 and restore r0->r7 */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  105  	mov.l	12f, r9
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  106  	stc	sr, r8
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  107  	or	r9, r8
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  108  	ldc	r8, sr
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  109  	mov.l	@r15+, r0
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  110  	mov.l	@r15+, r1
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  111  	mov.l	@r15+, r2
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  112  	mov.l	@r15+, r3
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  113  	mov.l	@r15+, r4
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  114  	mov.l	@r15+, r5
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  115  	mov.l	@r15+, r6
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  116  	mov.l	@r15+, r7
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  117  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  118  	/* switch back to bank0 */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  119  	mov.l	12f, r9
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  120  	not	r9, r9
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  121  	stc	sr, r8
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  122  	and	r9, r8
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  123  	ldc	r8, sr
> 9d44190eae97ad4 kogiidena   2006-01-16  124  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  125  	/* restore other random registers */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  126  	ldc.l	@r15+, spc
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  127  	lds.l	@r15+, pr
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  128  	ldc.l	@r15+, sr
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  129  	ldc.l	@r15+, ssr
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  130  	ldc.l	@r15+, gbr
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  131  	lds.l	@r15+, mach
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  132  	lds.l	@r15+, macl
> 9d44190eae97ad4 kogiidena   2006-01-16  133  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  134  	/* restore r8->r15 */
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  135  	mov.l	@r15+, r8
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  136  	mov.l	@r15+, r9
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  137  	mov.l	@r15+, r10
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  138  	mov.l	@r15+, r11
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  139  	mov.l	@r15+, r12
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  140  	mov.l	@r15+, r13
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  141  	mov.l	@r15+, r14
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  142  	mov.l	@r15+, r15
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  143  	rts
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  144  	 nop
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  145  
> b7cf6ddc13186f9 Magnus Damm 2009-03-18  146  swap_pages:
> 9d44190eae97ad4 kogiidena   2006-01-16  147  	bra	1f
> 9d44190eae97ad4 kogiidena   2006-01-16  148  	 mov	r4,r0	  /* cmd = indirection_page */
> 9d44190eae97ad4 kogiidena   2006-01-16  149  0:
> 9d44190eae97ad4 kogiidena   2006-01-16  150  	mov.l	@r4+,r0	  /* cmd = *ind++ */
> 9d44190eae97ad4 kogiidena   2006-01-16  151  
> 
> :::::: The code at line 38 was first introduced by commit
> :::::: b7cf6ddc13186f9272438a97aa75972d496d0b0a sh: add kexec jump support
> 
> :::::: TO: Magnus Damm <damm@igel.co.jp>
> :::::: CC: Paul Mundt <lethal@linux-sh.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


