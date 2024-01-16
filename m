Return-Path: <linux-kernel+bounces-27723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CF182F4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5E31F2573C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374621CF9A;
	Tue, 16 Jan 2024 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XUo49PwV"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025A1CF96
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431572; cv=none; b=c9bHHkKMGmWeLuZXs7JFflZN4ArPxloCd3kLHIDGrkoSrpuWJHGekJwq6P5Kr6nxcfPYhl19khUrDTa5PfQWGTm9QkNc4i8UoG23kvaZRBYYRERdx0Cexpm4vFCRCVHUpYFUv7A2wHNbk3lwG0LA9dXTI/ux9zuXiPv17XLOwFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431572; c=relaxed/simple;
	bh=gkyZzKo67p/K4XJ/v/j2QoEZUBgFvMHFIhSYARSxsVc=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=hOgtp/C2P7fTPqEAoeLi7SVQpSyB9LlyYIN3qxwWx46iRL8+TZ88kt+YanR+hCT7ZomLbmGcZ2SBfVhM4HlMAx6Ner8/aLePz+IOg1PhNwbphiCGf4a6m+qemeVrrRxocM7uQkv9uL5pqSS+tjSheneOHVR4LMRFJWhN3pKMZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XUo49PwV; arc=none smtp.client-ip=203.205.221.231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705431560; bh=eU+5dXg85Q+B81rY0M0vNH6+0V5kiwkRjQQOQ1SSHXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XUo49PwVC2aBRTKCtYmWtuep2mOnv8c3Hx9NgRkfNbqppcO5iIew7q53je3XRlpnE
	 RWUFmATSVQFgb+9t1FQUUHJ2eSQ8CB9qb1Ud+fv/pjfDF433YFkvK2mStqVzceMpLE
	 4ep8PJLFCKEp6ppdEirygVeQCQoiisXpWpqXGJXk=
Received: from cyy-pc.lan ([218.70.255.58])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id CB393AE5; Wed, 17 Jan 2024 02:50:51 +0800
X-QQ-mid: xmsmtpt1705431051t62kvvjaw
Message-ID: <tencent_8637383EE0A2C7CC870036AAF01909B26A0A@qq.com>
X-QQ-XMAILINFO: OXUTDCKaRCI/pPaxgHCPsD+M4r1SEnCJrBxnBy7Ka/EB+lId5sgWUrLuwKK82z
	 /DpM7g9jLXDIjKq4ic6w2U8cnSgaZgQgrYb+9su1bhY+dbfzG0zYXESNcnTxko0ApvwdfRG1pcjf
	 +hvgdXiwdZtqNOYNSqPkexn4cIR81SX/ApJ/48521J7hjEDdtKfF4lkmSxSR+Gq3hiNxOsOoZBT8
	 nIWsYd2E2F/1s1vooCMFYkt96jL1WB3tU6LKmu5Z5LTTTLAC6OSPzZ0Y4WpbYxnAIvQIAqoiyOct
	 I4H/t6hiSolUPfnJUsPc8sG+ER9DptBzHe/2rhDdqzLkAtaoqy7POSaxaiK5NoRNChMpzXqAXU1r
	 u6tmaxQxMI+ZRFoINfnp/hITYqMYlLib9LsKrXd2BFl8RnpOBG7/RT4XNnHDE5k4KjhRyujVTMz+
	 i/4txcNwwEIXau5hg/XMa+bcZZskdMGHhGPB6Zd2d3HwXcqmZbz8ygtNwdf020KkAVeOlHUpvGgM
	 rVpX0LAC49wdYnaLwyOwpT1cscby9faywQkKF+O4ymZiIoUVICqsb0LEKEXrps1ZsuJIbHBPbUac
	 dcP5YNl1ed+pdbZx/gRWmlAGTfTaIvxgiI719hQs0UkFileTmc21cyjjNysxShQbulWEX0Xq+tDM
	 auxhwKDVuelidp1XwYt3obbD06gnQidmxBIyYvcNZgeYh+OWphcGJeC7SgVtUkxKj5Qw0kW9+XfO
	 axSKgpE7swGSaDKt93e2qCrXQ56GMlERPbbYnqI3wPxp8QhuUAQ5t75ik0dODp68ReRaC9tOchqr
	 BOZqKhy11+QlAHWHL7f6CUSTOCxbVhqYlTPj2OxXadCaVfvjow/vnptWHfKEdjsfDF4DE4SY3Jfx
	 Q/fSGLf0pVG4fzfWTkl0DxAxr7EMjF3ubCW2wKqOmG0vW43tQOtZDk85vUhJOafjCrtZWwfWZ7az
	 /UjHugQO3+2o8Vg4TsIeaZoRU+7TrFEAVyrkQNbXPhS00PgfK7P1k58cqqKGegZcIrhsgLM4Q=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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
Subject: [PATCH v2 1/1] drm/ttm: allocate dummy_read_page without DMA32 on fail
Date: Wed, 17 Jan 2024 02:50:34 +0800
X-OQ-MSGID: <20240116185034.175354-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_53C5DA6E8E55B80731AE21328D037C908208@qq.com>
References: <tencent_53C5DA6E8E55B80731AE21328D037C908208@qq.com>
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
 drivers/gpu/drm/ttm/ttm_device.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index d48b39132b32..c9fa8561f71f 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -95,11 +95,17 @@ static int ttm_global_init(void)
 	ttm_pool_mgr_init(num_pages);
 	ttm_tt_mgr_init(num_pages, num_dma32);
 
-	glob->dummy_read_page = alloc_page(__GFP_ZERO | GFP_DMA32);
+	glob->dummy_read_page = alloc_page(__GFP_ZERO | GFP_DMA32 |
+					   __GFP_NOWARN);
 
+	/* Retry without GFP_DMA32 for platforms DMA32 is not available */
 	if (unlikely(glob->dummy_read_page == NULL)) {
-		ret = -ENOMEM;
-		goto out;
+		glob->dummy_read_page = alloc_page(__GFP_ZERO);
+		if (unlikely(glob->dummy_read_page == NULL)) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		pr_warn("Using GFP_DMA32 fallback for dummy_read_page\n");
 	}
 
 	INIT_LIST_HEAD(&glob->device_list);
-- 
2.43.0


