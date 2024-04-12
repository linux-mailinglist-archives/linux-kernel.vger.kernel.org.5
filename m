Return-Path: <linux-kernel+bounces-142830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5738A3098
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E15282691
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29B9131745;
	Fri, 12 Apr 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="admVldIk"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D563B127E14;
	Fri, 12 Apr 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931831; cv=none; b=VRBI5d8Ky+V8dj87de+CQwu8WYUS51QpnK0yKAfHM0uzRYeR9uPzE3YSRxja3TEbXY13H3RSaXw+m5dYVu7mgevWsKtVjFmrzwWCwD0EhGTxPLxr5NwIPvAYPWcAjGG7sD0dPdwldpZTVG34aqklJTYejf9LlqPRaqtYdW3BQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931831; c=relaxed/simple;
	bh=RrFmeckkxLSFqYTd/rrSC0usssCyWG9iD+ADLmZ++Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8DBG7OVRFPNss+WQl0gLgbaWze2FTwbDQLqwdJsbNzXO4EtBeAfgNK+1wEZdmcxt5Is6KA2ZWlaufscO8MVYGSK6MnAYOnERXotYPFIi28Sz+WsWfkPjHDxT0HRdQ/fSqa5tyuCpk5bB3SN/cihvEkTczSuAHiavxBMyxEnf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=admVldIk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed5109d924so884718b3a.0;
        Fri, 12 Apr 2024 07:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712931829; x=1713536629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7xaoM/t7sWthomv9Zj/NBnEov5ePJmCQG8giDyuvlc=;
        b=admVldIkP5Mqe2Kku6tPUtIPrXCiL/dzoAvk8fTM+5+JZ0jfhapbfieQ5YIJbSVXiK
         D0zTY6p4a+Rbf6NfiRCFtpe2t9XAm9TkKFUC/wLh0ntjuabgyDBvK/X+/X1GsLfZk5Bu
         d3D/ZvBQqJZidR0tOZiB0ICNg6fbGKuFAdy1r+a4GFWX2USC2KOV/AMw8t4yQFCYpYDP
         AZR1AK3dURnrHNgBkoHauvIaa1YAua4Fr0T0C7c81vJPzgAfaIUz+AcYlg4Q9raVuF2n
         Hpzs5intNs+tQ4/4waWKpuso+sEbhCkZ7jAnCUHgGx8kXMhsHis8lFI3yqxfJcTbsynR
         tqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712931829; x=1713536629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7xaoM/t7sWthomv9Zj/NBnEov5ePJmCQG8giDyuvlc=;
        b=EguJMppm8l2kKbdopx+cVwYPUgbd5XycxMy9Uxcx+8CGH58e1ffLAwQSU4K52v1ZjJ
         6FHngbaxv8irlzz4/1JSV0a9naivzyjF/DM0VVhnUofSc+w9/TqpkZiAltkB2CAb9UGm
         kayaE7U1CynNpkDSL5XqTUHaQtJzMsoEqZTjlQbqjM76tTC29QwjfriXL+V3Fv19zEhl
         MGypMGqoMllkqXMwb/Yu1emKZ6B017ZnyEZIDSDyAEFTjrUoL464QK+MiWn8VZccbO6x
         f94kAg1Ewa5mxln240LuJUv/X1FFcXMynarNQNOE2Q6TBdafMki+Za0V/N3z2KeIKHid
         1bdg==
X-Forwarded-Encrypted: i=1; AJvYcCXXiCrISB80lP+phicQ1960zIFea9lDti698gSclfHQffBToxHuKgU9Y++7X18q3ZGVpsdY9SYRjyjuY4D46gjifHWpW+85VKQYseUd5T5Jobh0sWr7OU9fSwuLTbdXFMS0VMAGRBD1bX2HzwviPIEEwKsB8hUE/TM82eZDHa0GgJYDErO4z7fJAks=
X-Gm-Message-State: AOJu0Yx9Eotj5wemYitMIcHVvjpdo8veY0903bxV8Dm5TLK9aJR8B3Ff
	OmP46pfUU4FfzrVzesA0rLeVi/YpXeskNWZA2nZheNXN0lb4rgZiA67q0A==
X-Google-Smtp-Source: AGHT+IGgvnF6BriGZyRXskbwwm477hSiQyryuqYwynoyzyRo+4cTcjt9St+9+DXj+W6ilmPPRPfQ3w==
X-Received: by 2002:a05:6a00:a87:b0:6ed:4a80:133c with SMTP id b7-20020a056a000a8700b006ed4a80133cmr3144178pfl.1.1712931828510;
        Fri, 12 Apr 2024 07:23:48 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id n43-20020a056a000d6b00b006e5af565b1dsm2946952pfv.201.2024.04.12.07.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 07:23:48 -0700 (PDT)
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
Subject: [PATCH v3 2/5] usb: ehci-exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date: Fri, 12 Apr 2024 19:52:51 +0530
Message-ID: <20240412142317.5191-3-linux.amoon@gmail.com>
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

Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
isn't enabled.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: fix using new DEFINE_SIMPLE_DEV_PM_OPS PM macro hence
    change the $subject and the commit message

v2: add __maybe_unused to suspend/resume functions in case CONFIG_PM
    is disabled.
    dropped RUNTIME_PM_OPS
---
 drivers/usb/host/ehci-exynos.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index e2303757bc0f..f40bc2a7a124 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -237,7 +237,6 @@ static void exynos_ehci_remove(struct platform_device *pdev)
 	usb_put_hcd(hcd);
 }
 
-#ifdef CONFIG_PM
 static int exynos_ehci_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
@@ -280,15 +279,9 @@ static int exynos_ehci_resume(struct device *dev)
 	ehci_resume(hcd, false);
 	return 0;
 }
-#else
-#define exynos_ehci_suspend	NULL
-#define exynos_ehci_resume	NULL
-#endif
 
-static const struct dev_pm_ops exynos_ehci_pm_ops = {
-	.suspend	= exynos_ehci_suspend,
-	.resume		= exynos_ehci_resume,
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(exynos_ehci_pm_ops,
+				exynos_ehci_suspend, exynos_ehci_resume);
 
 #ifdef CONFIG_OF
 static const struct of_device_id exynos_ehci_match[] = {
@@ -304,7 +297,7 @@ static struct platform_driver exynos_ehci_driver = {
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


