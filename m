Return-Path: <linux-kernel+bounces-60028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E5084FED9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821321F236E9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDDC18C27;
	Fri,  9 Feb 2024 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ZH6AOevf"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E753A7;
	Fri,  9 Feb 2024 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514117; cv=none; b=sCx+Es/tB2z+t3zFUtvgc/cTEvPlh+EtCEFo+3LibJQICGT+pEuh4Rto00yVMJD6l7644556oibd51JBzb9gT1uiY/5hPS14Rmd4j9r6IPmeqf7OjntZB6XX9LeAAqI5y/hbxSMcGwR9vhSlvER00GzpBTezsovW7CjlByES/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514117; c=relaxed/simple;
	bh=Qz1lsUVXCu4repeHzshFyEUOd9cHzoYBAcY+a/2BmJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M26kzXbo5PXn0i82iRJMSY2w9KBRl9NP4nGsbq2f2KRZ18cbAfPo3YSARbuzYP1dCOQgXcPtBUKPtgK8Z2Fj40Ms9cKhSX7kfjv6tVuTxJoBBTM9qEJeCbUjFRb93R3YFk+xl0CtfLHQ2GUgfIrWRTA10e4CjU0LA8qP+Xj5VJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ZH6AOevf; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 43968120003;
	Sat, 10 Feb 2024 00:28:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 43968120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1707514104;
	bh=dLmQ0i/jpUoW9BKIvHqBZWYTMFOGB89t6XHByYjn+Q8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ZH6AOevfVZ3AJKxqbu6FhgIDEdRjLVV9kowdaOV/THlihTRQYUIhlUCN8/0ohxiwF
	 PH76yZJcc3FCCKYgC5VKGBgCbN2wUc9fmgveZ2FqFr2Ib51qY+3Zs/5W7Eq8mMsC2t
	 S69kRTVSfuyzd31uGwliYDA1MZJ2B98bEMWlEIQ7UIGtAYDOD48DUbjSEUPGshJmE+
	 4J/szHV4Ta7msD2sySkIG78g9LeUkqdUoXgJQ3gzYi9H5WbKOUN35KHfXcLGsLbwQK
	 SDjVkYMLAZQm6kOp7Y0t1QWnYYxeQhUTJqsU9nahd+zwuzyqkJ+eYzOOdw7HssYJmd
	 ioKnZXeOi8Lng==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 10 Feb 2024 00:28:23 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 10 Feb 2024 00:28:23 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <adeep@lexina.in>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <conor+dt@kernel.org>
CC: <kernel@sberdevices.ru>, <sdfw_system_team@sberdevices.ru>,
	<rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v1 0/2] meson-axg: properly setup CPU power management
Date: Sat, 10 Feb 2024 00:28:04 +0300
Message-ID: <20240209212816.11187-1-ddrokosov@salutedevices.com>
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
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183341 [Feb 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/09 20:35:00 #23447606
X-KSMG-AntiVirus-Status: Clean, skipped

The Meson AXG leverages the SCPI ARM protocol for the management of CPU
power, thermal, and frequency. This series addresses several issues that
have impacted the functionality of the power_allocator thermal governor
and cpufreq cooling devices.

Dmitry Rokosov (2):
  arm64: dts: amlogic: axg: move cpu cooling-cells to common dtsi
  arm64: dts: amlogic: axg: initialize default SoC capacitance

 .../amlogic/meson-axg-jethome-jethub-j1xx.dtsi   | 16 ----------------
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi       |  8 ++++++++
 2 files changed, 8 insertions(+), 16 deletions(-)

-- 
2.43.0


