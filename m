Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1E27E0E70
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 09:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjKDI6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 04:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjKDI6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 04:58:46 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2071.outbound.protection.outlook.com [40.92.98.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A29CD5E;
        Sat,  4 Nov 2023 01:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAXFqqaQKZlOwgxfpQIAl8wokiiFAcwcFYz/JdyiULCDHGhQupClPtmsgPdFwKC8hpIao5YhdBmKt8uK8pcuCNEMN6qVp6eCW1pm8O6NT+i9e/Q2k6TcW1a06waFsjZe1enIF/PvrmlsaQlOrAANGAyJE/Hvu6XRBE+Rr7GHQDeCPsquj+KdlAvsWkOKBlokQzjQUmrSqkarrGheQxu5A8ma9Aq/+kGWB20zjPzPXQZtc/wFkvsZVDdY/IdeL/HcuWT9JZVGQIc62JKhV/glW42CUpqx8RMNoUR9eY9a2CjtT/O+Hs9JTwQqZ/D8r03OjdoB0mlONYQZI4RF9BOYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwS8nPnOJ+5jS0PMbXFmWbqshZAZOfUzT0xDR0HcJEg=;
 b=jib2spxuZuSPJdczWIZqCjPlFNBg7GnDC31ujxLLFRO7HzuXNE4bIjZj1AJVNrS/20S3fbL+awi+nRy69BBRaUDXNKG0ao5cgOefB/KQtTA4+db4lpqvrcaFTn7z80Jz6mYJqsYe6wF+WVb6kDa9zoII/e5a/oi27EGFKdBZsOWIbnk7NR+yO0g3kLwmiqNN5TTRAlVsGhlNfLb653TWF9MIjl1qt8d6T1BM2VvPP71JClxxghJcSOWN3G18BBNvQAd4xJLUeXrWF/Cg++Pm4lmMMHLUwlFZ0NVWyccPJdLycdfGICyLICE7c9Z2/1OZ/yK9ghHbS84F/YhW5cN9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwS8nPnOJ+5jS0PMbXFmWbqshZAZOfUzT0xDR0HcJEg=;
 b=ccK/7FpemXKfI0uYOBzL07CgdpGFQkXVqx6PdAUZ2opj0+g7XXSJUHKyQ/wUDJAUUcOzxkGXDDP8Q8VBOtCxh66uIsx44G1/Lj95jmmkA6isWagrqutyrJthIkVk2X0qEJrfnI4mc1+xHtoZ+PDO3iw0E4sxuOqcIAO2qRdO8h1f0X5EyWJHid0bNNgUNZgz5HDc9RmyubJXZ+ZUfpTXXa2kCQvTYQgsr/2QjmXShcrcPko10/HSpzIXDN3xf0x6x0VhgDMxibeoewjItmyuOHKxVokSU90aks7dr8NM3wklxn/fTjY+kBh+f1G6353n2BXAZtVgEhI4y91igE1HsQ==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB2289.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Sat, 4 Nov
 2023 08:58:18 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6954.025; Sat, 4 Nov 2023
 08:58:18 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>, Kalle Valo <kvalo@kernel.org>,
        linux-kernel@vger.kernel.org, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v2 1/3] wifi: rt2x00: introduce DMA busy check watchdog for rt2800
