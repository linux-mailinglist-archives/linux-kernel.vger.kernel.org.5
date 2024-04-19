Return-Path: <linux-kernel+bounces-150912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3C98AA6A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988F51F2216C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBC417FD;
	Fri, 19 Apr 2024 01:49:12 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D82D7E1;
	Fri, 19 Apr 2024 01:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713491351; cv=fail; b=HkgdZeKvMIHw8+wwZL8h8bPUVYrw/j0yrAs8maFFUPLruVBmTRonQMum6dVOoWM5Zi79zhcvhjGJJ0EUn775ZI2xBBjdIUBd7wEem9DRQdPXsrhZnbS9X8UHppkjr/t0eo+0OvX5d5jkC1ycWW1z7iIi63nFCcFJ0pjzqwCgrv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713491351; c=relaxed/simple;
	bh=Ag3MDn6p/6BS/ABZ9IzkXBTWwMWiFDlb5QYyhmPG8OA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mGtbwREfiVkL+9fDxVEZSqE1vjVS//vrU1/WPSKsRpYgy9orpUHiwtiFhXuyW4uUwdJy1lNRH+IAA03jn3K1FUIstbhi6IPIgoz8C1k8mR/K1qHiUuV39TahItDqDurf+2sgB1iWP/FgsGyxhDE0PoMWsmJ9ZV7tjE4qtbTFYis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIscVibTfyi10/UiJd1EB09QkNWB9VuRhGHgUkowGsaFUon4nsm6zqU6NM5ekBeP3gwyoM9kTIaKk/EyTjRhJDk0rNLZcBQum3w7aT5xKGZ4YiV5VKzH3Fuur78Kq5sCE9Rs5HdP01oIwTHZYbH3qIoe/YDOixRmDT9xqLeGo/mGYCSFvZ3AFuq6w2/A3cvOqbscMYoQl/j1FQL/hbpv2YwS1jrnzdk1APCfdJAozg4zpfzwYiior7UhFe6wfhZKL44XUVqJRnHvya2kOPt7Xeu0PrjqAKsk/AskgQqaDgZnv/9yTOFJ5AZe/6QK9Q/AR7ZB0BUnvczTqQNvh1jI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uztfItmyI/tHP9/PuQp8o6lEw7N0wwpLxCU7YjUerk=;
 b=oT6MD1UDwVrihX0IqvjxceOmqD4pJFLp9WZ7M7jBPlGWIrHHhNUHjGS/CSULIYj4BspEoDkuknQPxciv0THdY2rW+FLxdH31L2LVyZKoqEOT5nqVVY6oBeZvmpUNUl7A3dE7zH86KqpAYX3aaGkcIc7poyrk+TMMzfI6BCk4phVS1AXvSh7HioaDQgkmD0cAmvJcKKfaoz/m5E99KSb+r5IQVGhxYLlTCPZGIM12RNvG8XQCI08F3zYMLrLLtEugf0Uho1Qw6xvVniPul8jg4d8hj1OZXC1a2MxtZ8zRoYHG4DrwaYY9HhlaLbDAM6B2JEHnB77m6dyWb5+onAxgmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB6810.apcprd03.prod.outlook.com (2603:1096:101:65::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 01:49:04 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::c4f9:d4f1:c115:f1ca]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::c4f9:d4f1:c115:f1ca%6]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 01:49:03 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: neil.armstrong@linaro.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: nick@khadas.com,
	linux-amlogic@lists.infradead.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	thierry.reding@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v3 0/2] drm/panel: add Khadas TS050 V2 panel support
