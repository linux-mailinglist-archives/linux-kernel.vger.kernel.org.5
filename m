Return-Path: <linux-kernel+bounces-90472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE4E86FFB3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 960A9B249EE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAD6B654;
	Mon,  4 Mar 2024 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="rTPB3rgx";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="meAzQJQs"
Received: from e2i652.smtp2go.com (e2i652.smtp2go.com [103.2.142.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBDD39AD4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550086; cv=none; b=nyZcZiGTZaFJVyrkQhqFXHwDQpXTLPZlfP31bThwj1aIjrfFaFsUcO56iA1svjkwdQ7WRYoVUkMO6UbM2MVjzwN13p1Z5Gs0tZ2OANt+dPuKYkmaUz2M9MLzWi4o7Qnc8RRxQIBHMSjseJAfPePql7Loyctp5S/8ESgtxjg9oZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550086; c=relaxed/simple;
	bh=rBFiQEB8z/lHUfa+VHj4uIsM/ByrCz1KLthEmNo8hYw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jY5CCELUgCd4TYwlEf6jFT61FvmFYfQ1EqwEYKCkKNY7EIhiOCBP6AclIZ0DfiLJmcQWIhdY18NEqs7PwLtw6b16HSMddvZVl2b2PdkKTiovfX24/zDy9+sYF0W+IQSTlBgdvimeRiARYgZFP0CNp7SDsa1Bs/ENS+Czl+RdX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=rTPB3rgx; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=meAzQJQs; arc=none smtp.client-ip=103.2.142.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=pxSNbisWh19U3rdQiiYOgslG+MwHDfuy5ghPqFpWc4E=; b=rTPB3rgxufVjq8U6sKvdzd2T8+
	UaqXqayzFoQcWOwRqoB+vzT2o3pMcjx/4epyKXLA4fMvVLrRq4zudpI/Ycr2c7zyvoYrSEFDig9HD
	R4Fy1PI5mEpsMBdTxNtjPWhdcPkZdkJUcoF7+bLKbRtuSCjAohODPSXomkWv/tjNcwb6uK6cBOK8h
	r1hz4MPmxAEpjyPekW74reqwxklOUz65LKUBpYAPuK+qyCN4UCHJ7h9YPFDk7jT+jJRyrp6ju3RGa
	VSBIEMlhXrVSxLkVl9e2l7Ttjh2nempMJvM+nnnGxCV5gCR2/rXH+PmzOLgUCA0/z8vJzPOQRWuHe
	F3pzpNMg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1709550083; h=from : subject : to
 : message-id : date; bh=pxSNbisWh19U3rdQiiYOgslG+MwHDfuy5ghPqFpWc4E=;
 b=meAzQJQscpSkaY8hjwk4U4XszqMW+ttDZYguZnneF4iwEJGj2+gwSXTEawsRRVD40TqQd
 WJmAsOadsTnCgot5th0wZiYX5pIq5ltebiFZ3zFrvm//3z68HDohPZIbj+PcucVeLZ7J6zF
 SwRxF2Com//sSyDNL6BCAS1pyKpv52sYv4v9DuSp2S4w4buisJaZarJhB348V91nPY36w7v
 djDxpC1v26CvTXfr5xNPgcMxtmGCuQS4Gl9jH0Bi4nNXd6NtHBsojnKwCqEUsijk4ZhkcE9
 WTPCzBODQrSLrEY7Y8rB1uNys6qSD01zHlz/UVPqVUtIzk6kVt+7YgimqJFQ==
Received: from [10.45.79.71] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1rh64J-qt4GTh-Gc; Mon, 04 Mar 2024 11:01:15 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1rh64I-Dv15V4-0A;
 Mon, 04 Mar 2024 11:01:14 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with
 Microsoft SMTPSVC(10.0.14393.4169); Mon, 4 Mar 2024 12:01:12 +0100
From: Flavio Suligoi <f.suligoi@asem.it>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH] thermal: core: remove superfluous line in comment
Date: Mon,  4 Mar 2024 12:00:22 +0100
Message-Id: <20240304110022.2421632-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Mar 2024 11:01:12.0413 (UTC)
 FILETIME=[4529D0D0:01DA6E23]
X-Smtpcorp-Track: 1rh64mDv15V40j.5bn49EblaxtBw
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sD5JYLEGfq
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

The first and the third lines of the comment of function:

thermal_zone_device_set_polling()

belong to the same sentences, so they have to be joined together.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/thermal/thermal_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f7a7d43809e7..34a31bc72023 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -273,7 +273,6 @@ static int __init thermal_register_governors(void)
 
 /*
  * Zone update section: main control loop applied to each zone while monitoring
- *
  * in polling mode. The monitoring is done using a workqueue.
  * Same update may be done on a zone by calling thermal_zone_device_update().
  *
-- 
2.34.1


