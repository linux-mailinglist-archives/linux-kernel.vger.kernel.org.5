Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21A57B45E1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbjJAIGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjJAIGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:06:09 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15414C2;
        Sun,  1 Oct 2023 01:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jM6Mn1P2Sdl0YllkhtjXOKHlD7yrXGvUCU1UBhp2k/zlSWMPCqcCLTaXp4NFdGFY+LN7OAoZ+IzsPEWEBv4GKTqgiSEXsM9ipQ8ag3jWM3rmtXjB0Goq5ABibaFOX4aeyeGPOzjqffpIuJoaUBrfEFuttURw26XANEQiLZMnC5LiVuhaD91AJGy4GrK0qS8PqyZ3i+u1hA8BeAO89k3hQmfHOpYTll9L7jAvJu5rCjs9iggg0VJHw1UxVhBd5zv3BWAN8T3u1P6Q+n+ZCXPT7oi+Iv3Jsaq/1oB+1JnaxeA87FRvvkW40pepwJeUpGANIxrH6Ll0MdRoH2frfa2WwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrbKIXvZEZ21dT7v5kxt4MbuKKJdoaudY92bwzZPFf8=;
 b=FtlJJt8oVBSRzqH9qd52VDecRbOWmwdK2W4nXS/b+e5xCG3nVWZP/uN9PrPTwJPGs/NsTJL+qcSefQPS9N52oPeW4irt7jswCf89TSRRS+LBl9mKuc3Ri5kpJv9IDILYlPBtdPZTApnseEYJqEP0SnaE+fUo190z1bnIHlgF4mYS+Z7IdBfcl1pC09jSz7NSp898HQYjRPF7Hcg7o/tBcoSELDPVuL4eN8v4zV1nS2613NsXJky5sYXrbfhqgtA0LP88YRH6vkgtEvRRPT/Q3RooOVEqx4vO0/xAs0paWfBNK/Xy8A1UJX2ATYxZrW8zrxo8RW6zXr58qBFUOrkepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrbKIXvZEZ21dT7v5kxt4MbuKKJdoaudY92bwzZPFf8=;
 b=mK5QmdpvzA8F53pb1jkhM7W3gxzMFGryTupdG4FwZovv6Q+VWd9Qc6qkA5yQckyswUb0FVwQtlB4E1pNJI7fo34sbYy2bJS3iGvJJFGKvyRltU2Po/PZ9vctYzwaV2F1LzCzNy9ALxBHGxH35lodP+SNgoVM/mtpZheDinAUwgskDi02db2Ag+JodOL+hoicmXIwP6x/qkObO8ap2+16DaKQxxdrU7pkoTxF3bVw0pZP63ofPVoDbbFeCSE3fUIHKSEfHAlEdqDLbSiB1Ctqo6gXOuligBYiUtzNBKpGe1Be9574VEg6tXM8Zxv2Re6kwdnHLX3UKH3tmaCXaF7Geg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by PA4PR04MB7725.eurprd04.prod.outlook.com (2603:10a6:102:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Sun, 1 Oct
 2023 08:06:03 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::8647:4673:b19:acc2%4]) with mapi id 15.20.6813.027; Sun, 1 Oct 2023
 08:06:03 +0000
