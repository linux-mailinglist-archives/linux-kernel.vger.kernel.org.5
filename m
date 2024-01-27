Return-Path: <linux-kernel+bounces-41106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA6483EBF2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD511C21FEF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370BF1E872;
	Sat, 27 Jan 2024 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wPfzTSnL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17841E863
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706342661; cv=none; b=C58QNa4e71hvcSaM4ege+L6wmlfjE5KH6jZbdJySaGVfrAdoLutMJhOb8HmAxF64Wu3sG7VTCTF0PViEONwVFcxCBdrqgaM0dFp4b9NhP8e3TU1Vf7ZqwlrRLYLqYpI6mXb9LNfU9FVIVBLH8Bz2Hz6WEPcnNAgy7QFHXvXOgwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706342661; c=relaxed/simple;
	bh=+d1HJV+oqtFs0bU0G8OR0uyzqJEoUv2JpT9jgd5+H9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o15VB8FA3nv17jlGBEwdzUx52Zpu/YsCFapCc99OfbXeMK91FO6KEzBoNumWf+ggzz9W1hi/j4SQ+rBcBgIR/mRrU7KaXwKTyFVfpLj8hY5cZYW4eKc8XGfIkIzrVs9vf1WuuNNihJ7v0NnxbpXCMkNggcije4ewXyNBnxQ6GwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wPfzTSnL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706342657;
	bh=+d1HJV+oqtFs0bU0G8OR0uyzqJEoUv2JpT9jgd5+H9g=;
	h=From:To:Cc:Subject:Date:From;
	b=wPfzTSnLgE243uMUO/04o1rnKkcyQ2UWnpzYf/9yjiOTmzJ/8KLPl9oxXsOa27LRw
	 rgaxS1cpwFxMSw8l66MISWkRX7jfzi0sDL5C3JTUgwFupvGLW+ygPvBXZN9ppFk+xb
	 sMZwRqQCbpZ+bKDKzT0XnAXPcYakDh7nUe5fWcG6n0No/g9eMWFg+VVfYCb2R11r98
	 B7cYDVpQbYW3svxLKHAt/fSVF4usjjmy3g0TUo/ErVkh3Qwmltx0haqvJ1fLVcYFAo
	 UuEOGRA1Hg8bmiw8Hq3zagB8xMF8cmoFt9wHn8hVT4Yq+FJbaZXBqtiYfaafs0efFi
	 meIvOmP0Ph/jw==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A1FA53780629;
	Sat, 27 Jan 2024 08:04:15 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH] drm/bridge: dw-hdmi: fix trivial typo in comment
Date: Sat, 27 Jan 2024 10:03:55 +0200
Message-Id: <20240127080355.65770-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/Initializateion/Initialization

Fixes: 9aaf880ed4ee ("imx-drm: Add mx6 hdmi transmitter support")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index aca5bb0866f8..2fc7dae7b8f8 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2288,7 +2288,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi,
 	/* HDMI Initialization Step B.1 */
 	hdmi_av_composer(hdmi, &connector->display_info, mode);
 
-	/* HDMI Initializateion Step B.2 */
+	/* HDMI Initialization Step B.2 */
 	ret = hdmi->phy.ops->init(hdmi, hdmi->phy.data,
 				  &connector->display_info,
 				  &hdmi->previous_mode);
-- 
2.34.1


