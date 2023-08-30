Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD5F78E286
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242627AbjH3WsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjH3WsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:48:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A68E47
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:48:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UInxMm013293;
        Wed, 30 Aug 2023 22:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=KBQbk8kIN2CyXuc3CnsaVycCRSOsTF+DDnbEuGdrtjQ=;
 b=iaFI2Djur4kDfL8O8XYKHidVBC0YD/ba1FOQrKG1GzRN+RL3eYsx9agJbXSJEm0sQlN7
 UvutO9tjK7o6lN/jzef0heeLLy9Ryx5z+m8SMTI/X5Upqnq8BaSu90y7YxoLks9Ov4Vb
 1wMcL0o34yX7EpPuusLh2UaefgwvY7e3YT4fheC/RV6REB+1lQ+yjWlwMJUfKykIAKpa
 YI3d2d85g0I4p2Q4+Cp11cnNDIM8FGMRDUQl9XDMhZteGTufVpUBgujXBuqMbe+P79L8
 Rc5wuOThTEzhV8rXfVtgINVrFZYmieum++li9dSWv99u+8Nw/+Iu9CLXdBqksYkfQ1xw NA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9mcrjns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 22:47:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UM3Ghx014367;
        Wed, 30 Aug 2023 22:47:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6hq6c7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 22:47:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiYdDgDqcNwKeolU2tofhhvqASHTniBpLrgZepwjcwYIazgzl1JufehhMGpM7nDSclZ5sNGXZ7+Eab6dMLnuLoS13vLN3mCeXAEumz4V8xvK6wYQ6UJMfhGo4H/9vllRQFfvqo5WdqTRwRdIH5KshrLDQh6hVG2fV06C+6QrNpUXdAuDvbKUm4iCrBepR9yf5eJu+5DCWMP8S9f8a30kUeESVvMxyicIdHUNO5FUa/jOWllLJQ2zvKtUnlARYIGURvKfa9JjZYAPISWzJ1fDkEfnVCKqtBays4yUjQ9F9ihNplcO3NJxIqqJWz5RyvPWY1AQlbPcrw0cdJbFy9akdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBQbk8kIN2CyXuc3CnsaVycCRSOsTF+DDnbEuGdrtjQ=;
 b=nZ5/y6vQM3MDCxd3rvfhWxNHOPp0+4HPfP/EQT7XVJhtkdJXAhYthPu9CQjFmqtyvVKzyUT5ULDUedy5h68PL2qdFylSJ8xrmOnzsBwVFEXKLj/TjiA2vbwZq0HL7I1RmBUHYvUHKpOeeUtg84Sj0OhJ5Ei66Vwy9Uiwnhz/brq3Wkj/nq++rYhVGxQNFch0+4nYoVgQeS91yaMkxJ8u92DyVDEBdqk3fkcNz16G47CjaIYieefWPKdYv2sKX3PR/Co7XNBkkhNt1lp1WTLuTmOabdWAANXE0FgFtj7BbYLS27qIwQpxFiQoaV0y2xrriVw/WO6WgiV2w9mfUSGnpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBQbk8kIN2CyXuc3CnsaVycCRSOsTF+DDnbEuGdrtjQ=;
 b=w+jLUQDlct6h0wkTvmC6eUAJYaSo9mqbIFxzphDEHlduiYoyaNKOg0EPN3MJ0CXoxIh7FUivCYVOArAcoEDEvfsUIJu8v3HGBdsVWg7cIf6CWxTbvz8RxqDHzqIikSB+HmMPUFxricsiNxtGvaCOjxNgRF3FPs5aFCYvnIiuYyA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5083.namprd10.prod.outlook.com (2603:10b6:610:dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 22:47:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 22:47:09 +0000
Date:   Wed, 30 Aug 2023 15:47:06 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 09/12] hugetlb_vmemmap: Optimistically set Optimized flag
Message-ID: <20230830224706.GC55006@monkey>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
 <20230825190436.55045-10-mike.kravetz@oracle.com>
 <8e298c9f-1ef3-5c99-d7b5-47fd6703cf83@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e298c9f-1ef3-5c99-d7b5-47fd6703cf83@linux.dev>
