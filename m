Return-Path: <linux-kernel+bounces-25781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E40E82D5B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7788E1C214A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F008BF9C2;
	Mon, 15 Jan 2024 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="uSCfaWUs"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36BCA7A;
	Mon, 15 Jan 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnPgPiRc5HMEOzrMu/JoIfulzqY3McRMyiiKyLZlZTiog3EN8EZcPqHxKwCXZVJfJeam7RK56AsiqXfvGk9e+DV/YPE5HsMz+YeExJEaVP+9dEsegIQPgjo1aomGaRy8eOUBqeZ0a60wLAiEL8MddNcWEM7KkSJFj1AyqX2EmFzonsy93OrFObyMczind2YK9+MqKM6oLYZoqE9FoGcxEE3E7bj4GJk28qiKGSIWZOj4klnNTzoTFtotbwSv7q8Xt5YDSU6XGijt6OZtIe/CdyEPL20SJ1xMsBxe4rLnQcYGYVD+EYDLO3hZzkMpwqe60NIx17nNhC9W1hDmodLKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXGpWS8USjWi9RTxYzhG5mHhW6v+pt53C1Nrcadd87g=;
 b=GNC2JmnEA81pD2PZu47IOt2lDDUL6LB1/QsjBtWZElDQouQiBup7PS6QMqtos4htMSl37cKkM6h7iyDNtUsIRT7Rwu+Y+xrT4Zz5SlwV45qTN1z70v57E6aWplUt+JtOAteoaQCHctu8qMxACdDBnjEmoC8lmIJX6/hqtQppmYExi8/mi7J4zGAuUfUJKTtnIBWCxWBBV8LSLtE5opbKz//Jo+6skgWkifO98G1PBEuKuK6oTnIACcd4blRXzQHprjbRuYgA8XVNcnMQVx04hM1V55VbSO8nt5B8Ga6LVgUml0UVOq6hGcqnHw2J7d0uNKqPdZqN/ZsSfy2b2/VbeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXGpWS8USjWi9RTxYzhG5mHhW6v+pt53C1Nrcadd87g=;
 b=uSCfaWUsRi5d3d7AvH6sPgCWbrgQPJGyeSEIcHj3xBtKONlmRiqH7l17y2wrHQwM7f/uuX7OidG6+QI/p3u2XhtgWEymHOSgW18OJHs8SFyCtUJasETK5gVjOigWsOYwT2LfJbM8+ewLIMBoMJT0hbo9Ct97+saS3BJi3VO6vEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM9PR08MB6035.eurprd08.prod.outlook.com (2603:10a6:20b:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 09:16:39 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 09:16:39 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Mon, 15 Jan 2024 10:16:32 +0100
Subject: [PATCH 2/3] ASoC: dt-bindings: xmos,xvf3500: add bindings for XMOS
 XVF3500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240115-feature-xvf3500_driver-v1-2-ed9cfb48bb85@wolfvision.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705310196; l=1849;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=ni2dtHWBhPqUUIR7Lgbm7KZN1KzjAuAJdGMwDarzwWM=;
 b=w06Jag3yG5AYipCk53/pKgLVteSvbFm7yk2EG5flLCpnj740TDte3gx1yr6BLHOWAvJjPncSK
 86p7QnIIAciCBAh6/OzMMALd3CL0TZU+kyBkdFvdTzXpVc79mZRtU+7
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
X-MS-Office365-Filtering-Correlation-Id: f344b796-9bb6-47ba-eb53-08dc15aaae33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1Du1GDxS1YBk7nUrYbOtxjZLLeVloS5flwfLsP4stkA8oS8Zj7dMRkcz+vPVMJ2ALDPXrwsDpTRJ6U5AMjNNwH/BeynKFazLLWvwHcrJ8yF1vrD2I0DRxP8i5xfYwpm6Lgy1NXNUZENZoPefl6e4zuxKeZ5qQQf8zDmsctD95dzKAvaptzh2S4R8uyNnhTIDWACdq1nLZcSnERKxeVEyckJA4sv7URubPKduiZ278dlHDplWG2EpBQBxdPRODi99B++DcCsTkM82gF1jF1EB+Mzd5G/RinQ7Q3WW3FB8YxP8BGzqLDLqo/WJmIysHBDEYPYKwKl6LYKqrS2faES2YvaCObAa9gW4WBF8yc4XPKI1+T/Rs8pjOfJ5qvITg7KGrs7fP/ewikjQoXw1f48SD0/CZKeZrFy9f7a+8XB9wI9cYKNnx8YoX9CWh5W6QA/JuRvlexy9dPk1bAewuFpF0hi9JIH4f49m/kIAWa+rIIBrwhhzqcHiAQC2myAnldiF/+OYlDeWoeDmHdaY/RbVF16bHVFS1+8c3gy0k6X+Eym9ZI5dNsoL/PSYW5IAdNg33DPgVFDNsnVSLMP103SokABhl9NcWenVVldgodacWZw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(38350700005)(36756003)(86362001)(66556008)(26005)(107886003)(2616005)(54906003)(66946007)(66476007)(316002)(110136005)(6512007)(6506007)(966005)(478600001)(8936002)(8676002)(6666004)(52116002)(6486002)(41300700001)(44832011)(2906002)(4326008)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEJ4bWZ2YXdmMEpYaUJNcTZtKzdqaGl4R0VjSllhRkp5eWVodDVnNHRjUGNT?=
 =?utf-8?B?RkNTdzM1d3owdEhYdEkzY1h6WlpDbWNlVGs3V1pUK0F5UGcrT3o5MzRaN1kr?=
 =?utf-8?B?MTdyajhMZlVEYVU2WHltQnE1Zi9uOVZ6NzlPYTFEUWxrT20yZFppN04xaFB6?=
 =?utf-8?B?SWpqaVQyVWYzcjUrMlVsanVxSHhKNFZWWUdMcGJNM05ic1UyY0h2VGljZE1q?=
 =?utf-8?B?Mjg1NkgzcWIzcmtsMHhUdDB5MXoyRGVpR3NpQnJSU1RxdW5wU2ZIUnNSeWpx?=
 =?utf-8?B?MG85WS9wTUZ3TlRFNGpUcElWWEwrWnowRDhWZWU4dUhSWUlEenFiM0p5VUR0?=
 =?utf-8?B?Q2hFQ3Y3OVJNczRKS2ZwUUM5WnYwek1IT2h2T20ybUxobmZySU4wVjRWcFho?=
 =?utf-8?B?MEswMkprVzltQlVkNzZwWUZsNzhEMmlKa2lUcHQ0ZzdFTDJ2RU1zVjduVmE0?=
 =?utf-8?B?bEpoelRPcmJiQjh6Z0d5dHhDbmVoSFZ1dTY3ZTh5NFBuaVIybUxBaDZUbVIr?=
 =?utf-8?B?NnAvRWFEK25GOTFVM0VpejBxVlk3OEVJc2ZheGQzcnczZmFoZlRlWnFGbElS?=
 =?utf-8?B?cnJpV2EyWkhIY2ZaQk5xL3hlS1RTT3lpNFZlUVNadTRTY0xpc0dSeTJKaUVI?=
 =?utf-8?B?MXJuNzZOazFBRTlRdUVoUlh0NCtEeDdKdVhBTk96cmZudHFLNWJOaFpUcVJn?=
 =?utf-8?B?YVRjQk5OMTJrY2w3MitlTmVhSkxLUXo3RjVCSHZjZHU1WWJZM3AxdWNQeEtu?=
 =?utf-8?B?YXhEak1rMU8yeXBkZ3JvUnIxTXFZN3JkMGUzVHZRRUQ3QnJLZU5EcUhOdTFC?=
 =?utf-8?B?UEVVWUpHenpXcTZXT0VaTjhLak9qcUNwa051YURLTGlqK0kxL04yWEhpaWpD?=
 =?utf-8?B?SHNnbmFPQVQ5MFgza25Cb0hQU3NHNGFKT1E0ZThlZEVJQTBUa1UvZ2Z6VS8z?=
 =?utf-8?B?S0FZblNPMDBQWkdwRHdmbjJ2RWpwTFpRUUFJRlQ4VjlJaExDTDJONnVTSDB6?=
 =?utf-8?B?dlRidUs5U0tIM2FBcVgwd2YrdGN0RGJPRFVuQ2YwaC9LUUd4dE5jL3Y3M05D?=
 =?utf-8?B?T05SSFZ5TTFMcHNCOEo4OStjRml2QU9UMjZJWVdUcC9kbmhTSFo4K2RkQ2NO?=
 =?utf-8?B?TnNtY1dyaThOTFJ2L3IxMEJCeHRtTG1SOFB2VkJKNXlyaXZ0c2g3YXdGeUEr?=
 =?utf-8?B?ejlOcDZSM21xc0JsWTkvQmxMSEVvYml4VTZHOW83czlKUUZOdFFpb1o2Sjkz?=
 =?utf-8?B?ZmpTeWx6b2wrNEFvODZscTRsdmJ6TlFHOFZ5UHlBYUsxWkx2RkFaUG9iMk0z?=
 =?utf-8?B?NWV1Z1JBR0dnWWR6VTFENDFMVG1oR3hVa3FIQ2haMWE2THowTXBDVkNyUEJo?=
 =?utf-8?B?b3FrVHBoU3VTVVBzNFFTNGt1OWNTUDZVTGxTNUZOQmZvU1RhN1JIU096bEI4?=
 =?utf-8?B?OUZIUWpud0NVRktMNlUwUUNvLzBzQ3ZuUzhaa2JTc3hXbjlyOVhqMC9vMkZk?=
 =?utf-8?B?amlNeUtGenBZUjV6QUxwTGpQVGlucU8zblhyc2J4Tkd3T0pzNlJYODRkT3Q5?=
 =?utf-8?B?STdMWkpsMjZpNjE1T25SZXliazZTcnB5MGdtM1dXMklSdlZCMDlwR0VyRjFm?=
 =?utf-8?B?TzE4cFh6UkZGODg5bkxBWGhpRldtZmR4dElNc3c3b2g1dHZrdWRYNXYyYXZ3?=
 =?utf-8?B?Zkl4Z2lhTlkvc2lGTE9xaDBMKzFhbmY5aHhKYjhEN2pjRXpLbWVHT0ZmMlRz?=
 =?utf-8?B?UW5zczZpOXdTQkkvM3RDaElRQzM3TEtLVGtzRDBYeVJMOFpwbzB0SThwZStJ?=
 =?utf-8?B?ZkhPT3pzcTZuK0gwcnFTbGF3V2NiRjhrci83dUl6RUZURnRrMDk0MUphVisw?=
 =?utf-8?B?azBDa1pJWmdKMUxCdExzV2ZLNGRNY2ZWcVF3ekwwR1I2endzbzhwRllZalVV?=
 =?utf-8?B?SS9mN3Y5RnMvdDRZeFZPMy90N1poSjVnd0pzYWZINU1sdzFWNjJoQVNUa3Yr?=
 =?utf-8?B?TzdrbWdhOUk2YysvaTBYditYU01wL2haNFVMQis3OTVxRElhQ24xVTNiSVpx?=
 =?utf-8?B?dk1JUjJDdXVWTzcrSmxlWkFUUkZnb25uOHNUbjFRL1BJTnV6aVlLM0lMditF?=
 =?utf-8?B?bEpIUVdSb0hIa0xsQnlBQzc4OWlDaEw1UXNOdDBjS2IveElITWZxVFc5K2t4?=
 =?utf-8?Q?zresCvoWwHh8W2o7KusInGY=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f344b796-9bb6-47ba-eb53-08dc15aaae33
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:16:39.2277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxibH4yDhyDZBKM8F0kcmsMduG2SGoDst4SrZBZE0GHO8lrBLvsDLgekrK9Et5BywvXuLIHMCc8CkigLdTJxuppjkzMjke1dNxWZwjzHQ0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6035

The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
multicore controller for voice processing.

Add new bindings to define the device properties.

[1] https://www.xmos.com/xvf3500/

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../devicetree/bindings/sound/xmos,xvf3500.yaml    | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml b/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
new file mode 100644
index 000000000000..e93a735a0f1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/xmos,xvf3500.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: XMOS XVF3500 VocalFusion Voice Processor
+
+maintainers:
+  - Javier Carrasco <javier.carrasco@wolfvision.net>
+
+description: |-
+  The XMOS XVF3500 VocalFusion Voice Processor is a low-latency, 32-bit
+  multicore controller for voice processing.
+  https://www.xmos.com/xvf3500/
+
+properties:
+  compatible:
+    const: xmos,xvf3500
+
+  reset-gpios:
+    maxItems: 1
+
+  vcc1v0-supply:
+    description: |
+      Regulator for the 1V0 supply.
+
+  vcc3v3-supply:
+    description: |
+      Regulator for the 3V3 supply.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reset-gpios
+  - vcc1v0-supply
+  - vcc3v3-supply
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    xvf3500: voice-processor {
+      compatible = "xmos,xvf3500";
+      reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
+      vcc1v0-supply = <&vcc1v0>;
+      vcc3v3-supply = <&vcc3v3>;
+    };
+
+...

-- 
2.39.2


