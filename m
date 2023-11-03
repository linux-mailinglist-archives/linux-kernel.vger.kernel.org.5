Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D4C7DFE13
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344984AbjKCCiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344885AbjKCCiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:38:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B9419E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 19:38:12 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2NNuO1007108;
        Fri, 3 Nov 2023 02:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Bgc873ZeDPxuZ9swqrgOG7TPbXGidJF7dAAPITdGasg=;
 b=CNDgbEe75QI4qJh+n+KSSJ2hnWbZnZvkRN4dGecWAK4zEyFaX6/aIz2ipAkZQOn4mCUm
 MeymiQmp5HP4rHqT6kWXiyhgmvh2TvY9j5+PT77NwXVhKoqs1WKzaeLD8h100NWioLPu
 qG3dVmx+6FS6hZUTmpHj9tcoesODLSH0lNQ3RfVuuR6swiPPPyEB4IdXMUUE8owjI4Rx
 AUte2ZeKmQTUvXeF/kR70uVT8ZOY/ITGs5d55WAxSOeEaccVI9zXYTofuvW4HtRfpen4
 3n+DH1DrpEHePwGbXMfsby6rBGBIkz656u/x5FqmjLDajRrti45yyg9NHkHOyXjPWhZa KA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdu6mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Nov 2023 02:37:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A313tk2020064;
        Fri, 3 Nov 2023 02:37:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr9gaxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Nov 2023 02:37:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBXjpkyzcUKyLwo3pJdMS+D6r00CK6u86q8Jdcq35zg4Z8SSdAeCP31ihoPAeJCQiaPFEZxfYK2bEhuMTJcnkyFRhcnMHcqyvJYwEzFuGmcyWwg1cPVVAmHgu0eKNJQuc469cfz7dEm41kawnoqQm9FlgM4b8HnfKBkZYKz9pb9eTVHMYGLlxxdcjpwXe/0ydlE9GLPNJ3HTt9k6T+nx+tii2ch4ltLE+cYMiLSaeE3ezjbSaUDB2mAjj4B4R/dCiZQo34Haple0MmwONz2Z7RLHWOdwpqergdD+9LgbB3Ri6tm6x/xAYBm3cUUWKcRY/50ll+U6KsVzxr/jEHvndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bgc873ZeDPxuZ9swqrgOG7TPbXGidJF7dAAPITdGasg=;
 b=ikXC2EDhl2Z127L70zdIDoVdpGUL7lBNnOS8lH69NSMNqp2eSKdBlg0D93oqR4WPWedcDvFm3dAs5UolKvgtPgZSOwfXL9rsiFTJYQl/kTTs+uvGxMl5ZGPcbL5zJTChdjXQ0wtsqPHTTlxH7OtkS8/ppOXgW25rZu4JGbjKhUIKqWFxs8FwOB7cgPpGx5wtZKamFkycrRThHTh1fvKiaRB8Sk+nTi4h3FbWpMTJf0rtu23PZ6UEqqfNKPX+z8siobZQ42SqwwAa71JdsEWSzVHkT/Pws0OwOMdPj6zGiHCGBvJP5q0mknpFWUeuxpIfElfT5XF0t0hTuUIw9Tj01w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bgc873ZeDPxuZ9swqrgOG7TPbXGidJF7dAAPITdGasg=;
 b=BSkjJG7dGS2VAp7WFN7IaXfIzbM51NOa2ejuCMRq1rSewrwYxC9cVWa4pNl2Xe0ZOCS0yqPinrPP4BoVBfsXloWMuqEpC4jm/grUYImotEC32ZNTEyNsUmlkSdYiO6ktKDPMxvTO4M2FOfrrWrl1FgvpWxuvlPWmhW7z6OsDoLk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4713.namprd10.prod.outlook.com (2603:10b6:806:11d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 3 Nov
 2023 02:37:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0%6]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 02:37:40 +0000
Date:   Thu, 2 Nov 2023 19:37:37 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Edward Adam Davis <eadavis@qq.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, muchun.song@linux.dev, nathan@kernel.org,
        ndesaulniers@google.com,
        syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [PATCH] mm/hugetlb: fix null ptr defer in hugetlb_vma_lock_write
