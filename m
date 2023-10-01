Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5373F7B4670
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 11:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjJAJAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 05:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbjJAJAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 05:00:15 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD207BD;
        Sun,  1 Oct 2023 02:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVXwoLgAnd93Qor6vrcJkkdKLDoiV7oKsOE7+MxG3KsdgZaPnv1mdI6zZRfo3TXaaR/6sUXrs7fFhX0syIGNKuZBgtBt4fvuoDoNE4sYzZnDy7tu20hhHX3YJFsHmq377++3NYRKEYEEOVlO7G2NYTHC4l5XsXwNFz/Po/i9CCXd3XllG/0ahfTuJJ0aODgALzv/vMv4rmUQ12gYomAycA+ASZEwFi6ruEh7pZs4aKNB9MACJzQb1o44Hhv8f2CcqWB5LEq5CD4kW05KEoXX7JbicHSDMQVNfkZiRa+4mdujr6hcVFBnZzNic2vaztIybssphDG2ugEEFQpklVq/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLwD7it/TSK+76lV5tq2KGOJx5RfM+Z883h1j8vuQ5c=;
 b=eQA85Cubn8x5BfzT5CW9llzCCP1Nh8nHzk/xHc3p1kJejv3hQB37/UkZsIFWGwPSDbWIQqY+qzsG03l4JMLXBtATMe1rF8/q97OabKJOG5l9TMN0a2iBvTqvWvfPGalgOqVaDV5KFGReGlluiZD0oA2Wgtc5fe8tCXomlauKj6B+LBPLEj/v3cZPXlR0A9hxn05tV95QgLlKag9d5XVBdUNpz2hjhltqEvQg0ALMfko1CK+QnEMDAudDxTezZa7T17yJdgTLnaRYcOavshqLNd15q4DceStl5VR4b9V6YrbPeYK+8LuFVnIpQjRaUHkNKANU5ZuD0AA0/7stHyhPug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLwD7it/TSK+76lV5tq2KGOJx5RfM+Z883h1j8vuQ5c=;
 b=RwCDIhXcKNJmH6ziL8aELpdMYOir6yfriG/OZfOM4Pi6Edyk/ViYWc9mKtT3+pWS04s+V0K81ld+ju0WQdSO9eiZAWJEuVz3HZwOU4r6u7rs7S0SlRu+9ySwlI9oH8YEjLjIW2nUZUTb6Y1/B2XhDPUzHtM4GyvzO0i3YM9JBljotGYQch+c5qQVmkWeGt5yduIgJfuD2EcJbAc89enalhJR5fURdeDEYWd+4eL4/l+UxgsKIH+kE3pxJ9D1OeuaxdERT4Kdd3fomGR8phrHTO8yqnh3WFfF+UqGGQ32bbQyUU+5tNNumtDbtMAdq7SpgAw7xHUwKSAjh39UUdQDpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 09:00:10 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2%4]) with mapi id 15.20.6813.027; Sun, 1 Oct 2023
 09:00:10 +0000
Date:   Sun, 1 Oct 2023 16:59:58 +0800
From:   "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Reject connection with the device which has
 same BD_ADDR
