Return-Path: <linux-kernel+bounces-27403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4AB82EF6E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07ECAB21A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250141BDCA;
	Tue, 16 Jan 2024 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CzDoNhpN"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2A1BDC2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705410511; bh=pxcyGJeLrdotw9GYTqLreGiV8r21vRQ/d1wzlmuZ/So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CzDoNhpN5i4JVoBZ3b+82pScNQenqBc/CC9ClPWZsF8ezQaVT/zesqHe5HkLYjJwc
	 c/jU5DzQ7vANG553l6HIK8ewFaqp3k3Y0Gg91pZVmzCAtmkuSOQIToNr4PHOWNCZDk
	 gI0QoNai84PiekSK0WoJsbUxtYXc96JM/tIyoyAA=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 880E6D7; Tue, 16 Jan 2024 21:02:08 +0800
X-QQ-mid: xmsmtpt1705410128tzozwsdnv
Message-ID: <tencent_7D66A3085F83608576A8E309EE714C5CC806@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJUb+gPn8mDFbwcFcUtRNz/Q2Z7eArW6SD5oISlxsWi3jjtYgj8m
	 /t/Iq7DXN9342MVGfgi66yJcBdIUSRK5gLDF4Zg6ciFh8riHfuRKiu8xnDrmRuQsCXn7LKhcjDEC
	 oohPcP+uGHORgqGtfy+w7o6ki23FgwpXYHOYrubHrcs/UTt2Je2YySpF52T1KF/ywflT6YDtxJ96
	 jEMmBj5RKwfSHKVISNoiIcf6aOqJ4FxQtVm88wbRIKnNRtNDap9ii8dgUARiRykdTnynb547XVxm
	 bnH7T6uUJ++aVEwjYBBzcLKZwDgEB93tLwHzjZfSxz/VOPKsZMJ6vDiJwPfglzyZ82GwYYChSLDQ
	 DTZypplGiT2Huk42S9zLHVuYCoMM7XarZXHr+7blrwtYidglawixYsz+RSbSZjbndTMwolX3zKr7
	 UiIIu2mcSDlnBQ3vMGzfIEAb5VvICBt0XBibNRur8Rd1dvROh3OGJUtnPNN2zHR/ZcG9hpx5iAxm
	 d8SjsNROjaY5O0vKOOI9Hi48CQrlc4hZBCnvF3Gu3NoM69zEhUKNfBWsPLb7rCWA7Y6vt+UwBkQ2
	 npoWkDjGyZGsy7FOPupR2leiOB0SEpoeRycWVv6QhuY0hjgTeKRaL73pHcvZx9X7hr6M9fJGWX03
	 zu8pWabLdg4CqaV5dlveGuHByP3d0w4JAaqkXKo7+HMTXc1BBgBoqFfp4DLzYmzOBsC3RdOsdhHX
	 TurQYav8W5U6Q3nHVxtSWNo5SPixeETGPALVj7rBf3cSHHd4FeB2UcDHfLQDgUtnIH7um7PuYAC0
	 3WZ8XV3Y9Tj3JFQZ9xHHYMIbVxPDNnyVO9RKkidxojjeDcP4Jqu4D/Jux30eRjdjABMudwGjlfEX
	 IoL48bWLOaZ69ravZpepVmUnkEm8tN62YSiwaD687ydbUId1nnAPqyEzwJFKs3jntDMrbVXhD1vN
	 xPBpQ7cGK4BpWBxPX8XEkgs7dI2RU3krv2vyj5R2UXGEO/2bKDEjrmURs/s0uqIridolYLMNwduP
	 mxVUJ3zrfW2vamL6PU
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yangyu Chen <cyy@cyyself.name>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jiuyang Liu <liu@jiuyang.me>,
	Yichuan Gao <i@gycis.me>,
	Icenowy Zheng <uwu@icenowy.me>,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH 1/1] drm/ttm: allocate dummy_read_page without DMA32 on fail
Date: Tue, 16 Jan 2024 21:02:03 +0800
X-OQ-MSGID: <20240116130203.149635-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_40DF99E09A3681E339EE570C430878232106@qq.com>
References: <tencent_40DF99E09A3681E339EE570C430878232106@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some platforms may not have any memory in ZONE_DMA32 and use IOMMU to allow
32-bit-DMA-only device to work. Forcing GFP_DMA32 on dummy_read_page will
fail on such platforms. Retry after fail will get this works on such
platforms.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 drivers/gpu/drm/ttm/ttm_device.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index d48b39132b32..a07d9ea919b6 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -98,8 +98,13 @@ static int ttm_global_init(void)
 	glob->dummy_read_page = alloc_page(__GFP_ZERO | GFP_DMA32);
 
 	if (unlikely(glob->dummy_read_page == NULL)) {
-		ret = -ENOMEM;
-		goto out;
+		/* Retry without GFP_DMA32 */
+		glob->dummy_read_page = alloc_page(__GFP_ZERO);
+		if (unlikely(glob->dummy_read_page == NULL)) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		pr_warn("Failed to allocate dummy_read_page with GFP_DMA32, some old graphics card only has 32bit DMA may not work properly.\n");
 	}
 
 	INIT_LIST_HEAD(&glob->device_list);
-- 
2.43.0


