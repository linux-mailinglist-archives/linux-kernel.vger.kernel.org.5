Return-Path: <linux-kernel+bounces-40409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343B183DFB0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E213C2856C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB29E219F4;
	Fri, 26 Jan 2024 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgaahFHg"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F87D210F0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289360; cv=none; b=LBM54GZXw0cOgdXUEe/pMSTxCax2kHk/Ix08zrmFz8OkgPGpweVPonxv9B5Dni0FkodUt4Cc5cTB9GKbKyUSUNG9LKOX6uJE9Zy6G1okhiMckvQ5Wz14SO3wMPrdnpf1kbUPyTXQN8FhuWGb8fOxOQGuh8AqT2k9ACpwJpR7XX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289360; c=relaxed/simple;
	bh=nQYzWdDeWV5+4bKiItDoglDKTO/Dzi/wJFH7VQFwoK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbwmE8fDTGYNsRZGdQwHFzPA1FKwUebm1DappCpiP+chTgN85/YkWTMdAgEH9/Hp1qGqwwy0nClz80/LCmiI6vi69gFbqgtcHEvDkgFgnRWDYuucm6ngmQy6rd3ZhyhaxQsxJ0K62dHCTIf+9dG22CsEhaBBXz7W0L2kwsruNZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DgaahFHg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ed1e78835so10009675e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289356; x=1706894156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byLqjPGX2U9floq2ktVuyo0IP+fRFNCCMq67reNTymU=;
        b=DgaahFHgRvra9fyLK0Ew2hU8rTEaMInlX+oVxhcRAEQycERtoRyv3iXJJGobSm8A9y
         z2bZt7OaQ8+8V8t7JU0KG9mDr6a7wvpvV2c88KNmiazwA2uyq759Kgf06/jS7dbQfyw+
         b4jltwH1W9vtxO0iBdwoSy6DTrrbiZcvMIRPiZJfS/apItBmrWpYlYcDywFrtRYnBt9s
         lPUCvxpvSVtCBldaWr29Dz//4asb9PDuHT63JJMmsyzGZFTp4YYYYCfwVxbVmRlVCWuG
         YUNntKWAaBd0yAkhbeMYnggebBgn0nux3iie1Be5QmkIZpeMRFX5xqeiEvwmXLrgMI3P
         mK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289356; x=1706894156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byLqjPGX2U9floq2ktVuyo0IP+fRFNCCMq67reNTymU=;
        b=oCJocmDAwOOFUsaRHEqAjkTumkjQz08aq/PL1Kj3lIiWEFzozqUg+S1jvTNQYUInUi
         QYd2rvVw5kbpbojxNJ73k60KwHpMZxOR5u+D54aZ9QEqLM8Youlr2zt3x+zXya/vnXte
         /OMIiSdX9Zc27+kkaxyToJUaKkhChnd6fWGODZfjhxx3aNxkouqUEk3YNpwx1SaZe3A1
         ZELRUZvsaYa2BYj0W1xHpVRqKki5BmrACPvcAtScYuldtEu9wzgcYEmjF+dPwMOBwZ2f
         FGpd2hU/Qh/tew5xSE8Y0q5pu7fEwD5dUt8d1LNEpo8TigBanadB8dK7w0TDMts1MDPm
         xP1Q==
X-Gm-Message-State: AOJu0YxbgBpLVI8XNaRHH42/4PkVSQR4u5JUL7ZLNZWqNV3Uy6TcsU5N
	Hw+8orrvP38daWZhjnK7gGG8khI5ZFNa2OPYF60z21ZD/FCj/uiZ1j9n0lksSik=
X-Google-Smtp-Source: AGHT+IG83hVVkWCOFUgF0c27tv+I8VxsYGHb2dXyr0ioweVMaw0+DSQAY0Eif9VfosCOeNfsa8sQKQ==
X-Received: by 2002:a05:600c:4fc2:b0:40e:3edf:1053 with SMTP id o2-20020a05600c4fc200b0040e3edf1053mr94867wmq.17.1706289356632;
        Fri, 26 Jan 2024 09:15:56 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:15:55 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	jassi.brar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 07/17] spi: s3c64xx: remove else after return
Date: Fri, 26 Jan 2024 17:15:35 +0000
Message-ID: <20240126171546.1233172-8-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Else case is not needed after a return, remove it.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 9bf54c1044b3..bd2ac875af59 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -407,12 +407,10 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 
-	if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
+	if (sdd->rx_dma.ch && sdd->tx_dma.ch)
 		return xfer->len > FIFO_DEPTH(sdd);
-	} else {
-		return false;
-	}
 
+	return false;
 }
 
 static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
-- 
2.43.0.429.g432eaa2c6b-goog


