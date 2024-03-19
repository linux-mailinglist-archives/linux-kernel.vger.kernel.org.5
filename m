Return-Path: <linux-kernel+bounces-107714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A118800AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6B01C22A81
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767F5823D7;
	Tue, 19 Mar 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtd3eZol"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AAC24B33;
	Tue, 19 Mar 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862193; cv=none; b=GfpLlOSb8GTc4W3BPQywerqzvvEGbSJQqQltCxXCdrOVZe1RB3YhYamNf7hZEJCKRV/p02tbFTYk+3BBWFqHwahonlo5xoQnd2IbQNwQsLpfYREqPtASFtS3mnNJSYrs3d3vvncXehEWb0bedOutS+Rk+t3xG1ggJuA8DW+AcPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862193; c=relaxed/simple;
	bh=GlKb7exKEjnOBWdPf3Xo0Tq4lX2VT0Np+I2c1gOvVDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHOYdbeDfK4O76x3PcaF6jUQZzC9vkRoTnyfIVg8jGbXeTMSsaqIoDROdVQBZJd4eVcbLjyTTH8jDdk8ngACFKKiaqWrpx358N1/p8RpztKL0sjUicQwzoUKVRLFTTPfpzS7nmHKvoxKb3Fd08kf6qJ6Po65F5+xe0IDpLiRweA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtd3eZol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445CAC43390;
	Tue, 19 Mar 2024 15:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710862193;
	bh=GlKb7exKEjnOBWdPf3Xo0Tq4lX2VT0Np+I2c1gOvVDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rtd3eZolOpnk+hy4zpiZ1Mz3ZZpaLFJeIV1tvkRAq2x6GEdU6V6OAAaYgoqmWgcJ0
	 GkEjU2OYG88xD2TXL7Re5tZhjrDwkBxHWUXrsE+inxaGWXsgHCh7g8+ZngnqZBx6hj
	 jGXoiIljP7qlQmRRnuM04O0+JPTv1hvEYchak6Y5keMzuDjn4HhPSmMY95HEtm7hjC
	 lQCrV/6K/V0xF2b01kGaNHjaOb0ttyHJprgGjycsOapYSEXC9tig+wkrSvLxjxF+bK
	 Sn7KcattZWiUTIXug2bvSgiEnahFUY5Hf6vt1CtQ0COi4n500+jC+Y7JB7u+r9Tpj3
	 FowITlqeA7n7g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rmbPb-000000000LI-3dbm;
	Tue, 19 Mar 2024 16:29:59 +0100
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
Subject: [PATCH v3 2/5] Bluetooth: add quirk for broken address properties
Date: Tue, 19 Mar 2024 16:29:23 +0100
Message-ID: <20240319152926.1288-3-johan+linaro@kernel.org>
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

Some Bluetooth controllers lack persistent storage for the device
address and instead one can be provided by the boot firmware using the
'local-bd-address' devicetree property.

The Bluetooth devicetree bindings clearly states that the address should
be specified in little-endian order, but due to a long-standing bug in
the Qualcomm driver which reversed the address some boot firmware has
been providing the address in big-endian order instead.

Add a new quirk that can be set on platforms with broken firmware and
use it to reverse the address when parsing the property so that the
underlying driver bug can be fixed.

Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device address")
Cc: stable@vger.kernel.org      # 5.1
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 include/net/bluetooth/hci.h | 9 +++++++++
 net/bluetooth/hci_sync.c    | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index bdee5d649cc6..191077d8d578 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -176,6 +176,15 @@ enum {
 	 */
 	HCI_QUIRK_USE_BDADDR_PROPERTY,
 
+	/* When this quirk is set, the Bluetooth Device Address provided by
+	 * the 'local-bd-address' fwnode property is incorrectly specified in
+	 * big-endian order.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
+
 	/* When this quirk is set, the duplicate filtering during
 	 * scanning is based on Bluetooth devices addresses. To allow
 	 * RSSI based updates, restart scanning if needed.
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5716345a26df..283ae8edc1e5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3215,7 +3215,10 @@ static void hci_dev_get_bd_addr_from_property(struct hci_dev *hdev)
 	if (ret < 0 || !bacmp(&ba, BDADDR_ANY))
 		return;
 
-	bacpy(&hdev->public_addr, &ba);
+	if (test_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks))
+		baswap(&hdev->public_addr, &ba);
+	else
+		bacpy(&hdev->public_addr, &ba);
 }
 
 struct hci_init_stage {
-- 
2.43.2


