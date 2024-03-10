Return-Path: <linux-kernel+bounces-98278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DF68777CB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F77F1F20EEE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADBD39855;
	Sun, 10 Mar 2024 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="UOfuasIZ"
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de [129.70.45.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2821115;
	Sun, 10 Mar 2024 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710092544; cv=none; b=T8t4PYOb4/NGCoPWOpCDoc6MNnidZZQG2LJR/tFCQsiWjgZKdOjQj9NWl8iOXcJgmKU4RXLebAC4gMiK7AJKG1qH8Z+1m0mp9s410AX5vJeA4EXD4QyXs1LCxQDn3DSSQn6QM3/dHETCYAoXCDtJ8welPM215iIV6iulx7AuofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710092544; c=relaxed/simple;
	bh=JjnmvSWzQ3skeCeWaRaZEbDd1U+jcePFgpXcI+mVNAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NO7UBSwmqpyzRObW6kS47v8aQq3VENjL0qfmTxzFMhrwaPPHusVjYphMrBaSbIk7cWux85u0byNInb2EZRQsmztaaiGFbxHTf4azgdyvaQ/Q7uNULDMvMEZGDvAk6wMdr5ZmtGFf0nB1iNldD4gqeEjIIQVx4OL3jjSxb1cnmgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=UOfuasIZ; arc=none smtp.client-ip=129.70.45.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
Received: from localhost (dslb-094-217-220-071.094.217.pools.vodafone-ip.de [94.217.220.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id 03F8760ABB;
	Sun, 10 Mar 2024 18:42:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1710092530;
	bh=JjnmvSWzQ3skeCeWaRaZEbDd1U+jcePFgpXcI+mVNAc=;
	h=From:To:Cc:Subject:Date:From;
	b=UOfuasIZqVJu6n6AOCf14bJj4HXVvYKlYZi0XzG8pf2OCSyUh2OtlNi6FPgbupX2j
	 eL2C+aVQ71lyrQt42Vit6Hk0XVid08V1GK2DLDzf4irX3RzqS2cmDg+862h0mkgZGH
	 8+g1vkyBfld1nga2qBJ7Yb8z6BQUrjNZJochzTGtVncQIytFBA4Ap1rOPwJyJFfgTX
	 oNoffeH26Z0qvlDe9hWFksyckDuSITt7w1q0zBVts4rqrX19eG8Vj8k0O594Ff8Zoe
	 IOEmGVQZWWMlbEZRzppXHqrRFQbPKc5GaPEDCGq6s7RU+30IQz4keNgW8A2AMZAkeG
	 BxUod/hGV8rLQ==
From: tjakobi@math.uni-bielefeld.de
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Add Dell G5 5505 to DMI table
Date: Sun, 10 Mar 2024 18:41:43 +0100
Message-ID: <20240310174144.859510-1-tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

Enables reading the speed of the CPU and GPU fan on the G5.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 44aaf9b9191d..bee9cca2f768 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1192,6 +1192,14 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "XPS"),
 		},
 	},
+	{
+		.ident = "Dell G5 5505",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "GSeries"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G5 5505"),
+		},
+	},
 	{ }
 };
 
-- 
2.43.0


