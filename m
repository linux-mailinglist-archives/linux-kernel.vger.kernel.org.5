Return-Path: <linux-kernel+bounces-136399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A0F89D3A0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F2F1F21D8F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF187D3E8;
	Tue,  9 Apr 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="h2KMpMeG"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57CA7D3EC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649497; cv=none; b=nIfUAcH/mtstA00lmxzIBE6FdUqhBeycucHUC49NOv9QyhyAPhdKIhFBdhmu8Jy8iiQ95T9vnnFQLyoXT8iJmcjcgr1VtGfEP/cO7aYrwJsaUXBGCrwcwVYrElY8oGOOLfJYGRrwR1rNn3+4TtEddBZj5jDwamZeib2yuJNpcZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649497; c=relaxed/simple;
	bh=fkQFeV62PoatkDect11xNRrrL7rSiE+jiTOmwVolER4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A9RF3eUTKyPfvTyjbZ7Dloq+t4kHbSOMyJdZRRy+8Lxw6QFpqLAQkG/QJhqaDk5kaXMcIfKQLpbtCGtDPnhqM8qfQ2uAp5+AIf78JNSyFY7xIwhKvolKTE9wrLJ4u4J8jge28MAIHjcTZg2V3k8xckCHoDdpDI1+LJPjs0RaCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=h2KMpMeG; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id ACE56100002;
	Tue,  9 Apr 2024 10:57:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1712649472; bh=19/Iy6O/3LiyHhHggC3Vu6d5yWOLTGboqwpYX5yUxhE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=h2KMpMeGhSjBRau0u8dxlvcVd01vY+Bg0ZgvGrH0+UFqhE3oI/y6dv5nffZVPBFRR
	 taGnfUqPJQD0v3Mg27F58CI/vKFRXut6pQrffVZ0rHYyMBSqxJu/eEu9WMVCoNiFBF
	 vbhGbh4RfQ369y3AqyY/XSsnl/frty3BNVkmZwDUu9CJluZ8QAZJ7rXFM0Am//kQt+
	 yL3f18NadrMDRXadGUmDHbcw4OHH67HgGlKQm+zkDxbUxQRPvpSswgRhlb+lJ6NKcg
	 GtgL+IrE5LkDOGY3J2MgOb8xTzb/Bqg2ITyQsidjMxn4edlPW9Z4hDYWUP57JoC4//
	 kvr8ACzovQrNQ==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue,  9 Apr 2024 10:56:50 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Apr 2024
 10:56:30 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Eric Anholt <eric@anholt.net>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
	<tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>, Boris Brezillon <bbrezillon@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] drm: vc4: Fix possible null pointer dereference
Date: Tue, 9 Apr 2024 10:56:22 +0300
Message-ID: <20240409075622.11783-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184634 [Apr 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15 adb41f89e2951eb37b279104a7abb8e79494a5e7, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/09 06:51:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/09 03:34:00 #24714050
X-KSMG-AntiVirus-Status: Clean, skipped

In vc4_hdmi_audio_init() of_get_address() may return
NULL which is later dereferenced. Fix this bug by adding NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: bb7d78568814 ("drm/vc4: Add HDMI audio support")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index d8751ea20303..5f8d51b29370 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2740,6 +2740,8 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 		index = 1;
 
 	addr = of_get_address(dev->of_node, index, NULL, NULL);
+	if (!addr)
+		return -EINVAL;
 
 	vc4_hdmi->audio.dma_data.addr = be32_to_cpup(addr) + mai_data->offset;
 	vc4_hdmi->audio.dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-- 
2.30.2


