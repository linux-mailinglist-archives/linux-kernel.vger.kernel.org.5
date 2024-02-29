Return-Path: <linux-kernel+bounces-86447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14CE86C582
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9125CB26ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437BF60876;
	Thu, 29 Feb 2024 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXaizONx"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09B860864;
	Thu, 29 Feb 2024 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199507; cv=none; b=Ux24+e9yUt8rOX2o0mQSY/zKwhNczbXtirKZaqLEDUq8moeH4RfOO65E4WxQYyasQOsm6g+r+l+jOzuYpFNiHQwHi3iEPU8/5Pfg+5hGxPEaZHNgnzq05f2vRWMWHn6tRDM+6to5P47S/9JWoPHYeBFggon04W9h506OlWlZ0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199507; c=relaxed/simple;
	bh=geByKowRyOVCMK36p263NAG5QqZ0xPskpiZgukdnWdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sZSxI203t+SUUAS4Wop9RHiCilljG/WumaCbN3UICK/Yc0MlStX0S5myEgwqCLZLpC+WpUNpcPJSwvcwCPTHoRS1snxkbk0EZhRMkOsGJKY4irsQVOBtyi99b841UHCqtm28OqsEXII38yluezM7KTW1NCR2mW0M/pVEHiTEXHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXaizONx; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513235b5975so825265e87.2;
        Thu, 29 Feb 2024 01:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709199503; x=1709804303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+z65Ols8Ev/rVV6Hj6ehUx1Ocn6O7rfEJ/QlCaZe84=;
        b=GXaizONxcH6OS6+KBSNHeaTIqkshx5JSb84/5NfWOkMgH0pWifr4YhRzZ2njrOMhI7
         WWR+9vFvezUwdxHY/7HJJl3SlvbMLx2pFg5pEU9KtW0Lnzohc1pNadrQ7D15DSa2M410
         QFDuHIN87jHAQKvu+JHF+hWxIifI1rKxp8xxg55kAFNUr8l1j1qdTKlcF46YjNiBFRO1
         7dF0hKEPFNMCnAAEOiFq8cg8BPhEhbocTaqOVKUXfgPl289uht8l8TFYRxoqKrKWkElo
         FA6AOV9mMqIUkiVhGNy1/idgZlx6i1uewFyiusR4a+pnN65kDyAXWQho0CqFG9SUO3Kw
         Lq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199503; x=1709804303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+z65Ols8Ev/rVV6Hj6ehUx1Ocn6O7rfEJ/QlCaZe84=;
        b=pjqPwmxSGFlPTgIiw6wqVAfy/K3FrB3aA6Pu3nDlrHKbXKG+BXtb3HNTcjno8Z6tIU
         4JaVnt0KcLd2kj7GOrCvjzuIZjlKR0GHG/vWN8jErHKRGxrclg1VQYXVFieDMWzbImen
         R6Cs9WNeQxIs3E/lyGKUsjHa0jMaUyVyJvHPvpvU57i+6RWU/vmjNiC08Bqolyxuyijo
         99hx2I6B5r26/ZlIjGH4LS9krTyF9fiUFQdS2Knxrr669jSobMNq7YKgcNAdZbXNGOJM
         oXXSXyReHshQ53XDQ5tJ3nYzgUi4RHk5GrywvTus57F/+d8XUjgUIAjZKVvxXU21ENL6
         vHTA==
X-Forwarded-Encrypted: i=1; AJvYcCWoFarDMTGjlpNo+ZAILnlYJOEhS9UizxgSMSMew9D8tjTZacrPPuCmhB8usXYnOHEWWIHhZiOoV7G2w9BP/fwnS4B5Qr46yzkoveq9NvujeUNEAXrXG7vvlOpauk/IRftNKfr6Grv8iBAEszI=
X-Gm-Message-State: AOJu0YwuTUC3v1G0PJ8b1Xbz9WsCZndraE13fIzeb8vyyBEPZxAGBhUO
	PeQrF1G7M2gSDzQtdZY9B75zn9W27ZvzbjDUoOnTpy2YjFM8wCIYIUyAaLbr+h/gww==
X-Google-Smtp-Source: AGHT+IH04wVFxQ+/BAeopM/1ea/U9uubsTCuaOszB/Zgk36ckE2szxzw+HRMAdcNMTvSgVECqmccsw==
X-Received: by 2002:ac2:52aa:0:b0:513:23da:9766 with SMTP id r10-20020ac252aa000000b0051323da9766mr971087lfm.55.1709199502806;
        Thu, 29 Feb 2024 01:38:22 -0800 (PST)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id dw27-20020a0565122c9b00b0051304114e7asm189189lfb.6.2024.02.29.01.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:38:22 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: Michael Buesch <m@bues.ch>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	voskresenski.stanislav@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH] ssb: Fix potential NULL pointer dereference in ssb_device_uevent
Date: Thu, 29 Feb 2024 12:37:56 +0300
Message-Id: <20240229093756.129324-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ssb_device_uevent function first attempts to convert the 'dev' pointer
to 'struct ssb_device *'. However, it mistakenly dereferences 'dev' before
performing the NULL check, potentially leading to a NULL pointer
dereference if 'dev' is NULL.

To fix this issue, this patch moves the NULL check before dereferencing the
'dev' pointer, ensuring that the pointer is valid before attempting to use
it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/ssb/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index 9e54bc7eec66..74f549557a01 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -340,11 +340,13 @@ static int ssb_bus_match(struct device *dev, struct device_driver *drv)
 
 static int ssb_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
-	struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
+	struct ssb_device *ssb_dev;
 
 	if (!dev)
 		return -ENODEV;
 
+	ssb_dev = dev_to_ssb_dev(dev);
+
 	return add_uevent_var(env,
 			     "MODALIAS=ssb:v%04Xid%04Xrev%02X",
 			     ssb_dev->id.vendor, ssb_dev->id.coreid,
-- 
2.34.1


