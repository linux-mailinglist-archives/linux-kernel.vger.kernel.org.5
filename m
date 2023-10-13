Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1D57C901D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjJMWLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMWLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:11:15 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2105.outbound.protection.outlook.com [40.92.74.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE30BE;
        Fri, 13 Oct 2023 15:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgaImnHjBWVW3gZte+dvrOuQtTBQSDpme0YIT3EeyzU1wA4CpomPEykYkU1qiZEjnhVMacdBkoXETPfGoO3sg/OJWFnXsEYhsdZq/FDOJi4YFbEykgN9hPzNUkyNdicFOGN/xtUvAUBMeddkZ4dciaD08xCNjjTW7YDjQ/bsphghSSaMrPBahKsXY73dFw5u0Lcz+0cgs91xwAVfD2k8/CIdBOfFSDBA2a669uYurfbjnwWwM1C2b9g2s4q6WVMplXSNjLjAeAxioV/glhTHC+ghxVdhvHKzSofUAQmE6tpkzEEa9lDOhW90lJzuSfturrxwBMFIq4yazHzU5E5euQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsAyfEtCGQ51WUY4Rhvj6sY3ym7Olg+cMEnwPPgKMsA=;
 b=MQsQBmIOka3Rd3wCQZdlRLOIXGxx5qcwfpmUqJMPZ6/hbPvw5Dd/F1Pbhvg5xWznr89ujUkwvf3Nbw05d4/Tv8cfQNA6tQIgpTHFsY6phJBKFj1R78TxJluni8ywqBwfaQvNjQmU7GDsniaLsm5em4LCWiquEsvs7uP9V+CtUdPJPPWyAGDXVYd4d43Q8yk7ij5D2i7OMpyINnKP374u1F0fwE52Za+OmJsgkNPtg6ZBAW8frfPXzZBS0ZxiA8Or47tfPaVvAO49a4MoeMzhUDb772LzqjoHeEYZkX0j+Q1O4e29SbLc31uDLpUeOUrpXR9wdau/1tGKvKPmAhL4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AS8PR02MB8341.eurprd02.prod.outlook.com (2603:10a6:20b:521::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 22:11:11 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 22:11:11 +0000
Date:   Fri, 13 Oct 2023 23:11:09 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 1/7] tty: 8250: Fix IS-200 PCI ID comment
Message-ID: <DU0PR02MB7899233A57F6E714C0DD8FF2C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [4TqPu+WZh5uIiQepm5fIwuBIJgrRIC1E]
X-ClientProxiedBy: LO4P123CA0455.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::10) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZSnAfTvsN6zsxpqM@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AS8PR02MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 864bb450-5f1c-4b9c-2166-08dbcc394f12
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzaOaB0jzCuIox9vbgUG7HRVuOjpE3UR6nu7NbdFOkMsiGW81f3FUAXBFINM5J80VgsFTuvzI3TYZQgUXEvtTYO70jOLbW1lhZRYz32HRM9iSlKn70x6AYlXJ3CWd3/Ufx6NbqLbKQ1meo/4lwlMbXEYqGooUfjrjIeTdpl8pzdK+pVMOC3yxWhtrho5O96WiMtnDfG9ezLohV//nO0fQAipjvXLkVgmYFsxdnwxy3AoJZ3qA3Y7gGBT1AIN+d7XQ6LtrTN0rAGE5oTY85+yasStvk/qKy7ajmAzHlVgnaQVkVretCfpooMWzLExVBgvNw0BdamhNeUFJaGkzs9n79AzbC51i2yH8iGACmzd9XrDR7W7W+Dq4L7JOPUvQ8EtDSl4Rtz8Suk0Bx9t7nBt3ROwM26ZmijJ+0dbjhwRuxVc2ddlAwZUava3Z10SuyYWq45GwmJHmFNVBCMRJrOaBydtWNgPPhoMqowwXGnbhxXVFfkJNf+UaX4emKAx6JgD951a5Btbbz15No14bL/0GQ7BuyBzqb3RBHmPFrJKQi58Vm8LQL3UJefm1RqQbCqwWOs0cqllTtkIxvElXtiHMQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1naaEoPunfocYvCPEiS8Qo40bd8A3HBSDP/DTeSeXHTWN/Cnfcj8MxgFvZJ4?=
 =?us-ascii?Q?YkdL81glxh4dn+jbVZX6ato2MxAC5xK+UPZ0qJc80bevZRTD6mef+NUl2Zdv?=
 =?us-ascii?Q?thIx4ZW6ipdJt4XM2bq/Fsr0ZmSSC2t+qcHqkvl67XJfwanMC/ugOCryVHJx?=
 =?us-ascii?Q?/zM4qvEwGkCFoqxs1CP0Z6txO5/QzdFwO9F/QNVClT316gQ66DIv7ypMOV3T?=
 =?us-ascii?Q?bFyc6yOW0bH9+woUxYcIng6jcuQ217Tn11Cr3E0DHsOBwTR0Xd1uZWdrnsK1?=
 =?us-ascii?Q?F0n4+HTFC5utJJpvfO3yQVZCAjmP3+hM79pCyoJPE2yvUr6ihZ4jA26zpUGo?=
 =?us-ascii?Q?GfPUDv1gTyZbGkvAoaH2V1BSC6FLHi/NlGhsJqbXUgPapg3i4qjd+mZ3qOZt?=
 =?us-ascii?Q?aqRpzE7wwor2rhkh4EF2ScRXjrElnImwElLB9YEHn/qe0XWsMNLZ3Nm+T1Vo?=
 =?us-ascii?Q?46ydl74bnbaFRDjeyeT74J/NBvIZhP5rya3EPQmuLbJ8zlMB1atTOusB360S?=
 =?us-ascii?Q?tE4ZcMPEirrR0dQuuTVJyZZwOVlGUggHCeN+uiijJtMweM4YYqMh8rGbh2xN?=
 =?us-ascii?Q?FVCjxFntYnOVYoZnlB78YLHGwl22iaHXfkafa62fA9taTqj9C4k95vPF9MM9?=
 =?us-ascii?Q?2aZz68qPcCHUn31yQGe56yO99rxtrcQ1CMi2HKw3ZhK9cnJgv402VZwczleJ?=
 =?us-ascii?Q?KlVOiDEHoPxDthb3VM7E7vAMZxjzsmqWHn+W4Y35gTnV8PiyMR01yBcY1Mt+?=
 =?us-ascii?Q?fEa9yqMUd3zygsFrQbLuv6Yo10Agtil8k37s+yuMnRZ2vfXJA+cOx1xsy/hL?=
 =?us-ascii?Q?0+maDAxWHrsjBwGHVTeCv+vcNgMz9PSWlCqCyqLnEzCW8I40C+qTo6RVKjZF?=
 =?us-ascii?Q?+W+G/7q8qYwXHScX26ZwIuhfnEVY7ylTjDjZaNw6cIsU3PTBwO2ixfRGID5i?=
 =?us-ascii?Q?exIorqejl4kLDrwikBs8xhZIMLIZqVvcLPXzoNm66UGs4NeM2jLVdv1Aeua2?=
 =?us-ascii?Q?nDUoTcZ3nmsWvHoXiVH0q6t5Cv22JTzRMD9WN1spzBa9nuyrjVMPi8JyQ7b1?=
 =?us-ascii?Q?ONndJamXwOFMwyD2Z54UbZdw8YDzQlUbYxu9OlJFaXOGjJDtRtxoMuK5Rn/q?=
 =?us-ascii?Q?Fu0jF/IG03ALK1992HIrbwoU0Nf6/J9TR1B8NtTvjOgQMD8nvj8aZXK5d4Hx?=
 =?us-ascii?Q?qZdDh53TpEGH/dkF8+U+r9jfbBldsNZNJnjthg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bcc80.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 864bb450-5f1c-4b9c-2166-08dbcc394f12
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 22:11:11.7417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8341
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the PCI comment for the IS-200 card

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
This is a resubmission series for the patch series below. That series
was lots of changes sent to lots of maintainers, this series is just for
the tty/serial/8250 subsystem.

[1] https://lore.kernel.org/all/DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/all/DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[3] https://lore.kernel.org/all/DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[4] https://lore.kernel.org/all/DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/

 drivers/tty/serial/8250/8250_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 62a9bd30b4db..ecb4e9acc70d 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4917,7 +4917,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	 * IntaShield IS-200
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS200,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,	/* 135a.0811 */
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,	/* 135a.0d80 */
 		pbn_b2_2_115200 },
 	/*
 	 * IntaShield IS-400
-- 
2.42.0

