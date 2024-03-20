Return-Path: <linux-kernel+bounces-108578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC221880C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953401F23051
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CC53A1A2;
	Wed, 20 Mar 2024 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxRfRrdS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D329424;
	Wed, 20 Mar 2024 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710921499; cv=none; b=nIAoThuvOKpErKUUC5zcJlYAuNZk1Cti6joU5OgLhDFNYyt+Yn0VgXJPg3775aGkwdPv2FoQOvwuIdU6XiFBT2ijEEJ/Qpe1kI0fsFqwtfqeoi4q48SigQBIiSqgGxVIjj8we2BBUOuWNFzJxH0elqsOJXyJ5HM0KdX8qKd5daM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710921499; c=relaxed/simple;
	bh=C1RG275fn9xQtQpOn0JJPb4biy/sTALIc/k31KMVrzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AU+RHrTnDO7mJ/W68wEgCjZFEPUMbcO+wh+VhMbYbf2UNcdV/DVpOXtMv8hqHZZ/BgRl9KPSabR15nBIsnLSMEUyAhgoo5sYhxaZBexPQ0RN8HxymNwWOgI/jNdVEWUBTR+RKCGufERutEkeumIfO4hS86vUbMzNYi3V+jnrJSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxRfRrdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123CAC43399;
	Wed, 20 Mar 2024 07:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710921499;
	bh=C1RG275fn9xQtQpOn0JJPb4biy/sTALIc/k31KMVrzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxRfRrdSNN8lK3/F2XPyGySwbkYlfkf+PlhwU9xAdxtkJFdsgzBOWEimFvecJfH6l
	 2KKJBGlWd8ceHC6xjgsSBXtYwNrz3jBVsCI2SBuCdQjtibqsBSv6LriLGJpnX8SMAt
	 ha+wLtvTJvqCgtqRP4zCrsV8nUO/IBrSvv5OkvbU1yZquSZoOCokd52l5K+Qg+J8dw
	 JyMk72W5k2SGyb3gdj1mELPPJy+/QrqnWPopTszQhqJzZ/yvukY5WGjwJpUsrVNjbp
	 CcM2orjiNDk6Xx5chtHCIXKDc9KLEzANvpXC1I4ZknrSCx59yz6f4TscZLbcXxCCcs
	 jwMs2nmdROgeA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rmqq9-0000000029S-2OzU;
	Wed, 20 Mar 2024 08:58:25 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v4 4/4] Bluetooth: qca: fix device-address endianness
Date: Wed, 20 Mar 2024 08:55:54 +0100
Message-ID: <20240320075554.8178-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240320075554.8178-1-johan+linaro@kernel.org>
References: <20240320075554.8178-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetooth
device address in big-endian order when setting it using the
EDL_WRITE_BD_ADDR_OPCODE command.

Presumably, this is the case for all non-ROME devices which all use the
EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices which
use a different command and expect the address in little-endian order).

Reverse the little-endian address before setting it to make sure that
the address can be configured using tools like btmgmt or using the
'local-bd-address' devicetree property.

Note that this can potentially break systems with boot firmware which
has started relying on the broken behaviour and is incorrectly passing
the address via devicetree in big-endian order.

The only device affected by this should be the WCN3991 used in some
Chromebooks. As ChromeOS updates the kernel and devicetree in lockstep,
the new 'qcom,local-bd-address-broken' property can be used to determine
if the firmware is buggy so that the underlying driver bug can be fixed
without breaking backwards compatibility.

Set the HCI_QUIRK_BDADDR_PROPERTY_BROKEN quirk for such platforms so
that the address is reversed when parsing the address property.

Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device address")
Cc: stable@vger.kernel.org      # 5.1
Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Nikita Travkin <nikita@trvn.ru> # sc7180
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/btqca.c   |  8 ++++++--
 drivers/bluetooth/hci_qca.c | 10 ++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index b40b32fa7f1c..19cfc342fc7b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -826,11 +826,15 @@ EXPORT_SYMBOL_GPL(qca_uart_setup);
 
 int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 {
+	bdaddr_t bdaddr_swapped;
 	struct sk_buff *skb;
 	int err;
 
-	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6, bdaddr,
-				HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
+	baswap(&bdaddr_swapped, bdaddr);
+
+	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6,
+				&bdaddr_swapped, HCI_EV_VENDOR,
+				HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
 		bt_dev_err(hdev, "QCA Change address cmd failed (%d)", err);
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f989c05f8177..c73481c57741 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -225,6 +225,7 @@ struct qca_serdev {
 	struct qca_power *bt_power;
 	u32 init_speed;
 	u32 oper_speed;
+	bool bdaddr_property_broken;
 	const char *firmware_name;
 };
 
@@ -1842,6 +1843,7 @@ static int qca_setup(struct hci_uart *hu)
 	const char *firmware_name = qca_get_firmware_name(hu);
 	int ret;
 	struct qca_btsoc_version ver;
+	struct qca_serdev *qcadev;
 	const char *soc_name;
 
 	ret = qca_check_speeds(hu);
@@ -1904,6 +1906,11 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		if (qcadev->bdaddr_property_broken)
+			set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);
+
 		hci_set_aosp_capable(hdev);
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
@@ -2284,6 +2291,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	if (!qcadev->oper_speed)
 		BT_DBG("UART will pick default operating speed");
 
+	qcadev->bdaddr_property_broken = device_property_read_bool(&serdev->dev,
+			"qcom,local-bd-address-broken");
+
 	if (data)
 		qcadev->btsoc_type = data->soc_type;
 	else
-- 
2.43.2


