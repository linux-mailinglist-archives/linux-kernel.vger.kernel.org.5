Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4885578BD59
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjH2DsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjH2Drn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:47:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754E118D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:47:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SHxDZ6002449;
        Tue, 29 Aug 2023 03:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Y2DbpAx7i23Nr5b5KgvP8zUaVJEcj3NIv6G8WgYJbB4=;
 b=wjABfEPZiqflyK4OAhf/U/wcWrHDd4VvLgk3PNgpqkRvq6Ii2uKUeec0TXtJ4Jr9opHg
 Tr/eK8XVKIa3680yuiyoio4J0Uc++fg2qtwNBVpQnGPGeb7sWBlL/3cTk2ie2G+qXGfI
 wNvN+yW1Ib7R5sHZRsu32G+8hy5NuEm8O6lzbfBS+NAk1tzXAJaIotk8s5MlXnlx0u78
 odE/0r0qgBJkHewp3Q8980w0zbwkT03Vvw7KGMpgm71T47EpNL6jlAjwEIQY+3nMqjsm
 cPbxK7yUk+X3Bz8vmdBvETWvZ1gOhC5YYUwPsCA0ewW2NP/xwFKdI9TULrhrEfHZZFVc Hg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9nyuypt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 03:47:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37T1OQaA033703;
        Tue, 29 Aug 2023 03:47:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dn1bdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 03:47:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnNGjwoL/MkBq/SmtM+aaXNPcHagZjj94loa1FZa5//5DeErjtGCA4bCr1DYbAQUGF7ryWWjFJS/YxPkKq8xnzUn+eIcHFphIJJ2QBtnALp8vBI7IlKJG8tRcz+rnLBHFwv7xGik7HVLpHxm88NDygrtK/Ijj/+z+upe0r9o9g/2Sayh43qe9/JblRAI4NctNSiyTZD8pH234V+XfU8yopuvHswhdsCL8WtXkN57/SkmbyG5kZ56JGOMPM6fIwSddwXUVXsteY7nN+qMlD+UL1oP2NzxscwEge964eZ8PzCbUoUttgpQt6CLUUsMeITOfXQ/Wr9NY4f+mMefWogXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2DbpAx7i23Nr5b5KgvP8zUaVJEcj3NIv6G8WgYJbB4=;
 b=Qjwqnh8xIe1Dk0XxjJVQ14w2iJqFxuFNuciWNCSNFenbVRPzFF7NQVbIZed15H0JS+N2dB4CWUhNMND4+0KiDhdOwHMwy2ZZvjLC4IHuKDf7sVpBm4dGF5txJqXIVrGEcCLNOp6x+p1pllQv7Kl05/qTdD1rHgeCnF6p4rjtlVmGxqpVtDx8Ngyyaf6pLSQUDnHIFxRKU6NQ3shNjzw2LJDe2oRww92L6poMeewZkWw5+mxLyVU206bDwi3VQXWIJs76pU5p9cqaRqvlsX+hKs/W+lH6nL4jYPXkJ3AI2OO2Zq1lbBwqXZwU/5fwMY/kPVoI5tseTL1WNCxKw29ZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2DbpAx7i23Nr5b5KgvP8zUaVJEcj3NIv6G8WgYJbB4=;
 b=pD2tMhHIvaQwzj0uKP3s/rsn7Z9QK5HRKkwpxJQl9TDTfkTQHEQsnA1ywP5DPXg2yLjAAHdb0AWUodOS8B6kw9/34ecsGGIyiUSNTMoJSfhpAfc7bOwIvhypHesDPrlO/MM9XDGySsWG5gEPzcaT5QOqaBWhNbqS4RjUi2q1q0g=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5081.namprd10.prod.outlook.com (2603:10b6:610:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 03:47:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 03:47:04 +0000
Date:   Mon, 28 Aug 2023 20:47:01 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Usama Arif <usama.arif@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>, Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Subject: Re: [v3 4/4] mm: hugetlb: Skip initialization of gigantic tail
 struct pages if freed by HVO
Message-ID: <20230829034701.GG3290@monkey>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-5-usama.arif@bytedance.com>
 <486CFF93-3BB1-44CD-B0A0-A47F560F2CAE@linux.dev>
 <20230828210418.GD3290@monkey>
 <A9D058DC-699B-4B6D-90EC-D81ADD32C6DD@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A9D058DC-699B-4B6D-90EC-D81ADD32C6DD@linux.dev>
X-ClientProxiedBy: MW4PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:303:16d::19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH0PR10MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a22c8b0-5221-489b-876a-08dba8429c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQIh2eCGPh/shdg/7DopjZzZSLE9msOB3FU+n4B175lWT3B3V8qU1Ojq5f3EQ4rbzDBFskrmR+ctZy6RgovAL1Uz6pJ7qn4WJsd2NiYgMIBf7hK6L7GyvcV7ibMw/Bi24rhQx2lp38ghvoiqmF1GUVVHXQG0TteG6At9M1u+BwuC+yLWP9u0GFtixBDZEHCv1K/r+wbl1urxdQtgz4SUPE9Bv/IPdhbaoP5tZguQ5brSnyAh2cmTJLb7/I2hFAcbHZu1lRrPHxfhAM3pPGRmrBo4xLGqXnIwbpO1wgjN59ek3F/NEmQqwx2Y4KqtreqwBF5139N0XHU8AQIV1U7GWSieEVWynl16tnyrh+b4uPSWH3p5IL5k82EAu+Xbvof4zS5xJBcph8AwX9o4kQj+064W0ebodGxFfTOakI1VA7Ybs+FiQAgXe4OW7aKShAQqM9NYqRru8X/87Xlog5maKLTaS3B4k8LOLvIR1JsQnDQs4HsYIt7vM4/EZjjR6iVvdQ/UKoYugFT4fQxQa0SOEfjPjaB3nym9+Opo/X3gvd/VtpJNtZt9b578L455QU5+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(366004)(396003)(346002)(186009)(451199024)(1800799009)(6512007)(9686003)(6666004)(6486002)(6506007)(53546011)(478600001)(83380400001)(1076003)(26005)(2906002)(54906003)(33716001)(316002)(6916009)(66476007)(66946007)(66556008)(41300700001)(8936002)(5660300002)(44832011)(8676002)(4326008)(33656002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PXKl5RnctoZoG12rPq2CmJurjojALNnwObKiGZvIBZ+6qlpV6H+Ku61hbxtB?=
 =?us-ascii?Q?ddQvONbH4zLRPxUs75DRIVzT9/cluuFwwwBtzUAS0E9LKXyW3suMBn6VoI9G?=
 =?us-ascii?Q?1FTa1VMI4R9FIfjGcLdwU4lMKea8gaxJDF6rNAM+w6SBO60MrrUQNRPtG70b?=
 =?us-ascii?Q?DV3qIaO9VgU4S770YD+ma7rAmug66m7JJBQrq384radwgsQoBS/nBJzppJNQ?=
 =?us-ascii?Q?TTPlbB9YakkPNQgpTJPG7HXAXwpO1aXU4ekka9fbdcZ7XQi6froz9OrGzlvB?=
 =?us-ascii?Q?dkJ5o9pInkjdRDS2l/cS9y0fYI3q7nhONeCDJNXANgNX+zBOJ3L30uH6B+0R?=
 =?us-ascii?Q?ADhcqr2a+PkmyFveCLb9jmsT8mNZCiX7fKyGfN5AoUGEYBPzJnwqO6K11FAD?=
 =?us-ascii?Q?eVYFsOGuHcpVVFPx8YcIG4HpYOktR6rtlKmBV/0//pb8uCi6VmH4RsAHhNV5?=
 =?us-ascii?Q?HIV4xnFqENh2t/txLFVACZzEg1WtQZ/Bawm+AVVdNEAARY/BrR//eLUBL9m5?=
 =?us-ascii?Q?uuOElVWIa+zk2E3DZ0JO2WLoQp3zGKKzWSrLn1ZawSRbdesf7bo4NCjRHdYi?=
 =?us-ascii?Q?U7GIdEsgWWaYRxWZdqX+L7/BYR4pGnZtAteY0vGcFVWBsOrIT6C65xf9yWrU?=
 =?us-ascii?Q?eo+IHxXkBkmovdP36nqBzV7MOw/ycu6cGtlbI+XIuXH5wPj2/C0gzdd9uved?=
 =?us-ascii?Q?OJYLKsmzpKbunmXsyahnvougcIWv268ItXvRJy4rkCTOojmG8oCeXUctE6L8?=
 =?us-ascii?Q?6pDAe5bdR06atDoTD0Omqfo4uI7tjwBRrwrOKF11HdXW/Sqz2X+BgxJEgraq?=
 =?us-ascii?Q?iQssWYk/UN/flZ5A4UaV9boh1nDwSCZh1lWl7v6/cxwum+4egKTFbGGDxYIw?=
 =?us-ascii?Q?3PIECdQnZzukP/gRA7XsvUHsVeB6oL3LjyEgtxDBPD5YCN58t8dK9qxWpt9z?=
 =?us-ascii?Q?FkwJrda5QivAbcQzPfc4H9uIvhoSt8JRHk5bKZ81WaW1TFvfNKrT7aLGVfA8?=
 =?us-ascii?Q?vAfuF+jdur+gPMVTU5n/ktGg/EivJqMeSxOydAQmLOYSz56bHxQ7AQMBqA00?=
 =?us-ascii?Q?oLZngbZuhfb0Cd9Gb+qfaBml7F74BmyLMolQ786zFVIKFWT58c/Swy+U8YDm?=
 =?us-ascii?Q?7iOeC58fLptYZFE8bru5xKq03zKTF0Yw3zo9FKMDbfkh7iRLXxjdp6wqu+Ks?=
 =?us-ascii?Q?sZseNL0lwz/109EQ8m4QDCqb/fLmNZzkrWDQHbOM623Nehz8rdDSJ0TxecWC?=
 =?us-ascii?Q?QFVpeF07ma887sbsKEjxCjGJcCJGZ5dXJL9rfBimHl75ipnPybcNzUnSXH26?=
 =?us-ascii?Q?dqYpfz7wMkqbqEwNMaYB4FMK/lU02WWGTZKpULP9/0Y43iax4csStb2b9ydM?=
 =?us-ascii?Q?s3sCV2ehHMAMrGpxBqutQMvDvNTV08u4gqCwT67BooPMxzTqHcXLG7MvU2AK?=
 =?us-ascii?Q?ptEco+XJ2YOXuwNp+6mGi/Rjte2wOEb6+IwEqrwmNPDkI0Gm++1FYPVVw1iA?=
 =?us-ascii?Q?E1GqYgSOBtEJ9jTj9sjflQwdYVG4PepOlW+t7XToq5xTzHxRDpntSZzvIXnn?=
 =?us-ascii?Q?Yco2MXoVBYaAl+asx0HFYolJMWBYOpZtZkJHoPDX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qLUTfYrCSjCgn/xatNkaOGqb5Urh/44ff3bJ4yL/ZUxPB4URybtWk5We7BVM2eAzAZd1vkhKzZkUUyUloVGxI981owfMra7pwZFPe4h09UYbrv7bX3sprXjsge16M54r6CgNygI+o9/ykTb4qo6V9tlhvHkh0TyMWywk5esdt68eF2FrqwxB1JJNxIW/DcCwrqTqW2d5gWLHa8OtaEPi7U+noq6/2bCsm5sIag2laXi4+sS8wGziqPKMo6sezoiUownc4UWorOOkjVViYsh8o2h/8rbUkjj/v01eiOoBj9vkHonUPzQ6YAmwBUx1kHC2VlrwYN9+UwENKZW4uv/f7FvWnjK8EIVc65JLZ6KwdzJ7DZ8SrD3j2FAUeQSB/5Njpq/axJ2POCA4DIVFih+SZEgL3FjmfolYl0ca/4ssHexqf+BZD3z+1lqEnalVhd2HZ7mLJ2WnSLEi0t/u3hZdowl2QDZofyhoKS1irB6uxmhdXPWRZbuFd8QNM4jVWWnR9wWG6QSaABzQ490fwgWK5aWWlmd49mc7FB572UtE67U5Q/VXghmbSBZxrRU9FXvF9E5wL9tTSPSoSqYBYrVzbEtqAEcwmFBDn8mnDEhzlz67FOaGxJlqvRdX9qwLQmZWRiNoWHaORWu+bBdyUCGhuuXQGOzmynhS2CrY3FEBouSpx/mHjY7h1ahD4byqVU6UMmOO4HULwYDyPuZeQSmtowCLnNeRpATTNC9YgWkAns5jsb+a+eN45UU6uUCkJgXozV9MJtvmc08h2zGVRuVffUGkQ+laQHZMoP5zGIgg14LR2LocrK3knv0YIq3uWxTZ7sR07uf6ESEbc9tDICPvdNVhlU4Z1QRJAUpFzuyY+3kFEDJbzbHDzaZ+5BrjREPF6yXQWZMPAz4DsiHsIHq7zhAjWBLNjnSQawKAa04yzx4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a22c8b0-5221-489b-876a-08dba8429c21
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 03:47:04.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NeshRvJview7hXwRcdBXwJ2sT5MgNbDXat12HR7Ovy5LqMPMgI4rDzV53e2arPFeA5rk0LFP8up5rWx96cvKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_20,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290033
X-Proofpoint-ORIG-GUID: M1rSCRerzWrJsVf7GG2fThqeX8JNd-Oe
X-Proofpoint-GUID: M1rSCRerzWrJsVf7GG2fThqeX8JNd-Oe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/23 11:33, Muchun Song wrote:
> 
> 
> > On Aug 29, 2023, at 05:04, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > 
> > On 08/28/23 19:33, Muchun Song wrote:
> >> 
> >> 
> >>> On Aug 25, 2023, at 19:18, Usama Arif <usama.arif@bytedance.com> wrote:
> >>> 
> >>> The new boot flow when it comes to initialization of gigantic pages
> >>> is as follows:
> >>> - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
> >>> the region after the first struct page is marked as noinit.
> >>> - This results in only the first struct page to be
> >>> initialized in reserve_bootmem_region. As the tail struct pages are
> >>> not initialized at this point, there can be a significant saving
> >>> in boot time if HVO succeeds later on.
> >>> - Later on in the boot, HVO is attempted. If its successful, only the first
> >>> HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
> >>> after the head struct page are initialized. If it is not successful,
> >>> then all of the tail struct pages are initialized.
> >>> 
> >>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> >> 
> >> This edition is simpler than before ever, thanks for your work.
> >> 
> >> There is premise that other subsystems do not access vmemmap pages
> >> before the initialization of vmemmap pages associated withe HugeTLB
> >> pages allocated from bootmem for your optimization. However, IIUC, the
> >> compacting path could access arbitrary struct page when memory fails
> >> to be allocated via buddy allocator. So we should make sure that
> >> those struct pages are not referenced in this routine. And I know
> >> if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, it will encounter
> >> the same issue, but I don't find any code to prevent this from
> >> happening. I need more time to confirm this, if someone already knows,
> >> please let me know, thanks. So I think HugeTLB should adopt the similar
> >> way to prevent this.
> > 
> > In this patch, the call to hugetlb_vmemmap_optimize() is moved BEFORE
> > __prep_new_hugetlb_folio or prep_new_hugetlb_folio in all code paths.
> > The prep_new_hugetlb_folio routine(s) are what set the destructor (soon
> > to be a flag) that identifies the set of pages as a hugetlb page.  So,
> > there is now a window where a set of pages not identified as hugetlb
> > will not have vmemmap pages.
> 
> Thanks for your point it out.
> 
> Seems this issue is not related to this change? hugetlb_vmemmap_optimize()
> is called before the setting of destructor since the initial commit
> f41f2ed43ca5. Right?
> 

Thanks Muchun!

Yes, this issue exists today.  It was the further separation of the calls in
this patch which pointed out the issue to me.

I overlooked the fact that the issue already exists. :(

> > 
> > Recently, I closed the same window in the hugetlb freeing code paths with
> > commit 32c877191e02 'hugetlb: do not clear hugetlb dtor until allocating'.
> 
> Yes, I saw it. 
> 
> > This patch needs to be reworked so that this window is not opened in the
> > allocation paths.
> 
> So I think the fix should be a separate series.
> 

Right.  I can fix that up separately.
-- 
Mike Kravetz
