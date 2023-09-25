Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4807ADBAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjIYPjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIYPja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:39:30 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AB0B6;
        Mon, 25 Sep 2023 08:39:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso36678995e9.3;
        Mon, 25 Sep 2023 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695656363; x=1696261163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zI4xebzYU4bFfFhG1gQnF1IxqTyPLKeseQ7Q+EIyte4=;
        b=k0aGgrICmgxFGWvgmwgLhoyrQIqQRnkm8pso55jRzgi2Fcjlh4E76hq/SCciP4Dek/
         7DyQ8C4rqmCJvh1tsYTDoDEKEx16Fo9nU4B3THHWrOUMyXMMulMET1wgX561Bu7qtxRd
         DN6GzlHHTkCog87PhMFyv5kf2NLc4+TUXOT3850IYNRtzrTZNnJwzzMoMjQEuBQDRYrc
         zlVirzXsckgMjv8EGX242gUMwGu1YCfO1jmbAOiHBBzfizUseFaaufW2YSCrJckG/0Db
         shAOnK0oT0j9YpMUsYQ/C72hYsuxVg3BENCNDld5JS5nv8Vl936RAdWpuSiyv/+LKwOC
         KznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656363; x=1696261163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zI4xebzYU4bFfFhG1gQnF1IxqTyPLKeseQ7Q+EIyte4=;
        b=rqr5fgSwQLpKctYZDXDZAcmavbo82qWaknUso+6DIMrd4Y4jAfJftbeQifV3roo6Th
         p+1Pwll8rQMGxLSYoQJLAdl8eRc58zY0y/0R5p8HQ1Hfi396zl0XXgGLGKlOk/2Mb/R6
         dtV/8AemxaSS27DxlyJCbSuxxvEKQiCZ2v8Mpo92m/VBqB8PYpWk5jX77MusngNZZdWm
         PJskd9/Dw2J8EpmhtGWZ7dfsxJFNFw4bNocaHbmTM22cHP7YmcQzgngXt6hunrm/2eW6
         SgXjCxKKfFnj3/gQHbPC0VrrWtSfwWiz9JDNc95JSTOPnNZvuDrUc+wLsZq/hgpPLLL6
         T1iA==
X-Gm-Message-State: AOJu0Yw79kEMIKd7yU4JFQJb8ymQy0vN5m/fY8hcPvkxmBwRPzfa/AWR
        EFiaLknLeL2jjVBrl4xpODs=
X-Google-Smtp-Source: AGHT+IGmio0BsSiBXssQTj+z2/Vno0WeDNG8BAx+qL9K6D9LmNv/sH4hqT8UGCO6XH4OPejS3+i0tg==
X-Received: by 2002:a7b:c34c:0:b0:401:d803:6243 with SMTP id l12-20020a7bc34c000000b00401d8036243mr5996648wmj.32.1695656362475;
        Mon, 25 Sep 2023 08:39:22 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:47ed:1dba:e442:ccf2])
        by smtp.gmail.com with ESMTPSA id e15-20020a05600c218f00b00402ff8d6086sm12552582wme.18.2023.09.25.08.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:39:22 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] riscv: errata: andes: Makefile: Fix randconfig build issue
Date:   Mon, 25 Sep 2023 16:38:44 +0100
Message-Id: <20230925153844.26820-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Compile the andes errata with cflags set to " -mcmodel=medany"
when CONFIG_RISCV_ALTERNATIVE_EARLY is enabled.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309111311.8tcq3KVc-lkp@intel.com/
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/errata/andes/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/errata/andes/Makefile b/arch/riscv/errata/andes/Makefile
index 2d644e19caef..6278c389b801 100644
--- a/arch/riscv/errata/andes/Makefile
+++ b/arch/riscv/errata/andes/Makefile
@@ -1 +1,5 @@
+ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
+CFLAGS_errata.o := -mcmodel=medany
+endif
+
 obj-y += errata.o
-- 
2.34.1

