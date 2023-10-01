Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3307B45D4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 09:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjJAHtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 03:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjJAHtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 03:49:08 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2087.outbound.protection.outlook.com [40.107.14.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D7CC2;
        Sun,  1 Oct 2023 00:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1htsTr/JmY8eys+NCs+ZCmyScDp3v8a1Itghg1QNBcOEhjxZs3vXOj6lvure9QkM6iQ8mqKOlPODtvffVxCHBvcj8GHwet/huqXR3zdKII79wUDhYEozSct7F0JBXeyuE4wrq1tLpRzn8y7iAC8HUWQUUyGAg90mXuGLmBvUEdFW71CGnM5BxfN5DfWRhbeLD1sLvoTCrk8sWe5+nM51y+BujM7FfOXaqbVgJLg2tgHKNBcf3C1SEfHYJhLMtbJPw/3zu6GMX+xA5y5wmYBUAyK7Z0q3cmI9Ixhdr15kEK1761ZWsWFDG713qL0w6c5Q0AJNg9rL3wJ9a5Oiw/xOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWlURxDKCHcs14XBgG4qxuP9buQKtvsoB0qHNoAYn64=;
 b=DTapKtqupm4yhRsomB5591pSLmVHLdDGpjFJ8ceJEgkzto2YeZKN9k6GpaKpzTKRdF+y3ibOxso3A6iUA7n+KOObDQ3hUluHLVAvIwGXYyffDvRRGOqJqaZrGt7lmkTcD/FvSqEk+Ibe82i4R98mwBDojPhf/0kLBxvQfVaQg7hjY9z+bnRcFrTzugguwrA+HKrkv08nMElpOqEHhAaYXO90rhiaA+brtAmYm6AEwcaBEFtaB53WNmoDGNe9E7XLGQbiwPpOoxU9YpNlVHQTrV/tzlCXOoVIBCO28rWWFrXHGlORmdYfHLUnQ9sWwBJN3F3JYbflSLT4DTyFuIOLLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWlURxDKCHcs14XBgG4qxuP9buQKtvsoB0qHNoAYn64=;
 b=FwRH6FoITYRTRott1yOdXToiKI1UL5KrG2929xYn+AXux4R7ITbvfNp3dbxyTVZZ69QckV6viB6OGqAaJYpBYaydyALnhHSjYOn+2ml71OmvA5difrg05Z/xQyf6R89FXIIEQoVfPKJC1w6rJug35EYFRMOTctAqYK/XvX0Tt4Kv0XobIaQhLA1o6c1wbNsBY8UlGGuHqzRAyuNV6adcNaG0i+ioA4OlU8TqWHV6OhnJGt2CN4w38VCxfdp14cDvzFIPnSiwMStqQjDPl74plC0T7CGy2+EQ3L3g5enX4SSDvCxcvESqiGHjC1o67zmYU/9fD3Dr2nXup0jzTYUnDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by DBBPR04MB7531.eurprd04.prod.outlook.com (2603:10a6:10:20c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Sun, 1 Oct
 2023 07:49:02 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2%4]) with mapi id 15.20.6813.027; Sun, 1 Oct 2023
 07:49:02 +0000
Date:   Sun, 1 Oct 2023 15:48:51 +0800
From:   "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Reject connection with the device which has
 same BD_ADDR
