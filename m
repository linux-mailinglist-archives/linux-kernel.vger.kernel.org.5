Return-Path: <linux-kernel+bounces-92267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE22871DB1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DD41F28E8C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2875BAF2;
	Tue,  5 Mar 2024 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="W6yejpJM"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB83C5C8EB;
	Tue,  5 Mar 2024 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637948; cv=none; b=ovO4QbMLYMamO0vIzdumczBurgNYrjAnciquTsUky7dvs87GGZM9W3GfWRLfAvLyM/VIGqhhGPNQ4ftdit54DrZOqGj/QWJWNn1SwDLyYzR8b/SnbtHteSepCGPYmx84ughclPSQQUlKcjqa47BRxxBhH/z7GpF4cpD96hFpXHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637948; c=relaxed/simple;
	bh=8qQ0SeNJhXlABLurzglboJwjavq1YAoQO65VHoOV/Gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C3XxMJucbXUnEBRODNEHt9mSdzoiGn08lokoz7l6WNrwUZwOLfyk7IhUqyyZ46mYAUiByZXBFTo+4vhoBKxWhx7fgNeEdjQb8HSX0LK+TSvDiceKQP55/bcAfKk06BmDNAbrEA/NUWh8/410/QF3gNdPPvepQY821FQh0LpyjoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=W6yejpJM; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso3947357a12.3;
        Tue, 05 Mar 2024 03:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709637946; x=1710242746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEbIJfXwtU/2x/nSMLjhop89lagE2IVT+gG/0cVmfiI=;
        b=q7SfLX99/7RzHkMdPYiw6BnYAH+Nfc/r2ZeK3Y7HrXoSP2dMV5CgQxJZqYh0JMncou
         R4YBtibA8QYfcLqHvfam+lJ8nP7GtESRSghIqIwI+qjfdvL2R4rAF206iMSxlaZuR2+C
         jb94QTbX/mhBsNJfqSjARK5SYfv6sJcSFRlGiuS78QDeAQ0qAb79WnHAEKsH7vmKIfRD
         wpqEv09wmuW/RiJV+ZzU8uWinRtRxjYRKLYSl4dm+TYiuqSKQJ6pWsqVVCKHf6UepODk
         hT4sTl8v40SHxeTFeCPJOTVanEdppt5SMI+wqpDnfET4WunwmU8vpeFzHKugm8ii0LeY
         Ck6A==
X-Forwarded-Encrypted: i=1; AJvYcCVWmqhAvFTzlkbYDsLPSScHMIZAXOLl6J+NXmN10lfNOMLbzHdm7rTv9laA72X0w4YE2SDv4AwfhKDPN3NIv5jJY7flaf0AeIQj0Gtp
X-Gm-Message-State: AOJu0YxmT8TDbemSL7jThqkSgSTZ7u+Wm1rPQfb5ihZv651dLgpigiVp
	q/5PTkuSIIXCfz7NDd6B/Y2jT/zprQTypjgqNkt31paVMElAIZmYHSVqnrPoKRHqRQ==
X-Google-Smtp-Source: AGHT+IH7Kbem7StIsdbFa6w191ZdCQkGrB2O3Z1xiGxhezXqMz24LE3U+JQU0MAihxPMQVhX7qRAqw==
X-Received: by 2002:a05:6a20:8c1d:b0:1a1:4de9:f2db with SMTP id j29-20020a056a208c1d00b001a14de9f2dbmr999195pzh.58.1709637946073;
        Tue, 05 Mar 2024 03:25:46 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id cp6-20020a170902e78600b001dd1d7bc0f7sm3075933plb.154.2024.03.05.03.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:25:45 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709637944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EEbIJfXwtU/2x/nSMLjhop89lagE2IVT+gG/0cVmfiI=;
	b=W6yejpJMra0JsezaYgBcENuFaZecTOZu+ks3h6FcXg8dJvpwm6peXURJ8YAat+N9fPTahx
	6n7JMuTRzqrQ9e1RO8YTKCvzfHy+NkRWwQyEaxc4bTjwaJTo+mKeaHXp+K9L+9qhW77DFh
	TW6UlodstNf84GuLOKI/0r9cJkq9qYBN3To2uOwkgc85GMq+OXq83VDWJ81kCkuR7nkToG
	ZGSpi8CbbBFdKQ/9G1tP8zSlQtCEfkVeZdT8Fydwpysu21/Z2T1sKQXNZtHsCIlnxpOWgL
	R+i0W/uHj62wwRXy6MjV5Wh8ZKBCjPQfVL9lUjtSQL1HTJMJnJt+oXmKbd+THg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 08:25:23 -0300
