Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B2C773B6D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjHHPuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHHPsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:48:35 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e24::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5E84693;
        Tue,  8 Aug 2023 08:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtYu1YG1xzlW+u6tXeVQYB+PJVIxwR5fxR5b9m7/Jcx7hLWyN4cG/5BxSqYxOUKAz6j3hhvr0Ff28BskTmMAE2zD57WtUXynV+zYveFqomjq7R4/9MRCxREogJZLpCCTOPBsWyNBPere6baf31q+Y4JaXmeZHJXcJGqsspVTtj0jzeSGaU6IDsuqaeasBAJZLvrWTF5IRmDK2bU6iMtHHGm0soG3+kOkg8oB1LXykOZnKViqERTY9Zkb7aRaMRxD6MeqplzDNPNQq6+QY459XMxa76WVEQPGiBkERQo19lI+XIAzkLlcCKS26t0IgiKrnPMqXeasdvQh7D3gC7nMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boCy9SNgLaOWTFDQH/NLa8Tfd0p2terCm6WZR+i1ebw=;
 b=LBWty0jZQ3Kc8pTz8AWo2Kgbi4ag9hFuGeioGdH+QTAamfXCD6HFVlwphAAyxxdtEp5OFuq0DUB40lMZiZygyAUJF+ZAk5RWLcc+smAAP7pFZXnOJDNHEgUr8NuJtJdcldAb3rIdWXVyqUnf1wlcfKv4n3OEnzJY2WNKoEhnkU90V7bZf8XjyS7b/rs/wMEF9HroaSUiD8OOdEcfbDFJwio1E9SPXUOCMwSAQSydwrUV+6PpI1Kw1Gfhf1HPQgORaxfHISQ7Di4HbPjhfL2q25ICjlsZBUzQISCeV/XTzCLoAzgaIUnXdsM0k1FOvTolrP0WOaMJdIxViCcfFOVzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipetronik.com; dmarc=pass action=none
 header.from=ipetronik.com; dkim=pass header.d=ipetronik.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipetronik.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boCy9SNgLaOWTFDQH/NLa8Tfd0p2terCm6WZR+i1ebw=;
 b=PmZA4WKsc+uRPSLJKbaiWQO7wVbYBsbAvCPwdmN7ws7ZQe504u3vjtKdXIow6sE/KQA7TTj3ekQMlNq07rxAtZFjbmCPWg39zhRdXJDtBXZxMxuqt9gNNIOoE/X5NutkmYOBIt8QL83T001CWnX8xd+/XJQFbeUweyc28yr4yiNLoANBeWroonjCx8Lfb3pcT66z0YqqZW6QdC+wMvLw24Zmh9EaLUU49OWb0pao2vHyLCXfBsfydYfNAObh4lacHx/VFW2sgsoh6QsPfd8O26BveK3M3Uwr0S2S3ExhLHs30uoYVp0VRGhv+PaCP0PGYqVO2GdWedVxzXz8p72chA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipetronik.com;
Received: from BEZP281MB3205.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:28::12)
 by BEZP281MB1976.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:5b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 15:38:48 +0000
Received: from BEZP281MB3205.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f4f6:cb64:e0c4:ab]) by BEZP281MB3205.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f4f6:cb64:e0c4:ab%2]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 15:38:48 +0000
Date:   Tue, 8 Aug 2023 17:38:45 +0200
From:   Markus =?utf-8?Q?Bl=C3=B6chl?= <markus.bloechl@ipetronik.com>
To:     Gregory Greenman <gregory.greenman@intel.com>,
        Luciano Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: xvt: fix tx_req.data not being the last
 member of iwl_xvt_tx_mod_task_data
