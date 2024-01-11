Return-Path: <linux-kernel+bounces-23272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66F882AA0C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7FE1C25497
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937A014A86;
	Thu, 11 Jan 2024 08:57:40 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2048.outbound.protection.partner.outlook.cn [139.219.17.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1DD1772A;
	Thu, 11 Jan 2024 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqMF1xSK2TBXo+hN5hMSLey47oSzptIjZ7IpPCCUPV2+RF6X15YDhbniDX0zrP+8cy5Qlox8jRRFzKn12Bb+sfTfXDkp1PYyf1lRqkA446qqxwIQZZp7s6QGQivec76a1XKa2PIzirEhWiyJ3g1fxEl85fcwdP8QrUDLUjbv8A8EhgvgrnjxxFjZ5hzZNqXbpG2ltr5jtqVSMw2spS57J38bcGn5jGd5VRdsy/7JR4aVRBhAE+N1DTWyNVUYqvs3zBY/Bjm3IM67E4cmx+3jzTPOiACviQRw1zwRb4HSSSrj/UeISvo1Y4HwShOBYotrnX1l5v4EAsliBVfD9z/jcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLUIKEQOFP7DwdGLZjRCF2pAtfcyYftOURWGq1yoAI0=;
 b=fbGTU1Lf3nhzZwgMfixnez6rhAilelHDmH4e6+lOQZbwv/+PwvcOz7lexe/SMKF9Ts4iEBF84RX/5vvRZ7qINRXBziylIImfXMywI/ppgfY9ApVkujK2cBb3RWp5QGod4XpjjFZXbKQDyF5zw8gjZLZj83PLsABCRw1uk3doXOl2ykbtT1Pz17gAnzXVsRU3N31M6OfkJEXyLvhUufFEBQaN+vwycYoxt/XMGyK0D+STrDldduqv1LCceCA1cw2t78XSSzleds/9VWwBYsw0hejt1d9l4Z0Q/AH2Kh+TEE2a/2X92SESa89FteJoQ5xzQsutKVr64ZO7KWYavANmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21) by SH0PR01MB0747.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Thu, 11 Jan
 2024 08:41:36 +0000
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 ([fe80::e255:98f3:ba27:8c7d]) by
 SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn ([fe80::e255:98f3:ba27:8c7d%3])
 with mapi id 15.20.7135.033; Thu, 11 Jan 2024 08:41:36 +0000
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
Subject: [PATCH v2 11/13] staging: media: starfive: Add ISP params video device
Date: Thu, 11 Jan 2024 00:41:18 -0800
Message-Id: <20240111084120.16685-12-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111084120.16685-1-changhuang.liang@starfivetech.com>
References: <20240111084120.16685-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0009.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::19) To SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0667:EE_|SH0PR01MB0747:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c01548-62bc-41a4-d3d2-08dc12811f7d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fueyE9LVBXstFBeW+NxQsNnBiWfh/SMClUZg0zx0KtRKvJYuk5SqGAFpXfiOsY1Gvb6wt/W8ZDncqmNNi1ejP43oNp/ZEKYJpi+3Od4Ga7c87EFiEHCRFI0DgOygXd7RkiIyp3uWpSEkylzxX9WDoC7tjN1kQUEyOoLfi6t0JYhwsaYr3O4MqfwacUolz5MG2vjka1e6ugIFP0NAvJgoPOyA8rm1jRWFxDvdTY986jBC830fUYfuJe3D+yysdfRzTfiUc/rI+RVmCiVtzvp7iztiX4GjCIEmmbdvHJnISkeTqt/wiU1o1D4oWrhw+NHFBnyReuShEwkhD53lo9BNTDvSpYsqorHTWSEyS5dImRVJtA0gb2M4Jl46FeP4p3Q9HjJnHN55NU8rCHj8A/NdyO0OxIQ3WswaASZyWZoyuAjd/0YTbCvZcB9YD4zeZ6JNZlrcDgsDWb78L2qYcX3qRc33EUjoZw2Hpa1kbse0+lO39nY7p6Ke5sg3XLgZAb2ZtTUY45426aUQscfqFMnFhb9z9pF+32+2GtfxTcSpAzzEo7fXgqUSMEKDNoc8idkbR1LUfWM98K+gQC73TIrSkA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39830400003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(52116002)(41300700001)(2616005)(508600001)(38100700002)(40160700002)(1076003)(26005)(86362001)(36756003)(921011)(38350700005)(83380400001)(110136005)(54906003)(66556008)(66946007)(66476007)(8676002)(8936002)(41320700001)(4326008)(44832011)(2906002)(40180700001)(5660300002)(30864003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KkTbOREDLQMIVVeEWy3nig3rMv5htH3p6Ccwx8uexaWrFI6+sxxvgT2gAbE7?=
 =?us-ascii?Q?AKXZmrgw/mmOeb8kBcYD/e4nMhpmfEPBV/vItTTYHH2cZPiA5JNgAzfpvYcu?=
 =?us-ascii?Q?7Zkl+PckMn/XDc3PwtNcFG8KEW6IX55W6yzNsV637QvUDdg1OtLW6+es5w4S?=
 =?us-ascii?Q?7reGVC3ZOYt/oVNcAdY4LoBcjjlagRkAqvDuPO9cjSQgt74O1/lQf7YRQiGc?=
 =?us-ascii?Q?9t/euZYhprQ2k4UN79DXGmpPDaw/YzCcAfEvsK0f7i1zexbqJW0KIlYSg7sw?=
 =?us-ascii?Q?0uCaytj5ryfXyBWYGWJMuh6pmFm072jWH2ib/iP9JI6DGi6bMHuRaFfNQ46t?=
 =?us-ascii?Q?TKyL9slEujXURuzq+PXAv6jusAYUP1dflbf25JaqTwyawis7vZer3lnTJS+D?=
 =?us-ascii?Q?9AaWx+QsFHDdrf4OhjqjvY/fz6tWlBs6UCWSqXCYqgVy551xqUzM66NVbVCQ?=
 =?us-ascii?Q?7I8i5Ow0LWZwEQ95Toeo4ronSnrJm/xj7Xdew8Ppk9tsbgply4D4E9gaApYR?=
 =?us-ascii?Q?sRiQ4itku1Jn6dZIMP0bh/m/vBpNllAbfY+JTIDCBNPTdJDCLxyHkzHKjU8Y?=
 =?us-ascii?Q?AsOtNbftOSnHue60VXX2AD0dzlQug4VskA/8d4+nAZTYassr+XLaW6h+8K5A?=
 =?us-ascii?Q?QMa6qiuON8x6rBGd7tA4A0c2NDUkNh3RKFi5/dMNHEWI6Kj/MVwh6HFOo9Xo?=
 =?us-ascii?Q?Db+SNqvtPo6E3dL0A3QojD0FQaQABRsyWckLjdhcER/XjE2WQXfaEw9ZUu2V?=
 =?us-ascii?Q?3q+HItVtY/JpG6u5SrcXk2LCaZ0lwttO1/ZGgBSlQ065IaxLFdjNCnZKUDBn?=
 =?us-ascii?Q?CNPTAaVcojj8HW3bdsQcbHQjQTp5kitgHRe183s/m63UWcD8NxkvXyMmvaPW?=
 =?us-ascii?Q?g5girpuH6dZb4vawYzOn5HK4YkLhIddSODfCTeOKsyRUiEdyz1zcE4Y7i+N2?=
 =?us-ascii?Q?rjNvsAgqWWV2Aw7VGSatVPrC+9XNKGpxfxlNAQg3Hp8i3izWPQJUJU02xc3b?=
 =?us-ascii?Q?9E4uovIu9n7BqOEeyCwaoyUJzIULzx4jJC0BN7Ymu6z129TJBH5x1GYUrcCZ?=
 =?us-ascii?Q?89raiNy3OX1pKLuw98q1h+Hhe+Ms2dM+pTG4SHf+PqGvMq3FwW4dhKA/jdLl?=
 =?us-ascii?Q?VansNFFJM4E0NkAbWvsUYUyvMH6DYy7BHeqF5PmyDWt7iZZqcvutRpEn8Lf5?=
 =?us-ascii?Q?+0fvSLoKo9XkuGliMYk5/+AL5fKLxXCcTdmSQy2j5bMELC8/Jre+Uaa66eiE?=
 =?us-ascii?Q?3Z0lQ5jybiSadeyyLSHufJyfmDFQJbbfs/nrKTLQzR9FzSEBJYmXD1HMhSxO?=
 =?us-ascii?Q?y9h4MoAy6ZZGlqD2YBhPH96doYLu3f7KzY7b5olJ8Izok+WLeX75h5Vujd64?=
 =?us-ascii?Q?UNXFgtzDRyejla3DA6VG1FkVDHCbTw2lRhsn07Awb1oDBdwnNyWMxTeHTduz?=
 =?us-ascii?Q?coqiLiVu9Oh4Yb5+NrJMQhXgM6IiWFSjX+pO1zXUTV4MaAwZu2EkRGvRxKyR?=
 =?us-ascii?Q?LD/UTzLfj3RyaUlB3uYKWelcBoGbwK/ZkRJl2KmbAazFWqHVZP9pcf0xa5VT?=
 =?us-ascii?Q?S6K2sRhfq6KvdkH8mMtyNHN2iToqPjB0ec3ZbtGB4XgazWRSrxpTJssP/tvT?=
 =?us-ascii?Q?320Ho9vDz4OimHyddXwQ5r0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c01548-62bc-41a4-d3d2-08dc12811f7d
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 08:41:36.9134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RabgP1r4XluhLODgEeR3gpvxxbb35dknwW9uxX43PlPD7xxe3AOZNddri6W5KdJzFkqOmxEviNvfv4FfGJVCJMSzV5mpP9uJ4fBTlSDmiavdoia4y0u52ldpLuJ/DfeC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0747

Add ISP params video device to write ISP parameters for 3A.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/Makefile |   2 +
 .../staging/media/starfive/camss/stf-camss.c  |  19 +-
 .../staging/media/starfive/camss/stf-camss.h  |   3 +
 .../media/starfive/camss/stf-isp-params.c     | 238 ++++++++++++++++++
 .../staging/media/starfive/camss/stf-isp.h    |   4 +
 .../staging/media/starfive/camss/stf-output.c |  83 ++++++
 .../staging/media/starfive/camss/stf-output.h |  22 ++
 7 files changed, 370 insertions(+), 1 deletion(-)
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
index 3175d0d9a05c..51357f905a42 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.c
+++ b/drivers/staging/media/starfive/camss/stf-camss.c
@@ -127,6 +127,7 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 {
 	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
 	struct stf_capture *cap_scd = &stfcamss->captures[STF_CAPTURE_SCD];
+	struct stf_output *output = &stfcamss->output;
 	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
 	int ret;
 
@@ -137,13 +138,26 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
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
+	ret = media_create_pad_link(&output->video.vdev.entity, 0,
+				    &isp_dev->subdev.entity, STF_ISP_PAD_SINK_PARAMS,
+				    0);
+	if (ret)
+		goto err_cap_unregister;
+
 	ret = media_create_pad_link(&isp_dev->subdev.entity, STF_ISP_PAD_SRC,
 				    &cap_yuv->video.vdev.entity, 0, 0);
 	if (ret)
@@ -162,6 +176,8 @@ static int stfcamss_register_devs(struct stfcamss *stfcamss)
 
 err_cap_unregister:
 	stf_capture_unregister(stfcamss);
+err_out_unregister:
+	stf_output_unregister(stfcamss);
 err_isp_unregister:
 	stf_isp_unregister(&stfcamss->isp_dev);
 
@@ -172,6 +188,7 @@ static void stfcamss_unregister_devs(struct stfcamss *stfcamss)
 {
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


