Return-Path: <linux-kernel+bounces-93846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32007873590
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D3D1F24A53
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E6A7F7CF;
	Wed,  6 Mar 2024 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNRSSwK3"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883547F481;
	Wed,  6 Mar 2024 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724393; cv=none; b=tT9J7wsyupa7HpVp/aKT2DhI2x/usCzHvGsfae2n3oCo/lwivvf2cm/WsTqBvETsFk6sP9TpqDWbsxFThyLXMpv6QCrwwGFZ5dtpDKgZE573Wq0nVCZiZ3P3lToRR+EPzZ140IBor0GKvl2Y1W8HNW2MfVbcRikeNMDwE8vzGcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724393; c=relaxed/simple;
	bh=gOliCHdIhgBV7q1NLhl7x0s+V5V9uDwRDxehcYX/cE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cO9yAxc0txkf94ldmnJVjSu6exDJsnTfJyIEAvWaEckCKgiY5YK//mP/gOFlmdKZRSaiDFyRxjlWRPXxAyRwuK/fbAD2Uh2faoTwHXRQqU+/lCuc8mV/bo27bWhqwJEvBLcm5DhI7oPQgnXTmpanE4J0TlVOWx+IyBvAg8c668o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNRSSwK3; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5135ab96dcbso863615e87.1;
        Wed, 06 Mar 2024 03:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709724390; x=1710329190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpGDKqk8r4MMhQWPAjkpllQftqadx7vE/B26eIDNkxw=;
        b=XNRSSwK3YGLc3E+nfwPoxXjCOEOwYoXxggLaq8y87w/WmcuIZCtSkSDs5Mhtmodx5T
         zcCBHSiBWCTbyr1fR/jQp1tWe9P7CvpS3Jbm2z3IJYWPrHj9i/N/LJ5kg+q41s3erm5J
         oYT471s5Rn6ul95mrK+1MR49zjXqIya63xLyDEjP1q/Ycs0qcr60jk1zOf6999YIyauM
         d+/QbcnxNM1chz+n9JgWvv0WblF6lEo3f8TIGrA2l92/8VIUNdXtuiNU+rKNFbY/bvRa
         xXLsOTXU68nmz0oyi3k260TS5Nl46Rrh5h7QuuyVwoM+jZpP8xvIYH3//1YMvylfBtZU
         RoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709724390; x=1710329190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpGDKqk8r4MMhQWPAjkpllQftqadx7vE/B26eIDNkxw=;
        b=hvIwQKADHeaR6h5adF8ovyWbQga5Ayc4Kw7q0Huw6O9fJBqIi1aKUwVaswG70JAeqj
         xmkaIyM6lSoYiKN7CojlXeyy4UAI8iUh0jTGLG62icbIuZ5Sa3ebwjQAfzxnjQP3E1Gw
         qEwVwJxrxRnjs1uz0c+OrXKEpVzjBFNOAmy40m1q4P/lpc+8dXUj2maXEcpWS/zSS54X
         mq4491gsKCAFw99cThQeFEJshqS24g7VgCqCyiKtNGcRwloRXvwQm8Nc+gk1HdX7+mCb
         8tcPalWO0DtnYa2yfA326IW3NkF7TmnAsxFI3OjrdU0JupXiaRxSpTPejs4sGwfA5fZ3
         36pw==
X-Forwarded-Encrypted: i=1; AJvYcCV2PcV5chqY1yaTxs8pnOrISTrmb9FMzxShw33nWndLNt6nTw0UujRginy9eNmX1BVezxrd6Qgdulg7uVjZCr5mFBlTgAFSPh/L0L/1caP/CUlitux/k4jL5+3YcAwm6oSLYSa+cDFP2Nol57E=
X-Gm-Message-State: AOJu0Yzkc8rJhcFBfC5056ZVPy7q9ToxcJAi04+mt0XJyNZmFqogAPao
	1pEbW1AZlcPaCW1iKxBwTScZFYYhfILbIl5tL/KErwsGswzOigDZ
X-Google-Smtp-Source: AGHT+IFLqQYS4L2t+Ktsd23D5IHht1KQAiUdDItEDyVlhuNVQapcO3cLMkivaXKBF1MIZP28km9tZA==
X-Received: by 2002:ac2:4836:0:b0:512:f4f6:9343 with SMTP id 22-20020ac24836000000b00512f4f69343mr1853154lft.26.1709724389385;
        Wed, 06 Mar 2024 03:26:29 -0800 (PST)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id b6-20020a056512070600b00513216fa562sm2576385lfs.202.2024.03.06.03.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 03:26:28 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: kvalo@kernel.org
Cc: deeb.rand@confident.ru,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	m@bues.ch,
	rand.sec96@gmail.com,
	voskresenski.stanislav@confident.ru
Subject: [PATCH v2] ssb: Fix potential NULL pointer dereference in ssb_device_uevent
Date: Wed,  6 Mar 2024 14:25:58 +0300
Message-Id: <20240306112558.163415-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170966495037.424347.1344425289163744212.kvalo@kernel.org>
References: <170966495037.424347.1344425289163744212.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kalle,

It seems there's been a mix-up in applying the patch. The previous patch
was intended for the linux-5.10.y branch, not the master branch. I
appreciate your attention to detail.

The following patch has been tailored for the master branch and should
resolve the issue properly. Thank you for your understanding.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/ssb/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index b9934b9c2d70..070a99a4180c 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -341,11 +341,13 @@ static int ssb_bus_match(struct device *dev, struct device_driver *drv)
 
 static int ssb_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	const struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
+	const struct ssb_device *ssb_dev;
 
 	if (!dev)
 		return -ENODEV;
 
+	ssb_dev = dev_to_ssb_dev(dev);
+
 	return add_uevent_var(env,
 			     "MODALIAS=ssb:v%04Xid%04Xrev%02X",
 			     ssb_dev->id.vendor, ssb_dev->id.coreid,
-- 
2.34.1


