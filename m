Return-Path: <linux-kernel+bounces-118381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99B888B9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56CAA1F3B53D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EE612AACF;
	Tue, 26 Mar 2024 05:48:27 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2100.outbound.protection.partner.outlook.cn [139.219.146.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01707446BA;
	Tue, 26 Mar 2024 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711432107; cv=fail; b=AADCef7Kfgftk0JLqhjA2e/cYm3OHmVMw3gD8RFhV5ndKBykz4+R9X1b1uM8N/G+R6f6i32TaChHppZMvzsPpDPTV/GD7RGs/76zgrlRT+rQO8ShN0mFX9bkBSga8Ck/xaQPEI5kfkYnGiNw5RhxqgL9/8cX171X++nCMCFW1MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711432107; c=relaxed/simple;
	bh=QGRjzjjGTYBKckhCEqrNImTO8Jpp+RmJTSfXNR5n9us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mTV+RTVKnFCafLibxzWIGUotL3SOpKy8OBv4z7aYnHNEU9WYI9oqu3n2JDtFgJFu1bkZamvkPgOTDe3lMLyt0eFPdRWx66Zwa9gs/nSl2N7kLa77f4vr918ytWRPbhC+JpHmQmECtH5bvEnV/JQL4zzkWe6oFzHnxsk8J1n/qBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnQvr/slHOx+59KODpxAiaR0VDWbsBEj3rwvAAYa7Fz/lIxvtQ5eT7DTzafkFgyv/ubgkTy/ISWBd30oKvDHG8CwUi4lnycZePdlCZ2/r5Yi+CpuAvLr8sG9fHiuGJsGzLyFQmjeeZvMYT6EuG8sDaGxSIe8VyyfougRPeFUdhvgQEzWi2A+SuXd+VU7i+YDXcMPHJiyw0AJx6NqiDRpD4QhROZLv++Wc7BCB0XCksMJNSnXGgz0KxerebH027mQzQXEtWQaYcOi9AvnMWZaxNXPmX2EOgR2SD/k2URgIUfB/j6HaRUo544TJLXVAL6KKhgedFhszAzN0GSwAi/21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWrr15+a/R++OP67DBJn3f/Wax9UB7Rprnm4RAROmdM=;
 b=LFnpyRajK73UIFBSyHR1h+rwGptIQT1HMNYGUtegfKTK/wL0lE/WrwmQcsivST6xIio5Yn0feEMVBcw7SQi4Migw5nA68sey1jQosIrky0nmUaEbGPz9Av4bbH7pQ3arU/o3tqoKvn6dTve0LWw+tv4EVYkv8me36GmIixeC4nkfYV9yjU41fdLrs2Q5R4N3P6eOkiHWFM6AAtujmBfAkOkJTp265ok4fxotxpaGPthYXYYw/3nfNQAN38iAqnLZXgrUkHDf0eEEYcsWZIfXRtnuzuHGu0HFNQGsi5xBYw11upxFBgrkkfU7n2ds6QdmM5hKwJHf3CmBe9kz5UWWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0622.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Tue, 26 Mar
 2024 03:12:49 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Tue, 26 Mar 2024 03:12:49 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jayshri Pawar <jpawar@cadence.com>,
	Jai Luthra <j-luthra@ti.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v1 3/4] staging: media: starfive: Extract the ISP stream on as a helper function
