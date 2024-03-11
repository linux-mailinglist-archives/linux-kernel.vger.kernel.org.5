Return-Path: <linux-kernel+bounces-98398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF8F877990
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 02:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2521F21E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 01:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AE623A0;
	Mon, 11 Mar 2024 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROPAmu4J"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF03310E3;
	Mon, 11 Mar 2024 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710120867; cv=none; b=kbTE4eM6EkdHLL4qs1RFrL/54w1XRrwAdqtFpSZ5m2tcZspybDtU4cv/uCUxemfNg+NTtrQCWiWXgbMLtJp0XKHvmQPES2RrFbvGqKIsRLieZgb5dnomVjoJjAGAlqE9yMac78rbNzLLhZWO35FJs6BeJvthH1+160EXhVSrrg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710120867; c=relaxed/simple;
	bh=xYZXElax709wGkAri23JbY5iri9S5arOBEfajMbStqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CcF6+sf5GRwah1h7JNHPY0gzYib3wTt4GVOcba7vmQwJUAoV87h3OBAS9z9RX20z0QsKmKAdlW4gbVxq6KKYLbc6ppIgqHzM/R0r384wWr9C8lHWZ0NbxeQD3aaSI+Qay75dAp9RrX44oKYvzr+1MmFnpbbv0vLhSpqnQBKO2Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROPAmu4J; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dd611d5645so21697635ad.1;
        Sun, 10 Mar 2024 18:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710120865; x=1710725665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QpEUw5eyC4HEPvfJHmw08ig3V0O5LyY5ZvvKVAvM2I=;
        b=ROPAmu4JJ5dKud89acqqeksLaAsPpp09x9i93wQJwi4SDR43iHE9uZRNc4OqEs3GXq
         rHOK2g70r5fsO2zYOkKgY8dJKola0WZrPnn5ptKg/ibd9ddPxtH1usUCdXF1MDv3/yXd
         62EVnXHlQfECg55lXZ3ViBbpIeF1D2InGzzwapDu+qSSk51ncMM9o8gfH/xUQbdWgYQt
         jEOXJDYjQDp3agXrqmp5w5tRIo43p8pStz/l0yrOZRXtst1tcMQXT8ia+KPj/+QjaXzd
         FWVEXq2L3S291lDbqcIdKKMCrQleXoMyAvOfEiPblZS3SV83J5ec3AwH9KxLtsDBMMlX
         pj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710120865; x=1710725665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QpEUw5eyC4HEPvfJHmw08ig3V0O5LyY5ZvvKVAvM2I=;
        b=TT5eKdwwfXJc6CknGO8YxFk089GSzWANeZwoTdIgLYmWeciInRpoVzFVHATTsLJVpT
         Zpir/xOsWn+l3SqbZ17Au95/ATSbEQNlfi+ZjG9DuJNeEUJnKhfXZMLMZlKzW35JzJOW
         AfE1tAYuR5Hvo/Knc2Edrbe+v6eR/aR9Qx1SseherOjhsmVoDrcuFHbszKJ4qSXsVn9b
         CoaHQL2lIJGx5HeSnlUAeZ8xdK2WWmRjObmXEP7h17WFukC8bsKDbe/VN6PrQkvluWrf
         97FulKJutxcwnkCsYtxCI6t5j002cytZq3VtaOkGa+C+oiuR4CWPW3uWcmLM7WdCikxZ
         5Iow==
X-Forwarded-Encrypted: i=1; AJvYcCUEWCaIdP/T8kDq53wsIWbVlwzW7T260HcdC66p7+f8tbQ2gVS6RcZB0OgmMdnBcCD3/uj/lsuf1acaUu5EDAy3C4lD86q88YHJYKjpJUvcZIhP5r7PPxo2p95fNr2DeVKybCi4OQVG
X-Gm-Message-State: AOJu0YwPLUmnvFpdMQ7PvDjMtA7iNGlT3Rg4WdVQsWCVWpsQiOpzKElQ
	g66O5s4gMJMyhFywtnw+wmJwip8RYiC9SdZ+H20nWKaRKrmKWWRq
X-Google-Smtp-Source: AGHT+IEAeyjg3xhuB/I//fWBM/9zitHT4hxtT7rTFBLq6P6c+R8jMXNtVxd92ufsyQPcoTDue/fHlw==
X-Received: by 2002:a17:902:6846:b0:1dc:b308:c3b6 with SMTP id f6-20020a170902684600b001dcb308c3b6mr5895821pln.1.1710120865000;
        Sun, 10 Mar 2024 18:34:25 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b001dbae7b85b1sm3255012plf.237.2024.03.10.18.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 18:34:24 -0700 (PDT)
From: Mia Lin <mimi05633@gmail.com>
To: avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	alexandre.belloni@bootlin.com,
	mimi05633@gmail.com,
	KWLIU@nuvoton.com,
	mylin1@nuvoton.com
Cc: openbmc@lists.ozlabs.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] rtc: nuvoton: Modify part number value
Date: Mon, 11 Mar 2024 09:34:05 +0800
Message-Id: <20240311013405.3398823-2-mimi05633@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311013405.3398823-1-mimi05633@gmail.com>
References: <20240311013405.3398823-1-mimi05633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Base on datasheet,
    the part number is corresponding to bit 0 and 1 of the part info reg.

Signed-off-by: Mia Lin <mimi05633@gmail.com>
---
 drivers/rtc/rtc-nct3018y.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
index f488a189a465..9dce003126a5 100644
--- a/drivers/rtc/rtc-nct3018y.c
+++ b/drivers/rtc/rtc-nct3018y.c
@@ -517,12 +517,15 @@ static int nct3018y_probe(struct i2c_client *client)
 	if (nct3018y->part_num < 0) {
 		dev_dbg(&client->dev, "Failed to read NCT3018Y_REG_PART.\n");
 		return nct3018y->part_num;
-	} else if (nct3018y->part_num == NCT3018Y_REG_PART_NCT3018Y) {
-		flags = NCT3018Y_BIT_HF;
-		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
-		if (err < 0) {
-			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL.\n");
-			return err;
+	} else {
+		nct3018y->part_num &= 0x03; /* Part number is corresponding to bit 0 and 1 */
+		if (nct3018y->part_num == NCT3018Y_REG_PART_NCT3018Y) {
+			flags = NCT3018Y_BIT_HF;
+			err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
+			if (err < 0) {
+				dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL.\n");
+				return err;
+			}
 		}
 	}
 
-- 
2.25.1


