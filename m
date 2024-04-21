Return-Path: <linux-kernel+bounces-152501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571288ABF65
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 15:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFC61F21820
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E308179B2;
	Sun, 21 Apr 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADPEmUx2"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58B1BDE1;
	Sun, 21 Apr 2024 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713707333; cv=none; b=sTu0zDqSkcviPo9GjOlFrnKijyZ6sQLhkuUIs3PcSkA4OYddLxjb+8VayDeQfYfIesChZWX21LKntSDRuRZFpDsAaoxL0o6uDeaVu1xie+ctAoeuHxGLvkwqQPJxLb+LOEfzYjqlhLts9IDkRT0i6NRuYbJXOvv6FBYlDeDz2Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713707333; c=relaxed/simple;
	bh=Jd1njSo+3n9Ssr8M/lLZxDhNFtu/DSBLSWYTX7TOnUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiXVBqkXcOgp+TG6Fphp/rB7Xw59xiG7DlsYktHIT9+TqQW9GeMm+wwsj4IQgHEv2/rrUB4125YYAhPSwT4AyBKFS99tCZiLrnuox3pi3AN0VmPD3kfw08sb2cYvHWbp6hjE9gzbyyfrVTt9YOgoJWRuhiMYNCrlpmBe4rdgTKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADPEmUx2; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dca1efad59so2598072a12.2;
        Sun, 21 Apr 2024 06:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713707331; x=1714312131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fr8lwupgPbBOYuK2auIrCKM8IcU0Dw3SnEDCwy+iiEE=;
        b=ADPEmUx2QA8kK1Z3ZdGerBmbmDJtpNHsFwEmnmNcJ0mc2C8/3/C5xbz1TQYvT40D1/
         njwGRP9ghgirOhW1ZA3T3DvWCKopXGVH49JGhf5u/54lh36ylmYh/LIxltWG1NIbwUfP
         EBajeXqPuxCP0ROzLbGBxgwDc9a3nF1Svh1E+7B6uaIDdHKYcqGCMXdljL/aVcnG47y0
         b1sBj0ClRHJ34oLbqte+0igf5+4TrnBIR6Dws1rONVwxmgvV+gMOGrGY38z1MiUQYlYo
         Lp2tAZlYnoeW3p+8NWoCIhjahIxOlEGXziZ66kKKr0lvariwlWymTCj3k+0WpWEf/5LW
         pYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713707331; x=1714312131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fr8lwupgPbBOYuK2auIrCKM8IcU0Dw3SnEDCwy+iiEE=;
        b=kRPMoflvM5i7k4NSttkSOUnrvmsCCGRpYQHao1Hk+guXYcluq8tGDpPubupHP9JUci
         h1nUYm/JHTWvsXzCxP59+IAuoVQ0RfmMaBl2eaQowKX23pUWHes92dj149uk7OF7iKv+
         JxENa3S5eO+SFGBLsf+YIJxKbIW6A/rcvmrIk4AJYbxJcLMibv8Za23aNA01KXQz37G+
         BYxwc+hklQoSzUDR4cGW9Frhih1ZJ6iLTNyVNhDb8z0pk+LMpwJUXC59782tRp94WctA
         JF6J69L5ohkn2z0yBaoTeA+035o1aHO2s6vc25FODFyHf+eEXfXTZ3ZwLGqsceak4yYz
         +tlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMaLnjIbBZ+jywBBxUWYagvWf957bauNzVRkWHYmfv3W2L5DpLt5PQQ2bVYBBjBMmMyFvUaSQGQV8tPudu3PtY896XWeShq9cY28bkO+zW14GD+CveR6YrL8pk2lW5P+zbZmp+Fks6up7NDTWmLaNq0lB/gaZ0nB19BLDjPJ/gFf++m+dIu5duKsU=
X-Gm-Message-State: AOJu0Yw5ODG2GtCzlEJ7uu+tMTcO1gi4/hYvhglvPn5ZprtdYvXVEkgu
	uu5B095sEBc8SU/SzSKNPw1DieyheN3Uv/itIU6v5jCWJQmiPY6u
X-Google-Smtp-Source: AGHT+IG2cLYEOHRWAkmdXIu5WTnMlfdKTjYNd65KFwSvWcxeRUQLWRPI7PE9DToAr9E/lnxyGyQ++A==
X-Received: by 2002:a05:6a21:99a7:b0:1a7:a86a:1132 with SMTP id ve39-20020a056a2199a700b001a7a86a1132mr8649495pzb.13.1713707331300;
        Sun, 21 Apr 2024 06:48:51 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id o13-20020a056a001b4d00b006e6c733bde9sm6175043pfv.155.2024.04.21.06.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 06:48:51 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Johan Hovold <johan@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] usb: ohci-exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date: Sun, 21 Apr 2024 19:17:33 +0530
Message-ID: <20240421134752.2652-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421134752.2652-1-linux.amoon@gmail.com>
References: <20240421134752.2652-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use DEFINE_SIMPLE_DEV_PM_OPS macro to progressively switch from a code
model where PM callbacks are all protected behind CONFIG_PM guards,
to a code model where the PM callbacks are always seen by the compiler,
but discarded if not used.

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v4: rephrase commit message
    add reviewed by RB Alan Stern

v3: fix using new DEFINE_SIMPLE_DEV_PM_OPS PM macro hence
    change the $subject and the commit message

v2: add __maybe_unused to suspend/resume functions in case CONFIG_PM
            is disabled.
---
 drivers/usb/host/ohci-exynos.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 89e6587c089b..3c4d68fd5c33 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -213,7 +213,6 @@ static void exynos_ohci_shutdown(struct platform_device *pdev)
 		hcd->driver->shutdown(hcd);
 }
 
-#ifdef CONFIG_PM
 static int exynos_ohci_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
@@ -250,19 +249,13 @@ static int exynos_ohci_resume(struct device *dev)
 
 	return 0;
 }
-#else
-#define exynos_ohci_suspend	NULL
-#define exynos_ohci_resume	NULL
-#endif
 
 static const struct ohci_driver_overrides exynos_overrides __initconst = {
 	.extra_priv_size =	sizeof(struct exynos_ohci_hcd),
 };
 
-static const struct dev_pm_ops exynos_ohci_pm_ops = {
-	.suspend	= exynos_ohci_suspend,
-	.resume		= exynos_ohci_resume,
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(exynos_ohci_pm_ops,
+				exynos_ohci_suspend, exynos_ohci_resume);
 
 #ifdef CONFIG_OF
 static const struct of_device_id exynos_ohci_match[] = {
@@ -278,7 +271,7 @@ static struct platform_driver exynos_ohci_driver = {
 	.shutdown	= exynos_ohci_shutdown,
 	.driver = {
 		.name	= "exynos-ohci",
-		.pm	= &exynos_ohci_pm_ops,
+		.pm	= pm_ptr(&exynos_ohci_pm_ops),
 		.of_match_table	= of_match_ptr(exynos_ohci_match),
 	}
 };
-- 
2.44.0


