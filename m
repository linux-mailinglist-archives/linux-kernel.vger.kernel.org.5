Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D307B4667
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbjJAIyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbjJAIyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:54:45 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F0AB3;
        Sun,  1 Oct 2023 01:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khqVfzTFgcJ0vjOHkvRs5QyCcymLg8pmZH7Owl63LP+CLasX+zzdIhQTJZPaHTum+iT0GczTlkFJGIytNuhZXYfyVMb7rcplnvVUZgiIezzNJ/7IuITXK25lrTgtqXDZ5ny+IH95RjA+k2lwr8CqsOQYlDGazyG3CEGCra/5f4bvb+fS2xPpc8aq5OaKEOjNfNFbRdpyfFP4HgwCxlycRmoZMAvDd6yRLvvLZVVd80oFod+azLEe+MhmzBkZ97JixBLwf8lOFlWoVAF3TRWix1FQxcen52e7TRlgOwd+VLL7UrH0Ssbvj9zHUPoiY89G2DmxG2/dyICnzvKbQtFebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLwD7it/TSK+76lV5tq2KGOJx5RfM+Z883h1j8vuQ5c=;
 b=XX4uYYlD3gQ+RdXeWSLufol4GlPmCEyLLfqBs7EorgJ6yusOTI43nlsmK6z0y+ovBVwF4jBHdsL3BWqcORVyUz9o1nyDSSr7wfTD/cRMky7mJ8PXIsp93YsyW8kIrzFxcuWiSJTquC1pFtkRQ6pUdAUIZbaAeDFl8G0YhgRgHsbRh9noXNo5KXaB4VFd8l0SlhulPuRB4XW+RDwH4Gj4qZqbwrLfBN7uCXLqyBas3tU6uMGQBT62sEwiW/7FHFesc47tDB7NMjQhiN1FQr4YPsfIGrPImz3L5vC96jRCUrqFxJ8wKjToZUnjNnqCbKdfacT5krytMZiq6qU74nUcUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLwD7it/TSK+76lV5tq2KGOJx5RfM+Z883h1j8vuQ5c=;
 b=dXeg98GKsjvXSta8TJmg/mqPL1pAProVCZl5AtnTa115ufgQhUv4TbbEHOzS0f5dpaMB37SZxqKLvNJ7/6mDDvYM6E12w8Nj8F4djzVWpBkS8twMDHU1IlT82fDKvxPQ7Dxp9y0EFDKw80ALqVSpj0EroqT1XJfMUvsRSTG+1Hx/hQH0X6D6HblpRnlyMa/pRCy+aec8EJE+DlV9gdYjlEKMGujU9Xekdr9ICCD+KbLnOS97nLjM3e9yHaDob8YiqBRA0hLdj5EVAE6XmtqcQ1tOOUkTXT2qgNGzStVCCvA16sAo1Ve6ZJUeE2E57u312nbOtnCoXx/oEU3yVvIOhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 08:54:40 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2%4]) with mapi id 15.20.6813.027; Sun, 1 Oct 2023
 08:54:40 +0000
Date:   Sun, 1 Oct 2023 16:54:24 +0800
From:   "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Reject connection with the device which has
 same BD_ADDR
