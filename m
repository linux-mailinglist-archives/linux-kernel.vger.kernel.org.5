Return-Path: <linux-kernel+bounces-153219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 267DE8ACB06
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BE81C20BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD08F15219C;
	Mon, 22 Apr 2024 10:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9ZmdiB6"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F639146A67;
	Mon, 22 Apr 2024 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782349; cv=none; b=YT92U7cxl5IlrKZIYiPKhP8FXUDNdBnlfzen/OCswDHRTNM1Y0eMfceyMIbpNPhFo5qz15tW0fUv+zg1F3wkhccgNmYd0wkQ3khOLZ1KFGmJRRDeOToVSCypLH1tpqs85caupcO3A+GBSRL0TNB1ofegWNAqhbE+GmgqJoFqQgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782349; c=relaxed/simple;
	bh=HGvX8/yQx+s46W1sBOuUYo6ob3v9aa9d02JT3deFBfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FUAcK4WThZr4x+yGEw7LjP7gF3lqr3xqS30+lfMgIz7Y04NVe91OvhqvLwFdrnJdrmU9uQoAL94lIAtYDRuV8SvJVDpGSpbvJavKCprhZlgU3vlzrnNYOQ6yaciZbW0Yx9pgS4+PRHqMypO8B7VnawGrPQmeMZacMuCd9EvQKRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9ZmdiB6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso3983061b3a.0;
        Mon, 22 Apr 2024 03:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713782348; x=1714387148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfuwptov94CBDdHKLX3lshYY6MHoZbWBJU2S2yYTbo8=;
        b=G9ZmdiB65pQJhGcXB1NPCq/Gvsk+j16R4tRaOjjdmLMUN1cobA00H1hfKlqBnKTKtH
         wIM4jtmdiUtunej1uar+A9DLh8FBDxL5wgZEO7FT6FrprmAyqkaEqHgNfXrHCjL7ZJfV
         prkFoM7i4QrY7kq3DT0zgT+b7qejl5otcL32cCbIpumQNFJzMSN12Rzlm3xYXFOjNfBE
         rD1oE2uPMJyJ7bH8qDyV8PxM3bn0uqX+KUuhKcsykpqQWLn0v2MQvPobGZG4tC5bXzrl
         mOu26KcD5ystfqIQg6RW/Qdu95AY2mW3Yos686DM7x83uXp8i6J9YBFM5kcWtd6GVNlZ
         n9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782348; x=1714387148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfuwptov94CBDdHKLX3lshYY6MHoZbWBJU2S2yYTbo8=;
        b=m2na/MXVeEkcVr3jy4VIDVNLyqKuJQp8oklD5EZwojusmcoBzuckWtM7i5AjtnbQxI
         LvbV8WEhX2rDwsSdSOoLh4e9h+GjkGsW3yjqK6Su0ut+JJpsbkDK878o/9ePO/7cLW/9
         Q8FihlfCR2Q2YWeeyUJ4cbufkumJxv8Gq/WLh1g9l2UKLjm0yRjYEGL43tq8gO0RECMo
         jLbypVniR1Hbl7R4wPaUw9iOZE2z+qiNKShaE563ql/FBMqLTR6MD3Rkc/8iu3zjwu0D
         h9Ox/g8EYJZ12Cw+rh1LM5Tdtre50YVzaNyyNNTTu4kWPt7uZIBJt7Rb0uIqxJvZG+gV
         sgXw==
X-Forwarded-Encrypted: i=1; AJvYcCUTZ/o/+XN5wb71dj6OjnDxECI/wQPsvGYrWPzDuCFbgGQH4Wa4x0Nj8oCIGLfuIgFIHvPaSxoplRAWflQC3TiZgxoz+WrVcQhMSn4U
X-Gm-Message-State: AOJu0YwS+3Bo4W4nYv3ojfQyQVlSsUYbBY1L0WXgVSbLl9OT9DOf5cSc
	4JTFPE08VH6KNyxK6sg5Ffe30geRCMesEHnGUWfu3rKt2ot7nybF
X-Google-Smtp-Source: AGHT+IEsapGYKBx8vgfyS8NcV9lTVHbgqL+eZ2GrL+NSAyTq4tZ6P7rkIuwpe13YwomakerhV093+g==
X-Received: by 2002:a05:6a21:328f:b0:1a7:5100:7559 with SMTP id yt15-20020a056a21328f00b001a751007559mr14268060pzb.32.1713782347796;
        Mon, 22 Apr 2024 03:39:07 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e33b-6ac4-2bfb-4656-8624-cdbd.emome-ip6.hinet.net. [2001:b400:e33b:6ac4:2bfb:4656:8624:cdbd])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b001e3dff1e4d5sm7807904plh.135.2024.04.22.03.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:39:07 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V15 19/22] mmc: sdhci-uhs2: add pre-detect_init hook
Date: Mon, 22 Apr 2024 18:37:42 +0800
Message-Id: <20240422103745.14725-20-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240422103745.14725-1-victorshihgli@gmail.com>
References: <20240422103745.14725-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 310a8d18c2f4..3342aac164cb 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -417,6 +417,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
 	DBG("Begin do uhs2 detect init.\n");
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
 		return -EIO;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 91b52fca1002..2180cd21b5f3 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -724,6 +724,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1


