Return-Path: <linux-kernel+bounces-6585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C23819AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74DCFB21C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D99A1C6A8;
	Wed, 20 Dec 2023 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="pqRfgFo4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74951C2A0;
	Wed, 20 Dec 2023 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHt2k1mS0eb35R6so4DsAPkZDE3CfkiZebE9X+VITtC9f/821GS3i0vjpzEbt+I1EbIVt8hs4275QbebAB0Q9Vt5hF6CIDlemXViFEiwGu1MkvVPAMBJ+fkx9KEIzmNS/q5XXBl3jqWP4C1mQjOOKbSMPtjLNzekvAWWEgRc/nI3N0XaGyh5JbmNSxBQ9EVWPqSLbbgCXwJJy42L7PIV3sVbO9zc/+L/RWf+b8bQXdeyJ4kE+w6ZnFo/BVzkrbZKgA9oDyCXCCIeFmEBGvfOkh/cH4NpXoH6EUt21s36oaVFP7waSsY4w89+a/WQqUjBacVSdBgnZjaP+rF71A2R5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qLHJ9dqYB0OtTc9zrZYnQffNyM54mPTprYb0aT4iZ4=;
 b=XMPjQknL+d8MvgtTkD43gf0xeo0Bjzuif9rdOLsLlV8jueHUb1iSaos77wQ8OEaL06kc850ew7AyTT0TAE8x6N2vDu1rMC5smO+Dj2/VggLwsbQ6XIvBcv4u/LMkGHwEIMJlHne2+0HyCV3XOLpfAnwuWFAGzbICAcE/XEjyRkq7UkgN0XqMpepGAYXAFv1ScZGxjIMN0AGSRsrbgJdyujxAdgEq5cKGAYiyjtOVondTGn+6Ke4ZNNK3dHmZkKedrNWPt+ezPr+VgSdZ3gI9DuXuPa471BC0zgvqr0b/KEf65XwRGmni6/0bkMb0ku6Dta+zOzYnr4bpv2HWiVfa1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qLHJ9dqYB0OtTc9zrZYnQffNyM54mPTprYb0aT4iZ4=;
 b=pqRfgFo4lifMJqqqgjhIMmGSI1uKWJ9w8zXHZk6Ziiolqi/8bg9dHCiBWTr8sfahFVflhgJWN6YFpqZxP4fEc51LcYEzkP3ccP0sBon1s2JEMTtOeVlJGInRtodVHlF7X1kFOdPmFbqy1zVxygHUkWnzv2uwCqNJdZTn24hDQe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PA4PR08MB6080.eurprd08.prod.outlook.com (2603:10a6:102:ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 08:39:49 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 08:39:49 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v6 0/4] Input: support overlay objects on touchscreens
