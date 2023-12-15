Return-Path: <linux-kernel+bounces-470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CF58141A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2A21F22F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19830748A;
	Fri, 15 Dec 2023 06:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYP9NSbb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3984F6AB9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d32c5ce32eso10948495ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702620422; x=1703225222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl/MGXp1U5MDFkgrPsmaeRMSAGD9eidIYfifMeLoKI8=;
        b=EYP9NSbbuhAAnnNDNmAmah9wc+a33NwGIG7nbnV1yQtjLZPIWu5SlJ05T7QopnNBLs
         KA3wJzNg7Ug5hRIWvxR2goFAcLK3g+ojj4MM0bt2MC7ww/IFcPYdTQfbfgDSddgGRKQ9
         00VitWFgKhG9cnUsLY5yM3kJCOzOzmr0NwKz5XA12s4uRh4NzEY6mVcRkE5I0d/lAl7t
         tGwW2+wLdTuc02y+FalVhlTbJiwXP1Km16y/FG4oc5ylNW9engLf0zqVFNtsIPkREYhM
         Ivjl+XQsgzEL1xx+9qwMtzMhpiLBNfS9k6geX83Si7dQINXbAT239rNAYXAGQ5INm0CX
         ssIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702620422; x=1703225222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sl/MGXp1U5MDFkgrPsmaeRMSAGD9eidIYfifMeLoKI8=;
        b=GaTrXmYEIij170BoKTd/H3+Udyj//9jV0UvzJfx6V25UDXyeEC3/p33Qe67JQbC9DW
         NkoLI42YA/zvGBqLB5CB4gFaNW3zSN/v2aJEOs9kwKv/QaM88/23bZi7hpvGM6CXa3Vu
         Stcm1lQZhazxaAKEDz8LdAAjdWiSrM3XPtvSWtjc3pi+GDv4FoPHu+JHqeMES1FXVfYh
         D+fJLT0UCS+zlNxyNpu7ApxYf9w8Cm6jajaBh7mtkYyKmxfFUKf3TRPETCQ0SH1RCNdT
         Itx0mQcMkJO5Gi3CAy6hbuNFMXvo4il8vbA4JMf5wWtnmuxSVHzXMqiJNaCAhyEjJovj
         53aA==
X-Gm-Message-State: AOJu0YzsO98/wnzbM6V8S5obaYs2rngdFqTGpvZjTEJwVKHg0AlSHtq+
	Aptknucs+pgLdpu7uxYpW/8=
X-Google-Smtp-Source: AGHT+IGn5waI4kzFSgJWNCebQVQ9h6LycSBdt5bMWMtMhwDg52tEKqFTaUO4GtDyQQogiOrjRr5Rjw==
X-Received: by 2002:a17:903:24e:b0:1d0:4759:bb60 with SMTP id j14-20020a170903024e00b001d04759bb60mr15725492plh.26.1702620422477;
        Thu, 14 Dec 2023 22:07:02 -0800 (PST)
Received: from localhost.localdomain ([202.137.218.19])
        by smtp.gmail.com with ESMTPSA id d21-20020a170902c19500b001d368c778d1sm2344726pld.213.2023.12.14.22.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 22:07:02 -0800 (PST)
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
Subject: [PATCH V2] drivers: gpu: drm: vmwgfx: fixed typos
Date: Fri, 15 Dec 2023 11:31:59 +0530
Message-Id: <20231215060159.555229-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed multiple typos in vmwgfx_execbuf.c

Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
V2:
Fixed some more typos suggested by codespell
and the community.

V1:
Fixed multiple typos

 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 36987ef3fc30..76aa72e8be73 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -127,7 +127,7 @@ struct vmw_ctx_validation_info {
  * @func: Call-back to handle the command.
  * @user_allow: Whether allowed from the execbuf ioctl.
  * @gb_disable: Whether disabled if guest-backed objects are available.
- * @gb_enable: Whether enabled iff guest-backed objects are available.
+ * @gb_enable: Whether enabled if guest-backed objects are available.
  * @cmd_name: Name of the command.
  */
 struct vmw_cmd_entry {
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
@@ -1069,7 +1069,7 @@ static int vmw_query_bo_switch_prepare(struct vmw_private *dev_priv,
  * object following that query wait has signaled, we are sure that all preceding
  * queries have finished, and the old query buffer can be unpinned. However,
  * since both the new query buffer and the old one are fenced with that fence,
- * we can do an asynchronus unpin now, and be sure that the old query buffer
+ * we can do an asynchronous unpin now, and be sure that the old query buffer
  * won't be moved until the fence has signaled.
  *
  * As mentioned above, both the new - and old query buffers need to be fenced
-- 
2.25.1


