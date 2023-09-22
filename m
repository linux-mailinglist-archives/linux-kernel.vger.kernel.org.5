Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD8C7AB773
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjIVRaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjIVRaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:30:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB7310C0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:29:21 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MGOCbX004624;
        Fri, 22 Sep 2023 17:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=kBeOuTNNWzkO7tPTNzkN/y1eprGEpXsumRaVcRPOlPk=;
 b=KX/In/1v2v/7sav3sq0jB7TiYalBcDbVc/soZNhlZpDq+45SMbOKf/qTHuyPZxEbPySI
 Sy2dJwwKBITw29rmk2xTMbG3LJsxnhG/OnB/l0s3w0iakiWR7A8K9PHBJiekz6FD1Fh+
 NLdfFSQEYCjn8yZoJKEadUdxCc5JpoxruCoNYEw1x3/AM+kAGWShm7UZPDZysAeGK3s7
 /Ap5s2DYiG6xpx13sizvCfyqPPuZdAGzOj4TDUckZCpBbvkXk2+84UJMELMw9W+2SZuv
 cJvBFjCqIZmA2MllwlarK35y8uvPvk5UgZ6OeweljxFAVf5zO5lnp8N/m/qY0qpx3L8/ uA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsxtb8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 17:28:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MH1dkr016701;
        Fri, 22 Sep 2023 17:28:31 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u0vce33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 17:28:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA7J6i06HB4lyx0WJLH7DELeHNp1GmxhgYYxR5Xba54SPmT/g6Zuj8FdxuHRTDVxaPo9pnIG6HeJadP1nESirQrGn4uSzA1CcO51vdLU/JFjF377G761WKysy9ruD2YG7bSykzc0qGSsm9PGFD5LZ/1ZKcBopSVRnq+rWJWWZLwB0P9BE9kwwCBmdrTerJu3Z8nhQGc+ak5kGWiekEZ9wesVjJbvV8UGfOeHhmUbOcHiYmMl+zNbs6+9PYBvr3QNLMfTxFNZHIxBCyJiRwR8JTdTpSOBJrHoNfUlTBepa2HS8LrxjL4t847Q27vBf7DbmKnaXNuVWKRrN/4Medb5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBeOuTNNWzkO7tPTNzkN/y1eprGEpXsumRaVcRPOlPk=;
 b=F54B5RML1dm+uyUpA3k4t7U+xSrkbEJVmp6CAgFV1GrKcI/6egWaecEUuiK5QLIDN3nPipVezIpcyVx3KotgjQpVk9g7yi5q61LR7SqH2Ez/qxZuEOkJokRiBvn/+LuA92flrN2hrCCZ9EYvUP0q3pVihcoZj0Jes4AoFJaXDcGEnF0/X5gcdwNELLu9P3+izdjnuQ4+kziP9d/2GJmk6+v5Ijy1WvKCH2oTAY0p3sW8khb9pGzWm8+pMH1u2kbqjUbKXgn7tU8/XixD5TP1Cub+n418Qn4zYeqNjUY+GKKmW6KrZktUFTJbh4PdsQZOA7gSrr19JlkwI7RE+/rHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBeOuTNNWzkO7tPTNzkN/y1eprGEpXsumRaVcRPOlPk=;
 b=seTuOX9cp92JcItUA2zEYAEnuLdY+0FTSsvprxYNVBiMpfoiTLuqCAkz8tlP/f6EuDMifQVvcboWDC4idVq8hARQwoH+bg8Wk8PTWdG7MYmy1ATGremANcNUhalnvdPUvc3VYoSyZzNgrejNs7Awqj8CsHb9CbdrqFr8PWqMCuQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.24; Fri, 22 Sep
 2023 17:28:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 17:28:27 +0000
Date:   Fri, 22 Sep 2023 10:28:24 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 4/8] hugetlb: perform vmemmap restoration on a list of
 pages
