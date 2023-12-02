Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F50801C5B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 12:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjLBLOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 06:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjLBLOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 06:14:40 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D2C194;
        Sat,  2 Dec 2023 03:14:46 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c9c18e7990so39412951fa.2;
        Sat, 02 Dec 2023 03:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701515684; x=1702120484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkjKzmOgBIAZEWmOEC5zndYMsC69jtjEuyfNzanPv9Q=;
        b=aIb1a2xlanRmJRQvfu0w/i9I6vTTO1xFVMxukOV9B8j2sWy3du/kUImAQQOKk/qnKA
         ocq0vTx5jrjBQ13lhz801ZgLE0HBQuguhLymIi6R1BpgDXzEnJBTHSQfjuDort9xodWX
         R3NxSWc9oFmGLDTlFzh41u7JUWr5yDEAVQvNebbTgXTwq9hHiSpzo19ml860IHA3Jp9F
         8k60/H6ljjWZ66hpZtUoIJGnKyomshXvILEC/mIriE8PlyknzC3P/0I5jKMdhnz4WASd
         wgV2wlQM3tXhfY5CMHiGW3Ujb3zoXjz9kbdIzoUXhsO7n6BZSRPgUrzjJ5GA1v2PsxPY
         tgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701515684; x=1702120484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkjKzmOgBIAZEWmOEC5zndYMsC69jtjEuyfNzanPv9Q=;
        b=HMwu9OiGAg9+qgXPjuAiovKbmMp//IgcvmJ6DcZfSDQ8gVYVtzaWIy22OvPJZMedTt
         cQwQCDYWaWyrJxg9zUOphmbfdRSrX4kE7RxKWiVdzyoRapmHSRUBaNt41B3I4fv72TpO
         SbFSRBL+DJKLLi5IqqWzlViO37cy6lTs3Yl2+B19lLqhqof2q8yOb9RjoAi8dAmsXCjZ
         6DsOvcxiO3IUchh38zY7fiewQ2W3IRxjmCnXijsZattbodiwEF95kOOnFoKvd4jLtE+4
         D8YJ3RW2nsfNH5pYsakx2yP48qXispwtljGmMn9w2w9Gd4OQYldV85cm5TGyR+ZjoXXY
         WCMQ==
X-Gm-Message-State: AOJu0YzEc4dj2qUqfNWSFpf9LaATDK+zDUaKpkaG2iXlWjjvjV7+rhwq
        D8L1tekPSiZS13u393g6TxU=
X-Google-Smtp-Source: AGHT+IHA6+EuRkpkyQ96D47YDeUbDMbpN9C7dhAq1xKmSnGXQA8pEXs0hCR4j4mKPT0f09fQoTKiOg==
X-Received: by 2002:ac2:5a46:0:b0:50b:c4e3:b601 with SMTP id r6-20020ac25a46000000b0050bc4e3b601mr1409652lfn.66.1701515684172;
        Sat, 02 Dec 2023 03:14:44 -0800 (PST)
Received: from localhost ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id o12-20020ac24e8c000000b0050bbf6b1f74sm690720lfr.232.2023.12.02.03.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 03:14:43 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yinglu Yang <yangyinglu@loongson.cn>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
        Aleksandar Rikalo <arikalo@gmail.com>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Baoquan He <bhe@redhat.com>, Chao-ying Fu <cfu@wavecomp.com>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] mips: dmi: Fix early remap on MIPS32
Date:   Sat,  2 Dec 2023 14:14:18 +0300
Message-ID: <20231202111430.18059-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231202111430.18059-1-fancer.lancer@gmail.com>
References: <20231202111430.18059-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dmi_early_remap() has been defined as ioremap_cache() which on MIPS32 gets
to be converted to the VM-based mapping. DMI early remapping is performed
at the setup_arch() stage with no VM available. So calling the
dmi_early_remap() for MIPS32 causes the system to crash at the early boot
time. Fix that by converting dmi_early_remap() to the uncached remapping
which is always available on both 32 and 64-bits MIPS systems.

Note this change shall not cause any regressions on the current DMI
support implementation because on the early boot-up stage neither MIPS32
nor MIPS64 has the cacheable ioremapping support anyway.

Fixes: be8fa1cb444c ("MIPS: Add support for Desktop Management Interface (DMI)")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Note even though this patch is fully correct from the current
ioremap()-based semantics point of view and shall fix the denoted problem,
Jiaxun thinks that it's better to provide a different fix since
dmi_early_remap() doesn't work correctly on even Loongson64 - the only
currently DMI-equipped platform. In v1 discussion he promised to provide a
better fix for the problem. Until then let's consider this patch as the
only currently available solution.

Changelog v2:
- Replace ioremap_uc() with using ioremap() due to having the former one
  deprecated. (@Arnd)
- Extend patch log with a note regarding the unsynched caches concern.
  (@Jiaxun)
---
 arch/mips/include/asm/dmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/dmi.h b/arch/mips/include/asm/dmi.h
index 27415a288adf..dc397f630c66 100644
--- a/arch/mips/include/asm/dmi.h
+++ b/arch/mips/include/asm/dmi.h
@@ -5,7 +5,7 @@
 #include <linux/io.h>
 #include <linux/memblock.h>
 
-#define dmi_early_remap(x, l)		ioremap_cache(x, l)
+#define dmi_early_remap(x, l)		ioremap(x, l)
 #define dmi_early_unmap(x, l)		iounmap(x)
 #define dmi_remap(x, l)			ioremap_cache(x, l)
 #define dmi_unmap(x)			iounmap(x)
-- 
2.42.1

