Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89A175787A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjGRJvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjGRJu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:50:59 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6804FB;
        Tue, 18 Jul 2023 02:50:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jf3roXMZpezT5PLPEiFdYC6UZg3lp1tZAlB1+JnwZRkyt5uguQUSgeob1J/QnOZWRPI957ZbXt4gVPGiJnMIRoPSNwZOkqHbKkqKbYwCSojegteEHvMO1JEKmnLTM3k+Wq3LGEh0MAEcyhjoxQb1PyOFHLtfLBJKoca8ELJ3r61CeKdrhKnTF/P5pjuKxmxSH8Sm+LJz2IVy1lYMrewcB2NJuBtsXmZVyLoqRmmhHsBYALSJeGAWnD602Gr3fnYk04o57tXeY01Q5X2ca3R7J8Vki0KVR2WSPpwoNYdpoaCXCLULsOX+YXe5MEFO9spmqMdK5Nxr1w9IAvQCiqNI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSDokErEW24Y+K/+FEmUkfXUYoJN/EsPto2y3M0PEqQ=;
 b=VEqDS8Xo2R0V/c5v8IZ1hHpNbYaUhv+4ft0Ir4gb8dnDA2iB6POvXk/qS0BYVdweOHo6LTbQ6EBvaU98gzSD0x8toNI8S3I2G2pVacbnVDWiHB+yKBdRj/41HdGpcc+i8PErUwBHOUZ3196G3m7T2jIE2CS9V2OeI2fbMOimIjaAYcDrsbSjWd8I6kqBPTpLt6ZIN/fCorvcdcsB4XNew+DmfnIQsiVz1ZPXulxghUO3m5pxTDSg7fVwy232noa0KTNPbTelTmjS2gzKxa0LISk9FNA1JIx2nyKz96Z2ZF3Rkd4z2Zuwgj1hK/+da/HXgRH7wxQASKSO582KUiNzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSDokErEW24Y+K/+FEmUkfXUYoJN/EsPto2y3M0PEqQ=;
 b=oleAhlwbMW4QSBhWTRALiQbxqwjVWcKS1i3N2CxyPSrum5YIT34ramEvEvYztMw8P6TH96qwR18C4nqBtbyJ7vUPbco6xHMqq44qoctUG6f1UT+JbvMx3Spoxm2ywt3BOMAEhvK6JpQJv+Pz02CFNB+BCSRRwvORDoY3oFFu9M0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB7067.eurprd04.prod.outlook.com (2603:10a6:10:12a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 09:50:55 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:50:55 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/5] media: amphion: fix UNINIT issues reported by coverity
