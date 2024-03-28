Return-Path: <linux-kernel+bounces-122986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469B18900B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1991F26520
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5BE83A1C;
	Thu, 28 Mar 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="nnuYkOb8"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769F405FF;
	Thu, 28 Mar 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633514; cv=none; b=uHPpLpKii5BFxC736Rekhzg6nVQb0cXkPVC7q0+27+Ry0yJnuqeC11FK0DqpUkNZAhmfR7qGSZQ5Sq75N1/QMRJwAbpTS8j5vG6MqMSpiI2T5tSduClNNzKS/kMAoaOAug81fPsNhbtPlRBc1xQT5BPVhuY5EIW8YOnOGJs/pDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633514; c=relaxed/simple;
	bh=h92g/6S9MlLT97r+tVZ8qmPtJIxju0jPdq2wEd8Bqwg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nJWu/IQFYDe1DXBGWTMoIY97BZdqxOj/kwBT54owSX4u2sbjmGug55r946G4E5QIvsWhXvvnmAEoxcGb0q1EZB6cASxG/uFR6W/Oa2AaZ88RZdAVY887R7y3Xe8vuCXffT2mhYGdWktGTZZz+lkhKJ/tIXJufOcgZAc7MwGFov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=nnuYkOb8; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8643F100018;
	Thu, 28 Mar 2024 16:45:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8643F100018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711633508;
	bh=bxVgZki4tnU752Xc7UAMONAMGx/Fa1Rm1HjeoL827+Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=nnuYkOb8h3rQRJ3wZBkfT7Agyq9H1zrL42vxY4bPYIBeSThupI5mw5TIsX8i1uPCW
	 pZ1PmfBpvCnHtMN8CC6ScFTCSXgslj71rX1L1I70fwsDJ4THMf+ddUGFc0ODRaLu6m
	 U8jbZrrq7W16vC/btZekrgDYrWbeRSr1lHd+c8D0XaaLFvnYj9ETVff6ckTTW+cLmR
	 oCFht4mPqidD5yz/+t37ZYwsYHfA9lGertdrzrEEeJO52d6CWgVjNgACB7m4fKqtQc
	 p+lSYqrOIfSAREDw6kIcZpnb60EF0dhIonm4Nv64UgoYd+x9V25zSLdCFohTrD7UQj
	 OfJoRog7kyezA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 28 Mar 2024 16:45:08 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 16:45:07 +0300
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
Subject: [PATCH v1 0/3] arm64: dts: amlogic: a1: introduce thermal setup
Date: Thu, 28 Mar 2024 16:44:36 +0300
Message-ID: <20240328134459.18446-1-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/28 12:39:00
X-KSMG-LinksScanning: Clean, bases: 2024/03/28 12:39:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/28 10:33:00 #24492761
X-KSMG-AntiVirus-Status: Clean, skipped

This patch series introduces thermal sensor declaration to the Meson A1
common dtsi file. It also sets up thermal zones for the AD402 reference
board. It depends on the series with A1 thermal support at [1].

Links:
[1] - https://lore.kernel.org/all/20240328133802.15651-1-ddrokosov@salutedevices.com/

Dmitry Rokosov (3):
  arm64: dts: amlogic: a1: add cooling-cells for DVFS feature
  arm64: dts: amlogic: a1: introduce cpu temperature sensor
  arm64: dts: amlogic: ad402: setup thermal-zones

 .../arm64/boot/dts/amlogic/meson-a1-ad402.dts | 45 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     | 14 ++++++
 2 files changed, 59 insertions(+)

-- 
2.43.0


