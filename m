Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C173A79373F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjIFIid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjIFIic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:38:32 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2050.outbound.protection.outlook.com [40.107.215.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE912E45
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHMCecUGSu43pE1UKNylKOoK5sC02x84x1ba9TFU+ox1q59u4F0Kb9DdKfXOgkqZIcXg22HwZXXcoTnSdbVtTSZn4ZSAmbrDy4e4/sc3u+zmXRTZbk9Pg6Ok9Ly5jWZVlFelyDzAX/HfB0mX1rXQGGiWAPbhGj55oO6dqg8XCBDxXru46G/Le9ao4w/npUq+HIIVtAhxoXyvhAowrtdXCzxty+Amtuv1weS8wEuv0rmBzSq2PTJXoaiPphcTkCdK7+YFhD0zeC6R6YJDuDB4NhwlduPhE1+QcSEWBWi30cWvOxkBwfn/GPUDkADaDbvDYHL0zhxtuVhq8muLZ2JQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7rjnWJ6fke13uLHUOM5oHUP8pNYysl8XmbST6Rz+ME=;
 b=GaGLDao4ebSVOMuNvkH0h/nihZdiL2TRB30i3qyeLTQ6Bk+pznVaYxM7c10IKj5C9+udBDzkBGsfFHyEouFdBmthH99+rqRo2jgmmivxVTmiX/faZNVvJLp8IP3bQIEPMKTau8TzM4ibrKEN4f0Cws5SkeD9Crv9vqcOyWOorP7z38HLUugoHt6TEsG3YM4f9shpEreXERfNEXyfaR+RX13O2ggqxYVUWFr0PtMh+mcHBcmUp4KkrPQEApxIiziA7SCI+wkdXI+iAlatf4dypxh8tH6xp19z+ONUNIUmDCNmrdvTNCZVUx9g7JGtwIV8giVk4M8XD+SMd4Gpm79vsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7rjnWJ6fke13uLHUOM5oHUP8pNYysl8XmbST6Rz+ME=;
 b=SFYDZVjuXHFmx/mqoIfrHP362gkQJ2AqFvpFYDkMVa5xo1zHQMe7v+wR5IicTu4SbzdGVAjboPJbTcCLM9KCJ98R03tDuaw894Eapqc+JJ7OHqCKgB9/BNIPpEkOiLddLV5aOcmXiQIBOMQoUnfoTKBYjOrNWaoLrKeGJZHUBnuSQZ2W3nktWPIPxVItqYZ/ZXYo7sGxXUOKjMXoDm46JjYXyWw9W434LEyW1EXacFUOUPCrv5OV88mR+hXZYbDxvoqkWfdfcx0Z7/O1Dd6b5LEZNUrnarmotAhVUL4Ot+I2f2ULP70okdSz3C2RKOrOyed9/ZWwUA1HOSRcdtH+fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by TYZPR06MB6497.apcprd06.prod.outlook.com (2603:1096:400:458::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 08:38:19 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::cca4:d6a6:69d4:6e9a]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::cca4:d6a6:69d4:6e9a%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 08:38:19 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] mm/vmscan: print err before panic
