Return-Path: <linux-kernel+bounces-18590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8A5825FC9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396FA1F21569
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FE4749A;
	Sat,  6 Jan 2024 14:12:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162057494
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 758DA84071;
	Sat,  6 Jan 2024 15:12:04 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Sat, 06 Jan 2024 15:11:33 +0100
Subject: [PATCH v2] soc: pxa: ssp: fix casts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240106-pxa-ssp-v2-1-69ac9f028bba@skole.hr>
X-B4-Tracking: v=1; b=H4sIAJRfmWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxMDQwMz3YKKRN3i4gJdUyMjcxPTFBMjE0MLJaDqgqLUtMwKsEnRsbW1AHa
 lQ3lZAAAA
To: Arnd Bergmann <arnd@arndb.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Lubomir Rintel <lkundrak@v3.sk>, zhang songyi <zhang.songyi@zte.com.cn>, 
 soc@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=nG1Ud3E/McbOgiucrgVOFbNv69PsS0D3QewrfR7q2qI=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlmV+erp7NYDOlDGSNcq79EREE1t7nDQqu0YJxQ
 CpPJ52xTf2JAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZZlfngAKCRCaEZ6wQi2W
 4XezEACZ5xs9RVZqA8fSBiecFOpVS6RMzaeMScr8A02opWHWnRLJb5mGbECUwjRsFqT1vX2Bl+t
 T9NMx5aLt4jhYTE1Uj0qN3mooLCes/VIKg6+VJMELbnFe5F7e/YR/MHVoP0MlRJ6PPL0zuwCi3k
 4TY0/jzpRWi/OfNyhDT0G9VBFQahAHMyAQdSEPJ7iARzGRicXq4bTyIXvrIq11EQ0l5bDEHEQ6C
 4/HWJL18DKOSOQGW0bhaIX+Terkt5sLiP1he60rdqlf4/Yv8vX1nUVxGWUmbj2w3TphbIeO4jBa
 0jIrsOGPgQrI6R+PDYmVqAlDN48ccKUx32aueMABRPknJckb2fVYC7miJSmEHuo0/eu41mAJpLW
 1Lj6tSouB8TiQc20pZEXGYVuvJ9D2q/D7s8QMO+5HYoxblyVsEPDZhuoqGVTrqy3VwVIV+QJ+nk
 FUU+8UnmYGAOS1NT46/NFTWV2T83g4u09tiOKG0M3nGc5bInfgcIpnAWjpx85KKw7X6/boN75gy
 fYBOZm1gjun8MMcE+UL743T/dobU64ujdEgO5VRFD+zeTNetcuS47yZ54+nv1UQiYIrOqkBHs4R
 l86dEDA1HVzG/um26eg3ZusbpcDJGRE4D3iac7kPjdDi7gOk3bpBIYUfjC0mvubq1CujTZ6l2lG
 W8G8qP6LIJo1kjQ==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

On ARM64 platforms, id->data is a 64-bit value and casting it to a
32-bit integer causes build errors. Cast it to uintptr_t instead.

The id->driver_data cast is unnecessary, so drop it.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
This patch is necessary for my Marvell PXA1908 series to compile successfully
with allyesconfig:
https://lore.kernel.org/all/20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@skole.hr/

Changes in v2:
- Change first cast to (uintptr_t)
- Drop second cast
- Link to v1: https://lore.kernel.org/20240103210604.16877-1-duje.mihanovic@skole.hr
---
 drivers/soc/pxa/ssp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/pxa/ssp.c b/drivers/soc/pxa/ssp.c
index a1e8a07f7275..7af04e8b8163 100644
--- a/drivers/soc/pxa/ssp.c
+++ b/drivers/soc/pxa/ssp.c
@@ -152,11 +152,11 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	if (dev->of_node) {
 		const struct of_device_id *id =
 			of_match_device(of_match_ptr(pxa_ssp_of_ids), dev);
-		ssp->type = (int) id->data;
+		ssp->type = (uintptr_t) id->data;
 	} else {
 		const struct platform_device_id *id =
 			platform_get_device_id(pdev);
-		ssp->type = (int) id->driver_data;
+		ssp->type = id->driver_data;
 
 		/* PXA2xx/3xx SSP ports starts from 1 and the internal pdev->id
 		 * starts from 0, do a translation here

---
base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
change-id: 20240106-pxa-ssp-522745d42418

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



