Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5B57E12E3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 10:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjKEJvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 04:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjKEJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 04:51:48 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2046.outbound.protection.outlook.com [40.107.6.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD82FF;
        Sun,  5 Nov 2023 01:51:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICCxVThpwh/jym/TLoa4wk742ORY02C1JQUl01CGHCIkfh3czO4VBZZo+SrahUgYqMjB+D86ibwQXWl4PlpCnV6uk/4nKL23dlV8BdqCdp458P8mKxT/uK087VpWyyM+lyb31ZOYQSLtMDyK6QW3KZQa6qPJ8POazBbGbs4kt3CSul+A6blDUIIfmcj/qxkvF0j/BBvu0y/o2g6/rbPQuTY9NU/Otj/dHh4tN7iJKdboGcf2rKE2H/G1cjtKH+6lqgfSMeOML1ReL6WF81UYpPcZyMe9Hw+K/ZBO1B8npV5Iq8W71FUAWVXKsos8FgNV0Y5vv9fikDVcfHvupUN2tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drNeabeAd5ABgckLRSZ+8wug+1K0rKfYuSxCN55WjXg=;
 b=UQMli4Sx9Jm6wizkWCtn5NEo4XE/dtG/H/YLJF0lUUNOKJ9v1w9/CDw8gFH1C+WaSyDGHxOMKxg/9miUyzWJQivPAktJ8VOtjwXiEgLRgQAM0BLuiWrmEA057Wv2JLhFBLAt5wem+fUe5PqKqL8E68MdANcieelWMI+lddFuKFFhCtftI+LjpYISV/IbEzveZUfYX7T2t0p0hdbub0azRfGBCnmDw+S5mWONpEoh1y94C1PMQ9qR/aDla1ULS0mFn9+DFIjqGgBGbVHqlC8UpoAYr2dQ2mACVhtron+w3aSFF5hyQgXlccOl7mH6mgisQoSSshQcBLbq/5e9FEBLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drNeabeAd5ABgckLRSZ+8wug+1K0rKfYuSxCN55WjXg=;
 b=RKuGPjrpOjPAbeK9A/V3RHvPoABwswKsK01tHWFUp9U53pApHmaZf9q008eEqgy+pte/fcj0th8kvJVkrou38WJM9RKa5kirQ/T2pKZ4jyiSldizelMqGV815OVwTqJypYzwIaN9gzGVzTU5JL+luHbkMjVLvZuER56FV2nyI8ONNHssgIGZcJSXLnvkz4wPAgZbBk1+rBW8WGza/XAVTkcV63iOFeqH+hgaMfkql7e7oJbvAKgMKZHIZO9CeA84DWpuGYca6Rj9CAxsd/KIwf/Rw2bLEPgkJ4TIKnEFkKHGidtla5bNnvCmdIKzeryTNisrNri644c/ObQdagLDIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6309.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Sun, 5 Nov
 2023 09:51:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.027; Sun, 5 Nov 2023
 09:51:43 +0000
Message-ID: <06ed13ca-9f52-4b49-9178-aae245bfd958@siemens.com>
Date:   Sun, 5 Nov 2023 10:51:42 +0100
User-Agent: Mozilla Thunderbird
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH net v2] net: ti: icssg-prueth: Fix error cleanup on failing
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
X-ClientProxiedBy: FR3P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7fcf9c-0d94-458a-460f-08dbdde4d0f0
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPCOrYrOCJ5vYClnMXbmDKxkTGnjM+HFzUG6svGPCK8GhavemrAZa8oOyGA8yC2jjW1sShU84Y57/bFWNXnNTZeyUnVOYDhOIRrdv1H92Jqex5mOLRDDWcJvd6G4uLxgFNQunyGXrFBYN5T6yVan1sIPOnGgR3wH18PQTNZVIa6QGU6TlG22u2fRzwAfJvMigUd18T3L6F/UDFXnAB6u5OTcx78pOqhPRPno88qJaET+kUFm9Z7fQK3gRW4rMLl9dr6n/tOSjcau8pk20pGISh1ZyoLALmWfZFgNU/JfkMt9uHCt3AivbbAf25XEVsOW2rNF5MoVbInQR38f6jDBFTqPjVmFEcA8/FNXxuiJGyBDLpAow+UDldL9hKxsLVRrt89NGaE2PtCvKuNunVYGPOKZk1f/Anbh8Dchl1cqgaIbkZHYkXaWrRShT3SNyrma3PaCzBpPKT8X7s1pEqUywB6hKpdO8wTXZrEz2LiWOXX7fmglK2dc4lcWxIoRy1WuGlX8SE5u9UabtsCp45SkBNUaaq26pudX6wxRop6ZMpi5k6+unf4CSoDF/GdUANxMz4GT+lKrxPqYRFDGbBg4+PwETRx1IxAYxr/6OZma/rDU6uOnf9JNcpq6LVNmd0uaW3WEIA8qW6NytOsS9kjmSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66476007)(31696002)(31686004)(86362001)(316002)(2906002)(41300700001)(5660300002)(44832011)(8676002)(8936002)(4326008)(36756003)(66556008)(38100700002)(82960400001)(54906003)(66946007)(110136005)(26005)(107886003)(6512007)(2616005)(478600001)(6486002)(83380400001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTI3Y2dSVmVZWlBQZ0VHZURrbTFpQU1mSml1ZmNCSzZlaTh2V2JlYXJRb0dG?=
 =?utf-8?B?QXFiTGwxMGoxQXA3bzhTa2lZZnJzTGIyc2RVNWtWbnV5VElBdDkzcWN0dzVn?=
 =?utf-8?B?Z29TMytoL01qZFVlcDRhVnU4NG5JZklqL1dhdlpOOVVpU2svZUNuZ2x6QmpC?=
 =?utf-8?B?TGNFYkFqNk9wV1RUNUNoQ2tQUzZacVp0aTBPZy9iWTR6aWtIbnNEanIyL29y?=
 =?utf-8?B?YUFTSlNKMUlpQkx2cjE0UEJZQzNnWGZLV1lUMWpBNzRMc0RBUmxVczJhc1lJ?=
 =?utf-8?B?TFZyYjY0RlZkNjdnUS9aakFyd3l2WTlLZWVMR0hBNUp3aitnNkpUWUlhcElW?=
 =?utf-8?B?cWp5T2ZIQkFkWit5eVpOVXBFU21SMk43bzJlUmpuVEFmR3EwN3BpU1dDampY?=
 =?utf-8?B?N3F6WW1TWDhKRkVrT1NGWFphN1ZUa3hjQUNRd1ZQVk1WT1lEdG1BRDR0dXMy?=
 =?utf-8?B?TFdqS29abnc3VU55cGd5VmNMMHU1ZEJCZ2JCVDFvNXR1UkpRTmhlQ3dtYVNy?=
 =?utf-8?B?YW1nd1czdzhYdmthNmVsUkZWaXcvQ3ZkaExDeWtQaGdqU2NFNEd0KzdHNW5M?=
 =?utf-8?B?QVBOMEtFMTJzalh0TXpVSzhTVjhhWlQvSzlmdlhJOEs5OHVzZlF1TlhtYTNR?=
 =?utf-8?B?UWVIMktzelZYZ3pNWk1KdXFweE1LQWFBODZiT0paNjcwQnlDN3hra2dFTFBF?=
 =?utf-8?B?OHhVSHE5RXpuQW1abnc0ZDAzK3U3NXZFVklxTWYveDhXdDJSVE1oYUVKMGFB?=
 =?utf-8?B?bFlZcjA3SHAxMnMrRVlVM1V6enhFVmtvc2FvNFdES2Frc01RSlFnR1M2NjhR?=
 =?utf-8?B?OUlmTGgyYjRvbERTRmlLUUx4OHBaa3pQOWlmVVN5ZDRqbmZzYkFocFpNeTRZ?=
 =?utf-8?B?SVdNSitBMnVjNEVJaDZHK3R1bnlVLytobGU3NXRmQ1NqZ3ViUmRoZkNFMVRX?=
 =?utf-8?B?bHF2ZDhqd1hnQ084SFZ3TVpxdWtZQ2VTODkxeUJUV0Yzc2cyNmRXbVptUXJ3?=
 =?utf-8?B?WnRCVjRtaFhZeUIvM3huejhubFJWclo0cFZtV3JaMzVaQ3NmR0lGQlBQQnhV?=
 =?utf-8?B?Qmg2a2syaXQxUVZSRENvNjlCcFIrOEMzUHhpUW1ydFZiUkRFaXk0QkRZV2da?=
 =?utf-8?B?QnJ6dUI4WmFVeUN4WkNyM0lKU2FmWE1CN0tSeDlwSm00SlhWTHZDMmdoWkZG?=
 =?utf-8?B?L0tadjZSeWlOQktabzZ5RXdYYlRBWkFEOFZPbU9rWk5HMHhxb24wTzRYS1VF?=
 =?utf-8?B?NTVWNW43SkNtS2hYK0IvNUlwOEdWT3pML3Z3cFVqYm95bGNOL2JPclNVQlIx?=
 =?utf-8?B?TFpXRDFJaC9vcWtHYTNWaEl0RDZQRUU4cUJuRWFBdkVXZEJQa0ZSZDlVNGpC?=
 =?utf-8?B?RWJHcHZ1d202U3RWZjhmRTdobFlXc3RBWDVXNWM2c1ZFV2Yxc2NWYk5lOVls?=
 =?utf-8?B?T2JsamxnQ1hwTHBMYXcyZ3I3QjRmajRQSUwzSnVCTC9KZjJFcGM0OW44RXR4?=
 =?utf-8?B?SkxwMlFEem9zUGhXWS9rM0xtYjVab2crcW4wb1NUR0tqQzRsMVFpTHY2UzBs?=
 =?utf-8?B?WDROVUZRUnpnQlBtSFpwWVo2WUhETGNHWXVYVy8xeHgrNVdXN1E2SWF1Wkx1?=
 =?utf-8?B?ZGx4M0daOGdkemU5cG9yNVdJalhaQmxlUGxZN3V5YTgzcXo4WGlBUFRqbjlq?=
 =?utf-8?B?ekJjNzdJUy9pR0hEUHRBdnpTUkZQQW9zZDdENlowSG8wKzJVZzFTMTZCWGV3?=
 =?utf-8?B?SWdCWW84Zm5zVFljREJLUjFyZTMzeGlRV3hlTW1aaTBUZDNBSG5rdkdudDYx?=
 =?utf-8?B?UnIwRDRLd28rYmU2ZjBNNk5uVUYzQUtUNzZab3FFRSs3UGZEOU5QUWhtOHFL?=
 =?utf-8?B?eE5qeG5aQVF4WFNWd0crem5wbjBOOUExK05yZU5hUGpTOHF2NEpuRkh3Q1Fu?=
 =?utf-8?B?K0FuUW1TcG0vNkFUbTMyU3VOWjJaN2pEZC9mTFJzSENpSkg4dWRBYUNCV3NY?=
 =?utf-8?B?ZytyVzRmS0lWdkNXYUpKT0hDdUhCeDlzZVE1VDBtSXl0WGFSanN5ZnZmVU1L?=
 =?utf-8?B?aXk0SHp0KzJveW1UdmJneWNsUllBb3lvdWxMUDRySlQxQkIxOXlQWmtPdDZv?=
 =?utf-8?Q?g2jt0/dd0KiInuRGa7J1yBRzE?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7fcf9c-0d94-458a-460f-08dbdde4d0f0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2023 09:51:43.1869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zB5cPa2hk/+RH3bCEd3HslDIFKmL/NTJg0UPZrZRTaqiSqhGaf8PjIRRqBMOIOaRNhJiv+J3BofeaIIoOVdPsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6309
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

We were just continuing in this case, surely not desired.

Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - add proper tags

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index d119b2bb8158..845e8a782d3a 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -2063,7 +2063,7 @@ static int prueth_probe(struct platform_device *pdev)
 				       &prueth->shram);
 	if (ret) {
 		dev_err(dev, "unable to get PRUSS SHRD RAM2: %d\n", ret);
-		pruss_put(prueth->pruss);
+		goto put_pruss;
 	}
 
 	prueth->sram_pool = of_gen_pool_get(np, "sram", 0);
@@ -2215,6 +2215,8 @@ static int prueth_probe(struct platform_device *pdev)
 
 put_mem:
 	pruss_release_mem_region(prueth->pruss, &prueth->shram);
+
+put_pruss:
 	pruss_put(prueth->pruss);
 
 put_cores:
-- 
2.35.3
