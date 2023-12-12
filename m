Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F30B80FB07
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377953AbjLLXIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377895AbjLLXIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:08:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856BD98
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:08:52 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCK602R007179;
        Tue, 12 Dec 2023 23:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=AtmKYNLz8LCiaT55BsGe+X7AhuD8h1s+63rHPG5044c=;
 b=B79GplPYEq+NPfgDJVQOOhuJJN/bgRKguvcarx8xx7Y5T3QH2VBEWoQ2nNzRY7GdFlcg
 TYUYZw+a+D/Xwg3TWCQ302+k6Bfz3G9KP2z2tvm09EQ4uSMxjZkEfzkFNh2QSjS7elTa
 +YRqxiah7b+yxY9photXNPBVRPzcmoYEbqtAJ14Zmi4FlNLut0M5DElIiO79eKXGYVHb
 L6fwqijrADvDyTQBXprIf5cGk1Q2H2TcoTHv8EeEsp48yGTssvfiXQ9XNvrR7+NbW2aq
 VHZwUSo+Uc09FuOk3yoCPT1n7eC8Qz8yzDJTWOrLWKAS5py1UjVWZpuddWScX96Y5Y0/ kA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3n6q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 23:08:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCN4gPx008372;
        Tue, 12 Dec 2023 23:08:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep7ahx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 23:08:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhyDphIlsJoq3jlzjKooUZ3yQpeH2Vh0FpuQ78tofwYSj9C9LlaZzsfKT2apjN9yG2nmUUBs1n/rdycoHltvd7PiG9gXqczX6GNYqn+935a/V+vxu+tti+UJELu4TVxOHa6+AgklkGaMQRMaeNRLsTWsjbnILOP5GOq67eSzdmexRso6R/0grySMJV6ZzcK0mjzBmGQ7VSBX5imMwhrMEoEVNjKeEYSsHGMnT8XBq3Diqac03lqGfekvpueFElIdjjjbJ0jR0DFMD22PAH1gsSCqCHOzpOtuo9BEYvJN+0KFoP2L6LQrB3c6moZjOlI0wkPwwHVsvX9uH0xilMuHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtmKYNLz8LCiaT55BsGe+X7AhuD8h1s+63rHPG5044c=;
 b=XgGV3D0hOrPqgA+YFEekmZ9mTLDszKYghHN0BhsTtqCFtMpJ0tclnExMFggMXV+RRCaJyVtjbNGMnYJhuDu3nB/g0se91SSIr+rq3LetFdnjXImP7UftlBu7kA7K7Xq29iWE2PmgNajkN5bcppewZh0XCd/b5rbJyJop2kaZjt70eFlUdNCyLu2kt/m00QvCGKkby8w6wr6U47oN31kA8fOV1lOisaiLw44RbQ5A9Oktp7ksjVS5CVJlxL3fxMr15XwhutTuu7CX0tfY8krv0gb6yLrzYgemcngM5D+tQsLYipEbJVpRkeEQC1Jl+3vY8uLLJKFGj80GvUlpcCtBPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtmKYNLz8LCiaT55BsGe+X7AhuD8h1s+63rHPG5044c=;
 b=WOQYDaVIMoS7fec9ILdaT/XMgv39u67xX+tk2FKaE+Ic9xLk9IcCHbsLXoNnZJzzR5TLbZ8ccWu9RBO7BAgVherRF/bdjv5wnUPy+WSKGj7hfS71FewF5smqYJWV43u0ZgjJEfiOd8Lsn1QSwKF0q3Wl6lcxdltCEOXwDgCeT+M=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 23:08:22 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::5d54:7d56:454c:4ff5]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::5d54:7d56:454c:4ff5%6]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 23:08:22 +0000
Date:   Tue, 12 Dec 2023 15:08:13 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com
Subject: Re: [RFC PATCH v2 0/5] hugetlb: parallelize hugetlb page init on boot
Message-ID: <20231212230813.GB7043@monkey>
References: <20231208025240.4744-1-gang.li@linux.dev>
 <996ba32c-78f0-1807-5e64-af5841a820e7@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <996ba32c-78f0-1807-5e64-af5841a820e7@google.com>
