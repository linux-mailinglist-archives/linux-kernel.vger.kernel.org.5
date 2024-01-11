Return-Path: <linux-kernel+bounces-23100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C96882A7A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51AA28A77B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222BEDDB3;
	Thu, 11 Jan 2024 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="myfp5jWt"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AB1D292
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=t732zg/+MQiSxojyTX
	cqVLEyzZ2m2fg7s1KLd4hC/uA=; b=myfp5jWtvkRf7tSvYoWsZLGpXR8eSsF0yU
	undp5bmE5dYG69ZuItk7zNiM1oeFEiUlOiIy60oMak4fTAEPU66N3pwy/mhaxm6/
	VTYx3796wcy+dTfYj7PwN0Say3+iNnWEwlWRkCuPBXazE34MuIU/3MJixQmsakyw
	clIOJv+jY=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wD3P9iZi59lDsoyAA--.41287S2;
	Thu, 11 Jan 2024 14:32:57 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: airlied@gmail.com,
	christian.koenig@amd.com,
	daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amd/include/vega20_ip_offset: Clean up errors in vega20_ip_offset.h
Date: Thu, 11 Jan 2024 06:32:56 +0000
Message-Id: <20240111063256.8610-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3P9iZi59lDsoyAA--.41287S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XrW3XFW3tF43WFy5WF4xXrb_yoWxZrWDpF
	y5J34UGF409345JF13Jw1UGr45Jr4qyFyUtr1Utw13Jw1YqF1kJrn5tr48Ja1rGFy3Ka47
	GF1kArWUXw4DWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UUxhLUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOhtixWVEuX4KIAAAsK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line
ERROR: spaces required around that '=' (ctx:WxV)

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 .../gpu/drm/amd/include/vega20_ip_offset.h    | 78 +++++++++----------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/vega20_ip_offset.h b/drivers/gpu/drm/amd/include/vega20_ip_offset.h
index 1deb68f3d334..92cf2d9e767f 100644
--- a/drivers/gpu/drm/amd/include/vega20_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/vega20_ip_offset.h
@@ -25,139 +25,137 @@
 #define MAX_SEGMENT                                        6
 
 
-struct IP_BASE_INSTANCE
-{
+struct IP_BASE_INSTANCE {
     unsigned int segment[MAX_SEGMENT];
 };
 
-struct IP_BASE
-{
+struct IP_BASE {
     struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
 } __maybe_unused;
 
 
-static const struct IP_BASE ATHUB_BASE            ={ { { { 0x00000C20, 0, 0, 0, 0, 0 } },
+static const struct IP_BASE ATHUB_BASE = { { { { 0x00000C20, 0, 0, 0, 0, 0 } },
+                                         { { 0, 0, 0, 0, 0, 0 } },
+                                         { { 0, 0, 0, 0, 0, 0 } },
+                                         { { 0, 0, 0, 0, 0, 0 } },
+                                         { { 0, 0, 0, 0, 0, 0 } },
+                                         { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE CLK_BASE  = { { { { 0x00016C00, 0x00016E00, 0x00017000, 0x00017200, 0x0001B000, 0x0001B200 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE CLK_BASE            ={ { { { 0x00016C00, 0x00016E00, 0x00017000, 0x00017200, 0x0001B000, 0x0001B200 } },
+static const struct IP_BASE DCE_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0, 0, 0 } },
+                                       { { 0, 0, 0, 0, 0, 0 } },
+                                       { { 0, 0, 0, 0, 0, 0 } },
+                                       { { 0, 0, 0, 0, 0, 0 } },
+                                       { { 0, 0, 0, 0, 0, 0 } },
+                                       { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE DF_BASE = { { { { 0x00007000, 0, 0, 0, 0, 0 } },
+                                      { { 0, 0, 0, 0, 0, 0 } },
+                                      { { 0, 0, 0, 0, 0, 0 } },
+                                      { { 0, 0, 0, 0, 0, 0 } },
+                                      { { 0, 0, 0, 0, 0, 0 } },
+                                      { { 0, 0, 0, 0, 0, 0 } } } };
+static const struct IP_BASE FUSE_BASE = { { { { 0x00017400, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE DCE_BASE            ={ { { { 0x00000012, 0x000000C0, 0x000034C0, 0, 0, 0 } },
+static const struct IP_BASE GC_BASE = { { { { 0x00002000, 0x0000A000, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE DF_BASE            ={ { { { 0x00007000, 0, 0, 0, 0, 0 } },
+static const struct IP_BASE HDP_BASE = { { { { 0x00000F20, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE FUSE_BASE            ={ { { { 0x00017400, 0, 0, 0, 0, 0 } },
+static const struct IP_BASE MMHUB_BASE = { { { { 0x0001A000, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE GC_BASE            ={ { { { 0x00002000, 0x0000A000, 0, 0, 0, 0 } },
+static const struct IP_BASE MP0_BASE = { { { { 0x00016000, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE HDP_BASE            ={ { { { 0x00000F20, 0, 0, 0, 0, 0 } },
+static const struct IP_BASE MP1_BASE = { { { { 0x00016000, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE MMHUB_BASE            ={ { { { 0x0001A000, 0, 0, 0, 0, 0 } },
+static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE MP0_BASE            ={ { { { 0x00016000, 0, 0, 0, 0, 0 } },
+static const struct IP_BASE OSSSYS_BASE = { { { { 0x000010A0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE MP1_BASE            ={ { { { 0x00016000, 0, 0, 0, 0, 0 } },
+static const struct IP_BASE SDMA0_BASE = { { { { 0x00001260, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE NBIO_BASE            ={ { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0, 0 } },
+static const struct IP_BASE SDMA1_BASE = { { { { 0x00001860, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE OSSSYS_BASE            ={ { { { 0x000010A0, 0, 0, 0, 0, 0 } },
+static const struct IP_BASE SMUIO_BASE = { { { { 0x00016800, 0x00016A00, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE SDMA0_BASE            ={ { { { 0x00001260, 0, 0, 0, 0, 0 } },
+static const struct IP_BASE THM_BASE = { { { { 0x00016600, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE SDMA1_BASE            ={ { { { 0x00001860, 0, 0, 0, 0, 0 } },
+static const struct IP_BASE UMC_BASE = { { { { 0x00014000, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE SMUIO_BASE            ={ { { { 0x00016800, 0x00016A00, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE THM_BASE            ={ { { { 0x00016600, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE UMC_BASE            ={ { { { 0x00014000, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } },
-                                        { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE UVD_BASE            ={ { { { 0x00007800, 0x00007E00, 0, 0, 0, 0 } },
+static const struct IP_BASE UVD_BASE = { { { { 0x00007800, 0x00007E00, 0, 0, 0, 0 } },
                                         { { 0, 0x00009000, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
 /* Adjust VCE_BASE to make vce_4_1 use vce_4_0 offset header files*/
-static const struct IP_BASE VCE_BASE            ={ { { { 0x00007E00/* 0x00008800 */, 0, 0, 0, 0, 0 } },
+static const struct IP_BASE VCE_BASE = { { { { 0x00007E00/* 0x00008800 */, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE XDMA_BASE            ={ { { { 0x00003400, 0, 0, 0, 0, 0 } },
+static const struct IP_BASE XDMA_BASE = { { { { 0x00003400, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE RSMU_BASE            ={ { { { 0x00012000, 0, 0, 0, 0, 0 } },
+static const struct IP_BASE RSMU_BASE = { { { { 0x00012000, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
                                         { { 0, 0, 0, 0, 0, 0 } },
-- 
2.17.1


