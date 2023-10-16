Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF49B7C9DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjJPDjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjJPDjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:39:08 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2088.outbound.protection.outlook.com [40.107.215.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C668D6;
        Sun, 15 Oct 2023 20:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUAVoBOdFIVDOfBk02TENh0+67DaRmtfENnNocazx3Xlwt4IiwsQOMThPl88gVwzyw75qNu7dTufEAjme7XuJwN/tmX2sg1nc2j45/RgHoSzG1ZwH5Ck3mbg32sFs7iN87vSOFY4H2F2X1bvzlHryQh5IYyNo/h/DUa8iikuOtiDwGxgW7wtpnhxS9p6OJYiLgh63i7k5ndMHBz1YF9nhjwtFcrm0ETY22qozaz/+Jvgja3rk3czXF4SO1radjfmnledwF4IhmsXyuOOcVphci86a04Lk+WkrN+TrIy0c+aJe7qurGr3eMYPHRBO36+rUMum7thuaka0fstcBD6SzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tw3Yv68WCU5gjwUabKTVe/dryPnXluGxw3RNrf35/c=;
 b=G9wHi+NVHnAJRf+xK0HiwL/Cd81B7i/tdiEWk9T6DZ8nMGiVzp8k653r33j0bXr6pKtwk0oe8X6hhJ8mgua8QeAMfn1tZfQB89K4DpdAywwuDWPFfbSu3+MKbks5JEYFWxQKw8JChZcjdJ3eE5YUmekhVpiagopUOKfGmpi9e1lcNUwosOn9inr2ZEe8vJPV656Q0Sq/J09WRDYRIITZGWfuTIN5KYOGsudXJ4VYa+fTcWnmdcmIKWK5ZH/gPaQ6ZdL5KUemfm0v7NaAPuXAoHkeoaK5VzlrqCXkcO9ao1GgbVwZg5iNgVxo2t9HKGylZP5ry2SCBs/5yV26zRThbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tw3Yv68WCU5gjwUabKTVe/dryPnXluGxw3RNrf35/c=;
 b=g02lMWLsMlqXldkrhJ3C06geXzDI/qCbPHHAjawElRSUW1JVW6NlIVQEvjjqNAvjEwps4yKLo7WRYGP0h2Xv7bPiT1JYL4dfowTklahIAwaB4fPNwQmK7GdjrLwmiPnn/IQmZK0z25TgNNFhsTBvvld95jWLG/ukbE3zFhCpwzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KL1PR01MB5156.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 03:38:59 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 03:38:59 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [Patch v2 2/6] tty: serial: 8250: Cleanup MOXA configurations within 8250_pci.c
Date:   Mon, 16 Oct 2023 11:37:01 +0800
Message-Id: <20231016033705.20669-3-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016033705.20669-1-crescentcy.hsieh@moxa.com>
References: <20231016033705.20669-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:404:a::27) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KL1PR01MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea7731a-8927-4771-a96b-08dbcdf96e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJxIAtEaozE1ssb/kInMxZihiDANtJ7zzDUOvHoD+7c4nrOKgjpC4HS+orL+5OnL2xcNVB8RzalM2PQbxjspRsPO3ehybkeQiB0VgA9FvvRq2L3e8LeGKsh02BtqcvskvMsHBAH6n+Ikk2ShOSMTYr4u7bvEcLs6thMGIZM/oxvLGsyRFwfcLmQt73v2gYhEakKVmGesCli3cIOXt6tEeWvqcifdu0i2wntaka78dB1Yd62yfd9kAmgdJXScEBf0hxGM3NIq4DXhSl0914BpPPzopKWXiVDYNoQGeH7gd3cnmzw9kFOmpdTIsV/ys6IODQZDGK0Wu/YlkMMjm5TlCk8qXweOsNH8giGI8IxgDDTlYU+mtzFIegAVzqFMBtRa93C9Eow1nlAoelMHh/TvyMA6BSUtEn2o/zeGjq3Jm+VOQD6QGkDp8kgGH+2v2zGSowpWgHjIzQddMTN+OTySiEQHsyuG4WCUH/G5IEc0XiFWhM0ZA5Dz2bLdbXIUeeG5AA8kcR2kgOgXDsecFjBGAMkfl2eGnYsqBp6t6GjaN2cwyaFowGuf7PDlStNcIAwMCIrhxhBNCpX4fjCjk6+9264FhAa5fUSjl1NBXmWJPGkzUqjTsC9k3X0uDszhcIWD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(1076003)(26005)(107886003)(2616005)(38100700002)(316002)(52116002)(66946007)(66476007)(66556008)(6486002)(478600001)(6512007)(83380400001)(6666004)(38350700005)(4326008)(8936002)(8676002)(5660300002)(2906002)(41300700001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a/iHTajVxGh7q955UhcTOOCo7/RDISJ+MIYtvEo0OnD6uE7RyU98pNjoaFj3?=
 =?us-ascii?Q?7nMOWzh2plbBoatpyaY9fxFQkTEQhHvy4Ht+i5B2ocVYao/EG3FHr+vCGPE8?=
 =?us-ascii?Q?zSwK5CUDdKf7UnW3sMXqsLLip1I/8PJkQb/+K4o43OPq9mHub1KGYf1HabK2?=
 =?us-ascii?Q?7T61v0C6eIBueMaZdL6YtDYkIt+HJcCH4pFVisKlylq5z1PAqorK0npr0htu?=
 =?us-ascii?Q?3xK3v8ECnJT7i+zpnDp5/bcJHpxHWYTESchzZcQyQy1ldnnB9yjac2VgnoIl?=
 =?us-ascii?Q?xZwacvQ0KvOnWo54Q8hj5mSZ78QfecYAgDssh5faV1m4K1tRFkuGqRYTGIFS?=
 =?us-ascii?Q?SDbf9AldJFSkhZibt6sBDdCLip2HeP+d7fRVzPmVGc8PoZmfdiaBpRi/VOko?=
 =?us-ascii?Q?OisJ6OmmJrk2KTyJ8tZ7h3HlSfYsjvyVYo6W4WYNj59z88/jCJ6KQHlAsS5R?=
 =?us-ascii?Q?Z0C8R7NKZGYWrBLmKAeuSooQQCUmZT6AUVfDp9s29XCh9vU4IUjxlPmDbF1l?=
 =?us-ascii?Q?O1MNxFNunhHP72nNIGqAFJ8bmngv47mxNcrfWYPWjLYavZVQrcGnLV9Clvjb?=
 =?us-ascii?Q?pPN/Oc091svzalG1d5nLwXOkvbZXYarfn0Xvp2DuctQRfnWZ+BXrUBcg4Y6E?=
 =?us-ascii?Q?+oGGbbe+kho6PD73UvxNhxxY4ycY+Lx5A7lSoy//uV9Pd0iN7Rc8dabmr6XZ?=
 =?us-ascii?Q?/Z64cUDVj/X1rUK1VDvykCGdgoSgNBc4OoUtEy3pYqLIiCOWRfEbTXyzVGhi?=
 =?us-ascii?Q?RFGZGhFAHk2ZsARA1c0YFWVTEH9QIDL0GJDUyG6mxlxp7dLGctP+yzhKdADa?=
 =?us-ascii?Q?apjrxhXFeQjouZrCw9JXHVGsi9mJwo1QWWKkYOGoXQpzl91rsc/qDuyabK68?=
 =?us-ascii?Q?hXtTfW/l7TzgCtqFPf5YxtJ2itIvQGcu6wi63aVAa5qmHnAH9xHe5UtLi8+4?=
 =?us-ascii?Q?xRuJpOMijJ9pvsHXZRL6NkOPT/gAnDMcm8L5YUJ4me2VAef6KpCO1A5HVqEi?=
 =?us-ascii?Q?e7jZJ3BfxJi81jR+jRzfs7m95mepLs/0AJ1c7MW45eEnfa8/a5QnvZvby4Ku?=
 =?us-ascii?Q?OnaEsSphDm+HmgLOTx+/PxgEU950u7tRUQ0MndKhCOlpGNvSAaeahsGWl7dP?=
 =?us-ascii?Q?VSIadPWEvDEpUza5aPTsNAxSNXt3mq7QEeaP6449QG4jzsq5D3wRD1f5klrG?=
 =?us-ascii?Q?sweCJIZq8KEy1ebkxTGvFym/MnGnmuhtaty7W+UXCLe1x6TB4X09uyP7WEN/?=
 =?us-ascii?Q?g9Y6T0CygZR7ABNvhkJKgZHVh6kz2fU+HrOrs6souSu5wWDWPUB9WoUScSeR?=
 =?us-ascii?Q?a4xebygLoFyINa6fXoK2YLitjciFwYpVJLoor/5svYkCHuRIYRB9nCsFNjhY?=
 =?us-ascii?Q?UtnKi+0tRsOVt/AWV6ZFNK5Mw18ZVkI+eMUHp6p97csvivoO3RwVOU0CGO9w?=
 =?us-ascii?Q?kl4NbrChpt+s0N10hgUceMKj1EHp/w6RsSppTlC3pKsc/NKAA6Iq1pi/1DbJ?=
 =?us-ascii?Q?U+o0kCdB65BlHByxfN8+MXn7tg0iLq8IiVM3UlH4puvcNdRdpHXo7rpJo58+?=
 =?us-ascii?Q?5LPBmVlR7aoiO7OM62uauMvlddM3JLnj5FUmzFD4NzYcYI5EDoGd2bb1bCWO?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea7731a-8927-4771-a96b-08dbcdf96e97
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 03:38:59.0010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6bM+33QnqP7+3RfZXthm8nMWatIUixjZcpoJ/g/9eM9pDwHVoq+e1Tvw/+6DhgVXFsVoyldPp4vmaBdQszBMKw3HPA3zd4cuYv8bDyQegc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve clarity, clean up the MOXA configurations within
serial_pci_tbl.

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 48 ++++++++----------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 55a788b412bc..fd810a6ee38f 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5349,42 +5349,18 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * MOXA
 	 */
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102E,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_2 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102EL,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_2 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_4 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114EL,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_4 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_8 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_8 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_8 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_8 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132EL,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_2 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_4 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP138E_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_8 },
-	{	PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_moxa_8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102E),	    pbn_moxa_2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102EL),    pbn_moxa_2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A),  pbn_moxa_4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114EL),    pbn_moxa_4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A), pbn_moxa_8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B), pbn_moxa_8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A),  pbn_moxa_8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I), pbn_moxa_8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132EL),    pbn_moxa_2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A),  pbn_moxa_4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP138E_A),   pbn_moxa_8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A),  pbn_moxa_8 },
 
 	/*
 	* ADDI-DATA GmbH communication cards <info@addi-data.com>
-- 
2.34.1

