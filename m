Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599DE7E0169
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346909AbjKCJNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 05:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346901AbjKCJNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 05:13:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187B4D4B;
        Fri,  3 Nov 2023 02:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTMliLc/JPJoL3/CvsZBlPEZGN1rSO9zy9IWtwXCYs3L/KUETEO/sJrac6l0M8VIZY8mUigwB359FzX/cUcCy2ctXgjk0MqXVd+sXDW+55PnTr882tezJngkg6C+KPc/IDpilYpgFmQk7oQqPYOR8PrP22/qOUwpkvL2rYahHJ3m5P4CpPxPOV18p3CXIoHZaM8f4M67F1PzbyA+RUUjZ4TAtxW+FLdLJN1UWqr2NWjEvk3g25ykOQCs504uUucEZqKPK4iQOArGMZ6VLsC3QU0jTROlS9q+/Wgsmd5PiyVVKwyXHwNtry39s+KzI8MFWziqkeQ5P3CaurUq8z0NKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzHGoHdzG6OhdLHcyl9PZ34QCwkdgcvjB88vQ2frIl4=;
 b=nSk78APNSe4+71sJNcQxVpU2X/BPlk5rAcmac6Fq4sQ+N2qNHzYfYlYYwSl6xmxIn7Yabx75BEEsBYxrELMAAAQqFjqU8wD5Yq5WTMxB9ph3fZHHBvSCgArvBBMzrADn+nPR+oqk5DPNdyNgDyQJ1baOJgs9qYJ13J3aU4MOYLHVy93fQXN4XX2ka8H/aRZrgdZTMZcl2r2xKHhwa6QBsAlGZ5othfiRf/EuT/VlSCaUmLO+3Lmnt7c8HywC+SBjvzxja9u+8YyDOBH769gQCBEddKsGTMi/3LP9B63ZTD0Bwb5PbASsjwNmDz5tX3SHtU0IbdQXhicg9ZlWPSFuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzHGoHdzG6OhdLHcyl9PZ34QCwkdgcvjB88vQ2frIl4=;
 b=EUEIohOXII9MWovXMbcoF8jLKbhVEruSOQNJqaX20yUgRJVox0oww7YXeFkxTiR/q/2QM7Wyk94U3AC9LaQB/fTppbrgSf7uBPzKIwfwCOb1MBujtyV9Hlo9xffoOYcgyrhqXJlU+3wIoqeun3fvvUjwM0BECOkvkyFRjtijkPNbQGWTkJD658BbrIWIdDHlszvLIpBrB7LMpOyti5haFjBjdZaxY0KZguisUwa5LYR6aQDqUwhPh5K2NBvJC7TXIdpa91MAIDLEBjbQc9ZerzYTMJ1LiAk5mwcYE+YaueUsqmdrtUTEOvrWozs6Bc4461RjAY82yE7Q8ceSV7X+yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 09:13:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 09:13:38 +0000
Message-ID: <eb621845-45f8-4822-b92a-365d485f6870@siemens.com>
Date:   Fri, 3 Nov 2023 10:13:37 +0100
User-Agent: Mozilla Thunderbird
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] net: ti: icssg-prueth: Fix error cleanup on failing
 pruss_request_mem_region
