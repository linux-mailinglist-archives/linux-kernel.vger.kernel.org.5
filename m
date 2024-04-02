Return-Path: <linux-kernel+bounces-127704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA08D894FBA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC4E1F21F56
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00335B694;
	Tue,  2 Apr 2024 10:15:14 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2121.outbound.protection.partner.outlook.cn [139.219.17.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5675A0F8;
	Tue,  2 Apr 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052914; cv=fail; b=n4WRFeSWffRjuvq98Uq8l8CoNbV0UyeCtG8r192Y7VOK1+7+X0F/4RA6L5k+8nhbFpo5wnutRiIcLPuPAOcXJZiPKiKjvCRSrrjN8rDbgI0l0plpKNMn7NtJdGn5rcq1A2wp9T6+Q4muRXEMA4RAQj0op9cSpyTCQySrhNw2MLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052914; c=relaxed/simple;
	bh=TDXU8RUqlzGoA+hzvWweTNEW3CLTN2X9MzsUkwR4wqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jysqRBPstAOh+Wya5YDHo1O1x+C/4veLMIAbVn+l/gvd1XpfpyNMOp8HZkiO6yuWYPhqrPti38BPlJJvBL5szwfkL+Z7IpZcYL74EWNYyZmYXOWbvUmmRLCoCiPaZJv3FursRif19xFmO8HRw8s0fipq9wVr4AB6uBGUZEHJYLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaGZuRVDHin6auN6e6TDD9CAMqLtsL+LjFocalwSJnv91LinpRLKbYEmxh+sDeXhNrnJaPDaDqy80axQBB1Smlw9zK1YkuZQAfQ2QZ50d1dvEyzSCRoLB04ukygnItQJ8OJlKEp4SdDUZJvuwh9hWjA6Bi8L/s34rh5iil87e/iwBRFcHZeIcXxUqQW5eWD8pFf4wgb9CtOVxrzy0uwEHPuYtrEqBBKrkIoBCRKpGprqq2mf96T8t4xFc4EVJN7bv5bD4HoybyUdJYc2zM6ISNxWi5It2e82NE2SNR+agAWFAjKBj9B2/91OylFoXGsbM8nnEqb8ehMpQ/SZNjLvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nP0ImCN8olp+giiPSCpnkcLg6XZ7h9WXElBHd0WYGw=;
 b=JE/lflMwfxwAt324K7gZ3PerfASQ6NVC+Zr7lnlGPGBhavCXsDTTfsFOS4wXimXDWJHeLCYIUKwJ/B7IkVvDqp/SVCa91j+lWaWSSFxVad0+sGmUVc0o6trBKb2/SINIQT5LpvOJArjC7pbdzd3uA3ZKD1JF0PuHJcs6lLBkEyO6LFlnfQDolIVa7bHGg/bmnhas4ZpcI9g1tJ/0W4OwHObrNh1R/PocpIEVC07zR8ixoqMulh1EgH2T9hSFldPnWE1WurruSTZhu8PT7mYLp3XBUZLVse0seF4bOtniBJ1BY35B0S/N/wjm5c5hTioxiW56OePVRq7LiY6nCQEJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0669.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Tue, 2 Apr
 2024 10:00:23 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.038; Tue, 2 Apr 2024 10:00:23 +0000
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
	Mingjia Zhang <mingjia.zhang@mediatek.com>,
	Marvin Lin <milkfafa@gmail.com>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v4 02/13] media: Documentation: Add description for StarFive ISP metadata formats
