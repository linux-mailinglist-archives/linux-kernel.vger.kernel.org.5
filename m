Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DCF755D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGQHka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjGQHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:40:28 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA7DE54;
        Mon, 17 Jul 2023 00:40:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQaiblVDD8K5PW30B7gT7KkytYLUrRTRJcJLVqeKZKuZKHypHC5q+S/36uLFJa89hjQnfuglzumoHg+J0U9MjkhDVibl76cG5xmbkyHsxDSH5d4vrtX/1UXr2hAz+hNMea0KPY1fnOGzyUEkBhi5G6EsA9OYTRiqRiCt/rqrEVMX9v0BNxQ1bg9ivjaQw8VzAAvlzcmSRwM5R+l0Z/piMPxmOps/u7KbZRbEoQy7F+sfQQF9F8xgcwFQDN6FDkbpFJwWE19uekaUffHHoifefsV5OXkozz6OOA/+xNZqzEfUvgMUC2CdyEj9o3is19/DJR/PNdRTK25q8d7qW50zIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7ZVSf292lQyl5bMQXznfPAekJ40jy3ZnU2e4QpU5II=;
 b=HYljuEjKSv4jDe7769YDvH4u2HmqaCz0JooLD9H5ELlHsywG8Imm/pNkbfsYb1DZQUWZJRDntDhPYFfaLyqxwdcfoqgzVvRDOZHlipumAqLUTnXzNjdMnnDeAq5DQ5mW4tJrWbS3nLZY2iYNPHF1Mw+XD71mCZdm9HmLHf2PBb+SITRS1ZvH8tAr+z1gC9ajm6PLmyYypyYcZAG5If/KyPC46dUuwy90VXuemqA88T3a+DsDzwQjGn1/sSU30LCs2mbbsL3zq3QvLsc/c1OGneIB6u1Lpuix55ffHV6SBO6U5AG6LUbov1dD60W2c4YE7Z+kNu5hK89mrKjXEP8iHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7ZVSf292lQyl5bMQXznfPAekJ40jy3ZnU2e4QpU5II=;
 b=oh/GmAvbSfCNIDgbrNRXcm/s5tUlnd78YGH3IM6NSz4oMkafu05psWZicZDff1GKZnNVsxYeR51uW9MkQQZ7px5hG1HdLXhAqRCKXZQq3zeD5jmiBOxYnEovm1yHzjv5GbeWXjBymTXuwjhBLe3HWpriGJM8FooLP8ro9hvVhqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DU0PR04MB9249.eurprd04.prod.outlook.com (2603:10a6:10:350::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 07:40:24 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::cc21:3476:cea7:3436]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::cc21:3476:cea7:3436%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 07:40:23 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: fix some issues reported by coverity
