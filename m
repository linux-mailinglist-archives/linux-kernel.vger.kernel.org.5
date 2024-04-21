Return-Path: <linux-kernel+bounces-152498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AAF8ABF5C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 15:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6791F21839
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2241175AE;
	Sun, 21 Apr 2024 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmy/BBsM"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7732B64E;
	Sun, 21 Apr 2024 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713707313; cv=none; b=R+PhRr+8HpCTjXzG9mKcGmLYs/4t9ZVwyU6DS69W+/ORXNvUNlD9x/j2LEkkLWnqn1Iz7AeLgKWFKtQnLON5SrF3xR4UxauXuuTUEcPQPdFAI33+0jCRbq2GftKxrGJuUlaln0KzEWTLeKI5Zf/XtSmEDcdgCJTG3lFGwuIaOFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713707313; c=relaxed/simple;
	bh=YRvqVcmwuUP8KQzGkDUkcd/uUAKw1WBPiXOoWNitfhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaJKB9Ljks2nv3RpZZijMDqadQ0DEimhMLeoHISulvCue/z2J74ciWXvT76wnmA4AuXkpntPxhFBgni9y8JQiOC1ig5PwtWg3mPisHBBnJ8mvA8Y29W3fyyCRqXejcZGZ4+YaF7HdrQ0XnijbB/Zb8c1RCK9vBeN4Lh6DS3Xbt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmy/BBsM; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dca1efad59so2597837a12.2;
        Sun, 21 Apr 2024 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713707311; x=1714312111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcTvBG8QtewVblIlyVX39beMUKrTk6jsd2Uev9rHf/0=;
        b=jmy/BBsMlv0WrcF86mtgKemjEWRhxnp+cw64YKc64bu6qf+3slm7zrM0U6x8yi72Kn
         xZv8rKlHI/txXODUIsidV4w1rhtT9T017f8rAh00TsiknJTWOezdfqaCPnDm3AnA/u9C
         30kzTdYapZoQEl/XRKkGtNMXUXJvC6OcLJlIbDOL6moUFBkhYhGiRrGWQOwE4o0iIlyh
         1j1BsHK61zFu7cQAEc84K0WwmIRRI39k+w4OJoYnF5JkQsTITj3O8xXZBjCzjPJio7TO
         DaO++i0A/PIn2xIXYRUbqJdqB+m8t2tsrXmgLb4b7zsy5t5P26dq/KMcgCnE26oOWi7t
         DsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713707311; x=1714312111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcTvBG8QtewVblIlyVX39beMUKrTk6jsd2Uev9rHf/0=;
        b=h9vfI8t2xZTVBul5sjVjqi4Z1h9LlU55pE3CyDVPQLNLoeXAmVkrZmIj1Ppb70Lc8/
         jbJvg10KvWMRxaPDYNZXqj2dnkIXdubmtEgtfpuV7apxDQ1V4v+syTxtzqUmCZlFTcnP
         g9AgnChjeKgIfa3k91Cfc0Nxlv+I01wrrTCWgSx7w559uVsrj4Jgtt6vmeWJpE3fJ1p3
         3F6KsjEryiCQLBlZcH225dJhKqmH+58g81bC+N0OY4lVDvzkP54RmTgwsfGj5Om+hXPz
         u0yhq7v943TOcTd6X40n31uYh5O100TnPucnZQ2bWJscN+PMBY75XzqnlkPibEJhB2pI
         ZlkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWN593lHdS6daJBe/ENA62uJ0uQ4AWGfWqcziT0DG1HmxjuYU4JU7lIJ3xhmL0yzejjKZ5iD/i+f7iHLenA8HrcBzbc6LhIaktiKWfWlF03ESe3MQWDmuxplNxThQJQynuNC97x8b0n+AHX8fC6Ww/pdpXtm88nV0KB1LFo/UIXst8ckQhQrWOQuA=
X-Gm-Message-State: AOJu0YysmJ52XycJbWDly64cDysEx5uLnR6kYSPXtuYE0OQBUCmP620m
	Pfrds+WhsjOjQO38DwhGI13DAMBJQP8Gytijdugu99c22XbjgyrB
X-Google-Smtp-Source: AGHT+IEyPxwqw/6TXGpzi8WH9F4lH1JxYg6WoBnEpf5NAK/vkuPgmJrfQekLV8WaNKlLanS22PkK4g==
X-Received: by 2002:a05:6a20:9191:b0:1a3:c3a9:53b7 with SMTP id v17-20020a056a20919100b001a3c3a953b7mr7874675pzd.55.1713707310911;
        Sun, 21 Apr 2024 06:48:30 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id o13-20020a056a001b4d00b006e6c733bde9sm6175043pfv.155.2024.04.21.06.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 06:48:30 -0700 (PDT)
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
Subject: [PATCH v4 1/5] usb: ehci-exynos: Use devm_clk_get_enabled() helpers
Date: Sun, 21 Apr 2024 19:17:30 +0530
Message-ID: <20240421134752.2652-2-linux.amoon@gmail.com>
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

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v4: Add Rb Alan Stern

v3: drop dev_err_probe to simplify the error handle.

v2: drop the clk_disable_unprepare in suspend/resume functions
        fix the usb_put_hcd return before the devm_clk_get_enabled
---
 drivers/usb/host/ehci-exynos.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index f644b131cc0b..e2303757bc0f 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -159,20 +159,16 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 
 	err = exynos_ehci_get_phy(&pdev->dev, exynos_ehci);
 	if (err)
-		goto fail_clk;
+		goto fail_io;
 
-	exynos_ehci->clk = devm_clk_get(&pdev->dev, "usbhost");
+	exynos_ehci->clk = devm_clk_get_enabled(&pdev->dev, "usbhost");
 
 	if (IS_ERR(exynos_ehci->clk)) {
 		dev_err(&pdev->dev, "Failed to get usbhost clock\n");
 		err = PTR_ERR(exynos_ehci->clk);
-		goto fail_clk;
+		goto fail_io;
 	}
 
-	err = clk_prepare_enable(exynos_ehci->clk);
-	if (err)
-		goto fail_clk;
-
 	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		err = PTR_ERR(hcd->regs);
@@ -223,8 +219,6 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 	exynos_ehci_phy_disable(&pdev->dev);
 	pdev->dev.of_node = exynos_ehci->of_node;
 fail_io:
-	clk_disable_unprepare(exynos_ehci->clk);
-fail_clk:
 	usb_put_hcd(hcd);
 	return err;
 }
@@ -240,8 +234,6 @@ static void exynos_ehci_remove(struct platform_device *pdev)
 
 	exynos_ehci_phy_disable(&pdev->dev);
 
-	clk_disable_unprepare(exynos_ehci->clk);
-
 	usb_put_hcd(hcd);
 }
 
-- 
2.44.0


