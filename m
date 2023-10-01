Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C817B45DE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjJAIDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbjJAIDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:03:39 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CACCC2;
        Sun,  1 Oct 2023 01:03:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS6eLRFz8VGE4r7OyVwTYCYmb2R7ojOJwkHSdkRgTxNzQmBHR9gs/U4Zwufum1C541PCqgPbsjXN6ut0F3PjdJaqPSFpKFsRJGqcdyzC397UuVYsg/WEyG3UV47gti4yS9pFAax4pXR5Vri7IeXuyFZNnkiTSfNkPSlF6ec/5qhYQsjgzAlLDWCRh2vqNT6/du0y7ZzoIoUgf7rJSRAAVeu8C5zJzaff9GPMfqqV1T7OC05CH5kkpdFL26Lyj2kMngpj31vkyXuKDAdtdtXFlci/Evr7x240czPH8W4Ga3GGuVj2YS5vENpBjZCrzHgeeWuFI8OOxhX3si1C5cjUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usDYAF7/Uio4et+c3RkYZX2RrThASPQaEumJNzznkQ0=;
 b=KMTvDIdyF8L6LvaeAO94jWCD+iA/EOYLWE+DxeuY1zuNUyUDEF7/C4pf6BVLffc7JnsvXnChgeXa5gylAWcG6U9zX9AI+cQiqAHRC+272OeXNpqUljmdXyOxXPK/4Uf8kUKqoRNx5KK4fFKbe1cfQZsPJREMpGteR4Kh8AJmPw9Pt2gYZFQOX0mnerFGEZpdkT7zRJDXN7phNwDDNkreE4FNsepOSEo6LNhMqK6FjvhvkaPS6FsqC0WFh1GS2U5giaBZkswdNx2/kGz2J9j8R4evQnacQEY/s1dVmZMr/ryLep8Jb/cJbqKuMKLMY+XocFo+eTuySSP27/wofJEPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usDYAF7/Uio4et+c3RkYZX2RrThASPQaEumJNzznkQ0=;
 b=rAbAkF8yHBDYGBGyxeDCcW+HzqG5i0SGR2Ti6cm3tDhgj6iJrPP6ZbHM3mRLF0V4i8qSvCXn5NUjVG5X0KFazNnr69mOFLl89FJOKyaVtbrKRi5nAmIoa59/75OM/qz71IRwgvZVdIePh1IMMgMqHq393A3nJqedV8kEjxw7b1OFB8toVaVG3DTJPjfPYvMbc6u6ZKqJFHxIFV6E4mpSzvFQNBfyQHlet55y5RK7c/PRn6N+FkBsUSVPIdBk60rybrUjG2XN192ImRPxD0aD8Ar4SzzZyCynrtG/Aa2VjjK0QCYqhhtSNDrr+/RoSWxaVw4Lc6L84LZTw4TbyESsbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by PA4PR04MB7725.eurprd04.prod.outlook.com (2603:10a6:102:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 08:03:34 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2%4]) with mapi id 15.20.6813.027; Sun, 1 Oct 2023
 08:03:34 +0000
Date:   Sun, 1 Oct 2023 16:03:28 +0800
From:   "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: ignore NULL link key and reject connection
 with the device which has same BD_ADDR
