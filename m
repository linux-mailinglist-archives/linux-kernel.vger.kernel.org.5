Return-Path: <linux-kernel+bounces-49344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E48468F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C86A294E69
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649B6182C5;
	Fri,  2 Feb 2024 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b="Gkq+kGR9"
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2095.outbound.protection.outlook.com [40.107.128.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0AB17BB5;
	Fri,  2 Feb 2024 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.128.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857466; cv=fail; b=etjcieIEur6JvDFJrh6jC7QWM2Y4oVhY4cjVCM2+vfdP++HWCS5sfWWpO9UFJDVRHwU2lb7oNJglsB5lNoMy8PAykno9Z2OPD/lTbmikOvnQjCC4zlyphwmn31FoEgwKu9aJCS/YiyYoAPf7x0Z2iFV2+f+6jXOWktdWui4G1ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857466; c=relaxed/simple;
	bh=It89T/OCK0c4YrWvhqTPEL1//rjjpfiigp/1WxciMrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DJidJ5GzDPXa0EurDyu+XWvWTj0eyZ/Mqtu5GsN05LrxrGfGc+ARVkBf6uob3l7bMY5qhpKM+IG3sIxNUjHUN7T6ez/7mWyBpP3KnnEY/pjErqK1NWqsucJW2hkaLwWAQ8/fyy0aJEuxpaKhO1EDCBnXIhReoz6bVtgIv51fedg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.onmicrosoft.com header.i=@chipsnmedia.onmicrosoft.com header.b=Gkq+kGR9; arc=fail smtp.client-ip=40.107.128.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZ+yjYBzLno266sRDOMLvLhkpIkTf/owlmgvyahJGaAmi1Rg2nwrlkTJS2B1ZLFQ8yUGxkzPcSwVh4wsl7E2izYGIT4pvLDJwAx9FQIkaroofucq3wuWUWwV6egQT2hTb5Qainz06rGsDLANcqr2aI6NciplgwcURVxqAq8orQUsTD6i1DA+Wh/eSuXZ8ELHhnhfavlDEHXzCSI+fBXtsXUEWUGzU8kAv0jBs4i2+tWefOrl6FEhYSYFyph5iMrBH1Rc+UMBVWWFMkQQ+fWmTgC2BlEfKxDh6vpEW79f36L69fpLVNx+8wnqOQk9q0P7FG4UY2/B7VnP5Lm6zliWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1FYjVEimazUD4M4Ka9FO0ZhPmGOo7/M1aUDfxKQQGY=;
 b=mV6Y5i+QaOew/dGwLutdo7cxBIiBh5H/R0r4jTwZ9FZYEjcI5e+3hCz9x3eGOIcODxODKAhQi/dPieeu9eKWbVbdvUofCvMOmYzVMo5K7Y6/SIZw0LgqSL97adghaipSvnXB5tedxe7vZmBg7nGkhWZ4uqvWW1SsNJWJ0Bz1RmasmphJ0LGNZ5naYyeY1m9aiPc7NWIyv18n40y4sMxPHJfYArXGQq/V+iseVDGmaJpKy3IqrkU+XSxO4Jmq2M8VFzJzu4WvACs19eBLmh2OiJf+rtAI8u/yCfHOqowvDx5pm1YmdlWZX4ouoVtxXpEJhDwwpNm9MefgN3KNhKnPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chipsnmedia.onmicrosoft.com; s=selector2-chipsnmedia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1FYjVEimazUD4M4Ka9FO0ZhPmGOo7/M1aUDfxKQQGY=;
 b=Gkq+kGR9Zki6gZOinScijHh73+uuxvQyy/LqMEhQeLg/xXpZtPmfXEY730vwAFzcLGIBMYSl5+1hG/7JJmyA+obbk0xuKOGmSYShtGaFv5cgFFnko5V1ESdcSZiJQ0hE9EYlRoOTPxeQxEiOJzr3outj/8VysGERV/zWpHHW3zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 SE2P216MB1425.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.26; Fri, 2 Feb 2024 07:04:15 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::de27:9f30:e1f9:1b5c%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 07:04:15 +0000
From: "jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jackson.lee@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com
Subject: [PATCH v1 3/5] wave5 : Support runtime suspend/resume.
Date: Fri,  2 Feb 2024 16:03:50 +0900
Message-Id: <20240202070352.14307-4-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240202070352.14307-1-jackson.lee@chipsnmedia.com>
References: <20240202070352.14307-1-jackson.lee@chipsnmedia.com>
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0112.KORP216.PROD.OUTLOOK.COM (2603:1096:101::9)
 To SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1P216MB1303:EE_|SE2P216MB1425:EE_
X-MS-Office365-Filtering-Correlation-Id: 28235bb9-bf84-4473-3c4d-08dc23bd2ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vWQkwrxt+5S4sMIILK8nGb0+JOUrVoSj5uQMjL0Nk/MdkMI0fsaZolmT4lH951zZ/eYOfNOSq3RnHQs1TPF4KXM+hE1sc5hAWkgkVKRCQ+phNeCMPlROd8kpG3XfYtQNztrCljxFEbT97gpbGBvs1aq2534aXJ8hOjczMRlArTRRI24Vb5xYlrOidlS84cRpdLJcw9wp0tsQIxOXpLy7G8zYCkVlI433RWrlG5c+WY78QGWBpY6aTYQm6T6GVlzYTvVWpq3pGFffJoLyYH91U+lUHAIFPmrfsBDe7vcZ075VxyEGIktrC02b1pgUpA/T1Ww8EvJF1FXbTQFGEs3qahrD0d1WMZC7+26WMeS3XYTJIic5vT/VA4JfGq+2tqKulE5E1DaZNbis6xISSh1DeGmDRXoCz/UP4PeYXx+aoAsxAiTJ4xSegoUE+cgnA1DZtqa0Dsem278HLmE8KEOtQspz0p6gb+tVjCBSxK5Qh2OjKf2heeCMK2nhc1pSHSJeIfpOiNoEpec/O98Hgt/Orc9DSRPxkpahsdAr34ebaoX9gN7mDIE3mYaK8obb49yieUXLZ3R3NSc0UGFuw2mRDqBl3lmWY6hk1I2izQmbBsbAnifMVXM7Qcz30GpaQbkH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39850400004)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66476007)(41300700001)(66946007)(8936002)(8676002)(4326008)(5660300002)(2906002)(86362001)(6916009)(478600001)(38350700005)(36756003)(316002)(66556008)(6512007)(6506007)(52116002)(38100700002)(83380400001)(6486002)(6666004)(2616005)(107886003)(26005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u1hjulIpDpw4NIRl8i8KGQCVwwaNNQ73l09bmYqBKgCOMLpF8qYp2wzR/rVs?=
 =?us-ascii?Q?UDg0PmegQuTQm9jhdR5MrxXXxjw0KJiDkRlk43vkN0yQxOMP8B+JbORlmbSr?=
 =?us-ascii?Q?x8aPsjua+mYMZDU/RjdNRhHjaPGEYHpTHUzc9E5/bZ4s6JU9B0E3NUcBv2Fn?=
 =?us-ascii?Q?BTMFIPZJEdcxGRj7w+c5HhcTJKGOcxYOsSAEBESwxjdfhVWKpr5OO8frPNxT?=
 =?us-ascii?Q?ilrP2lSPF+JY9xOdVMIAhJK//rmyRXYy0XMVGTEUwhWpH3we840Hu8rVMl//?=
 =?us-ascii?Q?6bsgVksgL7K0VZZmr4OjK0SqvSXj5zFNrjneKwMqqXwN8hOtmN6G+TQM1Kx3?=
 =?us-ascii?Q?54Mn2bbkuydHE6APsKoeJ0mu7qLMic2K8T1fQm/XGIqxKYEXI1M7MICUz5K6?=
 =?us-ascii?Q?Ezy70LIMmPXPFzj5AVPxWSYjm3VN5DLiJ7hH8FoSBalIGoXfKVvVNiUjTmOz?=
 =?us-ascii?Q?30zwoj/XAWKz8zvOWgElngZH1C7KnmRncwxK7ONWc4Iy81K/AYLSStZ466+D?=
 =?us-ascii?Q?ocNEw01J2q4sTynEdq0kGJsaxJD/cMwGp6V/l8roqwtkbtysO8As2cWbl3qy?=
 =?us-ascii?Q?mPVk642Wes3iyfF67JVBoHYdDkgLb3nDXmFRuct1kcuVlq8aTJxYRTjm8sRX?=
 =?us-ascii?Q?d+u8NJssjc8v0k5FlqubEJACUjBbhdNoRUB08HN73O7NxlP7AMZuDGM24u2v?=
 =?us-ascii?Q?Epv6eUEu95mTyeDqJ5tcclwqepqVmqTxdyFWVDyABmzt3CiZzkXXZqkm1Qd0?=
 =?us-ascii?Q?cTwPVMzdEfI83didDSLZjyoURrQT4A/MuA5pMcaXIKjciJfhj86MuKQq552B?=
 =?us-ascii?Q?iiAW1Kof3Wp2JWH2AE5lnxgtQOzmBQpkuGYOIszYvS3kfAwsYZwjPklbvqN5?=
 =?us-ascii?Q?P3hqa0NP4+Vv6Df8uY9tcEGgBBLUo4u9MFHBySmQ0Dm0KoLdBFbhKs6UPfT7?=
 =?us-ascii?Q?bvi2K/I6skLaNB8pTqoTVtp6AYuVgD1W65vxwZNQhWJBSJiv2pbQrm5Ed9Bi?=
 =?us-ascii?Q?mbcgha6nAJDKuHSrmYTQBkMcx8p8+7JLfQJUZFfni1b4npAZ/xGDBxQF9dHL?=
 =?us-ascii?Q?cryDLD1WCe41mLI6Wzk0uKPE3pZOKD3tMjwSzXMywFYSEqTcatVS0txjgHue?=
 =?us-ascii?Q?Z3eb8/axNs8GA0sKb8ky2mPiBslqKYoITmMLb3hYQlGsyKtmmtEWeVp/GCOe?=
 =?us-ascii?Q?h6ZRjCcbrUgcT7QXhcZpkBBJNcmHS9y4BY+PuJXshi6b2EPslwceKg13fmcj?=
 =?us-ascii?Q?pHVmIST+3AkCKGvRN5p4arvuldtuHPaCyG81kbbSSdXVZ3jGkFKfhlZ3ldxZ?=
 =?us-ascii?Q?kMWYnQZmAtyHkb/gort8WUEEioEP5L736yaolTvuOsWh8dPojvrddL/+6mkq?=
 =?us-ascii?Q?O/RSiYPxeh0I+ObcpdkidosFCAYQJCBu2I/F2+mnitk212Ear5M/KLi6jHcN?=
 =?us-ascii?Q?LZwSl4NF+eWeHxb2dESSD5m2r3JVwF4EiPyo28h90PFchR7hgDbJbWp82DaY?=
 =?us-ascii?Q?rel1v79y+Q57qwEU7RO7IMiTV7S0iIl+NWwNJZ7dSt7Yb6gnIuzfusgdOxpi?=
 =?us-ascii?Q?Q/AFA2DNGAx0KF2D62fsDjXiyC0aDwoWCqXjOSr27Oow3hZyw2iikmYODFhF?=
 =?us-ascii?Q?e5Fliqx7p8UdfqCTDd8dSrc=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28235bb9-bf84-4473-3c4d-08dc23bd2ab5
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 07:04:15.3239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUEVIgr6VTySA7ihW7M0UGIYb5dBCHllGRW7VlRjTGi+p9SzWrt/CwMIzJucJy1G7tDDYB2T4QICgqi5IAkI+c4R/nLV1CSquPJAF/UhIcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1425

There are two device run-time PM callbacks defined in 'struct dev_pm_ops'
int (*runtime_suspend)(struct device *dev);
int (*runtime_resume)(struct device *dev);

Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../platform/chips-media/wave5/wave5-hw.c     |  5 +-
 .../chips-media/wave5/wave5-vpu-dec.c         |  9 +++
 .../chips-media/wave5/wave5-vpu-enc.c         |  9 +++
 .../platform/chips-media/wave5/wave5-vpu.c    | 68 +++++++++++++++++++
 .../platform/chips-media/wave5/wave5-vpuapi.c |  7 ++
 .../media/platform/chips-media/wave5/wave5.h  |  3 +
 6 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index 8ad7f3a28ae1..8aade5a38439 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -503,6 +503,7 @@ int wave5_vpu_build_up_dec_param(struct vpu_instance *inst,
 	/* This register must be reset explicitly */
 	vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, 0);
 	vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1, (COMMAND_QUEUE_DEPTH - 1));