Message-ID: <20231001074851.GA14412@linux-691t>
References: <20231001074524.GA14361@linux-691t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001074524.GA14361@linux-691t>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TY2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:404:e2::14) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|DBBPR04MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: acc9f512-12ce-4746-e5f4-08dbc252e168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qzyitr6lER+nRLEf6gbU4MjNLEmJoEb5oDAVxRWKvXbtIIRlB2yug0CAA6qgbD4Evi5iwMW75WC7d/+tfHB7I6d/rdaycbyDDIsp5wVelaKXPxdRG3Pboin0S0imD0r6A+XKVuPW/1sz4D8fYSwwIuIBP/6RBNDVZG95iP+dB8yIf6HawX6Ki8zTKh3EQeUBuo7ltPwIthmElIaVFYIR5E4PGuuoSdYL5ZcC+Xp73DVAbBS5//LXvnvjYzxz42SYRhHbhOVPYKSyA+wUqzi7rn9liVhYl9iZKBiV8Ulapmd2eZM761ykLRmEUygD8OHX+BBk4Cx3H4eopgRZZSApliNJNAZs2JCJbPZiMJyf8Ois4eSiiiLOUylU3ws1yFmsBCizpztkHkHFTHnEF4kQ+zgZyrHLlV1qgho2H8UPkZ/rQk/IzdY5+b8dgaFxsTJuQa39vey5naxjvX1OjFy8fCBejRBXXH4D0j+jmZjxFvNMEEChT0TDofeCM4VZYy4L4mkGMbpwUPfE+/ebUKpaqI9F7KZLFBn7iWW7Sg3cruc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66556008)(66476007)(316002)(110136005)(5660300002)(66946007)(41300700001)(966005)(8676002)(38100700002)(83380400001)(478600001)(9686003)(33716001)(86362001)(2906002)(6512007)(33656002)(8936002)(4326008)(6506007)(6486002)(6666004)(1076003)(26005)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XCDLeKRTwLtISQPSlYtse+Zq1lZvjR+ltTO1mszhjEsJwkUzIROFdbOUL9Sa?=
 =?us-ascii?Q?tGKjiL7gi+AbnN5SR8homMMzSJQ+oJq9DiP+qvDAINSIYUmKNP+sQ5qEv7cP?=
 =?us-ascii?Q?LrhOf7KtDSHuNICSLd1ALQvMHaZ2LT2AVZQjxiVDIKTVBPRxtMZxoWOxcxqv?=
 =?us-ascii?Q?yinFFbLjXv2oEu7oEvUgBIZz0AJl48UJ8fLSuf91QIcYZqxJDY3W6WLwOUY5?=
 =?us-ascii?Q?HNXBYAGRJBRhefwUYZRzAM5jgtZhW8AjZrmcKDHzKVuV9UwAu5HyiNqUQd7W?=
 =?us-ascii?Q?YelvAZ9yl8zXotvvfWuLtgbHYcVKCEGcPDBK8zOg7r5qb6MhPFanecF+RCEd?=
 =?us-ascii?Q?EljO3cYANTB4Rah277TjPgIwknEBXHHyR/BR/qjSfLHQ+so+/5L0lDaFAhra?=
 =?us-ascii?Q?IC9nQcG4TAbH5btirSVgANU+oZ04kGsZ9nR5WUPSm0FBBi82eAH5OdjemdLg?=
 =?us-ascii?Q?8pSYDWdkkPLiJsmsdxR4E9cuJK8/O+MERsQvI3uWsC/zCbVLMochQSVGc5bd?=
 =?us-ascii?Q?GceKlsN50xUpWvmlL9KiMQGshmpzf/7+9LyZ+RJV6eo/xJSw7zZDp8pdy8fZ?=
 =?us-ascii?Q?ZlD0qTwFkgTFi16kFcQOQTySrXJR8Y7zblA6WNXJjnaHDckBen6O/EPOP5AC?=
 =?us-ascii?Q?+q44TtwkG2UUlSu0ui3EnCE2Ry1PpYvrCeOj6gcmT79m1Zjw61SX9Lw6p7qB?=
 =?us-ascii?Q?dnCJ0ZuheyCABjzHujgC/JHPdOBQrWPsKDNd7lkplKib2/YTZgTMASJM5Vii?=
 =?us-ascii?Q?kWElfXPEBvWzi9pFYiTUOC2t8O/lVAn30thyY1FC6vNI398hmh71x+1Zk6Wh?=
 =?us-ascii?Q?gj4qECT4thgCiNzXpAdg03Pfdonxc+zF/f1jzpIW0JOu3gOAMFS3xHi3GZkb?=
 =?us-ascii?Q?7CnxRayDwX/oB35PIotcxqqPzTy+ykiRdOIADcu4pUnw/FzO7urVDKYkuYGB?=
 =?us-ascii?Q?rUXMOHjdmvRBYmNktZa8oUMlRunUpc/uF8IrnSIUWyd4fGUMX0hNngR7CIyp?=
 =?us-ascii?Q?oxjMa30aUmy0Qhlkdt+hTdX3Dk5OoFLxiPbqV3bXHthJNnls2K9a0+b2phQL?=
 =?us-ascii?Q?cXiy0qtTWAZlvQSdN9hZPodtH7Sgcvbb5ZvzHSJpuuxHF/qsDHpUE25TUUEm?=
 =?us-ascii?Q?vKRWNFQ6snMcBwlmHOYQZQGzHeR1IZCm1gLolIoYb4F4ky6KItDJ9eihKSao?=
 =?us-ascii?Q?bqMM6kKuKjd3aX19C7V9z/Df6WWfiWcuWgqaY37lF09czgcuIeNlnzfcLVm5?=
 =?us-ascii?Q?OkjmFxaAJHFsaN3SiEcSlb+i+MCLHvLiPCqQH6UsnNhJCsn04MGjLhn+ItzO?=
 =?us-ascii?Q?w8+TnhXkW7gyfTcFVHr+R7hy+8+JM2eMUwlspNA9YSCjQpIDDeI+clVx27H+?=
 =?us-ascii?Q?tTUynwZe7m9llpMTpfwDUnJ/jh6H3NZFV+i2ysHIAWJYkGXdKY0asC9530Dh?=
 =?us-ascii?Q?grNAwnfGWj3qdzDjtGoXdgQXk/1bgMtUANm5DvJyhFelY/pdHvYe3oeUeWpc?=
 =?us-ascii?Q?LYbryIBJpABgschP5FBL45/lgPflf6CEjrhPAGKd5iEkFUYDxCWA6g4RuYEM?=
 =?us-ascii?Q?DW7RvmCjD38L9eOPujA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc9f512-12ce-4746-e5f4-08dbc252e168
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 07:49:02.9024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBPP9FHJ6M69dSGMKwcq2y1GSNu092zy1c/XitqPJJ1wlgLCHttvNc+fwEGR3zmD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7531
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is used to relieve CVE-2020-26555. The description of
the CVE:

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

