Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C9F7B45CF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 09:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjJAHpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 03:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbjJAHpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 03:45:44 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2073.outbound.protection.outlook.com [40.107.14.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FA0C6;
        Sun,  1 Oct 2023 00:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ry1b+7eSROGlSFEH1MkBb+XT3hWpciae50uu8g+drd+4GzhSxVHb7+1MIPqJ7HAaYPsDBNMWbIuxPVfwwwZmDrAbtVhWJOzs01HqlGhBHB9KosT6cxSjf91Of6EHxEfUdVfwGDK6iS1HZlK3bmalZ3j1sni6YXjnuFwxJytekLgo6XWGnD5d0nF3kIFm316+DpMblERVDFeoTafp4XJfMCAfbOv/tLe7PjBQunWO2rW58gYNL3sYkujE0Pb7Z6VNMRqTc5X2F4uGhl4XF4svZlSrjv8o/I0CBq7Zt08wyygPzJjREFUp0orN3H5+mEcseBlLLYxm2tU4SnK0nVmgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mC00CyQjw2PbEiGh8IWOCl9Yhv+D+asdXu/1h7YCibI=;
 b=n59S9S+tfynoIKcgTp30x/lGHlfd5SFLlD4XqjlyUc1/NzVmRFQLHH6/RlO5amJ674H4EfC/7Osguik95/EkaJ7WiRH8XJp0K4cgAeCy4RGCD92YeIUDtcWktjCvdKOHxsFAcFt+ZbAHm/ETCIAcib8OojWZjOAsXyzzNf0MxourRfekwSD0fqJNVXXjQhla3JcoqNhK6DEk0jOHZ09RH4qFcNYFUlM/G1QS8HJ3sImm3lWrjEkKjPtvxr+ib86/7n/DiouWZy+eEgknuTMWwkwdSytvSwVf4lmbjgHio/HkcFiMHtNMiT3FmhPiCR7WQWgc7ZY6+HYO3WdIYAWJrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mC00CyQjw2PbEiGh8IWOCl9Yhv+D+asdXu/1h7YCibI=;
 b=pcgjatRkkqipGLvJTOxzWgDfkrxP8wrMzIf4ZSJF/dkUNaOEnOunNclYKOv7BilM8HGIpENuF2rw0nFbx2oJp5HzMCWtxfpSPiFtCA3Sxdohfu5Bh6mk4pfasPHvyi9BnVOuvcMPM9lNygETpwOGfMAK8+fY1cx7/UFsPiOId0/A00/v0uD6WzOW0MTfBxCjgSA3dwhPux1mVFFH+6LhbVPXKtOQC5CoMu3/8Ux/Lur3HLA6azJYkgGeZH74YY7G9AvVzwW+z0buR0op+TWV3GRXGnnhhkcludqIESuyDVMcVZO+TDmpCJ6NJWWBNDbReLcyJ5Uz8ahWPTfuse0nUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by DBBPR04MB7531.eurprd04.prod.outlook.com (2603:10a6:10:20c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Sun, 1 Oct
 2023 07:45:35 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2%4]) with mapi id 15.20.6813.027; Sun, 1 Oct 2023
 07:45:35 +0000
