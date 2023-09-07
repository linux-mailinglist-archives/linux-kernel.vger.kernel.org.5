Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E547797C75
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjIGS7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjIGS7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:59:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCDD90
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:59:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387Ip4UY003967;
        Thu, 7 Sep 2023 18:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=4XK2lQ+O2u4htUt8aQ7s0y+dkmxhiUoywow+Ek/6EhY=;
 b=qDOYlyYNf+HJspieqp7OBr9OJ6yXzotIO7ZyZg9pMXg3ef3NedNwc2wAhGG+yC9wjg9y
 ptQSN1v5/xfZ7rfno4YxjeINHVkB5h/jP9OU1ZoGjqhn6UyH5ZWzj4f/cEgYkHzEyZ9Z
 Yn5CH8ErZwxqweYNWzMkbFzGpKMv5pNXnSHcuPk7jKn+Zb1AklC0y5ZQ2WeZPrz1o5sn
 TiIAFm8Zj1+Z6tGnDI/JJhyMqzBf/eSML++NKvgVJmR+3JU2vAg4jQeA8JoD7h3i0qBP
 k8ccKoKwUVYtqvOJ88HztSNZ2FLLGDadJF23+QyCAU9g0H2jivYCqdAVqVEViiEpov7q hQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sym51g0d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 18:58:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387Imrep013279;
        Thu, 7 Sep 2023 18:58:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugecsp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 18:58:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBBf8wMbSVDxcA+JE/P6zS78lqHP18l21B8LHDgvgGQL2KVEQAD0zaVoiThuMyhi2vvAF6n5XtgDzJCP8fjEUTIFnVBZJaA7ryJyAbDfmqXisy5nKuZDcVZ2Ze4wFLYyq3N+kI9WLLdcLbyuJIWrM1zNAsO2WjJ3s0fm0b3Uh3EmxClozs3DP2ckle9pdN1VuyyfQOJMmmIc7d8GmcGS+kxoYuTbCYqZZYacc9d+FMwCWc4yAL4NnDjBrlLXLOcf3G6v1erTgYWV++THMq4hihzZY/12Dg/uIz5XICpAfJ+0zFvmVSfvK1oqTMkgkCqK/JVkp14FsE5JNkRZXC945g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XK2lQ+O2u4htUt8aQ7s0y+dkmxhiUoywow+Ek/6EhY=;
 b=D+/hf0CzGWd6jGnHnd1NFl6eJlIlBUgW0FUvTtq93nrDbMOKH5am8ftqIJIK3HoZOX/gTrGvGZaRJc8CPJjf1pnOqF+iAQv0ORQhZSD3WZLlY3+CmPWUe0DjnucMC6+3vyl3s9wMIvJBwykDEvHVHSCvfFwC6etbAjAhEbP5p3IrKBHcaiFFZM4hM6SZP/Wg8m9xWBkRDmY2N91OdfFDnS3vl7ZZdT3HAWl2FL9KFRtE1IRZb7CmOS2U+UAXGWgFu0G3UBb4aRHTU/cNjOd7oxkU63z2ukzaejOXWBOkyrGP8PkjXof/Z91GBseikvGL1LJL+5HupGQQOghAzYDj3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XK2lQ+O2u4htUt8aQ7s0y+dkmxhiUoywow+Ek/6EhY=;
 b=Nn7QzR10kHWfi2tUoK2zqSV2v28ynrDXwEsXbbpkfLsoO40L1oQaUtzhLSFAxgN9tJ8fLz3jX1YzDkw5raZS1ck7abaVJSV+U76a6AyOy6jkyZtPG32v6+bsL4ZUjvTiZH8v4wgPUwOZlVNdrQQyEIltwLgNEBazQvYC0z761bM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 18:58:47 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%4]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 18:58:47 +0000
Date:   Thu, 7 Sep 2023 11:58:44 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joao Martins <joao.m.martins@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 11/11] hugetlb: batch TLB flushes when restoring
 vmemmap
Message-ID: <20230907185844.GF3640@monkey>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-12-mike.kravetz@oracle.com>
 <a1008514-b469-96ce-c920-4ef4a3b848a4@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1008514-b469-96ce-c920-4ef4a3b848a4@linux.dev>
