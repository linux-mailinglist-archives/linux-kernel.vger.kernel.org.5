Return-Path: <linux-kernel+bounces-138222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD1389EE40
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC03A1F2397D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E842159570;
	Wed, 10 Apr 2024 09:10:56 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2137.outbound.protection.partner.outlook.cn [139.219.17.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD5158205;
	Wed, 10 Apr 2024 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740255; cv=fail; b=qpG8Jm/0LaO2CB8/fcf42INJGUE7U6b0nrP+Fi9+j17jDeOG3fuCitCUPcYGwHkctx8Wo7wmpIdmUvOICRY7HFS/G5iI/wziSug96BPj/3CkJVKgYsYujbRy9z0iTTreVvaaSBF0pS5amnCt+4RZvxYubUOkaY4U61dbA7k4Nu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740255; c=relaxed/simple;
	bh=QwNIcie8y003rVK0M/6SDuLIb0MB2zsCcXh2HlyWAew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LANzq/G3zXjAZFahPCpRpsrBp/Hbh3Za0CTcJ1dPtxQh79hs/QZyNMmiUMQiWHR3ctlJua1KZHUkGzFjPRtHUgBr49iYpV0gX+rdYgDx9YhBMXC2XElZL6I8vwmFau+KHrnnaqkbjdbNPWHAcyPeKUrVKzyo8STezizg8I82eL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+0RriMm4LYQ2wia/c0xTxt0IidUki4YkG1lvSS3DaPp4Jr/w8CXAs/AEaC7kQgVIigjmokAA+ZrzP0zNwDySCWcgmJqQSgeYGr3iS298p10ZvVduTO8Cw+6gf0QhFwNojku4Zgj5mv+hJHuslpOwjFrXZdiTB6qeDetdGDDOJQXXPOLil2q5uBN0k/Ixk30guQcxm3eKXZ/wdMGITCEJ1riDRvAd/Ij/QkYyt6cqbew1nvf2fha6PfI/fflzk36niJ5BpXIJi5peVIBUAvnUZyzfSqT3CKltpLduRZ31JhworijDPocpdsWAvcPCbFFb6ctjihX9FIDFnvFbBYyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg1wkwTfT5QLJc7rtQVc8/DD0xn3hxgC/rwSI7tETd8=;
 b=VTwoEGMXhRHGZHsgDCjM6zwOFlbTC9R78uIqzy4qiBuQbchCllucJhbYKLXEyx9iq6gdJ4Bzm0UK5lIpbSWsDV3hGNZDSaeG3uO9pOjZAnTpQ1iFs/HvrFLJQU1Qhk0l3QyUGZnC4Q41SYFTjwPOZxc7O14LzEyBz/KFWU1YHD006u3IYvzb2/flWwl7lnWOT03JiSLgdYlC9LONghcD7NBFbyZyhlk6QxB/c8AuWVYQCz69w9RgxGvLRfAFGv2gW1HUESEYV/VW2MBIHo+XyL81/ueUZwjNLjXxLJRy3i6u84UJeWEXIaxuKgpoHYKmva0Z+iCq3dTEKImz1SViEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0896.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 09:10:37 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.053; Wed, 10 Apr 2024 09:10:37 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v2 3/8] staging: media: starfive: Use PAD_SINK instead of PAD_SRC for crop
