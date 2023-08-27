Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5657478A393
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjH0X6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjH0X6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:58:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2037.outbound.protection.outlook.com [40.92.40.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19087F5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsDGNn5odTcVtW+y7TXE0cidJa/M97YUBdb49YHGM6lptmCsClD5AfvljunYX0oROcW7XvtSCnexBA75Embd5bsz5/XMa426muGe09rzBB8GnkXhNt+yNfWuPJK5gDzp4s7XvRBqzs9w8wM8T3ZzgauMrNAb39xjCuagnUeJ4bRVN29DkESw8g+FfCEkM4HDRvwts5N553wEZ+EPgJYJM7mWiLt2KwhbYP16fCfnZ9eqIIZDVVlLdQzPOkHn7ebVrNFLZP+S1jKrffHCxOuN23s7Lz2EF2EUsC7NlL37rJwBDeL8K7R9aF4MLtkRPMWAgOOORm9QiSh0bkPR5S27Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqdka8bWEbnAv27B7szEebmkrbgLt1SEVBzxCJS5ik4=;
 b=mnA2xRrqxIXw7sJcBEI3A6EkhSk1BfzjtYm0Aisqfbb9TgAH6tLxy7bZpEVHLEcZVi8rQRV5pnWX2IeTAiN+2IYr976LzxazZHAvIG/13LvFlkW1p4dVhKyMGzaDQJMhZNU5l0vbrvL+4H02iX9QBKk9qOxIu5OcgA1Vl8QlUhNfBZnW6H79KBFD/NdM/0mtxgW6qdf2U6eEFwB9bJ5opUTiYE41n01DNt7LwYvKv2QXkGFkS4TshQ9snTkxwTVgHmoebsteGemkY6QfCMGcrJXv5DvfFhdEwZH6mNOtVLOlY5CwzhjUvTKL4SXAxKF02zycXRmnUceMA1jrRzUAlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqdka8bWEbnAv27B7szEebmkrbgLt1SEVBzxCJS5ik4=;
 b=XRLi9XqGlIMqcmxIjII/5TIliaJA8SnlDeItO+ZFh3y63rmm9ZKREcTUQQfzkbcA1OK1h8GGgxwWHMcxHu1pk14giki4jDbL3Ugm1hOMa3UJMG8AspVHOJqETBBGSD3MQ/u59llQe2UqeRLzzOi7tfSrxRfU7WdpXK1IK1G7VH8AMcqUptqbDUl61WL8tinlm/nl7t9AsHjblOn6Rei3ahlxuP01VIeDYi7+OkjpmL0ZdEe/+xcvApttjn7tpiR282sqkcHLmTqNaxYlYzG7GjgRFV0cpVur5M4yfWnLoxTkcsFkAxlScX4p2m2TjovIL1st6RnOzOUwtoinJjo8TQ==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by BL3PR11MB6505.namprd11.prod.outlook.com (2603:10b6:208:38c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 23:58:28 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 23:58:28 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v3 0/6] staging: octeon: clean up the octeon ethernet driver
Date:   Sun, 27 Aug 2023 19:58:16 -0400
Message-ID: <PH7PR11MB76434E13489C9713CB562A74BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [u+6zHc0ZjcuLe7/ZLZ9TNm/IMEz5D/7ixHx3EZmjFPDMdQGff/S9S+jWVNHvHaVl]
X-ClientProxiedBy: MN2PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:208:d4::31) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <cover.1693180346.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|BL3PR11MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: 83894d15-a831-4578-ab24-08dba75981f3
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrTVQo2E8YhiYZbimk9QHlfee0RmoCxeVKGkhSSrBoyA/LsWV8U2uKITkXuBrAL1OIpJ25JdEAJQv+F2Nq9+HOUjst8j7mTR043PXEAugVgFzqx4ODumQ7OFd6aqwJvBIYFeqr8P4FIiyPK07fczYKAMHKHA8pfmuvFvBKfV5BldZfTyHrWtT1cQ3o1znb0eOltvRAJP8YtNlMfV8tcgE+oGEHd/id8Red019p+3fkcgFN5HTpbdZh7l7hzPZa7BY6iu+oZTKuQ5395OGmq5XlDf8KDXrtnjA0SVdV2nT0ImwT0zkwg9pBWeBX+sSFz3JyGkz5wqEDi38tDolzAb8Cnqeu/UjAoCDZHI8vvdxhVZ9aGYOy9LtAJMvaBhQWVi4Ixk4VT//prLke6SVzFoiUPXM6W9Dm9yz6Q+AwUi3PKqDnEx7RVfblb3X/deXddVmujiv4iRBUJHvszCQsuUfiDsJXAx6lZgV2pSbbtYZKIP0LLoaxF5IeBqH1yGC5laQf0p2k7aaeWLCnwxg0Q2+/sFCbrs5NS9lb0Ay3/0yfVuQtrrLyB49l1sOG8ryCBAaS8mTwnX40LKhCVM4lj9t0aX1L4sod4Ko5VpLsMXVeQoOCS3agIKdIm7RMPEzGEyFraZtoXv50rCcIjDU/06FXs/1hMCMBx+BWiJmL2uzIVR57oADUykNsA8XCdRYHnD7Qh9t0fpEWJkRWAEF6RfNieDRWApDnORw6TQ/8RqKwBBGIKAH+5g6wXoj+KqV8n7aY=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TJPhCxzyuhM8DVAKwa0+UA5vcnz+4STWgNOLRukJWGXAF4B4whOXXGOxSeKaNW3iWy03K6eMnhrTGjgyq04avAk6A+LbDQagDQFhCh6yAL5a5e3/1oQ4EfYP8n+FZgNGEOGjsSiNjdiTkyPDhFzZGvE4cuL8g1bUEihOycuGAUBYlFWTTX38dD7v61tKAizmQyD5Hntw/oDNut/k3uys6keCzMnUMy9E9NFRJmGVYCKGihbgZRgqoSMPzVL7D09QBni2VqMtDmDy9VMHm1dAX+T7E63ry31nMkoRR3j/aDZUEWrVNjUHsfbLGAsrpbegQnZvL5/X6J6JyaGQ3TaI2IwZ4oLMQblfP23HS21mMihfWitDZKAHjpKcKkmQ5MVcjglalJnhBEB7qxK8m3D9q65gjd/mRoUCs1lGdkdySIyR3/+AGdkBtjAhRSOm6p9VhuB8raEdrb8viLwNalXe4PWSRxB0NB20I88kVUm3FxeLQMWu/C1I6NOZdipa7XfnhB+DMrlhL+7eY1Wevvwy2U/hUTq1Kq1ApZgrpNWmmPHcF8/eSHQuMWPrC37eqYl04xvREiHh9tiQCSiQjmjU3+x9PMFDs4Dr4NiUme+DN16VCZlPxW0nI0SXnPAHLLg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lxoY7nXWfcdAmeuAsaTBwZIkSorGpowzOmPkK4wSSBBIxjCKjMsPHjYGSrOC?=
 =?us-ascii?Q?tdOHn0XmLfqkocOWFyqa9oDjDdB5p/83uZgAU89xULb0U/i2VqUbdEfKU3dn?=
 =?us-ascii?Q?S0R46G890YSVN/7C3qvNgXLpdqvbcgBvdqqUd1nokDEIfFQUqnqlxVzqS64q?=
 =?us-ascii?Q?cpuqVFvT3Qcf2WlIo3hn5e4wxTTUUznO5TkH7dV3lWu7v8H0Vhp+kYahmQza?=
 =?us-ascii?Q?xZXZjcCLoPuM4VZf0DFlAuouA8xWYgsytZtmcf6JemcNgUIzZFjncX8gejCc?=
 =?us-ascii?Q?G2EAVBB6A0t6pLcWutnknLukI6N/YghZUjl2zM71BYRq+XajprbS1fnFJmlj?=
 =?us-ascii?Q?Yh1DiJwy1wRUs/kCThCVcCST9JbGtM61HwdrrLvX/E1uJ/IuYGOGMScpeuor?=
 =?us-ascii?Q?4J1OsgJO4rfdYoNsY8TmVn7yuiYp2ygwgVm3Bj6XDYz+50BuT0UKMGbWbAjW?=
 =?us-ascii?Q?4plx+vByTt6m55rZea4OotKUhf65bVU5VWAjCpVeltxxXHQJUEEUWonbrs/r?=
 =?us-ascii?Q?hN6XXAtPUGKRLn7PBT8meDOtSAYlP/jqgQpxqws0EVg+FoSLwOAGEHsL9qM/?=
 =?us-ascii?Q?LYI4bc3tPl05Uf2bN3+KJvcf931RY4Gug8/WdZt6T1flF+pggJtEd/CCXWqo?=
 =?us-ascii?Q?4+tcGjIg1BfE5zIJLINZLSyZJTbLMZCZ0j1hMFR08iBs60OGhhE1tI8Ck7b9?=
 =?us-ascii?Q?lGruOTcXTJkihK164LKWJO9e2TgFfNoFmP7dqQHvZMH5pdFBLQhhuB4u42ly?=
 =?us-ascii?Q?e9W3X+2N0wFR75NlBWD1c0pZeA1WOURn+a3RshtmveDRythsXLCSgIMmrrm5?=
 =?us-ascii?Q?VTHpmkB0w8dYiDqdcdeHnEVyXuuQYKgKn5NBPgX9BdtH2tRBHJDtU+JJN6wF?=
 =?us-ascii?Q?PbukO1eiJd5LwwgXIexpDrcP20gij5uhe+ukuoOzDuOeJom/2HNtkC8Ng+M3?=
 =?us-ascii?Q?YQDjzdkA2YupRqrz6i9dA/o1aUgjt6qkYytztxUjC2WHydxzoyh5rJaurits?=
 =?us-ascii?Q?jdSa/RiR4Gld9dlE2/oepjxFZ7epjuCTZ25MZQPXzJviWsiprHBCH5tXbkO0?=
 =?us-ascii?Q?tryvQHCoFqgvcNGP5zAZTcYIyzJCCld0VkYJ/Cidj71ysbymfKYPeBvAcnxU?=
 =?us-ascii?Q?V7Z7q9bSZs7c913eN/GUyCDTj57W+SxN7nRt5DZo0RLXgZvcycP/c1boEtCY?=
 =?us-ascii?Q?TXbJnoCEykfF2Uu3DTo7osW6m4Y2NbwK850e0znMdNox2zlaCAHZVSCemnMT?=
 =?us-ascii?Q?SnkfZOTgQMPYNi4t/f31hfDTVDRzrvAhUm6AdKWsAA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 83894d15-a831-4578-ab24-08dba75981f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 23:58:28.0508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6505
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the octeon ethernet driver better adhere to the
kernel coding standards

Oliver Crumrine (6):
  staging: octeon: clean up the octeon ethernet driver
  staging: octeon: clean up the octeon ethernet driver
  staging: octeon: clean up the octeon ethernet driver
  staging: octeon: clean up the octeon ethernet driver
  staging: octeon: clean up the octeon ethernet driver
  staging: octeon: clean up the octeon ethernet driver

 drivers/staging/octeon/ethernet.c     |  4 +--
 drivers/staging/octeon/octeon-stubs.h | 44 +++++++++++++--------------
 2 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.39.3