Subject: [PATCH 5/6] s390: raw3270: improve raw3270_init() readability
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-s390-v1-5-c4ff1ec49ffd@marliere.net>
References: <20240305-class_cleanup-s390-v1-0-c4ff1ec49ffd@marliere.net>
In-Reply-To: <20240305-class_cleanup-s390-v1-0-c4ff1ec49ffd@marliere.net>
To: Harald Freudenberger <freude@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=8qQ0SeNJhXlABLurzglboJwjavq1YAoQO65VHoOV/Gg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5wEh2NOz7pWOq7WbNJsrESRcWBsMLx16YgEnm
 H+lz/QHfyaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecBIQAKCRDJC4p8Y4ZY
 pukHD/4h9dGin5s00Y2J8kR47uWNw/EvFTQc5yykanYBdx8WGAQMPDyu/baEFb7UAw7+jXalU1p
 tTkoakyCGBkXs0UZ/87R7GDkf2aJ+Ba5BStZiR1E/b92MX/FtUMi5rcTYMcxfgTKH7Z46DBPDvE
 MpK2NaJCvoIbXDiE4g0ibFjcqbhmciDp2OCYqx1E/VzdYbfcAEbw2ceAMSbZsm2kgD2sDGjvLLt
 4Px33O2VL/kiuYCZIAGzTZEafgpAqFoApFoIFmwNdiLrkMF0t5OlPAm3VDO5yEss3CQwaMkvU0r
 USnkmCoqNRNk5CmL0qaf8NjrQ7KFfh/e5d/jMA6RZD/BCFL32Ur0lpoGHMPLvhXgv54Y25iKB3N
 kfCDE3BR+5i/GRINscLG2xcXVnTgK2Jhk51/aUieYglNQCA1uHGWxo/VGCCD+mYR6aQYEd+KBnP
 Rs1ZGWRQz/7edpgDvWOVW44MXHBY8vRgyaxZTj5z26LIidQjAf6IUfsShWitLQ0v+6UJbw/W/1R
 CQbeMLur4xjZsZ+XDyeHAKkNMaFdnKZz2ShdhfKGQgn/oME3nIMz+K/LPBnub0DTJZsUVJt5CZh
 kCxL5ezQvwAoF7MVQIdQctEcBtr3olT6gSHLPzhLLqki3Y4TvJt3H4xJRrJZiYPE3TknxxOO3jn
 kpNpScjFCETJr3w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Instead of checking if rc is 0, check whether it is non-zero and return
early if so. The call to class_create() can fail, so add a check to it and
move it out of the mutex region.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/s390/char/raw3270.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 7115c0f85650..acc4cb37a9d8 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -1316,17 +1316,22 @@ static int raw3270_init(void)
 		return 0;
 	raw3270_registered = 1;
 	rc = ccw_driver_register(&raw3270_ccw_driver);
-	if (rc == 0) {
-		/* Create attributes for early (= console) device. */
-		mutex_lock(&raw3270_mutex);
-		class3270 = class_create("3270");
-		list_for_each_entry(rp, &raw3270_devices, list) {
-			get_device(&rp->cdev->dev);
-			raw3270_create_attributes(rp);
-		}
-		mutex_unlock(&raw3270_mutex);
+	if (rc)
+		return rc;
+
+	class3270 = class_create("3270");
+	if (IS_ERR(class3270))
+		return PTR_ERR(class3270);
+
+	/* Create attributes for early (= console) device. */
+	mutex_lock(&raw3270_mutex);
+	list_for_each_entry(rp, &raw3270_devices, list) {
+		get_device(&rp->cdev->dev);
+		raw3270_create_attributes(rp);
 	}
-	return rc;
+	mutex_unlock(&raw3270_mutex);
+
+	return 0;
 }
 
 static void raw3270_exit(void)

-- 
2.43.0