Date:   Tue, 18 Jul 2023 17:50:11 +0800
Message-Id: <ce7271cadd194feb56f3e4b2d7d3b41b704811fb.1689673395.git.ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6f7116e4-3e69-4877-46cb-08db87747ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgJKkiK6kC+lZ/sIRIAnrE+3V0S5l4kYoDYqc7onqdwlyse9aE5RaTVeUT/rnqtEUhcxxW72tYdKPXq8+8lG0unAmPJoErAdGtygVDAr/tt8dbBe6hba/7fmPpVRK2z9qjwIueHJ6iaNPENqf6nfcWYKLR7rJVX5E8IkccN1a7JDZj9rkKSrbD/0eOpGnynrGtfeKV2B1IhbaxpliAOumanBx/uuHTujYXl8+x8X5bisrvcNeoD361nNF5mA5XXbhHsAtwKaiHdyT8zcTH7zFccrv8gRi/cjCKKiQxgh/bcq8l78RvjzN5N7hd2bgNOqZcdl+H46bWsnCLA8AgKHbTBAXtU7Xtl9OMv4Ipy81luO6LNmvRhB92N7RfaJpvv+vqPxLZ+9mYo+OJofebCLTAMX8pK8lpOOYq8wWs8iBcp/+Q7UUm86RkPEnon0vMnUxXh/msoPBdBzENGC76yDcQ9/A6uveIjWCI8JBPw3dzXiTyB5tS2Z7KTrm9k/jPzccZb3NoyMhvFNaokymtH7OCJHgRCa3fWlcMLuNTYhw7XpnGworoxer6KS+tC3HPNiZgS8w0gng5Msb5al5Jvd7tLQ8wIf5muNtHYqQ011+LpUKw+p/oOfjVdhgxRigFWY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(7416002)(86362001)(2906002)(36756003)(44832011)(2616005)(6512007)(83380400001)(186003)(6506007)(26005)(38350700002)(38100700002)(52116002)(6486002)(6666004)(4326008)(66946007)(66476007)(66556008)(316002)(5660300002)(478600001)(8676002)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sqptiiUJcYkbqD/eRGYAJ49z+7EV14ts55lWT+YKirH/ee+DV22/eyYrrvHu?=
 =?us-ascii?Q?im80tMqthgFu+15euzifEsVGLrqVcuQiDTTlrn6sz0p95Q3Vg5RCzK0MySXE?=
 =?us-ascii?Q?X5do4H0oD44xbFBckgIvU41Y0KLHLlQ1L0KtDbG/axtJKJUKmY0V2oA8DcX8?=
 =?us-ascii?Q?7IbxW01SadXCcQPfIyrJoF3mipyXkmhlzeXXC/yfbFqbslDMTenZES2iVwX2?=
 =?us-ascii?Q?1wpIHXFD70O0NGnnTy5dLhZ/MSjOia6xq0gUPaVpiPTFI/PD6svdI941aREe?=
 =?us-ascii?Q?OULImQwEKQz/8YDiZpXfEdVTKV6sA7LSRfpZFPqTZzvN2/+NZJeuwqBgvs/x?=
 =?us-ascii?Q?YG6cls8otRqcedhc7nEChezzCsKFjgynFuuf359dd5rZ0FGlEvHxcw1/UXUB?=
 =?us-ascii?Q?67zc3/sGTGQfOGvJeAcqFqbe/dZHrTRXz15qhhQAKRg56/2qjXyerj1GsyO2?=
 =?us-ascii?Q?PA4ESIbn47DxQxr0eZuW1JxZS3pPz/654xxmLFOCDBahI9KzozSfU0M86C3v?=
 =?us-ascii?Q?j6z5i7/LPTiL22WKrieNFdeeNLwR9tmoqhCUCBfnZ6aN7a6/SPX7xiF5lPfj?=
 =?us-ascii?Q?+MKe8dtllaa53svtETxVtfDyoBExWH4gNlpcJNevgAa64UfjCqxXYc5l8bPb?=
 =?us-ascii?Q?ZH8BuYsyyefq0l2Us+0NawMb5bdOQJpixBnnlmhdF262X/BiZSGakNZvNYn8?=
 =?us-ascii?Q?/zqAozHvI0POF36xTxakaw+5L+CRxwYxZnY1dz8UsGEMYt04g48nOQ9IlMsL?=
 =?us-ascii?Q?cf91VGzd0J02KRJDE6jZwZ8iCFf8+MB1mm8N8MAGtxKWzbypdMNTEQC165jU?=
 =?us-ascii?Q?7UW6L8FObkltsq1YCb/xDmr9Ji12Jq40VIGzVe5WH6KNeRGvT0ypJyEfOGnc?=
 =?us-ascii?Q?eLu/fO3ce0bnAFvlClA76AmmAdNzhh9g1wPX38xm7BKz7Z2jjOwAmBZYrHKg?=
 =?us-ascii?Q?3TsYuJj1NQbGSsrlOhKEVpFMHRncT3W+eMNUw2y8elW5KYhQKyFt7wEjUXIi?=
 =?us-ascii?Q?y0qHhGV/O3dcDS+zCLfZkUwWwsw1QU9fSRZdwkhtx7Vngt00VOBPyURS4Kqx?=
 =?us-ascii?Q?HO1wUIOUWng2c10ee7lgYTvAREIu20F48AJsaKxF7UmO6bTnaOZpZ7RFYN8V?=
 =?us-ascii?Q?dRYb2AHCGZBxUeV5sRYVBFm2cuge8jzpW/Ff2yvcs9Ya+8gV1qIkcv7qbdaq?=
 =?us-ascii?Q?yGjpK7Q2p72X/fx7F/wmU0kShoqwiF9RFHMwWHy6H4QgMegm8giL7VFY/5tX?=
 =?us-ascii?Q?PaC65FF52JvSe/o9RDbhzoou6uRNZj0Y+0wjRppmT/peOiYZTUNkhHqFr5ay?=
 =?us-ascii?Q?nbt3iC/Y15e2daIRpm1Uf3XtkSjESGmNPNxeRlLfcUA4NdooWeWmDeB8Ircj?=
 =?us-ascii?Q?KKtB0RQimSCDkfWlRy6d1L/hGXrrKcgOH4jQp5S8qx1A91FCFPrEnbuecaQI?=
 =?us-ascii?Q?9cdts/20gNQVBJXB4cFYdsEgPg9i95AAq9zlySz6VKKu/YFLNV9MpBmQUe5Z?=
 =?us-ascii?Q?hYtxBZvidZ8bkUJXgtDzqthl0pj8Vnw8NeRzdrfwpWp27qbebO1ybJ2/86eb?=
 =?us-ascii?Q?IHzeHXcDQxzs8KBfksOJiktbpwRg/qloVKzaR4Y4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7116e4-3e69-4877-46cb-08db87747ad0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 09:50:55.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtG3ux/ERUrBDiez0CHuT8i1BSQI4L5TGCi9MLnuSdYle+SYoc6v5YOGCHNqhX3ci09tZviptaOtO8h1V0yJcw==
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

using uninitialized value may introduce risk

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_msgs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

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

