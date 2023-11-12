Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF707E9175
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 16:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjKLPiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 10:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjKLPiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 10:38:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19F52683
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 07:38:09 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACE9057028730;
        Sun, 12 Nov 2023 15:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=slp6A4Zyeyrciy+EY3P8oxw9JDotmvrDGKPoPsBM0GY=;
 b=o6NOeDrGMJ01B59aqsHxcnkDaxoT5Nb2enp0xz9Gn0c6jJF4wXf8oDMJHEv8/KHIk5Wg
 hjtMuCAExnccG0D1Y8cJRxbzsro7yrgL9skYNafHCHv/Tq5Fhu3hHX08a/0v4qmHTRDw
 TuHnEcJXBxOgb76fMoePfo5Gdu6MgtyEaKMGdl2JjB8M/20EYT+IsyGvM/4HUzxEA8Jd
 IykVKcCiK2quXgcZIMfiF8R0PEOdcfLpzZcZ0SCd+stjeFkhjt9V5OiBE6HWnm7AAvMS
 rb00hqFIgnejGXoS5vLBauyhesfRQaGsVLjaCV5+gdGr/SIlIPQngUp132Uu7kEbSC0M Rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2n9sj12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Nov 2023 15:37:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ACCPdmk022700;
        Sun, 12 Nov 2023 15:37:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxpvtvn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Nov 2023 15:37:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7VCwazHgHpnjdeP7YX+y4iMki2iq2fXSvZrXATjG/U1e7nd+fwlRo8Ig8TX4HSnPOF+MIom70pjhs4E0RG9n22vGJa+t9WUir+hYp8E468jnZL3AnaUAs1rd6iyB74QV9WQ1eMkiWuSm8x3GZMG/bw/AmQdNlxgh0ZcMpQpf/NdqOyG0k6guk1rLfp2WnhRLRsmeMNJ5SYH2pm9BnaNc8eVR6OGNmvOC+Xapbr668HZYE9WI8VN5NNIKOKTulw06K2X3qBoBepujjg6/LUYSvjTCXil0gS1XSYDgAUu1GBASAOuthqX1dqQyBROC0yYlRO8omTb/5Sj6nJFRFk+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slp6A4Zyeyrciy+EY3P8oxw9JDotmvrDGKPoPsBM0GY=;
 b=NbYh8aNvMfTT9ccWr/2CsrDNjb86Ddi5S3W5RitXamsqDqLTaUvTZRWHlQq8HeXJeigmZaNRTLUTWRazMFHi057jvKXd7hdxv7V07EQmRwxH0J9LOD/xXxnoxSvo8tE0jDEWQcCYtyZ/l3NpeYwfLJFVzuMdtUohOKOsjMhSvtFLoCQvuSGTQq6RneGgzNTj2UVyixwokvQXxrWZFGpLRIKqUWkb1f6IELU2y/G9Sh7UMeaGF4skjzWBr1G1rj90z95HMotB2nTF7+zJv15EaxgXaFRE5KPWcAzKGm5kaJdipLaw67vcG+2BDXmqbhIyneCHqSdd91mYohVhdFed6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slp6A4Zyeyrciy+EY3P8oxw9JDotmvrDGKPoPsBM0GY=;
 b=AU6FhUyuk0LKNtBqwHY6+uas7SnAkd9CZJbyqi9Z8l5VS3CnwM4ED9Fx61eLAj2xXNik7+8Ku3A3wMosIbn8Cd8si/gn1gZfLKNHYF0Yg4NAsFJ1ZNbkw+Zs1fqhwuMoRH35Lb65FQ/fWK/46pnq/3wwrcy99q+UeVCYis1XzGY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB4978.namprd10.prod.outlook.com (2603:10b6:208:30e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Sun, 12 Nov
 2023 15:37:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc%6]) with mapi id 15.20.6977.028; Sun, 12 Nov 2023
 15:37:20 +0000
