Return-Path: <linux-kernel+bounces-95346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5746874C8F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57861C224BC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C20985633;
	Thu,  7 Mar 2024 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG5NMRVh"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8BC1D699;
	Thu,  7 Mar 2024 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808086; cv=none; b=Fe8E1Xzu+O7VVL4An1i3/SVN1Z/KU1KWkmBun+dHtpQJAuMULfQCihnGiERysGVVmZAfBA7lVk01RUCJlYQIxEopv/vx5dU7ohG8sQdVxLvPwvAqesoGN84hGlnkOUo2azL7l+h3+yLMJnuP38IqQMP0ce3hMXyyViw0QVp8I9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808086; c=relaxed/simple;
	bh=u0HbKc169Dv/IfHrwEar9MH/mTXRwSs/imuaMF9eTMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oPFSiz7HGNahwmH8GL0eKNanFmyOUcNmsf3gYu0qCiI0D7JqhG6/6Bj+eyUI0iJUh2EdBH2sKt3Gm5qL9ymbljox2FX4q59D7vbt7RggkHLFwbnwGZGea7lfCz1J40SxvHVHqmlu6cuXc/0RcVUg88OtGuoqFSA/YisSIJNC7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CG5NMRVh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412fc5f5099so5804775e9.2;
        Thu, 07 Mar 2024 02:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709808083; x=1710412883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qgaA4hwjMMxXsNn/H65VvY2aAb1+rjCArUM3dz35oeg=;
        b=CG5NMRVhpcDuJcA+oNFDOK1FTObA0mcwbghq7pZZSGn5yl/mX/FqhLpqffdIrIE7Wz
         BaLB/Dm2gaoeXa647Opbu+YrAxQDo3gang6KqpnmIsKUhdozjkbkImRhHlURsxfiOMhj
         LzD/3bEtj1TxC0XVakAO54d6NFp0E/elfXGEVl0JDv6pMG7jfm4En/VGfT5OYiH0McUQ
         xN/Hs+7lxWuIrqkQbr+NVWofvqAdAWbNKuyBn9ZgQVgqVtsUUWowENcrmcwQtEdcBIq5
         sL+7Cj1LLousMDvVY2Pn7/+mnOUyM75HP3BA2R8jty529iS6xC0OBHL1ncKnUTP9B2Tr
         m6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709808083; x=1710412883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgaA4hwjMMxXsNn/H65VvY2aAb1+rjCArUM3dz35oeg=;
        b=en2BGEeoKze2KrxAneQSh95MmfscFErs4rLITsbFBVMCfTa/yxJ5NxAKAIefW5Xp3b
         qcW40H5sZHqMcGvfYV7QEjZ4W/D3Wm6ir+vO1uhbOfGq4ladr5u4ERoiljp/BKs6FzQ/
         /Qf92+rfUcMwhSa3GhiSLCXaOxSlT+uBdgwpB0r7ugyiRmcseQHNqpdcCyw8uD5Xzx/2
         jCo6BD15XUoRh5TbfFFeOig6ZmM3ey8apdmU5uIcZ6o4mJ1cbIzHmKdNoSGC/YsAGikm
         eJIeZ7J72MxPBx+2ETvlsN0fFQ6rVMD3mHDQmRB49vU8Xo3nI9jI0zGho0ad6AvQCf6Q
         EWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY5Mof1wu/2i4OpMdd3GASZ+w5zSTkSHH2MFAjDIu/5YNGSqsknkovNnAOYqqTMHLtl/4yrAVUQ5XYL4LbuVhiWWEJgPVUcc8RDc5e
X-Gm-Message-State: AOJu0YzSJycQT8MAMYyUnidUaVs0vjyFTEpvDw3aNAe3dfIORNAWZBEu
	Y60O9S3cgLuL+EyNtFVBnJEaHdnBE2HeM/vWqcWQZYJyS1Kyk/y4
X-Google-Smtp-Source: AGHT+IHFfQLpO+Ajim+32v9BfNQVyFeSt1SNjsGAX7r/QvA8WtdX08e2LuaNBQOxKkcCwOPQi0HNYg==
X-Received: by 2002:a05:600c:4ecf:b0:412:b457:6303 with SMTP id g15-20020a05600c4ecf00b00412b4576303mr15685863wmq.21.1709808082840;
        Thu, 07 Mar 2024 02:41:22 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id fk15-20020a05600c0ccf00b00413133cb9b8sm384147wmb.19.2024.03.07.02.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 02:41:19 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/qxl: remove unused variable num_relocs
Date: Thu,  7 Mar 2024 10:41:19 +0000
Message-Id: <20240307104119.1980621-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable num_relocs is being initialized and incremented but it is
never actually referenced in any other way. The variable is redundant
and can be removed.

Cleans up clang scan build warning:
drivers/gpu/drm/qxl/qxl_ioctl.c:148:14: warning: variable 'num_relocs'
set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index dd0f834d881c..506ae1f5e099 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -145,7 +145,7 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	struct qxl_release *release;
 	struct qxl_bo *cmd_bo;
 	void *fb_cmd;
-	int i, ret, num_relocs;
+	int i, ret;
 	int unwritten;
 
 	switch (cmd->type) {
@@ -200,7 +200,6 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	}
 
 	/* fill out reloc info structs */
-	num_relocs = 0;
 	for (i = 0; i < cmd->relocs_num; ++i) {
 		struct drm_qxl_reloc reloc;
 		struct drm_qxl_reloc __user *u = u64_to_user_ptr(cmd->relocs);
@@ -230,7 +229,6 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 			reloc_info[i].dst_bo = cmd_bo;
 			reloc_info[i].dst_offset = reloc.dst_offset + release->release_offset;
 		}
-		num_relocs++;
 
 		/* reserve and validate the reloc dst bo */
 		if (reloc.reloc_type == QXL_RELOC_TYPE_BO || reloc.src_handle) {
-- 
2.39.2