A condition of this attack is that attacker should change the
BR_ADDR of his hacking device (Host B) to equal to the BR_ADDR with
the target device being attacked (Host A).

Thus, we reject the connection with device which has same BD_ADDR
both on HCI_Create_Connection and HCI_Connection_Request to prevent
the attack. A similar implementation also shows in btstack project.
[3][4]

Link: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26555 [1]
Link: https://ieeexplore.ieee.org/abstract/document/9474325/authors#authors [2]
Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3523 [3]
Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L7297 [4]
Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
---
 net/bluetooth/hci_conn.c  | 7 +++++++
 net/bluetooth/hci_event.c | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 056f9516e46d..583d2e18314e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1611,6 +1611,13 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
+	/* Reject outgoing connection to device with same BD ADDR against CVE-2020-26555 */
+	if (!bacmp(&hdev->bdaddr, dst))
+	{
+		bt_dev_dbg(hdev, "Reject connection to the device with same BD_ADDR %pMR\n", dst);
+		return ERR_PTR(-ECONNREFUSED);
+	}
+
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
 		acl = hci_conn_add(hdev, ACL_LINK, dst, HCI_ROLE_MASTER);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a20a94e85b1a..d66718190dc5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3268,6 +3268,14 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "bdaddr %pMR type 0x%x", &ev->bdaddr, ev->link_type);
 
+	/* Reject incoming connection from device with same BD ADDR against CVE-2020-26555 */
+	if (!bacmp(&hdev->bdaddr, &ev->bdaddr))
+	{
+		bt_dev_dbg(hdev, "Reject connection from the device with same BD_ADDR %pMR\n", &ev->bdaddr);
+		hci_reject_conn(hdev, &ev->bdaddr);
+		return;
+	}
+
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type,
 				      &flags);
 
-- 
2.35.3

From 2c6cd3f353d21086a3163a9ad461789d203a7ee4 Mon Sep 17 00:00:00 2001
From: "Lee, Chun-Yi" <jlee@suse.com>
Date: Wed, 16 Aug 2023 21:03:06 +0800
Subject: [PATCH 2/2] Bluetooth: Reject connection with the device which has
 same BD_ADDR
In-Reply-To: <20231001074524.GA14361@linux-691t>
References: <20231001074524.GA14361@linux-691t>

This change is used to relieve CVE-2020-26555. The description of
the CVE:

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

A condition of this attack is that attacker should change the
BR_ADDR of his hacking device (Host B) to equal to the BR_ADDR with
the target device being attacked (Host A).

Thus, we reject the connection with device which has same BD_ADDR
both on HCI_Create_Connection and HCI_Connection_Request to prevent
the attack. A similar implementation also shows in btstack project.
[3][4]

Link: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26555 [1]
Link: https://ieeexplore.ieee.org/abstract/document/9474325/authors#authors [2]
Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3523 [3]
Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L7297 [4]
Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
---
 net/bluetooth/hci_conn.c  | 7 +++++++
 net/bluetooth/hci_event.c | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 056f9516e46d..583d2e18314e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1611,6 +1611,13 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
+	/* Reject outgoing connection to device with same BD ADDR against CVE-2020-26555 */
+	if (!bacmp(&hdev->bdaddr, dst))
+	{
+		bt_dev_dbg(hdev, "Reject connection to the device with same BD_ADDR %pMR\n", dst);
+		return ERR_PTR(-ECONNREFUSED);
+	}
+
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
 		acl = hci_conn_add(hdev, ACL_LINK, dst, HCI_ROLE_MASTER);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a20a94e85b1a..d66718190dc5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3268,6 +3268,14 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "bdaddr %pMR type 0x%x", &ev->bdaddr, ev->link_type);
 
+	/* Reject incoming connection from device with same BD ADDR against CVE-2020-26555 */
+	if (!bacmp(&hdev->bdaddr, &ev->bdaddr))
+	{
+		bt_dev_dbg(hdev, "Reject connection from the device with same BD_ADDR %pMR\n", &ev->bdaddr);
+		hci_reject_conn(hdev, &ev->bdaddr);
+		return;
+	}
+
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type,
 				      &flags);
 
-- 
2.35.3