Date: Tue,  2 Apr 2024 03:00:00 -0700
Message-Id: <20240402100011.13480-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240402100011.13480-1-changhuang.liang@starfivetech.com>
References: <20240402100011.13480-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::11) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0669:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a7474a-3e54-4000-ed8b-08dc52fbb6d7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	py2RntqVf118LZf6RWWVIgXeRSuqXEbX2pS8+dPpSpNYDJQxm+g8fciLz+k8ow+YmgunPmDbs2wq0YUxQI+tUJDgBFIenFEOvGRoiawvzEVbz/mLSHnWe2x3vUBJ2GetgMUVzWzc8tTe7SXcebC0820XT07JZHjw5YI+bGZqnIUvzvSmsTKLgrxChTSYZq/7XMbKCvk2XJ87Cqm/zpYOvPa3GCr9yz8+84ZD9c93FdsU3cxNar6Qs0IhRfXtn8Lp4jf1zULbnB3kWff8bBFdDInj2naP7SVh1+QWR7Lj2kECcesGs2vi7hA1OdJ/hihUaxe7AEyDXamtvRL1ue/BmnCjITLCMBMf7cYcBByVJ9WONsBQow70xuXvhMQdaBZro1iDvYEgPUNNYInaHeUEnPjIbAA9FV+9KNVE2AyMbmLbMNg1fevfIWgXtqaePvDInRLxRv/pD6bAyyA0Wr1AGWGNIjSwkH7j9hvnf6awP4Ne79hvC+NpnfRb1y4saIMFn/7vJyD+MkPVosav7Jj0KA7NrRWcPwUn/Bk8aBYl7sro6rEizoWqnyxg7JxfNZKxaHBkTIkm1vLb+UAyCiEj+cce9nFccz5gKa/qE8c6ZfSRaVoT/vbU7hZJhn2kpWx+TEErvhsyLyszyT3jcE18IQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(1800799015)(52116005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z79VuK5CgD5TiT22eA6L081JkQ3Q/945ZCAXzv0311oKx02rlgT4OCZZKrYP?=
 =?us-ascii?Q?z+17NCOwtmIzz0rgGHL56cAkXQl4VsN26U6J9ibtxACZ88uOn6AQdYG4GQb4?=
 =?us-ascii?Q?yF5oa3AWCan2gygTznokiPJ9jwkMoaHDAF4bHIpjYSNtQGrLPKvgfHe6UuUM?=
 =?us-ascii?Q?74c4PuKuluQSAv23TRMbhercOv8+KocYrY/tQ+bfrsL/BF0sjYj4wrPI+B4b?=
 =?us-ascii?Q?ipzrOVSwWcByp+Iai4oeor2TRFTiMDZbtxfVV7ZzPliyJhVNFqjd+ZjiXj4Q?=
 =?us-ascii?Q?OsyaiCSIw9+gom81wYwjLz7obKs6+x3jGZ5E497JTeTOn/+m3Q8t7Ioq52vi?=
 =?us-ascii?Q?Gjll3KNOyKkG2b2Xf80lidfIFNqqxZlRBNgTd2LadY9qrosnFYn0Okbqvp05?=
 =?us-ascii?Q?qcP3ujJ8YTS5uC5leUIzrMAtS+RuBdxbFaylv0DwjPS8OJbr/UvC+1rg+PsE?=
 =?us-ascii?Q?6xwVflBh/7gRdRpHzrYI1xQI7K+YBk1YPetOtHZbD1UQfWc/6IXAxI0UDMJ7?=
 =?us-ascii?Q?eoBxKBeBepHJjDnPqFgCmL5VNYw79q4CKF15iACV4Gofq8J8ScPi22kOMc2/?=
 =?us-ascii?Q?m3v3CyL0cneLvrL02uQzKmPnLswrJ0/QmxEWHS9o8EOhUqBdvmJUn7erm0e8?=
 =?us-ascii?Q?f+y1um3eaX7KBJUf72RUqKfRXVFupFRJK2jvBpU7NMmOqhndeZkrJoh39EZm?=
 =?us-ascii?Q?34cJNwp+JG0ywonpw9o8M9giVqcqivVatN5ZchSkgJiA+GtTlVaNs6nHT7hq?=
 =?us-ascii?Q?0+k+GOCA0g60gh2pRoOBnoQeGhOz7ci8rfRxkLEts4QcYecfvpICS3G/Ps18?=
 =?us-ascii?Q?NL0dotFTWaDFpZ83c4q+pWNQX9IFcfPqhZE7PtYuOQU66vDvC6WGY8Ho3OQI?=
 =?us-ascii?Q?FUOZ2x9XNSZQQGDXnEv0IVz5V0/SbB3cL1X+In4XSBmaL819N24eq3+vJPhw?=
 =?us-ascii?Q?Iwhu0fR9gk4DYHEKNoSHAt69XhGdNy+NyiIqr8GLcH4Ao7NxxqE1caGZhCCM?=
 =?us-ascii?Q?WbB7VxKD+ySw03Kmbdu+ZXPe5bjvf4wPi+ZUOoOM8rkXFx5Ybb7Os0wVIUtd?=
 =?us-ascii?Q?nC7UjBCjqn1RxfmOrkB1LNmaaOkhDewkBHyFwLLBCxjC7kpK6nrmuP9RD618?=
 =?us-ascii?Q?7ufZZlDaNqR8nB/JgrEK8NsCaflprnUIDNUc3dYeJE6gCVamiWDVjGAm1Hdd?=
 =?us-ascii?Q?Z99CMJcuS9MKuUxNEfyfa2UiTT0eoE5Qugr37PKm4F6fDH+aTdpwt6tB1DmY?=
 =?us-ascii?Q?aWz63TfbK8DFMdUxCWDjokzboJzEeVsj55qAjpOJYcVCf0YO1ZANQoF3UZqf?=
 =?us-ascii?Q?1TSPvfT+jBCg8HuASP2jsGedPqh1UFjIDFSeVmZpNpa2AckftWZ0xiSxNlCC?=
 =?us-ascii?Q?7oWM6hmbE3f+7+cNkF0F/ThENL2ZXSP8JkJ2bf9+B3NWMN0K0avHuMgSdzYF?=
 =?us-ascii?Q?sfGo+myyiVIEG4m/ksblawqtDu7tAwjNcVgHLvd5yCf+QlvzQ5sGGjUvKC7T?=
 =?us-ascii?Q?MpaBMXr3tMUODFFxMoKBxEMfoRpN3SHwLd4vMjEoRfqk8zxfEMUtJwUr1Xhw?=
 =?us-ascii?Q?BLz84L8b2Ux4A10rAwEIdBY4xBl7v0Hqx4kebA3zQl7JyTdaimA37oos5SlI?=
 =?us-ascii?Q?uDvAIGsaFgz76Tr0nLD7Ezw=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a7474a-3e54-4000-ed8b-08dc52fbb6d7
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:00:23.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/cMMO0ovOyfDe16Hm98Cr7adb/aiRmi3ZJOWnMHNbyJLLdTVsk9U5Te+blfNcX2LkNEa7Lhc3PZ+H4IHl1EjTtZaEElTYXLmrN+2lRhqQj4K/dGHP0B3+kB8II2FU2i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0669

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
index e5ed3c876a55..4ec5977a47f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20954,6 +20954,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/media/starfive_camss.rst
 F:	Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
+F:	Documentation/userspace-api/media/v4l/metafmt-starfive-isp.rst
 F:	drivers/staging/media/starfive/camss
 F:	include/uapi/linux/jh7110-isp.h
 
-- 
2.25.1


