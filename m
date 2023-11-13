Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7887EA04B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjKMPl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjKMPlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:41:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B64172A;
        Mon, 13 Nov 2023 07:41:17 -0800 (PST)
Received: from arisu.mtl.collabora.ca (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 398E66606F5E;
        Mon, 13 Nov 2023 15:41:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699890076;
        bh=Kpz4GbzKraVfywCJCP/gIgyjQGH1m53lANmGVN3Ca1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1weaeghfmY+NVJkA9VNXL4CfAxbT7HnnnxSm0tKoVxkI5OpG6mN99k83y2d7MXHL
         fkKKoFRy4BrNV20P0NGv95mgca6N0nyqdSJC8zg/LszT7ML78hAhHJ5MExAymCFXZt
         u8zVLNsHgrNQ/JBoDZdtVr26HO336A5/YBRlz1lCnrmskyhTfsSxNV0Qrbpq3Ra/Yt
         1ejVsP7Gq5Bl20kS67zFW5jCO9LyPIAREU3gmyeryGQNbhhigswKe8MRmlCtfgYGdJ
         XdhEwVJ8apVmhs6ky6l8oEV5JLQzzwO/+ZMcCXoc5WfbCXI9FZaGiqyqKi/+QwvykQ
         3NGd8qo99wN2g==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 2/2] doc: visl: Add AV1 support
Date:   Mon, 13 Nov 2023 10:39:59 -0500
Message-ID: <20231113154109.114488-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113154109.114488-1-detlev.casanova@collabora.com>
References: <20231113154109.114488-1-detlev.casanova@collabora.com>
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

Add AV1 information in visl documentation.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 Documentation/admin-guide/media/visl.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/media/visl.rst b/Documentation/admin-guide/media/visl.rst
index 4328c6c72d30..db1ef29438e1 100644
--- a/Documentation/admin-guide/media/visl.rst
+++ b/Documentation/admin-guide/media/visl.rst
@@ -71,6 +71,7 @@ The following codecs are supported:
 - VP9
 - H.264
 - HEVC
+- AV1
 
 visl trace events
 -----------------
@@ -79,6 +80,7 @@ The trace events are defined on a per-codec basis, e.g.:
 .. code-block:: bash
 
         $ ls /sys/kernel/tracing/events/ | grep visl
+        visl_av1_controls
         visl_fwht_controls
         visl_h264_controls
         visl_hevc_controls
-- 
2.41.0

