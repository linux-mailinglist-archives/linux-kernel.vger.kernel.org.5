Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC53176B547
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjHAM50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjHAM5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:57:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189541FD2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 05:57:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbb634882dso12226805e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690894639; x=1691499439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bnCBluV5/peVM0jbJDidt8t/2S3NU8gWwe7j2Nlnw0Y=;
        b=ztCH3XjCFi/VZjLTNuJ0M23wzispoT6pb4iomI2lAXpfGHDgaFI0uV9S5LULrjjktJ
         CqQLgh2xoX33qhXxyn0st3EV/n2K1mdNlKmCg49QhMoxh4pltj+2h95LYCMDqmyRhc3r
         dgTMMY45e92dR++kpZc5UNsQikxBBpJKAKPkk0JRiupM/4oZ4ub7BoIcNXjEF8JOYPaJ
         JQC0ngMEItSK2pivZk9ypjqGudZHF4LsIYdYUmJTtMCqZBjXKfh0c8kBQBFQPQHjTuBe
         MGmo22aWPoePMOwOnPw+dPlB7SclvthVQwLsarVAegFF0XJ3ujTy4HapJ54QIVeFzZuM
         ukYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690894639; x=1691499439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bnCBluV5/peVM0jbJDidt8t/2S3NU8gWwe7j2Nlnw0Y=;
        b=IcshxR53nBI1GmlUgTb3oTSU2HL1lFTv7j3HGlSpRhw/Mufru/ET+etz79bijoxwRB
         y7xJa7xhv1DkZdm/r936Cv43e5YFgk1suwJJ1iA7ElbaJfG9jBV3GY299u6KcIA6B6DK
         Ftqk2Pc5u8DS3GbbWkBZDOl+Te6hiyzcvd10rSytWVVKXoS3vRsbPQtgwJcSV3hUYStV
         d55loxy6qpgC93Tt5K7lpqyU+/v54nbSf36CdjJhX+qxB4Ru1/9XUwvWv42uiSMo9HYR
         0iVKLxJR8za1sS3QGjvAMRczniFrnH1XlJ3srFDmFNqcS49nAWgMsX++NutTTlMpMLHt
         G8Ew==
X-Gm-Message-State: ABy/qLbYMpU13wbTZGBJSRlH6MCs7vwdO0C/PvgBVVgpbEEcL8CxapNM
        WHyHSx02n1nOebtOrSEmUPypwQ==
X-Google-Smtp-Source: APBJJlEB2tOCWVCbNU0amxLgVmnJw2RVKmeAwXQlrVze2ga0IY0LB2rjfqnJvmRgBL4p28JpqKbxNw==
X-Received: by 2002:a5d:630c:0:b0:317:5eb8:b1c0 with SMTP id i12-20020a5d630c000000b003175eb8b1c0mr7415154wru.5.1690894639122;
        Tue, 01 Aug 2023 05:57:19 -0700 (PDT)
Received: from carbon-x1.home ([2a01:cb15:81c2:f100:94c1:d2b1:7300:5620])
        by smtp.gmail.com with ESMTPSA id y17-20020adfd091000000b003178dc2371bsm12630712wrh.7.2023.08.01.05.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:57:18 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
Subject: [PATCH] scripts/gdb: fix usage of MOD_TEXT not defined when CONFIG_MODULES=n
Date:   Tue,  1 Aug 2023 14:57:15 +0200
Message-Id: <20230801125715.139721-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MOD_TEXT is only defined if CONFIG_MODULES=y which lead to loading failure
of the gdb scripts when kernel is built without CONFIG_MODULES=y:

Reading symbols from vmlinux...
Traceback (most recent call last):
  File "/foo/vmlinux-gdb.py", line 25, in <module>
    import linux.constants
  File "/foo/scripts/gdb/linux/constants.py", line 14, in <module>
    LX_MOD_TEXT = gdb.parse_and_eval("MOD_TEXT")
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
gdb.error: No symbol "MOD_TEXT" in current context.

Add a conditional check on CONFIG_MODULES to fix this error.

Fixes: b4aff7513df3 ("scripts/gdb: use mem instead of core_layout to get the module address")
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 scripts/gdb/linux/constants.py.in | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 50a92c4e9984..866015547b38 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -63,7 +63,8 @@ LX_GDBPARSED(IRQD_LEVEL)
 LX_GDBPARSED(IRQ_HIDDEN)
 
 /* linux/module.h */
-LX_GDBPARSED(MOD_TEXT)
+if IS_BUILTIN(CONFIG_MODULES):
+    LX_GDBPARSED(MOD_TEXT)
 
 /* linux/mount.h */
 LX_VALUE(MNT_NOSUID)
-- 
2.40.1