Date:   Sun, 1 Oct 2023 16:05:51 +0800
From:   joeyli <jlee@suse.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/2] Bluetooth: ignore NULL link key and reject connection
Message-ID: <20231001080551.GB8209@linux-l9pv.suse>
References: <20231001074524.GA14361@linux-691t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001074524.GA14361@linux-691t>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TY2PR06CA0026.apcprd06.prod.outlook.com
 (2603:1096:404:2e::14) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|PA4PR04MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0bb3d7-ef6d-404c-f85b-08dbc255417d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+hoQNV82v/AvUn4aDdjHLDKVWhzEuzud9oRuXcQKBBEtAfUCVxmPhPKv2eNVMfkyDf2oMngRPcjO/rUkeayT94rbz0pNtKiQLrM6i+f17jImuQ7OBCD+/m0hPgi1sizLh6bg8lXGHhTOU3V2zfF18VoWByv7FghWeLC1MLRxFZkUVRu+/D3bhty8BWeq07YHphrdDgqaclbdHSEyRrJ/tGzO/UJaSyAMUlq3vYs6e+xPDT5XtyD507/W5ENeDXrkSFHf4iDLMmssJ6cTKzvucm9I1Zi7DyHKHGkRRnRQrauEdgkzmmuHdRDaKdl1TVLel1j+Y27AVqNBwrsxw3JEW7I1iThGmvGrQSJVktahGgY9gX9b94hyDBJ/eyxX3gQ2H6zuk7TdjybKJgw8c9OzwmeDo5KiK5A3RW3UuE3ae7TMw57KJckNc4bo8jYS8pzB24GzBCk7+Hdro9LsvHQIEi1f0rxlvU42yCrC+YvOz6s9OqRFUVC7oQeYT4R5zj2wGL5pxamaHvSXS24VEwE15YHbdU5cn7hDSnclaLJ0+eF3RZ8LdngHVRNXyzTM0R2SbGowcThiz5eE1VqrKC+51QsNlnUTNVzBKMJ1LXy4Fw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(41300700001)(316002)(26005)(4326008)(2906002)(8936002)(5660300002)(66556008)(8676002)(110136005)(478600001)(966005)(66946007)(66476007)(6486002)(53546011)(6666004)(6506007)(6512007)(9686003)(1076003)(36756003)(38100700002)(83380400001)(33656002)(86362001)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+sDf4qhMqhhH3azou3vHKc8H+kHuQ8tMuz17IRM0ocTj+JfVEbOPjshgOreX?=
 =?us-ascii?Q?1S5jrSvGpqz1zdplrG3hFfGUdq1Nro1i1MYPyZqabZBme81O5IPSqKX7H+Vs?=
 =?us-ascii?Q?0Os2juLmy4SrQlc14ghuYbXH8W3lDeQ1iNdaVTZ0cSW2c0YschYkLfat0jGG?=
 =?us-ascii?Q?SioIJ6wDYO9qI3OKFFXjETKv5NYenOCjGuh8t6cvM/p5jWyQthpFfVqqjSLH?=
 =?us-ascii?Q?/hstvGNsDFb2hLEBh4o16xrVScSa5ZKBKo0jRHbjJyiF4QybtjT/KeC+3av7?=
 =?us-ascii?Q?J51sImCFC2dlSsQefs15o/+WMPGJMtrS9Vith44YJgbiIrzFQ2+LeK1NTJDy?=
 =?us-ascii?Q?cGR0/kwGMyZKLfMrRvbQHh8xwEFLa2gEgKhdtimoazCfD0F8tanC10NbIBzy?=
 =?us-ascii?Q?NUTErlWI3jD0elQszeTDBvm2P45THRwtIrnP8h1gIRX5wdhYyeXj5xc10Dg5?=
 =?us-ascii?Q?pEnXNATrPiFp6qjovG0mR5i0SAHVftYtgrmXpe+GyBISXHpy+5nHorsDvFsy?=
 =?us-ascii?Q?80MWI4/8t4J70VDMLR+zrbCRL1pib+509/Xt/ZD6okIWubanIdVgTGyhtmxQ?=
 =?us-ascii?Q?F71CJzSwEit7TErONpUKH5W8w7zeMNfcnTTNt4gXG0ibK5kNCrotA6cAQdOf?=
 =?us-ascii?Q?8XsuBVrNpRZD5nsXXFy1Pydavpcc0j79iFF4Mhn2B8ywoP7ej46bNU90pwT9?=
 =?us-ascii?Q?3KSvgsqfyZZcgeyOgR2mzs9+us/jhJmqMYcr6Yuisfktmmq/r1CT4+AA0lqP?=
 =?us-ascii?Q?X57uxom5keR3Cf1CC2xkHiwDTey2d5CU64FaAFI4eRu6TPzK24MHL6OBO7SY?=
 =?us-ascii?Q?Jx7wj/n/AD+7OfXwYHLkVJyzgGkMu0CWOv7DwcEalRXuqNXAfQT5oOmlDjoL?=
 =?us-ascii?Q?UAm3715hZv80Vmekwh+509tyiRW0DbdmUrfsZANorOuZZ1rcorRgNekeP+PQ?=
 =?us-ascii?Q?z75+foMzYRpXo0e8/ylY+/qMv7IxibexjQf00vx3pWGGubWTRtxz0uQy/4FG?=
 =?us-ascii?Q?45KxQbD589aZvLl529R5/GURU3ikSRMwXDVCyG5TDVQz8uHvLmvIQxavyEhw?=
 =?us-ascii?Q?Cw/XGp+wO4wHvHO4kSV3b3GqNQcVg0boGnfFCSVM4DmKGEUz4zUNB2F/rzr1?=
 =?us-ascii?Q?kcouOyuAFfYotTJjEnn/KBqxFD6QjzdepVXDdCjU1hjGMC1RYdwGx0vBgy3R?=
 =?us-ascii?Q?soBf09jC0XkZlE0dc6/DIPLrY6OVlZwVhOoxzF8v6IaaFL4uK2ransSFgbOT?=
 =?us-ascii?Q?LkMCWBHRWaTeGCp00oHp/i+gLjNlOJzMjulvCyYIq4qkk5aCZ35n7p1pSmIi?=
 =?us-ascii?Q?92TQWO5CoA9EnMxOQ1CSvQNJKITyYH2CCjKtUKZTpd9WZ1eiiqSgqg50uGky?=
 =?us-ascii?Q?HcygFYETGI6dnKGCQNFNV7LaoZXO/kLmraUumvSOOHGjno7zYEdC8+ghvGHf?=
 =?us-ascii?Q?lUqQJmscSgSQo2wiut8VyICevuwUMuy0SqI/I5lPsttlI+NAqN8l1CGrwT70?=
 =?us-ascii?Q?3eSTIV7Ai+kV7r3Jsy4zQ6ahUlcET6EQNKenVz3dQX1Oe9e5GtptViheXiaP?=
 =?us-ascii?Q?gMUhmUmtc8vCVgBXGAH9wxfAfb/OyEob6kdrPXBQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0bb3d7-ef6d-404c-f85b-08dbc255417d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 08:06:03.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLywmDLkaLNSwNRZn67MUxs8BHipTbaZE9K8UhmUCajfxRw6hZNBRYnLR1JKF/kK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7725
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi experts,

