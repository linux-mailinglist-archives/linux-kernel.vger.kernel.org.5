Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404EA7C6BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378020AbjJLK4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377894AbjJLK4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:56:16 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D20B90;
        Thu, 12 Oct 2023 03:56:15 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9e072472bso3711545ad.2;
        Thu, 12 Oct 2023 03:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697108175; x=1697712975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9Da9MBT9rB+lZA9zm7WjEfc17v4yeizFPCpeNj0xZ0=;
        b=Ei07dD2m+RTvKQhFedviaU1CsU5TBQ/erBoTMJOHBNfnnycKPjdIy1+kaJ+4DWAfMJ
         kBe5yBQuv7K4vIqZhY2mryVqSd+ASML7t2cXci4Qjrv0NY/YOwgMGowdIXzdEGSv8+fd
         Pdn+qdl3Mxuz1s5wFIertknrqDOt970bnc/GBWa2GNSQs+LMZpG/MRumMXXg3Ne1jMA/
         pNTw+eeeR3oqUZWNedlC94yT416cqbpqwIrCQhN6wxLhBH4lVjDQdcM1ZE+cH7gB/MnN
         D50pm+hKYJk6EK1TinKUyzHGWj8QuaW/q0dDO+qzSYYbF4JN7HLBf/JtEVahNjyOTrCs
         cMRA==
X-Gm-Message-State: AOJu0YxQDamhMNb0DqygyM8iM0bsALWBmPRHUTJnuSFF/Smh+hmU4jGt
        50OAzBhbYBGMx+iw2M9BUz8=
X-Google-Smtp-Source: AGHT+IHrukWTPzhOjCyRsKwTW9N1rf4iR43yr7LemfnQgYdFKwX3fykZ3xDPkLmVgn5cqdkN8M/iSQ==
X-Received: by 2002:a17:902:fa8f:b0:1c9:d948:33d5 with SMTP id lc15-20020a170902fa8f00b001c9d94833d5mr2349432plb.64.1697108174615;
        Thu, 12 Oct 2023 03:56:14 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001c3267ae31bsm1642297plh.301.2023.10.12.03.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 03:56:13 -0700 (PDT)
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1697108172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W9Da9MBT9rB+lZA9zm7WjEfc17v4yeizFPCpeNj0xZ0=;
        b=p6mRBJRv15x2a8mugD54EELIKpHhGxE1HudINzkmlCUswZguuXtnlCIm/uEwKwVFGZVLJK
        nYWY3ofQoWfYLeWEKmB7VlsdpqXtvMSIsU6UcKac9GL54ENIO1eIdN7DJjkuzehSfniMDg
        qORCa7JwERprwg49vaR4XZH3DGZYcOA0iaWdlZhua/wejFBTrv0X29zVCWKoPHxCiZUyj+
        6m2N1mhjzLGzrd+M41gY1i3BLQ8YfOEO7gI4LQKNrAbrF/BAbWNzNcAJZ6yUKmJvj2rjU8
        m0xLBNvh1cZcYPP/CDUQ5IFVxGBe/Ql7NmfsVGUjkM9DsgHzdToaow1h361Ndg==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "Ricardo B. Marliere" <ricardo@marliere.net>
Subject: [PATCH] docs: kbuild: add INSTALL_DTBS_PATH
Date:   Thu, 12 Oct 2023 07:54:21 -0300
Message-ID: <20231012105420.16779-2-ricardo@marliere.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for kbuild and makefiles is missing an explanation of
a variable important for some architectures.

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 Documentation/kbuild/kbuild.rst    | 6 ++++++
 Documentation/kbuild/makefiles.rst | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index bd906407e307..9c8d1d046ea5 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -243,6 +243,12 @@ The output directory is often set using "O=..." on the commandline.
 
 The value can be overridden in which case the default value is ignored.
 
+INSTALL_DTBS_PATH
+-----------------
+INSTALL_DTBS_PATH specifies where to install device tree blobs for
+relocations required by build roots.  This is not defined in the
+makefile but the argument can be passed to make if needed.
+
 KBUILD_ABS_SRCTREE
 --------------------------------------------------
 Kbuild uses a relative path to point to the tree when possible. For instance,
diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index e67eb261c9b0..d88d4f0f4f89 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -1623,6 +1623,13 @@ INSTALL_MOD_STRIP
   INSTALL_MOD_STRIP value will be used as the option(s) to the strip
   command.
 
+INSTALL_DTBS_PATH
+  This variable specifies a prefix for relocations required by build
+  roots. It defines a place for installing the device tree blobs. Like
+  INSTALL_MOD_PATH, it isn't defined in the Makefile, but can be passed
+  by the user if desired. Otherwise it defaults to the kernel install
+  path.
+
 Makefile language
 =================
 
-- 
2.42.0

