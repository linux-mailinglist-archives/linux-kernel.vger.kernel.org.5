Return-Path: <linux-kernel+bounces-163237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C8F8B6789
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845511F2127F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4BC8BF0;
	Tue, 30 Apr 2024 01:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="hHw44X+4"
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11022018.outbound.protection.outlook.com [52.101.154.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4E41113;
	Tue, 30 Apr 2024 01:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441156; cv=fail; b=pTznKfy4kzjfycAEujvINHXEaUrvc9Q0LCFyqMXTcLcpYnuGNXcicv56DTX22EpxtfwZOldNLI5MSEtckZv3hbJM7zA5nkRFS9PN0w95iNMDg86rpbwEaMRUrpM30x5QIY/hhiGzv8qxekjvEaWgGrye8X3OrKiFUYqtkWBHOAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441156; c=relaxed/simple;
	bh=lrEi0r97o8Y/xoHGwh+4ip2R0DIFHkyP/JQtkN8aDZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oNCy0vqPvi5ttKTHjt5tVefuMphKROSdegV6W32K909MAvrSuqlX1G+qEjsGfO1xdEwcgOkLRHXZSbr/8C7RZJtCOBdbDoFgWbdy0ZjVKH5XkWTT7/rtPen9R9Z4UxehoOIdAUvEZ8nozvzyvqetqxRwun/cGsykO5xCX8O/Qe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=hHw44X+4; arc=fail smtp.client-ip=52.101.154.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DX18LGSuCc1P2/kW9q65V7iqpqGEJK2x7m7uG6YFyReUJoBIkqvRTYN6iNzM82y/ZtXRqUg8GhVe9Ok1HK8HJV6NGwINC3ulwoBAIbVYgHBUf5T4v3fbxPLJ0UBdm1ZZ4sForZOgQ0pmdv5Sbi/tNqPFnixFUU9UrVrOYBrtBAa5xuB7VSziDI1luzyTbFMhEexEvGGFZRWSZeLGa75i/13TK7qsSacfCq9fyJ0yEUXchoDlAWhVQT0cyG1ZcmDEJ08LHluvyjQHQ+pgH2kiHoFnv+SGcOy4PXQx6xB7xrWhGiPpLaQnFCtPC1lVibx0abwx3gC5JC0xAmXlRJznUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vACLLSZhrmTQO90kzFV39ILswOgXNXFuEX/8TwheFwc=;
 b=HfTkeQ+FN05/jUgp8h05HGaojmVkpim542nNuF/4CAp/uKukhe3mRIBjoCztqEW8wvw4N2jBrQKy50S2ldjsRWgqDMzcT3bU6v2IiVf6K6cV5Y+U8z0Xr3kWA7mthiqwI/8WhmzvnYIkCsou6QsJ7Kl6rxCALUm/9dIlI2GzzU2XgHnT2zIeM8c8/9p/CWKvw33lZBhwLlUcpsvp8DU+dxSr/teGVclC3kNB7fjg2Ew3wkhxaeQoLwJKWKOHa9htyx6DdxHtEIeDaDVchIbHX0j5Mw1CopZGkcrgUB9Gks4s3Zk/Kt/V+JfrkgWzOxQApqJe0bCxWn08IOoek5IbDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vACLLSZhrmTQO90kzFV39ILswOgXNXFuEX/8TwheFwc=;
 b=hHw44X+4RhrzfsNCQqGw+UwZBkuB/ho+1WCznhyzYZTrpiGm7Sk4F1TZFkWrHxJpAN7wP5qVv+fXi4Ep+7lp59CV0Ib4zA7QNONijMmN3L1TuVMwatF7pN2y15b/20lF2/QqyzbdcsnD3X2/OSVWVblfnd93r83kCgqXcR+/9Hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM (2603:1096:101:a::9) by
 SL2P216MB2195.KORP216.PROD.OUTLOOK.COM (2603:1096:101:150::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.36; Tue, 30 Apr 2024 01:39:10 +0000
Received: from SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57]) by SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 ([fe80::5b8:35f1:821f:4f57%2]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 01:39:10 +0000
From: Nas Chung <nas.chung@chipsnmedia.com>
To: mchehab@kernel.org,
	nicolas@ndufresne.ca,
	sebastian.fricke@collabora.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com,
	jackson.lee@chipnsmedia.com,
	"Jackson.lee" <jackson.lee@chipsnmedia.com>
Subject: [PATCH v3 1/4] media: chips-media: wave5: Support SPS/PPS generation for each IDR
Date: Tue, 30 Apr 2024 10:38:57 +0900
Message-Id: <20240430013900.187-2-nas.chung@chipsnmedia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430013900.187-1-nas.chung@chipsnmedia.com>
References: <20240430013900.187-1-nas.chung@chipsnmedia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0211.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::19) To SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:a::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2P216MB1246:EE_|SL2P216MB2195:EE_
X-MS-Office365-Filtering-Correlation-Id: ade7885d-d6f2-4338-9178-08dc68b654ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xQ02mcOYx9F2P5ujU+ZG79tXgF3v3XKSHbVmkiNpD79eIPUChcalxDTOqADo?=
 =?us-ascii?Q?5P9nSeCAZD1ZlfpPqPIkrgKOid0N91cJTm0ED6Hh88IPmyy3yBwvxOow+cmm?=
 =?us-ascii?Q?Zc19T1MEXm7DMTAFeikXi14uGmNtk7DXwZTi2fQGrnBQV6sZoL+MsVU7rTqY?=
 =?us-ascii?Q?MEfBClFIG8IIqMgSv0LzWKxlT0MlIaTu0IlqoPW2cFsflQAfYLub7xgp0/Fq?=
 =?us-ascii?Q?Vot+Et75HxhWuNmLp4WWp/uNHnoUvE/dE6L7hvKINHVrb5rJoOrU73ZM+OIM?=
 =?us-ascii?Q?FCX//D/YRjnuOScUn51K9Sn7cHCT+jo14260Tc0/1CpfXrXAFmDqbpNSMOlX?=
 =?us-ascii?Q?orUe+FRwrGBr4kO1b7a+mS0OxOTpbIv7d1sHDzJkCcE97uetDKmVxH00O1rQ?=
 =?us-ascii?Q?lGh/yFbx9H/tV2FPbeXH4xAI8+wLL6xoNsV19Fa4MZtMK0QGqa9vPK+iAK5Z?=
 =?us-ascii?Q?IcxhXA1jIpQCtsHESYB138806NyTQUlcCDtgOzJeK/ruDpyxi2VCR1eW3maj?=
 =?us-ascii?Q?eKgQQwzDv6sA+Yvlx/jETGbMaCV9Ajr8nVQMnmfL5Uzqd2yatrF7f3dIxpaK?=
 =?us-ascii?Q?khERpTXkabXGXor01F6K3S2MCCqDQdSyiOv36EPfXviZroyYhzS1q8aTfOUc?=
 =?us-ascii?Q?pirDvgnMnURPqUlrorvTKXFmTJh9IQXHo6wAII3CENAOVF+I64SWdH02wGY6?=
 =?us-ascii?Q?Hokw+R9aAT12wGztQhjvbTt3ZWEgi78OSUGvN9p+sQ3c8rlUiMerYhsDnrti?=
 =?us-ascii?Q?TanUrOhZuSYpIWP05vMb3raaxQ9zPDazUoUdzdfb6OLTXLJvn359X3O7FPPM?=
 =?us-ascii?Q?mVvaeStt7oThmmAbulaYKqD3hV2J3EuvsxbsezUmjTG4Zh7DXyW3CkV2XRpU?=
 =?us-ascii?Q?4ul6QXA335q+3CUbmifEWj/PBwBjXQiN4PKULnqyCwmD96d5evFZn/rS1zm8?=
 =?us-ascii?Q?F4Q2b2ENFBbbPOSGy/wkcphkYx5x6IMWuaafhxK5DY18V0sNhhsplbHSs7pl?=
 =?us-ascii?Q?6Vf7C88wHNbhoe+SwI8+4IUtFfXaDtbT+tRqZcKPTed2u6VbxA42YvjFNh2y?=
 =?us-ascii?Q?C4Piq56u3T3AZHCA0T2qG/i9wLBWeqYRBR03Qv8itWoShVOgm6HCJArUFQRf?=
 =?us-ascii?Q?f4YOmhNZQb4S1CJJN9CpqIaWAnbARC6CFT54titmgBADsZ6+hE5FATXzBypA?=
 =?us-ascii?Q?4kfs8YNjGbXmbIZs30T0POr+tX8Ki9ZfNnXxlaVV6gvuD9bVEYfslDGjkWuk?=
 =?us-ascii?Q?kUj/j8QLBIfbQcTWVzIX2ovI9UxAp+dBV6Ru+f3SUG7Zbv19HFoMRz95vgoD?=
 =?us-ascii?Q?zQWHcMkitcNPeMOUM1rRt+oAbg5AfNH0EeI1dzHM2DC7TQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB1246.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iok2cVKdBhK8QsU1++joBvr19Pnr6n+/R9+SOMFHTF3sw6eIORboQQIQ9f3J?=
 =?us-ascii?Q?K34K6q3KgJ/+6V9Et2hOOwjr+7Ada5jvc/x4+O9W7YA0przXcsc/KyOo4jxe?=
 =?us-ascii?Q?vEt3/0RpNxOkUc2KNgQcfUCHNIQf1Jo6JSQbLamLmo/GqoRAlRUxC8kE6KgD?=
 =?us-ascii?Q?OGu0mKaTiDcd9X0Ol0WtXDYLE0riGy4t38g4eHZf064bQqe86o51peJdxEzw?=
 =?us-ascii?Q?02uLmJS+PWjTTkqDPtU0+SMe0CpWyerQtLcM8b4FwsDy5CTTyWE4YM/qWrPi?=
 =?us-ascii?Q?6hSC462tdOqgHwuwW3kWl835kvpwqSCJTZy/A99pvn2i6IEloAGs+V7xUPdS?=
 =?us-ascii?Q?PHaprAAaN2XAO7fKvxyzj32UC8ZG5Wx5ZKK0xApDBPNcrWCOiEOqmDNdZSib?=
 =?us-ascii?Q?Guu5gN/H3Atg/gr48p5JjrbrFM2tzLmVRDH9EXEN5Jr7USWrCC+9VOgdTdnM?=
 =?us-ascii?Q?ISqEp9d+dLK8Oj8ZaobG0dF5bVwppM7uwPzwEd5lidVzifpKvyaJ3Dck/Og3?=
 =?us-ascii?Q?ZClY+0ywcus4TZ20vA8lYPqklSU3ecIe2LrPFNFVsalN7w0rQUHUBxXM855M?=
 =?us-ascii?Q?pkKCXVhqxzCEbP0hpNrT5weGRmSg0oJhGTrIHZeWOxCFqxx5QpwNYus2CgyD?=
 =?us-ascii?Q?A/YTGiUxeKfow4aqoc7SZRTlxQscmyCbKlhax1iZlS83uOihWY4u7eyueWXG?=
 =?us-ascii?Q?UrLjjT4CoJFEig/wxeA+KKRl2EqYako9ftNU4JKGAaGoggCOj/RQeserXcTP?=
 =?us-ascii?Q?18acxpvtPhOXlxJeWZ6G/o04IJqcwhIMfHIBAF6aFOJJFavDBe4RRsEC7Guq?=
 =?us-ascii?Q?/V2euhk3QexQA4Rf1TTvbtg6yi/y6HEmeavuW4DOYTg+Ja7t8kydoX9xdHQw?=
 =?us-ascii?Q?j4KwBImR/ojBLGzjqXLIS+SM9njEzkXKAI/k0+RPxAqc7wR777dTZcoapBEb?=
 =?us-ascii?Q?8Ikwk6TnIvFUhKtA9KVBu2mkwB4MJ3TSuJMznVxYFYm4gTQG2L71VoiVaRtn?=
 =?us-ascii?Q?QhOFzM81MsAWYCVv5eQgnd4P3VXHTcYiK1p77LbEtAACm41r3rEOSCBv1YCl?=
 =?us-ascii?Q?53FsfgE4xaLm8r41DMFGvKge/r+Qynh2bP7Mdz5ut4omBFWTmpNgoH7gxsoa?=
 =?us-ascii?Q?ZON751Tpw+m34BNEzkZZX7uZ7PJfg8CgUSgIxbF+V9ZG1KB5UnJVxl17u7UN?=
 =?us-ascii?Q?6ZdgTJ4AoDu5Xg64qsGL7ZDu2zJT6HtTTXaGVJOJNg01Q6K6dgePcpe7hsd2?=
 =?us-ascii?Q?rAW4qX17GS40TiCylg9ZwbIdOu6pn14ZqK+kqFJzbSvLwWNOY4Q+Jpxc2MgF?=
 =?us-ascii?Q?doiLkt4bj/BGoJMs5QhjUX4Bzgu3pIaYQMwsO2yLAPTG7XM6upyUaTtprBJT?=
 =?us-ascii?Q?nfZfJAOXDFISj0N+6oIEJzAdTCff0gSOhJG3Pii8T1Hie7EEgd2ZAqjbzl0V?=
 =?us-ascii?Q?DVDGtVI5d3S4MsrDWVMsnLJ3z7UsEqI9R0G/cy6qjbSB3L+TdIJuCJlRP6Ot?=
 =?us-ascii?Q?SAqCrOX29/2T1ahZbsPrNr9Qaic5Zebkm29+FAlj7sl4GfXHZe3qU/mUI7dJ?=
 =?us-ascii?Q?9WXxMr9pOHzcYSVRvV2vLzZDvskCPDrUSJb8XJsaV1fHqrCtZWGUUvbeQIrh?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade7885d-d6f2-4338-9178-08dc68b654ef
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB1246.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 01:39:09.9531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slShTY3Qkt0MTk6lFdd9BsIJL48p4MlLuvDVIwXqCbUAOzsUqLdW8EzntozaULnpA96JoyUagIjSei+SpGewu09RtKN+GuOhMkSEjR50Gqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB2195

