Return-Path: <linux-kernel+bounces-145643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5AD8A58E1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5103F281FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A319584055;
	Mon, 15 Apr 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFknscSw"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFED68289C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201136; cv=none; b=YEuLQSwmpF3eZ0kqgVBjWJXYnXDhiOQq5/HCKaamCE0WQwC3lfg/otuZdc75LTCp8SLwuf//2WntnJdi8IJIAUSn/Pfzl7st1z/WCVVRLeyv5X2EFzqh7aqWAkpeqAiCg/HjA9YNmZUXLnm2adsb39sk3DAOz3uGTgH+K33SpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201136; c=relaxed/simple;
	bh=r+GwkVwnqEAEA+xTUwJ+9bNmEWwrcN4rCWKgahGYD9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UgXt7t1bPm4s1bmpe+FMN6rRUhl0VeIjaHEpWk4Qk6me2hN5POb59p4t9DpfL0sB4Fi9yVpwe5KObWMmmAOW/g2nx5oGdq1VnuUau+Z/GOhBYqOE8cPtMaW9/AxhkcmpIHujnVuTRJ/0AEtrqc8gi2xKCZI/G9AePgQlggrOVL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFknscSw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed267f2936so2746190b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713201134; x=1713805934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CvwdBBuZlWCCCSofEdCkvt7eAMHgf9aarWbclnob5NQ=;
        b=fFknscSwOfe9iUQCC7gx13AC0mM7nqBUCpGuUVbazuEAICvTnRcYwc4XUsy4emYj7U
         gMkWhdIXgMySGetf7cBT1DMs99p/ZNvz4oDJmnC3OgxXtQLCTOWVM0sR2ZUd9Zpy4P8A
         Q52VyTX/vlpqSRr5PV4UVp8HNYHVYUMyvcuiDX2pmIvGZtI1fiOewHU5JCqrQpNSvevF
         43SKLCFLrGiy3OUe5zS3CF7KhxP7EGelAcBdl84SADwa3xC+aogC+nNQyrNHLcbUV8lp
         wO+MKxXDMMY1VrCzUgYKhjExnZBhSSdAlFmc38ceyyd1Lwrp8VMnHgaHiBP0/rlA1C6Y
         W/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713201134; x=1713805934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvwdBBuZlWCCCSofEdCkvt7eAMHgf9aarWbclnob5NQ=;
        b=Tl0sHhPEs6DuJderOQy1n2+hp9AWZsRFt0az1AaOwV6v/5eOnEp2hsWHUa6suKg0lX
         P5YuZBRSm0lhUvwezg/rtXRKS0naU6pY3CBPankDdv325Uf8V/q0546JNQjfRYik1JNO
         Cndmzug6yWlMUMqpd54XaC8uAbkCz58SiXdCjaXT8djUJe1R4t8HWxa18oMg+KozTWvI
         cHLiuS9IAqouqQWhlNLpWNOLH8EQVd4ZNTuoul9ah+PzuWjBTAoHspUtRJEDt9tG+LEe
         jUrhVlvnCFJ1AhWuueQWoB0o5nI5myhJGNoMfsCklitnGQ0vdbE02h1lLYjtT7z/XxhO
         cy9A==
X-Forwarded-Encrypted: i=1; AJvYcCWr7tDq77tYsbB5ntQAvSp/wKkWOQTVUhTJLV+5vExGj8XTuDsWqtgvI0m7QgAMl22N8lrmj5PpQsG+nu2U3j89Yr9Dp0V4tgCYkXvl
X-Gm-Message-State: AOJu0YxdMSkmW+b/vadel/4NJkSGLtTeP5e82hvohLqLRK4j4ZMmkpqs
	aN4lBH5BvOYtCXvGF5G0nyrtpIc8URMyHnIrhoOTR6R+AIXIYSY/
X-Google-Smtp-Source: AGHT+IE7IZU2/0040JDE8A9eO4n2gqnQpnPo+QJy1LEsOG5qn+YdoFSORy+XVRZed49zlffpB7jPnA==
X-Received: by 2002:a05:6a21:3707:b0:1a9:5e63:501b with SMTP id yl7-20020a056a21370700b001a95e63501bmr7294111pzb.44.1713201133804;
        Mon, 15 Apr 2024 10:12:13 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1cb8:5ab4:cff:f60:1176:9dd3])
        by smtp.gmail.com with ESMTPSA id v11-20020a63150b000000b005f769b41a58sm376599pgl.4.2024.04.15.10.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:12:12 -0700 (PDT)
From: Sumadhura Kalyan <opensourcecond@gmail.com>
To: florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	gregkh@linuxfoundation.org
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sumadhura Kalyan <opensourcecond@gmail.com>
Subject: [PATCH V4] staging: vc04_services: Re-align function parameters
Date: Mon, 15 Apr 2024 22:41:38 +0530
Message-Id: <20240415171138.5849-1-opensourcecond@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checkpatch complains that:

CHECK: Lines should not end with a '('
+typedef void (*vchiq_mmal_buffer_cb)(

Re-align the function parameters to make checkpatch happy.

Signed-off-by: Sumadhura Kalyan <opensourcecond@gmail.com>
---
v3 -> v4: Repharse the subject line.

 .../vc04_services/vchiq-mmal/mmal-vchiq.h     | 29 +++++++------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
index 09f030919d4e..98909fde978e 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
@@ -42,8 +42,7 @@ struct vchiq_mmal_port_buffer {
 
 struct vchiq_mmal_port;
 
-typedef void (*vchiq_mmal_buffer_cb)(
-		struct vchiq_mmal_instance  *instance,
+typedef void (*vchiq_mmal_buffer_cb)(struct vchiq_mmal_instance  *instance,
 		struct vchiq_mmal_port *port,
 		int status, struct mmal_buffer *buffer);
 
@@ -101,31 +100,25 @@ int vchiq_mmal_finalise(struct vchiq_mmal_instance *instance);
 /* Initialise a mmal component and its ports
  *
  */
-int vchiq_mmal_component_init(
-		struct vchiq_mmal_instance *instance,
-		const char *name,
-		struct vchiq_mmal_component **component_out);
+int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
+			      const char *name, struct vchiq_mmal_component **component_out);
 
-int vchiq_mmal_component_finalise(
-		struct vchiq_mmal_instance *instance,
-		struct vchiq_mmal_component *component);
+int vchiq_mmal_component_finalise(struct vchiq_mmal_instance *instance,
+				  struct vchiq_mmal_component *component);
 
-int vchiq_mmal_component_enable(
-		struct vchiq_mmal_instance *instance,
-		struct vchiq_mmal_component *component);
+int vchiq_mmal_component_enable(struct vchiq_mmal_instance *instance,
+				struct vchiq_mmal_component *component);
 
-int vchiq_mmal_component_disable(
-		struct vchiq_mmal_instance *instance,
-		struct vchiq_mmal_component *component);
+int vchiq_mmal_component_disable(struct vchiq_mmal_instance *instance,
+				 struct vchiq_mmal_component *component);
 
 /* enable a mmal port
  *
  * enables a port and if a buffer callback provided enque buffer
  * headers as appropriate for the port.
  */
-int vchiq_mmal_port_enable(
-		struct vchiq_mmal_instance *instance,
-		struct vchiq_mmal_port *port,
+int vchiq_mmal_port_enable(struct vchiq_mmal_instance *instance,
+			   struct vchiq_mmal_port *port,
 		vchiq_mmal_buffer_cb buffer_cb);
 
 /* disable a port
-- 
2.25.1


