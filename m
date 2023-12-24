Return-Path: <linux-kernel+bounces-10643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D21F81D7FA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 06:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5481F21B52
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 05:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785A72106;
	Sun, 24 Dec 2023 05:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KfFMxA5z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAFE20E0
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-67f911e9ac4so19775356d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 21:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703395285; x=1704000085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Va9uKfUKNctGYZAEDrYv1WrpTtXNDm86DRklEW6gSA=;
        b=KfFMxA5zsGahB9jfkCzk54abW6dfboQ8pKrdEVnB/HHVSX5D2dSGNbZh0QhGn3/C2t
         CfKeznp5xMayZmODUyXNkTjBk3hjP9wFGrUdUqSk5MNhnhkK/1PTKfRQXa6ZDB14T2ik
         WynlGIcgb6+H/Z+bVU6wKP9s6yl5bKZKf76mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703395285; x=1704000085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Va9uKfUKNctGYZAEDrYv1WrpTtXNDm86DRklEW6gSA=;
        b=w57eXcjZ5Atz+I4vo/l4OPmVdUEpr6DYNxdLv9KpspVWwADUx+GtT8SfvoFXt2pRMV
         dhuobTdlxOOzL/BzH9oIxNA4SPuTT7PDIUMoS6mqptwzD41yNriLhdb7hs30/Vby7YhV
         D1lCtBqAKD5pR6Y62bfr+E/iCUc2pHgN7CPNItCIBLQjPDnM/UaYKWTrVk4tKqY0E1s0
         /GVyK0UGf7p7vyBcPFFVe+hptfVyn3hXW2Gyqq8lrpJqMXo2Fh4TcU1ty15aRLu3CT8C
         VKiMxK5gGzrqTRbIkCeXVJdG3cAs4taXsIzLQzxMWReH2VYY+SIUsY63+OvlkmwD9yNk
         M8HQ==
X-Gm-Message-State: AOJu0YyuBi6FuEgOOPtE76pdzB8Eo5HrMzZMlOxAfEhdUfv54BezU+bf
	HxCIU7tSK0LRw02QTtQjRITO8QceTHkXo/qjrCdxLbckrPvLf9nsBIDr8FwZukpC1cG+9B6YCo8
	8cqXXExlhD4La8vxlJrlbBUPGCLdX3CZEqJe7syTSaBpvZFxBciXeEJikgTGL94YkQbTw6I52CA
	JijPCAg3c+CImzM0vc
X-Google-Smtp-Source: AGHT+IGbBPRb2fvJ+S7ksHoxbaOd3JVYbHW4dTFHsf/WS3E7V8T+Gqradt+yTgPKu23FX+j3hbriJg==
X-Received: by 2002:a05:6214:332:b0:67f:bd03:42fa with SMTP id j18-20020a056214033200b0067fbd0342famr2580930qvu.64.1703395285437;
        Sat, 23 Dec 2023 21:21:25 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id de11-20020ad4584b000000b0067fa0a9163bsm1315352qvb.143.2023.12.23.21.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 21:21:25 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Zack Rusin <zack.rusin@broadcom.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ian Forbes <ian.forbes@broadcom.com>,
	Martin Krastev <martin.krastev@broadcom.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] MAINTAINERS: Change vmware.com addresses to broadcom.com
Date: Sun, 24 Dec 2023 00:20:36 -0500
Message-Id: <20231224052036.603621-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the email addresses for vmwgfx and vmmouse to reflect the fact
that VMware is now part of Broadcom.

Add a .mailmap entry because the vmware.com address will start bouncing
soon.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ian Forbes <ian.forbes@broadcom.com>
Cc: Martin Krastev <martin.krastev@broadcom.com>
Cc: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 .mailmap    | 1 +
 MAINTAINERS | 9 ++++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index 68e72a6017a0..ac31f47f4636 100644
--- a/.mailmap
+++ b/.mailmap
@@ -637,4 +637,5 @@ Wolfram Sang <wsa@kernel.org> <w.sang@pengutronix.de>
 Wolfram Sang <wsa@kernel.org> <wsa@the-dreams.de>
 Yakir Yang <kuankuan.y@gmail.com> <ykk@rock-chips.com>
 Yusuke Goda <goda.yusuke@renesas.com>
+Zack Rusin <zack.rusin@broadcom.com> <zackr@vmware.com>
 Zhu Yanjun <zyjzyj2000@gmail.com> <yanjunz@nvidia.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 7cef2d2ef8d7..221871bd4e92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6902,8 +6902,8 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/vboxvideo/
 
 DRM DRIVER FOR VMWARE VIRTUAL GPU
-M:	Zack Rusin <zackr@vmware.com>
-R:	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>
+M:	Zack Rusin <zack.rusin@broadcom.com>
+R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
@@ -23207,9 +23207,8 @@ F:	drivers/misc/vmw_vmci/
 F:	include/linux/vmw_vmci*
 
 VMWARE VMMOUSE SUBDRIVER
-M:	Zack Rusin <zackr@vmware.com>
-R:	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>
-R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
+M:	Zack Rusin <zack.rusin@broadcom.com>
+R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-input@vger.kernel.org
 S:	Supported
 F:	drivers/input/mouse/vmmouse.c
-- 
2.40.1