Message-ID: <20231103023737.GC3531@monkey>
References: <3382634358afa9b95dc4f6db8a53a136d4b9e9cb.camel@surriel.com>
 <tencent_164A247533766D667C3D873798968236C409@qq.com>
 <20231103022426.GA3531@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103022426.GA3531@monkey>
X-ClientProxiedBy: MW4PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:303:8f::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4713:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb78a77-dc60-4392-309a-08dbdc15d95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KB7TgXpvllvZHIepQzwhUCElUfXM/i05k9OukXEB2/GPkp0UCc3EJ4+Kk6vXKEisyUj8QWUYLx/8KhDj0TGEByUdX9bR9cGtMC7VayKHw0rKfWlq26t3G/b4GgURxa108lWFTUQCVnOmmzrqTfYv2tsDRiUUz8YSLOFIFm5HCMzECG4bOe+Xq+hz9Q0yDw25AkG7t+zVLGvAHJ6PROjmfSxycY2Fbp3wLXGV6DbTo8GVo7rcrUNsUzm6seGah/5yrddobgcRYryqb+HwIuN8SjOWUlPMelmExPx9Mn6qPQ2jLN4NS4gUr5WLhfVWWJ1YdHET/xydJS0d94yGx6AGfVOV80u1StHd9rgG7m5h42DtVvz9N/EF7ZImu3z2Gbmn/7vZ0b4pi4PndW6LwzgBSrVN/XsNaB8AiORL3fdLkNs1xGFCRFurOlsCnpkhbWAAxW+1Ywh0HK78JVDV+oc5QKGGRgFQlOckLlyk5vZqvuzA1gVzbOONUio3/CD/4STYi0FvM1pwf46eplYUMs05uGhj1+av+GnMqb+N5OKjxpLstX9kT6gZIdLWRMbtUTEF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(9686003)(26005)(6512007)(1076003)(6666004)(4326008)(53546011)(2906002)(4744005)(83380400001)(7416002)(8676002)(478600001)(66946007)(33716001)(44832011)(41300700001)(5660300002)(8936002)(66476007)(6916009)(316002)(6486002)(66556008)(6506007)(38100700002)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Th1rYazXbF+mXFgG1qO3XBpcxJ3Zh55g7pxtF70QTsmgtoByX/wOa8hHdwFa?=
 =?us-ascii?Q?YNXV7PsaaeGHnnvebrd+c5KeL0HQ5XKIo4E2TFkZK5rCbhAUIOysr4I0vEN5?=
 =?us-ascii?Q?L+o7Ilza9dtxqPpzum8OxNGfM+hYV3KcB8BQar4P61VmteJQD6D4VBfwBmIv?=
 =?us-ascii?Q?5/TCPHMuh2iOZqk36yw5p375h+2/dS59L7wEU35F9UGy0vsRUib0FVAbdjJt?=
 =?us-ascii?Q?NV3M7q6CbRugBurmt8siPIPFi37xMHtxNKSCw3X4ne5ld17gw7huIRGyQuXB?=
 =?us-ascii?Q?qAU2QYOKwpcXsgcA1rCQHGi4joTkaZOmAzg5GkuJgNbLJqvOAd4gDQpC4/Cb?=
 =?us-ascii?Q?oaffJXA0Ih05byW5XAO2mUFs44w3vdkwL1aVbswY8WKcgOs+vS1RKzemNv78?=
 =?us-ascii?Q?nulavaOZ/1IbvhufWQzaghzBYSIvs6sXuxvsiyFLRdmu/G9IetmfNNMEoqjD?=
 =?us-ascii?Q?uQua9Qx7FknAdMUZj+KW4uKdCM9RCh+q7avTebit/jNjhtKP14p0p3gflkRq?=
 =?us-ascii?Q?KOjp+7bykImfd7kqWlMwqcPkXIAubzrPbrfqWH0/2TgSP6sdWCaL2678cirL?=
 =?us-ascii?Q?IccAYzpO+JYBxpnafbT6HXJLg/CZFABJtXHfHfjmfQeW9K4IuSMPTElN+VRB?=
 =?us-ascii?Q?oXWNZbi+cMKnvuVJGYBJw0eYW/VvSXAlnJiHntYbtQwoUMZo3k08oD4kO9cS?=
 =?us-ascii?Q?RmTVup8nniNHB2h3jX6RcLy0yDK3JxCdr4yn3Q9VpMpQjSz6/DyYyTgR2/Gx?=
 =?us-ascii?Q?nq56u7nSrPRJ10AJ1m7M1WvqYD29BQJzt2dkFKdM8n1aZ0tXdgwoCVi9VTQi?=
 =?us-ascii?Q?MJmOY9gqCSMM3DwTS9sawvizEDhveAmu0RhWmCo095PimUjXkh+2KESYwHPi?=
 =?us-ascii?Q?w71T0BV2ViyHcb6ZEc1DpVcYw1o34ocTd1LrlfM1BBkFlvJOkd+I2kBnttFz?=
 =?us-ascii?Q?6ukgVaX46IY28ZayPI/2DsIYmgS1YAfm2V2I3DwJSTi86kSH39K7MqMJyogb?=
 =?us-ascii?Q?DQ0UeIR0ibqIW9mju/n3i3HxSxVxTLZJKIKse1r/1BLUxszSarfqC+15jNR/?=
 =?us-ascii?Q?LOQGLFW4mC9z6N2XAosqWGrn0q3BBBTyJQO5hdQofx0uK7GP7zUZg1ZJhYye?=
 =?us-ascii?Q?1Soeij8X67NLWK4zjYmksDrg+Kt5P+Mpv1G0QkDzmGprsVoJwE7vaQZOI+IN?=
 =?us-ascii?Q?3iyRIGm/smSz9Qj228oDwEjHwcHU4mu/L6sC/u59oTg3xYM2ZthDsla7A/Cq?=
 =?us-ascii?Q?3HQrC6vXv5lZPqR3Rf4ytRwrRQwbYA29KWKIEzTFGK2IY9jKHLCNghFhOtef?=
 =?us-ascii?Q?+ylwBFGNxrpvMgQbXj61X0TieH013R0W9iIcTYCpOpc8YScZriBiN+ctOyy8?=
 =?us-ascii?Q?pJBUA1yDCf4iSirtCm0EEopIReK4oAaJMhaxWOCo3rvI0OBKZmDyNmXq8bVM?=
 =?us-ascii?Q?8Y9+wP/AwGMT9fddX7wjc0GGZXe5IsM/dUDMoSmjZw6u4ZpDXneYCoQb4fz3?=
 =?us-ascii?Q?lpImCAGTYxZMY4X5Iu1BoGjfTRp9xQDYWYCCSTjLQvTwN+RVzk9FsMUTzLo+?=
 =?us-ascii?Q?iOWAyADBnpUroy1eMuIkokN3QTyLdlbX9Ww2nVKC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?s+XWBco2ZCziNh+Egm/5JqDi8sYngjMGX0oEdNEE56WU6sM0nlrlOKkQwHQg?=
 =?us-ascii?Q?ANazH4wMVKFk38VLTY0U/Jk3kzcR6C6aS4ol2xnYWmcS56Hs7IhYISJqZqeW?=
 =?us-ascii?Q?GF2icTCmyxRaops4NT/9gnAgO9mSj92QX5EknTu56svDPSKGdkmEgY8K11cP?=
 =?us-ascii?Q?7eIsTVtnO/s5LD9kuvkGur6gZmR2czDaK9a2jLM2teWNB24NaTWHBdoK5UDK?=
 =?us-ascii?Q?6oXbwR0oziVSjIEkVmMXF1uegzPxxgkdOueGfHGCmoGQrBGQ4b/XpUH5Gm38?=
 =?us-ascii?Q?BVynNBv4CanEZTnqfnNM+HPRZxODuLhi48aMaFndIErkqMonVYP1F6Y6e5fg?=
 =?us-ascii?Q?tpBfNqQUQbgb0uJg72Y1jFqNAKIt3YSjveqyt2vZ/4Q724pfuX2dkZPLg269?=
 =?us-ascii?Q?YDrLmdYF6t81GlCVxJJ3cAucRAY5D28FXwMhcvJyFJ2qcqxeNyNxj/LdHsNW?=
 =?us-ascii?Q?6joZ4KlCX/7dOpFk7H+x32Pgbxo4ab80K0tlNWdBHXpuHM/ejyuZIYy/hM1R?=
 =?us-ascii?Q?uYWS1185K2ZsJpEKemNi/BzvH7Lyuc6VlGlJTGnYenGrr2LM5nsQn6cJnrPu?=
 =?us-ascii?Q?c+iunoEja6qx9+yj9V19rCNOivnR60i/thbXKUPRV8OYnzyYcfnIK+x+zmcQ?=
 =?us-ascii?Q?jL3vj/Cj7b9F0bTEV9Hfn9diPiku9s8Z0KhXjXG8wKPQN+glW4O9+PQGJJ9R?=
 =?us-ascii?Q?s5cAaR65i+ljRg8XMjXB/RWbav69AB0v4hKX0JYZ/k6JYbPBI6At9l0LcIGX?=
 =?us-ascii?Q?/i1sSDjpg8iAdsbILOgkmGH6jXTsZSAwgSVWHWGMvbgefXBPghN/KZRf6Sck?=
 =?us-ascii?Q?XU+8CwAwr4PxIYlM5EPj69T+voFJN/GfiQZIJWr+ZiKLrxIdo3qshjwq+2bU?=
 =?us-ascii?Q?gqxLLVHyWOf71fSomFdChMBQpQSQUsMT+JTyzs/B368XGYBGyXuKtK/H501o?=
 =?us-ascii?Q?iv8ARQI1z239F0xxCIrHJCPtPtgKrFG5ryq9VEZOGMlAl4TuMe5OU05SBztg?=
 =?us-ascii?Q?6EO7HdjirR2FmxCLEv+1Tkoy4Y6AKKrhqKoimilYe0zfMEzXNLt6wg66w0Xg?=
 =?us-ascii?Q?Tz9WsU9aNyfUxD2xn53gee4vJPWFMmJo1Z+oGpxaLbw2fPbNn3/nWjuRGWL5?=
 =?us-ascii?Q?y+vPJWz2juGtbKdMHYPa0xiwmQmg4SGcnb6rOIM8NOnNhIKQ+EUjuZk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb78a77-dc60-4392-309a-08dbdc15d95c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 02:37:40.3193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x90hBugl9iB5fZLwFy60k0zc7RkXxLrtK2MHxDZba7kDOgpMT6zTq8J1e39EUAqiQ7nJVDEwyXpbidGaMmYHYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_02,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=773 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030019
X-Proofpoint-GUID: jStd_mZ6EdNYszhb7rFSBFRblqIEi-bU
X-Proofpoint-ORIG-GUID: jStd_mZ6EdNYszhb7rFSBFRblqIEi-bU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/23 19:24, Mike Kravetz wrote:
> 
> In the specific case causing the null-ptr-deref, the resv_map pointer
> (vm_private_data) is NULL.

Hi Rik,

In commit bf4916922c60 hugetlbfs: extend hugetlb_vma_lock to private VMAs,
it correctly says:

    Extend the locking scheme used to protect shared hugetlb mappings from
    truncate vs page fault races, in order to protect private hugetlb mappings
    (with resv_map) against MADV_DONTNEED.

That qualification '(with resv_map)' caught my attention originally, and
I thought about it again while looking into this.  We now cover the common
cases, but there are still quite a few cases where resv_map is NULL for
private mappings.  In such cases, the race between MADV_DONTNEED and page
fault still exists.  Is that a concern?

With a bit more work we 'could' make sure every hugetlb vma has a lock
to participate in this scheme.

Any thhoughts?
-- 
Mike Kravetz
