Return-Path: <linux-kernel+bounces-98346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539CB8778AE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858311C20FC2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616153B2A6;
	Sun, 10 Mar 2024 22:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="IEoPgsYC"
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de [129.70.45.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C9236AE7
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710108269; cv=none; b=hELXf6tDIFx1wYz5bSJZCx0bR4jqfTl4ioxGUXeZPMp7UR06klYFooXtDhvWhMbL/BWmV1RYeO6OJCiJK8F0Rarb50Db1OvThwk6N4qcyizbN6SpL7Yw4vm5rJAT2V8yITfGjvxeuZ11yYtwHENkeQJYAalKEkVGTH3/ILP5JAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710108269; c=relaxed/simple;
	bh=xIEzLT2GAIp6whP8aTz63TNnh63lFskfTBq5DGV4TlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fyl4DL/PfWltSHqLkf3ZmkcjntbVS++CAIJAZ6c3rR/g1FdWlHKdu9Ayna7AWbN/u9klja6V7dXc1NDYWsb20o6Hua3j29PSFDYRxRCm+RxAkH8fhYbHybJYRJlFDTNzik+1awgkl6IPOO+JPBWPVRjkouu0dmtVJ5u9JseKgEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=IEoPgsYC; arc=none smtp.client-ip=129.70.45.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
Received: from localhost (dslb-094-217-220-071.094.217.pools.vodafone-ip.de [94.217.220.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id C86F560425;
	Sun, 10 Mar 2024 23:04:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1710108261;
	bh=xIEzLT2GAIp6whP8aTz63TNnh63lFskfTBq5DGV4TlU=;
	h=From:To:Cc:Subject:Date:From;
	b=IEoPgsYCdTs3KlfbG1RIwa4eVjjC/7DQiAcuQcZtd0PD1g1iXceb9KwMEmxYIy2GG
	 8eZAbmqzZnhkVmDiXwanGccaB1dvJKyR4we8KRK31X8Fp3TdQ271s7KGIoaHrxUACT
	 c8kD4WzxOsGQ5B2FsnamruylAbcaa9AWQlQrdknRZOqiavHzDX5bsmHi6Nwo/3KKH0
	 FwG9FBkOdnMbH6G5STdAIXmrt/mlFaCEqRHOBmiiPkBY2JJymhEe+hf0UtLaGTxLuX
	 48/WE9dBNv6nxL7yGC1LSZVmcrOxsi8LxYPLtugVe4JGLyuuauhGEEclqRVyEKqNrB
	 Nfuebz1wqcWXQ==
From: tjakobi@math.uni-bielefeld.de
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] drm: panel-orientation-quirks: Add quirk for Aya Neo KUN
Date: Sun, 10 Mar 2024 23:04:00 +0100
Message-ID: <20240310220401.895591-1-tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

Similar to the other Aya Neo devices this one features
again a portrait screen, here with a native resolution
of 1600x2560.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3d92f66e550c..5d3fb11fd45f 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -196,6 +196,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "NEXT"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO KUN */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
+		},
+		.driver_data = (void *)&lcd1600x2560_rightside_up,
 	}, {	/* Chuwi HiBook (CWI514) */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
-- 
2.43.0


