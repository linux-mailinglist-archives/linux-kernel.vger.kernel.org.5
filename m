Return-Path: <linux-kernel+bounces-23323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD9082AB0F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476E91F24317
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9BD156DA;
	Thu, 11 Jan 2024 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="YOzVROpr"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD029156D9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=riPFQzIM0RxLBVk/VT
	8AduR0Cn36/f+IWZyvzIbiXBM=; b=YOzVROprbofOruBBAQaoWV1CXrTLiWpGfC
	ekFpVev7x7ei5ifCRRQ5X+OUab1d4FEg0IkJgCeC6i/tcNorjHHdZxP3uIncr6ME
	Nxg9xtpdkV0MI2g4l0PMCbtorJzWfu56S3hImvldfFtApPmA64ACu9Gyi0m75deA
	rv0LAn25U=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3f6ubtZ9lAbY2AA--.24753S2;
	Thu, 11 Jan 2024 17:32:11 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	alexander.deucher@amd.com,
	airlied@gmail.com,
	christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] drm/radeon/dpm: Clean up errors in evergreen_smc.h
Date: Thu, 11 Jan 2024 09:32:10 +0000
Message-Id: <20240111093210.14000-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3f6ubtZ9lAbY2AA--.24753S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryxCFW5CF17Xr48uF4DJwb_yoW8Gr1kpF
	WqgryaqrWUtFnrXry8GF43ZrZ3ta9xXF18GF47Zw1Y9F45JrWxCF4DCFWrA3y8Xw47K342
	yF18tr48uF4ak3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRia9hUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOgBixWVEuYCDxQAAsD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 drivers/gpu/drm/radeon/evergreen_smc.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen_smc.h b/drivers/gpu/drm/radeon/evergreen_smc.h
index 3a03ba37d043..b34d54b567b7 100644
--- a/drivers/gpu/drm/radeon/evergreen_smc.h
+++ b/drivers/gpu/drm/radeon/evergreen_smc.h
@@ -29,8 +29,7 @@
 
 #define SMC_EVERGREEN_MC_REGISTER_ARRAY_SIZE 16
 
-struct SMC_Evergreen_MCRegisterAddress
-{
+struct SMC_Evergreen_MCRegisterAddress {
     uint16_t s0;
     uint16_t s1;
 };
@@ -38,15 +37,13 @@ struct SMC_Evergreen_MCRegisterAddress
 typedef struct SMC_Evergreen_MCRegisterAddress SMC_Evergreen_MCRegisterAddress;
 
 
-struct SMC_Evergreen_MCRegisterSet
-{
+struct SMC_Evergreen_MCRegisterSet {
     uint32_t value[SMC_EVERGREEN_MC_REGISTER_ARRAY_SIZE];
 };
 
 typedef struct SMC_Evergreen_MCRegisterSet SMC_Evergreen_MCRegisterSet;
 
-struct SMC_Evergreen_MCRegisters
-{
+struct SMC_Evergreen_MCRegisters {
     uint8_t                             last;
     uint8_t                             reserved[3];
     SMC_Evergreen_MCRegisterAddress     address[SMC_EVERGREEN_MC_REGISTER_ARRAY_SIZE];
-- 
2.17.1


