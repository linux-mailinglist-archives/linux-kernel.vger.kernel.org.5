Return-Path: <linux-kernel+bounces-30846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF7483250C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FDF1C22A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D0CD52F;
	Fri, 19 Jan 2024 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="az0d+tTn"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA1D51D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705649417; cv=none; b=NV+LIJNd2R/myRcZc++VrzW/W05Z4Ec4JUCt1c+OCEFtfq1Op0Zt8d8gVgSZffH6ok+M6mVDlC2kLY6wNOtvoeEEM5Odnfym9chnyTjRyEynCOjwbOtlojaoFE5oBCurHZ5r+EJCEW/+wbGwiftz701jMoiXA/qJGYF81XnnjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705649417; c=relaxed/simple;
	bh=d0nzALVx5Huz1UxcaTbDiEGhUtQ5tZ8N/WWCfalo100=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=K4/zRlf8ZvBvhQC54APFFWq0boies3qYSa4mboMY8VqeaDJZtK5Vi/x/n/P1yGkVS3yHOQi7h46RZohAK40NZAkobmut8rCQLJ3dc5YDOJQx+xf0G16tRVPwEmiaK0dIBQfiL5ZaRyRkB3GT7BirwcPBQMDghxlxliOB4bTMZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=az0d+tTn; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240119073012epoutp0336905e0a3b81b203263ad093734e9f7e~rrxqKmMFB2169821698epoutp03S
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:30:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240119073012epoutp0336905e0a3b81b203263ad093734e9f7e~rrxqKmMFB2169821698epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705649412;
	bh=6N9+i2zBdw87P2pvQtZNgxaco3hwd3DwBXjFeRUkiZI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=az0d+tTnArZsUEgb5Y5rTHV27mrPdhXBVC14mMrJC9drlOZwZ9vJ9rZCRxpWhRsrZ
	 We12UInvu2SwHQhsgcoflwLPDXRNQboYnnxULyjIbTxXhGSy7emmGYuLhGTehDX5+y
	 tXK5BQxwuJOgC/daXcLFwcTW1WAPxasySQVmuCmI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240119073011epcas1p46c1a93c0ee81cddc29dbd436d94106d6~rrxptATOz0138101381epcas1p4w;
	Fri, 19 Jan 2024 07:30:11 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.222]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TGWVC3nPSz4x9QL; Fri, 19 Jan
	2024 07:30:11 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	26.E0.10211.3052AA56; Fri, 19 Jan 2024 16:30:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240119073011epcas1p1841e79c8f673c3c69ef696edc9eb47b0~rrxo8wYtD0610906109epcas1p1j;
	Fri, 19 Jan 2024 07:30:11 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240119073011epsmtrp1e0b73ff32fb1a601ad574230243e8335~rrxo749Hn3009230092epsmtrp1W;
	Fri, 19 Jan 2024 07:30:11 +0000 (GMT)
X-AuditID: b6c32a38-463ff700000027e3-f2-65aa2503c01d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A9.65.08817.2052AA56; Fri, 19 Jan 2024 16:30:10 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.71]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240119073010epsmtip138dc9e69262c0f67e2c1334577c8685f~rrxopMZht1212312123epsmtip1T;
	Fri, 19 Jan 2024 07:30:10 +0000 (GMT)
From: Seunghui Lee <sh043.lee@samsung.com>
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, gregkh@linuxfoundation.org, avri.altman@wdc.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, dh0421.hwang@samsung.com,
	junwoo80.lee@samsung.com, jangsub.yi@samsung.com, cw9316.lee@samsung.com,
	sh8267.baek@samsung.com, wkon.kim@samsung.com, Seunghui Lee
	<sh043.lee@samsung.com>
