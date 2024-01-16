Return-Path: <linux-kernel+bounces-27072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD05982EA00
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC632833CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289B31118F;
	Tue, 16 Jan 2024 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="G38fTUco"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A811181
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705389924; bh=ZTnSJxE23Nw64lBhpFMiDwgBba+3N2Q91LfEvH/xgy8=;
	h=From:To:Cc:Subject:Date;
	b=G38fTUcoKNLSZd/QUBsWbCN/RnPFaiNfIYw18aeBSLdQUIRkuDB/RPJofM8J+aaI4
	 f85uc3qsOEtWcRmqRRFREBHHPH8w17O4/+SzyYhRHMo3Nka16AdWCpaFDdjR0OlMRE
	 Z0mYZl5oxZbkU9So7i1fRlgeuWG0YR+70RmLvqbs=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 651A00DE; Tue, 16 Jan 2024 15:25:17 +0800
X-QQ-mid: xmsmtpt1705389917t93fy8ema
Message-ID: <tencent_0B319B215E8D487CC082C0DA5E8E46B86B08@qq.com>
X-QQ-XMAILINFO: Mk33QmgWauDsVhZvDrj7M3dssC3UeSG28JJBftbgZZxw/z6e0XiKTnW6dUZ7ub
	 q4us9jOKT7MYrIpaxAp7A0JRfI0iTENFWvZCGJp7KoV736goBQFeEBtW6xmkl3opdSb9131K+bwo
	 skscGb5PaYHkklbTch8emcjsdSZ/CEna1Pc04OlqWBJ7tKAaROnot02p2pUly3jCvr3mZFPujXtD
	 MFK0TbmKyMFY7A2CaWEQVq1zx7l/E7gw4suN8RUFCIzJMJ3f905PGXWosBx57wbSGwXjZh4v9r+Z
	 0LkV/9avVPphtGQLt12EZz5W3+KoJ/0T+PqOPtkT20PuxKpKZRnjClVjzKzAd6uz3Xw2UfLgQw2B
	 ZTVHqKKNjdLA7a/IEHfyfO2hS7bl+ZS4h+T4JgGoDS4WB81HMRqOG6MrURCRbM4NFV7XEWgpE7bp
	 P1CIsQPY9YDCgRaqRWUAtrEck1Oi8m61cLmMUAflo1cfWN/peusc0YbjTX/NIuz1BgU0VXh/B7Mo
	 SOqG4hK4+PqPCMr9tNxCXvMPNMGjc3WVXZAR+BB5Rxyks+D+ZjvIwu8VNQP8LVPqNTXSfArz3fUY
	 d+AuLzIkQ6d/v6E6y14DGQvHRKx7z5tP7UVRI7M3cB/LJew4jHOnJCUC6aQwK33kpW5t2IDKWD2e
	 1ChYPRufeFC8NsiBXCXXW/8upYqOAKptW6mLfdKtJ4BdDYG1n69j9Ous5d7PqdDEZ8l3u5NeuycS
	 UWPmJKH0TmPfxTTuYtTLly2tKN7URRCHpJTllYxSdAFVwgcZgj+RR19qr2FQFw802669848wQan2
	 /WavfQo3m+cd8g7q3aI0JHafClIwOoHx/iHpx6bddDst3HPrd+5fWdvwj3D6ehZG+nqDAHNHbhEm
	 Z8QsRaxfcGI+i+/Yh4c4B9y5DVnA+mGrmtfCB5mdywA8FYD5v82QTJPi7T2ZnQEfNBk/EMye7dZ4
	 2v2E/t+guRkynBfXlF21eXMiOMfdjgd7mLxS0TqnTXOkq1OQvNcr1akSig9Pll
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yangyu Chen <cyy@cyyself.name>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jiuyang Liu <liu@jiuyang.me>,
	Yichuan Gao <i@gycis.me>,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH] drm/ttm: only use DMA32 if needed for dummy_read_page
Date: Tue, 16 Jan 2024 15:24:06 +0800
X-OQ-MSGID: <20240116072406.107206-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some platforms may not have any memory in ZONE_DMA32 and use IOMMU to allow
32-bit-DMA-only device to work. Forcing GFP_DMA32 on dummy_read_page will
fail in such platforms. Only use DMA32 when it must to get the bug
resolved.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 drivers/gpu/drm/ttm/ttm_device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index d48b39132b32..62f16fb72428 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -63,7 +63,7 @@ static void ttm_global_release(void)
 	mutex_unlock(&ttm_global_mutex);
 }
 
-static int ttm_global_init(void)
+static int ttm_global_init(bool use_dma32)
 {
 	struct ttm_global *glob = &ttm_glob;
 	unsigned long num_pages, num_dma32;
@@ -95,7 +95,8 @@ static int ttm_global_init(void)
 	ttm_pool_mgr_init(num_pages);
 	ttm_tt_mgr_init(num_pages, num_dma32);
 
-	glob->dummy_read_page = alloc_page(__GFP_ZERO | GFP_DMA32);
+	glob->dummy_read_page = use_dma32 ? alloc_page(__GFP_ZERO | GFP_DMA32) :
+					    alloc_page(__GFP_ZERO);
 
 	if (unlikely(glob->dummy_read_page == NULL)) {
 		ret = -ENOMEM;
@@ -200,7 +201,7 @@ int ttm_device_init(struct ttm_device *bdev, const struct ttm_device_funcs *func
 	if (WARN_ON(vma_manager == NULL))
 		return -EINVAL;
 
-	ret = ttm_global_init();
+	ret = ttm_global_init(use_dma32);
 	if (ret)
 		return ret;
 
-- 
2.43.0