Date:   Sat,  4 Nov 2023 16:57:58 +0800
Message-ID: <TYAP286MB0315D7462CE08A119A99DE34BCA4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231104085800.17576-1-yangshiji66@outlook.com>
References: <20231104085800.17576-1-yangshiji66@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [OZ3VfvqeRrgmpwGHEbKHTDiCI+l7FTZZ]
X-ClientProxiedBy: TYCP301CA0090.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::17) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231104085800.17576-2-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB2289:EE_
X-MS-Office365-Filtering-Correlation-Id: e566895b-eae7-464c-06d4-08dbdd143042
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22og/CWJIZLfxjp9PUHjNpDFUtKzwVHzxDh4FJdhvNWr1eHCiZbAxoVi9Ay7lPPlfYQ6fEfcD+jqL3xQLylgBfjPU7R2NpNoH2WML9ByxsAcStb/5h/HOkC2X6Ye//uerMI+neSCJuQNvqSicAbwW8WuVfcw3ba1lfn8M3IWNeu5NKRvkPYsNjXZKRYiZG7y15akahjLVNUxc7Ngb4YYE0auaEw8WJYIqGGNrkrRTjuxxGzNVovbgHg9jVgHdVbSPMmElJIgEeYZymtSpakw9Z2yon5SSbUsKYYQ1Yb7PVgbmvRffaoBCLuHn6/zoivUSqN49jgtbrDG+VDboZDXFyR2qUi20wZcAvRj7muzgWTlcM9hyjOgE4cplT2h3usMjEGKj8Qec1MK/qkVR5QhazHj2P9ISFQo7xikvr3rb89hZOu3BnoqI8wKFTb+F8uLVj32e2VyLaHJ7a64g1tVhMtWDKWxBMCtnWhxFjAqkvGKxC6cx7u4r2XdxMaDBG8QKByIogr37gZKY+ah+GKB/Q3+GMSMYJb00/HtcbYWvlFBw4TnSn4Yn7N5zLTKq4U+PHd2imJO+lpSLETQ8r0Rc5rVIjcpTXPza9/W25gaqmTN0f9puKIi73A08AUyl8sn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tia7WVZAFpfI8GqeGmBhswhauwtgJ6pHCXy45UXI+cptdCWIQLMAoZPAIAaN?=
 =?us-ascii?Q?L14BY6N9H5cIyTiODogDmyHpkENMXzLZ0xkL2cwVcaIhCpUa8cRSYmGleUSt?=
 =?us-ascii?Q?LxCXouY8r21PnV2VN6OYI5uO2DWXv6ClrlTNxvzXto3JGptkAhdPXfb1ix5d?=
 =?us-ascii?Q?ttYqXCDiChB/1nS60RxXsnYE3V8FX0fuQUVqeLAHN7YHx8x/4q4em5K3QY+R?=
 =?us-ascii?Q?az/znZVGXU9y95rMXGFp8heYxa/V6hiRV+1HLineHHLkafQKywxI9e+pF85p?=
 =?us-ascii?Q?XTSXHqP712j3ATXjueVv4Y6JKUHVLWWdoCZNKdsa+proQESh7u2ZniOgmEMI?=
 =?us-ascii?Q?nQS5LsoTsPVo/N8PC27ef7TerW6fsAea7bvrkB0sddpRL3ghd+0v6N1TtsJX?=
 =?us-ascii?Q?Bg0bNxK0fo8J92dlUivVNssm66ZN040uzYQajMUSnjFlyokKwYB2u31iM9RP?=
 =?us-ascii?Q?qy2jQUFNWeiqh0EVv7wpxNMp5aH8SqoXdvCbQMp762Ix9mVW/g+fx1TH1Jqw?=
 =?us-ascii?Q?1HwCUGmG7VnqDuHM9pXtbewFsNYtW5fJIWDz09r8iy0nv3oMSPqlYFfHAmXH?=
 =?us-ascii?Q?ZePgDCxjj9nkdGIcmaECKv8Djfkblp0uV20YSPS/Be1nrzLWwTGaJc8NtkP3?=
 =?us-ascii?Q?smIKWvm+es8E3GlYjYrR+viMDz59D1C1UgdUJFztCJcmHvkVjk7tuDnw2UZf?=
 =?us-ascii?Q?+zD4stppI3/o/oG4wUMXqfy+7U5/2bv3SK/F/RpxlnDLVguJ7s31BDSg5Izl?=
 =?us-ascii?Q?K7bKfJbdBYb2GLdODQ8rg4+YcV0kkKbA1chjhtqsKKMjcrs2hP7/K33b8JOb?=
 =?us-ascii?Q?/aoRKrOJnSJYLaUPzJjSGngdeY0nJkm7Dr+YpVi8D0b3b6Rld6FpDZgoSPby?=
 =?us-ascii?Q?tCVJswSyKMpUe0vAV3/5fDvhxIlLuRNl2w9+aIdWlsD+XL4Z0MamamXDxPgl?=
 =?us-ascii?Q?TiQo5LVamfmubfzBfbL18KT1ezQHH67tmIEI3z6Pe3A9uLPpBhIyZ87L1VrP?=
 =?us-ascii?Q?oYH0dmdTVQp2QpjNmmpME3NuQxzFlwuwtsFl9XSINL65rL/pVplR45OgI6P/?=
 =?us-ascii?Q?iIquD/gW17an0KFM8uS6Y2KUb7O3QBQfNPd/K/2t8/y9wiiDX5Ibrm673Md3?=
 =?us-ascii?Q?/yCshYxH1+wwSKEdNawJ7RgUmBo+P9MCWn76TetxCYIEKGsI0V5E0cKqkzfg?=
 =?us-ascii?Q?nQ7AIyYxacYACZR6DwW8icBCF1/I/Azuhkd/1WVI2BcV5N8XurhXDtE6J7A?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e566895b-eae7-464c-06d4-08dbdd143042
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:58:18.5238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2289
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I tried to fix the watchdog of rt2800, I found that sometimes
the watchdog can not reset the hung device. This is because the
queue is not completely stuck, it just becomes very slow. The MTK
vendor driver for the new chip MT7603/MT7612 has a DMA busy watchdog
to detect device hangs by checking DMA busy status. This watchdog
implementation is something similar to it. To reduce unnecessary
reset, we can check the INT_SOURCE_CSR register together as I found
that when the radio hung, the RX/TX coherent interrupt will always
stuck at triggered state.

