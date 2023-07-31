Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE78076937E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGaKu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjGaKtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:49:50 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6C510DD;
        Mon, 31 Jul 2023 03:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1690800563; bh=ucpGdtrngWa5JzqKl0A4/BV0rC8meuk5XgXujtm+V8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K72qV7FrPVP002HDxADN7m/xyBPa1V4f9gZyPcfPBk1OnCB7hL5kdE8t3olGoZGib
         VsX0eibWzOKbfwNmaKq4s7AmwCFVwTkS+AJn/WCySwAzYVPxJEaiHhP+FPj4VVmYEt
         7hBYlUGrlpSK3Dg6+kLuZ9mqxKuGS10rBFt/s0Bw=
Received: from ld50.lan (unknown [101.88.28.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id EEFD0601DA;
        Mon, 31 Jul 2023 18:49:22 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH 4/5] raid6: test: make sure all intermediate and artifact files are .gitignored
Date:   Mon, 31 Jul 2023 18:49:10 +0800
Message-Id: <20230731104911.411964-5-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230731104911.411964-1-kernel@xen0n.name>
References: <20230731104911.411964-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

Currently when the raid6test utility is built, the resulting binary and
an int.uc file are not being ignored, which can get inadvertently
committed as a result when one works on the raid6 code. Ignore them to
make `git status` clean at all times.

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 lib/raid6/test/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 lib/raid6/test/.gitignore

diff --git a/lib/raid6/test/.gitignore b/lib/raid6/test/.gitignore
new file mode 100644
index 0000000000000..bb92e11396c6e
--- /dev/null
+++ b/lib/raid6/test/.gitignore
@@ -0,0 +1,2 @@
+/int.uc
+/raid6test
-- 
2.40.0

