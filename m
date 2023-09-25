Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE9E7ACD35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjIYAlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjIYAl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:41:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713A0CC1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:41:14 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38OLnhAH028065;
        Mon, 25 Sep 2023 00:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=OP+HI4Dx3GzIthduXhchAaGMojbE9QNz8Df1OYn0zTs=;
 b=Zq57aqcvxjb+HAt5LLm2lXlf7drbgDbAJKcykAVUrZf6K0VUoTxpCxnRqUOs7q/+dW7Y
 7VnPiO/RU580e6gFgJwiTKJxr80EPxarus+oYCSORIINy7WEoFo5tE/QgN9EXfmJ9ejv
 3xF7Rpb9CenAvpJnxi6yTa59Fz4jXkUkxgenmIJzdXIFZGTLqEr91uI7bMIiOvC0hvkR
 qSP+SQSJGgFrgtA3eZNV5Ni8+zADfdiWveudCf2Nh/jAg2v0faSai/W84SiK9Yaore7i
 kqV8BU/aQ8oY+CDS2Nmickzo2ORFQay2+i5am2fb6auI1gVHNcOsZBZkdUIrOoJYAswO bg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm22gbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38P08QcP036610;
        Mon, 25 Sep 2023 00:40:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf4189e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9AtgfQb0LCBWql3DtZ4yjTOM0+ZNUiCg2Lqlm5v1DNwDwSZHu5lqHC/00dOB0kwXdyrC4gjF78YLN7TlVFtkqa3Ra9ux/oaposBpPUXjL06oTmvYfaKES2L+vR77Pfk+wk5SfB6FnES7LCaqqBkt2skZbHLh0T+7PYB99zXNBVEv/F78dNVObYprnmhYQbqxoW0RAG+ikx2ctBLpfw/2lA7DK+xVhv6bHUyFQP0ReqZCNKn2QfVNAydjrudjyEAOQoaXj14kFkLC7sPcdzf2KKd1dla2ThKAWnSiyqJoT5sGOzPaI0Vp3gUik7GfhLnpoz3vxLsf6IG3ASgXmC2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OP+HI4Dx3GzIthduXhchAaGMojbE9QNz8Df1OYn0zTs=;
 b=XOytx3JT8+usVebdL1rJpkddmUbwsFE1Hue2cyDWek1w5K+gqdH9SOOnamhWmJzrx9cjvjeJEWIcbIFJLlB/CCX0lfD1HH3PUdW5MkUSdTbZeHqNIMxK20TKPnP+rmCOJ71YoYA/+PaZ/2063ogxyrVuKqw0Bzc9CGsnYvQ8Hcitjfy/055RvLWch6Tl3yIL3VkSNN+LdazC7gAI+HUGTEk16AIyDaqJP5cCiXgIb1Zd7H/PY/s1iUjKXmLDHXxkQAaioMFeDXtNYQFoId7sO2Y2LmCCG/tWabSgsyolNSmK4EQwzfShwiOAEO9GWiaje9aRBFapb9KjiFl3I5vAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OP+HI4Dx3GzIthduXhchAaGMojbE9QNz8Df1OYn0zTs=;
 b=LQEoN7VxJH0MtcCAnJPUvyknZm0vUFNly/GG/xrxNEGaFeOGjkNVRUnElsmsgImGERwEjtzGgussV2T2ahZbFGIguWBv/Ft43GpQLLC/xQphJhIteSrpwM+Pr6TqoSb5xYyFO6WTtuuOxY8I2YVIN+mAlJUQSOB3HMpxonX8wMc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB7174.namprd10.prod.outlook.com (2603:10b6:8:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 00:40:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 00:40:18 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v5 3/8] hugetlb: perform vmemmap optimization on a list of pages
