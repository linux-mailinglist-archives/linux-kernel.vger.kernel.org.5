Return-Path: <linux-kernel+bounces-18656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F87E8260A0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 17:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8624B22F6A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079ABC15F;
	Sat,  6 Jan 2024 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="CTcsUydT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2073.outbound.protection.outlook.com [40.107.15.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1291AC12A;
	Sat,  6 Jan 2024 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rx5Yluv0Ar7BXVlFQblaOMcZT9g/R6pSnt+oIl+Yp1O/6DTOu8+0BqS9BfVAVLpCFiu1tRZYqJ+1OHg+/tporCexeMMdy00dV6mMJzxgkgwx/kJpF1drcL90PBEUonwFJUFOAuWJf0s+An80A3Rse/Zny9cJn5ADKBTlkufGnIy0hXERgjh3SGAneoTKuESsXHOcre153uXke4lsxvVCY1dKnkL4BTxQEMex2bVnXbGisVjn103Td9s+tArY3IvTyTB6hn2NtRXYLoJVqWfBZVF3bZXylDgKm2UjABGgXrHX8/1c7Yn7GU6K4No332QrfH4usBq8eBp9vkdWjXDcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6yTUm7MTX2gUH9a3AkDi4lA8c3/2xWhvLKLFJRvfjw=;
 b=a2puCL9YakJcAlon94DIk4XBMzWvjtZ22e3QO96Oxj4MyJTZUe0PX/8jmjYE4qV01oViKUhsJAhSjeQAPymz2Fr/ddj4nn4/kQtwwteLRsvHS/JAdeldJfd4hmdwEsJiucBmWPfafnEJfJiXKI1TfKFVdtAxKyPlxAJZuuTrjw6fZt+3GPKGxwB6H1UwClgS4z+jjUwirQJ+0+fFxT/PaTg3gSqaDEBPkVxnbhCQLgRG/TCnk0ya3mAvmkA35sMIJoNnSq+HNq3h2d9baX3JcnRroa6+LkRNIGEYn0cmautQNS7y6WL1ozTlHQ3Wc2c9Ozxxfzvqvs+RTn0YYkxw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6yTUm7MTX2gUH9a3AkDi4lA8c3/2xWhvLKLFJRvfjw=;
 b=CTcsUydTHunn0WfJgJVpXxSrlkEVaNbwOC6sfyMdyf3vw3umqTEKiMopRtilT5r7flsGOYqxDmGLAkQXr/gJoNpCCTKaxW1yhRQQCsn1cJZetLjvLdJN988HNkwJdcbqudQpIHR47vv//9nze/rEDTF7y+pUSk9s/6mIq+yZHVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Sat, 6 Jan
 2024 16:30:08 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.018; Sat, 6 Jan 2024
 16:30:08 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 06 Jan 2024 17:29:56 +0100
