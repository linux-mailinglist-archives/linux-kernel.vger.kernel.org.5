Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2286782C62
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjHUOpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbjHUOpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:45:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3D4E9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:45:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bcf2de59cso444002766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692629143; x=1693233943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y0VxwGQ+xc22tBdE5JYBo+p1/T9lFHQp+2kQSzguWu0=;
        b=UoxFtxNjlxRrthJpynO9UmxugiBztedDVT6dChbXc1SQ81cvm1ax6fCvLAifht4oSE
         kdFKmXMP1ZuViqrS4n/Rd21PAD+L4SAOv3HVEJr/RjxGQSAPorbsY2juzf/E1H9bix6N
         NXJSM4s4vhnAVa/QaJC5W3um3c2d0ny1IbsW3OU/yGjjgo/t8gjRuHgtTtFfSpIAgOa/
         vmyIlfd1wuAqMK1p3S4tHMFb+2w2Ad0EuJY1dkcnZxNeb55CdVx2OeA8cY7xJYlEWcaw
         u8gmXVrDHNn220PALKRMna1g/ZzWZ7hO57EUd+EcfuQ9Ceu6b3JLlszE+qdbpTAhcGnV
         WgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692629143; x=1693233943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0VxwGQ+xc22tBdE5JYBo+p1/T9lFHQp+2kQSzguWu0=;
        b=CM1hKGc9KlLFeV3hjm0fppYbR5j3nfXF/5cI+WUdu+EZXqBn5vQD28M7poNPlXNXl+
         /O07UctA/lCMTg24qiF7jZb/TDlGcrjs/1Xqx5aUL+KOPqLK7bGKjULkFAKt8ruD7GOd
         4K6pUkNHAabI/JStz8HD4QOKRsMfT7nRrFcjQg64GlDwKBUVtPJ6Jx5RbYZmyv56cn4R
         25DnG0KX/ViIk4eh7ThgqKe/9qGORu8gX4RhDbEWgkgnyA0DT524INNJyDhwnMsuIipB
         mC21fNSypjKDNcgq15GDtQ7lvjHUowcZ/jg75od08LgVr8KDrOR5ivK7Xxuf5A6SGlEt
         mHGA==
X-Gm-Message-State: AOJu0Yxfo88+50g3pe9y0E96JaZ1N1Zj2YSlVBO4ZKegqfMB6Pb+J/1k
        XO7GxE+zYdy+A2vew27681E=
X-Google-Smtp-Source: AGHT+IFH+Lipc3kHML632ozBnOob4H4RKIHgpELzZ/2n+k/9NDvTOXI6GrNMK/qPKXtU8oj+yb6vvQ==
X-Received: by 2002:a17:906:105d:b0:993:e9b8:90f4 with SMTP id j29-20020a170906105d00b00993e9b890f4mr5302704ejj.8.1692629143232;
        Mon, 21 Aug 2023 07:45:43 -0700 (PDT)
Received: from nam-dell (wlan-246006.nbw.tue.nl. [131.155.246.6])
        by smtp.gmail.com with ESMTPSA id dv11-20020a170906b80b00b00997d7aa59fasm6720356ejb.14.2023.08.21.07.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 07:45:42 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcaov@gmail.com>
Subject: [PATCH] riscv: put interrupt entries into .irqentry.text
Date:   Mon, 21 Aug 2023 16:45:17 +0200
Message-Id: <20230821144516.20487-1-namcaov@gmail.com>
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

The interrupt entries are expected to be in the .irqentry.text section.
For example, for kprobes to work properly, exception code cannot be
probed; this is ensured by blacklisting addresses in the .irqentry.text
section.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 arch/riscv/kernel/entry.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 143a2bb3e697..d7dd9030df3f 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -14,6 +14,8 @@
 #include <asm/asm-offsets.h>
 #include <asm/errata_list.h>
 
+	.section .irqentry.text, "ax"
+
 SYM_CODE_START(handle_exception)
 	/*
 	 * If coming from userspace, preserve the user thread pointer and load
-- 
2.34.1

