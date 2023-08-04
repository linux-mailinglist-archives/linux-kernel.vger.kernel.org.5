Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6711B76FC9B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjHDIvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjHDIuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013604C05
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691138963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1Vur9vhFgQMc0z7IU3gYJPoDLW/uQBhNiS46lcgbsys=;
        b=NqTL8Fv6JIjrzlWrA0/skaF5yZgMwZKeGnpzKvpZowPh7x4BlGmy9k36kmjJzeQyZVaF+r
        UaqrY7qEzNRtT3SgJS1cZhKagwGv9nbW//U6m/cdXc0FAnmQBKgpl10oiAnHWL5iZFru07
        WtzSyBRu1BBNiICXl+0JyMDOKznW0Sg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-HTwv9_S3OTS5fMxuhjf3Gw-1; Fri, 04 Aug 2023 04:49:22 -0400
X-MC-Unique: HTwv9_S3OTS5fMxuhjf3Gw-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-560c7abdbdcso2620019eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138961; x=1691743761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Vur9vhFgQMc0z7IU3gYJPoDLW/uQBhNiS46lcgbsys=;
        b=hX4XlVINO+kj6ITU4oZiTmNC850rsaDGOKY3WDzAfAhnvpmJr8TuROSt+7/q4Y2k7d
         UL02s/50JHmkoVHBKz8THPgag34EidBGtSa/0ntepaeVkFXZeexpxKFgisMRYUN3kWyH
         KFH5Q8omlOmtdZsDkS1hWCT6uq+YNte8XzG7wBc6QlfaBsaBcii3ctjCzS8PCtPUYDkP
         Wa6XnLPye1Nqmf49vFZydRyAfH0WZ/INVclQxBPVWwkGMab/9WPZEUCxS3FaVH1l80X6
         9RoP+Z2dg7d7zhS9r6noqQ4bGokzjQuhcIPdWbVjrLQOkAWUYu1jkQUi/xCSlsJoeyt7
         1Gpg==
X-Gm-Message-State: AOJu0YzI5b9YGSDy8N5LRXQmt4nmF5P9zICJT94/6RZW5p4g09YxMC04
        pt6jXAe8bssufTO67YoG4kxZxgFtmUV053Tn+z9HTxeBLrD4Vs3GCKHhB80yi2r+Yfzmfqh47D3
        ABd4koBupDYz89JSHHSxCtK9q+ijcYNXz
X-Received: by 2002:a4a:3947:0:b0:566:f763:8fb7 with SMTP id x7-20020a4a3947000000b00566f7638fb7mr1209711oog.2.1691138960723;
        Fri, 04 Aug 2023 01:49:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+UFfE5kIqjMnJEnmHBbkiyastZJTrRw0+4RxwlYLXQBsPZsV+LE6/4Sbj30UIpvzm+AUyKg==
X-Received: by 2002:a4a:3947:0:b0:566:f763:8fb7 with SMTP id x7-20020a4a3947000000b00566f7638fb7mr1209698oog.2.1691138960284;
        Fri, 04 Aug 2023 01:49:20 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:d380:694f:4f52:764c:4b7f])
        by smtp.gmail.com with ESMTPSA id f8-20020a4ab008000000b0055516447257sm685679oon.29.2023.08.04.01.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:49:19 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [RFC PATCH v3 0/5] Rework & improve riscv cmpxchg.h and atomic.h
Date:   Fri,  4 Aug 2023 05:48:53 -0300
Message-ID: <20230804084900.1135660-2-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Pathes 4 & 5 were compiled-tested, but I could not run-test them yet.

Thanks!
Leo


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
 arch/riscv/include/asm/cmpxchg.h | 393 ++++++++++---------------------
 2 files changed, 195 insertions(+), 362 deletions(-)

-- 
2.41.0

