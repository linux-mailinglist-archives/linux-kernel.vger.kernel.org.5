Return-Path: <linux-kernel+bounces-122877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1CD88FEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5901C25DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66C57EF1D;
	Thu, 28 Mar 2024 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ulp4A9wA"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1057EF0D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627982; cv=none; b=Kj2CyzaXWAQv4o6FwqryOYKE9yPJo+ILs0oMSlElNCyGQIaPCG9mFfOYqpCu9k3pV7JwogTjA39Ak8D8k/8IBVr1b8fYtXUtz9nZTICPK+nk85Qmw4B77i2HUPFuTAzUtDdmIwkkd9EcBTXA7W4UPv5AOcvLTLwLOUVfvDqcHz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627982; c=relaxed/simple;
	bh=rduB/RDRA5RPBB7h21AIh+xd67gq//w9BJQsmLy4FtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QpsmVEW1elFEzE+mB3PLG9/3zlAmGlJio4zVn8Ske0pPTBtCItWNwR9FXuIWvRWY3582/9WWhLVwk/qoSTGVvJ4nmV4ftxrUCicbrHmCSK1uHYsRveFJq4ETpvzm7eeKkwOD2mu0FjfxQbTJTxi6vStC0pTqV5gj8k68xslrBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ulp4A9wA; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so12379111fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711627978; x=1712232778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9w3iqi8v6g1Qg2xrkzZI49jeraryi4PMJn7xcz2yLU=;
        b=Ulp4A9wAMblKJ6vJ86JRNBeqEBQsq81jGhT2KPUoRPiVZsiuRyVoZI4zYKKFDV9+jW
         gcAD3itqNNNo2x2kxy5Y3lLGfMkWNreNGJAe1G3/Qh+qBxABl5DVVVF+4VbyQlR2R2Gw
         PfPvchBHW3a5ZfbhdVclJaXTUaF7YzcNxD1GHnIDqQmodCZL2d7L+nuyJmtbFGi9pZjl
         bCsweQkpnA3mzgwRmuxgu7pQHMfZFBCMVePhxGEzGgBCkLorAhQczCZ+Nmk0Pjeflyu9
         AOVkj73qFJLuCNfWQlhQVEeWLacjF0/Kowi7hklkCb2Ucn05TPjri3KBLeiJuoj0uHxY
         cWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711627978; x=1712232778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9w3iqi8v6g1Qg2xrkzZI49jeraryi4PMJn7xcz2yLU=;
        b=Ks0UdJv6gU/fxHIGg0w+FRWkgZMg7yUPuhGyGruGE3soojIU/xynnzqlmV584/hv3X
         M9NiMtHTJXUQypCRidIazuf/RSBtabOXTPmLgx8i344wEdBHwgu7Dq9px4ud4PeW7+tE
         wPWrei1eCqDnUpIKzXJJ9MmTwRy7sxim76lr8mO3Uf1A0sIz9p9Ft7sag5EwDXp+kD/S
         bqyqTTYYDzt48OgaUFdhtQIgeciUaIzzGuiva9DeCGtGLxWv6uFRDN16gUDqvQV3u1Ux
         9+l+e2Bi6JabMvZ9cnWRav5wc/vtMmNT/NXPmYjizx1K09YBy5UVFWi181DXhLWlz4mw
         mvQg==
X-Forwarded-Encrypted: i=1; AJvYcCUWGZVMbsvuvLptXaf3uC36dIY0Mi3ZOgliA4HvfN3T5JbcY21S7DyS2fMQ+G8qH9DC92TXuEsU94y0cumgy1Mom403BQ1m7WJr5UW8
X-Gm-Message-State: AOJu0YzmsxkeiGY8Ll5MwYG+++ti+DrmdsH15SGzNMkwCcp0dSZTNAnd
	AN3n7EWY9X+vCVwO75r93mqiuCVoDWHXvonTQCuCjmGxPiCxxP9B
X-Google-Smtp-Source: AGHT+IFXNzbhuclNbfEZdBE4eJZUSweezFj6xP8a2IZt/uTSmSn8t2yUDd3leLfO3tyGlIvwJiYWXg==
X-Received: by 2002:a2e:93c2:0:b0:2d6:dbf2:bb19 with SMTP id p2-20020a2e93c2000000b002d6dbf2bb19mr1503100ljh.50.1711627978242;
        Thu, 28 Mar 2024 05:12:58 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:125e:963c:4e4b:b7c5])
        by smtp.gmail.com with ESMTPSA id bd11-20020a05600c1f0b00b00415460a63ebsm1416456wmb.29.2024.03.28.05.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:12:57 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] staging: pi433: Remove duplicated code using the "goto" error recovery scheme.
Date: Thu, 28 Mar 2024 14:12:44 +0200
Message-Id: <20240328121244.1244719-7-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328121244.1244719-1-ikobh7@gmail.com>
References: <20240328121244.1244719-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pi433_init had "unregister_chrdev" called twice.
Remove it using goto statements.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 62ce75b07bf0..e538f1d4e787 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1400,24 +1400,25 @@ static int __init pi433_init(void)
 	 */
 	status = alloc_chrdev_region(&pi433_devt, 0, N_PI433_MINORS, "pi433");
 	if (status < 0)
-		return status;
+		goto fail;
 
 	status = class_register(&pi433_class);
-	if (status) {
-		unregister_chrdev(MAJOR(pi433_devt),
-				  pi433_spi_driver.driver.name);
-		return status;
-	}
+	if (status)
+		goto unreg_chrdev;
 
 	root_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
 	status = spi_register_driver(&pi433_spi_driver);
-	if (status < 0) {
-		class_unregister(&pi433_class);
-		unregister_chrdev(MAJOR(pi433_devt),
-				  pi433_spi_driver.driver.name);
-	}
+	if (status < 0)
+		goto unreg_class;
 
+	return 0;
+
+unreg_class:
+	class_unregister(&pi433_class);
+unreg_chrdev:
+	unregister_chrdev(MAJOR(pi433_devt), pi433_spi_driver.driver.name);
+fail:
 	return status;
 }
 
-- 
2.34.1


