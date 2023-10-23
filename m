Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966EC7D3FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjJWTAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjJWS77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:59:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E566127;
        Mon, 23 Oct 2023 11:59:57 -0700 (PDT)
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 633EA6606F65;
        Mon, 23 Oct 2023 19:59:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698087596;
        bh=o/FJjn4TuWXT7bS3XgNkUnwd6rBIim2FWrvD+41vxVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1JUMANzmSqA47TMmJoq35jq0eTArY3BoQtThoElSUcnmlwW3VPXsjAh7n3p8ITE9
         wM6eBUSvFvXpzwZjq1rD42FgD0FehFGycbLj1IN7EWip7J5DMX+U69vadO6nZHdbnV
         d0a55LNW1EGOiJ1yG6ifc7yR241rQ+rBoUF/6x3xl+qC//M78RDb70bfhdtTIOnf9x
         1ktqfDlYbPOEI8GjuRXUC9zlAdAw6fYhwkF/aFuHlK58fS7D2Zp9tUm9nl+pNtbzwj
         Cc51ytmyU5btLfjTVdobJhrkm1RzXztWsL4n+/dn50UGSU+O8zMcr+/KaTVQLxqhLh
         452uVqmQHdm9g==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 5/5] doc: visl: Document codec_variability parameter
Date:   Mon, 23 Oct 2023 14:58:25 -0400
Message-ID: <20231023185850.67082-6-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023185850.67082-1-detlev.casanova@collabora.com>
References: <20231023185850.67082-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