Date:   Sun, 1 Oct 2023 15:45:24 +0800
From:   "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: ignore NULL link key and reject connection
Message-ID: <20231001074524.GA14361@linux-691t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYCP286CA0288.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::16) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|DBBPR04MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e391341-a4a8-425e-c796-08dbc25265bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rEhZrE5LvmVZMqlL00TYQjqyXQ1uSOPw24o01yg7UxQvXUb/HjA8TQ9wjsAKom6aDDQY+BlUa0oCNpRt8hHpRSqO2fU9l0aWeuX4+8SHAZBP7xHZpo4kUXozb7NZ/kBK9+YOS0LErWFmj7oyZAmDHJaFxMiKFrXcK0TQDPh08j3zPrU2Px9/OSnfL0hgtp7LG5a02thkiDwqmdpDgdoEnEkSZ1RagT9lFwa/xpHGN8oQuVePv/ZRlSf04TqX8cgikDYc0Mmy4o6mcluMYE2FTVTQ0nisRecUFB9Klcm5E7+EAmD00cJUdH18sxxsoYqBqnSDQ9hWvs38lXKdCESgM7tLJzlywkgu/wnxuV9YDcrNW1B/F4jowQuP5heDiMYcgrteyL0JpRBHUH1VcJ5xNwlpEswiUCwmu6kuSUSBGANqV8Nptpxl5NWavo2Q6H6fbg/Pih/YeC/IZ3zvLOYH7l/jzfOK1B9vwpD3jB/snPFgcWbWJsNSrPeQoX2Yg5IIMPysR6XpgAJHqzl/eho4B9s8xmadMdO86CmtMV6ImXs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66556008)(66476007)(316002)(110136005)(5660300002)(66946007)(41300700001)(966005)(8676002)(38100700002)(83380400001)(478600001)(9686003)(33716001)(86362001)(2906002)(6512007)(33656002)(8936002)(4326008)(6506007)(6486002)(6666004)(1076003)(26005)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eunEA6+T2v6pG/PKvrmHhpWCYa3dZho0vrrKLtNG1eAMQ9sC+Im8piKuEKra?=
 =?us-ascii?Q?QGvbjoXWdNOAUqi8iaLbjNZlJ1swfZp4WtMhFuJy9tjGfLayTavcyl7Gzr3J?=
 =?us-ascii?Q?qG7DFIVynxdaH1sJaLWJ7efkUCphn2Sg8n8bp6xCBTzHPVMWwZG5BqcYgsIp?=
 =?us-ascii?Q?plrA1gPcibdAUW7PeTYGxXrqzJUNMQXcaEKJtsauIZX0opOheU7nr5bbSGKK?=
 =?us-ascii?Q?zzQYOFu87GaT1cznwWkrL9eaE/h7r3C+35aorg46dU0POweLpgIgCXVrMANH?=
 =?us-ascii?Q?YCPDfDelLlpdOXb9Gdps8mOu5UleYMEGeQTllZTul+iEK6jkPY2fLX2izrBe?=
 =?us-ascii?Q?wnGD5vXJndNgloOCn6eICo/BrT3xJ5scd+Zq/dqcJVw4waM9kQdiUHHZI1oi?=
 =?us-ascii?Q?3OJNmbZbw1G3e3RuHGpEzNJNs+RLadDWryFU1Fj9eqHL57EFDCYMlBxmJW19?=
 =?us-ascii?Q?bktgK6O55Ytu+k62uddvSj5sIMakioGbw0JZTuqjKYeqvEmMUCw07zrtkhLb?=
 =?us-ascii?Q?wEgzlfB0PcGc+Y9rZOd3LBeYQIil3uQf5uKNSUrAlH1gbytu/AkARllfdTem?=
 =?us-ascii?Q?apnMrm5Imo5DOgI9VQB7PYblaVpw7jkLwInj+xS6B1NMo5YU4zynnC5ishOB?=
 =?us-ascii?Q?26KHv+25+n42bFa7SvfyjiGE/FAjD62SSklgSYuKBDC/c/jGsMKRrkl3d4/i?=
 =?us-ascii?Q?F/gAfHJ7xROUL3WSAvbV8CJHUdE8TKEn+7NZN0a4orHPo1fThh2SP/bVfZYx?=
 =?us-ascii?Q?E4GotrL+aSvRBvI61myCkonat/KXhf8elVNelYE2tfPsOEbSreIhKsdSoNA2?=
 =?us-ascii?Q?TVV3Zgf4bkrnrgDpcfXvR5nSz+oxmrZwVkZvFXu2cZm860NikkERbsS6wfn8?=
 =?us-ascii?Q?RBITMdubhWYbt5niDeE9wxncFtQaG8rV0iU2HOFVuKjEmHCViDbs2O4Sy5yX?=
 =?us-ascii?Q?YMPIOKBR4CEXBBPz6i0Le8z2njZQTFeuiFPR27HPdog5/1q+0ZTTh/bXHc95?=
 =?us-ascii?Q?48hOsuJbfjmBYtjdx1WCOcPOWs/rLLGB1pue93a7kP73I97Uz/ADCyIpvwMA?=
 =?us-ascii?Q?aAZ54ywOAL1KVlu+lvmXtjKDPgkR7eT97XUUIhESXPMrqkgloDHMA7cuttIM?=
 =?us-ascii?Q?6lnbMRzOSpwF0Ne+9NZX/ryubbu9W3P+Qai5m6WMrg2OMTzFIsI/dchteQvW?=
 =?us-ascii?Q?a2OXvmLtfRhxRT9Wa3ovKCrl9pettCUf4h0iz181TnKmlL7RXB3oR1v2/Z78?=
 =?us-ascii?Q?XRZbvP0D5q3Pz47itcuomIjvWUTiVNEvSoeu9DrKwHp0ykvTi8L7HRBHCSXg?=
 =?us-ascii?Q?PhbBvcThAHW6yrqIVBL7FVKUbdhFclMxIne/qxXTkm/oEMlAq0edy6qH9hi8?=
 =?us-ascii?Q?MDDjCKK668Y14tuCkcglNwXBfF5DMd68YeH4q9vvvvM4DhDXUDMRepRj7mC8?=
 =?us-ascii?Q?tLEPiIwgo5WQ1WFDgo6/TXyvEOM+KgVnpWb7HgC+acB9rDl3XMwZ7KuSFD9K?=
 =?us-ascii?Q?CAI/YETA8z8jU9zV5pozuFToLC/aQ/mc2WccA8WC3BXOkGPvY2lBIDgnlfv5?=
 =?us-ascii?Q?IV/Y/n2efDqDBSZFARk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e391341-a4a8-425e-c796-08dbc25265bb
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 07:45:35.5192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRytNfEOuzwwB713SdoLdxF/D8F7B3mnckbUaZSCl00asfVXv6vizxtpIZnkVho3
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

with the device which has same BD_ADDR
 
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

From 2c6cd3f353d21086a3163a9ad461789d203a7ee4 Mon Sep 17 00:00:00 2001
From: "Lee, Chun-Yi" <jlee@suse.com>
Date: Sat, 30 Sep 2023 16:56:56 +0800
Subject: [PATCH 0/2] Bluetooth: ignore NULL link key and reject connection 
with the device which has same BD_ADDR
 
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

