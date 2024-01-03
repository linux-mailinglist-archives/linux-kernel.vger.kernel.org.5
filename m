Return-Path: <linux-kernel+bounces-15759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A2A823159
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D022281A6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1311BDD5;
	Wed,  3 Jan 2024 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+jnOUfC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34F91BDD1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704299694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tH023szvNYa//ZF6grt40ifEfduA6uuUO2rklppqYOI=;
	b=K+jnOUfCcxPw8IhZH2EPFbFYQZ3ctmH6JQP4N9v2CViqJHZxlxyy809JyKfuuksDRtOx2H
	4j3pOUm/O9aRHujvnOWOHuJYdtQlAN9z3WMJ8/46ct82cxxE16/lBMnyLFI/4Ssl5jIsoI
	u/XQs5N6Rl1c8yH/P0PvyFuSPZmDq5c=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-Lw_bKOl-PLa6bjw-SaEG1A-1; Wed, 03 Jan 2024 11:34:53 -0500
X-MC-Unique: Lw_bKOl-PLa6bjw-SaEG1A-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6d9b2360ed7so9716883b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:34:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704299692; x=1704904492;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tH023szvNYa//ZF6grt40ifEfduA6uuUO2rklppqYOI=;
        b=b0xZk0B4Ysm7SxkuXGWjGOcSDwOyHM69XtRb6hBih71+TAiEVpe0m9aRafRMEP8qKf
         oXLFb4UikvprMKM4l0fKx1d3vfHUlJB7ktV3gXqNxAmE28usKLPJgItdch5Oi44Zb/Cg
         cJq1+v+jNt2FKRBkKeKIwcDrOV5ZkwjsbsAtG+sGQ9LNmTe9KhTFr9k2I19YKThEvtFE
         gosgVPTUiBWVe5kL2bEOR25wyCmQSZN56lwIjZSgobpaK3/3xHVVmbhlRLg+PO3PuJA/
         dRvvaGcSxUe6n/LD2EF7v7A6z97XXGqZeyBzerXKqURbkRYUJV/cAtOmU0N6ZoM82SfK
         azFQ==
X-Gm-Message-State: AOJu0Yz8rLvKau74N5XR9j6dtjJU7rHi9uzjvuEr52wWLQnszrnxPTH9
	xe0yMqJmVYtKVBHQBHUaQ4kFLbPZ59pCpVXhnN+2WanMZfHHKe7SU0c69r4f4+L5FIms89Tb4Qe
	AsAEaq3QIlGi2iGHbp0F1BZTMdE2MUAFA
X-Received: by 2002:aa7:8dd7:0:b0:6d9:8ab2:c853 with SMTP id j23-20020aa78dd7000000b006d98ab2c853mr19059087pfr.12.1704299692605;
        Wed, 03 Jan 2024 08:34:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQx6xOcahl7NUiU4wN9Ryq88SdYIolFo1LKNQ3pa9MfnsSS6ZO05u7ru3z4/+N2V4KO+Kelw==
X-Received: by 2002:aa7:8dd7:0:b0:6d9:8ab2:c853 with SMTP id j23-20020aa78dd7000000b006d98ab2c853mr19059071pfr.12.1704299692311;
        Wed, 03 Jan 2024 08:34:52 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id fb27-20020a056a002d9b00b006d9bdc0f765sm16187447pfb.53.2024.01.03.08.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:34:51 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 0/5] Rework & improve riscv cmpxchg.h and atomic.h
