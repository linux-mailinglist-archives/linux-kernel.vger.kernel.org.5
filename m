Return-Path: <linux-kernel+bounces-165973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 347028B9419
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2B628380B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375491F959;
	Thu,  2 May 2024 05:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AP7KFdSq"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8029A0;
	Thu,  2 May 2024 05:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714626290; cv=none; b=fK3CTIrQt7aQGkjDkO/RnIWJF+bIr+YAEGB/pTKkHlFavlYQXBsuBj771NkefrS35NaHXNmvHe4Bpc/EYEXU0KMtjf2lwLiD8v/vEmJkDmuhItX/+UIbd413pJ+jCvBG+b+FuDQdndovhObmGdyFJRZnc5QsEXwxVBhb+m6AJ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714626290; c=relaxed/simple;
	bh=T0bJ9f3B82LY+xAMn+qJU/gURZEvWNZXvg8QNzKqKbo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ayP4I8RDFhOmrFXiBJRwdqw3rXFTeE3CupaG5gE4DE/+F9Yj8yiNDudXJORUL403BfV0vWkNQsK2XK5aFW1b/5Ev/Z0TgYchNgFPNX83NQRrlu2fysT/Y5nDhH/S+WwjDymfx69AaBrRbZ9cCEToEq+lqXcBtc76GVv0ypKyI5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AP7KFdSq; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714626288; x=1746162288;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T0bJ9f3B82LY+xAMn+qJU/gURZEvWNZXvg8QNzKqKbo=;
  b=AP7KFdSqUM1pfZnGc6vGltehxhn7381aY3Y91BAvFJ3m6Z0d8lKZ8Ar5
   koZDzbd2ugSvQ1KQbokINeifmWwkiIzqDoTFAhYrVUuNnAy3iV9g/VpFa
   eqmxmA3fiVujHT+DjTJenIV86ti/m05qwq7Q9hLdCoTm92YQxFpM8F/s/
   7B19x/XRJhJVnnxZPPceXfIBbC1/poDT9ybQZyd6MAbc07kk6QbF3n84G
   arBW/xGitP8vRt6FaUSotY7WJHfVRmSQeSGSeioGpudjyrBwLIPLhg0Xj
   mHjF1m6bynIP4ID5xa4q9shC0bofIaX/JRnWyywkiZpLgl/RVdGCY789K
   g==;
X-CSE-ConnectionGUID: xcYhx9FVQj+dINQhEIwqNA==
X-CSE-MsgGUID: RbhUzTQ2TaCsK+d9AS+NDQ==
X-IronPort-AV: E=Sophos;i="6.07,247,1708412400"; 
   d="scan'208";a="190689575"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 May 2024 22:04:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 22:04:17 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 22:04:14 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH net-next v1] net: microchip: lan743x: Reduce PTP timeout on HW failure
Date: Thu, 2 May 2024 10:33:00 +0530
Message-ID: <20240502050300.38689-1-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The PTP_CMD_CTL is a self clearing register which controls the PTP clock
values. In the current implementation driver waits for a duration of 20
sec in case of HW failure to clear the PTP_CMD_CTL register bit. This
timeout of 20 sec is very long to recognize a HW failure, as it is
typically cleared in one clock(<16ns). Hence reducing the timeout to 1 sec
would be sufficient to conclude if there is any HW failure observed. The
usleep_range will sleep somewhere between 1 msec to 20 msec for each
iteration. By setting the PTP_CMD_CTL_TIMEOUT_CNT to 50 the max timeout
is extended to 1 sec.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_ptp.c | 2 +-
 drivers/net/ethernet/microchip/lan743x_ptp.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index 2801f08bf1c9..f8e840fd62cd 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -58,7 +58,7 @@ int lan743x_gpio_init(struct lan743x_adapter *adapter)
 static void lan743x_ptp_wait_till_cmd_done(struct lan743x_adapter *adapter,
 					   u32 bit_mask)
 {
-	int timeout = 1000;
+	int timeout = PTP_CMD_CTL_TIMEOUT_CNT;
 	u32 data = 0;
 
 	while (timeout &&
diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.h b/drivers/net/ethernet/microchip/lan743x_ptp.h
index e26d4eff7133..0d29914cd460 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.h
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.h
@@ -21,6 +21,7 @@
 #define LAN743X_PTP_N_EXTTS		4
 #define LAN743X_PTP_N_PPS		0
 #define PCI11X1X_PTP_IO_MAX_CHANNELS	8
+#define PTP_CMD_CTL_TIMEOUT_CNT		50
 
 struct lan743x_adapter;
 
-- 
2.25.1


