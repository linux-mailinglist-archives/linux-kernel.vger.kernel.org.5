Return-Path: <linux-kernel+bounces-52250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9181B8495E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7274EB24E78
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2609814AA7;
	Mon,  5 Feb 2024 09:05:07 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2116.outbound.protection.partner.outlook.cn [139.219.17.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B754F12E4E;
	Mon,  5 Feb 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123906; cv=fail; b=SNp0vdfmRlXnVzShfBhCZZbp6ZAFZSyVMuxEp1fFc2EYfZqAdWbiHHRAwfCpkzYrrEQe0EONnCbmJIPUimGOGeIc5nY6xWD2W/5kBQBuWpAJGQq1zXkd2GZsviOgHtKKUwyZRngbCkWntfk5vu95pkmHYaT0uKd1Clln38SuvFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123906; c=relaxed/simple;
	bh=ZqS10ZAMwMKng4bCcyIYliSH0HU2nzc9NUI+fmHqPks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FNvUbyO3lo/ozfVx8HTBNsPnV0FhBhkqRT+V4znh+SKVaSmKzYKu+YXFKV703PsLCyJrlLRxWRN9Bojs43OYfLAOaq0Yby55Vs5g1XOU48IxEUCMVf223ogBJ6yIx7cPLOyPWLQv1petdtcD7Mwhq0wkvtTroRdv2AYN0JqBlHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkNN1iZo7N4LG2GkmByC6fGVzl9h1IRZQs+C9rPcQH5T9DEPZp74hARsSIYwjlrUyc22QplIbTmJnGuY42PDA1idY4Y5RsHce09WkjY9PXU0NrFPgi5RtUFpa1fXniSJY5IsOzUZ+G1cCrBvMEwhRu5KbaYrLSUesqQEq05QZAiicRIu0g+bi93i4qZVwUdJS5YXF00bKwJPrJnSdylKn2jJAdyxLsW4HMMCJiaO3ifur7USAGh3Cm8wpXHKS8j+xrAN/FX71qFt6kHgTlsCNrxXU8Jb+dsxEtCvXK8SP2JgLP8j6uJifnshuVjWQB736rSt9KJbxzhB8QmiqgaKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpYS+v+cBn1HqDAmhXTHJL+v2aLemV00fes8PvGvKzM=;
 b=JQ5ZMtGXEZB1eZhCQb3Eu9M1Po3/V+ewrJwZgw5ZmuIIJWsGzF9E9b7gwE5O+KcOHvVfzSvg73UzhnrZoxiAW8rS4ldL/on815tDyqwHZzgHD1V7XfIzAlFZ8+qnZsSuxcCMyMHXM07PrwhZePKWbutI1DzF23Ey5m9lxAzirlGOaYI20eujXVujIPVsjT0e1BmuklXJ+hAIr0QR9U07TLGGKwTw5UxUrMeVyaamECif9zo8Cw++VENKZA9yb0/zdlC7+FF0mELL654hVBrpgSLr6DFWRMQllLKjCUse44StNoCDJTl5h2GPo3Otm9vm2v10hfLzsVdUuztoUMf3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0815.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 09:04:50 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.025; Mon, 5 Feb 2024 09:04:50 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Ming Qian <ming.qian@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	Mingjia Zhang <mingjia.zhang@mediatek.com>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v3 10/13] staging: media: starfive: Add V4L2_CAP_IO_MC capability
