Return-Path: <linux-kernel+bounces-161919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215CA8B5347
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45E61F210E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124FB182B3;
	Mon, 29 Apr 2024 08:38:45 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF317C61
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379924; cv=none; b=a2cIjm+nmmRGiVzS9nQAmWfstfZFzG8elk+t3ADd/59WV8l5wCTF8S9j0HEGe1NpyfjPF9bMJFAsMfEWJFfwVzEoQyc8m7t616a4ZzkKu0sYh9DJ0EysDRsF58lP8ucrM/Jvz2W9t2hVwC+GOejcJNqzfzls4M1JEoMHvXZJGKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379924; c=relaxed/simple;
	bh=2vPaJA4rHZOML3PO/tJHgdTtReelsANrxgtdza9H/I8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmATVb2jzJse0oWt6I5rQbrc2CI0L8NZ5yJCKoLtUA4bQzelrla1ZPPjt1o2PHWgkMOQ+oEuHABxFbOo5MOGTvJiC9TD1yrXq2Kdhzx0SzcLAZUajZ3b/e+zFnA87k9s3naIoEbc6cyMsP9pqncR45i3tR/FBojGfm2y9g5abRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b782405d5so30582605e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 01:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714379921; x=1714984721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMX/6sOdt78+FMtHj7imwsUo6HkpRvWGO6ALKIS0xJM=;
        b=Qctk9v4aM1CZV02pRBayHI+qRygDXbidf2nNUS/Uw9t1F3ViyJE597WDpEz2xfDAvL
         5g2lFEEsouYBcRzVolu3pHYyf4gylGCZhczwfMxKxRiJH74DKqNprTot7I7c6/8bCsl6
         K9H+AWZeRkoOzW6tw13LSZiHFWheNVEoiF2Y2OXL/BPPI9N4bpk5jrlR+x7VTZEbN9lP
         /YeYsKzYj9BehudbEHlpa3FQpqvW2U2H8YOw7FiXsV8SRRpIxVQg8bBJ0pm8J/7/lcJJ
         G4jZ9BllYvX9SESQX2m2NXIDIwMv2a/jp0GpTRx91wB4xbzOdFFJ5EHh9qO97hvNy5RU
         7cvQ==
X-Gm-Message-State: AOJu0YyX4Qw5L8kqn9edZciUs2iR6VlCKH6YClzO7BgF+Bq9ouIxBG2o
	rrus+SDoCh2yIdvzCSDdkv+MTs2OzCtpNIBUWAY0yy+pin1FAXeI
X-Google-Smtp-Source: AGHT+IECQ7O5N0KewAIDorw3WWDKeIAseYkBajsVtvxs5vvZoXNYPmk3UGKAKKCKyYnksLD2+O2CXg==
X-Received: by 2002:a05:600c:3504:b0:41a:47db:290c with SMTP id h4-20020a05600c350400b0041a47db290cmr9864955wmq.5.1714379921271;
        Mon, 29 Apr 2024 01:38:41 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f745a800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f745:a800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id u5-20020a05600c138500b0041c5151dc1csm2113152wmf.29.2024.04.29.01.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 01:38:38 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 1/1] mcb: lpc: Convert to platform remove callback returning void
Date: Mon, 29 Apr 2024 10:38:25 +0200
Message-Id: <cd04e21a7e2646bfe44b2304eea2b3fd0ee84018.1714379722.git.jth@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1714379722.git.jth@kernel.org>
References: <cover.1714379722.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 drivers/mcb/mcb-lpc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mcb/mcb-lpc.c b/drivers/mcb/mcb-lpc.c
index a851e0236464..2bec2086ee17 100644
--- a/drivers/mcb/mcb-lpc.c
+++ b/drivers/mcb/mcb-lpc.c
@@ -97,13 +97,11 @@ static int mcb_lpc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mcb_lpc_remove(struct platform_device *pdev)
+static void mcb_lpc_remove(struct platform_device *pdev)
 {
 	struct priv *priv = platform_get_drvdata(pdev);
 
 	mcb_release_bus(priv->bus);
-
-	return 0;
 }
 
 static struct platform_device *mcb_lpc_pdev;
@@ -140,7 +138,7 @@ static struct platform_driver mcb_lpc_driver = {
 		.name = "mcb-lpc",
 	},
 	.probe		= mcb_lpc_probe,
-	.remove		= mcb_lpc_remove,
+	.remove_new	= mcb_lpc_remove,
 };
 
 static const struct dmi_system_id mcb_lpc_dmi_table[] = {
-- 
2.35.3