Date: Mon, 25 Mar 2024 20:12:36 -0700
Message-Id: <20240326031237.25331-4-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326031237.25331-1-changhuang.liang@starfivetech.com>
References: <20240326031237.25331-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::15) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0622:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d41e54-b6c4-494a-487a-08dc4d429e2a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wnlNuriiQ52wA0qwL8HVFWztHb1RTMXq5M5O0R7Yb8XB6p0Ekzn17qOKIJhxSr9fH/9DRm1fkM0yeFyQ2lUM3lCromfa3qx3/BXRR2HTfJR2LiLYb7Ii0Q4Q7wdvcWI5IDtd4Op/g7m/cYo54+7iJJQRWl3LjmAcLWX5b7ntJZKWskyvf8UxR09CtxL8Hl5Htol7zanztkhXPuiH8NUrf90ZWiO45kM0ru3BNEaoqhag13eFIkf/zm3uf8g5OgJFzXFPr/wuRPnU97Pg2mDD4NIXkAqdHuNpRM5gbyDzG3bYBv56ERtlqo81k8EyUtG//Bka8RkYpRDlER3ptXPENRTgjZzllSCWmrBHgZ5umEH6EzT4mlq+nEZ+fKbx057+ETKOA7l6f0WGFykapKllYbHsJkalPPkBt4X6jgNFowstqt17JkgvoPN4AAvzbq7dGNTqyaFBjZOfe7PYFPHC6BJo9wkb/gqHtKvGnSR4WdInbWi/pmqV2oxVeSxfuzfH6qQE8OUPBiLXPWzYkhYzXTIt+Ko3BVyxwgeInvzPqr/vp3Eq0NzSG41Yyqv5iuYKsK/x7d6cvxO+Q/2R4mmcGPBLmcSVccf/SZEp+hHpO3ZkXEsGSu7ka/Lb/1kwTSW5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(41320700004)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Du0TNGZycnJwf/3flUeZTL7JNL3gS119i6Di859quh9LWWO/PEpk9yVWfUsV?=
 =?us-ascii?Q?IckYDr1jhRTuLyy2ccIekCOLqKz0bbZI7JsBIapA4an6l8m2UYTIa0iEvMsE?=
 =?us-ascii?Q?zLwPj0Ro6FNNnmPsCR6LEIc2qQ+ppBamAAKEbtsCzDP1wi4DAkV5DZ8Ru7ex?=
 =?us-ascii?Q?LpBJIgn2VfkHLy7Q7BJ7MyZSLdkJHmunbcVIIgWk+xMfR5iBnvxWK5bazOSE?=
 =?us-ascii?Q?6gCLEDiVDZx8TduLSTGTcTlNFLZw0jw5zGvOS3EigdNathB7JA698qQxUfGo?=
 =?us-ascii?Q?tJQHfDCfvM5WARaQ0A2HQ/vTDRg6xM/r3t1Qr3GgmtS9GBf8E2Isx6yLWHoE?=
 =?us-ascii?Q?eYnayNKXNfY2db3h3z18IVTPPA1Efu8TifkMWycXtfx//Yln9pOvpaDnv6Dm?=
 =?us-ascii?Q?zPU0J1rZrGfwJyqwq619lZn/dLKOsLVhMnwDuVKXqKjAVp+qZGwy1a2+ywdS?=
 =?us-ascii?Q?wJ+Dp8j2GMli27v8hNiTi05csQ74itbLwP+L2EHwffE1/bOcXq4vhZ012V/e?=
 =?us-ascii?Q?LIqIBcIzJKmjiMklCpWS6XV2OW9n9ZtYDWYbIipQRjVuHZizwh3NeTOXFK5G?=
 =?us-ascii?Q?y5ljrA0//jKHfcMAyU2m4gvI/q4rFyDE80F0Xdov535d4GSbcxSjocnkf6fz?=
 =?us-ascii?Q?XgVrNx/jtbjbx8Qw5tOdT/6PTSxbhbfct4Ze7DpDjqEk+/fgH/O2QSTqN+dM?=
 =?us-ascii?Q?LdBNBP+TPVZ6P8hr/K6TtxaIoAUZaqnPxxnsyg6JvFxI8QS0a+9Mafj3dZV5?=
 =?us-ascii?Q?cr+7JE1G0bYx6/gOBAy17tOgYkFVFDMG7bKxI/vwMJbQt4mnoXMhA95ljwPt?=
 =?us-ascii?Q?hyWoMhsP/BnyQmzhmyL2eizoqhdQVXUZGwgBrprX5Jtb8E42MvnQBfuYG1Jt?=
 =?us-ascii?Q?JCJl6ERnkI+fI4YrqrwebMZUBJW4XjOO7TUSZQGSoXfEwuTES24SNtQLq7SD?=
 =?us-ascii?Q?EiubCn61vMAXjkFNEx6LaPdlKLuaeHMHseWEAn5O/uuyL1k7pOAvqDorKTMd?=
 =?us-ascii?Q?qx3GufTj+uHgUMo3dLGvvrHo8+2BQB+V8NVEGwaVhox83Fc2LH2auVMaUAie?=
 =?us-ascii?Q?fJBdpz0EFZWFdMYAhJNLBoTKLtxx6jDdmUFHpEA0POm1HlQmnRL2yQcCRias?=
 =?us-ascii?Q?xtXi6Wc/FldNClXDcIXpUh7CqWurQq6O3QGEg4cole6Jj9bj3wd2nZHVgVqo?=
 =?us-ascii?Q?FHs75PXRijhBrgtvfKde6KcuaqwHO6s1egreC6GgwH6vecHVTidzUyWJcPSb?=
 =?us-ascii?Q?4dAfS6VH5enwz0LHFAgWdlSJxe+csPo1Rf/cWyuhX+CC0aNFLSrmfhvtj+IO?=
 =?us-ascii?Q?ek2Da2EXALDo2+hysgTnsffSlM7MZ4n/iLMvWEanvPOVU3YXPjH6veH6usAK?=
 =?us-ascii?Q?S8kIn3dtKZDEKfmQSOHxFCjLT7g1u70L+pIaZDNdDIGgxcenklMpqHfkg8k6?=
 =?us-ascii?Q?/DVTVxDi68pX/8PHhOLys4Nf7BpgNnjDFFxv4mD3dgCb643oFwI4Ty8E+KJ2?=
 =?us-ascii?Q?IjtkXFPbo3RDRJ5mbrhi+4/trXzsLMbjOlnhwTzLPkkPkNhFM4478DbrKMjR?=
 =?us-ascii?Q?VJECAY6kKYNAw5AKfPllFU6S3KjPgmbYONDHdMMT3Ki6Du11rMItk6eow66c?=
 =?us-ascii?Q?efv7MUdESmdLk10olQSL75I=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d41e54-b6c4-494a-487a-08dc4d429e2a
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 03:12:49.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNIGL0i6gjjxT6XAIhGR7YdJ/rUHlqMWs/j+jUoqHqUquHx/pCer9p/l2F8kNf1CrnMZVFzZQxqaw5dx2yZ66C+OYfnUGbO2gUqonn4UXo7CBYok7EgZw2CHmzQVEyeC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0622

