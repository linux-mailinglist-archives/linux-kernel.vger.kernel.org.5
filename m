Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8DD7CD2C3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 05:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjJRDog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 23:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJRDod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 23:44:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8A1BA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 20:44:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HJx02h002462;
        Wed, 18 Oct 2023 03:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=xeLexDlFXE4jlACk5MSDI91rHPAcor0qBIMLz/sjnTY=;
 b=L49vVUxjmt3+x0YPGBfPZaisCsJp2A34LoYNq1A4g4vDgu778C9/5YjSsFqZvMCTynv1
 Y2vq5VOaOV+me2e3adLxYeuZf9ngeXWHnCzVsuxy5EKNp3GXCAsY/+/aF3a8O179onyR
 O9dodx+Nro1rKNrl7P6g4SRoigwGeI0Wd803RRBQmIOLeq5ZWvXrSXu8ui+gkMR7Jzs2
 8yqOSsGexD0cYsvvGgqaAsWHg3HjvXbxe74eZxJwfJLxgZhLduuDYbUaZhIg5vS/IXka
 +V2KXIdPaNkjkpXyndHSp9OSGkix4ZFQO9M4CMIIMGlb9jfjuQ2HbXxEvbbPJ7grweZC 8Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1bphcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 03:43:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39I1TpZv028509;
        Wed, 18 Oct 2023 03:43:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trfy4f6x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 03:43:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRVmVmhxv06Dtgc3WTpvF5ycVjVMnslx4LuRu8/W0NC5SCnfKCE65Nhzt7JXLyrO+Ot3M0diJ6UAIJnLYUokP0OsHrIEeKa8PvkpTHW+8VOPM/BocqmDQw1SmUB8OBoLEvXlflKazai/+3Dnv746qjWBzDYWCuWmmuti6bH3aAodGZUEIOLcKyTfSOEYe8xe9xj+6SvI+A4dMG3eWQrUkdXp/04TZ5K7+H44effRVqWVkCAsDweYDY7a2HBhOlcCzLGfh+MvTRC9PfFH2JHReHXBAJ5fXLS7ttPYJCa38OIYKYYev+/hEo6NKVYBpXbQ4pl/wNHQlx5SF98ZmDzjcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeLexDlFXE4jlACk5MSDI91rHPAcor0qBIMLz/sjnTY=;
 b=eRBgRVHhSPGjbK+SBajtbghlq2FFdsxz2plQH+yibQy/9iT7mpb48hz24js5GRzdAmPPk0MRAewaVJAWYBeg6leAAiPS8zaATW3MWQHpX2xFOyZ07RrjpzKRBAs81htqw79d3c0ykeK5myGtnMRArt9nBJdLr1Ats09v9ogTLs4sjRF/GNLMXtel0zPCFxUkatcEE8Z+5p9nUfzKc21B92oj5GCH9qlX8i5QueBbhxVfWeATefZHSJ+kHzTBklGS18LMV379S2L6bFgsc3SswQvgeOZ4oqxkWUH9UJFAst3kEDBTd0rBOhntQrNUK7PA7ux9zXf0sao0XRdpniMr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeLexDlFXE4jlACk5MSDI91rHPAcor0qBIMLz/sjnTY=;
 b=zsYlP3n1wGdCz3YJWliskefkzhy/SAcj0Le2cpBqEeBWy6RKjCLcEPbUiaKZd+5E6STmAeZHE/5KFky4+Dl398AWr/er1chj/t7eWcGsbAxtnNlCXYXUkb7rv1Qx99MIuB5yE+p/7GH6aDhx9Pvl3rj0ju67Y9U9+FmJxikJdMQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN0PR10MB5910.namprd10.prod.outlook.com (2603:10b6:208:3d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 03:43:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Wed, 18 Oct 2023
 03:43:32 +0000
Date:   Tue, 17 Oct 2023 20:43:29 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 01/11] hugetlb: set hugetlb page flag before
 optimizing vmemmap
Message-ID: <20231018034329.GA4202@monkey>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-2-mike.kravetz@oracle.com>
 <20231013125856.GA636971@u2004>
 <20231017032140.GA3680@monkey>
 <20231018015824.GA2942027@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018015824.GA2942027@ik1-406-35019.vs.sakura.ne.jp>
