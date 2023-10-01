Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9545B7B4661
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbjJAIts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjJAItq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:49:46 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1E3B4;
        Sun,  1 Oct 2023 01:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZW0DV+Hd+rJOkpaelHM7xSUtq6xuSFmHPEWkBId+6AVDT6yArjHv9ApkMhgUWnf1fHyWOOdiQHUphOGfDOFSWj8S8FFCFVG0aTsmYlM0S0kSJuhUIVe1KyqwBxgQZ3NIj+HYnu2CZnguMcrX54PXC9m4YwQPq2FNQ2dtnA0uEBzxyIwv/4aNK3Eo2I9xukP8Y8S7xik8P1UWp9Js2k2DXHUVYvn0hmk48jBQWza5jrh40xaRA6WHaQOy1r10pgalvFEmmwG/+u/G9x660Cv4T9iOvy96SFUWcNf5/2It301K4qZBu3wp+n8sVpxmuykcr/RZ7+2JvHix3N5VTaMCSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usDYAF7/Uio4et+c3RkYZX2RrThASPQaEumJNzznkQ0=;
 b=Er75ThYR2MzzBr+TrWVFs+w6d2Vm2VaBKNeqjp/F/LbLJ47lEIpY2w2nKxgiAvEzwJ/qH9LI5KA7ttQixVywNu6V8DlMQnosDmsnNzlXFVQzQhMFnFy9XMnPUjnbk0qeKKta4UZl5v0QVfzFFb168WFl75+bpHvk46ay4XKFOY+FDya4Pumhr5U9Fyz8kKbMEbD2mAFi+StG7mYDkNkxK3LlOj8fu0v+hq990uQDcfy+MvgnUhKiGVA3a2pK3AmLADNYnTUwyau6Q6g7gfrB8WEWMNZEnSTuJhHLCybpzzbkRGjJFUgJPkdoniV6aZ9WKasGGa1aSOgZv9mpAY7iUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usDYAF7/Uio4et+c3RkYZX2RrThASPQaEumJNzznkQ0=;
 b=sc66DwpNuTRHF2+cV7bLAJMQcHpjPMGGIKupaK4LRQylc0YDbavBqDa+BT2bszMlc0379zDQ8YfizqYngTQ3R5Ivt3kbG4AJz71PisRMtvxyqgt1zFPOWeyw7tRMfQynqkqVP7gsakie63qInJUdz5ZFZPaDaWrFByFxW4MNOf8zs+5cx2v+2fE7GOa9upDHkL7aoR0CMlBPl4KoLyLJX823fAvNha7PreIYOJey6/LZT0k0bUQuHEoAR7M+/jdY4CXcBt1YfMg0CkQFtM/J+vE2waHC+tNcYBbdo0Weo30BdmaU9gX8PjdDH5sVjSe66UNWQGa3O4Q2C2yaunovjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by AM9PR04MB8986.eurprd04.prod.outlook.com (2603:10a6:20b:409::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sun, 1 Oct
 2023 08:49:40 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2%4]) with mapi id 15.20.6813.027; Sun, 1 Oct 2023
 08:49:40 +0000
Date:   Sun, 1 Oct 2023 16:49:34 +0800
From:   "Lee, Chun-Yi" <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: ignore NULL link key and reject connection
 with the device which has same BD_ADDR
