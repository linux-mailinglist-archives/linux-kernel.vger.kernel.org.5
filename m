Return-Path: <linux-kernel+bounces-82142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D19C867FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB12828F0EC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9C712BEAC;
	Mon, 26 Feb 2024 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXZZBGZb"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1DC1DFF7;
	Mon, 26 Feb 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708972410; cv=none; b=os6QPDuDeS9bVsaAeiO8/chc70DWDlrOUiXaKLArKbVHnTR8ziwUrnFlEU/MQFNY/jHQSqI7QVB1GvYoKb65IHyY1bRb44/Jv2BODFVNZeNi41wvClJk8MffwiJNojdZRfZNC4P/2bjjcyMg8F8avUbzxvF0K3ZGYlO1lxMbA80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708972410; c=relaxed/simple;
	bh=JsfCY4whwMXgC0aq3QAW8sFMe0CHckGaDhVinE9NJQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e8e3270Z9manL0o/gGEvxUXJ9wZGbZn8w/pk4ZpiBlE3fI24s9xjOm529z1yP0rFGK8bDeLRJofgxRjuCsfsxomXg0SUyTd/Yznca4AAkw1WwZqr0iRpClbisZcy2qT1cZkDTL39w11Z6T7g8rTMWEHGNp6TSDI3DHK4TymQXJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXZZBGZb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dcad814986so7170955ad.0;
        Mon, 26 Feb 2024 10:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708972408; x=1709577208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HAEObWk7q9tpmoQojnoq6Ltq98FhWaI3HcoghSaFe9w=;
        b=VXZZBGZbKmEz8gLNyVp/pv9oYURx/1YU7H+TT0N/9bcniFCN3V0kdpvw4D+2XhLEBp
         v9wqPmaSB+NuNJ12pNzcKoajKr56xakdG+oOxKKjcQrI9wmqXR1d7caRAUPEdGJLX4f5
         altbBZ6tzA5RMqjlQrT/F1/WvfAVp2noG/NeycrEvvDLbpWPCO346n7tUSi4AinnkBSI
         ah4kMuDB3i8sWG+26Gorzgf9KtzYq87Yew4KNaVQJ6EZeQg6cjGyiTr3NmWlGK9ephoi
         YXm9Jj6kShDjFbVE8yoT92tHixxZch0ip89N89RQZvdAinSZSm8Iopzg0CjvGv3okUSW
         madA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708972408; x=1709577208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAEObWk7q9tpmoQojnoq6Ltq98FhWaI3HcoghSaFe9w=;
        b=hC/YFOjvWnarupCqDS/TUrMpXP9f4wvQUo9ZNMyh3u1UmQPnZpLQBBo3zkRGM9zYIL
         Aub1m1D6y1fJxYERDGmQm9Iglavk3zs5jl0s/EbXkPvhA0ZsdrS8se6VPVq9BgV6gKP1
         bbiaCJP5zp1uDpA46NYA+YJYoaVJMoDo8Muc5bJSYqiJK7pAn5pLeQrr8mLNtnujQU3X
         mUemYLLesZB7wVASwj5G5aiQiyJYs1EK+fbq+BJabwHsGvATOyEUu7BGA1DrIfMqQfyT
         JCBY2eulXqV3M9ESTFSS40i2w1lo6ICD/LUPyg0xkWnmh8fNbvpvyR6XdZY0JwSHdeke
         RrVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEZd3D3K4fy1kJTCrq0hr5HnZ8l7sGYRt9uqLX1CyNdeIG/11loZUShoq9cUzPpke5GjZNkEekFP6tzwQTpJLATEzoWY8h00LeEnP+jSRkEAerDVEzHYlKDlFgpkHtbM0JQ2U3fI9pJOgzqmU22/2P/jXmiVdffK2JpZYQiihBoQkg47mWt80Oww==
X-Gm-Message-State: AOJu0Yyg0MsxRRlju87rwvoiec/VyRd0llyYPifjoSFUi8SgenfTf+NP
	uQPnH1cwaNKZ/5csib+YsghzpGwiN1zlx0tDIDpATEkN+RkaYLGFGZ/ZhWbG
X-Google-Smtp-Source: AGHT+IGz32s4Nqri0wpJmVkUdRWblviR+tS2ZYRNwFOfB42AasdShh+BjCineXQuWxw668weMUhVAQ==
X-Received: by 2002:a17:902:b7c4:b0:1dc:b01e:99d0 with SMTP id v4-20020a170902b7c400b001dcb01e99d0mr1494288plz.1.1708972407905;
        Mon, 26 Feb 2024 10:33:27 -0800 (PST)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id jh2-20020a170903328200b001da15580ca8sm12302plb.52.2024.02.26.10.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 10:33:27 -0800 (PST)
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
Subject: [PATCHv1 1/2] PM / devfreq: exynos: Use Use devm_clk_get_enabled() helpers
Date: Tue, 27 Feb 2024 00:02:56 +0530
Message-ID: <20240226183308.4730-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.43.0
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

While at it, use dev_err_probe consistently, and use its return value
to return the error code.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/devfreq/exynos-bus.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 245898f1a88e..153340b6685f 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -160,7 +160,6 @@ static void exynos_bus_exit(struct device *dev)
 	platform_device_unregister(bus->icc_pdev);
 
 	dev_pm_opp_of_remove_table(dev);
-	clk_disable_unprepare(bus->clk);
 	dev_pm_opp_put_regulators(bus->opp_token);
 }
 
@@ -171,7 +170,6 @@ static void exynos_bus_passive_exit(struct device *dev)
 	platform_device_unregister(bus->icc_pdev);
 
 	dev_pm_opp_of_remove_table(dev);
-	clk_disable_unprepare(bus->clk);
 }
 
 static int exynos_bus_parent_parse_of(struct device_node *np,
@@ -247,23 +245,15 @@ static int exynos_bus_parse_of(struct device_node *np,
 	int ret;
 
 	/* Get the clock to provide each bus with source clock */
-	bus->clk = devm_clk_get(dev, "bus");
-	if (IS_ERR(bus->clk)) {
-		dev_err(dev, "failed to get bus clock\n");
-		return PTR_ERR(bus->clk);
-	}
-
-	ret = clk_prepare_enable(bus->clk);
-	if (ret < 0) {
-		dev_err(dev, "failed to get enable clock\n");
-		return ret;
-	}
+	bus->clk = devm_clk_get_enabled(dev, "bus");
+	if (IS_ERR(bus->clk))
+		return dev_err_probe(dev, PTR_ERR(bus->clk), "failed to get bus clock\n");
 
 	/* Get the freq and voltage from OPP table to scale the bus freq */
 	ret = dev_pm_opp_of_add_table(dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to get OPP table\n");
-		goto err_clk;
+		return ret;
 	}
 
 	rate = clk_get_rate(bus->clk);
@@ -281,8 +271,6 @@ static int exynos_bus_parse_of(struct device_node *np,
 
 err_opp:
 	dev_pm_opp_of_remove_table(dev);
-err_clk:
-	clk_disable_unprepare(bus->clk);
 
 	return ret;
 }
@@ -453,7 +441,6 @@ static int exynos_bus_probe(struct platform_device *pdev)
 
 err:
 	dev_pm_opp_of_remove_table(dev);
-	clk_disable_unprepare(bus->clk);
 err_reg:
 	dev_pm_opp_put_regulators(bus->opp_token);
 
-- 
2.43.0


