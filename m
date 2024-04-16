Return-Path: <linux-kernel+bounces-146107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 686008A60CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE1F28177E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18564111A1;
	Tue, 16 Apr 2024 02:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Fe/UVHFZ"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2085.outbound.protection.outlook.com [40.92.107.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95821097B;
	Tue, 16 Apr 2024 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233592; cv=fail; b=uwwQ0On0P4zy8CcphtmHPXgzwo7hJ616wjwb1fCzsgP00ixfLJIbbwgo+04wHUQ7PC2PhUdUPSQHc+ZfaNDYAY/iUTNITh+ko/JP4cHniaozIiThI3qDeeupaYRsZbNdGVRnyZoTUW3Os00csrxSPY8c91fty9VQJocZRk1WPXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233592; c=relaxed/simple;
	bh=NHXiNIS4SV+N3FIj8fzVb2/lualN7izIdYHoiES3N18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hIsp1S/Yw53j7VvotPpkS1/Q7kfEgT6awUE22/AQVPasWw5umb4rAnXqdvQDSSsh4Pk1SAyJ6i2gQBhlnDwlDitFuH+burO1Xl/4kcfPAQfC0t4/790KUfLTDPcst7Em4MQrBcUTlrwE1pAjNR+DU7/VZLJ+SwP+iXTQWnJTV3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Fe/UVHFZ; arc=fail smtp.client-ip=40.92.107.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMmknd7JBbjCT4Qnmdpx8xMoRjfStYBIfRW6QyZ1spFcyNIGiRiXBkYXetnGSxlfYcNjD6+sOy9X3x0ZrhVCsW5uOwF0J30bvHlhDgVqpFrp+8QgEgfwIikbgB0C4vx/f5lg2tqv2kkUKGu8+ktX3WnJwqCYF+QPX7TrFaF435+QZbAgRjCDiyAgrcjNQHtaMlz3egEW5t86AvOVP7wXpxyHCcmrCksMHfj+O8R9Uv4PYbI6xzc0u5pIKbMGCQES0toIwUx6iwALp/6cJ/ZZExjmhEwnVn1Y79W3XJ1JkTBrxdJQbf/aEEp2bBrgxTdngYftwNyli1m0+JTqs8EHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCOj7uV9ms03Ow1RoUlRpVuhMHp2LsgloqSeKq63ceQ=;
 b=n20Ihuu809tHGAf2nE390Rc4bRMD0A9OP0d2eYen8SXxZ7+Ft+6TR8c04MwnT/vyFoQ7enqkGCZD4vcSc7EUt6bITpXmcFI4FZWIUjNa5+Vedcu4rcqYLV8yPWSM2lIsFEyRt2VWxiQM2FfWGY46aQ3u6z4lOd9AtMldY0lkJ5dSC6Tc9EUagsTgdMI2nlVFxTliiNGdqgabM61BzdKyKQLBbCTYQnNH2ObOwbbN1anOIpiMxKU72bUNB8ukMGgqvnTAf2GIMYN5GEdhSFFT/wydE5dcL5Q3N1yPL36G6vCeaLV+tvM7PzPtGzGFlzoItAe4thGZFwPETUgPIx+FRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCOj7uV9ms03Ow1RoUlRpVuhMHp2LsgloqSeKq63ceQ=;
 b=Fe/UVHFZtrnBrjrsI6Uha4hYFLcupybw/QKVDQZEXenn9RVTJPWGTZc1mcu7/Pk/VIZA2iSymp+okOwg2ToY8r3KK4WaN7/7IYKKQKWt9eSpq3aAEmrmu6ixtQfp5VY4uufq1xx34fCm96frkRJUl8LWUVGzfnn+V6fNYEPfQqOhMPAqUWAZ4n76V/P3HYgSs8Xqyqk2hudiqIytMY1CKdJHd/ypvGNzNZSjm6JULP4QMpyNJCOtLl3Zfe8st9hupVaguDJLKqJDo5wqbWBWZHkofbTa0iZcwrrYLWmPvOUoo8kYZL/AkpAtutfZi0FFW3pT7w0kCqt6+00m0NRg+w==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by TYZPR06MB5323.apcprd06.prod.outlook.com (2603:1096:400:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 02:13:07 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 02:13:07 +0000
From: Allen_Lin <allencl_lin@hotmail.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Allen_Lin <allencl_lin@hotmail.com>
Subject: [PATCH v3 3/4] HID: Add DRM panel follower function
Date: Tue, 16 Apr 2024 10:12:27 +0800
Message-ID:
 <TY0PR06MB5611DF036ADAD02BA8B4E0049E082@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416021228.1092678-1-allencl_lin@hotmail.com>
References: <20240416021228.1092678-1-allencl_lin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [uaiYKQzXt5GGVkD4tHBvzjDJMJPLlpYX]
X-ClientProxiedBy: PS2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::14) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <20240416021228.1092678-4-allencl_lin@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|TYZPR06MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: c28d2106-b3c2-417b-9b90-08dc5dbac176
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XVZiwgpwR7piUQZvv7CJy9aC+KoGYxhmwE928vne1rCxlIEpZ5UGkXWsvlPHNge5PCliXjA2/qv4UJp27RYdCyaUF/ap0ZiOmQFAmHpVXmkkVdB+B8y2msc/V0spXYdpUZN+eUxW1WAslihu6hWVeh5DlNC+I/3YiusxyvYvYr2S+OqC5Cj/HwL6N5fiQV8z1ra/I4hV7RaVUk2mtSHERYN+xA72ivdjTuHHOQn4+6VjKsP51jrgMQfzWFN3dCCxhiY273K/QNvY7+ZaLBzuJD+uqqJ30WrQ8VxuRjBexhIdfrSLu8ogONTbGxqrfVIBBa7KyYeonf246411JHvswjSude0KN46ky+w0GpPHG7gp8JsRC/beUP3B07aSyrTuL0swb9SAvFrsg1NIqK5C00pzwoqvPXl8z3MA13lJ7+xDyCNSAymQU5JAfeTWONGNs8jkG3X3lUDIAGi7zUXFvVDL0BRwcFTSQolDA76OZTtzCRu9hlsiTNc+r4Jh0HrolCXKpMuTssJia+qdwTA65aQ8NJ6q9SR0aF1pmvPMYkCfX03qWTU5jywxF8/jBqleDIYW/jhVw/Djh8fFF6eQioZiPWjRD6CjH3rLUNW3raVOqPwZ/N+/7p7glDq1nYSQUoEeo19Cl5P6GKiSsTfFtpbjGoQe09C/K3b5lIv7Ega1PbBLmdeyguANGbWZQGeSAHV7YT8u7vFIJTG0ZVZLjs6RssH4evXC57U/o6QTzsaUBpdf2MXNb7ODLaYlBjn/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0xAAnr/5AAK7NVWUcJBm5UrqjksDsvWDNa+WF8IPSbc/ILZFepKxVcWVs6Wu?=
 =?us-ascii?Q?ctNIac5sMRWebQg+W1UANHfgENA286n9KZAWB2HpZtQmI8zHXK6rHko4b7ZY?=
 =?us-ascii?Q?h1lcrcb6JyLU7RqxGkuBJRRtmIvb6f4nJLYnMwlIJcRYAwQVkghCqyraTFyu?=
 =?us-ascii?Q?uAPX43YS0KKmfDb6FiDuSdnXb1blwHUmyWR2ac6eTBpqOmOg1PdxIgdwObwZ?=
 =?us-ascii?Q?4EjzkSPTYq4no2YUlE7HN+VhH3Vy7wYsv21CJjR4T3vhQlN3IO7csK74ZIDv?=
 =?us-ascii?Q?KteHhFZNDeGnEO85Up3MoWOGlXHuid6TKpBpWx/rySjrTq7/irg4A+fFCGIk?=
 =?us-ascii?Q?oxDh5fLw/gegha3DtqU/mKaEJtNWOFKkkfK2GzcxuYNPMKh4b63nYV98Qm/r?=
 =?us-ascii?Q?X7aW5FLrmHWVFUI9fwKHKN3QOyvMqcW+emQwpcaa08lfwyItvRI80M0YsAb9?=
 =?us-ascii?Q?6eprLDu9/yE7ia4zgObUY0eo20ECSXuPjSfVtqxhLRkiKHoJu/YZCZlZAEH9?=
 =?us-ascii?Q?7a6jMTnNeXkpAjy8EsGOYHIErcNHr7qY+upFFCIoJGR2N7dGQpVsVTrEAOhD?=
 =?us-ascii?Q?arZ6abwncxsTqh4tEUZrNMjKUxo8sn6aaZTZ7QN2tELgTxFhcRJlLyv+re8o?=
 =?us-ascii?Q?nvUfzWm7gDpHAM5cHt6KdqUQhrEXE6BngP3pd196Gtmr1F8b07jmFpwLsxos?=
 =?us-ascii?Q?n3EhMs/2nFEJAdxSnZmJUFfJSINoYbtAGKKJ1gdru1ZNoGNdg07BL5g0tSvm?=
 =?us-ascii?Q?juDV3RFb6qKiualNn20DuvgiNMHolMPC40UYR8AINzJtQkfgHzl2bPIIQepO?=
 =?us-ascii?Q?hfsBx3CUtgU+MIx9/+zjRYhwTD+24YmlWCvcaSNURM0Ppx2HvrxpkDGmcDSw?=
 =?us-ascii?Q?iEOO0/t1OV2tGT+3ZE1MprISzSw7Jg/NuwmD3kX7tuJKER6QPlSrzN/AGkIP?=
 =?us-ascii?Q?O7wsq8UD0plf9T2e/I5Ys9h0/+SO1M+63s8ucAOsq86RJyi06OvRt0036KCz?=
 =?us-ascii?Q?H+Qv4OqHDlQ32C380KbYcpOHrYFrfyAtMZ2NrP53q+tSWkb6sGPJ4JEd1N2r?=
 =?us-ascii?Q?Td0upNjACv3/r6m4eTu2de4neGDZw41R+uPVXwQglSTM61WODlssd2Pa/ukM?=
 =?us-ascii?Q?BQ2+c6zBE1JzmciWlyCB4PZ102lzSusHFAMMoLmc4IPBH8JZgmD59iRi+s1q?=
 =?us-ascii?Q?SQM3z0LuDufVuFgdZlJndLOGAdLkSrL0fAJ77mbY9JwK9Y3WC4gScx6cKr07?=
 =?us-ascii?Q?LNPNm9qo2zR+PDHFoqnT?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c28d2106-b3c2-417b-9b90-08dc5dbac176
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 02:13:07.3755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5323

