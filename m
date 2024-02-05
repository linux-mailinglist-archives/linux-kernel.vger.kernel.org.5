Return-Path: <linux-kernel+bounces-52251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9428495F3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94381C23EA5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0C6171A7;
	Mon,  5 Feb 2024 09:05:10 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2116.outbound.protection.partner.outlook.cn [139.219.17.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B514A90;
	Mon,  5 Feb 2024 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123908; cv=fail; b=NNEvYwSEu/9tQw3FHD7RYWAUQgKqQ7/6zKC2NdTTWco9rHvjUTRG/HhNytsfT8rDeViqNo2VXt9XtU/8jq2omEl2ErUedCocRcUwAtsQsEpduFi6jTn26KAoMpb8vGZBNT9FYoqMyts6yDeUoVxqe4WULtf2EggAlz4bHZaKJTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123908; c=relaxed/simple;
	bh=Bg0Y96nA25zmZWaf1Omv32RLhnIHxr2hxFpxFBLLhCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bWTHAKOjfe5n2dEtVDbXLww//YvSf2b0FwrM9m+T26s+KX1eHsKkeBa6WmKiQbsM2qlmQd7Mgds/YlGQKrybDXzJDVyPsgl190AOpsgqXTiPPSkavEKuEUVgFtT1i+kn2jH+V5vSStPNlwN3glOYHJAYmwZAUtucwrSauJ96QZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OO+XiQhEcYflhHF9GA/g7oSQBODNFGd75un2/YGCJYdT7gL3BIrvFgpObw+qwLL0u/gwFsHMU28OqRSenELETs8wTw/CNULGrNBkSzBTuVxUbXpuabJj6/ugjU8ynZTfA9Bk3J3TWvBvxpYYOUSaYKqjSWKBo8MYYMIppNiKmit21xBrgxnhVUY7ol8lr0gxxGTcIqyGfZ/CFVwqcIL78cT/mNCX6bll+DNa2BzISU7Y/FPwawXA2FgkrGsafFL8GJ5d88lS6JIKuanRboDtLMJFYCHgTFEDlbb2TM4O166rGWWWfsq4TrNqZOcAKaA9L3pvHZGHqKsb2jPIM+g2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DylJqcq5oUc0EaVRWzx49BgtQN+ucVadcqg2k2vhBWU=;
 b=OiOrsN0mUxP2AQKhSa4q4EPlrzbLNUsUIP6capV4djyP3onbwPx3lhImy0B7lS70bkFKAcYCjBTb+AAWzoZonMBglgTcyikqmq7F7cWf4B6j0O1PdqCJFwlrvUG+tjXthPViP3gZwUCEIChs/DbhY48PTqI/WZ5ASZcxlEVy2SIFu2O7YE1OUPbWkzkxDMapWORa5HQOdnJ6Q22B6CjUJvnc00EZxu+EZGMP2mrEC0fvzdLbKe8E0Xyu9tXNgc/q4wDenBBBI3rhT4aEkwPq0Cjwz5fUYE7FLnAHwQW4eE+qDuSc1EOSdxv3qP5jcNqZKrsoX2oPlmFYfhEvdVF4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0815.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 09:04:51 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.025; Mon, 5 Feb 2024 09:04:51 +0000
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
Subject: [PATCH v3 11/13] staging: media: starfive: Add ISP params video device
Date: Mon,  5 Feb 2024 01:04:22 -0800
Message-Id: <20240205090424.40302-12-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: a87e6d08-c40d-4a61-aaf8-08dc2629832d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rwZw28herc85KlPdEZ1KpJ5a7G2NQWJ6uQ7FXiCKYvJXa0rcHj7MLDxBFAll1UhC65KhlqEhLvYLzI7FYQ04rF5u4y7AJudrgTLKXoAyVDfhxEBqTMyeD3Pd+ya+x0Z2fNE1qi3jg3yQk+UR7Rb5NUaGYUb9HS7jb/n0zzbwHrdtSKTQnpiyifs1hhunFFju5fOhiGkRp6BiQUFmxtePplbAItbsictdxj90iVtH0J5T0S8fgY4nfq8QLLUr5aNH6ggaNvP6CZQxynAlRxPtH9Q46Ea6eWgQ8UH7MXfL398dqFidIBkfX0wVQkxm/+vD0rvLjov30gCI9GnFXBWOz6PXvAJ1+ehbhGV7sCCV5SaEIlCqDGpq2j6M+jqnhvmm/GejHvVWqH+ImBZ4zsAT4o0KfbDUi/KXNPnwbNj9A9on/mNWvhj6Fk0yHuWfcMccW1vMJwvjcCAf7wl6Qt1NGejz4e47wWTvLmYMh1jY8QeG8EsZuaOIzVl0ft5jsaI6NC0hNwebuQ/DGtfR3A7AXcNsE5H1da2SYNC9cSUPpucy88rv8szDg+dZ5TmQx2vxHQ+tQdd5iv0y9kgUI9L+bg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41320700001)(6666004)(52116002)(36756003)(40180700001)(508600001)(38350700005)(40160700002)(38100700002)(2616005)(1076003)(26005)(83380400001)(86362001)(5660300002)(2906002)(7416002)(30864003)(8936002)(8676002)(4326008)(110136005)(44832011)(54906003)(66946007)(66556008)(66476007)(41300700001)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+EOqg5m8ktcn4N62BxLDjZR9ZD1NfBuuNwMQvGR0nZrFzHFjurQxstane929?=
 =?us-ascii?Q?C3/VMGXUHec9nIf29ttV78BdQby7mTjaOK4a7jSt4IXlEC36L1Sv02OyG9RD?=
 =?us-ascii?Q?ccoFJEeZgTPr6S6L94l6CZF1uSinXaRNM96AImp4xghg/TsCeXyXEfugha44?=
 =?us-ascii?Q?4Mr9/FUzZSqEGPescQo5tX2QbyuOSBcGRFn1nw7IIIk/H88jlMZW3GXQfpu4?=
 =?us-ascii?Q?102OZj1QjPclsNDDA6LMunsObVd6AJuo3UrQ+O20br3XEheCD2BXbSOUXTvM?=
 =?us-ascii?Q?uIcdWWRZKihP4/cVep8wHZdHyxeT/Kuz/CUabDDtR527331OOlY891srYToe?=
 =?us-ascii?Q?hud7YEfcRuJ2GwaVO220/snhgE5qcF92Ir0jZn6G9TvuFhZcIRCjEaLZeauD?=
 =?us-ascii?Q?Zo8EQuIISUKcLW7+MojIBgxE+dddJpqpmbN7/sZwpxMd8GhFuQlye6It8eUb?=
 =?us-ascii?Q?VxpP8D8120959SJeyowklu+A/BHVZbHrUwkM/PAAn2fQWQNg13eJ+n9C0V6P?=
 =?us-ascii?Q?ogC8ibOFOhIBaXH8KV2ZVzwzO0shLRqxpjSAiIjvL/ncZvxLJywift3YF+PV?=
 =?us-ascii?Q?R1U07aGJfPdZs2tj2FoBpADVQsD4qKZiT4gqQ6C7hyE2uIXKAU1jDcg7Tklc?=
 =?us-ascii?Q?0wGNkDSg94h8e8gPuuRAuJ92v+HwYpqwnb/U8muIowWpjuXmb36pobiOZKwM?=
 =?us-ascii?Q?Gbs7TTR79OyR/R9HsPyPm2p1AhzPiUaW7pAMK5f4J/rqfdlfovd7YKHugaNU?=
 =?us-ascii?Q?MSpXOvJ9iif5Onjrwfjk9eSCH7tzE+bk4T96JGipIMArhxt77qbJXByuTZAI?=
 =?us-ascii?Q?KnN0I/96ozrd1HUl74AOV/jBvcFloiOcwrJPmiS1LarJo0g3fhjT2i6EN1cP?=
 =?us-ascii?Q?D93jTx6725cweS9Tlg23W78I+0X7LS8zd6x4LZGaJeot1titGa32UP9q7thS?=
 =?us-ascii?Q?EcgBctW7kGoyravqVEDD2e/naXuQnYi6sy7GdlSB8mFWWzBxYpKHD7/Y8i7y?=
 =?us-ascii?Q?KsyEafeDVcFV8Lzm9igOtlSV4rmHJnTOXYqcC9Y2QsEPAvsNuPuztG3KUl60?=
 =?us-ascii?Q?zxTJHzD/iHaCOzquj3bNVmcxXSKbmkhqdC1g1D/kgf5SdiSHm+LcLqV/4J9x?=
 =?us-ascii?Q?e4tAGOeOUSJTeiyZNWkiG7zws7SKmiklboTfM5zpTVXuQlse4xWOI3ImPt8l?=
 =?us-ascii?Q?5EWdzWIEOGvhevGrBKALRn07VJawPEzDmJOSk/vTiQveF3wI0nZ4YSCWC7aU?=
 =?us-ascii?Q?RV2zUr1ag3A9PnHd86j2KONuibaV9e3TiZSZEepjinc3+014wWcdzp777Lfh?=
 =?us-ascii?Q?QQBraCLYcQxMzwK6FvvstMMyqsENGGRRCnfzb3ZzvfWUTTM0y2GR3LTz8NLh?=
 =?us-ascii?Q?gbpytXQmfcajDcHDfGMvRwRd5lwfN9S6pi6u7EH9z4vWLzEIX5Vz4E9vu604?=
 =?us-ascii?Q?OkbR74cfv1pB3Vri4eH+XMc99YzhyamvVScQbATtwCSu++XGkkXYyHXz/JtH?=
 =?us-ascii?Q?0WFmsf3UC8Y4J8GLOFGVtDAcjgN2e28g+L5suD3SKvs6RCBy+yLFUFkVeIG3?=
 =?us-ascii?Q?NlPZhiah8ViTD3Ey7z/snear6wflwcasAK+400SWFNb/rWFyTgyC3Ym5rq+c?=
 =?us-ascii?Q?OYl3KmSrkU+NsBEUqJdO5ww=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87e6d08-c40d-4a61-aaf8-08dc2629832d
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 09:04:51.7240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpQvEBmv7fWS7TaFynDjXXNgxYiNVBaRT8eiWvtedTgfHmcC3IgEU6XN7yFNaWM/ohcZJVzcTaWxeV91dbCvccygsEBa6LqKe/2QWh35Y9lZDTuJJl9VXpVmthZY+BdJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0815

