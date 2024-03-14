Return-Path: <linux-kernel+bounces-102984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A510A87B977
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4649CB212BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049CBEEC4;
	Thu, 14 Mar 2024 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWa0d2B6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404746BFB0;
	Thu, 14 Mar 2024 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405864; cv=none; b=Bgk3VgxBcF5GxJthJBHkNwHQqUas3yuP4p82UPkb9d556EEcDSuPZTkaY+v3dFKn39oDoywsakj9EylYYnyQShqDOl21V4LMexdXB93W+tHirCWTdZU4rPm8DZRDquG/RaPF5OczFYyHtAOAuH3okcwoaOdkSPPdflPCQAqL/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405864; c=relaxed/simple;
	bh=uSNcHIIId1vff+Z6jkp9+Or1QRrkRqNJmq6CkIrqNz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLFePV1wS9ItQlscZ/eieEvVR81ACMBJueBr48vk4LTKz6kVul+T3TaSO/Z3Mc5VBAD3vjEPwa7a28vDsK665W02dSu5NlxtK8Dirm+FncwPV1YIAhE1IgzpVT9X6pv+7KHVEAyN9wvFRs9YtZTJmgn71Fo2GiJO/Lpubo+pdXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWa0d2B6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B976BC43390;
	Thu, 14 Mar 2024 08:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710405863;
	bh=uSNcHIIId1vff+Z6jkp9+Or1QRrkRqNJmq6CkIrqNz4=;
	h=From:To:Cc:Subject:Date:From;
	b=sWa0d2B69HU838DVFqYwiWMd43Me6oefKCpIoV/aTpO4qcsoV9Z2vfTSFcKZT5lEc
	 5T16m3neAHoSoLGboTlcDnQFmDRNu8bQJceTaRStg+7doYye0FiPxW+/dDZw3HfhUA
	 tpYs6vrxV2d6gDrhMnX7asEoxfrK2+MdpHiZCEV2krv2USgeiP8m+LRXPSYUgFGovL
	 RNI1851G9Dp8MRnjdKLX05qDDXaEWAelTxMYd3X3n89TF6xxbvSr/nQJqqEiHpTvqm
	 0pRUSiFWW12KC9kfLR95TKaRYJ9Wp8TX+yU96p088dxsBirzO/DMirGI63gZuW5EFl
	 O76o4uRodvnUw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rkghT-000000000IM-2Vrj;
	Thu, 14 Mar 2024 09:44:31 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Subject: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"
Date: Thu, 14 Mar 2024 09:44:12 +0100
Message-ID: <20240314084412.1127-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 7dcd3e014aa7faeeaf4047190b22d8a19a0db696.

Qualcomm Bluetooth controllers like WCN6855 do not have persistent
storage for the Bluetooth address and must therefore start as
unconfigured to allow the user to set a valid address unless one has
been provided by the boot firmware in the devicetree.

A recent change snuck into v6.8-rc7 and incorrectly started marking the
default (non-unique) address as valid. This specifically also breaks the
Bluetooth setup for some user of the Lenovo ThinkPad X13s.

Note that this is the second time Qualcomm breaks the driver this way
and that this was fixed last year by commit 6945795bc81a ("Bluetooth:
fix use-bdaddr-property quirk"), which also has some further details.

Fixes: 7dcd3e014aa7 ("Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT")
Cc: stable@vger.kernel.org      # 6.8
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index edd2a81b4d5e..f989c05f8177 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -7,7 +7,6 @@
  *
  *  Copyright (C) 2007 Texas Instruments, Inc.
  *  Copyright (c) 2010, 2012, 2018 The Linux Foundation. All rights reserved.
- *  Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  *
  *  Acknowledgements:
  *  This file is based on hci_ll.c, which was...
@@ -1904,17 +1903,7 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-
-		/* Set BDA quirk bit for reading BDA value from fwnode property
-		 * only if that property exist in DT.
-		 */
-		if (fwnode_property_present(dev_fwnode(hdev->dev.parent), "local-bd-address")) {
-			set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
-			bt_dev_info(hdev, "setting quirk bit to read BDA from fwnode later");
-		} else {
-			bt_dev_dbg(hdev, "local-bd-address` is not present in the devicetree so not setting quirk bit for BDA");
-		}
-
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 		hci_set_aosp_capable(hdev);
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
-- 
2.43.2


