Return-Path: <linux-kernel+bounces-158468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5643D8B2092
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78451B210B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F52312AADD;
	Thu, 25 Apr 2024 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UaC2S4av"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE401E497;
	Thu, 25 Apr 2024 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045400; cv=none; b=fg4RZoaZqU2Y+/vN9TxM9ljvvmLnBK0ouHNUTDswGTWz0ud19Ca768CYrAS14xoYIfWh93YEw9wHjYW/4cVRon5pGS8a4ijYFiacICfDhf5plFmSQDNk1yc8Jem31qZInPcsh3Xth76rq+P5nLahrWh+HM7sh+d2SaWJgFEtGOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045400; c=relaxed/simple;
	bh=r9iQCgsNre3zD/T+CXIOgTbGIYkjP59ItYR/6wtRGDE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vk16jhmV7m0kXOs9OtjooA+cSwORSe+hTAtC5mwuXKRMzHGyBr96rGYERNdRB+WS7gDJryomTOFb+/9ou6qQfCSYRKOp9oDLxbq5UsWiVcd/Pm4KdTi6oCDEI6pT71VQSikYw9X1dqk2541ZFNHTunEYe2IWOx8cTysj+KMJo8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UaC2S4av; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714045398; x=1745581398;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r9iQCgsNre3zD/T+CXIOgTbGIYkjP59ItYR/6wtRGDE=;
  b=UaC2S4avZrmuOk+wRRkCKNAIqWXgBBiGTvNb/lGjAGz6Y1jXyHQXi8qA
   8YGUIxZ04+py4TCmg0SmGSGm9a0yd6yOkZ+JnSpGJmDtR/YjnMdmPmRBJ
   cGArFt98NBMFs4lnOyHWw6jGl38cjCLFwMiXBP/1iLEuRWk22g13vOvLG
   VFxZ8ythAVJsj3HxhNlZCO11YFRZG9spvPa5KDmpgRPyTwxvXDKrJRKMi
   SUbPIx8AmJzL47dYzkBGDVJrkZuA7mO63nY1zEs+tVqKWYJk6inHKele5
   8aHaE+rxQeeodC2A+1U64EQNx0o1aCSA6tjsHbsvje/BBt3RSfNwZoZwr
   g==;
X-CSE-ConnectionGUID: qteOOrYnSzSrTY39UU9dBg==
X-CSE-MsgGUID: n5dJTltjRx+4BgqX4bl2Zg==
X-IronPort-AV: E=Sophos;i="6.07,229,1708412400"; 
   d="scan'208";a="22585804"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Apr 2024 04:43:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 04:42:36 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 04:42:34 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <lgirdwood@gmail.com>,
	<broonie@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<conor+dt@kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v1] iio: adc: PAC1934: fix accessing out of bounds array index
Date: Thu, 25 Apr 2024 14:42:32 +0300
Message-ID: <20240425114232.81390-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Marius Cristea <marius.cristea@microchip.com>

Fix accessing out of bounds array index for average
current and voltage measurements. The device itself has
only 4 channels, but in sysfs there are "fake"
channels for the average voltages and currents too.

Fixes: 0fb528c8255b: "iio: adc: adding support for PAC193x"
Reported-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 drivers/iio/adc/pac1934.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index f751260605e4..456f12faa348 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -787,6 +787,15 @@ static int pac1934_read_raw(struct iio_dev *indio_dev,
 	s64 curr_energy;
 	int ret, channel = chan->channel - 1;
 
+	/*
+	 * For AVG the index should be between 5 to 8.
+	 * To calculate PAC1934_CH_VOLTAGE_AVERAGE,
+	 * respectively PAC1934_CH_CURRENT real index, we need
+	 * to remove the added offset (PAC1934_MAX_NUM_CHANNELS).
+	 */
+	if (channel >= PAC1934_MAX_NUM_CHANNELS)
+		channel = channel - PAC1934_MAX_NUM_CHANNELS;
+
 	ret = pac1934_retrieve_data(info, PAC1934_MIN_UPDATE_WAIT_TIME_US);
 	if (ret < 0)
 		return ret;

base-commit: b80ad8e3cd2712b78b98804d1f59199680d8ed91
-- 
2.34.1


