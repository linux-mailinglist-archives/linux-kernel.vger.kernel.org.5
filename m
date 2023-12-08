Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA08809D28
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573270AbjLHHbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573332AbjLHHbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:31:31 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52AE1BCA;
        Thu,  7 Dec 2023 23:31:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEhWvyjPoVj1qwbHSPfdr+wS3nQJuukN7NeLP4xWfKeDWRLRAtGJuXl6yT5uJcINtRH4bijaFtsptCC/tm08SAbnvESnK+F0XZzBNZZkOkXH6VnWRPv/PhfMhp4wviU9NTJpH6rWmz1WkMUOwq0riNy0INzLZHtbYrgwbZDfx7Q+zFW1Bvxl1s3lpfLyLVac6QIQAU9JdOpIHF9WoVQAsV3eEOx1u6j7iAJuloceFs2BLsFmCbpCiunLvRTFQzy+8Yv2uTDZOvVNXFjJ1L6N7RnhJpHLEQ0ZRzyVKLRX2daqt4fFtFGo22UQPCULNoQ4hYnNgWHdQMoMj5NdfKPXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOHHVNN+vRC9ZXQvOH3ZJgA7AhhfrN9rJIIhMiTUaEk=;
 b=c2ztd18fwYpZkKR7Vfm5sa2HkpVXdGoIz5Fr6n1H5Hlkkk7tl7NakhsUgDnWmlC/FCrKztxwotAoBftm+pYeLKmBwJS9ere9ej6aKeiuxbq7FNJ6NK4RtmsA0TIl/hc3BmnUfo094kfVAT6dLKmM293DwxVCMh4408cn/aAXs8YzU4hIOGudOCIpw+IStl2YxuSMnPHEm3HlD+xLze18VPB4HuGkS5MS+P4KX64jag28nqDVbJtN34kzYIdAb6nTh/nzqStMk7xvv6XjqRs0suuqm6c1vB0YHr2jVMzBRaBirMzyMosc0SwOnGqN1aE4LsYzuyjPdV2tbAw8f202TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOHHVNN+vRC9ZXQvOH3ZJgA7AhhfrN9rJIIhMiTUaEk=;
 b=Pwx/QtPTUsLUmf63Gjn6/qGhMDd8NOIrfnYYG75da+XP06EVS3XwQXrdMIkM5XqxraQhTbxAEive3EGi50Bk9zcp5Ol0hLYpRp70avLgctWoP1TiVqp9HEzOLtB1WpnE0Zpty6PRZx73fGEtMAT29DyTfnrEsE/YSMtc/025fjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM7PR04MB7061.eurprd04.prod.outlook.com (2603:10a6:20b:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 07:31:24 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3e09:3606:82b:c7fb]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3e09:3606:82b:c7fb%6]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 07:31:24 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     xiaolei.wang@windriver.com, shawnguo@kernel.org,
        robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, xiahong.bao@nxp.com,
        eagle.zhou@nxp.com, tao.jiang_2@nxp.com, ming.qian@oss.nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: remove mutext lock in condition of wait_event
