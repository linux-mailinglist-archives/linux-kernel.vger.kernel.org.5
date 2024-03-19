Return-Path: <linux-kernel+bounces-107373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073FB87FB9C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE26C2831F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DCF7E0E5;
	Tue, 19 Mar 2024 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="qW8K8sdw"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2105.outbound.protection.outlook.com [40.107.22.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D487D41C;
	Tue, 19 Mar 2024 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843242; cv=fail; b=pn0ubVyxQNpbtDjAEDBRoEyTa8kWXYOevmg15gUpCZh5Tp/oylzZJJinW8yS6ztMuVTB0E2yh8fOM6FkNrFOrqXCCQt/2OH+sA3/YqGJUIoQ/+sC+nqGCmt15wH4Ab1i4H4jyCgzbtwhmooInmn47yJ7os8PwPdnjaV7/OfzO4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843242; c=relaxed/simple;
	bh=u7Wy8RChhMZ+pUiLcvlwssGg9LgsO1g3gmZIRth4nAw=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=LvNyFNXpxhhd3ovmMFSfVc3yu6KVUhwYt2RNCKjKR70XOHI1nxRj91k7U0CKw7MET5BgJBss8/LWBQX4q11xe5pQfoNKHGj5Qg12jskKFJyIicuFdl4TCbwlWkHHXlYkfzBu7hMKgG5EofWP5XTly3T6EdWt8U+tyfOycQPH8cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=qW8K8sdw; arc=fail smtp.client-ip=40.107.22.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGcwd97YsVHzrbMGwvtPG6VVt7eGkmvuvxifk0VGySY+xM/wfmOhj5td9uCX1RuvRN3zK6C3ERP4gagk9kP4k7dmiKEl889pzz/FrPsY7ykAcIAnnjBnduUf9gfM0Pzx1AwLVM1MfIg12prjGShFe2knazd4iixtzqwdueysVxMEKYSwEPtkpkUx4fxblY5c4WD1/5zQBQMOaHbaUz8+NtJLyHs7olYesutFmgCwbR2EC5bEW0/SmQU9JwjX6malf+aFf/qK2pL1qSQrECNH7dguC0BnhZQh8tTihit9LMXH/v1j5D0+enViNfNodWh0drOL9ZBSvzVBMKmevAfKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sbTNcvCr8Dr2LqaXtapBDZTZFsHoMnLxXl44XWO3e0=;
 b=NmIhVkycS13n7kGVSvee+gq1gsZcLt9cTeauoDcxP8mOdyrR856w5XjlBfriH3/hdyOzY16VHh8CFj7WKTaOcC5Ha5XWXwav8VPO0UmdIqGbz3/9ViSyi0B5i78T9AkyadKZJQ99BEmZ+Nyd2F9SRSMriKA5hFVEqODaJtJ0a5iTStE2vWFT/9QG9MmGKk/hERZIXxqKzhuXP98X9XLugbJCIGCuSWSLIZbli4MRNj+Wl5DZtCZOFSrN9W3+huyP6qeuNEVZdZJgSSXeRy3yw+Hi2JGaX5J4agomm0NcUwm3kYBxSwQHtxtmuu7X5/Vkq+RKiNdSOpadYpG5k4/tIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sbTNcvCr8Dr2LqaXtapBDZTZFsHoMnLxXl44XWO3e0=;
 b=qW8K8sdwmbe8h010Cg1vzmumdj7BVzyAqyIMhqgBfOmgk0PqDgQ7MzBBhBOHKvnAbWX4TQp01kiO03904a26W5gf+UFDjAexjdNFdu+EhT128RAuujD54LMNBD86gQjs4yMFxnTcUMpIcTJKE/8wQkN/wU83PkEDaiCorf6H00w=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB8872.eurprd04.prod.outlook.com (2603:10a6:10:2e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Tue, 19 Mar
 2024 10:13:57 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 10:13:57 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 19 Mar 2024 11:13:25 +0100
Subject: [PATCH] dt-bindings: net: rfkill-gpio: add reset-gpio property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-rfkill-reset-gpio-binding-v1-1-a0e3f1767c87@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAERl+WUC/x3MwQqCQBSF4VeRu+6Cmhb2KtGi0XOnQzLKHYlAf
 PeGlt/i/3fJcCLLrdrF8WHmkgqaUyXj65kilFOxtHXb1edmULc351kdGZvGlYsGpokpao8hGCz
 0dr1I6VeH8ft/3x/H8QOZbK/6awAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU2PR04MB8872:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CeNYm5tcp2PaBNAY7E0Is43VCvh+mXz8JNfMQtanYRbN/C4x1GyH+jnmstQQZyw7AAQ/VhWXnYJcZ8qJvSxRJdsvX6gSqr7eYZXWoFkjdWXLKDfXXfG6pPjULMnGijMep/OsEnS/jwte3wf5YBiTLE3to9nBv61l9qwBw8xLgwy/akqYapmaT5HaIupZar/uIoB+mwAq+SmE7Lu9KEuxwXNZeUmEmKDwaA7Zzh58dMtHFNJCT5z9jMnPmMeC2ikQpQis+hTDCQZ3UtPnRxtPwvm+YwK8JTawzrdJmmvBqCI2ybp36kBN2XS9NSlVhuJTHVx4WfMSFfM+M0InveBf/6nLh805HaXWqtK1sUS2stMGCXXm8DrIVPYFKSanq2lSNfwYwUQAk0zN0Z4bw69meK5H8o2UpC8qOAZbYEY4tF/iZEIizBq1IbFp4UcwQ5Csf5fvS0oPegPs4b1UwDI7SdQI8xQ507O51OYcG085tBpUrPKs5ZXJv8/4hXkprphXFCcVhPhrNCOknmRAbu7+KdHzA0l5bXU3+YgRmd2LcWcezVhREVhBfiPlJe2PFg9VghaHWtkpo6oXdypWef9azr+xJomtMwjRTuOh3y/OakBs6dDr0yPIoVFUA1ufIKZn8td2amFjR9FSkj0Of2g5YxfcYtBk6TL+hvatNbD7y7xM9KFO9EfOCeeSKucI8TnZanTDxgtU16u963XnguASFwQ8zX9Twkgt2SdsyjrA1zQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STZuS3ZIdnZzMzFZWjNGb2U4ZlFyZC8yMWllRWRBUWZBNWtGWExRUGkwRnFU?=
 =?utf-8?B?T1d1MDZEZFNWTHl2bUFIWG4xSW9GbjlVVXFxY1VVTno2VWI2azkyRUZkM3dH?=
 =?utf-8?B?TkVCcHRmSjc3b25GR3JYd2ZWdVVEbFJlU204cThpT3NZTDFvRmNwQi85WGdN?=
 =?utf-8?B?U3hNT1NCbWloSjBQMkt3M0FqejNtYjAxNXZBU3BFWklHcUlvQkNHZSs2K2la?=
 =?utf-8?B?em1nMzBzRnRFV3RwbzVNMUY1a29qU1RmUHVMdnZiUm12YUtVNkU2M0ZvbDM2?=
 =?utf-8?B?S25hRW5mZU1tQ2x6S2FFalRacFB6b2IwbldFZmI1Nk51SHdFT0pIME16TXky?=
 =?utf-8?B?SUZFaGlQbnFvajJEKzhrUFBpSjNqYlpvVjNmc1ZjaHAyMDNvTHJ3aW1JTDMr?=
 =?utf-8?B?dnV5cjV5Z2wybjI4RitjV3U3N0tMcElGSXpDZ2R3dmExOWlDQW5lVkRpNEhR?=
 =?utf-8?B?WEVSWk15dGZ4ZXhsOXJKbHR5bnJlaGNWM1piMEpZRHd5WWJhQlRJM1ovZEhh?=
 =?utf-8?B?TjgvWklGWHAybjNlQ3JXWTNCc2t1UmtNaDcxNEpEQTVoR0k0TWVaZUdPbTA3?=
 =?utf-8?B?bVo1cE4zSk5XS0doeXl4Zkl4Q2p6Ym11QjVGdDBxZTQ0SkhZQ1hReVd0bDAx?=
 =?utf-8?B?SlpwZ2hzcDBaS2dQMlRpc0p4a3B3KzZpSWNrcEpHTmdZQ0lycnRDbDN6RUhR?=
 =?utf-8?B?YWRURTF3eG9TR051M2wyTEw4bUJGbmlxdnZaZzRYMEZWWnJpMTQxalYyVGhJ?=
 =?utf-8?B?VTJxeGQ3NlZXNDBVOFd3QmplV29PT2NaaEE4NXU5ZVJSTTBTcitIekxMWnRv?=
 =?utf-8?B?UUlMb05meFRaQ2NQODE4d0U3MWphNThDNzVFSyt3cExXQm5VUk1IeHpvUjRQ?=
 =?utf-8?B?YTN6SHRhRWhmbWh6RmFxTWZwdFREUERYbTQ3eG5RaUlXS3NMNEV0d0ZOZk55?=
 =?utf-8?B?cTN3UWxFems0aUlhM2x4aW1zYjlFZXdiVVBGa0M0MzZDSUpUemo5VFpTSGxE?=
 =?utf-8?B?ZkdkM0kvaFN2YWZSSmVDb25Sb01KYjFXMHYxT2pINllrMTY2Q1E5MThaM2Vr?=
 =?utf-8?B?bGNqWW5DMzNKQlU1L3UzRDd3WXg2QWJoZW9rS1JqMnF0NEJSWVAwOUVRNXRs?=
 =?utf-8?B?T2J5ZHJ0K0xmL3J1bEtHaU8xQnRuUlhvZERsV2tDbDI2aVNBL01BajhxN2dP?=
 =?utf-8?B?RWNPZC8wRlhBZHBwOXROcjV1U0pucW1DNDNyOElvb1piM1pWQjUwd1k3eU9k?=
 =?utf-8?B?b0R6cFU5UUVyOVdsbkloV0JDMU1WdlF2VE9vTXowUi9FaVdCc3lJZVJzQmdK?=
 =?utf-8?B?VUNEbmxpVXNNaFJobXZoU1ZFdGFVbXNoOGVDMm5FVnZOUWlBNlo1TFVsc3ps?=
 =?utf-8?B?SmRsbDFiWkJxbmM4MjduYkpkc0JDS29aNk4yVExlOHZkRTA2RU1MdHpuc1g4?=
 =?utf-8?B?TUpIT3N0bWZWamtqWkF3SDVaOG9mOVpBcndUS1JZdlhDZ2cwQ0xnTnVNRDdw?=
 =?utf-8?B?NlVwS2pCcUFXcCtpR3NPN3UrUHJaZHZTNjB5T0twZ24wKzNMY0lTSEZVT1Iy?=
 =?utf-8?B?VVBlYWdWMWdLMXFVOGxxYnhFUys3R2lyQlJCZVNsV3hPaXNjUUJwL1luNW5K?=
 =?utf-8?B?VnhQVjNUWk82RG5aM01SWWJ1cFBtYTRhLy8rTzR3OGJpV0p1UEs2SkNPTWV4?=
 =?utf-8?B?aU52a0w0ZVpqMHd3K1k1M1VnSlBsNVVzcVdIbGJhSVpMWlBtZUZOQnJhYmdr?=
 =?utf-8?B?SGIxekIreUwvRUVXdERhVHRSRzZoaTIwb0lQY1hCb2d0d0MvdmxMNnV5NEJo?=
 =?utf-8?B?QmoxU2pCblUwd3JMZ0VIU3VKcVBLV2M2N25IUkJTT2phZXdIT0tQSDZTM29s?=
 =?utf-8?B?Qkd3bUE4WThNdlp4YkducUFZQkZPenRObTQwM0ZMTmV3a2laS3pTNldUT3VK?=
 =?utf-8?B?SU9Db2ZTelBadmlhem43NGNFRGoycEd5WnlscHAvTWpsSlArZ0Rpb2VwRUdj?=
 =?utf-8?B?OGlwMStjQzJIS2lORUNaZ09YM2k0NTlSSngwZlRpVU5qa0pFOXZGdWdHbUpF?=
 =?utf-8?B?azVnbWRIdWxONUxlVDBtUkRBL1Bub3lkcC9YdlVXSU5IZkZQdWwzTUVnWFlj?=
 =?utf-8?Q?LH5nUVrSnYaMvCBS+mqPnP8MJ?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510f1c5b-63f7-4c72-1a69-08dc47fd4a28
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 10:13:57.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7owavezGzSHhwz76tsSl98sN0Q51XYISPVjGUOvXF/3KNEWo8jGUnoqgZPEEqbKEXnduK0LuJcV79XQEExU/sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8872

rfkill-gpio driver supports management of two gpios: reset, shutdown.
Reset seems to have been missed when bindings were added.

Add binding for the supported reset-gpios property.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/net/rfkill-gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
index 9630c8466fac..d01cefef6115 100644
--- a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
+++ b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
@@ -29,6 +29,9 @@ properties:
       - wlan
       - wwan
 
+  reset-gpios:
+    maxItems: 1
+
   shutdown-gpios:
     maxItems: 1
 

---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240319-rfkill-reset-gpio-binding-5e9bfefb5f76

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


