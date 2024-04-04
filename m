Return-Path: <linux-kernel+bounces-131016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4C38981F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27BB28B161
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFBE59B67;
	Thu,  4 Apr 2024 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un1wmfk/"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360856B86;
	Thu,  4 Apr 2024 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214901; cv=none; b=AA2uUWfwCWqgPTmYup5wd0DpFp4wbws6sZexLjjZLzJcNvwKJ2CcQK5a0cm1zeGU1HNQGpDBH1EDhwko/bneTX6eg89oVhUE3DQE6IUSpojlmqwkYt2qYzgJe7YpWbnIA/XY+SAP73G5TeGVlxxjr7SrgCY4HtUhbKntDfqBKwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214901; c=relaxed/simple;
	bh=7VfsWiQ1l31jCN/4UAoYZTHSVvv7BRUDCNtRMnpIbUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApfTYLQEbO85cagV/uJqLXCVi+RBD+6muhsNdirGUttvcGuibZujo8l0EKZ/PDcZO4FSrXqfINgz2Cqj/rrsLKaRFBrdbcpIsGcXbIc8cSgpAvnMifqO7oWUXTejxY8cXZb6qlfvFuBETqYIFelKVvENr6ggyyksuZBBEBVd+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un1wmfk/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e27f800ad0so4481015ad.1;
        Thu, 04 Apr 2024 00:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712214899; x=1712819699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ4F7NXXW550+bos8lcUggXlnE8ksWoIQYNv7Dbni9Q=;
        b=Un1wmfk/gc+C1iqFO5hUVVQXP1QrBN10SckrgexDxWX35aluTfn0KMRzroGBVGGlWC
         qtEtwxgv4ebL+YsO1G6/wXNHDgbVIC6ocjYhEHEXxSpB3upa1g5ks0rys2XE3cy6IbQr
         c2ED+ApIDiwR233MVLsR+9m0GpKdv9gwacmCQZhOWpdBjs88rYkPulqN8yiElDxrv+b5
         qVZscDAT8TWzZ/BfUK27a1Ood7TqosbsZ7mcn88TFYdXnZKcqCVXjbcItQT1IXiObTjY
         Q5qKG0HxfdvawJvJZAC1lm0+fk/qhs2AOxQ3Jb6OJ6NjXWBfXZUYorOX7sCVe7I4mXS4
         vSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712214899; x=1712819699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZ4F7NXXW550+bos8lcUggXlnE8ksWoIQYNv7Dbni9Q=;
        b=fUIFATd0RtTyyrrqWYuObiuousmXkB3unGMphdR2S4akzCH4+FieHg3m4MH3MSZzxg
         pz0ekeSwpuGuKD6daa8R30h33M6fLxL+YFE6q2qrEwmp5IgnIQPwjsQwWWqFxuu21wWd
         0+qkIE2rDAP3l/uqQoQYuTiKXt4eWDW+Bln2SeSwrf58K2m2ya3+c9dTGMmVvHSknAsT
         5IiC/N8KBTGyCvao+DoHOoaRYt25SAbmmb5cdQIpmTchxrtHO567aKJzHMkrZSXx8o+e
         OXC/gEYEsrb1e7RNhIPph7Ce1645gZ1nQMtbOn8GQDIvhKMQ/SVnzfALfFn0+T3SS/bK
         Az6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+lVzCuPKkOEqb+l7ulDgmNjoAc4h6joqeUs9ovFxanKmMlx9xyFQPbtO1yiy1PZTC3l0oEuD9KcEAREF6TfYbNoZCixE0UYcJqeQYO5ncqGzMAfTlYwNcmRR3M9Iy7ujo0a7pzSZjp/gcajO5PZh2DHrO7uRPiqY7cEZol9Izl+I9LCJ9ktq2HKo=
X-Gm-Message-State: AOJu0YyrYF92FZnQCFX1yxoI+QU0x5CEnIfiiR1Plehd1vT8YS3mtAf+
	l9SgyfYL5LPPiX8AhLXePYV5SsrpQnXpB1/1UOFMT0CrAKCknkFo
X-Google-Smtp-Source: AGHT+IF4BglLZMXCnf9J9jEVYynLdLpCHS08eS/S41aNbkggt6yBZJUUl2YbEY/gGHbUJI38+3Orow==
X-Received: by 2002:a17:902:ec83:b0:1e2:6240:fe46 with SMTP id x3-20020a170902ec8300b001e26240fe46mr1426005plg.56.1712214899018;
        Thu, 04 Apr 2024 00:14:59 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f2d400b001e26c4823d0sm5220873plc.52.2024.04.04.00.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:14:58 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>,
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
Subject: [PATCH v2 2/6] usb: ehci-exynos: Switch from CONFIG_PM guards to pm_ptr()
Date: Thu,  4 Apr 2024 12:43:18 +0530
Message-ID: <20240404071350.4242-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404071350.4242-1-linux.amoon@gmail.com>
References: <20240404071350.4242-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new PM macros for the suspend and resume functions to be
automatically dropped by the compiler when CONFIG_PM are disabled,
without having to use #ifdef guards. If CONFIG_PM unused,
they will simply be discarded by the compiler.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: add __maybe_unused to suspend/resume functions in case CONFIG_PM is
disabled.
    dropped RUNTIME_PM_OPS
---
 drivers/usb/host/ehci-exynos.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index f00bfd0b13dc..4cfde1af32be 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -236,8 +236,7 @@ static void exynos_ehci_remove(struct platform_device *pdev)
 	usb_put_hcd(hcd);
 }
 
-#ifdef CONFIG_PM
-static int exynos_ehci_suspend(struct device *dev)
+static int __maybe_unused exynos_ehci_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct exynos_ehci_hcd *exynos_ehci = to_exynos_ehci(hcd);
@@ -256,7 +255,7 @@ static int exynos_ehci_suspend(struct device *dev)
 	return rc;
 }
 
-static int exynos_ehci_resume(struct device *dev)
+static int __maybe_unused exynos_ehci_resume(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct exynos_ehci_hcd *exynos_ehci = to_exynos_ehci(hcd);
@@ -279,10 +278,6 @@ static int exynos_ehci_resume(struct device *dev)
 	ehci_resume(hcd, false);
 	return 0;
 }
-#else
-#define exynos_ehci_suspend	NULL
-#define exynos_ehci_resume	NULL
-#endif
 
 static const struct dev_pm_ops exynos_ehci_pm_ops = {
 	.suspend	= exynos_ehci_suspend,
@@ -303,7 +298,7 @@ static struct platform_driver exynos_ehci_driver = {
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver = {
 		.name	= "exynos-ehci",
-		.pm	= &exynos_ehci_pm_ops,
+		.pm	= pm_ptr(&exynos_ehci_pm_ops),
 		.of_match_table = of_match_ptr(exynos_ehci_match),
 	}
 };
-- 
2.44.0


