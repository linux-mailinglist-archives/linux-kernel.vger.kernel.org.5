Return-Path: <linux-kernel+bounces-109981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226BD885884
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1EB728298A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C597859B68;
	Thu, 21 Mar 2024 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk3W9GMW"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B8BC2E6;
	Thu, 21 Mar 2024 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021412; cv=none; b=OVzyPsVQTnO8J4EXJhDfOr5PrSbygNopDkzJi8ndarEA0MqlDssSnsdjywH5k241UKfzZfPKKG6X2ifMaWxfMYGUN+PlivvkWT/bgxAd70CpOO0VVcnIk+fEPmcUfxCGw+4P29cOHAbI93asnoZvGyxgi7XD3htgMaxafPSKDxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021412; c=relaxed/simple;
	bh=kVTcSYVlxiNdGAPex2KWtA59f+dbd3O5+Vu4XbQrvY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=az5w934LgJIbn1wrVFn6Mw4smOokvAj9gO454gT0fUmKyJFOBjERrCYY91LBwwO7b7Y2rZMZStbkvn5yv7KPzpgBEDVEPJ8Z2IrSnNVbwo+0pG6SSaMN1SmQLUF49IBx1wopCzI6udblh5PbVegQt01M0FzEN4TOwiqJ2RmRbR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk3W9GMW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513dc99b709so1114699e87.1;
        Thu, 21 Mar 2024 04:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711021409; x=1711626209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWa9cNlH2bwcsVyoxfbxpoI0fh+ZRIvLCT8SC9LWbR4=;
        b=Lk3W9GMWeGxWAy/HMQK5ISfwk+vS46wqAYBxuzGX/+Z6SpG8tpe8V2hywe/GXPG6re
         c+Ai/XjoQ4fEjPXke+omOhANWlsJiY4ucVpaXYZUoadIkJcIFCfUwN79AuY3uFGji/PB
         gueDxeCPNXMQbFz5gXz4x3JOExXy2mJ2WjlDtEAAtZZl+ShBylCtQ2crzIPmMKvlpgEf
         BDXyt/GKG05ejSiiVkkSrobSlIaiFS7TUCf9loPwdrJ6zet9Cg+skrDqj/t/us2bZmlM
         LXu/WmYaYF7CR5jkJcKjgRQYg1zLyOUHUqNq9z5c7jJggMs9QCMBndYisMy3OAbPPAVM
         ERDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711021409; x=1711626209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWa9cNlH2bwcsVyoxfbxpoI0fh+ZRIvLCT8SC9LWbR4=;
        b=xADD7RyKIN8XeHPxPxzPc69bp8trzKQvD/uNrcLAK+mOqXpOUgwZMvpSTR1yGLrF92
         IA2jyPMkpJ1lCpruTIrI4cixP+QSmcB+3jgGCzY6GBQCi9inmU0OCbaZXlU4+VxfDRW/
         l4M1Ua7XW3C7JUxGQuTLCitjgPpJ+wW8AXdb+UQ3tM/d7Ox17IXptjXIvc0VSUbuH7i5
         O/LxenSuNM6qwb7WRay018f1pXK7W8dLzz4h1bMS8/mw2oVpIo9/XG9QziKN6wfJwzsl
         59czHlz8TLpFKB2qfiq1+sAjZ5YmTNE5FFOfY4wQa+xcN/rBzcpZTPD3GzExer/P36Eg
         AU9g==
X-Forwarded-Encrypted: i=1; AJvYcCXcEEtaf5x9PMHl2hgwe+pr3dLJ96maPeJBoDqu26aR3Sg0FjOEke0Snv9FBUWlljS05NbK8rn9F4hiI52jo61xFKIFvLXjFSVNk0Fa54oTaiw=
X-Gm-Message-State: AOJu0YzmCbFcG1MrqG5MO7rH0AeAwbVVL4gvTfCXj6QJB9YnHIH6a2Zs
	KsRQStlmtsPihBPnH/g4Z0rLgoyVOtqdgfGqJlUMqStxSRvL6GMz
X-Google-Smtp-Source: AGHT+IHKtSMvapJOFM5r86jXsJCYKwGum/KMaLb8NhfgW1rvWKC+qx2xi4hdDlzErPiExeFRshNWdw==
X-Received: by 2002:a19:4313:0:b0:513:c957:ea4d with SMTP id q19-20020a194313000000b00513c957ea4dmr5381476lfa.43.1711021408467;
        Thu, 21 Mar 2024 04:43:28 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:b4a9:c4a1:8759:9c01])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b0041330d49604sm5387363wmb.45.2024.03.21.04.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:43:27 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] reset: reset-rzg2l-usbphy-ctrl: Ensure reset line is asserted in error path
Date: Thu, 21 Mar 2024 11:42:01 +0000
Message-Id: <20240321114201.359381-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

In the event of failure during devm_reset_controller_register(), ensure
that the reset line is asserted back.

Fixes: bee08559701fb ("reset: renesas: Add RZ/G2L usbphy control driver")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index a8dde4606360..43eb01105596 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -132,8 +132,10 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 	priv->rcdev.dev = dev;
 
 	error = devm_reset_controller_register(dev, &priv->rcdev);
-	if (error)
+	if (error) {
+		reset_control_assert(priv->rstc);
 		return error;
+	}
 
 	spin_lock_init(&priv->lock);
 	dev_set_drvdata(dev, priv);
-- 
2.34.1


