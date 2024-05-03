Return-Path: <linux-kernel+bounces-167833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2808BB001
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A401F23588
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF9F155741;
	Fri,  3 May 2024 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VeHLohjq"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC1715535C
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750525; cv=none; b=PG+UGo6We9h/uIIxU5uhSkvwdsYtGnBaK1D8v3eQXV7UETaE1HcczQ0D37Q9IKouNPZtnE3FvmMJjNdMuKg9/V7U7WDfTN8XY8YTmS9CvokJLOwCMCL01T6Lil7PTJ3c2gjiJ3LwO7B0h40FiQS+WtjUVHdZUSeX/N6KflW1VQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750525; c=relaxed/simple;
	bh=SP42j9CgUufiyxU3nQ+lSzjh2IG6/vPluK3RUFWHhsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JoGhaduXSrKXv51YQO5B3T9gS6mOgueLeaU0ihzj33ykb2hK2YxxCXB6/Xa+uGp7UimGYJpkwYhxjknUDicVEcYOKo9p3hhxb5mClbShSC+V3kYYrijWyGDpLJejiO2K7a3hlMJSMsb7aXWzVQvogAGDIAkpuwxN2MvSmK2Ac7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VeHLohjq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41b9dff6be8so51336155e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 08:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714750521; x=1715355321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vEIqX+46YstO49KdzfUit+EY7cLOMRSSqZNN+MC6uM=;
        b=VeHLohjqRINAl+EDgnGS3iABYNvFrBb9ZZJ4TZyjx+vhIp8gvL9vUbkR2g9PJK5VVR
         UY2+Fx8ciREYHiEtZ29Rxm8LbezJ/XPgRidktuFfLRes7KQcEVjNJBi6R6w0HGJVczR6
         4p48TTmYfBpBFh+51FHZEpIJ2jKqFH6zF7kTq3HjHRYW14RCQRznqpUhCOOJlOo+7A5f
         P6zvpsGUiLfhmv58QHI2DEVw+uPujMlctBMyMfIMU5mVAS92G+pj+Z9U69WVnheNFe30
         bH3q5Ux37eDnSzOc9Qz+IPl4JVZimcsvEFJ6s0V4b9mkczzniqfpGulGBm6Qsei7Whhg
         Lp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714750521; x=1715355321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vEIqX+46YstO49KdzfUit+EY7cLOMRSSqZNN+MC6uM=;
        b=sujekFbLriaD2xzoMZo64s3TqOFfQZ/DePCPZCa1kH5LBU7TMI5ddsfR+dh11z5GoU
         MPlEbOkqqeAkwMenb3MC5HCk6r2+O6gnPWentHcxr2kSSzmF+M5aOVtOiFnbfk7XYeCM
         mwa/Dpz0PjW8l47imOd4ZsqWXbdrNR9UxfK+L80gBvVb5QGPlmu5Qrwo6eUBBQTSA3Xo
         9++47ygsMoxJyUJejIZghzWvnCdiLnlYNT/YunqQNPvVSBSe/aA4fWZ+B0zdOLZDXhAe
         pC/8E3OAl3msFkvgDobgZObRO9Zf3ux/nQ31t2lpY9Zmb+uivavXi2Ut2GdBYqvxcfxv
         lrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzObalgYMO6VQoIWy49wUl0p0q8FtrgTl1I2Lagoo2Ll+O4nS4+VDheq7NtSDfcOEjxO/K58UDngZHaoVsQRw+LjY24IM7+vI1Ld3s
X-Gm-Message-State: AOJu0Yx16lhHLfKo4ucJOsrK1KMKplF2R7zZbjesxriFmyoVg4rcHg21
	bY4Hx0oU34HImE93BYdpVeluYDM/mClwcKP3Jx/7A3RY2/kIcJjyTIU6LI+23Eo=
X-Google-Smtp-Source: AGHT+IEeDubyf88dJ1F/c3Og9mfDQHnx2tPeXqImVG53S9rY41X7jlVgH6PBon7anUpjzltE+G0flg==
X-Received: by 2002:a05:600c:2157:b0:41a:5521:d848 with SMTP id v23-20020a05600c215700b0041a5521d848mr2499549wml.25.1714750520756;
        Fri, 03 May 2024 08:35:20 -0700 (PDT)
Received: from [127.0.1.1] ([79.87.205.120])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b00418e4cc9de7sm9702373wms.7.2024.05.03.08.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:35:20 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Fri, 03 May 2024 17:35:13 +0200
Subject: [PATCH 1/2] thermal/drivers/mediatek/lvts_thermal: Remove unused
 members from struct lvts_ctrl_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-1-f605c50ca117@baylibre.com>
References: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-0-f605c50ca117@baylibre.com>
In-Reply-To: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-0-f605c50ca117@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714750518; l=708;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=SP42j9CgUufiyxU3nQ+lSzjh2IG6/vPluK3RUFWHhsE=;
 b=XEe30h/H6gys1feNgm+rZLzcV5J/Xy1Zpsm4B7NsLcCwZ4+d8iU7BJcBUbsdUPve9xEvBH2uz
 jqhA/ej8FdcAcU8FzxutsgptICjvq5bkBz5Off897RCh2CtDUcC3LQg
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

In struct lvts_ctrl_data, num_lvts_sensor and cal_offset[] are not used.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 86b2f44355ac..18a796386cd0 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -105,8 +105,6 @@ struct lvts_sensor_data {
 
 struct lvts_ctrl_data {
 	struct lvts_sensor_data lvts_sensor[LVTS_SENSOR_MAX];
-	int cal_offset[LVTS_SENSOR_MAX];
-	int num_lvts_sensor;
 	u8 valid_sensor_mask;
 	int offset;
 	int mode;

-- 
2.37.3