Message-ID: <20231001084934.GA16906@linux-691t>
References: <20231001084934.GA16906@linux-691t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYCP301CA0012.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::10) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bfa198f-a930-4358-ec28-08dbc25c0c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJZvAGu9dIcB/7hjzZvghhz1Zh4/M0pZj2Tg47ZjIs+sewOcz9b4CY/QPXiAcmTOjU6kyXayX7aleU2UP7kj49myFC/5fHIfmaaV+3GfOdn6TdDJ2lj5sgnJtcJP8BGmZywiwnkvbFgiOEhmTEB9hzrRQ35p/s7YrdT5GzobkQVdJTY04JRc3iMcVqD/BC04EIo+KKPcspmlfAZFxE+WKHEMTzTyXbN2NWn2O2zL6dd8gOzJIQH9+K2gP/q/l33EYvPwYVHq0alOHP9m4SSSRzCJ1dAvT3ddQWupsPsbYYhdx9GT06lZUtKuiVH2THUtSOaC7wkJCu88Rmu+N8fgf38h2YyLUPRqFa3JCWKChHMyofqx8f3ecShym05TPDnYRcRUfX3kAvP1GBgVp0hcxNzK7ku3Y9olxpTuNRvQEYWMaK20jRWKK7iJvZO/wF5jMRcJns+DzL9NJN/sKanDqDx73/c/harH6DY67zW8FUzyZEeMpnkoU+G8h967KA3reTxYjuHrdIaOYMOnVIoDRXYtsAxTzhUSg1SJ04jcCvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(376002)(136003)(346002)(39850400004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(41300700001)(6506007)(26005)(5660300002)(8936002)(2906002)(8676002)(4326008)(316002)(1076003)(86362001)(83380400001)(6512007)(110136005)(6486002)(66946007)(66556008)(9686003)(33656002)(478600001)(966005)(33716001)(6666004)(38100700002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hlNfS3AFsFMyLnk5kqq18aZIxx15JfWI/yKDPU6FdVf8sRpcM7wnJW04F0wQ?=
 =?us-ascii?Q?btMQtWqboz84ipSgMDmbnT+eM+vG0CAwx5uXGu4OB+bitLbbaSJQwrm7Y2we?=
 =?us-ascii?Q?wc5T8zU/0LmlZKg7i9z2RjR7Tj/8eU7cO/3dWvxweVojhq8S+xBgkMMj12gV?=
 =?us-ascii?Q?Ns2yo49Vb1YkM3FY6O78LvVJo+dncOJVHYIuqPqutCdPPBtx9VsW099eSWMR?=
 =?us-ascii?Q?6nBYtYPDLmh3B1UghbcfQjV+8lUjosWkq8v800fBBAm6/0l8rA4vnh0Y+/3n?=
 =?us-ascii?Q?GCNIpqyRsebvtLVi0lHyRRU+ygE8wpBO6B2FQV1z712oAofAVsgo9+febVQB?=
 =?us-ascii?Q?iW7yox0RLB/5w3cHknia8wMk8Lumvr4enouXocWmxECl8AA/qKdunFtOL3ZD?=
 =?us-ascii?Q?APQFrLMWTO5YVgzmZtpeiTFzSpF0SARYEUcZ0hthb9cLfctgOs0V4OM9V0Lx?=
 =?us-ascii?Q?CfGUtCkd+mJCe7AjPf/lGw7sM3DiIDNUvxtlHMDTLuo/jhrEola5fNHpmkTo?=
 =?us-ascii?Q?hN1QBJ//vqKATSDLt21obhXsj3H5NDrSJRJSMcEE4spmLrRae8lWalKTDqaX?=
 =?us-ascii?Q?25uZZbPC0/PEzm7FpQILxV1crY7eijDXll+U8XRguz75aUiRZNm62IjLGWv/?=
 =?us-ascii?Q?u4C2LNM7qK2ZbW3wKXHWg/2iydYkF0xEfU0CtG5xl0ybDBDNLk6lqS5F7xjN?=
 =?us-ascii?Q?q1toGe+5IMsu+eQ+Lx2iohSiTBBSeVH/R6eX3AHK3WApThw0zXbAhOWf0sdf?=
 =?us-ascii?Q?HY7QAobFzAG+nCqZIUZG2bBpZ65J84SJUvVPVJpERr/PoH6+bCeCBFy0Bqn/?=
 =?us-ascii?Q?FnjjyxPlcU2Aldw2d6u9NFyicFi44kBTaGPpKVMg/thpzUDGW4hBy0me8qte?=
 =?us-ascii?Q?YBycMeJQXMB1ddRuPgxeOwiPNpLoGrVUkuDwoxJoa8C3edhn8LCMh6vq9a+l?=
 =?us-ascii?Q?P6Nmqk9yDd2mUiNcAUm4MKBqEvgZMpnz5U85n5WaaqYENk9sf4O5sfMVx7qI?=
 =?us-ascii?Q?MhQ0FJ9fqr2h85K3509pInYwM70X32vxoaKs0OC8mcr7QLxtp1c5/yixKHuo?=
 =?us-ascii?Q?X4UI+GtjcWhSMm3u33CnwIzgciRyJR9q20NeZ1v6oQUXhNrEIO9RMRbHv3FC?=
 =?us-ascii?Q?L6XJY4TXaUvTTmPjqYRvoiGUbvb8BHdcURoUZomMXjdQRcarTPINcVvSUEb0?=
 =?us-ascii?Q?fVlx8Kune3Te7lHCXJdBhDj9++WkOYCBKiCMih/5Egrf2NHbB+mn4pOqakIr?=
 =?us-ascii?Q?sunZ2LavaRik71as/PdMlGcCQ0HGch4lhONGZSNtnjLvrJQTrn6lBKE7DKC+?=
 =?us-ascii?Q?yp9lId9MNfeb4pV4+l2xktwO/Y55GFjbjfCyMsGCGX5sK5aHCP+Fmn4JGx5W?=
 =?us-ascii?Q?s21hSOgDmPt5eyl2pzACXxBs65XY+7l9wn3ff9D4rgj3Wl5qQV2IusNYqczB?=
 =?us-ascii?Q?sWFDznEiHkbEJaBqf/CXCjcTF/ADSgDJkPREfL6enh1MH+1xYZPLul6uSZeC?=
 =?us-ascii?Q?uVnVm0T4gDgj2XhLv2dBqfW6TiuVkzhldwKkQuWqBqjQWa7Z/t3IWU9OJNG6?=
 =?us-ascii?Q?WDs45WEy7T28KmN9iE0IYCeMSXx1BIT0S1hK4d9P?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfa198f-a930-4358-ec28-08dbc25c0c20
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:54:40.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SarPna+jgjpJ+l7XENCMQbKC9Sr8W0NDFE4I9N24LRccKdu6O331jqwVV3/BI78N
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

