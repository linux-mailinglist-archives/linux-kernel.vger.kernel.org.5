Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A8F757875
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjGRJvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjGRJuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:50:50 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2045.outbound.protection.outlook.com [40.107.14.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EAFFB;
        Tue, 18 Jul 2023 02:50:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi+TA9at+4Esd8r2NYuwPhBLfl+BhcJJ8fG1P1lK484Z3VB3k2doL8qYzBW8ZY1+jBqNJ5MS9Ygy8ElcDI77PcJb2q1qG5Zrzu5lFZGYq7QuJukc6LMMA5x5b5C099agEHN1Ss/0NYU3sADLjSt5c2UejHPPB6j/6ZJycU9reRtMK7fxOcNyLpSyPvqowhAVd73zqanpGnBqhDgZkCWf7YyP78oaoJRNh2UPQ4zP54V/P+wiHLN3J1Ov3RtDPJIh1EpPErF1FUfcZGDzjHCZnxhTxEQ2hC7WY6ySemWQwgmk/+8w8KCz49PNPORWJqvM9WPAQ5JM3OfIZgnrNbNFVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enSYVrFfIT24FN10A6OY5c9XnXIhLz6/pInfzdHOsoA=;
 b=bbCainN0qJJ74s/FquaJUIHIhCXU5VhbOKuxNgVG1eF19xzV8LLUuP+T3g/uwGcEaRlHBX/dI0s2HAzZrF1PXx1rJNLUOESc9+xLbKoTPKdRRqko9Xc7ruh3zBsQffiNFOZ5czQ91lb6hCQlwtmwyuoQwR2s/kQCjLDoXvfjdpLfsgBuJAgLMPlpeUEzbIjrsPYiT+cl2a4EMwp2oFotG0SbPZgQ5MWu5r7F16vkBwBdEPobr4kaSCzSzf78uAueV4YEOPWg5TsV+BhacJP4MUkGTRZzR4Jkh6qL2k0emyGX43w/JSQtPDX3I8LRlWfDVIkgHd0hWd5lGIHeDIHsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enSYVrFfIT24FN10A6OY5c9XnXIhLz6/pInfzdHOsoA=;
 b=QNxnk3Gmt+iOzl45V2Nv6yORJSP57RIi9PLVvg2wm4mx6fiJ0eqLBMPeW8vZ9qf1Rdrz2vJrLCfxZhzydqrWfSkNlZD0xW7fVqWsnfWR25DpkIOeqjN8UQv7Yep2/k3swoPAN8nQ4Z+VdVrceexmR6VWxhLlwyj+c2+NFeAFuz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB7067.eurprd04.prod.outlook.com (2603:10a6:10:12a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 09:50:46 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:50:46 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/5] media: amphion: fix CHECKED_RETURN issues reported by coverity
Date:   Tue, 18 Jul 2023 17:50:09 +0800
Message-Id: <6df1c8bb1d85543d131e09408581b59842bb02d9.1689673395.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1689673395.git.ming.qian@nxp.com>
References: <cover.1689673395.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DB8PR04MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 026c5c93-ecd0-434c-100e-08db87747592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CfamIPAQK9vBEc2hbinDiCj/3KSZHJspPvG2Zg0pXx7vDev3WWQhm+HKWTynrZjUYz7zWQCVJxEztZBD2tkT0Trp/TWico0LdhPs126ti1H/+aNCbaeVhEyDxMCoDIN5XvAzNfFIxNYCm5vtu/u3nr8QTavbOEGXkMHBjC+BGl++wum4Mkk7EyXSON5/BNvGK+w4SxNxaZ5am7W6gzWDkIpwjcpoGFzRTkRbf1RWKoAhL70e5sFfvDsfoa1ituFtB0hPQyhaO4ObFxKc0+np0G4xTXgygtHMXdHTqE1PkOlAy+LaNuAJHG/SFn8LZJvrcIWccw41XwSfI5UF51YIYfg3tk7JhdSBrdSaA70WV2/5u7Gvx7xSDGP5FRTv9Jb/SHhdOss3Sz1K51DXk3Pbxlqg6RcveoeVfWaoO8ALJfikgShMz5O8DciCsHiLkAsyhrHIJflNP4Heoqm2rYqUIhgLizvLeUP+NzVJZoR9osuYbppWdlKmrUtO3XDilh5JsD4796sOZFz7GQGn1LrH7FVGeFoH4dzfedo0neB2OE/B6yaMQmDV64H3qz59rvYjdirdK0c+5t/5RTgz3JFt7WZmxeE3AbIMdAK69VrdlQqdt4fd2v7XI9rzyt4GMqgI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(7416002)(86362001)(2906002)(36756003)(44832011)(2616005)(6512007)(83380400001)(186003)(6506007)(26005)(38350700002)(38100700002)(52116002)(6486002)(6666004)(4326008)(66946007)(66476007)(66556008)(316002)(5660300002)(478600001)(8676002)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/NvyqlpVRmW7SeEo6RUe17WAkzNLsm+4gTigXFGuRTzRVDozCpUsCHcK1Zzr?=
 =?us-ascii?Q?p7TpW0U89mhpWWg51oga6zb/Qk6CyUzMHr6xtfPHq/miNX1Hr7F/xUO1vSRn?=
 =?us-ascii?Q?fjk2zfl3mvLUuuVZi918Dk8iRX2FqfSVf0Oph/qf3ufHAyjHcIoT73vR/5Q5?=
 =?us-ascii?Q?scaCuiqfmPyMMt096somPjqpPUMEbkaW79SavciozneLWyAnM44/fLtZyV0i?=
 =?us-ascii?Q?8coyLDdeF7DbPq3rUgnQ6tx81dqhZMt+zh4IDO9QjY1PAzPVaJ6rfh0Kf8wT?=
 =?us-ascii?Q?amLKXJ1bC5SAWmxAuDwOI059S+0A8+9gpAHfyDgYTe/yBDBOez/b18wAYM46?=
 =?us-ascii?Q?pHytE6CgxnPNjqv+UiiHc4mL9J7ML2J0mrnF7hEPciRwVkjOJpvXOhRXBeA4?=
 =?us-ascii?Q?DK/m5s3LKb+3YyjIXvJCHcDvyBdOAvcRrnGUHw8JQDXtyF367q8fImIBFaFa?=
 =?us-ascii?Q?VWLhNzqxwacFUyHY2dXollVOAJC5/J5/BL+WM7V9TmJro214OJ4pf1IcvRxR?=
 =?us-ascii?Q?dbM7GIBANKyx31wVaqb+lxkHOUclEwteNCGCbFq1j0vQa44WKyppGRJZmO3V?=
 =?us-ascii?Q?WW4Aydjckru2oPBLlrkSYbzWOAACkePFvXSMY1zsnkY0n8moIlMp270MEQrU?=
 =?us-ascii?Q?0Mzveighx/n901ZEW7qy0sKddnQKvQNbf7VmTRRs6gmqwFQXQ4pxBLHiEEGk?=
 =?us-ascii?Q?UPEciArLIUff6Kd/0XDyVKMo6k975kQ7l44D6zSpgK9FYSnVJzdAYt32HKC/?=
 =?us-ascii?Q?EqE9Nd28DvqiyWv98uJNEmUPToliOaFgjpbuXIT1XaQy5FkkQmPLM0XTk2Xg?=
 =?us-ascii?Q?l3z8e+XAHnYkcpvSJk+j8pOxGSw1Y2iB5xWHEAB8ojilVdXmcrS8zBunM0bz?=
 =?us-ascii?Q?xkPa4/JLDexGsLyT9ZJTfq+M5hcD/LyOcL1CRyUqSN/7gCYWMqcBb93csO0C?=
 =?us-ascii?Q?oRx6b08QMWCOXMsYrDP7fUJCKTDF/RlhZ+FE/T87XxEw9zZI6zq1E52v/CJs?=
 =?us-ascii?Q?gmwPqJ66AuygXT/w8OkNX6QuTHCWhFztLZN8wYFUzjhX0TJPnH6MfUshCzGW?=
 =?us-ascii?Q?hcatyqnwZPNJv68AAduolb0Ey+T1wPm8yusxOV2N7rj/r9KYtxBzqg7F+035?=
 =?us-ascii?Q?eyb7kYsrLdheZmuYxVD1AL8Subl4OAunHwX/60O83Cq1DeeVRTCr8Aile1JH?=
 =?us-ascii?Q?ozMmrqzfhGlZBynZMhl1ODVKe9iqclyzQ/n0hGic1TINcpi/GN9dxKjWpJ3g?=
 =?us-ascii?Q?BH+Q9N3qZWVEhMA19RVsmuOcNy0Wt3yDSh5zwxINkDYSswbxVQa+Z9tnv/6k?=
 =?us-ascii?Q?9P1ZYiiRIsAfgvR9Q4mJQuGyBrYv2b1SAbAQKEGBjXKOPRdwdX8bpSfGMekg?=
 =?us-ascii?Q?6rus5508Gg6etoFi2ehfu1z/7oCiq+EIi3TTG3WaE8JHrbzWrRa/uvyqkokH?=
 =?us-ascii?Q?l8qx3bQRpioR0yme4cZeGkEQMkmh/Q7aD89GIOtzre6tIbHb5iWB5D3NwRVq?=
 =?us-ascii?Q?phMVlaMzbYldNa+5+HsT4TV3qlF9lq3I/1sCsz9dvjFReqH8njAHHG9Fi5lD?=
 =?us-ascii?Q?9kU7fbf9EpbXAD3+To8xUqO7oianZiLIaEF6VsuA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026c5c93-ecd0-434c-100e-08db87747592
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 09:50:46.5244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BneUr227W6Q/jBF2dTeAz4nn5tTBfLjlQa0iGR+FJp/PUs+nBY/fhUf0WJVMuwJjjvhQrsqGf7yIyQHA1w3b+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

calling "vpu_cmd_send/vpu_get_buffer_state/vpu_session_alloc_fs"
without checking return value

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c     |  5 ++++-
 drivers/media/platform/amphion/vpu_cmds.c |  3 ++-
 drivers/media/platform/amphion/vpu_dbg.c  | 11 +++++++++--
 3 files changed, 15 insertions(+), 4 deletions(-)

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
diff --git a/drivers/media/platform/amphion/vpu_cmds.c b/drivers/media/platform/amphion/vpu_cmds.c
index 647d94554fb5..7e137f276c3b 100644
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
-- 
2.38.1