Message-ID: <20231001085958.GA17052@linux-691t>
References: <20231001084934.GA16906@linux-691t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001084934.GA16906@linux-691t>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYCP286CA0221.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::7) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: abb63cf1-5bf5-48c6-70b8-08dbc25cd130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaxsbfIJzMBxgvowZUaTPXwF0d18OG7hZ4epSx+0NBjzm2Gt/UwnV+7Cx7Z58EK4HWq9nxPrYsJ8xxsYHmq/aeYzOLRcf22UMi8HNBK2bFQm6mzmYwqdkDSJZqbHDTDtRv1Yzi6DrRcrOxSsAl+bB60RHbSKIzR0dP9NNL7Ot1UexhUmLAWjQW+yD4DIcq2vAxER4EUCpeP8e2puG2X1K8lwsifVvc925uztPtu/1CegwRGFtF4bU+wCyXo9hg9uiKfc3uCs3L6JL/BXTw0VHgmgj+QtvQ/E4kRNJZn5O/2zk8DUK5Yd9Euyio8d9TE31RB6FWvtuF8+1VXHVUviKYD73MdykOIuGzy3pxLtZIlB0y3sHK4eEB9ZdV0g9amhHbh2HIqFIz6KvWHMJ/zZ+RMsgX0uZOv+y7qtXPJhN1js/V9dkY0Wv10cDhlEnDuSe5Wkfn2cN1ky5OeMdBeIZF9nIl/Q3tqAxfxriiihLsvz57csgv4Ks7aJjQ+NUaQg05rgW9kJ6OpAiT9qYKyDO21XROPLn+DvTmSKduakFhQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(136003)(346002)(39850400004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(41300700001)(6506007)(26005)(5660300002)(8936002)(2906002)(8676002)(4326008)(316002)(1076003)(86362001)(83380400001)(6512007)(110136005)(6486002)(66946007)(66556008)(9686003)(33656002)(478600001)(966005)(33716001)(6666004)(38100700002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?duQWpZi4uVhOGnWWAkmvLG53lutLdKS/a8vYzPNCxLNNa6tTWpYzMrWTj2Ip?=
 =?us-ascii?Q?hxqKp25eRPy/ffOoeuQtc4FoIXnxh/cdxtwLKLbR0NkijsF5UA4y6Lh8emg8?=
 =?us-ascii?Q?8DB+kLVqAMJubCQtEbi20uXUaCwfstRz77z8hrvRbCbmIzwevFUXheL4kUt1?=
 =?us-ascii?Q?52FSjHY/S16ROH9d8GqIJ9VvvklUQRWhJ5V39kSwZS7qXRkoKSIiGJruYqgB?=
 =?us-ascii?Q?mjxXCzg9YX1xKa2YaNK9sO81d0z7hdTxzVioB2K35tArELQWsWf4FcJtZVoV?=
 =?us-ascii?Q?BaDAlZ9KQR1ZkE1/pOo8Dax40cdxFCdTpiaMjGYAT/+NlSWkn8czZTOi3dmU?=
 =?us-ascii?Q?pbg1BVw5swtTs1EeuEx3CemV6Us0R6nQeBU/i0esKUrFD7orPiM+2TISN3hk?=
 =?us-ascii?Q?lAXENnaHjunumb0s2KMAJTBREnj0LqPgcCMmOk3gHNhzA2k+A8C1OqIkYgyP?=
 =?us-ascii?Q?gefIF63r5whPvXar0r7wLXwwl0sJ8PnZ+/J5gutxx/I883u5ts1ryYLwus9X?=
 =?us-ascii?Q?WRHzBBT407DRzl76u6u76BdrHFZH8JHzjnoIUjetD776/AtbHIFjQnrkDHX9?=
 =?us-ascii?Q?BFct/LCvWsJWk/YAc2eJALTyZf6QnX0TKYU/8BDB9nD6aLzgoLLxeJats+1r?=
 =?us-ascii?Q?yvjrvRJcHySKv05WUS1qMIOo8WkfM5d/jrCD6Tr52wtkssix5E8r1IjstE2T?=
 =?us-ascii?Q?wQQRkunBxuVMSbPKMh/hfWL6tinJTRpzRF8qcLUOai1GX+nMDlkPNTQtsJIV?=
 =?us-ascii?Q?w5wDJYlZMqujb6W42HW55oqWu3wkzwqm1K3ckmZVLXpugLHW5A9hruDIeQWP?=
 =?us-ascii?Q?F80RZ22W41Xu/Y4YulElwwV8fVDo/M/o13U0T7c1o+IR8sLC5yy6lptez8Xf?=
 =?us-ascii?Q?KPXDuL9vsM6fpcTusgVd/V0Iv18vn0zF2QKP4bENlcTdroCfPIyHsmK5/C2o?=
 =?us-ascii?Q?z+PeJPv1hRQDyxqbq+G0tTOBIun9EelVB7lwDPcVek3Ik0fGqPNxFye6MFAT?=
 =?us-ascii?Q?iamWoIhiAlfkD0Bswq0oVQx+7+Pu8sIZPBGaWu5cSpxknKJJo5p+aEW0KOy3?=
 =?us-ascii?Q?HDBUmDDRj+hkiBufCo8StaZuf8+UkEO2mnHYZUWFurW0vsjXLCiS6roIncwl?=
 =?us-ascii?Q?q3MuCJ+MikGSVXfcWekndhCWujOauYX5cyZhoRWM8isUl07rzfJUyezcKcmH?=
 =?us-ascii?Q?QIzx4LltedhrsGk52puVEDyTQAYyRaOCkRdYCJG8Vwn4nkjavcbL8rUlARhh?=
 =?us-ascii?Q?VvZMaSAmZN/kh4/YJNkskBBV8BabLqxHuli26MMzA153rgf7KP+TZaBFlCHW?=
 =?us-ascii?Q?MvTDNhIms/7H4/0TkMgZRVyOoMOmOnZM5pTuT64MQ3sjE07MITbbutgGcnew?=
 =?us-ascii?Q?NjaKSkV0ljBUGtgIMTfNusuVthEBB+lXTwjc3MJ2Q3tjl08plu2KkhvKsPy9?=
 =?us-ascii?Q?0wDNMJdGsofRc8oJuktoGECgfE+MEv5nEFEi0koKqNqqk4tHb1iJc257/XNs?=
 =?us-ascii?Q?GCbjOG/CqftSr/H/oxFDh7DVp1R76I3zes1AvETTAgmvN/qW5MlkxHTn1RJp?=
 =?us-ascii?Q?OR1nsae/+dLWp7LS+w1qj5gWEcJHmBntKMLx+e3M?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb63cf1-5bf5-48c6-70b8-08dbc25cd130
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 09:00:10.6873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBRiIaWf5AUVaI6fShZM5JBvL88H0OKbztsH5l+4dBocpWjCVexPVatz9gNjXxyK
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
index 9d5057cef30a..21c831f1fec6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1627,6 +1627,13 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
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
index 2830abbdd329..df97dd64be6a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3267,6 +3267,14 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 
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