Date:   Wed,  6 Sep 2023 16:37:00 +0800
Message-Id: <20230906083700.181-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|TYZPR06MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: e5eef631-5d34-4b68-e52d-08dbaeb49f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11NYl22J6L7AW0QWwg19vsGOcwXWD2BWxA88YLCyGvvylsHnUrV9jvz2lgIemEEDiPm4lNOL+NFZFx1/u/eoGJORtTzhF+2BtDP+ykefmN23wMBicKQoIiVinchFjnqsD/GTEeyJ6AwTyEZonI6Jvrg9TPYJbTOH/wI2hFTMaOB8hZe04PphT6cRQH6tEHCrTO25PTApI5XszQYKvmnPT41dPBnQxNf6GZm+/QaCTnLBN+VvEFFa93TXM9f9hfRAYLjrgIzBqKq5ewrZ6Ssf9i7T5944ycNQ7N7S+igwtaVo62aXeWm4pp3sMCN8W977pX1PGExV05h8Omy9TTs3yW3dKUHVlue3nsSgcMXGa4dg7AbqLZZ8erRCDtjia5M1tNSf+kszkO6ButGQMyM/IN+kgnJauEOniBoibPIVLRP8Gn0sS3gQbwC20DipxGkQXgxGrGh5Fgqz8Vcg/w4lvJeCHYfeivIXD5qxiVnX6KVvuS9Eb0dN+H//Bau8RHVvtBH0L1RngJ0Mq+Se8i345F0Nbc/qGRqOdiDxaI3vE/8/XLhKLZuLMlkVilYArcBhV3cSeDCXa5m34wpiQa8Nw6Kp8kEjGKQ2cG/CbYZbygGok0DHbWOxl2+TkoHJ5UX+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(346002)(376002)(396003)(136003)(366004)(186009)(451199024)(1800799009)(26005)(5660300002)(6666004)(44832011)(66556008)(66946007)(66476007)(6512007)(6916009)(316002)(41300700001)(52116002)(107886003)(8936002)(2616005)(8676002)(4326008)(1076003)(6486002)(6506007)(478600001)(83380400001)(4744005)(2906002)(86362001)(36756003)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjZkNU5HNjkxOXl6Zmc5Y3Q5ZEQzSENQRVZMdVpwckgxdzNvUjV1ZkZ6WElH?=
 =?utf-8?B?K0tHSm9MRDBOMlR3ODFzOGR2dG9mWFdScjBXMkZKdWtCdEZ0YmRXbkFMKzF2?=
 =?utf-8?B?dFljRUpXeUhrTzRpZHZ1MUxlejl5VWdWS1p6V0JKR2w1NmE4bDRUaVE5dEc0?=
 =?utf-8?B?OEZMdkFJKzNmUGREbmx2R0xZaVFydXpGTDBHMjI5OTQ0amx5bzlVQVNteFAx?=
 =?utf-8?B?VmZxdnJiSlZqSlk5STdFK1FBZG5SdG84WmR5cXlGTXFVYWl0bWNzQmhvcTZU?=
 =?utf-8?B?cEYxamhWVTE1a1ZINk1MU0pxdE1QSXFwTzdUT3ZmeTgwSllrQVJwdTF2Q2Rq?=
 =?utf-8?B?eUFxSU50by9aNkYxMVNKR3gvUTMrZjl6b2o3ZDV4MHNWUDF0WUtNaStYYldD?=
 =?utf-8?B?WnpzSm9zWW1Yd0E4Zm9DY1l0aSt1bHFrV3UvNWxsaEs4NW1HUGJhU2N1dURv?=
 =?utf-8?B?d0VTcisyYm9lUk5CdkxpV2Yrc1pqZWRoMnFRU3JkKzhpbjZOS0cwYy9vc21X?=
 =?utf-8?B?L1E1Z2hIdUNxZDIycWc5czlnSTlyanp6V3JDQmxJOGF5eU83akllYnJ3aWV5?=
 =?utf-8?B?Rkoza3B5OHhWYkM3SnVKNlVSY2tvcGRwRE5ENEV0VTltcWFoK2VicDNaOWVq?=
 =?utf-8?B?RkJCQ1RiU1l5OFlDdlRjck1LU21QOFNwOGNvSng0S3A3OHlja0RRTVdCT21L?=
 =?utf-8?B?ZXRDSm9OV2FWVE92c3JsbXhnQ2twUU5xUTU4WnBqWmh6bGZjdEh2Tk5qaEpW?=
 =?utf-8?B?ejQxbFVXUkJKTzJIRk04Tk5XQzJOY1drL3NjZW5SWmdOSHRIdDhQWjlRK0ds?=
 =?utf-8?B?TEFlcjZYNmFYWmhNWHFDZ0ZNN3hPeHI5NGF4a0ZaWHhvaDVhcFhoNWt5UHJY?=
 =?utf-8?B?K0RRN3ZMSmhTbFJvTWoya2pOancrMVVUTkFRR0VKcCtTUlUzY2tGb3JXNmxW?=
 =?utf-8?B?Tm9oSmU2Snh0d0YwUURQNjB4RW1lT25GbnZLNVErRHY4YjQzZU40MGFTdmhp?=
 =?utf-8?B?UXZBaDUyOFRQV1VNN0ROTFNwb1VsN05GU2tvajJpaDNUV3YvQXdIVW80Ulcx?=
 =?utf-8?B?ZlpwaVZ1cHp2Tmh2UXdpa0M0Y0tiRXJBUEgxNGtsTm9icUVYeHVOMkZ3dFBM?=
 =?utf-8?B?ZFg1cUI2ZWxQSzdtNklkMnNiY05sWnBBZUtBb3Rack1aemN4NEhiNUx1c0lZ?=
 =?utf-8?B?WlRTNUR6QnkvazdZRDVSZ3ZhNkhacUhKaWJEdWt3SFVKTW9jcDlTZ2Z1KzVo?=
 =?utf-8?B?OENlbkY2VlpEWXlpdnBmTy9kc3hFZGY3ZFBXOTUveU1hWUI4SExNS0ZSaWpH?=
 =?utf-8?B?R0ZJZXpMOTNuUDFEK0svR0NXUDRGczc1T1owMTU2dHkrRWJrSTVFdlR5c1Q3?=
 =?utf-8?B?MCtQOXZRYWI5UXM1QkZHZXN4YXVTUVBjbkNYVFdBTTd6TDNUTVBES1VYWFpr?=
 =?utf-8?B?TjZyQXB4QXY2T2xPTkczNEFCdWFhK2pTMlg4V2NPNUpMdjd2WVBabVlLSEdZ?=
 =?utf-8?B?UXI5Y1lERFA4UnRreVVMVEVtbmhaYitoZHczVVRBZjFDc3g4YStHWUNUR2xC?=
 =?utf-8?B?ZmovYVA2L1oyU2R5dHRtaENwT2VCRDlURkRFUUt4RlhSNTNUNGx0aWxQeDl4?=
 =?utf-8?B?enJEUkdiQlJQVnlaRWthMFhXMEg2cGFKVzBOMnVBbjZLRHhib2VrK3l1ZExh?=
 =?utf-8?B?Tmttbm9lOGp0UCtSdElCYzBvVmI5a1Yrcyt6RU0yVFVxWVl1WGpXenEwNmdG?=
 =?utf-8?B?czR0dVVwbTVxTHhVUGNnQWN6MWFCVEpOMjJMK2prcWFFTEFaZkhFWG1YR1RJ?=
 =?utf-8?B?NG5RT2ZpNDREakNHbnRWa1hPWGJ2NC9pcGFNaEFTam9QQ0g5dVd1MVhmRGxh?=
 =?utf-8?B?RnZkV2xJV2RmN2VFREQ2SkRJby9wRUpjd1BqY212dDQ3bnB4a2FnNzZlMkNx?=
 =?utf-8?B?Y3R6U0tlK0VyUmVXcTg4V3MrK2lENC9FMWdEZ0FIcktPb0FNaHYyWEpaQStO?=
 =?utf-8?B?cUJzOEpNM2grbU41aitXMDNobkttZHJjUTM0VHRkcURERmJxcXdMbTFYVWNQ?=
 =?utf-8?B?RTc4V2RoQ1d0TkhJVVNWNFNocmFnbEEycjNSOXZQeWtmVFVQNVBiSFNEZkdF?=
 =?utf-8?B?S2xLMmI0SklaQjdOOS9VVlIyN3dZL1FNZk9HVnZ0OE5lNzJYL3hrQm8wWDdR?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5eef631-5d34-4b68-e52d-08dbaeb49f1c
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 08:38:19.1936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaHC++3rn2RlKTIAg4JjYdm2zRBh8VffHNK5e9gwXBuPF1RoX5T9iCCUjblnxLerxlX3fm7v3Pv0trjBp6fk4qzICAeIHpFY5NY+auESOTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6497
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If panic is enable,the err information will not be printed before bugon,
So swap it.
Print the return value of PTR_ERR(pgdat->kswapd) also.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f13394b112e..0436f0ed9671 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7892,8 +7892,9 @@ void __meminit kswapd_run(int nid)
 		pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d", nid);
 		if (IS_ERR(pgdat->kswapd)) {
 			/* failure at boot is fatal */
+			pr_err("Failed to start kswapd on node %d，ret=%ld\n",
+				   nid, PTR_ERR(pgdat->kswapd));
 			BUG_ON(system_state < SYSTEM_RUNNING);
-			pr_err("Failed to start kswapd on node %d\n", nid);
 			pgdat->kswapd = NULL;
 		}
 	}
-- 
2.25.1

