Return-Path: <linux-kernel+bounces-10253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353B981D1C9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598FF1C2279F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95108BEA;
	Sat, 23 Dec 2023 03:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGdw/+Lf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DC08BE0
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 03:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703300881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0MsJ0VeRgA3aYXF/QQZp6FvDWhmY2cf2KWfFSXSqrY=;
	b=QGdw/+LfV1P27aFHw5zzAn1Jm289FymEO+ex7pzDdiL5YNVebTqwqVlfsJ+TXyAZqueKbw
	hcwDt0W5H2XRh0RoLXvXs/fYZMAv8421rLPCx6T4NmfDH1EdKV6Ppot6OI81mmr3m9TbXk
	uQjrGYNUlbdT5IU2mYMIpu7+XASIbh0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-QRtznM-aPbe0rRJ7WzV3Yw-1; Fri, 22 Dec 2023 22:07:57 -0500
X-MC-Unique: QRtznM-aPbe0rRJ7WzV3Yw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ce337ff87fso2408258b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 19:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703300876; x=1703905676;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0MsJ0VeRgA3aYXF/QQZp6FvDWhmY2cf2KWfFSXSqrY=;
        b=D0E77bwRmfkaIzVGHWHFsVJHVP7YdPqk4OKRFJlBhOXTsOdNNYB+fXtbyx8+cxeXAF
         9OEzfZBloxmgfc8tAQeE7AN2uRPE6gPV4FGieiuvPKpWZnL/x48fwB/Fibf0F/LgCMuB
         xf1+pxcS41rao1BnjSN8+MSVuWBTHEmfZn4LFu+GIItRSGX08uzekV1uaeTi7TZDz+Ys
         zVYMtLAc4zB2nJbWGnSigJaHDNbKKunqzEmEtq06sOcW/Aor7nvetQY9TnMDo13Nc+TE
         kiweBaopt95hvm3phuyIZQ4gKbD2EXmGUxDn1GsnHEe0/V3EbUA6WPpesY8Y/n781Acs
         Ho7A==
X-Gm-Message-State: AOJu0Yxmix2l7N7BBq6tAywAyiZnqu440aWVasnjcJmE4fC+SgqZrTAi
	bF5Fac2WApdQIRcK+lAwpWGKj3n/CYwW80D+KMwyNVBGNGzTBZoWZ92DwvWM9ZHziczUglxm9Nf
	Gogr49kY0YfpmuFyZkYKAUzNGpNzsFIk8
X-Received: by 2002:a05:6a20:8e02:b0:194:c0a8:3b5a with SMTP id y2-20020a056a208e0200b00194c0a83b5amr4175661pzj.3.1703300876230;
        Fri, 22 Dec 2023 19:07:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/RAZxdYpWJlUuB5a1DnfRyiqwnMns1rRZevN4BQV3hHyDx9qh/QuarlgRxngT/HMknV8bvg==
X-Received: by 2002:a05:6a20:8e02:b0:194:c0a8:3b5a with SMTP id y2-20020a056a208e0200b00194c0a83b5amr4175638pzj.3.1703300875611;
        Fri, 22 Dec 2023 19:07:55 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ed:60ec:45a7:dfa:5e5:9eed])
        by smtp.gmail.com with ESMTPSA id v5-20020a632f05000000b005c259cef481sm3992876pgv.59.2023.12.22.19.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 19:07:55 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Guo Ren <guoren@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v5 0/5] Rework & improve riscv cmpxchg.h and atomic.h
