Return-Path: <linux-kernel+bounces-123476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31258890935
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBBC2968DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0091384AB;
	Thu, 28 Mar 2024 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="n9yMInIB"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5749D3BBCA;
	Thu, 28 Mar 2024 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654018; cv=none; b=NhOJD6mcpuxy65JNdHsNIM1JSaB4m37vhWb0PzGuWNAp5kd4+ixwLg60L2ySaT61ipS7lIxLTqTOChE+1fCcWCey7V0w4ZZbrTvjJ09165JUqyXGb/VUPEd0u0Gh/9KbnDoNuGs7YdJEqjATH6sVUEYrWxxbBfxI4fx0itDN+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654018; c=relaxed/simple;
	bh=4IjQCbBX39x+rcMchxVSDV412sPV0FIRrFPhrOUu/CE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JdDcTJ12aoovtXHCToRWVRP4A1fzo5WplOEdjslnlkJ5KKt24pL+XGDESHtNUH+XwH3e0Sqe+qBeyY6j4fPHXNYxfwhwHIL7A8acD76vU/jugJsmZ12Pho6a39pNtvi5ZsjyWwD9rzRCG30CMyMFKa0eO9zHEF2ZJ24K8Nw4iQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=n9yMInIB; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id D295B10000A;
	Thu, 28 Mar 2024 22:26:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D295B10000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711654012;
	bh=4LvmixhzRlylWi1iASNzlMPPp0Wt/MZ3t6kmFoX+58E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=n9yMInIBxBcPBRiF4+4Gdh9/V5Ipq/YOieRDnLAUKG/MJyuG5cvYhD76q+0Lh2XPz
	 8U8cw1uIqHXXYo7hYGGTac1H2d47EJyO1JMuLLb/T5DtR6PM/Mc8+0dNBoIr1pUmcf
	 bDhrpCXDHpQYszKFJciUY+oNVPPKrxwF7MVfIwJIsp4tMYTJP7yR2p4pjYZO8dcgvP
	 NLUt26ORj2vdghSHQ7ANc7qH7Y0DAecsZ4GJYPKJPvU2tY9i8YQcW/iu4Kw4/aL3kP
	 Bye6D44IKNaG51hnne8I2nTGmeemzHHHJyjLKWIT7BvpBv/ydhkQv8ck6hQ/ypLbaz
	 cSqY20dKj8vGA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 28 Mar 2024 22:26:52 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 22:26:52 +0300
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
Subject: [PATCH v2 0/3] arm64: dts: amlogic: a1: introduce thermal setup
Date: Thu, 28 Mar 2024 22:26:34 +0300
Message-ID: <20240328192645.20914-1-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184477 [Mar 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/28 18:21:00
X-KSMG-LinksScanning: Clean, bases: 2024/03/28 18:21:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/28 18:13:00 #24496606
X-KSMG-AntiVirus-Status: Clean, skipped

This patch series introduces thermal sensor declaration to the Meson A1
common dtsi file. It also sets up thermal zones for the AD402 reference
board. It depends on the series with A1 thermal support at [1].

Changes v2 since v1 at [2]:
    - provide Neil RvB for cooling-cells dts patch
    - purge unnecessary 'amlogic,a1-thermal' fallback

Links:
[1] - https://lore.kernel.org/all/20240328191322.17551-1-ddrokosov@salutedevices.com/
[2] - https://lore.kernel.org/all/20240328134459.18446-1-ddrokosov@salutedevices.com/

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Dmitry Rokosov (3):
  arm64: dts: amlogic: a1: add cooling-cells for DVFS feature
  arm64: dts: amlogic: a1: introduce cpu temperature sensor
  arm64: dts: amlogic: ad402: setup thermal-zones

 .../arm64/boot/dts/amlogic/meson-a1-ad402.dts | 45 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     | 13 ++++++
 2 files changed, 58 insertions(+)

-- 
2.43.0


