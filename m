Return-Path: <linux-kernel+bounces-88142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7693F86DDD3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07063B2743A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181206A335;
	Fri,  1 Mar 2024 09:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="P8auQz5C"
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC546A03E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283955; cv=none; b=gzFet53CkER+qEBOX9iya4IWb8rbjdDCM8XGrryZpJZXqH3KvQG/7l5sZIgpRk3dYHWHur4m/WMj62pEfJi7U51v0IMjs/SP7RSFNNnjUSzJ0kyzMls59zLo6VF+lqqp7ixS8NSMStTeHUOAiYrcrR44ErvI+BR6lMDETD9luDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283955; c=relaxed/simple;
	bh=U6zrGDf1CH9J4v5DCBN2pKsyO7iS9kDU6k4Ptp3kKy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mo6eJLROW9hxQH2hBOpR2T6arW5FW3JAjTD4rdurh+Vv9wGRwTSMpelBPiNsNsOUrTf9U6ZtE4pMrZcyg5A/32YkUw4xkIqYpwux2EKUBBSju4pYu0iTw2CfM7scRQNCRYi0UNRGK0HAl3ROu7gP/0bmx57mbNjVcslHzYyiPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=P8auQz5C; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 20489D998EC3B;
	Fri,  1 Mar 2024 11:55:33 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id z6G6-abwn9Qu; Fri,  1 Mar 2024 11:55:33 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id E0C91D99A42FF;
	Fri,  1 Mar 2024 11:55:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru E0C91D99A42FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1709283332;
	bh=f2qKsIAGkUNEVelOg7DTK/0b4IF/e+zG6QgMW3olvD4=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=P8auQz5C6OaEzL92Wd4UVkrC0+agep5xnkw9WQbAvEflW8hYcBiV0bOPGTvWixe7R
	 5gxvNYDmZDMIDT39UZNaUeriACLVOP+LYwBzNwp2rfCUbIjLGIV4y+Gn9PkkJH1Er2
	 JUF5lJQmT3mMEr+/Q+tD7LNg94RH6EhR51r9IvJ99jPoMVABIFcQizUSbngm4T9xos
	 YOlMDOS/3uc9mLjR6mQOjQb3qWpyRgPOrUpRCM0lhwhsDpkcZH8FPO5fhQU+YqsFOp
	 sZn27iVdF2fI7cmW584/cJT+Vz4OzY87Bc1BK5LaXVEkH+8L44a/1Ao+xDCGi3r66n
	 9aqkPUQvTnBAg==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id I9d5Qmb4AYe6; Fri,  1 Mar 2024 11:55:32 +0300 (MSK)
Received: from ubuntu.localdomain (unknown [144.206.93.23])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 97E4FD998EC3B;
	Fri,  1 Mar 2024 11:55:32 +0300 (MSK)
From: Aleksandr Burakov <a.burakov@rosalinux.ru>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Aleksandr Burakov <a.burakov@rosalinux.ru>,
	virtualization@lists.linux-foundation.org,
	spice-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] drm/qxl: fix NULL dereference in qxl_add_mode
Date: Fri,  1 Mar 2024 11:55:11 +0300
Message-Id: <20240301085511.23298-1-a.burakov@rosalinux.ru>
X-Mailer: git-send-email 2.25.1
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
 drivers/gpu/drm/qxl/qxl_display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_=
display.c
index a152a7c6db21..447532c29e02 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -236,8 +236,10 @@ static int qxl_add_mode(struct drm_connector *connec=
tor,
 		return 0;
=20
 	mode =3D drm_cvt_mode(dev, width, height, 60, false, false, false);
-	if (preferred)
+	if (preferred && mode)
 		mode->type |=3D DRM_MODE_TYPE_PREFERRED;
+	else
+		return 0;
 	mode->hdisplay =3D width;
 	mode->vdisplay =3D height;
 	drm_mode_set_name(mode);
--=20
2.25.1