Date:   Mon, 17 Jul 2023 15:40:06 +0800
Message-Id: <20230717074006.22372-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DU0PR04MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d949887-3f69-4240-fb46-08db8699149d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bLgIqcq5Z2oWPLBFGB80GPVA4KF2gm2BfK/qZ8F/PDG3JUIRxpfaYgY6V7eDiOzC9Db8ytbRdzH38CgmpXbUZXxVaQqR3d3HgRL0hR0FShKYO8goMzqQleqjzidYIP2jPBZA55lQtBArV6cV13oQzo7HBZ/CbEvuV7++qgTI/5yahnMWlLTXXkf8456DrEBzDD3hccPQTrCUtLSNnoz8KrxBD/ZQBTaG94A1hlcmhleHAdpcQE7c7haZCQEb2wQnnhZnep5gOyw9dUzRIWJ5niu6xG3NvPBPDnw9h/aVlQasGyGeQAMbubuLxkvMOYfEs9XgzFYR1/5Mg784TMfcjCZpnzb2CagpgsLZsTizcAzD5Fgu81YKQaKS9gWn+WuFKDK6Xg4aX0+140QYeHvcD3qEfMGpePZS13AB4J/nUxRfekvJ8/GYx0QCs7BD5c2BlV+0/KAWZmMGNv47lZaS2JmLOg6sgt0Ngq6TB5KhX8yGsF11gzdZ4ZqY8ABa6nC76H5CI+CLe9o5/vK9z/8CT1qFvetQoRcesl1w42QSjCXfcCle7z8L13EGTI4lhgm4cjz1+Yl+bwblG0Q8EW/yYXnEnGJYJvAvsA5/wk011ZILLG+QDCuyb1FqP0xqixY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(6486002)(52116002)(26005)(1076003)(6506007)(6512007)(36756003)(2616005)(83380400001)(38350700002)(86362001)(38100700002)(186003)(8936002)(8676002)(2906002)(41300700001)(478600001)(44832011)(7416002)(5660300002)(4326008)(316002)(66556008)(66476007)(66946007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GZwMWIrAYKyaZce+pnJTU5tNMMRGivX6VKKmjLqngrd4REXDSSUqhcjaXey5?=
 =?us-ascii?Q?TdGZ8pHlWdy8wg4gLYEEyvwFSqLP4dDOup+f6vJHdun7H/nAexQoQXCvQ6fh?=
 =?us-ascii?Q?Jia935kWc4MSZr86ZsXwk1NNfGBqCmXSYds8KjhYGHeMqdOQdr48udpyZHB+?=
 =?us-ascii?Q?Sve1CtRoKuZ2sSI56hKgOcZ//JwEnv+W/6nbNifNqH8KcG9uvuEvrTP5uDw+?=
 =?us-ascii?Q?srWOtEnJQpUk7fCkXRG47kjQqaDeEQclOpMXOIt0ZoDnj40iqZb86cKU4jL0?=
 =?us-ascii?Q?Fg4Yon6/mLKuykX16Im3tomOQ+X3dklD//RzAtXmffF/jc/xvNLbA0UhvCpR?=
 =?us-ascii?Q?wacVzCGQA2fHNnyoXJwR42LvtVjt8lGQUDH+epbK9CoBwbuJJRb4Qyw82Aa4?=
 =?us-ascii?Q?EhGpzkOnPr5SVpbYgDg5xrtAxYi+TOx4P8aMN+aY1CtKddb5NVZ2QiP24M9C?=
 =?us-ascii?Q?RG37FB5O0rRlB9Iod5/leu8wD8AsgmWTshUDDhAGesd4BFc5KejSC5WMULdW?=
 =?us-ascii?Q?1soYXPisWTo6Rf++iKYxDF1JelV/ME2ONQPCO6tqqRdrIfZdbcs5Fox/Mi73?=
 =?us-ascii?Q?9tM8mXbMSO/ZU7FPG7Wts34sNJRQ4ol2/ZrHZxsLBfe2t4OvKfP52RtnJkEd?=
 =?us-ascii?Q?jAm0NENu+FsfyP/+BeKinDxL14/3oDYcWRbHa7DWMibthfyUDOIRy1Ma8NLa?=
 =?us-ascii?Q?sBNAEfOzadoXRVDejL1CFU+M3XoMbMAd26gY7wD1bnPjzNoTJbcOSXfeiRWN?=
 =?us-ascii?Q?ORxy2BsiWWM+TDOQ6dMWsyfEjnY3bi2Q5OR3PdgHTLqR5EjwKUWloAP1q5/2?=
 =?us-ascii?Q?Prx5beRvzvJPjCby2yvwI8x21kOR4iURKA+4HI0v+OQXDnWAcIx6+TBc+W+j?=
 =?us-ascii?Q?QXjsaOQUAWkdS1nCuYM9JW1j70jsiA2IFs4BKfgnAFKLo1O+j1weWNmF75Yo?=
 =?us-ascii?Q?EG/Lhv3Nswl3bQhM/zHrIQmE1JY6BGjyJeZIX4nqAU37ze1TIv8BEKHPPaeh?=
 =?us-ascii?Q?pQKWkkO2q8c1BEwEcO/bfRm43x+ZaZkKkL2L+KasXMekeqYSYkwnoHsdM+ky?=
 =?us-ascii?Q?20Ofl/TrCgT6pLEhUVzpEb6I/8vyzoZMATNS783eVK+Vt8XAdhTWzfWi4Sl2?=
 =?us-ascii?Q?kJ4y0E9eenM5y3cbcsCSxopGN3sQhWfMx1QW59Oa0MEnbUs+4P8nuq7xLdwI?=
 =?us-ascii?Q?QKXxwhvw0CA2BH6tEgKQqQxQfu+rY4qnI4aRH+VRvvh2j483/Rkxh71tib2j?=
 =?us-ascii?Q?W7C0VvYgqUideckE/Yjxd45S/fztSl8j38lUnQFTxPs6F4GyRIqVtrPpau11?=
 =?us-ascii?Q?7Peg8HCa7fG/BxO+TDLUOwRA9BfXCaZJB3bwgNHXpjcUnchK6Kx7P7YK+v+o?=
 =?us-ascii?Q?d4ZeKQjZk/Xotr8ck6HzLRfVSiZIiwWIVmv3RXhnbomNIBHCmj9++jNAgXz9?=
 =?us-ascii?Q?OBvcH29IdfHi1MAB7Lyok3/HQ7fDYM3nTtHKGgNP83c5Vw28iHE8JtgEDGhL?=
 =?us-ascii?Q?nIyDkvtDfOQs9UNyC8XN5IRclFP0GqkBBCNrhWcJSE3fdhWMMrbmbdlfXU9B?=
 =?us-ascii?Q?ny9bpkwtRCoNzQOVenGc4s5snsRma9alQ3oafT+V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d949887-3f69-4240-fb46-08db8699149d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 07:40:23.8900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgzjHn2cQ80ha7IfZwWsF1+f2JjrUAQLGAGR5EFpwj6T5OJqGRM9dwCpDO6eX3mq/f0Ir4Dd2osFBk51fV7aVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9249
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CHECKED_RETURN: 4 case
REVERSE_INULL: 2 case
UNINIT: 6 case
UNUSED_VALUE: 1 case

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c     |  5 ++++-
 drivers/media/platform/amphion/venc.c     |  6 ++++--
 drivers/media/platform/amphion/vpu_cmds.c |  5 +++--
 drivers/media/platform/amphion/vpu_core.c |  2 ++
 drivers/media/platform/amphion/vpu_dbg.c  | 11 +++++++++--
 drivers/media/platform/amphion/vpu_msgs.c | 12 ++++++------
 6 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index eeb2ef72df5b..133d77d1ea0c 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -1019,6 +1019,7 @@ static int vdec_response_frame_abnormal(struct vpu_inst *inst)
 {
 	struct vdec_t *vdec = inst->priv;
 	struct vpu_fs_info info;
+	int ret;
 
 	if (!vdec->req_frame_count)
 		return 0;
@@ -1026,7 +1027,9 @@ static int vdec_response_frame_abnormal(struct vpu_inst *inst)
 	memset(&info, 0, sizeof(info));
 	info.type = MEM_RES_FRAME;
 	info.tag = vdec->seq_tag + 0xf0;
-	vpu_session_alloc_fs(inst, &info);
+	ret = vpu_session_alloc_fs(inst, &info);
+	if (ret)
+		return ret;
 	vdec->req_frame_count--;
 
 	return 0;
diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 58480e2755ec..4eb57d793a9c 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -268,7 +268,7 @@ static int venc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *parm
 {
 	struct vpu_inst *inst = to_inst(file);
 	struct venc_t *venc = inst->priv;
-	struct v4l2_fract *timeperframe = &parm->parm.capture.timeperframe;
+	struct v4l2_fract *timeperframe;
 
 	if (!parm)
 		return -EINVAL;
@@ -279,6 +279,7 @@ static int venc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *parm
 	if (!vpu_helper_check_type(inst, parm->type))
 		return -EINVAL;
 
+	timeperframe = &parm->parm.capture.timeperframe;
 	parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
 	parm->parm.capture.readbuffers = 0;
 	timeperframe->numerator = venc->params.frame_rate.numerator;
@@ -291,7 +292,7 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *parm
 {
 	struct vpu_inst *inst = to_inst(file);
 	struct venc_t *venc = inst->priv;
-	struct v4l2_fract *timeperframe = &parm->parm.capture.timeperframe;
+	struct v4l2_fract *timeperframe;
 	unsigned long n, d;
 
 	if (!parm)
@@ -303,6 +304,7 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *parm
 	if (!vpu_helper_check_type(inst, parm->type))
 		return -EINVAL;
 
+	timeperframe = &parm->parm.capture.timeperframe;
 	if (!timeperframe->numerator)
 		timeperframe->numerator = venc->params.frame_rate.numerator;
 	if (!timeperframe->denominator)
diff --git a/drivers/media/platform/amphion/vpu_cmds.c b/drivers/media/platform/amphion/vpu_cmds.c
index 647d94554fb5..235b71398d40 100644
--- a/drivers/media/platform/amphion/vpu_cmds.c
+++ b/drivers/media/platform/amphion/vpu_cmds.c
@@ -306,7 +306,8 @@ static void vpu_core_keep_active(struct vpu_core *core)
 
 	dev_dbg(core->dev, "try to wake up\n");
 	mutex_lock(&core->cmd_lock);
-	vpu_cmd_send(core, &pkt);
+	if (vpu_cmd_send(core, &pkt))
+		dev_err(core->dev, "fail to keep active\n");
 	mutex_unlock(&core->cmd_lock);
 }
 
@@ -314,7 +315,7 @@ static int vpu_session_send_cmd(struct vpu_inst *inst, u32 id, void *data)
 {
 	unsigned long key;
 	int sync = false;
-	int ret = -EINVAL;
+	int ret;
 
 	if (inst->id < 0)
 		return -EINVAL;
diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index 43d85a54268b..6f054700d5db 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -88,6 +88,8 @@ static int vpu_core_boot_done(struct vpu_core *core)
 
 		core->supported_instance_count = min(core->supported_instance_count, count);
 	}
+	if (core->supported_instance_count >= BITS_PER_TYPE(core->instance_mask))
+		core->supported_instance_count = BITS_PER_TYPE(core->instance_mask);
 	core->fw_version = fw_version;
 	vpu_core_set_state(core, VPU_CORE_ACTIVE);
 
diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index adc523b95061..982c2c777484 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -50,6 +50,13 @@ static char *vpu_stat_name[] = {
 	[VPU_BUF_STATE_ERROR] = "error",
 };
 
+static inline const char *to_vpu_stat_name(int state)
+{
+	if (state <= VPU_BUF_STATE_ERROR)
+		return vpu_stat_name[state];
+	return "unknown";
+}
+
 static int vpu_dbg_instance(struct seq_file *s, void *data)
 {
 	struct vpu_inst *inst = s->private;
@@ -141,7 +148,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
 		num = scnprintf(str, sizeof(str),
 				"output [%2d] state = %10s, %8s\n",
 				i, vb2_stat_name[vb->state],
-				vpu_stat_name[vpu_get_buffer_state(vbuf)]);
+				to_vpu_stat_name(vpu_get_buffer_state(vbuf)));
 		if (seq_write(s, str, num))
 			return 0;
 	}
@@ -156,7 +163,7 @@ static int vpu_dbg_instance(struct seq_file *s, void *data)
 		num = scnprintf(str, sizeof(str),
 				"capture[%2d] state = %10s, %8s\n",
 				i, vb2_stat_name[vb->state],
-				vpu_stat_name[vpu_get_buffer_state(vbuf)]);
+				to_vpu_stat_name(vpu_get_buffer_state(vbuf)));
 		if (seq_write(s, str, num))
 			return 0;
 	}