Date: Wed, 20 Dec 2023 09:39:42 +0100
Message-Id: <20230510-feature-ts_virtobj_patch-v6-0-d8a605975153@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE6ogmUC/43PQW7DIBAF0KtErEsEGHDaVe9RRdEMHmqqyo6Ak
 laR715Il/WC5WfEm/l3ligGSuzlcGeRSkhhXWqwTwfmZljeiYepZqaEGoSRgnuC/BWJ53QpIeY
 VPy5XyG7mpOxotACgUbP6HSERxwiLmxtQ7FHz6GQbXSP58P3Y+naueQ4pr/HncUSR7bVjX5Fcc
 ANk6CTRKatfb+un/2twXCizJhfVq6mqeXsCi55GEH5XG3q1oWqoPY7eaQQcdzXdq+nW1FknvJN
 Ek93VTK9mWlNv0Tg9oX0e/mnbtv0Ca2iizRgCAAA=
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bastian Hecht <hechtb@gmail.com>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703061588; l=3573;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=tpM+Xc0TAJ3ZjF6V53JVkBDUPs73M68wuHcVutzJiuY=;
 b=r5CcnWHuNUyVo+srKUPcZZHHS8C+ndIP338rIXg0cwYSlSc2B1jAAJYG8JdYMN3Oju5hNnDF9
 0ucNmKzc6tZDlAvItd0N+av23dR77GusjBIpAGCz9Vxl/kQgxc2BfB6
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR0502CA0028.eurprd05.prod.outlook.com
 (2603:10a6:803:1::41) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PA4PR08MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e9e10b-2407-4095-f44b-08dc01373a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D9Q8jKyk9p9XC2+r8LTmpM2i92aTOOTgxinYVyrLmjV4l0dWt+z54/89WW3B1KXffvuj7Xf81JOvoU5hd9xdhaIuM629kFTLIixNPdWHUFyerKSDMPbRcPo8ksYmiQzepFXUOam4pQu6gpXg8LzqQ1ABRsMPif/cX0eYzay95tU8DmOSKI9m7pnqLdUflizk+mdPSP4O0TpGzkiQHAKdzsP2v/q0Pbhi28OsnITPe2bCl6V/lWj+MvOh64GFzBBk6rVZReh26TYQ/J4CAjeuHzJbE1hKyyvxtVrxnhCuP1F+RzXXYppePDh0Nrssxeqw0Quli12fKi5+EshTXdPsE138wy7NTD9pvwlXwK3itb2GDjH8InFa7BDy4WAntKFJStUbP6XSajlg9BJEwGqMubhTgDEL7nbtWaKuqenHJmGUZAe/iXgtS3nYa/j/wX+4DPWVl+uYrRSKSsvmE8Npkis/+NOsH06K9mXUiUI52UzeFZxReTGYy866oBezWM4BnrmCOAqQdoNjT06HJnp05Tz6n4qbawBEQ8kt5eowm6amMEEqGnyAYSRbLmpzDll+wJLchzHdDj/VKbN1fw11ikT7lRldSQUKeg1ZeiGVxGE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(346002)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(86362001)(6666004)(6506007)(6512007)(52116002)(478600001)(26005)(107886003)(6636002)(316002)(66946007)(66556008)(66476007)(44832011)(966005)(6486002)(110136005)(83380400001)(38100700002)(36756003)(2906002)(4326008)(5660300002)(8936002)(8676002)(38350700005)(41300700001)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDZDdmhUd3ZWQUpmMmRKTXgxMEY5clZuNzF0T1FlQUdqL25EUDFPcms3UVpm?=
 =?utf-8?B?RDFNdUVwaTJmMmtSSmE2SVhxODJ5cjhvaHV3cVRaaXBObHUzTVhteU84RnBR?=
 =?utf-8?B?WjBkL0hVVk5zbG85UE9Fc1pQd3JVaGx2STZucXNFOHdnQjc1Z1V6RDNmVTBB?=
 =?utf-8?B?YkpVempmWUd6N2xpeC8raVlPQ1d0VmlxQ1NBQzVJSE5kQlBLRzVNNGluUXVx?=
 =?utf-8?B?WGdmTURBaXV6NFUrR2RiME1MYjBTOUdYSU8zZ3FWTk1VK0Z0RVhyUDU1MzIz?=
 =?utf-8?B?RFdvUmc3ckJTditOdlVETlRJdG1SVXRpSmhHa0FwbFlBQlRoT21mVnJwNjJJ?=
 =?utf-8?B?SGpQMU91SmlMUkU4ejQycjVVQlhEMjlTekpKd2dES1pCQVgvcnZva0lXOGRt?=
 =?utf-8?B?UGtXSHRKOUFxWDFMMHZEa2UycnNROVhSZUF5SUZvOXhZODZUd0tNZ0JGOFJ0?=
 =?utf-8?B?a2c1L2dRbkxNMkpvWWtaem5nZisxaFhscEprTnIrWVU0N2g5TjN2SHFTdXBh?=
 =?utf-8?B?UzhkdlZVSlhIM2dQYWwzejU3bDcvQko4dFU2bFJ1bHBzNVFTa3RSV2p3NXVq?=
 =?utf-8?B?NGczRHBibG0waHFQODFmcU5MNS9FWTRpL2FtZy9EaTJNa3RaM0ZMQmZrUXEz?=
 =?utf-8?B?TE1QQmZwVHpiaTBNbVVPclZxZDlwY3dJcFZRLzRJRmxOTC8xVU1tQ21oSCt6?=
 =?utf-8?B?ZHNCblR2aERWT2lDMHJmbnhIK1A1NDJxRXpvaytmQjNETDBvR2dHODlJOFJn?=
 =?utf-8?B?T0pZYVp4dytHUDNIM1UzSWllUU9uamppdmRYWktLVzI0elNBZHd4NWJOaHpv?=
 =?utf-8?B?S3dScWJFd1RxeDV5bEphSFdpNWtGK3p6QnlKbTN0bGI1aWtBdWNXZWpHd3Yx?=
 =?utf-8?B?RUtOQ1ZhUE5ENXgrOHFvc0VwQ1d5WnJpbUxkcEZNWTBnSzV4NUVCM0ZCbTJz?=
 =?utf-8?B?QmMyU2xXSkVnVEE0WE0yRnluS2FsYkFPUXd0NGpaMXZHSzBDaldQWGV1WGFQ?=
 =?utf-8?B?Lzd1RXpJcnNHZW1DR0xqWCt1enpQRXdVc1dna2hzMEdLWkc1TGJGZ1M5M0JK?=
 =?utf-8?B?UDBJMmdVOERvbmNLV1IzZjQvbXZlRFBrYUFTNGJUbHdzQnNHUUU5QkhOaXY4?=
 =?utf-8?B?clh2aEc3VWdoNUM5K2VOOHZYZ3dtay9LVEdaTXVLMjNZMDM5VUpEM3dYWC9o?=
 =?utf-8?B?cjJVUWtaaXJFN0d2UFo0aC9sTEExTkYvMHRteHpnSXprOVQxblh1bVQvcGpX?=
 =?utf-8?B?bTJDVXEyeWJxNFZEbjhFZEVvajl0QWg5Ri9YdVQwS2JhV1F5dE94UHlFc003?=
 =?utf-8?B?ZHloVjdmVDQwVGlJalN0Z1VySm9LbUJKZDROL3Jic25DVFF4TFdPMG8xUmd6?=
 =?utf-8?B?dTE0Y0J5b0t5RjVlQVR6YjN3UytScURKNWhTVmhzQzYrc29lTEJ5Sk93T2Iw?=
 =?utf-8?B?dlpHcWp2cm85ZDFpNUJObS9ocUxoOFl6QmRYUzlHWSswRGxESVhOc2o4ZmVV?=
 =?utf-8?B?R3o1di9yUUJ4Si9nM0lMaDhPRmtaVjFyUE5rbUJvdFJ2OHNKdmo5dTZCNDBs?=
 =?utf-8?B?Qm9BWEo0ZWcrV0w2QlBBS3ZYYkx1T05IczkrREdseXpiSFBYdnhJS1dmcnBG?=
 =?utf-8?B?MUdEYkpyOEFPditSbERsTmFxNnlSWGdlYnBBUmxtU0hUV0VmZXBUNlppSHc3?=
 =?utf-8?B?YzQrY0RLWUl4VmdWYzBya0pna3RTcm9ScGx5c1FiWmkxTEExK1lkeTA2Tm9D?=
 =?utf-8?B?OVFVemNEQ0xsMCttZENmcWtLWlJoa0V3R3hSMndaRzB1ajFyWCtpUC91QW14?=
 =?utf-8?B?MmJnbEtZeHROdFBZMmtOWG01dGFkSWxqRmY4bE9LOWd2K205V2ZPMHR4QzRC?=
 =?utf-8?B?WkZRM254bkVkL2ZjMW9IMVhUSlllZHpvclpKQ2lobncrclZ0UUZHK2ZuQVdT?=
 =?utf-8?B?QTAyTDN2UytPeUlqZ1o5aFljK2xhZG9TMDFqTnlnSG41Z3BQZEthWlNyT2h2?=
 =?utf-8?B?UEtMaDNMblVHUXlQdTl0L0dvTE5TK0lvcXhvM2FxY25MLy81MWtQUlA0VEpK?=
 =?utf-8?B?RitWclEvcjJaRHVCNzNMdU9HWnFXaWxqakQyRVhGWE5XT3p1N0tRSDQ2b1VX?=
 =?utf-8?B?a3BJeW16SzFMaitXL3hINHhKV1BlMG96bjRQdHlBR1ErcGtyTENxV1R2bGl4?=
 =?utf-8?Q?6Ks2c1o4KHskDt6f1NVWQBo=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e9e10b-2407-4095-f44b-08dc01373a4a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 08:39:49.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5o6Et9+3l+jPABOHT/KaTzHqfFbTJF90tkVJ8cnoG/LuwRSrtJ/lkIty84dY7e5+6a5hcsiiRRMTHOsVLVp7a+MZQIbVi2t9uoZ9Sczwuks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6080