Date:   Sun, 24 Sep 2023 17:39:47 -0700
Message-ID: <20230925003953.142620-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925003953.142620-1-mike.kravetz@oracle.com>
References: <20230925003953.142620-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:303:b9::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 6246bc1b-2423-4a98-7ac5-08dbbd5ffe24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/CH5T7HWeaVi3xIPRqyOel9MhSqRbXSbEHIucBZKeUCjq5qHTY4I1BfqPhL8PBimjMdCVX17mswbLTI8oa47yDnxDJx4eegvq5SfaUvtqPgST/pHmWIm0ED+j/+YhH6orby7Cb1oRdlzgEQdsBF+/020XP3vPjhCqvoGQh/3BEaPlyPsI4Ri4XU/zI++2ySSXtHOYesuzuvtbuIMbPpfzxKKedIIn42LD1q8WNAnRncs7Ysvk1+oGEv/q4AhXUb1cMuSYKfkktgOqL4OuU2Arsw1rkAHo4rWcWUPcTHLVvYrqAK18YxurMfUGy5tLoyHM6VdvQ5fN2CPKO0+DMoJHEivXYgU4f8EITIKhuWWvrmYJjj+Im5z3uPiZcRkCBT7dgtgwHm0gbByOb2uP3J1UrBN1OoJYw37tOOzU/LL2X4eMeAuwkSUfDvcu9mQ3oG9FE6hK08c7/4ajwjmMZQ0ZMau7SbLH4qD3X8KoflkjOlZtgW6LqzZ57uSm46++VpwYXQxfJ/B1IPra6OymwMYyGPiiEf60D99eDJegco4o89CyVWSoB25Rum05MGvoAn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(186009)(1800799009)(451199024)(6666004)(478600001)(6486002)(107886003)(2616005)(1076003)(26005)(83380400001)(36756003)(86362001)(38100700002)(5660300002)(6506007)(6512007)(66556008)(66476007)(54906003)(66946007)(316002)(7416002)(2906002)(44832011)(41300700001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xzuWm6g4P9gJCcq0IjWjNymgCMafHMS/T5jshGvV4+I0HsrAcBuZIzNk1nMF?=
 =?us-ascii?Q?3fasB9GRikG/aYFgzlfk0TT3/vBj07p6MENqelf48eJ3JqH5WVB2cv4CSTZ8?=
 =?us-ascii?Q?VFemgZ2hhIqbHU2HmlT2voo9hZAFBul+ukm7Fw8pORBec1TdDl/vYIp4urFX?=
 =?us-ascii?Q?J4++GVl43GWov+Qc0mjTi+64jXi6+H+JFzhLeC1dIGtiSJTqbVec/XxxK801?=
 =?us-ascii?Q?CtGce15W0XuBJgwrOFZuABa5zuxz2yb6wy1LBjQbwK8WgUABHr45/lLRQYlo?=
 =?us-ascii?Q?w4Gf20c0T1HMnRc1Iy7H043Zn6t6Fjt7ctpmSKlIadEJzCFzBFWh7CgNEwXc?=
 =?us-ascii?Q?mVsfWtJza4qC4jO4BFxIsCI2qfXs3ra6WS5+ruXQ13al7Xb67XZ9WDkg5EnI?=
 =?us-ascii?Q?p/DvPftlv7Gj1fyfgTEJT3FnAjwirWY246YUP81jrlEyys1w475Lf+I6AoGt?=
 =?us-ascii?Q?9oj45Ki0fAD7bhwQF4yQNg+wf/tpkDRWm+HeIKgSJQG8awSegB7OVe7KdIAQ?=
 =?us-ascii?Q?NF5E88+WMxMHMhJsLd7ZNVw2JXWsCY7WEmYmNY1KEm515m0KalSXKdLIW8aV?=
 =?us-ascii?Q?Che6Scj0tdoazYq7QzYd1IsNDmVqugT++dDgQORjHGnGavMqrdIjyvDhofTF?=
 =?us-ascii?Q?rq8W2+69VcrFBwK4XyGuZzU9UlvHo3ARDquOExCk/QUdunG5H7BwdAiafQ5x?=
 =?us-ascii?Q?437oQ/2r8U7pbl+WfDOq1R485TYwO6OwAEBt3UkapdWNI4VoDMkaBZDe/ZOX?=
 =?us-ascii?Q?IiOYf5eVtVOR6P4vwkuASQRhpYzxhmfMbp/JmOEkS8vFyJukLeet5l6yCm1P?=
 =?us-ascii?Q?kDkjly5LfwIF+gVEAwV+jHgbHBzFRYxavIX78FBVC+l8zL7MfTNxovsDM6PW?=
 =?us-ascii?Q?z4uTIKfQieAiNFiDG8+FYnbvqhGWsfInjyLNGcXywIIv9Orwm4cDYmNCSPMT?=
 =?us-ascii?Q?nkZ0wV1+/PqMK8ApBCxgy7SrecoS9nrjQX3lFHHD4bQ5CcRcbY/5R23lMAwf?=
 =?us-ascii?Q?bNX63Hqo7VB0mfvEjJ7839x4TtB6U+dcSRppfFEFLJY59/ha7+jJ4/6YY9d9?=
 =?us-ascii?Q?vgHXDt0gs2f8UgUgH1A8jzahuEnazSl0ORssBOinueNp0fe51MDmv7X8UwAV?=
 =?us-ascii?Q?g3tmCtJ7Qs5FK3fx4J9if+5qeTNuQp/iH1T8MIexXuDPb+A3mS/hmaZNKR36?=
 =?us-ascii?Q?KqyK/DmLRwYrhlaj6N3CeHPYCopqsrXHyQdxrt7ClziEjFrIwGVklpQHsOIc?=
 =?us-ascii?Q?8GZUzZdnrQjHTZ1JGXUdi789Ow+9X3M+xt+4T/DGf619vGVkmfL5Dj2eCYTN?=
 =?us-ascii?Q?eC6hmY+xSYYwFZlTavYhHGTQlJIHvr0wrgM7ykS7d1TBv9uUrPLXJ3dkG+PK?=
 =?us-ascii?Q?FQEkC9vea4aYYvST4xi3Q08SW/sUAqlkHj6XBfwP4W7gIXJzhv4zerdVQOSM?=
 =?us-ascii?Q?OEhWMTVT3iqwFJI4GEb5LMu/9mT2FWCcfHlF2sTFdjn7gH1yAUm5dmlAA0dS?=
 =?us-ascii?Q?HNPm4dx0sQtANHxCZtWWAl3PA3pRpFJSjuhCgkPx4erZ9e02JUj+xQpxdnho?=
 =?us-ascii?Q?+mG/8p2H5V4fMEScTmVko+cVVBhqF7O/QttF2GF0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vzhDeaXjmQapCNu59SMJ0POiAwZdCzkhuJXMf5D+u5B3O+/w1OtQEmqUbQ7r?=
 =?us-ascii?Q?oKi4SU38icTrVeXwtXQIm1S77riK2O78+xDO9yorHjcLDILoYolJ0pxEhMzP?=
 =?us-ascii?Q?K7y/ZTxbg3aAE9VtQdxuegv7RQHvThpiAIA4g78Cc66Y2w+0PricFb4SpEKl?=
 =?us-ascii?Q?8XVcrLXiGx/D0b5kqXwOE4JeHz0dVzIEsqZw88AEisXlLJSHwK4p7Gk3DYfi?=
 =?us-ascii?Q?3JZe2ZYCYyR1mZUtaZcBdAOVq6purCOFsjpX4emZOffrwYO9HL7UPs58PyCZ?=
 =?us-ascii?Q?tKb4LHGNtuXRLL5XaHuI78pufvKGkPTuqN+yJwM6lIk1t0Rc8z1nhPz9VDbg?=
 =?us-ascii?Q?YbGVAz/6tDsxH65xMvaa6UK0p+M4s9PDs/ZQVd9Kom87sjq+p6wWpRgeFfFv?=
 =?us-ascii?Q?/ZWtlStH5nc93SJ0pUh0f3PdKrslsM6aonOXOLF0Fd2QtPuo9fJHJHhqgJ3H?=
 =?us-ascii?Q?7BjSIWtsZvAwrutZU7Cz5HHuTcabEPdcGRLgZ9x5FnLj6EaZCcSCqbFvemLE?=
 =?us-ascii?Q?eAJKcvAuZFCX94O73efi6G5fxwn3UN0e4g2V9CG+Uf4sA+mVqtGNq30yijvh?=
 =?us-ascii?Q?XD9cNj8MBEgQFxYzxk/AWeCg5FeRpmamlRxOhYf8TWByoUZTXwQfI2XceHy4?=
 =?us-ascii?Q?J0Q4LvaOnek7yT96GTkrm5Aq/sG/YgcsYYMaS5t5yl+U6vOXUZNiHONiO5gc?=
 =?us-ascii?Q?ASD7YoEEiwPmYfC1nJ1GHGT7O5PMSIWzEMT80Rp4OjFXAEaijc5KcCL6JaxX?=
 =?us-ascii?Q?qTCqRQmTRsk9ldW4xr7aaZ2q03pbVSFccrTxMeVrh0BUDrP4XS9bJzLLRj1U?=
 =?us-ascii?Q?5PHE1GS5wL7abLViHYWh/pWN+fx6U86Ng6YMFnRRgGz7dp2I+3OSyeZZF/Fe?=
 =?us-ascii?Q?l83rs+PidG/LqP7znWmfQMQfuuqzuKx+vF2YL7s5xzrkL/2hhvMqYZJugWCc?=
 =?us-ascii?Q?6o1lzW2rA91HDaP2tR+icRKA2zSrON5Y+vPc5pk1Q79XVOm/FZle3P0c9AME?=
 =?us-ascii?Q?7Z964TkgAH3+Nym+iSrM0McQfO+319zfQGAgZrV4OFE4N/OTrBBJB1ubtZka?=
 =?us-ascii?Q?jYLYgqujhd/B1z5tRpeofuZGw2KiDy/3Q2k83lJ6tAATodcEC1a20jvsBAr9?=
 =?us-ascii?Q?Lg+utQ2jMP6c?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6246bc1b-2423-4a98-7ac5-08dbbd5ffe24
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 00:40:18.7828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nny5f5EbPAH42zElviylXdVDTjlj7cyzKkLshO2aq9oU19pTeNgFUKhhQZOUmlUcKwoomtURqtJrUCVdpjU5Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250000
X-Proofpoint-ORIG-GUID: dE9xvf161eH_uNoglxSDdfY0ecc_L7N3
X-Proofpoint-GUID: dE9xvf161eH_uNoglxSDdfY0ecc_L7N3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding hugetlb pages to the pool, we first create a list of the
allocated pages before adding to the pool.  Pass this list of pages to a
new routine hugetlb_vmemmap_optimize_folios() for vmemmap optimization.

Due to significant differences in vmemmmap initialization for bootmem
allocated hugetlb pages, a new routine prep_and_add_bootmem_folios
is created.

We also modify the routine vmemmap_should_optimize() to check for pages
that are already optimized.  There are code paths that might request
vmemmap optimization twice and we want to make sure this is not
attempted.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         | 42 ++++++++++++++++++++++++++++++++++--------
 mm/hugetlb_vmemmap.c | 11 +++++++++++
 mm/hugetlb_vmemmap.h |  5 +++++
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 64f50f3844fc..da0ebd370b5f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2269,6 +2269,9 @@ static void prep_and_add_allocated_folios(struct hstate *h,
 {
 	struct folio *folio, *tmp_f;
 
+	/* Send list for bulk vmemmap optimization processing */
+	hugetlb_vmemmap_optimize_folios(h, folio_list);
+
 	/* Add all new pool pages to free lists in one lock cycle */
 	spin_lock_irq(&hugetlb_lock);
 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
@@ -3305,6 +3308,34 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 	prep_compound_head((struct page *)folio, huge_page_order(h));
 }
 
+static void __init prep_and_add_bootmem_folios(struct hstate *h,
+					struct list_head *folio_list)
+{
+	struct folio *folio, *tmp_f;
+
+	/* Send list for bulk vmemmap optimization processing */
+	hugetlb_vmemmap_optimize_folios(h, folio_list);
+
+	/* Add all new pool pages to free lists in one lock cycle */
+	spin_lock_irq(&hugetlb_lock);
+	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
+		if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
+			/*
+			 * If HVO fails, initialize all tail struct pages
+			 * We do not worry about potential long lock hold
+			 * time as this is early in boot and there should
+			 * be no contention.
+			 */
+			hugetlb_folio_init_tail_vmemmap(folio,
+					HUGETLB_VMEMMAP_RESERVE_PAGES,
+					pages_per_huge_page(h));
+		}
+		__prep_account_new_huge_page(h, folio_nid(folio));
+		enqueue_hugetlb_folio(h, folio);
+	}
+	spin_unlock_irq(&hugetlb_lock);
+}
+
 /*
  * Put bootmem huge pages into the standard lists after mem_map is up.
  * Note: This only applies to gigantic (order > MAX_ORDER) pages.
@@ -3325,7 +3356,7 @@ static void __init gather_bootmem_prealloc(void)
 		 * in this list.  If so, process each size separately.
 		 */
 		if (h != prev_h && prev_h != NULL)
