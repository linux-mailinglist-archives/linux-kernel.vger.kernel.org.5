Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835C67B4665
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjJAIyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjJAIyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:54:10 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E4FBE;
        Sun,  1 Oct 2023 01:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOzZTa65Mig6mWhM/igQwg2QmTyyiDKyEHnLOgoz2AsQrPRXjG6H/nBf/IYQwEk2jJwA/rVahC9D+pIj/RZOKIHiI4NvZ7o4oaRNE6uoTxOL65a07X/N/xtrXHqrH06m33M/XH7OGOhrpmAO5Mq8U3RTFOqgcI6RPG2bDUnMPE0MOXJRlXdt9CdxxzN9Dfb88GXGaXwVwmdmwDveiWyd88JPNiI7FrSyexamTRgUHVJzarpfHKn7wtAr6QnF/GQswp7hbzRiFLo60LjJfhCLY9MBOOeGYPKoLHTTiw3hZtcnnefzwMSg+ooVhPglGq9sAbMQTnkoHVyiqocCb59J8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QngHf0069SUpa+0aQXtb/GwNP/xfzgPDh2waFl1kvHs=;
 b=KKsaH/4yAY19n6dcfonFPGFtxj/Zvz1E5MhnDgBtpxRFAJfrIeKR4beB/QXYOySLW6MsWKFFdE+wqXC4DLFSWSnpJhFuqqMmXf7YKf1GIAhww9Ur+yY7uD9I+9MjVHcWyc+9iUVCU3udlR8RvL6KobP8/8GqOXs3KsSbeZtYYkmnz4G9248jY/Hf2n/V1ZBMcZ7YHG6H61982mW+10QBUc2TAZq/L6j2MIYIFmHu113CqodG9UX3z5KEjIPFLr0kWzPBSRT5hr+WHvgcw3/pW6iMDaPSZg+mLNmYLO0nNVAU0pfdzhsOHk/ZmsZXF3Szycv5W4+gz471fwGG/qGsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QngHf0069SUpa+0aQXtb/GwNP/xfzgPDh2waFl1kvHs=;
 b=mQsdIXCHm25VGuTTNK1o/XPwL1M3zNfeBFIxKzT+VoMhsHQ7jrKXksKs1Z7QuYsRqJs4pcUP+g6IcG/hHihVy6vzsCq+N0Ri7T0QfbjfKdXcVBsYNBHt6wOppJsVUcHtFK6yAids+uxGoj9m7+G9bKMb7bo9GjZZDH18Dj4+RMS8sRG78f8SJRTAHsMYl/8mdihQbQulJTzNeAaOqI+oNcn9LDlNgwRjYQQ/7FbH2s7kFPoL5RZGUMCRcqoZD8n7kezqxxhRBnBBU4C/r0eEQtjkO/gvHDOKB3WvaswclpYWSzKfEPQZjPr1wbr3NHp2JfhBRo+IDVVOKBssyZPPFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 08:54:03 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2%4]) with mapi id 15.20.6813.027; Sun, 1 Oct 2023
 08:54:03 +0000
