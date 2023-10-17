Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530067CB93B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJQDX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbjJQDXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:23:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B48211B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 20:22:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GKOFDX013129;
        Tue, 17 Oct 2023 03:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Kv2Ra3uaRaQw575Ge3ZLM1hywazGZQU1B11w/wwi548=;
 b=CtsK6komu7zwdBsy8KzR5cHRQ5FW8zzhyPi9lr/qDtirCsyqOL7BwEW40QuZzO/YkF1E
 /0MMdiDS5KCPzv5pHeXHhABSWDrytYTHlnBcqeb9rr0fZgq6fYphE3U6WOXITxt8QlWk
 oXS49jXYWgUsWhv51y9vPMoAtOJrTxXi42CPT/43qbFNq4Y1vywZgjxHu4BLlzalCqK2
 Z4Ho5Wf1SxhhYN3UNjBKZDF/t7/xJV5FTLpBylOOFyO7maM8MXoFXUr3S6sOuqbN1PRZ
 EeJB/bsARc5zgZwKp5/6O4nnpao/TxRPx908lWu+RfrFFJDbM/tHx/ES1dzHQjGYBJ6Y tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk3jm60d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 03:21:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39H23hOi028411;
        Tue, 17 Oct 2023 03:21:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trfy30513-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 03:21:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuvFH3KJ3kHH0I87lXpIbFwnuzQmKlX4+zh2NMWOgwtUIhN9RMwnT1JtOsevhysaDesWkr7i5I8ImSNfxfcHtblyhi91O+BRbdMdpca+fW+c3ad7KSWZIS7TBtO4R+EJbiRSKZcPChQvYxA5qfXFBZmThSquIS2paC3scNvTEcKpnxcCNFsFsthpDFbrT/CwVj1Yf1QJ+AzQxB4aQFQsO37gl4Ba5daWejhDk9pA4dYMj2tY/64l0rYQiDz5By8FhONyVJKi+awMfh7lqEbfLoZq4avbRK+tcjo52plH9No1Tkb12owIh7/8qyMSSoPe04VpmTRtW96bCKT+2S9HVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kv2Ra3uaRaQw575Ge3ZLM1hywazGZQU1B11w/wwi548=;
 b=GAhn1E85hV1lLE1Z0r7uzXZoPyDPxEk+iJG79PMxtP1aXfYqxtuu/Wy1s79maBOIKLTvP8x684XL8uck3xAuAcyOQOmPXzq2f0gay3MaxErLZDSJu0WX/PbaflurYjjB9CpLSFHL0HhCjP00zSUubqSmeH47huhKgnHOafn8npGdF4mM70knADVVDgBvcbRNFdppYfY7kPGxi3p24bHz+nuTrOLdo7dI5xoFeZeaVpWAy3qPatCXe3edqywmPq5NNjTk+Qo8uFTfRSKEl2sgu0Wa3QLcGIv5iqQ+YzbRYWXJ3SuiFK8XPyfo7KRiRfaVFgLwoZUy8XUUa7IEM62WVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv2Ra3uaRaQw575Ge3ZLM1hywazGZQU1B11w/wwi548=;
 b=iEuZevC9dBPPv8MSxhMnzxaSIOtJifox3112i5oWmxKr05vNLdTTXeRf3EBFiEsnvnsm9mC73b94dMUYI4tX+lfNgvqD3+RpZ7o4//rM970Ql+SxoXmUIgFfRT7Sa7ddzht01YKxSsWE+tiY3xUOJRH0nd65kroglo81DO3KpHU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4537.namprd10.prod.outlook.com (2603:10b6:806:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 03:21:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Tue, 17 Oct 2023
 03:21:42 +0000
Date:   Mon, 16 Oct 2023 20:21:40 -0700
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
Message-ID: <20231017032140.GA3680@monkey>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-2-mike.kravetz@oracle.com>
 <20231013125856.GA636971@u2004>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013125856.GA636971@u2004>
