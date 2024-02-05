Return-Path: <linux-kernel+bounces-53991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB5184A8E9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DDD1C26210
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880605FBA8;
	Mon,  5 Feb 2024 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6oZdz4E"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9085FBA1;
	Mon,  5 Feb 2024 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170384; cv=none; b=AfZ+oLAiIkHofCqT+4j1GdP/oGYGc6z2uYnWaSisrMGtp5Nof2ixX+ztfj/VoUhlRBdKBG7nOIK48deBWAuxmVRaddjLBRKubwumSaTGapmMLE457FC1pxc81oddsBJ4UrA5JN2m4khGTUjd4qThV1trq2zHoiPIJuqy0Cp/FjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170384; c=relaxed/simple;
	bh=+AS06WoujOeqXU4Hb3VAVxvfM0mY/e5EGItG8aTCTas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bAWqpSWxG+D3P7CT5klEUkQwVahJMJs5cTvGL2DF3KmkTab3Qr//GNB6qhxJa37f97YSdYJ/ebbZsgfz7Tlxh7ibtD4L4mJuJs6gQaniprBSrriAVc4yb+rzq0vSqcvQZM6Fj6dDvZWA9qKRyzYUS9PnX5xIyqKT2lafZvDZpB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6oZdz4E; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ef64d8955so1636225e9.3;
        Mon, 05 Feb 2024 13:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707170381; x=1707775181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7v36dUm/qfcDe5R6rUIhuYhf7AEbt4izd4LOEjbQQ90=;
        b=k6oZdz4E9JTHmNdNPxQEnydRA8yk2EdaQoVMHXZJIWmN4i6PcMRbCt4pS3ZCFOQOgB
         hNW5/McwMcDU5cvQvKRQQgnKNhOWQvfy5s056kqMH9zIF7v0ZpcOBvJIYDX4X7L79HPp
         egH9VCky3Akw3uF+i1DKQwJoN37OX65lP46sSn3hWk4GVjDdonDhdmXbAUjiAMxoz7a3
         nB2+CVOdTNh34A7Km1bbHMUXN1SPe9WqNhTvTQvXpfFbHFLp/6FiaaQKkktGs3TbnvLK
         5NbwBou5iVyXQNcSDS3wSergTCPMQXMNXapTwNpi/RSD2ZuBVBq3AX4piYVxfyy6ySn0
         UHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707170381; x=1707775181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7v36dUm/qfcDe5R6rUIhuYhf7AEbt4izd4LOEjbQQ90=;
        b=K0tAepwf/2ngvojze8VKpdA4GCbGcM9Oaw6b5HLgp42M2pFlkamPtVTHvm81lMwH/J
         VAFTozWL7S0g1KnrH4sIEjwkkxqQSoV4EnUoblUV87/u90kuv1r2pKYzgnxP+sjZP/c7
         NdX0T93rD94fvWt5a3rWw5vtlYCPKnmaazgpsp7YTs0HdV9EofMshyGnw2Isrgf6oF+S
         8m3ry+iiXyVSDlXDGUz+68KBZiEyAS+4WmUKmxsge6U6Ov3NlVkBVO58YJkQ38Dw9ckT
         JBYj9J/smI+VSE92cMmbsH1UoH1Wm6QvTGMpMBuXy7NNZ1at5q/tXADYHngALvXjKfK5
         YPfQ==
X-Gm-Message-State: AOJu0Yxh1U1lpUcBwDbxWCSaRfy2a8Oxk4a6ZaiKUGTZ5ham/jCXfTp1
	oWmh7u8N3ZqsWTlBx3iTM8tYhQoH+sxtQ2p8/uLaRH1jhJ9GxZaCVrghe93Uw9k=
X-Google-Smtp-Source: AGHT+IGZlV9OF1/ilTswL166CszINvzdpP3TzLASP+eTjpBTHUwh9tFjMQkxoBOYPGk1AgPzN0Ozrw==
X-Received: by 2002:a05:600c:3581:b0:40f:de6a:2a27 with SMTP id p1-20020a05600c358100b0040fde6a2a27mr698032wmq.40.1707170381323;
        Mon, 05 Feb 2024 13:59:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWy8BJdViKpI9NE7N7rSvNeqaStkN8WderlhTgTe1CsuSJAIo2mgM+X54TowxaYb98i8WkoeTAORncoqvB1y1CumSKzB3asdXxSs54qYlU0r7nTAJMO21Xcw54dBOi7bTBMCskqBfoiLL1jwA4h14LRjudSQtPg/6IiTKDd456Y1Jk=
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id fb4-20020a05600c520400b0040fdb17e66csm1081486wmb.4.2024.02.05.13.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:59:40 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] input: ti_am335x_tsc: remove redundant assignment to variable config
Date: Mon,  5 Feb 2024 21:59:40 +0000
Message-Id: <20240205215940.1851349-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable config is being initialized with a value that is never
read, it is being re-assigned in the next statement. The initialization
is redundant and can be removed.

Cleans up clang scan build warning:
drivers/input/touchscreen/ti_am335x_tsc.c:160:2: warning: Value stored
to 'config' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/input/touchscreen/ti_am335x_tsc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 34324f8512ac..294b7ceded27 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -157,7 +157,6 @@ static void titsc_step_config(struct titsc *ts_dev)
 			     n++ == 0 ? STEPCONFIG_OPENDLY : 0);
 	}
 
-	config = 0;
 	config = STEPCONFIG_MODE_HWSYNC |
 			STEPCONFIG_AVG_16 | ts_dev->bit_yn |
 			STEPCONFIG_INM_ADCREFM;
-- 
2.39.2