+	vpu_write_reg(inst->dev, W5_CMD_ERR_CONCEAL, 0);
 
 	ret = send_firmware_command(inst, W5_CREATE_INSTANCE, true, NULL, NULL);
 	if (ret) {
@@ -1075,8 +1076,8 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
 	return setup_wave5_properties(dev);
 }
 
-static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uint16_t *code,
-				size_t size)
+int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uint16_t *code,
+			 size_t size)
 {
 	u32 reg_val;
 	struct vpu_buf *common_vb;
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index ef227af72348..328a7a8f26c5 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021-2023 CHIPS&MEDIA INC
  */
 
+#include <linux/pm_runtime.h>
 #include "wave5-helper.h"
 
 #define VPU_DEC_DEV_NAME "C&M Wave5 VPU decoder"
@@ -1387,9 +1388,17 @@ static int wave5_vpu_dec_start_streaming(struct vb2_queue *q, unsigned int count
 
 	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE && inst->state == VPU_INST_STATE_NONE) {
 		struct dec_open_param open_param;
+		int err = 0;
 
 		memset(&open_param, 0, sizeof(struct dec_open_param));
 
+		err = pm_runtime_resume_and_get(inst->dev->dev);
+		if (err) {
+			dev_err(inst->dev->dev, "decoder runtime resume failed %d\n", err);
+			ret = -EINVAL;
+			goto return_buffers;
+		}
+
 		ret = wave5_vpu_dec_allocate_ring_buffer(inst);
 		if (ret)
 			goto return_buffers;
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index 761775216cd4..ff73d69de41c 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021-2023 CHIPS&MEDIA INC
  */
 
+#include <linux/pm_runtime.h>
 #include "wave5-helper.h"
 
 #define VPU_ENC_DEV_NAME "C&M Wave5 VPU encoder"
@@ -1387,9 +1388,17 @@ static int wave5_vpu_enc_start_streaming(struct vb2_queue *q, unsigned int count
 
 	if (inst->state == VPU_INST_STATE_NONE && q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		struct enc_open_param open_param;
+		int err = 0;
 
 		memset(&open_param, 0, sizeof(struct enc_open_param));
 
+		err = pm_runtime_resume_and_get(inst->dev->dev);
+		if (err) {
+			dev_err(inst->dev->dev, "encoder runtime resume failed %d\n", err);
+			ret = -EINVAL;
+			goto return_buffers;
+		}
+
 		wave5_set_enc_openparam(&open_param, inst);
 
 		ret = wave5_vpu_enc_open(inst, &open_param);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 0d90b5820bef..f81409740a56 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
 #include "wave5-vpu.h"
 #include "wave5-regdefine.h"
 #include "wave5-vpuconfig.h"
@@ -117,6 +118,65 @@ static int wave5_vpu_load_firmware(struct device *dev, const char *fw_name,
 	return 0;
 }
 
+static __maybe_unused int wave5_pm_suspend(struct device *dev)
+{
+	struct vpu_device *vpu = dev_get_drvdata(dev);
+
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	wave5_vpu_sleep_wake(dev, true, NULL, 0);
+	clk_bulk_disable_unprepare(vpu->num_clks, vpu->clks);
+
+	return 0;
+}
+
+static __maybe_unused int wave5_pm_resume(struct device *dev)
+{
+	struct vpu_device *vpu = dev_get_drvdata(dev);
+	int ret = 0;
+
+	wave5_vpu_sleep_wake(dev, false, NULL, 0);
+	ret = clk_bulk_prepare_enable(vpu->num_clks, vpu->clks);
+	if (ret) {
+		dev_err(dev, "Enabling clocks, fail: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static __maybe_unused int wave5_suspend(struct device *dev)
+{
+	struct vpu_device *vpu = dev_get_drvdata(dev);
+	struct vpu_instance *inst;
+
+	list_for_each_entry(inst, &vpu->instances, list)
+		v4l2_m2m_suspend(inst->v4l2_m2m_dev);
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static __maybe_unused int wave5_resume(struct device *dev)
+{
+	struct vpu_device *vpu = dev_get_drvdata(dev);
+	struct vpu_instance *inst;
+	int ret = 0;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret < 0)
+		return ret;
+
+	list_for_each_entry(inst, &vpu->instances, list)
+		v4l2_m2m_resume(inst->v4l2_m2m_dev);
+
+	return ret;
+}
+
+static const struct dev_pm_ops wave5_pm_ops = {
+	SET_RUNTIME_PM_OPS(wave5_pm_suspend, wave5_pm_resume, NULL)
+};
+
 static int wave5_vpu_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -232,6 +292,10 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 		 (match_data->flags & WAVE5_IS_DEC) ? "'DECODE'" : "");
 	dev_info(&pdev->dev, "Product Code:      0x%x\n", dev->product_code);
 	dev_info(&pdev->dev, "Firmware Revision: %u\n", fw_revision);
+
+	pm_runtime_enable(&pdev->dev);
+	wave5_vpu_sleep_wake(&pdev->dev, true, NULL, 0);
+
 	return 0;
 
 err_enc_unreg:
@@ -254,6 +318,9 @@ static int wave5_vpu_remove(struct platform_device *pdev)
 {
 	struct vpu_device *dev = dev_get_drvdata(&pdev->dev);
 
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	mutex_destroy(&dev->dev_lock);
 	mutex_destroy(&dev->hw_lock);
 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
@@ -281,6 +348,7 @@ static struct platform_driver wave5_vpu_driver = {
 	.driver = {
 		.name = VPU_PLATFORM_DEVICE_NAME,
 		.of_match_table = of_match_ptr(wave5_dt_ids),
+		.pm = &wave5_pm_ops,
 		},
 	.probe = wave5_vpu_probe,
 	.remove = wave5_vpu_remove,
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
index 1a3efb638dde..f1f8e4fc8474 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bug.h>
+#include <linux/pm_runtime.h>
 #include "wave5-vpuapi.h"
 #include "wave5-regdefine.h"
 #include "wave5.h"
@@ -232,6 +233,9 @@ int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res)
 
 	wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_task);
 
+	if (!pm_runtime_suspended(inst->dev->dev))
+		pm_runtime_put_sync(inst->dev->dev);
+
 unlock_and_return:
 	mutex_unlock(&vpu_dev->hw_lock);
 
@@ -734,6 +738,9 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res)
 
 	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_task);
 
+	if (!pm_runtime_suspended(inst->dev->dev))
+		pm_runtime_put_sync(inst->dev->dev);
+
 	mutex_unlock(&vpu_dev->hw_lock);
 
 	return 0;
diff --git a/drivers/media/platform/chips-media/wave5/wave5.h b/drivers/media/platform/chips-media/wave5/wave5.h
index 063028eccd3b..6125eff938a8 100644
--- a/drivers/media/platform/chips-media/wave5/wave5.h
+++ b/drivers/media/platform/chips-media/wave5/wave5.h
@@ -56,6 +56,9 @@ int wave5_vpu_get_version(struct vpu_device *vpu_dev, u32 *revision);
 
 int wave5_vpu_init(struct device *dev, u8 *fw, size_t size);
 
+int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uint16_t *code,
+			 size_t size);
+
 int wave5_vpu_reset(struct device *dev, enum sw_reset_mode reset_mode);
 
 int wave5_vpu_build_up_dec_param(struct vpu_instance *inst, struct dec_open_param *param);
-- 
2.43.0


