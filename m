Return-Path: <linux-kernel+bounces-23169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2E182A890
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C375F1C228AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ACEDF5D;
	Thu, 11 Jan 2024 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oSYWWDe/"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB57DF4F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=xrO6F352bB0OQHSkJm
	YMF2mTT4CT2aJj50jk7PWpqVk=; b=oSYWWDe/6x9DkJ2/8b07CWbiH8k4Ll+L+N
	nWIZ/gPhr814FoAslMJ1y4e2Qw75nWT0wWUzdEhvlBVLK87m1+kekwFdN9KsM48x
	ZKUE524zecBz9eBlXcuaNLfR/5SZtiulekypNWBN15Sl89DtfCz3ZwoqkxWL3TWf
	6/l9ffsbg=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDnjxFQnp9lGeMPAA--.3951S2;
	Thu, 11 Jan 2024 15:52:49 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	GuoHua Chen <chenguohua_716@163.com>
Subject: [PATCH] drm/radeon: Clean up errors in ni_dpm.c
Date: Thu, 11 Jan 2024 07:52:46 +0000
Message-Id: <20240111075246.11027-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDnjxFQnp9lGeMPAA--.3951S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw15ur4fJr15Jw4UAr43ZFb_yoWDJrX_WF
	18Z392ga9xuF9Ygr43Aa1qyFy2vFW5uw4kur4xKa13tFyUWF1kZF9xK340qr45AFs7AF95
	K3y7XFW3A3Z3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUZXo7UUUUU==
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEBRi1mVOBk7vVAAAso
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: space prohibited before that ',' (ctx:WxV)
ERROR: space required after that ',' (ctx:WxV)

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/atom-bits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/atom-bits.h b/drivers/gpu/drm/radeon/atom-bits.h
index e8fae5c77514..2bfd6d0ff050 100644
--- a/drivers/gpu/drm/radeon/atom-bits.h
+++ b/drivers/gpu/drm/radeon/atom-bits.h
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


