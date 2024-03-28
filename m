Return-Path: <linux-kernel+bounces-123459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3128908ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAE91F26D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66BF1384A6;
	Thu, 28 Mar 2024 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="N6dgwb8q"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AC23D3B6;
	Thu, 28 Mar 2024 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653218; cv=none; b=iOcZvdLb8iCLGoZT/tyDByd6orHMewZuXLMzeRnAJVoDu8cCtlomU+iSfKGKluUkEHJJPiAnnbqOg2D2hmFWIer3BM7GkBmkeqV2Iu7i3zUwYxgLjipjMPjnJrAj84WgmFzhHEiEWdmGgPqCxHmlhf+dFr1UIj1P9qacSA7etWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653218; c=relaxed/simple;
	bh=rnSWslXWohvsbfuSkLuBUu1/TF9fW9a72TKkohDGhEU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qvLJvdNRTV7h4wSxKaGAJzom+E8/u98xUa0IxBlARlbO5BxyvfCvb+E4TaZQ1HgSdyd4u9ubXxZsswp4Uq2hbP0oHJGjsukOvnmGdaVyfGFjk2tGuF7ih61pEtFKRrx4I93GvrwpMtuQZBTOXW9hLJtwS4tR+atBlmYQGZbsl9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=N6dgwb8q; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 82B33120003;
	Thu, 28 Mar 2024 22:13:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 82B33120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1711653209;
	bh=JInZBtKkASoN1jfIy+D2n9+9WIjAH4zJOpdoFKT/o9s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=N6dgwb8qUyNXhkZD3Jyr958bqrEXqGa3Fqecuy3VA0XcXBO78XHQw1e8W3+x0goUD
	 mwWOy09wL8/lie3378OX6EUipQwKrRq9nebA+ZU3Ir+00Y2OtEYbBMT/ZbIrcrT+OM
	 fbiIUSCjCdiudGDqTBQl69caIkImIe9QhnSeYoioDf8bORB4TYE3/21a7f+OsqZuIW
	 5VzRwIY9K8oIcGXDxhwtDIhH/ZvV8U6j2bXCb0sdfBWnHgezi3xQjSBSWvECA+N91f
	 PLGW3lIXrIXI5xOUWwgCKr0WIOhDY+Lt4qxhgsfGq/ZkaugG9f4CElgKTAdBzc8463
	 ia9qTvX3ZajnA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 28 Mar 2024 22:13:29 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 22:13:28 +0300
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
Subject: [PATCH v2 0/2] thermal: amlogic: introduce A1 SoC family Thermal Sensor controller
Date: Thu, 28 Mar 2024 22:13:09 +0300
Message-ID: <20240328191322.17551-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
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
X-KSMG-AntiSpam-Lua-Profiles: 184477 [Mar 28 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;lore.kernel.org:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/28 18:21:00
X-KSMG-LinksScanning: Clean, bases: 2024/03/28 18:21:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/03/28 18:13:00 #24496606
X-KSMG-AntiVirus-Status: Clean, skipped

It is primarily based on the G12A thermal controller, with only a slight
variation in the offset value of the efuse parameters. Therefore, this
patch series provides appropriate platform data and dt-bindings to
ensure proper support.

Changes v2 since v1 at [1]:
    - provide Neil RvB
    - remove 'amlogic,a1-thermal' fallback, cause it's not needed

Links:
    [1] https://lore.kernel.org/all/20240328133802.15651-1-ddrokosov@salutedevices.com/

Dmitry Rokosov (2):
  dt-bindings: thermal: amlogic: add support for A1 thermal sensor
  thermal: amlogic: support A1 SoC family Thermal Sensor controller

 .../devicetree/bindings/thermal/amlogic,thermal.yaml | 12 +++++++-----
 drivers/thermal/amlogic_thermal.c                    | 10 ++++++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.43.0