Content-Language: en-US
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4017:EE_
X-MS-Office365-Filtering-Correlation-Id: a81ee0fa-80ff-4029-5436-08dbdc4d2a50
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmSHsWbZZlBPToA1ZjDsZ+7YqJQnD1wROAV+1rz/ObLu7weFm5jEzRLsJ3i+a7jWefD4bGhkusLvdmzD8eA1f1y3yUSXTvg/0JPN2EWPmRAgJXV7RdOI2gBSB3G6acHbMUHM68zzbrI9N5Qxtaqu7ASYbaHJc68bFZkXxwxxaBjjKpDOzXOKFIykmk9UiDILqy5YhMmzpy+92IJ1KYMBj5ZQb4yIKjFy2yLHImwwBCS5y+kCdReOBcHbuJMBsUAq+v9LJbztaRfRAQ2uNVNVq8p/GtjXDxTwEhCbR6N2Wh3s6p6yH78EvFvUW8RWsAPwomG4ecpfyYX9UUIj9zRhja1CquZ1hJ/RPvGq0XLZrsxIRybzYWTnSB8hqGaYRZ4gih0x0jFt2h5Jo3aVIepc5eTZUvkcmdMW3Eaxg8Zs5rS3ySqwH2IhqaohYMO3oRc2/q5c6yiMjJt/MfJglsUpjwndV4CXhrIPJ40j/rDhF7OvYCCuj/lbudbxcxV5hPAYAN/pYNOrs09jVHKQklj4ZkeYI9AEFGiUVrn1PRCjAeq9XjoipvokL1jVs3peBmmiRuRfKpokfL2YuPPDKMOnPBkIzPAW72CT9FfpwULoD5QJ7xOQW7GbSLyiJfDRBFUS+okmsoLs2bqzi3GxaGse4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6512007)(2616005)(6486002)(478600001)(6506007)(44832011)(83380400001)(26005)(2906002)(107886003)(66946007)(5660300002)(41300700001)(4744005)(54906003)(66476007)(66556008)(316002)(110136005)(8676002)(4326008)(8936002)(36756003)(86362001)(31696002)(38100700002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnZ1c0VJWUk1UEtKbGFSQ3hXdzFyTlBOdy9UQVFka1JFTGMvRXJNTlZva2tK?=
 =?utf-8?B?WjdhUTZsRmJVUk83SFRJNjhWcDlkQUVHV0o2V3VFTzZpZGVrTExySEpTRXRW?=
 =?utf-8?B?amdzVUw5OTRlbENKTThvdTVXNHh0QlNEendZMzVjNys3N3A4UDdqNTJOellr?=
 =?utf-8?B?Vzl4YjM4b3YydjBQZTl0SVkzU3VXcXRYeG1HOHdWVTJWZmVkUnZmY3JMdGZq?=
 =?utf-8?B?OTNiTXVXK1d3YzBHcU1iSkFuNTY4eXZpdFNJWTlCUE5oaGwrRzFBNzAvODJM?=
 =?utf-8?B?QSszYkQ3cGFFdFJKMzRwaFdpeE1LNGswSlZUSWtLTUhWcGdhMklzT0JZQzM5?=
 =?utf-8?B?UGJpNUQwSnA1WWt2dFBRTG1RUUY4TTVEQ05HZlRacDBVSEhKM0hmUGE1R0RN?=
 =?utf-8?B?SUhHVnk0Z3U5YUNoMzBPR0VHVXo4OEhpbkxxSzFGVmpQTXNJTFJIb0o3Mjlo?=
 =?utf-8?B?aW8rdzIzV2hVc0dPM0V0V3JJenB3eWdYYW94V0RpaWd3bU9YQ3Vna3Zzb0xU?=
 =?utf-8?B?eElOVFhwUlJKdDhJamZLV1A3QVN2ZTNxMjROK05pZDRjZ2xCR1g4OHh0TUZU?=
 =?utf-8?B?enFVY0hCdm1Bd0xDMk1hLzhGRm83b0g3ZTk1eEpKR1R6ek1FMUdObFlsbVdM?=
 =?utf-8?B?VUEyY05VRzFXM3BzSVNtWjhCY0VSSDQ3ejVVckJQREp0anFRWlpHN3M2ekZv?=
 =?utf-8?B?N2NRMzAxaGxBYmtSVWhmZmNydHBsUzZRclVqZFpjZ2hwa0IzK2lPMkZwWGRQ?=
 =?utf-8?B?S1d4WGNNbzArNVRoUDYraGxGK1NxTy9UdnNlZVRybDFyZThtSmhvdWVwNVBl?=
 =?utf-8?B?bE9aOXNFYnBDT01oTUZraTRiSWliTEt3cHdSandSSXlWL3dPdXRZSHFvTWtC?=
 =?utf-8?B?NTk5d1FOLzlxUk1UY0pyOGVPZ25Ic3dXUDNlTHZXY3p5N2hPNHZnRVZQTGFi?=
 =?utf-8?B?STFLZG4wSjRNVkpWbG5COWtYUURaUkY5aC94eWNYNDQyOTB4MHRWTlFiZ2xm?=
 =?utf-8?B?YVFRdmlGKzB4Q1gvR09kZFRxOG1lV1BhOVIzVTBGYkk3cFY0U0wyaFlyaFFZ?=
 =?utf-8?B?MGFvYlVCTGFQYVdyRXJDUmx1dVZCV0xJRm15MlExVzFZQVJ6em00Y1VNNm1n?=
 =?utf-8?B?REIzT0NwU3hta1R3aUhkb2xYZVB0d1VOYXlrWG1kWHZDNENnVVdrTEJhUzRo?=
 =?utf-8?B?aW1SaHFOeEFaSEFZcGd2L2lxb08zbEc4RzRnamMxMTNpeS8zcWZjRGltbVln?=
 =?utf-8?B?OGhoQUhwaDdwSkNsMzlJaG5LR3VWNG53M0l4OFhHaWFFdEUzVlRCWnRsdW9k?=
 =?utf-8?B?ZjJac3MwR0FtRHFOeExXK2UvWkJ6M0ZrWTlmNS83S3VDWjVNbFhuNkp4SHlu?=
 =?utf-8?B?QnYwT1JSTkROcGtCWWdoME9pbDJ4RXlMMVpCZDlTUlhrQ2NvVDNCZWY1T0pJ?=
 =?utf-8?B?WkYwZjNydlFFS1pYazFUc3ZXSTEzMzU4UVQ2MHh5ZnZwcmpKVHlKTE5XcGtS?=
 =?utf-8?B?VHMxeU5GYms5a0hlclJUVEJrVm4vaEwvdERZaUU0MVl4ajcvUWNIWnlMaXk4?=
 =?utf-8?B?akZ4TWIwUUpITTl1VTl1NHNBaURyUlgwTURGTCtHYTd0aVZQMmtwdTBMUXQ5?=
 =?utf-8?B?MWh5eHpYcmViUWdHaXNlcHlWbkJWNlV0L3dCWWIrRVk3dy94R3hva2lNQUk2?=
 =?utf-8?B?TmFNRSsyTG5DdkJTdVVwd0hnSHlGa2JJbG1iMlJkTGZHb0dEeHltRzhnNStD?=
 =?utf-8?B?aUdJK2V6THBXK3FxVUlUT2QxTUg1cGZUWVp0TEErcGg4N2UwYW5aYjY3Wmlm?=
 =?utf-8?B?Snpoak85WG55TEZVUUJRb3J4RmZLUTg4SEcwTnpBWkppcWc0T2gwbWxHd1F0?=
 =?utf-8?B?M3Nad0tTL2VmcWJFSWxMYko4b0hHZ043b2RyWG10M3RhRE0xVUlPSnJaTnlw?=
 =?utf-8?B?M290dHhDY3FlSG40NXE4Tkh2STVWZkt4SU4yZ3hwSWdXNVFPSmU5dW1NR3c4?=
 =?utf-8?B?NWtyc0xDZmUxNG9FUnM5YXV0WUh0Lzc5bUIzSTJyNmNDUWJ0a0pkeXhqWDUw?=
 =?utf-8?B?dFQ5c0NHT0tVVzZsMnRrTDN2dUZrZkxsMzI2eVF4VWxoaWtudVB2U3BlNGkx?=
 =?utf-8?B?VmN5Zk8zUkN3aDNJTThTcXQzdDRMSWlFU2ZyWm9qOVFQZStBM21MYncxazUz?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81ee0fa-80ff-4029-5436-08dbdc4d2a50
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 09:13:38.4743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RplqojYZR1Qpm6UpkLFAYAwerir/xPGVFR//YTZqzsbz/wGKHxhEqWJ/N6B2EOxvNw2gPbCKwvqjZtdSTahiyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4017
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

We were just continuing in this case, surely not desired.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 0242e123fc05..70c696ef0177 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -2064,7 +2064,7 @@ static int prueth_probe(struct platform_device *pdev)
 				       &prueth->shram);
 	if (ret) {
 		dev_err(dev, "unable to get PRUSS SHRD RAM2: %d\n", ret);
-		pruss_put(prueth->pruss);
+		goto put_pruss;
 	}
 
 	prueth->sram_pool = of_gen_pool_get(np, "sram", 0);
@@ -2209,6 +2209,8 @@ static int prueth_probe(struct platform_device *pdev)
 
 put_mem:
 	pruss_release_mem_region(prueth->pruss, &prueth->shram);
+
+put_pruss:
 	pruss_put(prueth->pruss);
 
 put_cores:
-- 
2.35.3