Date:   Fri,  8 Dec 2023 15:33:42 +0800
Message-Id: <20231208073342.276143-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AM7PR04MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: 0675a8d2-3cf3-4b78-2764-08dbf7bfae81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ny6FbaM6bScA1NafoGLzCQgUAelJ9IYzg9y7tR9miJp3rMF+kPYldjTeIsstA9x24KhsirFplitdt7tVPTbeMFKziAuW9wglu4bsGdkLk3ZQKr7FjKr57vGMP8FHlTXDM1uoRmrNhybbdmDtaBhoQRvUQfkGa6T2BsfpEoIPZeBmnI03X/gakFMQsl8aL0x2YneUA/rk3FXl5BAG68lfifZYWv/DIgSH7DLN++uZVVXxLrZ4q3S/XnFZqPFxND4rVhPVg+4SE6bUg/gAnm608jOk4wBt9neb647kBdDbd/LTkLDZ+simrh6cW7p17z2dKkhyOlh2lrj96wvJq2A5xsHImatCh+/iZqaRsKeSMAg6BJZwpDB9z7Rdpx0RICJHeTFujBAp/Ef63ymjN1haecijqxEbVelCA6yHjkX9nwUbWH7gRIm2mgI7gOZNsRb3tsmxI3xuzK6JfeTIgTqPs33XkA3AD8MJ/cgeIZKVBB6PC80r8hCP28hxqoUZgUQcvzxM4rgVkFFvqDb7duJ94xxnbnArQOj7ehd2HYg03cRVCUpH0+oRAiR1tEAT7FFBos/DnhBI5QnvznyVq37i6SJ0tN8Ql9pCRbTW6NOWzjVsP68GgsCHrbCKh9/JSs2yx/29trQxuVPR0CQ5NEfk1IS536j3V7FbY1vcN1TysEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(8936002)(1076003)(26005)(83380400001)(2616005)(52116002)(6506007)(6512007)(5660300002)(6666004)(44832011)(41300700001)(4326008)(2906002)(7416002)(6486002)(478600001)(316002)(66946007)(66476007)(66556008)(8676002)(86362001)(36756003)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2DbMIqTmuBZkwZ0ijGyiu85EzpQ7q05nna/n8ximafDt9u+09CUKdFz9Ty3I?=
 =?us-ascii?Q?KCibNKS3zlP5qbXU4U+r7wtbk63jgzgzBIGyEihGvPWwxunEBOP+brh9F4IZ?=
 =?us-ascii?Q?jaEMh67gpwLDS8vIYHSvFVSmht7EU1anSevEtX+BfuKkZi7xTYDcLv+4kjdu?=
 =?us-ascii?Q?4mTfZzDgcyt7rkAqbZaToq+NSzveEnuhOkgjBmt3rs42+QY5djU9rv0pO1m1?=
 =?us-ascii?Q?ap01M9vwS5yLTmZpXzHBpKx2uL/mv3rbRCePJ7kKNyJcQ+x4iPNFnDS6Ngco?=
 =?us-ascii?Q?DMwKWxGCxzgjI6xFqLVIyZzyZRXm9mj4HZ3x6U+UJO8CYPyOiefAJcJIXRIo?=
 =?us-ascii?Q?bhygUOQxCqbBB66B/WT/CpVL9aPYNQoaHnDvJ40JnRVvxmjd0/yH0gqqlnw1?=
 =?us-ascii?Q?TMe5xwjzrfOjDax1yV2W8WPZC5HgeuxabhCsEvYxQ7mwszeUWV9GtyVNcQmL?=
 =?us-ascii?Q?6n94BVEIZzqOIlUXKCCa6ubDWrt/iJ42xT6aTyGV3/a+lA8ZQcXqwOJi+gEs?=
 =?us-ascii?Q?ps6lTFwgodI60KmDEVCYLFKguDafNj+PKovl8xmv4S1Pe3FRukT1d73zQMGb?=
 =?us-ascii?Q?x887ZPvp7/06OctZu21HM5BMWXorsmHDg6UND2oy1Pt4ykdJYTG7dQxu2GFA?=
 =?us-ascii?Q?Ztx+VJJNLepaP9RqtYsIn7k8YzZ8znDXPKAKR3hLkZyUbOUth+g76os5ZP4H?=
 =?us-ascii?Q?GzGi2wW02JHEgw61EaJcSoXqDFvcv+RlXW4XC9LQxNgOyyrzLQLJzOPtZPo/?=
 =?us-ascii?Q?JxIU/9aYWJmxAWWOyrC5xg1DzxZVwbIWozbZbKlDMcvwKNjrtw0PblwSGWqU?=
 =?us-ascii?Q?6ml61iljWsZwuTI3FuUVpQNIkq5m2lSl48wzTSuFnr/WA3/m2eBU64zdcaH+?=
 =?us-ascii?Q?sEyE8d7ORaCZWIQd//7XWPluc2PdO6o+ASznbJeF+xj2k5RFlD6rjNAakAxf?=
 =?us-ascii?Q?7BTquqxPSDqO5AeK0izzRPGmSsUJ2O5ZUZQZOgADajt6RAgpVTnWtiXA92Zi?=
 =?us-ascii?Q?9bh0z1czb5X3HJ8YTxiFAErowxwgjB8wbx2qW9qFUX+iGTRocV6lfiRziy7G?=
 =?us-ascii?Q?faiw+RXd9I674eWMcnyBPuAo3zJjM+z0Zx9q06NRpWjgzyZChMjk8povQhrT?=
 =?us-ascii?Q?vfcg2FJK+HybrXt3rrKtFWM/1KfMY+DJN76Oz2KfetCk053lLTMaiKeRAk1p?=
 =?us-ascii?Q?jrDeiSj8DUbJq2sLiJtKW6fqeLDZW3NGpCxgueMm8cDgjwOKyYXiVIFgueQt?=
 =?us-ascii?Q?3buoafBPPhqjpTUBIRLt4wLDFHX8yA97anjU7vi7dgMgsKS0glw8Qh1fzjc9?=
 =?us-ascii?Q?xXgGL9oVuwME4y/Uk7R0C1Jgh3N23PIdiO9a6K2+jYAwKINat3W4e7YxtA2E?=
 =?us-ascii?Q?01Mzk+mBWpxFDLB5f7ywnPHzuyS9Tb+emUBVU4UyHnYQvgiHvNbD1f89EpJx?=
 =?us-ascii?Q?taAqSjMDop5Jr2qZ0H5Z0LanwCvaWJSVs6lyimr9Y++80UnatHzoOExRqha2?=
 =?us-ascii?Q?661tFmvw7bv9nYdP9D6gKyp1D2lKritx9qW6MJV6ZqbfXbzj863OsMZdX/LP?=
 =?us-ascii?Q?J3oNB+8QjFuVcsNCb1WlpOZwaR8dVRrpzG4eep/0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0675a8d2-3cf3-4b78-2764-08dbf7bfae81
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 07:31:24.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PY3fjltHnP+o2rHDQfJTmfyX8jCwreFjUuSLUxhAT+yxP/X+fVeu8dSzcEdVkThwK1mGnkVAeDPyovRW83OsAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mutext_lock should not be called in condition of wait_event, otherwise,
when CONFIG_DEBUG_ATOMIC_SLEEP is enabled, we may meet the following
warning:
do not call blocking ops when !TASK_RUNNING; state=2
WARNING: CPU: 5 PID: 741 at kernel/sched/core.c:9859
__might_sleep+0x80/0xa4
Hardware name: Freescale i.MX8QM MEK (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)  pc :
__might_sleep+0x80/0xa4  lr : __might_sleep+0x80/0xa4  sp : ffffffc0123738a0
x29: ffffffc0123738a0 x28: ffffffc009194c48 x27: ffffffc00bbc1050
x26: ffffff8814b282f0 x25: ffffff8814b280d0 x24: ffffff8814b28080
x23: 0000000000000001 x22: 0000000000000032 x21: ffffffc00bbc1000
x20: 000000000000011b x19: ffffffc009324670 x18: 00000000fffffffd
x17: 30303c5b20746120 x16: 74657320323d6574 x15: 617473203b474e49
x14: 00058b5b8b9aa1f1 x13: ffffffc00903cda0 x12: 00000000d744fcc9
x11: 000000000000001c x10: 00000000000009a0 x9 : ffffffc0090201f4
x8 : ffffff8828245000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : 00000000410fd080 x4 : 0000000000000002 x3 : ffffff8815aab4c8
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff8828244600
Call trace:
 __might_sleep+0x80/0xa4
 mutex_lock+0x2c/0x80
 sync_session_response+0x110/0x310
 vpu_session_send_cmd+0x18c/0x244
 vpu_session_start+0x38/0x70
 vdec_start_session+0x1b4/0x3e0
 vpu_vb2_start_streaming+0xa0/0x1c4
 vb2_start_streaming+0x74/0x160
 vb2_core_qbuf+0x488/0x650
 vb2_qbuf+0x9c/0x100
 v4l2_m2m_qbuf+0x7c/0x224
 v4l2_m2m_ioctl_qbuf+0x20/0x2c
 v4l_qbuf+0x50/0x6c
 __video_do_ioctl+0x174/0x3f0
 video_usercopy+0x210/0x7cc
 video_ioctl2+0x20/0x30
 v4l2_ioctl+0x48/0x6c