Subject: [PATCH] net: sfp: add fixup for tplink 2.5gbase-t rj45 modules
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-tplink-25gbaset-sfp-fixup-v1-1-8d26696bd2f4@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAAOAmWUC/x2MywqEMAwAf0VyNhDr+sBfEQ9dTTUotTQqgvjvW
 /Y4DDMPKEdhhS57IPIlKrtPUOQZjIv1M6NMicGQ+VBBNR5hE7+iqeavVT5QXUAn9xmQeLTGta6
 pSoLUh8hJ/N/98L4/SMtVUmsAAAA=
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR4P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::20) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AS1PR04MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: f830f1bf-9e6f-4611-9564-08dc0ed4beee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FsWJHfameDa/oMwvu8kuwFJ9xpqhG7+S5OivZ6tJYIEe0YdkhtrRXO7cvKSX9nT2H1sNvxEZ/u8CBo65S/qnxipI37eqj2aI1aWgsKRGQmn+5z1GYWO9wiPQ3u5PPjiCOviA+op0eh/6fCc9jMQpKilVgQ1zdJtDp6IF+JxNKJYy5cVZgLlD7DHuR8hsuxdybzDy7jXnVwaJWF1Kd0iDjwvqzHrbX7kvrU0Wc7rJtJe50Sxdgv6+FWy83OJkUfs+UQHrQWVaj7scyqvZ7HqViz9bcJ4vZJo7rtb+EbcmEuZZi2IWxKGn/jyZckH1H90mYd8UjxEseBqrcPG+oDKp3itbsclb3hi3v349tAlQxmgsVeQqOaaOCegvjm2vhxI6MZNFusFWjqkyLPGEAo/MyrL+wSymxY7zIgTuFoBd4Oga+ktp3FRiYXRDLl1cKUTPkq7StiPaWsow/QCAuuzOB1rAr/Z78ihDCtp9j0Y8aMDH2C2zqaZr4fbmVm2lhzMD+vVPG6IWhuv8S986nlEZENkg/kgvO1ZU8SYKRRW+eGP+qJlbZq3Es3Y1IoFQbPtnYQiDdmei/m4hrh8Gq7whsnPdgODurHMObo2iHk0ZlIXbB9Ona1F00KqPrdjZHUKv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39830400003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(36756003)(38100700002)(38350700005)(86362001)(6506007)(8936002)(6512007)(107886003)(2616005)(8676002)(6486002)(316002)(66946007)(66556008)(4326008)(66476007)(478600001)(110136005)(6666004)(52116002)(26005)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MENaamJJMExxcGNuN05UajFiVHYwV2p6Rk5ndUdYZEI3QWJiNlEwa2VGU0sy?=
 =?utf-8?B?VUY4OXFVLys2bTc0MzdPNjFZc1lUZmR1bmF3RGUwcnJTTzdrMTRBeWlPNFhB?=
 =?utf-8?B?NmVPWloxYlVzQ1JDcnhDYzZUUW1DY2xMZVM0RUMya2FYZ2VvWVoyY2VtSHlr?=
 =?utf-8?B?Q0lWMVJ1ZnFQZnBGYUMwMTB1TFVJUVdFbWI1MmFReVoxOHNaZy80OFN0REFM?=
 =?utf-8?B?R2RxSmNsMnY2TXI1cVVJSzFoai9iSkF5NGJOK3E4cTIwY3JZbGx2cGMzNGht?=
 =?utf-8?B?bGRVTkE1RUVxdnZtdG93bm1FT2l6YkQvTUFzRHpuVnBkTFdzNWtlU0VDK3gx?=
 =?utf-8?B?NGlOYUhpZFhFcHcxdlN1UHBxejByRXp3V2xRejdvTUtXM2tXWEszdlFrbnpB?=
 =?utf-8?B?UUJyY3grUE5scisxMkFPWlZMK01menNwWGZCRFNVMEppSzBRU1kyV0tIM1hv?=
 =?utf-8?B?RlBRQ2NrUGp5Um1KQVJJRFlrZFZzbSt4L0VaZDNJT0JWd0toN3ZwZXJvQWYz?=
 =?utf-8?B?R00zTzZ1dEZCTHFBK3Fia2hFZG8rb2pNa0hGbHRSdXBROFJzUll6NTgrb3hP?=
 =?utf-8?B?cHVEYmtWY3lqaFlDd3FBUHBGeXI2TVNyZ2tJYUE5NTZnV1RvaGx5TDhXQk9Z?=
 =?utf-8?B?T2RFTkEra3MwcTAzYVc5dUlRQTlSOCt1T1EvOWdYeHVNVjBsMGluZVkzMHVa?=
 =?utf-8?B?TldtclAvajBSK0xkcDJiSE5VYzhPWW5QdmQyU2dyWVdCR1JCY0R1anhkVWhu?=
 =?utf-8?B?TnJldmROejh1TjNqdVBpQWxVY1ZkM2ZzSm9UdTdXTGlHRmxuMXlJVzh3TE5C?=
 =?utf-8?B?QTAyQ1FhUjBsaGVNZEVwNm00ODQ0RmFiT3Vvd1E3aEhTMXg0aUhSb1JyTVpv?=
 =?utf-8?B?Y0FieStRSmJsR2VQVU1RWFNIZ011MWlhVm9Wck0xeXVYMk1tUG1WZ3VveVR1?=
 =?utf-8?B?Z1Z4LzBjalJVZjRZR3NiRzVxTXV6UTZiU0xlYTFjeHJCRENFNnlLengzK2tk?=
 =?utf-8?B?eHNjNUlma3FNQ2MyK3VLRVpLVi8rNWQwUVpHSStIbEcwZ3A0d2JjQ3dEVmFp?=
 =?utf-8?B?QVhlc0g4S1p4dUprVEc1MmdKZXJwczJlWHZjV1R4VVJkV2Eza2JEcXNmQndU?=
 =?utf-8?B?VXZmd1YwZC9mMTAwdEh2RDNkRXprdnRmRWMvZmlwdld4dVl4eDFMejNWUUlB?=
 =?utf-8?B?Vyt4N1ZVaDVHdTRWcmtoKy9NaFYyQUhaU1lkb2drWGJUVWpEakZ5bm1UNklV?=
 =?utf-8?B?S2QzcHpLWHo1M1NEQUV6bjRKTXMzT3ZBeFAwdkV3bEZCeGcvamE0elZuZWlB?=
 =?utf-8?B?UGd5TW1FWkljWmlud20vN0JmVDVuVHRiOGhNbGNwdlJiZFRBOGVZanNjNk93?=
 =?utf-8?B?T21Wa0tzZXI1NkNEMndYWkRTZFU0WGpjekVFcDVaWXJkNFR6dmlOaVlnd0VE?=
 =?utf-8?B?bnFSbG5RYUdkbldrUStodGxJaEg3QlgvU2hzcC9hb2lQMFpzYjNMNEo0UUJv?=
 =?utf-8?B?R3NrQlpGM0Eyd3RiNW02VTJiUnJiRS9JV3UrcXdGb2ZRVlBMU083WDBmKy9U?=
 =?utf-8?B?Y0paSm9DajlwMGdLYW04U3JaZzFlelI3bVZmdHZpUkMrcURxUmV1andremZM?=
 =?utf-8?B?ck1RTnhOcGVnTmx4WEtqRndtR1B2ZnprZmpIeTBHR0tQMk02M1hnYkRyQm95?=
 =?utf-8?B?b0kyNXZGbTJGS2Z1NUJpNlRuaTNyckpWY1JLTkw4RlZmQkRSWWNpVlR2Tmpz?=
 =?utf-8?B?a29HTHEyT1NKdWRXQW91bks5YXp2ZExmUTE5UllrbW4zYU5MTXBMSHhYb1lI?=
 =?utf-8?B?NWxkWUZEeTdkQ0Y2cktybkEyZXliKy9yYUlTVnBzdjU2NFpUbWI3TzNCQ0lv?=
 =?utf-8?B?UjlMTzJFY3c1OW02a2hKTU95cTRWSlM2NWJxTm1rQnZvTkdlL1lEVWlhTFFI?=
 =?utf-8?B?dkZqZUJXQmpLNWx6TlZyQjgwb25JMld2WWk1ZE5xdkNKYVNmWXdwQngwWG1H?=
 =?utf-8?B?NFlpRUR5c3lUQTdKTnVxRzRwclk4ZHBVR2hUQjVZK3FBQTRuTTdUNFYvZURS?=
 =?utf-8?B?amVDMUNzUjdJbkFvWU5QT1hLRXZWTnhBdVpGZHJINXZXOVh3N3o5RUp5cnBW?=
 =?utf-8?Q?TIZSCCdjiE+bP3zwCrfDCmhX0?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f830f1bf-9e6f-4611-9564-08dc0ed4beee
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 16:30:08.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPIFi+3e4/dgqC42WZxSK7OEE0LOOi564eWRcNKVO4i7+aZfLOh+3gJWiLOQM3DEWKrQ22sCdtvXs1K++4Vm3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429