Add ISP params video device to write ISP parameters for 3A.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/Makefile |   2 +
 .../staging/media/starfive/camss/stf-camss.c  |  23 +-
 .../staging/media/starfive/camss/stf-camss.h  |   3 +
 .../media/starfive/camss/stf-isp-params.c     | 238 ++++++++++++++++++
 .../staging/media/starfive/camss/stf-isp.h    |   4 +
 .../staging/media/starfive/camss/stf-output.c |  83 ++++++
 .../staging/media/starfive/camss/stf-output.h |  22 ++
 7 files changed, 374 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/media/starfive/camss/stf-isp-params.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-output.c
 create mode 100644 drivers/staging/media/starfive/camss/stf-output.h

diff --git a/drivers/staging/media/starfive/camss/Makefile b/drivers/staging/media/starfive/camss/Makefile
index 411b45f3fb52..077165cbba7a 100644
--- a/drivers/staging/media/starfive/camss/Makefile
+++ b/drivers/staging/media/starfive/camss/Makefile
@@ -9,6 +9,8 @@ starfive-camss-objs += \
 		stf-capture.o \
 		stf-isp.o \
 		stf-isp-hw-ops.o \
+		stf-isp-params.o \
+		stf-output.o \
 		stf-video.o
 
 obj-$(CONFIG_VIDEO_STARFIVE_CAMSS) += starfive-camss.o
