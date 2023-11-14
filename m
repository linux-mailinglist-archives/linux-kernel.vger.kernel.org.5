Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09627EB143
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjKNN4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjKNN4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:56:14 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2026.outbound.protection.outlook.com [40.92.52.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DAD1B5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:56:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORh/aFr1hMaZBRnhMGCKr5A2S9vXp/1iF3Le9bSRaNkAmcUyTELWUnTzZ1y3z6cbZrRApv6kLrPHN/txdN+JlWJDsvpsKTTWdvJpQI6APtxMW8aFUQvX6iLruJkYNVrCY2fiJuStpFAnfvSY8PD8w1YTonl7cU/EGxJJ+OpjeRajmpGjrdtuBTTf5TCYMPLFXMJ9WDVyS+mgPxcJu1xUBPRrR4dIvjKTzXGrg0qE6A0RYP+u7GaUUr6PMvqB/8QSuE5ODFG04U/AOvhMFRPDB8VQy9hZgJMSXQlqpZDIBmr1vw1BYLaQTUPs/krKWjscKDRTugyqsiQylIV9uv6FWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3XhF9Xcs4nnvrWoTqPueCiZpomgxMwqpo4wTIiXmwI=;
 b=Nn+MRm6ow38te/EixTsBco02owaFNIcyqPP/cua75cTdzyEGPpjyT3DOWizk4ggRyp4GNHTQLU2jmYxdzMDM6Y3U4vAQHcHtQZHHWXFjmgc0DpAj2i/6JlJS46VkSO6yg5xSuQUIsGUuR6ryf1bf0Q1hBL7ZyO18LRCGbVKdRwIxcxi8n1q03q8UdbR8kUM5o54qSGHkBnjm4e6RHmEGMG+ii6Jgrfj9eoxCaPpVgIuL4/yvj/Obg/qip10FDTN+F4zcI2NGJ5IW2/Xf+mZN8SR+uduKUK6QJlwqfPAQLR0GzCBs4b0kGI9HseJMUmDyOEszFBqnkRWD8tSl8wH3jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3XhF9Xcs4nnvrWoTqPueCiZpomgxMwqpo4wTIiXmwI=;
 b=GYiTi+qrX0tmenPuafFZnHeChBQDCQjqAHwcGaFdvv/wX2AI6SEQDmywjTn2iNgnnv5CTbauQJYpm7fm61It7+Fuedo3QmdmMLmfpbTF7UWLJgJkEzbNN07b8EKZKkM2tt3FRXgWGXX+YZxAlycU89/dB1900sNdPU2nt0FMAklapKeaHBASoXJ7MWGf12fBjGcceNKW2tr6esz3zq+J2ad843+ZneqghUyQWgcf8e5g3J0VJC04g5a5JJuJPK4MEqk8khWIjfLhcEKyW5i0RhFck+OypBiTG5pt2k/Vd4vyIIZPR8a71s8N8Wq8zBLJc34Gawu10kEcB13Fosb8hg==
Received: from TYSPR04MB7084.apcprd04.prod.outlook.com (2603:1096:400:47a::10)
 by PUZPR04MB6915.apcprd04.prod.outlook.com (2603:1096:301:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 13:56:06 +0000
Received: from TYSPR04MB7084.apcprd04.prod.outlook.com
 ([fe80::8f70:a575:732a:ecc3]) by TYSPR04MB7084.apcprd04.prod.outlook.com
 ([fe80::8f70:a575:732a:ecc3%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 13:56:06 +0000
From:   Enlin Mu <enlin.mu@outlook.com>
To:     catalin.marinas@arm.com, will@kernel.org, enlin.mu@unisoc.com,
        enlinmu@gmail.com, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: remove kaslr-seed node when it had used
Date:   Tue, 14 Nov 2023 21:55:51 +0800
Message-ID: <TYSPR04MB7084AFDB414AA7AE49A02D608AB2A@TYSPR04MB7084.apcprd04.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [9FNBAc1B5B9I6B0xVHWDYkqmtgbdhp+P]
X-ClientProxiedBy: TY2PR01CA0010.jpnprd01.prod.outlook.com
 (2603:1096:404:a::22) To TYSPR04MB7084.apcprd04.prod.outlook.com
 (2603:1096:400:47a::10)
X-Microsoft-Original-Message-ID: <20231114135551.9402-1-enlin.mu@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR04MB7084:EE_|PUZPR04MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e5559a-c1d1-4cc0-2f67-08dbe5197217
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHAV6pBaS5gfIAWHd0FBVlVFBNdPaZKpChlH0D49eRxK+dPhELLYoGKemDFUsLdallf9nDsHCvhv9d8q/Fe5ewwASJxEGTUSp2j019xWxTaV3eF3vt25MpgoVP5AC2LJHiz/Zh9UQ+y28653Mdvh+p99fVfrhO/MNNviYWS0xbsi46DigtHHuVrliWX3MpEEGd0aKENFgZqONgoR5uWSO/fD6mvmj9O1aNAFZlXdZ7DTi1mYZTKFikgkwqA4YsG4Y7lKB4hv22IKf2S1mvB4+NkuVZSRsB22t2G7wqiW/WmCJBp0D/O3MFfBFlfCNwiVJh3Wz4nN2jUFopm7+JEs5ryH2axxo+g/RxkFGhmcRRMwCit3ugz9Ky5RWLOIcSnzhiGQNQDfvsWcZTMDn2jlHwZfbwJeZNVApYjZd/fWsn+7rN+fGAf2IxnXQGqTQ8UAbl5WZZEfsvUqCpbjg7dTmJ5GLwEQ5W7ky4lW0/tXNluUe0NhAp5BmS3HEEX90GD1k9U5X4jdfeizrD0C+hD0UAK3iYNBEurLalmZQ6+hoID5FIfnez1Ol6rqPvTwx6aI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rk3D/PZMbIdXnrk/JHyjyr0aVuylWUGhQBD+eWy48o/DsM9saSpSM5PYbLEb?=
 =?us-ascii?Q?QrlHDh6jVvy9F32C+YfUXd1wlM0xu6+e5o1zZ1P88PZE3ml+kNt4M8GCXr42?=
 =?us-ascii?Q?HzHTsGs8vDVONxnVQ6M68J1rPauKf4TaIejxt3cGnH5YFQZ3FBBNd+CZqyC2?=
 =?us-ascii?Q?xZaGvQYQHadiuD0fsCdGto/HVJT5luX1TYaGWC9jZBQU/xNQumlQF6xCrR0a?=
 =?us-ascii?Q?CQl9RJ4+ZZtpuvp3pGrG/6V02FaEQ0K32zPihid1qynPmMuhegfuAvnMAnZb?=
 =?us-ascii?Q?ogYMExprEfAsFnAFvgL7BvqStDKdgzx9uRzqrXZ1XRbjGwk4nkIkrfIrWNr1?=
 =?us-ascii?Q?6QbwRamFYKvJMW8XSYbQLE32RodCzuBSPZvNqxQGdzLKED/syWGWWl1XeOMB?=
 =?us-ascii?Q?17EVXMCdFShDIwfaDm1AHNE6yF+H2avUvu4mmGEE/zBGAzvIiNwp5VAcsP29?=
 =?us-ascii?Q?vwKlIN7adPWa6SaYKKLkM+aDdotgz9W4G6rhWl9yDUHHjBLryMtLapHF+3Zm?=
 =?us-ascii?Q?8nYVgRHvovm5x+RaG9xjG1d1E7uLA7dUefDY6L3jqUEm0muK8SGkepIwLuYy?=
 =?us-ascii?Q?00TeMa6upERAoZhqvJhfyPDJT/j1DH6hHFmnJzTOfFVs+OfqTRWX4arVzh03?=
 =?us-ascii?Q?c+/q4+H7X1SbJ7tUaZQzwh6chTUJnWxvKYEvyh8NuFn32QmCn/o+r8mr0nZq?=
 =?us-ascii?Q?CRD/hAOgwv0h3rasZjINPKz0RI0qzxhPYHXmvqWdQ6+Dx6EBojLrsMgLWBWg?=
 =?us-ascii?Q?3NEXgyzOhllGAGxeNguQPKurpfJByFkRq4EZApH2Ny0yHmtUjCs1lQjSn8qx?=
 =?us-ascii?Q?SVWdPQsXiAURrL+kE4kqW0kRm1C0Mw7nYOp0a26WQuAfxXJ8vsnEV7NerdRf?=
 =?us-ascii?Q?E4NpMBDaop0NkmPuF4pJjB8WeQDtVSirVnkhabWI2f7GzojV1fY3takcoqt8?=
 =?us-ascii?Q?SpEVr5RuAauqFFFSWgMm/0vJ/Y+vI+qoVr7J7BtBtVSHCYMRzNV74Zwk4ek1?=
 =?us-ascii?Q?D2wca8d0QuMLeEjaTHDJU18qdEPlzjHG4sl6VR9Y3kX/d0l4SQ1XS1tgmG5y?=
 =?us-ascii?Q?a2HDWaJJWPF4gra7UwWcg1ZkSWW2DOVEOG1TbiYo9L1ySPqn5CHt8bcgjTjO?=
 =?us-ascii?Q?d2yUuDkNDOjwD19qs7InhL2F/s0sh8jNXkEbWpzALeIAVPyjQ3JuxrIy8Pzl?=
 =?us-ascii?Q?dY6KbVBR4q2tcEzvDGGtdqDzorZDTyBeoWwnkNSlTNM2YRm9A2Qke0UgvZes?=
 =?us-ascii?Q?fOlLlfLDPuuJAk9dtYUU?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e5559a-c1d1-4cc0-2f67-08dbe5197217
X-MS-Exchange-CrossTenant-AuthSource: TYSPR04MB7084.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 13:56:05.8688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enlin Mu <enlin.mu@unisoc.com>

If this node value is zero,it means that kaslr is enabled.
Removing it for the system safe,nobody knows if this feature is
enable or not.

Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
---
 arch/arm64/kernel/pi/kaslr_early.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
index 17bff6e399e4..bc35d4ed84b7 100644
--- a/arch/arm64/kernel/pi/kaslr_early.c
+++ b/arch/arm64/kernel/pi/kaslr_early.c
@@ -81,7 +81,7 @@ static u64 get_kaslr_seed(void *fdt)
 		return 0;
 
 	ret = fdt64_to_cpu(*prop);
-	*prop = 0;
+	fdt_nop_property(fdt, node, "kaslr-seed");
 	return ret;
 }
 
-- 
2.25.1

