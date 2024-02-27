Return-Path: <linux-kernel+bounces-83606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E18B8869CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9543FB30B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299AC2575A;
	Tue, 27 Feb 2024 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVlG+I1K"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C737F208BC;
	Tue, 27 Feb 2024 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051452; cv=none; b=OUtJIgWl48TduyxKMGrqeO8G1U7EMpKuq3Tby9GBM/lYoyjGL+7C4RIuerNFwDt8DKEO46l9NKMWD6mLztQq6BV6dOo/2lue4JjK5O4NpakbT1gWhbJR2F5qmUYA543vCeqh7DkH+XgBE4z2VxkK+Hf4beQpzGhhvEViRjrtT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051452; c=relaxed/simple;
	bh=GU1sdyhFBj9bzRppJ/hsZ88L7R9BMut3eh/ZoZbanbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/t8E2J67eKZSo+qMTZrsHHGFkWZ4G6zRAngUpZZKmex5+OjDX+us2XYkN/89BP20dOYdSHQTyC9NUQzNq0uECKWFaRXE06ot97IBY8fK3jTX/OztvJryZDDO7k3Aciuzbp1cuFhWQHYXr5wyxRC7C/o7csArMpri71TUAYUOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVlG+I1K; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d23114b19dso63389471fa.3;
        Tue, 27 Feb 2024 08:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709051449; x=1709656249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KocPvQVvLJA/0nwdtzHdh37+pJjC48KN8F7Qu3p5gNc=;
        b=WVlG+I1KsiNBx5GuqEmBqsymI1ZbwKNCliF3L7RRGkAKKBb113CeQ3ipJEfc5ukvSY
         56wF7eEl74tNMznOlc0uXy0F0Y3OJqfoQGxXJjEEt7pBLhE7RfcMz8OTI655G5HYM0cb
         RrjCj9jLt59W8ynpVhVv9OSrjUH5ZNuEnYyG40DRpA875ZFwARLXMj0rojPrxdCbMvzU
         3Cm9iNpB/Cj+InaK6p5LihWIh/hbGZ+pczfwh9jDReXoc4NMlKgwKDDIgTmyxQmyonyI
         1A6lFQhOksnAb0eLP5VNfc6YjxbN6swXfDhuNrZCIWDRSzVLWCOBkZT7UErmv65QXtWG
         dIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051449; x=1709656249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KocPvQVvLJA/0nwdtzHdh37+pJjC48KN8F7Qu3p5gNc=;
        b=ajLD+bcYl4/aru5s/qmLEZDY6out1hkfUVEzbdyjL9+VqqXeMKb7xPA4mhnkEgGty+
         6Qy9Kn5WCxAt//Xgv/Nm6rQivaQuxAwz825uWwSjqfF9NKROxTnTlqHS80KxMXNBazWg
         5jAdayaLuAUaFI5qY2Tk6VodHCcNb0nDIPCah29n7RTzOSU2tVIjRdmZ5XCt2rVLJNPD
         Dn6JqRycCTEON14hcyjNe4A2k7XyEVP79wxVTTBmjqkGvQ9STzRFC/ozIVYeOYpUj+MN
         lcM7OFNRZ82IaN7lEv8a2yFb9b7q1oHIf18i46ImY9EKLNXETzzV/hosTERWo0ThsIHM
         1KUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHC9Fa5OEECHHdGWRYLRM5VtpfjOY/OYmxaVlsI2mG3y0b8Jc2LPaZMurQCkqQ01Ef4xDjMu8TrzmhG8Zq0meP6TkiyYDLLD8e2nZBV9mDkaXgZP6wZRe7SZ/DqoKvdnHJkVElR8JLsT0=
X-Gm-Message-State: AOJu0YzQgRsvZaPUdmqxhZ5ZCKpJrzqeDM+fLhzNN5vDsnRi6BDYlU3+
	XG6KV7fCEp+PRdL0le2HO6uw7Nk/1n9IQXYMbXO4ao/LkXsDEjN2
X-Google-Smtp-Source: AGHT+IHrf1sdLM6TECOJlRau3i0lChAZb0RVnZRz/jtDDyGI7Xd8JHgNhqUOSO+rXm9/7XUKXUqWRQ==
X-Received: by 2002:a2e:b5b7:0:b0:2d2:2b77:43a8 with SMTP id f23-20020a2eb5b7000000b002d22b7743a8mr6212652ljn.14.1709051448752;
        Tue, 27 Feb 2024 08:30:48 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id n11-20020a2e904b000000b002d0b6eafa8csm1300712ljg.39.2024.02.27.08.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:30:48 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: hdegoede@redhat.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 2/3] staging: media: atomisp: Remove extra whitespace after opening parentheses
Date: Tue, 27 Feb 2024 17:30:42 +0100
Message-Id: <20240227163043.112162-2-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240227163043.112162-1-bergh.jonathan@gmail.com>
References: <20240227163043.112162-1-bergh.jonathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes the following changes:
 * Removes spurious whitespace after the opening parentheses as per code
   style guidelines

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
index 77809e88da83..cd00282b87b7 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
@@ -1357,7 +1357,7 @@ static int atomisp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 		pdev->d3cold_delay = 0;
 		break;
 	case ATOMISP_PCI_DEVICE_SOC_ANN:
-		isp->media_dev.hw_revision = (	 ATOMISP_HW_REVISION_ISP2401
+		isp->media_dev.hw_revision = (ATOMISP_HW_REVISION_ISP2401
 						 << ATOMISP_HW_REVISION_SHIFT);
 		isp->media_dev.hw_revision |= pdev->revision < 2 ?
 					      ATOMISP_HW_STEPPING_A0 : ATOMISP_HW_STEPPING_B0;
@@ -1365,7 +1365,7 @@ static int atomisp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 		isp->hpll_freq = HPLL_FREQ_1600MHZ;
 		break;
 	case ATOMISP_PCI_DEVICE_SOC_CHT:
-		isp->media_dev.hw_revision = (	 ATOMISP_HW_REVISION_ISP2401
+		isp->media_dev.hw_revision = (ATOMISP_HW_REVISION_ISP2401
 						 << ATOMISP_HW_REVISION_SHIFT);
 		isp->media_dev.hw_revision |= pdev->revision < 2 ?
 					      ATOMISP_HW_STEPPING_A0 : ATOMISP_HW_STEPPING_B0;
-- 
2.40.1


