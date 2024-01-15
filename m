Return-Path: <linux-kernel+bounces-25783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C32C82D5B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE9B1C214CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159B21E865;
	Mon, 15 Jan 2024 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="PxV/kBmu"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5AAF4E3;
	Mon, 15 Jan 2024 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NR8tplSI2dsjC0RxAqIIpznGoYlCvmePNO+G+2dmcXJpEyCLxYmd+WvCiQYIVevQuNJN0hWoh17n67p6Ir4LcvyV0iFxbVK1ISD7V37fThcT7nGl+pCx2L2vJ9WB494K7wmpqiwSzbkfzBstpuIfl3Blcds9sLtaUP3fzIwrLWryQrCOkpR3O/feOMGkM6DdG9ZHQGTkRbm4RmGbh3Fra/IbsfOB9q1yWLVLfhIth9NZR/nUc/zYZFkI4gzs8rV/d1r+l18RdEfZMPif9IpgCyu5wZXj+S5ZnetPtJ/AvIELwIH30KUVQuuu1bB1gZk1ua4tgjta1VdYBRam/Jvmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4vTqiQL1nGrKQJQ62l8AJQ4ZdiY55P7+3cTvEi5954=;
 b=fjv+80MbF4RcIOCpIAej3392hW6V5szYB1p1uaitGhj4LPaqb4fDiaIRwxDewDz+amOtclXe+lO2StNwU2Cq1t2o4oL27bHrwcKFUcs0nD6ExCxUKW4iGPEDkeB6sC00DEVd2p7DCesq3OrbtxkTYLQT1LxYiCEVKTdlIF2L5V/bKLq7wrBbRBmUM2dGisQjfVNDKowIjVyhH4EDp6vF/uQl0TL9Obz+4YJObJAZL4zZuJUtpwLWaFWe6jxSUgzXgpOqlBUj2rh0lZdvtDRL66cRBymNQ4Rjs3N3kFVR7eUlatwrbC3cECBLKfBgHKaj8TiqW2DtBcbVDG94udoTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4vTqiQL1nGrKQJQ62l8AJQ4ZdiY55P7+3cTvEi5954=;
 b=PxV/kBmuWB6gEhrGWB5p5PYYBC9vAxF08qdYTMAzHnvBWDlP6C4nvLEK4oeiUlQQK1FSwiX9SBBRmmopQWTCPH+Yf10ZnNFX+dF4ZKx+ac/Kv1ldONZQ47jrhZ7NtJBKilh6MQlKh35llwlKOnQjlyV7tyeWFlEuiUfrrvC8V0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM9PR08MB6035.eurprd08.prod.outlook.com (2603:10a6:20b:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 09:16:40 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 09:16:40 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Mon, 15 Jan 2024 10:16:33 +0100
Subject: [PATCH 3/3] ALSA: usb: add support for XMOS XVF3500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240115-feature-xvf3500_driver-v1-3-ed9cfb48bb85@wolfvision.net>
References: <20240115-feature-xvf3500_driver-v1-0-ed9cfb48bb85@wolfvision.net>
In-Reply-To: <20240115-feature-xvf3500_driver-v1-0-ed9cfb48bb85@wolfvision.net>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705310196; l=6607;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=cgjB6qaEKMrZ9M/nM5ez3VnfLkmywgMj1aWY3jnDGgU=;
 b=m38rSpHMErKsKzVbQSiHmrpxTRgeFxKu3MEUAKAmxtBsb85Q+SHfMPPxFR5iax3303cdeYv4D
 1O0ZOXpHntoD6qa0UbR/b5lhcDFzwYQVfyhBNcNniL7nXRs7kHzKjD3
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::18) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM9PR08MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 58937aab-5fea-4fd5-2088-08dc15aaaeab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6UUS9OEwyJybkyu8eqOttaYIh2vCSDDhMcfnHzpagO7XkezEvpxiIv9OhFIOPgFWYjYXGNnfpemwUYyhhWWG4rX+ioVb7nyATT10btymMRlJEyGWgvsZr5mtBZazdTbV127PHvtM+4v6fyhUM1ECCNvje4tynOudgNDfJFkYMPLIweS+p065DWm5D4YAtaeU+NkLn/9HHNcjfRvjvy8wuMS+8cAkmnv/4ilki4j9UfKgVN8bjfKnJqWC7kwtn7Nz8zvikvxTXFd92F/5K9C3cCG/TwFXAdYZGcEXmnfQrou6pAPiAoPClXMJkvv7tdT4SxfO2xa0OQ2w93vC9PuBqOyofiEpseQGrLq2HfAV9ByhjOvni/tGB7jpIcoS8kdgHgewQmycvYrB7BK1C/0Ew6TmbcXDG2/YI8exzucG/Ce+kRasYraM19IF9UMmgkAvoPtidroq5K5441wKmgoqwHsL9i1lzDSloD9U2ErKFi8EWXAo990dv2C0va7xepM1aMgjawIQD1po6cJ8iSjNAPh0V3Yo3RfbgItWt7/VzubLnKSXDCVkyginDbFzK5L8oTFUlVaDPhWfJ1WNU9HD6Ynj0EvmYHM0X9RZP/GxM0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(38350700005)(36756003)(86362001)(66556008)(26005)(107886003)(2616005)(83380400001)(54906003)(66946007)(66476007)(316002)(110136005)(6512007)(6506007)(966005)(478600001)(8936002)(8676002)(6666004)(52116002)(6486002)(41300700001)(44832011)(2906002)(4326008)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djZCQ1l4enNQQ29mMzFhWnA2UXA2WlJiMWl2WmsxK2tVVUdMK0lybHBzK3pY?=
 =?utf-8?B?VHFDS3B5ZGhBRnA3aHBkek1nNlp3enJSc0wwWk1lSlhSUGlscVRldjdraGZL?=
 =?utf-8?B?SEkwb0twYUY1MEFJajV2U2pBMWVQYnRhRVpIODg2NmtMNWxKeERQM1BlNlBn?=
 =?utf-8?B?dS80dTlSc3FTaEo5VXhFSG9wUUtuRmdLMXE1aXRKWkt5ZUVrUWgzMHBwU0tk?=
 =?utf-8?B?NmQvV0Nsc2NNM1ZYaXdLRS9FZGgyTllJeXV4ZElEMDYwbWt2R0F4MmZ3ck9U?=
 =?utf-8?B?TnJxZjFPUTJQMXJITEI0aWFiaFNEOHZtZUhxa2lNSXpIUkRCZzZSVkNGdjh1?=
 =?utf-8?B?T2R4ZTczUmM5bVMwVzFuaEhERWpkbUVpKzNnNE5kN0dkYmVUeDZ4bzV4UWcz?=
 =?utf-8?B?eWRrRGpRcStGd3JKVzUreHhranZKMnlpR3dIQnlRd0VJTUlOK3g5ZXlkenVQ?=
 =?utf-8?B?QncvalNvb2srRkZJNitKZFBodzJGSEQzZ2Vla0RnVm1janhLWkVrS2JJV1Na?=
 =?utf-8?B?TXhMY3ZYWEYrd0pwZWJMOFA0a2htMVdjRU1mK3Y4ZDAzZE0reWErR3paWXVW?=
 =?utf-8?B?eEc1WlpnSk9iSVhXNzNJZjZtWHB1czZKNmI2YmVEeFN4VXYyVEdGOUxRUGpu?=
 =?utf-8?B?T2VvcDlMTUtmVVBaTk9XQzhUdW9NcU5kQXp6dkxoNkgrNGlFdnV1T3IrOTFS?=
 =?utf-8?B?V1FWaHR1NXA1Z0FDekpwOW4zdWpCOGVvUm5hSHhaSCtVMkthNSs5eDZPTHl6?=
 =?utf-8?B?bG5ReDl5WHdYVjQxLzlXOXV5L3JIdFFZMklHQVVTM28rMXpaTWJMZkFESG85?=
 =?utf-8?B?UkFkZVY3M1ZYbjRXbXprT3ZuQ3dteUFsdnNPSWFvQnNhU05Eb3l4MVdUV3FN?=
 =?utf-8?B?NTh1c3VXNnBtZDRrdmVDSXlDK0ltL3g1cGNwbUNGNTlyL2NuT3VPSjlsODdi?=
 =?utf-8?B?MnVERkdhNnNQVEQ0RzBLaGx0VGRtTmFydkZHVmhsVWpqUElFY3oyVWdrdzlw?=
 =?utf-8?B?SitZN3RsdElHRXZ0clVWTkY3aGlTM3dPeGttRDlPcVdHOU5idHB6RVJjOGZn?=
 =?utf-8?B?MGlOVUVwMXBkNFZjRzQzSEhOeFpkVk9PR0wyK3JKdmJIWjREUFdEQzd2eFhv?=
 =?utf-8?B?ZSs2ZzlzL0RlVXExQnpwMWZIWGpCSWVzbm1FK0MzVk5ud21oYUdOSkhpdC9P?=
 =?utf-8?B?NnE5TjloeEs3d292dFQ2WW1uaklzamtiVDJONWFEYXJ6RmpOVlg5SFkvbERs?=
 =?utf-8?B?M3lQSzVPWjVrQThHTnFOVFBySW51blRMMEZxbUtzMStITGIwWWpwZkNqRmla?=
 =?utf-8?B?RGFBVUtuUHR0UUlJbkZFbDNVRWE4U0lsYmd1Uzh3TDBGNGZZQys5MzJQQTNl?=
 =?utf-8?B?NkhUTWM0VG1INUN4UmNLaFpGQ1U4YWQ0enQzb3RHT0tjc1RmdkhwSk8vOE5k?=
 =?utf-8?B?RmlGWmhaN2NLZVF0R1RUVUd3eUo1a1RuRE02MXRnSHY3aHp4R2hDQ01Jb25V?=
 =?utf-8?B?S2NFbm9Qek5FejlEdjBOdWg4M0JIUUtRYWpZL2lYZ05Wcy82dEZ2THBjeFdZ?=
 =?utf-8?B?eXdtbmorMXMxd2d2alIydXY5bU5zdnZhZ0pLazFyUjlMVU1OOXVFWUo2a1JC?=
 =?utf-8?B?OXZuOFNIVEdWRnpta1p3YWlEdVphRmdjZVpHc3ZLMExXaTBYZkZGT0xJZTdD?=
 =?utf-8?B?bHdjQkhrNDRXTnc5SmxaY3BWNFNnV1N4S3l5TnVyR00rS3NrZlF3Q0FCZUx0?=
 =?utf-8?B?MVpxVzgvMEJQeXplRkNYV0dLME1WYXhOZG5EaFRhQ3pPUkZzdTR1QWJSUDA2?=
 =?utf-8?B?dlJ2anhtS3BKL05ZeThzSXZibmVqL3hWYzRCallXTjY0L0p2dDB2ZW9sVE1k?=
 =?utf-8?B?NUhEN1RhdHJTd004L2pqc2dQNE9wR2l1UU5WQ2N5SlBma01uV25FaFBGSFFU?=
 =?utf-8?B?QkhKclhpZm9wZm5ZSDJvZmsyUXFrc3NTV0U4NlJDUmRWampZeE8xT2pQZmVG?=
 =?utf-8?B?UGtiQ0hobDZZcWtQQ3ZXWngrY09ZV0FqRGhlZGs1aFdTRkNHL0FINmY2dXhr?=
 =?utf-8?B?MGsxUG1YK1YwN0h4VGErK1VGbTJpNjlkcng3bGN1c1haV0ZVQXFnMFBmck9H?=
 =?utf-8?B?b0pEWGFOcWc4U0JYcE1kZkFPdVEvZ3NxL1c5YlRFY0wvNllVNmpuMGJpZlUr?=
 =?utf-8?Q?GrTu4WEiieWKvNIWE4eu/wk=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 58937aab-5fea-4fd5-2088-08dc15aaaeab
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:16:40.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIt9WMZc1q+8eyoy7eCxIzFr08JjHIDOs/zfp7/noIqgNFBZcXDxQfpweShnSzOr+kPEdzrqRACkZ5L2xHWmS3nkE1jtrhr/2ZfxbdOjhnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6035

