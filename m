Return-Path: <linux-kernel+bounces-14660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0649682206E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34731F23002
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525AE156E6;
	Tue,  2 Jan 2024 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="nmZbjt0X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mxe.seznam.cz (mxe.seznam.cz [77.75.78.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3305F156E0;
	Tue,  2 Jan 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Received: from email.seznam.cz
	by smtpc-mxe-54579945bb-pxvlm
	(smtpc-mxe-54579945bb-pxvlm [2a02:598:128:8a00::1000:527])
	id 72f428d68c009a7c727aa6ce;
	Tue, 02 Jan 2024 18:31:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
	s=szn20221014; t=1704216700;
	bh=Xx0LeTeIW32q/hCd9KIFcqfXL/LqFY+MNCe/80cec9I=;
	h=Received:From:To:Subject:Date:Message-Id:Mime-Version:X-Mailer:
	 Content-Type:Content-Transfer-Encoding;
	b=nmZbjt0XpO4vNUIGqkICThigSStuTvgWxkjB+SIraTiS+BJ7tzrxJ4aYUfcojHS8J
	 Tg0c2J9jP+EJ9VHprk7Zzh2f5HT18Qd68T58R4ApyXsFBi2taJIeFARX/lAzlScXPR
	 GDVCMy4rSDsX5vz3SD31AGyexc4IWDCieGtRD8IKxXrhB/FGRRo2n7vpaxJ7Vsk+Nq
	 7riL4Y3RCCiGFat7M61I5uUjDpY87tJw5oikArKQFgNAlbYF2P1Pgoycm3hGXTpfv4
	 WDpCL/KX1yCPax/5BgNEdWm/tAII1vtd/e5gCepdBadV5CrhpcQaawoHtcn88orHkI
	 LTYG0oZvxdcpQ==
Received: from 184-143.gtt-net.cz (184-143.gtt-net.cz [82.144.143.184])
	by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
	Tue, 02 Jan 2024 18:30:02 +0100 (CET)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: "Kalle Valo" <kvalo@kernel.org>,
	"Jeff Johnson" <quic_jjohnson@quicinc.com>,
	<ath10k@lists.infradead.org>,
	<linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: ath10k: add hw_params for Atheros QCA9377-7
Date: Tue, 02 Jan 2024 18:30:02 +0100 (CET)
Message-Id: <BBi.ZZQl.2U1cEGGzeXI.1bb4WQ@seznam.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (szn-mime-2.1.33)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add hw_params for modules based on Atheros QCA9377-7 chipset.

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 drivers/net/wireless/ath/ath10k/core.c | 42 +++++++++++++++++++++++++++++=
+++++
 drivers/net/wireless/ath/ath10k/hw.h   |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless=
/ath/ath10k/core.c
index 6cdb225..cb33c93 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -615,6 +615,48 @@ static const struct ath10k_hw_params ath10k_hw_params=
_list[] =3D {
 	},
 	{
 		.id =3D QCA9377_HW_1_1_DEV_VERSION,
+		.dev_id =3D QCA9377_1_1_DEVICE_ID,
+		.bus =3D ATH10K_BUS_USB,
+		.name =3D "qca9377 hw1.1 usb",
+		.patch_load_addr =3D QCA9377_HW_1_0_PATCH_LOAD_ADDR,
+		.uart_pin =3D 6,
+		.otp_exe_param =3D 0,
+		.channel_counters_freq_hz =3D 88000,
+		.max_probe_resp_desc_thres =3D 0,
+		.cal_data_len =3D 8124,
+		.fw =3D {
+			.dir =3D QCA9377_HW_1_0_FW_DIR,
+			.board =3D QCA9377_HW_1_0_BOARD_DATA_FILE_USB,
+			.board_size =3D QCA9377_BOARD_DATA_SZ,
+			.board_ext_size =3D QCA9377_BOARD_EXT_DATA_SZ,
+		},
+		.rx_desc_ops =3D &qca988x_rx_desc_ops,
+		.hw_ops =3D &qca6174_ops,
+		.hw_clk =3D qca6174_clk,
+		.target_cpu_freq =3D 176000000,
+		.decap_align_bytes =3D 4,
+		.spectral_bin_discard =3D 0,
+		.spectral_bin_offset =3D 0,
+		.vht160_mcs_rx_highest =3D 0,
+		.vht160_mcs_tx_highest =3D 0,
+		.n_cipher_suites =3D 8,
+		.ast_skid_limit =3D 0x10,
+		.num_wds_entries =3D 0x20,
+		.target_64bit =3D false,
+		.rx_ring_fill_level =3D HTT_RX_RING_FILL_LEVEL,
+		.shadow_reg_support =3D false,
+		.rri_on_ddr =3D false,
+		.hw_filter_reset_required =3D true,
+		.fw_diag_ce_download =3D false,
+		.credit_size_workaround =3D false,
+		.tx_stats_over_pktlog =3D false,
+		.dynamic_sar_support =3D false,
+		.hw_restart_disconnect =3D false,
+		.use_fw_tx_credits =3D true,
+		.delay_unmap_buffer =3D false,
+	},
+	{
+		.id =3D QCA9377_HW_1_1_DEV_VERSION,
 		.dev_id =3D QCA9377_1_0_DEVICE_ID,
 		.bus =3D ATH10K_BUS_SDIO,
 		.name =3D "qca9377 hw1.1 sdio",
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/a=
th/ath10k/hw.h
index 9643031..f5e6f8a 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -29,6 +29,7 @@ enum ath10k_bus {
 #define QCA9888_2_0_DEVICE_ID	(0x0056)
 #define QCA9984_1_0_DEVICE_ID	(0x0046)
 #define QCA9377_1_0_DEVICE_ID   (0x0042)
+#define QCA9377_1_1_DEVICE_ID   (0x9378)
 #define QCA9887_1_0_DEVICE_ID   (0x0050)
 
 /* QCA988X 1.0 definitions (unsupported) */
@@ -121,6 +122,7 @@ enum qca9377_chip_id_rev {
 /* QCA9377 1.0 definitions */
 #define QCA9377_HW_1_0_FW_DIR          ATH10K_FW_DIR "/QCA9377/hw1.0"
 #define QCA9377_HW_1_0_BOARD_DATA_FILE "board.bin"
+#define QCA9377_HW_1_0_BOARD_DATA_FILE_USB "board-usb.bin"
 #define QCA9377_HW_1_0_PATCH_LOAD_ADDR	0x1234
 
 /* QCA4019 1.0 definitions */
-- 
2.7.4


