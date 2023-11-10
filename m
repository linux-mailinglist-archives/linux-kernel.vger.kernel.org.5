Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DB17E80B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344901AbjKJSR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbjKJSO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:14:57 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8099E3C6D8;
        Fri, 10 Nov 2023 08:13:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4lkLyf2863DVeiu1Tzo3lnEnuosagKKUWdl/k3fm47YcCebr63Hq0onRZo/skecLYbKJbdX/AY5h9i1XaKG+KYiydI4E186Gqg2UOW5GqcBYo7DxFP2ec9Q3VQU7jgXZdWT+/rC97jSvfsUdlqNA9fDFwSjzMGdBGHJproXIUEuh3ZoZdNNWyGHJCsAa7lfZj98pR04KnRAiOBhPQ+JBit+1fso2tEjetdkZdpEF94dH7oPb4R8XFwCKx/91UWKOGt2lbUfeBRVyLAhJyl1oVuQt4dlwieuf4YTDD1Du8nLvTmBE55J/ELUmFbd12PYVVe5gW22rx+Hh0vioBeQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcX2jxt4x2Vxyw76+dm9r0oMksDBreswRcx/5GtG6oU=;
 b=V9WmOHY6+k7SAg5Iu+J2PKV1nLgZDkJkyR/00REffoLg86zujukf8JnzUmf87C0b2tLaLtXSsVSlTEXP5L0oocQGkbZA7lmSyfXmmLHec4ljrFFmJRoTqhxy6Qcfz3lUnj89GqMfzkPq5LgYGTFWY3rYrUpq3ldYjWq219g977gaP1Oqo4IuPEf9eqscMEuCF/UqdvRcm2M7JgtQKTXrQ6RtBZ2thMjN5y850lXod2AMG6kDKvWVb5gAZH9GfI8uSiTKQJSqFRhzTZH1ulVnRswHEbhMLNSQL/6S885GmiRm8idJNw3FkIaBJPntvF5ShIRTxt+RTBQfc4+waM5teQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcX2jxt4x2Vxyw76+dm9r0oMksDBreswRcx/5GtG6oU=;
 b=yynuzWO9afb5krF+OXZBHMcq4ayMJqph3WS3KWHgiRL+JlpJR9EqsEtS7ouQC1Px4sHuNt2wv75pvX1xP4tAtPWFiCPoT+CsY96r/t5KaS94HPFU8otNfXjvgnCpRXT+85NSIAM8Ei7Eo4km9dx3GgkYVR4gLe6qtxDELxXAxVjBJ5qVjZSQUw94G9YJzazJSVjZ7/Pbl9WEdYz3WcePqxzWrr+rZCWWYJzsgjumQ5BW1W9u9bB5DUgqPm5b+dRAx+FXWXOre2zVHRg9KdgvEf3e34Th8U5B54Jiem66H3nRdbqZabqnGK3dl5ddeIS7Aq9Exu5DfmNHyA3DitR+QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7970.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 16:13:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 16:13:08 +0000
Message-ID: <7a4e5c5b-e397-479b-b1cb-4b50da248f21@siemens.com>
Date:   Fri, 10 Nov 2023 17:13:02 +0100
User-Agent: Mozilla Thunderbird
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH net v4] net: ti: icssg-prueth: Add missing icss_iep_put to
 error path
