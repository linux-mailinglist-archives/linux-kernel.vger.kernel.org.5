Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814A27D5B36
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344244AbjJXTKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344250AbjJXTKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:10:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4630293;
        Tue, 24 Oct 2023 12:10:25 -0700 (PDT)
Received: from arisu.hitronhub.home (unknown [23.233.251.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 69EE66607326;
        Tue, 24 Oct 2023 20:10:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698174624;
        bh=ik2lJ68nmMdHse/0Pbl+ym8554daPlCABLkgBBaT6pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BAytmgOax273LxN5RaxTJMxPjBYDB523K3SXGGVOmBqz7bvx06OarJbHdzD9stAh2
         OOO2XC4snhYG9igas+cjt1T1cmCsMEUry6zWUGJ/AKne4sy4Rp3d0SshIwxZnuHZhA
         qEkpO+Ge4OOhOeBW9kvl3LoZA4yLow830pA11CFkcz1nibv6wCgBYWTgEq+/vw/Jii
         yIrG54sGxX7X/hVUvjveW/6r5c8ye+GvqGGWKEQkeR9VMTSQMz5u+i9e7QmBrSBECp
         qn9334NEf+qJOBN2ogTGJObxmxnt5ObtHhg0qFYoM6CEjll8lqGOzn4dP1jcrDX1/G
         pFDukigOXdiEw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 5/5] doc: visl: Document codec_variability parameter
Date:   Tue, 24 Oct 2023 15:09:50 -0400
Message-ID: <20231024191027.305622-6-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024191027.305622-1-detlev.casanova@collabora.com>
References: <20231024191027.305622-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 Documentation/admin-guide/media/visl.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/media/visl.rst b/Documentation/admin-guide/media/visl.rst
index 5b26fd943571..56d2e9ab72cc 100644
--- a/Documentation/admin-guide/media/visl.rst
+++ b/Documentation/admin-guide/media/visl.rst
@@ -53,6 +53,11 @@ Module parameters
   sure that, for a given input, the output frames are always exactly the same.
   This is useful for automated tests to check that output frames are correct.
 
+- codec_variability: Add codec specific variability in the ouput frames. It
+  adds a text line on the ouptut frames containing parameters that is specific
+  to the format of the input stream to ensure that different inputs do not give
+  the same output.
+
 What is the default use case for this driver?
 ---------------------------------------------
 
-- 
2.41.0

