Return-Path: <linux-kernel+bounces-132584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565768996DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F241F22315
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DE813E412;
	Fri,  5 Apr 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="C8iLZcm8"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA15013D601;
	Fri,  5 Apr 2024 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303158; cv=none; b=OW60alDTRbCkxl6lHEGpDMr0WAObwrf1pHix2TFkTLAiWGp/yqtfKwOje6yibRo8IjEma2pygg2SYtNIRIVZ9Rui+VW0Iq6oQNTvmiHNsY11LTKUpePxM84BLjiKfGt02F1+S4+QmNTYV3wmvLTKS5OmlXJjv2OBochpXGYX/Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303158; c=relaxed/simple;
	bh=1ZDpfD3a7RKRHSzvUXknQC7JfUb0EeRAFmr7HaGNp/o=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=PBmc00OJo9R5TwLPjKl4w+ArT3joSOopwMAc7ipWRJOSKV3AcWUdZV5aXpGXVt9OfSTsJyX5433WEY4kBCiiP7IrKrOfBf61CWBwn1osej/eHhdqT3i2ThxnW2AnCRbk0H0qy00sVOmGiDxsYRMxE0xB6B4GuYaKMy4sltDCB/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=C8iLZcm8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712303157; x=1743839157;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=1ZDpfD3a7RKRHSzvUXknQC7JfUb0EeRAFmr7HaGNp/o=;
  b=C8iLZcm86fGH+YItlDduL3fgCedtW+DakpMZKJ+fJIJE+bEA7RRdk09s
   SqGTDod12h1DM74XxArsVmB8TfnTxuaV0Uf36JLX8uTnygCJfh/y0+PsN
   Zil+I4Px5OEX1nWrT8UjTeV6MJV5743hghkGtq2Dc5BNX7VVfvqYN45TW
   9bgHHAckGCWckD0RJLKrMKDxOf3dnoox8noavqR6Sc0+abuTsmWdkf2na
   rP9tZpX3wHSFI1olN2fmUNsKIVnPX0C6ZfJ7BiEQkP+LWBbZZxsYQUiMl
   77RzYz8JsmP1M/hhmxZq8J/XbcV7aJ8jS/QM0HEsXfJ7PWkcZGR2xv3pn
   Q==;
X-CSE-ConnectionGUID: 4qZUTU13T9uNgS2+V4FJcw==
X-CSE-MsgGUID: iW+rMIoVTuCswnVlz6AsWg==
X-IronPort-AV: E=Sophos;i="6.07,180,1708412400"; 
   d="scan'208";a="250415236"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2024 00:45:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 00:45:03 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 00:45:00 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next v2 0/2] Add support for flower actions mirred and
 redirect
Date: Fri, 5 Apr 2024 09:44:48 +0200
Message-ID: <20240405-mirror-redirect-actions-v2-0-875d4c1927c8@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPCrD2YC/3WNywqDMBBFf0Vm3SkxPhq76n8UFzJO6yxMZBLEI
 v57g3Tb5eFyzt0hsgpHuBc7KK8SJfgM9lIATYN/M8qYGayxtamNxVlUg6LyKMqUcKCUlYhEdds
 RNa5xLWR7UX7Jdpaf4Dmh5y1Bn5dJYgr6OS/X8tx/9epvfS3RIDm+kSsrS657zEIaaJLlSmGG/
 jiOL7BiBU3MAAAA
To: Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Ratheesh Kannoth <rkannoth@marvell.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Daniel Machon <daniel.machon@microchip.com>
X-Mailer: b4 0.14-dev

================================================================================
Add support for tc flower actions mirred and redirect.
================================================================================

This series adds support for the two tc flower actions mirred and
redirect. Both actions are implemented by means of a port mask and a
mask mode. The mask mode controls how the mask is applied, and together
they are used by the switch to make a forwarding decision. Both actions
are configurable via the IS0 or IS2 VCAP's (ingress stage 0 and 2,
respectively).

Patch #1: adds support for tc flower mirred action.
Patch #2: adds support for tc flower redirect action.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v2:
- Squash patch #1 and #2 from previous version, to silence the false
  positive NIPA warnings.
- Return directly from vcap_rule_add_action_u72() in *_mirred() and
  *_redirect()
- Link to v1: https://lore.kernel.org/r/20240403-mirror-redirect-actions-v1-0-c8e7c8132c89@microchip.com

---
Daniel Machon (2):
      net: sparx5: add support for tc flower mirred action.
      net: sparx5: add support for tc flower redirect action

 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   | 68 ++++++++++++++++++++++
 drivers/net/ethernet/microchip/vcap/vcap_api.c     | 12 ++++
 .../net/ethernet/microchip/vcap/vcap_api_client.h  |  2 +
 3 files changed, 82 insertions(+)
---
base-commit: 5fc68320c1fb3c7d456ddcae0b4757326a043e6f
change-id: 20240402-mirror-redirect-actions-cc469cc58586

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


