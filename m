Return-Path: <linux-kernel+bounces-14481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E9F821D9D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2F41C21F2D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68D511708;
	Tue,  2 Jan 2024 14:28:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2040.outbound.protection.outlook.com [40.107.239.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0C612E4C;
	Tue,  2 Jan 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2qUcSAptY3b0zBM+Nv64H9XsY6Dk7kZnCFWmMiO3Y+Nu32NBS6WNvt7QUjYiTuAiiWuhZF+ypeIcW70QnYzPIvQTBEvg4wQd1+CR5Xc0vKPN9273jbAeSrBZS7UV3LdsZJRd73fAYF+nMRv5wdVeHYfNODzev0ar7e8UAHIgfxlZyU2k9LBG9JO9bytoiy0eqK7IDt283MByxN7JjRmQoPp6gGgvk7OeafMGNoThqstvZ9N0dmQ/E+nkBlqQ2EjkefgtT26r6MS/AAuaaEkswCMoSCcB44HqLg7OQVEjKEp0f6OljC/oM8z+9ASVw3OHLmvsvqGRkGNe8XiEhiGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hw+ZMfeXpfA9wyHP9iUGLuEgZaEXTvU038rMq1+iCig=;
 b=O9Xg4QFFTw2j9X0+VF/h8psGOJ+iZToaAokfh5RvHganuGIxo6/KfrYtvAdKWBebJ8zoPWd+iqMf9Z5/C/5kI2N//XyoeEm9H43svncbNEHP82Ts7Np0MsaAI7MkGzt18JmyWjY1mjwWOck5dwEySTLuqTFfBbN/jDflW71tETfeO9SQhdk4FBYpKtfkVxbthhoSVBVq5BkoGD9+dmNo65V8rKbqsVv7mpdP2BYpvCdwGyjrirKklWBkwP1LTpujJd8zrjk5fmldfUV+yaP5u9OxNkvpGNUYJQ66LXaOxjoBz25IL6f/DHuhuwcmnSbPCuXMOycGHd3uDYp6bOzYDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::6)
 by PN0PR01MB9723.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 14:28:02 +0000
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c1b:b2aa:7fc0:6532]) by MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c1b:b2aa:7fc0:6532%7]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 14:28:02 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: mchehab@kernel.org,
	kieran.bingham@ideasonboard.com
