Return-Path: <linux-kernel+bounces-15753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05326823150
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5271F24B7E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322C21C287;
	Wed,  3 Jan 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSPoeVl8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026F01C288
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704299553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KyS8wdRUQsy10KBAC5tBoeMUxtC/5Vis4uewibneY24=;
	b=JSPoeVl8mqo3+RLFIe1kDVL4bxfH6IilmHYkzd0ycd6/1BIU7O72k7dDRkYWd4p+PmFkNL
	YgHvpnBa2CyYX6yrCkwNp3NlQrbBgXzFlGVbpr7MZutXpXWSSp7TGiOr+hPpIh23Rqf8LG
	3+azwQr7jt6RhfdUC2qGW2+V8iSlTSo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-OH5fqpaUOaCjhksvzSzjXg-1; Wed, 03 Jan 2024 11:32:32 -0500
X-MC-Unique: OH5fqpaUOaCjhksvzSzjXg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d4bd86416dso10576215ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 08:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704299551; x=1704904351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyS8wdRUQsy10KBAC5tBoeMUxtC/5Vis4uewibneY24=;
        b=gdRHqmZmva25wylttl0wPP/Bu7csVAQinS6gfE/ZAn9UCICiJzAoBafXOOjG1XZuOL
         7cBkHx5yy2fY2ABoJkd63JfJti3nd9IETCN2QvL8gD2NcVgIX81SIh56MBeH4o+0sAUw
         GOWM4sjooZcALdHRYavXkJfbtqiYQzBn9qIxVCYxQc2zLEkdyII4muUgEaTPiKHA7jcV
         Q00HcyEY45B9tg5Ulw6oqERInCW0RCj/8n19qqRHXGyatLFazg2zCdDSoKYa+zuZHFNj
         MVhB5DuD75cqbbF7aChVxA+wyggaLPO3RsTylbTMaIX1YJWKWObP9BI82OAJ0EYxH9pi
         FGDw==
X-Gm-Message-State: AOJu0YxcgTbEqFnakge+x+bhUpRuJGX5FniezMr+Ogn8s2IPe3QM80Gw
	iVZc7DfKHaDmQPt8C6K04xtQvufkcvhTGiwdHbt13Ekf5YvVDnTisV9sESFyNKJrlkjw0TnxWyD
	VnThZqTppj9cCGPR3yI21RWwwxDjcgPhe
X-Received: by 2002:a17:902:db85:b0:1d3:bceb:ba88 with SMTP id m5-20020a170902db8500b001d3bcebba88mr9465701pld.11.1704299551534;
        Wed, 03 Jan 2024 08:32:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+6GSIc7+Qig8DFanxr8PlU4r2+JepKfCBXAeWKp5WEN4cGQRs5a42dQlyEupGQsh2bh8+QQ==
X-Received: by 2002:a17:902:db85:b0:1d3:bceb:ba88 with SMTP id m5-20020a170902db8500b001d3bcebba88mr9465681pld.11.1704299551251;
        Wed, 03 Jan 2024 08:32:31 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7ec:911:6911:ca60:846:eb46])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902b78c00b001cfca7b8ee7sm23930425pls.99.2024.01.03.08.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:32:30 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v1 0/5] Rework & improve riscv cmpxchg.h and atomic.h
Date: Wed,  3 Jan 2024 13:31:58 -0300
Message-ID: <20240103163203.72768-2-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While studying riscv's cmpxchg.h file, I got really interested in
understanding how RISCV asm implemented the different versions of
{cmp,}xchg.

When I understood the pattern, it made sense for me to remove the
duplications and create macros to make it easier to understand what exactly
changes between the versions: Instruction sufixes & barriers.

Also, did the same kind of work on atomic.c.

After that, I noted both cmpxchg and xchg only accept variables of 
size 4 and 8, compared to x86 and arm64 which do 1,2,4,8.

Now that deduplication is done, it is quite direct to implement them
for variable sizes 1 and 2, so I did it. Then Guo Ren already presented
me some possible users :)

I did compare the generated asm on a test.c that contained usage for every
changed function, and could not detect any change on patches 1 + 2 + 3 
compared with upstream.

Pathes 4 & 5 were compiled-tested, merged with guoren/qspinlock_v11 and
booted just fine with qemu -machine virt -append "qspinlock". 

(tree: https://gitlab.com/LeoBras/linux/-/commits/guo_qspinlock_v11)

Latest tests happened based on this tree:
https://github.com/guoren83/linux/tree/qspinlock_v12

Thanks!
Leo

Changes since squashed cmpxchg RFCv5:
- Resend as v1
https://lore.kernel.org/all/20230810040349.92279-2-leobras@redhat.com/

Changes since squashed cmpxchg RFCv4:
- Added (__typeof__(*(p))) before returning from {cmp,}xchg, as done
  in current upstream, (possibly) fixing the bug from kernel test robot
https://lore.kernel.org/all/20230809021311.1390578-2-leobras@redhat.com/

Changes since squashed cmpxchg RFCv3:
- Fixed bug on cmpxchg macro for var size 1 & 2: now working
- Macros for var size 1 & 2's lr.w and sc.w now are guaranteed to receive
  input of a 32-bit aligned address
- Renamed internal macros from _mask to _masked for patches 4 & 5
- __rc variable on macros for var size 1 & 2 changed from register to ulong 
https://lore.kernel.org/all/20230804084900.1135660-2-leobras@redhat.com/

Changes since squashed cmpxchg RFCv2:
- Removed rc parameter from the new macro: it can be internal to the macro
- 2 new patches: cmpxchg size 1 and 2, xchg size 1 and 2
https://lore.kernel.org/all/20230803051401.710236-2-leobras@redhat.com/

Changes since squashed cmpxchg RFCv1:
- Unified with atomic.c patchset
- Rebased on top of torvalds/master (thanks Andrea Parri!)
- Removed helper macros that were not being used elsewhere in the kernel.
https://lore.kernel.org/all/20230419062505.257231-1-leobras@redhat.com/
https://lore.kernel.org/all/20230406082018.70367-1-leobras@redhat.com/

Changes since (cmpxchg) RFCv3:
- Squashed the 6 original patches in 2: one for cmpxchg and one for xchg
https://lore.kernel.org/all/20230404163741.2762165-1-leobras@redhat.com/

Changes since (cmpxchg) RFCv2:
- Fixed  macros that depend on having a local variable with a magic name
- Previous cast to (long) is now only applied on 4-bytes cmpxchg
https://lore.kernel.org/all/20230321074249.2221674-1-leobras@redhat.com/

Changes since (cmpxchg) RFCv1:
- Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build error
https://lore.kernel.org/all/20230318080059.1109286-1-leobras@redhat.com/

Leonardo Bras (5):
  riscv/cmpxchg: Deduplicate xchg() asm functions
  riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
  riscv/atomic.h : Deduplicate arch_atomic.*
  riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2
  riscv/cmpxchg: Implement xchg for variables of size 1 and 2

 arch/riscv/include/asm/atomic.h  | 164 ++++++-------
 arch/riscv/include/asm/cmpxchg.h | 404 ++++++++++---------------------
 2 files changed, 200 insertions(+), 368 deletions(-)


base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
-- 
2.43.0


