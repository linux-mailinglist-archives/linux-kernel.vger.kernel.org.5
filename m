Return-Path: <linux-kernel+bounces-31043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF51F8327FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C18284325
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BD34F88C;
	Fri, 19 Jan 2024 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JkDcVPQU"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AE14F1E8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661145; cv=none; b=o/p9639j0W/REHz97dnjqTysrJhZgtN/l8akNdeK9UA4ibXcIXoDiipd7vZ6ROYgAApWQNB1P3KgndTYpKnXc9BGp48AtcIOpIQMzw1IknR9VCd7zQhyuoWJUQF2i8QZ+7NVZ1T+iPWThpGvU4bdg4DjnSL2um4uPGrqWelKRps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661145; c=relaxed/simple;
	bh=yyPxa+2O3PUiMwwg0ga5y4EkBLkh+hUE/RHLPR2apyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Od9WueWNkXLzSMmEwYDGx96p1w5e0VV3KumcxeTrHF9oBJ5RtPHFsfsIyL6e5Q44XzLE49uRjjOc6OhHMHoY0uiHqVMuJVP3bZw/vOHtPJgSzKxnZZfJuXU/8NkcKzm8aF/vrzhyjnRQiI6g1H9juy7N/ftPL2nQXNVE4myQ/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JkDcVPQU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso7733295e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661141; x=1706265941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKtqqOLjqJGdMtonI4P5mEMTKVliGwJ+zwCnWH5C8bk=;
        b=JkDcVPQUrStKHVzWG+vOilni6QBhiBU2uCIY8gzHTHgveta/kDtaGwKlMF4M2sO5PM
         ovB+p//Zu0E8y7pylMIxXIiPmor+3VYg0US9fv9bUk/m9bVu87pEdfAJAiod6oCWoV1H
         ye6g+zgQhwa5iXZMX+OyUQ8auH1Hjt1ijKspPrsQcOLWIslq5lGUD4BMf7lie28l9JJ5
         Pzly8bf2rpTltcGZSnr0/XmJtfK6C+PgFKAdJCRCwYpTHp/LmFuci1EAZvMYHhQvfofO
         mJQ9I518tZfwEeIFr9iv8xAly/1i0BnfWvxlnepqXUlhfouWo9advrOCOvMhvj1OCbXR
         guxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661141; x=1706265941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKtqqOLjqJGdMtonI4P5mEMTKVliGwJ+zwCnWH5C8bk=;
        b=JS9aYiqFxChfTlfxDYEVkykG4JD6FKaxP4bgs9T8tjbQJMSdNTwp0hwf/ty37+6Nf2
         eLXRToer+kAHbZuq3nah9h6xGWoOb89qmzmjfkqfmxEmEN7Hs7D2CFWLywLnJ7Z+nmbK
         IHelm0PB4dDPfDvRvsBtmN1vfbQanuDtuOgeASGEqvM4eXIDIx2WHiFYTtETa7CrDPbx
         OoWTM3GJpQqzERA2S+adt884Z/CBB98849o03srciJdKONRfoRJAjCsloS9fNtRpGltm
         /IZDqOJScfNWyQs/JtkEJrcC0Ul1ERulVu1goefmsr23gFvfZ7OtHnFivMCXz7cV+pJx
         OWCA==
X-Gm-Message-State: AOJu0YxcO+nt5Wys4PEMEw5E8yazvmJbxbA7k/IUeaiyc8iwOGHvZelu
	OSSWURDQGvp4m3z7W66yFtp7hEoHhU5HqyYwk6Ga3ueexmHv02qsb6pr/U1HrmE=
X-Google-Smtp-Source: AGHT+IG4Y1qsP7t7ylEa/vU+m005rweLwKBMwyulcKNBD5OybDrKdZCdyTNr5tSCDvcQkIt7aSdNiA==
X-Received: by 2002:a05:600c:5116:b0:40e:86c0:1d16 with SMTP id o22-20020a05600c511600b0040e86c01d16mr1301827wms.150.1705661141695;
        Fri, 19 Jan 2024 02:45:41 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:40 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 13/19] tty: serial: samsung: don't compare with zero an if (bitwise expression)
Date: Fri, 19 Jan 2024 10:45:20 +0000
Message-ID: <20240119104526.1221243-14-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
References: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bitwise AND with the fifo mask is used to check if the fifo is empty
or not, it doesn't care about the length, thus the comparison with zero
is implicit. Rely on the implicit comparison instead.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index f8a8b459a86b..333ffa3a76a3 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -988,7 +988,7 @@ static unsigned int s3c24xx_serial_tx_empty(struct uart_port *port)
 	u32 ufcon = rd_regl(port, S3C2410_UFCON);
 
 	if (ufcon & S3C2410_UFCON_FIFOMODE) {
-		if ((ufstat & info->tx_fifomask) != 0 ||
+		if ((ufstat & info->tx_fifomask) ||
 		    (ufstat & info->tx_fifofull))
 			return 0;
 		return TIOCSER_TEMT;
-- 
2.43.0.429.g432eaa2c6b-goog