On Sun, Oct 01, 2023 at 03:45:24PM +0800, Lee, Chun-Yi wrote:
> with the device which has same BD_ADDR
>  
> This patch set is used to relieve CVE-2020-26555. The description of the
> CVE:
> 
> Bluetooth legacy BR/EDR PIN code pairing in Bluetooth Core Specification
> 1.0B through 5.2 may permit an unauthenticated nearby device to spoof
> the BD_ADDR of the peer device to complete pairing without knowledge
> of the PIN. [1]
> 
> The detail of this attack is in IEEE paper:
> BlueMirror: Reflections on Bluetooth Pairing and Provisioning Protocols
> [2]
> 
> It's a reflection attack. The paper mentioned that attacker can induce
> the attacked target to generate null link key (zero key) without PIN
> code. In BR/EDR, the key generation is actually handled in the controller
> which is below HCI.
> 
> Thus, we can ignore null link key in the handler of "Link Key Notification
> event" to relieve the attack. And, a condition of this attack is that
> attacker should change the BR_ADDR of his hacking device (Host B) to equal
> to the BR_ADDR with the target device being attacked (Host A). So we reject
> the connection with device which has same BD_ADDR both on HCI_Create_Connection
> and HCI_Connection_Request to prevent the attack.
> 
> Similar implementations also show in btstack project. [3][4][5]
> 
> Link: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26555 [1]
> Link: https://ieeexplore.ieee.org/abstract/document/9474325/authors#authors [2]
> Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3722 [3]
> Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3523 [4]
> Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L7297 [5]
> 
> Lee, Chun-Yi (2):
>   Bluetooth: hci_event: Ignore NULL link key
>   Bluetooth: Reject connection with the device which has same BD_ADDR
> 
>  net/bluetooth/hci_conn.c  |  7 +++++++
>  net/bluetooth/hci_event.c | 16 ++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> -- 
> 2.35.3
> 
> >From 2c6cd3f353d21086a3163a9ad461789d203a7ee4 Mon Sep 17 00:00:00 2001
> From: "Lee, Chun-Yi" <jlee@suse.com>
> Date: Sat, 30 Sep 2023 16:56:56 +0800
> Subject: [PATCH 0/2] Bluetooth: ignore NULL link key and reject connection 
> with the device which has same BD_ADDR
>  

Please ignore this patch set because I used wrong mutt command to send out
patch. It causes that the mail has duplicate contents. I will send out a
new series.

Sorry for any inconvenience caused!

Joey Lee

> This patch set is used to relieve CVE-2020-26555. The description of the
> CVE:
> 
> Bluetooth legacy BR/EDR PIN code pairing in Bluetooth Core Specification
> 1.0B through 5.2 may permit an unauthenticated nearby device to spoof
> the BD_ADDR of the peer device to complete pairing without knowledge
> of the PIN. [1]
> 
> The detail of this attack is in IEEE paper:
> BlueMirror: Reflections on Bluetooth Pairing and Provisioning Protocols
> [2]
> 
> It's a reflection attack. The paper mentioned that attacker can induce
> the attacked target to generate null link key (zero key) without PIN
> code. In BR/EDR, the key generation is actually handled in the controller
> which is below HCI.
> 
> Thus, we can ignore null link key in the handler of "Link Key Notification
> event" to relieve the attack. And, a condition of this attack is that
> attacker should change the BR_ADDR of his hacking device (Host B) to equal
> to the BR_ADDR with the target device being attacked (Host A). So we reject
> the connection with device which has same BD_ADDR both on HCI_Create_Connection
> and HCI_Connection_Request to prevent the attack.
> 
> Similar implementations also show in btstack project. [3][4][5]
> 
> Link: https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-26555 [1]
> Link: https://ieeexplore.ieee.org/abstract/document/9474325/authors#authors [2]
> Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3722 [3]
> Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3523 [4]
> Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L7297 [5]
> 
> Lee, Chun-Yi (2):
>   Bluetooth: hci_event: Ignore NULL link key
>   Bluetooth: Reject connection with the device which has same BD_ADDR
> 
>  net/bluetooth/hci_conn.c  |  7 +++++++
>  net/bluetooth/hci_event.c | 16 ++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> -- 
> 2.35.3
