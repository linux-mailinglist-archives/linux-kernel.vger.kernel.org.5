Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020C27FF9D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346730AbjK3Sqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjK3Sqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:46:47 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2081.outbound.protection.outlook.com [40.92.18.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777C210E6;
        Thu, 30 Nov 2023 10:46:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiYFcEa9dZ+Qm+JCwGKstl/U5ImQOfqIgOakfYuaIP01iLYaViGjwn+/CmCkQr/6HlMf2O0O50vAMhpNM/1Vi7nA8QuUmQm7ZX7cyWznkb56i4RU+cBv8hd5H6tTZs3yhLPaJ+ubud5xxB1th3To0dZTRd3RpggFf0BTWMRHRG4QrktyeL3KplSwnbUBhrlZP9+VoL/upwBEsWTekGsmm6BZJjubukyKZORjj2Cx5pMdWN7xJxv41rLimZ29YMMvW8uZbtYVWDfwMYsY4apeMn1p1tFLPUgxsEV5BmfFYqfbLqu3aBT1AJplbjRIvo/jdwS0roM+VhNGoRBZIYqKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CooryLmNa1dj1SA4KgSc3T9KA4dLeGUZnSc6Ztcfzo=;
 b=KDb8X6YK2YYyKar7sPDjY5J5K9yRK7U1E2UurE6rcf86j2Nks6/LkeHmZsZzPZRRMAmeP9vO5BLk7dzMidZMUCf0PVaZZytsrRZF+PTmB/UBA7TgU/WdhN2sxSXoY1SZmB1NqDp5DPbmvOri4V/XHkqY526sMFE2gXlhphntC62QOvj966ue3fTFXAI8GaQ1ZltHySNyRwKuj7rupMqaJaEwYc1YjKaD9L+3mzPwyVYaB9tJbagS5o4if464+Qs+FnCXhbrU/u+zKL/3OEahe/jkQg3w23SORXdvw2TfpmMa6hR/9jbwR4EDm7TLdU2ng6b1gL+RqnfCpQNMhFkfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CooryLmNa1dj1SA4KgSc3T9KA4dLeGUZnSc6Ztcfzo=;
 b=rqr4TBia4f/JgXFp/6Y3f+CXelBiF61O9yZ+X1YMqSHiwCCX3hhRcH/R8fG6NNfxZVCT54u/13EMt3D4uaCHjThLyDfPzw5Bf7hAU3qdmLqDuVuQ8AoQs25cikWIMO87tcyTh020l+Zb5kVqZeOs/022+KVbO3ibZHs9LJsYPM3bsV55OvC/0E1Udx4cuwM1CNOgvugnShfb3dIJ1ruPUVeo+xgWUOBeHdsz2IWoI3DX9X+OFehtfziiJH2E62so+VoU1ZOa0z59x9pF31/89Qmpju6+LFYBf+qi8SpGumyev/HQtfQYeTkHvnr5+pF8wTnCY9YVjaCKhdczf/+e0w==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by SJ0PR03MB6779.namprd03.prod.outlook.com (2603:10b6:a03:40e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 18:46:51 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 18:46:51 +0000
From:   Min Li <lnimi@hotmail.com>
To:     richardcochran@gmail.com, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v6 2/6] ptp: clockmatrix: set write phase timer to 0 when not in PCW mode
Date:   Thu, 30 Nov 2023 13:46:30 -0500
Message-ID: <PH7PR03MB70642B77574635AB8BB7E321A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130184634.22577-1-lnimi@hotmail.com>
References: <20231130184634.22577-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [VWfRdhi9pgAXfe30cFSayPjHIqBz3suH]
X-ClientProxiedBy: YQBPR0101CA0262.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::24) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20231130184634.22577-2-lnimi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|SJ0PR03MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: f7585186-b48d-4ce5-7bc3-08dbf1d4b6fb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nD4PEuLr2PPrvvVIe0lD2A0lKoK5M9giCOcpBM+8QT25kFkyvqxmI8ehXbWnvvTp/EOIPmeWEVRd6dEkgJO4Cn+P5QCbePTT2dF+h8CdBQ4hh0nmPQogqOsJEQJ6aASfc3LVvsNEuQVpGvKWUYvYKgob20iFKn4sYlIh2vIFxzMmR96ToaZ6bS4y/KZMa/cHWt4VBHqc712osoXYUokE6k+mYfyKlMO3vOts2Ak/rt7QIeQVS//p5ydPZLK7KKwYG8lmmL/BfbKNsvInbkDcvKMkaZM/ofCJVXVWDLV6GUV4RdQ1MuEH+ak5cuP9CO15kN9L9MZIn7a1pxU8JINMPipGRPOrX5gRhMAdFS4L/R9C/0fkrou9xtED/d68k1V4dXT9yS2PW1s1VXj8s6n3cle9W0rhBP5ObGxJl2cXisTrNsJEnG1BhhB/TSZXg6XUzFbMlF0HbFGW7Lw/zmSUCMNjlouT7fKVkLP1vOnWoJaygPm18konVaMhgZC2MscpUCtcufv8s2KUMoJ5cz1WUp3CTnIxoGVAq57OaMaVVBUQdFi2Nogujb1XgNZDOJsE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m0dhl6Cb49xDdjrHIKfsCUFbdxGdySomNNMZjK1xtIfHAbeCWRaS0Mc3hyop?=
 =?us-ascii?Q?o+klqi9tCDiY21jA5ZKE0FJ673hPiseT/JWd5/10Snu4B6cdRe+wdHWcUofE?=
 =?us-ascii?Q?UEbEFsCSOwAjxJoKbM3Ii6PikorzwfouZpcr6M40HKJoX8KX/qusG/C9jqlK?=
 =?us-ascii?Q?05MwP0V7YaOcdpCTqFHywTQvmKRyEu+LdW4nWV7TtuOkbUdWo0mfoQa0IA/u?=
 =?us-ascii?Q?m1zRmbavcnkMZ9WlsNZpQimKurkS97GG3kdCaxEQfi4AiFEg4NmD7tnAC3db?=
 =?us-ascii?Q?j3GOFlG9sJYxRwMDlYIA9Sc7VJAbjOg9hS2tmgtHffAJO9t6PdCQZeWt2Ai7?=
 =?us-ascii?Q?dRSd3TG1OnDtDnEFYH8ZqJ86xuhS1sQ178KqQQ6S/y3SyNmJRg5p/iroHveS?=
 =?us-ascii?Q?n/qlA5vCZ2m252imb2M030mLidamJTZGW14SOVI85XRRawCKrxV9s4dj9cqz?=
 =?us-ascii?Q?P6RuTNXd/ww+jt0kHbc5ghgp+3GH0ka+vS3Vr4EWvHHF+8cpUtZkBYmXNmvk?=
 =?us-ascii?Q?lP/vQ6ctWGnleAkfR3qNkU1399dFt67beilU7m1RJeGahq3O4MXYzNaMfVCt?=
 =?us-ascii?Q?BfTKR5MVI2+JsNVVTDvVMK2vdzCgWtnsrx5MNEb+HO88z3/nVlWfMqJ2M3EJ?=
 =?us-ascii?Q?eok9ZDa1ud6xI30UYKkA6quVU94IgfSls97fI5WB7W/r8ryuVZE11JF3T8en?=
 =?us-ascii?Q?ejLHq+U5UzQ0GCbzDvCf2D71GqGYsrtg3iOdzwiDo9LkOoI7ePfYb6uK/qh5?=
 =?us-ascii?Q?IkL05eobDqDKcAInQqhNNiLY1kEpPjCHivml5h8Hs5WHG7gcSoZWMXBJryEq?=
 =?us-ascii?Q?irWyVdpU+6Oqn9WcFCNQTQxN849ykysublf8YQ/E6uHjBBy7MRr7gyNj1nDo?=
 =?us-ascii?Q?TtZ5A9hKyI3p5jzFa/0/vdQGj1ifsreTr1b79iwud1XWrX2Km6QuJgYrWV6e?=
 =?us-ascii?Q?lxbcsOJ7Mm2E9+qQYT7eJi6GPPmBw4k/S+jyIty/5gU0JLpyOWaeNz1xu61P?=
 =?us-ascii?Q?otch8q+CGeRzuEjgQhIkcUOWanMUFTyQBza+mMGPNiVAsA7qRAVVbywrlIz/?=
 =?us-ascii?Q?eVk5+VxgW8Q/+CPrH4G187mEZwIl2hYj95fYQLoMU7UvsTf3qg1UG+rM2RJw?=
 =?us-ascii?Q?nsICAvQ2NPgrO62r8fZSlgY9gUtVRuNE1W1aSYulkeKZkJQPl/4avKt+vrTW?=
 =?us-ascii?Q?1Gxv0Q8Q2jcaGJxjOfYRoyLILUymjKD4vTcb5Q=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-685f7.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f7585186-b48d-4ce5-7bc3-08dbf1d4b6fb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 18:46:51.3963
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

In order for phase pull-in to work, write phase timer shall be 0
when not in write phase mode.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_clockmatrix.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index f8556627befa..6d55da54e496 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -1396,6 +1396,20 @@ static int idtcm_set_pll_mode(struct idtcm_channel *channel,
 	struct idtcm *idtcm = channel->idtcm;
 	int err;
 	u8 dpll_mode;
+	u8 timeout = 0;
+
+	/* Setup WF/WP timer for phase pull-in to work correctly */
+	err = idtcm_write(idtcm, channel->dpll_n, DPLL_WF_TIMER,
+			  &timeout, sizeof(timeout));
+	if (err)
+		return err;
+
+	if (mode == PLL_MODE_WRITE_PHASE)
+		timeout = 160;
+	err = idtcm_write(idtcm, channel->dpll_n, DPLL_WP_TIMER,
+			  &timeout, sizeof(timeout));
+	if (err)
+		return err;
 
 	err = idtcm_read(idtcm, channel->dpll_n,
 			 IDTCM_FW_REG(idtcm->fw_ver, V520, DPLL_MODE),
-- 
2.39.2