Some touchscreens are shipped with a physical layer on top of them where
a number of buttons and a resized touchscreen surface might be available.

In order to generate proper key events by overlay buttons and adjust the
touch events to a clipped surface, this series offers a documented,
device-tree-based solution by means of helper functions.
An implementation for a specific touchscreen driver is also included.

The functions in touch-overlay provide a simple workflow to acquire
physical objects from the device tree, map them into a list and generate
events according to the object descriptions.

This feature has been tested with a JT240MHQS-E3 display, which consists
of an st1624 as the base touchscreen and an overlay with two buttons and
a frame that clips its effective surface mounted on it.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Changes in v6:
- General: use a single list to manage a single type of object.
- General: swap patches to have bindings preceding the code.
- touch-overlay.c: minor code-sytle fixes.
- Link to v5: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net

Changes in v5:
- touchscreen bindings: move overlay common properties to a $def entry (Rob Herring)
- st1232 bindings: move overlays to the existing example instead of
  making a new one (Rob Herring) 
- Link to v4: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net

Changes in v4:
- General: rename "touchscreen" to "touch" to include other consumers.
- PATCH 1/4: move touch-overlay feature to input core.
- PATCH 1/4, 3/4: set key caps and report key events without consumer's
  intervention.
- PATCH 2/4: add missing 'required' field with the required properties.
- Link to v3: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net

