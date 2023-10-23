Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2077D3FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjJWTAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjJWS75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:59:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C576D68;
        Mon, 23 Oct 2023 11:59:55 -0700 (PDT)
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A1CED66072AE;
        Mon, 23 Oct 2023 19:59:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698087594;
        bh=mp7PyZ9vAaUjeaw4jeF18DYXuzZrzrZrcZ2nFtR0WBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OzUlubulWrTJ6ypilllWJ7PmMBaqM34nB/uJHxJSicO162mhOgKZvMhNAGuUXn0ka
         ll701p2w1nL9LcthUT8LXDEwJFgd78KRH4jmayCLDPhzHlykA+yUoW3WDt3cyuFyYT
         eMVENCiWEitdGdD1ezy9GkoJ7aIAvF/I8YKqc3r1fxM66zOvg6U5A+/s13KKA400hZ
         +WNP/zUimJT4Llm8VxbQWFlsX5RVjAhLBjKklTPkkUDYAxvkuHJrFVDhu5v/5T7SQq
         0Vry0568AL+bWRJcItyA40nppHTR0kRmzmHBMABV6cnj6sCsTg0xEgKP8/l/vpICag
         gQMGH2t9ofsfg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 3/5] doc: visl: Document stable_output parameter
Date:   Mon, 23 Oct 2023 14:58:23 -0400
Message-ID: <20231023185850.67082-4-detlev.casanova@collabora.com>
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
 Documentation/admin-guide/media/visl.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/media/visl.rst b/Documentation/admin-guide/media/visl.rst
index 7d2dc78341c9..5b26fd943571 100644
--- a/Documentation/admin-guide/media/visl.rst
+++ b/Documentation/admin-guide/media/visl.rst
@@ -49,6 +49,10 @@ Module parameters
   visl_dprintk_frame_start, visl_dprintk_nframes, but controls the dumping of
   buffer data through debugfs instead.
 
+- stable_output: Limit the information written on each output frame to make
+  sure that, for a given input, the output frames are always exactly the same.
+  This is useful for automated tests to check that output frames are correct.
+
 What is the default use case for this driver?
 ---------------------------------------------
 
-- 
2.41.0