The 'watchdog' module parameter has been extended to control all
watchdogs(0=disabled, 1=hang watchdog, 2=DMA watchdog, 3=both). This
new watchdog function is a slight schedule and it won't affect the
transmission speed. So we can turn on it by default. Due to the
INT_SOURCE_CSR register is invalid on rt2800 USB NICs, the DMA busy
watchdog will be automatically disabled for them.

Tested on MT7620 and RT5350.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 drivers/net/wireless/ralink/rt2x00/rt2800.h   |  4 +
 .../net/wireless/ralink/rt2x00/rt2800lib.c    | 77 ++++++++++++++++---
 drivers/net/wireless/ralink/rt2x00/rt2x00.h   |  3 +
 3 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800.h b/drivers/net/wireless/ralink/rt2x00/rt2800.h
index 48521e455..8930589b4 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800.h
@@ -3194,4 +3194,8 @@ enum rt2800_eeprom_word {
  */
 #define BCN_TBTT_OFFSET 64
 
+/* Watchdog type mask */
+#define RT2800_WATCHDOG_HANG		BIT(0)
+#define RT2800_WATCHDOG_DMA_BUSY	BIT(1)
+
 #endif /* RT2800_H */
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 594dd3d9f..be4f7c144 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -30,9 +30,10 @@
 #include "rt2800lib.h"
 #include "rt2800.h"
 
-static bool modparam_watchdog;
-module_param_named(watchdog, modparam_watchdog, bool, S_IRUGO);
-MODULE_PARM_DESC(watchdog, "Enable watchdog to detect tx/rx hangs and reset hardware if detected");
+static unsigned int modparam_watchdog = RT2800_WATCHDOG_DMA_BUSY;
+module_param_named(watchdog, modparam_watchdog, uint, 0444);
+MODULE_PARM_DESC(watchdog, "Enable watchdog to recover tx/rx hangs.\n"
+		 "\t\t(0=disabled, 1=hang watchdog, 2=DMA watchdog(default), 3=both)");
 
 /*
  * Register access.
@@ -1260,15 +1261,12 @@ static void rt2800_update_survey(struct rt2x00_dev *rt2x00dev)
 	chan_survey->time_ext_busy += rt2800_register_read(rt2x00dev, CH_BUSY_STA_SEC);
 }
 
-void rt2800_watchdog(struct rt2x00_dev *rt2x00dev)
+static bool rt2800_watchdog_hung(struct rt2x00_dev *rt2x00dev)
 {
 	struct data_queue *queue;
 	bool hung_tx = false;
 	bool hung_rx = false;
 
-	if (test_bit(DEVICE_STATE_SCANNING, &rt2x00dev->flags))
-		return;
-
 	rt2800_update_survey(rt2x00dev);
 
 	queue_for_each(rt2x00dev, queue) {
@@ -1296,18 +1294,72 @@ void rt2800_watchdog(struct rt2x00_dev *rt2x00dev)
 		}
 	}
 
+	if (!hung_tx && !hung_rx)
+		return false;
+
 	if (hung_tx)
 		rt2x00_warn(rt2x00dev, "Watchdog TX hung detected\n");
 
 	if (hung_rx)
 		rt2x00_warn(rt2x00dev, "Watchdog RX hung detected\n");
 
-	if (hung_tx || hung_rx) {
-		queue_for_each(rt2x00dev, queue)
-			queue->wd_count = 0;
+	queue_for_each(rt2x00dev, queue)
+		queue->wd_count = 0;
+
+	return true;
+}
+
+static bool rt2800_watchdog_dma_busy(struct rt2x00_dev *rt2x00dev)
+{
+	bool busy_rx, busy_tx;
+	u32 reg_cfg = rt2800_register_read(rt2x00dev, WPDMA_GLO_CFG);
+	u32 reg_int = rt2800_register_read(rt2x00dev, INT_SOURCE_CSR);
+
+	if (rt2x00_get_field32(reg_cfg, WPDMA_GLO_CFG_RX_DMA_BUSY) &&
+	    rt2x00_get_field32(reg_int, INT_SOURCE_CSR_RX_COHERENT))
+		rt2x00dev->rxdma_busy++;
+	else
+		rt2x00dev->rxdma_busy = 0;
 
+	if (rt2x00_get_field32(reg_cfg, WPDMA_GLO_CFG_TX_DMA_BUSY) &&
+	    rt2x00_get_field32(reg_int, INT_SOURCE_CSR_TX_COHERENT))
+		rt2x00dev->txdma_busy++;
+	else
+		rt2x00dev->txdma_busy = 0;
+
+	busy_rx = rt2x00dev->rxdma_busy > 30 ? true : false;
+	busy_tx = rt2x00dev->txdma_busy > 30 ? true : false;
+
+	if (!busy_rx && !busy_tx)
+		return false;
+
+	if (busy_rx)
+		rt2x00_warn(rt2x00dev, "Watchdog RX DMA busy detected\n");
+
+	if (busy_tx)
+		rt2x00_warn(rt2x00dev, "Watchdog TX DMA busy detected\n");
+
+	rt2x00dev->rxdma_busy = 0;
+	rt2x00dev->txdma_busy = 0;
+
+	return true;
+}
+
+void rt2800_watchdog(struct rt2x00_dev *rt2x00dev)
+{
+	bool reset = false;
+
+	if (test_bit(DEVICE_STATE_SCANNING, &rt2x00dev->flags))
+		return;
+
+	if (modparam_watchdog & RT2800_WATCHDOG_DMA_BUSY)
+		reset = rt2800_watchdog_dma_busy(rt2x00dev);
+
+	if (modparam_watchdog & RT2800_WATCHDOG_HANG)
+		reset = rt2800_watchdog_hung(rt2x00dev) || reset;
+
+	if (reset)
 		ieee80211_restart_hw(rt2x00dev->hw);
-	}
 }
 EXPORT_SYMBOL_GPL(rt2800_watchdog);
 
@@ -12015,6 +12067,9 @@ int rt2800_probe_hw(struct rt2x00_dev *rt2x00dev)
 		__set_bit(REQUIRE_TASKLET_CONTEXT, &rt2x00dev->cap_flags);
 	}
 
+	/* USB NICs don't support DMA watchdog as INT_SOURCE_CSR is invalid */
+	if (rt2x00_is_usb(rt2x00dev))
+		modparam_watchdog &= ~RT2800_WATCHDOG_DMA_BUSY;
 	if (modparam_watchdog) {
 		__set_bit(CAPABILITY_RESTART_HW, &rt2x00dev->cap_flags);
 		rt2x00dev->link.watchdog_interval = msecs_to_jiffies(100);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index aaaf99331..62fed38f4 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -926,6 +926,9 @@ struct rt2x00_dev {
 	 */
 	u16 beacon_int;
 
+	/* Rx/Tx DMA busy watchdog counter */
+	u16 rxdma_busy, txdma_busy;
+
 	/**
 	 * Timestamp of last received beacon
 	 */
-- 
2.39.2

