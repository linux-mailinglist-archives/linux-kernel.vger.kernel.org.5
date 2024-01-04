Return-Path: <linux-kernel+bounces-16796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6123E8243F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3EB31F249E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2692375A;
	Thu,  4 Jan 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OwgrRQ0r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BB623741
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704379195;
	bh=LwJiWNixgLxt6lWwrlS02C+4POupia0P98Da0BOUfU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OwgrRQ0rIDcc/jUhiQv/PCwYmkZNCxYNoy5da/8UTYUGsfAetij6ESu41hWpT1oDb
	 LmiUYP4ljJJkyONMuLwqiM7bFOYZHW7/MXHqZh6r9jlgh4FQv9/8F376VIVCrxM5gE
	 QE8n9xStFBpK1KS2EOfXqRBR7Eut5dmc37QM5stdlhqHX7hPMN/XrgUbA648f9MP8x
	 DiOZEXiQge4FSZMPm+vfoWNSKRDWvL9JHkjW5ZXqmZqV0sctX9e2uiuSRffCH/gFeu
	 Ipaqr2E/Ezy5HiF3wko5tNF2J6dhQkFwSEbbOR3GgGue6Jnfr8DOibb3r6WrvoxMmz
	 6GY0PHjmz1Z0Q==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B9BB4378201D;
	Thu,  4 Jan 2024 14:39:54 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH] drm/rockchip: vop2: Drop unused if_dclk_rate variable
Date: Thu,  4 Jan 2024 16:39:50 +0200
Message-ID: <20240104143951.85219-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104143951.85219-1-cristian.ciocaltea@collabora.com>
References: <20240104143951.85219-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
introduced a variable which ended up being unused.  Remove it.

rockchip_drm_vop2.c:1688:23: warning: variable ‘if_dclk_rate’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 44508c2dd614..923985d4161b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1685,7 +1685,6 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
 	unsigned long dclk_core_rate = v_pixclk >> 2;
 	unsigned long dclk_rate = v_pixclk;
 	unsigned long dclk_out_rate;
-	unsigned long if_dclk_rate;
 	unsigned long if_pixclk_rate;
 	int K = 1;
 
@@ -1700,7 +1699,6 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
 		}
 
 		if_pixclk_rate = (dclk_core_rate << 1) / K;
-		if_dclk_rate = dclk_core_rate / K;
 		/*
 		 * *if_pixclk_div = dclk_rate / if_pixclk_rate;
 		 * *if_dclk_div = dclk_rate / if_dclk_rate;
-- 
2.43.0


