Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307BF75FF1E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjGXSdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjGXScu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:32:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BA41712
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:32:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFO8TM011878;
        Mon, 24 Jul 2023 18:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=9J/Td+3AHwaHr2JXIHHZLSKTigrpnJ4n7Wkr5132wIs=;
 b=3XPi5R94cmrREWsB4+of38p99DGVlIBQ9HShdSFiQSVnfXqugyRgK7YK6SFr1+iD7O4b
 QLIrBRMsBO/dWLVa+ADo8RDdiTa9vkEfx2flmhrftUnVIu9P0sHr4AkqG/ZX2TrYGu6X
 1u71hyrcYBukLvGQUymp4nIuRggH5qUvaHhvrTCD40EieQd7WLUutXKBVWnijgNPbYx1
 7Zle6B8o7HY3NFwCsaxeQAQIUz9YvJLNfeS/FbpIa1a4tS09R3MFiSU437tvzpFgZLVQ
 f64dZnvtBbgmLM/k2k4kuOG8MY7Aj/ZlSe/3WJdgzQBUQgdkk2dg5OmU1mnhCkt0TYei KQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nukcsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OIDuuf029061;
        Mon, 24 Jul 2023 18:32:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05ja2a2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L87b1/eKSRX1WrnOY5vId3qaOj7AnnYCL5mYEAp4CDUeKsUFGCzPVR6h83ExRswqA1oE8hsKZfwKvF1/gvbOhiLKvbU6GYAl/NvNtvDnx9T7yiuyQSjLekGvRMBznNQBTXZIn6lbvwSPtjIGDMsaZY5cYmtI1FnScF15g5GtITa5di3/UscOfvExIm2ECnwzMHHKfp5tVN9xixdf/sGoKDWcteIzNLz8zfS/2tBcavAYRNRRXau/xWJSIo4f6nSL7OSjkM9NWcF1yzBytngAZuhykLuD7MvamgdFcLpw1TDOI1LvhKC7NPIicRjamP0ty+8dpanZYmsqD9SEIsTIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9J/Td+3AHwaHr2JXIHHZLSKTigrpnJ4n7Wkr5132wIs=;
 b=ii/hsRlA0QpTa9/dG8UF4QgFVReXxD3oM2R4a2ZgCM9D6O82zdIkEcUAywwmCcTe4SbRXkXyFFEiotv2LoN8Xa8gFchxStB63g5WN5AfxYDqDK/nSYggmmegw0lZ2dBBx5tUr0pJigMg6bpwYWvrIPm16+MkImyD1nHtYEcmh6mXDFbpVg/ciB2uFF1XbG4Lga4jBuNJa2L4H+kq8h45By1R6zsRT/1p7Rt+eech8YcU6OlRNy3dfen0qXLBpcJYpVuVPti8ChovdxIz649tPmr5lLFzCREn1ouOSdWG72DFkv2kOsSEFyqbvt45ilAInmebXjnVP3l6bRp363A0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J/Td+3AHwaHr2JXIHHZLSKTigrpnJ4n7Wkr5132wIs=;
 b=hqaF3YuI2kccDftnRK9FhCpEyd8NA9sRxpZojsbxWsHlXH/R161i8fQpzgW1wL/y3ZNHImiNR5Z15cPm3uQuGBH89wwCxS/ZNfC+jW4FvTIvWfWlHjGEhIykb8ODoyKN088Kzh9OMmuLrGmZibcVdQSQYM+vq3u1jLlSm2+bCZE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6654.namprd10.prod.outlook.com (2603:10b6:303:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Mon, 24 Jul
 2023 18:32:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:32:32 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 06/15] mm: Remove re-walk from mmap_region()
