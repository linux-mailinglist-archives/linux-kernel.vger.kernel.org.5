Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE99E77BBB9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjHNOcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjHNObx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:31:53 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2062.outbound.protection.outlook.com [40.107.249.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5164E9;
        Mon, 14 Aug 2023 07:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLnQKLZf145k6ZznmC2+ZO88gEPA043OomB0CfQVKuYx3YD2pw16nfjumgxU6KdpWSxTyPfwKPqUORBXxssHKgHcanKZo0QP+klbqHgZDnnYwfuSXpPUBYe0DTkAMw+TyHvAVDdUPQdhO5XPwL41J2GocwmfuEnzAak3Zkd8Z6YjzhdV+Ic7JK3J+jVCnNZykiM8xtrwYn/tYWIpJySuJ+dAeYv9oCpEBnMusGnRr1jzN22dS8qPslW+chRo7c+skI5Gr5q0uOgiuPeKyNrOKCHClS2QSUj8TTJkaQY1jC5JU+I4FHldBqeuu3lxwDpBRZ8g/31ScJ8/T46wiPPaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6H9CmNjdHAmYh5jagC7VnVqaS4rOcOA0LNCHgNoT2cE=;
 b=ghXSvPCB+Qjtf+ln1d5wlT4zQxoFLGU++06Hsq+orilFvpwm0yCrPvGstrJp3CKHw0/NZSgu6U/vIcjnQch8dB3CI3eYCy0Gt/lRseSoR5bMlfTen0NhBj5NV2PKmhr2+SYRDD4tsPhx/ENKgW231GCtD2bjRFl6FI8N+dYegRX8a/rbeC0RJL/CIZLmy4tn+To/kk8zvkgA5qGG4NxRqyrPjQtVDE85DopcngaHACQJAePoGKOGFvf9+LWnyxhd8GQT5IcMAIn/fQRzWK2XZs/Q/ewV7icwYzEa6IsFQX+YfIbf4J3UwLRWrjB/O0yKWpu/vljEWYG5VF6yfdV7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6H9CmNjdHAmYh5jagC7VnVqaS4rOcOA0LNCHgNoT2cE=;
 b=dFvHP0PaaUDxj8JpOu+7S1tFIjwCJe9QBB46TsPDlf1eL95I23g84i4R7UboDXRXcHls12nyLGgcw8rKNqOecNjEYdRNeAzxUdjvnRXGMGyeFLMkBCmrbzBODX4nQFnBm/XDoAGTT3D6M4NQSPRF7Ww9NlGYU5LEfPtz9D6lQ6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:31:48 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:31:47 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Josua Mayer <josua@solid-run.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2] net: sfp: handle 100G/25G active optical cables in sfp_parse_support