Message-ID: <20231001080328.GA14494@linux-691t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: FR2P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::6) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|PA4PR04MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 0830b3c6-7df8-4bd7-19e6-08dbc254e8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vO4duyr9wFfT+QcWR4xL8mRquBBB6hw4xqdI3HGgGId8FyxmxvqCfkWftl+wC4RSgNfW2hJPos6e4DLdihgfGaWvaKx0is48cEC8i0Rps2VHPwHzzneDBQs84vzRf0+osdHO1IzuKc6Z6m5xtY3JrSu2is2Ht6K3FXBQLxrtBfHPxGMuQRZjITHmcqicpmZqBqLC1MMreycWwjXMwyPeTzwZE8bcNXmQtsDOa1qXbmIWgv1jDKHUVJ8RcUZ5wci02CgKOiDb7JKybOIWvmeuaYryQxzOAR+INUXXGQ7JTdSdQUrBJ2vC0YZLnfN6ZsXFnnLGo9cAXqWk20Dms8Giy2rEkn6XEGVgcPIA+oWxUgearW0YuGEGV2gt//B4rCC45QWg5DqM6ACecTqeCfuF6C5aZd+i9ZuzPEgYCKBtdEneTODLHqs/yD93P7HqrnEfpnvu8HMjRrcA2CstwnLZyp6mgnjq4g3/rgs4VT3DbS3cMXKbIRo4XKb8FuDG9evM6U9c1W6mEfKzxl570w4ew3VUpWVjKrytssujWMMArXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(41300700001)(316002)(26005)(4326008)(2906002)(8936002)(5660300002)(66556008)(8676002)(110136005)(478600001)(966005)(66946007)(66476007)(6486002)(6666004)(6506007)(6512007)(9686003)(1076003)(33716001)(38100700002)(83380400001)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r5jwUXqTTPbPG+8OmLfA0fM+6+REJfXLk2wPNmudqLCRG9Ii2cuq9rI7iKkp?=
 =?us-ascii?Q?cU53Sg+yoByyy3sXdAWQXTORd3JKUa5JS0f4ReHo2FjyFAHXIbMx1GA9eTmC?=
 =?us-ascii?Q?IsBJdgrNHKpO1TIhivHhLndSTDuRhdqmt3Ab5frhYwdkg9qeRqZwo5cbOg3w?=
 =?us-ascii?Q?dRDps2wxzF9HDqsJJ2OZETwYJ0nqiANhRelWxGAJvagxUiD5aCg1KzBgOYo7?=
 =?us-ascii?Q?ZFS5YY5QMLwAKH2ZZ8y8WvCGVlfQCJ7fGguKtmcKuQBbSItmI8uyNvPa5Mu7?=
 =?us-ascii?Q?cwEEZ/kHRPf1RtRTeaAcVd9dbdAjNWTyOcgi3oYiT6wPU0dCMJlUUiezwJID?=
 =?us-ascii?Q?Tq6KYFAJDWePETivVL4cKti5+DsbGEHnu1usj7ddVglDSa86itCZ2bxuXUo3?=
 =?us-ascii?Q?3V6XijPPMx/G10K56GoR86ccmcU8ZCOfT7A3CCo1peG4UiMwsE6T1AlKh4gV?=
 =?us-ascii?Q?gdDXIsm/ftIjCm3uf2k2wryrGIYjni0ZKdl5AgMwyd2AFbpnozu/1NI7wobJ?=
 =?us-ascii?Q?ZbdClIjc0xBigKxlsdtohz7AbJ/VN6QU3qNYRFaUxNpE09xjPaMsVdPejxka?=
 =?us-ascii?Q?TRirHPf6JUzcO5eRnTspfufTiSyimrUdK1ySNstMF2nIYyBhJhCFuCVPG7jh?=
 =?us-ascii?Q?q2UwzRC/5cMM0SNTRIuD1XMBPhLxZz7btpbrAPSbRMyURfdqEkXnoAMht78N?=
 =?us-ascii?Q?hmvLlDVm2MbfvXI+pKjYLM7oBAI1cwFqHpcm3ovlc3H7sFKX+OyHb2hx8pPe?=
 =?us-ascii?Q?XBMqAvxoMVcbmmhXyl+1d9r3xzYu06J9EKRJj1XL5UMBprDVPnqJrCPyUC6g?=
 =?us-ascii?Q?Hfqf5aBuZMyx1fGLb+U0qSWh+5EyYfLN1U+amCOphHzr29svXZLQgfwTnek5?=
 =?us-ascii?Q?HwFF/kpHyV9DUV4a6bEtwfWpcfztDGjKJooZUHYiZShIJoR2+6s+CQKWYM67?=
 =?us-ascii?Q?swzYP6+bx67GBOV+mQ8FKjfZhwnsh59IxXeGQt98EQdU1WNyN/HDgBLt92d8?=
 =?us-ascii?Q?BC9xuZBA8NAwArqnwjv6FqKLOmyiGD2x+7BkE2Gbjj3zO7lWFzgyGM1n1SmS?=
 =?us-ascii?Q?UVa2xYT4AA0XqLZySz0dlmDKBQe4AQW/BaOOyt5bjWfYdHqawxUSPsPPLN/f?=
 =?us-ascii?Q?K4AgByjQZE+tBSFeoHemb+lGCOoir8YGGZC4dLqBjh0pOGxV8n7w+xVzXGvT?=
 =?us-ascii?Q?OC3akjdV3tF49LMW4uIkPGgnVKMblV3bmypsKEwqlY9fnvMyntrUqjzfKFFy?=
 =?us-ascii?Q?O4oHqNIZanR0YDksS/Bb+XLKjry78o9rwq5OV78TcCGIlWfK3tmxfkjXBYtj?=
 =?us-ascii?Q?HdvDQ3RdF+qRZyQDUcNE4GB/Ciegs5BV5Gfdqn/u/Dw3Dp3B5Ggv+WW30F4U?=
 =?us-ascii?Q?tmEhlGu30nSEfSoEibEIe6vDtKw7CnQ0XL+czcFLFgAeN2aAH0wVyWyWSsqx?=
 =?us-ascii?Q?t0iZP1wtoZbWvOOZz6I7Kv8shw1dWHuFhy/UEgOncmnazX1Rbb2T2THDss6q?=
 =?us-ascii?Q?CdagQKOGARWUfDJ2buUrSwL++W80WlkRJjx07q6/nPMhV60LrlEFLqjiuXdG?=
 =?us-ascii?Q?uyo3vM5ecp2DdZCRwd+PMW8qdnIvTxAudw9LmM+g?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0830b3c6-7df8-4bd7-19e6-08dbc254e8e2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:03:34.4454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIsmlvFyB/PXdPpK0y8bfSUbsSau2T92moLoFMFHOktBYjwIvi7QpQeL22k40gFo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7725
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is used to relieve CVE-2020-26555. The description of the
CVE:

