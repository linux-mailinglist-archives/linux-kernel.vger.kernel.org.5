Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C7F7877B0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243016AbjHXSVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243004AbjHXSVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:21:21 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA941BE3;
        Thu, 24 Aug 2023 11:21:19 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37OILAw0130191;
        Thu, 24 Aug 2023 13:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692901270;
        bh=0AfiQjed5ChtkdXYwfP+W9d+uQPzKKcTCI0+Tp0FZMQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cUMhX+ChvpIIetEiw6PiJjIw83Ga9QfZVpvitBijc8o+pn9XlDw2mv+PG8rfF7Gkb
         SJokPIfw7uMghj/ndio/PBNtwzJyU/Isv3GU740bZ4JoDXmC8qVgQ7CiQGX+KTm0Ap
         m5VaFdz/yJI0DuDLH7+fQqUf6xutvxzEeuNWwznU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37OILA7u088748
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Aug 2023 13:21:10 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 13:21:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 13:21:10 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37OILAUN029180;
        Thu, 24 Aug 2023 13:21:10 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bpf@vger.kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Neha Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/2] Documentation: bpf: Use sphinx-prompt
Date:   Thu, 24 Aug 2023 13:21:07 -0500
Message-ID: <20230824182107.3702766-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230824182107.3702766-1-nm@ti.com>
References: <20230824182107.3702766-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use Sphinx-prompt to generate a better rendered documentation that is
easier for copy-paste.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 Documentation/bpf/libbpf/libbpf_build.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/bpf/libbpf/libbpf_build.rst b/Documentation/bpf/libbpf/libbpf_build.rst
index 8e8c23e8093d..2b94e5778702 100644
--- a/Documentation/bpf/libbpf/libbpf_build.rst
+++ b/Documentation/bpf/libbpf/libbpf_build.rst
@@ -13,25 +13,25 @@ setting NO_PKG_CONFIG=1 when calling make.
 
 To build both static libbpf.a and shared libbpf.so:
 
-.. code-block:: bash
+.. prompt:: bash $
 
-    $ cd src
-    $ make
+    cd src
+    make
 
 To build only static libbpf.a library in directory build/ and install them
 together with libbpf headers in a staging directory root/:
 
-.. code-block:: bash
+.. prompt:: bash $
 
-    $ cd src
-    $ mkdir build root
-    $ BUILD_STATIC_ONLY=y OBJDIR=build DESTDIR=root make install
+    cd src
+    mkdir build root
+    BUILD_STATIC_ONLY=y OBJDIR=build DESTDIR=root make install
 
 To build both static libbpf.a and shared libbpf.so against a custom libelf
 dependency installed in /build/root/ and install them together with libbpf
 headers in a build directory /build/root/:
 
-.. code-block:: bash
+.. prompt:: bash $
 
-    $ cd src
-    $ PKG_CONFIG_PATH=/build/root/lib64/pkgconfig DESTDIR=/build/root make
\ No newline at end of file
+    cd src
+    PKG_CONFIG_PATH=/build/root/lib64/pkgconfig DESTDIR=/build/root make
-- 
2.40.0

