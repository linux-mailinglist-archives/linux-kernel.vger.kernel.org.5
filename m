Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EBB7CEE12
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjJSCaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjJSCaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:30:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F770123
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:30:12 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIp2TH022416;
        Thu, 19 Oct 2023 02:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Ys0tRGvtRrx9s2MkQo09bEdImuKXq/6ZSZkURc8BzeM=;
 b=z05eyl/e1sDQs6eU7/UwnTJ2R8DEuQaTz78FVdTF3hnXdZ+snCRbixBzlIDzBPCiTO42
 Ou5gZPfjofPZaWq1wkDs0iuCfxMXnwwUtpXKlP9Ohu4d03mVOXbymqitTBRy4VqKyCuu
 l0hFfLhMEiO5ZVyu6CUdLOpE8oUkl6USXnH+LJ2TZI0YVqJacxhd5Ml0rApywVK26hAR
 Vwcuzq0bKPiNxIEcB2PaQIWCf/tehd1zVB1w/ekyhbbCNNQi/CVsvb5n05PdVvBYcOhG
 +/gPfoWnlYT02qgYo8EOZ6cO7HYkJ92+3e5Ntln2g8E6JtX77v7WN1E/AmIt25bjQ2kp sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28saje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:29:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J16sN0009857;
        Thu, 19 Oct 2023 02:29:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg0q2xb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:29:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxCS5lOSzr708ofzRXXCJd6cxUfG62uPdlMIWI29CEFreeBE5nif4Q0yFD4F9khA5PJlBnMGfIXcOxg2HGSdq3XydwrhwT/jNS1hKP0Ym7L67zrWleLIcVy66vigUNDN72ekeIGHB8MaybaXvTOLCFr4EbABN6lik3k1+iim/WEIOoBac3hIwmlHZNZBL+7GOecvW4HhgpQIgXNgCpM3ZMrqDkWLMPCXHHySlyH5V54qhQDljgwyB7XwZ2Y4K8W8iuptq6DSy2XZwzzMtuY0D/PgBjqZX0glOaaAx1V/MuM9f7NFI1tSPMJS40ev6spfroUHYlTRCEdAqo7X1Mfapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys0tRGvtRrx9s2MkQo09bEdImuKXq/6ZSZkURc8BzeM=;
 b=TyEc6I2CmSBqD7IVN7nAin1htDPm6BrgGi5/6zo4N7mV/Z8xiOj6b/wFwA86JXBkbi2DmD3jNGo4imFsuAXIvadHHPNzEal3IVEe1ScDioad3TusezvVgYYYy1Uf67XLvQfDRtYkIJIiVyI4GNOg6DM7cODNZNIgRNsETpjIhGlBxwFaFTOGwxUI4ksE86t0rhfvCVWc7YFdW2bQBUgMabR0tdb0yukVSqtOCh+e1XKJJoQFWx095/JVyHrEOZFH1kmUuXzPgaTdDA+PfDZilcG77588ERBT+rPo2mpBuYk9nWq1nhzDmJSVvsjgrIA9ADnSau6XbCnY3c2SF9Q3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys0tRGvtRrx9s2MkQo09bEdImuKXq/6ZSZkURc8BzeM=;
 b=rAT9K449NyepxDA8B6PylGdGex3Tb/858wxshQwXWANymscK/cc0ikZRZ4DBsPQbm4fwR+bslDqRL5aNun+W6DRBwodpvbmwr8Sa9orPEKcMcByhzVBx3agjjZEr6cp0svhMXGO1GmKGt3APNHR8ofbzt3GU0z8N+QcPN2AChEA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4574.namprd10.prod.outlook.com (2603:10b6:a03:2dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.40; Thu, 19 Oct
 2023 02:29:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Thu, 19 Oct 2023
 02:29:05 +0000
Date:   Wed, 18 Oct 2023 19:29:02 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Bisected: [PATCH v7 2/8] hugetlb: restructure pool allocations
Message-ID: <20231019022902.GA344723@monkey>
References: <20231006032012.296473-1-mike.kravetz@oracle.com>
 <20231006032012.296473-3-mike.kravetz@oracle.com>
 <20231011064756.GB2866435@google.com>
 <20231018224422.GC5181@monkey>
 <20231019021532.GA14965@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019021532.GA14965@google.com>
X-ClientProxiedBy: MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 723dcd3e-a985-4e1a-2986-08dbd04b2a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXfEPF7NrOTieu+GE+R3ak4n3sE47pcoYNxi34Tj/olWve0iu8MfqDJ2gzgp2htnyplkSwBhkaTyIvkCP5ZUk+lxWwhgjU5OzRTEbEGZVbreH33VITnCbW4kgsbhKlxn9qQpLUpEmUiu7BcYnsiqHO2dJIK4d4yWZGs3MgqNe8LiktCPFhnBR+DufhEc6gjA4Yt75M0hwXc2dNh3uCWKFY0FQeFvwREw0HOT/5bfpcaH1cUH8SPAHp8KYVmhWwaLUgP2xJ7DeB+Y2Z0qvV1Cb2HapMUsR+TwDX45KnI2R2shqcpCmkOuhwmI1ETdBJy0VBVvB0UvaERZww9r+BIHwnCb0sX77wr3z4F4ew69eMzhCf/0EYweurPTuvpG/2l5kw/Al+buN2AFNHWH6mqNVMLxVybzb4U5ym6rnapb05aVtzyQwybl3NOiiSr8pR0fBeso+dPLlFf9HNGuYZ63os/mnrFLklD2ryMGTkkkqmSyv907DAgxGsqr2r82Emgq3KjEnOKan27qCepsVvUjyI5D5gDdB2edYMO8PCz1Ero=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(1076003)(38100700002)(6506007)(6512007)(6666004)(9686003)(53546011)(33656002)(86362001)(6486002)(966005)(41300700001)(8676002)(8936002)(44832011)(4326008)(478600001)(5660300002)(2906002)(66556008)(7416002)(66476007)(6916009)(316002)(54906003)(33716001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E3+si9GSC4Q/OtO2dJJ1HTHxaL3Lp+uGwimx/SYz84gqv3NBlaAq+P0HqHeG?=
 =?us-ascii?Q?I/2J1Hngr5cE6JVSKCWX1dukK5nzy32xHGwa9SxmrFwMWZBJvadSYleQ1TKI?=
 =?us-ascii?Q?Y0Y6lBxa4KUO/Z9QZfaa517dFPRgy/b760M+elKLzulUzFQqXwrzOQPJHvv4?=
 =?us-ascii?Q?7VpAnr5BWjJXCidsJgo/cjrDhcJ2MSmGR3wci9v2GxQLzo92SIWe4B9PpHIP?=
 =?us-ascii?Q?STVtZXuaL4TcwHPil8uSdN4gQAW2G6FtpgHnu4ftnzh1ASn6oTvk5GIjScuM?=
 =?us-ascii?Q?LZUe0jGDwDNDY0lbV+3cwG/cXkKU5eML8vSQ0kQXsPmU4IjH8q41XlNSX0g4?=
 =?us-ascii?Q?EHvO2PeY3LUeeBOCsQ2cX9eMAofzrzcMqnm0Z79m29nXigfKkYBkMiYqXLlq?=
 =?us-ascii?Q?hmjlaENzrqg3neRnJex4AEmFUqYSPvHRMH4v0jquEp/Run+roLBUhPPagvke?=
 =?us-ascii?Q?xsKaUX5x4J0v72BM9SEt/BtzdY9zyC+afI2uqc1R7+/Zw3l7M/Mq8semDnIU?=
 =?us-ascii?Q?0xBKSYnayeOH2fpdb7rW73O5e9O3m5QglWqjdUig4AHoIole6ANku3pWPnFi?=
 =?us-ascii?Q?nojd/3c0Rv0GfreiJdbQR9WE/rLFgXC+86ORz1kchqL/bEvVdWsoPJN84ObO?=
 =?us-ascii?Q?oR/zUK3mNKChplkQCH/RE7v/XdjUWtq6u3Kg0OcOWwn5JiBpmOn1/+9iRumQ?=
 =?us-ascii?Q?p046iw9G1mDXQjJ7b4pjvTFa5Q9aQu1REwdHaFjGL/jFMopB4ZsrF0EwkcTM?=
 =?us-ascii?Q?mG4tyMWKkqeapYmAqJljogJALGg485N/SpkUe9snfdWR1zlQphoR0J634UgU?=
 =?us-ascii?Q?xjtduf/x4w/Qzh05KIO0VkItZ92JboZvmTgxKX5VDlnCIWRJqKxJfSusVu0H?=
 =?us-ascii?Q?LsM8Pn4JkD8J6SElZ5FhOLA4GWsQRZNtOJllPVM6UaLMUB4a3OCm1BHBHXn3?=
 =?us-ascii?Q?joHhO0PifGoziJZ4u8kaH9OI98HZm79K33/2RTixNjl3EHQQJoWVE4YIes9U?=
 =?us-ascii?Q?43mKuhYv96/HedhK+9EuG5IIYdDHa5T0QKedvRBmGrpE4OQF+GAQpihSf0fy?=
 =?us-ascii?Q?QkP3i3gnm4JIIbtwwRbJCgyBJXuFnZuOt1deyyXcqVvCUs40QVuCMULoAS1u?=
 =?us-ascii?Q?OUe9PUIqMf2Cf3vwcTYAReUpkKEZZEmZkI8wowwePsewbjT429/geRd1GEBx?=
 =?us-ascii?Q?NGyjNWArtIRLjfoJ+qXkLolKRSSdrmxdB4JiGpy4ZdTYUcVzeTDtY9KdOIJR?=
 =?us-ascii?Q?iAnCfbmn+kzSn2WstnlVGrqwA5TLH4jvWR40v7RuTf+dECeNgT5gsWCR1sBS?=
 =?us-ascii?Q?F9tFq6NK1+npaZJuwuppa0RelmyaRNDfLEC/UopcYV7wd5lGmdnTKsyADG5i?=
 =?us-ascii?Q?jkFCMtGJ1DNdipppnwsKqa1GspKM5d4inmYj70krCZgyxdv39FAbDp0zOVGE?=
 =?us-ascii?Q?s3Cb19i+KZ+gd0MuktvaesqtPE6SzjX29P1lmFuoyfxqlnZkyhG4yNzDHQZ5?=
 =?us-ascii?Q?Yxl7Dy9l17yKQVKXuc3sDkHL6bOLbD84ORASd+ecfL3VecF+zfkjITnZn/pg?=
 =?us-ascii?Q?ysLX5GmuIBKyWtjwPeUv9snXCNp2NI1kk8gRNnq5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Okr2nsv+WO7/tu3BciZzOx2imq7ci9Ea67w/HXoDNzA3/zbToLXN1Xlhpvjf?=
 =?us-ascii?Q?zIEWitwwiYsiiYAXDcvhAgKu4I6QPECUmVLvyKZesWAf81AWZj58fDddVqan?=
 =?us-ascii?Q?9fLuiUsWP9XwtomFUSUFaHSXr7x6cWL757oc30mmV67l3XT97veMifXeDdi7?=
 =?us-ascii?Q?BnsSTaxg6hr/aRqXCqqwXC6Vm7+Hk7U6w4bSam61JBcY8dn/GSQKjbK1rXrq?=
 =?us-ascii?Q?vj6sbfBqZYa0YrrHgCKrEC98myYZktZmXvNXXgFik9FsMH+NAIJkhdrpbgoP?=
 =?us-ascii?Q?D8barXE6W9mUjrGoTJ5Z8N1HTZ5JkyrQoBqBtLamiAd9GAiFNKNj6WrAACkn?=
 =?us-ascii?Q?2DpeGelgWTG43Wb8VKDZ7wiD9t9TfQ/Hs9nGXl8WP4k8FOp2dHSuyP/8XimB?=
 =?us-ascii?Q?HolWiaoHkU1O10VMlJtJHkt5WzK4Cu4afMa5JOVyOVFpvgcBPFM7HstqPkVU?=
 =?us-ascii?Q?dBRwXb4S+iS6kukbos3m2WXcpYaq4HuesAqNqrvXagzfF98dz2hDrmrTtv8/?=
 =?us-ascii?Q?z3aLvKsLRGWWqvC6JNdCC6Z8+vs6jfxtSUMz0Nm0HrW/cAZ3VX3VCgwUC+Je?=
 =?us-ascii?Q?FB9zkp0XDB30zInWnd6aCnEspRc8gtLZjs7S9rGRG8g40lhJlSssJgVPTkhd?=
 =?us-ascii?Q?gnuzJ4jN/+vtDrJxIHnrkXovG0A/DljB6ds+SZoUW7gutzgtcRcgyt2/8cWW?=
 =?us-ascii?Q?B50A18V9yY2oAPLeOtWL5ND0dw85bBSMYlzcl2JUgJUWVdWWeNbnjjCyCrBm?=
 =?us-ascii?Q?sTi616YPkQ9kvJOtMw1uPHX7ON1d17LYxzFqopoJhpR2eCpACAuiNEbqASL5?=
 =?us-ascii?Q?3pnIwiYQkt2yPV0Cv3naejv06pxxQhMO8ALDUY+8wcErKG/F2M7kmCioSJkp?=
 =?us-ascii?Q?f73kVjXF4wgh+QpgAvdhofKIs8T5Se6oxC4ETa/bUGgLgLwHOku7dx1PZZjQ?=
 =?us-ascii?Q?ZqoeY4BnEoiCHZoyGlq3h6uomsxpIt6BcEy6At+V6kq4G3Qs2qbYVBOVJwqV?=
 =?us-ascii?Q?OAilGZ7/i/tdoN/mRVu7m21Wc4jfL6yF5bSWvFzlAcYoDbr899xcW0BgQ1VG?=
 =?us-ascii?Q?hDae2hwTm+JO9XiFSID9cUf5a2gCJz7qqAYgyhlS1Glvein5jlVZ8yoh5+QR?=
 =?us-ascii?Q?fFmJvOJM95ufzZQm60URNF2D4TqOhBlklxmhXvAfHRqsjGU/aFnA63pwqER+?=
 =?us-ascii?Q?65F0uArlg+bOv2qN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723dcd3e-a985-4e1a-2986-08dbd04b2a5b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:29:05.6511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3DjKNGzFVY3DP9hDcd3fmXxB0y995usnZh3X7J3U8pnWFcYOiBKkd+BITHtHVR8iEVJJ/Wq2CFbHh98jTHd7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190019
X-Proofpoint-ORIG-GUID: 43pGJ-n2o0rfblAO8iEqnjupEbUbPJuI
X-Proofpoint-GUID: 43pGJ-n2o0rfblAO8iEqnjupEbUbPJuI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/23 11:15, Sergey Senozhatsky wrote:
> On (23/10/18 15:44), Mike Kravetz wrote:
> > Hi Sergey,
> > 
> > Sorry for the delay.  Not ignoring your report but chasing this in
> > another thread.
> 
> Hi Mike, no worries.
> 
> > https://lore.kernel.org/linux-mm/20231018222003.GA21776@monkey/
> 
> Oh, interesting.
> I just read the article the other day about some of unexpected optimizations
> that clang can do [1].
> 
> Setting h to NULL seems to be fixing the problem for me.
> 
> > Quick question.
> > Are you using LLVM/clang in your builds?
> 
> Yes, clang 14.0.6
> The kernel compiled with gcc does not BUG_ON().
> 
> > My guess is that you are hitting the same issue.  That BUG at mm/hugetlb.c:3180
> > should not be checked/executed unless you allocate gigantic hugetlb pages on
> > the kernel command line.  Suspect you are not doing this, and loop code is
> > being run when it should not.
> 
> Looks very similar indeed.
> 
> [1] https://research.swtch.com/ub

Thank you for testing!
-- 
Mike Kravetz
