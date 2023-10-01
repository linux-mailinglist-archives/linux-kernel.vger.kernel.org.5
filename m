Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8E07B466E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjJAI7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbjJAI7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:59:49 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E848BD;
        Sun,  1 Oct 2023 01:59:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwMMvlsQQIP5kRkm86ZgmAXUy6U2PnDBUzbhOzOPbVqYNkhYdhuPnPOSOgGuWskOfJ9KXrV5IM9uXdxqpviWYx6OgXBs++S9TY6Uo7EAsmEKUOQ0ACyqiNbRyNF/i5LA+whbiq/RAYK7SbWz2HcW+OnhNkP2S/ctccubZ6F6/3amzeahvMNCiyWGQs6XgD500gsMHopUR8TTqJIpvo4LJCSWL4akin3OBHMnJ/o7CiLAncG+Op/m31iSab0bnJF4xojtnp7AuW7OcDzkSspaEZ9zlEI7FFZRS1ginkvHQNy3+GPpCzU84uEIH3Fl+/E6wic6Ev/vG7Ef+ZQ2f0g5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QngHf0069SUpa+0aQXtb/GwNP/xfzgPDh2waFl1kvHs=;
 b=clIwgu0BO4SshjGZAwvz9wRB1OlPiNdGToOuJ3k06JZx4lFgwaHroftfzjibRDVf6HIbnDqx6U5guinx0GQRz7wY+v7svbvfuuoipJC8htICjG3jvuYi7AaETgbSsLYcS0tuxquPvq3Gp29IfytvEyNJZo2DjjPbXeRBQs9gGDxwGPVB+mwWYbpHwMh6DTuw9LUOyXg01Xs0VML3ErUBz/Zg3NsPRhnnUF7p8adHNmcgpULIiGU0bLixObXPidd2M4ErxzyM0r7QF2eHd5Jdt/pWkUX7mU9innPI8U15Fh/BR4ZR7xNycjtYk3f4Bvvg6HsIEX+mEcscuaU0Vd116A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QngHf0069SUpa+0aQXtb/GwNP/xfzgPDh2waFl1kvHs=;
 b=Bd2DBWx+gXh4bZPeOzRyOe3QHnDv8K98YHW9TwZz1CDx4nKy0kgo+GEb2/6HXU7ZQZS7O2+Mir4ZOPRHLByH4FHzEiusA4Pq0sJtWo/lT6wsGBqx8r1lIglP8C/vVrYW14cCksOgHdUudAcgQs6iWjA61pC7TR9ga3bzN2Esqv6orfmWNx/VzjX3p530Po8nBqDmSVmDZWAd1kEAljTqa+traCu4VyqVK6WEhvlJZYeu3RwzNEFIXbPjdWMKcZOy30mfJcBw4RlSmY6BcTyThu8NQov84qxmaAgdTOQASWWHyOYipPZ9uggh8D78ObN/PtZq6WQ98xxS8syv3LeHJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 08:59:43 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2%4]) with mapi id 15.20.6813.027; Sun, 1 Oct 2023
 08:59:43 +0000
