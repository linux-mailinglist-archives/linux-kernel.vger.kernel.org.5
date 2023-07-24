Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E889075FF21
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjGXSd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGXSdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:33:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C16E19AB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:32:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFO8FL011886;
        Mon, 24 Jul 2023 18:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=GE2s3lmFfqPSKflVW5Y+GVJM/8mYdXBolYbovOkyrDI=;
 b=Kkp8ux8X1lPpAAfMN8J7uk8ZFaDtpN8GtJHgP1A1Y5qFm69T9BLUUybmb766dQJnGAUF
 Mn4BPuZbZTGqoqwElHOlkav3kG1721OI59b/2L+xgPEwApgicBWuqyLwHXFqaGJTSIWc
 AddOtsvhC1l/21dbsD9TEv5G0usArnfS+jOmvnMPdz+YV4YWG8UCC1mQTXX0ft/lFClv
 AVSWDnA4WtppJXwLZAcyt4utXahIbJP477+3QAn7BwMMqW06OcGiqd0xk/AjPCJsUtX9
 FAcE78KOHSHR1CH3cKI1Iz9fkCg+uaCptnKiiF2YkOavuauqEtMsJiBHc8DMm1qTJC9v yQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nukcst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OH08Gv027537;
        Mon, 24 Jul 2023 18:32:41 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05ja25gg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtuWj+bTt2leVmWzTkqey7kII6LYCLpKf8GFyUlkK5ce4kFbhuJV1ufajkd4UI8rplMg6EaxQ3fMjcUQBBopDTZr32jpOUSakieTTQTasKO5RCPxKeOrTdVQFCseCnLugbZRR7yLUsk4JLO+ZCx9Brnh1Gh083rYFBFVlQN7h1gq0lgAA/C5JfpRS0RqxyenXEUqlaSUzbui5qq1FPFvvCxIiTsFX9Gi1jQVWF7HHW1jzQb0pwS8VRMANiNI/1kjCSJG1NKkrwP1RMAvSrUc0j/OCkCfHYUyXFCY8LzXh744DT1vAhHJ8KiOzD+xiuKOPX7PnCScdhyx/g9kunkoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GE2s3lmFfqPSKflVW5Y+GVJM/8mYdXBolYbovOkyrDI=;
 b=SNueWafy3OEbK+Wf0+x152Hmv6YNDFq/DWqilZYso+IfF9d1t77hOpgZj9Obh4NhPzlmLVfoe3LNA87qsG4IX4c6DQrw19Fx2LS5WTQZHbaB56XgnuB6635o0C88tRaTCmkJF16OvIgD0WkjC24vmG/XB0bDTJqyb1N80+osIImwifT4+2SNaYgSTnAWLJKePVo+8hFTEifNRS7ZTaWkuO7y3+kpop/b9TkmvKygpgVWJg/VHNn2wijip8JVJVsrNzScNhBOApOZBYoJXcNGv4DNxs3XMHHdAUfZJ25qYOqE+djOKagbPx28TccXfZPVWKYoqgRPebixzp0k/pG3zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GE2s3lmFfqPSKflVW5Y+GVJM/8mYdXBolYbovOkyrDI=;
 b=AwM3B/2d63bHQ71tg6fo8tgp7nLMbkOjYDQrompT3cllKTsT/23WxpEcJjxntYEA5WeeO3DocNUZ7iLmicYlyKNvD8GJgDk7yBFze0hglKzKeVl25EFPIuZ7GVm0BP9jqBEHZ16TJEtflTxkpFJR/WFGJBskQKIJOW1DW30RRuA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6609.namprd10.prod.outlook.com (2603:10b6:930:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 18:32:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:32:39 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 09/15] mm: Use vma_iter_clear_gfp() in nommu
