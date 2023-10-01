Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902507B45E8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbjJAILY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbjJAILX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:11:23 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2080.outbound.protection.outlook.com [40.107.13.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69528BA;
        Sun,  1 Oct 2023 01:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JC+0Dsts0rB5z+ZTWaUJIqpyySb5e1W+qKLdt+sK40IF6CewUKscIvmWt6rL2vQ8cEAmUWDXFmf7W0OA1VEN0NoQd2XjUc+aGG6aPoLfe6dhYwPZ7ZOChLI0uRrC59JPnno+AMOoAwxgINSt2ki/fFvbyF+HKv/u/lUxLBaWX7d1YIXsiRFF0sdLsOdFI7tWK5npaY/nSOTZyMPMA0712RUxk6zhKZcIj4UrvE1r0cFG7Q8wFzUT682jjWcAUoJ84uFalvWSRbnmPcHxosVO5A+nIlovwJy/PGdYOukS8RzjozO7CTfk4DWJGaNU4IZe2ieJF3VjsfjqRQyHaszUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbg5dEf2maQJUv1G4F/zAIXkuiIeUoM3JSyBo3VOpYw=;
 b=c83aAftCduG3qMaFkm53CJGcSeWKaM2pe+yToYoDQwTR6g2ejFc/vOJxHywmIhBQpLvl6ECO1uc6yfwQMxx7wlHJy4OQPYU0HAe7lHblm/HHUz8X9whSS5OkaD100S8h+80fdcGAD5l0XO2QPvLln35s/xlzzs216rm/+Ir27SVcEy/yLcFUrm4vpq49q2Dl5GefJ25Y3I3o+ETPWXEHvenZ2S4CX4WLgdMbRfuErL3QsIOnr3B4UuDjxmc/kbUtPBu3GaHJFndll/dVSEQi/mke4cRsMfNGgZbobzG+9q3AvcOKPoGgvvXgO7vgxrMBAbsFYy6ez6BKLh/Ma69dhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbg5dEf2maQJUv1G4F/zAIXkuiIeUoM3JSyBo3VOpYw=;
 b=KFryhiFBf5A72YSZeQt+6otx5jtAMmgVdCXFpbZB8wjI8lsIsC5hlETPqrk50tbVp92tGzfz9PkeyB5LOWWyTAkZbPeIwMesg22Pz4hxVFfP6xy66cXZzJqRhKT6EWUiu+WhmGZ9chwcJt7fTytes4GJJ6FsyBCiWzTVFQnORddxt1/AwkYAFj37RO6XizfGKK9bwDn4uFqLcyn6863IXL7U+2mOy2mSHBfVDvhVlhj4CyZMdS1xZfJtJcu0BY/OUlEu+4OroC45NtmJkihg750xAZpX+/ZCKLOkkt9EzpixFCui768EMoY/2kPfmAMLIov2DNhekljhaFoartSMVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by AM9PR04MB8572.eurprd04.prod.outlook.com (2603:10a6:20b:437::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.23; Sun, 1 Oct
 2023 08:11:17 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2%4]) with mapi id 15.20.6813.027; Sun, 1 Oct 2023
 08:11:17 +0000
Date:   Sun, 1 Oct 2023 16:11:06 +0800
From:   "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Reject connection with the device which has
 same BD_ADDR
