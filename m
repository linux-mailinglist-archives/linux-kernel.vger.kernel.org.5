Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6297C9A31
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 19:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjJORML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 13:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJORMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 13:12:09 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2084.outbound.protection.outlook.com [40.92.65.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8043A1;
        Sun, 15 Oct 2023 10:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRTAZdw/egehKQTf1+nMCCKrK+qLtXGxLRP4wJmDU+hEjAG8Ql9DgtrZqmzeQ4guGDfz26CXgD73/cGYRBDa650E4XPJJjWdrpceydnzMfVhRKAlA9J0UMX/ObZVYmtDySHKpvuZD1n8PINdm0gIft4CAVUNuN2JCaBTudlRJyoz+CMi4BXgrMeSo7pYEacnAmNWLtxRkCvDFMki62wE3Qv96BiNtL725xtrVjq3Hr3Xt+wOKC9d9A1H+gK3nt2KsQcdukonkF0v5WG7sCzusXfNUUWZV0EYWdptl4DfdudJqGU4pxzdM8TCjb5s0tXKYCCsmwR6oyisiLv5XhkQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8/KsQqUekhKrDcE+RqxBK2jZGrNr+hngWOUXVLaoWo=;
 b=ZTmaf2HcJSaM3T69jsgpLDAoVHubMakUYYv2thftvgMjT+gvrPV6/eeh5Kw+DBE5odciuiN3IypJZAgZKQoYikO8wbi4xwGX4Vt5HQTZte0WOkkT8IZAwxfJsxKXl6qpCz8qqcMSZliS2/MSncaHLddhguiSf8mtu3wEZIXOvGnAkoS1UaCzNksi9v1KYRXV7+jv0WHC4fjlZqpFb/XOmpy36OpwaLZqi73SHExrlBaywOj+6ZC3B1y9Sc/BOA7Ikkpy6qQnLvpRl4ahnrwlEZ5OXVqILCfhxsIZIIXLayxdYj/j6LcVL/uxJ7gkUpH6C7QkaOJForFy4RKgEDAhjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by VI1PR02MB6093.eurprd02.prod.outlook.com (2603:10a6:800:18b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Sun, 15 Oct
 2023 17:12:04 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Sun, 15 Oct 2023
 17:12:04 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>
Subject: [PATCH v3 0/7] Brainboxes serial cards additions/fixes
Date:   Sun, 15 Oct 2023 18:10:15 +0100
Message-ID: <DU0PR02MB789901A0FD8D0A16614B7B01C4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <BBPatchesV3>
References: <BBPatchesV3>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [AZJUG0XghH28bKjVete8pFDtsutTIBNn]
X-ClientProxiedBy: LO4P123CA0066.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::17) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231015171141.3309-1-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|VI1PR02MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ace2fd-2f9c-4894-d5be-08dbcda1da86
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXSwjT9a5X96BqLsaHtHvgi42WBwzoxrbh7DBLWTPf9dB1+05ApPG8aNotMJBR0Td6w9giwmQSqdMROzRddMexqx+qRKNTiU9ntxnzF1Y8hBOf1FP/K/q0lx/ZhlIpiVvfG2KTHOMqaBz5oLtB3DKbsI+e8KlqKoST/njr+ga8Zd24bRQhBNJ5ep3qwy4M/n+eFE4/9l7rGeI1jyBs2oVGgl0sNlXxGL3bJhAiFM1CvSSBm9PmsmYjAMf1Mg7rTGL3Tr4pFhqEvEEln8tzUXG1Ssc7zJldrFGedIPcm2xxZdyY2Tx/UxTNpzwiTAfN+JzJBykAAmwup6+XdfRWfVdTjHvzZSMVF7rNsSIDkaWuc8AYvjvKZiFDdtsRuF1BkK/6vO60TKRKdew72HNkS2eXo/y12dlkv8Psj7m7CAVQLVGtgCIHlfwcXlVxiomKSS+H5as7S9g4r0yEN+hyUoNk10Ux5YuGooydjlO9HKWPW9ffkAF28wCbca+E1HS+1HJNcUfn7InCDmdsTpANbsE24tqCkFBOPCUuQ5nh99htq+Yo0GlEoZYzPlSkba4trOJairzVcIbj/+p5pPq/X842yBu7/PJkH586fDeEpIaSPx/pWgTo/eJCcB2PbSiyoaHtH5zzvZnxPaJt/VLxYVdg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ipC3nN9nhQK4avj8d6452C3nF95C1E6cyYvA2yzYJ9aifR2I3QwesKroENmo?=
 =?us-ascii?Q?G4HRHUf193oYBCvL64P0dgEIHVGURNsYAWQRaJL37veB6NLlyxcRKB+wwMNN?=
 =?us-ascii?Q?eKzselFz1N/yr4J2jGaA+StOw7jW8KCR1qn4FSZvYVwC+7A1PaP2pxfMpOyF?=
 =?us-ascii?Q?f8E/tebc29Z3smv9J4HD+I1MQs6Kee9dfXxUnfiZzHGASae950eE6vVvIMCd?=
 =?us-ascii?Q?moh8n8R0y5PVcQOtAeI3tkQygQ0C8YkFH3dtKINKv4UJm4PV5JBEu/GZYbMw?=
 =?us-ascii?Q?/Mou00vhhIjGpKwiUQ8UurR5SMuWQQtMo9QIr+FIuy855ucYEb0gc0XeEKfj?=
 =?us-ascii?Q?awaqnyCl+vU2M0dPHaTp7NGu4lq49VflSGn/SkQpsVmTo7s+lXEaFaCFivmM?=
 =?us-ascii?Q?XZJnsxMtM+SMdhPAJEreO9Goct9dmEd/tH7Y/mRIVyGqApTtIMXh6DJ57uQZ?=
 =?us-ascii?Q?oq/2hembWv89+q20KSE418RNfzWiCWgtHRzB3HSYlzWx5xBw5wdcAQ22ZMTl?=
 =?us-ascii?Q?GCCj3EDWQVmlzsZjvLD41+zBjMzWK0NPq1oezHcIIsICOPC9OHolDMx91ZfD?=
 =?us-ascii?Q?m9qdEer+N9yiO/kDPc4/ceYlBHiNeUzO1sAAH3U6WJGQca+XHCs5gdos/ZU0?=
 =?us-ascii?Q?UO9b6Wpit4cqsLnLi37jeFMFDsUZRbP+Wa5U8Q3LIJyeA5D2uXFlazh9eS36?=
 =?us-ascii?Q?zlDHm4rYv54h9KYQqAnvMsSYE8f1PGlYdyRj+ySUd/n6jDyowPpmaR3QYtR0?=
 =?us-ascii?Q?EXggZMzcivLaeNRoQk7SSOxn4+aGZOGDreft0F7u37m2+VKBfdmryFF7LMXR?=
 =?us-ascii?Q?rGFyQh5xvwaOfVW9NqUcC8Zrm9HjuE6VDWpXRBZpQ7E5E5Vo04vzcfePz98M?=
 =?us-ascii?Q?JoHuALSX+EwdEuUqhYZ0E0Qacjpr7sh2/7T29GdGLN+CswpGyUE52tdOp+6j?=
 =?us-ascii?Q?mo5kDXPc7KQ8LzsByMXR6ueWcl61IuvMiPY/B1Aknm4drX1hVarfgutt4iZh?=
 =?us-ascii?Q?QS6EVOG14K04+HD2l1z35Xbr9kKE4B2C9U9K/RJcLcSPoJOWhtvh/vy/4Ebr?=
 =?us-ascii?Q?NAfb6tNGq9H1+H0dEQ/OPX5LtKwWs5lvXtVbN7X9tDIwqHWGoJTVYsbzZuFd?=
 =?us-ascii?Q?SdwUz/Br7G8Ge2afde24ErP90SbgGc3WOZK2sRZ/lOYC+Unp9TGzee8GZbPv?=
 =?us-ascii?Q?viz+LvZDq7tG2GNAM0H9/8lOS8SW7KebNhbKXQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ace2fd-2f9c-4894-d5be-08dbcda1da86
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 17:12:04.5409
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

This series adds and fixes the Brainboxes PCI/e range of serial cards,
adding any missing production card IDs and fixing any bugs, mainly with
the Oxford Semiconductor based PX cards.

Change from v2 [1][2][3][4][5][6][7]:
- No code changes
- Amend patch 1 and 5 commit comment to better clarify what has been
changed and why
- Send using git send-email instead of Mutt so (hopefully) the
threading works OK
[1] https://lore.kernel.org/all/DU0PR02MB7899233A57F6E714C0DD8FF2C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/all/DU0PR02MB7899CE749DADBEEE38564F9DC4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[3] https://lore.kernel.org/all/DU0PR02MB789934AD01F657CD108E0999C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[4] https://lore.kernel.org/all/DU0PR02MB789954113A4F513D4CD65140C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[5] https://lore.kernel.org/all/DU0PR02MB78993B38B6D95DE0A84DA5E8C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[6] https://lore.kernel.org/all/DU0PR02MB789945AC3746E79AF2390C73C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[7] https://lore.kernel.org/all/DU0PR02MB789927949F9C84AACD694F48C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com/

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

