Return-Path: <linux-kernel+bounces-11831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E1B81EC44
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897CCB22370
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 05:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1824C9F;
	Wed, 27 Dec 2023 05:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="KeJnTNke"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2012.outbound.protection.outlook.com [40.92.52.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505513D7A;
	Wed, 27 Dec 2023 05:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUHVF0j+3cIKZtrXzaPwbJe/EMfVYTOceyzIm8xVu73PGW2hr9E8Nda6Hmc1N7xHCa4GZvkYniLWzH9cAveClRoGjR7AQXsrQc0oW0Ziwl+rCgi6FuoOYxPJB81zDLcWl96V5FFG8rk4OdcB7unW4rycYSr6aQmxvSyqBtVRam2q9G/DJWNO6DszB6SVWExBSd6FNuEPRz9JJ4Y/GJYBD7jjmo995JMCEFGdIasA5ub9SpkHhB+d81Zgh+Z/i+4gNIrejm3JNdZAmsfxIUTMxfoQtDzi52co3dlIUf/snHn/StMPdBNE7niMrXEFYJYW0/PqnI/lJxzY8BhBPTlNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gb2AYUGcFuQ5czTHbaq9/vfUsxOl5J6XNnomTPkdZBg=;
 b=j3G9HKFM9p7mXCuAucFjEpO8/E8OUrDXqWYMBmJ7SP1+Bmplc57WuACJiNkt6HDZAKzXbxg08zsQC5jz0PMGdhlj7cEv+ZkvFXS8kCUTRglQgtljsc5yNtYCEoBXMmOMgxqYDTuT5PCQHd+cAuCCYLxezPLXCE4k01ZovGBtO7xB5ey0Fctt5kI9bdLvhx0Fyzfo1hJGtezE8MolbDs85XTIzS24Lta0i7JHJHBSbFSK45xgGtYzjjC9/I7Gonq1diRb37NNCjGdOFam2Jtm/BV9jbKp9PZ7V/AJsDvtF1oRSOu2ZhmriNborFLNRR9G8BZM68ICQH3H2OgCHdmjZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb2AYUGcFuQ5czTHbaq9/vfUsxOl5J6XNnomTPkdZBg=;
 b=KeJnTNkeQXRYxjWpbB6ngrp92O82mnOmP3xP9r9qrAwDGBhV8VI3fGQeajcnaOxIBh7pxCnzGI/tnEBcbP9Dk1Sjf8+AlsTh5mMcQkwwAYke+edeOvuqhEIWKrJSOfByzjybnxRTKO95qZVpwAqMS+TB2ypjOqNyoZrB1yhau/RqNS2sJYp85Bs9BgQUUk3uUOx9w2AcvznW7QjnMg8XN7o7r37ixRwnAu60lk1T7P36rLozX2SO/6234IelQLTdtuI9M5T/NQTYWH941BeeMBkZnofgHy8xlTT+zQJrwSFcetCRmLxE67f/D/mJQHceC2uBE0rAbxkrp97oU3nqDQ==
Received: from SEZPR06MB5608.apcprd06.prod.outlook.com (2603:1096:101:c8::13)
 by JH0PR06MB6977.apcprd06.prod.outlook.com (2603:1096:990:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 05:35:22 +0000
Received: from SEZPR06MB5608.apcprd06.prod.outlook.com
 ([fe80::3786:2a86:9685:a19d]) by SEZPR06MB5608.apcprd06.prod.outlook.com
 ([fe80::3786:2a86:9685:a19d%2]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 05:35:22 +0000
From: Allen_Lin <allencl_lin@hotmail.com>
To: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Allen_Lin <allencl_lin@hotmail.com>
Subject: [PATCH v3 0/2] Add HX83102j driver for HIMAX HID touchscreen
Date: Wed, 27 Dec 2023 13:35:07 +0800
Message-ID:
 <SEZPR06MB560853A09167B9C804F1C53B9E9FA@SEZPR06MB5608.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [e/Nx10ubnAZlmJ2OqvIHmx2ml5pJJMqs]
X-ClientProxiedBy: PS1PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::33) To SEZPR06MB5608.apcprd06.prod.outlook.com
 (2603:1096:101:c8::13)
X-Microsoft-Original-Message-ID:
 <20231227053509.894642-1-allencl_lin@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5608:EE_|JH0PR06MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 44033084-dd88-4d27-d227-08dc069d9e7f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5//2s10KFRWXq2KZhlYxLHPDkYobj2/hMQEl8MdYj+p9sWV2Iks6M+p8CtkSr3KnCVsabj0+/40wmuvJT+DotohkerGdsUhmbH+ONcgJJxKBxafPTQZ14mMZ6GYl2SqticqYS60Ezhd8gz6hgtwLGMk8bZyQLPCWqtNpbaaNIdrAhr1ik8VV9gh7md0XWovlxKrazdLxTR5tYUvvKXldbBc3hqaQj3u4l8xzNXV7hJLwvxSMzp77X6v1Xg8kdi5GuFUme9JAc3Q3BPoYc30b9cr8fC5y66XeJENuySSmGGzgZHCZj9eRGmVNjSwjw8PDvDgeMenA61hbgaVlm2qHNyWTE/3fNzqN7SNIskc89+ruKVGjw1ganDIsS6xZDh5wyqB2u2UmBhjR01omlflBmaLMk2b2j7+FWoUhgcp/3N7vcWfaahyEscoGtBeLJuBTVOLAKuzK+v2VNlheRecX0bhacueub0gUFlwnTRH733C+988UgwZpZ4OdnG5UHPm3egxGccY4zPWIBspjPAMwJZG0BkwVBqEtiSAu6UB+vTmBVjh8D48yONyHGRHlFqKambx3SF2Tmoi9r6DARl1XogLy9C/b0P1+Kp6o3d88DH1CzLZ8phwS4Nla7//ZAF29
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iKd5O8GOtO8vKBd8UOJBzLH0rW1qQT6sCCsHq7Gf5LIVVihoOkEVoVyJznwU?=
 =?us-ascii?Q?xtf5M8rOATDuXTAACPlZCa21JU4IW67cnVp+FVoTHjDQXg+K2ttEsstC4YM6?=
 =?us-ascii?Q?gCWMJA2jxeKzI21WEpWWDxRJwpkpKqwC+Xalm+1nU+ryLVH8w8x4BHDBRKMO?=
 =?us-ascii?Q?O/YPZ03MUlMxR1sg4j2Is+OsX8wbLJdaznUG2s8Qb6s4D7wyQ+XBKDZ7tzt4?=
 =?us-ascii?Q?CHISygt2PU+IcNxvRAHrz2O2J8yOS3O/YtV3tJWAZKSUF/AjzOBb2/TcIeQ5?=
 =?us-ascii?Q?4P9NEyftG4timfyUAAa9ltJ/tx2Xq3F8AeMaQiHec3J65DeItszVy9t2tt/K?=
 =?us-ascii?Q?hWdcF2yZcVIVA9pDlZiiOsp8Mn3A+XAf5tiMyCFboH7ThLRyvWByUFJDFw+j?=
 =?us-ascii?Q?hzfnla5619NBgJzDwM0nVyLOiwQNHtszDfhJLMNBmtgj0cx+nBxhEUPq55ii?=
 =?us-ascii?Q?IwGWquFS9bhgn3wm2l8OhW1kGj8leTE71X52SpmVCn10Nrw6uc5Lx3XR0XGa?=
 =?us-ascii?Q?OyKBYtJr39ThnjEbrU9/ul+ZE4eb0uB2Z8EAc48n2Lh0mpgNjaOt6En83rr3?=
 =?us-ascii?Q?CGHR4y2jYPLoCfeGyuC6UF2lziFoS6BPAZFUfsfHwKYCcZZBO+pTJIKmOQXG?=
 =?us-ascii?Q?Emxmae+h5HzvgH7XscHCXMy/8GuyWOQ0dZI+fk31LdVEGzv8EvCsskS8LCAz?=
 =?us-ascii?Q?3eV6Bav9zsass/DuvAE/Nu2kMrCkvH9FbH7tC+evlvCTWOSsHPrDcixLGE/1?=
 =?us-ascii?Q?+LdVPvTvF7yUhK/29dB8+87Al8KwOTNRdX15RAf6QZnUvAjTZEoloWFWsN7Z?=
 =?us-ascii?Q?6s0Yn5gMQj96qxoUi2FhPADRiZS2HWxyWW+BvVKGBj+3eqGc00punXY5Coq7?=
 =?us-ascii?Q?j4ce2CbDe0JyiH1UhDkNdvhqEiPXExUxbwmmfutyFzEmlvF0wQWAJlly1Zrb?=
 =?us-ascii?Q?JFR7BEIWXQTerjOSEApEVI9R42+AiHOSEYSNDLYIFaIQAE2LeD317Hg2aFFE?=
 =?us-ascii?Q?K4UHMtzUbzuTzIiu+1oU40jKqmT61RVQdRw8jnhx5yeBmJtzSBUxYh2OlQmO?=
 =?us-ascii?Q?U5H6w5AJqx6Ms4s5EX2t6xH8YlfU+OJq6yXFKW0v/g92ozFPhTuSksdut0cr?=
 =?us-ascii?Q?/GkojShSaNW+WvN3QG/0Fd7RwqfMrHgbNX8cTQtYZoK7fawF5nPlMznIbuJV?=
 =?us-ascii?Q?L/jg4nsF1YMtAmxL/BBn9JeBGLfl5vEx52E+sw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 44033084-dd88-4d27-d227-08dc069d9e7f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5608.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 05:35:22.1867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6977

Hi,
This driver implements for Himax HID touchscreen HX83102j. 

Using SPI interface to receive/send HID packets. 

Patchs notes as below 
1. Add the Maintainer and devicetree bindings document for driver
2. Add the driver code and modify Kconfig/Makefile to support the driver

change in v2 :
- Fix kernel test robot build warnings.
change in v3 :
- Modify code according to review suggesions.

Thanks.


Allen_Lin (2):
  dt-bindings: input: Add Himax HX83102J touchscreen
  Input: Add Himax HX83102J touchscreen driver

 .../bindings/input/himax,hx83102j.yaml        |   65 +
 MAINTAINERS                                   |    7 +
 drivers/hid/Kconfig                           |    8 +
 drivers/hid/Makefile                          |    2 +
 drivers/hid/hid-himax-83102j.c                | 1096 +++++++++++++++++
 drivers/hid/hid-himax-83102j.h                |  202 +++
 6 files changed, 1380 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/himax,hx83102j.yaml
 create mode 100644 drivers/hid/hid-himax-83102j.c
 create mode 100644 drivers/hid/hid-himax-83102j.h

-- 
2.34.1


