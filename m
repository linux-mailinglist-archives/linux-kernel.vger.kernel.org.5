Return-Path: <linux-kernel+bounces-22952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22E982A5CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92ADEB20F44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FF4111E;
	Thu, 11 Jan 2024 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="T2+Ok+A4"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EEA10FD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=0kRJudjq7tmrhqObxO
	TG1bQVC/NBVuREr9lAMxPysTI=; b=T2+Ok+A4pZh7m5XiIs+3TcxbHFvTibwtKn
	P8haxL3rLaiHemOBosjbw6blR23uSuPpW1tOu7vmbNpZWzS0xCkEtsp4zuzghHvH
	1k5fRgtqR9cANB4ZyrTlX9lVGxB1NjYmBjGk82tWOBkvuM85Gd2S9FCznmiAKvip
	Jnlsqm8RU=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD334L0S59lWQGcAA--.53623S2;
	Thu, 11 Jan 2024 10:01:25 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: christian.koenig@amd.com,
	daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in amdgpu_atomfirmware.h
Date: Thu, 11 Jan 2024 02:01:23 +0000
Message-Id: <20240111020123.5523-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD334L0S59lWQGcAA--.53623S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1xWrW3Zw17ArWfAFWxtFb_yoW8GF13pF
	4rJF1UJrZ8u3WrZryUXFWkua4Dt3W0qa48KrW8ZFyYg34qvF95JFyrtF4UAr9xArW8Cw43
	JFZrA3y8Za4qvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UbF4iUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWRhixWVLYT17lQAAs6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
index c7eb2caec65a..649b5530d8ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
@@ -36,7 +36,7 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_gfx_info(struct amdgpu_device *adev);
 bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgpu_device *adev);
 bool amdgpu_atomfirmware_sram_ecc_supported(struct amdgpu_device *adev);
-bool amdgpu_atomfirmware_ras_rom_addr(struct amdgpu_device *adev, uint8_t* i2c_address);
+bool amdgpu_atomfirmware_ras_rom_addr(struct amdgpu_device *adev, uint8_t *i2c_address);
 bool amdgpu_atomfirmware_mem_training_supported(struct amdgpu_device *adev);
 bool amdgpu_atomfirmware_dynamic_boot_config_supported(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_get_fw_reserved_fb_size(struct amdgpu_device *adev);
-- 
2.17.1


