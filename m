Return-Path: <linux-kernel+bounces-106042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C075087E83E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79CF62822D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A143639AF2;
	Mon, 18 Mar 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cR/ElfzX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2026364BF;
	Mon, 18 Mar 2024 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760139; cv=none; b=nlSiremQ48t3lxbKb1+lkEB/V+hWuE9iLIMInBiQP4CPtCx4CrE76OxFf+aJy1kSKNtIx8fHCTepNMzyPSGrxWoeu23wHww/obCtWZV0qKOyd1JaSWC7ogr2qfm+e37ZuuF0TXAwkyLnPwmfVJCmdZ/rQmHvnfUoRfbiYdoALsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760139; c=relaxed/simple;
	bh=vFYxI/evLVZ5xnjJcv/HxjQrEpYkbG+SjslgqJGSw9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmMfZGRdFYBrGaUndz0SUDzQCfOj2wjqlsl/VMFVEkPWemKAiHZ3BUwaa4tWgyZHeyb4loJ3ZjWhsnedLGD06wARgO/e0JZtMp/+c6W+Crpu3wSd93fdTTzq0oAENMe1DKu0WmRi/bm0msK6c99sT/ANhLs7T9f/SmxOQF/Ln/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cR/ElfzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D12BC433B1;
	Mon, 18 Mar 2024 11:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710760139;
	bh=vFYxI/evLVZ5xnjJcv/HxjQrEpYkbG+SjslgqJGSw9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cR/ElfzXeQ5RfhRBRufwn/QdOag6NRNsRSMmdvp4OsBMEkQg194NAMaR2m0mPHUDs
	 wJkU0TxY95DRJ+IY7QKwzqchYsoXp5vVatMtvmOJfXw4VH7nB7V0z9RQv1RPPTmrQO
	 ftPgFbYGUIqzOVD6oIO0E8d4wdB0eyc59HM4pnhU5dqlfk9ZXpJ8Mw0luUmOHTJhLa
	 51ht3JXKgZXCEbsNTmtwBpR6Bq/eOILukrNVKEZe154dBlA5YwxpLHyzIhICsoHFq+
	 G0cPna4EHmvl6BcJbCn7fZUUzdzNdlMuIdJvgMrjDldD4BCb41QICj9y2yO2jhEuWc
	 fRqVfXQYGD68w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rmArY-000000008Jr-45VI;
	Mon, 18 Mar 2024 12:09:05 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Doug Anderson <dianders@google.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
Subject: [PATCH v2 4/4] Bluetooth: qca: fix wcn3991 'local-bd-address' endianness
Date: Mon, 18 Mar 2024 12:08:55 +0100
Message-ID: <20240318110855.31954-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240318110855.31954-1-johan+linaro@kernel.org>
References: <20240318110855.31954-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to a long-standing bug in the Qualcomm Bluetooth driver, the device
address has so far been reversed when configuring the controller.

This has led to one vendor reversing the address provided by the
boot firmware using the 'local-bd-address' devicetree property.

The only device affected by this should be the WCN3991 used in some
Chromebooks. The corresponding compatible string has now been deprecated
so that the underlying driver bug can be fixed without breaking
backwards compatibility.

Set the HCI_QUIRK_BDADDR_PROPERTY_BROKEN quirk for the deprecated
compatible string and add the new 'qcom,wcn3991-bt-bdaddr-le' string to
the match table for boot firmware that conforms with the binding.

Fixes: 7d250a062f75 ("Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC WCN3991")
Cc: stable@vger.kernel.org      # 5.10
Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f989c05f8177..346274fe66d8 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1904,6 +1904,16 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
+		if (soc_type == QCA_WCN3991) {
+			struct device *dev = GET_HCIDEV_DEV(hdev);
+
+			if (device_is_compatible(dev, "qcom,wcn3991-bt")) {
+				set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
+						&hdev->quirks);
+			}
+		}
+
 		hci_set_aosp_capable(hdev);
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
@@ -2597,6 +2607,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,wcn3988-bt", .data = &qca_soc_data_wcn3988},
 	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
 	{ .compatible = "qcom,wcn3991-bt", .data = &qca_soc_data_wcn3991},
+	{ .compatible = "qcom,wcn3991-bt-bdaddr-le", .data = &qca_soc_data_wcn3991},
 	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
 	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
 	{ .compatible = "qcom,wcn6855-bt", .data = &qca_soc_data_wcn6855},
-- 
2.43.2


