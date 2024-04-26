Return-Path: <linux-kernel+bounces-159814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99758B3474
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AC12854C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D7613FD8B;
	Fri, 26 Apr 2024 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgOldmJl"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D44913C9A7;
	Fri, 26 Apr 2024 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124949; cv=none; b=r5PnlhzFwIpWPwNsQ47/ONJ/vY3KD7z9kehB4/sSrfhI2rMwTOV4QV3YH1oVhw70RPYmI28GBM4Pown+X597eTWcxexthEeBhlpazH1mkwx+XkKkrRF9+sBZlrn1nTfreDQeGyDiRbsz7XNmT/Rrgg52K15pxFL/RhBR1PblPw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124949; c=relaxed/simple;
	bh=f0pnAMVgnef8kxy0zW8+L4guOLodpzNcya5RGzZzom0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Bu3lK7BwPmSHLLpIuR3A9MiW3dkCzun14qCiH3zM8x0C/EnysHDaqLjG134KglsFYkyJgXLk1sKFTbpIKqBkvTcOXIKNhXL0DSgdAGeQW5OTC/AK+nlF47RJk7NGUzIXaXJ3Cl8FdZ1tCVe0YFqbFlLnKp8Jg/kAOXqFb83JW+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgOldmJl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41adf3580dbso11415045e9.0;
        Fri, 26 Apr 2024 02:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714124946; x=1714729746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OTqofDDyhWS27DTBkyA9Wn/ozYeD7cxzwbx1fLDfXq4=;
        b=FgOldmJleKXf2cgz3fAxUMtii1adNFJaphWFChRNUhjweuCUUB3sdRnTmCo34pAHz7
         hjJ+8XyfckWINKYKgYJl5PtL9+hGAi5yfYS8VEsYF2cQPJGe3Z8eMUxG31FEFuLNsx7l
         fzpcXofIEh3xmxmx3+TxzBzh4CHTNi7gfY378CMbfm4kxIBCNzqN27H3DZ7sVSZxDM7+
         4jdjCRgn9UUbvT2xpVs9cWP4nMaPKXcCe+53fC7eU43JdjA7XXkW1aSNQXX/h94butTT
         O91nViO/vR8Zcf/EnO56ISOa5nO5GPtEkxDMDGJkVmXnt88/SRsocja5StBo82NZdN9t
         Kxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714124946; x=1714729746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTqofDDyhWS27DTBkyA9Wn/ozYeD7cxzwbx1fLDfXq4=;
        b=hpXrpjMTmYk3o+XggJkNCfZB3Rl3cA1WdZ3ui5aCo81xYC+1pFwW5IH6HQjbWOAoPY
         YqGD/1o67o5h09/cpe/i1jBrTmnBU75Oid22DO8Fc7oZ/wt57b5c7wF9YQHDs73lEqxb
         8CysPpjWSfdlRe7V6T6IRxH5M+d2ChIenljwy2QX69IqlgQnXOBCwPkHZbPw7Tq7pWBR
         3F35rVqklJV0mUukVxVKghVllhObD5Q2MlMrn0sYoiDhBtMvHClbdyWYnk+JEUmvKfPC
         BhU+ex+v2GfUeQNASwv8sOuOum7OULey8wcao84waKp5a6TELfz9QPoxKH74tmWu+1jG
         4MWw==
X-Forwarded-Encrypted: i=1; AJvYcCXx7fI+FzD60HYTdg3ZlBdTO+uudlEI6JwBaygCJFQAZ33mHz4O3zg1YTt3VlMitJMu/Mh9Ev8dOLt/+Eje+yu0xW4kxitbUz6eMxrJ
X-Gm-Message-State: AOJu0Yy0oyf2ooz5YDjnWI12ZQ28ZqJq3gid837dV6GO2e84Q5dXxlRz
	EN0vQ2utKj8vDIrcbuSj963F4kbPY+lgx2f9hzcVimzxgInvS5c0
X-Google-Smtp-Source: AGHT+IEnEbGzWwb5BtL05FOeJSjU5tiXoKG2o7C40aXQG1lwfb02NqLf7df70RE0rq1MKonJ92sK/A==
X-Received: by 2002:a05:600c:3509:b0:418:de31:7148 with SMTP id h9-20020a05600c350900b00418de317148mr1930550wmq.3.1714124946253;
        Fri, 26 Apr 2024 02:49:06 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe2c4000000b0034a3a0a753asm20338400wrj.100.2024.04.26.02.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:49:05 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/xe: Fix spelling mistake "forcebly" -> "forcibly"
Date: Fri, 26 Apr 2024 10:49:04 +0100
Message-Id: <20240426094904.816033-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a drm_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/xe/xe_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index bb4fbae5edb6..b61f8356e23e 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -788,7 +788,7 @@ u64 xe_device_uncanonicalize_addr(struct xe_device *xe, u64 address)
 void xe_device_declare_wedged(struct xe_device *xe)
 {
 	if (xe->wedged.mode == 0) {
-		drm_dbg(&xe->drm, "Wedged mode is forcebly disabled\n");
+		drm_dbg(&xe->drm, "Wedged mode is forcibly disabled\n");
 		return;
 	}
 
-- 
2.39.2