X-ClientProxiedBy: MW4PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:303:b4::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4537:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d5f71c-9e04-4b9e-6f25-08dbcec02f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2vXRvbYh1wYqSufwBThMMGe96f4fXz7QUKOBMM2CsYbiOiYz5pzsaQCsFwpGTjElZdEHoYLNXPon+AHDtNOtObnbS+gffusotOdQQoPcsoqd4pKY+D5Wp5JYZfXybkx81Sk9aOISXygJ3IP8HrwQO8Gq2ac0mMSVkIA4Zes2ECXH82uRqcIW+p4Vrlc0YUnwL8a7me4XuIO60fFoRI1KRDOETfxjktJ/yiMtaxkQ8PJrOEJa3ExS2Yhdyv1qEhsrlR8EJ7+my+CZGniT+mF5vUgRTtqlt+YaFOkTceNQtCYBIZiH+T8DyGIZTX3tZFioC1c3mX/LAILEBM8aZDvbNeX5XF+lNDxOsPPYDus94V6G6Tsz+Lrq+2VHmfR4jpOqFfKzZ7zlcl4r7Td4JHxIwLn5dVeb5kfx1EZ7CF7mCAe0cEjlPS/Y0hS3iDIAERo4fVZqRxJLf4KLG+UIww4qmwm5kv+mJztXyxOuXuJQrQmRniT1uC/cMspOQLB+1qA0Q2+GrAlfmTSjtmNjjoWebyYQJZJFxdyVVxWNIHghzvPtSFFBKdlgCr0ZDjbw6ZL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6512007)(9686003)(6486002)(53546011)(6506007)(5660300002)(4326008)(8936002)(8676002)(478600001)(1076003)(26005)(83380400001)(66946007)(66476007)(316002)(66556008)(41300700001)(54906003)(6916009)(86362001)(38100700002)(33716001)(33656002)(7416002)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kkvufVbdz0k56c20T/bMAmDjWvfrcbtRZuk91HER+8+ttJ4HqSPY4B363ii3?=
 =?us-ascii?Q?ZbyGCqJ/ov0eU3rW2+mCU5dOWjBWuNenaEPlyGXQpWhuCZcRC9KZ5j3yorzf?=
 =?us-ascii?Q?nFCP72pn9jDYKUx526ALpLb3F2pyBdd/WyVZvyIe99nIXAmo9RGsZzKIz+F8?=
 =?us-ascii?Q?4ikgFQO9oRF8LzTp8ZPLqqJ77lXjVqK+1reCeqEIw3XEt8+R6wYaj+m4dPA8?=
 =?us-ascii?Q?YpQZcz9hUFWtwNGl9msgxKCFJ6+SHFRFsyBHDxvNOOM80Y+RNMCZ5N5D5HDK?=
 =?us-ascii?Q?gOmfOUam2z8BumeMJN/7ouTTfmpuiEc0uTxrfXjLYtsdsw4Fw4ArWZDCsMAM?=
 =?us-ascii?Q?BFxxK2fF3UBeCHp48aLPzXlrVMP2oGewxXLFD6xiyWDscKkuektQjF+dB3SH?=
 =?us-ascii?Q?6hEW2v1vxkF+RrR/jjsziRZufZ4LzE9/J3UAe0JLSvgOTSCHu4szuVchqZq3?=
 =?us-ascii?Q?BFqLR9DCmHU3l6LGCi1YiuMK7ThVXY34KnQi9pvLmVLZrQGN1fp8DqrFnncx?=
 =?us-ascii?Q?3blGWVeIfOb2dn7RN6G5kx2kBGnrnJGrx2hbHwnplGMcM2j+ehOqSu46y74h?=
 =?us-ascii?Q?/njpmLrvmKeQZIuCXiTJLW+13qBy2Cb6KJ7CGhYQeuL7bhsYB5ZLhsE/bjaN?=
 =?us-ascii?Q?E5SASQ8UuNkHB7fs+0nQ/HiMklY+75Sw2f/1/Gvs5K1NOsmEH6OVitb9k2tc?=
 =?us-ascii?Q?i+9wmn8zFjiUYzpcbxSpXjaf+eXv0almXtvm8XcNZQRn+UbsPZLo3QPQoaNm?=
 =?us-ascii?Q?le0kcu5Fmqtkw24GOVYn5+nXFleOMPfknjfTLdbVYUq6auXlILD6NzNvmqna?=
 =?us-ascii?Q?is1l0lWXrRHitMUm/cya5HRUAjYAq3LAeHtaszHX7RwOzIshldmzvQVAogt+?=
 =?us-ascii?Q?zmrFJUBXk9CsKftAaPVr90qejik2SKuKBuKyBQNUyiB5SVIlpao/Xk+J/PO9?=
 =?us-ascii?Q?jTprl6YMF3iomMuxGq7fec8z2PNh9LiGEYkkhwUfVzyev9Qs6ZozqJTTGjBX?=
 =?us-ascii?Q?2ca3OA8v8iNmvKFVOprUs1S/OeEPF4XNMhkgAnTw6SoAHEfUvObmcebpmN20?=
 =?us-ascii?Q?8YOi2ftkNU27aQpNXA1CW4Pk+FnQRSHJntWTYXEOnVGpkWu97YQ7gy0j6ZY4?=
 =?us-ascii?Q?+Yc7kxKHIO3w+8728Eez2ibggFxWCbWzAZXeVsjkaOdh8uIMEcpz4fJBgTW6?=
 =?us-ascii?Q?CUHKDlmUp6mHYzcpKioOk/C+o/sp9joYTgv9ObUiVsl/DtMYmLCzvma7B1hV?=
 =?us-ascii?Q?+mmLVVLJecUmYw7LVwC9uiQpZQHdOpBpohcrKsMdE0csn89LwVB9hcUmd8i0?=
 =?us-ascii?Q?YhOXof2G+ywn6HSPuxDiX3BtooGAMWY5lxLlOD8Gg1KLvyKbX2jy9sZEEjmL?=
 =?us-ascii?Q?NhwlFpGMAWP488VbqnjhakOR/FgsnDDRvLvirj5GkOgilPtUS9+zUwEPrghU?=
 =?us-ascii?Q?PpSHCviXi3z2KxwUZ6Yqo+dOn9qvHoEXk3hGIhGEoADlW+QABEPpCpRUbKlP?=
 =?us-ascii?Q?NbO5SwB95/jlwbLXBzG7xPq1Re68+G3A4Pjlnt1miXIlFxdfmPXJ5EmHSwg5?=
 =?us-ascii?Q?Ys1dxGRFC8n6+PNcnldOl0jQtM7uNltgpNLWQ4/r?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nkfipApsnww5thI+FzIlfCAI/Q1JJ6JLzj8c8PNgWbxXkwUgRxfLGVuKE2XH?=
 =?us-ascii?Q?Exl2OfAFU0CVvoOPGSN0xMQPcFSwMmqUi/pEIaFefRyrtMj4rH3oWk3uP0oH?=
 =?us-ascii?Q?u7SSunfV2DCabv8TI4qYyRY5PBvhJUIqrXUAj1rn7YSv+b2B4niI0ni3rWsY?=
 =?us-ascii?Q?wEogBiVMursNWJ8aoGX5b3kxS3aCexBbh3T/2uNIII+lC5IgENI5JVlbwAN+?=
 =?us-ascii?Q?A9DhIwXJpWfT+ZJOQj9P7JMJM0bL7/69Db9d8J9QRrELd9SmbuWMqCJ1n+re?=
 =?us-ascii?Q?L+zduCICc4seNvI3O6M0GNFTj5mlUIf5vBQaqK/gufOzjMkb8vxTP2odx1yl?=
 =?us-ascii?Q?yCMYic9vQgLHfSzp8BCqLhVMpD+ppvi45JuyW2JWDOEKHGGoEeeYZhAUK3ps?=
 =?us-ascii?Q?LaBD+uiYMFbrsUbkoE39ngtli3S1DpT07e1PXAdVN1g6s2PkD0HINJMjBf4+?=
 =?us-ascii?Q?/4OpYzAXQJgpM3B+DO4CNRZFV2+pzvL0yvWE7uAeOLQVeV1S3uqZraIy0di6?=
 =?us-ascii?Q?TLB+I/GII8LWEpPow8xBA9HMYOg0Wrcz4febi5wCtkQ7GXxrCsGTmHWgecS+?=
 =?us-ascii?Q?SfFiU9wr4Iq6csirjmaLVV3jhBQK05eH7vc13gguAOLVtFw4T0FPErW9tqwn?=
 =?us-ascii?Q?mACXyHcBpqbHGM/CNIjwUQtaaf2bxHFd6AKnX2882TEQAETGI9ZsS0rlqWAY?=
 =?us-ascii?Q?RRNorOA8g6LRsy41DV7EE0V5LaT5QpkeDjyLviJT1ys/7/+Mzd9urRmPLI69?=
 =?us-ascii?Q?olsEkw0dGLigKom5JyciD46PgKZUeatyD9lReXuiSEHmqCQEzsEvqS3QcRBX?=
 =?us-ascii?Q?4DvchRmkXIAJNTUfBXNfdir4UrTi8wJi5xaDFkc58tqoet4pV6PZsWU/0Vxz?=
 =?us-ascii?Q?9/qm/vt/GFnAi1UrS495CJqyPVZ4nsnlPz6CJGLfsLk2CGrshiGJVuZQqYmt?=
 =?us-ascii?Q?QIC510EbnlIyMkFA1pL/+B4aOBxUpD3NTyauMmYjnMvpwUrY3VppbZhK+HSe?=
 =?us-ascii?Q?lpIAQWsSDFIZDiwNWs81Q25Db60LDMQrFyx33xYzVYU52z2CYJBi8ESlNTLv?=
 =?us-ascii?Q?z+mEn8qDCg6hulOgpO5e3rJkX4al0wcfE5fQg+j1ay3MpCgTDlOpFWxugc+9?=
 =?us-ascii?Q?FFE8HhDv9yAu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d5f71c-9e04-4b9e-6f25-08dbcec02f55
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 03:21:42.8693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0OvJoapTexPSIxpIY8S5GcwIfB9/IRmL1G8ZoszCGux4q2dyWdHA5hHRP5HvKzfRE4PD8wWOdBvBsgoN+1hUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170027
X-Proofpoint-GUID: 9Rkug1g6hHrObwK8goVyjKBg3ztqDZr_
X-Proofpoint-ORIG-GUID: 9Rkug1g6hHrObwK8goVyjKBg3ztqDZr_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 21:58, Naoya Horiguchi wrote:
> On Tue, Sep 05, 2023 at 02:44:00PM -0700, Mike Kravetz wrote:
> > 
> > Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> I saw that VM_WARN_ON_ONCE() in hugetlb_vmemmap_restore is triggered when
> memory_failure() is called on a free hugetlb page with vmemmap optimization
> disabled (the warning is not triggered if vmemmap optimization is enabled).
> I think that we need check folio_test_hugetlb() before dissolve_free_huge_page()
> calls hugetlb_vmemmap_restore_folio().
> 
> Could you consider adding some diff like below?
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2312,15 +2312,16 @@ int dissolve_free_huge_page(struct page *page)
>  		 * Attempt to allocate vmemmmap here so that we can take
>  		 * appropriate action on failure.
>  		 */
> -		rc = hugetlb_vmemmap_restore_folio(h, folio);
> -		if (!rc) {
> -			update_and_free_hugetlb_folio(h, folio, false);
> -		} else {
> -			spin_lock_irq(&hugetlb_lock);
> -			add_hugetlb_folio(h, folio, false);
> -			h->max_huge_pages++;
> -			spin_unlock_irq(&hugetlb_lock);
> +		if (folio_test_hugetlb(folio)) {
> +			rc = hugetlb_vmemmap_restore_folio(h, folio);
> +			if (rc) {
> +				spin_lock_irq(&hugetlb_lock);
> +				add_hugetlb_folio(h, folio, false);
> +				h->max_huge_pages++;
> +				goto out;
> +			}
>  		}
> +		update_and_free_hugetlb_folio(h, folio, false);
>  
>  		return rc;
>  	}
> 

