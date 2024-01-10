Return-Path: <linux-kernel+bounces-21871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E39F5829592
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C4A283880
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103473A8F4;
	Wed, 10 Jan 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXbENs5B"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF873B18A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336c9acec03so3598908f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704877275; x=1705482075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sRArHkRqDcxNs+rnRnHFE+VoKiAC9DnbvICFMUk3Z2M=;
        b=DXbENs5BFN72Wqk30EE7wA8mRoVm1ae9pro+Etdlz3kLUXCSrPxaMvMOTkZC3X/WIi
         MlT3fDVg5NeebSi/ERMM86RClEUjmhzEFx0ZonICrETJrTWRFo44q/pKyvBs3fKwmPdw
         aqVd4PVnowF3P0zkQhVWnhJvvQvstXsCVs6Y12//9Nm95leycYfBNrZAFn3DK8YVXAFr
         O4sRenq1zbpYCM7JTgtVVbu8pmtA/s97uTNHHfpXKdBg1ODOuUf+BKwCB89mYDSpDMDX
         XytJ6How76QJABIwdvkV6yHi23hOJUcHnRNKgkEUUe5hgsR4kcDyGColFx8EuXy5kOLo
         sOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704877275; x=1705482075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRArHkRqDcxNs+rnRnHFE+VoKiAC9DnbvICFMUk3Z2M=;
        b=C/BXbKUenKTNl9q8Kdfcc5RRCywNFny8iTsqci/CpcDtv+dbI+tUqrqmDP7hVi/FhN
         GQF2N1+rEA/7uj68mZAXuwPXl3I84tC6jW0ha/59DPxowaCT0efjmECBfvIJEM0jQmFR
         Yd9L1GIGgB4bbeXx0c9DaXGfOKm1ki8FiFgJcB4c+ToASARUBQXZbMZl7K4H+mh2JYBV
         Mh/cDzznpCc5hjRWghFxjRVwBIdaO4/q/tujjWMYJRjAdrWO9pipIM8RHTkSX7O58PMt
         jwrghepDr2xUlaZnQK0/D2Zm06JEP6F0y+fAKe26LTrlvm22hx0k25yLzs6knuXA4pTy
         1sZQ==
X-Gm-Message-State: AOJu0YwhYKG4wdkWNVlJGH6CHPuwoBjVTpXGFulINNyb3tiXCAosnTXp
	zjnEBo3T0T0Hrj/lEN7ZSxq/f6aIRAY=
X-Google-Smtp-Source: AGHT+IFhI1QbnljNAJQKeqKLpITxAghwB7HYxYq8Sy7FJYkGMYEi2GM9/WUDUrqUHiMgyYz/d+eq+g==
X-Received: by 2002:adf:e508:0:b0:336:616f:c1ea with SMTP id j8-20020adfe508000000b00336616fc1eamr337105wrm.90.1704877274667;
        Wed, 10 Jan 2024 01:01:14 -0800 (PST)
Received: from localhost.localdomain ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id c2-20020a056000104200b0033642a9a1eesm4348171wrx.21.2024.01.10.01.01.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jan 2024 01:01:14 -0800 (PST)
From: Levi Yun <ppbuk5246@gmail.com>
To: james.morse@arm.com,
	pierre.gondois@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH] firmware/arm_sdei: Fix invalid argument to unregister private events.
Date: Wed, 10 Jan 2024 09:01:07 +0000
Message-ID: <20240110090107.26323-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To unregister private events in device freeze, it should call
cpuhp_remove_state with sdei_hp_state not sdei_entry_point.
otherwise, it seems to fail on cpuhp_cb_check.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 drivers/firmware/arm_sdei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 285fe7ad490d..3e8051fe8296 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -763,7 +763,7 @@ static int sdei_device_freeze(struct device *dev)
 	int err;
 
 	/* unregister private events */
-	cpuhp_remove_state(sdei_entry_point);
+	cpuhp_remove_state(sdei_hp_state);
 
 	err = sdei_unregister_shared();
 	if (err)
-- 
2.41.0