Subject: [PATCH] mmc: core: Fix null pointer dereference in bus_shutdown
Date: Fri, 19 Jan 2024 16:32:47 +0900
Message-Id: <20240119073247.7441-1-sh043.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmvi6z6qpUg2NbZCxe/rzKZjHjVBur
	xb5rJ9ktfv1dz27RvHg9m0XH1slMFjuen2G32PW3mcni8q45bBZH/vczWjT92cdice3MCVaL
	42vDLTZf+sbiwOdx59oeNo/9c9ewe/RtWcXo8XmTnEf7gW6mANaobJuM1MSU1CKF1Lzk/JTM
	vHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoEOVFMoSc0qBQgGJxcVK+nY2Rfml
	JakKGfnFJbZKqQUpOQVmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZhw+3sxX0cFS8mnGUuYHx
	PFsXIyeHhICJxMkrX1m6GLk4hAR2MEo0n94H5XxilHjXew/K+cYo8eL1YnaYlo19k1hAbCGB
	vYwS+5eaQNifGSVWb+cHsdkEtCSmb9rCBNIsItDGKNG34jHYJGaBD4wSv/pWAmU4OIQFPCTO
	nC0CaWARUJU4//sK2FBeAUuJY28eQC2Tl/hzv4cZIi4ocXLmE7AaZqB489bZzCAzJQQaOSRu
	vF7OAtHgInHv9WZGCFtY4tXxLVCDpCRe9rexQzQ0M0q0NUB8LSEwAei3Ba+YIKrsJZpbm9lA
	rmMW0JRYv0sfYhufxLuvPawgYQkBXomONiGIamWJl4+WQXVKSixpv8UMYXtIXF16ghkSKrES
	j363MU9glJuF5IdZSH6YhbBsASPzKkax1ILi3PTUYsMCE3hUJufnbmIEp1Atix2Mc99+0DvE
	yMTBeIhRgoNZSYTX32BZqhBvSmJlVWpRfnxRaU5q8SFGU2CoTmSWEk3OBybxvJJ4QxNLAxMz
	IxMLY0tjMyVx3jNXylKFBNITS1KzU1MLUotg+pg4OKUamMK3eyUb6vQnvE1y2uRUZpB7aebZ
	2MKHUzufrhA7/v5ue7BaZwvHI6OsPw1egpvMxTa4KgRe/3nq1i25r0lb0n+dFUsLXCae8Moq
	NVjRv/SXZo58bknb3yymSYkB+l6fc0OUbtXNYXE6F/N8akHqjuJ1Jr/e/Hs9Y9K+nAOFNQuX
	LXh73Kj0x/TeVQoGsx6efCv02zBt0mMj1393TpbGTbx9xuWs9Jf8xzWL3u+8lDHPPiHFx+Yv
	3/yjr6OVHuflS30JnfGke0HcBt5Y86OTp0wPl/mfNb/2CM+TJdvXqczSkf3JcmK53Iw0rX1m
	Rf7cF/vddmwI91wmaf9QRU/docDE63/ev7xNun5BSeePXVNiKc5INNRiLipOBADsGfkIKgQA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSnC6T6qpUg5sfLS1e/rzKZjHjVBur
	xb5rJ9ktfv1dz27RvHg9m0XH1slMFjuen2G32PW3mcni8q45bBZH/vczWjT92cdice3MCVaL
	42vDLTZf+sbiwOdx59oeNo/9c9ewe/RtWcXo8XmTnEf7gW6mANYoLpuU1JzMstQifbsErozD
	h9vZCno4Kl7NOMrcwHierYuRk0NCwERiY98kli5GLg4hgd2MEnM6/rJAJCQlFj96CFTEAWQL
	Sxw+XAxR85FR4tS5d4wgNWwCWhLTN21hArFFBHoYJfp25YEUMQv8YpTYMXUZWLOwgIfEmbNF
	IDUsAqoS539fAZvPK2ApcezNA3aIXfISf+73MEPEBSVOznwCVsMMFG/eOpt5AiPfLCSpWUhS
	CxiZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBAe6ltYOxj2rPugdYmTiYDzEKMHB
	rCTC62+wLFWINyWxsiq1KD++qDQntfgQozQHi5I477fXvSlCAumJJanZqakFqUUwWSYOTqkG
	pu06Lb416fqHMpL36S5Osj/t7V28MdZ4i0vBtncep7bqbjDe4v8j7nrInXzv+ylLHzJ9//VB
	wHm+3Iney5VrMhoklY5qbDUIW5DyO0kx/cq9745KUZs7XnBzKdqrsTgz1x7ab6Un21R+O+ED
	s6vyl65a1ZeLHQ4faNAK6RP8aarqwvrxwtMrXTsOVavNmugY1PVrw/2+neJOW3bP7ihQF2pa
	cEvH9dbPD7HfDnC37nO+8NG3emNfRK3txIymr89Wr0x0qCn7d+8hy68X69JDV/eYG3xRLpzy
	dnLZuj/vQ73X/joqe0hR8I/Bc9UH1dy2wTs5V1uHc/THKCoL2/U73JI7d3N2jNS306tDublZ
	lFiKMxINtZiLihMBrTkCSOMCAAA=
X-CMS-MailID: 20240119073011epcas1p1841e79c8f673c3c69ef696edc9eb47b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240119073011epcas1p1841e79c8f673c3c69ef696edc9eb47b0
References: <CGME20240119073011epcas1p1841e79c8f673c3c69ef696edc9eb47b0@epcas1p1.samsung.com>

When shutting down removable device,
it can be occurred null pointer dereference.

To prevent null pointer dereference,
At first, check null pointer.
Next, block rescan worker to scan removable device during shutdown.

Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
---
 drivers/mmc/core/bus.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 0af96548e7da..4f370a6577aa 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -143,9 +143,17 @@ static void mmc_bus_shutdown(struct device *dev)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = mmc_dev_to_card(dev);
-	struct mmc_host *host = card->host;
+	struct mmc_host *host;
 	int ret;
 
+	if (!drv || !card) {
+		pr_debug("%s: drv or card is NULL.\n", dev_name(dev));
+		return;
+	}
+
+	host = card->host;
+	host->rescan_disable = 1;
+
 	if (dev->driver && drv->shutdown)
 		drv->shutdown(card);
 
-- 
2.29.0


