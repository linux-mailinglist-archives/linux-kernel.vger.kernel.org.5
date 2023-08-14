Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F54577C376
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjHNW3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjHNW3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:29:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C2B1718
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:29:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOihb031591;
        Mon, 14 Aug 2023 22:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=88t2alqR8C+BKZqFm+gXf16pQWdq5bMHsjjbp6Djxa4=;
 b=FQcWwSA+otvBnsydtPrCdoI+1lT+MHL3Xu7lRK6XHH6lrNn6p2HZf4IXj+t07IIfgLEZ
 0DwbhTJHjtYr0+TByYqGRI3Mej2+KYuxj+hJH0JoDJP35fqERpkyltZs6XHh1BDFmocK
 2xuGMr7X6dyLmMxUliNblj4uYbvjPmQ4b67dFMLpngf/pTdnpSmNjAgh1xLUpoEcT5pR
 sA/xdmaOWXJz0h6f4+Va+rY16dhVHHDH0u5xUC8+SSjkNqiKFVODcpQkOXIszFQ/E8/e
 gIlzoPWwMcqv469A7pMso76nrLFVKbJ1fd5OH3HH0lzedYiMrgI4aUeJtexZnrej+xFb Mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se3143qa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 22:28:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EKNZ7o027320;
        Mon, 14 Aug 2023 22:28:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1rf1k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 22:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSOkozVNVsHbdSVmDB78HiCRYJhXoKcliYJ0OjHTTLIR/4L3LxzdPOwGA3S/mnZ5G+QHMoZq/aDA268Z6lQsCbu4Hg2EwLJSlJqe9GU4eNR/bozRqP3SD9hsK7UOO7ahjVuAwUdmMfxKdnRBzAfBHQbvUlHouiX64bt/bbdIhNLZqWXIMQtTpSiWcQcG3It5alASD2P/nJ9HLW0A4fHG/xLC2mkXK6EAuNalDLmrbH7u0t98dGfY7b6Q3JqgPBIubWGlD0eMQLd9AkJ/SNLx6oTQ3ADiwQzqlwZS98GBJ5zIZEg8/iRtBW8EQA+7nj+i5ckIropkWlwrvUrlGm2BFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88t2alqR8C+BKZqFm+gXf16pQWdq5bMHsjjbp6Djxa4=;
 b=Be7y8g7uNyeTGKb5n7qAnSZ17Q95WKdU8I1a21ObFQjAnv0xmEHCFAwfMu94f9sDdBxuk61AORLUzzJqf/pyfhBRlvOA2KCAoZnOIgwS0Ds3of7dep2/0audkKmNCOnDebycOAwqhQT7Bz8Au4CVmb1RV4Quq7YTCf9ybO/tMwHSGZpm+GVDYcqZ8YbKNhxK7jrgPqxl9stucbQ8K6f3Puc6SKT9A/USNzUrOJvKZYqssB8r15U/+G3dDztUwaaYGZLXehV6zOl7O1pYfcVsqdJCFutHUdkcdAOHYD7kBM88y8jg5n8PVjDx3/Ak/ERFx+8OHMD0F0ZIxTCRTC38Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88t2alqR8C+BKZqFm+gXf16pQWdq5bMHsjjbp6Djxa4=;
 b=NGqlEaeJisUVD36hKvrW+EYRBAbx9ccFDKpFu8UnABVR8trYx4Rhh0lYFUZ+w4SjaLFgvx11qAWkjtE0EYbYbGPu5xpe7T2grlT4NeIYAOytaSRbDB960s1mpvrw6q4WY0vJMqD2Rca7oQFXGgdKFJ1rRoIzYu7ubtTTYcVq7s0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB4905.namprd10.prod.outlook.com (2603:10b6:610:ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 22:28:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 22:28:42 +0000
Date:   Mon, 14 Aug 2023 15:28:39 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     muchun.song@linux.dev, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb_vmemmap: fix a race between vmemmap pmd split
Message-ID: <20230814222839.GA49018@monkey>
References: <20230707033859.16148-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707033859.16148-1-songmuchun@bytedance.com>
X-ClientProxiedBy: MW4P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH0PR10MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: 965f88bd-7e78-47fe-9ec7-08db9d15d0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZui8UGwiTqRcWvnMVnU3Xr0yF2stVKD4IwIfdg7BYif3kkUXeh5tHYjnB775Ul99KNuVWODpA1kWFmSL56pfae29OLTvlIohgFhJnhyNN397USjZCbFN/NusOQ1kva+e7hLt7r/mdAaG5mpqBRqEsETjRDz9gL8MW1h5wSYXLt6Y5QfFwKjTuWXAU6/p62C9iGa34Y3YWA3rYk2ptKiu2pWuFIWkgzbikoLNhwMl2MAkvyrUE0tCEOiQ+P+XB6oM14Owdbxpo0q3B+S2iswj1c8XXwhqvj6LXFJs5bOKRBxAFDLkyewhFI3OqZkuTcn6UEfqzYWKqzpMydLV1DvK3VbH3jPDoQZt9fdE4pNs9c1TtvOMXZ0A4fFDox51L9JFIhXzh4ArSQSGIghezAfyPcOBm/MMuF6fo2yaZ5nrb1QeKvWXQWnEyIqDXr55AJJxzXvLYJxJVFEzRiJhVE4V+wYrgjlUPuwTzh6JXe8CNz0w0Vp+nqxpJdC3Ccy16UM5Iq/a6g6jjV0zXiir5RGOtcI7S4RC9KR34Kc+pgd8KmowAYMV6hDkgFdGedg6ll8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(186006)(1800799006)(38100700002)(6486002)(6666004)(478600001)(5660300002)(2906002)(86362001)(33656002)(44832011)(33716001)(6916009)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(83380400001)(53546011)(26005)(6506007)(1076003)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?byuvjd/o23NAK/Bm2BitfiEv4HPm0bVH10VloYcoKoqtqJwbY4HsPN5CVcI+?=
 =?us-ascii?Q?HnDsonVymwV1BxHmqI+j3fP+xnw2/ugBJJF4n5xuJj3bTtIowNPwsOeGrVfh?=
 =?us-ascii?Q?8IXDN1sTR9np8fLkN5FaqTT7GXBtRZac/jp3dFGzJNy2ZxiDBCFqwCpqXusM?=
 =?us-ascii?Q?02fp04jzpbC8ZaUw1ZCUIl5wK5Uwb3R1Rew3Epwtg9LOKS9waK5r8yTmTDh6?=
 =?us-ascii?Q?WW17XyegzVKXghB2qzu/TBprzHpU9SdHZyRiHnYmVHoy8rGzoP7TsCrYIcnE?=
 =?us-ascii?Q?TcKhzbREBFPbTS8hqJaP7el+Qrfbpf6hJdcpYR02VicOvBl0y3XH+awUwhG3?=
 =?us-ascii?Q?Xdpzk+MeXDpbZ+8ABj+5zKISDdnDlcPa+bm8VeuSkaY2g6RL2mbc2dPylKlR?=
 =?us-ascii?Q?yHwC6qJBltM4OwSGjpDmZ59NYHurT/jroCKF8ooWEBCPvlpJ48D4hJjULJ7Y?=
 =?us-ascii?Q?XZCULUj+tcjNmP/WZSf3nN5hLHOVMsuxziA7GDkRec5OfFKZ+Nv+VQ2BOGFK?=
 =?us-ascii?Q?4vkuR1zL94RBV1KCQc97M+Dkt6QkOb2jdifQCssGj1xqP2x5lxs6LCAlcqov?=
 =?us-ascii?Q?KvzpKQHWF6fZgIcHiF0j4xiz2xeysa699U8bsTpZzJhgraP5lU/AzwxgoYZU?=
 =?us-ascii?Q?ysUTbbB+Ylb8HVGN8uPIEeujAnzGDf4vKzabjBTbrR9Ai/Z+NxC2l7i58bqI?=
 =?us-ascii?Q?VeuXZMuT+HrjvedlfOcfmomTx7fW6FaPSn0RStFc41P31I14Q0n3zh7KjSkv?=
 =?us-ascii?Q?NmC8RKuU6ucMf6FQQk3nubaLfE96407yDXrGGc81YiGcVd/Kxb7q0y04Y4a9?=
 =?us-ascii?Q?XYrm0xA8gyaSl9CrDkuvybdfg7De4zsgo/FHdhp1aaR7gX7JkdXMQOiNWbnk?=
 =?us-ascii?Q?eWpwBojmhLkgXl0qYqWM5Joa3M92dko7IdfqNeoE6c0Cmyj49BgDYaMNUXiu?=
 =?us-ascii?Q?oh9VnVxG3J02KIZkuYtGs7JexnYFvEsCdowhrdTpcej9vuYvqVyzak2Zrlyy?=
 =?us-ascii?Q?+mRE206tyYxdJbZoExtawCIY9ZoaPwAJ6g6YY5RwtCer3BFPGdavKQcke/rV?=
 =?us-ascii?Q?3A+J14XJ7pp22fnzci9/SLaCN3gfrMeNuPlXJ4unMjFO3sIwXyEsTFxMHi0n?=
 =?us-ascii?Q?C2+uilyhTsytOFilOupvQqoqIGtmypuVNYbdndcknjPheskIRzrEvuekAlNE?=
 =?us-ascii?Q?284X+rJrEl0O50W/JuO7zJaiBkD3Jn6XIVgdP5Wnww4865Eqg2y/YNxeel47?=
 =?us-ascii?Q?DShH4pIBCnm6+FiCFcjanDH3qABb8ZwRfC5JCMenFPdnDV5f6JUdfbctAuXm?=
 =?us-ascii?Q?AWOAqYH/EuD1D9L1Sr67aSL6M17dLCrny6eoIeoCqy4u0sfnIXxjT+IzXAQC?=
 =?us-ascii?Q?uVXaaQ6af13UlUNMpZsFAJsGRMSMYDJp4Eqvv7ZzwayK/PgaZyaI1BHzFpHu?=
 =?us-ascii?Q?6KbpSDwyRslg3GVq+QZ2Z0BWoMKnFcMzwAvvnAmqjOkp4bw8Kedl7ZZT7DY6?=
 =?us-ascii?Q?VR4uchIS60C5lL2Tzl8l70ABBFUiIKeOvvcG31ysTVSLDMHAFZQtsZKQtVGL?=
 =?us-ascii?Q?X2L6NeX7Cn70dEH2VeJF/ZowmRzI9cpN1uKR3742bX73wZTPfpkZ8OG/6Ycm?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p8t7U0So3Ho1FhyJA1anulLvObdtEMVA9qG2HMNjRY8CIhpDBF5Zv4QqExQKtLCSIfXostzt3N40gd0nS/GSMuY2sZiN3qibLtdnsOyLNdHQjpRAH8kzFkTL3agf0K38R+mjI4XdZ81sqtPl78IGyjR3WwWCUL1m58SoMoh6QXjNBb6SyvPNXPimssXv3XAawqoEIWa1dL2rJF+pG09ewnFrsFz5VbBxuhaLApcXvmrdW5d76brxOfpmkgZL0D9sq8MsQkxiIILkmluvK1troZ9uKCKiP2S2I7UAaeFnaULRAUgxQ53WnEtkSgUSfphBIGZ26RVBIe5ECGDnqjpNDZr4NtpWMcNuvgmLou312FqISQ45/4fxsWOicGB6oUGS7ImrpGT68QdipXdk+B1vi9Ka7fbX/21PhKBG8zqmkExuPhLDZ1Y2DwIkysyQxpFhrSCDAtwrSImTZr0NO+GFFNA8zSjVR79NVE7BPVKcymBA0O5HhIj20k1WZkQHviaoB9Mn1aZ4jsiddSvVeIzAPKsdg0ea+ZJqUnv6iQ68a8jMj03ovKHo9zjfL4JoAm1SpWLTguC8m5+FtFS1BGEXHF3pvxwT0y0Ebs4ieqzeSk0vqyo9qWRiPlLl3ba+ZEA3t3wHHSkXtzC7O/s5rPUe+1oJerTmcEv6owWy+aWsSqp/7f0wiw5Y3d4nwzDWEx23vZ2dyY9XuHbyTINx3DEG52GQeQk324NBoVIvtR4t6pJRKBbyDbD6y7P9DM5uiioUN4JfAMc+g/p2B+vtUQcUZYEMRWKW5cOHS+E3yfACSiGecY52XhGK3IqdRMR7+1XR/6ogRIVjUfxvXk6ycys9wXmb6wCRsnAEWhHkOlv2Kij/nlEXELL4VaNTuBj9LnFxHCtBCUik0pAm7sU0aiGedhChM7wKmij9JjPBzaIvw5U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965f88bd-7e78-47fe-9ec7-08db9d15d0ce
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 22:28:42.8398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/IFr+QLms5WL2jNFyORwV6355XP4tLxiUkrz024mB1YtyY9jW0/rKakluabxO1Tbqv7r9Pxi1yc+lPJ2FvM1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_18,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140205
X-Proofpoint-GUID: SekNmV06M6Z1_Vpvhk4nS7J41uW4Cg9s
X-Proofpoint-ORIG-GUID: SekNmV06M6Z1_Vpvhk4nS7J41uW4Cg9s
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/23 11:38, Muchun Song wrote:
> The local variable @page in __split_vmemmap_huge_pmd() to obtain a pmd
> page without holding page_table_lock may possiblely get the page table
> page instead of a huge pmd page.  The effect may be in set_pte_at()
> since we may pass an invalid page struct, if set_pte_at() wants to
> access the page struct (e.g. CONFIG_PAGE_TABLE_CHECK is enabled), it
> may crash the kernel.  So fix it. And inline __split_vmemmap_huge_pmd()
> since it only has one user.
> 
> Fixes: d8d55f5616cf ("mm: sparsemem: use page table lock to protect kernel pmd operations")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb_vmemmap.c | 34 ++++++++++++++--------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)

Sorry, for the very late reply!

This code looks fine to me,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

The discussion about 'open code' or inline' has me a bit confused.  I am
perfectly happy with the code as it is.

When I hear/see inline, I think of the inline function keyword.  Since that
is not happening in this patch, the mention of 'inline
__split_vmemmap_huge_pmd()' does cause me to think a bit more than usual.

Yes, the backports will need to be modified.
-- 
Mike Kravetz