Add DRM panel follower[1] to trigger suspend/resume due to TDDI nature,
TP need to follow panel power sequence.

[1]:
https://lore.kernel.org/all/20230727171750.633410-1-dianders@chromium.org

Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
---
 drivers/hid/hid-himax.c | 292 +++++++++++++++++++++++++++++++++++++---
 drivers/hid/hid-himax.h |  10 ++
 2 files changed, 286 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-himax.c b/drivers/hid/hid-himax.c
index f8a417e07f0c..7b0ee48acfae 100644
--- a/drivers/hid/hid-himax.c
+++ b/drivers/hid/hid-himax.c
@@ -8,6 +8,7 @@
 #include "hid-himax.h"
 
 static int himax_chip_init(struct himax_ts_data *ts);
+static int himax_platform_init(struct himax_ts_data *ts);
 static void himax_ts_work(struct himax_ts_data *ts);
 
 /**
@@ -1145,7 +1146,6 @@ static int himax_hid_probe(struct himax_ts_data *ts)
 
 	hid = ts->hid;
 	if (hid) {
-		dev_warn(ts->dev, "%s: hid device already exist!\n", __func__);
 		hid_destroy_device(hid);
 		hid = NULL;
 	}
@@ -1501,6 +1501,154 @@ static int himax_load_config(struct himax_ts_data *ts)
 	return -EINVAL;
 }
 
+/**
+ * himax_ap_notify_fw_suspend() - Notify the FW of AP suspend status
+ * @ts: Himax touch screen data
+ * @suspend: Suspend status, true for suspend, false for resume
+ *
+ * This function is used to notify the FW of AP suspend status. It will write
+ * the suspend status to the DSRAM and read the status back to check if the
+ * status is written successfully. If IC is powered off when suspend, this
+ * function will only be used when resume.
+ *
+ * Return: None
+ */
+static void himax_ap_notify_fw_suspend(struct himax_ts_data *ts, bool suspend)
+{
+	int ret;
+	u32 retry_cnt;
+	const u32 retry_limit = 10;
+	union himax_dword_data rdata, data;
+
+	if (suspend)
+		data.dword = cpu_to_le32(HIMAX_DSRAM_DATA_AP_NOTIFY_FW_SUSPEND);
+	else
+		data.dword = cpu_to_le32(HIMAX_DSRAM_DATA_AP_NOTIFY_FW_RESUME);
+
+	for (retry_cnt = 0; retry_cnt < retry_limit; retry_cnt++) {
+		ret = himax_mcu_register_write(ts, HIMAX_DSRAM_ADDR_AP_NOTIFY_FW_SUSPEND,
+					       data.byte, 4);
+		if (ret) {
+			dev_err(ts->dev, "%s: write suspend status failed!\n", __func__);
+			return;
+		}
+		usleep_range(1000, 1100);
+		ret = himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_AP_NOTIFY_FW_SUSPEND,
+					       rdata.byte, 4);
+		if (ret) {
+			dev_err(ts->dev, "%s: read suspend status failed!\n", __func__);
+			return;
+		}
+
+		if (rdata.dword == data.dword)
+			break;
+	}
+}
+
+/**
+ * himax_resume_proc() - Chip resume procedure of touch screen
+ * @ts: Himax touch screen data
+ *
+ * This function is used to resume the touch screen. It will call the
+ * himax_ap_notify_fw_suspend() to notify the FW of AP resume status.
+ *
+ * Return: None
+ */
+static void himax_resume_proc(struct himax_ts_data *ts)
+{
+	himax_ap_notify_fw_suspend(ts, false);
+}
+
+/**
+ * himax_chip_suspend() - Suspend the touch screen
+ * @ts: Himax touch screen data
+ *
+ * This function is used to suspend the touch screen. It will disable the
+ * interrupt and set the reset pin to activate state. Remove the HID at
+ * the end, to prevent stuck finger when resume.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_chip_suspend(struct himax_ts_data *ts)
+{
+	himax_int_enable(ts, false);
+	gpiod_set_value(ts->pdata.gpiod_rst, 1);
+	himax_power_set(ts, false);
+	himax_hid_remove(ts);
+
+	return 0;
+}
+
+/**
+ * himax_chip_resume() - Setup flags, I/O and resume
+ * @ts: Himax touch screen data
+ *
+ * This function is used to resume the touch screen. It will set the resume
+ * success flag to false, and disable reset pin. Then call the himax_resume_proc()
+ * to process detailed resume procedure.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_chip_resume(struct himax_ts_data *ts)
+{
+	if (himax_power_set(ts, true))
+		return -EIO;
+	gpiod_set_value(ts->pdata.gpiod_rst, 0);
+	himax_resume_proc(ts);
+	himax_hid_probe(ts);
+	himax_int_enable(ts, true);
+
+	return 0;
+}
+
+/**
+ * himax_suspend() - Suspend the touch screen
+ * @dev: Device structure
+ *
+ * Wrapper function for himax_chip_suspend() to be called by the PM or
+ * the DRM panel notifier.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_suspend(struct device *dev)
+{
+	struct himax_ts_data *ts = dev_get_drvdata(dev);
+
+	if (!ts->initialized) {
+		dev_err(ts->dev, "%s: init not ready, skip!\n", __func__);
+		return -ECANCELED;
+	}
+	himax_chip_suspend(ts);
+
+	return 0;
+}
+
+/**
+ * himax_resume() - Resume the touch screen
+ * @dev: Device structure
+ *
+ * Wrapper function for himax_chip_resume() to be called by the PM or
+ * the DRM panel notifier.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_resume(struct device *dev)
+{
+	int ret;
+	struct himax_ts_data *ts = dev_get_drvdata(dev);
+
+	if (!ts->initialized) {
+		if (himax_chip_init(ts))
+			return -ECANCELED;
+	}
+
+	ret = himax_chip_resume(ts);
+	if (ret < 0)
+		dev_err(ts->dev, "%s: resume failed!\n", __func__);
+
+	return ret;
+}
+
 /**
  * himax_chip_init() - Initialize the Himax touch screen
  * @ts: Himax touch screen data
@@ -1531,6 +1679,130 @@ static int himax_chip_init(struct himax_ts_data *ts)
 	return 0;
 }
 
+/**
+ * __himax_initial_power_up() - Initial power up of the Himax touch screen
+ * @ts: Himax touch screen data
+ *
+ * This function is used to perform the initial power up sequence of the Himax
+ * touch screen for DRM panel notifier.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int __himax_initial_power_up(struct himax_ts_data *ts)
+{
+	int ret;
+
+	ret = himax_platform_init(ts);
+	if (ret) {
+		dev_err(ts->dev, "%s: platform init failed\n", __func__);
+		return ret;
+	}
+
+	ret = hx83102j_chip_detect(ts);
+	if (ret) {
+		dev_err(ts->dev, "%s: IC detect failed\n", __func__);
+		return ret;
+	}
+
+	ret = himax_chip_init(ts);
+	if (ret) {
+		dev_err(ts->dev, "%s: chip init failed\n", __func__);
+		return ret;
+	}
+	ts->probe_finish = true;
+
+	return 0;
+}
+
+/**
+ * himax_panel_prepared() - Panel prepared callback
+ * @follower: DRM panel follower
+ *
+ * This function is called when the panel is prepared. It will call the
+ * __himax_initial_power_up() when the probe is not finished which means
+ * the first time driver start. Otherwise, it will call the himax_resume()
+ * to performed resume process.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_panel_prepared(struct drm_panel_follower *follower)
+{
+	struct himax_platform_data *pdata =
+		container_of(follower, struct himax_platform_data, panel_follower);
+	struct himax_ts_data *ts = container_of(pdata, struct himax_ts_data, pdata);
+
+	if (!ts->probe_finish)
+		return __himax_initial_power_up(ts);
+	else
+		return himax_resume(ts->dev);
+}
+
+/**
+ * himax_panel_unpreparing() - Panel unpreparing callback
+ * @follower: DRM panel follower
+ *
+ * This function is called when the panel is unpreparing. It will call the
+ * himax_suspend() to perform the suspend process.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_panel_unpreparing(struct drm_panel_follower *follower)
+{
+	struct himax_platform_data *pdata =
+		container_of(follower, struct himax_platform_data, panel_follower);
+	struct himax_ts_data *ts = container_of(pdata, struct himax_ts_data, pdata);
+
+	return himax_suspend(ts->dev);
+}
+
+/* Panel follower function table */
+static const struct drm_panel_follower_funcs himax_panel_follower_funcs = {
+	.panel_prepared = himax_panel_prepared,
+	.panel_unpreparing = himax_panel_unpreparing,
+};
+
+/**
+ * himax_register_panel_follower() - Register the panel follower
+ * @ts: Himax touch screen data
+ *
+ * This function is used to register the panel follower. It will set the
+ * pdata.is_panel_follower to true and register the panel follower.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_register_panel_follower(struct himax_ts_data *ts)
+{
+	struct device *dev = ts->dev;
+
+	ts->pdata.is_panel_follower = true;
+	ts->pdata.panel_follower.funcs = &himax_panel_follower_funcs;
+
+	if (device_can_wakeup(dev)) {
+		dev_warn(ts->dev, "Can't wakeup if following panel");
+		device_set_wakeup_capable(dev, false);
+	}
+
+	return drm_panel_add_follower(dev, &ts->pdata.panel_follower);
+}
+
+/**
+ * himax_initial_power_up() - Initial power up of the Himax touch screen
+ * @ts: Himax touch screen data
+ *
+ * This function checks if the device is a panel follower and calls
+ * himax_register_panel_follower() if it is. Otherwise, it calls
+ * __himax_initial_power_up().
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int himax_initial_power_up(struct himax_ts_data *ts)
+{
+	if (drm_is_panel_follower(ts->dev))
+		return himax_register_panel_follower(ts);
+	else
+		return __himax_initial_power_up(ts);
+}
+
 /**
  * himax_platform_deinit() - Deinitialize the platform related settings
  * @ts: Pointer to the himax_ts_data structure
@@ -1660,25 +1932,13 @@ static int himax_spi_drv_probe(struct spi_device *spi)
 	ts->initialized = false;
 	ts->ic_boot_done = false;
 
-	ret = himax_platform_init(ts);
-	if (ret) {
-		dev_err(ts->dev, "%s: platform init failed\n", __func__);
-		return ret;
-	}
-
-	ret = hx83102j_chip_detect(ts);
+	ret = himax_initial_power_up(ts);
 	if (ret) {
-		dev_err(ts->dev, "%s: IC detect failed\n", __func__);
-		return ret;
+		dev_err(ts->dev, "%s: initial power up failed\n", __func__);
+		return -ENODEV;
 	}
 
-	ret = himax_chip_init(ts);
-	if (ret < 0)
-		return ret;
-	ts->probe_finish = true;
-
 	return ret;
-	himax_platform_deinit(ts);
 }
 
 /**
diff --git a/drivers/hid/hid-himax.h b/drivers/hid/hid-himax.h
index 26b47be49714..45dc3e6283ae 100644
--- a/drivers/hid/hid-himax.h
+++ b/drivers/hid/hid-himax.h
@@ -8,6 +8,7 @@
 #ifndef __HID_HIMAX_83102J_H__
 #define __HID_HIMAX_83102J_H__
 
+#include <drm/drm_panel.h>
 #include <linux/delay.h>
 #include <linux/hid.h>
 #include <linux/interrupt.h>
@@ -69,6 +70,11 @@
 #define HIMAX_AHB_CMD_INCR4				0x10
 #define HIMAX_AHB_CMD_INCR4_ADD_4_BYTE			0x01
 #define HIMAX_AHB_CMD_LEAVE_SAFE_MODE			0x0000
+/* DSRAM flag addresses */
+#define HIMAX_DSRAM_ADDR_AP_NOTIFY_FW_SUSPEND		0x10007fd0
+/* dsram flag data */
+#define HIMAX_DSRAM_DATA_AP_NOTIFY_FW_SUSPEND		0xa55aa55a
+#define HIMAX_DSRAM_DATA_AP_NOTIFY_FW_RESUME		0x00000000
 /* hx83102j-specific register/dsram flags/data */
 #define HIMAX_HX83102J_REG_ADDR_TCON_RST		0x80020004
 /* hardware register addresses */
@@ -219,13 +225,17 @@ struct himax_hid_desc {
 
 /**
  * struct himax_platform_data - Platform data holder
+ * @is_panel_follower: Is panel follower enabled
  * @vccd_supply: VCCD supply
+ * @panel_follower: DRM panel follower
  * @gpiod_rst: GPIO reset
  *
  * This structure is used to hold the platform related data.
  */
 struct himax_platform_data {
+	bool is_panel_follower;
 	struct regulator *vccd_supply;
+	struct drm_panel_follower panel_follower;
 	struct gpio_desc *gpiod_rst;
 };
 
-- 
2.34.1