Message-ID: <20230922172824.GC224968@monkey>
References: <20230918230202.254631-5-mike.kravetz@oracle.com>
 <b9d03e01-7582-8ec9-d219-941184166835@linux.dev>
 <20230919205756.GB425719@monkey>
 <CED64A95-00E8-4B52-A77A-8B13D2795507@linux.dev>
 <2FDB2018-74AE-4514-9B43-01664A8E5DBF@linux.dev>
 <20230921011223.GC4065@monkey>
 <306da2a1-0dd4-e858-930f-211947a466d2@linux.dev>
 <20230921215810.GA21193@monkey>
 <7f222dae-c256-a625-6846-dd22e16687fb@linux.dev>
 <20230922170101.GB224968@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922170101.GB224968@monkey>
X-ClientProxiedBy: MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5134:EE_
X-MS-Office365-Filtering-Correlation-Id: aef53563-061a-4f72-2995-08dbbb915510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pd5XAbvW2hxj7liZUhTOvUsJmDyTxhP5hICLkEtIjkJzFavFKYLuMhQjPPwSL2f+ryaujjM555lXf3f8xGTkm+SwsZawXwnLPqEjf5pvauufaT9k9SsqfGOljZzsWEa4zBSnzXjh0GkU/vGlHe8WEJKmNO1Ku5v/jxGa2+pWay+Hv3OZv+dNQGIGbFqVYfdIkM4OlpntRiu0F5K6JwEb002u5jg90iyaXPOaVgYKhT0WJ9DJpeKtH0ghJqfTHJAyXt/rabwz2+/FzOwdY/PJf8uHaRMavC2NDTuzOn1KP8tRz+cQf+e8xkT9zLAIi7JVKaxFDYlfB1Hk+wUZcWva9lq9z/QzTAZ+t4B0ZnkQLjGFyEJJfjW7UOD/CuxQXZAE2WFyRCmo3DH2CZftwnlz2CsFdhuSaDK2hQ2xZ/0yJ+cnGYKWd6ZXZ2UrI1l5SqffllLnA6B7Dsi9UjUeXcdgR9Rbxd5gEcS5Vb3k9nOq07ltyI5rTqiQJuVnpYKJk1WjlAls+J/r49AdzG4rHBCwFHeTGyZaDcPzskcFFlqzdt//0VzCsNK4jq/fmn5uU9ZC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(396003)(346002)(366004)(186009)(451199024)(1800799009)(83380400001)(53546011)(33656002)(6506007)(33716001)(26005)(6486002)(6666004)(9686003)(6512007)(1076003)(44832011)(4744005)(5660300002)(66556008)(7416002)(316002)(8936002)(54906003)(66476007)(4326008)(41300700001)(6916009)(38100700002)(66946007)(8676002)(86362001)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kKQn69AA95Jipiu9XYef1g87iRPuLs235dRWhZ1MqfLI/y2gzud76kaWnBVu?=
 =?us-ascii?Q?uRbq3KbVPPIYIzI89UGNk5z4y4KI2ExGbIXRsd7ytZkHSF/YcNAcm4/rzRUN?=
 =?us-ascii?Q?cnyMLuj6fwArj2W99FhlFD3azAYYm9Qd086wnFLEsIpcfSKooJMnFRFa/bxq?=
 =?us-ascii?Q?Z98ibKNmYNull4JMBq9b/cuTsVzv6JtfcumcM+Z4ZxIcp+6u8wqh/BaFiq3E?=
 =?us-ascii?Q?Glq5ma9wM03hoaoexnA2YheZTswDVMbUFjioWfZj5nwIbvzLuCYJikpftiWn?=
 =?us-ascii?Q?AHf2oS7IQ6XTXGZTDEzVVQI3vJJL50e1uxvNTyTFFNMURGMCViyFYgSmRfIL?=
 =?us-ascii?Q?VKNzoOtx6Bzi8lByBwXhrzES7hhscpALjhY02YiKsthBt+Eea13uRQI9cD6r?=
 =?us-ascii?Q?njB+dNgmZ6XC3d2HZPtG3UReGXpne95KDCHYWigbqVO/iEyyJAE2UR2hlufO?=
 =?us-ascii?Q?AA9efGBjAjhv7np5kI/L6PagcAUDDI5+FY9AFsHUzfyF61TtPX6uz2JYiqTl?=
 =?us-ascii?Q?QZgKH1dDjtKW5cIF8eigqViHmevp2WD6mISBLiXZZZGT0jVBH0Qafqbdo3Gb?=
 =?us-ascii?Q?4J2RLL43jM29aHDkbl99ujWtgbnbZXYGEhmrVuymxx3fozRskS+p9/U1UCi2?=
 =?us-ascii?Q?vutAJrMzMhF/i/fCzhbH8PSUn+adIVmttedoWHFY6Ah5bnL3C3/euPTIMGwD?=
 =?us-ascii?Q?+dxi3qrla0mGAFPGsv/LSZHNZWaO0cZmggQOfdG1UFEdc3miHwbxwdGHzKjz?=
 =?us-ascii?Q?Di2Unpzbyk9CubP75os6gIV/AwAFdrZBR/kvjdTNlbleQdEgQMbQSJihL85T?=
 =?us-ascii?Q?Vu16194yZCdqH87EJPA9UFDq95WGwrOVzX+WlWU7gFhVZ79U/amwZOalxgwb?=
 =?us-ascii?Q?evIfpALXZxery2qLrSLDjD60rvCijV2SCLD0mJKj0mD8lgL/w71nr60E6Wny?=
 =?us-ascii?Q?264rOKeQtX8PlRiwPh7Ve/piTTh3EYDBOC1pg9LTFw6PutdzMYTv8vsjL6KH?=
 =?us-ascii?Q?Elvy+7BGhr9Y7i6bQN+k0nar0J3bnDkdg7bSy/FLdrd1niMIN2Yk0HsO0o4v?=
 =?us-ascii?Q?h0DMNjCH+Ini3w2VK4gGf9W7kJ6JDvh2hqwmqIRi09EQ0qTS6Jp9PQUTanuP?=
 =?us-ascii?Q?oeMwMYvYint9P5mKbLXum8HErZb+N7X1Ep54/uikzoadF8uk27UAKshIOk1R?=
 =?us-ascii?Q?egN0Xbs/7J5vtAoY0dKuaCtr376EDMm0Mo6ZLU43dDJ4LjplUOnlgEDt7Gps?=
 =?us-ascii?Q?DrYU4Ko6v/GqRVDC0PzP4ANJc/AP9UTcSzynwe03aMyhugw7SOnXOjoXZqhp?=
 =?us-ascii?Q?p5HuZ9zLa9uzYGpNO3cI4fPzDty1NHlJH+zJSDIVA5GivGvky/gJ0fVJT+37?=
 =?us-ascii?Q?ytOMRDuHJsnGX9/tGBpptdWBYD/PqcaCfTDKMipX6rNuUq4ubqf+bd6uQQ9L?=
 =?us-ascii?Q?3qVk0J3Cnl6qvj+4GRYqnUCqBJPkBtL4OJ+Hip4Ns2R+BQPBzj1NSn4FuFZQ?=
 =?us-ascii?Q?1yoj+qQQlT+kiUai1a9Zkx9IS7gw4LTwd/ajk8kgCmZlFIPboYB4rL//6Rth?=
 =?us-ascii?Q?oHxSBfjjad1igGWTycG1/xQ7gseyUabNgRytK4zoJJJCpjMCQWGC8FKwg4Pr?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CFOFYxzKSqv8LN/chonKSP9n83kpiD3tQu+yYb7QCJVGFYWkE+7VHSorqOO1?=
 =?us-ascii?Q?PpryVCDsxJfCcOUPF/kZ9eVjMViztmTZBmdLhtzGLuRQfM5z0ZOeWWga+IFQ?=
 =?us-ascii?Q?q2o5045/v/wu6jOEB7Yn1xunm27ZokRVhGMBHSFEuHfhxCEHe0OOI9XCiObV?=
 =?us-ascii?Q?1wH7TvMzRsH+X9Lr27NrwMMebKwqQaAxFwwHUYw60PlliyEW+j5dg2vzXCSM?=
 =?us-ascii?Q?HFaLqmsHT8FUzi+n90gEedKUkG/a5KoBCMq5muoFq6kRFBtU5ZwUeGjz8SJs?=
 =?us-ascii?Q?0HT6I50tH2DuyS7pgtG5IXLWXAtPh1pDFWYGgBAkjVNqe9g5048KCOsXjZ6k?=
 =?us-ascii?Q?jcMcBUyIafzMeMEjAFALIYOvjXbjoZXwZuPUZJd9DeFxDNEOqpWNQiEHYhix?=
 =?us-ascii?Q?vMW+YXu3+tdcyiWen4uYfohOfurkgVF6nc0KYBW9kxnWJZSNEJuKWMZIlOUp?=
 =?us-ascii?Q?aGlmsSr/NdkjVHiDnyZvHP/6LRfWgmeQpVcCD1ISQ+KtuljnpglY/XrkHykE?=
 =?us-ascii?Q?0nwvtbzRoLGi6nIR0tDz+Osv929meMwbhpXl9H4D4eQ9OEh1qjGYMAk+81Nu?=
 =?us-ascii?Q?w3H5Vu3eJj2iq7M+93aI5P0K8sWnh1HrkMXgyOCLWucUMIzA1LtbMQtXW/m2?=
 =?us-ascii?Q?z/yIfKwWbocyaMHSOL1i4xD1xkrZ9yQ2OmOskx8jIbpVf9CIIoXNabinxyv+?=
 =?us-ascii?Q?uqzlvTvXrlVUWl/G8gAovhPi7WuA3xmuWjXpInm6iONBmGWd/l1v9hhRlhyA?=
 =?us-ascii?Q?oxVnrY0PsuMz1gQmqpvPKo+FstnuMlqqRNsTK5VAFGrmFkBhYQjkGiFPT9gY?=
 =?us-ascii?Q?UTeUQf5pQiNNtpfCXL/zAnvjgS5Cq4PO3r9qM8RXPB1o0WZ8Cb0Y085bTTls?=
 =?us-ascii?Q?C79knYiEmIsDlQF4+OM3Ne4EOuVlAs4ZCim4RzMQB/XLTG8T76vPm8KvuxKB?=
 =?us-ascii?Q?WbdVN0PFsIEOVGgl1UBUdzhbLLAjEAVoKxbW1dBYqHbv6DeHEXEz4snUOFTJ?=
 =?us-ascii?Q?M88+PoxIa7emGFG9/pBiM3sdXY6s6/a4czhYb68J7r4w/W5nV3BAbEPp+xBw?=
 =?us-ascii?Q?2Rf423PI7iWBKXjx7DP3fdGNW1H5NMw5IUMuF4OHf4FKDs4ej/heJ2A9lJt+?=
 =?us-ascii?Q?yGaWLenJUxDv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef53563-061a-4f72-2995-08dbbb915510
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:28:27.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSXH2O3KN6YSgpZ5Q5k7/7y7Tu7o60XyyuRICKUkZ8BCA+aet14fHxlQxWW2t7YEiwfHqy+k2otLx+2B92kLKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_16,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220151
X-Proofpoint-ORIG-GUID: YjFxJUibLntwpe8I96-g8FHdY52_5SPY
X-Proofpoint-GUID: YjFxJUibLntwpe8I96-g8FHdY52_5SPY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/23 10:01, Mike Kravetz wrote:
> On 09/22/23 16:19, Muchun Song wrote:
> > On 2023/9/22 05:58, Mike Kravetz wrote:
> > > On 09/21/23 17:31, Muchun Song wrote:
> > > > On 2023/9/21 09:12, Mike Kravetz wrote:
> > > > > On 09/20/23 11:03, Muchun Song wrote:
> > > + */
> > > +int hugetlb_vmemmap_restore_folios(const struct hstate *h,
> > > +					struct list_head *folio_list,
> > > +					struct list_head *non_op_list)
> > 
> > non_optimized_list or vmemmap_intact_list? The abbreviation is not
> > straightforward.
> > 
> 
> Ok, I will be more specific.  non_optimized_list is better.
> 

I changed my mind.
The longer name caused 80 column line wrap that I didn't like. :)

I will use non_hvo_folios.  The abbreviation hvo is pretty specific
in this context.
-- 
Mike Kravetz
