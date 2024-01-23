Return-Path: <linux-kernel+bounces-35959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D890839929
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B421F24763
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84231272B0;
	Tue, 23 Jan 2024 19:04:14 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04186ACD;
	Tue, 23 Jan 2024 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036654; cv=none; b=XMD6KXHSoN+P9VIVEbLeICzIEuLZ3TcSHg0KWrTDqhnPbbBiZfSsNozACXqvE8kcBbGBo0XdlbpH55OR4ZESDjUQP/ZRa9BBnzNMfRkxFL8r3dlmVsIizVr6vJV3TFmarlb9XAJENROg/ZoYnxnD4R480EOIWnjAJEb5afmM2N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036654; c=relaxed/simple;
	bh=mUSXXGPgY8FzkMOOClPqzHH3thRlJ2ker48ophTtyRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NBC0v9KhOtXoavP/RxnB9I/N0MMZkfBQZlc68mU/snoyH8b/6ZEP6ob+9777hdpb7f4ZkdHeQbYwm/Dpc4o7yFKLP+UVbxNankvvoXe22+fqUOzWZIWM7+O6nAGksFTQFuGxIDKGa3G+P7cKwlRQyUQzP1MSfh3LnyKd3J9TjdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50eac018059so6509178e87.0;
        Tue, 23 Jan 2024 11:04:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036651; x=1706641451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXBd7/4njBbq+wgt8CKjNpRhE1ABIHxgKJAmYauI2kE=;
        b=exzP8yhYJPRTTsHBXfkC/VirJtL1BD+Aou0TRDLUNbLLbNgElgZEygsHNaYCyntw2G
         nRyqUBePgdNbaTzVEXcCvRB2NgvOwawOn9BK8go1AjYlX9vi2YMZjUyeyOyihsZnOZfH
         5leuls8n25KUNuROcLrIn8j3sPFVCtPxec43IK++XHMMCkSiiK7J0XCDyVxGYeTtnvH0
         5XWTA5WCs9hD77gPj/gnGBKTeAVZyjvju0fcFRyq5weG4UyRG6DTZl9XEfOoB9ZgKwqT
         +AA450dzFuU8Kx9xKA/r3jqbl/dH1bX6JAR+7wpvh5tguJI4objcOKAJI89tscqtZ+zz
         6hrA==
X-Gm-Message-State: AOJu0YzG/cI9fecQnc1squoOPzJ++Oo5XgNRYV0lMZrwq84glAa0be+r
	HcQ3bewyaRMMuHeYhVQvWk0dSQbg26UUyAoW+hggcQmsWCdm4SYW
X-Google-Smtp-Source: AGHT+IGxUghnYQqlL6hAa+8/jaDKpK88rUh3GIDCuwb/mr9Op4l7J/WZFE4rMenqrwx6nVC/Ksf2/Q==
X-Received: by 2002:a05:6512:6d4:b0:50e:b3ed:f508 with SMTP id u20-20020a05651206d400b0050eb3edf508mr3750894lff.80.1706036650910;
        Tue, 23 Jan 2024 11:04:10 -0800 (PST)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id d18-20020a1709067f1200b00a30e9a2c592sm369087ejr.63.2024.01.23.11.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:04:10 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Hartley Sweeten <hsweeten@visionengravers.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 04/10] net: fill in MODULE_DESCRIPTION()s for ep93xxx_eth
Date: Tue, 23 Jan 2024 11:03:25 -0800
Message-Id: <20240123190332.677489-5-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240123190332.677489-1-leitao@debian.org>
References: <20240123190332.677489-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Cirrus EP93xx ethernet driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/cirrus/ep93xx_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
index 1c2a540db13d..1f495cfd7959 100644
--- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
+++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
@@ -868,5 +868,6 @@ static struct platform_driver ep93xx_eth_driver = {
 
 module_platform_driver(ep93xx_eth_driver);
 
+MODULE_DESCRIPTION("Cirrus EP93xx Ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:ep93xx-eth");
-- 
2.39.3


