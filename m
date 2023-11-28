Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85547FC310
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbjK1S0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjK1S0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:26:41 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF5C1A5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:26:46 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f4d4:eef9:4487:4eb1])
        by andre.telenet-ops.be with bizsmtp
        id FuSe2B00E2jytoH01uSec1; Tue, 28 Nov 2023 19:26:44 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1r82ms-00AHWm-F7;
        Tue, 28 Nov 2023 19:26:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1r82n8-00B9me-GS;
        Tue, 28 Nov 2023 19:26:38 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Nas Chung <nas.chung@chipsnmedia.com>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH -next] media: chips-media: VIDEO_WAVE_VPU should depend on ARCH_K3
Date:   Tue, 28 Nov 2023 19:26:36 +0100
Message-Id: <eb27184d182811520de31e59f449ea49e7cc6963.1701195705.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Chips&Media Wave 5 Series multi-standard codec IP is currently only
supported on Texas Instruments K3 J721S2 SoC.  Hence add a dependency on
ARCH_K3, to prevent asking the user about this driver when configuring a
kernel without Texas Instruments K3 Multicore SoC support.

Fixes: 9707a6254a8a6b97 ("media: chips-media: wave5: Add the v4l2 layer")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/media/platform/chips-media/wave5/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/chips-media/wave5/Kconfig b/drivers/media/platform/chips-media/wave5/Kconfig
index 77e7ae5c8f35f454..9ccc1f7e32f3874f 100644
--- a/drivers/media/platform/chips-media/wave5/Kconfig
+++ b/drivers/media/platform/chips-media/wave5/Kconfig
@@ -3,6 +3,7 @@ config VIDEO_WAVE_VPU
 	tristate "Chips&Media Wave Codec Driver"
 	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && OF
+	depends on ARCH_K3 || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
 	select VIDEOBUF2_VMALLOC
 	select V4L2_MEM2MEM_DEV
