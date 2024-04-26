Return-Path: <linux-kernel+bounces-159884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F078B3570
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49DC41C21D87
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21348249E;
	Fri, 26 Apr 2024 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gGKSthFZ"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A0140360
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128099; cv=none; b=GbwKJxKDexTpN1RoeQpEva66BRSDmBMBMX8p9mw15DOxKDf2EDJZotP8zCkD7p0UWngnteNROaV0PQIY4nifd9SgtcvydSe88bPDAAaxQnSU+Xol9ZZh2XUnmwL9L9wMc8abHTXqh2LW9FC6y0BZyDXsPohqp7uaTgvadQT5pwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128099; c=relaxed/simple;
	bh=n9yKBX8qjigC7/F1M8bGWOMSsRVeFv1nqroVB06gU6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUmlXHtOYFwlcKDZIInvqeASvRBb5tFNCh0JuXQpOAKecHpduHPdwJUxmHxmDa8yeJYH0XppN7AvfD0R+wpG7CHZgXS4AbNPe10fL4okR3GkvI9kAYWSMmRAM9MsH455vLFHU6U31Zfd313uM/4mjibRB2QL8FS957wsEmTGmtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gGKSthFZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso27630241fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714128096; x=1714732896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbXwx/HNBBmagZEhDQ/BaLCRVM/2fRQKE1iroB24Qwo=;
        b=gGKSthFZvkA+Zib+3mbp41VlANM9omptCOYSOjA479RlBErhZXCDEpbMJXX7qrOFt0
         oobkbbebp7v6BMFUh+wGtUURdS4ndLfhWn1AP8JZEOy5lvvwAaVyH+Z5krFsY1gJY04L
         JcC/cnEX1lpzbb9RoUjICQHvhaLPQihaPW933nRmKCjdv3sZZFBapyhq6pnKRVliT9w8
         bkOAde3yVqpf2eo1X0wzhdiHSGE788tgBxj2kO1lF52aYRfRwP+p0Xv5S/IQbW8SsLdr
         iahP31LUeNNFeaGSUk6h9DKaiXXv36NOWpa2Tb4BkYrfGajKXCg34Vg1H0U8H86Xm+rN
         X5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714128096; x=1714732896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbXwx/HNBBmagZEhDQ/BaLCRVM/2fRQKE1iroB24Qwo=;
        b=YqDeUGCZOIDutBQ4JWV1AMVaOlnVJH89J8IsxLgYGDsDlEcnWFXRtd5/uWPqDjtpbq
         KAJNNSS13ns/r5pCPXxMmju2ktfvBhenazP00cmNid859hedyrRerQPM2slxG635v4qt
         XHEYCYicW0mn/tLGjn36/wrT3oCOKeM5EYRYmT8qAyHkbEti8ClmooQTPFJ54ybMo2If
         OSn3b2Y1yBr1nJvilQm1v9Nb/SAB8oxDT7wt0oj8hZiV+4TQZ6rFQV5LijFm+Hq2jvGc
         us98NVTRr+ESbtCXfmcsSvsPK8RMZqwXGaYwQmHw9Lg4L6D4S/M2eGgTmLOAuHYzAQXy
         Qhxw==
X-Forwarded-Encrypted: i=1; AJvYcCVxDt41pHSoXxE+31jGivlyI76L5BbMyIvwtwltpKWV/oxwhjD0lUWcnCDxdGf/Bz4O13V9ARDahwus3AlQ6OjPNm84EQyTzE3NidPg
X-Gm-Message-State: AOJu0YyF2jBOD421MaEz9C8knReD3sU7s+bEoLuOK61sbBpD96Fde/wl
	HFcEaZMDj7y+lIVNEYIoZ1OA2HanjDvzru7WlwAzLnkVD/E1lEHJPPyjGXY9HM8=
X-Google-Smtp-Source: AGHT+IHiylD7VQWD1+ej27FAWnFwoUKQ+ZEhfuiu1lnbA/xYwpsUIFHWtBloSi6kC41eD+L1ByFyIQ==
X-Received: by 2002:a2e:a1c6:0:b0:2da:36be:1b4a with SMTP id c6-20020a2ea1c6000000b002da36be1b4amr1770332ljm.19.1714128095556;
        Fri, 26 Apr 2024 03:41:35 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:63cc:9bae:f542:50e4])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c510e00b00419f572671dsm22035335wms.20.2024.04.26.03.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:41:35 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: vkoul@kernel.org,
	kishon@kernel.org,
	krzysztof.kozlowski@linaro.org
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 2/2] phy: samsung-ufs: ufs: exit on first reported error
Date: Fri, 26 Apr 2024 11:41:29 +0100
Message-ID: <20240426104129.2211949-3-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240426104129.2211949-1-peter.griffin@linaro.org>
References: <20240426104129.2211949-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To preserve the err value, exit the loop immediately if an error
is returned.

Fixes: f2c6d0fa197a ("phy: samsung-ufs: use exynos_get_pmu_regmap_by_phandle() to obtain PMU regmap")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/phy/samsung/phy-samsung-ufs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
index ffc46c953ed6..6c5d41552649 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -99,12 +99,18 @@ static int samsung_ufs_phy_calibrate(struct phy *phy)
 
 	for_each_phy_lane(ufs_phy, i) {
 		if (ufs_phy->ufs_phy_state == CFG_PRE_INIT &&
-		    ufs_phy->drvdata->wait_for_cal)
+		    ufs_phy->drvdata->wait_for_cal) {
 			err = ufs_phy->drvdata->wait_for_cal(phy, i);
+			if (err)
+				goto out;
+		}
 
 		if (ufs_phy->ufs_phy_state == CFG_POST_PWR_HS &&
-		    ufs_phy->drvdata->wait_for_cdr)
+		    ufs_phy->drvdata->wait_for_cdr) {
 			err = ufs_phy->drvdata->wait_for_cdr(phy, i);
+			if (err)
+				goto out;
+		}
 	}
 
 	/**
-- 
2.44.0.769.g3c40516874-goog