Hi Naoya,

I believe we need to set 'rc = 0' in the !folio_test_hugetlb().  I put
together the following patch based on mm-stable.  Please take a look.

From f19fbfab324d7d17de4a1e814f95ee655950c58e Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 16 Oct 2023 19:55:49 -0700
Subject: [PATCH] hugetlb: check for hugetlb folio before vmemmap_restore

In commit d8f5f7e445f0 ("hugetlb: set hugetlb page flag before
optimizing vmemmap") checks were added to print a warning if
hugetlb_vmemmap_restore was called on a non-hugetlb page.  This
was mostly due to ordering issues in the hugetlb page set up and
 tear down sequencees.  One place missed was the routine
dissolve_free_huge_page.  Naoya Horiguchi noted: "I saw that
VM_WARN_ON_ONCE() in hugetlb_vmemmap_restore is triggered when
memory_failure() is called on a free hugetlb page with vmemmap
optimization disabled (the warning is not triggered if vmemmap
optimization is enabled).  I think that we need check
folio_test_hugetlb() before dissolve_free_huge_page() calls
hugetlb_vmemmap_restore_folio()."

Perform the check as suggested by Naoya.

Fixes: d8f5f7e445f0 ("hugetlb: set hugetlb page flag before optimizing vmemmap")
Suggested-by: Naoya Horiguchi <naoya.horiguchi@linux.dev>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 36b40bc9ac25..13736cbb2c19 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2290,17 +2290,23 @@ int dissolve_free_huge_page(struct page *page)
 		 * need to adjust max_huge_pages if the page is not freed.
 		 * Attempt to allocate vmemmmap here so that we can take
 		 * appropriate action on failure.
+		 *
+		 * The folio_test_hugetlb check here is because
+		 * remove_hugetlb_folio will clear hugetlb folio flag for
+		 * non-vmemmap optimized hugetlb folios.
 		 */
-		rc = hugetlb_vmemmap_restore(h, &folio->page);
-		if (!rc) {
-			update_and_free_hugetlb_folio(h, folio, false);
-		} else {
-			spin_lock_irq(&hugetlb_lock);
-			add_hugetlb_folio(h, folio, false);
-			h->max_huge_pages++;
-			spin_unlock_irq(&hugetlb_lock);
-		}
+		if (folio_test_hugetlb(folio)) {
+			rc = hugetlb_vmemmap_restore(h, &folio->page);
+			if (rc) {
+				spin_lock_irq(&hugetlb_lock);
+				add_hugetlb_folio(h, folio, false);
+				h->max_huge_pages++;
+				goto out;
+			}
+		} else
+			rc = 0;
 
+		update_and_free_hugetlb_folio(h, folio, false);
 		return rc;
 	}
 out:
-- 
2.41.0

