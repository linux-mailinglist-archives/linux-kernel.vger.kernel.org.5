Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86C27F3C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbjKVDnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVDnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:43:01 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2113.outbound.protection.outlook.com [40.107.117.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DC518E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:42:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqjAyQ3Z8OsDGCVE32Qx3dQLmGoO6Sds6vU1uF+UTij6mwNrvfr6A/+P6/QC+MUARCvT/ztXeeMoInw8p0BK2HvdsTLoXTTzSbPxkf7VEC7fJ0NYEnBs1Sn1FGZzglP0ulbmNuUAYN7gDjzKR9dvkP36cPcW1U2glJwzx6Y60MUIg6otUTlKN0P60DT0MElfTotf5EnEVC1ODcpStM9o4JcEuflXV1S5Q98BWG7qI7MDnMv9gdVXe6u/XCtwIts57ovdt0XMb2BD6uV7RAOBrnf24vZUlDrUvPuHjzMQs3mL+Ere7JOLqgEdaH4DH+eAU8gSuCC3vDcLo+gmTOa6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krSYVEZ1urv78MrZTPe7aKwLhVd7BQF9SttC/bBfuMc=;
 b=W7nFNRBsDvsUHyBRFGbbcJcs4y9/sQ5jcLu38KwS+Gd7vqCJl5ndMlMf36udIyulbIb7INqraehDwmtitE80VQR0/pnWZX6gdGEtrKWe1dquImsaYvkHF3SThfrUm1z1TcUe3MDws95uf/63PJWTLzc0c2iCoqDizUfbZnNuZ7aoC1dljQ42P6TX8donMZqaycV5xMpvDy6MBYR4ITUo3aC/1ZmxuP6g7hFfvFyWf21PFu4fQwh1anGIyXGLfRPBF4Ru3U2NAntutcawpjSOJT5l9QRsuLewCVjaqBPWWHVyLxIshuT4Lk1hSYBGSV9bEc7JCPQ79b7zhL1xhcZdRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krSYVEZ1urv78MrZTPe7aKwLhVd7BQF9SttC/bBfuMc=;
 b=TCxF9zuirJaF49dVN0w8tSt6ZdGqKdVuE/nmmHWl/yaQs9FjxlZSlhaL0WHMK7+/ARMucDJZ+HyQ+lb9JxROlzTV2Nb3zj32RzEZVSCstzF8JP+/LUW9U3jQgJfo9RseSvJTTJn/0mNwct28m9vU92hhKL5T8HusN05fF522rswdRCIvb/mv2yZsmoarGTB/5L6vAKtbDDVIMwe+1/rxd7GjuTcwQfrqwPyYIDk8ixHiIpaK5+5Q9BsoFNh6gGJj/CDZxGB5wLBRejwZBwUAyeJFbkasLZl9QfXicfgZMZLOCgvZNyH4LK2NrNkQGry4l32ATMYPlvsKGW/VHzL/gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS2PR06MB3509.apcprd06.prod.outlook.com (2603:1096:300:67::17)
 by KL1PR0601MB3891.apcprd06.prod.outlook.com (2603:1096:820:2a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 03:42:49 +0000
Received: from PS2PR06MB3509.apcprd06.prod.outlook.com
 ([fe80::863b:f0a1:3066:24d]) by PS2PR06MB3509.apcprd06.prod.outlook.com
 ([fe80::863b:f0a1:3066:24d%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 03:42:49 +0000
From:   Wu Bo <bo.wu@vivo.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wu Bo <wubo.oduw@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>, Wu Bo <bo.wu@vivo.com>
Subject: [PATCH v2 0/2] dm verity: fix FEC stuck during lower dm suspend
Date:   Tue, 21 Nov 2023 20:51:48 -0700
Message-Id: <cover.1700623691.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 PS2PR06MB3509.apcprd06.prod.outlook.com (2603:1096:300:67::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS2PR06MB3509:EE_|KL1PR0601MB3891:EE_
X-MS-Office365-Filtering-Correlation-Id: 2461ea5d-d017-43a0-5f38-08dbeb0d1862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRUzUadnYDD4Z9o7LXUfaikCJV4thvwTbWfgKZBbwUWueaE1aGeOz/SDW4QjvTNhP4oGIsJFPDikCcfBEz78gLm1j8XD0BpLd8cb3WK690HR5HzvDgfc+Qi93kaFyGPlueFIUG33dGREZUjtUrH1vMXaug5oaw3gAmMuSc+vRyj0Bs/NFk6zsedi6f+2ksPyjAGD6sIV116u/6pPdGcjex9Uz16UkvfqtDED82UVBV+XAUkGYm+gXXQ3lTGW8Jmw0EHuxaweFkJmxEDOr/C94Fb57ONGFQbu9wE3iPACMTcqK+tqJHUMcnHO7a9KHl5RpRNapJtFRc7c3HpB7t5Q5QAzzn/2NtlV1uMpJnNz5NkZrJa4IwabSe3Edu3L97TWGur4KH18GIFDbufGtBKtdArWBUtQQbrRczcYsWqNmrYawl0e41+pv6E6Tciyhqk33eV8z3Tjbugxoha0Xr5Hdsjbg1Iz7CJ1jT92wbg2yUVNRXpCbsnLDudDuxVjgYffA2osyg9shPZZKGWMOgjpfaeZjoerhRSAiUFXj6HtxSw7WKKjxkfq2fkN6gLiBUO6dUxUjn0jfcZBlHHtALSMgXH9vO3ZJHaWwa7RWg38dVZcJ8FZaZi40B89iVNqw2Yw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR06MB3509.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(38100700002)(5660300002)(4744005)(2906002)(86362001)(38350700005)(52116002)(6506007)(6512007)(36756003)(478600001)(6486002)(83380400001)(2616005)(26005)(107886003)(54906003)(316002)(66556008)(110136005)(66946007)(4326008)(66476007)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KhQ3D+v8LsJgFru8Ju+2D6kR0bA+R5Tknu8j/al7z8tK8vRUaYA6ioyrf7Xh?=
 =?us-ascii?Q?sRatW1oeninPDkzuIsQCbRA1W1VcGc5u9mAor1Wra3epx0AmSOblUI2+XBD6?=
 =?us-ascii?Q?6gIXrByaQG/fOZw7zjfdwoj3NMB3K7IQJlY83Z7s855LOAmnlmZ0pK/k3Hst?=
 =?us-ascii?Q?Y+cAIgKFa/hfG+x/1QVomceVZA/up5g9acTulu6LgBL/x27zl0xeZuoeQebX?=
 =?us-ascii?Q?Lw5YQxWJ2rs0iIzaHuvFVrWXl7UUCcys8H6MRD8qdWk1CIU25lIHvhCPFo08?=
 =?us-ascii?Q?gkvuNTLD7cpS4FpVkWNGk1v71K17A15Qsr+Qb8p3JwmSHCrMVYMvjRhrX2cu?=
 =?us-ascii?Q?GynSXcx89cRmGg973ea2NeyGTxknolHGngiFzSptnP+TJKzR5WXCvVenrt2d?=
 =?us-ascii?Q?ZiGRAgiHlV7pppR41lBTx6iMVVr7AMBUzjgthkEluc1+dn2mhwfQPjE50wYQ?=
 =?us-ascii?Q?TswVxJ0jJx1q478NvMbEqDlUpyDMG6p86tYRmarh3Z4kJLnT8wcEHd7W0CI5?=
 =?us-ascii?Q?Vv+SmyrYXvE3KBDSBvybIjkt532qqfzVNMlp1xLsEdQkMV+vGMNczKUo/2EQ?=
 =?us-ascii?Q?HMSwiydVn8BRGLi6z0KyP1TTS0XuHFuxK5UYyBJyprUtHuG1eX/CfyS6uCeT?=
 =?us-ascii?Q?1zaGe3Fpru7V2H5jtPln6roNVd+6Jwt6rn/hSJZoMsw+T35X9zFBhc7lOPzU?=
 =?us-ascii?Q?yAgI+YwTadpfe75pkknJj6R2tATD6m7Yj5FmE/kFKhcSZkqyqzhrK11kCjGQ?=
 =?us-ascii?Q?c+fImBMZaRHU8faAD8OYtv6ulMBqFjRs3suAZc/xIDP0INw6pR3mJkpv6Ao1?=
 =?us-ascii?Q?jtnOqFlbx6Slida46nji9lGU01xQoWKnQPpFHsWeRpp96OksOJbODXxOFRaP?=
 =?us-ascii?Q?nE/Onek2JWTKIovAAcyHVQqSeooWqogsrtX9lZcSfOcTpkPM+dEEpRSWej72?=
 =?us-ascii?Q?GLeR9SdZzfUXmEGS12q+IWXrr0DyXQoKClQ1GPELREvECAy0PxpHRDJIMKCt?=
 =?us-ascii?Q?8eYgsWEwmOVuO1bukfA7+uuUEFaSUwN4vxBZ5eyZ9LgLotEWqQKjIxvJO02k?=
 =?us-ascii?Q?zUpHTYVPBalpWAvtBLkjxetp/hDLqYcGUC1E3tPIzmvnHF3LEOfKIdFZtt/9?=
 =?us-ascii?Q?j99L5EjxP88lqk+MVw0+TNBz4y77d7OzyoipDPAhTFNk54CqlKYvIgExx3lM?=
 =?us-ascii?Q?zGYfn4S1rs88DfPKTs5dDe/XAdHRFGLxAH2j2RelQYfDMgijYnT/7NDh1M7S?=
 =?us-ascii?Q?o1Q9zVRJEMKwGmCvcsmJAv/OUFGhifR6zlZutDJwLrvmhnDFAofHaLKk0M0G?=
 =?us-ascii?Q?cIogfv6iJKMEDvvByVV1ohtt/mz0SCwqDqwD/fY4/4cMsS/Z32j9aVCgFDv5?=
 =?us-ascii?Q?IcWB/7TR9FAtyoi8akD7tcH8vQs68ET9LL2O5qnMmMQJ6HORMuTSelyW5TW0?=
 =?us-ascii?Q?r7pEXr5DfL3AoF9p+CkhuBa4pzrAQH1A2QP4vxCg0TdC/Et3cY9XYRquiLeL?=
 =?us-ascii?Q?fmSl8uYMZ8GpGP+hWplL1iY1gXa5q6PUwvJu06/ZL5z3QInfvFxc50enzFgi?=
 =?us-ascii?Q?kcmCw90VWSGDVLOhQvYvjEvpzAw3O3oOEthjIlmZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2461ea5d-d017-43a0-5f38-08dbeb0d1862
X-MS-Exchange-CrossTenant-AuthSource: PS2PR06MB3509.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 03:42:48.3106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqcFZolT+1RC7a5oA37+wO3KvvwLBe5LG+HqQ5sBuepiidYz75/LA0+M1o4F6+yZDuoTgR6feQczOUHk9LMzVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Changes from v1:
1. Modify patch1 as Eric suggested
2. Add "Fixes" and "Cc stable" tags

Wu Bo (2):
  dm verity: init fec io before cleaning it
  dm verity: don't verity if readahead failed

 drivers/md/dm-verity-target.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.25.1

