Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BE7793325
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 03:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbjIFBGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 21:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjIFBGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 21:06:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6289F9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 18:06:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3860tYnL025637;
        Wed, 6 Sep 2023 01:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=kaNyHUGUhkw0/sJfsJv9ttYK6592u5qZ7ztRd3HNbx4=;
 b=LN1Vxdp84bNjEQvkv0pVqM8h7JYSwEDRnE9y5qP4PX8/KraLj2HkNdDfKWRQaRYMQsWT
 itl+fU2Ni9XipBWAUeQeFwBhlZHelmvtlf2UzxsmzyzjaKV8hFrfUtWL4EyW8P9w15uR
 sa/75IqCM4B3IgpUoI5f4g385rsPQ2c46TSasbq2AU9Ip6DWKyaTtYKLe7vzNlz+ZqSV
 +06PW5AJLdWVB05jg42u7gZhESXr9V7Ly0GZQ+GK1SJduOcHizuONCEtdLEHWTrB3V1X
 d2ox+hGvLn3FmKLqwZ28OsAe/h72JV7hotrGrh/j3XD/2jvl0uilD/1ZtW13w0VwHwqd 1A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxf9xg0bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 01:05:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385NiJII007675;
        Wed, 6 Sep 2023 01:05:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suug5j023-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 01:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFER3KRB1v/x7e4ZehGoE61gQfoj9TkFfhggvKNWEYFqlhAS3WiNYdQ5B/MHAIPfhC4deaycyuf6lV2yPUIJE3VtFBFrapje14DbpNaENj2I82FKAGfEgmYwFZ0NQgBhNP5S7qv7DQMF2pSbSwnSTbcSuw6bsSrTkR4f/QiAx1vHop+zPLbHjkQ5pG/RV4xFbITUWPtEslPqCUKP6S8MUFwAMIkJ7XGnW/xPTC9j8fJfKVIHZSBBJYhvaSRXM8OOeFuJ9rcziS6Xj3vKUqrj743a97VH8VYOfnDQ3BQ5oWjItv3hEGkn9lA8TF3Euz9pvIWpzErLBN5H6PxGzv4+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaNyHUGUhkw0/sJfsJv9ttYK6592u5qZ7ztRd3HNbx4=;
 b=WwJnGSmhmtJ3nml+BOaZyUP0YYlbIInHaR15y7AyUVelSnse62V7SeRzQUQwwmhnQ6/wWNsdK0w1i1aCnXn4SaLoTeFZLPJvPXRPYUb5J8G6hoEDgNxjuWGu1WYLMCT+Zi9f99OM2/dX8Kp8y/2xSpevIRZNZ7M1P7XbPYj14KJPlAHjA9xX0ctFtnOJUx/oVIm/qPt7WCIeuSFeAsxlF/6niypjOWP+YjazbuyzVIET0xF3oH1/OpSzaiogxLDBBCnFNf/8P8vN1sMFA014b4YiPMsvUUhnsl/cpO50IdypL8PlOOIHyYWICzh5+OzfcgaqYr3eA5JQcdfBLP9cDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaNyHUGUhkw0/sJfsJv9ttYK6592u5qZ7ztRd3HNbx4=;
 b=HwgvQHb/ZdcFaPe8LxUyiLMTpZtmM8c+L1ounKwRAig9BLrTkp8Lnx4d/Le4TJ1Dc94GRcgqsOxofFDHe7oz5bcC5Ix0SZ3DRVPfRcvIghyivLnev2or4302bGuCvETeSka0C6Tj3btmsw2Fe53KiYknVSk78CZPMIQ40XVdqUI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5615.namprd10.prod.outlook.com (2603:10b6:a03:3d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 01:05:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715%3]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 01:05:09 +0000
Date:   Tue, 5 Sep 2023 18:05:06 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
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
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 01/11] hugetlb: set hugetlb page flag before
 optimizing vmemmap
Message-ID: <20230906010506.GB3740@monkey>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-2-mike.kravetz@oracle.com>
 <ZPfMds3PloTLeZPP@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPfMds3PloTLeZPP@casper.infradead.org>
