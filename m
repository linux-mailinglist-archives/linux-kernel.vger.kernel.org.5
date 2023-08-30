Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FDE78DEC5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbjH3UE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241330AbjH3UEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:04:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B97107
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:46:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UHHO1L019195;
        Wed, 30 Aug 2023 18:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=EpmwRlq64b7K8FZ1FOHejWVGmLun3o+KPVJNQqNUyZ0=;
 b=sdVZffvszproslSYNlxTNF2SOIWUJSNaonZmBMWrIf9K+z8+BMEs+OkKEG6ct1ZXkLrS
 URPGhyZhWs6IWFR8h8pYYTykOabzA2ecCwI6uT39NYNxvV8zi6jcwfeGSB0kXQjXKzGn
 iIW2kP2vMOPQJOrxEq22oF8HOeIILuR0UnRWAZ8N4tKx8tawjV7MuxA2iNc5EGSIFurv
 gelVQEO3+8y0ICAygkkl7VtJhhJX/kkqlmRsi2AeXZImsznh1ydtNcG15g7R6GZqU8B4
 5r5WEhLw5C2jWYX1vg/bItLYrwwqgUFN+FFidftEvucMXbIxkWZukgMIoT71+HK9OLMF HQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9k685d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:36:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UIBJ28009188;
        Wed, 30 Aug 2023 18:36:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ssepya7sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:36:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXQsNCAIBhYusKM9yBe2RJr3FKzOOwuGW0Mzxli2QG3ZsJKSWyWW5SnItxrmRPHgSrFEWQHxKzGmE+yI7pSa6qIvFL0hxduAHN9YwhDhmYuwNPd3T/2gmB7RmzD2KllnP59+cMNMucklKkW7RR/G8Juj8ghkmSMCfpS0FxuNERMEG1fW3mh6IpTbfwvWstaj4XzCMtP/GCBUl8f3y69CHvj96orgnUdO2jYUGokoSgbzbzUPG5to/C5EK5obcL4/iNrIKWKiuYGlA/+/o8qr7pIXMcTXzwRJ5qYT94X40AEGYuDfE2qbFy5hCjGAqA3B522EsqyVj4JBH7vbBQ9fvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7Ai66DTx2Z80gvdiNIRbOoQ8PZLFM/SqmTxgkAOtRg=;
 b=b8TrRL74i6k6/UEq9ytiSn7tqsGtfLOrmmFmJFb0CBpJJzVikbxsVK1mWB7ortjh0tBWqb8Re03rXF14yq9RUH6lGDEhqfz0QWmqczdSjvGYMC4CAnK/hwhkxnIh0U8ZuxDoT+kb9JdWisV1pePe2sRDeBMoHvkPi3iGaFBqdALBOcyxgm6i0D2S8CpVVH5o48pmtcnlFDY3OPgW1EoG2lDwiuBovU5V/J4tqsqtCT6m4rLrdIG9vIEcn8oYTkhb1pjdsIPTBEETpwM/t0fH4F1f3Uqe+z3JaF3dz94cqOo7p8XJmG/eYLNXcUMOyAc/gQoAZDEDSBGwI1fBHAC82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7Ai66DTx2Z80gvdiNIRbOoQ8PZLFM/SqmTxgkAOtRg=;
 b=OE56FTWpQcw7K/8VQBsOXIcARRTeTZNSkgubzXUAYtRhvBUcXGwmvqEwnq0edoeA1pPMtUCWFKCO14o/5c7Pd8i5HnYZeqOVYMg64QZhafwZ5CDFcgWB35suudLLQcyIw4up+gpXlmLH3iCUdl6ePuBmxDrrxcMDcusksp8481A=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB7415.namprd10.prod.outlook.com (2603:10b6:610:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 18:36:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 18:36:06 +0000
Date:   Wed, 30 Aug 2023 11:36:02 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Muchun Song <songmuchun@bytedance.com>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 08/12] hugetlb: batch freeing of vmemmap pages
Message-ID: <20230830183602.GB55006@monkey>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
 <20230825190436.55045-9-mike.kravetz@oracle.com>
 <79f4d305-bddb-9042-d15f-a683fd6003d9@linux.dev>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79f4d305-bddb-9042-d15f-a683fd6003d9@linux.dev>
