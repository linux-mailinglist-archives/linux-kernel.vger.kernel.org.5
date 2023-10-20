Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802FD7D1386
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377895AbjJTQEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377860AbjJTQEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:04:50 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2089.outbound.protection.outlook.com [40.92.58.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FC3D8;
        Fri, 20 Oct 2023 09:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNpdL38jqfsQLIHWcR7D5U4X63bb4alYR1DtaYjrkEw+c+JBPCC44ryXSsaNQ44PcVlNL8yDhaICKj3vkzTJr/Ch6EatSig2Se4WLux4xUx0nDZI8q16ZrRNJpB5me+y2ckV1tBN0eqBzP7iIVth+8esQ+SJrZcodaVIslgifvktEcRLG81nZTZDjNHrQL2UYWSaWYiVyfF6VhgH9tCVobJLMn3o9ARuFLPye4G8OENGmfZ+15diXhkuh2VgwNVgJ5XlP5JeA3hIrwlRL0D0/xiFRPw2pLVUho3ozFeIT0wrzbENI4Arry63YuQEh30poaXiKjH4W1u29hNwDTVc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuS9cjJzEGfcLKVQ2Gi0b8BQ6oIDdeyzIN4dWzPwyzE=;
 b=hzMfu7DqkVw4dyCu/E2SKoKHTxvV3UwgTI5M8gfDeROyxAnQrRFY8MqLFJak/VOXq9ApqfiTJzf20jQyMdCcYlzwX1K6OKwcwbycrPv25WGDoDW+r6Ut+45GsuwT1joYje8tL8eGoKELwVmfgQOOAG3QtEP/ZWZCu/m0v6GXnQuaqkrBtTTHqZGS+m5QsSZvIx9fE0KCwNsL6tHuSkdGG1VlMGF3+1X86W/SdZKY6ajJ4hruBqoW4n6OuBPGpVak+zVUjitlsN+Z8FAQX5zYp74y65HlCf1ATFPTHTcz/1fS3U0b8KxzCZmEp/PtcAvoemeH0UqWp0vxawJvDsLeGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AM9PR02MB6930.eurprd02.prod.outlook.com (2603:10a6:20b:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 16:04:48 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 16:04:48 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>, stable@vger.kernel.org
Subject: [PATCH v4 01/11] tty: 8250: Fix IS-200 PCI ID comment
Date:   Fri, 20 Oct 2023 17:03:07 +0100
Message-ID: <DU0PR02MB78993B6AD85F6550AF6590FBC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020160412.118550-1-cang1@live.co.uk>
References: <BBPatchesV4>
 <20231020160412.118550-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [XygCAdmQTIUEXFPJKL1XxRN+MmcjhJ44]
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231020160412.118550-2-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AM9PR02MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 959ee49d-7e30-4c9d-d962-08dbd18648bd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJXNSqVvM/DsLVX5rBGsnwOFlfweliXoPgnB2U2kbl2V1M3VSsbQPh+TMf6UMlEH7ye26oJABpC/drxwQ+m5w16dGqMh3dzsNKSMUO8eLljvyVO+hPhRpqsfM/XPz0XzC787LCp+yydPxZldbcG0Gcnwi03pYWS3xeSOKZ1mXIoYyseYecjhpO0bjs10Lt1jOvDqCDDkEsjrABviJ1aT1xyz1fljPDa+I+fa/M7IoaVxgUQ+9uvWDqE6X+li9Gko9bGj+qeH4zB/2ONuXKZbTeuyh8Ar6rkxylP/vGyLQLQJIQakedEPlLkYeT4Im9tdlQCAYi/pcAdfKembXEeAG/Bi9sxquF9v3TqPdL8pQhir2jNaShLK4RVqMWoC0YnYgmNIMMtrVyNEqst8TqKCK6wRBaM6leF0Q+w1DrqkTNDd9RBbLaKmbDDOQHjzI30emOSd5FBmLcFs6Ygy1rV/rDu41/WNP0CFkNeiENlyIxzDgNTnx6VZLU/tDoZXVkIZu28QaK+t8JIm34iwus7VY5GZKy0fLkA0tPQWanIXcljaOnXqgoKxBKcFIP1AtCBvUPeHw1VMRqPOTD2g/NkMUzDKbNQzyWRLE9JzfVqe8aRSvsw+4odvmUDhd0BWIPql9e0eQ52Z0a38CO0kWlLNjA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E2Xq7cFxMH+4fP4JbV54TdsoFYVSyZzGCVqxbvNNueIfDOgoxB6lc9XQbwew?=
 =?us-ascii?Q?VA8XYPAUgqTYtiWLJC/ohh5doZk1sYpqPJGpkZ9MKU58gmsbeMr2n+HJlcIc?=
 =?us-ascii?Q?HrMEyelzvpvJkLpHdokoqLyVdHrdJiI5soicx8WN7TcxIBhL1fgSyvDrZM9T?=
 =?us-ascii?Q?2cw6w2tF4zGojqKksIlPFk4gq1/aCvrJfDokwfI6aHs5DX2isfmFDnVNdGHL?=
 =?us-ascii?Q?J+Rt9gaDtAlq7fHnWvXVppWPC1yRsHf7FUw/SptVKClvC9GrEQzezY/kVm5w?=
 =?us-ascii?Q?siACm6kXkxRq3+qlTk2QJdWtuQV8S948R7NXbahKFlz22CCUTMeom9TlHI8y?=
 =?us-ascii?Q?ax/29zeHGCgi3HqxJQWE/ZvSmWq4z8hTZWoBny6M+bIFryd5AFO6zVN/h7Dg?=
 =?us-ascii?Q?vFOwsCggoj5ed3hoXzv6od4sYf3SogvXlNobW+BjeLPJ29r14AZEIYrrB0sV?=
 =?us-ascii?Q?cmYvQfmkKAvQ2mYtQTwrkVz7mC5ZoEKGhEExfI3gnmiMeXVf6pZzkL54G19v?=
 =?us-ascii?Q?qJ0VeBFf1Kf/8++MxTn7uSdWB7istP+Y0/Z51ujdLAfOrpZXr+S1NLA198rX?=
 =?us-ascii?Q?jKOgys6CqAkxpxoij93Vgl/QgNdH0LKPYxXNkgFKfjfXtJOrXD8mi6YmR2z3?=
 =?us-ascii?Q?EFw6lkF/XA/BuX9n/2ggdleXOcGuCEQUk+HgImGd4FPz94FbD3Ys1efp5Dxw?=
 =?us-ascii?Q?x2R4Jnc3oR/e4y0jpePEFgYVtboFajk97Q9yjtJundOSUhdSxC2MnoVx3ZJi?=
 =?us-ascii?Q?o4YJG+7Jo9wxr1HFXs2EWJB+i6gJ6D8kmgJoiOCn6UychemL1VwP1OQCoumJ?=
 =?us-ascii?Q?L00zg8jfO9aKSpHdUbKMkus+EnonAuckpKVzd5dk3ZyZr5T8ENeh1+omZKhu?=
 =?us-ascii?Q?EYLkMWaAQx0YvWIl2LcIBX1AzVzdKcmYocJe8D4PMr3pYg45ys3Mb/PfZ/e+?=
 =?us-ascii?Q?3RUaJ4T1PcslY5aY6hvmZtFsBEelwgTY7avu5KaLU2dE3gv1c+91EmcOOI/Y?=
 =?us-ascii?Q?+/EJzldqwMJUk/sE3m11Rr+g5ip1ImWeFZh95i3UdOxmBngUhcnYO68du0Ia?=
 =?us-ascii?Q?LUi+DKafy/H3wIPVv2cCjuh+5g3cYkkHEDWWXj5JMyY8vYa4Xr4GhyPluylp?=
 =?us-ascii?Q?J5ChQq+evdwCj4ccCsU74F4ciBZkUbOscBBJ2cQqbEjAqPh+Vac1Rq4Ff8TD?=
 =?us-ascii?Q?r5rJFt8gNLhQK/dVCmv1yWrTUGRhLd43brKzkQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 959ee49d-7e30-4c9d-d962-08dbd18648bd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:04:48.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6930
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the PCI comment for the IS-200 card. The PCI ID for the IS-200
is 0x0d80, and the definition used (PCI_DEVICE_ID_INTASHIELD_IS200)
is indeed 0x0d80, clarify that by fixing the comment as its
neighbouring cards are all at 0x0020 offsets.

Fixes: 737c17561fb2 ("[SERIAL] Support for Intashield 2 port PCI serial card")
Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
I argue for fixing this rather than removing due to this patch series (and
the code already in the kernel) referring to the rest of the cards in
the manufacturer's product line by hex ID, makes sense to me to
have the hex IDs all displayed correctly one way or another in the
one driver as the IS-200 and 400 are the only cards to use a definition instead.

v3 - v4:
Added Fixes: and Cc: tag
Added above note for reviewer.

v2 - v3:
Clarify commit message with better explanation of the change.
Re-submit patch series using git send-email to make threading work.

v1 - v2:
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