From: "Jackson.lee" <jackson.lee@chipsnmedia.com>

Provide a control to toggle (0 = off / 1 = on), whether the SPS and
PPS are generated for every IDR.

Signed-off-by: Jackson.lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../platform/chips-media/wave5/wave5-hw.c     | 19 +++++++++++++++----
 .../chips-media/wave5/wave5-vpu-enc.c         |  7 +++++++
 .../platform/chips-media/wave5/wave5-vpuapi.h |  1 +
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index 2d82791f575e..fff6e66b66e4 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -23,6 +23,15 @@
 #define FEATURE_AVC_ENCODER		BIT(1)
 #define FEATURE_HEVC_ENCODER		BIT(0)
 
+#define ENC_AVC_INTRA_IDR_PARAM_MASK	0x7ff
+#define ENC_AVC_INTRA_PERIOD_SHIFT		6
+#define ENC_AVC_IDR_PERIOD_SHIFT		17
+#define ENC_AVC_FORCED_IDR_HEADER_SHIFT		28
+
+#define ENC_HEVC_INTRA_QP_SHIFT			3
+#define ENC_HEVC_FORCED_IDR_HEADER_SHIFT	9
+#define ENC_HEVC_INTRA_PERIOD_SHIFT		16
+
 /* Decoder support fields */
 #define FEATURE_AVC_DECODER		BIT(3)
 #define FEATURE_HEVC_DECODER		BIT(2)
