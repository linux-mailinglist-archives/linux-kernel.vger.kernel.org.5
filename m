Return-Path: <linux-kernel+bounces-158961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB1E8B2761
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC30B253F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3C51514E6;
	Thu, 25 Apr 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ORREfMPk"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5E414E2F7;
	Thu, 25 Apr 2024 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065193; cv=none; b=QIREEtsDhfTcRwWAAqGCOLeAocE5qlgrxaEJTVnCrVaXOMVLLnO9PugQ6H5NG5EzoVADBAK0MCWwSCKb4QU2Hv7TkYPYpWBnCX2Ub85uW/m6d54xHuYpwcd0Dgrwexr/XW0D8OMRFfC6RxM9sYsjz7xh7NRPAhG5b2YUag4lekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065193; c=relaxed/simple;
	bh=wyCx0FITpwp4glIQ6MUVGka31eqtr+ov+bKyWJRFq0E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fiYxdNxi+Emsae7DLhxEE07S66l5OxvuzFlsYbnI1zuoDUaQjGNbqTEJTN+80Q+lRNy+QgSPKszRrcMD67a5A6by7e78VgKx42gg3OeTFLr6YfeFFK7hN0vgA7alFcw4m8af0ZMNjQDCNzqOKPCMDZHpIx7cHcJ0PAb5Wi81feE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ORREfMPk; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B8DA612000A;
	Thu, 25 Apr 2024 20:13:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B8DA612000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1714065180;
	bh=wYm8pN+1CoBvKNj1w9JY3v9T8uYFYIB1Dq2+Zmhr2MM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ORREfMPkmA0Wgtmivtkg+frz3yhlTjoi0+atbo1fDIuChe6tjw4LWhe2HMY6luhsO
	 sfEyNxMNOLg9OA6q/SQu9XOzCHkbBMZ3cumhsCC3Yr6lWOcYWhpcbt4q59WwFKyfIB
	 RkbyiJcl/ebgGGBDCc7N9MYmh9jQVqsmjxaynT7IDEn3WtUFyshQBOugpuB15r+cjP
	 y56dpqXo+28Adz+jK3vJVkv5kzYNwDI2my7ERlNF8Q4EAoyDyoz6auLzOKYBGiaaAP
	 YiVPBfd1VKuxN31noe/VH34JdGF9y7I0PFim5tkavKnubxKT6p5J+MDm7hnR6bEyrj
	 N2r1laVzFFoag==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 25 Apr 2024 20:13:00 +0300 (MSK)
Received: from work.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Apr 2024 20:13:00 +0300
From: George Stark <gnstark@salutedevices.com>
To: <u.kleine-koenig@pengutronix.de>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <thierry.reding@gmail.com>,
	<hkallweit1@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH v3 0/3] meson pwm small fixes
Date: Thu, 25 Apr 2024 20:12:50 +0300
Message-ID: <20240425171253.2752877-1-gnstark@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 184930 [Apr 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/25 14:26:00
X-KSMG-LinksScanning: Clean, bases: 2024/04/25 09:59:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/25 14:02:00 #24969020
X-KSMG-AntiVirus-Status: Clean, skipped

Just some small fixes for meson pwm.

Changelog:
v1->v2:
  pwm: meson: Drop unneeded check in .get_state()
    - update commit message
    - drop Fixes tag. It's not actually a bug
    previous version: [1]

  pwm: meson: Add check for error from clk_round_rate()
    - update commit message
    - change unsigned long fin_freq; to long fin_freq;
    previous version: [2]

v2->v3:
  pwm: meson: Add check for error from clk_round_rate()
    - change format modifier in dev_dbg() for fin_freq var to %lu
    previous version: [3]

  pwm: meson: Use mul_u64_u64_div_u64() for frequency calculating
    new patch

[1] https://lore.kernel.org/lkml/20240423161356.2522636-2-gnstark@salutedevices.com/T/#m6d1d5cf100dc5b77f85e2a7d01c0b0097b6a04da
[2] https://lore.kernel.org/lkml/20240423161356.2522636-2-gnstark@salutedevices.com/T/#ma84e2d490bf79bda12f8393773c1af37b48d5473
[3] https://lore.kernel.org/linux-arm-kernel/20240424132408.2565916-1-gnstark@salutedevices.com/T/#m52b7e5a34c3e8907235d73c2827b92cb13c93dd3

George Stark (3):
  pwm: meson: Drop unneeded check in .get_state()
  pwm: meson: Add check for error from clk_round_rate()
  pwm: meson: Use mul_u64_u64_div_u64() for frequency calculating

 drivers/pwm/pwm-meson.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--
2.25.1


