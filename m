Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D822760967
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjGYFi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjGYFi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:38:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0A419AA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:38:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99313a34b2dso748918466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690263531; x=1690868331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7e91BMfpSrUV8pLZU1LBjqTvh3MYJ90peEUrbZ0fJg=;
        b=DUV24tjMeuaYTRh7/en2rwqUQ0+Z84MXh9/5CuvvoPYwgfUUGT5C92XvGlgjodir7I
         DdKAbGyDJNcNNPqr9M7EbSkoyGIxObjYdArkaS2KSPwsqM785K3rSeWH2Alvn9h05Qm9
         WlBBkAH92Hur813wc/6oNLVSXUAGe/mMeRVieqSfSJ19PnFyaGu4YVDevZh7L7fxonT2
         sqSu8jL3ZSNzRMIRmxTM8RV+tfF1B6W9NiMcG4tUSGvcUPqp+FGO0KmsC/NsSNLS+KOa
         JihUGIjt1i2UhE0zex4wEfQ1u1Q/lNxR7zu8ks9wdLNGSKmkgYYsckHHA7jJZfEk7TKd
         U3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690263531; x=1690868331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7e91BMfpSrUV8pLZU1LBjqTvh3MYJ90peEUrbZ0fJg=;
        b=HC7rumDlvDd1LVmNR6TS8UAbpKmQr6WQXEB/buv5VbKhYolX2B8ihp4bBWcicMxoLD
         Z6HjLqSVEGk7b6ua0C04oejddMetYlojRd9yHR5suUKMRREKVChEyIQ/i3zie0cXXLdn
         cC5Jn88OOvS0jbj9WyBdnpYad9uLQ7hT1pTSJxhb20sDFL9S6cnPMKLBMwVFehaDJn+h
         9Db0xOc7kmfJtOWvx2z+XpJqaNJO7QrII2fNMSu5LApQgXpSB7Id7AsVd6P2GkGhiT3c
         I+X0y3PHmG7TVOpKK5A7QR/aduiolhxEewSVVjOw6FCcNCRFDTMXiezFhpCMpY2zbruy
         MqrQ==
X-Gm-Message-State: ABy/qLYSusj8PhtYOqQvOchpt4KnRF2QxIr2aH43C7MGrw/H9mkvCV+G
        ywgwq6RMfGUA8P/2VI3ihaqiwf2W9Urmig==
X-Google-Smtp-Source: APBJJlGIpBQohsfNWMduzGbsUTuAkIXnC9gXiYrUHa9hdT4wan2u4ldYKt0z7d2XhO4EFumjgXnwxA==
X-Received: by 2002:a17:907:a070:b0:993:da91:6e0c with SMTP id ia16-20020a170907a07000b00993da916e0cmr11226554ejc.3.1690263531214;
        Mon, 24 Jul 2023 22:38:51 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id jp7-20020a170906f74700b009937dbabbd5sm7639369ejb.220.2023.07.24.22.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 22:38:50 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcaov@gmail.com>
Subject: [PATCH] riscv: remove redundant mv instructions
Date:   Tue, 25 Jul 2023 07:38:35 +0200
Message-Id: <20230725053835.138910-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Some mv instructions were useful when first introduced to preserve a0 and
a1 before function calls. However the code has changed and they are now
redundant. Remove them.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 arch/riscv/kernel/head.S | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 11c3b94c4534..3710ea5d160f 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -289,10 +289,6 @@ clear_bss:
 	blt a3, a4, clear_bss
 clear_bss_done:
 #endif
-	/* Save hart ID and DTB physical address */
-	mv s0, a0
-	mv s1, a1
-
 	la a2, boot_cpu_hartid
 	XIP_FIXUP_OFFSET a2
 	REG_S a0, (a2)
@@ -306,7 +302,7 @@ clear_bss_done:
 	la a0, __dtb_start
 	XIP_FIXUP_OFFSET a0
 #else
-	mv a0, s1
+	mv a0, a1
 #endif /* CONFIG_BUILTIN_DTB */
 	call setup_vm
 #ifdef CONFIG_MMU
-- 
2.34.1