@@ -1601,12 +1610,14 @@ int wave5_vpu_enc_init_seq(struct vpu_instance *inst)
 
 	if (inst->std == W_AVC_ENC)
 		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM, p_param->intra_qp |
-				((p_param->intra_period & 0x7ff) << 6) |
-				((p_param->avc_idr_period & 0x7ff) << 17));
+				((p_param->intra_period & ENC_AVC_INTRA_IDR_PARAM_MASK) << ENC_AVC_INTRA_PERIOD_SHIFT) |
+				((p_param->avc_idr_period & ENC_AVC_INTRA_IDR_PARAM_MASK) << ENC_AVC_IDR_PERIOD_SHIFT) |
+				(p_param->forced_idr_header_enable << ENC_AVC_FORCED_IDR_HEADER_SHIFT));
 	else if (inst->std == W_HEVC_ENC)
 		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM,
-			      p_param->decoding_refresh_type | (p_param->intra_qp << 3) |
-				(p_param->intra_period << 16));
+			      p_param->decoding_refresh_type | (p_param->intra_qp << ENC_HEVC_INTRA_QP_SHIFT) |
+			      (p_param->forced_idr_header_enable << ENC_HEVC_FORCED_IDR_HEADER_SHIFT) |
+			      (p_param->intra_period << ENC_HEVC_INTRA_PERIOD_SHIFT));
 
 	reg_val = (p_param->rdo_skip << 2) |
 		(p_param->lambda_scaling_enable << 3) |
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index a45a2f699000..a23908011a39 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -1061,6 +1061,9 @@ static int wave5_vpu_enc_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MPEG_VIDEO_H264_ENTROPY_MODE:
 		inst->enc_param.entropy_coding_mode = ctrl->val;
 		break;
