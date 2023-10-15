Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF7F7C9A34
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 19:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjJORMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 13:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJORMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 13:12:19 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2063.outbound.protection.outlook.com [40.92.65.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B7FDA;
        Sun, 15 Oct 2023 10:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDoMC0mpEhCPoRjnIku6NKkwMrO9xVu0kdL86AzR81ehsTLXwNZtthZRpA513YyMAslBI/En3G2aYdXZ9C7Vux7+YVZ6oIKLZwMXkWFl9Q6J+TEDeYXGQ5yIHikhmgcXj3P3kmaIK4GyxqNK62tN2Ch6bbX/a9lrhJbtyACUHtEI/yfQWbrdkrBb3YLEZYHVOVNx4eZtBlQdQ5aNMKfnoZGRVB4sdJFH9QJP2PDPjltQ+t2QOAqFu5+qynzUfwIG+6jX23bxqbj2cIJPfpqULIvMwSqomgWxLVaUVW6YzKCIIRRlqOi9HvzwgA+fO62q7X4vFl/MMXTo9JPIKKueOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vY2ZuoVYYvlArdnUHOrBZdjeRIMRBRGJtZRFJ5X2iOw=;
 b=MFX8lIzXyN2tmiMcSc4znadev8iF5bO7/iX7vHlzIoyOxvZKZPz1h/7PQqISXFP9EnXlN6PSqh5KLnQWghJ+qbhYfckiZ/HEA3UtqfGcH9tx8jBWZwoMirW7JUpmrNaBF/TtP9MDbNoWDhR7F5zdJcMrbDPhmNg9y/r9MJcJYx3qSa0nQiilQHMjRHd+00/8GTdNXuEyagn6d7W6aSAaOSpyGXS/7Ab1wJZv2eOIrOKSotCm1Dc/3wakkh7q39zX+377GRPT+zv5mFbSYgQ1YLI7HKykHu4/ARjQq2HSPywDNPbXeIyBw9Bjrprlrt3rDuQg2FoQfwyjZu7FagNJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by VI1PR02MB6093.eurprd02.prod.outlook.com (2603:10a6:800:18b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Sun, 15 Oct
 2023 17:12:14 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Sun, 15 Oct 2023
 17:12:15 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>
Subject: [PATCH v3 1/7] tty: 8250: Fix IS-200 PCI ID comment
Date:   Sun, 15 Oct 2023 18:10:16 +0100
Message-ID: <DU0PR02MB78991BB41F77731BF0BDD777C4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015171141.3309-1-cang1@live.co.uk>
References: <BBPatchesV3>
 <20231015171141.3309-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [zcD/yFljFcBVqCAL9yQgX/KtAoCL7vB+]
X-ClientProxiedBy: LO4P123CA0066.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::17) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231015171141.3309-2-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|VI1PR02MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f64404-0537-4d5b-1111-08dbcda1e0f5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnbRPfJ6cahFM7Y5FfeJ5H4WGlZRu3nWT4oFWV2AbpoLS2aDUK6BKTdX57P2Lg9oxFy/RyJKb2wTO9KZ3tlO4hzqU2mTYmp0+IFlF5ApOa8n+z9tnbuMxblDljVNplmW4eR+xidv8gKId5kf4grvi+NHEI+ebwUe2cPZnHUet1pfAkCGaVGov2zR7hqu9jo9WoqIk7DsQIMrO5aGP171OqIiGyCTXsMjriDWRllDMCDvIy4kX4WzBfjZX0BQcsgVzb5QqsaIKbV78etY3XytFeIKAOnDcVosZDKvbbxQrhMWogl42UZia4Gd4gLJ9zMApy8bK50Od7I1NsUfCOJ4z96VMGF0Ast7ZpMj50+jb5nBA2vv0gNzqp3qp2mlTKxh6ocaU+Z32jw37WKFdfdlOMYIETd9WFUzVh2YORbOdXrtFyX821H/AFmgBnhxOcSndB13/fL7qhvcBQx/zs4P6vnudb16djtINMR6RapNlS+L4zbS6GrYg0pV3cTeA8zUx4pY/jsPjGnmnV7Wj4H/2y9vkzSbocZoYI6WUHCRqc6x3t4VW6/JKL4yZtoyL/S+d7lPdEP82T0Jk8sl0vtsot+ovht/SqP9RSlBUSQpDznhK0J+09zf0c02+80JCUOX72N2aGpRXX+3Wpxt2EtlTA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9kNLpFTYAyB3I58X4wcObIQfIDVmMBNvRZ2FhDft7iA54Po8VukkiofcV8Xi?=
 =?us-ascii?Q?bGyHNnPpjPOg2RGo1W1My1eYKk4qqh7jD/OiZzn3Nrk+zMC5lqCTK4KeFdxo?=
 =?us-ascii?Q?WtirUxpurZnNmtJ6y09i23y239O4d4kHJ+lSAPn3TlWEMesjDeU/fNJDg+q5?=
 =?us-ascii?Q?IODW+xZQObJh7J9rN+CBym993KCp4nqArfQQaTzGZvSi+Dz969wkw2yz0d3r?=
 =?us-ascii?Q?OXj2ZNKWKle/psUV+q9S9esNn6pIhnVbA32P/Tp3fOBZATFZLxRNhvoJcnhh?=
 =?us-ascii?Q?o4JE1GVODOJ4RTI6MQssZlQOy1iURUzQPk5g5jUs5MM7ceCoV47N8LyB8ZSK?=
 =?us-ascii?Q?DpGsXwCD9Ar9VBx5boarDUXjf83xNvkmSyAUbQg00c0KnxM6EwN3rDE0o9/W?=
 =?us-ascii?Q?V23c2z3SEaIa770HqwQ9NtoU5OzYk1U15vYuhVsHrmrdXvvAOvG14DPfLh+n?=
 =?us-ascii?Q?a9OkY5GEpprjMAbrqo0NAqhBPGfOv4ohsdDXZ7zDMa/7h/c5KE7ckZNADHt6?=
 =?us-ascii?Q?kYigKmrsP9BMQBW2ywORNv8TE7kP2LS2NQyCHlxFSXqHT1xKZdqb3hTZ2ohA?=
 =?us-ascii?Q?CX7tqMmkVsNaH2RWhExTvn55Ys2Ev1CRferCKzywJds+jxW36YrovcRt1OOD?=
 =?us-ascii?Q?0q3aGWC3mbH2S9tTSpjiebkdRWS0630yKwPP0Su+ZE84NVCzsCUgWw4k7Ndy?=
 =?us-ascii?Q?sQGyUU3lYYmy7IW+8v0cRe48LZnoY/LU59ZEPoXQt5tFEC43uJ+N+b4xW+gA?=
 =?us-ascii?Q?wxZyDuuFJhG8kdVEVo7Lah7LZe9P7J/2GQV2OUmZRj+On27oLY/9laqGIT0g?=
 =?us-ascii?Q?m2myNrEdfLJS+SLmqgnLjBT2T9inUl5jHIPCVjpBepMdrrjcV/rMKMKCCUQF?=
 =?us-ascii?Q?sUC5bS1AJGMEklUgEMyonYW5S5NVjFO0uUwyqg8ntObyiDihCZNaWzVMGDZT?=
 =?us-ascii?Q?Mxjb1CGtg7J94nac+aphNyEFOxQnNwhsUmGSVYns8j2P9Hjx+3PswbZ6ZHec?=
 =?us-ascii?Q?1EN3VGR9HOooOuCymQiXGXcN1+2poZdtZlm3HzS9fnTkY9HNBpIX08JjGhpB?=
 =?us-ascii?Q?efzhdF7qCK0c2PeOZqmWWe6X8ga4HEraFS1fDCB2zMHw9oe5aArob4vbKpAv?=
 =?us-ascii?Q?iYUSm/PLDawK9jV1Vze+QObIw7daWMM1CcJhq2b2rSWEi5Jvkyt6KhUTbq8y?=
 =?us-ascii?Q?MT8Zz6Sd+7LiGdOYa6ev/RKX0sbRiL4tiPwdYg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f64404-0537-4d5b-1111-08dbcda1e0f5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 17:12:15.3206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6093
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the PCI comment for the IS-200 card. The PCI ID for the IS-200
is 0x0d80, and the definition used (PCI_DEVICE_ID_INTASHIELD_IS200)
is indeed 0x0d80, clarify that by fixing the comment as its
neighbouring cards are all at 0x0020 offsets.

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
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