Bluetooth legacy BR/EDR PIN code pairing in Bluetooth Core Specification
1.0B through 5.2 may permit an unauthenticated nearby device to spoof
the BD_ADDR of the peer device to complete pairing without knowledge
of the PIN. [1]

The detail of this attack is in IEEE paper:
BlueMirror: Reflections on Bluetooth Pairing and Provisioning Protocols
[2]

It's a reflection attack. The paper mentioned that attacker can induce
the attacked target to generate null link key (zero key) without PIN
code. In BR/EDR, the key generation is actually handled in the controller
which is below HCI.

Thus, we can ignore null link key in the handler of "Link Key Notification
event" to relieve the attack. And, a condition of this attack is that
attacker should change the BR_ADDR of his hacking device (Host B) to equal
to the BR_ADDR with the target device being attacked (Host A). So we reject
the connection with device which has same BD_ADDR both on HCI_Create_Connection
and HCI_Connection_Request to prevent the attack.

Similar implementations also show in btstack project. [3][4][5]

Link: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26555 [1]
Link: https://ieeexplore.ieee.org/abstract/document/9474325/authors#authors [2]
Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3722 [3]
Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3523 [4]
Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L7297 [5]

Lee, Chun-Yi (2):
  Bluetooth: hci_event: Ignore NULL link key
  Bluetooth: Reject connection with the device which has same BD_ADDR

 net/bluetooth/hci_conn.c  |  7 +++++++
 net/bluetooth/hci_event.c | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

-- 
2.35.3