X-ClientProxiedBy: MW4PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:303:8e::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MN0PR10MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b48e403-1f72-4f3c-7068-08dbcf8c6657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7AdRp+Oxoac1rO2kFiIdFITfEk0R72GfPClAAaIOYHONrSFTI57yM/jnLcnhOujDquES3hx5/9Jsq5IspksnSfV2jKJCyAvwEFUeCdGrpCMXgb4nobSNlVj2Kb2leSOr6Rkvm+euJowwwvL2VXJo8hxB2ZOfOny3dzlQ+37Q741v84YZAdiCUHwpr8TyhkbfjmX+9ABrfjbAgrOohCp6sDLYHGIwqjG6uKQ2M08QcseMoDAKqcYlFFls41NMUVQV7PZ7o4xbC03C7tpUYX/11sxxh3WOfJ7ms6CfCnSE0prCJMU0AVvWuLkdckafeR+08BwphHyQytuZK+2kNugm0Hfma+KqiQUSXdb668C6Qo8QWxwFOby+AzN1IPbgycnw5wESI7YGkvc4z7AtM6m1+LlsCH+C4l6GsIX9GeHigLu/utY3nf7B6TmrXDcOh6kw8yU6zhUTh4KmoFNAtGTI+Mo8MDALaueS6uGbePbHDhvIMP6kGiYo/+aZcpUe/5lVHhrct2XPeeCHdksqnQxY0nPwr0AtUf9OeQgDaS/ZFp4mopyvmnhVNR3kQGFizvDo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6916009)(66556008)(66946007)(6486002)(478600001)(66476007)(6666004)(54906003)(53546011)(33656002)(9686003)(6512007)(316002)(83380400001)(33716001)(1076003)(8676002)(4326008)(41300700001)(8936002)(44832011)(7416002)(2906002)(5660300002)(86362001)(38100700002)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oNOuGW8Ko9+JZbONJ8HXw5GwNBrfPbsiEdRjJ94Nk5KCI6dYoUrYsS6+rX06?=
 =?us-ascii?Q?tBIwj6kepxT1c0Br+opms1qUxhnhCOoL8HW+DpDIyOPbdM+SzgrfrcuEwnta?=
 =?us-ascii?Q?GNpCcrYcvErppamvXXNOHXPjqp96FVT3iC1AqVHzIRnvPsagcA0GWYcvYxvz?=
 =?us-ascii?Q?hhFUovYAswbHQ4NA5UXVZyBK/NXKc3831BuXLmr5hEcqnq7nZ1fxSc70Mt9L?=
 =?us-ascii?Q?p+yjBz+URqGhbY+pmvo/d7p4c4jFjVEajV/AU+qAT8CUSux3RG8FWDp+H0/t?=
 =?us-ascii?Q?7xxVDHabeZECShbpTb++0YURmxE1KKp/vABSxuISqU+U3FjJAI/ofCTRXfrC?=
 =?us-ascii?Q?9xeS74Jk8+s/6pGcdHr425TCecER0euWFF/YhIXrvFk0+zkCn9uoCvlxk5O0?=
 =?us-ascii?Q?sE0uMjdL/ytCTuwutOnV1rSg+40miO7BY8b3OgMU1HkuNK3ybVClkY/wNFAw?=
 =?us-ascii?Q?vBhivyQpt7NUcDUJENBJE2Wl8979lRf+p+x37sAHzdI79NOqIx6gkEqqq9+w?=
 =?us-ascii?Q?jNctBY0KW5FFginpYnMHPsh0rvSLznzdn2rhkauxtE/EeSGwMDm4vrtGoDq8?=
 =?us-ascii?Q?C2DHaLUl2ZNHBAE8MfbxCYW9NTETTU7mfYQCaQWdQWS4+uH6EQfKUcqM74dr?=
 =?us-ascii?Q?BbCgpK2M+4itjElQI0LIQLlZ4Tka22VTXZ/EVIPSsj0mC4+Wi6jYI+naO9CX?=
 =?us-ascii?Q?xGWRC9XiX7ZUOeCnV4zZzaOcMfiWHA+5Yy4SH71Dj6yaPVo5ufr4HambJk0l?=
 =?us-ascii?Q?fyDwxH1Mb9K6UzwiO+7azhRMExuYXqrsh92fZPRa+m7RmNMy7w57z4gwN+ya?=
 =?us-ascii?Q?FmTSL9fDeqbwQPMzyaPDdvJZ9+s+tMxjbFGX0R/g0Q9eQrTIIFCmHKNiBSPj?=
 =?us-ascii?Q?9IRijz6+UgVR47G7AGMfWLttTszt7Ym/j2cyMZE6B+Zvb+7EJcLbvnOUOzD8?=
 =?us-ascii?Q?FQBGCteUDg+5mR7XprrA6eW+bqp44M2BStGGk2fb96DcMmwMq24dDDRMds/x?=
 =?us-ascii?Q?SvzMb8efQr8wEWk2acAD6tFHnvt94oc9yWnNHYHpG50aem4nJDmhtGFqTHZO?=
 =?us-ascii?Q?QyiJFjF8HOlDnqwGFESkaHhjvNjwwtYUFaZO5cpBAk9VLEVHaEoLERVops1A?=
 =?us-ascii?Q?0ZRh/7qhaN0Jl48OiDlo+pjN0IPYBsS/dQ7vA6+RLn+N2fdCp+bkjKGeTWtJ?=
 =?us-ascii?Q?8xBqmHw1CWrsPALYRLbnpmV0lKS8H2nHQGIwUw8T7rJNL8KR9qHP9vcXXEKv?=
 =?us-ascii?Q?anxk9nTIM2oTcYN/mpLAI82SGdw5U4iemWuZ2bpUSgRP2dm5PoTe0kIIOI09?=
 =?us-ascii?Q?e7bUpAzeKu6NpvN+Dolo+VVbZafCDm36pxHdai1XoVONDq+wR2IkuXr7Vzid?=
 =?us-ascii?Q?VpgPo3VfWCE8RrUPmOGXLEXAHEZve4ttVtKO0FWk2ilymLHk1XuuEsDowGVI?=
 =?us-ascii?Q?b5NUQWjmgjkd/LlgT0i79x67lw7LcZaMKXJ9re6aJifuX62Dx5p9gZIJSK3q?=
 =?us-ascii?Q?ib8SjyPWe13d+jVfSdD3K0jWXQcCO6GcSY/C5ur0fxyQFVrTdeNDcvYGFnfe?=
 =?us-ascii?Q?QVxihdUMdpAtySLTfdeUmdBOFem0OA7mFxpntaTm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ag03dc0cotorvj4VqAEi6unQL3LY3iplUrdPcdMK8+b0iu1LKOy8fNyvECqP?=
 =?us-ascii?Q?01oZyrbd49o2JGJOqXr+ZqZFGBn/jOvTMxBMYUNDarG7UOtuHT4AnG1qhpAW?=
 =?us-ascii?Q?xGVhWB4Aog5GJmwRQaxOvUifyO/pZ1LmcS0Ig/Se7lINsoQnjaJcvt1gDaMW?=
 =?us-ascii?Q?DxHd6MW5sJvS8Qbsi6VCg51/jszy9lLH2Uuhl/QH+aJbFy7AoEoiNyLav6Vl?=
 =?us-ascii?Q?wBvE2ziifegVWvzDCAIljkgOJ5ioBkDi+JdFZ1xqqgEV89GzNKBbEj8SV7Bw?=
 =?us-ascii?Q?+2qJh9K0WfsJiD/9dMXKPqbuVQfV2GvEAoAtONeRi6juANxPANQRMjtjAqXQ?=
 =?us-ascii?Q?+pbUHuBs8iSiIgbTYMeUs8QOAc3Hy5b8H415bpBZ7OB2wvSZXDLLxPmtQVOp?=
 =?us-ascii?Q?hl4+HZaygL+Q29fi6a02FwUR1679RMwkO1Pxl2USJlcLuW0H1rZ4hhnCUvId?=
 =?us-ascii?Q?9vKpNWO+31fXXCcYsuaUcDFLBMa3suv51nvkhM5Xhjq+u1wJr9cd0UMzOK3N?=
 =?us-ascii?Q?tu6SXwfL9CESzkUzQe7wbaI7Pc8WjsXgQx0/+jOzRR0fnqZklYT2EkCbAz6a?=
 =?us-ascii?Q?qzFPyageZdtgDl0L5fjZqoHmgwPVtadP4yMdvcG7rQGxSNubaiSDtToY6djP?=
 =?us-ascii?Q?NRGUg5pKzx70JsOMqTRhX52mlqO4pa1ol5+QrvHimkPRrYpKkWy7A/hwMZH5?=
 =?us-ascii?Q?4nfdXX4i+PubJkgdOO02Yn9L4UqriMkOFoFW7JwNr0lqMxSW8TakLdHk/nbs?=
 =?us-ascii?Q?eMmOOg22qd5yDqAhO9LDDz/rsszNd3//us7iuA+PY+64/LdHm0/XPNUmex2t?=
 =?us-ascii?Q?1IqnP03J/PbBSOwkKJi/WNdfeTgocU1NyLBYqpy1l9ohL2IDmz23+vO4JkPs?=
 =?us-ascii?Q?g/Nvt7GPM9W9rGX7IILIvwd6iOlkcLicqBI7Ys7x4cf76t8kM/XMG0NjPUIr?=
 =?us-ascii?Q?JfvSK8Nrl5ivHVPILxVkpsXE8ktoWD+7/6k83FKy5v0CfZ7/41l1Y3k9VPc3?=
 =?us-ascii?Q?NKvB6klOa8A0C2aTOvH7RBv6i4PCoTvzH0uthOb1LeHVr+O9m77n1NLpuupF?=
 =?us-ascii?Q?9yTLFCH3AWT/kJKPRnRvP/J3JMoAGb0bFOy4sUq5dM9RPzKVmDydcGhG4DUN?=
 =?us-ascii?Q?lrFCdaUgodzG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b48e403-1f72-4f3c-7068-08dbcf8c6657
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 03:43:32.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tp93SSXoQby1pMO//VUvpH72sO9tvFSoeQ2jxuxqGORHqHUTFXmJpDAMaAc9HTvP2Zk15xCwMz/cq22ci6RyIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_08,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180031
X-Proofpoint-GUID: RWuTTn2601HkTzpID3NPd0_dA0e6eXzD
X-Proofpoint-ORIG-GUID: RWuTTn2601HkTzpID3NPd0_dA0e6eXzD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/23 10:58, Naoya Horiguchi wrote:
> On Mon, Oct 16, 2023 at 08:21:40PM -0700, Mike Kravetz wrote:
> > On 10/13/23 21:58, Naoya Horiguchi wrote:
> > > On Tue, Sep 05, 2023 at 02:44:00PM -0700, Mike Kravetz wrote:
> > Hi Naoya,
> > 
> > I believe we need to set 'rc = 0' in the !folio_test_hugetlb().  I put
> > together the following patch based on mm-stable.  Please take a look.
> 
> Hi Mike, the patch looks good to me, and I confirmed that my test programs
> showed no new problem on latest mm-stable + this patch.
> 

