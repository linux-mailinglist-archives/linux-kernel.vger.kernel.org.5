Return-Path: <linux-kernel+bounces-106241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1E087EB48
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1028A28303C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE494EB51;
	Mon, 18 Mar 2024 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlF2qcva"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38F4F8BB;
	Mon, 18 Mar 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772996; cv=none; b=sSDW8GltS2zVZzi/cVdH9RAEeVv5VXCWe87qsMSTLXNk3kt6CWw20hSPq36L24AM8GWBHe05lhFSBm27u2Ci/0eSkv3U0+UufOt4jRaGOunXqpY5aMRwIqd+yI78KIPB4oZPAjI/wHCYORXdAK1h5XbabKeqQfvTZTSOLf2t9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772996; c=relaxed/simple;
	bh=U1GVmxI9hPSsLsozVSjn7Wl8In6bRVVosaDp+jSxwf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVrc0cM1OXlEYwkosOGXlMSAdUC8ADsd3S9azsvLzxRo+Z7s8gcReDwBuf/14g8mNTrVm3pIe+ERivdWOkI4CiUJu8JinKWN3sDtTczonU6EQedL7SEsVtcbXcBCwixVL5RwLjbg7iLakgZvUaipzqjd5636UmRo7a+6cDADwKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlF2qcva; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513e14b2bd9so2363703e87.2;
        Mon, 18 Mar 2024 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710772993; x=1711377793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEEUhaWTvii2Ap5iRpqK5SudmyXgOxssHMUe6EmUmmg=;
        b=GlF2qcvafUmAjyaCp15GjxfJ9z3NeGTmBNiO/cgLz6mPrthT+y+YCb3buVBemlXnEo
         iLnzt20CDh3xiRzT+y4fy59TsfGPzPmqwrNuuOC68M1dfVzDa371fBuN48BHrTaf4e/f
         2Csibw1RTZpR6wIg8YDb1x1OKThb+6gBSM2TIzgTQqLn/yKHS5/u376EecmoaDcsu6fT
         aXkYWHkNnrXPGR1waHZ9iPqztcFh1rOTb1lqGVjexWJk8c3RvJe1eUsh+YwRd0nGC/Uh
         eDggIt55snCjojwng47B0UeolwuAXgRip035QAjw2qc35foomBrfUfMLK+NY35WKpV9c
         1Oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710772993; x=1711377793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEEUhaWTvii2Ap5iRpqK5SudmyXgOxssHMUe6EmUmmg=;
        b=q8I0QVesedYgPocp/ErQAA4WRD/S/kW2JUgX4FQAkte9EBWK2FbnoOrppP8jw8FwIg
         HQzaks4dvwVoX51e9/a0DQvD+o0omlPpBTeHOGpFkHRGMKR5ocX1BnagHqxp+tEVbsbg
         1GnY+W/7bWdp4BZWT+AAL5WOhwvjUIuwtkpQF0f9PFVahJ2gEf+4tO/V8G7J7SxCCkHp
         Y2oEKLeqD3IWOhO6C45vu8568dsUT2YIOMDHB4j1ntxO857U2bYLknHo+Yyf/clmPhUy
         AAGMNOiKVlMXNq5FWpzXgwM61x7HdOmiqJHBz/U4brXX4JdPZsEodHwj4mDS4heqmXqY
         CcVg==
X-Forwarded-Encrypted: i=1; AJvYcCXVAoZ4kS++L2ImllPNxX14ZMWv/LCE8liXEZs1kGRCqoS7aliYNNZoyhUmecPCcRfJ15KVrbGBqLLWcFEirm/oG+1P70c+rPGnRfsQKoHdV18LykyRxDl3gmIVrDKfGdHVf0vYuvR/JAk1u+/tc/kCKn3jyQ7YX/przD/o5XIpn2HoErTv
X-Gm-Message-State: AOJu0YylloGkFqS7XI2Nr9VxMWzVYUoVR4rLSKcmCGGaeATJrOQPZeNn
	woVvnglDMqmJRin1zdV9PVU5LR3s8gFlYjLYqIsClQzbV6wa59mX
X-Google-Smtp-Source: AGHT+IFv+SCKzN9Rj/HyJ4Br477Enjb6XxPQQHNOF7pPE3XfI5kDtUXy0yMgwkODXdPiofPjLA2EsQ==
X-Received: by 2002:a2e:a592:0:b0:2d4:6bad:69cd with SMTP id m18-20020a2ea592000000b002d46bad69cdmr9148409ljp.22.1710772992851;
        Mon, 18 Mar 2024 07:43:12 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a2e9c49000000b002d476327311sm1527486ljj.18.2024.03.18.07.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 07:43:12 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/6] media: chips-media: wave5: support reset lines
Date: Mon, 18 Mar 2024 17:42:17 +0300
Message-ID: <20240318144225.30835-3-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318144225.30835-1-brnkv.i1@gmail.com>
References: <20240318144225.30835-1-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for optional reset lines. For now, simply deassert
resets on driver probe and assert them back on driver remove.

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 .../media/platform/chips-media/wave5/wave5-vpu.c    | 13 +++++++++++++
 .../media/platform/chips-media/wave5/wave5-vpuapi.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 1b3df5b04249..f3ecadefd37a 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
+#include <linux/reset.h>
 #include "wave5-vpu.h"
 #include "wave5-regdefine.h"
 #include "wave5-vpuconfig.h"
@@ -151,6 +152,17 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, dev);
 	dev->dev = &pdev->dev;
 
+	dev->resets = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
+	if (IS_ERR(dev->resets)) {
+		return dev_err_probe(&pdev->dev, PTR_ERR(dev->resets),
+				     "Failed to get reset control\n");
+	} else {
+		ret = reset_control_deassert(dev->resets);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to deassert resets\n");
+	}
+
 	ret = devm_clk_bulk_get_all(&pdev->dev, &dev->clks);
 
 	/* continue without clock, assume externally managed */
@@ -256,6 +268,7 @@ static void wave5_vpu_remove(struct platform_device *pdev)
 
 	mutex_destroy(&dev->dev_lock);
 	mutex_destroy(&dev->hw_lock);
+	reset_control_assert(dev->resets);
 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
 	wave5_vpu_enc_unregister_device(dev);
 	wave5_vpu_dec_unregister_device(dev);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index 352f6e904e50..fa62a85080b5 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -757,6 +757,7 @@ struct vpu_device {
 	struct ida inst_ida;
 	struct clk_bulk_data *clks;
 	int num_clks;
+	struct reset_control *resets;
 };
 
 struct vpu_instance;
-- 
2.44.0