X-ClientProxiedBy: MW4P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ0PR10MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 3122afd7-0009-48d2-fc73-08dbae7550b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULWI2yd30mD1tplXx5YDw5bkhRaRXSvdtYB/J4G81fFA5/JjPpcVc8eHgUjtc78RK6psbaCfM015t4Hyn9KI82Eud8WkwnMRzablP9tf1rjwUYfKdpEQyOGY5LLgyqm5gPy7Pv9J7ZvkNzfcUnBvY+bX9S7a1tBAASCCyJ8a2WyW9ELWUsjRy7tFK2rapWr/nyf1KZR5+53AaGXLINnfUSE9dO0GlgT61R0Kmjizh7Vf9GCQ0uSK77JmOtES3fujE0Vd1hlrr/Ct0kfrqcmAT2TzInXPaBdn7sIdWWxWxkyMvdVN9lnx1PR8CCA3i7z/AjysiUVOOj405WHN+4Vnn2QCLwWjCpjjHP7YeIS2Qpx1WY5uk+OFhgn9KL9TZnWKZy+pn1kfLJzssy9OzMlZ2opsoSCmmSJWgULEFvA+CWD5GHsV1StlkqaGTu415wNz5js5pWUy7Ut1VZC8+yGnOYplLe248aC5l6Q0hFKeMZ11XNbvWp3nB98WeA4LJ2PtUUtbOzX6VAPBaagulnTiFK87xI8iEeC19/wwu2xwhPh8wMfadFPA0sb0LEksefRh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199024)(1800799009)(186009)(5660300002)(8676002)(316002)(6916009)(2906002)(54906003)(66476007)(66946007)(66556008)(8936002)(4326008)(44832011)(41300700001)(7416002)(6506007)(6486002)(1076003)(26005)(9686003)(53546011)(6512007)(33716001)(6666004)(38100700002)(478600001)(33656002)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MctkqYJDcItC6VVnH5+LeePYcbesbVVaxcdEPpA+qyIU61LLXXUCybqffxTe?=
 =?us-ascii?Q?VjK5dEniuUWs23LqlSeJTutFz+UrqYVqO0jLUqS5cTJpS3+RAoT1JvGhuXi4?=
 =?us-ascii?Q?HH1MuroziqW4RmkwXXdgP85gI7zJQ+LvqZjIsaMiPSCfWWEYilsZgTzFo76M?=
 =?us-ascii?Q?9zynMvkMvc0+lfXqVHxu5q27NcehKxFCwztKX2r3p0SU+3iTR4bWCCPzO13S?=
 =?us-ascii?Q?6HWzJw7xmUp5XLvHKvFyLNN3VgtTWFxqigFGL4Gin2iKn52SCTMSkiM0i1Js?=
 =?us-ascii?Q?wMYDrYR5YtG2r+bipsAfVKsdUjA03dj9PysrcmcXgHdKblQuA+sI4C+R0gtP?=
 =?us-ascii?Q?Do2vaVgI/UVXB7RCtDQORvoL7RdqUMk+tdM9mjxkfWqfbgfh1lxkjtTzGjXf?=
 =?us-ascii?Q?WgUF4dxfutKD2eb/p2s3oRhrgONiT4dppCL5HoicDgdqlTkmCPm8OY3lJiRN?=
 =?us-ascii?Q?9EqnpxDo81l8XR8HkVCoyCHOeHZQGOIeBLaSt7RwCO/w6ELMeKk6ScE9HqV6?=
 =?us-ascii?Q?OYPnOPPQed/iaqwpu0PzTglox3qhM2d+4Ha+oDr+YyDuUm0QaTE4/bYfw4rn?=
 =?us-ascii?Q?oy7ZbRXwiIbOyOqOkN5dj2kcC69mkoYhUfOrY6VdWRlyVNLFE4vJVIJSCvDl?=
 =?us-ascii?Q?PgUFJpQ2M5nt9sXqViuMf+C/5QmoJE2m8avRjvQCLRObbwYdX2aD6GiZkKTX?=
 =?us-ascii?Q?IWk5tqg9X2IJzOy/tjLSSyr/QzL/z8uuR+e2tTnhkHR1t/5utbThJGFMixST?=
 =?us-ascii?Q?tQKImrLW3sN+ofuX29bpU2b1KjASerE1ANWjumnLxR8ToKCg1nkx6+bPtqjr?=
 =?us-ascii?Q?CDQLoQT+o2DPmbtMmsOvqdDk1HBac/bR+Wu/mZXqBFkQ65pTluy3Iq6DLz9+?=
 =?us-ascii?Q?sAtV3k4Rzm9KEoRz1nzi79Z2Ljh+1ys70C7Zkj51UwexRio22u2DfQwZaU/J?=
 =?us-ascii?Q?I851n6nNdTH3d0y1hAqhTu3msTEN6fnbj1r91PYYwvqjO/Sp4c0l4QTwKXkt?=
 =?us-ascii?Q?bkxbsMdLvz8ztKGveAoKUpivrr71EB+oW4SMwb9wCAmMwPp9KMoicjovFt31?=
 =?us-ascii?Q?3hIyNbADEik1WuyqMFK5VRTg3Qo5uC787Fo3CfKr/xymL+b4YjIn6uISRKDh?=
 =?us-ascii?Q?5BczlEjJkvVteiKOZ5f7HLIAO++dIIYXCf4yDq/uJnFOkJn65W2P/4f4gWuG?=
 =?us-ascii?Q?BxTvh/+z9xe0H286ETOvuWiWAk+ZMXwax1luUyaYJyT+4PSmmKQd5trpfWzg?=
 =?us-ascii?Q?I77TRwf5DFUbeiwHzjdWilQCh4+4DAfwHckFEIL/OLsO5jVuBWXZK+B2fM+i?=
 =?us-ascii?Q?Es/ogWmtvyWpBhyCii/q2LR1XngE8A4tPRAyf8msmBydod8Ov1yisuTUypnq?=
 =?us-ascii?Q?x7hXmhxaLU0uvfi0CsYfHgYy2SK5tOytfjLfFyy8xBheRngsTgKQ9XrFGmfx?=
 =?us-ascii?Q?bLXo4JQ5gQeIrowJAHlkH6kQh+fKeRLEuig9KAAd+lUFFCfzirsKaQd3UDGB?=
 =?us-ascii?Q?jL8fM5tAPPYWYItMITPqU34aVkG8FF8ERy3EfvIejFcv3QhIiUju+c56e2vZ?=
 =?us-ascii?Q?oDbK4lC8YDzofnjBH0pTrE/dze2NkWaDeUT6cnQQIS4USwUeLjwMv6SSZ/iO?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?N2IM/AckzKFeriVAGZjtPxdumG2WtB3MZYWXvkMzBluZIxOSy/3eaQQROIgp?=
 =?us-ascii?Q?GZEc/MMd6JIE+5WqXvpGDoz5oCMdg3nqZMckel9RoTmh6BWlGiii6mRPr6CN?=
 =?us-ascii?Q?SQaFUoiekBrATOZBTw6V9VNej65ktJZmbE5EgHTupDS9tQJNeAjHb9RFRX5H?=
 =?us-ascii?Q?Gcpr3tqUMbFGxBKSL2RcDyMWkjrdaCO8dimMXk6Ic6seQ11hreWOHFeKl3Sx?=
 =?us-ascii?Q?Pg47HBl6MjcA68KfM4MbbfQEz9A6g0Gtp13EYXw5toRZN66zIc4etFwPMrIC?=
 =?us-ascii?Q?7eUlgnBiFcEHbZqzNhSz4P3t+iOP8xj+2TkiWgUfemvXP/2YsL6bGFGoBH08?=
 =?us-ascii?Q?mOdwqLteY1KPxFOe/yi6a349sgU3T4he4ANMHBjQZdkHJcG+GT8y9ciq8VO3?=
 =?us-ascii?Q?JqLWwEu/6aENTmqCSf8P5V06QmQ00caE8asOj/n4rJSLV5A+CGq6H2Ur6Oto?=
 =?us-ascii?Q?wXP/nlx4Wls1JSRiOjMqPC8Xqnm3N1BpPURYXKkG0JqA/3kvLDX0eixIdj+P?=
 =?us-ascii?Q?U6cmB4u4jyz9eOxjHRiNdSYlQyIydMCe6p7ZuYZ8j4uBcHqJfMIeCjLuzRJc?=
 =?us-ascii?Q?afEu7u8uANAVINdY80LGnJSGwWocqlxq1J/SUiwLGPfFXGnoafKg9OfAI5Jm?=
 =?us-ascii?Q?slut/6MUup4Qn/r9VfeFlfjeMTXhxNiNWq65aGvzU085svcZ9JEuk619cAut?=
 =?us-ascii?Q?/jdISijCDeUhz9ZPVY9iG25NYnuxBKbGOYp6s7yev4gNkoJ7w5RYfc61i85J?=
 =?us-ascii?Q?zLpG6TCyFeXc9I2podW+M6DmbEt71YC2ckxn/8f+lETEB17syGVQxReflRW4?=
 =?us-ascii?Q?bSQlbNvTU4bfYxZqZXPSzQ0D8MI1mAgnrcjFpuy6fF186fZtbNsFf+exnri6?=
 =?us-ascii?Q?xzWa2o5hrEMCHfuJO27D3OIPAGbZ0GUI91p3zrYEgc5ug4u3hlKCJB5qVQqM?=
 =?us-ascii?Q?kzBZdAYsuSL4wCGzhVzFDmh5oriilDwNXk55X7vnelJmmWjrjP8myXyn36/M?=
 =?us-ascii?Q?4zUOfBOi5YupDmwDdvyxjSYOI/7G0mJP590GkStSHWLwFB16auxiFjGTKAPU?=
 =?us-ascii?Q?BcsDbHLv5qcbRG4u3inqfRirlE8r4SKbwgl6AMCL5xUAONfOK3raOe/pdSVf?=
 =?us-ascii?Q?gEeDRMji1idY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3122afd7-0009-48d2-fc73-08dbae7550b1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 01:05:09.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNrdhXI3AOe4ImXSsd1xfsoIMYVt4vsgPO7NgOY/3hEtRAVStkEwNYkNE83jpBXxdYZ1LqWIeUj4StMoiAnxNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxlogscore=875 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060008
