Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB41180870F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379020AbjLGLv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379016AbjLGLvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:51:15 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF97D7E;
        Thu,  7 Dec 2023 03:51:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDd97ELvn/bRO0pbasXmFCyQoaUitjw5Jjv9w5vazop4tijCLG/KGfcKNbZ5JqLCGezF+Op63y2dCQVWq9P9Ddq8iu1xBhcHbZapLOSJVhqwiGo4gSHsNebnGR3Cxq0J9iuEDurHibuu+2VTSwovg74bdSXV5KJ2oAub5H5u+uoN5I9Da62/hvvC47CseX3M4wny6a+/JMkmbAUmWXEE7HBVXAELAMd2dkzNWtfPFsJU2GYKoA7xXXi9vwJCzMXrOZ7gLtHKgT0jE8NwIDM70umJqAVEWG4ercO1zs6tc69QGxG8ddZMYa1J/g4Tinoypz+P/fsHrudZlClyjPNacw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cujQEzVlmkJFha8J9PhqlxbUa/4fk9ZOlxsXZrOBJeI=;
 b=Qxip92iUPITOJJMplLnw2e90byAeG9v8QGIkzI/xBSbCxIDAhN2BBnrgHgO+jURPe5Uyd17qjyhh/mI5+ITiknVEeiBruvP7fq5yMo1Egxw+CoZId1YEGdQ3y1OjfBQgSy0dxA8ViI6tqL2rHXQ6PWQ2Z27CnxefcOdY9ovhWODXH21kLCuP/zCVe3G+jQvTsHpjEnQ/5+C6xaK/PMvfBdOp1/877zaFi6pnUFI6arR8/ndG+m3OhT1OA+dcq7CJ8JGw27l/G80ygZTe0bkB+G6sdlJqTQne2Ia1iN1Ul42vBA1BeQtjE2GEB4ejJR76RbRDq3OTvk6mWOeZt7ST6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cujQEzVlmkJFha8J9PhqlxbUa/4fk9ZOlxsXZrOBJeI=;
 b=PLF9Mv+apyItWHLBikFpY5Nf4a4h2sb4NWYwZxebatFuK6nMDbTIWKTrNCp2tfM5jycrCFfTR/XOp9ZBuIneNrqvK+1Di4MJxqVNPx/C0D6mbXSj2qOAtnnUBkVOCVbh02be9mooIn7FQyqw6whQsAhEUCCWdRS+7Kwaz9j3WVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM0PR08MB5300.eurprd08.prod.outlook.com (2603:10a6:208:18e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 11:51:17 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 11:51:17 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Thu, 07 Dec 2023 12:51:09 +0100
Subject: [PATCH 4/4] usb: typec: tipd: add patch update support for
 tps6598x
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-tps6598x_update-v1-4-dc21b5301d91@wolfvision.net>
References: <20231207-tps6598x_update-v1-0-dc21b5301d91@wolfvision.net>
In-Reply-To: <20231207-tps6598x_update-v1-0-dc21b5301d91@wolfvision.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701949872; l=4936;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=8PtfpVXXJlDFboFn5Nrw8L2jU1tK9s2cmm7l3ScqDZc=;
 b=NK9f4hLXyN/Odj8cay2BgA+lhDxVk7Rld/H/LBDUvq/122FpQ3x6uiohnXpQkpttPO1H9/BtY
 7kKfnEiuxP/BKgvLCJc9ggsUHXt0LK3mAVtPjsPnNv3xSKvJcafo2Y/
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR08CA0248.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::21) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM0PR08MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf6b13d-2e9e-44a6-9a05-08dbf71ad0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhSA5VwMMADqesAzpR5j5PaKRfEZ3IyG10KPdmLE0kF+PCkwNG2Ue6QhCG1WSmILdON/bSz+Q+hUUDHsIYXMoA+QQu5OTEMiNU6LYZ9m+ACvxilOINAXJIaa3EKgJIEqM/6ifBbQkKE5PSQ4QKFCfPPhmY8J1p6W8p137TlzTkf7pzzFu4lFj/Ml5iPBcl8OO+9Va3ZPpUIQOHZ7PplP0jZyT9ai2+fKYb1QxrMQCaFZJ+80jrow3iyiMhUtHzqpsfAbtI/TmpI6uZHx7pTglnuetd8kLEHjj6vEUQq8cUw0e1832iARJ0B13nI2b8tEpDfWtj5FPqRAqPUadSIsV7d+Ox+AlKQ3pk4/GaYI/SjNRBJE7kGq3bFwPt8Idbqc9gvoVngoekKVjtKt9EJtjrWRAy7UMg5DZJHA6WIoPdKSZi1IoQUSif/BZF6brQbZNe1cgM4s0sGKp5ZRtA2nDJpAZ7eFoJbYG/IuETOPSUVaMf8xCgw+KQkYl6T2izz/hR3PK9ZItj+VlSxCknYcmzEjsZH40yxBb5Qx72NsWt71R4MT8I9MNZPzGnflZ2RB+V6F5LHGsuqFX2kynv701W/uiivTvU4AoWI7AKcTU7aZpwNFgi1SsllD2VIPQV6FKOKU0buGzmhkUMR9QnLBYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(346002)(136003)(366004)(376002)(230173577357003)(230922051799003)(230273577357003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(36756003)(38350700005)(15650500001)(2906002)(5660300002)(44832011)(6506007)(6512007)(6666004)(52116002)(107886003)(26005)(2616005)(6486002)(966005)(83380400001)(478600001)(38100700002)(8676002)(8936002)(4326008)(86362001)(110136005)(316002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z09iemZWNEtCWDBlTER3QTg1NTNEdUNzaVF3NTNrVWNDeWUrZnpmQlpETFVH?=
 =?utf-8?B?YzIwRHV1YVBlcWRCUko5NlpGdjlrbnJZT21mdDlxU05MWXpZNHdCNHk2YjlS?=
 =?utf-8?B?ajQzenpFYTBhbXkrRm9hVURxTG4vejhTa3BqUE5jQkdIWkcyTW5vV3RyZWJL?=
 =?utf-8?B?bk9IcVVDNlRMOHpTc09YSkcva2VKR29aUS92T2VZcTNnbzB4RzFnaDlJdWNz?=
 =?utf-8?B?ZHBmVlZWeXp4bHZoSEpFekFPbEgybitHaVFjYXpkU2UycnpVY2lvZGY2dGNy?=
 =?utf-8?B?NTZYUDJKS2VEdGZxNElTRXVjSXFURVE4VWJBd085NVVPYkJhWnJtTEd2Sm9G?=
 =?utf-8?B?d2xka0UzQWhFSE95OUYvTUgrcUkzL2tLWFhKVWNGTUVoWWNONEJEVDdvcFZO?=
 =?utf-8?B?U29YTTJXUlZjN3p6cVp1QVFQWDZHMnVFZmRMK1YvYTREVXJLNWphVXRpQ2pq?=
 =?utf-8?B?UzdTZC9FZlhmMm1ORURVSG9oQ3dNVnl2M21QVjlhSWRuZmRyaFJLSm9zUnMx?=
 =?utf-8?B?WlZjMGhBNUhlbnJCMFU2WEQ0RmNJN2hoV0Z4VXV5KzU4cGpPaThMZmV2KzBr?=
 =?utf-8?B?cjU2Vit6WXg3OGR0WlU5c1MrVDhEN1pMc1BjRXc4QzlVYnpxMXc0K1FyT2xY?=
 =?utf-8?B?VlhnZkxrajVMNXJUalVRNG1la1pFdS9VV0RtY3lYTEVjUXQvUm1RZ1YrbVo2?=
 =?utf-8?B?THg0a0ozckdIMUZyaHVqOXgzMStycDdNVW9nK2tsZG9mMXNmb3JpaWZJNldo?=
 =?utf-8?B?TmlhV0pQaXBTTWFjbGRTWnpGMUhPOFg0c0JrSngzbVgzcmdOdnFoenJHc1Zp?=
 =?utf-8?B?ZUVvNloybWNwN050UGVNZWNDcWo4NkZEZlFNSWRGQndnWFFPWDhZNVQ1bysv?=
 =?utf-8?B?MVduL2pqcUJJNkxHYldMb3pPaWpzK3Y4Mmc5TG05VWpDdWN2MW12Z205SGFm?=
 =?utf-8?B?TEtzY0ZMUVE4U3pKMXpwRVk4cVFNajBhRmFYb21KOE1OSHJOSVp5Y3JJQkJi?=
 =?utf-8?B?cmpBaS9TV2xXS0tpSVV2bk9vaW82ZENUbUxNNmtiZkxDTndleWdQMjluOFVG?=
 =?utf-8?B?dCt1UGFDUTNzdGtrTWl4T2ErQzF4OXZKakZCR1BNSWlmZG1MQmxyZWJrVk9X?=
 =?utf-8?B?Skoya0wxS1BoMmEyVVRhSmJ6ejB4UXA5OEdta1dXRjJDYjcyTHVIYTJ5Nzl3?=
 =?utf-8?B?bUhGOGF6Szg3WnhhV1VVMXRtb1FpQlhxL0pkb0FndTFlSEFETlg0cU0zT0Y5?=
 =?utf-8?B?NXlZRXhQWG5CeHZiRytXam5ZZUJyRCs1a1hENENXclo3MHFhV3FWOXdqb1Ba?=
 =?utf-8?B?TisrZTVVQ1IyZ0RnY2R5M1ZmR1h1ejJoWjFEZjVMRUU3ZUNwWmE4SkJUVW1j?=
 =?utf-8?B?YzlzZVRmM3NOQ0JJMGtqL3ZKdlNvVWN6QWtFczZhSjFNczdMVUxWSjM5ZVh6?=
 =?utf-8?B?M1gvTk1ESEF0N2wzSUlCNUdLdU9vTFpHU1dtM2NOMWd0Z0hSbXh4YmNKdDF1?=
 =?utf-8?B?M291T1Z6QU11KzdQK3gyUFhKejNWbjVQQ3E3dzFIdTI3NC93aE5obE9UbnRL?=
 =?utf-8?B?SStiTmRSS3Fyb1FRM0ZKdEw2YUl2ZTdPbmJPbFVieENDSFNaeFNnZUxFZ0NC?=
 =?utf-8?B?MG1mMDlxQnRHMXppeXplV3YvNU9wd0FRdW1xL0dBanJGM0gwYlF4d2VWTGdW?=
 =?utf-8?B?aWhPSTRKWDhMRVhzU3FKZ2NQN3FYa2NYbUg0QzcyYWpzK0h2WWp0eWZhdlAz?=
 =?utf-8?B?eGpselUveHJrbUZoZGhXcDVKVjBXY21WN1RLdW5GaUljdkFzRm1sRFd5VVFL?=
 =?utf-8?B?d1VZSFAvajV5eUVDaVJyZW1Cb2lTU2VBdGVPYXVLMHltb2tXQnpWTVhrZXJO?=
 =?utf-8?B?YlhUNWFYc0ZyOWh4OTY2UDJzQzBHb2tLeTByeGhqUnlPNGUwVnhyNTFmdWh4?=
 =?utf-8?B?ZFdaQ2JSU2xMdmIvV3VmQ2IzN2QzWVQyNkRJUTYrR3JDMGdUa1UzRXRGUDln?=
 =?utf-8?B?NmZqeXJhN3I5SkZpZks5dktaTHZXVE9RditSRDBOTjVPdlFJdTNNQjgvckZN?=
 =?utf-8?B?ZGFLM3JSTVEvbHlNdVgrMGFvRHAyTkVFdXFQYW1GbDE5ZDZWOUlydXF4aVcr?=
 =?utf-8?B?VVplTFVMbnhyVmtxelhyaXYwV3dncGw1Q2pmNU0yRnE4cUVuTTZJN1NpYVhl?=
 =?utf-8?Q?UE71IRj/e7WYS+Mj9ZHteR4=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf6b13d-2e9e-44a6-9a05-08dbf71ad0ba
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 11:51:14.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2yfNRbvqz1G0seD2Fw7I68G+Q9bgm89W9beT3QPT2sUnz42OJuhzbixntewoMNlHr4r+tVM2sMTdL8qiqNlTHloD7sLmIE7agnXFzzxICQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5300
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
index cd5214c9799e..a4a50c52253d 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1126,6 +1126,71 @@ static int tps25750_apply_patch(struct tps6598x *tps)
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
@@ -1151,7 +1216,7 @@ static int tps25750_init(struct tps6598x *tps)
 
 static int tps6598x_init(struct tps6598x *tps)
 {
-	return 0;
+	return tps->data->apply_patch(tps);
 }
 
 static int cd321x_reset(struct tps6598x *tps)
@@ -1469,6 +1534,7 @@ static const struct tipd_data tps6598x_data = {
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