diff --git a/drivers/staging/media/starfive/camss/stf-camss.c b/drivers/staging/media/starfive/camss/stf-camss.c
index 04caa4dac2f7..515d6a77ef56 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.c
+++ b/drivers/staging/media/starfive/camss/stf-camss.c
@@ -127,6 +127,7 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 {
 	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
 	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
+	struct stf_output *output = &stfcamss->output;
 	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
 	int ret;
 
@@ -137,13 +138,20 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 		return ret;
 	}
 
-	ret = stf_capture_register(stfcamss, &stfcamss->v4l2_dev);
+	ret = stf_output_register(stfcamss, &stfcamss->v4l2_dev);
 	if (ret < 0) {
 		dev_err(stfcamss->dev,
 			"failed to register capture: %d\n", ret);
 		goto err_isp_unregister;
 	}
 
+	ret = stf_capture_register(stfcamss, &stfcamss->v4l2_dev);
+	if (ret < 0) {
+		dev_err(stfcamss->dev,
+			"failed to register capture: %d\n", ret);
+		goto err_out_unregister;
+	}
+
 	ret = media_create_pad_link(&isp_dev->subdev.entity, STF_ISP_PAD_SRC,
 				    &cap_yuv->video.vdev.entity, 0, 0);
 	if (ret)