X-ClientProxiedBy: MW2PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:907:1::25) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|PH8PR10MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 24af6cae-150f-4d00-ab1c-08dbfb673c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZEDos1H9QIoJVPYTJqHg9xERwCEYEokzMeum/gzaHkSfO93x69/OvRFpE/wCqrh0qEgZMj6X6kplFFBqb7P+BPgwU2KM8JqJ4op4IEkR3fEk5DI+2a7C1nrsKXuMmbvFTy7Uv23EX6J9Nops0hpqkHJSk+aPvdywhRXTKVj1M8hoeJwCfNLLhdKEYY9MIWq+J6IEC41GfEnQxzJ4txyeSKw00A4k7CTpm1JN1ajqaGcZMOT24EfCH9SsYdX8CHPFcFfG66mr4ib58xAvidj1vV3CAADO50XNUvpdQcBb58RD02o/KsAqp9sApuRsZH8NvjQvOOdYUUlvYzXhoec1mnfpcS9DGjrf3KsJeLr8ngOVEqCaCH6kK2LkandyrtX0wGCiWy0PIOSH932GPiI8ianns8g2+czU1pEZcDtpvzPm7ZGy16TPGFcYluX172m/YOc5Y30oY+Z82wk6WNTlETNP7gklRaybVLNTuuRt9ojy4Ik0TpFvaHIPPFA+UC4jhy7UVx8GeAUk3GDO6dcuhe0AqYnoPBIokVAXCyuUeB5IrQYQ9nPj81eKvKcQUml
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8676002)(4326008)(8936002)(4744005)(2906002)(44832011)(5660300002)(478600001)(6666004)(6506007)(9686003)(6512007)(66476007)(66556008)(66946007)(54906003)(316002)(6916009)(6486002)(33716001)(53546011)(41300700001)(38100700002)(33656002)(86362001)(83380400001)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nbQeB8nI8DciQYio6JeaaYWZ3gjzlgYSyFqFpa1gjjy6bs+qjq3GeN5Ioycc?=
 =?us-ascii?Q?bKd3l3CosCdZB+BS/ExR5eOCvEI3OEdIu6ZTqp/vLLccWGtvBzGeP/o7mY4d?=
 =?us-ascii?Q?UrwLsoI50Y5JtrWQ7w4MTCKWc6BV1t0A5nMrf6CODKXR4CaSlZbAXQCgYMVn?=
 =?us-ascii?Q?unssOP8eyH6SjVaZLYTZVfnUrLum7PGYgkO/Weif37MAZ3elm4YlIpVDDP/Y?=
 =?us-ascii?Q?z3yR30OwJQ/SRBxq0j0KavBiQTECBHEWrgdcfY4p8WDDg1/9pzCz7USfXLz3?=
 =?us-ascii?Q?aZFgCAFIO2BXT221pLZNBN1BluWPBpypM9ZPmWDfnmxlhMgqyA9ij1xdSv1a?=
 =?us-ascii?Q?+mSaHkfRD0KehqPWaZtJR5zIN00YHCqEHa0TmS27t0AZZXv1lZaF/BeatMTG?=
 =?us-ascii?Q?MThjEck2RpQ1x0XrzAEEK4aLuZo1C2q/380elFjNxhxsoyvflbcTaYUpV8if?=
 =?us-ascii?Q?tl1c2dfGQ/yGMixDX/uNL2PC/9dl+27kygzmS/UuaHC2DghU5EuUXTmCzRhg?=
 =?us-ascii?Q?+TPgLhfnzdUDYWihDKRVvx5Det6dCIHqcjBE3otnLtjP/burhY2MH+Z8ebYZ?=
 =?us-ascii?Q?jPyYGWWh5dqAt1GmLwkvjG6flCAbhTPM9pJSJLmLPnHPfOLLpg8Wb9EQA5As?=
 =?us-ascii?Q?s85IbpTU5cNJKDbzxirEvygYP3/65GE8k7ywnnJk13hFKOwX6rgFiBdOLaNG?=
 =?us-ascii?Q?mhpBboPRGsrjqd1JQ9lw0kHPdbuLZdRoQmH/dmc8se229gtm+KY3YodzK22q?=
 =?us-ascii?Q?C+1Jk2WISaAvDUv4NYB4mxheKxuxggtLJIeTs95IyIAcyc7E7pv3UJHuVgcM?=
 =?us-ascii?Q?1EBCuiUa8jD0GhxaVcPhP+1gE2XQm4ZrIVvbwsyY0/GLEBu9M6Ez+2+Kh6dw?=
 =?us-ascii?Q?xhkUdaMlmG2E+Z0t72cdI5RbbncBq6J5VbgxJAlgnSwbZYxGxbfQTDuHSAUS?=
 =?us-ascii?Q?NflBVbAUI3219LiRV8sKrnWxtJymr2pSLrF9p4YhfEcIP0zOyqdoBPNaexZw?=
 =?us-ascii?Q?/dFJUtQb29FMW8pgtVTUaV10hXxhbo35co/vY/N8vDrsALrWJnR3OxGPlyW0?=
 =?us-ascii?Q?APXFF/niwjwGoyRzYASArdvQUFbenkGX0RtY7sp2FrhvS4m8B7BaHSs4mEyP?=
 =?us-ascii?Q?QYpMt06DFl1dL1gPXpuKlPhjy9N8kHE35d6XufZt1b8DY5w3i6uGV1CeRYro?=
 =?us-ascii?Q?tW3mLTB3rpqn8/wQazn6g0HDxiKCZwNIMCmzmhhEhIU5FBy8kDLgLivzO8oC?=
 =?us-ascii?Q?Yo1Q4mL09LIq417UxL7BJTXufb5+1Ca+cK/V4c5lz3hWgpIlrmnyjhHZT6Pu?=
 =?us-ascii?Q?K0DRPvYKQ8t2l9JEzJUb4z9UXFHTId3GUgwX0x1dzW5JfVmpTo+pZG68jnGb?=
 =?us-ascii?Q?G4b7P6itveAEteZsS6VajSX5RAFkSv3/jkqss16fjrJntyrdfaHNwW7QUGqV?=
 =?us-ascii?Q?DgAvQx26JmvmsmJK0Yf9EelAJSbM96xDa0/2IQhP9mczejVFYIpLfJgOivOD?=
 =?us-ascii?Q?SVgTilcwoS5DpsPEM8wEgpEwohOswVTla+rjan6jZL6f2OsJFAALZHF3iWr0?=
 =?us-ascii?Q?Zb3u4YcVtDNuxxapN1ptfgy11nh+cjgh0BdJD62Z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8a8B4iK3JTO9f3uT10IKbVguA2IStAGhqUZY8tAT7A//mrgrX166SgMKCOTR?=
 =?us-ascii?Q?UBoujUUG20g+CZU2v/XOJneEFX95CliHzBtdy2GpfksnA8CK9TEduQB/dmmW?=
 =?us-ascii?Q?wHo6uYo9cMhbt4hvO0J+dzhgKiHfQ/9KfQCdMgM+WMoYVcIvuaG8C6id7Hio?=
 =?us-ascii?Q?9Rr28DPiNKLLeniRmP6Q11WykLk/4rhc7rPR7FeanK2TQkl9FB4fTmImM8CA?=
 =?us-ascii?Q?HtwsrvKeKk30tKUcdYs5fiPgweAnZtoKB7+JZQGgvhic5kaBFeeiqgX1r+GV?=
 =?us-ascii?Q?ci7geQ8hPIER5oE0oCwUYIB75BSO+6bJ57n3Y5y2ebh/jgWeSc4OnO+afokr?=
 =?us-ascii?Q?Xto69+SMRZ5xVwScg2vpWjhpbglHyKRaAa8CJ1hQgYGjtZrA7V4yn0KgEmtY?=
 =?us-ascii?Q?qzn9WCezpeRLCrBw9BZuGuuuOpy0uZH2bWG6u8lo46ZCgKE/6hofLtpASj9i?=
 =?us-ascii?Q?947qZ4oTNFvW8V9llJ6VpIiWlsy4Qp6GBW2efMDf09iIJbAbst4VPY2azWEC?=
 =?us-ascii?Q?BsVuJTiyFmD5T+678ghclQGagmnulm13sY1/eA5rWHL8oDgkEZv/pJ46nDoF?=
 =?us-ascii?Q?7d3pM5DGKKGOe6ZCIIJ8YLUnnGTE7sge5OhHAJDGxTWWVaYsqYV1BNCq29CP?=
 =?us-ascii?Q?WPYnBMHqWQbh7Y9hTWO/p16tvHpSKS4O4UuZJ5weNATp96cR9z6jm0z9vpFj?=
 =?us-ascii?Q?0p2Oj/hZ4lTLAAt1esSgHk1KwQwmQpu4J8KJKW13/PLiEw7EuRPWXaN7HCz0?=
 =?us-ascii?Q?Zc/BabJtpM4wdowAzfgMyE4MGRXIdA2CcvvAIyHHeDDHR9qy0BsZ/ay1xz81?=
 =?us-ascii?Q?L3fl0aTT5NPUd6WrVZoZVVTLuOmAeABgq8MhirARmUUaOVLxzqu8OY5xDg+P?=
 =?us-ascii?Q?24T2IahImZi788PPeqf9695bcrd84JcrRWfQRv67Tf6xEh9I65+BUdevaAlG?=
 =?us-ascii?Q?td92N0zbqne/rVyTVOZo4A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24af6cae-150f-4d00-ab1c-08dbfb673c3b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 23:08:21.9703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NvC+PTMkDZbJXhuf9Zms4+74uXB0GUUjO5PMltS1QgSpGF+XR7VpGYcHci+nYp7Cjmo9iU2RbhRDQfQGwsw5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120180
X-Proofpoint-ORIG-GUID: AlhSliLTILbAJBvuJAHTwjljDxp2hFnU
X-Proofpoint-GUID: AlhSliLTILbAJBvuJAHTwjljDxp2hFnU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 14:14, David Rientjes wrote:
> On Fri, 8 Dec 2023, Gang Li wrote:
> 
> > Hi all, hugetlb init parallelization has now been updated to v2.
> > 
> > To David Hildenbrand: padata multithread utilities has been used to reduce
> > code complexity.
> > 
> > To David Rientjes: The patch for measuring time will be separately included
> > in the reply. Please test during your free time, thanks.
> > 
> 
> I'd love to, but what kernel is this based on?  :)  I can't get this to 
> apply to any kernels that I have recently benchmarked with.

I was able to apply and build on top of v6.7-rc5.

Gang Li,
Since hugetlb now depends on CONFIG_PADATA, the Kconfig file should be
updated to reflect this.
-- 
Mike Kravetz
