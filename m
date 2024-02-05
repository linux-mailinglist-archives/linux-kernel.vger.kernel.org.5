Return-Path: <linux-kernel+bounces-52243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D2A8495D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 743AAB222F2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB2712B6B;
	Mon,  5 Feb 2024 09:04:52 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2116.outbound.protection.partner.outlook.cn [139.219.17.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1493E12B69;
	Mon,  5 Feb 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123892; cv=fail; b=YjtJJD3d/aZR2i3W92kN49At1qMdSovzrg1o1lL80rbYQQN8o/Xb6uwTkGWPqIi20Jd5TeWbLaY02wzjhZtXnfCgEv4duU6qbYAqoJEnCQ5sl2X3n9nnDU5OjkWWm6/Hp0CCyvrNVXvlR+xYS0xVBq3qH2usbsfZts9b3GsCuyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123892; c=relaxed/simple;
	bh=DP6vw8YEKz+8UEyTmRjFodZ8c57T74Rp8KzMtvKWjiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H1iTr9+MsND4p/rxviigB4Jd6LaFZJT7BCBl7E2Bb0iD/dAKwZ0Nxg8MzlcjJmtszLSjQr4hvaE+jtmCWnUXT9gg3sPdeVxhcnUp9dBA+R45Rm7Kdz6670of5zn43CPgGavFmEAvqUURBCA7o2MtzCu083PAqOdcbSOYFnhqSPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMha0IZXcArWJjBtmlv6DMFO8cC47pQ+AB/aVPMQ44dZNh+T1l+pQn+fUXpAIgV7e6hgU6dsPI1SbvrFS4SvvOC8DlP9FdTA9OwZ6hPimgy1jMLaaN3cJP973DW0PGz4bFTWT2UBqZntDZ8Nr4oGc/ddTuXCAx/Cp3PxuG6MTnymIBpAlDxFRIRy1RDw1uhuxiNCSQ3ZClXkWBOkNeRChwmEm+vIIVKngYWYsMfcB0uS2axglaSSCfLW2TrfkDtXI4n0AsELzIgEbh8+jULgfikR476f/SckSRPP9VfUBQ4A6uEphMuKNw6kqfILIBFakNZeIZDMv94VbiIdiskcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Oz04WczGquyYac0YzEHJqFUIgWs0NknqBW7vIHdw44=;
 b=E48HM07D+0clVyDvy4fzveGX6Te04T8x37o/Wm6bmzNW9LbabVNo6GkKQ3UYopLU1Q4oPOBo3L8ObUmloLfh6LB3Hd95gtSNAMrDd9yC4AjcRRDfQ6kFgXacLOa3e5/ZdmT1CUJWK8d3R9cxwm65r5uGy6QRr4uSlH8tqhsRTI4bSUP1Zvm+e9FAIPH7AHBJWnAjG1LKfn/WR55jzuh3mz7KWJ+uoNzXuz1OqS6yDYOtC7G0PHgXbK3K5jtSrNywTjLU1sbT+mjV4rxALJYrXKecB4xCmyHO2gDJyCwgM3Sk1ocgbwKNSyQhn5bAqgSa1vyS6RDKKBPu5rZ/JJotjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0815.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 09:04:37 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.025; Mon, 5 Feb 2024 09:04:37 +0000
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
Subject: [PATCH v3 02/13] media: Documentation: Add description for StarFive ISP metadata formats
Date: Mon,  5 Feb 2024 01:04:13 -0800
Message-Id: <20240205090424.40302-3-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4da0e80d-04d5-409c-9f62-08dc26297a59
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F92jqKvXW3MTG7APsPUN865rIdIZFh83Kr1dwW4zP6A9qc/cErLpd6CPU3oPc9Bdj8W0hugudEadg4ZzuXdU6B5CduU4gbnqY2qc+qNeq6ECGUN+RwEROoU6yOosMetx7OAvJjDC24VTQl9OIBYuEDg/D3gLq0ftBZHswPCmpeV9Jbl/cOKiiNYNPJbP5QuqiAczXhmCdwLjUKR4dP+u5tYlJc6NfGJg7vvh651QjTHvZK7wsT1mDdKdagMUkFyvpgfB70nxZW3LMCUo9MdQc+6DD0ZX61PBpzMTBX9nkUVNWQ/ez5XYbOE3TWr78d8Hiq+RpC2Se/ZMQwn3ZY4ggOM4HNQb6kINWvfKWcBtW3SmW4EN+L2U6QoYoE1iyCnOGzDwkWDOEhtiQS3eNWHyI1oKSO3YQ0O7ItJbGvLi/n0OrNww1yL1OrFFk+NlcZ8ucl/1Rk6ovkid21Oz6CtIwxV/0IeSBPxDjeX16RYN6FjaDmNJEV5EIguzzpveUjHMimSCjsXNk7ODIaLQzEEnlTTnUM+WPjB54H5hI4hiVuLQkefpcpl9zrlNW0OwNHslWJ2jPxOnhsqNmOMQ+TysVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41320700001)(6666004)(52116002)(36756003)(40180700001)(508600001)(38350700005)(40160700002)(38100700002)(2616005)(1076003)(26005)(83380400001)(86362001)(5660300002)(2906002)(7416002)(8936002)(8676002)(4326008)(110136005)(44832011)(54906003)(66946007)(66556008)(66476007)(41300700001)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rKgHpZa9Ar7xDABbxO6KQ2VC6d2skbCuA9EPRnHp2SAfOlgUteo9eNOZJT1f?=
 =?us-ascii?Q?e58q7smQWrtWo8cz/YJdJfEykIhtopmlysylrEa789qCWEoKX108kh1Wrb28?=
 =?us-ascii?Q?AUEfXC9a5GmrkPEo/vTrX5p0frIiQt2JSO6v0b2FpITrBcVZ1Gw3dhmHBYTQ?=
 =?us-ascii?Q?FzsE11D4DRpLNavLzZ2VdiiyZ+TDZkS/yVcbz6OqgmgAYFXNYtMXYeZGrS8J?=
 =?us-ascii?Q?wI0ZGdo1e7JAQNBKO/DalWbMQdV7Q8m2mOomxfLi2iRzge8Dy5iRN0eIgyHH?=
 =?us-ascii?Q?KThyP1jc46yWnj5oPaBK0kvzWzpQnGmpLFrCS3BipX1hcEio45hdyL/1R9OX?=
 =?us-ascii?Q?cvFyi8DYP0Ty4/yLWC9yat4PU6F0owGezHX8s1IdMpZjsXTx2jT4Nk2UWx+u?=
 =?us-ascii?Q?cJtL5g4jEZJkNfl+d7qQdHwt8hV+J88GtYoydL4Pej5KWI3NzckTiR5uSE0F?=
 =?us-ascii?Q?HYmQvme3XPDjzqbgr+ZN9Nyfrfwb21y2Ayg9bYlXRCWx9sMMcn6LN9Jf0wyX?=
 =?us-ascii?Q?kwD3JPoUBkmRnWMQflJ6Tep/T98GXI0K1NTQQgqbGYaHZfTugkHIhWR6zOhq?=
 =?us-ascii?Q?HnXsos/yxGGDkEXywUjjXYcaV8Uok0+VhB/28GsxbkRTns/dqKHXWnLUc/Nl?=
 =?us-ascii?Q?JFNidRiOLuxhIqrmjf7okI1bLzuc181creewU+Nfb9jUURaj1O4PL3Xga+r8?=
 =?us-ascii?Q?EoNvEC3LxL1JLzWK1hH8Lm7zdRTng+7cdZxf66dnKJHfYUZQ/GpzDykbVwv2?=
 =?us-ascii?Q?W/lACvjY6yBLAcLhwdt8jOeOPQXjxRN10Yh+cv5MRzh5zp5/nYoOIknFpQzk?=
 =?us-ascii?Q?WAieuNU5NTiEqyXWf2RmopIHn9kXRVX+Q4eRYTEgdjCnyg9JnjWPRvddjsei?=
 =?us-ascii?Q?uwC5puNGvJ3Oacrn2Ul4dIMh5wCKkIimWVcz6YbdjuBiXkcadQO0INqJK7VR?=
 =?us-ascii?Q?f3k4ezLxuwtXLETFERM6ZPBLhN9FMQcMPWpP8F2nzd5zYazp3nw0lYRiMv0w?=
 =?us-ascii?Q?dCopYlt2Ofi+qLzwalW7R/cyw1D8hvXxz4FiMkXg9Gg8U0ltRzl2qvsJRrQj?=
 =?us-ascii?Q?zPMAs/zn2dyWNIy0GpJp033XzBStoXQnTD0jnUyXhmxsDKhQFyKggYvzZRbU?=
 =?us-ascii?Q?di5EcMLWZNqtKmlZ5fxVfRqKAiZ+jeYs1S6yGTqito0ulQS5wYBp7Ec5gwhA?=
 =?us-ascii?Q?rKWp4xvqMLeE3J9GlfHz+ZWY6u0kKKFccuSy9UXaBgIUxJUWUlQzddHtFJr2?=
 =?us-ascii?Q?klzCPSZjN6KXG3hIqAOx1E/DhgsRBPmK0VaADh+3UXNJ2ZWcP6GD9rmw8wkR?=
 =?us-ascii?Q?KaxgGyndhI/EgrJAk6gDkNEY992qK1cwUrISa87PRHyuUkK5G+SGpBhP0EHB?=
 =?us-ascii?Q?00b/zUrClKzKaWtCqpQ3AxgGOQc/Nrnj+HY7Hzu7zxDJnJ2zyBLOVHfoDZ05?=
 =?us-ascii?Q?HYGO/aofTFYaXuLgZ7EPAi3HCCWcDpAAExqdL4vEgTdqVNnJGvQDJ9g7bibP?=
 =?us-ascii?Q?jCV6XeBBCDjv1M6tvYo9wPLzbEPDro4tcMTkvY2KyPZF6LzYofzfvOia0aaJ?=
 =?us-ascii?Q?g2qtdHWGY9ZpbVewvQLbLOaVOKHTpI5svTXi3Pj+D65I10gFj/uYNgP+eYLp?=
 =?us-ascii?Q?FVOxOgy4muSX3/VR9jfErms=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da0e80d-04d5-409c-9f62-08dc26297a59
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 09:04:36.9317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78aNcK7gaLGV0nH09YGD3iYhzcFfagXo+rEn0+Ifm20RYn0R6oGU4a5NxbNnW5/tEnUipSMj5YpzkUgFI0/UpPrBZEGoENnj/6dBPVWpHo0/KMCjsmMx5saSLGkhdjN6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0815