Content-Language: en-US
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Roger Quadros <rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:610:76::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d61adc4-56d7-49d6-68fd-08dbe207eded
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MsaB1bqxNDxFIfZxPkbpWW5tJQQ7Hu8YxQRo8Bui7PAFq+UU4+9GEwR2yPPMcbomKB8WoTZ0NbbUJgE0hwV1AKptUhlgzYrtWI+r9yu++9Kw8Hz9J1WuPtTuwmuvIWIZYhhg2E8DBquhu6zD3MDd836J0Kq/jPCbQP1jhX1hlUfmSZxTfhF1kOccWggPFsd4FIGB8Swqui1zyNPIOxfXOKqVsn5Le/3rbdGz1bBjFFssMTeDQOziFTrOtKzqnvyYgBRbjJKJOEqYLY/tojfY9W9jaXUZrAEcGBcu1Etn19MnOxRYwniA4gW1MmilaUa0dRIU4qQjpBErSDt1bZt8lSVcNWemttdqfoXz/HXtzb0McmakCZWeW6+uZ2MFxF6zJwo25/dh/PyeR0DJmQI+Bn/O741pPtop0jNSTeQ2EsAQj7VDXSik9BDApEHOzuqGW+9oTyGO6hv00+ObjUCF8Al5s8wa/gQHgRGcHRaPlI/VCnxHFgzqfm6g/Vp503X3KLTyjQciUk2CJ+xQCkEWcx65vPfr/YssODs3JE0jajuDzpJaWua9uvfKxc05Atds9vdnepV84MObVLtEaKURQc8OFlYC9VXcN5IFH9zcc25AEAy6PEdww9//OSXJewiHoqeN8ZQ3eypyxAzO1zxV+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(83380400001)(26005)(82960400001)(2616005)(44832011)(6512007)(38100700002)(6506007)(31686004)(478600001)(66476007)(6666004)(110136005)(66946007)(54906003)(316002)(66556008)(36756003)(41300700001)(2906002)(4326008)(6486002)(8676002)(8936002)(5660300002)(7416002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S25GamtKcjlEVXJhZFFZQ2tTSXd1Zjg2SnZRQVhkMGIvaysxQWRWcXVsRytD?=
 =?utf-8?B?MnpncEJzUHJmZmdmUUV0bFpXdDVPbVM1d1AvU3g1Qk1qWUNmZHRqQ0Z5R3dE?=
 =?utf-8?B?VlNZd2RYV29heDk5Yzl4QWNtSHBYNVJPZ1FpaTlQa2ZFM01tZktobUNCSllZ?=
 =?utf-8?B?K0o0SUJUU0xLdy9Sc215TVd1WWJpMjhjWXlqaVJ5L1hJM2RqNlBqWGtHYUZP?=
 =?utf-8?B?UGZ3Tk1hc3ZYRUhYbGZUcDlGcEhXNWRQMlJ6aDA1czV0UWlpYTEya2M0UG1z?=
 =?utf-8?B?dzFqTXF3RkpFOTVlSzVicHZQOVpVZU55bSt1YUh6WEhqQkpORnYyQ1FRNVhK?=
 =?utf-8?B?L1UxdlRaQWludlpCZFI4NkZObmJDMXBQZE44MGkvWHB1SDVJSmJPdCtTcVNR?=
 =?utf-8?B?SVNkN3NZaXRIbFFZQm5PK1BaUk5uQlBsSmI2elRENHRSRjM5Z2hQOFFMTWk0?=
 =?utf-8?B?dzdGL01VTVRLOVdwSG9KKzVFaUxoTFMwNUJzTUw0VU5pL1NXWDdRdUFSWjU1?=
 =?utf-8?B?WFpmQm1FN2owL3p1dm5Od3MrTWpveWRKK1p6dDdsWXdqaGp2ck5ZTFZkbDBW?=
 =?utf-8?B?ZlNqSVRobVBybmRkK1ZuVmd0ZDA2bE85bUVpRVdqRXd6OGhsUTErSm4rRENw?=
 =?utf-8?B?ZDNpVU9zS253Ly9hdUZQZm92REpqZmZ5SnRCSDVyMVY1WmVIMUdRMjdzdkl6?=
 =?utf-8?B?aWxqMXdVS3IrVU5Nazl3VHBNOHEwMDY5T2VQRXViMjV3OXJCL1RTNTgxMm1a?=
 =?utf-8?B?QjlIbTQxQk5qZGtxWEo1OXQ3NW4yV1huZGhmbEpHVDJkYWdYL1lVanhVMCtE?=
 =?utf-8?B?QmNoVjA0emNLY3k4WGZzNU8wK2ZGcUVzUHZST0J2OTNDK1cvdU01dTZ1MnVO?=
 =?utf-8?B?SFl5d281UlRZNnpNeHVWQi9DNzE2YUczKzBONE9ab3BYZ2lGU0VTSzJoVjJC?=
 =?utf-8?B?Qk9pUFhSYXZzMXAvQk5qYXNneHVoMUo2eWhwNVlCQ213OFhLNWJGRGRiMktY?=
 =?utf-8?B?YWwxUFpBTCtpM01mTDdicjB1MzI0a0laN2V3OVF0TERkMm16WmVsSkd0YURR?=
 =?utf-8?B?aWZkeHR2WWsxandwTFIrSnh4TE5oUjFuclQ4UE4reXM2cTdjdWcyRUMrSDlB?=
 =?utf-8?B?SzU4OUFxeG8vQmZESjVZODlQMGNwMi9DdnlqdzYyQTlRV0VQM0ZkQzNTdGtR?=
 =?utf-8?B?L0RJZWlPSnloeEcrTFVKM2hzSEZQNnN3SWlMSWYzK2xWYUdtRndJYXZMcU0y?=
 =?utf-8?B?U1pMenhsODF5bWwrNmpFZjVlNUlwVGF6ZWNZcnhXWGhRMW1tcHVpa3ZiSmdT?=
 =?utf-8?B?NklhbkZVWmMzQzJRcFJNWVgwUDQ4MzFJdmhIbFA0blMvcldSdU1kdUZ2dzho?=
 =?utf-8?B?Zkt6SFpRZTkyQ3g3SVZRMElwbDFkNjl5SWFXOXpBdzA3c1ZraXZwVSt5UXd4?=
 =?utf-8?B?Y0FaQTFuUXVxWmNMcWFiZUJuTTdFT3hZTUxOYVdoYkNySzlmSDNGQlFPb3d3?=
 =?utf-8?B?Qmxld2Niemg3YTRyakVxU1JOeWNsdXRDL2tPOUNBSVUzQ2NVUnlxUjV4eEZ5?=
 =?utf-8?B?NkN4UFlEcHRTMkoyQldmYVZsTHBZKzNLRnFpeFpkMWhFUmMveGhFU0VoeC8z?=
 =?utf-8?B?c3grQXBLVitLcVUrNFdKOVFhV3NKMCtnSnRrZ0VXVTZTdWVsOUxFRHJYa3J2?=
 =?utf-8?B?b3dlWHF3M1ZGMWsvUFl2bkVxVCtwMjJvQitpc1liYzdaRG1nU00zKysxWEhU?=
 =?utf-8?B?ekVOaWFRSjRvVXZZVXZSTEhmNTVWWWEwYVdxQnppRHhxWHdOY3M4Sy9lQW5t?=
 =?utf-8?B?L2VtOWV3QXlPdnZTcXVjY2VZUG80aTVGZWFLVXpTZXhXZkxxV1o2c3hWMTVU?=
 =?utf-8?B?b1lFemFmYXczODFHR0VZNDdMMm54cVBBMWdzdkFVb0JJOGFFQVpudVdaeStL?=
 =?utf-8?B?V3RvQ3ZZK1BubHZzaWlHYktJemxRYkpUZDBnTjlXRm4yWDZxWmhnb1Zna2N5?=
 =?utf-8?B?V2VaWkRaalNtTE5zYkN3Q0wrL0JvUXVrM25ZWVIxMldnNUxxK0ZlQ3VtajNV?=
 =?utf-8?B?UXQ0YmFtbURVZnQ5UGF2K011d0RScndZa0ZSWm9ESWx1eEcxbDBEcHVhc0FD?=
 =?utf-8?B?YXJDbWRWcUdNV3Y0d0lkUmt4dUZIdnNkWmNZQ29BWHZDRThOTEdBVzZlak5F?=
 =?utf-8?B?NHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d61adc4-56d7-49d6-68fd-08dbe207eded
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 16:13:08.9324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPWZmJPhT+Dubzb43REXMi6BF23DfgijG+MhH4uxaPxvQ9Jo66sbQw3BemEvZoekX3kL9uucuq6ybzdxzRuLWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7970
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

