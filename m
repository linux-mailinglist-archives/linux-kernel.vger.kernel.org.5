Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E998A7DC095
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjJ3TeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3TeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:34:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F96CC;
        Mon, 30 Oct 2023 12:34:00 -0700 (PDT)
Received: from arisu.hitronhub.home (unknown [23.233.251.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6DFDD6607394;
        Mon, 30 Oct 2023 19:33:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698694439;
        bh=+KcBfZwgXPJhqinSYs4xXnlKFE8JG3Ctt44QFVgA2pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HM3bxqghEy6IGnMvXXpTAOKZha2wgv1BmNNVSXVpLQBt8uGoL+jEGbgwVgHJZTPBp
         0vCW0OqoAkaRcz7RN/eOTMuYWxa89XIQ1ic9fRrxUXBWmsreSjLiT8T0+hFz1CpG5q
         YC/H9xwgdKUwyn53z85gLAw4/B+ovRI1IneUqGUFgt8wnq1TIGcvqbvp9/fYXOnuDn
         t0LdvzyAdRtlpPteddFwxrQkrqJczEjTGqk5FiEU+LCvI4rORT+VRk1t6hZyBVcS8C
         sTBykmw/3zUhOvfiGqH6PPZjPVLPUFg8ST5a79z4UbqxrP+QHqpVvuuMVCLWaVXUV/
         eALr3dtvsc0yg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 2/2] doc: visl: Add AV1 support
Date:   Mon, 30 Oct 2023 15:27:56 -0400
Message-ID: <20231030193406.70126-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231030193406.70126-1-detlev.casanova@collabora.com>
References: <20231030193406.70126-1-detlev.casanova@collabora.com>
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

Add AV1 information in visl documentation.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 Documentation/admin-guide/media/visl.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/media/visl.rst b/Documentation/admin-guide/media/visl.rst
index 7d2dc78341c9..64229857c17c 100644
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
 
         $ ls /sys/kernel/debug/tracing/events/ | grep visl
+        visl_av1_controls
         visl_fwht_controls
         visl_h264_controls
         visl_hevc_controls
-- 
2.41.0

