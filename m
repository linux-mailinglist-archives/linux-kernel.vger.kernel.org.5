Return-Path: <linux-kernel+bounces-22939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A485F82A5B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FFFDB237D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B634BEC9;
	Thu, 11 Jan 2024 01:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="AuZFHS7M"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147CBEBB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=9aR55xkwecnRVJ0nnM
	w73iproCVEKWqgG1rUjSYKFBg=; b=AuZFHS7MqHdcUB1kQ9Q0cdu9sPeOr6yEyS
	bOmbVOaZi4gUDoajsT8nD6YRgeVX9X37NHlN3l0mf6iX0/B78w3R0TG9Waf0kKQ9
	QrD9+nLkge4hP9dIFbzqTw3bwYIT1V58zztzPFMKAZEzUpNk9rewhrXhdt7ITcNS
	czw5X8BiA=
Received: from localhost.localdomain (unknown [182.148.14.173])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wD3fzFmSp9l3IAsAA--.46727S2;
	Thu, 11 Jan 2024 09:54:46 +0800 (CST)
From: chenxuebing <chenxb_99091@126.com>
To: christian.koenig@amd.com,
	airlied@gmail.com,
	alexander.deucher@amd.com,
	Xinhui.Pan@amd.com,
	daniel@ffwll.ch
Cc: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	chenxuebing <chenxb_99091@126.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in navi10_ih.c
Date: Thu, 11 Jan 2024 01:54:42 +0000
Message-Id: <20240111015442.5343-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3fzFmSp9l3IAsAA--.46727S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWDZrWxuFW8uFW5Jw4DCFg_yoWfGFb_Cr
	W8AryfXr12vF1qqrn8Ar4Yv34kKF1F9rs3W342qFnayryUZr4rAa1qgryYqayruF43Wasx
	Jrn8WF1YywnxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUrHUDUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiOgtixWVEuXlrAAAAsc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line

Signed-off-by: chenxuebing <chenxb_99091@126.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index e64b33115848..57d04ed20357 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -722,8 +722,7 @@ static void navi10_ih_set_interrupt_funcs(struct amdgpu_device *adev)
 		adev->irq.ih_funcs = &navi10_ih_funcs;
 }
 
-const struct amdgpu_ip_block_version navi10_ih_ip_block =
-{
+const struct amdgpu_ip_block_version navi10_ih_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_IH,
 	.major = 5,
 	.minor = 0,
-- 
2.17.1


