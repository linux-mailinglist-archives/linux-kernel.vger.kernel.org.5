Return-Path: <linux-kernel+bounces-23004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C59A82A645
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260641F22DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28DE15D5;
	Thu, 11 Jan 2024 02:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Q+NG9STZ"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8677115A1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=V6R35R0+952N1XFVaV
	VFcQufmJRU97VsQf0bdd0bwRg=; b=Q+NG9STZKl5fZ/FZ1NJwn1EmYV+TLoFw5K
	Dz6IWgKX5ArPEMLqJIDXf4PlDxGvJmwbgZ/Cwvq6L1cm72vi2JMGChPH0iVyWEN2
	maoR6o0U4GaiV4r/fgmGMa+Jxm+KZPl88wmmiLEnZEQIq7gQsw7RmyPXpN85LW85
	DKDSxgABw=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wD3P8JsWZ9lkFcuAA--.19717S2;
	Thu, 11 Jan 2024 10:58:52 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	airlied@gmail.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in atom-bits.h
Date: Thu, 11 Jan 2024 02:58:50 +0000
Message-Id: <20240111025850.6778-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3P8JsWZ9lkFcuAA--.19717S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw15Gw1kWw47JF1UCw4rKrg_yoWftFX_C3
	WUZ392ga45WFyvkr1ay34qyFy2vFy5uan5Xr48Ka1ayF15Gr1DX3sIgryvqr1ruFs7CF95
	Ga1fXFW5A3ZxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR_OzPUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOhlixWVEuXqx0gABsE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: space prohibited before that ',' (ctx:WxV)

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/include/atom-bits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atom-bits.h b/drivers/gpu/drm/amd/include/atom-bits.h
index e8fae5c77514..2bfd6d0ff050 100644
--- a/drivers/gpu/drm/amd/include/atom-bits.h
+++ b/drivers/gpu/drm/amd/include/atom-bits.h
@@ -33,7 +33,7 @@ static inline uint8_t get_u8(void *bios, int ptr)
 #define CU8(ptr) get_u8(ctx->bios, (ptr))
 static inline uint16_t get_u16(void *bios, int ptr)
 {
-    return get_u8(bios ,ptr)|(((uint16_t)get_u8(bios, ptr+1))<<8);
+    return get_u8(bios, ptr)|(((uint16_t)get_u8(bios, ptr+1))<<8);
 }
 #define U16(ptr) get_u16(ctx->ctx->bios, (ptr))
 #define CU16(ptr) get_u16(ctx->bios, (ptr))
-- 
2.17.1