Date:   Sun, 1 Oct 2023 16:59:31 +0800
From:   "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_event: Ignore NULL link key
Message-ID: <20231001085931.GA17048@linux-691t>
References: <20231001084934.GA16906@linux-691t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001084934.GA16906@linux-691t>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYAPR01CA0212.jpnprd01.prod.outlook.com
 (2603:1096:404:29::32) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 79126a2e-1a36-4622-9ad4-08dbc25cc127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCAzoYkumOXx6z2XNojFq1VlJr9QXa12qlL5DB8K4uupqFMDXEbVlkYFw+GkiWv02RVrd3zvDf6tMeCP/EpQ3nyIgZCeEFw7EJWn5NQsZY27/cSIC46hvdP/mxbsaJZWOmXBWqqa6APIZkNtsrW/vHpn5qu03ECtywNt9HjN+7MAa86UVeqo01mqK13g+NJmDOfiA1DkWxDmOieeAI3J10LfhNBfQteZVdLrfw2HlUqyQ7tR+qaHWNVU0vXtAK0GJxrrYHrocASUfgK+1OmYXtuiWALcbpSlc2NzTR/QqrVg55dQ5QSQJYab9QH4cSgK+UAlb4XZ2imK44O/9XuVbwkQqvh3MQ2QRA/ZvJGCLxF7OaZ8mMrjtjYsDJcLTX+fttE8sQQIsN8jc+BDUBk7eSEX6MtQaAttqbi+dyvGjYsZ3NI+ZinOKvsOfzFCWEksyYQtp3/LQIvyX4qo9A/IQMnvETDNu6GLXV3BT/aOEkXcb5qD+BGSPU2kzwFnnIsTDwaOVDV4hFePBExTY18CHZfdjD9fiKb4mDmdJglzij8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(136003)(346002)(39850400004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(41300700001)(6506007)(26005)(5660300002)(8936002)(2906002)(8676002)(4326008)(316002)(1076003)(86362001)(83380400001)(6512007)(110136005)(6486002)(66946007)(66556008)(9686003)(33656002)(478600001)(966005)(33716001)(6666004)(38100700002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jmqxeUt+WXuqYOzNe1Nr1ijS9QRvkFCMTEZ+q+kGf3kmyi1Loxni/iTYKftk?=
 =?us-ascii?Q?H6lE5VXzvl7ghnf9OTsYnGmlruFgNOwlhEK5z4nVv/01Uhh0D17T2wvrF1ih?=
 =?us-ascii?Q?vhirtsPiOx7eFUttPu9mb01USBVuMJ0+ZP9RJu28Rh74eSyNKtz0yJXFrolr?=
 =?us-ascii?Q?esP5cam8VXC9YhT86fDQNZdOLdoSwpSCAwAssER11fdd4ReFCAg4WU+5llAT?=
 =?us-ascii?Q?K9LNcZNh2Bzxy23af1G0UPzyioStyIutInLrGlkRHI1BvDEoIvOeaZIsuVYH?=
 =?us-ascii?Q?CR19DJbSWEF1bby4OhFV5jk6w1tRJt9eyLoYY9eO8Qzn6LLb1CAdmKB+1DR2?=
 =?us-ascii?Q?Q581L4UUM7gQiiA7PdzlR+WzBA86AYsDObrUi/IHIhjs+FDYZTQ1d+nzNx3H?=
 =?us-ascii?Q?al1ApwQCNsR4jLy85wAf9oWAg5iSSKwYcG5tkqdEjCR+TkOxDSMLMOENpO8W?=
 =?us-ascii?Q?WHiVtZd7T/aWJ6yTeJ1SzckMZFpCEZWFUMbOWSJtSw0zIFKOZHnZzOzBCjXG?=
 =?us-ascii?Q?Zmvnlzv4sZfU4RTpe2V6b2IjZc/xdPBEd5/PeWE/3DukxxwpyP+QozEnUCXR?=
 =?us-ascii?Q?ql/Qudy0L3Au1luOr/QrFVUegFABxM29M6fDZEezlWFrqstd7eba8NQReaS4?=
 =?us-ascii?Q?FSdKDXzX+AunORHNrzTc3RRPtbJLNcOJMxfw69knj+wyWVJKL8GIJ4jZuFpQ?=
 =?us-ascii?Q?dfJQVWPGj5FBEzpgU6LS7aAW4Iagx/uwD21t4Kbmr5R76MEV2P6or1nVbqO5?=
 =?us-ascii?Q?EW8BwYd/Yp9JhVmqFA+2nX537h5YhU+5Nmk/zJZ3nBc3DBVAAvQP6lQ3DRJf?=
 =?us-ascii?Q?79hFv21u1XX7WQ+cLLLz1gmEcDTZmEPK6SJ19M2pTPo8KKhFRSvq1mJnkaGs?=
 =?us-ascii?Q?fXCo28WpCckBfatBv6vtYgHgqQ0kcqd5MvOvwhZmFJB2lbjiv5Y137/+tzea?=
 =?us-ascii?Q?YdZ/ojI/Z908mLCaOLpkRMYxG4IiAIg5L0OkXDpAp+8mvmOKTz+60NkvSjgN?=
 =?us-ascii?Q?MwSJun1DzI4UL2V8DlAy8I0RxHWwA8tB56DtTTFfzoIFv3lfJfo4e7+W4TDG?=
 =?us-ascii?Q?VxDPJBTiNmy+Bk+aF+Y7u7aCvd1wbZuwaMM52eEZYBoxyNlAY77DEUeSn8zm?=
 =?us-ascii?Q?qLMvft46pBwjhrOjwmXQwPMZBz2lXiK31WRqP+fbbYoUJaRwmbrzfXtD+HU9?=
 =?us-ascii?Q?938wEtVgkqttWaQIOKKTY66rdm38pjrjwOPUGXi1Jy2nqjT+QeCr9ZYSm+SW?=
 =?us-ascii?Q?ZJ/0s33E7eJITrswjbetQRxIfv24g8LjbazYUX9CfWZcTXfUh3P5JTpgaCW/?=
 =?us-ascii?Q?I5u1Yo+jHw7kzYs1sT/DGU03EYGjb8d7vjnWIt5VW6gzGAXzl7t/x/C/6aDi?=
 =?us-ascii?Q?t3trNv2KpAzXTn46fs/Q0UP0jT4tT+xK4eKey3zlNVS3dxrFFUCkVd5xGPA1?=
 =?us-ascii?Q?isLEaMS2pvZbwcRTyiskYQmsRqt93vVJdCyxOGeaah39B0CrZUjek+02ajr4?=
 =?us-ascii?Q?CsOpy/sooinZ5RvgF44rJMtDa8DBsjQxi4KMhYTnmOwbpIjOWNCf/rKKHWVG?=
 =?us-ascii?Q?JXk2GodDNwb3OkZJeWkDgRzT8YIJgq4XGi2+Yq6z?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79126a2e-1a36-4622-9ad4-08dbc25cc127
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:59:43.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VCQOHLnbVixDqEAWJkTnaOFE3aXJBZNFQ0no2M/61j5xYkfEK1wjwpvoAotUBOr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

