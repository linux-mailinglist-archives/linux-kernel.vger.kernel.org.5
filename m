Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84BF7F27D0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjKUIqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjKUIqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:46:46 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B768BD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:46:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHLjfZphRJ+AKHb0p9XW9uuOF+j7ObEK9fYoJO2APwbNu9XfspyvgvtEZ1b9pVcy8PsPgbPcUj6Hfs0Y/lHtojf78ZPTsSQAsKpF2/A9NtHAPYZuu7EQACd/mdis1z7vl2JimdKoi7eIkZ3HkfgqOlsszmmK2WK+g6yz3cv+OKb3l7ynzfujlu+OaNKSIQMRrdu1ofNJ2VRFKIKwYiptwkr8M2GnjfkzZWYWv8YEYuukbgvQGkmsTPKxsqmQUqDwCh9+Z7s/IKhpgz6TUw5rCUOGQtMvuq6HYwbBQLxqogGhjMWm7xxN6EyyhDBhGrO+r31qljD0cKA2r4TNDS7F0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaqQTlkIaJaCsKu2tp3KzrgrAGDXof2uu+Eep6sGojU=;
 b=GzHHOlG+l2iSAmMBXlfKoHCw/1mpOlfDtEQEjABKvk/oTs2E9xozFUc+nNbGCnAhtd9SEQXjCZNcYcwBVIpLeyBn0cufhvvnSsxVKiNsV/fBJPnigt5iTX6tN29qrbdd4+qXpIdC8b7dolyx+EPjpgx+CoipYlfcUtfIGKsitwGkztxYcRbUNxpoNrfKChwsxMD1V3gwQHSioJUvMDG1O+AHaJ4f5PHxZFl3ffxl+SdzfpTAqkxW5rgC/5gPAgqZoxdwukU57U+5ys4fxmQrmODMSCpG1LRUvIMUWQc8LuOb4dDUW4/52Wn0IfaSeQbUqYddz+4cikLWh6BMF7Lo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaqQTlkIaJaCsKu2tp3KzrgrAGDXof2uu+Eep6sGojU=;
 b=QQYDIQaplwqf7PEJ/J5tAp0sfReONv317FiqFsp1sduMv0+r6wYHVbKXCDndN4zDCWdAsEr7v4rqfcsQVjyYdjLgACvZCuHbD2LR/FRIpXU56FY6x9BlrRMaxtyOHNWoMJY0qhoufYAmHH32U0qAJ+sUnM4Qo5wQ5hoen83yVRxjZRtSINhXH97zBu401/iTcQ9BTH5Vd5YF8lNmKpIqo1vI4ps55M4gGDOOcaAK6mp4EY9aIseld9kCE+6kh1uPEJaz0frA2FxJ3d4rkez50x/PuIEEPTqiJncdV91xZd7frK/lGUcKP2e0z1yrqZgpqLcG+o7BIoABZuN/iYPMdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS2PR06MB3509.apcprd06.prod.outlook.com (2603:1096:300:67::17)
 by TYZPR06MB4127.apcprd06.prod.outlook.com (2603:1096:400:6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 08:46:36 +0000
Received: from PS2PR06MB3509.apcprd06.prod.outlook.com
 ([fe80::863b:f0a1:3066:24d]) by PS2PR06MB3509.apcprd06.prod.outlook.com
 ([fe80::863b:f0a1:3066:24d%6]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 08:46:36 +0000
From:   Wu Bo <bo.wu@vivo.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wu Bo <wubo.oduw@gmail.com>, Wu Bo <bo.wu@vivo.com>
Subject: [PATCH 0/2] dm verity: fix FEC stuck during lower dm suspend
Date:   Tue, 21 Nov 2023 01:55:27 -0700
Message-Id: <cover.1700555778.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PS2PR06MB3509.apcprd06.prod.outlook.com
 (2603:1096:300:67::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS2PR06MB3509:EE_|TYZPR06MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: dcaa383b-1135-4ffa-e623-08dbea6e5e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GeGJy0+o1qIUTlH0oZVJYnvmYqNVqN92CMgyLzAEq5Z8fJluPhi0Qo1steBwUXgxiq2xm02/IUig/pkN1HkQXqVIDKlOXbX6SrFSZbf/PgPtGiyoxUSRCa0X5ne3lO7rlddGycaE3bto7Ai9rFM9NFVR0ByCqZP99Extmd8qRXx69I56cMlpfxntgEFK2XYj5DUU0kNmqMM32oyIvfodpknzoGWeBWdVZB6s/W8H4PWjUJhhvet53QZIu0tciapXxBG+dK4iPjEjMnZ9ZaKvKK2PQ4qNiar5Az1NL7GquoIRK8LbhwYTnwU+09nbmOkHTHjXVUeU82c1b1rf70GG9VoTuANqiKlSm9ct/c3ns3NWd6uyaQ/zzw8xD1s7VRaVOYi7Q2EFR34wPQoK1w77cEq5eh0yW1r5Wc4YoF9hKbpd+8cqWXM6gMgOA9+xlDYpNxdn1c6NvTu/THq1JLptGEoKVlVVnW0XVa/xBuMf3p+z+IAywysZYqtden0xm5onoFjzY2JhJvSplOUT+DdgyAkmEhbjNr+fU+LHYpT4PK5B8RaQWIij1aOH6KAwOEy/Z/Zymw2rjPa6RCyo5Kre7VAlGcsLIlYW+zzeU2jMCgCDH9VH5tH2Vi1DV15aKEd3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR06MB3509.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39850400004)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(316002)(110136005)(54906003)(66946007)(66476007)(66556008)(36756003)(52116002)(6512007)(6666004)(6506007)(2616005)(26005)(107886003)(6486002)(478600001)(38350700005)(38100700002)(83380400001)(86362001)(2906002)(4744005)(5660300002)(8936002)(4326008)(8676002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Je89Ud2RFmGYQ8bOjO8JyxgRrY/OW05Muz7w2VpPMiNGpMw2a6B9/ioRdshl?=
 =?us-ascii?Q?dRhSI8s30PejM/3bcOdc8LqwSCBy1ZMQxlcKzWc+da21KulBgbfxAAERK9uU?=
 =?us-ascii?Q?S+y0Q02xEmcJQFth6E3iB6ZXGcadfCIdMoakI2801/W9AjfJD7I+J84GPcTx?=
 =?us-ascii?Q?z8eD3rtHG4FDWAwKYPZtbZCytE0PjKNmzqqJezCBepl2h4Tem1Z9I1hmWWJ/?=
 =?us-ascii?Q?7ZnlUvoO10fRiZYb86rmdHkKtQJ82A9h9WcV+C+vYaalBYmCGm911whS+kLc?=
 =?us-ascii?Q?C9zg4Loag60uGUKTFBX4P4Xt46mNE3N9NzJrVdf7aOjhpkBwQxtxrnMrdo4A?=
 =?us-ascii?Q?dkqwzJRJVWno3GrZh/rWK7ov6m102nE0+kEBssyItnt6+xWWxl4tmgjE3NMD?=
 =?us-ascii?Q?PGuTN+0P3kzrXtvfTEzDkRhpWF7AnTJHe4SJkVg5H7+aHlzu5ipa5g15lvaH?=
 =?us-ascii?Q?56ExMhnzMhurkIa2mP14xGBV81OcT8EHhHGPYzS//iJATZxSS9D4KMB4siCe?=
 =?us-ascii?Q?qJamAJv4xYsAzaNIS65nnh4dnlgoWXW033TKep+3rVNKFz56K5cYy9thOqt7?=
 =?us-ascii?Q?JYwLk/NNJigEv53ti55v7Opy6YVa4JiNuJRevuQ1rNHCpD6KKKvv+fF4JTEv?=
 =?us-ascii?Q?+5WwCRtFsZmuRynNN8uuVvQJQuhlS/P8zCIvxA7OSYKIM6TJEVDy5DXwLaI1?=
 =?us-ascii?Q?p7BbPHkHjge0X8w94+hVPXgcvQDYuQA7gjrt73GChrLM5uv3Mlq2seYDZLsf?=
 =?us-ascii?Q?UWcWVqESSjQI1hMAtZjAywxyD0SX5VCXaUaS9RJnwqGUqnLMf1pWCeHUJ270?=
 =?us-ascii?Q?p9cEW1RSosLfIy4jIhpue8vOlPEEL3SyYgP/vWdWuXMaYykOnkcsiQ4RlLbd?=
 =?us-ascii?Q?hCNmtQIG9CGOVZZx9mR2uwT8oqGZagZvk2OmJh+eX1OYxSprfqrAPQuuxK1P?=
 =?us-ascii?Q?MN3pJ3d0IS64ArO+M5rclNrp8Rw16zrnXmvf//Re6Zu6BNHDmskqmjIN7Ipu?=
 =?us-ascii?Q?DoTpIn/u9d9mRyfXA6DmRP+/jmcYFugAIyKlazzNqJcJwhQIVz5+grT2pu6D?=
 =?us-ascii?Q?wmL3wI2B0DMQAkHYVTh6a2ZOJRzXUbVC6cigLUYaneC5gVnRhnlLiEdJDWMU?=
 =?us-ascii?Q?GSM6M2NBuoPz+TfXxSf04KFm9aqNyQ6HPNFSZUGJBX1Y/YxnXQ61lT5IoZhz?=
 =?us-ascii?Q?sNNCXiMnh3hmPsL++0H+Ui4pKWrMEXOlrVcVCXFVl4JJ9Kt5DpQgibVljyqn?=
 =?us-ascii?Q?6dLmY3+j0vNm29d/THF/rqNLYug1ts23MwlC3ho+mpXO/PJrXvQMTCh1Modw?=
 =?us-ascii?Q?uDyTJHI0XONTEzYt+skeF2QEQ0eNFLA7RX/4xeOgg2i1L4EmWHPzPseq+05O?=
 =?us-ascii?Q?RXEWQKMi0mMaSFhlf0jmKoBHUIw89M79ztTv42wCEWqgoFKl43e7HHtBrwsb?=
 =?us-ascii?Q?ZthuDIZOaOYNibPp17xOZPPsWr7VjJ+Fhby9N8ky87vS7O13Pi8xjzkEgkcL?=
 =?us-ascii?Q?SSTvWujUHUfXeDZomEBx1Q0zwmq5CkIGc3wZWp7PNPlejoTrR8KtZbudrxQ2?=
 =?us-ascii?Q?UTdRikyKUQA9XfBhueQGDPfWJ42KRI4LUcUqbFg8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcaa383b-1135-4ffa-e623-08dbea6e5e68
X-MS-Exchange-CrossTenant-AuthSource: PS2PR06MB3509.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 08:46:36.5129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G19+tr77f/oJjeQLnDU3ObApVc0T3fb2PH2kPi/K4+OvWcf4zJLNOc7u/p1qPBgzGAbuWzadllIQeSp/RdIJzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We found an issue under Android OTA scenario that many readahead BIOs have
to do FEC and caused system stuck. These 2 patches try to fix this issue.

Thanks

Wu Bo (2):
  dm verity: init fec io before cleaning it
  dm verity: don't verity if readahead failed

 drivers/md/dm-verity-target.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.25.1

