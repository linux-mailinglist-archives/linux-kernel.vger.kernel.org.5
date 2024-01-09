Return-Path: <linux-kernel+bounces-20708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A4B8283D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536FB1C24576
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0872A360A3;
	Tue,  9 Jan 2024 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lq+T9eVs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B4A36083
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704795644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8SIIXck5uwYvwPpJnTFzb6gmOuEum/JO9/k2N35WTjM=;
	b=Lq+T9eVs2PLZRpOPueIAiJ1bm3oGTeYjzbUI9aMJqi79Pje2RxkUu9Xp2dSbU6SV7r7Rtv
	0cucNJWeN9tqmm0P51jfgvd7W7lGGGLbpHJsaVlW1m3FVcgKREfZ1mw05tW0ledOeseKS9
	+9wMrYVy9dHkLtW+2HfbhQIzDFt7WaY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-ts8ng6Y7OqWIAQ-vrzUjVQ-1; Tue, 09 Jan 2024 05:20:43 -0500
X-MC-Unique: ts8ng6Y7OqWIAQ-vrzUjVQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7815b7f7a78so69182285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 02:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704795643; x=1705400443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SIIXck5uwYvwPpJnTFzb6gmOuEum/JO9/k2N35WTjM=;
        b=GQMaYwMvOTzyYIT7oUgX3mO+QI2WRROPhltEMaDhBJ0ggw4fabD/FR8zP1+xBZKlo6
         WscrM4cT2SGZiDBiraE8lm6W/0Z3BeGZBi/+5MrRjmGVoT6FtX04kdC63mcZ1d1m9aa/
         hRSVLuDdbgdzjEOYfwHyNNZE93RQCTgGfs+FJZPCLFsCKDRvoE3up2yAk5bMVD6h/zs3
         V23o1ZhmKda5Q0/iFoEo/9ofC8NhXcjryhmLtx0IS9/wYJYPBx8OuDNxHW5EhJB1QSeL
         U/VIQ68GNnLnYDOqhdBTnxsek01WmPA+rkalnP51jbT8aenrTeAb9yPhFrnGQDQ3P7Hc
         vf0A==
X-Gm-Message-State: AOJu0Yyxj+RWA0CcjwIer+7lCvet6foU5vSkCWZPTdbh3XYZqeXiH1RW
	4gFRnC/P2n486Lh4AdBDm7j78fqDh5sdD2KUV3PDKUEdgFDMlSopWqgDz+r5UFuT4g6MrQ7l6oQ
	V8z0+0OSFE/SL/z2z4ZiiVVhl45+JaLbr
X-Received: by 2002:a05:620a:410a:b0:783:1077:714d with SMTP id j10-20020a05620a410a00b007831077714dmr10128955qko.7.1704795642791;
        Tue, 09 Jan 2024 02:20:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm98LGFsI95VtFsTojt3ky3TV9lUFR+SqWmfn+hfcm+azOazpPki9dG32RlcMzB3+1Pr17LA==
X-Received: by 2002:a05:620a:410a:b0:783:1077:714d with SMTP id j10-20020a05620a410a00b007831077714dmr10128942qko.7.1704795642563;
        Tue, 09 Jan 2024 02:20:42 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id m24-20020ae9e018000000b00783217607d6sm679695qkk.115.2024.01.09.02.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 02:20:42 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v2 0/2] drm/imx/dcss: implement region request and devres
Date: Tue,  9 Jan 2024 11:20:30 +0100
Message-ID: <20240109102032.16165-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dcss currently does not request its memory resource. This series adds
that request with devres. As we're at it, it also ports all the ioremaps
and associated allocations to devres.

I can build this, but I don't have the hardware available to test it. So
you might want to have a closer look.

P.

Philipp Stanner (2):
  drm/dcss: request memory region
  drm/imx/dcss: have all init functions use devres

 drivers/gpu/drm/imx/dcss/dcss-blkctl.c | 14 +++-----------
 drivers/gpu/drm/imx/dcss/dcss-ctxld.c  | 15 ++++-----------
 drivers/gpu/drm/imx/dcss/dcss-dev.c    | 18 +++++++++---------
 drivers/gpu/drm/imx/dcss/dcss-dpr.c    | 25 ++++++-------------------
 drivers/gpu/drm/imx/dcss/dcss-drv.c    | 12 +++---------
 drivers/gpu/drm/imx/dcss/dcss-dtg.c    | 23 ++++-------------------
 drivers/gpu/drm/imx/dcss/dcss-scaler.c | 22 ++++------------------
 drivers/gpu/drm/imx/dcss/dcss-ss.c     | 11 +++--------
 8 files changed, 36 insertions(+), 104 deletions(-)

-- 
2.43.0