Date: Fri, 19 Apr 2024 09:48:50 +0800
Message-Id: <20240419014852.715125-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0118.jpnprd01.prod.outlook.com
 (2603:1096:405:4::34) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEZPR03MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 37403cb4-9a83-460a-95f7-08dc6012e425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KuHOuy2yCiKRlcN/qjMTa9ukKQW8Q8c4CATWD5aiG2zgbh5t0T/rHbz0+zoN?=
 =?us-ascii?Q?VzngDf5wNyLoQ7L6XyAkTKr7yCRtIqvKMewg+FAJilILHkvmSjNHEvuigDtl?=
 =?us-ascii?Q?4YYeJvwMgcV8NgDxJKuFslG8G1my3LpEqd/jUv/XlQUntCpwLiYo8O9iJ3sv?=
 =?us-ascii?Q?0hSCH63wEFKEetZcVK4b4W/eLRJAtyAaAIiXfxx3CG2zKYoE3yGDiHUbZ5xk?=
 =?us-ascii?Q?8GIA+GOKqOsrxnUvA+d45e9OGE5Apcnh5cwuKW1HCzt4YoceggN4JzVfD5ET?=
 =?us-ascii?Q?IMKd6Bt09zwA3Le4rttk81yQT1OwHj7zFDGVZcq+QsNrxyUc4vUfA8c2u2mj?=
 =?us-ascii?Q?yfdV2OMfqW/NMH1zLUaax3PtW52z/8sLRlKRfVKLWuq20NKVp9ky80SMuonv?=
 =?us-ascii?Q?m9UOxqcPemkkLQ+QB0TT6jKsHRWZvPg00cM+tur2aeP5cKrPOh0drDKvCRE/?=
 =?us-ascii?Q?H7Wx+lqIDWN0MZDGrBucFmhQQyDfa8h4oHc0Od7jQVEXoPTg7KIBrjVJ2S9X?=
 =?us-ascii?Q?Tj9CGCv5mQs9OQoNQEfl1StChYfx5Gjg/yGIm3AOMG0Ajm7Yr2jvGTc6JGMt?=
 =?us-ascii?Q?HUq10fQv6lhie6S28ZSDF+b27rpxoOxHid815G4wf9mEYs4scvCobAYnXNba?=
 =?us-ascii?Q?gEyORc6kR1ubFOtAkAIDrSbnILObqYYDqov8Bc0dH+WrLnMCkXbq9HdFxWLm?=
 =?us-ascii?Q?WwgNmRfqqEtaKapaesWTJn4PeU6UGAFl/4m0Lz8t3ri4GfxOMsZ87zkhJ1xe?=
 =?us-ascii?Q?6auMka/YE97lq/LZ9vOfGf5y+M9QAFnVThrlexfojYG8Pifn6hplI7GNSgeR?=
 =?us-ascii?Q?lRguExc6kldE+g9r7WtUIMfUcYsdX5f6GR9+3K8ZVwqpUTsPmTyvb2FIPQgo?=
 =?us-ascii?Q?MgGftrswalBuxzZGPkSrhwiHChFeQCq7G/ykrqSfTduqkIpZyLc25pEvntu1?=
 =?us-ascii?Q?LETCIsf4FVGQXB79ets5OxM2+VaGJ0ubHXJ2bs34YhN28ZCzpTnCG/Yr5Rfm?=
 =?us-ascii?Q?7Kewd4YH8Mdwfj5KklgpS9To++k1Ir+bqeb6vhrS7ip0ul20WxaqMsCBYsYd?=
 =?us-ascii?Q?jyEIMdg+oTIxgCEvxcUoaGBJhm8VXM0GGnJSYctXlqer+YrdzrBAVSIwOYD0?=
 =?us-ascii?Q?kukprwabeVwffdsjVa/mgXG1nN4Jx/r5lRBQvg5G0aNvaj6mk5MfKMgd3GiB?=
 =?us-ascii?Q?32pusntdjJ7oCeF4dQq+Cd4/Ov9jQkxxMKQonh3XyOeGNAwwVKvPin6BCuXY?=
 =?us-ascii?Q?QImKhYkAcCM58VmnZCNb+HDjMrBYjpW52hMKUwrdv2/5ZMuKRh54rcIBfY4F?=
 =?us-ascii?Q?XURtmgx97zkvOf9ulSFeaUzYgzRQADk/dJUYTkLGOwer/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KPgQWLyl0f1EvyaNTJP1VTavtSi7Hbl9HuCbL1XZrsqLSNl4x8xECQYCf7u+?=
 =?us-ascii?Q?xxyC+ETJJEVPVlnTaMiojJeda9bIw6JudTU1n3rB4oiBgD1NZM0KLsVk5FLN?=
 =?us-ascii?Q?ikO4JAExSFu3NDpgqaacvFFsT75kSI+5GEl6h14Eq27dP41LhhMvlYgKLAHZ?=
 =?us-ascii?Q?eiP3/4WV8gh1rTJx2HVsA5h99rquABqXcZifgm6epF0UWgxkQkPWB9fqh//h?=
 =?us-ascii?Q?kZL435f7e39VmVpiUYTOZGuo4VYORDZQq3GTUkyuxGUQ4lpQAsWFoFCTTpkp?=
 =?us-ascii?Q?e+274ZfoaZHA1Q2NmZV4gW5OVwyFVhrdMTkh0d97YQyHEvG0Jkq5GR0KPSmc?=
 =?us-ascii?Q?VAlfD2eSKzh4AlUEZ+3oxDMj1NbaYHhKyVZAEXgIGaLCjiur4U3Oiviqaafg?=
 =?us-ascii?Q?Tw7rH5M2wPLncGX4cZM74DqIzPmEKOtas9JiSJDk8vJY7gmNWVEPT1gOor0J?=
 =?us-ascii?Q?fI5kuna78GTULtzww7D/ezqt68NlZs82vwDhc0vo4dMSWNJx7+rqTHmwVwOX?=
 =?us-ascii?Q?JSdN33rVmRgkQc7wIiLLeGqjN/6cz1Y3iRYqPD1XJlNk9cVNWJx7bXQBIc6d?=
 =?us-ascii?Q?Zt2BY3Um4ddND4kSsIxarONYyOf9IyNHx3D0kfzB/+mXRqfUEPvcxgKsbofR?=
 =?us-ascii?Q?SShtDF6K8N+iQmsiPMqCU+1lGIrhG+/y9S6U//n4lWkvKDqBQxvK6OqHvk19?=
 =?us-ascii?Q?X9iE3NwwP9Mv3b+KYlfC+8hzDtXpm5sE/9fCYL75IC8cqjAlzLiBHpirMFsE?=
 =?us-ascii?Q?hJfeqI4Ota+QSM2Qu+NoBqR8P4lAmZxkLhN8eQarZ3ZfT2mhKxsSsdC6nuAG?=
 =?us-ascii?Q?Hr0SeN23VuA0USQ+cFypzwWeHTADKmdZEbLZH1TX1h5tpI0fuXocLcU5kTcK?=
 =?us-ascii?Q?88i/3U0TIK6vy3YQ870iQVO/L0zy6AS2Qv6aDzexutCK5oS9tzNS++ql4ceq?=
 =?us-ascii?Q?PzM8dpGTt+uERb8JhAZWNTAW/eL7p7ammfcj0OhKfp2ct3STOx9PYhS9wXhV?=
 =?us-ascii?Q?lGMC0k/Fm9l8k9vqjy4GWnL7E8dKrr0Bg2VqegHqeSkCVZggDUXlhrUjiXo7?=
 =?us-ascii?Q?htWgAZAhV/L2rLdzTZiu1Sg3+uqWGgCCdz/X8V2XOXxIwOann3rjXCnP6MSC?=
 =?us-ascii?Q?K74s9EQWBWg+ev1mUp8YxQd48H3HK8tTTI3/tEoFPakV2ZyghQbTU1c0SZuT?=
 =?us-ascii?Q?6UIM4GlrjVmVdcANoRljr5/N7pryENMYWXsxOqMvkv2vp4G5xAxrKboNSIfM?=
 =?us-ascii?Q?NkKNbfSskHv3qAdRL+B+jE6khG5pK7+Qv68i3pnGIspUo7dFpLlWg86SfuMf?=
 =?us-ascii?Q?tnodbugDGi5gyXJHk1uXD+kSr3rEOk12DTN5F4Yd1+672R4qW5s9d6W6K2d/?=
 =?us-ascii?Q?Wn1ikAXvtyRBtguhjDll33nPwJHuYXHfS1O+yGKUsjy+XNRFHrOJtwnPm44x?=
 =?us-ascii?Q?Pt3yh/7dJCUta9Lw2lUj8W1Sn1YPwdC1DWpC8b6kBISJsWX+cxwUbDFfpaWc?=
 =?us-ascii?Q?J9UfKiKRj7YWhCwF71UJAdYnVKAZN+2GDJH4Y2R/RnE5oYg9MdE7K9m9o5z4?=
 =?us-ascii?Q?6CHhzH3j+r5bqRhEd+GU/JDV+GffPV3Ac6s7pU52EIw4Yi8Crbey+uQODrhT?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37403cb4-9a83-460a-95f7-08dc6012e425
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 01:49:03.5084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pj2JTDMod3nTbWr28jqx543tWyh2O+rEmlsoDMk5o+mbHUgWTEXrWp2dQ6QTWrWUOjVeVnRWALFFxXb+EmazA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6810

Khadas has update its TS050 panel, the only different between the newer and
older is timing squence. In patches, add new TS050 panel named "ts050v2" as
make it compatible with the old one.

---

Changelog:
v1 [1] -> v2:
- Fix name from "newts050" to "ts050v2"
- Add specific description about controller of both panels
v2 [2] -> v3:
- Add acked-by and reviewed-by tags
- Remove redundant "bindings"

Links:
[1]https://patchwork.kernel.org/project/linux-amlogic/list/?series=842707
[2]https://patchwork.kernel.org/project/linux-amlogic/list/?series=844460

Jacobe Zang (2):
  dt-bindings: panel-simple-dsi: add Khadas TS050 V2 panel
  drm/panel: add Khadas TS050 V2 panel support

 .../display/panel/panel-simple-dsi.yaml       |    2 +
 drivers/gpu/drm/panel/panel-khadas-ts050.c    | 1112 +++++++++--------
 2 files changed, 592 insertions(+), 522 deletions(-)

-- 
2.34.1


