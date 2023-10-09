Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC8D7BE465
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376414AbjJIPRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346619AbjJIPQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:16:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE98CA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:16:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399EYpFZ030770;
        Mon, 9 Oct 2023 15:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=/v1aL46TSJoKRnoNGRosDya9pqvfKQxHRCnOQ4etvLY=;
 b=2SiE+/bHO3VgXq3PnZJVQwWfOhMfGqBeA0gc6oVwzLd+o8RQyRr5cvOuHou3YuV3Xvek
 5WwaFhRB+lqfRRHtlVhdLrRvadasj3ifyWS0hsvB+L2pftYcYuvncY7UmmUa7/dP2jwq
 AxxYck2ZWBITSAE9/12gq3sdmrQNw62kcJ3gQ6VBF/eObyAVgmWbZOYO37bXTNzxx6YC
 WKfPwZs+iTq19P11vOw5j5jy1blzLSDtKUVbJ0wWK94+/kEhVHdnvOwndEQ1RnFaDmsH
 jDP3w7MnQP8DEoiSQJYrfsgz4egT7i9S/yMpA0sr/tYbx+Vy1panYuRDtYSiDfCsbtYK gw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjwx23179-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 15:15:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 399Elck4016404;
        Mon, 9 Oct 2023 15:15:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws581je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 15:15:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpLah8qvc2ACo/IWIBcmm+ZgfIwfi0lnlBy2zIpnVqNWd40/7YYJfj8o7j3c25ue8+o837eiybqBM6lKvhXT5gWq2l7EU373bu7CFuIOPJjPdiWzv8UfVqfvMcKUMNEVyQIpjOkcycv8D2sewlEWwH1yuM1Cl/k5Zds1OQd/GzK9/d36dUAcYfE5DA6NZkgJeXTl9RGTbsogpemqfxbE7uj8EGpvBu9Spcno6v+SfdqkHODHUB6GV20nncaaUnN1Omcla/kZMhOjNEzuarU/Y5yHRQYcXslLKiW1r8NGukW0Jmmj33L/xZOY9nTUAExXow9/rY39GAojRTQRx9gi9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/v1aL46TSJoKRnoNGRosDya9pqvfKQxHRCnOQ4etvLY=;
 b=Z71UEyszUZuWP+5OHMYkNag2h8QXafFxWVpKvaVWoW22tagwDOpzhWlxnt9U5FJG1litY7HHNUeBypL7nqfH6P6mEas74/TErwWOr5u6Iqb9YGfwYoJM/fWYNTl88Wri4vg4QWViGr+vv4kj9/qVwLAdM4S1GuqCmlGLyggGpHGxr5ffkwmUJ3cq2ZO6PIWwEtDAeA3jmpZi8WK604iZwavV6vURSIETvQ76lAyBjoGvVbD7RuXWWCv/dDiCJFC3BrQ9uLyoNT1G7Y6F4GSe1g2a+MlirM15pPkzRnar0CHeyaO9MIj6fmIVODHo2iqqT8OahOnHUBF0xwdRXTaWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v1aL46TSJoKRnoNGRosDya9pqvfKQxHRCnOQ4etvLY=;
 b=ErftO/H4qXvUxsObHzF340sMMVMBpgyAZR7ylmwUeLuu/a+rkI0uhbd9VNMvBmX0TimLLM3cHs6fgzx0SNNTwST7zeeSLaHOk0xzJHnB9Y84YvG3GJBlrluLy0GKdSOi7lTxsHj1TAM4kVa5R4NfolyzJwY0Yo8YcHjxXh5NaoA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5703.namprd10.prod.outlook.com (2603:10b6:303:18d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Mon, 9 Oct
 2023 15:15:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 15:15:17 +0000
Date:   Mon, 9 Oct 2023 08:15:13 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20231009151513.GB3846@monkey>
References: <20230925234837.86786-3-mike.kravetz@oracle.com>
 <ddc10c41-515f-48c9-966d-4ae7756d208c@kernel.org>
 <20230929205731.GA10357@monkey>
 <ba5a528d-7e85-77a2-5096-5a143a3b1606@linaro.org>
 <20231006030836.GC86415@monkey>
 <5d14b681-a2c9-4210-a0c1-bf38708b7998@linaro.org>
 <20231006223512.GC3861@monkey>
 <20231009032926.GA3376@monkey>
 <070bd916-d4d6-41c2-9f51-af35e80c96b9@linaro.org>
 <20231009150401.GA3846@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009150401.GA3846@monkey>
X-ClientProxiedBy: CH5P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5703:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9d910e-c126-4e94-45e8-08dbc8da8b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGXOrpk2PddSoD+eKr7c863s/y8jgxDjJMh1FLJFc/vgzPqZQtT0R3DL2A6mvgqrWdEEhsT4Fk2VsxEv40MWGHQSNRqenmQiqMYghXLEHka8fFDYWna/SXiSVeCZferLV7ed0EqccOzWPyc1d+TObDf6hxQ87b7l7Tiy2oomukgr2Fm2cen6pJKDpK85EPa9j6JHinP/maPdo10SfkRJgXwTT+XNXEhUbtrBw5XcAuFJzei1Y3O5EGUDBiWDB1ZGFetQc0exrNjoNyjgBAS5smnpiQ1r8MXnBdd5fw75g/zqCmE3xf1wCiS79XSkd/8SqSPI3Poxdbk4M8JWF8t2NLjxFZqkEg/4UeQYL+hzuB0t3Zam5Zwpujzfb1REZnlqk6r6cfM8lMVWVpOmlZGl1GAZvMPcJ1cS1u1rkUK8Th7lq5T0FvwuBhYfX15y3xeIi/Q/tv6bt0v80aDMIYOITYA0bCZqY+nIF5oj21wad9qW3VtKRgyUBccKADgqVFJzbEsYBqLXaHFlrzfFr4JXX+kDVJCY3x8Jee7ZBCZCscfcKL10qa4FRrVC6IItEmsoZmL+pKs9vsUPCSFYGzgA2R9Fm49A7WLdl4r/MSae+og=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(1076003)(316002)(54906003)(66476007)(66946007)(66556008)(6916009)(38100700002)(53546011)(41300700001)(7416002)(44832011)(6506007)(9686003)(2906002)(6512007)(33656002)(33716001)(26005)(5660300002)(6666004)(8676002)(8936002)(6486002)(966005)(4326008)(478600001)(86362001)(10126625003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s6f9D1C7ZmI5v2la8kG/SF5RtFW1u5Dj6vYlvaqIxFCp8QQrGYv4ppIY1eX0?=
 =?us-ascii?Q?eJqGdYqKINSEk5j8rvSSdKSwxTm5QnH77wPTK3JCfn7DOrRuYXyCd7AA/W+q?=
 =?us-ascii?Q?kuoI3SyBxgnPPCMrHcv4NvdNQeu9r/OL0pWwI1o9CzXh7adVqHRhocTr5yTP?=
 =?us-ascii?Q?Fpiknm2QKszg5qgRyFSEwyN1QUBMzTK6idY352n4iZhVjZ+eHAbnjc63kVLP?=
 =?us-ascii?Q?DHuPJo6DNaUTHBTK2Ab02A70pH20wT1GhXyfk5ZQORyO8SKdRe4lbAW+vusv?=
 =?us-ascii?Q?ckF74H2gco9yIK4ikAUy1FqzDb8eDMOiDCH5ijv0T7GA5HJesPeXTx5hWKOz?=
 =?us-ascii?Q?qyULn5s2tgwqZ1gCO4e39hXSkO0Ix/u2J9t/Av7kJ4zq9h8tFeft25fG8w9p?=
 =?us-ascii?Q?F7Yw4KHY7bXQ0qZIxLXSdsdqlTuZ3tmU4F4wHXxfYwbsAS1QUdLRLsbwI8tP?=
 =?us-ascii?Q?wz25C5NgjJy7CBGUUzOk3ibpvVxb3XYJmRHxSPwWae8TQpL//oG2tMyANs/L?=
 =?us-ascii?Q?/sqGT2mZf4FK2JwjBNKKzU8+AROjkPU+3WtHgO9tkJceSfip4nBPp4m00l6C?=
 =?us-ascii?Q?hT11WBOi7zWLPPyZWTjEejpyjyYXf1hXJjJw8X5ywhR7tQJ3ZdYE+M5scDG3?=
 =?us-ascii?Q?j8UkA9iU52pFS7JEtTIs+fWxB5+zDDzOt9ypWcq+ujhSCFfHcsiHiNCkB4IQ?=
 =?us-ascii?Q?j+Wei4Fq78ac2yjlFip1u50RKdMJURiwYnVs/wfRiziHce4hVYhky6BmVtcG?=
 =?us-ascii?Q?hKiISrqXNq8oE8TADoCtyENFVnVBhgN/2vDa2ldLrKqDdNbQ5Ksjzy4OxTBy?=
 =?us-ascii?Q?KyBa82B01wDZ1BnkfAVCGP+inavzQkWn3JL5ShRiElD3pf/VETYBHCIpIGja?=
 =?us-ascii?Q?gqALaPZNdClMluIObnX37Vp+4LxcCwNru1yiFpNOwHtorTt/hDucHVUtvoPy?=
 =?us-ascii?Q?x+sw2r/dQVSwpHRYx10r26f+PcsRXR0sKl02PD8a12H6ZM9v3Tz6H8KYsOOO?=
 =?us-ascii?Q?7HO4gy3Sj3Y7OGGkpO4BBijPT13Rm8dWFjL93BSzLZVlf2dzQvv7C+bW6Gy+?=
 =?us-ascii?Q?PEtvJaJQMQNhYZb9rFuwfQpp93U7nyZOdM9tPmAZsBg/7c9wusVryLReAXZN?=
 =?us-ascii?Q?Xx3WrN0c9u8+Y2askRXM39AH8rT/d7SdzCV2P+pCTdNdqR1rFjUEAW4OypwC?=
 =?us-ascii?Q?EFqZCDxeqsLUQ2QFvfcYfu+7BtFMQY5C1tqQNIaCANPhx0f3tIpA1dn8DBrq?=
 =?us-ascii?Q?7xXtvEQhgsr3CvLo+YzqYRTCOGAXrtEVJb3LP8rFbWSlxmvfif96uI69cOYH?=
 =?us-ascii?Q?zAfiNHrW9FnKgNx3Fd02OKWWQLpGyHswERACjckyAov+khv6uaFFUS/CLqAQ?=
 =?us-ascii?Q?TBE/pWHStjzzA1yorOgWvIm9ALE+HQF7sooC+r5B32n1GJy1UrVpOVgz9pUa?=
 =?us-ascii?Q?CPhV+7zSM6O0QFeqo3AFbQGKGR9vUNEZAhJcde2TveNc3jnmHKSaR3O4kdQY?=
 =?us-ascii?Q?cUYYR5P14VUPJeroArR8KS9UnzIcmk3jRitQANHu+73u2qshnJV/WaEQY3x4?=
 =?us-ascii?Q?1H3bpvZTk4lqkk7BGPNC4oQMmvUhc/vsm8jbWx2vj+/sLeS03XWgDb9/f1cQ?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?TCiFuu1yeqLwtquPg1I4kBan6skFVwg+mCsyUv44g4nMA1k+YX54UIauU+q9?=
 =?us-ascii?Q?pVtNyKjbOt/3JtfTz3pHnIsgflr+UUQUchpPoqlaW/YGl/rWruTxn8J/aqBP?=
 =?us-ascii?Q?u9HX4aZoyKDr6BwgqsRwrtxWbSUxILfYsGoz5UncO2hZNaDOyayuxH9xnInK?=
 =?us-ascii?Q?VOOhUqPgrLcg9XjOYMVu/hzWIG92TYQOc9PcZ2OfJgBJ+mAytCprh8PHutEA?=
 =?us-ascii?Q?ubIKiXnhXzXklCW1nf/qbp6QH0gTfE3BFSRmlIBazTTqqz4rHBnOc46pKwxV?=
 =?us-ascii?Q?LQB8P4cV0jG/E/EvVOvH2Cb2DCnnrJaH1bh+v1gYF9vg2cdpK/4WegC9Qkf/?=
 =?us-ascii?Q?9rWlL0j/DvltukUDEt3H/5Zs6DII58wKJU/0t+PwXvxTPW5s7LzEMnwOSJEG?=
 =?us-ascii?Q?uvXQWUQoETGwrotOkgMkJ+TyNgO+c+SGA071itrjH4ZSAMGBdCoFXJLFOVsJ?=
 =?us-ascii?Q?ELvfpGKqwIR39qdaG3JAdVuGay1R+XJdye4pzuQORRQG4gDiO/oMNRmF7zJX?=
 =?us-ascii?Q?9mWmg676dhMAvYDa+swD9Ph/TpGbz5YkB6RCLH6WXbCiKTzbbvMBufGqP/h7?=
 =?us-ascii?Q?p4paFq/GJXxvKrKIinrzu5LYrfkCrzdW/yvx7hrHhxhhy2yHUROhD1O4rYqb?=
 =?us-ascii?Q?n0NMgu3ZhG5AFLsLJXQZV5cF5BXNEj1z784iz74997ZCqZxZdSPy7tZEUVZB?=
 =?us-ascii?Q?xAqZrJdFjjO4Nq6kcHSVWQNZKcsXHRtpyTWmA/l98R1YUVuJW7L/P3v0wlw1?=
 =?us-ascii?Q?AvQbT5gKHuVGyqqMwxPr9jbb0VmpZv4B8v1mlwxaP65pLmBeGz7XLGwDMdQ0?=
 =?us-ascii?Q?Ju82axl7cUFAgOvN1rr82IViPYGkzapfh98aUCJQG20LrxQ/nszREv+1yU7q?=
 =?us-ascii?Q?uRyJmmF/aayblAU8O0jVpZ2sv9Rvjl9kW6Hb/L2ACdoHD0qBw9lHCwb8Srj6?=
 =?us-ascii?Q?eaBEsA1ktenqZTFYiFHf8QwUh04DGL/H5qTxgVKbHv5yZC83jAf+3yiv7VtC?=
 =?us-ascii?Q?ALttV9AScyfvUpXe6wvjrYECCasdXfeY+TktHAngOFax0hYJFWm74Xgy2NUf?=
 =?us-ascii?Q?swPbHHTwh1zvEusR0S/EZuaoQU3JWT8P41M303qqCMAedhXekbzI1XNu970r?=
 =?us-ascii?Q?0d6gVEKTAGNf2h6Ay6UcPxLfgaTmKbl4LA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9d910e-c126-4e94-45e8-08dbc8da8b6c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:15:17.2568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSQ8S/EG4VrSO7XCqp7OxM7Hcg6cvnS8YL4UczdY1wZ0bAq2EKYdgqWrMOg3ggmcGs5DLynXH4Z4xCUUei+hwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_13,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090126
X-Proofpoint-GUID: UdlL8MuQhJ_YQTsa7LBzpZu0TnaXjnVK
X-Proofpoint-ORIG-GUID: UdlL8MuQhJ_YQTsa7LBzpZu0TnaXjnVK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/23 08:04, Mike Kravetz wrote:
> On 10/09/23 12:11, Konrad Dybcio wrote:
> > On 9.10.2023 05:29, Mike Kravetz wrote:
> > > On 10/06/23 15:35, Mike Kravetz wrote:
> > >> On 10/06/23 23:39, Konrad Dybcio wrote:
> > >>> On 6.10.2023 05:08, Mike Kravetz wrote:
> > >>>> On 10/02/23 11:57, Konrad Dybcio wrote:
> > >>>>> On 9/29/23 22:57, Mike Kravetz wrote:
> > >>>>>> On 09/27/23 13:26, Konrad Dybcio wrote:
> > >>>>>>> On 26.09.2023 01:48, Mike Kravetz wrote:
> >
> > I managed to get a boot log:
> > 
> > https://pastebin.com/GwurpCw9
> > 
> > This is using arch/arm64/boot/dts/qcom/sm8550-mtp.dts for reference
> > 
> 
> Early on in boot log before the panic, I see this in the log:
> 
> [    0.000000] efi: UEFI not found.
> [    0.000000] [Firmware Bug]: Kernel image misaligned at boot, please fix your bootloader!
> 
> Isn't that misalignment pretty serious?  Or, is is possible to run with that?
> 
> There are no hugetlb pages allocated at boot time:
> 
> [    0.000000] Kernel command line: PMOS_NO_OUTPUT_REDIRECT console=ttyMSM0 earlycon clk_ignore_unused pd_ignore_unused androidboot.bootdevice=1d84000.ufshc androidboot.fstab_suffix=default androidboot.boot_devices=soc/1d84000.ufshc androidboot.serialno=ab855d8d androidboot.baseband=msm 
> 
> So, the routine where we are panic'ing (gather_bootmem_prealloc) should be a
> noop.  The first thing it does is:
> list_for_each_entry(m, &huge_boot_pages, list) {
> ...
> }
> 
> However, huge_boot_pages should be empty as initialized here:
> __initdata LIST_HEAD(huge_boot_pages);
> 
> At the end of the routine, we call prep_and_add_bootmem_folios to
> process the local list created withing that above loop:
> 
> LIST_HEAD(folio_list);
> 
> This should also be empty and a noop.
> 
> Is it possible that the misaligned kernel image could make these lists
> appear as non-empty?

Actually, just saw this:

https://lore.kernel.org/linux-mm/20231009145605.2150897-1-usama.arif@bytedance.com/

Will take a look, although as mentioned above prep_and_add_bootmem_folios on
an empty list should be a noop.
-- 
Mike Kravetz
