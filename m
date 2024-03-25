Return-Path: <linux-kernel+bounces-117524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E95488AC2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAFD1C3DCB6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32432137922;
	Mon, 25 Mar 2024 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="WfV9tcVS"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C308136E1D;
	Mon, 25 Mar 2024 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385834; cv=none; b=rQ85XeHwKiEjCyP2wcS6xMl7WEqlwbeUBnMl7EZcI9MSEeOp+mENRRFcfOJI/JbKa6hsOW2bz1dBHPQOi3rij1XdLQS75pFpl751eOatNZHBauoWdXnxPqi/YKp81h3RQyIRvmX8Ky0SLqe+23gvncuOUJ3qbsrez0Us2hqJMVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385834; c=relaxed/simple;
	bh=yGM4irWrOGL/RrRmQtB8pS5xeSrk9c3qzsw0hBez+uQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M0O2yOwGf9mJGB6+MRopany+nCsDt5j803pGt4UKYTCW6LmtRT3Rpjdseu6QvNQKLAFz353a3l/kjeJg1xaDBZhPdpgz8HV7La+2zaRBgVfHLCvQdgtbXJbNQA3teySCYIaAYJD8xxklQEwibdymx6p3p+zM5kkBJXHXioVdotM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=WfV9tcVS; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 61553120004;
	Mon, 25 Mar 2024 19:57:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 61553120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711385820;
	bh=gH+zZTG2XTxDhXno5HnG1q7mVFathfIQiMuRGllPg9I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=WfV9tcVSItH3bplVNXX82ohdZn7KYBMsDVDQ4jPe7M8TfeG0jKDxbNSk4EJD1x0On
	 u5SPikbk1cjTo1QfPR3i1P2brE9e6ZOXgFlpR+LIF/tZ4/qagpV3obDnh4TveAp4AY
	 9sVbMFLTuGAtc9Telf+URL4u1oJ8ETT5jy+nAn+WkBIGs30AJ7uGC3wLhVMWcgxGtY
	 mKDzIdAm99NuJGtYKdzSeTjLPSncV47IrRzY6t8FrTfzF3UnKQa4xqrSUXkgqNEB32
	 Vb6YPSAeDgC1C7XQkYF9yU0Gvx3W5kteBl3iTBgXAJBR/14m0pRqOq/y+GUwfexhlz
	 dW9w5hyRd2zLQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 25 Mar 2024 19:57:00 +0300 (MSK)
Received: from work.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 25 Mar 2024 19:56:59 +0300
From: George Stark <gnstark@salutedevices.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <harald@ccbib.org>,
	<gnstark@salutedevices.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>
Subject: [PATCH] iio: dht11: set debug log level for parsing error messages
Date: Mon, 25 Mar 2024 19:54:06 +0300
Message-ID: <20240325165406.226916-1-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184403 [Mar 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 11 0.3.11 5ecf9895443a5066245fcb91e8430edf92b1b594, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/25 14:48:00 #24435619
X-KSMG-AntiVirus-Status: Clean, skipped

Protocol parsing errors could happen due to several reasons like noise
environment, heavy load on system etc. If to poll the sensor frequently
and/or for a long period kernel log will become polluted with error
messages if their log level is err (i.e. on by default). Also some types
of those messages already have dbg level so use unified log level for
all such cases.

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
I use DHT22 sensor with Raspberry Pi Zero W as a simple home meteo station.
Even if to poll the sensor once per tens of seconds after month or two dmesg
may become full of useless parsing error messages. Anyway those errors are caught
in the user software thru return values.

 drivers/iio/humidity/dht11.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index c97e25448772..e2cbc442177b 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -156,7 +156,7 @@ static int dht11_decode(struct dht11 *dht11, int offset)
 		dht11->temperature = temp_int * 1000;
 		dht11->humidity = hum_int * 1000;
 	} else {
-		dev_err(dht11->dev,
+		dev_dbg(dht11->dev,
 			"Don't know how to decode data: %d %d %d %d\n",
 			hum_int, hum_dec, temp_int, temp_dec);
 		return -EIO;
@@ -239,7 +239,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 #endif

 		if (ret == 0 && dht11->num_edges < DHT11_EDGES_PER_READ - 1) {
-			dev_err(dht11->dev, "Only %d signal edges detected\n",
+			dev_dbg(dht11->dev, "Only %d signal edges detected\n",
 				dht11->num_edges);
 			ret = -ETIMEDOUT;
 		}
--
2.25.1


