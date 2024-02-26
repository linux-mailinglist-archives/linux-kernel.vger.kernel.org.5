Return-Path: <linux-kernel+bounces-82143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E854E867FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2592D1C244E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078DB1292C9;
	Mon, 26 Feb 2024 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PozRxbyB"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35E91DFF7;
	Mon, 26 Feb 2024 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708972417; cv=none; b=SsLhDDtHGmvlaX22DCCZJJ3ERHg6truLa/W7OECi8HGpyk9DW/w/mm1HwvS51yBtAwkPFE4Yq+ynGIQE3Im2ds2HygAUYLjgbWd0ylaGSYNeLKQnuZKHp28HaNMMB69G+/OU4yls4vQ/S7f4A4xA1ACCbP17BVssS9taZDatsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708972417; c=relaxed/simple;
	bh=EWxoD9j6rTxWBOpnl2KFgmZwKCO3iFiFXK60kAnp+WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DU8kfcepavmpHoraROH8v0uugCJGrQ7vT/Nn7wlsWNvmuPQKGnPJV7DGuA0lfCL3Lxxx9UL5YgEC2ayrSQXf5N/16Awj4SGpvIMJZ1aAHvJSLNL++UDD2cpTNLQvYKlG6/IUdZfy6fg1CKSWreiYG2ytUvceF11huxes7m3Kxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PozRxbyB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc1e7c0e29so15199845ad.1;
        Mon, 26 Feb 2024 10:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708972415; x=1709577215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yRd6vmoyv4T18CdVodPMErjLFH3rEI8d97qlyMUvhQ=;
        b=PozRxbyBUGq48RU40EDTOm3dzx+6iE2IcDSxfiIL/Cp6DR3zuARPVNsA3uXvgwGEnZ
         p4r1EDkXfddAEduo6cYa4pwgSU5Gk6N4K06sr9n4g6wf4CGrS287Ekbdkwl5xVglFutr
         V1Fbc07ZkgvzF424+DWVZqB2+d5DCfSkhm0nbNX2Tyz0ZJqCF+FxzlvtfuQK7CjMo+7y
         WzypthMVMyUcYLGfLUYfuBdge8o1kiJyzBNpcKTsRSJJJrv7xy2cYaPrJrsuhrhzurkg
         9M+grH+L36ddOlkyIjpNQ4a9YNr9s3YI4HIJcQ1ZmilV4CehZ2GxAjtEuD+EercWWGHO
         H2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708972415; x=1709577215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yRd6vmoyv4T18CdVodPMErjLFH3rEI8d97qlyMUvhQ=;
        b=KNKFPSPTYddT6WTXdTtWynlciGGvO9n/VfScxOUbhQwneRT/TkabVVF+yoiuU4IrAx
         nvAq9mafvvuIj0TDL6yUhpKYa9XxEeZT1EqLXuubLDHrKJ1HHOosuMxEVOy1Vq4RdYsk
         mu66p4tfZAlRFQciYssjkAteQ7bpIOuvNhLOKFC5OsU/W2bY2nDhb9iHldflQf7+F2sk
         EhiauztTsiliwMJl3XVHAWBwXCKKfCuuxI2RuRAdxWbH0xzNcHEomcFjs0DQe87yvFMZ
         zs4Hdl+ksGTsFAPxiA5e9wVUXLAdqsWzPieT/Ybz2dNSAHhdJNOOZhC6p2RLm5OOLThw
         68FA==
X-Forwarded-Encrypted: i=1; AJvYcCXGSmXYR9GbqsJbfPOJisgui9112qlNawv71GeaH5+1SDELXkeWsvCIRikAISgLpeSd9RWdDlopoXEGeuvGi+j2sblndVxCBUCrOi73YSWg54wFl4oiH7GWiGfc+NXfOKSLZX6IFysNmx3m/dXaFVhjwkAcgItCplA8km+zqNaR5LZGOr3H+P1BjA==
X-Gm-Message-State: AOJu0Yw3qym5lszRZgFXG3K62ltXEV7RfOXfzt8zmOcUN+tbmkULLNtu
	bwGW2KFCCcy5MUTKPfJDEjgtoITuDqOjTBn3jAq8cPWDhBR+GwF2Eq4KQyiZ
X-Google-Smtp-Source: AGHT+IGZK+cA1x5WgBzoBVyRV+UXGp7W+13SR0ugBuvzIA2rJqCIvVty3bnIlwFL9SdiAjrYH94S1w==
X-Received: by 2002:a17:903:1d0:b0:1dc:7f98:d9bf with SMTP id e16-20020a17090301d000b001dc7f98d9bfmr8261579plh.59.1708972415188;
        Mon, 26 Feb 2024 10:33:35 -0800 (PST)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id jh2-20020a170903328200b001da15580ca8sm12302plb.52.2024.02.26.10.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 10:33:34 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv1 2/2] PM / devfreq: exynos: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date: Tue, 27 Feb 2024 00:02:57 +0530
Message-ID: <20240226183308.4730-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226183308.4730-1-linux.amoon@gmail.com>
References: <20240226183308.4730-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new PM macros for the suspend and resume functions to be
automatically dropped by the compiler when CONFIG_PM_SLEEP are disabled,
without having to use #ifdef guards. If CONFIG_PM_SLEEP unused,
they will simply be discarded by the compiler.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/devfreq/exynos-bus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 153340b6685f..63a3e0c0a682 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -454,7 +454,6 @@ static void exynos_bus_shutdown(struct platform_device *pdev)
 	devfreq_suspend_device(bus->devfreq);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int exynos_bus_resume(struct device *dev)
 {
 	struct exynos_bus *bus = dev_get_drvdata(dev);
@@ -482,7 +481,6 @@ static int exynos_bus_suspend(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops exynos_bus_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(exynos_bus_suspend, exynos_bus_resume)
@@ -499,7 +497,7 @@ static struct platform_driver exynos_bus_platdrv = {
 	.shutdown	= exynos_bus_shutdown,
 	.driver = {
 		.name	= "exynos-bus",
-		.pm	= &exynos_bus_pm,
+		.pm	= pm_sleep_ptr(&exynos_bus_pm),
 		.of_match_table = exynos_bus_of_match,
 	},
 };
-- 
2.43.0