Extract the ISP stream on as a helper function and open it, Let the
other files can use it.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-isp.c    | 27 ++++++++++++-------
 .../staging/media/starfive/camss/stf-isp.h    |  2 ++
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
index d50616ef351e..16694b502e56 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.c
+++ b/drivers/staging/media/starfive/camss/stf-isp.c
@@ -58,23 +58,30 @@ int stf_isp_init(struct stfcamss *stfcamss)
 	return 0;
 }
 
-static int isp_set_stream(struct v4l2_subdev *sd, int enable)
+void stf_isp_stream_on(struct stf_isp_dev *isp_dev,
+		       struct v4l2_subdev_state *sd_state)
 {
-	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
-	struct v4l2_subdev_state *sd_state;
 	struct v4l2_mbus_framefmt *fmt;
 	struct v4l2_rect *crop;
 
-	sd_state = v4l2_subdev_lock_and_get_active_state(sd);
 	fmt = v4l2_subdev_state_get_format(sd_state, STF_ISP_PAD_SINK);
 	crop = v4l2_subdev_state_get_crop(sd_state, STF_ISP_PAD_SRC);
 
-	if (enable) {
-		stf_isp_reset(isp_dev);
-		stf_isp_init_cfg(isp_dev);
-		stf_isp_settings(isp_dev, crop, fmt->code);
-		stf_isp_stream_set(isp_dev);
-	}
+	stf_isp_reset(isp_dev);
+	stf_isp_init_cfg(isp_dev);
+	stf_isp_settings(isp_dev, crop, fmt->code);
+	stf_isp_stream_set(isp_dev);
+}
+
+static int isp_set_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct stf_isp_dev *isp_dev = v4l2_get_subdevdata(sd);
+	struct v4l2_subdev_state *sd_state;
+
+	sd_state = v4l2_subdev_lock_and_get_active_state(sd);
+
+	if (enable)
+		stf_isp_stream_on(isp_dev, sd_state);
 
 	v4l2_subdev_call(isp_dev->source_subdev, video, s_stream, enable);
 
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index 955cbb048363..1a3e8cf7859c 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -421,6 +421,8 @@ void stf_isp_init_cfg(struct stf_isp_dev *isp_dev);
 void stf_isp_settings(struct stf_isp_dev *isp_dev,
 		      struct v4l2_rect *crop, u32 mcode);
 void stf_isp_stream_set(struct stf_isp_dev *isp_dev);
+void stf_isp_stream_on(struct stf_isp_dev *isp_dev,
+		       struct v4l2_subdev_state *sd_state);
 int stf_isp_init(struct stfcamss *stfcamss);
 int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev);
 int stf_isp_unregister(struct stf_isp_dev *isp_dev);
-- 
2.25.1