Thank you for testing!

My patch could be simpler/more elegant by eliminating that else clause
and just returning 0 after update_and_free_hugetlb_folio.  Oh well, it
is functionally the same.
-- 
Mike Kravetz


> Thank you very much.
> Naoya Horiguchi
> 
> > 
> > From f19fbfab324d7d17de4a1e814f95ee655950c58e Mon Sep 17 00:00:00 2001
> > From: Mike Kravetz <mike.kravetz@oracle.com>
> > Date: Mon, 16 Oct 2023 19:55:49 -0700
> > Subject: [PATCH] hugetlb: check for hugetlb folio before vmemmap_restore
> > 
> > In commit d8f5f7e445f0 ("hugetlb: set hugetlb page flag before
> > optimizing vmemmap") checks were added to print a warning if
> > hugetlb_vmemmap_restore was called on a non-hugetlb page.  This
> > was mostly due to ordering issues in the hugetlb page set up and
> >  tear down sequencees.  One place missed was the routine
> > dissolve_free_huge_page.  Naoya Horiguchi noted: "I saw that
> > VM_WARN_ON_ONCE() in hugetlb_vmemmap_restore is triggered when
> > memory_failure() is called on a free hugetlb page with vmemmap
> > optimization disabled (the warning is not triggered if vmemmap
> > optimization is enabled).  I think that we need check
> > folio_test_hugetlb() before dissolve_free_huge_page() calls
> > hugetlb_vmemmap_restore_folio()."
> > 
> > Perform the check as suggested by Naoya.
> > 
> > Fixes: d8f5f7e445f0 ("hugetlb: set hugetlb page flag before optimizing vmemmap")
> > Suggested-by: Naoya Horiguchi <naoya.horiguchi@linux.dev>
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >  mm/hugetlb.c | 24 +++++++++++++++---------
> >  1 file changed, 15 insertions(+), 9 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 36b40bc9ac25..13736cbb2c19 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -2290,17 +2290,23 @@ int dissolve_free_huge_page(struct page *page)
> >  		 * need to adjust max_huge_pages if the page is not freed.
> >  		 * Attempt to allocate vmemmmap here so that we can take
> >  		 * appropriate action on failure.
> > +		 *
> > +		 * The folio_test_hugetlb check here is because
> > +		 * remove_hugetlb_folio will clear hugetlb folio flag for
> > +		 * non-vmemmap optimized hugetlb folios.
> >  		 */
> > -		rc = hugetlb_vmemmap_restore(h, &folio->page);
> > -		if (!rc) {
> > -			update_and_free_hugetlb_folio(h, folio, false);
> > -		} else {
> > -			spin_lock_irq(&hugetlb_lock);
> > -			add_hugetlb_folio(h, folio, false);
> > -			h->max_huge_pages++;
> > -			spin_unlock_irq(&hugetlb_lock);
> > -		}
> > +		if (folio_test_hugetlb(folio)) {
> > +			rc = hugetlb_vmemmap_restore(h, &folio->page);
> > +			if (rc) {
> > +				spin_lock_irq(&hugetlb_lock);
> > +				add_hugetlb_folio(h, folio, false);
> > +				h->max_huge_pages++;
> > +				goto out;
> > +			}
> > +		} else
> > +			rc = 0;
> >  
> > +		update_and_free_hugetlb_folio(h, folio, false);
> >  		return rc;
> >  	}
> >  out:
> > -- 
> > 2.41.0
