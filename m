Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F3C76DF96
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjHCFPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjHCFPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D9D1B4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 22:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691039672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tVYxWTkZM5MxAXyW1tcoWD4FZJx006FyKlsgQ2S6vrI=;
        b=H6yrBGOsGeQ2T+rIN8/5dRojqHcyVewHgtSj/GgcOrUzROBUJeGfKsWc9yARBcTbmeDlxJ
        EuPyy+6yCujeHoF1C0AQ2yM9L3FDrAd3r21vJATy33wHG2zUHGOkIQBYQBWYQw43hUO4fS
        C7XoFJWPi6Jb1023SE+qBZoy1XqoMSs=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-Bt9TOWYTNKGjJ99jhYYRRw-1; Thu, 03 Aug 2023 01:14:31 -0400
X-MC-Unique: Bt9TOWYTNKGjJ99jhYYRRw-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a751d44acdso875195b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 22:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691039670; x=1691644470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVYxWTkZM5MxAXyW1tcoWD4FZJx006FyKlsgQ2S6vrI=;
        b=RtEpLnpGfWAy90lVXSYRralYNAyLzySCs+0lUJxLlwdpf7q19WZiv7iYQvzhEU3eqz
         eQ/rvG2PpLadmZzYiFDPAimDFVuFfzHho+Ntr/BjLLIdX/niea1BP2QPFcSXiz2DySEc
         gQw+yeC4yA6O5YLGO+kthGvJ6Ab9MUXl93MjO3JEJCqQu4wAvlNMt2CGIlvzhTRRIKTm
         S2iW2gQKevdwY8EhF2jgFbTiQC8I2ampKQ/ul88Z8Hjr7+HAWd9LtUdjbSTG3i4hS1Ch
         Gql9GyiTi2ANopyJC+12ZFSHPGK46rUAhR10EljVKzorzvbGGVQy8JlYI1LQrmeZwsJ2
         2DrQ==
X-Gm-Message-State: ABy/qLab+Z0zJodQMP/FhapXVllbAEN9XH85wmKy8Ow1gvytsya2BrXL
        SkOCUOHYisACFuGBLTG62Mh9kyWHBzbF8xBR3dwhWAdYYJL91yXaYbympstmmObesSgPUNrjffZ
        KQA8/yPl/l82Hxkhdr1tIYa/cv14BlV74
X-Received: by 2002:a05:6808:1243:b0:3a4:a87:bea1 with SMTP id o3-20020a056808124300b003a40a87bea1mr22621582oiv.21.1691039670627;
        Wed, 02 Aug 2023 22:14:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGHkWZOKBl6mFHadL8uFrpU9XlCOsSVnPSp3iY1y2FAQauWvnIQlW4XqyEz3aKjpwF/O5uLEw==
X-Received: by 2002:a05:6808:1243:b0:3a4:a87:bea1 with SMTP id o3-20020a056808124300b003a40a87bea1mr22621571oiv.21.1691039670356;
        Wed, 02 Aug 2023 22:14:30 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:d380:694f:4f52:764c:4b7f])
        by smtp.gmail.com with ESMTPSA id g51-20020a0568080df300b003a75593746asm1675473oic.57.2023.08.02.22.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 22:14:29 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [RFC PATCH v2 0/3] Deduplicate RISCV cmpxchg.h and atomic.c macros
Date:   Thu,  3 Aug 2023 02:13:57 -0300
Message-ID: <20230803051401.710236-2-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I unified previous patchsets into a single one, since the work is related.

While studying riscv's cmpxchg.h file, I got really interested in
understanding how RISCV asm implemented the different versions of
{cmp,}xchg.

When I understood the pattern, it made sense for me to remove the
duplications and create macros to make it easier to understand what exactly
changes between the versions: Instruction sufixes & barriers.

Also, did the same kind of work on atomic.c.

Note to Guo Ren:
I did some further improvement after your previous reviews, so I ended
up afraid including your Reviewed-by before cheching if the changes are
ok for you. Please check it out again, I just removed some helper macros
that were not being used elsewhere in the kernel.

Thanks!
Leo


Changes since squashed cmpxchg:
- Unified with atomic.c patchset 
- Rebased on top of torvalds/master (thanks Andrea Parri!)
- Removed helper macros that were not being used elsewhere in the kernel.

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


Leonardo Bras (3):
  riscv/cmpxchg: Deduplicate xchg() asm functions
  riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
  riscv/atomic.h : Deduplicate arch_atomic.*

 arch/riscv/include/asm/atomic.h  | 164 ++++++++--------
 arch/riscv/include/asm/cmpxchg.h | 318 +++++--------------------------
 2 files changed, 123 insertions(+), 359 deletions(-)

-- 
2.41.0

