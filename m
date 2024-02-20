Return-Path: <linux-kernel+bounces-72508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C5B85B471
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86E8B20C90
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08CA5C5F2;
	Tue, 20 Feb 2024 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kgg0FGuZ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632FE5A4FE;
	Tue, 20 Feb 2024 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416383; cv=none; b=TtyRSsZtMXpFQPZrgTbVbLNVnowkECJd92DnjlkYGG3GQorSLD4+765SBByFLdNEwZ0S5ZoIB733SaPzfaxSAYq5kzvKnLPxE3EQFrh31/pReL+7STlr3qsxTijF8ei4P3fuCpyn5Ne2FlHTcMiyGRBFQeUw9aZgGk8I9KZ/WNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416383; c=relaxed/simple;
	bh=2AajWmjvWkFwXUAy7YnyQC6wKfOpBqV3ZyOyOZCf5vM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QVJlfdhYZkrbEy/r3oK9+ZGGGYCW2/Y+JQ17gXNiK/FFKHKn3gIRsGkpO/9pJm2E85dmXZ3BRpzONi/JSdV6mqFyH4fuiyMVFJUYnBLzgd1BjlqQRiSFv4b5WhL27cgyqT4xJ6P4SMwsYWL6AS+6h8z9UacfhjZkgQs0kNd9d7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kgg0FGuZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4126f4863f9so1940395e9.0;
        Tue, 20 Feb 2024 00:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708416380; x=1709021180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LLrWaeUumJ6pHnaaEwb9+G7skI59DBlkbGeW+yJ43lU=;
        b=Kgg0FGuZpN+IMDO3uKj67qJaVRj+mMlQ/BJFXfNgVqoohi2+36nFAUWB0ucbmNvwSr
         zc6cn/zlX66uQ3HDVbT0jo527h5sSCCxlEq8G2gMkKneRMgPdDkwIgjUOfZtAwvuSiMA
         MMhLZwnUeARlNPuadmIhCeS7MPTcSTBElhe20zcfSBDxIFQfDcKzNHiJNZ6uGM3yBTvv
         sYEEVkurRnJLN+lJDwhxys93iAJkWNWOSYjXi9vNQywhZAOI2Th1eJhIG0KqdWrmSD4A
         UVuQTF/5ao2IWJiCDLh6lLmy6eo+RoP9fPOx+CoOf5bqHsJAzLkBuTybuO7HWwNGv9VV
         F2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708416380; x=1709021180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLrWaeUumJ6pHnaaEwb9+G7skI59DBlkbGeW+yJ43lU=;
        b=qzHuOGQrftOeX6A0hWhcwsPdr6b177rYU6j4q8+hzoB7SwblYE+HX2K782mHokbfPr
         Qgiw+wudChG6ZO5n3Mqi5xI1QKG6EaI8yVOitnJbm1sKzpi85HLCvmlrWbIRQHDxffDT
         R8fA+Owa+5r1ujirvau+8kqmFF5xljnCu8LjcrCvdf8AVS9CsvIdTmvKUHoSw3GiNf4F
         7lycWusRxNWqOUwRsVIwdSoIMDRsF9V9DF0nB0JNm3Ox0PvQ24aZJeCDNiq3r4zJoW0A
         eCozQrFp80v+mww0bGOrl0pZKSwmRIvsNJ+rp/4oaAub8x55Hoa1EObHukRNmqOma+XE
         CcVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKO3GEhZeH2ZqZl+LQ3Gr6FZldah9aDvfgEZUFmg0f1MUyG4lMMmbFcV1oXnxX0n/fxERcXMQ7Avpodykvvoy+OtFUKgAWmNQKFEycTxgZH8OBoRNcwwyCcmHuUuHSjhG+59sKXgP1
X-Gm-Message-State: AOJu0YyKC3oMLnyjH9xe++71YaC6Og1VYCKJ0dhSAtreeHJB0NwL3Zr6
	qvmJbERBFvZy4I3hvO/2z0JB4LuLG/hAIl6eEqZxWRuobmCLvWZH
X-Google-Smtp-Source: AGHT+IF8OGMQFT7NrO47/sHeKkCDlVa+uW0HmkYWTVHWnO47HZT87n/5/gS8K/R4ws2AXKWPCeKP6A==
X-Received: by 2002:a5d:6643:0:b0:33d:26dd:8c4f with SMTP id f3-20020a5d6643000000b0033d26dd8c4fmr5602887wrw.23.1708416379405;
        Tue, 20 Feb 2024 00:06:19 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bu7-20020a056000078700b0033d5aee2ff1sm4053257wrb.97.2024.02.20.00.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 00:06:18 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: cdns3: Fix spelling mistake "supporte" -> "supported"
Date: Tue, 20 Feb 2024 08:06:17 +0000
Message-Id: <20240220080617.2674613-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/cdns3/drd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index ee917f1b091c..8b936a2e93a0 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -435,7 +435,7 @@ int cdns_drd_init(struct cdns *cdns)
 			writel(1, &cdns->otg_v1_regs->simulate);
 			cdns->version  = CDNS3_CONTROLLER_V1;
 		} else {
-			dev_err(cdns->dev, "not supporte DID=0x%08x\n", state);
+			dev_err(cdns->dev, "not supported DID=0x%08x\n", state);
 			return -EINVAL;
 		}
 
-- 
2.39.2