+	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:
+		inst->enc_param.forced_idr_header_enable = ctrl->val;
+		break;
 	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
 		break;
 	default:
@@ -1219,6 +1222,7 @@ static void wave5_set_enc_openparam(struct enc_open_param *open_param,
 		else
 			open_param->wave_param.intra_refresh_arg = num_ctu_row;
 	}
+	open_param->wave_param.forced_idr_header_enable = input.forced_idr_header_enable;
 }
 
 static int initialize_sequence(struct vpu_instance *inst)
@@ -1701,6 +1705,9 @@ static int wave5_vpu_open_enc(struct file *filp)
 			  0, 1, 1, 0);
 	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
 			  V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 32, 1, 1);
+	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR,
+			  0, 1, 1, 0);
 
 	if (v4l2_ctrl_hdl->error) {
 		ret = -ENODEV;
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index edc50450ddb8..554c40b2e002 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -566,6 +566,7 @@ struct enc_wave_param {
 	u32 lambda_scaling_enable: 1; /* enable lambda scaling using custom GOP */
 	u32 transform8x8_enable: 1; /* enable 8x8 intra prediction and 8x8 transform */
 	u32 mb_level_rc_enable: 1; /* enable MB-level rate control */
+	u32 forced_idr_header_enable: 1; /* enable header encoding before IDR frame */
 };
 
 struct enc_open_param {
-- 
2.43.0


