Return-Path: <linux-kernel+bounces-67065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E7E8565B7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F019B2C240
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B796131E48;
	Thu, 15 Feb 2024 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GUjLhBLT"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B1912EBD4;
	Thu, 15 Feb 2024 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006466; cv=none; b=NfPZG1c6+X7YOs0+lWf5UCXMTIsIqRd3nSinoHtUHAyUw/7oj28bz7Kavv3x9dbdD75K9dxawnljwf+4tt5H+1trn1plTgZqzJz1v4qKX3AbFRQKYss6SIAoAWZgVrNgl1+tHbQ+em0oEN/TLnWBTQZOHc9pfvBZMvON5RGI6I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006466; c=relaxed/simple;
	bh=Pl94FX9jABh58putNDS5MTxIlDCKyQK+qGnIUegwhsA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l2z03Q/2i2YBX5nVYjOAnoquYT1+8cWK32HQEQE7GCtyjz+nbm15gA5+r2/o7S5FuNdPgMi4mk4kGc8n0ijUXw+8RNrDFZ/ODWfiJ5mo6Uu9itCdoA8TXpXBA5ZktEYjq7VUMUOIPPama7WImNN6uNp5mgJHvJShCM+xX6sQKcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GUjLhBLT; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3DEA6000B;
	Thu, 15 Feb 2024 14:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708006461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WjYKmqjE8TbHlo4ippGPCTLvH3WmrEy1f5h2gFbnQxY=;
	b=GUjLhBLTYqXDgdvnzkzqSEgpF1C7IhrPduA3SCbvsfG9GnS6NpozPAiQ4e8dRPZzJzVq/2
	5o+gyihQweXhFv8DOEem2fY45HfTu3OekiQcNTiGvMflsxE7gC/SL5LTYJuLPb5W4fYEg1
	6cHPl1Lp+CE4WFid1gT7oY2x9nVmBtl8vUjzHPco3WHm0XcYIg4t9Ga15BUQr/6NOKZcR/
	w1BzNyNq7PO83fQIprdZ4MyGyPnrYFJSTNaU5l3VhD+Duak53gyxVTKnBbykGxG9PLa9Dh
	jNkHqXigVd9GIDIeHLe0I2Tstxo82o66yv2F6NB/MzeDQOy5EaQ9SH1mPcQCWg==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH 0/2] wifi: nl80211/wilc1000: force WLAN_AKM_SUITE_SAE to
 big endian in NL80211_CMD_EXTERNAL_AUTH
Date: Thu, 15 Feb 2024 15:13:51 +0100
Message-Id: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB8czmUC/x2N0QqDMAxFf0XyvEJbFcVfGaMEm83gFkejIoj/v
 rCnw4HDvScoFSaFoTqh0M7Ki5iEWwXjhPIix9kcoo+Nj6Fx8u6NIT35SDh/km68kiaSzChCqi5
 2rcc2dxn7GmznW8ji/8f9cV0/roHNBXMAAAA=
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ajay Singh <ajay.kathat@microchip.com>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Igor Mitsyanko <imitsyanko@quantenna.com>, 
 Sergey Matyukevich <geomatsi@gmail.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

This small series is the follow-up to discussions started around a sparse
warning in wilc1000 driver ([1]) and implements the solution suggested by
Johannes. It moves a historically needed conversion to be32 in nl80211 (in
NL80211_CMD_EXTERNAL_AUTH, specifically on NL80211_ATTR_AKM_SUITES property
_only_ when it is set to WLAN_AKM_SUITE_SAE) The user scenario affected by
this update is a connect process on a WPA3-protected access point with
authentication offloaded to user-space. Two drivers are affected by the
update: wilc1000 and qtnfmac. wilc1000 case is handled by a small
companion patch which also fixes the sparse warning.

For the quantenna driver, I don't really get how it manipulates AKM suites.
The only thing it currently does on it before calling nl80211 is a
le32_to_cpu. IIUC the raw value (before applying le32_to_cpu) comes from
chip/firmware:
<interrupt>
 qtnf_shm_ipc_irq_handler
  <some callbacks chains>
   qtnf_pcie_control_rx_callback
    qtnf_trans_handle_rx_ctl_packet
     qtnf_trans_event_enqueue => queue skb to processing queue

qtnf_event_work_handler <= dequeue corresponding skb to process
 qtnf_event_process_skb
  qtnf_event_parse
   qtnf_event_handle_external_auth
    cfg80211_external_auth_request => sends NL80211_CMD_EXTERNAL_AUTH

There is no cast to big endian on AKM suite at any point in this chain, but
there are plenty of leXX_to_cpu, so I assume the chip/its firmware sends
its data in little endian. Then, since the be32 conversion is _needed_ with
current wpa_supplicant, I wonder if it works at all in current state, so I
did not modify it. Or has it been tested with another supplicant (iwd ?)
which handles WLAN_AKM_SUITE_SAE differently ? Opinions (and even some
testing) are welcome for this driver, since I do not have the corresponding
hardware.

[1] https://lore.kernel.org/linux-wireless/87a5uatfl1.fsf@kernel.org/

To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ajay Singh <ajay.kathat@microchip.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: <linux-wireless@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Igor Mitsyanko <imitsyanko@quantenna.com>
Cc: Sergey Matyukevich <geomatsi@gmail.com>

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Alexis Lothoré (2):
      wifi: nl80211: force WLAN_AKM_SUITE_SAE in big endian in NL80211_CMD_EXTERNAL_AUTH
      wifi: wilc1000: remove AKM suite be32 conversion for external auth request

 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  2 +-
 net/wireless/nl80211.c                             | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)
---
base-commit: a4c7842e88b0f7d937015e4588ea2a1dec33cf2c
change-id: 20240214-nl80211_fix_akm_suites_endianness-2750a5d7da83

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


