Return-Path: <linux-kernel+bounces-19237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D94826A23
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2F01C21A92
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1714BDDBB;
	Mon,  8 Jan 2024 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SDz+xyLS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0115DDCD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e490c2115so1503905e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704704761; x=1705309561; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2EyoLbnPqZmV+8zXuTXWwVH9AFKfyr2X73Q99Ksn7g=;
        b=SDz+xyLSrHs8XA25VS5OX3bTq+MlRk+2QXHAsRJMDzhJjFHRjXNp6vBJVfWaKFGLAd
         Njx6ExOG9TI/poYZndRBGndcbCh4VlG18MauJvcl+C5ldCmDtR0B8lv2zRIl58Np6a9R
         E9qEYdfWixyrdyboHLdQPXXtoWJeYb13/hjRQAbEJdtAfgmdQSQsGCXLYgbzEgT290v+
         Mm/lIuEo9QeI23rv2sWui2WnuuJVWnYAqbGmfPSaxjoZKDA5RZiImEEbY64oBPYT/Sq/
         mQ7VPLa3wnmSfw3dkeADjR5Ap1fa7vIkj6AbXMo4vLUpRgYPLysv8WfEkQzxGnMvZzXF
         IVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704704761; x=1705309561;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2EyoLbnPqZmV+8zXuTXWwVH9AFKfyr2X73Q99Ksn7g=;
        b=gdycdQvbDlwmjHnFZUWtrwlHyvFe0xuYwSBqYxTlPnqZqReUhsp3Q900id6bhXu2Po
         j7v38s/VzvCQRQYe1Zq+4fXciTQII98N8Zpk3c7C7wA9s2eSQdn99/dxFXOTV+s1rmhF
         3gyhftWlgWvEbvqj1d4sCRjsE+O58wbgxpH3fRBUIJzOUo1b5Fk1dBlwrhdFYjPU0EBx
         cisj8+JQykP/L/ZzHUj3G3/hoev2LtHBFcG9xqfJABZjFz5kW7Xy4LuQN/LNrT7tAfFZ
         QTuPBntQXQHzT0cWtZJMs1zPLkhAdZo3GZddUoXZJYxHTTL9oe6JMaDMUH0zbqhVw50r
         Vx5A==
X-Gm-Message-State: AOJu0YyF+HW2kvV3/4i99D/Y3CVUGeyItkXLI/UpdljWatNv0Jt7HajB
	vaVdiC0IIT7JfvCzix5Ylfa61HJw0AQtzg==
X-Google-Smtp-Source: AGHT+IGCvzuvE9K9DjjuxaKem4GrCkze1n5YKKD7JDglZ2aL/3ZCSvPl+yXc9xU+sGZNscYNx6DS0w==
X-Received: by 2002:a1c:7204:0:b0:40e:4aae:7e62 with SMTP id n4-20020a1c7204000000b0040e4aae7e62mr12731wmc.58.1704704760955;
        Mon, 08 Jan 2024 01:06:00 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id w5-20020a05600c474500b0040e34835a58sm10219495wmo.22.2024.01.08.01.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:06:00 -0800 (PST)
Date: Mon, 8 Jan 2024 12:05:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	John Harrison <John.C.Harrison@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/xe: clean up type of GUC_HXG_MSG_0_ORIGIN
Message-ID: <ec22d742-632b-426a-ac86-62641a38c907@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The GUC_HXG_MSG_0_ORIGIN definition should be unsigned.  Currently it is
defined as INT_MIN.  This doesn't cause a problem currently but it's
still worth cleaning up.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/xe/abi/guc_messages_abi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/abi/guc_messages_abi.h b/drivers/gpu/drm/xe/abi/guc_messages_abi.h
index 3d199016cf88..c04606872e48 100644
--- a/drivers/gpu/drm/xe/abi/guc_messages_abi.h
+++ b/drivers/gpu/drm/xe/abi/guc_messages_abi.h
@@ -40,7 +40,7 @@
  */
 
 #define GUC_HXG_MSG_MIN_LEN			1u
-#define GUC_HXG_MSG_0_ORIGIN			(0x1 << 31)
+#define GUC_HXG_MSG_0_ORIGIN			(0x1U << 31)
 #define   GUC_HXG_ORIGIN_HOST			0u
 #define   GUC_HXG_ORIGIN_GUC			1u
 #define GUC_HXG_MSG_0_TYPE			(0x7 << 28)
-- 
2.42.0


