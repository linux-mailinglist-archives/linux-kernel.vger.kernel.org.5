Return-Path: <linux-kernel+bounces-451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C1F814145
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62786B219CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5906AB9;
	Fri, 15 Dec 2023 05:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHZzHdzY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F536AA1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 05:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3536cd414so2035195ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702618242; x=1703223042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OIvU2rMOTpvQeMXLzE6AgfO3UsG3x1FAaRngC/8R2RU=;
        b=CHZzHdzYvSz3AYV3Q9TM1n7wIAgUVZCdpuDdC/3GuEtIkoNocD8QeFqgDBsFc9jcUr
         pOQDQETE5pyhnhA3MK87KnsDJ/DqJHlXLDjFRv8vukb+6BuzYz7lRKSly27a6nd+xzQ4
         TchXn2W3iNMhXs4WiQM6ixTH+CkfZtro5J3HSWVXfhfrZOmse8QUgxTXgviaclWEMmsZ
         7XO36/gYNaQUVu9ZTo8d/Iyeiybl620/h8InbiFs7EdfOdB4ygCxyV2X7G6gec3XQ0Fs
         TuaA/m1zqftbT13FrL9KjaC7ZgcxzQlOW9XO5J5h5q6vZgSnFgSq69SMe6SyrcC6XQhd
         2JzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702618242; x=1703223042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIvU2rMOTpvQeMXLzE6AgfO3UsG3x1FAaRngC/8R2RU=;
        b=uZEaCtfEB3TurnVmJNdAzVAV7AK7cfEn17MQdC4wZMaAwCE1UrAb+VAq3nGh5fp2sw
         B4hZREsYaOaH7SRxMde0/KYzCQqyZ/Lk3XJTS7W7kZ3PFMgTxgSEVktf1kqIvXFBjXat
         LamIocBTTr0leX56opfdhmeYEWmrFnUl9lxh1vLIog1WRZqv0ZmZtno50TKv5SwwXK2k
         z9ES0VNslMSpWOHrZ9sd9/EMfhoEPr3P4lzXYDx7I7NzhPnmCH11762ddO+fZQRWru65
         veNqFSs2bMtG8rIUHHOqv1hkHKvK0xJK4zanAUdk2/BZ8EvWtHQbivOAHOKBFrHTF8Dt
         no2g==
X-Gm-Message-State: AOJu0YxA0XYZ0QBGcZ1Micg5ZddkgSKreL5H7JbiEblasUeB9g3b8LVT
	bYwEB3wRcz/omU8w+21dHRE=
X-Google-Smtp-Source: AGHT+IFljRxhBOcaFOlEZE3V2qqM+fQ4vtaLInFtl2lkBjp/59h6M25sWQrddIYScyIhzZcF+t1AOg==
X-Received: by 2002:a17:902:c212:b0:1d3:492c:faa4 with SMTP id 18-20020a170902c21200b001d3492cfaa4mr4159521pll.127.1702618242381;
        Thu, 14 Dec 2023 21:30:42 -0800 (PST)
Received: from localhost.localdomain ([202.137.218.19])
        by smtp.gmail.com with ESMTPSA id j15-20020a170902da8f00b001c9db5e2929sm13370158plx.93.2023.12.14.21.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 21:30:41 -0800 (PST)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: gpu: drm: vmwgfx: fixed typos
Date: Fri, 15 Dec 2023 11:00:16 +0530
Message-Id: <20231215053016.552019-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed some typos in vmwgfx_execbuf.c

Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 36987ef3fc30..272141b6164c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -621,10 +621,10 @@ static int vmw_resources_reserve(struct vmw_sw_context *sw_context)
  * @sw_context: Pointer to the software context.
  * @res_type: Resource type.
  * @dirty: Whether to change dirty status.
- * @converter: User-space visisble type specific information.
+ * @converter: User-space visible type specific information.
  * @id_loc: Pointer to the location in the command buffer currently being parsed
  * from where the user-space resource id handle is located.
- * @p_res: Pointer to pointer to resource validalidation node. Populated on
+ * @p_res: Pointer to pointer to resource validation node. Populated on
  * exit.
  */
 static int
-- 
2.25.1


