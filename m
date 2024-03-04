Return-Path: <linux-kernel+bounces-90889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84894870671
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBF21C211E5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC16482DD;
	Mon,  4 Mar 2024 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Hbct6sg+"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3645045BFD;
	Mon,  4 Mar 2024 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568215; cv=none; b=SA4Ap2leATLchSWS3FVtIenlNmTvRCzXKZIi5wFy5+u724zqhK0f5w6TmqzZBKzR+KO+Q6uGp7z1eaDNRat8C72OOmAAg0JREKLWw7dhe2CK6+rmfXNk5bbZUR6H1yltS6wbznqWoqzSI22n2xyv3oCENqiOUEKOvVuU74M0bX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568215; c=relaxed/simple;
	bh=D/KwLnLg1Pt6FCC8yfq9skBV2EtjxAGhtIjMRLLj/os=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PQe244MOnivpAg9sAF3IlNDuetc/tk6JAUMKnsDj9d7w939cCjdVepYMIMQqLTV7cFhfRVktHaV/uvzqEkogY420TfI5pFXDDrwzrWc+RUkZRNNenfkDHaUX9NP2u5DFxg41mvLmbKwOI35DexLBi7ek3jUrnz/FU4Wo/YOpT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Hbct6sg+; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4247LDvd007062;
	Mon, 4 Mar 2024 10:03:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=l
	my/Qp1muiAos4gC1fKw7bY7+r2yo//3ZsL1BGcy9AM=; b=Hbct6sg+b1NPOqTIj
	kU/6Mk9lr9eqzsYvYA+sPerNyvjHGYwy/6Skj8Uz0MF0mNgIDIXixUN5USMNrRJ+
	4ypr19a0Kxwjz+OMJt1As/5TDdFtfn9noCW4+bQE5pCzdy15DSa+7rMcguTV4fjO
	hKR52+79ovkxOTZNTiqxiLTyyVA49Ias8DERixjDI8QhjVQ8W/NS4+t+hOHoYiOW
	9WGv7gFvXPu3PoIcQPC1XPgqmVkyC1oszJrTj17BtiTyYa6wDgt35cyD1WCK/xjI
	jitK/T8Lh9HrSnpCiWyjLwAB8bxsOiij2icdTz8KT3eCA8MrCiuT7uF/Ook2bzbS
	yJWBA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wm1dpa366-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 10:03:22 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 4 Mar 2024
 16:03:20 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Mon, 4 Mar 2024 16:03:20 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id CBFC8820241;
	Mon,  4 Mar 2024 16:03:20 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] gpio: swnode: Don't use __free() on result of swnode_get_gpio_device()
Date: Mon, 4 Mar 2024 16:03:20 +0000
Message-ID: <20240304160320.1054811-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6b8zv0zGbPRGvrCu4CH_x6mTFgCBAtbJ
X-Proofpoint-GUID: 6b8zv0zGbPRGvrCu4CH_x6mTFgCBAtbJ
X-Proofpoint-Spam-Reason: safe

swnode_get_gpio_device() can return an error pointer, however
gpio_device_put() is not able to accept error values. Thus using
__free() will result in dereferencing an invalid pointer.

As there is only a single exit point anyway, simply call
gpio_device_put() manually. Whilst modifying the code move
the variable declaration to the top of the function, and move
fwnode_handle_put() until after the error check. Technically
fwnode_handle_put() will handle being passed an error value, but
no need to call it when the code knows it doesn't need to.

Fixes: b7b56e64a345 ("gpio: swnode: replace gpiochip_find() with gpio_device_find_by_label()")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/gpio/gpiolib-swnode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index fa52bdb1a29a3..de43e0b06a4b1 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -50,6 +50,7 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 {
 	const struct software_node *swnode;
 	struct fwnode_reference_args args;
+	struct gpio_device *gdev;
 	struct gpio_desc *desc;
 	char propname[32]; /* 32 is max size of property name */
 	int error;
@@ -71,12 +72,12 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 		return ERR_PTR(error);
 	}
 
-	struct gpio_device *gdev __free(gpio_device_put) =
-					swnode_get_gpio_device(args.fwnode);
-	fwnode_handle_put(args.fwnode);
+	gdev = swnode_get_gpio_device(args.fwnode);
 	if (IS_ERR(gdev))
 		return ERR_CAST(gdev);
 
+	fwnode_handle_put(args.fwnode);
+
 	/*
 	 * FIXME: The GPIO device reference is put at return but the descriptor
 	 * is passed on. Find a proper solution.
@@ -87,6 +88,8 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 	pr_debug("%s: parsed '%s' property of node '%pfwP[%d]' - status (%d)\n",
 		 __func__, propname, fwnode, idx, PTR_ERR_OR_ZERO(desc));
 
+	gpio_device_put(gdev);
+
 	return desc;
 }
 
-- 
2.39.2