-			prep_and_add_allocated_folios(prev_h, &folio_list);
+			prep_and_add_bootmem_folios(prev_h, &folio_list);
 		prev_h = h;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
@@ -3333,12 +3364,7 @@ static void __init gather_bootmem_prealloc(void)
 
 		hugetlb_folio_init_vmemmap(folio, h,
 					   HUGETLB_VMEMMAP_RESERVE_PAGES);
-		__prep_new_hugetlb_folio(h, folio);
-		/* If HVO fails, initialize all tail struct pages */
-		if (!HPageVmemmapOptimized(&folio->page))
-			hugetlb_folio_init_tail_vmemmap(folio,
-						HUGETLB_VMEMMAP_RESERVE_PAGES,
-						pages_per_huge_page(h));
+		init_new_hugetlb_folio(h, folio);
 		list_add(&folio->lru, &folio_list);
 
 		/*
@@ -3350,7 +3376,7 @@ static void __init gather_bootmem_prealloc(void)
 		cond_resched();
 	}
 
-	prep_and_add_allocated_folios(h, &folio_list);
+	prep_and_add_bootmem_folios(h, &folio_list);
 }
 
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 76682d1d79a7..4558b814ffab 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -483,6 +483,9 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
 static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
+	if (HPageVmemmapOptimized((struct page *)head))
+		return false;
+
 	if (!READ_ONCE(vmemmap_optimize_enabled))
 		return false;
 
@@ -572,6 +575,14 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 		SetHPageVmemmapOptimized(head);
 }
 
+void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
+{
+	struct folio *folio;
+
+	list_for_each_entry(folio, folio_list, lru)
+		hugetlb_vmemmap_optimize(h, &folio->page);
+}
+
 static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 	{
 		.procname	= "hugetlb_optimize_vmemmap",
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 4573899855d7..c512e388dbb4 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -20,6 +20,7 @@
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
+void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
 {
@@ -48,6 +49,10 @@ static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page
 {
 }
 
+static inline void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
+{
+}
+
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
 	return 0;
-- 
2.41.0