X-ClientProxiedBy: MW4PR04CA0096.namprd04.prod.outlook.com
 (2603:10b6:303:83::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB4944:EE_
X-MS-Office365-Filtering-Correlation-Id: 5318f98c-64b0-4fb1-a230-08dbafd47761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: siaOCLf/WXfREPR/oX1boSG/A3Mv9sqrtI06e2rQGkuCSNxUjaHIxUUFKoRxl1wwtAY3nJU83FPnoTTPCKOMY4hkVxmrMfMfg5K9YcYQ5f81tdA9gw02KW+ZocBD40EP3qOG3Ar0CFc7okHULi9vvdezgC+K0JwdnTEkJebsOUQ7RK9EqWLzOSMobFqBZaMYarOFTASRkQnXiDojgIxq5L9LMqGDwweBCkfyEOfoMZq5PkG1rp59z8sMq60DRFfdCRkdZ5X7ncUtCygoQunV4BuS/1MoFREST/mRaCjtOHMJBb87xmUJQd75HzFGBONzAcpaPVQQRpq3Gxx932vPTNu+UsHG18dLptmSjuP5cLY7NKVbPaUBEoI4XZaQNClav0JSYNnSWopNsYHQrT10VAGYuccnMQrGYrSuJkjPVCLLquwnmo9TzmFKuT0//2j4Cuh+kG/Thi4uCp7VoUTgXLU1zNoSNU4R88wxLjyjD8Sa0fRKlQC1cOFLMjCBrznR7KUTDPrhVJx3/e3oFlypQxvjX9Fum17qtxXvEv6FjWORmQQ1kaXJ0yfdKvaAHNuE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199024)(186009)(1800799009)(44832011)(5660300002)(66946007)(4326008)(8676002)(6506007)(8936002)(6486002)(316002)(66556008)(54906003)(6916009)(66476007)(41300700001)(2906002)(478600001)(6666004)(53546011)(9686003)(6512007)(1076003)(26005)(7416002)(83380400001)(38100700002)(86362001)(33656002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2VB65UZ4Uflbz5Si8nfIIe0GHgvYa6U9paLSjYCMZPBgsnxhk28pLzTBP5Ic?=
 =?us-ascii?Q?bBRq3H30W+UZ9VbMi5zHttXH62wTAhVi8ASki2zTxZVEtN+fAqUBI8I+CXKb?=
 =?us-ascii?Q?nLQkH89qgZ6w2Ae7j67AzFMGDE4+LZEFyh/6YQNMeSCQU5fYawEgvxUueto6?=
 =?us-ascii?Q?4rAz7A0aroR3U6xz6ZTzTsJ7vc4Z+sQbzUY6f9b4eCN+vh5wZ2jQGorXjaNV?=
 =?us-ascii?Q?qimMFiVMywEhlHMQln080xI2ahg6aTtN3MxbSSeEHm+KdTfXAw75tCf1nc0B?=
 =?us-ascii?Q?b5ukAXAXukD3hVMHIJhV4j81+QemwiQJHaBLc/TO4F9TjTIBLn60MzMk9zVR?=
 =?us-ascii?Q?UiM65elQPVz5zglfiu6X9YrAvYQsSgm0hQOejbuv6i8axKzyHAO3XTdFjmWK?=
 =?us-ascii?Q?xMHssoBY4CWTbnxmA21hO42cimT9TmrWN8CcoRNN/0jgmVLYxGQTw+QcvgFi?=
 =?us-ascii?Q?BVvpjIy7ZR/U0LWz+7nEPqyuKQ72jKOWoHSjN4Et2dOciH7P1pHt87AIcdnC?=
 =?us-ascii?Q?kKovtkSmr8sR/V1Hn/xM5j7h6ooih6/HX/i+PfOa0eC16FCnGGD/Q7HhvFhD?=
 =?us-ascii?Q?qEMt5OhLOHR6u8dYbl54p9b0rd5FSKxTxOAFPVg1wF77f/Evj6YjgWUB6BNW?=
 =?us-ascii?Q?m/VyKx638B19S92uKYi2E6mK192QUGSMBqy54rt78gLNfOl8zqYTUdG5tuzm?=
 =?us-ascii?Q?21nwB54xdDDD3oA7kKysh4SJSjoHDN9ueiTW5IyUe+UpwacVzNLamGFr8UvB?=
 =?us-ascii?Q?K5VYxVbT6L8aK/PB8+sot4Ae/C0HNWGDCynWWSD/cx5RaQbeMGDFbZd08CK6?=
 =?us-ascii?Q?6Qgjxudg+NuWQhv2/ZQrv9AM4eXxGwF+Qeu4NikXEEYrPmwTB1t0VB6DpYp2?=
 =?us-ascii?Q?e3i2sU1tSgkKO5adF3uYHDIHGH+OFGc+siVsZ60XU8u3WsEc0qM6FmBk+GK5?=
 =?us-ascii?Q?YIPE9QzWKuZPm0HJ5vRD0+kmlXwCZmjoBcZB2zpF13yjtp86xvYkz//rqX7j?=
 =?us-ascii?Q?l7fsO4rJR0I2MTQD3EJyuIS2G3mEJ0OeSxfOwnMHVc4gOqLYN0QlSTEsV1eZ?=
 =?us-ascii?Q?BLWAN5k9ZjybIbet3RWAfJvSq5wipN/d+wH+H4/ZDHzXflbFgM8TBBN8pfwF?=
 =?us-ascii?Q?ot5wvqJbZ7vfc/JCl5MYz6Mwzgbo9YgqA9ybrQavZN0NA0ysTVWszZYY8Yih?=
 =?us-ascii?Q?pWfQOElQlI3TUEMMD/w0vQ/33u88osBQf4gd1bm1l08mgYu0vwo+kzR/9R/o?=
 =?us-ascii?Q?Qve56ma/BgzuigXhZFbYeVP+/kR6LoNux4zReaee8a/7Gmpv0JpU4QixmPtJ?=
 =?us-ascii?Q?aEfBr5NSBxuIjUjLpV1JmgQwhT+HHIWbnUoZJOPdu/2fMtzxzRyC+cB+Bblz?=
 =?us-ascii?Q?8UNHsOgh2Zio9dpnuh0oDO4FQCHwB349zgSufhdhKtsVehrYsXjwIqNknKkn?=
 =?us-ascii?Q?4MoKi+asCvJ3PmHjMV6AlEj9ejITXrL2NGOwb3uOsxFHv8BZGz7oJjB3JsZC?=
 =?us-ascii?Q?e4CN5Iq9sjOWLN0ibYL+2ZZDqYt25gyI1vx/9YprWdHSha3CShbhYdRjgGW3?=
 =?us-ascii?Q?G0h9OB9uMdvyw69/GFkRJxFvhO8GjlPWsQiggWqYPbwuHHV86oNhT8qS+zma?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?afhSIL4fvNpm8iQDud7DUGWB+iCU366hh7GQxOj82coU54Je63rX2uzyrtwb?=
 =?us-ascii?Q?c6uN3zzsI0n2sCAiGyiAGirNIgYPlqg+ChQiOm7j4IYQQJVjO0P2hrQzt1hQ?=
 =?us-ascii?Q?uJRh0br3oJMOwWaEQy+wCBK5f9AMyDo38CmT2TcmgmFDb7knBUWYUk1mOy5a?=
 =?us-ascii?Q?2bJXtuD++3yvxIws1tjG6zyZ+z6m3d9NvfiYUiP25GbTcL45Tt+PLerBB/nQ?=
 =?us-ascii?Q?JF7Zbnm4r/wU/sZsmgC53f+7lajofUIy7PwtqYtIierBi212qMaPi2TCUgcb?=
 =?us-ascii?Q?ilEbwWJP3Pfj8crjce95VfMSYL5HgD5JDI+jW8R42maK5WZ5JX8iYlyxzDgz?=
 =?us-ascii?Q?chkFj0Q/uQrSytAggCzMzMbyvRU+pc0lSYu+N9XNBoGTdM8XgMqFVEZyz0fJ?=
 =?us-ascii?Q?NkE8sC13CF0vZaXuEjmysfsGbGr/xP0QI8QSwYHSL15ybO2GN4YVms8g5oTI?=
 =?us-ascii?Q?TSXvSlaNuOmSL7pyt0fa6imsFFlsRvFcDemjnmm/QJ0qFZA/gqLZUr5BDr4t?=
 =?us-ascii?Q?OBsUmNnGvaLnXETleDh7ei1mB5GtCwGj69nRZEx9ipFF40urD3fm0/upbjTf?=
 =?us-ascii?Q?O+JZKqOT7BB6cuWxyF2wf8dlnu6tfgqYGJKVnFfyPN2KDJa1+PckTokEtwxP?=
 =?us-ascii?Q?9WHJiamGxVc/P5Bz8M3yrWfeVwRsGs1Or4Vrck4ZftodwxIHUilZwQCMAait?=
 =?us-ascii?Q?kHHcAhV9oaR65Sx0enyxhN+GsA6wiWQNVquQarKe/cgtwXcMW3Nqu/s3Xqrt?=
 =?us-ascii?Q?Q0FeJRbDujgTZ2UqReyTkKf7uDCcPL/Qks3PaBcJsLSUAZDsYK4Fe6C4G7yH?=
 =?us-ascii?Q?/Bsq48vRxrZkmi5CJ6rVRTKZV/JY0WuVpfyQC06qVpSwWjlX39h9VtujQCGa?=
 =?us-ascii?Q?cws+QLy6No/OHobqz/oKIC7AsEzIzNrmG7ENjC8I+D+uIm6hCa3JyXDXhJ4+?=
 =?us-ascii?Q?W9cm9rwuO7DZDXtNfxqjAfehBly1BWcFBG+5gXh/koo95Sa1Mw8qd4uPexl7?=
 =?us-ascii?Q?dXYMZ4ONyG7O5t6bQlyDmriFtX0AFzoDde3HV03bIT+tWjYWXLv1bbTOYYof?=
 =?us-ascii?Q?yUrGbNpEDYgy+7hjioAHUu/nSp+XZQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5318f98c-64b0-4fb1-a230-08dbafd47761
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 18:58:47.5071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YemXqaObd2sn8L1yo6vbvOoTVP6FV/m9d8z8jfzTAbAky++pC/gWWUpYPfWf511LzJ9RTAJ52GxacmaH/fDO4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4944
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070167
X-Proofpoint-ORIG-GUID: CeZUgS0dlkFQt5oSInELCOSq0-7lQLvS
X-Proofpoint-GUID: CeZUgS0dlkFQt5oSInELCOSq0-7lQLvS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/23 14:58, Muchun Song wrote:
> 
> 
> On 2023/9/6 05:44, Mike Kravetz wrote:
> > Update the hugetlb_vmemmap_restore path to take a 'batch' parameter that
> 
> s/batch/flags/g
> 
> And it should be reworked since the parameter has been changed.

Yes.

> 
> > indicates restoration is happening on a batch of pages.  When set, use
> > the existing mechanism (VMEMMAP_NO_TLB_FLUSH) to delay TLB flushing.
> > The routine hugetlb_vmemmap_restore_folios is the only user of this new
> > batch parameter and it will perform a global flush after all vmemmap is
> > restored.
> > 
> > Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >   mm/hugetlb_vmemmap.c | 37 +++++++++++++++++++++++--------------
> >   1 file changed, 23 insertions(+), 14 deletions(-)
> > 
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 8c85e2c38538..11fda9d061eb 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -458,17 +458,19 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
> >    * @end:	end address of the vmemmap virtual address range that we want to
> >    *		remap.
> >    * @reuse:	reuse address.
> > + * @flags:	modify behavior for bulk operations
> >    *
> >    * Return: %0 on success, negative error code otherwise.
> >    */
> >   static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
> > -			       unsigned long reuse)
> > +			       unsigned long reuse, unsigned long flags)
> >   {
> >   	LIST_HEAD(vmemmap_pages);
> >   	struct vmemmap_remap_walk walk = {
> >   		.remap_pte	= vmemmap_restore_pte,
> >   		.reuse_addr	= reuse,
> >   		.vmemmap_pages	= &vmemmap_pages,
> > +		.flags		= flags,
> >   	};
> >   	/* See the comment in the vmemmap_remap_free(). */
> > @@ -490,17 +492,7 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
> >   static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
> >   core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
> > -/**
> > - * hugetlb_vmemmap_restore - restore previously optimized (by
> > - *			     hugetlb_vmemmap_optimize()) vmemmap pages which
> > - *			     will be reallocated and remapped.
> > - * @h:		struct hstate.
> > - * @head:	the head page whose vmemmap pages will be restored.
> > - *
> > - * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
> > - * negative error code otherwise.
> > - */
> > -int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
> > +static int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head, unsigned long flags)
> >   {
> >   	int ret;
> >   	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
> > @@ -521,7 +513,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
> >   	 * When a HugeTLB page is freed to the buddy allocator, previously
> >   	 * discarded vmemmap pages must be allocated and remapping.
> >   	 */
> > -	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse);
> > +	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse, flags);
> >   	if (!ret) {
> >   		ClearHPageVmemmapOptimized(head);
> >   		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> > @@ -530,6 +522,21 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
> >   	return ret;
> >   }
> > +/**
> > + * hugetlb_vmemmap_restore - restore previously optimized (by
> > + *			     hugetlb_vmemmap_optimize()) vmemmap pages which
> > + *			     will be reallocated and remapped.
> > + * @h:		struct hstate.
> > + * @head:	the head page whose vmemmap pages will be restored.
> > + *
> > + * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
> > + * negative error code otherwise.
> > + */
> > +int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
> > +{
> > +	return __hugetlb_vmemmap_restore(h, head, 0UL);
> 
> UL suffix could be drooped.

Thanks, will fix both in next version.
-- 
Mike Kravetz
