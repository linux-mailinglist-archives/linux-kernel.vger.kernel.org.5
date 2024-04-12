Return-Path: <linux-kernel+bounces-142831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BE38A309B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323472841AD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E6F131BB7;
	Fri, 12 Apr 2024 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtdUTAvW"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2BF127E18;
	Fri, 12 Apr 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931838; cv=none; b=BS4eWvREid1zIeOk349SbJm+i5FLYhrSsh8gvFn8wYmSmGN30r/xTTvVZg+aTW6iK7vH01yp+BRnXr/r3fB5+jXupjPD0S2MfRFBD6wgciZQD3DtfrdJpZ12k+kCn9yk4bJT2xoSERq7JHiEMIe/LjGLS/HcPR+9P9u2OKVx4Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931838; c=relaxed/simple;
	bh=kpmI1kJ5CiC906Na2qpuKgKUS/Inlp19HDZ3ukQQDqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVPfzZFO7LdKaLGPsD1CjbFvESuPuW7wWpVjq2PDJdXsr2taF61paxY+MLVAUyNAIk5gQxsvEJiFHHiAitN2ceT2B4271MLrttFtaT8WzgI6a/565z8tl1DIkhWQR5TrfLBJmoHerIa8bNN+NvFfppMaZRkVmim3QSR9Mo5y1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtdUTAvW; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22edcfcd187so316641fac.2;
        Fri, 12 Apr 2024 07:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712931836; x=1713536636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnop7Tz3u3A6Y7l9rLZDgV358HdsfnR1FGKtIeVuKBc=;
        b=XtdUTAvWBSHMwTnvEh5gBc+1XQ5VjscOHCK2pTsP+RPcYWaFyKOO8XXpvbIJy2Gnif
         5fT4JOavbQk7nNvAj7+L3EmjTEMI4grCClbLfdP4n6svj2MGh77jbYtmRMzyLJmbkq9e
         0P6Ln4+Z0mb2ERvn9w2J/BauCKVIuRbEv1q6WBn2Uiap0t3gxFX86bFx7I4C24lnP81G
         Ki1zQE0r4x2O4hmT892HF7L8W3z6RIo+iR587v/9q5qN8aclJRfEWxXEguDZ5L+S+3Eo
         ZAfW0abjGs4EYw1fbXEaXwdu3vYfcj+PzT45uwdRyrI3chgZhr/jBtBEVejoeIJhLcp5
         akaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712931836; x=1713536636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnop7Tz3u3A6Y7l9rLZDgV358HdsfnR1FGKtIeVuKBc=;
        b=JV7L/jdnh8xMI4GMwthxb2zKGlTsm67nLWJYyXCu+FhzerR/gHzFus6GjTfsplUi6R
         4eevqLgwFFU+bFJPJnjV7wJqEeNedoXLa6Pa+sl7Ox8vdHoYH35K8ztTO7UgGAiOYSZR
         cWlv+inFXCzU1L4rF/zXCf6qlOWJvYLguSyQaBhmXzQxLWlrUzWv//Pr5Qvgo5/qOgaF
         CCymJULD5U0ag2d0YwOdnKxAu/FMO3q2PVwg7VFjeF2MzR7kdW7UuMME4ymONdk0+JGH
         2myaVH1kuS+v2XkNsfa8aH+NmICimSaVn+9Pzv+83Zkq9QiV+Ghy8glntNdNMDbtRktk
         BxJw==
X-Forwarded-Encrypted: i=1; AJvYcCWJWHLA5aAZmgvLUTFzNSHHdz+EGfeqqBho+6iXsbFpL02B6fOtTRfIiVZW69tAyo7aqkZ7gUqVABobHNIpQISfWJCc6sj+BYHUQlwuhkvdgqAEzwFgMXjr1N+nHY6kuC4FaFmltJx8pejJGa5jekHfJ7zjI+PULaqKQfkV/68Cny8QpvN73L+UKlY=
X-Gm-Message-State: AOJu0Yw4YyeqSW7LaiJCv2pZ9pgIY56e3oRrUb7uFFhP7FKxMHZLHB/r
	2zWAPs0lWas14MUV8JYgVxJA5/gouL/i7zoNMJ0CBopMQuh406b+
X-Google-Smtp-Source: AGHT+IESH4fkXQOzELFKbwow3I/3zmYaBjB31FBeox2i7Lpcl/4hma+H6YA6EljsfIfiVAabwskJIQ==
X-Received: by 2002:a05:6870:4194:b0:22a:f96:28b3 with SMTP id y20-20020a056870419400b0022a0f9628b3mr3085006oac.53.1712931836388;
        Fri, 12 Apr 2024 07:23:56 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id n43-20020a056a000d6b00b006e5af565b1dsm2946952pfv.201.2024.04.12.07.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 07:23:56 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Johan Hovold <johan@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] usb: ohci-exynos: Use devm_clk_get_enabled() helpers
Date: Fri, 12 Apr 2024 19:52:52 +0530
Message-ID: <20240412142317.5191-4-linux.amoon@gmail.com>
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

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
      call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: drop dev_err_probe to simplify the error handle.

v2: new patch in this series
---
 drivers/usb/host/ohci-exynos.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 20e26a474591..89e6587c089b 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -135,20 +135,16 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 
 	err = exynos_ohci_get_phy(&pdev->dev, exynos_ohci);
 	if (err)
-		goto fail_clk;
+		goto fail_io;
 
-	exynos_ohci->clk = devm_clk_get(&pdev->dev, "usbhost");
+	exynos_ohci->clk = devm_clk_get_enabled(&pdev->dev, "usbhost");
 
 	if (IS_ERR(exynos_ohci->clk)) {
 		dev_err(&pdev->dev, "Failed to get usbhost clock\n");
 		err = PTR_ERR(exynos_ohci->clk);
-		goto fail_clk;
+		goto fail_io;
 	}
 
-	err = clk_prepare_enable(exynos_ohci->clk);
-	if (err)
-		goto fail_clk;
-
 	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		err = PTR_ERR(hcd->regs);
@@ -191,8 +187,6 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 	exynos_ohci_phy_disable(&pdev->dev);
 	pdev->dev.of_node = exynos_ohci->of_node;
 fail_io:
-	clk_disable_unprepare(exynos_ohci->clk);
-fail_clk:
 	usb_put_hcd(hcd);
 	return err;
 }
@@ -208,8 +202,6 @@ static void exynos_ohci_remove(struct platform_device *pdev)
 
 	exynos_ohci_phy_disable(&pdev->dev);
 
-	clk_disable_unprepare(exynos_ohci->clk);
-
 	usb_put_hcd(hcd);
 }
 
-- 
2.44.0


