Return-Path: <linux-kernel+bounces-130557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EED88979EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EEF0B270C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64F015625E;
	Wed,  3 Apr 2024 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vvTen/Kx"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51B15625F;
	Wed,  3 Apr 2024 20:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176618; cv=none; b=cAPkTXy7j/ed+TJMWRUzsqMj9DzlXSRccOdpSorw+uv1a8D4oL0gV/RZoXKZHOTg/EPbjGfE+bLXDwevZs7n6BK/wXPvCM35FYTiGixq7yhIerLsCqrkqT0OkRE2yIAIoUOcj0crXNwrqVkgzAdBL0W23Bqgn67NBm4Ca8cV/90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176618; c=relaxed/simple;
	bh=AmutkIMXoFoI+xlbdmM8YrB8Y5IthRp4+Pww6eKMnOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgvV06orn6oXVyAqPkkZhg+h39OSi9d7auL1eZiqsFNYe2u1wH3mWP880oWYfX4xrKOuXDF7PNLeICsrsDfGsAqjdyOc8oPxy4rCdGQbZdLXcoT7fZK9KzwqCvzxp9h60bTGZj36+4KdLs1hfIGO31iULqFe6awlI251VKJSrgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vvTen/Kx; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433KaboY076297;
	Wed, 3 Apr 2024 15:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176597;
	bh=s0eXc4e7+KokmvhKQNCW52y6DVPW/nkE8HC0W8JHKPQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=vvTen/KxyPGjFL9as658R1PWVvcPs9oWzXISlI68wU0Ab07oVH/rhOKZO3RqBkDnX
	 ZjCn5jC8Hf9cqfNJLyJN0FIGIT2RNGekPogARw1/IdX/ce2tGdJfZqYYoLaPf+Qg/Q
	 LqLjep7zDyzrsgR4RxzM4/bkwn/zhNT/f//fwDnU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433Kabxt092362
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:37 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:37 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFm080324;
	Wed, 3 Apr 2024 15:36:36 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 07/31] hwmon: (dme1737) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:09 -0500
Message-ID: <20240403203633.914389-8-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403203633.914389-1-afd@ti.com>
References: <20240403203633.914389-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The function i2c_match_id() is used to fetch the matching ID from
the i2c_device_id table. This is often used to then retrieve the
matching driver_data. This can be done in one step with the helper
i2c_get_match_data().

This helper has a couple other benefits:
 * It doesn't need the i2c_device_id passed in so we do not need
   to have that forward declared, allowing us to remove those or
   move the i2c_device_id table down to its more natural spot
   with the other module info.
 * It also checks for device match data, which allows for OF and
   ACPI based probing. That means we do not have to manually check
   those first and can remove those checks.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/hwmon/dme1737.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index 3dcef221041d0..1a9b28dc91e64 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -2461,8 +2461,6 @@ static int dme1737_i2c_detect(struct i2c_client *client,
 	return 0;
 }
 
-static const struct i2c_device_id dme1737_id[];
-
 static int dme1737_i2c_probe(struct i2c_client *client)
 {
 	struct dme1737_data *data;
@@ -2474,7 +2472,7 @@ static int dme1737_i2c_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
-	data->type = i2c_match_id(dme1737_id, client)->driver_data;
+	data->type = (uintptr_t)i2c_get_match_data(client);
 	data->client = client;
 	data->name = client->name;
 	mutex_init(&data->update_lock);
-- 
2.39.2


