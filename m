Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D537F6362
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346230AbjKWPxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346219AbjKWPxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:53:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FB3D5A;
        Thu, 23 Nov 2023 07:53:38 -0800 (PST)
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D6D1E6607397;
        Thu, 23 Nov 2023 15:53:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700754817;
        bh=Kpz4GbzKraVfywCJCP/gIgyjQGH1m53lANmGVN3Ca1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKti0DFEYmHlpeXJV9noTlvtJLOAdKGuIDW8heMkGxu7Z550f30WrM3utFJSj3Moj
         Dgo0Dn2p0nBfGwOxBAePD2MM30ge8/vUy5En3m2020ipAGRgKwmWs9gI4MVmphV9mf
         jbwnDej0ntos86yjf8OzwQZiKg15KvSiaBoCwklsdFM1sowoFeUcS3BqGjxamdit2j
         pJHtg7191/pQorAMyvInpl04m0qdr6tlStsnO+w1KVciVrI2G+aNSeGP0KrHfssKdJ
         DlA/eUii0vFozE0avq14DplOwBtekUTKFuR7TYVac/hUKj0blLCTATidwkIBMXrIvi
         Rn+t8AaMKnlIA==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 2/2] doc: visl: Add AV1 support
Date:   Thu, 23 Nov 2023 10:52:26 -0500
Message-ID: <20231123155342.56277-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123155342.56277-1-detlev.casanova@collabora.com>
References: <20231123155342.56277-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

