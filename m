Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C96F7F4F62
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbjKVSYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344071AbjKVSY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:24:28 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89BDA2;
        Wed, 22 Nov 2023 10:24:24 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c876f1e44dso1147541fa.0;
        Wed, 22 Nov 2023 10:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700677463; x=1701282263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZqSoai9pFK0GqresiQ3Tq3Y3O3t4JmiFmz/3QD+TGg=;
        b=gMPbJWOhswn5ISVbGiAK1ZoPpQfLNltxl3xPh5Y1dw7c6YC6mLGb3LccFU/ouYcBc1
         qKFg1RcuUmA0fvE+Zbqzpz2EQy9kFqFkAw3Gc+pGPn4q3BPUTyeWsJly9AH5TFQ/haWR
         /o6Y3tNvOjtYDebO8j0d21D3HpKgMSEe2bqt5KDVgMXIfbMzGZzRzvwF+cwTWW1E26Il
         MtDGYMynA+9swiHNksRnuW/S0q+BCwpDFwNDk/TopWBJq88beIgEJDfAaKRSJtnEjq/v
         o+kwo05couMQZowmXcrNnNXEo6rituMManWa10gauE/bJk1KnITwO3d+TN16MPXsLAP1
         jJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700677463; x=1701282263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZqSoai9pFK0GqresiQ3Tq3Y3O3t4JmiFmz/3QD+TGg=;
        b=JJeyuORkNbBqq1/EDfqYxKF08DHm1a0wzu5oqTDkwGpqFhHHA912fRO6pKejWXDSyu
         Fm7pVA3b7NDZ/Rjd8eV45fuM80WKL7/XelyW0BSDyJLiQ0zx0csdCxN5Te5XllrWuaFG
         JFGGrtzrG2Cnlq7HeQqjUuyZk6XY4brK+0jD3x/08OiDlv/HGWr1eX0K5noAq142yUtb
         IixWlPfwTl3pYJDNJUUhqJ/eHR/znJFVDJBPFXpap0jmI1CEew//nnVLX+8/1Ony6BQO
         ud2jTAuZRj6juxfOrmcVJE5xeckaOQOmkxBZO/V2LMrBrjPM/fek14NceBNvFRCFGVxc
         VXoA==
X-Gm-Message-State: AOJu0Yz9e3lX0dR9tOUraB228OFrTJo0Zbl2Tw2SeVzw7POJUpQn+FlQ
        +SSvEAtaAAbi/PSLWFGnqsg=
X-Google-Smtp-Source: AGHT+IEdXztrfEOfr2tODY/5p4eV//O7lSRUCCr4vRo1zq1D8sIg0ukQ4XcMXDtJo1WCQTaJ0w3pkQ==
X-Received: by 2002:a2e:a9a6:0:b0:2c5:8a4:9e6f with SMTP id x38-20020a2ea9a6000000b002c508a49e6fmr2531940ljq.37.1700677462609;
        Wed, 22 Nov 2023 10:24:22 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f16-20020a2e9510000000b002bc3fbe9fd5sm11819ljh.55.2023.11.22.10.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:24:21 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
        Aleksandar Rikalo <arikalo@gmail.com>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yinglu Yang <yangyinglu@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] MIPS: mm: Fix some memory-related issues
Date:   Wed, 22 Nov 2023 21:23:58 +0300
Message-ID: <20231122182419.30633-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just recently I've rebased my MIPS32-related work from kernel 6.5-rc4 onto
the latest kernel 6.7-rc1 and immediately got into a bootup-time
mm-related bug (see patches 3-5 in this series). After fixing it I decided
it was time to submit for review the generic MIPS code fixes which I have
been collecting in my local repo for the last year. I was going to submit
them a bit later after I finished working on a patchset with my SoC
arch-specific changes, but since it was getting bigger and bigger, it
turned to be reasonable to spill out the generic part of series right away
especially seeing it might get to be useful in the most recent kernel.

So this series starts with the MIPS-specific dmi_early_remap()
implementation fix. It is utilized by the DMI driver in the framework of
the dmi_setup() method, which is called at the very early boot stage - in
setup_arch((). No VM available at that stage which is required for the
ioremap_cache() to properly work. Thus it was a mistake to have the
dmi_early_remap() macro-function defined as ioremap_cache(). It should
have been ioremap_uc() in first place.

After that goes a fix for the high-memory zone PFNs calculation procedure
on MIPS. It turned out that after some not that recent commit the
IO-memory PFNs got to the high-memory even though they were directly
reachable, thus should have been left in the normal zone.

Then a series of fixes for the recently discovered mm-bug is presented.
Any attempt to re-map the IO-memory with the cached attribute caused the
bootup procedure to crash with the "Unhandled kernel unaligned access"
message. After some digging I found out that the problem was in the
uninitialized IO-memory pages. Please see the patch "mips: Fix max_mapnr
being uninitialized on early stages" description for the detailed
explanation of the problem and suggested fix. Afterwards I submitted
several cleanup patches for the MIPS/mm and generic mm code.

The patchset is closed with a small improvement which sets the MIPS
board/machine name to the dump-stack module in order to print
arch-personalized oopses in the same way as it's done on ARM, ARM64,
RISC-V, etc.

That's it for today.) Thanks for review in advance. Any tests are very
welcome.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Cc: Aleksandar Rikalo <arikalo@gmail.com>
Cc: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Cc: Chao-ying Fu <cfu@wavecomp.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Yinglu Yang <yangyinglu@loongson.cn>,
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (7):
  mips: dmi: Fix early remap on MIPS32
  mips: Fix incorrect max_low_pfn adjustment
  mips: Fix max_mapnr being uninitialized on early stages
  mips: Optimize max_mapnr init procedure
  mm/mm_init.c: Extend init unavailable range doc info
  mm/mm_init.c: Append '\n' to the unavailable ranges log-message
  mips: Set dump-stack arch description

 arch/mips/include/asm/dmi.h |  2 +-
 arch/mips/kernel/prom.c     |  2 ++
 arch/mips/kernel/setup.c    |  4 ++--
 arch/mips/mm/init.c         | 16 +++++++++-------
 mm/mm_init.c                |  3 ++-
 5 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.42.1