Message-ID: <20231001081106.GA14555@linux-691t>
References: <20231001080328.GA14494@linux-691t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001080328.GA14494@linux-691t>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYCP286CA0300.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::15) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|AM9PR04MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd61bae-4023-479a-977f-08dbc255fd17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tu4rNjTO5tf6NWxXi/yPZhe9lrpxwQzgR5BaNq5n2a7fInSt1DfWBzU7s/CRyR8BM60+t+hMc+HgMjcKgz6OzrpqmZrKiHJCiu6Jkbbty+fHf2WDL3EAlzLk95yZJOx8qP0l92AW5cI8nmNkrmLSaAmqTx0VrJVpRSPjwGD+cCuXNIUgWdm1cmpynYWqC2knfXDNmLVL5iy/uHFX8tp6We21bpJTStoaUoTt8sHPt9umGO2pf4nKdQBAqZS5dO9MnZR2LKtE7E5r2OM4Co+BfO8G/dK/bpPiQqR2xOXatnpEnXl2qqFu9uWg4F7TJWnhc6djLZTn21HKQkMNxJfThnISSnxyKYRpqI5PxoMhB8O53NR/FlnNrtTHAzH4LuPSdhu1JmD8c0nKV97ECaLd7Gh0RhnM48vI1QnPvd4om/byPWMJIqCWVsDSrUzmBv6Gd4R22ywffIvoPZob0ufzBEEBYAVHlxaw5klxVk9mRPP0HGbuBo7U7YROyzppFqwApnbdUD7KwVV+jzaxPe/dnBIdDind94sySzvGien7zVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(1076003)(26005)(33716001)(38100700002)(86362001)(33656002)(83380400001)(316002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(110136005)(66476007)(66556008)(66946007)(2906002)(6506007)(6666004)(6512007)(9686003)(6486002)(966005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SwWkcz5GaWsy+vZNH2kW3iOStQoWSja4sjFeRUcUpPzmKvoTkoUYOdrNU5dV?=
 =?us-ascii?Q?dOLjzxcOKi7LfTBUpSX1ksheS/zuou5yRS+ZdnnZp+CGa3AxC6+BOTj/fI5G?=
 =?us-ascii?Q?NJs1t3r2BPLTp7I5l0PDd/9CA0C7bMDdbyZ2z0lnlJ5FHySrEkk9XduX0aA5?=
 =?us-ascii?Q?T9r4Kfd7HtVibSRzq11/9WYwPP3oLl26TkCDCljZH8Gi/K1MJDRB2f9WLBzv?=
 =?us-ascii?Q?V2zPISbDayWuQZyjH883h1D5QrFAsRaJEpD3mI2ytEZg7K2rDWpaV0mAclWB?=
 =?us-ascii?Q?oIGLXOMI1OjsoGNIek30SkTrlLUgR8nLiDG6DTFqDagK0+LxVr7h3w4WGJvW?=
 =?us-ascii?Q?LJct7uIcfOoGFmjgzzeAumxQ5vYiIEhqie3RzeB0hEfRaFhbPCurnugRL6he?=
 =?us-ascii?Q?hQIyZR/CKuV14GoqI6SZgY8y4m8YAwGY3Jf5HuRwClfvLi0J/wxZ4kM63Q5q?=
 =?us-ascii?Q?FfFkFCir2ka+gsB4f3LwQLrzs9IgoxWrLdc4jzPm5I2ToRBQBy21Z/9CcgWs?=
 =?us-ascii?Q?4DhiTec6Fa8uzS+yW3SN5YcfYP1KO3x4jOz/+lt+CXZ74tMSgv+gjut3VAMT?=
 =?us-ascii?Q?KeQOIaMAZ+HCZJozVao7tyZQtb6rP9+kxebVd8ZRnL+8qpDXLntRf6kC6JAG?=
 =?us-ascii?Q?vnXb7dlT4ipaIcomj+eBiuJ0Lcv3ulFsAwTYOVGDvT4gEuw0p6HoU8w6V19b?=
 =?us-ascii?Q?g2i+BHLDqB0dBSFx+i0Nl19BJtmkzHZqEzMLmilJT0lLIfxYD/cxtV8N4yvt?=
 =?us-ascii?Q?Y6kRIhKyU0oa1N0jADZru9Xf08Rji5EuD4lR/if4XrC51diAGaiIAJx11jiV?=
 =?us-ascii?Q?gNy86SrBCb5j0hx3itzsej4JIhIttjKP6CjsflZyUofaTV5+iDuSI7kOIOcb?=
 =?us-ascii?Q?YxJiqARU2xZSqhU6H3LDKja1s4VbAV/nGUdD5V9eXIaMnuR9fAbBfIiuQ46J?=
 =?us-ascii?Q?nUr7vgqRNlY1bOl/wIPOI6UG2x+quMDCAU4w9ofEYFLux/hy1uJs8YoHPPyz?=
 =?us-ascii?Q?Z8XVnYgOW58CzEtPggMEVIvNWKb7PRbOGlFtkSWbwQhCBnHtFI5m0twGpPye?=
 =?us-ascii?Q?poJ/iNrcFz/gsdEcPXqZugx/kPwX9cfI7mhdqlUjP6Pa7WH7bewXVD6aF75A?=
 =?us-ascii?Q?jMSGJJDY7L0qBBvuhmi0l0pkWV1xbDWKOac9ef72QzwwAz5WieUtrMA5Vagj?=
 =?us-ascii?Q?KKVph7CO5WTPU3A69D4G12m+tB8fwesNxCZIn6LYtYQSOGMuQRiKzhIA4+M5?=
 =?us-ascii?Q?bZf3XH4ACTLmKP+RxZNG62DK8SY1QeZUQnA6qgTvzZVptIxhUvIeGLPiCL3h?=
 =?us-ascii?Q?DB/UATeX64a81I7tLMgFBbtk18ccEXzysKc6AD6pwppbdi9xZWJN+ELisALG?=
 =?us-ascii?Q?U+ilTTkmQpKeTJmJg0L3FZxA1NGRx++au/UT7oazvuBmxpSZprjkmpgoGo3y?=
 =?us-ascii?Q?03NHqQocQG8lFDSJFtAm6sGosCzp3HLn34phIscLzkrAOivsPMfmU1Zh2b17?=
 =?us-ascii?Q?yvEUe/wgZm2psE1keYgnH08maAuCf1YI7yOdqyka2KS+BBcLFQA/XEsY22LT?=
 =?us-ascii?Q?l5Fa5Whyu31w1rrkw8zyqm07amEscG59JMJmFZl8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd61bae-4023-479a-977f-08dbc255fd17
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:11:17.8275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HSgVtOENppa7Eieudycuov98sI4UEhauleDy2wypUWO7jcG6+G+ZSQu7bHDLste
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

