Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8097B45E5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbjJAIJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjJAIJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:09:23 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE78BA;
        Sun,  1 Oct 2023 01:09:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDQAUiqKh3stLRv2s2q38oRIxodE/W2m6FeyW8dibnGU/Ark1SNce4vVCTMP9VcErqicHCSo88gpIlqw6QBHgGlow0dD4rIFJ3dDgKX5q4D6g/mv6vkCJLdM53SPn8IwCMjSrNcFA4ROs7jPAYHDlF9scKf7ojewdzilJMd6SW4qWh7RMj7kRzbUEs6UxXGTKwN844HxEc333ncSWioUPKGakW3icEd/bmGKPQea/BSDhQnyJsBxKvaaEtwNbPXOxEXz3HLP7KZ2+pT2hquNZh742skvEDULIy0oLJ9dZhPwHVVUeRNqMsBtXwYkBvNbt6MAaZe1w1aMLIhsOXV97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbg5dEf2maQJUv1G4F/zAIXkuiIeUoM3JSyBo3VOpYw=;
 b=kgBR92n3NImhibBJCcR+OXpQqcpYSL6QxcyrPX2O8kVMKZGVgX4N9YbplGLpZIpZ9DQvZ51c8Nm9gp89Da/Svfq/WDHKiA0cT2uqqBQ4NUPrczrQHLlwNUhBdeY5Z66XgDGEbtyxsIn7IVBbbAJjtHOoAe2a66uXLqinU3R7aXzNA4MDowXzFuZ50vPZFvPte663Z+LleS5GVBHHQxQ1rhuICtK0BkrHxaCezZyfyu+jZ0X+5NNkQJZtGftsbMG/tx5koE2rkO1REwcxqoPxPuvtHhjkhDCNQi/6l9y1w0JteIfmAa57hXJ+OW1dBBFQYW98dY+aK3moNTHn/W3eMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbg5dEf2maQJUv1G4F/zAIXkuiIeUoM3JSyBo3VOpYw=;
 b=mPhyn5rcY/sxFpuhqqscoHxS9V22kBkQrxg61dF4ICajqjK9r3iSioCosj5SdzdCwlrEpqEGRMG2rulXWykxReM1RWr3s4JEJVecJgE8QjUC6wdxUPjQXFe0sizBii/WUEaHwz8Wp/IWFAfHlJdnr0fevqonfH692BzMTRR9iFYwhcytEpbl6VJ7N03nqe54drvprNWbp6hvUsPJVE9LHTu4NVXZBGQDA65lYZ8D3x8I5M/noAnGGzFhbEJiUK99S+6OK5rm0netGb5YJr9KkRgD9HEHbPlrIvluSgDYXC0nW9XjKeqo7nW7hS/sI6/sSQHBVVVKWBqjG20rXUOrpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by AM9PR04MB8572.eurprd04.prod.outlook.com (2603:10a6:20b:437::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.23; Sun, 1 Oct
 2023 08:09:18 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2%4]) with mapi id 15.20.6813.027; Sun, 1 Oct 2023
 08:09:18 +0000
Date:   Sun, 1 Oct 2023 16:09:06 +0800
From:   "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Reject connection with the device which has
 same BD_ADDR
