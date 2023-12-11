Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1302880DE28
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344987AbjLKWN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjLKWN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:13:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17608A6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702332843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iPVf4tIFm+3r3HHF66qfweGUV+NYW/dRVWEv9IV2zdY=;
        b=UyTDZAOgblmjK31BeSb1Dgx2c+OFjry8MdHFustruASYiD3GjQ6fCtruwnoAZh9ECX40Jj
        2oJc6VvQxzz8S2GQBrmgwztz1m+XQvG9xjWnvBdQXhN4hFFkQr3aRZ2oYfFVT0vufa8Za3
        HJ6ROClTjjmg2DOLi2TbwV58PSYmC3k=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-5yHqR-O5PKi37l8VqP5_Qg-1; Mon, 11 Dec 2023 17:14:01 -0500
X-MC-Unique: 5yHqR-O5PKi37l8VqP5_Qg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1d1e42e807cso32412445ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702332841; x=1702937641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPVf4tIFm+3r3HHF66qfweGUV+NYW/dRVWEv9IV2zdY=;
        b=jr3d5d56d0T7bA5Tgf5iEm4st/MvvfNFaWed7CNVUM6PgRMob2gXMRcE2ykPxVjc17
         kZA8CF/31Wp8znT7H0GvIPvDOS3fdxyQf2oAkkQHrYUKWOOrr0YGuPukCvC1JXb++mDz
         r5FCk+71Qzkkwto+GyiaYWX3Cz015/n+8Al6Hch1BqErhhKuIN/CMFxq8zWp8p7KRGyi
         MQQwXwMUeHJiiKkRSNas09/yYImmhLQE2IG6rc0/wqAszBOvmiSR8c10JCP0LYpjYMSm
         2P1EdaXgtKF/KxwkiKev6LfyibH47ItNU3pBcCu8xbZYpsktymsst7NBJ1AsgfwZ0r9U
         xolA==
X-Gm-Message-State: AOJu0YwEqNILFLU6ehvPrghMSIUa227Juwclct+2SljP/P4NfoOA7c7K
        nTJbi3MZpKqtOcCzRVe6KDqL3TubdEmfcx9fSCcuTVLSiUzs2MV4DfoyuaKO3BALheTfmRWRNq+
        OE4hb4J33uGea9CvMN2UQC7h0
X-Received: by 2002:a17:902:e5ce:b0:1d3:2a94:cb46 with SMTP id u14-20020a170902e5ce00b001d32a94cb46mr1288783plf.31.1702332840675;
        Mon, 11 Dec 2023 14:14:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkKKD1GNOH8Kn0zpCPYCYxVlnLcOySoe0F3975EC+0WOd8bY3cWRYFMYInjvFkdNRrdMJLZw==
X-Received: by 2002:a17:902:e5ce:b0:1d3:2a94:cb46 with SMTP id u14-20020a170902e5ce00b001d32a94cb46mr1288768plf.31.1702332840343;
        Mon, 11 Dec 2023 14:14:00 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:3102:945e:6f76:fb73:6512])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b001cf85115f3asm7161187plf.235.2023.12.11.14.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:13:59 -0800 (PST)
From:   Leonardo Bras <leobras@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [RFC PATCH v6 1/1] scripts: Introduce a default git.orderFile
Date:   Mon, 11 Dec 2023 19:13:36 -0300
Message-ID: <20231211221338.127407-1-leobras@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Changes since RFCv5:
- Replace "*Kconfig*" by "Kconfig*" + "*/Kconfig*" to avoid matching files
  like foo-Kconfig, which should not be valid here.
- Same of above for "*Kbuild*" and "*Makefile*"
- Thanks Masahiro Yamada for this suggestion!

Changes since RFCv4:
- Added scripts/* into "build system" section
- Added "git-specific" section with this script and .gitignore
- Thanks for this feedback Nicolas!

Changes since RFCv3:
- Added "*types.h" matching so type headers appear before regular headers
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


 scripts/git.orderFile | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 scripts/git.orderFile

diff --git a/scripts/git.orderFile b/scripts/git.orderFile
new file mode 100644
index 0000000000000..5102ba73357f0
--- /dev/null
+++ b/scripts/git.orderFile
@@ -0,0 +1,42 @@
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
+# git-specific
+.gitignore
+scripts/git.orderFile
+
+# build system
+Kconfig*
+*/Kconfig*
+Kbuild*
+*/Kbuild*
+Makefile*
+*/Makefile*
+*.mak
+*.mk
+scripts/*
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
2.43.0

