Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1507B45E3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbjJAIIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjJAIIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:08:31 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2053.outbound.protection.outlook.com [40.107.15.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA092C2;
        Sun,  1 Oct 2023 01:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKV9qVxFUq5OP59rT828HD6quGBNyGecP039OQFUdna0/U2uzBFxscM07/vXxvoCoJFNg5D2RPQSFAYq0zm5bjtqhACVrYus/OsUvsxkh2DzouzM6H++nCZ8nWhkFLfTVnovuNSTCm2iMfgHzJ+6ys2PPoCKFaISs1/7B+NA4v1s7/bBrPLjaQKv1j4i+iUUOX47F/S/18kcUb87vNNWq0l0eLNdECl1UDrgaI8zfV2w0AY5EuTdgPT66xWuOY4r0t7mEPPUiz5oJpJBjuBwoZgQze6DcA0Wa/ZSe0ry3NAtnmKlvvwE3ZK2ccqcrRX0nnA2r6zhWS+sm7/EeW+icw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGQqYZ0FgUqrYy37FVP0MiI7B5zDK0F712BQATH/yqA=;
 b=h9QzRe2mCOV2pgPirFCRYtJdZ5iuAPZRTSDRZeZvBKGE+IC5cqDdEhziTrBzJPRXWkqf+WfuqH4SO5t6MNklKxghRaXtldb4xtbpSZgpiGzNLbrfXl790saY0PgtPh1jTWCWuvsudF/cCuJetRfOrRLGRWsoF917R8gHYYWBmllop4csBMcRe2fporBzKX1tConGDtxmSTw/EX2BLjX1BhOgJFol2bJJ847wJMz+/7drJrul/Y7R2PCeGlo00KiECxhVXKxaVosRdaX7I4ZQuFWRrhsTc9MH/Ykt2y6HANxzJijWlb2UR/UzV3GoYCC6lETBO+YaBPUnPfpp7P/Lpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGQqYZ0FgUqrYy37FVP0MiI7B5zDK0F712BQATH/yqA=;
 b=rRm74ao4AJBdQQ3CFJratCV6N7F/fDjb9oTd/3PEz2rnkZXFb0c4+KOUV7pheeQ4S6VRsLiNRAcOI+Sbs1jzNytzB8yqDKG1ip91NcN4ussRjWOQFug9lK2DeySGMj0RPM+5XxnF8tbgfzeUzmZedqoA4BgkU1gQKAE8fw9LNkM0X9vW2LkZ+ALlBN373pIR21gEKXRkni4u7mTHoBPeqBMEwD7Qx/naowkdlGUoAXXeVHbyJ4DrovXjvRRY1BnkfOuY8AMOdVLC3p7UxUDP4rfRm9XJrQXUhavuH4qKxRY2yo1vuDlNDYDngwfazsfyTpK1BYqlQGgbsh3+0eDpPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by AM9PR04MB8572.eurprd04.prod.outlook.com (2603:10a6:20b:437::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.23; Sun, 1 Oct
 2023 08:08:26 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2%4]) with mapi id 15.20.6813.027; Sun, 1 Oct 2023
 08:08:26 +0000
