Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1843E7FF9DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjK3Sqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346708AbjK3Squ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:46:50 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2076.outbound.protection.outlook.com [40.92.18.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F6210DE;
        Thu, 30 Nov 2023 10:46:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iydVL6Ry7fki+gH4oS27nnziUHf7AtQSStU04wj1h7EnYccQzvZO1mOFb3S6u9qyJVxi0WHquEvyD538c7F5G78Yx6mYwoxfJVyEgkracu68SxDqGUGrv5SiKRSoPd0WQb0fE9eo4sIZTbgPqnuMQQOlYqoU17Nm7nhSsj9afE7dxHvk0dJg6Jzm62kC1Zk6kLJEZnjG7BryEpjMjG5tN0KgXojzSDplhVYUie73IEAFgUXC/GH8AFIoahpPRKKpzOf6070NYSVxHq+rIFOPawofivVZ4IxoIz2K2+1ib9ugOjE3++pIRL5x22dgAeLmonpMb2LMtZttGk/facSKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnYg6tXqS/UXyC0JDSDC8eyG6rh0mINlAAkhRQrZuLc=;
 b=SYJhab2g915G3VqYl3b0qOQME7r6kmNI+FnukJ2V8FRGhYFc/f6XmpwYjKagu4n5Zk0sXo6QX07H0JgLQmclQWh+OXk0QxKuXuWpaTsYkyCHKEa6LChEjXw9+ue8t3myu9rt1DhhiJHK3UmJi9myo3byXGpgafUy7rYfB3xAsal9AGAiIXRFgMkUs6YuD7CyT26wFieV+KcVSJ16qq77UBvIG5X+6oZ4AzQLRqxoU3Z6OU1Ig9KwFLPT+4Q5RR7OABtVqRKhjtEBNR9/tolM180lLZ4/Gbto4gaD+0sV8zqqUmtg1wR5CUjkwa5qfKy9RnqmlMWDoRJV1CrSgmSMqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnYg6tXqS/UXyC0JDSDC8eyG6rh0mINlAAkhRQrZuLc=;
 b=E1FHwBKI7SudhXw+O98pA6yVQiIPAY37y2VnaiFuGmDUd4p40KZ/ji8MEmwXeb/Dd7nAztqBvoKKOJWMWotfn9o0cerf12YNTCCW8qqfS2kNuPkHa+nM9pYW4m8LVwSBFhV/LVYQUErmGsEa5UAb7riTYvcyniOOqLBe5y466KwOdcgM2riCiHpRIkaKzO74Lo7XYSs2srQIfLge+0EMtlj0DNPnlnqlW8JRnhjyQQUhs5Vc9OMhZPM5n43O+MbO0Xy3cD5YmuTyzrud1ZmLh4J8Mk9Uttz05UrN7ztcWa6m46+vy55ClzLvZ9vqxAVDxGF26dMJsgBxuIE6hnmQzg==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by SJ0PR03MB6779.namprd03.prod.outlook.com (2603:10b6:a03:40e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 18:46:54 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 18:46:54 +0000
From:   Min Li <lnimi@hotmail.com>
To:     richardcochran@gmail.com, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v6 3/6] ptp: clockmatrix: Fix u8 -> u16, DPLL_WF_TIMER and DPLL_WP_TIMER are 2-byte registers
Date:   Thu, 30 Nov 2023 13:46:31 -0500
Message-ID: <PH7PR03MB70643CB46D5BA34397181500A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130184634.22577-1-lnimi@hotmail.com>
References: <20231130184634.22577-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [BOStujframyzf09/fZBCDl7yndnp9D3B]
X-ClientProxiedBy: YQBPR0101CA0262.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::24) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20231130184634.22577-3-lnimi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|SJ0PR03MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 5002e956-d910-4a10-3fd5-08dbf1d4b8e4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtxiddZHvfUUlrBCWNRbogxjkfpjkFMXnxo5T7G1DzDQGaC38YHyZZV5tPfcrdDOngGA8/mbUxuXvphjt7lfCDbjuYOVX3unVnvvxTZCA5Wj2iTdFKoS+Kuu6600Z/62BN0f4WLf/I58hCx47/9eiiEmraAzKu1ODdPhtgzfCXhfuYuXQuDl10/hN7fwKUFUczclvHDUpxUyPQi17yf83C2H3KohR5S6eNq4J7ZGqqe7v15yOw0aCwPDbJ4gVyi0TADYsFvFl8HG3Ik7gMzBMdlFbnDqYLn2VLzDAJQBhHich7arHyBWliN813ckswhGc2WFWH6/MMISyWt0ke+d1TYeqVGp1T1C+4Ya82tleqxe+kvDVffhqN2SNDt9vhs2DjYZ6kzJA8Mgw6TUxvBKHkDnFo9bh6z8+Q7XR6rHeSUW4C8Fj/vzkUMPMtYQ/c4ZNxeIiMZ5oqPOKtHYDPhcNkewgIR74/j3jOI5OnIJqHFOHgeRpudgvYx8P8b2LmALhhVBLBmrL/szBSKOof4OCjr6A+egH+NU2cHe6DVA9x09w93zBEaQBtT0KFrTLzL+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MEoAOa+puwP4E7tvkG/MjoDyYLOtX0fztxp9gL2dgTiFItg/MSF/Jxcp4ya4?=
 =?us-ascii?Q?LnZMs4ZR9Pn/7rjr8CuX1FBT+K5jgT6m8EUCPUURmdvlhL48cE9qfe+p7Yvf?=
 =?us-ascii?Q?UYYKpeSfyU+81m/bEN4VkzmJQDCT+KfU4Ie6OnZcg2LyKHxUy22EpDtBuosW?=
 =?us-ascii?Q?veigJyg7SUUZHAl6gDp9UxjMMYNT9xp2xSr3GIGno8fzuFAANKLjPuqXpw7K?=
 =?us-ascii?Q?r4mUlcyQvwEWXwjPIJn4/iMjS5uI6VBmN2WgKBQECOSmJORy8E4/Evsu8Sws?=
 =?us-ascii?Q?Aom6vyrvGTotAOMIbcL1jR9Q6j7BjQztf0IN8WFIasIyMyBrbntJkAdXiare?=
 =?us-ascii?Q?z7S47mcDMgVrddj6PJgshic9VizOkE0XKz8DWo0rLMJ4QJxPH1OuL4UX31Vw?=
 =?us-ascii?Q?hVCLeuAuQA4Hn9Yk3GmPj9qe3OTT4WQ4ukOCqpcrlVBQtvxKsfqB/uSOI0GN?=
 =?us-ascii?Q?ye5iIXCFQlDDso3PhXpOV7pGTVL85JtYE748uoup1p6hSIkTGNt1Mnv2akai?=
 =?us-ascii?Q?+oJV/8aFVqlS8CTszpMuNTVAAyaiU8lcPtEOt2Q4Z+hVFsTYVDJ96Yj356i8?=
 =?us-ascii?Q?b9DhpZM45o/UgOK9u+TzaK5ecGoCoaHEwZcyg6HkWBPSu4gT95JoNJghsxmY?=
 =?us-ascii?Q?lWUuefNqGS85NAkrYMWG0lXbDu7QB+OadjXauZqvScsSajCo4d94AkRQxjwJ?=
 =?us-ascii?Q?70mPYDlT9NMHHmkgWoBCd7Cyr+FYGn815Ty68aRkTNo+jXSt+YRoHiggLy4T?=
 =?us-ascii?Q?igWvUVHTLd7Z+WEVJOYj8IIkbqNgWtmy8NlSwkkgaqto5XR1PukHd2vp8/bN?=
 =?us-ascii?Q?AwVKo4oqWaTH04Ivtsk5mm59TktIQ/MdKqtxfMFMZVnn8gRNEgn+Ng9hOWJ+?=
 =?us-ascii?Q?u1AoCHFm134BVikLGSDJhYkJCIlsBMKq1Gyii/i7Op1jE8wclDC//5ZolKoq?=
 =?us-ascii?Q?7H77tTJkZAaE3ddKp+oXsF6sPixQvl1vYXoXXRbSOg8i6VlGtpbu5OiQKm9f?=
 =?us-ascii?Q?IUZuVsam7++DY4nk09iHd90GJPh4DRh3IP0hxJl8rfVeb39KOuUP2rioc6VD?=
 =?us-ascii?Q?DyMnIzIC1xE0HrHFR9dtvWCZx/UGHflVla5cFfIml+bzVVZfdmTTz13RJ7Mn?=
 =?us-ascii?Q?Ggj2hPhWlJEGgnCMDVaUiRKkSLdjl3cN3yKFwkCQA1/GhVxaZuL1U7rGweuI?=
 =?us-ascii?Q?5XxNwqCUh3ikyOrtnIcxEsZpIw6L0BYOGgM+Sw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-685f7.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5002e956-d910-4a10-3fd5-08dbf1d4b8e4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 18:46:54.5853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6779
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Li <min.li.xe@renesas.com>

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_clockmatrix.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index 6d55da54e496..d069b6e451ef 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -1396,18 +1396,18 @@ static int idtcm_set_pll_mode(struct idtcm_channel *channel,
 	struct idtcm *idtcm = channel->idtcm;
 	int err;
 	u8 dpll_mode;
-	u8 timeout = 0;
+	u8 buf[2] = {0};
 
 	/* Setup WF/WP timer for phase pull-in to work correctly */
 	err = idtcm_write(idtcm, channel->dpll_n, DPLL_WF_TIMER,
-			  &timeout, sizeof(timeout));
+			  buf, sizeof(buf));
 	if (err)
 		return err;
 
 	if (mode == PLL_MODE_WRITE_PHASE)
-		timeout = 160;
+		buf[0] = 160;
 	err = idtcm_write(idtcm, channel->dpll_n, DPLL_WP_TIMER,
-			  &timeout, sizeof(timeout));
+			  buf, sizeof(buf));
 	if (err)
 		return err;
 
-- 
2.39.2

