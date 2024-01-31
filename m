Return-Path: <linux-kernel+bounces-46170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7813E843B88
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBA42847EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B35D6996F;
	Wed, 31 Jan 2024 09:57:22 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2067.outbound.protection.partner.outlook.cn [139.219.17.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42C969958;
	Wed, 31 Jan 2024 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706695041; cv=fail; b=honNmz2pgaHxE3VEb9e1398Gt5vp78RUhMOTasCkRW83RNEdQBeSc9fTVzWPtH5kR1HdoCiJGCxtxCNQQyluBxHmS7sWrSPWuadZsVY+rVL0qe8bKsodroIAbhmBos4j4AA4KwXmSLGxnIDzimFpQGOJiVqn9tFwaHwaQDHOx+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706695041; c=relaxed/simple;
	bh=ytVULuwkFklVC91b/qokiLoeTsfLvoZO1FXXpUJ0MM8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oOiUlnNghTZ5r7PUAbQy/b9sDENybUhiYqaZeEWnuyPhAVhJXnaMNMaak3d23tx7PIhidGbAlI63JmCwCSUkoHhSgTLTDVZxLxLAh8vkvOJmZGy8NcQkQlagYeFU30uGyiMtF+if8tDKOOj+kRhEQE0pBTvro8xqtNaYqiOS9dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OG4wJD8kUQ0XAKc66dwH0oCP6HR4x1XgK9xsrtL2+eRJziXIgu2MZD55wesEM5ees7FZoL/RXXzjnog8qDXzaJPnEkJgMNBD5eN/J7WfJT8AXav1t2dd+11c9tYYQFiJwIC4JzGUeZexHl/kgCc3YqLLCWYaq7A48CuluHtN6ehbqhyVLsmfZH3973QKYcsykwcFW6YUVFWg6NPlAJOrj94CZriSMv1Bh6WWWjHHEGnLDG9Q+PrqRlw0ltf4UYWaYY2+fVfntctmpFKr918XLHsD+IEfStxie4Czo5LI3mn5X/PhBZvlCYhV1ZXsAduiWXfgSydteSKisYS+ZXgJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aw3CWTlCesETFFXC33GBRJUHEd72O25xH+lGBm4JbLc=;
 b=FSQw7XxYz9kE9RWrnJk8AA3bpQIL79dF5NlFce1234v/WVvDStUe7L4FNJf9yc2Ybvq5MOFd6cmcISI/NN/8qSB676GW4ehS2r8xm+LNKvcvnazrWm3HC+fVohQukDSw9q9oyV30KAbaF4ev7m4wjoMfValhKoQIF//853u+yaD8J8fI5hsPep0gm84KCm7P9BIGHpU0x0KwcSoSHgM4GRmcuNEccEfM/qUCNW4ZTMOe5tRNHhoX3zHrApqR1u41k4dCT1i3km8uqFuIfIpXKMH9540fz+cr0M2AGkeOUa8GL9ISgeVFqCVRsOvFHSy+AX2gjh+JEDQTzDV93UDepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0591.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 09:24:39 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::148c:e1dd:302a:196b]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::148c:e1dd:302a:196b%6])
 with mapi id 15.20.7228.022; Wed, 31 Jan 2024 09:24:39 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [v1] staging: media: starfive: Set 16 bpp for capture_raw device
Date: Wed, 31 Jan 2024 01:24:32 -0800
Message-Id: <20240131092432.232540-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::23) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0591:EE_
X-MS-Office365-Filtering-Correlation-Id: 0343a24e-5696-4255-3968-08dc223e72c4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HavGtDbH37WLnxAiAPBynLD526uCOO499MjsX2ODQzsYYT4mi9sFkdHu9QIKf3LrSFFwvKWe+YKamlJp6btVQqKWqIhR6GOKFx9lGOOrFqA6CQXXyf39HFaZkEujgbZDP9EGLYWuJ2Il/QGgncIx/OmDNyZx2D3vKbvGWAp4CvTuLiX4SVgGFn4T1vH7mF1UAHb90NMXkVpRWUbBmCcKwMHrz+Eke0oj9yzLgZIfoX7GEtogl/KCA1+SPxsupFjcKXZVl+uKVsmCWBFVBCQdUYxd0jFzwd7QaJjeB0/ReP+hYcZXThV5y+6rasI1SQT834Z+rIMu+OsZWIcfhbNFgDtVyCmCIR9Dtp+pchw4QKEiVbPP1oqlvKJ2FtqJm5DG/EtXckbpasKavNvrP0GCiiCR4XMZNLdFcdWcLUqj0n6oKW/8ebS5BJ9AeNW13nHU20JThbAix5caQCbEY0uiKYL2TyOEtCp57QSR5c7S7bLOCrdUDkU8XF9A/bijUGRIaFbyqcp3ViN6xZm/88dgLWsWIiBr7eGxW5mU07WHqlJksS7nyQmaKN11mjnqoWui
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38350700005)(41300700001)(1076003)(40160700002)(41320700001)(2616005)(26005)(36756003)(52116002)(6666004)(83380400001)(508600001)(54906003)(40180700001)(38100700002)(2906002)(110136005)(86362001)(66556008)(66476007)(8936002)(44832011)(4326008)(66946007)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?19DMFhwyfykPhGuennW2ken26WpTWNq805TDQzdpWIVkOaiur9KleDeW0Nsi?=
 =?us-ascii?Q?Df2DYIlyChO34Szta+XaCYNZ2fl3TBnFF5e4XhQtfxPbXQXTa8w3IWExywuW?=
 =?us-ascii?Q?IBNJ97Q0NkbJAAaV9m/UFKKcyB7Q1LNq8hmU3YlMomxymoNGT2KPNUaMjRP0?=
 =?us-ascii?Q?FEhXuuUZhnyBPh745uuMM3CEpZGcoiwwU0qXipJBfVX80BwfIn7KwLF3MrLP?=
 =?us-ascii?Q?qzQ5e98FiEiKtguNBEWKwS4xxMJs6YihTChItEPyyl/Q8rCv5qI3osU6eK5F?=
 =?us-ascii?Q?zR7isp+OU21L7bhIijN1XuNP77q5CF2g6tDCq4zWy38biftlGLF3CggdR5hp?=
 =?us-ascii?Q?j/iDit7PsgsFG1cM/LcRX5jpRSVtaPXSR31ec9a2q6iCwQJXGQvh3ff604l9?=
 =?us-ascii?Q?FONEGjVWM/V8922b2rM0tO4qm0orDmk20bBhK3yZRAPOt5KltGCC2DrTSqLU?=
 =?us-ascii?Q?+BiIL58A8Zb/9sMinHAaUWrXTj6nJaZdVaDCYZTioLp5Iuj6Q+vHq0zKPGy2?=
 =?us-ascii?Q?kp/Bbzorjw7mbBoI1M6i6ce3VfrRskBui+QeZ1fW8j7VcLLsN6RddEmlVIln?=
 =?us-ascii?Q?DxkWCNyQxLoCcGFcUVEjgcelxh1UVDdJzicchSYMMmh/9nv5eoEmnOPRUE/w?=
 =?us-ascii?Q?sO7EepMsCEZq7tRq8yCjHuwZawr/J0VrpyfnRkGaziTqU4KVHEAMTrXc9IGD?=
 =?us-ascii?Q?SNdiYKxwuhGy80Rg0sRQ9EtppXgopAy8+h+GRoFbZzuT9CrNElK62kpGZRou?=
 =?us-ascii?Q?SgPb/33UrCd4MflQs6ENF2JderkGGqxiNFzFcGpVyADb6RCtvSFunmC6CXl4?=
 =?us-ascii?Q?KuAkxHf8FX4dh/bDrlUqYjK3+YFC3KewtjnMnxa1JJnCuwVzZ9Kq16x8kc2S?=
 =?us-ascii?Q?uT32xZWmAf0PXFVUe2sgsXHjopN5ftENrnuzI38tyEDRMQoTLLXvtIS4vLVI?=
 =?us-ascii?Q?qnTVWiwHfPzkZV+8qL685TsK3yBxbMutdpmTMcN8uZrbLRntaGm3kfrSW0mC?=
 =?us-ascii?Q?RkRyYK/5GhL4cCliRU1Mj9c78ii1EsZpaJ8MRHr8jPADF4xnSqeApeV7uA9F?=
 =?us-ascii?Q?VaRI9SYTlk2GHv/hCB2weA8CPo1kYoHjRvDEzqyLxUbRdfPjYdtJGjZIzF6W?=
 =?us-ascii?Q?0JtZSvyIanyclcoJwQSm5D44kV4AuxaHheQ1GIC77xNIpz9G7+TqIM4Q5ni8?=
 =?us-ascii?Q?tqpayl6BXmK6uJQ6Eb21Hbq4Od6J//XrxlkZjjXenl8OgpXZglhB2GQyQrul?=
 =?us-ascii?Q?vAUhCqdMsE+BKfr1JKp+N9McsIar7n1d8d3Rh0g+PJniz7/ngqvxMPQ4n+sn?=
 =?us-ascii?Q?3h3BzqpQ6s742pNAceExR6X+ajAEe0kmT0o77Rjsk0h/fl3BG5ZWESo3uzNP?=
 =?us-ascii?Q?N+Kv8L1oTqqd608joNHqJIrwbZ+pPkog0uMdNJBOES2JtE5VWuVjDI4gB7nR?=
 =?us-ascii?Q?ISCIXIyiRsF8jaN2wT+CRsWPKrupyWXIiwo44v2+LE8TNrQ+E+c5JzbzAcms?=
 =?us-ascii?Q?zrGvRpGedYgrrdziCC/RfVRiOv/Dgc3aVM4nDQ6BjUTNy4ofO7W7LU5G4EbS?=
 =?us-ascii?Q?VB27JbJnYqtIv8tQVhNUH2zWq2zAuTLujBNjuhLVqgZe17sWZ46pVGtQxoPz?=
 =?us-ascii?Q?lCmsY0IpRQmDxgrgwaRYXIw=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0343a24e-5696-4255-3968-08dc223e72c4
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 09:24:38.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vw2j/fIKHpbskVQkmbLa2t2H9K9ktEXYTJOXdLRAbMwH4GGLS0iGvPPx0GFeGEmFpUILkUaHdblUFGCjH/sBFbYkHsPTsF32CAuO2z1SoTPXuJK8Cps1gh4i2M+5wa+r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0591

