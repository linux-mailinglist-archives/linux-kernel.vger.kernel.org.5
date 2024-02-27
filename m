Return-Path: <linux-kernel+bounces-84101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A2586A258
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9215B2F346
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D4B1552F7;
	Tue, 27 Feb 2024 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyQuJgN5"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2615C151CD9
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071850; cv=none; b=jXJonvw50kh5oCYxe8S68wP/bvFCF7dYpN4CAebJ5+QXNOJY2NMBlm6iUslB+W9jtRKN+g7pkvBN9v9kJ/hq6NnrC8qOU4mlgOk47SaDmdkF7+zlihYysgObal0wuKK/oy004Om9fmzh2frPPq48Ex5QqfLnmbaUGNx/nK+6l2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071850; c=relaxed/simple;
	bh=+2njOV5Ga0IzlzN0XUiI1XPr4AZxQTAQfakyMWn49qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fjbth3iU1YPei6Z0ONVcobLhvZmtBC0TccLf/nmxjpRVjRKseMo/6YGFFSqW1EpNQ2u0XYd41mEEo2w+2IWTOL+719kdNXs4FTqqdbvvrhWiKtgF1gB1RUiCtgGSZPWICOPDEV9Z/QTTAMBMn5oedGAUB0OuAiF6uRoIwaHqR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyQuJgN5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d8739ddd4so3560570f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709071847; x=1709676647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ahqsv6gOyMACRg/0NA4F3TAuiEZ+oz6aihxiy2L38w=;
        b=TyQuJgN5QufjGQzZUqLNI3SlLOJtYEyGedM8nK0u8gP0YbRV2q9VlY7gnakAW3GvYP
         yrasffFGnX4Eh/IVp8DEpo/hKPPGNy1TiE36OcoGebysGL4XAcS/nxyyqUw4W4KHl10S
         2FHFLTO/F/H2gVzfrgVjtvo0OUaUCQjgE2Gdpib6ERUARvWt8EilrIM0G2ApzagTS3uL
         QfxgbvYtj57veQa1+CUPNo4RtEoov8wxlejdROJn+oE36kXQPPeB94WGhFfU39crhsBI
         eyI7DSy2NtsGUdNbbng2qi4C8WwuhyRY0sKuPHwGRUflnZN8XeY0HilR0yW6Y1S9IW9/
         46nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071847; x=1709676647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ahqsv6gOyMACRg/0NA4F3TAuiEZ+oz6aihxiy2L38w=;
        b=q8AM1J3zRG6moiXxSN1FfNIhj0er9wmqtk3sHT9LQTCF86j5YjHP5Zzk8UI5pcPTCL
         b+fJVWIgVCf+pQf3pnd6p/pna84NOWCWmKtdSY61uAxv8L1tDNV1/eCLTk5IdOC3Dw/h
         sWFkBF0vOckL3Rh77Se7j2I77nf2Wmoq0w4WsCoZLmbegu/OHFV6u5aPEirW/lSUdUa7
         bnEaFKY/QDFPfU2cQrvn3jvdl8TEvaJ6zxLrfaW7Hqs4NRceEqI/KpbMHYWsU6gNIjsp
         IAvT+zW4CP2ss6UDDOcdgzYDg8WmWGeo3axOB8fIXtRB3ffcUl8pA5B4NboqgnJml3Nf
         bi0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0iOkchW8E/bIqHjIxoWv4IMtEzBTFO2m98X04AzeqTJ1ZfoiH98gD0xWN6g+mbrB4SQ5juiOof+Xb05KWUxX3gaTVRbykdnalAnrl
X-Gm-Message-State: AOJu0YxOiWLEzLw7OsV4g5eedRqnvecXcNx2WUp/j0vabspibTiR1FKw
	xzG7ZPWRTppo9Q80RqTgHu9MlkeTd0gWTF853SFldmvVmM6YIL6e
X-Google-Smtp-Source: AGHT+IHewtvJpIknI3aiuB0KRWRWRBvA3NbH2g8mKCsD2iZN9UApBRtAZ+TWF1Klb32AkS5o3ST60A==
X-Received: by 2002:adf:eb92:0:b0:33d:be6f:7dcf with SMTP id t18-20020adfeb92000000b0033dbe6f7dcfmr8086572wrn.24.1709071847468;
        Tue, 27 Feb 2024 14:10:47 -0800 (PST)
Received: from YOGA.local ([2a06:c701:736b:f200:73a5:2235:8954:9b7c])
        by smtp.gmail.com with ESMTPSA id q2-20020adfab02000000b0033cf5094fcesm12562384wrc.36.2024.02.27.14.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:10:46 -0800 (PST)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com,
	benjamin.tissoires@redhat.com,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] staging: pi433: Remove a duplicated FIFO_SIZE define
Date: Wed, 28 Feb 2024 00:10:39 +0200
Message-Id: <20240227221043.532938-2-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227221043.532938-1-ikobh7@gmail.com>
References: <20240227221043.532938-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FIFO_SIZE is being used in both rf69.c & pi433_if.c source files.
It is also already defined in rf69.h header file.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/rf69.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 8c7fab6a46bb..b3b8d1abd3eb 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -13,7 +13,6 @@
 #include "rf69_registers.h"
 
 #define F_OSC	  32000000 /* in Hz */
-#define FIFO_SIZE 66	   /* in byte */
 
 /*-------------------------------------------------------------------------*/
 
-- 
2.34.1