diff --git a/drivers/media/platform/amphion/vpu_msgs.c b/drivers/media/platform/amphion/vpu_msgs.c
index f9eb488d1b5e..d0ead051f7d1 100644
--- a/drivers/media/platform/amphion/vpu_msgs.c
+++ b/drivers/media/platform/amphion/vpu_msgs.c
@@ -32,7 +32,7 @@ static void vpu_session_handle_start_done(struct vpu_inst *inst, struct vpu_rpc_
 
 static void vpu_session_handle_mem_request(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
 {
-	struct vpu_pkt_mem_req_data req_data;
+	struct vpu_pkt_mem_req_data req_data = { 0 };
 
 	vpu_iface_unpack_msg_data(inst->core, pkt, (void *)&req_data);
 	vpu_trace(inst->dev, "[%d] %d:%d %d:%d %d:%d\n",
@@ -80,7 +80,7 @@ static void vpu_session_handle_resolution_change(struct vpu_inst *inst, struct v
 
 static void vpu_session_handle_enc_frame_done(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
 {
-	struct vpu_enc_pic_info info;
+	struct vpu_enc_pic_info info = { 0 };
 
 	vpu_iface_unpack_msg_data(inst->core, pkt, (void *)&info);
 	dev_dbg(inst->dev, "[%d] frame id = %d, wptr = 0x%x, size = %d\n",
@@ -90,7 +90,7 @@ static void vpu_session_handle_enc_frame_done(struct vpu_inst *inst, struct vpu_
 
 static void vpu_session_handle_frame_request(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
 {
-	struct vpu_fs_info fs;
+	struct vpu_fs_info fs = { 0 };
 
 	vpu_iface_unpack_msg_data(inst->core, pkt, &fs);
 	call_void_vop(inst, event_notify, VPU_MSG_ID_FRAME_REQ, &fs);
@@ -107,7 +107,7 @@ static void vpu_session_handle_frame_release(struct vpu_inst *inst, struct vpu_r
 		info.type = inst->out_format.type;
 		call_void_vop(inst, buf_done, &info);
 	} else if (inst->core->type == VPU_CORE_TYPE_DEC) {
-		struct vpu_fs_info fs;
+		struct vpu_fs_info fs = { 0 };
 
 		vpu_iface_unpack_msg_data(inst->core, pkt, &fs);
 		call_void_vop(inst, event_notify, VPU_MSG_ID_FRAME_RELEASE, &fs);
@@ -122,7 +122,7 @@ static void vpu_session_handle_input_done(struct vpu_inst *inst, struct vpu_rpc_
 
 static void vpu_session_handle_pic_decoded(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
 {
-	struct vpu_dec_pic_info info;
+	struct vpu_dec_pic_info info = { 0 };
 
 	vpu_iface_unpack_msg_data(inst->core, pkt, (void *)&info);
 	call_void_vop(inst, get_one_frame, &info);
@@ -130,7 +130,7 @@ static void vpu_session_handle_pic_decoded(struct vpu_inst *inst, struct vpu_rpc
 
 static void vpu_session_handle_pic_done(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
 {
-	struct vpu_dec_pic_info info;
+	struct vpu_dec_pic_info info = { 0 };
 	struct vpu_frame_info frame;
 
 	memset(&frame, 0, sizeof(frame));
-- 
2.38.1