For StarFive JH7110 Camera Subsystem, capture_raw video device output
raw10 pixelformat requires 16bit of alignment.

Fixes: e080f339c80a ("media: staging: media: starfive: camss: Add capture driver")
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/stf-capture.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-capture.c b/drivers/staging/media/starfive/camss/stf-capture.c
index 70c24b050a1b..ec5169e7b391 100644
--- a/drivers/staging/media/starfive/camss/stf-capture.c
+++ b/drivers/staging/media/starfive/camss/stf-capture.c
@@ -20,28 +20,28 @@ static const struct stfcamss_format_info stf_wr_fmts[] = {
 		.pixelformat = V4L2_PIX_FMT_SRGGB10,
 		.planes = 1,
 		.vsub = { 1 },
-		.bpp = 10,
+		.bpp = 16,
 	},
 	{
 		.code = MEDIA_BUS_FMT_SGRBG10_1X10,
 		.pixelformat = V4L2_PIX_FMT_SGRBG10,
 		.planes = 1,
 		.vsub = { 1 },
-		.bpp = 10,
+		.bpp = 16,
 	},
 	{
 		.code = MEDIA_BUS_FMT_SGBRG10_1X10,
 		.pixelformat = V4L2_PIX_FMT_SGBRG10,
 		.planes = 1,
 		.vsub = { 1 },
-		.bpp = 10,
+		.bpp = 16,
 	},
 	{
 		.code = MEDIA_BUS_FMT_SBGGR10_1X10,
 		.pixelformat = V4L2_PIX_FMT_SBGGR10,
 		.planes = 1,
 		.vsub = { 1 },
-		.bpp = 10,
+		.bpp = 16,
 	},
 };
 
-- 
2.25.1