TP-Link TL-SM410U modules are single-rate 2.5GBase-T RJ45 SFP modules.
The EEPROM data is lying about connector and extended cc,
reporting 25Gbps fiber.

Add fixup for these specific modules forcing RJ45 @ 2.5Gbase-T.

For reference original eeprom data dump from ethtool:

Identifier                : 0x03 (SFP)
Extended identifier       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
Connector                 : 0x07 (LC)
Transceiver codes         : 0x00 0x00 0x00 0x00 0x00 0x00 0x40 0x00 0x00
Transceiver type          : FC: Twisted Pair (TP)
Encoding                  : 0x01 (8B/10B)
BR, Nominal               : 3100MBd
Rate identifier           : 0x00 (unspecified)
Length (SMF,km)           : 0km
Length (SMF)              : 0m
Length (50um)             : 0m
Length (62.5um)           : 0m
Length (Copper)           : 0m
Length (OM3)              : 0m
Laser wavelength          : 0nm
Vendor name               : TP-LINK
Vendor OUI                : 00:00:00
Vendor PN                 : TL-SM410U
Vendor rev                : 1.0
Option values             : 0x00 0x18
Option                    : TX_FAULT implemented
Option                    : TX_DISABLE implemented
BR margin, max            : 0%
BR margin, min            : 0%
Vendor SN                 : 12154J6001608
Date code                 : 210611

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/net/phy/sfp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 5468bd209fab..a5bb9d569381 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -340,6 +340,12 @@ static const struct of_device_id sfp_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sfp_of_match);
 
+static void sfp_fixup_2500baset(struct sfp *sfp)
+{
+	sfp->id.base.connector = SFF8024_CONNECTOR_RJ45;
+	sfp->id.base.extended_cc = SFF8024_ECC_2_5GBASE_T;
+}
+
 static void sfp_fixup_long_startup(struct sfp *sfp)
 {
 	sfp->module_t_start_up = T_START_UP_BAD_GPON;
@@ -503,6 +509,10 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
+
+	// tp-link 2.5Gbase-T modules wrongly report 25Gbps fiber connector
+	// in their EEPROM
+	SFP_QUIRK_F("TP-LINK", "TL-SM410U", sfp_fixup_2500baset),
 };
 
 static size_t sfp_strlen(const char *str, size_t maxlen)

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20240106-tplink-25gbaset-sfp-fixup-0eca2f8f7530

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


