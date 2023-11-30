Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE8B7FF9DD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjK3SrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjK3Sqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:46:53 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2039.outbound.protection.outlook.com [40.92.18.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C2210F0;
        Thu, 30 Nov 2023 10:46:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcOwEytcXFRwpvFqGr94x1W3RfkmbsU14VDBRn0Yvni62zcR26Aa43DOQZKW3XGszHbFL8UeBS4Mfvb65KwtfjVQUAiZQzCDVtdwIdGZJtGd70gXEqFMJaU51yXOTKSQGBOxmXlnXfApkIB2oO2GkwIYt9F2vdQ4Opaxl/sl9pmqYX0ATruEdOhOvn53wkno3+6mam/DtBzGGQ6LNd7v4BC9MnYgsBMyjncymNVEywXfCUryPwn3aAqVe4kpX3yo2DaXwLeaRynxdgzV8WK1wery5rBIVi6FIVFgRBDy9/plv5AdRuOUueMkAEjP1igw3PYY7kK5pDl/OjeV6/Hznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCR4dH+nSgJwKX/AKlXC9LZZ9ptdyMnaaKrpFcXKJSc=;
 b=U08RDgAEnQxQFkiyhnPnHK1h6nDuTHgvBB0GR79ii/HMIcsMdj4B474mvPn/zqvcEL/jg1VGs0MyfXZHqHglVQfY+parHsHZAcGYeNq+Igw8Gkj1++nHEfMqvIFx5y3KPCBpbpK1NnzI2XQuvPcDstKjiE/GX6zeSfcpKiVfEq+wwxW6aFc26K46aBp+kjjAiULjaB+dl0TmIpYvoa4klfFjKApBLNv55cGTZw003SlUCpIcihZzz0eAZcTU2+aSM0MneAK9NcJlwDwbiBHLeGSH3G/u/oWrjhuQn7DqWNijvaPXPNzx/1AyTOkFENErqQhHXkqDewSj1Oc8rtDUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCR4dH+nSgJwKX/AKlXC9LZZ9ptdyMnaaKrpFcXKJSc=;
 b=RTEFs+MFwPa4FT0myzLvee5LDONmJp9fyKYrji2S94ECkEcqaBfrj7/o4PaE5qxLolvoADz6GOsUmmM2R4bJ7losjWxzJdqrKrbYdr4NgG58Rifx7eoU36kCxliRdK48a9rWRie1ahaxQhdpY6AjERB+AxEHXgSI1Yrlr41bIdqNsGFzNwBTvonEKKiKag9nYOdXgKWLtHeq56GvALHFmzqOEPwPlwlDFndrP5uGhJi895VjiaQ4UBE5qJYeNONRT28Okkv5umWuveILpsz+b3BJvIyHZM1KNBJ5Bmd+qZ6cwZmFgEUmxsXQwSWK4FJ60BuCK9PF4POJeAFb4+95mw==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by SJ0PR03MB6779.namprd03.prod.outlook.com (2603:10b6:a03:40e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 18:46:57 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 18:46:57 +0000
From:   Min Li <lnimi@hotmail.com>
To:     richardcochran@gmail.com, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v6 4/6] ptp: clockmatrix: dco input-to-output delay is 20 FOD cycles + 8ns
Date:   Thu, 30 Nov 2023 13:46:32 -0500
Message-ID: <PH7PR03MB7064A9C11FB1252AEED5EF13A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130184634.22577-1-lnimi@hotmail.com>
References: <20231130184634.22577-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [C0hL0toyEmrxLneOU1BepbnB3dnHexEK]
X-ClientProxiedBy: YQBPR0101CA0262.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::24) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20231130184634.22577-4-lnimi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|SJ0PR03MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 953bb17e-b09a-438c-1b24-08dbf1d4ba83
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQstSANJ3QnGOJgDcN92X+kXcqPn64noTNxAivSSunn/j062aY9edyEYBoeyjt9bk1Q1jdfzOwdvFvJQQLvR02nkIAyHSSVUJOGm3+yGsy3B996OZqHgdlFNV6VrYJIP5h+6KCo3anX97RHp3Umbmzam7Ndluy5P7TeU8oKPLWiyCsZgU3WK1fvjcTBqAR3jsS62/6zkVcu1azoglT8NhYhk9Pg5FHqYG6bj/9uBFSIPIdFJB4UTiNKACkLXYJDd+Zc2PMQg4rZeRi7hUyYao9Wd0NWweaq+7lbOVqHBgajyDAhnu12WCoFD7+LQX4okonW5unrYeBODi2jnGxmcTKGljpAy8t1jxgPur5OigIEaQpAdyj9vqSDHs2gioADcm59zK1ntiXDIk1KMGFDhQKsMyEBiHXEjIWyA75LzE1bxFVuykiM3kIGx+8MtQoN1Sp5wHJiwQZAWULZSorUqhgzM4yNtXfNBg/Zpz9sbR07TyLQlga5vq2eASaRjx0x4oIqx9Flp7HanReamDNUtWlo5Tin4PQaazzevUaPnn47Iel5zjLSg8MwaEhCkYX23
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xOghqp2cUTOdFn03wE5/gi7zLvWdm2Kq9CDftZH4QKDkpoxcsG5DgYHAonhb?=
 =?us-ascii?Q?Gvgba2quzaDg+GtcLSnLGcK417wbleaUQe1k6gtmVgQxZGy8nqeYkTjb+Dsi?=
 =?us-ascii?Q?jNimISfyy0QNS+NV4WeHuJ/VQtEILQOtN0ufxtn6ON9inZ8b2ONsix+SC2v6?=
 =?us-ascii?Q?v1Oa5/Lul40to6W6pirhmh3/WBzx+fLMTe+z5sEgZeBElCDav5YG/DmbtQDb?=
 =?us-ascii?Q?LtYt35qEaobpR/lqNS/2WLJUaRau909QUAzsDfaSKOUW5pGPgAldg3MDn0SO?=
 =?us-ascii?Q?WiNYLqQEo6uSGEvQ2Ej/7o0kFS/W30uT0WudJgUvR9Md5y+8L4xtLV6jSjyT?=
 =?us-ascii?Q?3XtCaYpLbeeRFMNzAWCdT26Kq1t7+HYGdeAOjXnm/FXCJ+SrtUc9E8rO0z/l?=
 =?us-ascii?Q?Dlke3eB6ruxsd9Cfms5YSI9EQTKGhxVmeRJU53rn9Ey4iIt27hmT1bnEKekm?=
 =?us-ascii?Q?q2+NzRSnz15HSAhcSVubecVR9kN/CDKUNQlrY0xk1wOOH1CGKBj38h4c7ozv?=
 =?us-ascii?Q?ya689ArT/F58A/YtRI/YqcLJeqvWP55jMfad1TDEiDNr21Vf8+fev7o3vaST?=
 =?us-ascii?Q?CiCcQFjTXaudUlHtBp2bndq8TcUhM8da8ln28xhe9BiVG6m0NqlIv/3ERd7K?=
 =?us-ascii?Q?dA+6c05FFde11Iv60C0rLvP2trqPmm7Ea3t3elZoTO6gwT0Y23F5LPDaxOfX?=
 =?us-ascii?Q?qQJaplO/RpKAG8MQOc/oxmJIVLUh3GE+CNOLgA9ywmlhIj4+Y2ZblsBlyP+1?=
 =?us-ascii?Q?aoIltOdln+2jGuap6B2E3eajlqncNovlTs8zsxf30YRf3T7XJFBF6+Lg1/Qg?=
 =?us-ascii?Q?OUL+0stHMipN8xAZ2Ldg8Aj4A+MEu+DpdWtSTlh5PldeD/aXLgbg1YuZkNq8?=
 =?us-ascii?Q?IQYVY+MJK8FCe1JF8TxMkEreob1rf9sa45OM6qqCW+NbePNVb/hKpYjAHnRN?=
 =?us-ascii?Q?miZrc2oFENK6aG4XN3jW7cWXrQ8wRmJl04oZqnPBomh+9JwRTRiy8tIX/iJG?=
 =?us-ascii?Q?Zv5if0ullSP8bbrOv832gXv8tZttl8qmbX3QH4narTQuBkE5+6f6PhdBcoZ3?=
 =?us-ascii?Q?vPKkgrjIoY0V+Uy5L5pcr2sALCeFHjol7guAMHpoMXWcMpxZtC7eBGfGFJqB?=
 =?us-ascii?Q?ovgW63CcfATvfY+rFTP6xRjRDEAto11lEuJ+vciiNuxiDw0DAghMkmTqMZOi?=
 =?us-ascii?Q?4aJjjP2zCg3tG+/OlXqSwtaL7jmOEBMUXPdSNw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-685f7.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 953bb17e-b09a-438c-1b24-08dbf1d4ba83
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 18:46:57.3089
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
 drivers/ptp/ptp_clockmatrix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index d069b6e451ef..21f3a2c179f5 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -2165,7 +2165,7 @@ static int configure_channel_pll(struct idtcm_channel *channel)
 
 /*
  * Compensate for the PTP DCO input-to-output delay.
- * This delay is 18 FOD cycles.
+ * This delay is 20 FOD cycles + 8ns.
  */
 static u32 idtcm_get_dco_delay(struct idtcm_channel *channel)
 {
@@ -2196,7 +2196,7 @@ static u32 idtcm_get_dco_delay(struct idtcm_channel *channel)
 	fodFreq = (u32)div_u64(m, n);
 
 	if (fodFreq >= 500000000)
-		return (u32)div_u64(18 * (u64)NSEC_PER_SEC, fodFreq);
+		return (u32)div_u64(20 * (u64)NSEC_PER_SEC, fodFreq) + 8;
 
 	return 0;
 }
-- 
2.39.2