The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
multicore controller for voice processing.

This simple driver provides the power sequence the device requires,
which consists of enabling the regulators that control the device
supplies and a reset de-assertion after a delay of at least 100ns.

Simple PM operations to handle the power sequence after resuming
from a power-down mode are also provided.

Once in normal operation, the device registers itself as a USB device.
Therefore, this driver requires USB to be available in order to
guarantee full support.

[1] https://www.xmos.com/xvf3500/

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 MAINTAINERS                 |   7 +++
 sound/usb/Kconfig           |   9 +++
 sound/usb/Makefile          |   3 +-
 sound/usb/xvf3500/Makefile  |   4 ++
 sound/usb/xvf3500/xvf3500.c | 140 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 162 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7c4cf8201e0..fb9be0e12c71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23960,6 +23960,13 @@ S:	Supported
 W:	http://www.marvell.com
 F:	drivers/i2c/busses/i2c-xlp9xx.c
 
+XMOS XVF3500 VOICE PROCESSOR DRIVER
+M:	Javier Carrasco <javier.carrasco@wolfvision.net>
+L:	linux-sound@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
+F:	sound/usb/xvf3500/xvf3500.c
+
 XRA1403 GPIO EXPANDER
 M:	Nandor Han <nandor.han@ge.com>
 L:	linux-gpio@vger.kernel.org
diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 4a9569a3a39a..11565429163b 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -176,6 +176,15 @@ config SND_BCD2000
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-bcd2000.
 
+config SND_XVF3500
+	tristate "XMOS XVF3500 voice processor driver"
+	help
+	  Say Y here to include support for the XMOS XVF3500 voice
+	  processor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-xvf3500.
+
 source "sound/usb/line6/Kconfig"
 
 endif	# SND_USB
diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index 8c657c2753c8..4171db0f483c 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -34,5 +34,6 @@ obj-$(CONFIG_SND_USB_UA101) += snd-usbmidi-lib.o
 obj-$(CONFIG_SND_USB_USX2Y) += snd-usbmidi-lib.o
 obj-$(CONFIG_SND_USB_US122L) += snd-usbmidi-lib.o
 
-obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/ 6fire/ hiface/ bcd2000/
+obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/ 6fire/ hiface/ bcd2000/ xvf3500/
 obj-$(CONFIG_SND_USB_LINE6)	+= line6/
+
diff --git a/sound/usb/xvf3500/Makefile b/sound/usb/xvf3500/Makefile
new file mode 100644
index 000000000000..51a61c8f165d
--- /dev/null
+++ b/sound/usb/xvf3500/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+snd-xvf3500-y := xvf3500.o
+
+obj-$(CONFIG_SND_XVF3500) += snd-xvf3500.o
diff --git a/sound/usb/xvf3500/xvf3500.c b/sound/usb/xvf3500/xvf3500.c
new file mode 100644
index 000000000000..647e5d09d1e5
--- /dev/null
+++ b/sound/usb/xvf3500/xvf3500.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the XMOS XVF3500 VocalFusion Voice Processor.
+ *
+ * Copyright (C) 2023 WolfVision GmbH.
+ *
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+static const char * const supply_names[] = {
+	"vcc1v0",
+	"vcc3v3",
+};
+
+#define NUM_SUPPLIES ARRAY_SIZE(supply_names)
+
+struct xvf3500 {
+	struct regulator_bulk_data supplies[NUM_SUPPLIES];
+	struct device *dev;
+	struct gpio_desc *reset;
+};
+
+static int xvf3500_power(struct xvf3500 *priv, bool on)
+{
+	int ret;
+
+	if (on) {
+		ret = regulator_bulk_enable(NUM_SUPPLIES, priv->supplies);
+		if (ret) {
+			dev_err(priv->dev, "failed to enable supplies: %d\n", ret);
+			return ret;
+		}
+		/*
+		 * A delay of >=100ns + regulator startup is needed before releasing
+		 * the reset here. Wait for 10 ms to be on the safe side.
+		 */
+		fsleep(10000);
+		gpiod_set_value_cansleep(priv->reset, 0);
+	} else {
+		gpiod_set_value_cansleep(priv->reset, 1);
+		ret = regulator_bulk_disable(NUM_SUPPLIES, priv->supplies);
+		if (ret) {
+			dev_err(priv->dev, "failed to disable supplies: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int xvf3500_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct xvf3500 *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	dev_set_drvdata(dev, priv);
+
+	regulator_bulk_set_supply_names(priv->supplies, supply_names,
+					NUM_SUPPLIES);
+
+	ret = devm_regulator_bulk_get(dev, NUM_SUPPLIES, priv->supplies);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to get regulator supplies\n");
+		return ret;
+	}
+
+	priv->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->reset))
+		return dev_err_probe(priv->dev, PTR_ERR(priv->reset),
+				     "failed to get reset GPIO\n");
+
+	return xvf3500_power(priv, true);
+}
+
+static void xvf3500_remove(struct platform_device *pdev)
+{
+	struct xvf3500 *priv = dev_get_drvdata(&pdev->dev);
+
+	xvf3500_power(priv, false);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int xvf3500_suspend(struct device *dev)
+{
+	struct xvf3500 *priv = dev_get_drvdata(dev);
+
+	xvf3500_power(priv, false);
+
+	return 0;
+}
+
+static int xvf3500_resume(struct device *dev)
+{
+	struct xvf3500 *priv = dev_get_drvdata(dev);
+
+	xvf3500_power(priv, true);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(xvf3500_pm, xvf3500_suspend, xvf3500_resume);
+#define XVF3500_PM_OPS	(&xvf3500_pm)
+#else
+#define XVF3500_PM_OPS	NULL
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct of_device_id xvf3500_of_table[] = {
+	{
+		.compatible = "xmos,xvf3500",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, xvf3500_of_table);
+
+static struct platform_driver xvf3500_driver = {
+	.driver = {
+		.name = "xvf3500",
+		.of_match_table = xvf3500_of_table,
+		.pm = XVF3500_PM_OPS,
+	},
+	.probe = xvf3500_probe,
+	.remove_new = xvf3500_remove,
+};
+module_platform_driver(xvf3500_driver);
+
+MODULE_AUTHOR("Javier Carrasco <javier.carrasco@wolfvision.net>");
+MODULE_DESCRIPTION("XMOS XVF3500 Voice Processor");
+MODULE_LICENSE("GPL");

-- 
2.39.2


