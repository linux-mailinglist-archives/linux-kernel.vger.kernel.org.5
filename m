Return-Path: <linux-kernel+bounces-89874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5FA86F6C5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8685B281E39
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC7B7B3F4;
	Sun,  3 Mar 2024 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nmq9tsWK"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE979DCD;
	Sun,  3 Mar 2024 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709493665; cv=none; b=GNF2O0ah0SAvG67frVYFzf9TMGtyaOVOe1y20OZSsHZFoNVACNKWtmFvnEa4SkbUMfSgOKeqRBMaNCvtwy/nDAVP9+Ef1aG9vBbmFhqONM0rjM8RLVt9uZ+889gcfP/GF8HtUzPgciVVAQJs+e6giAkt8LEYk+Pn3zvIr0jniw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709493665; c=relaxed/simple;
	bh=B7ddWFTd53goqpQQb2J/wqa+ZBWBK1KkrYMV21UOh/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RIsQjP8oKN/0e/3PDkTN1aAzLoTtAefIies361F5BklQTBYZ/ONTHYcoPPN16w+oyawJ2XDADA3fPrD7YHwJNUXSeg8WufUQ3ZVTX8SlMe1/oXcT6HyCR3yO83eFbFAOEnn1ogxPEkAuJ5xliEWbT1E0ZDpaULdK7QhgKKFOC2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nmq9tsWK; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d2305589a2so55277061fa.1;
        Sun, 03 Mar 2024 11:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709493662; x=1710098462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBTeI5LwyRNmwz0HTOBaEkUs0RB1H06fQtRx1M+6JPA=;
        b=Nmq9tsWKD9PfeAqK54Nz7SI8DULnhbIXgfisMk+v1ynBHN+b1OJmKghSUYa+1TyoAz
         BnwoLRRt+WIoHmI4HUg8+tZKxfAtGwXlxvwNB1TAz+wOb19PfvdvZ9mkZC5dr1CbRgi1
         Er452y9zYSuXP/Kpc2HT0VohHqZRgm7QgkR4Yx3aRZWjKrn312mbJ1+IGwnCpZhu+MTu
         /Yg8Xo5C2KGbCiXftNK3nrHRYvrwVCOlpXCtzfjAcJwzkwvL1H2hTcLC2ltyoTXzgmrz
         NmOdSXy69hrPsUe9EOwF/aFqzFbEER/Gdtzuu3+OeZT0V8WTgmSCl5XWg6IHSxG186rc
         L7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709493662; x=1710098462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBTeI5LwyRNmwz0HTOBaEkUs0RB1H06fQtRx1M+6JPA=;
        b=eXHXqp2i6BAqYSdQPFKPjXlR/E68GsifulEk/KrahY1ZFlVFfX/UsWM5aeMUTlSOv9
         VCXqbqCs8a8V4fo13MbZqvNLxts35wiHYgoBKQMMUWpZxyKftUz3MbORa5NOw1RoeJts
         DknP0teyQxMhZZN8z0jMHLUqpMwEHLbEHJ/nv9PQBVFtnDfiK6+Us4wX74oceAyFgArS
         /7/cJHUEa5D3j+85JwvwBc31vUz2trFZg8ku+tP2W4P6xuRH5Mbf6oJch5Bfpn2iKoSr
         n0icnp+DQB6aFGnswnXMQKFndB3isORPJI1lZFK4dk6aKlDAEbS6lFMaEUFEzLkO+VgJ
         78jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPxDbAw16kBPoCKhm9sB14ZAp+EbzT1Bd5B7S/Xqw1XED9aJUV25jFpDGXNh+jg91OB38UCRE8ULlxqASnRl3Ie3f1D9ekystm7suupXYA4Ou1ecyitkoLfICZ9JJXdNeKb+tqmK3g8Ko=
X-Gm-Message-State: AOJu0YykUailKVstQCWke2Uw2WZ7KcYqvzYAR9cQtd4lc+0/w74m3ftu
	ccFeW9xoC76qdSP5g4UKRLmUlJqXWObfus3AIwpQXv6OncKbuzBh
X-Google-Smtp-Source: AGHT+IEtASUJLCUkIEQR8OZE+pwKH8QFdqX2jr5mv9lbn5Jg9d0L9aVjqOsTz2uyTv0fWEP2ZqgJLQ==
X-Received: by 2002:a2e:92d0:0:b0:2d3:93dd:c54b with SMTP id k16-20020a2e92d0000000b002d393ddc54bmr1556767ljh.25.1709493661940;
        Sun, 03 Mar 2024 11:21:01 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id y10-20020a2e9d4a000000b002d3c466adc7sm68438ljj.15.2024.03.03.11.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 11:21:01 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: mchehab@kernel.org
Cc: mcgrof@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 5/9] staging: media: av7110: Fix block comments to meet code style guidelines
Date: Sun,  3 Mar 2024 20:20:36 +0100
Message-Id: <20240303192040.8116-6-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240303192040.8116-1-bergh.jonathan@gmail.com>
References: <20240303192040.8116-1-bergh.jonathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch does the following things:
 * Ensure * for block comments are aligned

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/av7110/sp8870.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/media/av7110/sp8870.c b/drivers/staging/media/av7110/sp8870.c
index 5857fc8b0962..65795c5a01f9 100644
--- a/drivers/staging/media/av7110/sp8870.c
+++ b/drivers/staging/media/av7110/sp8870.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
-    Driver for Spase SP8870 demodulator
-
-    Copyright (C) 1999 Juergen Peitz
-
-
-*/
+ *  Driver for Spase SP8870 demodulator
+ *
+ *  Copyright (C) 1999 Juergen Peitz
+ *
+ *
+ */
 /*
  * This driver needs external firmware. Please use the command
  * "<kerneldir>/scripts/get_dvb_firmware alps_tdlb7" to
@@ -456,11 +456,11 @@ static int sp8870_set_frontend(struct dvb_frontend *fe)
 	struct sp8870_state *state = fe->demodulator_priv;
 
 	/*
-	    The firmware of the sp8870 sometimes locks up after setting frontend parameters.
-	    We try to detect this by checking the data valid signal.
-	    If it is not set after MAXCHECKS we try to recover the lockup by setting
-	    the frontend parameters again.
-	*/
+	 *  The firmware of the sp8870 sometimes locks up after setting frontend parameters.
+	 *  We try to detect this by checking the data valid signal.
+	 *  If it is not set after MAXCHECKS we try to recover the lockup by setting
+	 *  the frontend parameters again.
+	 */
 
 	int err = 0;
 	int valid = 0;
-- 
2.40.1