Changes in v3:
- General: rename "virtobj" and "virtual" to "overlay"
- PATCH 1/4: Make feature bool instead of tristate (selected by
  supported touchscreens)
- Link to v2: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net

Changes in v2:
- PATCH 1/4: remove preprocessor directives (the module is selected by
  the drivers that support the feature). Typo in the commit message.
- PATCH 2/4: more detailed documentation. Images and examples were added.
- PATCH 3/4: select ts-virtobj automatically.
- Link to v1: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net

---
Javier Carrasco (4):
      dt-bindings: touchscreen: add touch-overlay property
      Input: touch-overlay - Add touchscreen overlay handling
      dt-bindings: input: touchscreen: st1232: add touch-overlay example
      Input: st1232 - add touch overlays handling

 .../input/touchscreen/sitronix,st1232.yaml         |  29 +++
 .../bindings/input/touchscreen/touchscreen.yaml    | 119 +++++++++
 MAINTAINERS                                        |   7 +
 drivers/input/Makefile                             |   2 +-
 drivers/input/touch-overlay.c                      | 283 +++++++++++++++++++++
 drivers/input/touchscreen/st1232.c                 |  71 +++++-
 include/linux/input/touch-overlay.h                |  24 ++
 7 files changed, 520 insertions(+), 15 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20230510-feature-ts_virtobj_patch-e267540aae74

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>


