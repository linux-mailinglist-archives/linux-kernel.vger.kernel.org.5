Return-Path: <linux-kernel+bounces-107718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D98E8800B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1FCE283269
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A019582877;
	Tue, 19 Mar 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbOEhBTF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B165657B2;
	Tue, 19 Mar 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862193; cv=none; b=Ntxj/IvCJ/4B/MxQLk+1RC5hmsTBxFrsk6/edKy3l6p7X7xftY6lHj3ASLb81MO6az2k3g8aIjkFSrGsihucDfH0qpplBnM9f79YrF77Jt6bt9cRrOIyp7tIGAn43ZbDRjSON0649N8DcPaY2Ty7jbrePO+UbvbA9HACVKtv//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862193; c=relaxed/simple;
	bh=J6fbFW/hwqiA6LHzfsT/AMLYc+NWeHRMPXg1NtzMCYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjrRhTb7fdRNqg3pvlp6Kfk5brs3iqCTz/yez07tFir3cW4Xc0pUU7wlLwv+McOBrHzHZodC/SZnqJ9Zb86dFGcTYSjthP2DI8/CVvx55vvkAlwLThQvl535WkwEzF1/gMAyg2ZBfpu4wO0RQeKVWVzj51las6OGKWdn59epLE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbOEhBTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46972C43394;
	Tue, 19 Mar 2024 15:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710862193;
	bh=J6fbFW/hwqiA6LHzfsT/AMLYc+NWeHRMPXg1NtzMCYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbOEhBTFeXAdxstMkBJ6ztS1KBg2hbVkr5PS1mveNvUknB4WliWXG6r54oZ8u2Y4t
	 YXB8a6MQARRjjY50sYMvO0SZMWwxZ2sorrRV5coXKnQeeVQkyorbsGhFvAjLYjJUys
	 /QOtJWsU0TJHsMqb6aM11UJvBKkGEOHy5dd6D/MpBoZcoYwlqvalNXMvTbFj7jfG6t
	 nwuyHo//zrbWj9GZIhtoK3N7XBqSWOMrPpUgDSyotA8QmhVX2Xx34ISeISnzqaNuMq
	 RVrYI4bHdDhdQo1OUmCTK/sdjzBsXBJrN4V8Tvm2ODS/nQnVf2uloKt9jhSk12/BAS
	 J+GNgKQ1JEWCQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rmbPc-000000000LM-0CB1;
	Tue, 19 Mar 2024 16:30:00 +0100
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
	stable@vger.kernel.org
Subject: [PATCH v3 4/5] Bluetooth: qca: add workaround for broken address properties
Date: Tue, 19 Mar 2024 16:29:25 +0100
Message-ID: <20240319152926.1288-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240319152926.1288-1-johan+linaro@kernel.org>
References: <20240319152926.1288-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to a long-standing bug in the Qualcomm Bluetooth driver, the device
address has so far been reversed when configuring non-ROME controllers.
This, in turn, has led to one vendor reversing the address that the boot
firmware provides using the 'local-bd-address' devicetree property.

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
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

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


