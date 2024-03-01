Return-Path: <linux-kernel+bounces-88396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1A686E109
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638681C22C7F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CD36E611;
	Fri,  1 Mar 2024 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="PdctvGqO"
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63CA2AEFF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296018; cv=none; b=HJSPPd7/3ZruXlqETO6KUkX/ZtB4dx9/ohZjQeRTbnVSkylUoqXAOK6zgQEA78AeK3XlUzwLwNPy77u7smqxd03vX30vzNmkThKHzY8d0GEZUPpv1nd5QRxAitsQf10diE+J/PAht7luFG9WPKGZyHfLx7b9M0GYNGI1sPkbxaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296018; c=relaxed/simple;
	bh=j5D9U6KjNVFx9zJvU329TCD0lS74yEhf5AvcIdP3EC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YLZw6321WVigM+3Xb8jZbtSmGsG6Kv4k3jTfh544/OrOg6z0PlaMM6+LO+yFXSx5pOfyMqrY7G3r1oVl1qHmWFU5mLVlAgaFw0w4VdfkJk7Pu/nomixV1Fp5AG4rXjJswMAVJxjfF7oF62l/nPqH5qrYtHqDLQLQfV9QxYwvSoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=PdctvGqO; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id AE28ECFF46BCC;
	Fri,  1 Mar 2024 15:26:42 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fqAs-W5z0ecx; Fri,  1 Mar 2024 15:26:42 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 84DBFCFF46BD3;
	Fri,  1 Mar 2024 15:26:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 84DBFCFF46BD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1709296002;
	bh=GPmQWvjQuc1pVJSK54+GnJ6cGFBHUxKlE2p3TVblCUs=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=PdctvGqOjq3p2Zi7u3eZmpT/nGJf2zXfxbj9ZZS/6BvPa9WdbccuaQU/a1buAlzaC
	 lVQ12ZpwmWjDVedZ0smgilBF8Z9Pe6XTnpIJ6krCG8aId80PRbrOGaVlptqYNZB+Yr
	 wSAiQLLqn61BPdFa6L2VO57xPNZseHWfXUpCL19ZXoz4/zXVNFK7qBaSHTzKgPkFoy
	 4wwsxFNmCIXStxhnrXXpp3Vh9fwJDbH6AgIYKG8bDv7Mhw/uP6sQ5KgvDZZJyCZkqW
	 farm3lc+/N43U0R7OhXA7dtka1vlBlx1I68xZq6QYF8bhRJ69UMWEhvPE3fOR9L9Wv
	 fmVWP3Fdhrk7w==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IDqMVs1C3EXX; Fri,  1 Mar 2024 15:26:42 +0300 (MSK)
Received: from ubuntu.localdomain (unknown [144.206.93.23])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 48574CFF46BCC;
	Fri,  1 Mar 2024 15:26:42 +0300 (MSK)
From: Aleksandr Burakov <a.burakov@rosalinux.ru>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Aleksandr Burakov <a.burakov@rosalinux.ru>,
	virtualization@lists.linux-foundation.org,
	spice-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] drm/qxl: fix NULL dereference in qxl_add_mode
Date: Fri,  1 Mar 2024 15:26:35 +0300
Message-Id: <20240301122635.25058-1-a.burakov@rosalinux.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <oprbqmdpjzhjwuqypqfdnirl44drvrhlaiounos44ywdbiustm@myk6llv5chlv>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Return value of a function 'drm_cvt_mode' is dereferenced without
checking for NULL but drm_mode_create() in drm_cvt_mode() may
return NULL value in case of memory allocation error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1b043677d4be ("drm/qxl: add qxl_add_mode helper function")
Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
---
v2: case with false value of 'preferred' is now taken into account
 drivers/gpu/drm/qxl/qxl_display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_=
display.c
index a152a7c6db21..d6dece7a0ed2 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -236,6 +236,9 @@ static int qxl_add_mode(struct drm_connector *connect=
or,
 		return 0;
=20
 	mode =3D drm_cvt_mode(dev, width, height, 60, false, false, false);
+	if (!mode)
+		return 0;
+
 	if (preferred)
 		mode->type |=3D DRM_MODE_TYPE_PREFERRED;
 	mode->hdisplay =3D width;
--=20
2.25.1