X-ClientProxiedBy: MW4PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:303:b4::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH0PR10MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8e4949-cb3c-42df-c8d8-08dba9ab0af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXF6vjTwGBgw4YX8SmboxZMrG4a6HWlxfNiYt8X97nuQYCNXjbi3BXfCe/UXtarxRDjSP2kGQbsgDs4beyLL0JNk5rm2q29ArKNr6PqhuNC90O269EA4xlkPsiC7OygyGYUmEqn8sejYKniCS0X0JtjJewrmxY4epQGPVN84fGrn7VGw4iQZad3ITXpJ7uo8gYotZkSLLABO69fboYM0p/6BBCPDYKkZnZwIBbmAzbEKaFeaPA9sc9EtrPRX4cSGqUU9iz+rvNZ/fwqmkoZV0MJv9iVreD7Co95+Pm8UK25Ns54AIJcuLtCFd9IjypQ9815gYBW4H7xm6rRJIisrl2EVPQtbvmsAf0SpEYddfDgCbsP9GYCuHNBedQDscCk719xWcN04b9JZRngHaeCEyWox4g/y+ud7sjIw6/sE6bcBVOhSjnaTpxCB1uoKKjeNgxHhK7O4RvVAXWAg/VYnyaQ6lJaEnkA+7I1z91ysY5Gc73T16ZVBr8C0EDt56VKTvgKeZUHeAA9YKkdH7gCL4T15XUQu3ViVSHYuSthPY2J1eCBK1cLMQVQXAOttN7IJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(366004)(346002)(376002)(136003)(1800799009)(451199024)(186009)(33716001)(33656002)(7416002)(83380400001)(86362001)(5660300002)(41300700001)(44832011)(4326008)(8936002)(8676002)(6506007)(26005)(6666004)(1076003)(6486002)(53546011)(9686003)(6512007)(38100700002)(478600001)(2906002)(6916009)(66556008)(54906003)(316002)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W1XW+NOd0SY3GQfTYEKIeCSU/cyuIl1lMpG+QH1Lz9p7yHc7o46iCbyJgu2S?=
 =?us-ascii?Q?cycWiesB37MKVIBdviiXVYL9DyVXS7uuNXfFws1FiwJ6I6NkptaaZY/DuyiZ?=
 =?us-ascii?Q?3UfWyX8jyeDDf6rDgG+PNr2CLZgtIw+uzyqOiK33lqiGiWR357INPQiZd8jV?=
 =?us-ascii?Q?H03tBSPuTOj4LDoH58fjfmKptN2G19i6XK7DEu7hgXUEjX0bQ/1WFaDxPXgD?=
 =?us-ascii?Q?h/l3QYrffx7Dt7H1RIOMN5Kj5CN3bVPYClJtxdw0wAJqrbQQn1uXfF+zEJYI?=
 =?us-ascii?Q?c70SNu84Nye94eTzQzYRmUXNuSrvc3Nku1hPbM5M3XddhPiTpmTCURfCXdKQ?=
 =?us-ascii?Q?RlJRaoVGqbLhTjzX3l6IxhIBCz24aJXeio/1+gNLE0i517jx19r7oAxPKoXT?=
 =?us-ascii?Q?qgWy0CgCdN8/sChKDrbFV6B/p8K5jFFmocuXQkWCe9dphfIHFv0rVWPLML0X?=
 =?us-ascii?Q?43frIoKPY5M4lGrJHX1hgDoF2dfrrskeUKRjxJRTlbqDxh+n6SRI3jvOWvjf?=
 =?us-ascii?Q?EdTLrsbqrL+1Y8kNFGlXVefIWAwLgNuvPiS94qJjlbfzdNINcymHUw5BVoyc?=
 =?us-ascii?Q?pp67zyac15n4uS48UbaQOoQhXNLFA5/YplopyM+EEnNf4SLhhIQnpzxe2/xZ?=
 =?us-ascii?Q?rRIg2MMYacQ7PmOMMiXKPnZIm/6h1Q7sO/Qgl54LmaqBUgDka0TAeAgsfjGx?=
 =?us-ascii?Q?hkLUFQeajxX5QGJeVM5y5nV/NK0Q8ufT9QlDoSmYfAHcuXgRmg/PiEZmQqn1?=
 =?us-ascii?Q?n8IwKGBxq2Fa/LyLy3Bs8+zeLdfykImfRnuxSp1kuz5YMxbasDouC1hISR8g?=
 =?us-ascii?Q?7VgRm2nwJ9v1EIAeAi4+LkIsNjN3o35zkETI2XAQJX0bjba/hQPScQJ1SFK0?=
 =?us-ascii?Q?HdIpfsFNE+YVW0YOrGvDer+goSrHPrpYRK5G4qTp2yuLfrQmNMz2IpnXgLJH?=
 =?us-ascii?Q?LW0goidVYoiYgOANUW/GLBA9/0SX6fn6n/WAAguhSGHgyqXFqREiSsKBXGe9?=
 =?us-ascii?Q?qFfp+zdI/K4B62x/DyTqWHjrZ7bkt7iJdfHct49sWOz+h2gbwQTfr50aPuUI?=
 =?us-ascii?Q?OhIKJjUkdsziTCAcuM2/HaEor+6pPo5kx+wt2Gq3WFlYOmkgg7TQzv96QGHa?=
 =?us-ascii?Q?+DUXaE60k8Q0s99nZhU7317njdFfPVtxv08Rr48mC6elBibCJVKRrHF9+53e?=
 =?us-ascii?Q?/GoMtHup6ZC2MiUpHnsJcC2nTF4B/BPNx+XmCif6UI7AlhUzWatLKMra1+nL?=
 =?us-ascii?Q?w0P0Zj5TIUErOJU2MGxSsbp11UsnW7E3DhkRRA8xP5agK+UAPniuYEBJcXfu?=
 =?us-ascii?Q?N8GbY5xwpZFFGs3JSPtewfjV/TVs932QnDr4kBTU8XZHLjbWz5KMW/uEAep5?=
 =?us-ascii?Q?YH/SuY9FDEw0FVWgJy6RWlOn7W7CtOLMtWKRY/enImUJf5Xa2aC9Y1UiN4e+?=
 =?us-ascii?Q?1Kdawo5MTuuMk0GP3+dcKalrG8ix4fG1+QAJVOUXUR3Hl7m6sEBWLTlgRLQ+?=
 =?us-ascii?Q?023I/R02FaRuHBpDdP1ZpGEYGPI+kOExnSWbxODngIlwPU2FalXIEJN2I9T7?=
 =?us-ascii?Q?2hi1zCbnGeFP6i3J2u687cNBoPD8zjxEuZFr+KLY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?iJhzYGSgobBpqSJ4eaA2u+bNLijj2PQO+PIDZoA6hiIlos0V3KVb0zMr354C?=
 =?us-ascii?Q?iXB4TgdYRfpOd1+gdNt4gwm/GiSw7paWCgcNaNO1sJQgqBrC3CslfT+wF3GM?=
 =?us-ascii?Q?8ERLnsoC56YSInObahlYd+JphukJqK+jh2nW8uFAvngds4MNYid48rAbVpBo?=
 =?us-ascii?Q?4Otf+3EQeyQl+WZ9GIo557TFOb966fxQOMjGItOtwmaZHAvJEVEe9K/UcAFc?=
 =?us-ascii?Q?b4hX8nTnifOyood8y2urLyj5bVz6lOwfD3nWOZ+oA3Vu4myiB4L7gnejr+tT?=
 =?us-ascii?Q?Xw3pNrXSu5kJpHArbN71D4wmjZdpH0pvfW4PdDUWjgl7xTZEzBA2twx5utNo?=
 =?us-ascii?Q?pnyIIM2kFVcz8yybxWpG7G8wJWl/JTYwp8USQFUHgapRGQPrA94tJQxSgigV?=
 =?us-ascii?Q?bswZnRcia5pTcsdPz2Pr/3CAn0kOtmmUOIT+AvG/m/E8xyoFGWCyJkgdAFSi?=
 =?us-ascii?Q?a+2f0I0YzYQZb6g/ku+bz4QosFPP76IBL4zsSjcp69AQWOZ7vksKkivj9ltU?=
 =?us-ascii?Q?6fp8PHzVqUbTY6Da1vVbLX7WKD4eIIfcn3krQu/v4OGw8QNXM38uw7YFUKwF?=
 =?us-ascii?Q?wHMQGIsvIs7KWii9rChK1RfyJSVYiIdWBsAmV3W/M0P2kn/zaCXjGsNfRUB8?=
 =?us-ascii?Q?bWaFrjImYV5digRPXBpaHi47WRN6rc8M30oxxjKygNhfGmMqlPMYMyjaB7XF?=
 =?us-ascii?Q?qkwZgy0uU9GVk3+mIr5bo9bz+5qO9tIhzf6yNRq0ksZNWolPv8xv7+TZaic+?=
 =?us-ascii?Q?YQ0D+qR+DrDOcDP0sn2igWDCJnJAUiqlC5ZqjNG/CKqZUzGyXARvRcqT8uXi?=
 =?us-ascii?Q?bcMb+X1yF9NoDx93D4i465B+XRwpVSaf1RMQnzJOKviAwQnU+7VLzGlvY/kt?=
 =?us-ascii?Q?1FQiUYu0/zVecWDLqI4ojHBMuXdEhXXyQmSrBhQkMa4T7aqc7w3cvqZCPzwQ?=
 =?us-ascii?Q?GwiCDJQKPVFx8MXsn6y1MsftEy+tIc7AVzTCcEp24eXaO0PwEgDQLTZp9hmI?=
 =?us-ascii?Q?buzisWwG0UZduDkfn5JjOLU/S5BiqXw9yZxjrzdU+stD/E3jt9qiBIfe1tYf?=
 =?us-ascii?Q?csATZ+q0k3W3B4Pjl/Z9cYqMMaKcwGR0M83WNNpa/oN55CCcehzNpElaiAPj?=
 =?us-ascii?Q?vjy6H2p/aVmj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8e4949-cb3c-42df-c8d8-08dba9ab0af9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 22:47:09.4651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hj8LRRS0EPBU5yt/B7wIbhWB4+bQX8GFh8Zn9mZ6pIEnA8A7kVuYbQywQAQswS8hNf+6dboT8QNSOciARrA8qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5083
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_18,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300206
X-Proofpoint-ORIG-GUID: CiD_4GHkP-T2_7qCUFijuPoWyMyBi4Ft
X-Proofpoint-GUID: CiD_4GHkP-T2_7qCUFijuPoWyMyBi4Ft
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/23 15:26, Muchun Song wrote:
> 
> 
> On 2023/8/26 03:04, Mike Kravetz wrote:
> > At the beginning of hugetlb_vmemmap_optimize, optimistically set
> > the HPageVmemmapOptimized flag in the head page.  Clear the flag
> > if the operation fails.
> > 
> > No change in behavior.  However, this will become important in
> > subsequent patches where we batch delay TLB flushing.  We need to
> > make sure the content in the old and new vmemmap pages are the same.
> 
> Sorry, I didn't get the point here. Could you elaborate it?
> 