@@ -158,13 +166,23 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 
 	cap_scd->video.source_subdev = &isp_dev->subdev;
 
+	ret = media_create_pad_link(&output->video.vdev.entity, 0,
+				    &isp_dev->subdev.entity, STF_ISP_PAD_SINK_PARAMS,
+				    0);
+	if (ret)
+		goto err_rm_links1;
+
 	return ret;
 
+err_rm_links1:
+	media_entity_remove_links(&cap_scd->video.vdev.entity);
 err_rm_links0:
 	media_entity_remove_links(&isp_dev->subdev.entity);
 	media_entity_remove_links(&cap_yuv->video.vdev.entity);
 err_cap_unregister:
 	stf_capture_unregister(stfcamss);
+err_out_unregister:
+	stf_output_unregister(stfcamss);
 err_isp_unregister:
 	stf_isp_unregister(&stfcamss->isp_dev);
 
@@ -175,13 +193,16 @@ static void stfcamss_unregister_devs(struct stfcamss *stfcamss)
 {
 	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
 	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
+	struct stf_output *output = &stfcamss->output;
 	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
 
+	media_entity_remove_links(&output->video.vdev.entity);
 	media_entity_remove_links(&isp_dev->subdev.entity);
 	media_entity_remove_links(&cap_scd->video.vdev.entity);
 	media_entity_remove_links(&cap_yuv->video.vdev.entity);
 	stf_isp_unregister(&stfcamss->isp_dev);
 	stf_capture_unregister(stfcamss);
+	stf_output_unregister(stfcamss);
 }
 
 static int stfcamss_subdev_notifier_bound(struct v4l2_async_notifier *async,
diff --git a/drivers/staging/media/starfive/camss/stf-camss.h b/drivers/staging/media/starfive/camss/stf-camss.h
index ae49c7031ab7..3f84f1a1e997 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.h
+++ b/drivers/staging/media/starfive/camss/stf-camss.h
@@ -21,6 +21,7 @@
 #include "stf-buffer.h"
 #include "stf-isp.h"
 #include "stf-capture.h"
+#include "stf-output.h"
 
 enum stf_port_num {
 	STF_PORT_DVP = 0,
@@ -55,6 +56,7 @@ struct stfcamss {
 	struct device *dev;
 	struct stf_isp_dev isp_dev;
 	struct stf_capture captures[STF_CAPTURE_NUM];
+	struct stf_output output;
 	struct v4l2_async_notifier notifier;
 	void __iomem *syscon_base;
 	void __iomem *isp_base;
@@ -132,4 +134,5 @@ static inline void stf_syscon_reg_clear_bit(struct stfcamss *stfcamss,
 	value = ioread32(stfcamss->syscon_base + reg);
 	iowrite32(value & ~bit_mask, stfcamss->syscon_base + reg);
 }
+
 #endif /* STF_CAMSS_H */
diff --git a/drivers/staging/media/starfive/camss/stf-isp-params.c b/drivers/staging/media/starfive/camss/stf-isp-params.c
new file mode 100644
index 000000000000..dbf50f31709e
--- /dev/null
+++ b/drivers/staging/media/starfive/camss/stf-isp-params.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stf-isp-params.c
+ *
+ * StarFive Camera Subsystem - V4L2 device node
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+
+#include <media/videobuf2-dma-contig.h>
+
+#include "stf-camss.h"
+#include "stf-video.h"
+
+static inline struct stfcamss_buffer *
+to_stfcamss_buffer(struct vb2_v4l2_buffer *vbuf)
+{
+	return container_of(vbuf, struct stfcamss_buffer, vb);
+}
+
+static int stf_isp_params_queue_setup(struct vb2_queue *q,
+				      unsigned int *num_buffers,
+				      unsigned int *num_planes,
+				      unsigned int sizes[],
+				      struct device *alloc_devs[])
+{
+	*num_planes = 1;
+	sizes[0] = sizeof(struct jh7110_isp_params_buffer);
+
+	return 0;
+}
+
+static int stf_isp_params_buf_init(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct stfcamss_buffer *buffer = to_stfcamss_buffer(vbuf);
+	dma_addr_t *paddr;
+
+	paddr = vb2_plane_cookie(vb, 0);
+	buffer->addr[0] = *paddr;
+	buffer->vaddr = vb2_plane_vaddr(vb, 0);
+
+	return 0;
+}
+
+static int stf_isp_params_buf_prepare(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+
+	if (sizeof(struct jh7110_isp_params_buffer) > vb2_plane_size(vb, 0))
+		return -EINVAL;
+
+	vb2_set_plane_payload(vb, 0, sizeof(struct jh7110_isp_params_buffer));
+
+	vbuf->field = V4L2_FIELD_NONE;
+
+	return 0;
+}
+
+static void stf_isp_params_buf_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct stfcamss_video *video = vb2_get_drv_priv(vb->vb2_queue);
+	struct stfcamss_buffer *buffer = to_stfcamss_buffer(vbuf);
+
+	video->ops->queue_buffer(video, buffer);
+}
+
+static void stf_isp_params_stop_streaming(struct vb2_queue *q)
+{
+	struct stfcamss_video *video = vb2_get_drv_priv(q);
+
+	video->ops->flush_buffers(video, VB2_BUF_STATE_ERROR);
+}
+
+static const struct vb2_ops stf_isp_params_vb2_q_ops = {
+	.queue_setup     = stf_isp_params_queue_setup,
+	.wait_prepare    = vb2_ops_wait_prepare,
+	.wait_finish     = vb2_ops_wait_finish,
+	.buf_init        = stf_isp_params_buf_init,
+	.buf_prepare     = stf_isp_params_buf_prepare,
+	.buf_queue       = stf_isp_params_buf_queue,
+	.stop_streaming  = stf_isp_params_stop_streaming,
+};
+
+static int stf_isp_params_init_format(struct stfcamss_video *video)
+{
+	video->active_fmt.fmt.meta.dataformat = V4L2_META_FMT_STF_ISP_PARAMS;
+	video->active_fmt.fmt.meta.buffersize = sizeof(struct jh7110_isp_params_buffer);
+
+	return 0;
+}
+
+static int stf_isp_params_querycap(struct file *file, void *fh,
+				   struct v4l2_capability *cap)
+{
+	strscpy(cap->driver, "starfive-camss", sizeof(cap->driver));
+	strscpy(cap->card, "Starfive Camera Subsystem", sizeof(cap->card));
+
+	return 0;
+}
+
+static int stf_isp_params_enum_fmt(struct file *file, void *priv,
+				   struct v4l2_fmtdesc *f)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+
+	if (f->index > 0 || f->type != video->type)
+		return -EINVAL;
+
+	f->pixelformat = video->active_fmt.fmt.meta.dataformat;
+	return 0;
+}
+
+static int stf_isp_params_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct stfcamss_video *video = video_drvdata(file);
+	struct v4l2_meta_format *meta = &f->fmt.meta;
+
+	if (f->type != video->type)
+		return -EINVAL;
+
+	meta->dataformat = video->active_fmt.fmt.meta.dataformat;
+	meta->buffersize = video->active_fmt.fmt.meta.buffersize;
+
+	return 0;
+}
+
+static const struct v4l2_ioctl_ops stf_isp_params_ioctl_ops = {
+	.vidioc_querycap                = stf_isp_params_querycap,
+	.vidioc_enum_fmt_meta_out	= stf_isp_params_enum_fmt,
+	.vidioc_g_fmt_meta_out          = stf_isp_params_g_fmt,
+	.vidioc_s_fmt_meta_out          = stf_isp_params_g_fmt,
+	.vidioc_try_fmt_meta_out        = stf_isp_params_g_fmt,
+	.vidioc_reqbufs                 = vb2_ioctl_reqbufs,
+	.vidioc_querybuf                = vb2_ioctl_querybuf,
+	.vidioc_qbuf                    = vb2_ioctl_qbuf,
+	.vidioc_expbuf                  = vb2_ioctl_expbuf,
+	.vidioc_dqbuf                   = vb2_ioctl_dqbuf,
+	.vidioc_create_bufs             = vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf             = vb2_ioctl_prepare_buf,
+	.vidioc_streamon                = vb2_ioctl_streamon,
+	.vidioc_streamoff               = vb2_ioctl_streamoff,
+};
+
+static const struct v4l2_file_operations stf_isp_params_fops = {
+	.owner          = THIS_MODULE,
+	.unlocked_ioctl = video_ioctl2,
+	.open           = v4l2_fh_open,
+	.release        = vb2_fop_release,
+	.poll           = vb2_fop_poll,
+	.mmap           = vb2_fop_mmap,
+	.read           = vb2_fop_read,
+};
+
+static void stf_isp_params_release(struct video_device *vdev)
+{
+	struct stfcamss_video *video = video_get_drvdata(vdev);
+
+	media_entity_cleanup(&vdev->entity);
+
+	mutex_destroy(&video->q_lock);
+	mutex_destroy(&video->lock);
+}
+
+int stf_isp_params_register(struct stfcamss_video *video,
+			    struct v4l2_device *v4l2_dev,
+			    const char *name)
+{
+	struct video_device *vdev = &video->vdev;
+	struct vb2_queue *q;
+	struct media_pad *pad = &video->pad;
+	int ret;
+
+	mutex_init(&video->q_lock);
+	mutex_init(&video->lock);
+
+	q = &video->vb2_q;
+	q->drv_priv = video;
+	q->mem_ops = &vb2_dma_contig_memops;
+	q->ops = &stf_isp_params_vb2_q_ops;
+	q->type = video->type;
+	q->io_modes = VB2_DMABUF | VB2_MMAP;
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->buf_struct_size = sizeof(struct stfcamss_buffer);
+	q->dev = video->stfcamss->dev;
+	q->lock = &video->q_lock;
+	q->min_queued_buffers = STFCAMSS_MIN_BUFFERS;
+	ret = vb2_queue_init(q);
+	if (ret < 0) {
+		dev_err(video->stfcamss->dev,
+			"Failed to init vb2 queue: %d\n", ret);
+		goto err_mutex_destroy;
+	}
+
+	pad->flags = MEDIA_PAD_FL_SOURCE;
+	ret = media_entity_pads_init(&vdev->entity, 1, pad);
+	if (ret < 0) {
+		dev_err(video->stfcamss->dev,
+			"Failed to init video entity: %d\n", ret);
+		goto err_mutex_destroy;
+	}
+
+	ret = stf_isp_params_init_format(video);
+	if (ret < 0) {
+		dev_err(video->stfcamss->dev,
+			"Failed to init format: %d\n", ret);
+		goto err_media_cleanup;
+	}
+	vdev->ioctl_ops = &stf_isp_params_ioctl_ops;
+	vdev->device_caps = V4L2_CAP_META_OUTPUT;
+	vdev->fops = &stf_isp_params_fops;
+	vdev->device_caps |= V4L2_CAP_STREAMING | V4L2_CAP_IO_MC;
+	vdev->vfl_dir = VFL_DIR_TX;
+	vdev->release = stf_isp_params_release;
+	vdev->v4l2_dev = v4l2_dev;
+	vdev->queue = &video->vb2_q;
+	vdev->lock = &video->lock;
+	strscpy(vdev->name, name, sizeof(vdev->name));
+
+	video_set_drvdata(vdev, video);
+
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+	if (ret < 0) {
+		dev_err(video->stfcamss->dev,
+			"Failed to register video device: %d\n", ret);
+		goto err_media_cleanup;
+	}
+
+	return 0;
+
+err_media_cleanup:
+	media_entity_cleanup(&vdev->entity);
+err_mutex_destroy:
+	mutex_destroy(&video->lock);
+	mutex_destroy(&video->q_lock);
+	return ret;
+}
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index eca3ba1ade75..76ea943bfe98 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -474,4 +474,8 @@ void stf_set_scd_addr(struct stfcamss *stfcamss,
 		      dma_addr_t yhist_addr, dma_addr_t scd_addr,
 		      enum stf_isp_type_scd type_scd);
 