Analogously to prueth_remove, just also taking care for NULL'ing the
iep pointers.

Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
Fixes: 443a2367ba3c ("net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
---

Changes in v4:
 - no functional ones
 - added one original author in CC with new address (no address of
   Grygorii available)

Changes in v3:
 - consolidate cleanup logic further [Wojciech]
 - make sure to NULL iep pointers

Changes in v2:
 - add proper tags

This was lost from the TI SDK version while ripping out SR1.0 support - 
which we are currently restoring for upstream.

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 6c4b64227ac8..3abbeba26f1b 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -2105,10 +2105,7 @@ static int prueth_probe(struct platform_device *pdev)
 	prueth->iep1 = icss_iep_get_idx(np, 1);
 	if (IS_ERR(prueth->iep1)) {
 		ret = dev_err_probe(dev, PTR_ERR(prueth->iep1), "iep1 get failed\n");
-		icss_iep_put(prueth->iep0);
-		prueth->iep0 = NULL;
-		prueth->iep1 = NULL;
-		goto free_pool;
+		goto put_iep0;
 	}
 
 	if (prueth->pdata.quirk_10m_link_issue) {
@@ -2205,6 +2202,12 @@ static int prueth_probe(struct platform_device *pdev)
 exit_iep:
 	if (prueth->pdata.quirk_10m_link_issue)
 		icss_iep_exit_fw(prueth->iep1);
+	icss_iep_put(prueth->iep1);
+
+put_iep0:
+	icss_iep_put(prueth->iep0);
+	prueth->iep0 = NULL;
+	prueth->iep1 = NULL;
 
 free_pool:
 	gen_pool_free(prueth->sram_pool,
-- 
2.35.3
