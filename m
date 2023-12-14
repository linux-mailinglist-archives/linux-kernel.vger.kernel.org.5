Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEF281363D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjLNQ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjLNQ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:29:19 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F247112;
        Thu, 14 Dec 2023 08:29:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaYnODPS5xUWoXI1a4DTIUpf7Z2rK28FYHWfBbt9bKbJzNsvdaJB4+/Zh0SSD0pgPN7wUsw/qT+NBN7evLGtu0qNc1eCyG/xh1L+53ClXKGQdnEP45omkCnn9xH1faKv8+lHMMrLg7caXkiNZ4NGfllXzYNyet33vB3rE0LH2ypBfdNN/Gl/Gu5ijwmWH8Kz2v7Ur2IEE0tqU7d2DfhjtW02XuDmlcm3zLkqa1XDY5ZOWhY0XyFhcKVCVBE63Uq36a46KsOxC00UNJbVHwAQqnk/LRW+TO6lZ/NLpCDHIA5z+ORKRlrNPOb/rUSJhHi6ZJYksplQ4ZN6X6lavVJNQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cfnz/JgogGoqHnZ/PtMvlHqKqWdKHhhucVx4GLaQzVM=;
 b=KmXg1p+ysLO05n4NLaV/ntJ9gr0PMT5Y3VKGnvOx+4PqlGK2XfBkk9OZ8hqFRE103lol6m+HzNTZgNZXRRDi+YhbROFUuoTAwlqf1VQlhmJ+Gfv2murwzqnVky3qtkE7IfkJkhJ1+2sH80tbk0GjrM7jUANCz3Od3LyHRPlgUSqrAjockKu0pyEky0kiRk72B/sQ6fQqp56ZXqBmujvlJztdooOwzdxK+Xfm6E+srVqKf85LuQdkH0OfsTF+iZ/M6wZmhYyqNidO5cGU/GojQJQQgt8wShdyENvfySd5yjaRLOdLp2/Mra2Lt3x9pJu5dY+RqyFZQKLzD1i/I/HmCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cfnz/JgogGoqHnZ/PtMvlHqKqWdKHhhucVx4GLaQzVM=;
 b=F+05H9McRvg64JGhNPjCDAihi7HjgxnelLBcFRnz1R+pqc9KyWss5zzHhsN1WxAAnL0oJl+plAemeRYLJGNRJ0eZ5zz3ooY959/D9LsGf7C2frYV52qq/yfT/ThVeeqdDG8o9m+KmGbmIp5mc+goLTRMk3DSxDcSYhpfXLDPa0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB8302.eurprd08.prod.outlook.com (2603:10a6:10:40e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 16:29:17 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 16:29:17 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Thu, 14 Dec 2023 17:29:12 +0100
Subject: [PATCH v2 4/4] usb: typec: tipd: add patch update support for
 tps6598x
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-tps6598x_update-v2-4-f3cfcde6d890@wolfvision.net>
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
In-Reply-To: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702571354; l=4936;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=TVl+/n3421/aHLjJqCJvBtCJNcSNOeLZsG/G74/AoQA=;
 b=7PymAq/KTkfqBgqFa8DkBWDzirlTkCbae0Q0Pq2IZTw2G3DphN8F4xqr6zh9JgtkkBAAR7ktD
 fOBF/tDKrJmCkNyhpoQqYJASIrjK+htau5MxosQvpfUlQNB4Nf2jQWb
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::19) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 575e72e1-30ab-4b76-803c-08dbfcc1d134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QzJs+JqFTiaS3UQDE2Lf5T9MQqFbVOxq2djIVUuqVIi9GVYM1NmcB4CBoZDuH1i4DKp/80kciqbTssOeHjJTpsOMJs5LZ07Ayzji7EBJRZVFi5BWjafOnAbexMfRa+lXFxSM5Ol7duomlzvlXfNK3qD5KYayYnT02hWev9ZUkn81Mgwgvu4qJk04zY2XcWgWKyU1WSnjfPdt6gvanx/FLWIQ/zhugQym4YYSInQM7rHpNhSS3dfBbqV4rD7FkR55/x3+/El8UwmnQtRuIe1BKlfhrbKevIXS0wtRP1hE9XuvjJEqYiL94dtjN3bHzuc18jJ6ipCoSl3tlFiv/hxGnQQsIvO8Bb1ZOWHEqrWimKJq7dx+sJaR9+oE4u7ikc5AFBuo260n0sm3kuZ5S5WltVq1neTr4AFOYXS/LrOdPsd4vZVWP1GjLZh/vWPs0+3GUq0uFjKyHU4SY6T3HzSApip9mI8hvmjRRfZqkrxYjZDammGlKhSjCe2r0ZG6zeir4s2uHk+mkO9LLcZReDZnzLHA/sG/8Z3bIWB6HPzFvwnRg2gefcqRHKeDCgIt6Vyhfm+yZc24HVOCoxDY0DZrETEySwt1zqk9nFWBJbKiGInumzSRkrKoNeSqu+7IhwT2kH+h0hMOcpFfbqCCL0rWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39850400004)(376002)(366004)(230173577357003)(230922051799003)(230273577357003)(1800799012)(451199024)(64100799003)(186009)(52116002)(107886003)(2616005)(26005)(6666004)(6512007)(6506007)(66556008)(83380400001)(15650500001)(44832011)(2906002)(5660300002)(41300700001)(6486002)(478600001)(966005)(66946007)(8936002)(4326008)(66476007)(316002)(110136005)(8676002)(38350700005)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVIySjArNHNpZFZmRnlic01HTVhSY3ZHQS9Eb0dqdHFwZ1l4R1RTa0k5eDdL?=
 =?utf-8?B?ZjRsWG9IVlVXVWI3ZllTTGFDMU5pbS9xdEdOdUh5di9ZK3haTVhwQitReElX?=
 =?utf-8?B?NWR4ckoyTjdUbjRxMXVmV0JSeStEaDgrWlhEdEIxY2grODhsaU9VQ0FaTUxH?=
 =?utf-8?B?OTFjQUFhNm14ZENXbVlmaEw2eitjQW5EU0w4SW5CZ2tzVWtYUERNUmp3emd3?=
 =?utf-8?B?bnprRldqUHdFN3YyTjgzbHA4RFoxcVc2ZldxUHRZZVYzY05XQ2ZjUGJ6Qjkv?=
 =?utf-8?B?dkp5S0h2YU13d2ZNZTgwbFcxYStsYm00cjBjYjJGRkJRVmU0d0NUUXdndDUw?=
 =?utf-8?B?ZVlhWlNibXcxcXNGWlRZazhlcEpIWm5hUm9QTG5SWDY5RUxLalFtTUY5VjBE?=
 =?utf-8?B?QjFJWG42dUxnOUd2SjBXRTBtNURVZU5sL24ySzNnM3oxUHcwaUIzb29tcjhM?=
 =?utf-8?B?Mit4NWRXWjVkaDRzSUlDZnlGVVFWQnF4Q0gxTVdaQkRyUVhkVm9UWDdRcERM?=
 =?utf-8?B?MlJ2cEM2V0E0d1ptaG9VYkhBL3A5N3d3K09GT0VFWnFrL0tjb3Fad2xmVUhE?=
 =?utf-8?B?cytwbEFPZWZlams3a1lvNldDQ016dEFvTGpCckNzRzBLVHBXWTlCRHBxbXJs?=
 =?utf-8?B?bjR1YjlMYTBZT2FMZmIzakFyOTlkRkxyZnFkZHgvR2h0dXFoMGVEM0JkaW0w?=
 =?utf-8?B?Tk1HSENEaUdBUUMxVzd2akNLRXFSRUVjS3ZVZS9XbUkrYjIrd0ZkUnRUZ3Ra?=
 =?utf-8?B?M24zNTVUMVhaZXFzb3NBZ3RVMyttZG84RW8xTVpIT2kxc21RVjdJTjFLQUtu?=
 =?utf-8?B?eCs2WWpLK0tDTVhkaXh6dElyeElnckNrejJRUmw3L3V0V3lGU0VQd0cxRVlS?=
 =?utf-8?B?YVNyMEgwendrczlxSnE3NFBGR09Lc3UySlhOYytpT0J1K01vV1hwazFIWDhQ?=
 =?utf-8?B?KzRTNW44N05OK01ES0NPbFVPamdjNWt1Y00zeDcycklzSWxBYnRwOGZ3RFdh?=
 =?utf-8?B?ZlFoTC9nWm1Bb2xlTjZUSEZsZEJ0Q3E3Tk9JVW9jazg3cnZValc2SnloM29K?=
 =?utf-8?B?dzV1aVBKVjNQNlBmUFlHVGtodnFiK2VYWTE4UWZCMm0wMExsckRqS1lmZmhN?=
 =?utf-8?B?NjVtMlA4N2tvaERHbnJuSHZ0WXpzYU5NemhrZkpqelRLN3pQSG9RVUozZFp5?=
 =?utf-8?B?RFZjbGx1aXh5MU9EQnQ4cVduaTJmMDViK3dXNmhaMjJhUzB2Z1h6bkdyNC9R?=
 =?utf-8?B?S3NES0NtSGlPNkc4UjlJZmMvZUduK1NaaGpwOWZueHlPckZYVVZKQ3FzcWtm?=
 =?utf-8?B?eVFpbjZJSXFHNDI4MTlaU0NnNFZtVHpscHRRUTFNNGpjUjdrWW5WVFptNG43?=
 =?utf-8?B?Zkc4OEJETUNJTk1BZlk2WWd5M3hrK2dtNmxGdHduRzZ1ejYzYzB4T0k0TWFt?=
 =?utf-8?B?RjBMZG0xTTkyQ1RGd1BBbEJZb29pN2ZZcmhUZlI3dUl5K2tGTzhRQU5EZW9T?=
 =?utf-8?B?a1R3OWkrdWQ1OHhhTWUySHNFNlQ1aVJMNjdtUkVyekxWSUFQcEY5QWdDNzV4?=
 =?utf-8?B?NEdLVXUwVHg2UmE1WjdmMFRqd1c4QVlkaitSajhjSUFYUWJacmsrSXhXTito?=
 =?utf-8?B?c20zd1JybHNHSDRHZm1oekZhd3RGYndVOHpOTmcwcVpwMGpiSXdRTzF5Y1cw?=
 =?utf-8?B?YzR3MWhWN2s2Mk9hb1d1eDc4dWZURDU4eEphMEpFaXFqczIxeGQvdEQ4TEFz?=
 =?utf-8?B?WEF2TVgwbnV6VUpTUS9kUndqb3ArMktSNE1Pak9xQmw0cWtuczZKSVo4eHJq?=
 =?utf-8?B?bkdoR3BGbElmRnhEQTZGSTV6Wm5CM3kwTGNIa2MvcFBid0tqQS95eit5Nlc1?=
 =?utf-8?B?ZUF3UFlRejFGcC9wYjR4Zk4rSTBzZ0xxQitqRnJndzJ3VVQzMm5DZGdoNEYx?=
 =?utf-8?B?bUFURkJKNmNIVHUycS8yQVBsYmUxZWxiSjJ2SlV3bEwweVRNc2FVSnEyOVdB?=
 =?utf-8?B?eld3Qnl6NFpkaHJIMGxMQ1k4dERBY2RTWGJ6YUpOOVBmNGp5SDl2aHFnN3Iw?=
 =?utf-8?B?Nm5TcStTUzBLZ1BUd2FtRnludkY5Z0FQRm1USnhld1Bua0lDaS92OWNsTDVh?=
 =?utf-8?B?VDRRU3BmeVZvV2VUSncxUWxiVUFxVGY1eEhLTmZCYVNodElLdGhyY0IzWERR?=
 =?utf-8?Q?IVhTWHLWmcS/Qlpb3AIK/04=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 575e72e1-30ab-4b76-803c-08dbfcc1d134
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 16:29:17.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRJ8HHRJx/+UAhYN9w/LsaFE+QI7qJeb4U4E6qMnEg0DUW5hWYQDLvUsUkXPOoZwncH1YnIVmd7b02bbhCdpxC1JbPofY+WqzuDBCtgRnfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8302
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TPS6598x PD controller supports firmware updates that can be loaded
either from an external flash memory or a host using the device's I2C
host interface. This patch implements the second approach, which is
especially relevant if no flash memory is available.