Cc: bhavin.sharma@siliconsignals.io,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: adv7180: Fix cppcheck warnings
Date: Tue,  2 Jan 2024 19:57:29 +0530
Message-Id: <20240102142729.1743421-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::27) To MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:42::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZPR01MB6957:EE_|PN0PR01MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: 1159943e-68b9-4f90-7b34-08dc0b9f0713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PJkxEviak0j2xGqieyzmNyn5i0MZ4wuO8dHzZQPpJ4+CcPUiIvmz/hKAwvgQXyb90mZlM6VX1b+j5swpV9ENxZkghRoigMjyUjY4ct2bsWpZWQoSvr2DmM21le8GOoAf/79UJ+El7k0ih+QLsB1EBE/CtodfC390fthBd6gXtc3TUX8i5wzYm3d8WfVkmn6N2DUVXIfG4n+dkLjMom4J0M0APaJ47xtdpPfE52cucXRvC3fG0B3GbXsbjsKqNDJByDjNZJfKUow9O7WJwdNCALAnDARA/d9oFSGG6ma9RA6JVXLmN3icBtN5SUmGsQFUXZsFurXZ8DvcodVA12473lAjBBq46eefU2VCu9Y6Qu5YXSJlh3WJsUhqGr+ytbPK76hI2g5sjf3BN5NIwAkUnA6w7Yy3h3CH0LT9f/IKGzW2fmaa4/wusDSnNpp5BU+LNZD4AxljglnfEUVNxwH/qmuRIFjf+3f8QDhpwC2nX37rbU4SCTWcHDXIrKth1/IXdmXbARTXd4mWWNn7YI6Ce7DocZ2fl57PlgMriPIGLIFJHAhoioOOryQKPAHnLztHXYtbFH6RPmFn6AgyRmT8ab/Zx4n3viyL4tL1GywXegzpwA+UgZte3Cpq4FXABQ968bqniJJ+Y4/lpQPKAe4sCy6MOdN3ppF9c9DrJWunpJk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(396003)(346002)(376002)(366004)(230173577357003)(230922051799003)(230273577357003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(2616005)(26005)(1076003)(38100700002)(41300700001)(8936002)(8676002)(316002)(4326008)(5660300002)(2906002)(6666004)(44832011)(478600001)(6506007)(6512007)(52116002)(66556008)(66946007)(6486002)(66476007)(38350700005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pzzECu0HdDpx48bMLq5+ScYKcmYQzdvnfzh96haP/DRqZSMIkiloyfyZ56oh?=
 =?us-ascii?Q?RWqBeiCuV/ANaGpW/3InrzmkFE8oiXjsgvtXhoa5BYHsag/utJe343jJ92j6?=
 =?us-ascii?Q?Fa2shhIWwKxiy7dUed/fMIjqNrhEdtveGr2SBJJtgMMR8Y3Ul6beVbXHwp9Q?=
 =?us-ascii?Q?0IFu8z0Dprhe+6IwZ6gyYKmOSVSt+qcXK/Zc7t8/51P1JaQlAMtFGRSy3ucs?=
 =?us-ascii?Q?3xpDSPpFw1x41yes6sjxur8ut1CT+wFOLnGVRtss9Nd0gMAgRkP5YZzRYt6C?=
 =?us-ascii?Q?inMiLBWyOQGcdyN4BOV6NpiNDm7eD6RJZzDDldFfJMMCI0MztWPrKfRhHDs7?=
 =?us-ascii?Q?poy/w2RVSFnD4WdXXJVY6vI0utMKI9JaYAMPQWELsPkA+EPgDfv5OfbJysrE?=
 =?us-ascii?Q?xxHjVR0UQrAa840H1X+1H9w4mbOdxVTsioQcVG4aUrftZDqBLjuJqrVtEqwb?=
 =?us-ascii?Q?VPbaitOI29p97wQTPglekipZKJqemtq6jX4HYqRdOLFVIuSIqPwS5yz3z+vQ?=
 =?us-ascii?Q?nmpv4HQEpTrcJ7uejb7uz+SCjQJR7q1qIpHFBl5FE5v7Ok/GQ7BoPXH4/LR5?=
 =?us-ascii?Q?TD+5eT7D3ORf46kdKqP9nmP7ycLuIDhGZ8S6GFoYrMYMDTbEXK01Vli9hyhZ?=
 =?us-ascii?Q?kSg9LWteGbidWJgnPr5T7Bt6csrzH0EDe7TucNv2YdTPNZs9i8U2mXI0PywD?=
 =?us-ascii?Q?cxXU1H4IbVO7gkA2kln/bMTDqt4LJGP0ivHA1N9o80ZJgJX4OqobyKRK85TW?=
 =?us-ascii?Q?WlMDpg9pMlsm6USxgpm/32gVOEV7E/4WKejTY+NMukXGYTJaD3GqdgnAgr9O?=
 =?us-ascii?Q?utaHwt+P5qkGMPOb+AyJYzZR3A6mSf0nrQupV3l2HIgFPZzIWx2E7XG24Tpy?=
 =?us-ascii?Q?x55OaHr2iI1mTI2zM1qFWSDVl3yPjwLsAx2ZvEeYFFdFEWv52fwOvvurJtNm?=
 =?us-ascii?Q?cnel5qw6vuBXj7sOoQl62DUp/hI7cVxy5S1YynokIVAE5oMn+BS5nHE4+bJs?=
 =?us-ascii?Q?PXRHdMrERwiA2JpxVqxs26yQkowgYYHSLONHs2KVGkxWqqBYj/3u60SQd8Ul?=
 =?us-ascii?Q?7Krq72vZSnY1/5cNY3LsLTUIXTHrwytQa4VJhsQXPE7qyD4rA1wyqjEbjOrg?=
 =?us-ascii?Q?z8N23L1+WrT5Gu3yh1TQAXZl4oH8M0Mm3vr6HmrEj6t86Zc+piDDs0ELZ6Wi?=
 =?us-ascii?Q?Oy3GnTLiynifp8SJpTjPfAQdWC+V2jPBrs60Mb8NAbkbG04ABFVMcIhNAnYO?=
 =?us-ascii?Q?tQ8qRUU7ICbLqtxHi6AebkFmAL+1DjtkpFqBtxHbog4QDsq0760JIw9P9rom?=
 =?us-ascii?Q?BRrgr2g854vY5Ob8lKzO4AWWGR9/o679HTt3ghfIr3i/IxFOpNejPTd2Q9nG?=
 =?us-ascii?Q?OhZRv8h+GXWrwsurR1A2/ucDRyF6PHPq7UWFnkiVmjbp7gITVLPUsrvh2URx?=
 =?us-ascii?Q?sLFgL1SShQG6HP5Dau7AWGCCTut/O8Ra9y1aDd307M1Mo2ZEanwfSu5R9A25?=
 =?us-ascii?Q?LoWga+lvOyoCqn77gDiyDXy8pgOdAvJvDE7rlZwBdOxvxb6g6f0IF+xiNCce?=
 =?us-ascii?Q?q8cx3xjq+j+2/eH8W1f225zMw4EKQgkrd0naSQcwUe1jkT4UUaw/oI+OwVge?=
 =?us-ascii?Q?QJ6KVGOOGYbhWIgt0kjgAiY=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 1159943e-68b9-4f90-7b34-08dc0b9f0713
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 14:28:02.7227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WyOjNtAdzEVhK1G/2huPuaDxapL5ledk3quuXFsrGUM2lOWxzAK97EmylaOS0yEh/We4TlbwTyGfo4WYxAKMIrAaUGbUrB+TtPTbZtjdDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9723

WARNING: Missing a blank line after declarations

Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 drivers/media/i2c/adv7180.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
index 54134473186b..0023a546b3c9 100644
--- a/drivers/media/i2c/adv7180.c
+++ b/drivers/media/i2c/adv7180.c
@@ -335,8 +335,9 @@ static u32 adv7180_status_to_v4l2(u8 status1)
 static int __adv7180_status(struct adv7180_state *state, u32 *status,
 			    v4l2_std_id *std)
 {
-	int status1 = adv7180_read(state, ADV7180_REG_STATUS1);
+	int status1;
 
+	status1 = adv7180_read(state, ADV7180_REG_STATUS1);
 	if (status1 < 0)
 		return status1;
 
@@ -356,7 +357,9 @@ static inline struct adv7180_state *to_state(struct v4l2_subdev *sd)
 static int adv7180_querystd(struct v4l2_subdev *sd, v4l2_std_id *std)
 {
 	struct adv7180_state *state = to_state(sd);
-	int err = mutex_lock_interruptible(&state->mutex);
+	int err;
+
+	err = mutex_lock_interruptible(&state->mutex);
 	if (err)
 		return err;
 
@@ -388,8 +391,9 @@ static int adv7180_s_routing(struct v4l2_subdev *sd, u32 input,
 			     u32 output, u32 config)
 {
 	struct adv7180_state *state = to_state(sd);
-	int ret = mutex_lock_interruptible(&state->mutex);
+	int ret;
 
+	ret = mutex_lock_interruptible(&state->mutex);
 	if (ret)
 		return ret;
 
@@ -399,7 +403,6 @@ static int adv7180_s_routing(struct v4l2_subdev *sd, u32 input,
 	}
 
 	ret = state->chip_info->select_input(state, input);
-
 	if (ret == 0)
 		state->input = input;
 out:
@@ -410,7 +413,9 @@ static int adv7180_s_routing(struct v4l2_subdev *sd, u32 input,
 static int adv7180_g_input_status(struct v4l2_subdev *sd, u32 *status)
 {
 	struct adv7180_state *state = to_state(sd);
-	int ret = mutex_lock_interruptible(&state->mutex);
+	int ret;
+
+	ret = mutex_lock_interruptible(&state->mutex);
 	if (ret)
 		return ret;
 
@@ -436,8 +441,9 @@ static int adv7180_program_std(struct adv7180_state *state)
 static int adv7180_s_std(struct v4l2_subdev *sd, v4l2_std_id std)
 {
 	struct adv7180_state *state = to_state(sd);
-	int ret = mutex_lock_interruptible(&state->mutex);
+	int ret;
 
+	ret = mutex_lock_interruptible(&state->mutex);
 	if (ret)
 		return ret;
 
@@ -466,8 +472,9 @@ static int adv7180_g_std(struct v4l2_subdev *sd, v4l2_std_id *norm)
 static int adv7180_g_frame_interval(struct v4l2_subdev *sd,
 				    struct v4l2_subdev_frame_interval *fi)
 {
-	struct adv7180_state *state = to_state(sd);
+	struct adv7180_state *state;
 
+	state = to_state(sd);
 	if (state->curr_norm & V4L2_STD_525_60) {
 		fi->interval.numerator = 1001;
 		fi->interval.denominator = 30000;
@@ -828,8 +835,9 @@ static int adv7180_get_mbus_config(struct v4l2_subdev *sd,
 				   unsigned int pad,
 				   struct v4l2_mbus_config *cfg)
 {
-	struct adv7180_state *state = to_state(sd);
+	struct adv7180_state *state;
 
+	state = to_state(sd);
 	if (state->chip_info->flags & ADV7180_FLAG_MIPI_CSI2) {
 		cfg->type = V4L2_MBUS_CSI2_DPHY;
 		cfg->bus.mipi_csi2.num_data_lanes = 1;
@@ -857,8 +865,9 @@ static int adv7180_get_skip_frames(struct v4l2_subdev *sd, u32 *frames)
 
 static int adv7180_g_pixelaspect(struct v4l2_subdev *sd, struct v4l2_fract *aspect)
 {
-	struct adv7180_state *state = to_state(sd);
+	struct adv7180_state *state;
 
+	state = to_state(sd);
 	if (state->curr_norm & V4L2_STD_525_60) {
 		aspect->numerator = 11;
 		aspect->denominator = 10;
-- 
2.25.1