Date:   Sun, 1 Oct 2023 16:08:13 +0800
From:   "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_event: Ignore NULL link key
Message-ID: <20231001080813.GA14514@linux-691t>
References: <20231001074524.GA14361@linux-691t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001074524.GA14361@linux-691t>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYCP286CA0067.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::9) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|AM9PR04MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0a1c72-277d-453a-d8ee-08dbc25596a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NqcaeDvVwL6IKIWPnzzCIKlHikLBxaJ1w42i0z5PKBLaU1vbxmhzviFAEsldbvzWDk9otWwg3uQn2d/DdZjHCTEJ6POPjfgG+pWDZzSMphlYkObxjXj/OUSZUPDVc8XMPl9ShcNUQC2/aHgT1tkWPp8pM+LT7K68V4YGPszgQVJJwO2qaTbtKE9s0NIWljl0gaUsmVaM2IQvhj/ckJMrJwlcX1hGhEyO4O7F11j377IdfWFGs+arsfL9RiHbPakjpO31XiHULhNj25FXzL6Idjpr1nP3mplHfJzGxvuLJZNa950Nij5ocfsV7Ef5AfeoFyxxMq9ppSRh+d5149/NM7kYuUtBeSKCX4xcpXKXIkrR9EhhgaaTD6sAgQUJr2ThCuEys2qPjFXdyJ5vOwtFMfGzKEVN6N3hgVznC6Hf3S8DyU45odgQZOdnyDQhrXxaR88BCy4MiqtRA2sEWJ/Vd7yhUlI0PZlL/B09CVfcsLcbjKJCE2b/XyfLFr9xb7Bsn58hp1K1IUAvytnmx9sVRrz5jEHl0BEzMmTe1QM5tiM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(1076003)(26005)(33716001)(38100700002)(86362001)(33656002)(83380400001)(316002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(110136005)(66476007)(66556008)(66946007)(2906002)(6506007)(6666004)(6512007)(9686003)(6486002)(966005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sdKkf3oreHeWlVSI47uHsNOFlJuo50DVU394nB110u2pY132C4ifo3yQfmF4?=
 =?us-ascii?Q?FK+/841BzTYz3Rpkd1HHQA2beBy9heSq+bPUjS2lfivmLIyo1bymmbgiTt+S?=
 =?us-ascii?Q?I8oP9dT+xVQEp/hzjOcpvqZww//SC6Aiv3H/PYYSpxyAGWwn65U88gXd9DiN?=
 =?us-ascii?Q?BArq8n+7LvhLYFnPfF373l+H9uDs1peCVJWyH/z7PquSkZ2ea4vcNbfS8/uy?=
 =?us-ascii?Q?t5EfYJGhuxrtkvgZkTL/+XElYZMqoBFEd6fQ5oyNZcKVwrkOh3R0xc7jH212?=
 =?us-ascii?Q?w/kqerI/aALTnwfCOtL6KKVIy8FTJZlACTGBxJWsUGfunPpnt/O6+7ZszTQG?=
 =?us-ascii?Q?9ONOnoGBRX8msuYKhmk8o7nsVFcRX5N/xPMZ/wAjGclp8xf3WiC4UKulCl/Z?=
 =?us-ascii?Q?9QXvtJrFF8++4i+Ud8vllDIcc/9+po9YgjkTosGZrhB8Z05DsLM8LAwpo2I/?=
 =?us-ascii?Q?KvJFqKMlOjUCCS1eyDREV5uh5xzf2GucJo9tOs/0I4iFbOqvcnq7iyzDzkZv?=
 =?us-ascii?Q?FoGC7rARwaYWjlilyMjRMhcEQc2iR6KjZenPhpmlaXyBg5uFksXkl/a0QvdR?=
 =?us-ascii?Q?nMcTJXep3ZSzt/mpkooDxh3Z835z8/22QlJibSZsDM6XyPa/jo9l19aKiKZX?=
 =?us-ascii?Q?enszAdyyenkNbqC6i0XHEL+ZTifC2HyaSlp1ThfBRIHmh47VJ6jdlDgesu4m?=
 =?us-ascii?Q?3GQLb+7DmiMQqChN7wZBw7uyY8oi90v0BzqykyoSlJUd4Xr0B8A8B2RzJx55?=
 =?us-ascii?Q?ul/Synr3tWnZu7LSjqfoU8VNmSgDyhkr3njYoOKDepFMZgbTWiipkRH/5mae?=
 =?us-ascii?Q?qZ6v0D4yy50Izi0vCpyy9RzosGCbyjRVcMhmgAJGrAfFe5QrDwMxOyaHqFjy?=
 =?us-ascii?Q?DBdqlQ0INnvf9CL5+Swuvq6FINL2Vp9NADzM9PcIGP/lqj12JAIZTOHqyP7D?=
 =?us-ascii?Q?Tph4gohNTnNSEh8ob3I4cfiW1juudP1PzTgUMx4GIRYkwdpvKHDA9O2HG2LD?=
 =?us-ascii?Q?uvw3LEqhhYS01QdPlwKELo5e6oncZPwALHzCtbnHxb06uRFEiBlnkA1tdhX2?=
 =?us-ascii?Q?FLBftPYwbcUftWbxqxE7qoruZRjRMo/FK0eML6JhjOcLSle4amrp9JukPvB0?=
 =?us-ascii?Q?0lqlDAJXPsPAv7VEDskKf4Ce/sZeTiv7HQpWpBRqNpHI/8AvLZMMbFy9+2Gm?=
 =?us-ascii?Q?h+xH32sYnabFLKHfI1ZcO0hYIu64j/GGYBxMzvRrcnZ9YYMhhmiElRuBZ8vF?=
 =?us-ascii?Q?eQ6XZDF0nexZ1+8WgisZbPHnQR7FrZzVu3rbjFKAMk9WxIla+I8Eq+G7bmhe?=
 =?us-ascii?Q?N6AoOqx0znTi4DXewNY56TdEqnwicGzpaY0oqt1OPdpnxnCa4/8L3Ms0HIJt?=
 =?us-ascii?Q?J88XzZ2gm0WJ6TizgLLlr4cdAnwBNsBBKE7QKB3SA4HBH38dc1zqlWl3J7Hp?=
 =?us-ascii?Q?jqvtUoB8wM00FK8NCVxSszJzbDb0bRybympSmQ1umdDVksOOymvL27wjxejw?=
 =?us-ascii?Q?XnZ+60lenfQa3mCmbuVKg839h5R6IzGKnEsMQ61q2N1R95msPt6qyyeFHZxj?=
 =?us-ascii?Q?QKgXVkx6JEUrEtW9/9Ao1NjQIPrtS1ZCtw0KBhW1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0a1c72-277d-453a-d8ee-08dbc25596a7
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:08:25.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5sPcvSGjInDsrXO1GWWM5gBl3WJAnaAKe+t4EGZhsEycEl6hMb2sszGaWwgBzzI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8572
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
index 95816a938cea..a20a94e85b1a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4692,6 +4692,14 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, void *data,
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