Message-ID: <zwleihaxhtvxfutlncdn3euf56m5v7kjiamhobhqiuxh47zttt@mcivytuq6flb>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0019.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::10) To BEZP281MB3205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:28::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3205:EE_|BEZP281MB1976:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ee5e6d-e22a-4577-98f2-08db98258eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q1EwLhHwwEgEkuphyPw+T7HYhJvPCX67N9WrX3FauVLwidZQNiKNy9kFtUKYaV+M4qSAbJuvbKfpK8H1r/h3eNOKsgno9HFAx+FAT2nMUbMTaeMyiSzGy36MshxqCIQNQVitQz95eSzAU775IAJV2jHxPLJtCF8wo0CBzD+oFS9lP1c0vPdn1m4osUpasoJrGgVdVrK1dmNtKRPdPjcRxT3vF+hKrVFR/rK77fY1pKK350KKVC+uqr7nywbzQnxz1g80gUs4DzTrll3IVC5beK3tAnSDq+zcJBIREQXIvhRXWZ1Iaz3wW2kPly/wtf9CAwoCIYvUrGEp8yHS4RfnxOIo2AQbOgLIcYQ47Bl+Fsm1uwFnFCtEe2Z5vHyB+Fl1L12sM2xXXc3jg6ZC8XD/cnGlssYZrFDXD2YIEvT4UE5cgcqhsHBGgcA4mMFH7+lNy3+nfAuVP8Oe0enNpIa6aO/VjD+XhgktyyXROqBV9Z+TPTES0gtE1unNdtPREFBtAHeUurviWTTLiKMAfHbygx3MK75AnlLRdytRFUB6A7T9tcowllSUm1XqyIG6WjOiI28lZ6qvDfhqEp1Dvubp7wu7ju2XvSd2tlzaGvXdPiFKEXgr4aB/U+14WF7BbrMSDNe7aFXGqNcnbhTmlsYYFTJ2Ab8ehF+8ZYdQoKk0lI0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3205.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(366004)(136003)(39850400004)(346002)(1800799003)(451199021)(186006)(2906002)(26005)(33716001)(38100700002)(66574015)(6506007)(8676002)(5660300002)(8936002)(83380400001)(66946007)(41300700001)(66556008)(66476007)(316002)(6512007)(86362001)(9686003)(6666004)(4326008)(110136005)(478600001)(6486002)(12101799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFNPOTRNNzR3WVMxaGVFSnNvNWJqNjJjeHJJUFZCYU5sYlNRcm5jdjBTaEJD?=
 =?utf-8?B?SlVzb0RvUmZNVzN1T0llWGlyRVhmaU92QTJhQ2wrSnVGZkZjWVoyK3VjMWZh?=
 =?utf-8?B?K3QvdzVMN3l3bkpaNnRLem11S1k4UTl6M3drSVZ1d2F0dktVRjVncFF3cjZr?=
 =?utf-8?B?dDdVaXErZmI2b3VlOXp4Yk00VWdNQndlVlF1MHU3M09zZkxzWVdaK256QTEz?=
 =?utf-8?B?U3dJYkRQWEF0d2F0dzZIOFBaTWpDdFhWWDByK0RXNEYwYTU4anZRU2sxdmpP?=
 =?utf-8?B?ZXFXb29lNHc1UnJiY1hCUEE0UUVycGdyaE15bDNGZmV0ekV0NjBQWWVwY3dY?=
 =?utf-8?B?eDZCSlNaazV6TG5nNjBYKytYbjcyRlhQS09qZElwZkJ3YnMvWHR5R3diMHU5?=
 =?utf-8?B?TlNVeFZ4ODBsT2xmVjBGRWhEektXSE1kZ0YyT1hNOEsxNGJ2Tlhvd2U2ZVky?=
 =?utf-8?B?cU1GYzNlWmhVVU1DVEozQTd3OTh5TXgyNUxubEpIcjI5N0hFSmt0bWR5eEdV?=
 =?utf-8?B?UnNQWXdhbUlaT0xaWVBaejdOcjJKOTdBTSs0Q0x4U2xtOGxPcVU2eUhiUmxQ?=
 =?utf-8?B?dlhrYkFXeXRUeWZYQUVMcWlvUi9wU1dydXZHSjdOd3YybEw3NDFkd1lGS2Zx?=
 =?utf-8?B?ejBQQWR3cjBqLzFwYkExMXVMSFk0L2dtdm4rK2JoOEw1Q0srTlBSV0hma1dJ?=
 =?utf-8?B?QzZVWVV2MkI5cm9tMXJ3WE1XWURyOVh0MUNwa3JJTm9jSkF5V2ZZU05wclFp?=
 =?utf-8?B?WGhhUlpkc3Z4U2pXK2luaHdhOEZnTmRXQ2FaYjJTSE00bnZoZ2hOVDJuL3d3?=
 =?utf-8?B?QWtGZGlzU09PSG5wZmh0YjE2TmVWOHpsa28wTkpxa051aysrZjlFcG16akJ2?=
 =?utf-8?B?VUdsdEtjQjg4Z0tPTG0vMkp3enNySlVRUVJjTVRJSEF1aDQxMGlGRE43dUpR?=
 =?utf-8?B?WUlOTjUzb0t1a2xDSzlpeDRMengvMTQ0dXpsVElROEFzaUZKbkZNdGc1dTJx?=
 =?utf-8?B?R2FKM3NwdFR5TE02b0NqdGI1d1hBUUh3bzlteUhBT1ZsUkdYdFZBbkdwUzZP?=
 =?utf-8?B?NGJHSCs1ckk1OUVwbUFOSTJUSFpoblNsUXZXL2szNEh1SlpyeUFVTmxVN2Zv?=
 =?utf-8?B?L21mbWdlRzQwNm9MVCtUTzhlak1kN1BFT1p0ZzFmKzcyVGUrL3NJZnhpQlM2?=
 =?utf-8?B?aVd3d096endpSW5jL3lWbGNNQzdNWXhUUThFTGxQM3JLUDZiWjU5N0lmd2h4?=
 =?utf-8?B?aHpkMXRYWlUvc0xEbmtsTnFGWEVhZCtsUnNrTjJJSzBqQ3FwY0ZRSkpiRGo3?=
 =?utf-8?B?LzdBMElxWHUyVHQ1ME1XVFlYM1FTNkRrWlcvSHg0dkEzTkMrcTRvR0NwVXpp?=
 =?utf-8?B?QlRpc1BaNFBrZE1PSENQdkh2cHdCV3MyRDVHOXRyazlEY2Z6T1hhazZFZzJi?=
 =?utf-8?B?VzBzRk41QncveWJzaGgvTGt1MnAybnI3UWZvcFB0TDVTNi80SDhrVkYwNGw0?=
 =?utf-8?B?bHNpVGhHNG9FbTZBTS8vRmhsdng4K0I0anVtMXd4MDU5Sy9EZTNkZmY2QTN6?=
 =?utf-8?B?NHU4cElvK0tYYm5ZUVpUNFRaZ3JhUk94aVBSbjNIWGFiSElsNkNUZWFpQUp6?=
 =?utf-8?B?RVdZSHRqQVVnUW9jRmJuUjY1ZkEzU2FFdzNxK09kdzA1RjhYdWFtdzYwMEtz?=
 =?utf-8?B?T3FVSTcrRHBLTWZ1bHRESFExUERhd2tqYkpoRU1iR0ZPMzRJNk4zSHZyUk9T?=
 =?utf-8?B?dUo4STY5ZjhHd2JWc0VXaUhHQm1jZFBhMFVmZXdrTVgrNzdxcjYyOHVmVUc1?=
 =?utf-8?B?Z0JESnJnMEZobWoxaGZqNnFNVE1WbW9OampvalBuVGttbmR3a2JSdjQ1Nnhp?=
 =?utf-8?B?cSszbklKU0tPSmFLdE1leWo0UGFpNUxocUxCV2Z6N1Q4bmFXVHM4SXBVZndz?=
 =?utf-8?B?UldNdWtvSU52aElHNE9nWjM0cmppOVZXL1BMRHZTUEhqRkh6bHVudVNURXU0?=
 =?utf-8?B?VTEvZ1pFNkYxV1Q3R2k2bGtMQ2tPaGxEbFg2WWVxWHRBQ0ZVMWwyWi8rcEhi?=
 =?utf-8?B?M1poS2NDNHo2bnBDUUtzKzBzL1NzT3BGaml1NUE3Umo4eGY3UUxRWVo4c3FV?=
 =?utf-8?B?bGpTT2cyVHdJWkVXTWJhT2dhM0tvdUtlU3NseDRua3lFYnFQQzR0VXRtZE1T?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: ipetronik.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ee5e6d-e22a-4577-98f2-08db98258eac
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3205.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 15:38:47.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 982fe058-7d80-4936-bdfa-9bed4f9ae127
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikAp1yVc1OHYOd+PsWXYhlmTJWz5W4upwZerk4idyMfiCChihVfZcpvlph3bIS5ucMgkoB3O8+Svv0VRSxgbI+glBudKX6aBOA4Jt26Jsm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB1976
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is for backport-iwlwifi only.
There is a violation of the "encapsulating flexible array struct" rule.
As struct iwl_tm_mod_tx_request contains the flexible array member
'data' it also needs to be the last member of struct
iwl_xvt_tx_mod_task_data.  Otherwise the flexible array is no longer at
the end of struct iwl_xvt_tx_mod_task_data but instead overlaps with
iwl_xvt_tx_mod_task_data::completion.

Fixes: 3316d819dc59 ("[NOUPSTREAM] iwlwifi: xvt: fix thread completion")
Signed-off-by: Markus Blöchl <markus.bloechl@ipetronik.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-tm-infc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-tm-infc.h b/drivers/net/wireless/intel/iwlwifi/iwl-tm-infc.h
index fa647339ff93..68b44662cd78 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-tm-infc.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-tm-infc.h
@@ -459,8 +459,8 @@ struct iwl_tm_mod_tx_request {
 struct iwl_xvt_tx_mod_task_data {
 	__u32 lmac_id;
 	struct iwl_xvt *xvt;
-	struct iwl_tm_mod_tx_request tx_req;
 	struct completion *completion;
+	struct iwl_tm_mod_tx_request tx_req;
 } __packed __aligned(4);
 
 /*

base-commit: 7a0a4e45dd7b1482c9964748d0ffb086552a9d1e
-- 
2.41.0

