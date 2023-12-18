Return-Path: <linux-kernel+bounces-3879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAFA81749A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0B62854C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EDF42398;
	Mon, 18 Dec 2023 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmRprAEn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730EC3D579
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c2bb872e2so36677795e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702911759; x=1703516559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSPmstIzw2V0xdaeu3UEvx0O97+IGAfial7Fk0oauN4=;
        b=jmRprAEnIzZ1lfm3mzVNU8fr2ItU28yKLMDyGpFqueV3eu7A5XC0lKbIEFgXTXmnW9
         R8z39BD8GmBhdL3nGKQ4gDgsT9IM/MrKnOSDQGG4LReoV/0rnEp3aBx3CxoHP3N0Xmyr
         c5WlTNO33Ctsjea8t/f5DMqzHnEE6hESPEbIC4AZeK5QCdX2L0cUVSdj4KkdDV/RG16x
         m8K3TK+naIwxTBk3ON9fNBqGRPvqezJbkidqBKFpvmN6WYnsbaZavmNEt10gW7iybOeu
         c0OX5ougQu50yz6l+OhGWWQhisuzam9cdnyxhluFZS3J1OTTEgAir7WzTrvO84jOpEoK
         jMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702911759; x=1703516559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSPmstIzw2V0xdaeu3UEvx0O97+IGAfial7Fk0oauN4=;
        b=gKPlzCjiZgRbYCZtmrXGyaNPjbwtw2EETS66YicDNx1qdxUMMhlPvg55etMUPOdgGx
         EvMuRW6ukotL2crtVbgOccfTmNbXcwKqt1KQh8nZsVidUGEZwCHhf0BAFqSFK+Gt78b/
         6/E1RvwT1IB1bDpXOgAMpBHZPbIdA8razoiuYDrnaQeg2Zi6FA0lIhkAUq6EH5PQTlEu
         0ATvHv+VPgAOvHs6KKukdaY+zgmDhCKyTWt4LMiipWbKpSoa3Upm528OkZzWhFNxcChg
         qinLKgmTxwUliy5nPIxNIKSPzAFY+SJYD2DLEX81kwUbBQmT7in//Wvs505jOCb+y8Tz
         LCOA==
X-Gm-Message-State: AOJu0YwBnU8U/73bYf21CQ3UeTC4a5Kmfu8b942z27qRB5J7XdthSAjA
	cn/xZiKzfcvW7k5ISBuz3Qk=
X-Google-Smtp-Source: AGHT+IGXxSUtvYbNnBnFFcaXLM9umBTEYXvSB0O9Kf2YTnQppX1mwL/dYFwMMXHhWFNIfBijr0S4hw==
X-Received: by 2002:a05:600c:3657:b0:40c:35b3:b797 with SMTP id y23-20020a05600c365700b0040c35b3b797mr4222408wmq.35.1702911759414;
        Mon, 18 Dec 2023 07:02:39 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id v18-20020a05600c445200b0040a3f9862e3sm3741814wmn.1.2023.12.18.07.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:02:39 -0800 (PST)
From: marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To: krzysztof.kozlowski@linaro.org
Cc: gregkh@linuxfoundation.org,
	marc.ferland@sonatest.com,
	jeff.dagenais@gmail.com,
	rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] w1: ds2433: remove unused definitions
Date: Mon, 18 Dec 2023 10:02:27 -0500
Message-Id: <20231218150230.1992448-3-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218150230.1992448-1-marc.ferland@sonatest.com>
References: <20231218150230.1992448-1-marc.ferland@sonatest.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Ferland <marc.ferland@sonatest.com>

Both W1_F23_TIME and W1_PAGE_COUNT are unused, get rid of them.

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
---
 drivers/w1/slaves/w1_ds2433.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 9f21fd98f799..cd99eceac1ae 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -25,13 +25,10 @@
 #define W1_EEPROM_DS2433	0x23
 
 #define W1_EEPROM_SIZE		512
-#define W1_PAGE_COUNT		16
 #define W1_PAGE_SIZE		32
 #define W1_PAGE_BITS		5
 #define W1_PAGE_MASK		0x1F
 
-#define W1_F23_TIME		300
-
 #define W1_F23_READ_EEPROM	0xF0
 #define W1_F23_WRITE_SCRATCH	0x0F
 #define W1_F23_READ_SCRATCH	0xAA
-- 
2.34.1