Date: Wed,  3 Jan 2024 13:34:43 -0300
Message-ID: <ZZWMox3D2GHX0Tzr@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103163203.72768-2-leobras@redhat.com>
References: <20240103163203.72768-2-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jan 03, 2024 at 01:31:58PM -0300, Leonardo Bras wrote:
> While studying riscv's cmpxchg.h file, I got really interested in
> understanding how RISCV asm implemented the different versions of
> {cmp,}xchg.
> 
> When I understood the pattern, it made sense for me to remove the
> duplications and create macros to make it easier to understand what exactly
> changes between the versions: Instruction sufixes & barriers.
> 
> Also, did the same kind of work on atomic.c.
> 
> After that, I noted both cmpxchg and xchg only accept variables of 
> size 4 and 8, compared to x86 and arm64 which do 1,2,4,8.
> 
> Now that deduplication is done, it is quite direct to implement them
> for variable sizes 1 and 2, so I did it. Then Guo Ren already presented
> me some possible users :)
> 
> I did compare the generated asm on a test.c that contained usage for every
> changed function, and could not detect any change on patches 1 + 2 + 3 
> compared with upstream.
> 
> Pathes 4 & 5 were compiled-tested, merged with guoren/qspinlock_v11 and
> booted just fine with qemu -machine virt -append "qspinlock". 
> 
> (tree: https://gitlab.com/LeoBras/linux/-/commits/guo_qspinlock_v11)
> 
> Latest tests happened based on this tree:
> https://github.com/guoren83/linux/tree/qspinlock_v12
> 
> Thanks!
> Leo
> 
> Changes since squashed cmpxchg RFCv5:
> - Resend as v1

Oh, forgot to mention:
I added some of Reviewed-by that were missing.
Thanks Guo Ren!


> https://lore.kernel.org/all/20230810040349.92279-2-leobras@redhat.com/
> 
> Changes since squashed cmpxchg RFCv4:
> - Added (__typeof__(*(p))) before returning from {cmp,}xchg, as done
>   in current upstream, (possibly) fixing the bug from kernel test robot
> https://lore.kernel.org/all/20230809021311.1390578-2-leobras@redhat.com/
> 
> Changes since squashed cmpxchg RFCv3:
> - Fixed bug on cmpxchg macro for var size 1 & 2: now working
> - Macros for var size 1 & 2's lr.w and sc.w now are guaranteed to receive
>   input of a 32-bit aligned address
> - Renamed internal macros from _mask to _masked for patches 4 & 5
> - __rc variable on macros for var size 1 & 2 changed from register to ulong 
> https://lore.kernel.org/all/20230804084900.1135660-2-leobras@redhat.com/
> 
> Changes since squashed cmpxchg RFCv2:
> - Removed rc parameter from the new macro: it can be internal to the macro
> - 2 new patches: cmpxchg size 1 and 2, xchg size 1 and 2
> https://lore.kernel.org/all/20230803051401.710236-2-leobras@redhat.com/
> 
> Changes since squashed cmpxchg RFCv1:
> - Unified with atomic.c patchset
> - Rebased on top of torvalds/master (thanks Andrea Parri!)
> - Removed helper macros that were not being used elsewhere in the kernel.
> https://lore.kernel.org/all/20230419062505.257231-1-leobras@redhat.com/
> https://lore.kernel.org/all/20230406082018.70367-1-leobras@redhat.com/
> 
> Changes since (cmpxchg) RFCv3:
> - Squashed the 6 original patches in 2: one for cmpxchg and one for xchg
> https://lore.kernel.org/all/20230404163741.2762165-1-leobras@redhat.com/
> 
> Changes since (cmpxchg) RFCv2:
> - Fixed  macros that depend on having a local variable with a magic name
> - Previous cast to (long) is now only applied on 4-bytes cmpxchg
> https://lore.kernel.org/all/20230321074249.2221674-1-leobras@redhat.com/
> 
> Changes since (cmpxchg) RFCv1:
> - Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build error
> https://lore.kernel.org/all/20230318080059.1109286-1-leobras@redhat.com/
> 
> Leonardo Bras (5):
>   riscv/cmpxchg: Deduplicate xchg() asm functions
>   riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
>   riscv/atomic.h : Deduplicate arch_atomic.*
>   riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2
>   riscv/cmpxchg: Implement xchg for variables of size 1 and 2
> 
>  arch/riscv/include/asm/atomic.h  | 164 ++++++-------
>  arch/riscv/include/asm/cmpxchg.h | 404 ++++++++++---------------------
>  2 files changed, 200 insertions(+), 368 deletions(-)
> 
> 
> base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
> -- 
> 2.43.0
> 