Message-ID: <20231001080906.GA14521@linux-691t>
References: <20231001074524.GA14361@linux-691t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001074524.GA14361@linux-691t>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYWP286CA0004.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::6) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|AM9PR04MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c98bc4d-c0b0-4257-c168-08dbc255b5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01a9kkeOI2J9cNw6bs+2Hbj3yjunhom/z1qvcArpmW+hNEKMT6udte3GzRKMLmubyhjC93YStzkAGoVE0iAiKpOKAk2rGMNz0vs7wgMkEuyO3JMTmgSCzibFVQ0sbtWzB5unvQMEXHWndiJGCp0YGwbKQ/V/ldeleNtZcaZmqyrbHOFZOgdvFq7pL2tnve7XasZFcvUuO342ZIFsjA5fVBr6tO2Mb2d2sCDDLkOwZ/8M9Q0Nqmznq5TUOlZl/DvptAnrlec3iiv3dimjQtY/i7ZGUOKuo7uY9EfRc9aQyuTf2lP2Lzww6AQE0UvQXswsjxc9s5SO2MpV83bFM5ylB6ROjcMPAehOw1KAsUEPiRE9/oFl0jq7JCrN2HhDC71otdLRaGpDL/GOHQ0JYFEPgP137UZOJppP83GNYsu71c2b/cAWNlGgtlgW0hIREpgaq7ngjWZqlqNOrMPsW+OCU1Mjogn62IOjll5ZiJrz2ZSyhTkSIYegm4z3OJ93hrpellsqVvOfi8yKlAS3VHNN0W+4yBWd23WHxsfJNj4fGs0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(1076003)(26005)(33716001)(38100700002)(86362001)(33656002)(83380400001)(316002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(110136005)(66476007)(66556008)(66946007)(2906002)(6506007)(6666004)(6512007)(9686003)(6486002)(966005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?stbhGU91R7VT0Gr+ErR0kKlziNBl+Vt/qBiCn4sGYXWc73H78wYbSv5S+U5R?=
 =?us-ascii?Q?aCHZg2riDvnzKbvaaHVvFmwCOgeZoE1EGBeBly2HZPbqM2k1hCD7PnnivEdd?=
 =?us-ascii?Q?aJtbolOemcLlhFUwBIpcAswZwxREGHhoNtiirAFQYIzrWCHbAGDYe4wgmzDa?=
 =?us-ascii?Q?oaWDPjqGwzwByy8PZesPITQrnjofiOzUYGLEoaFLLPGrC4tC+ZQnybntSKXj?=
 =?us-ascii?Q?sNOS2o7hBbhDXcsg3cBoKP5yffZQJUgUv/EXklHASbS1oRdhDPdk7qNwLm8M?=
 =?us-ascii?Q?Miyl91MiSnE/8EE3KAce526D0D33ZxYDId5zWQHEzAXPlifln1Vxso2OpIwT?=
 =?us-ascii?Q?Anm4kJJB/5U/7CjKku4x4p2nUg9Svr9S4ZdZWFjEiiaPd3uWSxOt9gOwxF9T?=
 =?us-ascii?Q?fe8p/YtyHaK/f8LsjX7gAfxb/R1tJxPq8y4tIt3Z65xZ5L0lmVwZhCbybTF1?=
 =?us-ascii?Q?msAr+Gl907SXgn7WvRCvItZ8N9BJfDyVI23XlrKa7pm3bExXwW4dBJAdyifY?=
 =?us-ascii?Q?07o9YOQcQa1SGUpl+1YQwPj9dokB5vOcpPYiOMIRIQj2onJOUhVSjR5iJqlW?=
 =?us-ascii?Q?cARuDP/xkO94YXVgXb4bdRsn4EVkellGZheNf+cKo+BpM4r6nh8XUPj3sTZ8?=
 =?us-ascii?Q?0sIeCssDaDeiU/m5n6icotkCeHSQWsWn1P7bd1DDWL+3142gSciASuGC2rms?=
 =?us-ascii?Q?Ktcme4pgPmE1yfzILAjXpi9nw77VbnMwuSFKiG0NUZ8xXSonvTFkGyS9uXPF?=
 =?us-ascii?Q?pNlhq2c4wyY/VN4CKpoM/zJ9Jtnkabp8EQKqOfXxR2IZ/XmIA5i4EkxM798c?=
 =?us-ascii?Q?wrf1DqBB9fa/Dfq3MT+I5dnPamYMJ2uuzUKXFmNNSp31ObPbALDkPRSNguV3?=
 =?us-ascii?Q?n9FDk5TfOjZZB1uOeot3uPewBShqaiL4tMiHmUGa3i/Oa8iRi/eWeLq40xoT?=
 =?us-ascii?Q?bASXcNQeLSlrb9P8aWfypCPfhySUZd4zHSb3fhrw/GRUNc4V7EXMe0M3z1iz?=
 =?us-ascii?Q?4VwXMAZnjQuZ3QCV8XsIbiHS9H32MAA7YxIzJDA+j6DdJDXGOoZcXyYwVP1T?=
 =?us-ascii?Q?oZXO+v1Nq6Xov0pIIbcsOA01RIfRnMtPAz3zjEJKRWyV5gAtBiuXA0umzZFw?=
 =?us-ascii?Q?B7sYuPjBxeytsBXKzGs/xDprTOplZGsVQqmiwE7wdiKZ4Xx8xaE1vR08bCiD?=
 =?us-ascii?Q?nUwwLaBB+a+OmPH+2UHh4KUl25O9npVm7AVWShRsM1NPqF8gf/a1QW9WLPPw?=
 =?us-ascii?Q?OVsZr7ZLjBRPl0S3l1YPomlhrjiFCg0RdIlJFQjrHZ50q1hYS65QLBEqHzGF?=
 =?us-ascii?Q?roEr0Tkn1c7Mf3WFT7x58uqWgrheYoh/3CpqjjZoit3HsHpF6r4w4gkcA+FK?=
 =?us-ascii?Q?cD0XUTvk0/X+0UP1NdJxtt1SpcCGmCqHcVonSbZ3FetdRE3g4vqIhnxARpSI?=
 =?us-ascii?Q?1APjCbHhpV0vEo2b6dNSOX+Zl5NPhYqCvsMQP8G7RrhBZFdzVhLSeKrfC72b?=
 =?us-ascii?Q?Clp+TaKRbboO3ssh1txGjoZwWRGI/VzENOte2xZhY7AIBLvoLMIWNg3YW2TD?=
 =?us-ascii?Q?rKaqANXVCz187oeSEQGI8ELGNAEsxJDDdV2pnA6V?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c98bc4d-c0b0-4257-c168-08dbc255b5a9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:09:17.9857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQ5WE7B1PXcEfQVsEcZO6o1FoTXfAwlYiphY0ibzVJR73K3AkD4KaCb/zdSaS3mA
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

