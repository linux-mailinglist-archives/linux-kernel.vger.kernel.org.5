Return-Path: <linux-kernel+bounces-122964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA5189007A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8AD1292437
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B8A81AC1;
	Thu, 28 Mar 2024 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="jR2Sl/zK"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6311DDF6;
	Thu, 28 Mar 2024 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633096; cv=none; b=tJxvZ9QEHJaiDeGcjANMlmqksLzE8gFlGtHIw3cZeQs13IUn7O02ehKNJ4hGOHRWJkz/r9b0ZoYd1ixHW3qKNAzkYEPccY90acnlBXZRrlBTfmkNEec96RzGuvM/+4eJgslEVUC2/uHogRKCeDb0MfsSf9xgJvBEkW3w5T22Apc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633096; c=relaxed/simple;
	bh=0dok5g0tg7QuPm4S4YUPz3mypyYi9jIsQw4Y3h1htvA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eGvcA4aFIXITaOg4315hcjuikbOSq8apEa3ouKdsc90WAHyd3zRyso67WbnpgU+rfiV5i8p4Vjr5v3xaBLKpy6E+uoE51zZIRnBb6YiV4pKOMvW2Kq8ChFDc0HJrbFUT3/HjtAXEFu1EOgsHWYkIK2Lm/5+4flLCT7Y9WPI+xxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=jR2Sl/zK; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 59E08100014;
	Thu, 28 Mar 2024 16:38:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 59E08100014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711633089;
	bh=1VOGE1dl8McFh3KcGh2ht+nrIDpqZWZpRU4J/qJlqq8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=jR2Sl/zK8pmtiz+iiXdE3k4xB6dE01jb9JHaXlxIqzhPY7uiL8unvBd68Tyg85d64
	 K97asJ082zBxtMLIXNGiKB9w9eKyt7lhrpm6WJQhXxi4Y8uj+kL7bsnIv5SIXuhCIz
	 16q5JHKDW3/ydVlsRHy/lOoNsD49amT2g1SHuDVTr3ghzc6nBmRlCFnJFN69K1KO55
	 pyCULfRLTdpaSW/QneBqalsAMqwKHL6i+ebK+nksm+Xx+Zj5F6Wc5n4MxN66nQWyiL
	 cu9Dq16HWxEy/0oYBsjgnp9j+2hpKKynn+N8YPPuxWTAh+IVScZFZ9dysKf+oOq1Ly
	 JZrJADaTyjnMw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 28 Mar 2024 16:38:09 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 16:38:08 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <glaroque@baylibre.com>,
	<rafael@kernel.org>, <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
	<lukasz.luba@arm.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v1 0/2] thermal: amlogic: introduce A1 SoC family Thermal Sensor controller
Date: Thu, 28 Mar 2024 16:37:51 +0300
Message-ID: <20240328133802.15651-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
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
X-KSMG-AntiSpam-Lua-Profiles: 184470 [Mar 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/28 10:33:00 #24492761
X-KSMG-AntiVirus-Status: Clean, skipped

It is primarily based on the G12A thermal controller, with only a slight
variation in the offset value of the efuse parameters. Therefore, this
patch series provides appropriate platform data and dt-bindings to
ensure proper support.

Dmitry Rokosov (2):
  dt-bindings: thermal: amlogic: add support for A1 thermal sensor
  thermal: amlogic: support A1 SoC family Thermal Sensor controller

 .../bindings/thermal/amlogic,thermal.yaml          | 14 +++++++++-----
 drivers/thermal/amlogic_thermal.c                  | 10 ++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.43.0


