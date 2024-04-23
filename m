Return-Path: <linux-kernel+bounces-155525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E538AF38E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60770B24759
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EA413D250;
	Tue, 23 Apr 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="GY608lPm"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F9113C66C;
	Tue, 23 Apr 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888628; cv=none; b=I4MhmZT4586qxyfYiRkScaLv0sgGJC/5n+nt6cb5V4wjQCuKiVaSAe2EdR+NHKRBJZ0/Of62yUnQnuj6oihQ/tEdBkKBfUJ1Jp3mN/FBd49DYvp5xKLQomWEtlX7Uj5OoCXb6M2Ujb2qbHH4OByxxse9M/bGAG7jEEXLTirSAQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888628; c=relaxed/simple;
	bh=hNKc7ExTFhMLywfIJP+PycIbALVManyLftM917gb0R4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nPIArIZ02j8wuWvH/uWU/B4Av0CtwpN8SUcZYdA5ZtkU/vGAuZKocrFckSH0ooqCZvlgMNtKELldjtMDwNNiNh5I24EaLuXYjaADvF/GCIt74YzT/wLsyB+fuR0gU2aSM43hO2oHEiy0alfPvX2AJkLPQm8C1n9jYB/2rID97qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=GY608lPm; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id E6D0010000F;
	Tue, 23 Apr 2024 19:10:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E6D0010000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713888616;
	bh=DVY98jI0X94wEfGtVnGL5e71u5Av+34StswLSdjKMcs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=GY608lPm+OHvHFn6oSpWz8Y24ZDsU/bVdrbNUGJwLp2XrP0Egsps38mdY3vX3vTMG
	 VflSktVIFX42pcUFHhsOpAYpbw3vHw1N07nTdEed5Ze24OTPYae2UE3IJPc0TeHZQw
	 pmbQocZN9cbm/+Vu3w5F8WQa8gBl50uYLrNDXIohoJ+xfIZgxU2JlSvhJCVwFV/Q3J
	 Jq2yBlayDc/sDu6oXasrfG5DMspxP+D9f8x0hBhMdJySpWz7Uh33uRssQK5hg72VI5
	 GZ4xEqmXgDuFlUtvdZLHVw5E9EDdRFC5mLDVQl7j1hF3FltqlUkNiSpPmo27ibCkbm
	 N7k3UeVkNg9PA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 23 Apr 2024 19:10:16 +0300 (MSK)
Received: from work.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Apr 2024 19:10:16 +0300
From: George Stark <gnstark@salutedevices.com>
To: <u.kleine-koenig@pengutronix.de>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <thierry.reding@gmail.com>,
	<hkallweit1@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>, George Stark
	<gnstark@salutedevices.com>
Subject: [PATCH 0/2] pwm: meson: add pwm support for A1
Date: Tue, 23 Apr 2024 19:10:04 +0300
Message-ID: <20240423161006.2522351-1-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184882 [Apr 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/23 04:11:00 #24934400
X-KSMG-AntiVirus-Status: Clean, skipped

Add support for Amlogic meson A1 SoC family PWM.

George Stark (2):
  dt-bindings: pwm: amlogic: Add new bindings for meson A1 pwm
  pwm: meson: support meson A1 SoC family

 .../devicetree/bindings/pwm/pwm-amlogic.yaml  |  2 ++
 drivers/pwm/pwm-meson.c                       | 35 +++++++++++++++++++
 2 files changed, 37 insertions(+)

--
2.25.1