Date:   Sun, 12 Nov 2023 10:37:19 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Levi Yun <ppbuk5246@gmail.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH] mpale_tree: remove redundant check on mas_wr_append.
Message-ID: <20231112153719.63ooidpcb4kgmtco@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Levi Yun <ppbuk5246@gmail.com>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
References: <20231111105455.37917-1-ppbuk5246@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111105455.37917-1-ppbuk5246@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BL1PR13CA0351.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b95fbd-b893-4be6-d2f9-08dbe3954207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDdYbhi1srBYnhPmo8NHoxmU+97UluF+E4wWKXsCv7zgwpiqZaoCAqF1daLJInOtLfQLN3zfOcKIfX8EdIKCuW2g5lL1Zj0kiM5LyH0PxSfKx4K2x0QrocNdgp6z+XHrLasSPLpZ3QeIygxvfmMPqI46o70L9Q5AKAuVHvpMI8HlWWx88WUQAeIVWu6iYSnSY38XPCXZUGd/e0P9x2KdVVnQVcdV2NTmgbwXNJTqEchrfBcrd6cRDHnkiAvFMiSGAL+uX5BOiLZGkQgatIUcNX+1NWgqj+AYxURiN4wTathKkTaPurYdRjv3s4tLnBF1A623jhIjbJUqJlQIE5vghBcfpH+xIh69NiX69FSdb/XPPKcAad4lTdZgNEVX8gaKcXa7l7JnS2PYu6nL8VjYuVQKiijGy1kYSdLSHaF9LPiT2LTLk/zsVyFbplzbk6gO/UPgF1CvWHRkOC28AzuiuhBuKzXrWNgbuUTBuYIHtXBRKAvVjjfKRADWn7syzMQPBX6B4/4TxFpqkM9Od/BwEJHD57AyePTE0cg074zhQBAs3KOZWDFNOy7GhiQM6Bkmvwp0+Z7cjbGcfwK338faEGus4nCvGfXWmgaMCJYsHZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(4326008)(8936002)(8676002)(38100700002)(66946007)(33716001)(6506007)(66556008)(66476007)(478600001)(966005)(6486002)(26005)(83380400001)(9686003)(6512007)(6916009)(316002)(1076003)(41300700001)(5660300002)(86362001)(4744005)(2906002)(35810200002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mPgPP4P/F5L3k4oLsr+3G4YqS6+BV7KHcJaIwLFhNtVtPq7r1+x155Qo3G98?=
 =?us-ascii?Q?zNjozfaznX3uSOW8hlao0CVhilQINjphklwrv+JYd5G2PWW2qsnXyRuDkxpN?=
 =?us-ascii?Q?FpcY3j0+iobiXXhmng524nMMvrSJdgWVkX2Gbt5768UQYnCtdBlO6mbe/6oz?=
 =?us-ascii?Q?V/q9po/bmeCYDPBtbbuTXv1rZQORbCqytEDGD7Wl21mjsKoj+S+GJIJjk9tD?=
 =?us-ascii?Q?S64AEv936nE9zpM9szhzftPxCzj4pi3+IUfwsJP5Ws0y/yVEJS4Urh2WwQnB?=
 =?us-ascii?Q?6t9SmiYhbiqeNalkSxsMIbQtHB55f65DFNqIJA05+AeFpIA2KawsEIYbfzTL?=
 =?us-ascii?Q?snFH1CswCpHWXOtig18JjwjV0FQIHNZ3IkdkHedjrdUkqJB+2FnOZb/cfUG8?=
 =?us-ascii?Q?lUurqR4QiknvhMuy1LYIZKrvLxK2DuazgpoyBHrks9tWMlKUpDD2IOiCQFRa?=
 =?us-ascii?Q?SkjWdB3qL4BVE/8Di4sVt5ZEj7JnoVw43j1YeoSlD9ARDrWrMltCrBSNAB3t?=
 =?us-ascii?Q?fpTcUNNf4zmB81nkK8IwPveA/YRlCWR/95YxYzdpz7NwKBUT9fsoU9iXi9G1?=
 =?us-ascii?Q?FNGY+NT9fEih3sQ79tgZ0gdNpxWXypsvcEotd6YmXxXS6vn/M34Bmotd7CYe?=
 =?us-ascii?Q?2ZIQY3UxZy+ngmJi3v3oloVRfjh4vmmeZtLY+VIehT9qgMAPHAMAo2CQtNd7?=
 =?us-ascii?Q?9BqWPSQ/R3eE/LzxBIT5L9gmGs1zEscG520Td/ycTWlwk9Ekq3NlyCWlligk?=
 =?us-ascii?Q?OdX/1xUUQNDS9NO8qHj0tTiU8TQBFff07xRzCkwOboqVXyWC7hdtC3JZXm4w?=
 =?us-ascii?Q?kONkpKfA/dPycU+WiXRGvnXdTHDMwqowuRWEy5GL4Tm3bAsFTohWMLovNL0g?=
 =?us-ascii?Q?m08VHe//sg7+bbLngUtgO9/dbvuL7+QyI4fQP9TMq1GJdv3xf22yN/fZPBpY?=
 =?us-ascii?Q?vPXiy2KPAQ6x/s3nqPIFXjsk4y+w8dvoQEeVx7qwVILU9AbPLk+Ap2Kk1oRG?=
 =?us-ascii?Q?GtbdLf3NqLwgr9UP38lmKMR5LSg0qJbUg7EzQxFKiY7LuQOZ6vsHtKpKSQZY?=
 =?us-ascii?Q?VAUhFiM1GhE5aexJ8QVDnJjx5KBln8Dpv4dZeGoYLTvC1yCHOjxUg0hZw40o?=
 =?us-ascii?Q?/4Xo8zdOOYiFzJ/q7Qdu1rH3tGRlnNOkMHwQtGWFgqe9qSlYKmEfZixKjT+U?=
 =?us-ascii?Q?Jt0D1VguSwFHCcnLE1ANBDHAfNc/nmPLManEkJy2qV9KtQe2PAdS/eTrLt0a?=
 =?us-ascii?Q?FYPff4O+TsczdRydxcllRXfSEiZUA+b4ilHIhZPTPnIdiLV5D6VPApWp7LlZ?=
 =?us-ascii?Q?9JwsIZpEveXFYrzHzwdDmWqZlLsJRIFbJwz8uOd4sUtC1DIOZOuD/IfCpQry?=
 =?us-ascii?Q?Baoi2wxjj+iD/ArZrLA5CfewGRFnLfm3hRX2EqZmFICBf8r2U2//NATTA2WD?=
 =?us-ascii?Q?/znJdjpgUC/qeGIk2GIzobU0BnzSz0i22iwq7q6RjQxX9cJGCWtnFbSP6i2m?=
 =?us-ascii?Q?2NBPOxAdIrKz0KOgABFGN+ITwRWPaTE9OquIx2668qH9eDuPJSyMtG/hDXhc?=
 =?us-ascii?Q?ixQNE758sGLYt/YVXKLT6ExTMK2JR30NG+gGN5On?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LyDFKQ+/nlQqKsffQVlr+aX05pUwFrUNoGk1I7NjMfXAh57ocXv3mGiXo6ydyEnbD+ZwXHd/B0aP1Ymj0vZax1tdui4nc8/Ajr90w7EHIkrgUT21d9dkhw5JVUyptEN4y52rRROhBKvu5H3h9iQ0B+3b+/ve96ZZHjcDZ3veqwqbuNTcfZPIwJXfYLErmLjbTZ7jhjpKcoVC6wXXLglCvqdIzysPhtNF0kEWxDTOy6Iem8swx64YFaIck6KdrgC1m6dfMUYHZL5zTj1J8r8nDwpcE+YRVluNONV2/gfw2iGLOZBPZT+wfrAK3QJZBbY6tebuF6zf2urOKoCU/GOZ4C7pogc1H3unKX0eHl9hShUnb4mHwSdPx6curC2tM9YpD7fnaqGR+vQlP6RqNJ/i9m2JwafP9YVNiaNiDANIKI9S6HN9tFG2HRIWo/evzPCcWpSaJKO0rzOD56QNcl7M/My28uEEjZoOeWv2KfJGErUUDGKNInofhJ2qLunAGtqGa+2AVBGtQTHtN3r/WyrjZ6CaltjM674fUk6ng1CNqEHWy2d0veOAworHin8bXa+uXQFqKSXEnpcK23IdvNzSlP3tKSztg0rRKH43XpKWB8APSk5ofBlYhZocooNEefNUj+xCuZWnOBLfKMviq2zqCmJkg/i5knsGfoGG7sPj7biuzmEeW+LFbaH1O0+rz6fcOqoBJ+FSgPfM/UjumZxrps8Zx5rQS/1xtq6aoEWuMhAA006Su4gvfup4ZQ8qMcl3P8MPBIW1AI9OZ0h4vq5H1mzagWkf8Qtaoqp56PE+Ac7oFncqEop3t0i2TFUVQbueSefl2V1Sd48ASibyTP/ZOvu1PtZ+rKqnRFdIz3UHtXlrTXHaLXLGtjtbJn3aLPgMKWwm8uqVpON04s+Dw10BqA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b95fbd-b893-4be6-d2f9-08dbe3954207
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2023 15:37:20.1637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NC5H2KFbg7Cpg9uXM0xx3uB3FwBdlQypa6ST918lmaiuUVvnbomPsyOlldZVpOgi5M5O5X/pkGEzzfttkT//7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=727 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311120137
X-Proofpoint-GUID: FpkwmToRsp7ksI3voCp-Wa6F50qgYc1m
X-Proofpoint-ORIG-GUID: FpkwmToRsp7ksI3voCp-Wa6F50qgYc1m
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Levi Yun <ppbuk5246@gmail.com> [231111 05:55]:
> Checking data appending on node is done by
>     mas->offsest == end
> which is identical with:
>     mas->offset == wr_mas->node_end
> 
> Remove redundant check and there shouldn't be functional change.

This was already sent out by Peng.

See http://lists.infradead.org/pipermail/maple-tree/2023-November/003051.html

Thanks,
Liam

> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>  lib/maple_tree.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index bb24d84a4922..d16b8e211174 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4141,9 +4141,6 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
>  	if (mt_in_rcu(mas->tree))
>  		return false;
>  
> -	if (mas->offset != wr_mas->node_end)
> -		return false;
> -
>  	end = wr_mas->node_end;
>  	if (mas->offset != end)
>  		return false;
> -- 
> 2.41.0
> 