we need to refine check_is_responsed() to remove the mutext_lock, each
cmd has a monotonically increasing id, and cmds are executed
sequentially, so we can check the id of the last reponsed cmd, then
determine whether a command has been responded or not.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
CC: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/media/platform/amphion/vpu.h      |  3 ++-
 drivers/media/platform/amphion/vpu_cmds.c | 28 ++++++++---------------
 drivers/media/platform/amphion/vpu_v4l2.c |  1 +
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platform/amphion/vpu.h
index 5a701f64289e..0246cf0ac3a8 100644
--- a/drivers/media/platform/amphion/vpu.h
+++ b/drivers/media/platform/amphion/vpu.h
@@ -154,7 +154,6 @@ struct vpu_core {
 	struct vpu_mbox tx_type;
 	struct vpu_mbox tx_data;
 	struct vpu_mbox rx;
-	unsigned long cmd_seq;
 
 	wait_queue_head_t ack_wq;
 	struct completion cmp;
@@ -253,6 +252,8 @@ struct vpu_inst {
 
 	struct list_head cmd_q;
 	void *pending;
+	unsigned long cmd_seq;
+	atomic_long_t last_response_cmd;
 
 	struct vpu_inst_ops *ops;
 	const struct vpu_format *formats;
diff --git a/drivers/media/platform/amphion/vpu_cmds.c b/drivers/media/platform/amphion/vpu_cmds.c
index c2337812573e..5695f5c1cb3e 100644
--- a/drivers/media/platform/amphion/vpu_cmds.c
+++ b/drivers/media/platform/amphion/vpu_cmds.c
@@ -32,6 +32,7 @@ struct vpu_cmd_t {
 	struct vpu_cmd_request *request;
 	struct vpu_rpc_event *pkt;
 	unsigned long key;
+	atomic_long_t *last_response_cmd;
 };
 
 static struct vpu_cmd_request vpu_cmd_requests[] = {
@@ -115,6 +116,8 @@ static void vpu_free_cmd(struct vpu_cmd_t *cmd)
 {
 	if (!cmd)
 		return;
+	if (cmd->last_response_cmd)
+		atomic_long_set(cmd->last_response_cmd, cmd->key);
 	vfree(cmd->pkt);
 	vfree(cmd);
 }
@@ -172,7 +175,8 @@ static int vpu_request_cmd(struct vpu_inst *inst, u32 id, void *data,
 		return -ENOMEM;
 
 	mutex_lock(&core->cmd_lock);
-	cmd->key = core->cmd_seq++;
+	cmd->key = ++inst->cmd_seq;
+	cmd->last_response_cmd = &inst->last_response_cmd;
 	if (key)
 		*key = cmd->key;
 	if (sync)
@@ -246,26 +250,12 @@ void vpu_clear_request(struct vpu_inst *inst)
 
 static bool check_is_responsed(struct vpu_inst *inst, unsigned long key)
 {
-	struct vpu_core *core = inst->core;
-	struct vpu_cmd_t *cmd;
-	bool flag = true;
+	unsigned long last_response = atomic_long_read(&inst->last_response_cmd);
 
-	mutex_lock(&core->cmd_lock);
-	cmd = inst->pending;
-	if (cmd && key == cmd->key) {
-		flag = false;
-		goto exit;
-	}
-	list_for_each_entry(cmd, &inst->cmd_q, list) {
-		if (key == cmd->key) {
-			flag = false;
-			break;
-		}
-	}
-exit:
-	mutex_unlock(&core->cmd_lock);
+	if (key <= last_response && (last_response - key) < (ULONG_MAX >> 1))
+		return true;
 
-	return flag;
+	return false;
 }
 
 static int sync_session_response(struct vpu_inst *inst, unsigned long key, long timeout, int try)
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 0f6e4c666440..d7e0de49b3dc 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -716,6 +716,7 @@ int vpu_v4l2_open(struct file *file, struct vpu_inst *inst)
 		func = &vpu->decoder;
 
 	atomic_set(&inst->ref_count, 0);
+	atomic_long_set(&inst->last_response_cmd, 0);
 	vpu_inst_get(inst);
 	inst->vpu = vpu;
 	inst->core = vpu_request_core(vpu, inst->type);
-- 
2.43.0-rc1

