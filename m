Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8E87B4A9C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 03:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjJBB5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 21:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjJBB5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 21:57:23 -0400
Received: from outbound.mail.protection.outlook.com (mail-sgaapc01on2055.outbound.protection.outlook.com [40.107.215.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A15C6;
        Sun,  1 Oct 2023 18:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReV2dhXlvgcd8vJ+TtK8rUGITciJIYJsyD0fr1ngWwOLifY6rWARGUo6IggfOBKnRU8anshxtbglg92pyZuFCU+DuHBVWlN6MkWeDYRmQSHbWwiWXzvIb2Ve/8fPFqTv7QtOoO+w/Fy5zRkeNs5X77tiMmQHVLou4fO1j0+Cx+wzD6G+RuctnJZtw//SUMEKEmE/ZzLnMK8XWjzNyK9p4PYDdeJuLL6cEWjltiN9oqks7ZaE8GxvQSEx2QaVOKmz3DvIzITKsExXe9w9SvZ1AhVxPyo8EPJnJiLGYmmtq7fPQSJhBsFTW9cWCjUWed5ynR1Ela4/gsK3eDCy+/gGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjtDVOiN12rjaqjQ36GIcwBHiAVvi2op+aD45Xn2tW8=;
 b=b7UOif09GA248gAk2i64r2rcoDivcsyuBcNCRW0/rA2I5Pe2MbhTbFpafWpYebyKQyciedUiBVkXDfmXlNWhnEe0jW4VMQMwSOc7qxSx34kPlAuj73LNbV9+P8I+IghQu371k8M4VnfFkZHp07faTtYThr1PHT4+Pgl6KBfeysrUS9xASpS4Evr2kdCe+JTbhYT4uNOLo+HpufJxvAB8cbMLOrGg/LDBbRf9PUlqVQS0VYkBAhkZoi5RRw3Cmh1s3PKCXmGYEWznYSxV9U50tBb7WEc8azk2P880qOaDOMmx5jFyHm9GFpetLoyKOIr9YI2SSLAftC1ZeksbvK/iew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjtDVOiN12rjaqjQ36GIcwBHiAVvi2op+aD45Xn2tW8=;
 b=XgTwBJ6SxIFG851g8hZPykYZCN4UKM902kkO/WAXY5kuE1EBSgMC05BX8gw/0HatxocesVOeRAX2Y1aKF9C0hYq4FdN/ms2g1M13SkUT1r2m8FuNxMFtIbStjYJjGZVC1ZiwzF11FnUEhFvYp/aex0WER83j4Kkz558ns+UpAsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TY0PR0101MB4788.apcprd01.prod.exchangelabs.com
 (2603:1096:400:279::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 01:57:16 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 01:57:16 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH 0/4] tty: serial: 8250: Changes of MOXA PCIe boards in 8250_pci.c 
Date:   Mon,  2 Oct 2023 09:56:58 +0800
Message-Id: <20231002015702.30509-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PS2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:300:5c::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TY0PR0101MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b4c1f3a-7a61-4cd0-1f29-08dbc2eae6fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTwEeG4ujHjJFuNL4tXkigNlZHV9ofsx/XTypVYvAIHm9zk8eQiqK3F9fSYFDJDK5CGwP28+xEInN/Y20JHJDbPJAMTNWYdGR9W4QqkmWbFVro3GIkuENGDzecAR28oLyEZ4Lqq7i2ziaEnx5RHWg9FIervlLSntnuTFaAy9MalCFi+sNgU2LqiqQ0ETzLF5pN2sgitvG3CbtV1IznIvviGv1KyYfJl4PyZf0ugkf67wY/TmOoitxc9/KZpzy1OLauQiQwc/e2yihGfnPN//Mzq/WQ0NyUcS+wC8zicI/3QJItIcIicaVzyQE7eZ3w5jy93Lr1aW129SIdqIRf8DH2ib9l+dkWZMOKFCBbqcg4+3EdTaP0DsqMWiSJ6lfmkQ6/kNgv7syyteCkzruFTkL+pk++iLP6y+wtobUUt8RhOERKRzfuhk8CnELRRQdaoP2inV/vpsbhXXK9tUyiyEf8ArPq93w01yhTJW/A+eYHNAJznCF6BPf3H54kjERq3WdmOFHm7QVFPLMPrXTBrG5y7wgGozUx+KULh1aADdulcpETM/7Gxmco5DDwEgeh4YWtonqtq5mFf+OvP6VpQxcdO3N/bAQ5nLp8deeAeY8CoWtPT35+AVKdyK4D3bgpph
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(366004)(136003)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(4743002)(2616005)(107886003)(1076003)(26005)(38100700002)(86362001)(36756003)(38350700002)(83380400001)(316002)(4326008)(8676002)(5660300002)(41300700001)(8936002)(66476007)(66556008)(66946007)(4744005)(2906002)(6506007)(6666004)(52116002)(6512007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kWSWzLxTdDNuczAnaX58CqD33jTNyaCm7tVw2YPNXOYdZshKoxfdJT462JKi?=
 =?us-ascii?Q?hNY703IGYNYo/VAVeH38Pu0FZtRd7WA9kUJw+w+Eq0T1wW49XqukH2QBapO/?=
 =?us-ascii?Q?11zljEccGQDzitIeqvK6WwsCGECNcE2zNHFR/7rTXmYVKgh/cyFB2GopPZD3?=
 =?us-ascii?Q?AfwQwG/E0PBytdI0PWhQEpZb/kRmMaoJO0GF93fbws8NsiGhCmKYbSCevRF8?=
 =?us-ascii?Q?I9Ov9T0Bu4J3rZDk2BtEnWZGdahsqgqITPOVi3pxs3i+KGls1v2HcApEKbrV?=
 =?us-ascii?Q?WwNxnjyYwA8z4iRUQjRPC6b1aLk0gLmVFgLe69y/j9Q8zDYOxcjQwC+tz8ZJ?=
 =?us-ascii?Q?WHzT/yx827ogj876+fWEneGhveS5bFkfCOUAfGsmnCbfSdV6t2+pUWRxewLw?=
 =?us-ascii?Q?UbaJXz04uJh7YPtYPSkCjaZLmRlPkfscgn0XAfWndvyg8Ncr0bXeAaZLT8YV?=
 =?us-ascii?Q?QLfvArDpSKb4qjtBOHUJOud+ZhslL9mYD2OJ+gJ06xVpNQ7iWuSvpgChas3R?=
 =?us-ascii?Q?QPKDpncHOrmfrAh14a0/RHVdTKfSDcXOGcm33v7XgBX3SIbPeZczY6vCeBE4?=
 =?us-ascii?Q?WPxw8eugtik079KXKeSMo7mScWoud6CCeOhJeGLbyOigKdUPpjXYWWHTm+O4?=
 =?us-ascii?Q?gVkI+G6ik6tjVvsKC7rxw9Bl+SEzjL+GKs0QE1my2Kvgn0c/b0+upP8xR6pV?=
 =?us-ascii?Q?YFx9KcXxFId/+pEX3oiVW42+KThRPq4gBvp1Lo3A2gIsHB5TzVLKdeWSXTh3?=
 =?us-ascii?Q?fgZsuMAItmYgSzVw888ktvC5PudovnrXNHKtSoMX7L3N9mqJxQXnTcpJy66x?=
 =?us-ascii?Q?E92Lg2dgk2IZGR9kxXlNh5K2FODDYRZj0VmgrbwhgrRd2IfUZI9skORmxWKD?=
 =?us-ascii?Q?jzPrcoJEBn2kV1yOAjscdcmo2Q/QsFkLdcsI2IeEWT2kZqXKorKVYMn8vQf9?=
 =?us-ascii?Q?Y97jhFo+ThHoHc+Kf9kYXRU8gPRqV+fMudoYaW7x4g+zOCc8pqaMZJKvbpG+?=
 =?us-ascii?Q?n35LuNM25oVLIQoWpTF3kbUblhylcFBBw6ctWRSoh+4/KF9gb7DKOF8iNjh1?=
 =?us-ascii?Q?b8Uav4p7i4HlT/WgLhbaM9SBiEWIWBvy74xwTy1J55MDdCXsC9VToPWkZzVW?=
 =?us-ascii?Q?aKISNfHG8bDSf2qG859MA5rraMT51GnfGAxK40B4baEtLSI51cqJLl+1WMco?=
 =?us-ascii?Q?fRoZ0xzn//aKKDRQBGKk9atWZXRm6IwIe2tZPw9eXsK8xb+W/sKR6fs9xFIJ?=
 =?us-ascii?Q?xaXq75oZfEz86cCIdNMpWZ6VleL46aszly3epfOD3/cSUf7jlJYqCULGOXX1?=
 =?us-ascii?Q?X2l10yS1slm7sY5cIpYwGzLVFzoX7hT8B+vk4rwwu0fJb0BHrZOAAhjepYzF?=
 =?us-ascii?Q?LWV2+Y4PmF1UzvCMrW/JXdXI3+/DY6auTJOWqlO93BF9WFzvfkub/8Nwm7r3?=
 =?us-ascii?Q?PUFTs8ZNXx5zURBRi2G7y0JBEc3vEA+pc8ThpPGVg27V1vhJ2E/q1RuZbU1A?=
 =?us-ascii?Q?uIyrSoDJlXnWk43CXNstsaPP6a6ysfgCybKrnsP+RA3E9JaOLTRfKzmPslK3?=
 =?us-ascii?Q?2CptwrJ8xqud/1it7rC2mjIgg1u1Qv2nLd28hZjyj+HEQr9e/IfEYNcawzb3?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4c1f3a-7a61-4cd0-1f29-08dbc2eae6fc
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 01:57:15.9364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uT5mcn70mX3wijR6TvXYx9TB4eIG8ABsqpEpUvrPcfh5Tj2VoIhiJIHX3zYuxQtomJj+rDxgzNw3KbSo0NeJpgUjdA7TdgfmiN0HByMLAfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4788
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patch series do some changes to MOXA PCIe boards in 8250_pci.c,
including:

- Cleanup MOXA configurations for future maintainability
- Add support for MOXA Mini PCIe boards
- Fix MOXA RS422/RS485 boards not function by default
- Add support for MOXA PCIe boards to switch between different serial
  interfaces

Each patch depends on previous one.

Crescent CY Hsieh (4):
  tty: serial: 8250: Cleanup MOXA configurations in 8250_pci.c
  tty: serial: 8250: Add support for MOXA Mini PCIe boards
  tty: serial: 8250: Fix MOXA RS422/RS485 PCIe boards not work by
    default
  tty: serial: 8250: Add support for MOXA PCIe boards to switch
    interface between RS422/RS485

 drivers/tty/serial/8250/8250_pci.c | 205 ++++++++++++++++++++++-------
 drivers/tty/serial/serial_core.c   |  20 ++-
 include/uapi/linux/serial.h        |   4 +
 3 files changed, 178 insertions(+), 51 deletions(-)

-- 
2.34.1

