Return-Path: <linux-kernel+bounces-23268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD0D82AA02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3E4285569
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E844812E52;
	Thu, 11 Jan 2024 08:57:04 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2053.outbound.protection.partner.outlook.cn [139.219.17.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDF711CAB;
	Thu, 11 Jan 2024 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh4q8V2nlkwzpbOHB4j4PXedlu0XuaK7aEymfVJJe52r6Zyw7bcfmba3Aq5NTUbSBVfGffQxEQENLEmb4CuAxsdKChTmaReiwZ8jdcOCf/oOtPUhZhmI4sr0sih4v6jvsq/RhBoeHc04Vg3IVhnlY8Uf3cATWnpGSQNuYyuKr/iu3H3y1gKfktku93pRn4kAKr5Zkcj7HHZu0x3Pf7W5GWD0BZmUrDA+A0s4ptTje3bGrGiOor3zTTPTXCqm6zoVaQ+PO/qkFTTGZg5gVlW+ezfw9pCZKr3u/gdTPBjFwf//xPveUySgKjf1voQCgGQs7YQSIfYR1qUci9NU0r4w9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMzsKjsZw2SixbzRykWPerHVvDK3lk5KvnsyKCCkru8=;
 b=YYo+i4gCH5lPQEwpajAn9t5MTNVb2ltl/rLw+Otjn5VLD22s6thhBP/nfAUowcInch9QySJWYsMKE68eVWJqozj16SJqbhhTNcYo4SBvCE45VT+66FkDA0vW7YNflEzwLfNcLw45un5hwI0r9xs1Qb8cUNPlZ57l++4mQR6P2E0QCiXacyRnEy6Jn0vfsmPn7W3Po1G1Xf2cSZJEaXKpLV1T1iriBLeVNm6tvmTNN18vgipY3AxADQzjlFfCI+3qVeDsnj327V9bMovpAyWtCPOM1TN9GQVjKYOZ4tgSofC3VCW+DTESJjBYMyBA+Qmbn6jCD8d1FgZML6KSPrcxQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21) by SH0PR01MB0747.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Thu, 11 Jan
 2024 08:41:29 +0000
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 ([fe80::e255:98f3:ba27:8c7d]) by
 SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn ([fe80::e255:98f3:ba27:8c7d%3])
 with mapi id 15.20.7135.033; Thu, 11 Jan 2024 08:41:29 +0000
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
Subject: [PATCH v2 02/13] media: Documentation: Add description for StarFive ISP metadata formats
Date: Thu, 11 Jan 2024 00:41:09 -0800
Message-Id: <20240111084120.16685-3-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 759e6b94-8a80-40df-e313-08dc12811b07
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W47M8Qv860NSnpQQFDhx5P3MgumNBeKcMWwh3dscxsSmXU7ToRIey8SjwqrNOVU7cdfbv4Bx7zpOZ/rhyKJdReaKc6aXh/KWo10mz24wrEkWi0f4mtk0HLau52blz7A5byvW8ap2yB+S5egMj3R5Abb5EYl91kzXIzu3nb3/w1Z4oFkweRwx7lbcxzpW4JP5PwWTn6dw04wqQALzrMxGkfCWCxYlAs6M33PdVmnKmX61UYA5cpZ2o+hh5GNZjFEf922JjG8Zy8Le98cLe9ESN1/curoO/Yt7Q6gJD+jeJl8YzNt22KNpX4pF4mwTxTAEAY1n75OHaW/wELvml9tkobARRglKpIvT0O+SvwSIqqENgQdNJhwp7mLQ/LRynvGZ+1ua4/oW9g95U/ivUs1C3vYxepT0C8s62bk0AXxJsddAkleIBTi6FzTcGxymjADu5X2OW0wB79ufAl/gbMqgDLWm1rkcIe/GXa6cMwhuOqMx5dMnMiaEuexw1aeRzGNEpFKMZK6J0qLCx+X0KUlLCMZRRVugthNF8RgQxEpMGkl/6foX+Fteiu3sFrVRJpxSWm15dS2z+sM44ssesWUQPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39830400003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(52116002)(41300700001)(2616005)(508600001)(38100700002)(40160700002)(1076003)(26005)(86362001)(36756003)(921011)(38350700005)(83380400001)(110136005)(54906003)(66556008)(66946007)(66476007)(8676002)(8936002)(41320700001)(4326008)(44832011)(2906002)(40180700001)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jr2uEuAQ0AsGyP78SwtBqf+lmykfgNZ/+uiYltDp0xvU/3pbCD+w+iDownbe?=
 =?us-ascii?Q?MVSpLyd04qXrBa6zsELHq1pB3/kMGLEM+W/zlSM/k1ETb4xXtP6WqN3k8i5C?=
 =?us-ascii?Q?eMWblTrUOIau37gNyxDSOnIEWjKneA6RzTmZCJL044b24Fq+QGvWoa/FJTq9?=
 =?us-ascii?Q?KPXKANiFRGsQEcWYbJgJ/EsW5KeawHvEpL9CAof7TCKhCkbhpJNHkssywNf7?=
 =?us-ascii?Q?cv31zrmoSg8vk53p4JnrxpdrZS6rsNehRch9QzxuJwLhPvaaspASNPc0rpcl?=
 =?us-ascii?Q?rxtmuTR7dOHvZXBN4LnSaQrzPw9ZJx63YVYc4/FfUKRYo3DlhMN97e8cQf21?=
 =?us-ascii?Q?NjTHFcl+YbIgoneUv8BCipbvKki8toMT9DqI9kMsxmvq5sxWbUjzjNm5dNsH?=
 =?us-ascii?Q?MgUIeI1TSIxZWt7te/1E29uhZxvqSE8owWdIOnDYvyy4rA1CIhEx30RgqnDH?=
 =?us-ascii?Q?0IfXEIoDsLG1g9O9fguLkGYQ7tok30SXVS1Vjrg0iQ5D/N8bYtfdFDbbpGyb?=
 =?us-ascii?Q?4PMJmP0DbAaWb+AUZ+2onigL1RpJzeYH6mf9HgAF8oJAqfpEiUnX5xyoKBPn?=
 =?us-ascii?Q?b3vaW5o/qhqIinIHLC5TJgGW+hVlqP+lRfpJ3fDbLKk0bbn+aWJQKwPasFd3?=
 =?us-ascii?Q?PJX8VVvCjXOyvTwpRn4TOoIAfcN3V7tpnFGLcIERpuMdhUw54K2SUJ55WWc8?=
 =?us-ascii?Q?lACthN2AW0RqNNBPkO8oAinMLxhnoP+2TGs5HVPpmYmq2PfCXAcQSqXA9Voo?=
 =?us-ascii?Q?ZsnpIzdUT4HWnDk2pmYtayvA6TTGwqW6VoVlsZqlaLNFUsRpAKlaMR5Aa9MB?=
 =?us-ascii?Q?HINQvYBJaSzTJa0Hg438W3zgYhNfvXIUiehMROY21bkBq4KdXeYopJg7FoDM?=
 =?us-ascii?Q?OTsSZj39KO8qOeTNQLNUhZ8OVtt6RQWzmSXCcy/jDd625+GpclPrvLC+k3AJ?=
 =?us-ascii?Q?fSlZ9o6mUDjkdPoXvsQf6j+jjr5sLgt1dYFpamBWp1h5B3g8stbSPHopgNb2?=
 =?us-ascii?Q?ZIu0KrmlcIdu2mRI6b3euWxrZ7Y8UTNx4XoUkQZ19fCXq/zXBBXN10HHoAPU?=
 =?us-ascii?Q?qTJG2VM+JLflfsHxt6R/DKqNnHr2qOZSgzyzmOt6e71wIl4JeiiC9tvAqatL?=
 =?us-ascii?Q?IBSrTiDeStKn/GeJ/dvUwQilS53nOJ5m22vrM1gCABQsvxAwJ2kCn93DBfm7?=
 =?us-ascii?Q?0mBoLl/9LuQkts0Z943elT0cd6r1XmPNTd+OOeiy+Xt6epxVVJrYEHt+tPyK?=
 =?us-ascii?Q?H4kYJ3u1LEEO0oW3EYmLuWtqmlodOekU1dePAFg9xvM3wMOgY4FbH9puGxTZ?=
 =?us-ascii?Q?FYMKAHz0HpOYunVMqmSmRB63wieDDY2vLZVadHtidmjCcKm/7cstgnm1qFSL?=
 =?us-ascii?Q?3Wcm3EH2Zni5n3hymmHcvAicpLip/VOFoRBIZRTmAsMSkA/fbxIXZfaAs465?=
 =?us-ascii?Q?r62gScBDQKzS9z0Sdo65AC0ws6X8BdTyj1gBcJU3Dgx8pq8SQy+kWAHWkPyK?=
 =?us-ascii?Q?yeiNZjFr6388oLLLkJFuRUh83TBAhNRhPzI/N6tlvtkYAmkZGf/8xW8WAgrU?=
 =?us-ascii?Q?YXdlMalrbWl6mGdKl54aUykB85n8EDBDk275QRJyWZ0tqdUmR4EEZBmXgfJy?=
 =?us-ascii?Q?yVVpihBz+y2gBiMTkxTekkA=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759e6b94-8a80-40df-e313-08dc12811b07
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 08:41:29.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gju2jPok65FiFZm6lOZgigYrAOFzKAF0RyUFLhRFcb3+SXVtjFNvRPfC72TcOBwRtStPJGQwu0mhmWcLjcBlF35IX0FOBA2NnjMfX+NftqJWR0U/dd0rus4LoRUe+ith
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0747

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
index 000000000000..46c5193f5722
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
+The ISP1 device collects different statistics over an input Bayer frame.
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
index 0b47e88a51dd..3b8565b69ac2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20688,6 +20688,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/media/starfive_camss.rst
 F:	Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
+F:	Documentation/userspace-api/media/v4l/metafmt-starfive-isp.rst
 F:	drivers/staging/media/starfive/camss
 F:	include/uapi/linux/jh7110-isp.h
 
-- 
2.25.1