Date:   Mon, 24 Jul 2023 14:31:48 -0400
Message-Id: <20230724183157.3939892-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: fce2ecc1-76bf-4f54-e061-08db8c745844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZrzR6iMPNFOvjlACw4Hu5KFAQYqMo2H8dXaIhG5OnL5d+vU82QkHHz2BKnuvl2WXmfy6mfuMMT6TV0eCAzRAIPqrmNP2HaJvPlXBjT7O8WEVJXblkHq+mXII3P9VT4rlP5e+T0eJDO24eeGjfvDZ5lG1Y56P9oAKk/tVeK/OSn2h8Cbn092UTguTax/7iYLvrLKDNrmQ5louyTvId1x/gLkJJuD0K+2OuLUkO+Yf8/n20j1a+eAnA3z2tkCaCU2y3piesIQW5eViPdszNwWWe1Y7KWW2hA7zbyoF/lXlCLHNZBi6L6OcpLqyvZpMbojUXTpXa5hHflztCz146Lj1eSMXspipwFFTbkLHdFR2GjzlSK9cCmD5xGP4SfwPMF6u2zVsqeoWBhC14ycwY/T1eABAtCZI7UvDuuIo6fKY42WvE6QaJ2/wp1qmxJVM1te2Mhyx9I6p76/HCaI4q8qvJA5DFbR7nK3NldAEYFAGud/VjpkMGbzlfICA9XLpc6nRPiBb8Jqa6cs9KRLNdtmrOs6tD+q5ebULMN6BrDqWs6Bu/Mm9m5SeTH5pgcocUDb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(2906002)(66946007)(66476007)(66556008)(6916009)(6666004)(478600001)(6486002)(6512007)(86362001)(54906003)(83380400001)(36756003)(186003)(2616005)(1076003)(107886003)(6506007)(38100700002)(26005)(4326008)(41300700001)(8936002)(8676002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?05ZhsJ///WjSNO9nG96OLCXen0j+Fd8teA//TiewmtQ+gWpu1BGVxtui4nsM?=
 =?us-ascii?Q?NJkUSrQokFPhlpVKCEdDFGF2ViflVB/C6OD5HU9EhYQEXHUf5+uqIudjIjLx?=
 =?us-ascii?Q?RghMJ/DduxlKH6RltbgyBjowh0oo2EXHs7QxwF11eXI30/gPIyRTnfXcrY+L?=
 =?us-ascii?Q?ORqvVpoakX1xNX0TXoWwpJZ466vyAWGwE2/1nKnlOcdZXixXy3Gx6oi95JLp?=
 =?us-ascii?Q?nGuc3gtg3dFdvCbOMd3+CeOgdsdSDuN6q6TYgu4i2FcXrY4A6Ye0bCa8F9Lk?=
 =?us-ascii?Q?sjWWSMkN96WTkMyeY5yKOtLkv3Suuu0HMw61h4lAE9qGwPVA+CE73v6j6J/A?=
 =?us-ascii?Q?g+Mnf4vwFEj+ASpjSx+pUTrDTjZh4nSpIw6nfM7szdvGGXeeGpNE8l4MyQMp?=
 =?us-ascii?Q?bhg+8lQQ9vOUHeS6R4/eTtgawXS9d+akHysjMtjxrL5i7QdFpis3gCzSp3sg?=
 =?us-ascii?Q?XN6RdCgoLbjeAD7n1/uc8MtE/UM/vPVljPYEsa1YO0HfzbLRWJVAXpahRHfx?=
 =?us-ascii?Q?CmIeqIBe20+z6or9jq6eJ8fQ0C4P4e4Te3axOGFXnMzViRf5LBqLAl1RzPKs?=
 =?us-ascii?Q?Nsm9wrYMIyw0GdC0fu5xpA4BAIv2Y54ASko1vxde2fgO7etJCS3AOT9MnJ++?=
 =?us-ascii?Q?FsWDgSRCPuCxjeZS9kPAmno0xv5P3hZdniWb8VagYixxOe8Q9umpUW5OVtPx?=
 =?us-ascii?Q?7X87f8EdXjAuQvp1LnYwfn9JGXLahntC/EK2h+moAcz6h6qFJo4hTknmIGAB?=
 =?us-ascii?Q?6Pd+Nvqj6ip/q0EEWvNRr+3oq7myUoIzzU0pDRTHdwDUtLD9SqeKPDZ7kRaY?=
 =?us-ascii?Q?YBB+eVlmPEW2/wu9birBmQEqRf5UNN8Z5KRlLhHvu329F3XUaVgQKHqG9wyA?=
 =?us-ascii?Q?VzD/e4nMsDKvs88fg3E9Hh4HBXwYxo07RUdd4Qj28gI6lb8t4gkplzvFW917?=
 =?us-ascii?Q?ByxBU5Ys0ItVBgd26jKX4lhdimSOChOeCGzrZzZu7HTmuR1xnNEl+aZgRy8/?=
 =?us-ascii?Q?DujXxyPyq3uXQyONCvhvSignkw92olIbjeIRhD0teLL2NJ/PsdUP3QtHKIpo?=
 =?us-ascii?Q?9imOVXRgrHzTHmZsmay0A1xJafnptVTVOf0DacH9GNdHVbJjHZBKvdzKlUXo?=
 =?us-ascii?Q?vpSqCXhzVpSvKS7B35kefSJk349Q0IDybvogtzQDW8gnH50v88wKgVlRfm90?=
 =?us-ascii?Q?3MnOcKaBOeD2wKYdK3ZB1ZDLAmTYDPZSZJSz8fcR2ZA5ADcKsEGAf+190RVl?=
 =?us-ascii?Q?bkZ5SP0WtYy7mD3ZXHSCW3xgYIZmx4en3fhKZBOr7FoaJn4mhtOw5WtXQ+/Y?=
 =?us-ascii?Q?+KRzYKNxan7h6O/Ud7GT78WOEwN1zUs0lruTKq1Fdsv5+FmOjC5PrOrs9M80?=
 =?us-ascii?Q?6wg38UM0w3ah4VM/Xk/4VkN1kcErLuMojTldSil+d597BQ4kMt7tv7yXhpL5?=
 =?us-ascii?Q?DBXV4tlWA5M+iuhEzg7h9ppgbgjATTDbqb9oq6B/mBDYAVS3qog3plQonU5W?=
 =?us-ascii?Q?QovF+Yd3ixaimw4gkio6jmj+P0EGtoEX4wT50cOXarF/LYA2iTiubWCXiaIT?=
 =?us-ascii?Q?4r7zR8zAQmAG7i5DQpe0c/H9K2d7VEFNbjYTg3xxpDltZOISm1XOUNGPoI99?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 21zcPxOjX79NZmObLq64DtEeQ8HjFLO4MnHu+RDR6JEPlOckpQvU/KdtmRFrQbGviHUfyBQoO3n4HYQXNqM4dJNCzCJKawQqEDjnGjYnR50PfKpJvMMVqX0LU1M9LsVXO7SY4oUHEQxwIKDh/dsqTBRqEBWmOEihhXADrP96u+XLY8eDaHC/TmNn4KgbZfGHfbb/mo2YHGSeRNb820am3gpp3MmsgDIFV0gYbuv/5hSIS6+n9NGMp6eRGUNWf9TmyPyrns1v1qKADHfSbKai1/7LcgYQf78zvSCQvopzvFMkVLc5/ZqUdMarmuyKMcWOu9i+3yLt05p+PuRxTelnXre4LiZiFmMQsHBPFSFbZ8n2cgt3I2/PDAd5h6JlyZhcODf7hdwv7rBDF18ftN6bO733K+Mu8jwpnCXRahg4gvr5bb8aytgTrlGfUnHilMhnsUuPiThcyRKA/6qyH8zGwnz2wZDWMujOPIPZRM8ChfK7zGWk+V7FcL0mSg/MHYIfZKHClpYfZ8MpEDutCHVxt5ab+uSix6pArS1txsVzyocYFXdbXxTBFYPwpVqFOdNw7jgTNZ6WqW3WM2zQVHDMSDmj80IN+ms3W0E24eRjbO87hkjoQ2o3B0YgJ4PLfgFs6m03zFA0Rdc2FkuzbMfpZeMRfxpbuIhvI2Mg5WsEVIS9pbPCIy7TACRFwSci8KCdDTd5euErUQRgPLA5Eio8N7lja4ounN/g47uiyfhNX49spExEpdAYk6obxUvzpGbEwjTYlgTMDgO0RMWEIGR9r9PBt3OH1PJaxHxccpn+w8pK4/mMeCc0g1Yc/QG056N5OxMyKvpgIOp5GEGQSq5Z3XbJNM1IPPv4qjzFm0uivL52XO84EHVLB1WqOUwrH9ipD1xya4YGL1s3mUmjwnC3qi1N2ZPafv5RBVpr+TjVBws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce2ecc1-76bf-4f54-e061-08db8c745844
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:32:32.9278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZaY7Djj72H81GNyDt5/A+aOVK6EEiTordFTNYfWBfmOzN1Yi+Hu0RnW7fRKqn93Xy1fL832pXS+fXxYInNMig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=923 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240164
X-Proofpoint-ORIG-GUID: Gn6WRtjlRztsA1Rvwo5w5zpgi06NZJYB
X-Proofpoint-GUID: Gn6WRtjlRztsA1Rvwo5w5zpgi06NZJYB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using vma_iter_set() will reset the tree and cause a re-walk.  Use
vmi_iter_config() to set the write to a sub-set of the range.  Change
the file case to also use vmi_iter_config() so that the end is correctly
set.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h |  8 ++++++++
 mm/mmap.c     | 15 ++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 7d11ebe5d11c..c5ba08f55deb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1041,6 +1041,14 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 	return !(vma->vm_flags & VM_SOFTDIRTY);
 }
 