X-ClientProxiedBy: MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: f97df436-fae4-49ed-41d5-08dba987f896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WoGqBRGMGph3XDmDhS2rKZBSyQmAoMdGBrla45MF4iwuJb8TTFv+Aob5Iko/3g/bpcqmD00132UxGWeTHtEqtORu9uLece+huQrdVDuE7lXdc++bLJLvNIRT1O+jzbd0LfPCrciB/29QUXHQZeDo8ZtopztDBEUdkCKEbh3hkbgAeND6MCV370utIxtE7MPHHnNHkHkVYyik6TpFU0vZ/a+G7j9kk4AoxgNcWMcPjF1DmepvvZSoXs8zKaoQaixvv+qZoN9TJfK9+B99YPSMdzb4/hhSfYDwwTME1MhmAZjiWmO8jjKOKq4P7pembpfWqD528nhn1hRYD5QKRsQGswZtPO/vkiC1BLFgI5zqTAapn53uJISKsHSK7nZBaeu+APxj+tlbga0VXKossKGps4W2S2GS+TlbD2tv3CmuwmmxMLtW7T2Ne+4hqhUG7ULtJ+HnL51DSILDm+J2UqHFZ7udtUO1A/dXPPW5z+ut99BONvYl4SCUJx4G8oqBCmSDKBrwxdNT8j8HSvvVpVYcda4+c5px3agm467zClBIhHLU412dqeQCTRfAIYZMfpx8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(366004)(376002)(346002)(396003)(1800799009)(186009)(451199024)(2906002)(316002)(54906003)(66476007)(66556008)(66946007)(6916009)(38100700002)(478600001)(7416002)(86362001)(41300700001)(8676002)(8936002)(5660300002)(4326008)(83380400001)(44832011)(53546011)(9686003)(6512007)(6666004)(6486002)(6506007)(1076003)(26005)(33716001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wctQEJI4KSWrnOaPRWs0lwYoBmdVAW0L5f3v/ctGJmmA6O/CH2nrL4DJhB?=
 =?iso-8859-1?Q?KCASsVrftnBjvE6ljdjcoe62YE1bvqp56grysroNg312pcYoL9ZKLNqxev?=
 =?iso-8859-1?Q?9snjFFwxp+8hz98CPMWnT6t1NAr5+HizoV+33z0Atvqmn1YSHwD9j+ytgF?=
 =?iso-8859-1?Q?+RwlX1OBHWqg84L2uXLiwgDIUggR/m9V1TdqFUVB4Zps9rYI0Het1Nkopz?=
 =?iso-8859-1?Q?6TeD6Mkx6K5ROdb211LcB09iLHCaBHRe9NLMjU4wcEySsJqEqU5h28YqWp?=
 =?iso-8859-1?Q?9H2ZKICZbSkhcRmkSHzk3bno1TFdPcnJegwJIC7OxycDj/zWn32nmxxikB?=
 =?iso-8859-1?Q?YlG0paEvvT7zDjPy49tOsyY/6ymO+WJJqncwx3dhYEK4h4OSoZnA/ug10L?=
 =?iso-8859-1?Q?VSU6xqM255bU1eIdGdhEZVsWVa/p+lyalH9sQFl1onENbtXl8utL5hth1i?=
 =?iso-8859-1?Q?IZN7+pUbz8LKnwau6uPkvGibCjnNbYRp/tnapSmNyHlEzcyANJGuZbCIdA?=
 =?iso-8859-1?Q?0tJnrqJnF4EFQA8i5/IkeM2VOzYSGLnBdmLKfPmKuHuDBnElcbuRFXfqzI?=
 =?iso-8859-1?Q?qqM2TkkEFP09DxStmeI5tZQ1oZHfazr+NtBdz0+j39scv4XchZESk/W1w+?=
 =?iso-8859-1?Q?wHdvqQn7rZ7nulc6U7hULXt+TFPz4jRUHTTcwDts0SEmB6LN0UmIeBZdBD?=
 =?iso-8859-1?Q?fVPD+Y4mPPuNkKkgEsn6jvouJrlwX/dpBrcGjmpPueelOnHEhbGn1/liIJ?=
 =?iso-8859-1?Q?NB2tJndYjdneMV/ihSs8GckzukCMpLjTeBG5Aznc/IQkfZJBFx94tHFoDO?=
 =?iso-8859-1?Q?/w9xFcbf/TfbZP0OYGrUVgj+TxkYjtQtMCUnTGoeBDYnwHZd3GviUaF3IE?=
 =?iso-8859-1?Q?cyTS2ftAc5c+jl5y+vw+LPgc6UIiHcdVGzS+eVFiWiPJocs3sht4wPm1hh?=
 =?iso-8859-1?Q?Uvf1id7zQMkpdfXrFQLEhTpCzFmrNiNoBEBc1tQkpwxVk4xaOj+IVDpX5G?=
 =?iso-8859-1?Q?DuG9pVdtywouKSLnvdkI3QgJp/5YDZvRf1mCltl/kiIZ9K1s/HRv7qQ86U?=
 =?iso-8859-1?Q?8e7Cs6xKoLWqsc+kaPYUUhUiHfVx8DsQ+wH7hNZW+eKIqI47HJ3x2APnV+?=
 =?iso-8859-1?Q?ufeAitt18D6XJcDa3mtbae2OQlGFsI4Gx8QQdw/Jo4REE7BlDz1wnUt9/z?=
 =?iso-8859-1?Q?CBUP3WCRTDJghPoXqQcMfd2GFTtMyJLwTIpezlopuCF2tqmeCbz+KTOWnh?=
 =?iso-8859-1?Q?aqu6P79DQPqoHNSZE1qpleZ0UTvtKm5d0bnc9xcy5NfouvK9M+q7uJgtOM?=
 =?iso-8859-1?Q?CNBdMPj1LgHY5on7dwM3dxEpLmfYgXGH1cevX1Ww0Jzc4lE3PDC4jTTquB?=
 =?iso-8859-1?Q?xCdCxc7FVaOREG4A8OsM+11SgkTOyvj4pZar+yANkbGuh22Xd7nW+kwspl?=
 =?iso-8859-1?Q?m1Et+ruvzdnN0zIQ6cYpHfiUUppUHGu2qk4ApHwoihAIgJxcW/chcTByaH?=
 =?iso-8859-1?Q?aVRrgqlax8pheHkIk0t2QQXJxI1gHXGY85H3dg3PfCRpcGzFtWGMoKZeaI?=
 =?iso-8859-1?Q?W46WGKbg+WvAoOxpK8MASQIlDoRlhDYRtkvzqz48wOqUVgrt1BNHob+7E4?=
 =?iso-8859-1?Q?XEFgzLIqFqyNzJzZtIbFIe/40HIlGCL03UMhmgmD8+NMDqrnhpaWbxcw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?TpFr1DNleYXft3SiyayQiykZ5SotpMdWq7EkuErPY3MA2Hc/g6xqX98MQg?=
 =?iso-8859-1?Q?OVBqws4gDMRrBIQCAb1lMJ3+dLrAZrgCGRiBviDIlnhxcNeC81aAKmNwgO?=
 =?iso-8859-1?Q?YZ2LPuW28arI2K9D+rrpi4qYgXHF3uji3nf+3Xb7UyXRA/p+WuhvlUvgaC?=
 =?iso-8859-1?Q?p7od8MmPA7IKEVPObAAXFaQvK2StrnPVBlbATchtR75rtI9pQvsIO+YFre?=
 =?iso-8859-1?Q?gYiRAq+skXCgTByEy0PnpvrzkCAATCtUelw2/gi0coXBb3VP9CWhB4mMC7?=
 =?iso-8859-1?Q?Pfsm7e9Mf4+8Vm12tQ5xxx9NluOZbdul5wnfghfQ9m+jtg19zicB+KZ8z2?=
 =?iso-8859-1?Q?99HlnCmkPEg25kOh+60Y3iXYnYZFFDs8WEo0lfomGB2rp7qoAbo1oCCb5z?=
 =?iso-8859-1?Q?YLhmGnkggVWFCUOEjZYAl/xoUiGNV9u0ZwH2U9oK5xoYQEh4CtEIHH5nAW?=
 =?iso-8859-1?Q?n95NRiKfWQNLCTqujfRB9akC8ee0JxARv+ZWFEB5sT8k6dzmOzHTjK8tEL?=
 =?iso-8859-1?Q?IL9m/rVAjufJ4Qa/OatupQkLX91fKaLMq9LQkOLGuKNiR8GlgVsUGS/yd7?=
 =?iso-8859-1?Q?OLK4/blfvDXyZp8+7JVyI0VdQb4BWmQ7Q0bkkvZJyu+T7eiTcvJ3M93+Kr?=
 =?iso-8859-1?Q?AWKG8UNp2Ql6Usq+ZZFpc3pLf/EGoJmMGfFkGpyIkbDCi9KS/F3M8hfZ8x?=
 =?iso-8859-1?Q?cJCP9+lV3yDFTYWjJ049E72NjD8J9aKU48lxXRZx7oXWr04uzC2T0Y9EOx?=
 =?iso-8859-1?Q?tMu1NMW3iHZoLkin273Ln34ZPaf0Q0pLutV/WuxPWrOf4nYoyU4r1M3/oA?=
 =?iso-8859-1?Q?RGdnECOrWEJ935O8JOKQA6NIZhHZR5DJ2wpDl+YyXMmmb/bIvMXCelumVf?=
 =?iso-8859-1?Q?SNfFmIYWv4ZXUvFMynvsmuely4y9sO2Aboiu1LIwmGuquUGZGNUkBOfJFH?=
 =?iso-8859-1?Q?NydVB5y69jHTyHoITLfnZs+/MJmhruDW5EgAib8XJkQfS/feXOt0u0qw6Z?=
 =?iso-8859-1?Q?xrZxiG83vz3bPiiDooGP8rBhdK84e8HVrFEHdO0WW+0K+R6Uj4lhBQLA6+?=
 =?iso-8859-1?Q?TOq0L3AEqpg2e06qBGUJa+3eBFZaWTPu3Q5UHaBihJnjGgSwoaR5FutNw3?=
 =?iso-8859-1?Q?WCeNBUnlEwTEPOr4S+rqvZMJzQiL94aNjcEVlG2g5eiQ2F+9BK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97df436-fae4-49ed-41d5-08dba987f896
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:36:06.2588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgsgTKpKyFCsIDaUIzTSCbBg+AKrRao1G9cH/1xJ6e0dcSvL12cBHYmItcj0kq7fbxX+EC36e+C2TIKgq1jC6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7415
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300168
X-Proofpoint-GUID: YCjDeIPzbZk4mvNEDbRNXb9ghCl4g8gY
X-Proofpoint-ORIG-GUID: YCjDeIPzbZk4mvNEDbRNXb9ghCl4g8gY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/23 15:20, Muchun Song wrote:
> 
> 
> On 2023/8/26 03:04, Mike Kravetz wrote:
> > Now that batching of hugetlb vmemmap optimization processing is possible,
> > batch the freeing of vmemmap pages.  When freeing vmemmap pages for a
> > hugetlb page, we add them to a list that is freed after the entire batch
> > has been processed.
> > 
> > This enhances the ability to return contiguous ranges of memory to the
> > low level allocators.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >   mm/hugetlb_vmemmap.c | 56 ++++++++++++++++++++++++++++++++------------
> >   1 file changed, 41 insertions(+), 15 deletions(-)
> > 
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index d5e6b6c76dce..e390170c0887 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -305,11 +305,14 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
> >    * @end:	end address of the vmemmap virtual address range that we want to
> >    *		remap.
> >    * @reuse:	reuse address.
> > + * @bulk_pages: list to deposit vmemmap pages to be freed in bulk operations
> > + *		or NULL in non-bulk case;
> 
> I'd like to rename bulk_pages to vmemmap_pages. Always add the vmemmap
> pages to this list and let the caller (hugetlb_vmemmap_optimize and
> hugetlb_vmemmap_optimize_folios) to help us to free them. It will be
> clear to me.

Makes sense.

I will update all these in next version based on your suggestions.

Thank you,
-- 
Mike Kravetz

> 
> >    *
> >    * Return: %0 on success, negative error code otherwise.
> >    */
> >   static int vmemmap_remap_free(unsigned long start, unsigned long end,
> > -			      unsigned long reuse)
> > +			      unsigned long reuse,
> > +			      struct list_head *bulk_pages)
> >   {
> >   	int ret;
> >   	LIST_HEAD(vmemmap_pages);
> > @@ -372,7 +375,14 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
> >   	}
> >   	mmap_read_unlock(&init_mm);
> > -	free_vmemmap_page_list(&vmemmap_pages);
> > +	/*
> > +	 * if performing bulk operation, do not free pages here.
> > +	 * rather add them to the bulk list
> > +	 */
> > +	if (!bulk_pages)
> > +		free_vmemmap_page_list(&vmemmap_pages);
> > +	else
> > +		list_splice(&vmemmap_pages, bulk_pages);
> 
> Here, always add vmemmap_pages to the list.
> 
> >   	return ret;
> >   }
> > @@ -546,17 +556,9 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
> >   	return true;
> >   }
> > -/**
> > - * hugetlb_vmemmap_optimize - optimize @head page's vmemmap pages.
> > - * @h:		struct hstate.
> > - * @head:	the head page whose vmemmap pages will be optimized.
> > - *
> > - * This function only tries to optimize @head's vmemmap pages and does not
> > - * guarantee that the optimization will succeed after it returns. The caller
> > - * can use HPageVmemmapOptimized(@head) to detect if @head's vmemmap pages
> > - * have been optimized.
> > - */
> > -void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
> > +static void __hugetlb_vmemmap_optimize(const struct hstate *h,
> > +					struct page *head,
> > +					struct list_head *bulk_pages)
> 
> Also struct list_head *vmemmap_pages.
> 
> >   {
> >   	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
> >   	unsigned long vmemmap_reuse;
> > @@ -575,18 +577,42 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
> >   	 * to the page which @vmemmap_reuse is mapped to, then free the pages
> >   	 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
> >   	 */
> > -	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse))
> > +	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, bulk_pages))
> >   		static_branch_dec(&hugetlb_optimize_vmemmap_key);
> >   	else
> >   		SetHPageVmemmapOptimized(head);
> >   }
> > +/**
> > + * hugetlb_vmemmap_optimize - optimize @head page's vmemmap pages.
> > + * @h:		struct hstate.
> > + * @head:	the head page whose vmemmap pages will be optimized.
> > + *
> > + * This function only tries to optimize @head's vmemmap pages and does not
> > + * guarantee that the optimization will succeed after it returns. The caller
> > + * can use HPageVmemmapOptimized(@head) to detect if @head's vmemmap pages
> > + * have been optimized.
> > + */
> > +void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
> > +{
> > +	__hugetlb_vmemmap_optimize(h, head, NULL);
> 
> Use free_vmemmap_page_list to free vmemmap pages here.
> 
> > +}
> > +
> > +void hugetlb_vmemmap_optimize_bulk(const struct hstate *h, struct page *head,
> > +			struct list_head *bulk_pages)
> > +{
> > +	__hugetlb_vmemmap_optimize(h, head, bulk_pages);
> > +}
> > +
> >   void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
> >   {
> >   	struct folio *folio;
> > +	LIST_HEAD(vmemmap_pages);
> >   	list_for_each_entry(folio, folio_list, lru)
> > -		hugetlb_vmemmap_optimize(h, &folio->page);
> > +		hugetlb_vmemmap_optimize_bulk(h, &folio->page, &vmemmap_pages);
> 
> Directly use __hugetlb_vmemmap_optimize and delete
> hugetlb_vmemmap_optimize_bulk.
> In the future, we could rename hugetlb_vmemmap_optimize to
> hugetlb_vmemmap_optimize_folio,
> then, both function names are more consistent. E.g.
> 
>   1) hugetlb_vmemmap_optimize_folio(): used to free one folio's vmemmap
> pages.
>   2) hugetlb_vmemmap_optimize_folios(): used to free multiple folio's
> vmemmap pages.
> 
> Thanks.
> 
> > +
> > +	free_vmemmap_page_list(&vmemmap_pages);
> >   }
> >   static struct ctl_table hugetlb_vmemmap_sysctls[] = {
> 