Message-ID: <20231001084934.GA16906@linux-691t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: FR2P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::13) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|AM9PR04MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d08ddf5-adf7-4232-2f2c-08dbc25b596e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B45zzL+hacsepbz9Th62kFJmFrjBwBtLUbfduq80WCzG7OrdljJH8muTIAOGOpePSeSHbL8ok8KEIqm41w6ZkwaDNI9nUjG2uM4ib+krkxAXd3eJd9gbqWBFWoa29bao5Ys5dL/v3TaDO+DiQLNgAMO6YRsled8k2/3gbhBxzalOjoL7X6MGoJJDimRrSbHSqZ8KpSBE5+MQpObhhXE1VRHOzXg6UjV9kc0HiKefyk3eYnXp4qYNqPOb6VEcdBn8ra59RTfYmTiApnwo42LnKN7jYmTZcmQK0Bom4jBZQ3aRaE/Rtl4e7qxVBZteeXGQuFw8A3cgdAAPyXkyCNKtQWVoO75zNKmKzhiXNsiNAYulpDPS3DSEjVGksuboarYZoAGZiExOaylgVZS1SkRe7Oe1+n6tdvy7iTgDP53rXjFSJWV4Xhh67Db2WRPmeT/UCOUsd7L0SZY5YSgO28t5uJIP4EZMboXbRifL4f30MasCKG0D7XmzgaRJs3tSuw9gzg2GZdHmF79HyufacYY7MMwWLK8OOUQQ+zP0NJouQh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6512007)(9686003)(1076003)(26005)(38100700002)(33716001)(33656002)(86362001)(83380400001)(478600001)(66476007)(316002)(8676002)(8936002)(4326008)(5660300002)(66556008)(66946007)(966005)(6486002)(110136005)(6506007)(6666004)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aN8MLYD/a81g8Mwbyg6czQGOqEuejRaGg2KbFQj5wv0pxhInW+lj2nIl3XgH?=
 =?us-ascii?Q?R8UujJvX8BsiSYeavaxEX8IKrrwIXKg0Pc2/a6E88zM/64aKZdPBepSkHkRX?=
 =?us-ascii?Q?Ide1fLRSGWcjLl6x8BipyJqdq7oEAHr8hyKDzktSbIMw+nzMGrrvBHmfR4x6?=
 =?us-ascii?Q?O4gKwiXqSrQgi2VNxjYsKOpZnR2eWgPcaRL6zNicUjKSSMnrD7ktt5Mq3t8y?=
 =?us-ascii?Q?T/XW5SlCYgL/epvw2S13r53c+b0xsBfaBFkjuUmVT6wKkbeNv5AJC4Q4LsWK?=
 =?us-ascii?Q?JtuzDgzxwkmZl+AOsDrlzhEgfZqQGfDEXOwawuJitR/l96OOamlJ+K+BxyWI?=
 =?us-ascii?Q?MrYFlUUmgOHWEFYrt77qs9RlcoZKjZb5eAH3r7unl4hYQm5/kTS+CsboF9fv?=
 =?us-ascii?Q?0O8eJj53HKBKNfcjSh5qdT9jAbpjfsP1Uop+CEhTk5PlyIr2C37oLqszdRcz?=
 =?us-ascii?Q?UoE1jv9XGR+D3+rDnIHMnApH6t7rTp9DxSiwMMRN8qBSbhPHLGsEPUI7a1YN?=
 =?us-ascii?Q?lCXZ7FRWVx2gWaSzXKJBeX0Pm884TfqyIsOOgMsONWNHCGtG+y22iW6JaBxh?=
 =?us-ascii?Q?IRCRD/1uTiIoIVahRwWGqfztqZFJc+wNCe0C0sdzQb9rWgfcSHwtjtef7r+k?=
 =?us-ascii?Q?AD/3AjthUiZ6AqORakCBUtXfXITCM7s9D8hkfYZqnFxiQ5+CKPNsnfRVTBH5?=
 =?us-ascii?Q?k7DE5+r3tdQGWVutJlBwHmzLhjhcOATcOFO+rFDIOnis6cFGGKbR3FwOU7w8?=
 =?us-ascii?Q?D+gcsOLYhOH81bfz7GnmUcaB6ylTkJps5MLSQDH3Nfkh5B+1+6+AhfsMGOHW?=
 =?us-ascii?Q?ibEIeMD4qYjjma00TOLjcNm4512HdCmdOwJmRohRnAuOW92CN3qr7ESpu0Ed?=
 =?us-ascii?Q?knYO4iZZRyMsgUzu8Ubyi7eNsbqw2d3hD2wOJZmeLMBPDwPqpy22k689hswZ?=
 =?us-ascii?Q?SDmf/AaibX+Y9ZaWTU2oPFE+bvB9HjGrvqMAtX30xPUFXQKRWxGoTGUJDkXx?=
 =?us-ascii?Q?vduDU7GvpTo4nnpgbbIZbYfvm2vn2t+a7epTOMLgRQ4OfFnyanVCdwYWyiHB?=
 =?us-ascii?Q?mqdM5kChkuSFNZ+tuAmVGpwE6U9jSLTnwk5VqcNqutsBbwQxwqRb0evidxw5?=
 =?us-ascii?Q?9DF50ZfUt/pY8hJdaGHMlup/2ZvIzi9jUzZxTGjRisAR6wikSwwHY7Gpw4+v?=
 =?us-ascii?Q?D87Fd9lQ85m2kTo5uS2am6mve8wJEQTaTL2+FygEVNyb7ik6TblwPrVzXzqN?=
 =?us-ascii?Q?e2Eo9HXE3dY9mHCLegXF/hEEHbIwZOY4GjomMHsLjLf51nWpvExdzkyuV8jC?=
 =?us-ascii?Q?sfgrYLeebTp/GJ56PRIDDBMdCAW8Ngg3i6sK3CxLtTfif87yApFgi7fUX1ok?=
 =?us-ascii?Q?hYXC+wj1wHBZ/+cACx863MoHRRZQT8AiXCrFPCTiBDXd0eIkJRdJf2qA1Low?=
 =?us-ascii?Q?UwoPyCRmO78B/usAXW2cdIbbuLG+z0qZMqfxYSR5b1kqfAkQqElacQdF1Cf9?=
 =?us-ascii?Q?/UHQYo+02XYmf70fRVoB7KL2xQB3NDRc+A3d0KvsL6Xq6mRaJPUS9Z4bnq6u?=
 =?us-ascii?Q?4c/fZWMNPIfg8tA1sjgCbcL1fd40lMSd3glVWaR4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d08ddf5-adf7-4232-2f2c-08dbc25b596e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:49:40.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EW+1KxmUsSBibfAivcjKAqVC5uS9jYcUx8FC2VXlLWnoNV3ZhLXYEyciahhrewrO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8986
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

