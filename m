Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AA879E142
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbjIMH5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238663AbjIMH5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 129B11989
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694591774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+2YZeWGnhtLtLKWmmtDa9+kw7Cib/DF3yutI/cbgQ0s=;
        b=FzyE05m0Mk2EPnvhyJQfwRq+37i7bx8kpiPpaoJ3VhLxkmgNCTpMOLXb3lw0EUPuD65hUt
        Uzjl+QShoFE1WS3b2BUkV9iRkkbszUBP/GAzeaN3rWOnRMxh5sXw3xh1bplva2In4XIC5m
        wKeirwYS/SAzcYfRZpuQtDOoDnaL4RY=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-B6fTUf5bM72yMrRfZeayow-1; Wed, 13 Sep 2023 03:56:10 -0400
X-MC-Unique: B6fTUf5bM72yMrRfZeayow-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-57617c2528dso6499510eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694591770; x=1695196570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2YZeWGnhtLtLKWmmtDa9+kw7Cib/DF3yutI/cbgQ0s=;
        b=DyDcaBDOXJIrGqLH1XtCfX4k3O1OFKlAoIfLEMciI3EhPI41lC/Ty7zpOcf11hw1s4
         tHP1AMkLPNApBcLwO0lGw+YOyzO5+NoyPv1O/SioocI+Qm5me+c8mwvhKUDoeZ5djAut
         +1VUhgoJXT/JFm16e3UkhTI3+RYd4q6PfxOrN3hzheN1ZYPyLUbuyxC8kQq2QU4/KVKN
         Ah6igNs596OmFicNBKkcfQtakuol7ox9YG01GfZfnmcFhnoI+a+ZSn/lSAOntWWC6/OH
         2kRU/xkYkMI7JglTrZEY2LtljiveCxwHJxZb7VtK9h/SkJJtEOJYwPFONJ+Iw+HVJmTG
         h+ig==
X-Gm-Message-State: AOJu0YydJSrrqrQvbXA+2LBEor1vFQVu5DV0w8/tv5VPnuNIENYlRGRG
        ZXqP59q/lNtw90Cag2iofM1sW9H5fdFcRPXqH+fhBjW1oPY1hWaH+Gi9FpDuInpeqTDENIKz9nH
        bq3bUWNf5bmQP8JLAKW3qQwO8
X-Received: by 2002:a4a:925d:0:b0:576:8c2c:c869 with SMTP id g29-20020a4a925d000000b005768c2cc869mr1992890ooh.7.1694591769771;
        Wed, 13 Sep 2023 00:56:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETWXxBvUyReXyaN1A1TR+W1jjzsiQKEmfbD3TbDliUontlhrXfdDCeVcvCyU7EdBmLiDCw1A==
X-Received: by 2002:a4a:925d:0:b0:576:8c2c:c869 with SMTP id g29-20020a4a925d000000b005768c2cc869mr1992885ooh.7.1694591769591;
        Wed, 13 Sep 2023 00:56:09 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id a42-20020a4a98ad000000b0057327cecdd8sm5137519ooj.10.2023.09.13.00.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:56:09 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.or
Subject: [RFC PATCH v4 1/1] scripts: Introduce a default git.orderFile
Date:   Wed, 13 Sep 2023 04:55:50 -0300
Message-ID: <20230913075550.90934-2-leobras@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing patches, it looks much nicer to have some changes shown
before others, which allow better understanding of the patch before the
the .c files reviewing.

Introduce a default git.orderFile, in order to help developers getting the
best ordering easier.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---

Please provide feedback on what else to add / remove / reorder here!

Changes since RFCv3:
- Added "*types.h" matching so type headers appear before reguler headers
- Removed line ends ($) in patterns: they previously provided a 
  false-positive
- Fixed build patterns to allow matching Kconfig, Kbuild & Makefile
  in any subdirectory

Changes since RFCv2:
- Fixed licence comment to from /**/ to #
- Fixed filename in how-to comment
- Fix build order: Kconfig -> Kbuild -> Makefile
- Add *.mk extension 
- Add line-ends ($) to make sure and get the correct extensions
- Thanks Masahiro Yamada for above suggestions!
- 1 Ack, thanks Randy!

Changes since RFCv1:
- Added Kconfig* (thanks Randy Dunlap!)
- Changed Kbuild to Kbuild* (improve matching)


 scripts/git.orderFile | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 scripts/git.orderFile

diff --git a/scripts/git.orderFile b/scripts/git.orderFile
new file mode 100644
index 000000000000..7cef02cbba3c
--- /dev/null
+++ b/scripts/git.orderFile
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# order file for git, to produce patches which are easier to review
+# by diffing the important stuff like header changes first.
+#
+# one-off usage:
+#   git diff -O scripts/git.orderFile ...
+#
+# add to git config:
+#   git config diff.orderFile scripts/git.orderFile
+#
+
+MAINTAINERS
+
+# Documentation
+Documentation/*
+*.rst
+
+# build system
+*Kconfig*
+*Kbuild*
+*Makefile*
+*.mak
+*.mk
+
+# semantic patches
+*.cocci
+
+# headers
+*types.h
+*.h
+
+# code
+*.c
-- 
2.42.0