X-Proofpoint-ORIG-GUID: zn0pbCoBEf2-LtbVS1AW-UJ6pTlzciLu
X-Proofpoint-GUID: zn0pbCoBEf2-LtbVS1AW-UJ6pTlzciLu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/23 01:48, Matthew Wilcox wrote:
> On Tue, Sep 05, 2023 at 02:44:00PM -0700, Mike Kravetz wrote:
> > @@ -456,6 +457,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
> >  	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
> >  	unsigned long vmemmap_reuse;
> >  
> > +	VM_WARN_ON_ONCE(!PageHuge(head));
> >  	if (!HPageVmemmapOptimized(head))
> >  		return 0;
> >  
> > @@ -550,6 +552,7 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
> >  	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
> >  	unsigned long vmemmap_reuse;
> >  
> > +	VM_WARN_ON_ONCE(!PageHuge(head));
> >  	if (!vmemmap_should_optimize(h, head))
> >  		return;
> 
> Someone who's looking for an easy patch or three should convert both
> of these functions to take a folio instead of a page.  All callers
> pass &folio->page.  Obviously do that work on top of Mike's patch set
> to avoid creating more work for him.

I think Muchun already suggested this.

It would make sense as this series is proposing two new routines taking
a list of folios:
- hugetlb_vmemmap_optimize_folios
- hugetlb_vmemmap_restore_folios

-- 
Mike Kravetz