Date:   Mon, 14 Aug 2023 16:17:39 +0200
Message-Id: <20230814141739.25552-1-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0189.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::6) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|GV1PR04MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf76397-e20e-4f30-0798-08db9cd330e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCADZ1Mb2x65Bw+0nj9NfDCrp56bq6uWFvTzD/0Hb0YK+Tvi1rBCvOB5NHhegyXtMi3q3zwfXuuSte+/OmyBvuyZrP8l7+KeUTRco8vDqmy2XmJ3wg7/r3LNlyZi1GQZr2OU2zEIwMVW6u8Vw6D2Oz4Y/H+2kBbNoOK1lN7/zqZQdHDQfybdfJW0fe4ff9d3zW/yxdeMlGzaYuAmxRAUcSVQbvKEMyZqJUD1I7bARnaaPb7mco8ULlknxXsP4hpYrmdmOwCUlZUNcpW/L4WOi7GT3lqmfLXOULVdUR+w3jE2uFnRHc+POwNnC/NWz2xLCoED9/LIKs2NnfIaHaDZ+x9S5UNn42KKlCyKswt33MyOqqsVL5C5ni+wTjFh7lA23IyK1cUcg7WTGfr1iqjjytFDhSBR5dyeRch8moOERdUx7PjoafAuT2XLa4fgJJe1aW7xn6MEWNTKhwwG4N5lapNGr5SUek9CX28Fm/uH+TL0sjiyb2wdJ7osW9M5AQd4O5u6I807CJ0fSl1YPKu/LieuxbGyg+C6zkeqlyHYqSIPy79eFsC0WmdzfTvBYLXZL3wuwJVXtdR0fWcNY8Y9yGhNdMAYlD8ZyLODpJ2SaeRv4WSXf6XtVcX6ZZavYnLS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39840400004)(376002)(366004)(136003)(346002)(186006)(1800799006)(451199021)(83380400001)(36756003)(86362001)(38100700002)(41300700001)(478600001)(38350700002)(66946007)(54906003)(66476007)(6512007)(66556008)(316002)(8676002)(5660300002)(4326008)(8936002)(2616005)(1076003)(26005)(6506007)(6486002)(6666004)(2906002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AUhlucghsBfd6la7n2F/OQIWpQQCBJphjjcjeFemSLCLim2VoEijbC4v+yKn?=
 =?us-ascii?Q?lPMWtZ8nViKk05JR0kB7WO8TxNWG7c8jJl2lZQw1ae98V7pWcwf2Qslv8Zxc?=
 =?us-ascii?Q?O7J6gr1IOVuhNCM5n+VM0grIxb0PSal/jnbnIgb9ELM7azJwAPBSoYO6s7ae?=
 =?us-ascii?Q?9hrXPpVPqQYVX6HCIFMVsT8bnDePm6kfGsDAiVaavbDzlYrH5rLNfPWhk5Ya?=
 =?us-ascii?Q?Z2YsCxXCZZwxXGJm2NnkFxvsKEHJCLyHRPLwFZjEYXp3/Yt5KTADljxaIOPh?=
 =?us-ascii?Q?0DVmyB3gNE7gL3ogSMSURivxQHOkosGgIM3320RtHqg7+wUr5ZSw/+ifiVXk?=
 =?us-ascii?Q?As+ptZCXi2fq8aAZbUXjRKqlMGGWFZTT4qHHyrFjR0thCC4pg5rXH+Djly1D?=
 =?us-ascii?Q?NnasO7YHIlcEHb+bpC2hdbMtz5P99W3L5dwiGIPHQxb74ZzKvJLUkVfjQEqS?=
 =?us-ascii?Q?YNkt7cSJPBc4HBN3dzstdJNpHR6TI5s4UbYwbjfWnFp5ZGx29KIDkxOpMmMl?=
 =?us-ascii?Q?Fx7C8ktZfeBZRBwA73ksu/jyCLaHIFXeeOY+jwiSZSf4v9CBXW0pMhVm097B?=
 =?us-ascii?Q?CkDRyks8ZI+w86DEB/FzCa4yVIcGolc8mOHaKWTqcN4KBevA9H8e6oRjf1DA?=
 =?us-ascii?Q?D8NwVqEXkOVByNjZFzpRQM5ILE8qzjCbqe8birQPh4A71Dr6nbILauN+PWEv?=
 =?us-ascii?Q?Xx357zlEEImNoXEN6uoImF37zWuFkX2VuRdsghSabiO4w3dv60P5/C64XM+0?=
 =?us-ascii?Q?PibVlLWyVqrk2/sCbJHuKDa1XN6A8mKffO80Ddpuy6Nn1AXu5oXoys4lYU+X?=
 =?us-ascii?Q?WfeJ0Tzpp1pBP3nJ0OBP77r640BaeYb9N/+nKV/VH5wiCqGrTv+3deIOC6SI?=
 =?us-ascii?Q?eYL64JZmrx2fTJ6yZ1f9kJStFgA9rlfMhEG6hmIzIjMyRriO8SB24DMItVV4?=
 =?us-ascii?Q?DRHGvjgxJ4bnLNZBK/h6HBcrc69x51ux8AyBz0rzA5S9ZJ5qOPNqSxcUOXd3?=
 =?us-ascii?Q?4hgzCGrp1S2+OS8Sa93ZRTlXDKSNPz0ZvdBkL9sXu0U8gjPpUhd8L4QxAUHO?=
 =?us-ascii?Q?4gcxU0WqQV2PlEBcIJlwjU7MmjQ9dWcPZDjAmZG1y+G2+gIH1I1sbx3P1kuT?=
 =?us-ascii?Q?KzUqAeJ+B5cc2JiAJudqxjB5vQpqKj84VYa3uwToN+7lfzSxYE1r0A31Vf2t?=
 =?us-ascii?Q?E4KtKQR4c1IavHosdFOmI2F+wiRMKXNhRsy2eDrrl2WPnNdvVTS59adbsx3W?=
 =?us-ascii?Q?FW/b0KQsYqt3niwI5VSbDOjcZTR47U7ArC/n5JyeOF/uD3kOgq3Oun9LFRWE?=
 =?us-ascii?Q?UwAKxxfzsar/MoqPqKlphJFzqJM0b4im0DEjAYudr7G0XYdq+wkK94o0Ci6I?=
 =?us-ascii?Q?9hhxoyb8OsoGP+yAbUfbbYcl3PL/kNPTqPGhr+7zhequTfhbchjogztYkSkz?=
 =?us-ascii?Q?cmpbaAtIjy5zPCThrrANXR7hrLouvfVAt3XGh23T5IaZ/GKDc9SZj6a+S2/y?=
 =?us-ascii?Q?j+mmFWqFH3e7AW8IcilH86x9ZdWOiaclPbsX7wEiOaeS2LfSZ1N4k0W3zbPs?=
 =?us-ascii?Q?7fCplcaJilg+W8Tn7IKzjQoA40/BzZ7t8WeV3BHo?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf76397-e20e-4f30-0798-08db9cd330e9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:31:47.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trZZM+HIEaXj4yl7erMHPZ21CCfDuE/g2qN6rEk9HKRnQhYEnR+RtBc3sPfKnOr8/uY4pJj7x5VpO910acOGBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle extended compliance code 0x1 (SFF8024_ECC_100G_25GAUI_C2M_AOC)
for active optical cables supporting 25G and 100G speeds.

Since the specification makes no statement about transmitter range, and
as the specific sfp module that had been tested features only 2m fiber -
short-range (SR) modes are selected.

The 100G speed is irrelevant because it would require multiple fibers /
multiple SFP28 modules combined under one netdev.
sfp-bus.c only handles a single module per netdev, so only 25Gbps modes
are selected.

sfp_parse_support already handles SFF8024_ECC_100GBASE_SR4_25GBASE_SR
with compatible properties, however that entry is a contradiction in
itself since with SFP(28) 100GBASE_SR4 is impossible - that would likely
be a mode for qsfp modules only.

Add a case for SFF8024_ECC_100G_25GAUI_C2M_AOC selecting 25gbase-r
interface mode and 25000baseSR link mode.
Also enforce SFP28 bitrate limits on the values read from sfp eeprom as
requested by Russell King.

Tested with fs.com S28-AO02 AOC SFP28 module.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
V1 -> V2: added separate case SFF8024_ECC_100G_25GAUI_C2M_AOC
V1 -> V2: added bitrate check for eeprom values

 drivers/net/phy/sfp-bus.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index e8dd47bffe43..a4b0bb50e2eb 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -258,6 +258,17 @@ void sfp_parse_support(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
 	switch (id->base.extended_cc) {
 	case SFF8024_ECC_UNSPEC:
 		break;
+	case SFF8024_ECC_100G_25GAUI_C2M_AOC:
+		if (br_min <= 28000 && br_max >= 25000) {
+			/* 25GBASE-R, possibly with FEC */
+			__set_bit(PHY_INTERFACE_MODE_25GBASER, interfaces);
+			/*
+			 * There is currently no link mode for 25000base
+			 * with unspecified range, reuse SR.
+			 */
+			phylink_set(modes, 25000baseSR_Full);
+		}
+		break;
 	case SFF8024_ECC_100GBASE_SR4_25GBASE_SR:
 		phylink_set(modes, 100000baseSR4_Full);
 		phylink_set(modes, 25000baseSR_Full);
-- 
2.35.3