Add description for V4L2_META_FMT_STF_ISP_PARAMS and
V4L2_META_FMT_STF_ISP_STAT_3A meta data formats.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../media/v4l/metafmt-starfive-isp.rst        | 75 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/userspace-api/media/v4l/metafmt-starfive-isp.rst

diff --git a/Documentation/userspace-api/media/v4l/metafmt-starfive-isp.rst b/Documentation/userspace-api/media/v4l/metafmt-starfive-isp.rst
new file mode 100644
index 000000000000..ebb4291833d6
--- /dev/null
+++ b/Documentation/userspace-api/media/v4l/metafmt-starfive-isp.rst
@@ -0,0 +1,75 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _v4l2-meta-fmt-stf-isp-params:
+
+.. _v4l2-meta-fmt-stf-isp-stat-3a:
+
+*****************************************************************************
+V4L2_META_FMT_STF_ISP_PARAMS ('stfp'), V4L2_META_FMT_STF_ISP_STAT_3A ('stfs')
+*****************************************************************************
+
+.. jh7110_isp_params_buffer
+
+Configuration parameters
+========================
+
+The configuration parameters are passed to the "output_params" metadata output
+video node, using the :c:type:`v4l2_meta_format` interface. They are formatted
+as described by the :c:type:`jh7110_isp_params_buffer` structure.
+
+.. code-block:: c
+
+	struct jh7110_isp_params_buffer {
+		__u32 enable_setting;
+		struct jh7110_isp_wb_setting wb_setting;
+		struct jh7110_isp_car_setting car_setting;
+		struct jh7110_isp_ccm_setting ccm_setting;
+		struct jh7110_isp_cfa_setting cfa_setting;
+		struct jh7110_isp_ctc_setting ctc_setting;
+		struct jh7110_isp_dbc_setting dbc_setting;
+		struct jh7110_isp_dnyuv_setting dnyuv_setting;
+		struct jh7110_isp_gmargb_setting gmargb_setting;
+		struct jh7110_isp_lccf_setting lccf_setting;
+		struct jh7110_isp_obc_setting obc_setting;
+		struct jh7110_isp_oecf_setting oecf_setting;
+		struct jh7110_isp_r2y_setting r2y_setting;
+		struct jh7110_isp_sat_setting sat_setting;
+		struct jh7110_isp_sharp_setting sharp_setting;
+		struct jh7110_isp_ycrv_setting ycrv_setting;
+		struct jh7110_isp_sc_setting sc_setting;
+	};
+
+.. jh7110_isp_sc_buffer
+
+3A and histogram statistics
+===========================
+
+The ISP device collects different statistics over an input Bayer frame.
+Those statistics are obtained from the "capture_scd" metadata capture video
+node, using the :c:type:`v4l2_meta_format` interface. They are formatted as
+described by the :c:type:`jh7110_isp_sc_buffer` structure.
+
+.. code-block:: c
+
+	struct jh7110_isp_sc_buffer {
+		__u32 y_histogram[64];
+		__u32 reserv0[33];
+		__u32 bright_sc[4096];
+		__u32 reserv1[96];
+		__u32 ae_hist_y[128];
+		__u32 reserv2[511];
+		__u16 flag;
+	};
+
+The statistics collected are Auto Exposure, AWB (Auto-white balance), Histogram
+and AF (Auto-focus). See :c:type:`jh7110_isp_sc_buffer` for details of the
+statistics.
+
+The 3A statistics and configuration parameters described here are usually
+consumed and produced by dedicated user space libraries that comprise the
+important tuning tools using software control loop.
+
+JH7110 ISP uAPI data types
+======================
+
+.. kernel-doc:: include/uapi/linux/jh7110-isp.h
diff --git a/MAINTAINERS b/MAINTAINERS
index d5679e5410bd..f4017aece273 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20838,6 +20838,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/media/starfive_camss.rst
 F:	Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
+F:	Documentation/userspace-api/media/v4l/metafmt-starfive-isp.rst
 F:	drivers/staging/media/starfive/camss
 F:	include/uapi/linux/jh7110-isp.h
 
-- 
2.25.1


