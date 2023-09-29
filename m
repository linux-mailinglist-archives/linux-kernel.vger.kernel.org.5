Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAE17B3BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjI2VMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjI2VME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:12:04 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647811A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:12:02 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c74e099ba9so6397305ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696021922; x=1696626722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=19scQT+vZguMbMPGvwbswmmwWeMyYkP13y1R8IKgsdo=;
        b=Zd6JRriOPOX1x6aTOLFBCqzeK/oCDIqgP2b+sbpHWzAsxc6caGkOCYDY2Ks5XGVIz7
         uhGkdjS/ImUVT2Iga+RfyKLbtFAf2ZfkqNEjRzGZ+AdrLnnHk1sHvMZqkvdbYIvj5YQe
         PeWI+aF6G+Hs+ilT6qhP22WbvLXXWY6ZsCNsxF6M8PIiaEL1Db9GE1huzhtYt+8yeQRd
         tWJxFZFt7W0ouxNi7gEZ2vkRcyPEVcRiTBFGf6G7VfPNia8/tTxqUbSpf4Ud3ZO5k6Zu
         rHDlx40FWz6xFRs/FMim9TScpVDgB0XTNOgUnZOlLPNfq9Ne7dcqOptWDmvIyVlhQSUm
         /KVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696021922; x=1696626722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19scQT+vZguMbMPGvwbswmmwWeMyYkP13y1R8IKgsdo=;
        b=IvsfoQz8j9hGriUzmYU8ObZRhjrS2rvJDX7eMX4v+jorHlStZYIQFVW6SaB494Yrla
         73qKFW9+fBEHaGnrlKZ8jWNS5s7iWTPKOS0bjtUGWQVCiPD2VJE3xBuedM664G9YDJYz
         WVjYPEPa8c58m/wOfYjoxcd4WxzRWx7nwvz8ZuXBHT9ftF+RzZPl43iMUIBOyIti8Lbx
         bW/ajL/M2WG42Dp6ejDJLwsrJOOVEFcsKNof96e4TjRktV09WceosP97Rpu4lTY/ec0l
         Xa8sIWjVqCV+ErHSMkAfc2Mm7ugQce0rfvzwI87R1wLeECsyO36r/9E6sgkxjmbBmY2G
         /mNw==
X-Gm-Message-State: AOJu0YwOr5ocU26oKV2oL9er3xa7kUlkpY5x8R5RAtN9KI0T5ZGB61L1
        zSbj4hsTGbLe4Fk+Gol0axsnh5rDg7y8rWxa6j4=
X-Google-Smtp-Source: AGHT+IEu8pWqkhn949EN2w2MEEmF4sIQU2CD0ztiPLeuQl+OuKcbvmbHD9LpYfISQSvkmvSO3SxPVHDUipdN2Hi1oC8=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:903:1c8:b0:1c6:d25:8730 with SMTP
 id e8-20020a17090301c800b001c60d258730mr75155plh.0.1696021921796; Fri, 29 Sep
 2023 14:12:01 -0700 (PDT)
Date:   Fri, 29 Sep 2023 21:11:58 +0000
In-Reply-To: <20230929211155.3910949-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230929211155.3910949-4-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=samitolvanen@google.com;
 h=from:subject; bh=MSLQAq+u1Gq1vqQPv1L24OvfGxs9lQjVrKINsuZaDko=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBlFz2bXFheIUWsMCgpXroYNEMEHJSzh7lHXZPhb
 Ah07CUmBI2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZRc9mwAKCRBMtfaEi7xW
 7oPqC/9r2/xEbO/XFpLcUfW8kI4zwGyW+1Bc7PLy9I1XUD02QER16SuVa1TjN8rJQPDmOMsvTB5
 T5jEE8zHkuv5iPAUTq/yfdsqgq7Z9o7WUqulun2nOY9Z455ZDOwLvbCIfEXhOthriqRBjm08Kd8
 068lN/FADXcZatUB50UlQahfJo08fLC7oUQ5xDGv0aXR6pnqONVNs/F1FhlysA15ZmM0HVhJePX
 6NcJ3HNNPyvbDbeafLIysEsEirdqqDLbxHXo6W0v7OFcevxKffQom+ZUD8w0SlBJsnrgLSQYfrL
 4SDgYPIT3RgVrVY58SpSU/IrpswNMkcW1oGV+VpuE8vh5HfISvX0Y/jFIK76jIL1xM9gdG/5oKD
 xSBdaJPOnpK9Gcze/0uC08IM5oubP3raIy1qzWvrbWFce1KlRfKgkHLVVNp7KcJmqHe0lhZqoI4 gKx2VGQd8AOM+C9TUeca+0u6bNkxxIvvO6e8Zupt2MkaleKzO1xxv6N14XGwr2/VkIpsg=
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230929211155.3910949-6-samitolvanen@google.com>
Subject: [PATCH 2/2] riscv: mm: Update mmap_rnd_bits_max
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_MMAP_RND_BITS_MAX is based on Sv39, which leaves a few
potential bits of mmap randomness on the table if we end up enabling
4/5-level paging. Update mmap_rnd_bits_max to take the final address
space size into account. This increases mmap_rnd_bits_max from 24 to
33 with Sv48/57.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/riscv/mm/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0798bd861dcb..ff8d21a6cb2d 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -762,6 +762,11 @@ static int __init print_no5lvl(char *p)
 }
 early_param("no5lvl", print_no5lvl);
 
+static void __init set_mmap_rnd_bits_max(void)
+{
+	mmap_rnd_bits_max = MMAP_VA_BITS - PAGE_SHIFT - 3;
+}
+
 /*
  * There is a simple way to determine if 4-level is supported by the
  * underlying hardware: establish 1:1 mapping in 4-level page table mode
@@ -1071,6 +1076,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 
 #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
 	set_satp_mode(dtb_pa);
+	set_mmap_rnd_bits_max();
 #endif
 
 	/*
-- 
2.42.0.582.g8ccd20d70d-goog

