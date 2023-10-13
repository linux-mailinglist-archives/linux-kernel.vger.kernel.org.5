Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67A17C9018
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjJMWKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMWKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:10:04 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2069.outbound.protection.outlook.com [40.92.74.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1B7B7;
        Fri, 13 Oct 2023 15:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9e0JATCYSvdRtCqlQ+GJtj1XLZw4wPDO/T3sKoDRSMfkGtrdjWNB6WnboPV3LvdKfUz412LdZFecjdliTJxrtqmCCw8n49dJrAUEvVkzl1nFUoPfR6pJfRPRQGqZmJRlKLmHB2KekfVKiKmEr1dy//CwFbFEM/sJoJ9CbejqHjNpPYhITDuo25vMBzF+XqmQod2ihJsi2ZR2NV2xHbO1XjnWQbldanbYVgcr/gq6NAnVFzvqnWUZ6xV00NlH/OOQCfFa90fMfqMfHzeY/Zmjk6JrIWeZq8ycj2iKyEHeBJLM7vMtA1rvZET1F7tNGpqtuGXwCvUXwVB/ZvM6LfNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfzy6YZliDadRRADfCMeLp6TW8OkXv9z/cPaPhlEtpI=;
 b=YCpvpmoo1vAM5fB2iEEO+/Ix3UT1LDYHszVUe0Kbza7vb8E9Bjv8CdY4l/4ANYmLMy0r6hQwOweSynVjlF2Y66qzDQkLtT8VPWXsBTwjneDa+GZvTdXnU1WBef+h3Qbkgq7EZ2R17occijPesJvMiEDpEDv87CYddXd80iuQLtvMxbAx4yDI62vkD2jrtvgokmkRS6S7Pebhs/vyRHCBvPUD7b1iq0xwXEyG+Jxz8CvdctnDDZRSHK+DxiKk9SsHSbELKXbCf65cQQaZFVcoCI1R/Xpcf8TB8CTLuu3IQG1LEfBcVRCCG3JFxy9PwWb5pVtfiXUkrVErgw1D2H+ZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AS8PR02MB8341.eurprd02.prod.outlook.com (2603:10a6:20b:521::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 22:10:00 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 22:10:00 +0000
Date:   Fri, 13 Oct 2023 23:09:57 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 0/7] Brainboxes serial cards additions/fixes
Message-ID: <DU0PR02MB7899BAA0D2FD8853D93F99C8C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [FyzpsQhDEd4fRNSW3pKCct0FPoyVb9Iq]
X-ClientProxiedBy: LO6P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::20) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZSnANWBikozgqroU@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AS8PR02MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: a06f4a76-2a34-4e3f-65de-08dbcc39247d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHwOomcBybaWhDmOOrBdWD6YKxmzUuE/F4LqDFCsgX1zz5GuwHwzzzIFgi0kutDGcpJd1hG9i0ZzzfFlqiRTpcmvbSQGembgjdtjHv6D1pLjE9UaEh40K5+OPA0ti1TmezLxZlpkmmqAdZyLZigVwtjB8K0yWDqpQpWmIIH410UHoZ5tT+r6ASFopr9rrhL8qCVz0WN6sMtksdXxHs+8Ah/JrQNMrOdJnCYgDH/HWzEsuqrJjh5wIc9PsP1Ik4n9Bw8f34xPcTcitOyy2S8rx4mXOFqi6qejjtJebn5w0F0w0/4j93XZQ9WtONksHBO+sZDwx+LhfOnprU/Zg+KpAXEMeJr8VudRmeoeVNfsy+GIM6tTlMws8Nd+8oUBZHamgv5ZtxOXMLfWx+GJh7ePueqbxVC5iELIzNCjbrLlKsmIqzT0SsLImqaZYSBNiXm6sAaim/yPW1tPl0dMPH+/IyUyail7YlbsHldI/lroE5LC+eiRMTJvwPrYiy332kJgAYjxJgn0VPLh9qAavQWv2vsWwgFgcrUw+KMFskt4mvFi1MOOl2z7XwhDg/bWJKtOS+O3VD8og3hJmaHcykIz9A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VWz4o1b9i5+l1LVHezkM0JzUR5XRA6Y4wruCTOhx1h1NNrc/ODYVtZSWrVpy?=
 =?us-ascii?Q?26WhhjNN9eQMemSNrq7Sq2ToH8rpLBU0hA3CZBG+jjs2eurRxx+Uyx8jYj9H?=
 =?us-ascii?Q?9u9XfBhiC6zg9odSbsL/KDW1YwMPFKB7cLePaD6sytyMbXWeb3pZBfNBW+/A?=
 =?us-ascii?Q?gHjWTTjbUspPkcvzItOBWW1Sy/jAbMcT1P4G0NQYToPJ67YXv5JuK8hmYul7?=
 =?us-ascii?Q?5m8A8AUpqobDSkwCKp8tddASjT0lBFt222mW6xRZATeTUwzjuEZlSzCRBUsJ?=
 =?us-ascii?Q?8p/DlzSggzm85CpHiV3Z69YGAc+lTHXSuKqLtMjNbRqW7VidEZK0gevNf8yy?=
 =?us-ascii?Q?EptF5LJiVEXoVNuAj6TqO5O1OQ/eAPJ8QNO+nhOW1Repmw65ITnL164ZgLWX?=
 =?us-ascii?Q?0ZPoBizrCXib1/5xjK0wY3JCK0UaHxD9TQAsYxFyOSiYxUkIdwR+yBVLw6ck?=
 =?us-ascii?Q?lKU1CKQBto/Lf41NrGBsMQ7UtOU2Vuk+WgquEbL3SOTOl7/F2bZhBZNpatfS?=
 =?us-ascii?Q?64nGA5TmdVmbHlA81blHu/KWXJTEcbolsR6RVgIq97CfaeFjM1JpD/u+zY9d?=
 =?us-ascii?Q?VNGPPeWYvHI5q/BM9Nw79cTGz26Y1GY10yGc8k4isP3MI4aMv6zYnet8d9ew?=
 =?us-ascii?Q?xZ98FGZ81T44G3MDcXrfG3kr8GJFw6pCOBvPOPCsHXUkNIOB3iq8YsDU3r1p?=
 =?us-ascii?Q?w/W5gnxMz6Quu0Hj5gzvVvtXkbtSvWuBoo40q8ndjPBT3bDE0fU4lFMVeznk?=
 =?us-ascii?Q?tWtFVc/9+5T6kKImSCw55DTRyd/lspRlPQ2+j7hMQ02YRe6+wZpLYPhIx4Td?=
 =?us-ascii?Q?XLRawD3FNOEbgnSDBRRgjTZIOhyLPayvGdQg63iOgCywZhmxPHQcu/a7gU8R?=
 =?us-ascii?Q?fus4UnMB4M+WwgkJhcrbG5mKlOTP3JYZSrfchhEHRk3/xEfKOv1+Oa5F1yTS?=
 =?us-ascii?Q?RIGhapIvJLpip5JKn48gN8+aCNVZ9Th05in4XCdHtnzPqkELO8VKHt+SFq18?=
 =?us-ascii?Q?WqfyFa0igJDzX8Xn4MOxzEgtbO/3IyJ9Bpev8fptI4BUGx0iw9TMXJ7RsVOz?=
 =?us-ascii?Q?JN7Be96UvNbziKyT8hSuBXK1CrQPL1HCbfZu/EDT6sq+OcO6urNRAnB3p8CT?=
 =?us-ascii?Q?plWrk8jJr3jJOarv9k2ZxruVO8yjDVerOXpJM4AkV+T1xE0+jHCHRGF8SA+V?=
 =?us-ascii?Q?hZtkxqOovtl2/4AZX5T87FkyIy6Rnp2hCJUy5A=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bcc80.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a06f4a76-2a34-4e3f-65de-08dbcc39247d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 22:10:00.5409
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

This series adds and fixes the Brainboxes PCI/e range of serial cards,
adding any missing production card IDs and fixing any bugs, mainly with
the Oxford Semiconductor based PX cards.

Change from v1 [1][2][3][4]:
- Split the patch into multiple commits for one subsystem/maintainer
rather than a large series for multiple subsystems.
[1] https://lore.kernel.org/all/DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/all/DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[3] https://lore.kernel.org/all/DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[4] https://lore.kernel.org/all/DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/

Cameron Williams (7):
  tty: 8250: Fix IS-200 PCI ID comment
  tty: 8250: Add support for additional Brainboxes UC cards
  tty: 8250: Add support for Brainboxes UP cards
  tty: 8250: Add support for Intashield IS-100
  tty: 8250: Add support for and fix up additional Brainboxes PX cards
  tty: 8250: Add support for Intashield IX cards
  tty: 8250: Add Brainboxes Oxford Semiconductor-based quirks

 drivers/tty/serial/8250/8250_pci.c | 330 ++++++++++++++++++++++++++++-
 1 file changed, 321 insertions(+), 9 deletions(-)

-- 
2.42.0

