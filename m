Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F397BB06C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjJFDJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 23:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjJFDJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:09:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8321D6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 20:09:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3962P8rE021597;
        Fri, 6 Oct 2023 03:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=KBT8BWrDNMkbHx+WgIwyBrzMw4Ilt7iw9eRmwwyKJ9s=;
 b=VO8eYYtMVgKRyFH6uaOna+4LRoSuZ2xo5w7YEzTZZpZM4+gCo7S8UI9HTQk3Un351Mib
 Rs4cUIVw37dJEDZ/DmyeANo3s6NOWsKvFL//3/+IBactk4BTa52Lb/D2adyOxykvozpU
 LA5W+wqKVJwz7xkw5FY4MPYEx7zkOYR6p+Zcsiq7oXpJfx+Zx/NNCwL6TZeqvr7l9ZSI
 Gqd81mCUi/fCwQwwSROyvMB0PhhmVFPzihMyNwEcdOJd4m0yV/1OgU3EmzIXaCI93jO9
 RLs+e4h0zqEg+UYGG4GYZ8PSnRJjaqO3DjWmicuGp4Se9jCa0NySn3Q13Xy9/adm8MGS zQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vjwf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:08:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3960aFLJ000353;
        Fri, 6 Oct 2023 03:08:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49xnut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:08:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki55v0vsbxg41Jeg2F2Z5x5hYnO+UTlzDEbjuAS8KM23poTRdnQ2nS9AmkFcpMeWroITXICR26S0OSMUtfMrm6EWQb/HZboz+7B5NWxsOjRZ3TqcoRvM/m1nBrK3oO5FGtvWrCnrUWhSTEd1NcU11iKSuN8XF12QSSeMh0KwoF//AC54LRVrHytJ3/8+0V4Qn8FMpp8cnjpJYw/rGwtl9V37pEjRZSM0QG/4MWtW8eh4PDxMHhNQui7+gzUPsdZ5OEP4LxI95lUU4KV1jeKEX8fK9XVVy0458FGU+G7zRmnLecXtFeecbljyn0mnA8BuqTBjEhEbb9n2K5uYKtnhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBT8BWrDNMkbHx+WgIwyBrzMw4Ilt7iw9eRmwwyKJ9s=;
 b=FXKw182LD3jGXAkcEnIcReI/bot8ej+KW9c+ih7uok10+wCq8oE58YYaFtAkY44KAfXHkKdXKhpjrk40zFJMMzrCE/B3RWzsRfP6VKmSrH5IBNC4fBep0Py/mKv5O266ueJ6MdIErv4xbHSAhqSawVdEjOOC2GnPvrL7/s4CBTj6lpMZzwov9xllJTgPgPVfAqT2NL3MocGUykOedRSkZ+4V6Mlz0NIvVsySYyVBpcd8CKW7siZfU8GRJLYbfRNVh1TpfGMbuEhfGcwv9xyzW1AoQScmWbM46HdctfiF/u4W1A/IUO6JEdPPrjxOjFJ3vbgW7NDBtO7F98QrhdpBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBT8BWrDNMkbHx+WgIwyBrzMw4Ilt7iw9eRmwwyKJ9s=;
 b=I3jINhO/pWJ2u2pUbduh6qBALk7Q9RwrMzs4cLFI16uajY+Kl+1qAkbWYx9FdAMwAwSO/c6DII7sUmslc9wrj4LvWlcLcT4RqQy0tMyeaXg/obmRh38QmrVOtspZGC2aPL8OQtHQkjTvrKeCd1aLq2fteCjfp0idJmXGeuN9oro=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4179.namprd10.prod.outlook.com (2603:10b6:a03:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 03:08:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 03:08:40 +0000
Date:   Thu, 5 Oct 2023 20:08:36 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Barry Song <21cnbao@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Message-ID: <20231006030836.GC86415@monkey>
References: <20230925234837.86786-3-mike.kravetz@oracle.com>
 <ddc10c41-515f-48c9-966d-4ae7756d208c@kernel.org>
 <20230929205731.GA10357@monkey>
 <ba5a528d-7e85-77a2-5096-5a143a3b1606@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba5a528d-7e85-77a2-5096-5a143a3b1606@linaro.org>
X-ClientProxiedBy: MW4PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:303:8f::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BY5PR10MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5d7dc2-4cdc-4afb-7e55-08dbc6198a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9c80W+iqYZ78P9rojbjyZZXaSXnxjo1G7pl9XpqDW2lvER/MvudmTFXe69FUwe5NdrUrzbhAOpzrczouBNc6g+MmH8NIo8YcQ7TktnRsce5xQvYrba3lXDdOVk12PHM0Acy1lQ7rkPogsa6K3Ag/ViasQ+LOn50txgkKw3bK1NWs5jIOkgdkKzSSM0M33Z9Aawuj50qG/s1sXrrWBcdHAOp2/JsrideBwRggNyXsbKmrNV73eHf+Jb5euCw/eBUdSUg9JTKc1rZ2YraRmpRIG5IyYwz56/D48JkV1rUHTefVpI+SLiJ5Lll1g0PAG+ymdH0YYjyG213+x3D7uLzKfKyLHEQ/2np1p1SgJYrXR8souQHgQ3mZDN48OT57uw/+FyirIUjSiTf+2SD0197uGpvzgm68uO/wt9oDJUnIGFEWT4P6xB5Vv2f467fGjGXseHLHIOjOyTuwT1yY8n6u1c49VwDRl7mDxZG5hAQK4vaQ5jv5Fy7R5oeWCzl6dHkJnZ+pwjD15xlzGSgDCjqz1eSc8/VV6zSLQy3Zky4Hbjxcixo4cxTm7ZJzdKGfG9q0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(9686003)(6666004)(6506007)(53546011)(6512007)(6486002)(478600001)(26005)(83380400001)(1076003)(316002)(33716001)(7416002)(44832011)(110136005)(66946007)(8936002)(4326008)(41300700001)(8676002)(54906003)(66476007)(5660300002)(66556008)(33656002)(2906002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9otqYycCb9QQEDHviLeWwAMHJOzfBfnw1DszEidX4Vu1uirop4L5YdjwActc?=
 =?us-ascii?Q?twFpgRebLjMYbomZmcnCOvT8iqmg1l86Rq0HNg0GG5BLifhA9g3OptAX0o1E?=
 =?us-ascii?Q?/fVlgql/8q0u4ooWQHbK17Dg+bocz+tadcUyUMfIiE+Y4LA7wiRVNEv79NoI?=
 =?us-ascii?Q?wZDjl+ONZ7APpmiD7S0IiCAaXuWegaBUQSR17iqAmXKIWp4COElSkNT/WeCc?=
 =?us-ascii?Q?FdYJnJ6t50Dpjx08rEg/3ZYnx0G9VY+jktQSImEcCWZ0MWM1SBfypyLqi/eC?=
 =?us-ascii?Q?LyCAEfXrdscQ9zDKjPcFS2cpQqwq18PQu9p5nsxmfyTXQZ2mMfuyuYmrdTfl?=
 =?us-ascii?Q?QeCR74J9QJ92/4oYBncXXU0MICTJIyDfrGTvIX0c3OEiNqBFjYfTqDW5tRzh?=
 =?us-ascii?Q?uv0UKYTvGcaGdqNaEW+S32mhJkjMpYNFrwsQ5zL1i6VHUyHhSxDB/SyIo69E?=
 =?us-ascii?Q?eKHQ1usUuaDAUg70UCgO7Qw3pv6NKi/6JgHBEQwG0lg25GSctcb6su0/+CLN?=
 =?us-ascii?Q?Cu01e2x9isSS+s1tv55/Se/HKgC/brUY9+zXLefjPkFTLCP+ZNgysaw/73Eu?=
 =?us-ascii?Q?JkjDOLBCpLOqLdAS5TVt3xFMgERTDHUBh9CNIKvLBEg1+z7zMoW8bwQ3b53d?=
 =?us-ascii?Q?mmLwN3gWLtOvMTbOHPusqbbKngJpbqaOiE9u8hGJznLti38YsVYACXfZGaUe?=
 =?us-ascii?Q?f1KHxNhpeDcud1uZAjKrY0G8tp3j0JhVWwgGlVIa5WlbD+1DKY9zk5lRG9Ll?=
 =?us-ascii?Q?u60B2o0kn2NPIyjir1+UoTVCgMu1bFH7XbA0sybZL8OcyOEOXfimVuWJM/x7?=
 =?us-ascii?Q?s7DDhPaDeR4d+uWJKnnpJcpFrBamWH/acBD/LwdOdLGf1PO5HrHKL8j3buXu?=
 =?us-ascii?Q?D2mmP2dvdNPg8+TAy4+MLjKtHhJydUPEoPfNDP8F+gqpUXF7WyxJGmrAlUOZ?=
 =?us-ascii?Q?UEDJmrhSB945IW2DIQoUpUrhCWWn1YgwHH4L+7aa9+Zd313NWtbIzREpGaEF?=
 =?us-ascii?Q?2jEQFV7tzescf6t27vaggo6jo0rqPJhJF1lhpc9IwNNniVMJzPtSekXqMzCk?=
 =?us-ascii?Q?OQmuKLcA/v1YBuDJdputy6ZHlNw89nNlhr1oV54wFm4kUroz/LNKTu+4hS5G?=
 =?us-ascii?Q?1Z11kzqKSmTLootAlccbApPbd/HfF0qFY3C2nPv3Ilc7icriOOcbnqEVyCRW?=
 =?us-ascii?Q?NT7TyclcATZmyJ412PX8DUDhfPfYUaQh3g1DTcSGIM2oPCbsbp5lovS0/P0v?=
 =?us-ascii?Q?OBCtYPE5hTptPr/HJKJ2hDCYhJa9LqlRmXZB+cFSgpWjQQF9ZpI+fWfNW3bz?=
 =?us-ascii?Q?QQ3Cp4vdCIvSNA/N2cyq0J11Fq+smDtkek6E0oB1uS8UtxZtHbLkixWQrFqd?=
 =?us-ascii?Q?sn5E1BkKdJJdGbEgcvsHhV1Wq5cozF/9O6QR6GI0sCE3POJmAaYybAecP0xE?=
 =?us-ascii?Q?zJccwcRhs13nVl2F2KQnVvK6QJuKkzocH36MtknD5a5Y0wzk3Dlm+aPe7HyV?=
 =?us-ascii?Q?T8FWzNnPKLH8+PcNnY+8d4FQS/1blnMPziDTEu48X3BqsajeN+TJbcxXI0Ja?=
 =?us-ascii?Q?QQq1jhMCoyWdUD+X5jIvfiufpW1MtrH9Bs2RtMpr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?J8y81FduIxxJsEb5m4BtDwNj86h133jAbvF8LBDUiH0sce4IkWtt2haExpfB?=
 =?us-ascii?Q?hsnFsGAyHpqOmRu+/qR3HgQ+vNsVVkh0VNEkDNhhcu48vRMBBdEfhGf3NuuZ?=
 =?us-ascii?Q?GGxeY77iJhY7m0ifVFrODdNcZ00i3HIKJ7m2saxz/X9GC6aqqC2PIrD11Ji4?=
 =?us-ascii?Q?SL5jHhePvHsDnqIbJ07NIXSiaypyOViuYE2w0AcH5CbIMk2TUry1YdRcr5Hq?=
 =?us-ascii?Q?luXppLKk+XIR8b1MjAEGic570N7uLM/UvJyy3HeLL5WqMR7kCN0I5ZqNsdR5?=
 =?us-ascii?Q?mEa6+xOOmq7h1ipAMzE4TKR30Gt0POLjHzK+56bXMjot1DTEcRjHNnKVbIsb?=
 =?us-ascii?Q?3tErCLH0mEvjP/cCml4hIlKcLGqm0SK7yOOBGd6vvdWkFTQ9H7pZgklyyfwE?=
 =?us-ascii?Q?x7nNAZXEgD3ONnZ7AO5pRbpwkBzAGSLiZST73/BFaVBCIkaTf+vLrrOlpdkU?=
 =?us-ascii?Q?5N9q7lhilKq6jNYMybB7NeoAta+wGlGyqDrdVjWKgzn8cE8B+UlRwjzhC7jy?=
 =?us-ascii?Q?UjcT+f5SYrkia16MKknFCjq57wrlUxQgmcHONUNSbya+77847IeZkJmkHF/t?=
 =?us-ascii?Q?aJtxTbYjj36XUMl1CpvQhP9YGv15AZsqVGIxhWunq06yCgFuDzsHLAvlrBOI?=
 =?us-ascii?Q?SaHQbzqxHbg8nKBfHXrrfTKDL27CqsPKQo9patiQzyXEA94D/LRahXYKPxBW?=
 =?us-ascii?Q?byGVQEco/nSMp+wMb1JDTXZc9G3A0nBcCj+DhH9gDUilGtjSPw1xyJF0szvB?=
 =?us-ascii?Q?EPzgjwTHXpojgaLgbFfRdLfq3zIKQEXJzXqegy/9/1Q/NpR+OCAb3s5O1HU+?=
 =?us-ascii?Q?TebclTyAwwXnCYlbLkag49+Y6FDn1MYuP4YDmoajHgvstohWTv6+xB5WgY4h?=
 =?us-ascii?Q?0D64pBiG6/NTo3fqjJJYb/Yg8o9Ck7AYVQJS+xy41/fX0Jo91bAl6sgm2jVX?=
 =?us-ascii?Q?Z7xEY307XpA2Yx7DG/PWy09heX7RPo8wBrHyUq94sVeT1q/CHHD7uCV/H8lf?=
 =?us-ascii?Q?mRt+jcx5EySlfou62WRFCb8naMWMUF7TmqFe0nq+PGwz+4sUgNg8//AkBr+Z?=
 =?us-ascii?Q?PqLLZFPNW6D87sM4A8x2I1qX/fM3nXWVb+8HArvyp+iGu2TMr8uv12nUP1iA?=
 =?us-ascii?Q?rvGuXKxDauwmNl+YLYIX0M1joUJYmHewcw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5d7dc2-4cdc-4afb-7e55-08dbc6198a5c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 03:08:40.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIFw07hg1XuLZOey5yS2IbKtsYPbz2qEODKLWIbmhFejNqZS1nNdxIopDVesGlZQStA/N+/6GHe4GGK6fiIF9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_18,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060023
X-Proofpoint-ORIG-GUID: T4Y_jGDZ47U-xel1NDkSvHLuiVGC_HlF
X-Proofpoint-GUID: T4Y_jGDZ47U-xel1NDkSvHLuiVGC_HlF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/23 11:57, Konrad Dybcio wrote:
> 
> 
> On 9/29/23 22:57, Mike Kravetz wrote:
> > On 09/27/23 13:26, Konrad Dybcio wrote:
> > > 
> > > 
> > > On 26.09.2023 01:48, Mike Kravetz wrote:
> > > > Allocation of a hugetlb page for the hugetlb pool is done by the routine
> > > > alloc_pool_huge_page.  This routine will allocate contiguous pages from
> > > > a low level allocator, prep the pages for usage as a hugetlb page and
> > > > then add the resulting hugetlb page to the pool.
> > > > 
> > > > In the 'prep' stage, optional vmemmap optimization is done.  For
> > > > performance reasons we want to perform vmemmap optimization on multiple
> > > > hugetlb pages at once.  To do this, restructure the hugetlb pool
> > > > allocation code such that vmemmap optimization can be isolated and later
> > > > batched.
> > > > 
> > > > The code to allocate hugetlb pages from bootmem was also modified to
> > > > allow batching.
> > > > 
> > > > No functional changes, only code restructure.
> > > > 
> > > > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > > > Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > > Hi, looks like this patch prevents today's next from booting
> > > on at least one Qualcomm ARM64 platform. Reverting it makes
> > > the device boot again.
> > 
> > Can you share the config used and any other specific information such as
> > kernel command line.
> Later this week.

As mentioned, I have been unable to reproduce on arm64 platforms I can
access.  I have tried various config and boot options.  While doing so,
I came across one issue impacting kernels compiled without
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP defined.  This is not something
that would prevent booting.

I will send out an updated version series in the hope that any other
issues may be discovered.
-- 
Mike Kravetz