In order to make patch bundle updates, a series of tasks (special
commands) must be sent to the device as it is documented in the
TPS65987DDH and TPS65988DH Host Interface Technical Reference Manual[1],
section 4.11 (Patch Bundle Update Tasks).

The update sequence is as follows:
1. PTCs - Start Patch Load Sequence: the proposed approach includes
   device and application configuration data.
2. PTCd - Patch Download: 64-byte data chunks must be sent until the end
   of the firmware file is reached (the last chunk may be shorter).
3. PTCc - Patch Data Transfer Complete: ends the patch loading sequence.

After this sequence and if no errors occurred, the device will change
its mode to 'APP' after SETUP_MS milliseconds, and then it will be ready
for normal operation.

[1] https://www.ti.com/lit/ug/slvubh2b/slvubh2b.pdf?ts=1697623299919&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FTPS65987D

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c     | 68 ++++++++++++++++++++++++++++++++++++++-
 drivers/usb/typec/tipd/tps6598x.h | 18 +++++++++++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 7f4bbc0629b0..a956eb976906 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1125,6 +1125,71 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 	return 0;
 };
 
+static int tps6598x_apply_patch(struct tps6598x *tps)
+{
+	u8 in = TPS_PTCS_CONTENT_DEV | TPS_PTCS_CONTENT_APP;
+	u8 out[TPS_MAX_LEN] = {0};
+	size_t in_len = sizeof(in);
+	size_t copied_bytes = 0;
+	size_t bytes_left;
+	const struct firmware *fw;
+	const char *firmware_name;
+	int ret;
+
+	ret = device_property_read_string(tps->dev, "firmware-name",
+					  &firmware_name);
+	if (ret)
+		return ret;
+
+	ret = tps_request_firmware(tps, &fw);
+	if (ret)
+		return ret;
+
+	ret = tps6598x_exec_cmd(tps, "PTCs", in_len, &in,
+				TPS_PTCS_OUT_BYTES, out);
+	if (ret || out[TPS_PTCS_STATUS] == TPS_PTCS_STATUS_FAIL) {
+		if (!ret)
+			ret = -EBUSY;
+		dev_err(tps->dev, "Update start failed (%d)\n", ret);
+		goto release_fw;
+	}
+
+	bytes_left = fw->size;
+	while (bytes_left) {
+		if (bytes_left < TPS_MAX_LEN)
+			in_len = bytes_left;
+		else
+			in_len = TPS_MAX_LEN;
+		ret = tps6598x_exec_cmd(tps, "PTCd", in_len,
+					fw->data + copied_bytes,
+					TPS_PTCD_OUT_BYTES, out);
+		if (ret || out[TPS_PTCD_TRANSFER_STATUS] ||
+		    out[TPS_PTCD_LOADING_STATE] == TPS_PTCD_LOAD_ERR) {
+			if (!ret)
+				ret = -EBUSY;
+			dev_err(tps->dev, "Patch download failed (%d)\n", ret);
+			goto release_fw;
+		}
+		copied_bytes += in_len;
+		bytes_left -= in_len;
+	}
+
+	ret = tps6598x_exec_cmd(tps, "PTCc", 0, NULL, TPS_PTCC_OUT_BYTES, out);
+	if (ret || out[TPS_PTCC_DEV] || out[TPS_PTCC_APP]) {
+		if (!ret)
+			ret = -EBUSY;
+		dev_err(tps->dev, "Update completion failed (%d)\n", ret);
+		goto release_fw;
+	}
+	msleep(TPS_SETUP_MS);
+	dev_info(tps->dev, "Firmware update succeeded\n");
+
+release_fw:
+	release_firmware(fw);
+
+	return ret;
+};
+
 static int cd321x_init(struct tps6598x *tps)
 {
 	return 0;
@@ -1150,7 +1215,7 @@ static int tps25750_init(struct tps6598x *tps)
 
 static int tps6598x_init(struct tps6598x *tps)
 {
-	return 0;
+	return tps->data->apply_patch(tps);
 }
 
 static int cd321x_reset(struct tps6598x *tps)
@@ -1468,6 +1533,7 @@ static const struct tipd_data tps6598x_data = {
 	.register_port = tps6598x_register_port,
 	.trace_power_status = trace_tps6598x_power_status,
 	.trace_status = trace_tps6598x_status,
+	.apply_patch = tps6598x_apply_patch,
 	.init = tps6598x_init,
 	.reset = tps6598x_reset,
 };
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index 01609bf509e4..89b24519463a 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -235,4 +235,22 @@
 /* SLEEP CONF REG */
 #define TPS_SLEEP_CONF_SLEEP_MODE_ALLOWED	BIT(0)
 
+/* Start Patch Download Sequence */
+#define TPS_PTCS_CONTENT_APP			BIT(0)
+#define TPS_PTCS_CONTENT_DEV			BIT(1)
+#define TPS_PTCS_OUT_BYTES			4
+#define TPS_PTCS_STATUS				1
+
+#define TPS_PTCS_STATUS_FAIL			0x80
+/* Patch Download */
+#define TPS_PTCD_OUT_BYTES			10
+#define TPS_PTCD_TRANSFER_STATUS		1
+#define TPS_PTCD_LOADING_STATE			2
+
+#define TPS_PTCD_LOAD_ERR			0x09
+/* Patch Download Complete */
+#define TPS_PTCC_OUT_BYTES			4
+#define TPS_PTCC_DEV				2
+#define TPS_PTCC_APP				3
+
 #endif /* __TPS6598X_H__ */

-- 
2.39.2

