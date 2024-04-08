Return-Path: <linux-kernel+bounces-135786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FC189CB3A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2876F1F27D01
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD8B14600C;
	Mon,  8 Apr 2024 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JYtx2mPX"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8727D145B17
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598803; cv=none; b=pWaitTf4uREZeQjty2hwTV7GWvzDQxDzFwVIw/ehxQ99grbNqfVvLOMomP60o2jH9ew0+yZTyD1MhInQ5vslNSq4c9FhIrsd4fQ1dZDxng4mXa+bJr5IZY+7JIVmmIhtk+OyaBItuMCSGzmEevlQL1/Dw/eCZ0ADk9JP3NiE98Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598803; c=relaxed/simple;
	bh=g25hNBF6/2ZvrUwCgI3AgRwG2o0NcE1IyQw6SZQaZ7Y=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Y+NCtB86UsOkF2OLKc8WvOhQqcxOqh3krn/dk+9mTBhX3J1UCzX1diCUsX0rfsGkZ1vi4y4xAWFDf+JMAWO5a0uvcTD+7EEtfLZsFoBaIeoNs9Cklt6dhh+uXC59i9Iw9DmhU1aMZGomxgS+T3NNchhYr/lYlJu6psu8WDNJlmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JYtx2mPX; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712598797; bh=Pps4HsLgFHLx122khZoFNB9+hWAVJVChvnEPFqxgolA=;
	h=From:To:Cc:Subject:Date;
	b=JYtx2mPX006rbKJCRQWpi9GkBT+wNuv9zVL7RvY7dy33IOLN1QavdCokPVshyu2IC
	 fItR6fwVQ7/LrS9IrjLZFP0Slj24ueib9Ti9x0AmocHtIK2vs9rtPnRs9YBJgKE7W5
	 6o1cZgYRiLadM0Sm3nBoDfzo5j9F4DLw4V+kgrIo=
Received: from b.. ([111.45.33.200])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id D2B0006C; Tue, 09 Apr 2024 01:52:43 +0800
X-QQ-mid: xmsmtpt1712598763t0rn2vgkn
Message-ID: <tencent_9949E2F260D801549611A452B52FC112F009@qq.com>
X-QQ-XMAILINFO: OdDhBiKk1LgMmeqTxzAoEjqQRh7T+DCyVeh1exnmT20HYw7qVIcrsV/TyrhQyI
	 aJr1NuytaezlNYKp2TA2+EAII7aItDvhhtimtfLvM8L7re7Es292gZ2JmBzd7hEK1K1WJyjbHlZC
	 6Onka8U2lusbJ0AxUv2ts2r6aTko1Ca2flXNy726IsuheoO1e7W8Gpj8xTyCkHAtelestFOiwDRa
	 X15GZA6kJPkZXwVqPYR5EuRQ8egv7PiYDeMewZAUTntzfCgMzAQnOHKY7whkvVIzyWSeiOiOo8BH
	 yMxJNKLNMFyUNFI1B49dCiANMF56Bs9FTHG/yC0MwbSWBBBq3lHhaNJTO6r9hzW6OYcXJzLfq56f
	 XTfWZJtzjn169mx+TL5tZnwr6p4RUXxqeNasqzcJO65as9I8DCY1p/tiP15RvAOOLG3ZsmZcUT8y
	 3P+ijqDHbq9N90GkJU+dSSaR1TNRoKeBRQGKsrbUoHvJOSUdXv/5XHJlkjFoltTxwnfJcfAu71Kv
	 +EPHNTmyPmCLBeqyYaJOwm8y2n7vAxXuFsjjmoVMCZ7tm6JwWXJC/lFiqRz7txWVyf8XLob2JUIm
	 kOFNrna82bari7KP/tMeRPLkLt1ttdg+7o3E3BhKDyHViASfUenLn5vMbnUS9AK9KDdgBZdiXr3B
	 udP0XDKhCrbwDB8kLSnnXC1wrDDLRJBc6PM89mLMFVXzLg9OlbCI+KqLCYuvIqqJwWNXVLwc1+cd
	 1rqRgYjMdg5LT1lEAbqneYKv/yoMSeN1V7aiTf8jPJSnFnYyLnU1NWqFvtMSx1eKTTmnx4ihI19I
	 zkKwBjt9kOTkDjJolOXZc/iZzbZjsJVm3xOUOK+IHYhw6NDrVCblw5ikOLs0vNI+WVjROpPb4HKd
	 zrHxBmO537uus/rcVOthfz4oFC2d20Eq0S9ojyDOEjsFlf00m59PtWKoLy6ekVOrm1ZZ3XHpvDo9
	 dJ0xKdPqQ=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: brolerliew <575705195@qq.com>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	luben.tuikov@amd.com,
	brolerliew <brolerliew@gmail.com>,
	brolerliew <575705195@qq.com>
Subject: [PATCH] drm/amdgpu: remove "num_pages" local variable in amdgpu_gtt_mgr_new
Date: Tue,  9 Apr 2024 01:52:42 +0800
X-OQ-MSGID: <20240408175242.613724-1-575705195@qq.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: brolerliew <brolerliew@gmail.com>

amdgpu_gtt_mgr_new and ttm_range_man_alloc share similar logic, but
"num_pages" in amdgpu_gtt_mgr_new is defined as local variable which
is calculate directly in ttm_range_man_alloc.

Signed-off-by: brolerliew <575705195@qq.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 44367f03316f..0c56e4057d85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -116,7 +116,6 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_manager *man,
 			      struct ttm_resource **res)
 {
 	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
-	uint32_t num_pages = PFN_UP(tbo->base.size);
 	struct ttm_range_mgr_node *node;
 	int r;
 
@@ -134,7 +133,7 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_manager *man,
 	if (place->lpfn) {
 		spin_lock(&mgr->lock);
 		r = drm_mm_insert_node_in_range(&mgr->mm, &node->mm_nodes[0],
-						num_pages, tbo->page_alignment,
+						PFN_UP(node->base.size), tbo->page_alignment,
 						0, place->fpfn, place->lpfn,
 						DRM_MM_INSERT_BEST);
 		spin_unlock(&mgr->lock);
-- 
2.40.1