Date:   Sun, 1 Oct 2023 16:53:52 +0800
From:   "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_event: Ignore NULL link key
Message-ID: <20231001084934.GA16906@linux-691t>
References: <20231001084934.GA16906@linux-691t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYCPR01CA0181.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::10) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d99cf5a-1704-4e7d-30a0-08dbc25bf5f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wCeA9hxcZZ9xmsGhMH9UojH+PKBacTvE1Seoncd7rgfR2D1036DVzuMNCFqpm0UBxkPk3lxWKCV+Hu1lw8/H+ETgL+eVEb9c1XC1HOhAM0GhBqrCgJ2CqNiRRCglVhdMorscS5vs5Jow1/k5LuqqLnB3gSX+MrKLC6VV0rFXus8bGBLE9RoN/GLbnJDgs94j5p8kuNshZu4efNTLQ4jrnYZ1wER6v04lowTMwGWcRmaKcWl0CdMbt5tp8H5YT9IFMrJYGlaVW1/HAouqOBkaoHWC3bJtaaFqpVGzyFkikil+mGJ8Lg2v+Sdo5+ZzyqRIy6/hnztjd7WvSEv2Ln/kJxG3zu63GAhh8hS/HuphIMZa/JmNTSr15H2GrLTqmz95G7R7BNmFaqq8/F9yByuWpSvNsb2Elh+cvH5TkWLVlebZCGwkntjaTRjF1ShncUbhYL8IzLbUTZc6Su4JUqIHk5kYYG+GcRy9Ya+3BCvQP1cEm+eymaZJ6kheh8neuO4/1QrDmtmGDFw+AM/5kLGAVfk3i/c2lzAsFVIhloZuUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(136003)(346002)(39850400004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(41300700001)(6506007)(26005)(5660300002)(8936002)(2906002)(8676002)(4326008)(316002)(1076003)(86362001)(83380400001)(6512007)(110136005)(6486002)(66946007)(66556008)(9686003)(33656002)(478600001)(966005)(33716001)(6666004)(38100700002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QlAivkJU1vS4xyKk8g5iHdKrbpQjSCLJ5ehStNpp1zstWzgMhYvgKv7i1dLg?=
 =?us-ascii?Q?kRMDVsOXC+lw3tZPYKqxsxEKRyuwGsXafQH0wLruLorB4sNOPC6ptHsnLt9g?=
 =?us-ascii?Q?G0yTBvpoB98/Pwu2wQVLQkqqX5YZze7VGTaljJVbp9uvuichmkYR7Z6REral?=
 =?us-ascii?Q?rEY674KAsN4S5ACgwiqT2/zhTMunRLMbhldPZQETme5gR1HzcVCXiKYoG/YH?=
 =?us-ascii?Q?A4qnafAG0JUACvg1uG+wNyLS6IB+EwpVmxxX67/q/1gRyQTy1tNNLZaMntld?=
 =?us-ascii?Q?6c87TgGkNv3jVSlxXJqeh5Dg1ScMVLtDNorLI5s7g2c9LmJzpIncHvgIRb66?=
 =?us-ascii?Q?DacQyB0/7V40varQ3WB+UKCI/XMvfh+UCW1wEFL1ItqXWABpC/9/2iwVwuwI?=
 =?us-ascii?Q?ThvYzR8LXVqTqzfR6+MHN31Irrh5R7J/uEN9ZKxSgbd121xPL1jPRpCD0sTv?=
 =?us-ascii?Q?DDH7JG/DNtsKtXmdv1ihVt/C4lrzQQbtsBK3t3LIwo2tLnwtoQJ8qeFyyi00?=
 =?us-ascii?Q?ocPCd/HIHpVSVpPcplkbABkvKKq6LPuMXR0bjQ72xM5jvwhkQJPKSQ2HG/IY?=
 =?us-ascii?Q?8elPqFlnsdMtD3KlKjKdZDT/NHp72DhwQxt5SJfaJt20toAf0ZKB+tio6uBC?=
 =?us-ascii?Q?i1ndir4MvyphU/RgKNZpw/8SLiTnm//mRnbeSw238YAEsaX2RKhFIJvz0glG?=
 =?us-ascii?Q?ZpaCB55QFRikcyQCvoe/mW0OobY2TAPxG6DE/yDSLwDMpq9tKSCNGqILTZ5T?=
 =?us-ascii?Q?L2r3n9KCDJMWiUHLGllxi3Qf5gvoWABPegwgPk9U4B4fmjFH+3hwNwvvCos/?=
 =?us-ascii?Q?oK6Cy0AHQK8Jv46EmL+fEIYKCOHQZnnGY+cPGst7TrrS7bJFlUXg3fl1YBmU?=
 =?us-ascii?Q?Br3l1glTp/wtObsllbE/bvB3N4b7KeT3/+JFZlC4BYL9BO8lmpg+jITZWimB?=
 =?us-ascii?Q?egow7QQMsAPlZmGt20oRYYhdyErHX3EW5h4Q0oHvnCX0QF4RgVSWtgDqqe2G?=
 =?us-ascii?Q?C5cWMEkPDBDy+sVt6sAga/UinbyU+lXofInMyJ1CBULMfHiIFWdAxJYAGzn2?=
 =?us-ascii?Q?ptPFtwTWIfa/r1aB+BM0fLSQA8gu7LXtbgplwKVtCzKAR0VLWzBSWwHaFpBt?=
 =?us-ascii?Q?Myq8si5i9E7WN4ykAUjyJaBpRHtHf/G0aURecSu0P0/Ig/qQaC8mjI9/7wEe?=
 =?us-ascii?Q?VYhLtn5PC1aLWcHenqipgQmSEX2Xnqwz05eylvat7I9p1GPmK9SRlerlwPDs?=
 =?us-ascii?Q?NAzd9hiIWSBnHSFNlMpxmpJcJquPRPffCqs8kSJKzOoTBCDDZfpADpDlR948?=
 =?us-ascii?Q?1q1K6lQlgxpN0DUFH7jYcUU77VgcGv6cK7eNhGMLLfn6lqtoLpcu5gvrH5LT?=
 =?us-ascii?Q?Svgw9GFNkQUin7gD9ygAV7OLNvbazAQwQy91dZVZIbwTpe18webHeQ2dd1sX?=
 =?us-ascii?Q?NGW6SpyFY+jCz8TGN065oSYE0rSv/Bek+f01aizs/zG/C80U4rTWUGxRHItR?=
 =?us-ascii?Q?dGgGYwjgW16v0NQ7BK+vhiojT4f7B5QD9gg5Oa2qMO7mx4zbweWWSXLliuZy?=
 =?us-ascii?Q?CqtZbXBlCVGzsmhxw2Bl+AipObVWd1u2wA36pkRA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d99cf5a-1704-4e7d-30a0-08dbc25bf5f5
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:54:02.8692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czD4Ji3q/Dp3mp+ObswZKQZZX8afiZl6gMjJYwTrvjTRZsr5AKG1mhqD5ygh4Z9V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is used to relieve CVE-2020-26555. The description of the
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
event" to relieve the attack. A similar implementation also shows in
btstack project. [3]

v3: Drop the connection when null link key be detected.

v2:
- Used Link: tag instead of Closes:
- Used bt_dev_dbg instead of BT_DBG
- Added Fixes: tag

Fixes: 55ed8ca10f35 ("Bluetooth: Implement link key handling for the management interface")
Link: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26555 [1]
Link: https://ieeexplore.ieee.org/abstract/document/9474325/authors#authors [2]
Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3722 [3]
Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
---
 net/bluetooth/hci_event.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 35f251041eeb..2830abbdd329 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4741,6 +4741,14 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
+	/* Ignore NULL link key against CVE-2020-26555 */
+	if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
+		bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for %pMR", &ev->bdaddr);
+		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+		hci_conn_drop(conn);
+		goto unlock;
+	}
+
 	hci_conn_hold(conn);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 	hci_conn_drop(conn);
-- 
2.35.3