Date:   Mon, 24 Jul 2023 14:31:51 -0400
Message-Id: <20230724183157.3939892-10-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0187.namprd13.prod.outlook.com
 (2603:10b6:208:2be::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af05131-b7c4-4b32-b1eb-08db8c745c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBD6ccZcliDW/+Hzj19utkL49FJ28/WijNP8fZELeO7im5FLoCTF4u/xl7s5I+DKhFznhDQWhGuLnlv98GZQR86l+AErZJuBuILIdIITUZjxlw6qMbwrotVZmrcOcJgbHQj/41CF1NqZ13sA4Ch5MrLkxBQguD/n2By8MofU1Z9PkrMMTKINXVk6n3q9f82kenqXcHb5RRiKlyUDNvPb/JUIUYWMNGuNUfuRdUtAEMvnVZ6YIefLzXZyhvdqr6j0QF9H+iOfW2X+ZJsCNdrkJhR+LBycuKuhYfIfEuW7se+geB9pnf5Jq86lWvMdEotqZbuANIWsS6HXfTIPqoSC1XveUDZvjct3Irm9gBx378VigZD7aRgGgYm1jE6Fc4zj3Hq1Zkeukrh4plcjdiIxL2C+1NSfkWzSEnFXlPcq8ij7Us0nNu1ABALoylOVLRL0HwPoeyKBuABj7ZhslMRYlpkqj7iNGhRbicd/O1qzFljYuCs3timPmv/6BE5rCr5JMyj9BVoM/jivRUNjgZST10yR/qmuYh9sI0aFPuTq8rpTfIbpF4GOcV1wmS+OLS3P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(38100700002)(107886003)(2616005)(36756003)(83380400001)(8936002)(8676002)(5660300002)(478600001)(54906003)(66556008)(316002)(6916009)(4326008)(66946007)(41300700001)(1076003)(26005)(186003)(6506007)(6486002)(66476007)(6512007)(6666004)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3kiDznrgR1eArGIuoofkMZiVoiAXpGIBgsAPRP0U2DmUY+WRzepPQkjkqhhu?=
 =?us-ascii?Q?cAXo+Ho4fv3WYGTD63R+KOPSreLnE/CpUSK1v+88NMXo7rEfafpLfROw95wW?=
 =?us-ascii?Q?3RUduBTQvFRHyEh2nZM/VDw9qCOSWdOBFIBHTvjQ3XYMfnBHpJxOHFFwcked?=
 =?us-ascii?Q?KWULW4n4p4VyX42rXGQDWPs0C62YRZzfIzONXqGx2ZrQ502w6ju/1ifZTs1C?=
 =?us-ascii?Q?X5Crr9qDXMoK8a/lrfOLyIJ4xJU5l8LzEQIhypuUtlwhnAMoh2KoZPPXEP0w?=
 =?us-ascii?Q?QtqWxKOPcNZFZc6VDCftQ81iywuRS7rFQymhoyYwO4LCYXOY93J6ul/o/Kx4?=
 =?us-ascii?Q?+b99cgIeehx3Mgqh9xChn7FLWrQURZOb1tjN0CP9n8dC2+y8fJIkL2bzl/wZ?=
 =?us-ascii?Q?xU8tH1F1TtK8dzuhj3EFUk/IpBNjo/SqNuNdATB+VI9uYDexSc/pWnZCEnkH?=
 =?us-ascii?Q?0BIn0YMcex5QuDNDYaCgIsiO6gPCzW/WdKsZt5jnIYyslL2Zj+wAzjGnCuM6?=
 =?us-ascii?Q?z0bmsDH7ZiAE6UaSJhxD3yxkVRPvmJ76sr1vjY+bcMOZ5SByPzZd8atDAQDQ?=
 =?us-ascii?Q?l0uMO9mt1ocZgy+CIFuzz+loR7PDImPd9jX/clQ2sBvzWb7LrHy8eC+7R3Mt?=
 =?us-ascii?Q?f+K47xlqQp0LY2oz500Z3mQCy+H4M1Wfsn6UPg456RfmpTIZMC8keie2+U98?=
 =?us-ascii?Q?r8ImRZpVGGJJeL3FJ/d9J8/x1TL+DhtN4jK3+JpJnyZv6oDYVKUP/IESZlfa?=
 =?us-ascii?Q?J2BRQ4xr5YDTcomT10DszvGNXhs4pLB/56UhJc7xDV0abn7C7MzNEsiZDPQ6?=
 =?us-ascii?Q?P+PhKgGrbN89JP1Lj7xo0yoe9aFYDOhYn+3kfYw1vN+5uZ7MAhCoseKSJjIQ?=
 =?us-ascii?Q?zqELP4A31jlqZzQ/NOnQb5qKFjkD9FeZPNzOiwT6ltccxILFykwkQjrlTgoG?=
 =?us-ascii?Q?NyCyasRqySaKZUrTEFV1DPLS5rwx9O5awhI64WhCAgKFOj9DuIG6notltws3?=
 =?us-ascii?Q?TUkvWp+wEni+BZ4ffUnR4HOeccwXxsy3B7DP3kWpQRf5ZGtY2KY5CFKJ9W6C?=
 =?us-ascii?Q?xsiMe8/113w3Sic2kRtpspqc19CVuB+csAmdJOx/RDRMbd+bfGTegbFGjhvK?=
 =?us-ascii?Q?rQzgBQbPDEn40XuiJS5woQMH3o0PTkkzx/gSbtsUhxFLQHlTmlrhKtbUmXp7?=
 =?us-ascii?Q?VqpbQpWGVoq2B/By4e9zwOrNX1fT+k2sNbvN53286LJfZL+W5lp1iNGxtG6M?=
 =?us-ascii?Q?WSwwAKdgXMoEpox8Q9REbTPmUc7IuECwKZb+Yfld5Ah4IeiS1FlLevyAmeo/?=
 =?us-ascii?Q?fIbrchxT3mernaxFAPORvUx02KWVxpO7gWlpDK6VyeL6EHUkRtoDWlIcdMk8?=
 =?us-ascii?Q?LUZaNR7eitqnJT4hYeb8KupCsYJfgA+BSeuWiULv5xxyfTpXQanW/qqF65iU?=
 =?us-ascii?Q?bw5BChfYCHcBjrJ3mbUDdKud8yengdwe6iWOBOTHhLiEKVd1d/duuVXTkHxN?=
 =?us-ascii?Q?/IHACuioqTdCkaPDTkZ1Uzhu6ns05YE9it5jmMJFJzPjIXQN/g4OTEUwlIx7?=
 =?us-ascii?Q?cZovQY3d2sm/W3jF21uox4drJ/XAoif5fDjRkipbRzcJHCVNdRqURMGeWUVA?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bbZhfsaReDBh5YZgmeZ9vNA+IUbetRoxXJsyTd26GImrL4VKtGloXQh9H7iV38blq0xOaWKBfk3X+q9OhnKVy4Vfp7R8SmRhjyCSSXqkr9z1hxj4pXy8rgD5wjZ/Eo1ibnoa6vjp/Dd19ZrBrCgQjiY1PkyTHnyhXQQVojw44ExB5fr9SD1xAIlyMnQNuDRBMG/5RAelAgDp592NjfmdVOmiNRhuyEjinZXEyeUyLM2lukt/dhEhidAAw12S3IXBHxzi1Ke2A9ZYdUIp+Yhd/MqPjqjvQoC3vc5mLG73PvAGihNeC+sDiLbXowcK2zPs1SNXRq7Gh0rRogxBv0Owae3+VKkXldiTX3yCosISO/e4WW7BdYK5QYjzXxVF9ZZ5NudKKUjNOSckY4ZvBtt+p0cO5iN5zldaSjVvFK3t+tkesl7NBB/3bl25/4gDWHLxF8snOzcgjhO3qOad5CfW2rCU8rd5bCjnlnWD/mvGNPcnRj56YuXRa26qDVw1ZI/aBPjCcjgV/95Shfx2kuFrCjzSJYVPtSWFWNShoe5iXHlCdov0k+FJdBPT67VDvk7MYacdt72idtFE0O7dXnTOFxTECFgNDnndftfhY5+3OsnEFa1miduQ7mmt5JBQIEGwrlg9KODjC7ZO5TamT9D3PBJoWn/dNFTRSP1F5eLFd0VQR+TEJ6t0IkEZMa7fzouAx8hYd8TUJ0JZriuD9eAFKrtLlagXx+Xczz4Zr2HyOJZYsdqlOyyXWFy9WbvnMbyFtXPht1pHdCk806vGMFem7BUgIdOd8oP77D96H6/KmJzRROy3K8I8BxSBhC2YP3H0bMbOWxQtlmeDTF5YBBPKlU9ukSWX+6AprvxygO3wBBinjQLGa/rfHUpRpt7n3Sn9Rl9f+Jk+AKZS2G2q7tgrCQPKHUcnRC8iTPzu5j6FDfk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af05131-b7c4-4b32-b1eb-08db8c745c56
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:32:39.7325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqCptlumz+RJv+loFufi+zHcMSPRLGZ/3Ww59q79Wk3MUgL3WEG13DYarhmXqVAanjYHZm3lZ30CwLcHXNvy+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=977 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240164
X-Proofpoint-ORIG-GUID: IgcTSrN3O8tnsnrEJ47nfyIqF40EnByr
X-Proofpoint-GUID: IgcTSrN3O8tnsnrEJ47nfyIqF40EnByr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the definition of vma_iter_clear_gfp() from mmap.c to internal.h so
it can be used in the nommu code.  This will reduce node preallocations
in nommu.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/internal.h | 12 ++++++++++++
 mm/mmap.c     | 12 ------------
 mm/nommu.c    | 12 ++++--------
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 65f646c2ccf3..2f35c0ef7b7f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1064,6 +1064,18 @@ static inline void vma_iter_clear(struct vma_iterator *vmi,
 	mas_store_prealloc(&vmi->mas, NULL);
 }
 
+static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
+			unsigned long start, unsigned long end, gfp_t gfp)
+{
+	vmi->mas.index = start;
+	vmi->mas.last = end - 1;
+	mas_store_gfp(&vmi->mas, NULL, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
 static inline struct vm_area_struct *vma_iter_load(struct vma_iterator *vmi)
 {
 	return mas_walk(&vmi->mas);
diff --git a/mm/mmap.c b/mm/mmap.c
index 625d7411d5a0..d09f11a9ad85 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -154,18 +154,6 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
 	return mas_prev(&vmi->mas, min);
 }
 
-static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
-			unsigned long start, unsigned long end, gfp_t gfp)
-{
-	vmi->mas.index = start;
-	vmi->mas.last = end - 1;
-	mas_store_gfp(&vmi->mas, NULL, gfp);
-	if (unlikely(mas_is_err(&vmi->mas)))
-		return -ENOMEM;
-
-	return 0;
-}
-
 /*
  * check_brk_limits() - Use platform specific check of range & verify mlock
  * limits.
diff --git a/mm/nommu.c b/mm/nommu.c
index 9826f6101a05..418cc0669c1f 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1396,17 +1396,13 @@ static int vmi_shrink_vma(struct vma_iterator *vmi,
 
 	/* adjust the VMA's pointers, which may reposition it in the MM's tree
 	 * and list */
-	if (vma_iter_prealloc(vmi)) {
-		pr_warn("Allocation of vma tree for process %d failed\n",
-		       current->pid);
-		return -ENOMEM;
-	}
-
 	if (from > vma->vm_start) {
-		vma_iter_clear(vmi, from, vma->vm_end);
+		if (vma_iter_clear_gfp(vmi, from, vma->vm_end, GFP_KERNEL))
+			return -ENOMEM;
 		vma->vm_end = from;
 	} else {
-		vma_iter_clear(vmi, vma->vm_start, to);
+		if (vma_iter_clear_gfp(vmi, vma->vm_start, to, GFP_KERNEL))
+			return -ENOMEM;
 		vma->vm_start = to;
 	}
 
-- 
2.39.2