Date: Sat, 23 Dec 2023 00:07:47 -0300
Message-ID: <ZYZPA-Ugfowk1VXq@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZP2DVap64lJZj9g4@gmail.com>
References: <20230810040349.92279-2-leobras@redhat.com> <ZP2DVap64lJZj9g4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Sep 10, 2023 at 04:50:29AM -0400, Guo Ren wrote:
> On Thu, Aug 10, 2023 at 01:03:42AM -0300, Leonardo Bras wrote:
> > While studying riscv's cmpxchg.h file, I got really interested in
> > understanding how RISCV asm implemented the different versions of
> > {cmp,}xchg.
> > 
> > When I understood the pattern, it made sense for me to remove the
> > duplications and create macros to make it easier to understand what exactly
> > changes between the versions: Instruction sufixes & barriers.
> > 
> > Also, did the same kind of work on atomic.c.
> > 
> > After that, I noted both cmpxchg and xchg only accept variables of 
> > size 4 and 8, compared to x86 and arm64 which do 1,2,4,8.
> > 
> > Now that deduplication is done, it is quite direct to implement them
> > for variable sizes 1 and 2, so I did it. Then Guo Ren already presented
> > me some possible users :)
> > 
> > I did compare the generated asm on a test.c that contained usage for every
> > changed function, and could not detect any change on patches 1 + 2 + 3 
> > compared with upstream.
> > 
> > Pathes 4 & 5 were compiled-tested, merged with guoren/qspinlock_v11 and
> > booted just fine with qemu -machine virt -append "qspinlock". 
> > 
> > (tree: https://gitlab.com/LeoBras/linux/-/commits/guo_qspinlock_v11)
> Tested-by: Guo Ren <guoren@kernel.org>
> 

Hello Guo Ren, thanks for testing!

I will resend this series, and I would like to understand how should I put 
your Tested-by over this patchset:

Is it ok if I add it on each patch of this series?

Thanks!
Leo


> Sorry for late reply, because we are stress testing CNA qspinlock on
> sg2042 128 cores hardware platform. This series has passed our test for
> several weeks. For more detail, ref:
> https://lore.kernel.org/linux-riscv/20230910082911.3378782-1-guoren@kernel.org/
> 
> > 
> > Thanks!
> > Leo
> > 
> > Changes since squashed cmpxchg RFCv4:
> > - Added (__typeof__(*(p))) before returning from {cmp,}xchg, as done
> >   in current upstream, (possibly) fixing the bug from kernel test robot
> > https://lore.kernel.org/all/20230809021311.1390578-2-leobras@redhat.com/
> > 
> > Changes since squashed cmpxchg RFCv3:
> > - Fixed bug on cmpxchg macro for var size 1 & 2: now working
> > - Macros for var size 1 & 2's lr.w and sc.w now are guaranteed to receive
> >   input of a 32-bit aligned address
> > - Renamed internal macros from _mask to _masked for patches 4 & 5
> > - __rc variable on macros for var size 1 & 2 changed from register to ulong 
> > https://lore.kernel.org/all/20230804084900.1135660-2-leobras@redhat.com/
> > 
> > Changes since squashed cmpxchg RFCv2:
> > - Removed rc parameter from the new macro: it can be internal to the macro
> > - 2 new patches: cmpxchg size 1 and 2, xchg size 1 and 2
> > https://lore.kernel.org/all/20230803051401.710236-2-leobras@redhat.com/
> > 
> > Changes since squashed cmpxchg RFCv1:
> > - Unified with atomic.c patchset
> > - Rebased on top of torvalds/master (thanks Andrea Parri!)
> > - Removed helper macros that were not being used elsewhere in the kernel.
> > https://lore.kernel.org/all/20230419062505.257231-1-leobras@redhat.com/
> > https://lore.kernel.org/all/20230406082018.70367-1-leobras@redhat.com/
> > 
> > Changes since (cmpxchg) RFCv3:
> > - Squashed the 6 original patches in 2: one for cmpxchg and one for xchg
> > https://lore.kernel.org/all/20230404163741.2762165-1-leobras@redhat.com/
> > 
> > Changes since (cmpxchg) RFCv2:
> > - Fixed  macros that depend on having a local variable with a magic name
> > - Previous cast to (long) is now only applied on 4-bytes cmpxchg
> > https://lore.kernel.org/all/20230321074249.2221674-1-leobras@redhat.com/
> > 
> > Changes since (cmpxchg) RFCv1:
> > - Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build error
> > https://lore.kernel.org/all/20230318080059.1109286-1-leobras@redhat.com/
> > 
> > Leonardo Bras (5):
> >   riscv/cmpxchg: Deduplicate xchg() asm functions
> >   riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
> >   riscv/atomic.h : Deduplicate arch_atomic.*
> >   riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2
> >   riscv/cmpxchg: Implement xchg for variables of size 1 and 2
> > 
> >  arch/riscv/include/asm/atomic.h  | 164 ++++++-------
> >  arch/riscv/include/asm/cmpxchg.h | 404 ++++++++++---------------------
> >  2 files changed, 200 insertions(+), 368 deletions(-)
> > 
> > 
> > base-commit: cacc6e22932f373a91d7be55a9b992dc77f4c59b
> > -- 
> > 2.41.0
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > 
> 


