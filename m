Return-Path: <linux-kernel+bounces-142834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B4B8A30A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804AD28750B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080DB1332B6;
	Fri, 12 Apr 2024 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQkhiatD"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB8813329F;
	Fri, 12 Apr 2024 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931854; cv=none; b=CdcTOWTqwgmKjuRHoODzYVK8bKP8hWyn1ge7PvKimUcrANONEmSuYOjlPA8oNJxGBJrX6mtNEIqnHNFtKpmGviIt/isELl8jxMotJ8P3SOBZrZG4A4SmBMiLD1t9MBaRX/GgiyUJIVdsq/yt0/0/ZR7rz68sQxO+FqGJGrh4bXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931854; c=relaxed/simple;
	bh=nQsr4zJZqo6g2ONPE9BPL84r5IX3WtjDVrxRxwxOwDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkC9XMB8E/qG6ElH2XoxkQGXkVdOZgNimpWPGelYhaGTuMqQjowko8xSDX6m78vcrcPXBQKDcSlH/z9neCzQ2ZdCTBuDJyFiY2QfMWAGopkIVrTGUvpGAa44juCVDbmll8ztrFpohnB+74kOfid766fvl//Xtqj+y574AJa5jZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQkhiatD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed20fb620fso779325b3a.2;
        Fri, 12 Apr 2024 07:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712931852; x=1713536652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ycTUqQHx5D5MreNoECYZAdXjkRI9aE0qu1OLjEN7fk=;
        b=mQkhiatDI8+/MZxF39XJhGVw5Rr/7KXW3ENYJKhqGDRzGIZ7t2g8oiusGwsW6oXtXD
         JVwXNcIODk4IXR1C8c6X9eeqFSyThBmmF0nlajyUNAYoRUuOkB2wWBtV4ebNL6Oheiby
         0tnduggMED3JciR1VvpXoOxMI25FXXnc8w+zNehyZ3V864EM4uSFJ3zX2OO0O/QOPv85
         oGOAB5b3r1vDMsdNm00SHQosQr5XayBm4KH1QpeTMkOiHWWlwwNK9OYQR+QJBMViX3Lo
         CsqQokfMLP+vKBF6ZKsJBHJru07k9juXwXORhC8bhW8w2mfkXKHo9i0Z59OSARWpL506
         FKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712931852; x=1713536652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ycTUqQHx5D5MreNoECYZAdXjkRI9aE0qu1OLjEN7fk=;
        b=k08K0VP5728GOjlKIh2/LApMDSIxA+Dti5tK5aHWguF0xJEHyGsvoNZEbbUKP+xn2D
         4thrvj8m+1QOPFecvDa/eybiAfJqECA+WXVIIUcp5PkytU0zY7ScR9PX3CU2387KrQb7
         3G2UyjYbp/NfA7FS/uzubAtFKAo8BZeYTTop2PpYuuba7UFEEd5oj7S+hEqaw06p4yTZ
         zRe6WCQmjUgNTzcBbpWJsecJI1gjy1PGMwK+fx7QP/Kt5HDJm/3t3EPi1ySDivjtVc5c
         81h3A0d51+HdVADBUDJ3kce0ahibqkfBaDGTAATeGtPE2isXAqVIM8VWZ3Q1jSqC7+8Z
         rcEg==
X-Forwarded-Encrypted: i=1; AJvYcCXtLnKHgKv+mR8eMmzbwpyDNT49FZxQp9dOG06W+gkLV6jjwP/X73m8HxyqpWzDneoV6DdEAESDMG4xZZupP/jbn56mal4gfC+j8AfmFlPjZBT4myoSW+8m9vSxMIgOI29aH0oIP9QPuUfeWrgiVB2geX1ker9CyTYX2L3WVgnr845H/djrUZf+DJ8=
X-Gm-Message-State: AOJu0YykvthCsvGJsHN5md7jgxXzrU+LBIpDpbO9u8H7VTVDoVazn/+U
	YF5pzuHYhreaDyeqikDMondQvAqjRGPOpIlW1hI/Xi18Y/agW/5f
X-Google-Smtp-Source: AGHT+IEVIzMZY6CCMhIHZf+aL4aqZNSAeFET5jkH5mSvmrZ4I4gbLuytamFXU/gqKehAc/d6O6nkoA==
X-Received: by 2002:a05:6a00:acf:b0:6ea:ad01:358e with SMTP id c15-20020a056a000acf00b006eaad01358emr3589380pfl.0.1712931852323;
        Fri, 12 Apr 2024 07:24:12 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id n43-20020a056a000d6b00b006e5af565b1dsm2946952pfv.201.2024.04.12.07.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 07:24:11 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Johan Hovold <johan@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] usb: dwc3: exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date: Fri, 12 Apr 2024 19:52:54 +0530
Message-ID: <20240412142317.5191-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412142317.5191-1-linux.amoon@gmail.com>
References: <20240412142317.5191-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
care about when the functions are actually used.

Also make use of pm_sleep_ptr() to discard all PM_SLEEP related
stuff if CONFIG_PM_SLEEP isn't enabled.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: fix using new DEFINE_SIMPLE_DEV_PM_OPS PM macro hence
    change the $subject and the commit message

v2: add __maybe_unused to suspend/resume functions in case CONFIG_PM
   is disabled.
---
 drivers/usb/dwc3/dwc3-exynos.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 5d365ca51771..3427522a7c6a 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -187,7 +187,6 @@ static const struct of_device_id exynos_dwc3_match[] = {
 };
 MODULE_DEVICE_TABLE(of, exynos_dwc3_match);
 
-#ifdef CONFIG_PM_SLEEP
 static int dwc3_exynos_suspend(struct device *dev)
 {
 	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
@@ -230,14 +229,8 @@ static int dwc3_exynos_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops dwc3_exynos_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dwc3_exynos_suspend, dwc3_exynos_resume)
-};
-
-#define DEV_PM_OPS	(&dwc3_exynos_dev_pm_ops)
-#else
-#define DEV_PM_OPS	NULL
-#endif /* CONFIG_PM_SLEEP */
+static DEFINE_SIMPLE_DEV_PM_OPS(dwc3_exynos_dev_pm_ops,
+				dwc3_exynos_suspend, dwc3_exynos_resume);
 
 static struct platform_driver dwc3_exynos_driver = {
 	.probe		= dwc3_exynos_probe,
@@ -245,7 +238,7 @@ static struct platform_driver dwc3_exynos_driver = {
 	.driver		= {
 		.name	= "exynos-dwc3",
 		.of_match_table = exynos_dwc3_match,
-		.pm	= DEV_PM_OPS,
+		.pm	= pm_sleep_ptr(&dwc3_exynos_dev_pm_ops),
 	},
 };
 
-- 
2.44.0


