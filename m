Return-Path: <linux-kernel+bounces-122875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6666A88FEC3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976B81C26718
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D705C7F7CC;
	Thu, 28 Mar 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ag+mZcnQ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167F7F481
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627979; cv=none; b=tnYe47wgdITbbEBKnHtOWR917CrZE7EBl4LsCdEb+CxgTEd97QCPb2kDxostFbUcajBw4ip4nO8APOHR5jXXj3Y47rscO+BlY5dIr4l5lZ6KFHm4GYX2bZsM1VGHzy3Io6jGxt/WZPjX9rlszktKMEuxRk2+lJFTnU+0UbrrkFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627979; c=relaxed/simple;
	bh=jK+AFaPuB4QJkOlQSpapYzjziTfiCfCCfo7UWLC+ajY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kbpUunSu1Qk0KffwyDTsvEHOPvrEv5R3q/S5Qek6V1vv8+92fjFH+btAew6bbvmt00fMCCaSsbruwFcfk63/na7LkWIuY5LQ9dXfR4SLnIdpf2O7KLIMK7ny+PVASR5AhywwVEqqAONQ0gugImN231BEQ+ImHWlRUt1BJrUblfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ag+mZcnQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4154614b47eso2445875e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711627974; x=1712232774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF9nmGQgrbBBKoEODSqmsdf3m34vi7We9f5KYGrq5eQ=;
        b=Ag+mZcnQac2wITZSvoFkZTbi5Lz/Xwb/3KsLC3524wIGGF/zMhhcqAzZ45l28B+boC
         svC1XzXVC6nbOAvVY9NTNxUOIhJoWYjjjaIZu4EWdrtsVN6PAe+mmwDNMblFzeBkSHRH
         UernIO9ZKNpoUual0OUXsfduksryKjYQyqpJTPxMb0RhkJ/6ipaPIhlmTaR/HEBzwWPZ
         kJsw/7uNku5eoR/QYc0A+OU3icgi/24bnXLEbvXBliItcHIbeulKKwHtR4cH+NTJps/1
         0u27uKcZYMJqMvug5GDPVdrOQrt93oKazaKpFjcEES1q3aHY/a3rVJMGLGeTCjweNijU
         6WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711627974; x=1712232774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bF9nmGQgrbBBKoEODSqmsdf3m34vi7We9f5KYGrq5eQ=;
        b=u8YRF0Itud3wkgaWjqCrrruE6FVKububGsQ+DhXKwmFadbNn7QhgbAunuOjI9evWH1
         EUgXCMfM+ZDEQpOcKMRV2wM8KOaAItohDBDOVbDgv3k76xZoh25ypiMBP73gCGnlcTUe
         MFT97WHOvw37SNrBRx5FwQbK+auM07+nd3pjcuu0o4uMp+8fUJmmaAAM/Wv86o8/9hKm
         Gm0m1xGApxBixb5IST7Ll1fXdLd7sNlIOHtZO0sG0BxrUuG4bZMTAz9D0TpS05YFoMGJ
         avnCl6QPwkbezCoVRRwsvb+hbX2KOxdTlBu78ko1fOdYUFpwrKmmZs2JN5Ei7KdCn6Wa
         iqsw==
X-Forwarded-Encrypted: i=1; AJvYcCUUBg3PWAbbXeT4NpLwows+FCqvPl6hAOOb3S5XNBN81CJbGiDNatO1ZBuLVVE2HeHAsRob96nd/WYJUMhGdhtzhi27mmcR88+7e6cy
X-Gm-Message-State: AOJu0YxWi47jFpYs53gqM5M8/L+u/0ltk6Nr6n/QEQRmqYu4PPbW96kt
	+/6ooHBpW0fyME2dzisfKdgNrjqchhNeC441o76clUs5alZkMfbC
X-Google-Smtp-Source: AGHT+IF+IokEdEflEHk8FkCNBzqgYdy/CilxTJ3PWNYmSf1TJrLbjG9XI/v7yg25G0/pAzlMPoQCUQ==
X-Received: by 2002:a05:600c:4f89:b0:414:87f7:993 with SMTP id n9-20020a05600c4f8900b0041487f70993mr1727393wmq.18.1711627974155;
        Thu, 28 Mar 2024 05:12:54 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:125e:963c:4e4b:b7c5])
        by smtp.gmail.com with ESMTPSA id bd11-20020a05600c1f0b00b00415460a63ebsm1416456wmb.29.2024.03.28.05.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:12:53 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: pi433: Replace pi433_receive param void type to struct pi433_device.
Date: Thu, 28 Mar 2024 14:12:41 +0200
Message-Id: <20240328121244.1244719-4-ikobh7@gmail.com>
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

pi433_receive is only called once.
It immediately assigns the data param to a struct pi433_device.
Rename param name to pi433.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 7efe6b8501e3..208c0c6d3649 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -409,9 +409,8 @@ static int pi433_start_rx(struct pi433_device *pi433)
 
 /*-------------------------------------------------------------------------*/
 
-static int pi433_receive(void *data)
+static int pi433_receive(struct pi433_device *pi433)
 {
-	struct pi433_device *pi433 = data;
 	struct spi_device *spi = pi433->spi;
 	int bytes_to_read, bytes_total;
 	int retval;
-- 
2.34.1