Sorry, this really could use a better explanation.

> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >   mm/hugetlb_vmemmap.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index e390170c0887..500a118915ff 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -566,7 +566,9 @@ static void __hugetlb_vmemmap_optimize(const struct hstate *h,
> >   	if (!vmemmap_should_optimize(h, head))
> >   		return;
> > +	/* Optimistically assume success */
> >   	static_branch_inc(&hugetlb_optimize_vmemmap_key);
> > +	SetHPageVmemmapOptimized(head);
> >   	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
> >   	vmemmap_reuse	= vmemmap_start;
> > @@ -577,10 +579,10 @@ static void __hugetlb_vmemmap_optimize(const struct hstate *h,
> >   	 * to the page which @vmemmap_reuse is mapped to, then free the pages
> >   	 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
> >   	 */
> > -	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, bulk_pages))
> > +	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, bulk_pages)) {
> >   		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> > -	else
> > -		SetHPageVmemmapOptimized(head);
> > +		ClearHPageVmemmapOptimized(head);
> > +	}

Consider the case where we have successfully remapped vmemmap AND
- we have replaced the page table page (pte page) containing the struct
  page of the hugetlb head page.  Joao's commit 11aad2631bf7
  'mm/hugetlb_vmemmap: remap head page to newly allocated page'.
- we have NOT flushed the TLB after remapping due to batching the
  operations before flush.

In this case, it is possible that the old head page is still in the TLB
and caches and SetHPageVmemmapOptimized(head) will actually set the flag
in the old pte page.  We then have an optimized hugetlb page without the
HPageVmemmapOptimized flag set.  When developing this series, we
experienced various BUGs as a result of this situation.

In the case of an error during optimization, we do a TLB flush so if
we need to clear the flag we will write to the correct pte page.

Hope that makes sense.

I add an explanation like this to the commit message and perhaps put
this closer to/or squash with the patch that batches operations before
flushing TLB.
-- 
Mike Kravetz

> >   }
> >   /**
> 