+static inline void vma_iter_config(struct vma_iterator *vmi,
+		unsigned long index, unsigned long last)
+{
+	MAS_BUG_ON(&vmi->mas, vmi->mas.node != MAS_START &&
+		   (vmi->mas.index > index || vmi->mas.last < index));
+	__mas_set_range(&vmi->mas, index, last - 1);
+}
+
 /*
  * VMA Iterator functions shared between nommu and mmap
  */
diff --git a/mm/mmap.c b/mm/mmap.c
index d4056d1de7fa..f518e4c70a7b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2675,8 +2675,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	next = vma_next(&vmi);
 	prev = vma_prev(&vmi);
-	if (vm_flags & VM_SPECIAL)
+	if (vm_flags & VM_SPECIAL) {
+		if (prev)
+			vma_iter_next_range(&vmi);
 		goto cannot_expand;
+	}
 
 	/* Attempt to expand an old mapping */
 	/* Check next */
@@ -2697,6 +2700,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		merge_start = prev->vm_start;
 		vma = prev;
 		vm_pgoff = prev->vm_pgoff;
+	} else if (prev) {
+		vma_iter_next_range(&vmi);
 	}
 
 
@@ -2707,9 +2712,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		goto expanded;
 	}
 
+	if (vma == prev)
+		vma_iter_set(&vmi, addr);
 cannot_expand:
-	if (prev)
-		vma_iter_next_range(&vmi);
 
 	/*
 	 * Determine the object being mapped and call the appropriate
@@ -2722,7 +2727,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		goto unacct_error;
 	}
 
-	vma_iter_set(&vmi, addr);
+	vma_iter_config(&vmi, addr, end);
 	vma->vm_start = addr;
 	vma->vm_end = end;
 	vm_flags_init(vma, vm_flags);
@@ -2749,7 +2754,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (WARN_ON((addr != vma->vm_start)))
 			goto close_and_free_vma;
 
-		vma_iter_set(&vmi, addr);
+		vma_iter_config(&vmi, addr, end);
 		/*
 		 * If vm_flags changed after call_mmap(), we should try merge
 		 * vma again as we may succeed this time.
-- 
2.39.2

