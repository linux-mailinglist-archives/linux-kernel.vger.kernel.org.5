Return-Path: <linux-kernel+bounces-78793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6F38618E9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5071C24943
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D7912C544;
	Fri, 23 Feb 2024 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ZFxKjX92"
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E871B12B173
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708249; cv=none; b=V/n65KD4VoLGdKLdxtGEGLi661MrEhRySSMqYNlhoZQAvjIdRC9J1M4+0L6K3TtkeFy19o4VCj0xU8C/F8o+V7zt5KHh2yhjtg25PBasN4BfGHYHZg5eeQE6kUMuUtwyuULgTFM4z6Mf2GCqeRumjcsinPEi60yOYD1MsX1dFQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708249; c=relaxed/simple;
	bh=y9JUzFCj5/6Y4JFU5uKrYaAMUtXH6djFg6d36YsXAVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nPjlRCk/XmtLqn+6K6wiQDw0fQ9Kvd9Phq/3qx7hrHwHuZhEJF1EzZTKm9fJjVOkC1Ax2zXEU1Jh4sNvhfcdFQENrYXaTugQ/CsishcRjNjPSWyB4idxYdwaUCHp0Rf13UdSBrsA/Kwbsxvo0Bl4rO/dAaBYnpmLF6xJq7clBGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ZFxKjX92; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id dZ3GrKc3YdwEKdZ3GrQYVX; Fri, 23 Feb 2024 18:09:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1708708177;
	bh=yqjFD2SSA0fcwHyt4UvJnhSi3JeettLpDMfFQ+pNE78=;
	h=From:To:Cc:Subject:Date;
	b=ZFxKjX92Vu7ZqQCSXP5FXEIV4ARiUZPiTmKDl8DjfrUCWc8awqrlxd1pGs1iaZD1V
	 ndBEv+CCPhtf4lo3spUhMT0FIZxcNl1bPZzZ6KgTC/Bd9K22kU90ZiBrLJLa0Gpgit
	 r5mpBLS6NhtRdB6oejdlo5L8Vi/byW7v0/CVVenpgBMkRWhHsB41yRVOOjEu4Igjx1
	 EpdofouwzhryL49+ZIBtKnONYzCCpGC6fjGpe1iqqsnZfB3F735Hw0+SgVzN8THGMB
	 MBvpPyvaAF0KW62UBEvVrNlthJUj5YfQltxx/yG1t0IMxCSFGrMuIlxxscCGsV8qmJ
	 mm7/FlCgFIXOQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Feb 2024 18:09:37 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915/display: Save a few bytes of memory in intel_backlight_device_register()
Date: Fri, 23 Feb 2024 18:09:28 +0100
Message-ID: <ecfdb3af5005e05131e2fb93fd870830f39a8c29.1708708142.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'name' may still be "intel_backlight" when backlight_device_register() is
called.
In such a case, using kstrdup_const() saves a memory duplication when
dev_set_name() is called in backlight_device_register().

Use kfree_const() accordingly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/gpu/drm/i915/display/intel_backlight.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index 1946d7fb3c2e..9e4a9d4f1585 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -949,7 +949,7 @@ int intel_backlight_device_register(struct intel_connector *connector)
 	else
 		props.power = FB_BLANK_POWERDOWN;
 
-	name = kstrdup("intel_backlight", GFP_KERNEL);
+	name = kstrdup_const("intel_backlight", GFP_KERNEL);
 	if (!name)
 		return -ENOMEM;
 
@@ -963,7 +963,7 @@ int intel_backlight_device_register(struct intel_connector *connector)
 		 * compatibility. Use unique names for subsequent backlight devices as a
 		 * fallback when the default name already exists.
 		 */
-		kfree(name);
+		kfree_const(name);
 		name = kasprintf(GFP_KERNEL, "card%d-%s-backlight",
 				 i915->drm.primary->index, connector->base.name);
 		if (!name)
@@ -987,7 +987,7 @@ int intel_backlight_device_register(struct intel_connector *connector)
 		    connector->base.base.id, connector->base.name, name);
 
 out:
-	kfree(name);
+	kfree_const(name);
 
 	return ret;
 }
-- 
2.43.2