Date: Wed, 10 Apr 2024 02:10:21 -0700
Message-Id: <20240410091026.50272-4-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410091026.50272-1-changhuang.liang@starfivetech.com>
References: <20240410091026.50272-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::17) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0896:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d076f08-7f77-4ed4-6181-08dc593e1616
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a1BDsJi+qgO2b9KstyAt0iV3J7DPANT1+vCjjo2MU4zlMKPuUkDQkmfG+a53j4U6vmKh/hdy82FmpYghCRcxgOLWqpoGFXERNr9HdPeetePAg+GlP8PZ/bsNgbDVp2ywAhXt/vFs1svGq9F60YTGYllozRfioMklUCHCbn2Q7dAxrtAeFWIbT2Xv8b2yhUX/6VeG385lc12RKi/n0hfT+LIK2wOWhyBushWIYdbWr4UCRIVDe6C+W0gnG3+Y/mhgmBAPF54/lRX9oSvd/TY1sFlEUxJK1GblnzJIjKFIbb30GlAdWJUbgKF7ljtxlDzjgVLSHOd3+etGzlxz9y6ZzppXE+OsU+tVQXijIpya4J2CtQM4b1FTlXGaYN+2EIvzdQA9YDhuvYSeCj+vMyU2edziG7iT4yqKa5vFLf7STnC6U0QgpJjOZMwKy4S/GXziHW+Btya0uRdvK7hC0OOd6gO03vb3DFAXBzugOqSLZS1Qd7KG1DYjkq7XQDGFa0VmiWl3H5XyX2kWNrpTvysWwNrkIl6JGgU4UJ14CAuuwgHzadOfSWjsFfDxqBOwjiQN2gcQWhIuejRGbihMAl7qt17IhpCNHuzcqlAcKgnmbiOfXo/e1T/dFKs05+9pti+v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oPlf4wg1n7x+gqXxDXv7TlZVemhc8dUUbMdUiuuCbT0RRnCk1Mxem1Ulx3/l?=
 =?us-ascii?Q?QFwe2NNyVvt9vXX69SidF2w/JGeYHlqs9rOiIqDQN+dYdcNfS1/7ckOlDxPC?=
 =?us-ascii?Q?XSgUiIPngp95qsH/h9P/7cRQ1cY4KxEksk/QB/qMOQecHtw2t2vPH568RYsj?=
 =?us-ascii?Q?gOkryPvNTmABFC/5JTqMCjQQHNoEW89+SSDKh+mnak1Gh0ZqjZJIybUVnR4c?=
 =?us-ascii?Q?I6tGjqkbFbxBsAmoGyzV02sTtOLcpID1E6xcI+i7UPVL3CpVzmpNYDqQVSl0?=
 =?us-ascii?Q?OTUaXeO5k5a+LHtIQXBKxqI+tvqTCyOFvzTZOmYaWpNMwbUQBZFUXA65jwVm?=
 =?us-ascii?Q?e0H7GTAralySKGOn3luGbK++aNNNjNDA14B4USSzjL1Ha29yE959+rJq5vve?=
 =?us-ascii?Q?EbwGiA1RJjoce2q5B4MvvTW/brofQgy0IMiYgwpRyL5LJa61HaEJRL+KrcLm?=
 =?us-ascii?Q?Wjr74ZCnMmYppZ4ZklNECHEaXLIMYs8t/xflXVMiFks8Dy5tZGk+GJiX4zBj?=
 =?us-ascii?Q?d6lS+q6DouTs30oFMNhhSPIHxdMkndUYxcmZNTwXzDKGzNWMFGEyuzrpnq93?=
 =?us-ascii?Q?bnWzysz4hq64i5ihEEHmbhtgj8p2Luly94ElHOHVoZnKCGFRcdoyvzeaAmsB?=
 =?us-ascii?Q?JpKcXRvmSEhR9mnkXM0tBsVgEkNCplDwyldA0V7zYsz1OBGkG4qucpDITj91?=
 =?us-ascii?Q?XwOQzc8bv8G7qt/EsLmaRCRUIleI8wtENrRDBN86DP1jW6tXpNcMj+qNHW62?=
 =?us-ascii?Q?hKakgxUOCPVnMqXxH4LLvJh/2BnlC9mGcEYgI0xXQGBTOw15k/FzXPtr+02I?=
 =?us-ascii?Q?MPhCS2OgANVSKexAc5j4BAJzCW7oisTES6/udK8ZbYSnIevrCDN/4Yn8Lnw3?=
 =?us-ascii?Q?euQ0GvgvHjY09JO7i0WP9svCDHWnVAG60doxWTxjGAHqdIlh5LGgNWB/7akv?=
 =?us-ascii?Q?20VFijO4671UxQ49BlpJdmXVHQDaJ0fwnIY8V2e3C+EFMy/hiu5OvBs83Min?=
 =?us-ascii?Q?u/HGZ2l2xaH6PwVKkrxkLpQmGq5WgJ2As4x62TGsDX424Mi9MiToa2igvfhc?=
 =?us-ascii?Q?aIQ2KlmXiFsL5P2TERWg9M37R6gfM+UHvBl2R2zzVuXgqpQWclilsoSdstX2?=
 =?us-ascii?Q?eW6dBiCoHXcrNdwKGSns8ifsTLnd2sXQ+Gp0TFbqrW7Cc6joidUi617iM70A?=
 =?us-ascii?Q?Js6SLhcJdJWZIzIH1U76D7LfcH+HyUU74YwpcW0PwBTI3upWSx0bkXQvtMtc?=
 =?us-ascii?Q?ztkb8gp+vRBrupLSu5f6ABrQj+3nOJFgnxIqwFMLZouW27khMInIVBhLeo/g?=
 =?us-ascii?Q?bh+0yQynwyCPHztKShOY6/m4odok8/oFpbQfYywQUgCNJst742tXjSlUhUEQ?=
 =?us-ascii?Q?oM+DrAcK8dEL7lyTWc5UG2kdoaZ36m3xzBljbzxsgCJWbho/33QPSPGnBHwV?=
 =?us-ascii?Q?FcUTAYupBPYC7NB4oBvCLLkJzCFDqjotcEXEjgV6knYT7GcSgDQyNHLd7sNb?=
 =?us-ascii?Q?JcKjWNh5SS1sJtYbBNQR1YMSXtbcccdoFKooweY9MrB9+9ezb41P/+1prrMm?=
 =?us-ascii?Q?4WefCKPfyeIDtlDMbW9Ppb7SwvpwmZa1el+RM852Rt4iCEL5CuP7TgX2vWAz?=
 =?us-ascii?Q?0JzqCstJ9tJ5/0dq8xcYfWk=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d076f08-7f77-4ed4-6181-08dc593e1616
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 09:10:37.4601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +irkoBohEaqZZfRpeq438kPh5SrZiH1HqkDNQ/D5eFhVNR+0SwuVw14A+TfUB7huIxeRYQUyW2o8NaXGCkdOrJMHdtOn5megLMNWV+10TBAmsocLnUvjCnAH5fu6hw48
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0896

PAD_SINK crop can be applied to all of the PAD_SRC crop. StarFive ISP
supports multiple ouitput streams, this can avoid getting the crop
for each PAD_SRC.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/stf-isp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
index 53b9cd2b49bd..fb48e7a29e8c 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.c
+++ b/drivers/staging/media/starfive/camss/stf-isp.c
@@ -96,7 +96,7 @@ void stf_isp_stream_on(struct stf_isp_dev *isp_dev,
 	fmt_t_src = &isp_dev->formats[STF_ISP_PAD_SRC];
 	fmt = v4l2_subdev_state_get_format(sd_state, STF_ISP_PAD_SINK);
 	fmt_src = v4l2_subdev_state_get_format(sd_state, STF_ISP_PAD_SRC);
-	crop = v4l2_subdev_state_get_crop(sd_state, STF_ISP_PAD_SRC);
+	crop = v4l2_subdev_state_get_crop(sd_state, STF_ISP_PAD_SINK);
 	src = stf_isp_g_index_by_mcode(fmt_t_src, fmt_src->code);
 
 	stf_isp_reset(isp_dev);
-- 
2.25.1


