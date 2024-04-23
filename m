Return-Path: <linux-kernel+bounces-155532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0758AF3A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BCAAB23B70
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2361D13CFBE;
	Tue, 23 Apr 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="CzFXzTBn"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105B13CA9A;
	Tue, 23 Apr 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888848; cv=none; b=RNjuSu3skiq0xqrcQKZEcjRe1UmYuQcTqVxQUluvVnL4JSA2ltkwoJk03R+UdnJgzS/XepO262W0sBnD2mjXVYkL4xcr0ymsbGsR6csg0VNj9IwCF4/ITRJCH6EdS5/8FKZl6rcPyzzD02kEiMkh6wPp3495lYIjd3rcqiUIAug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888848; c=relaxed/simple;
	bh=1M0zjEi/7fjsN5QHwlX6mde0ElagEfbuxivmVUwHLf0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZbzLos7tr0fKAhxZ5gCzf0A2evJduzGMwAxWX+EN2bT7pgJ6cGPKcbbx5WGgFd+vtY3EFI0RyynTovfz2zC5hWy9jQ+8SCJqY693eZPZW8r4CC1WJ/jvcHARz5qljFQJALUhxaKsrOZ4DLtSK6s2ZjJe+aUdtI7rTV0AHKBEgMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=CzFXzTBn; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B12D712000D;
	Tue, 23 Apr 2024 19:14:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B12D712000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1713888844;
	bh=ro/U3Qx6b5YUrNBUIBbRznelxtgGj/fcTpCvx0y5DV8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=CzFXzTBn43Y3lSBFff/H6nT5o5xEj82KuduPqDRT3B4zh8l4bP+P3g8HAeYwxNZvN
	 8bFwLwUB99SOivaeg2UAWB76cm3T+R/L2c3VIIBdO8i9ggjWPc+FgIAlNYe6PN9BE2
	 Ww1Zxy+nVwVs5LvSyHZlW3rR5zsH5MkVLILVtpUeRBb0dq8QBLzhi272jc/XOawIOV
	 3JX9tlhR9JKJVDcnQvM9V9XaHtL2VDgRCxtiQoLT2Fd2G2ohY8tjCL/SRlZmEJYZco
	 E2MDHxxIYp3Y29liy+L22Y7eB1zh96qbpcu/Kjlm+KvIAWf3Ts1GIPkwPn0KE2737H
	 DxxLvRBwLJPig==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 23 Apr 2024 19:14:04 +0300 (MSK)
Received: from work.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Apr 2024 19:14:04 +0300
From: George Stark <gnstark@salutedevices.com>
To: <u.kleine-koenig@pengutronix.de>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <thierry.reding@gmail.com>,
	<hkallweit1@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH 0/2] meson pwm small fixes
Date: Tue, 23 Apr 2024 19:13:54 +0300
Message-ID: <20240423161356.2522636-1-gnstark@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184882 [Apr 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/23 04:11:00 #24934400
X-KSMG-AntiVirus-Status: Clean, skipped

Just some small fixes for meson pwm.

George Stark (2):
  pwm: meson: drop unneeded check in get_state callback
  pwm: meson: add check for error from clk_round_rate()

 drivers/pwm/pwm-meson.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--
2.25.1