Date: Mon,  5 Feb 2024 01:04:21 -0800
Message-Id: <20240205090424.40302-11-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205090424.40302-1-changhuang.liang@starfivetech.com>
References: <20240205090424.40302-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::23) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0815:EE_
X-MS-Office365-Filtering-Correlation-Id: 800332c9-e9cf-46c5-58ae-08dc26298233
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gJ2tbHLykmyOQ84fCXPnpqzXlGGxlHLBnuRKYOMrpzZWLNvFaqnUa2InGOkXYhW7uDl4jFU6tKDtDZd3sLxt21TnEr+/qx1hCk1A25gT6RT6Tha1C6TLfQCzrWy4nNmi3X0BlQQQswNf/4Z7AkdAD1gh52dXpgSLD9vHu0TXvwPUh1+jAB40eKtIvN8EgYmpWAxTMOv8T5BOPO4KQesv/7BU66AAf2pf0eb1C4mk3GKQb2Du4jN7lWOR8Ji5SaDZZBeuvgfivx8iACzzvnVFKg3ndxMrYmj6PmUViw+BVlCGtXH3IzrihYEebtvCnUcra/Oy954hDnoZXNrUe/XKK5n/dbByA6/Nz+HRK9XT1DNACFW/Zo/zFGaYLgr5rkQLneciEDB5JXCZEN8ZNIIO+32cmqlhvvrAzjieDB64Ucjp12MUX8MVKPjs8OW9z3Cf0kOjg4EdKILqEMDtsh8cddIljVOmm9JDrh1H1MbFboyiE8Fa+dtVY/+72puEInXAs00kH/PB4o5z5bhjmQYdMHXe1UHZs1fxnLruhuMUvC6VY/lglzOsaH6TEWZp4i2Y8nIeId4aYP2eVbllbW7ApA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41320700001)(6666004)(52116002)(36756003)(40180700001)(508600001)(38350700005)(40160700002)(38100700002)(2616005)(1076003)(26005)(83380400001)(86362001)(5660300002)(4744005)(2906002)(7416002)(8936002)(8676002)(4326008)(110136005)(44832011)(54906003)(66946007)(66556008)(66476007)(41300700001)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?90h62bh4yr/VasX7IdioHWRfTD28hd6msihhRkMVnJAPSVWeKNQC3g0nMrJg?=
 =?us-ascii?Q?Ny+miNFNcux8rpt7g6gNJdIEj6GoexpbyuVHISleXJY/rsT/i9fSSNxSsVo/?=
 =?us-ascii?Q?wN60DX8VOR1amnhdWDq3LIXgDQ/K7CVHoihZmRP6zM6UmKxNivJK8EzW7eU6?=
 =?us-ascii?Q?EOblImcWbsG/W/UAygy0SdGt5ia6xqX3l5gnbqUK1bPGDLtjoB80CwtuwIth?=
 =?us-ascii?Q?pjJ23RgwRATkRlAvuKrc0yluQMeWnNbgTHNz65VM3wnaFhbnzsEKOKOSuC2O?=
 =?us-ascii?Q?sxM6gIkhWtmiEC10adadJsF6BAdqcmsEi746v003y/Ivx4dnRtBf+SWGwl2X?=
 =?us-ascii?Q?mYceOPcr4Giac4sYu74YgFO9DXGwdR7yMJMbvHZ8g470Le1F8DSN9v5waeYy?=
 =?us-ascii?Q?ZG7mBtz8QIlKSyMDdZJZmmVSK8gVrEHmT6BhtPv+BA6ij/nUa1ywOWqntt8i?=
 =?us-ascii?Q?gvw+mDBpfgGYPOjtcg4eqyCfsf9F7Si4Lwvi0p4EjFvWgGogfgEBZ7lQGDD9?=
 =?us-ascii?Q?FX47xvXEYF8kaTGC1GRaPxtqjnEtucV1a8n4H4kjvC6g0fpqCZGt0FSKOk9a?=
 =?us-ascii?Q?jsa8Sn4Qp5cMZ2rHHkjmilW+fCrjGAzOsESMcHpla8brLCktzywETw4t91Qr?=
 =?us-ascii?Q?cfp6fNhxfAFrLH272ejs8SxsqyctFXViNDE8FwVgvfrdbJTKuBSM52HsRtDb?=
 =?us-ascii?Q?Ed+6ZnDDiSyIxadfQkLEYCXhbP00RNYcFE70v6aaD2WAOGM0x9PZumPKDfdT?=
 =?us-ascii?Q?g+YffddyrWy5g+HaA2vj/lhbr+Sgve6xrUcjYMjxybYz6HE9TluDcHcV8cWj?=
 =?us-ascii?Q?hXZBQudP1XjGysAI+X2BKoyj14QJOjzoS59zWYGMQlaXj02lfP3k15AyyU7k?=
 =?us-ascii?Q?GzOtXKFZJc0AuzZhCWuvR21DX9007mBk1kuixzp1SwVlNJuslP+nQlKzlgoV?=
 =?us-ascii?Q?f63Bn4FiCNsqucAY4LXO+bCl0Ro8lMRY2EAg3YJJ+w6pytlh31R98W1jfcFX?=
 =?us-ascii?Q?MEdRHfhYlGjSv03SKejh9idDc24NvnFZLUGY3ORX9/5h127l2l9XaTdD4KGk?=
 =?us-ascii?Q?WZzXk/osFuQ1dkEYEjzR2XypT7xfvA9ldaU7kr+VVaJWDx/Y7kQzRhalKTrf?=
 =?us-ascii?Q?ZZ/nMdAT8n+2cdN/g3aYLQ5XePMmeUK2Mmnqh5I0FKd/Y7mali8rwMTqCmiI?=
 =?us-ascii?Q?54bZ/2/WTne5kfK+qMnLvlSeSJVqEdabVmW86xeRJtXGOQRF72Tw4OjzGQJp?=
 =?us-ascii?Q?zFJ3f9dv0e44Zvzu1r+oFqIHkX6przn9OA+42n2d2cgRSR6FAUdmbZDIwYzu?=
 =?us-ascii?Q?jTBE/GOsWc0+I1UfdH7YLy4rZBK3It0I00mtbQHxzr4Y8VUtDE+DYcr7kyay?=
 =?us-ascii?Q?pGzro9B8rbVqJb3sNyT79MbUqrtxvHA1Xv68uIOpidquJEmntFsA0P7rJu4A?=
 =?us-ascii?Q?0GW6cS3nZOKGQgAC88qnsHkiHgPcsxfXhrHySfw59LrDDaqgRxYVIRiT9Jk7?=
 =?us-ascii?Q?aKuDPT5ZktddO46Ncxm/r475ydjQxFmabNg61/dd8IxHJJXip5/IIFoDF0AF?=
 =?us-ascii?Q?JAl7aMlH+3zOW2TRcpClS8kowJ81DASfsznrZuF8uCGfmLNWZ1av/pXgd0ku?=
 =?us-ascii?Q?uZ3AceVXFA1vweZ1h5EGZds=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800332c9-e9cf-46c5-58ae-08dc26298233
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 09:04:50.0966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgFwuKVler1yKwsjayrIXKAGdVaJyko1EQcHJiwWXblj8Fo25ewVSlvM8hneDloaDKEQesOz0qZFausze8miH+nZG423k/Wn3kksLfqnIdkLrXJ4BsGiRAyg6NzGMwiQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0815

Add V4L2_CAP_IO_MC capabality for video device. User space can enumerate
formats by mbus code.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/stf-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/starfive/camss/stf-video.c b/drivers/staging/media/starfive/camss/stf-video.c
index d9e51d4e2004..4ca889a7b757 100644
--- a/drivers/staging/media/starfive/camss/stf-video.c
+++ b/drivers/staging/media/starfive/camss/stf-video.c
@@ -665,7 +665,7 @@ int stf_video_register(struct stfcamss_video *video,
 	}
 
 	vdev->fops = &stf_vid_fops;
-	vdev->device_caps |= V4L2_CAP_STREAMING;
+	vdev->device_caps |= V4L2_CAP_STREAMING | V4L2_CAP_IO_MC;
 	vdev->entity.ops = &stf_media_ops;
 	vdev->vfl_dir = VFL_DIR_RX;
 	vdev->release = stf_video_release;
-- 
2.25.1


