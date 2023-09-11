Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3D079B584
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357148AbjIKWFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244211AbjIKTjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 401D318D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694461107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BAo7XhrjvK/3ybteqvsiiDZDbALbJjGeMr635r5XCfY=;
        b=bnBUAY4PCodCziEBDwgg9V8Lm7JTNjkGLRgf8ihvbh29WVNoo/s07BLsXhpLXqAnwk42eV
        tviZ9l0QysB2iHWnJDPrNBcxTelPcq1BkM+JjbLAVUX7m7CEkkJv1cZ2DEm8DOVhtUfV7G
        tbITRgiUqKcFAa9Ebv3m9T6CRfDBQjw=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-HJGZUjlkPLmufVoz0y9s3g-1; Mon, 11 Sep 2023 15:38:16 -0400
X-MC-Unique: HJGZUjlkPLmufVoz0y9s3g-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6c0d4cb748bso2443482a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694461095; x=1695065895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAo7XhrjvK/3ybteqvsiiDZDbALbJjGeMr635r5XCfY=;
        b=gPz13cE6aMXTulyhRduDvMHOKVzlxRa7goO4QaWMCmGpbJYB1ASgz6mftTTdxnEEeE
         QynwmTOSpCtQd0QSMGIKGaTVCEYBcKM0Bd2N5/+4u+LfEN/MIlBhGInTSnZyNMzs8g30
         QaVNV0iw8rlz6A7SISyrZ2uInK375ZD7ch9skpQssfmrWwpljxULN7mjC58omS/ptvKp
         xiAiqCjaSXvBlVTYVp3fa6IDgKTBGiPTSHQyLaRcBAXGjFkdJY6LIT/XfoZULUtex1PG
         NiSzi3lNJKP16va4Itki/2vajHci3bLQM9w+HCpKD8ES/eXU/2rlDpjFLg2Jg5Uqk9vR
         9SpA==
X-Gm-Message-State: AOJu0Yyb2Ia9xM5mq07+d0CdslStcZHa7oPMZhWPFM1Hv9NE70oGMPkX
        f0KK3VrVrPu8pw9z36pmqkPuf8w7dumUR1jIBc7B4geWpsuQ4UzMERbKUyE54DVDhFyJoxB3DPe
        aXlN6sGU/HB/FQkpJwUJuTnow
X-Received: by 2002:a05:6830:1692:b0:6bf:29d4:1886 with SMTP id k18-20020a056830169200b006bf29d41886mr10934392otr.34.1694461095423;
        Mon, 11 Sep 2023 12:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtvtstpw9gL5+/J9wmqaf20G5/bfkGVLGUBNzaC/2aa3xh3lly3d7FY52n+lm1dBU5D608bA==
X-Received: by 2002:a05:6830:1692:b0:6bf:29d4:1886 with SMTP id k18-20020a056830169200b006bf29d41886mr10934379otr.34.1694461095225;
        Mon, 11 Sep 2023 12:38:15 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a803:c91:da45:7fbc:86c3:920a])
        by smtp.gmail.com with ESMTPSA id v62-20020a4a5a41000000b005634ef4f1c0sm3662444ooa.31.2023.09.11.12.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:38:14 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: [RFC PATCH 1/1] scripts: Introduce a default git.orderFile
Date:   Mon, 11 Sep 2023 16:37:51 -0300
Message-ID: <20230911193752.27642-2-leobras@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
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
---

Please provide feedback on what else to add / remove / reorder here!

 scripts/git.orderFile | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 scripts/git.orderFile

diff --git a/scripts/git.orderFile b/scripts/git.orderFile
new file mode 100644
index 000000000000..3434028be2f2
--- /dev/null
+++ b/scripts/git.orderFile
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+# order file for git, to produce patches which are easier to review
+# by diffing the important stuff like header changes first.
+#
+# one-off usage:
+#   git diff -O scripts/git.orderfile ...
+#
+# add to git config:
+#   git config diff.orderFile scripts/git.orderfile
+#
+
+MAINTAINERS
+
+# Documentation
+Documentation/*
+*.rst
+
+# build system
+Kbuild
+Makefile*
+*.mak
+
+# semantic patches
+*.cocci
+
+# headers
+*.h
+
+# code
+*.c
-- 
2.42.0