+int stf_isp_params_register(struct stfcamss_video *video,
+			    struct v4l2_device *v4l2_dev,
+			    const char *name);
+
 #endif /* STF_ISP_H */
diff --git a/drivers/staging/media/starfive/camss/stf-output.c b/drivers/staging/media/starfive/camss/stf-output.c
new file mode 100644
index 000000000000..8eaf4979cafa
--- /dev/null
+++ b/drivers/staging/media/starfive/camss/stf-output.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive Camera Subsystem - output device
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+#include "stf-camss.h"
+
+static inline struct stf_output *to_stf_output(struct stfcamss_video *video)
+{
+	return container_of(video, struct stf_output, video);
+}
+
+static int stf_output_queue_buffer(struct stfcamss_video *video,
+				   struct stfcamss_buffer *buf)
+{
+	struct stf_output *output = to_stf_output(video);
+	struct stf_v_buf *v_bufs = &output->buffers;
+	unsigned long flags;
+
+	spin_lock_irqsave(&v_bufs->lock, flags);
+	stf_buf_add_ready(v_bufs, buf);
+	spin_unlock_irqrestore(&v_bufs->lock, flags);
+
+	return 0;
+}
+
+static int stf_output_flush_buffers(struct stfcamss_video *video,
+				    enum vb2_buffer_state state)
+{
+	struct stf_output *output = to_stf_output(video);
+	struct stf_v_buf *v_bufs = &output->buffers;
+	unsigned long flags;
+
+	spin_lock_irqsave(&v_bufs->lock, flags);
+	stf_buf_flush(v_bufs, state);
+	spin_unlock_irqrestore(&v_bufs->lock, flags);
+
+	return 0;
+}
+
+static const struct stfcamss_video_ops stf_output_ops = {
+	.queue_buffer = stf_output_queue_buffer,
+	.flush_buffers = stf_output_flush_buffers,
+};
+
+static void stf_output_init(struct stfcamss *stfcamss, struct stf_output *out)
+{
+	out->buffers.state = STF_OUTPUT_OFF;
+	out->buffers.buf[0] = NULL;
+	out->buffers.buf[1] = NULL;
+	out->buffers.active_buf = 0;
+	INIT_LIST_HEAD(&out->buffers.pending_bufs);
+	INIT_LIST_HEAD(&out->buffers.ready_bufs);
+	spin_lock_init(&out->buffers.lock);
+
+	out->video.stfcamss = stfcamss;
+	out->video.type = V4L2_BUF_TYPE_META_OUTPUT;
+}
+
+void stf_output_unregister(struct stfcamss *stfcamss)
+{
+	struct stf_output *output = &stfcamss->output;
+
+	if (!video_is_registered(&output->video.vdev))
+		return;
+
+	media_entity_cleanup(&output->video.vdev.entity);
+	vb2_video_unregister_device(&output->video.vdev);
+}
+
+int stf_output_register(struct stfcamss *stfcamss,
+			struct v4l2_device *v4l2_dev)
+{
+	struct stf_output *output = &stfcamss->output;
+
+	output->video.ops = &stf_output_ops;
+	stf_output_init(stfcamss, output);
+	stf_isp_params_register(&output->video, v4l2_dev, "output_params");
+
+	return 0;
+}
diff --git a/drivers/staging/media/starfive/camss/stf-output.h b/drivers/staging/media/starfive/camss/stf-output.h
new file mode 100644
index 000000000000..d3591a0b609b
--- /dev/null
+++ b/drivers/staging/media/starfive/camss/stf-output.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Starfive Camera Subsystem driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+#ifndef STF_OUTPUT_H
+#define STF_OUTPUT_H
+
+#include "stf-video.h"
+
+struct stf_output {
+	struct stfcamss_video video;
+	struct stf_v_buf buffers;
+};
+
+int stf_output_register(struct stfcamss *stfcamss,
+			struct v4l2_device *v4l2_dev);
+void stf_output_unregister(struct stfcamss *stfcamss);
+
+#endif
-- 
2.25.1


