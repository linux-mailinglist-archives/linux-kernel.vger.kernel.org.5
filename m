Return-Path: <linux-kernel+bounces-130455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F24897869
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F921F285EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B54154430;
	Wed,  3 Apr 2024 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="D2vKj29w"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D599E153831;
	Wed,  3 Apr 2024 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169750; cv=none; b=iuvLlmbDzgwtohMArepeJMdbFUZehLig4CQErbPjJDziEk3HdI/xHHEyNEUrp/z/jesqVner9HqxX59ySiKlb4FFuupIURyfYjIkoy4hNWD3R8/zpRL+miEh00biJdkjVeGCF5ufFGCVy69gukNm1AyH5XETOGOoEi1kwghs/kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169750; c=relaxed/simple;
	bh=+02UOlVxnZuD45S1Qu1BKfAhKN1vNMYWnQum/WOH5qs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=UMd4Kmc5Hw+BpNrCCbyCvz/0EQYHUuwBFgYRPLbZ2ePnma83ym/rjWiFL+Cz2cjpI3h06OJaAIHr5A4qngzHeI9xUP/3vX7LorzGE753yACaDW+h3DqZQqZ472y00VQ7njDjb1s4V7NmmmnpacbcLCfJbOVOFOgWlJQEdD+SA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=D2vKj29w; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712169749; x=1743705749;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=+02UOlVxnZuD45S1Qu1BKfAhKN1vNMYWnQum/WOH5qs=;
  b=D2vKj29w+GQ9TMdo87rkriEi8aO8VqBuyw/3yGUQmuyoIETHEyXzWQ18
   Z0+pN/P/K8RBlkcxO1djchubxyjrcPO3XFy23Tu6da+OHYUGAnmaadY7/
   +P/qAHF7UQEZdFlu9xwZKts1fkK/Irxa2HsJ8YRi6M3ov9fge8xKUttrD
   9gc+AcgGIkjz0zkw7IF5iTzC+PGJRsCi2gxslS9+aC+ATCKu+0UQSQtEK
   td7fiIvt4p57QYki0q2nzhTsH9TPEh09Jdwt8Cpfu3DXTWtXi4cxKz6UR
   TJehXT5D0prCILlHmINMb8H3e2ca1IbNzEMWPL3Pm2rGSBI2bpmiQhfh0
   A==;
X-CSE-ConnectionGUID: dPETYnhxT5ynVvwtxb0tHQ==
X-CSE-MsgGUID: B98+knGLQoOSJwIb/rapIw==
X-IronPort-AV: E=Sophos;i="6.07,177,1708412400"; 
   d="scan'208";a="19360444"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2024 11:42:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 11:42:08 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 11:42:05 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next 0/3] Add support for flower actions mirred and
 redirect
Date: Wed, 3 Apr 2024 20:41:41 +0200
Message-ID: <20240403-mirror-redirect-actions-v1-0-c8e7c8132c89@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOWiDWYC/x3MQQqEMAxG4atI1gZqqaJeZXAh8VezsEpaBkG8+
 5RZvsX3HkowRaKxesjw1aRnLNHUFck+xw2sS2nyzgcXnOdDzU5jw6IGyTxLLiSxSOgGkbZv+46
 Kvgyr3v/zhyIyR9yZpvf9AcbXIORzAAAA
To: Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
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

Patch #1: adds support for 72-bit actions.
Patch #2: adds support for tc flower mirred action.
Patch #3: adds support for tc flower redirect action.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Daniel Machon (3):
      net: sparx5: support 72-bit VCAP actions
      net: sparx5: add support for tc flower mirred action.
      net: sparx5: add support for tc flower redirect action

 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   | 76 ++++++++++++++++++++++
 drivers/net/ethernet/microchip/vcap/vcap_api.c     | 12 ++++
 .../net/ethernet/microchip/vcap/vcap_api_client.h  |  2 +
 3 files changed, 90 insertions(+)
---
base-commit: 5fc68320c1fb3c7d456ddcae0b4757326a043e6f
change-id: 20240402-mirror-redirect-actions-cc469cc58586

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


