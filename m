Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391BF7AB6D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjIVRCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjIVRCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:02:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D1D19A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:02:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MGOHAi011823;
        Fri, 22 Sep 2023 17:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=log+gtNahEshb+fsyI/77i2/qThLxqwe5Sjgaj0kevc=;
 b=M6fLtqM964SKemO40thtocVh4SS8RxNjnFB9t2rq9dqQVN2I3SZhk9/N2EMsAo9ud7cn
 Xd3hb1ehP3HPvoQZV/ur7vuEUNnfr+clNlndunta1+4ZIUOUaT76l+J/GqxWNrtUh+Hn
 VScwLRI2VuMLcrv6xpYhf42h01a95VL22G2n46ZxR1rrnfJO+WnahX2rpV802gXkoF3c
 aOTu/plheGek8waAZkxHcJQrJu2V60UE1NPA3pXcsCI8Jz/nnuNfHIsMiN4HZWGXwy81
 lgODSuq4pRc3VW2opCoEIsa01nVGHjSCs3o0gwl1LkHV9lQUibLKTy4UU2RoPe2F/1hz LQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt0a99k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 17:01:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MFNHPr006295;
        Fri, 22 Sep 2023 17:01:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8tt8b146-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 17:01:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyxH6jMOdh1aCqfXRjjO3KB+5LdDuMRIFmXHU6BXMxWghrTBy60vhYOqlriHXJzXTVdA029FiKESfKAIB/AbgmsWBxRYEgcXg855gK4JsyEhP5MwhLZj5rej8CntS+Spo5SmmluqjTMcqzRIBKIaxQ2fgOmZhyP94sJ2PSSRUFa3DDmEqbz3NWVz0GoFZyj4I7C8m+XKTnuJdWBlStZlClXFnNBK/2lOYUaYnByOsgljY0YC7JgEefJ7+x/5LGlcRd2BJ1GV0+b+DD4shf+7R9/094I26rDBMLv3jM7G7k2uW5hWDMZ1DWNgGi00PDWuH2nv2OwsXVJ3dU517AO8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=log+gtNahEshb+fsyI/77i2/qThLxqwe5Sjgaj0kevc=;
 b=isPR7uh6MGSzJbes8SGNXQmnNX/zjVv+VdXZLrmHP378J2q44nSYstDAjmcZ5LBDEapEF2t9Kb/KKYeugTykib2h/0J4zGLvHbGZF7KtQkyvtQV+34Ump1l2+ZzU2LvwpgOAsJg0RSwg9tyirnidw1rgqa8my11qygSQTVoFFs37MNX5HJLW03xZDdDa4Qa1BRQTRocOQThOvlcU/JzvSiOsvXHngy/qengDQVVII3fUmKqnJslCDs7vd21xest5sXxbDmDacsP5VpGIs/Xgdc/EdXdVFRkXDeIRJ0SHpQahyUr9Czny166oW+26K+XEO/lIgbS38LKJ5KXRQ9/Gkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=log+gtNahEshb+fsyI/77i2/qThLxqwe5Sjgaj0kevc=;
 b=juUuKs5jt59rpzlet5B2yenPxjDxB+9zi/kjbBMtt178pmMuNFflFzUtweNyoeQHzS6dhQ7C3XEILsQNqx3BQk1YIt/wpdHYrmuS72//rooQN2dd+FQvl5gsQPhKHaS/pCi8obNwStT9VJNSX+8BN/5LorJeBNgChSRNDFoRANc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 17:01:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 17:01:05 +0000
Date:   Fri, 22 Sep 2023 10:01:01 -0700
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
Message-ID: <20230922170101.GB224968@monkey>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
 <20230918230202.254631-5-mike.kravetz@oracle.com>
 <b9d03e01-7582-8ec9-d219-941184166835@linux.dev>
 <20230919205756.GB425719@monkey>
 <CED64A95-00E8-4B52-A77A-8B13D2795507@linux.dev>
 <2FDB2018-74AE-4514-9B43-01664A8E5DBF@linux.dev>
 <20230921011223.GC4065@monkey>
 <306da2a1-0dd4-e858-930f-211947a466d2@linux.dev>
 <20230921215810.GA21193@monkey>
 <7f222dae-c256-a625-6846-dd22e16687fb@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f222dae-c256-a625-6846-dd22e16687fb@linux.dev>
X-ClientProxiedBy: MW2PR16CA0072.namprd16.prod.outlook.com
 (2603:10b6:907:1::49) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 867574f3-d34c-44a4-b093-08dbbb8d81fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEYhowCafXRywkDPQYJ8rPEOniQNh0UsEWJN04QsfWkd9na0AbANTagZn/z5kgB1t+FVoHXC13Pw8Ulz80ra6hsRqRi0a6/jFRJMp1df1gKogKLM7WkNZxG06aK0fco/Qb69f6lH+ejqfMmiJpz8kEsdoSOcA70f/04PfhRv40b2mwTwMEFGlL8TicadzTfwkY2B7NDplSe+1bD1InLJGciI5xwiCk5JK3jtLoX4Bk4O3LMs0/pBp9Qkx6M3YlwQKn6plwfO8Hag8/7n3mb9560MuF18EKTo/aDUb0xaxAf1SNmDQb+A1Gt+FVLh+iB3YDQQBzFT44pi8wuWWs9zEnxD4r+aXBzZQnofuSqfagjLBVrZNgMpiQ4cqsgojYkhErLtzfFE5AoUyb7S6VzIC8tbxizIBqPPxMusMFz7ba5HkalfiKY7vHrcaAX81KKTfkRSSVafrG7LIUTEgPSFsiZamAZ/DT05glr/+65oUcDq6krNrJKoaXn2o85mBKePvdTOe4pSW1Ds/+w46d3yKUVn/VD/Jyz1EOrBJIVPDI9iRMCUYlCrlG0NELW/BOPa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199024)(1800799009)(186009)(33716001)(38100700002)(33656002)(86362001)(2906002)(66946007)(6666004)(54906003)(6916009)(4326008)(30864003)(66476007)(66556008)(9686003)(6512007)(6486002)(478600001)(6506007)(53546011)(8936002)(8676002)(44832011)(5660300002)(7416002)(316002)(41300700001)(83380400001)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G6lgRVDpp5OrdW6T/H5u1p0+fdBOTByRR0mcCaYOEpeIb90W5RtB1A+JaD75?=
 =?us-ascii?Q?SwlrW/fPipCkwxVoks+4j0xnh46FmIizDVTVNAF9ZIJQLuwlls11xjSJSXCg?=
 =?us-ascii?Q?QTjHVs/egJTBI9beQUFl4YzrZ/jS8SDECPO6Mp5Fv+g81KQD16q2XgWwIZVy?=
 =?us-ascii?Q?d69XOmvyu1ZPz6KgnXOA0Wq7xfJYxXEPZvllFmicTjGnQqkGF/bNWCQ4Dmom?=
 =?us-ascii?Q?L4SrBRFm+u1iUaba8byOwOFoZISiHUbJw/RiQeZ0EODF1tAdExS+eqJL04JW?=
 =?us-ascii?Q?BChHTLsV3kew01dY3NzULMeqGXl0t7T4sy7sYIiXEM/R7o6ZIDoTGETioZlS?=
 =?us-ascii?Q?2ptBOF8mAo+0dL9nAR9pQtOfORv36NXOMQ7uY4PPTJIHOshfBcpuZGhfmipo?=
 =?us-ascii?Q?778vhhzo9+9o+QTNc8e26r5MmTTkJSjRY4SLVwI4l93nsGVvqkUzBdSweNE/?=
 =?us-ascii?Q?8h7BEJ1MoEm7OW6vlS0P9EVWccFI9fASAGuNt7EdY8su2ryFhN3dcvMvBVKH?=
 =?us-ascii?Q?ybbXXTHnsxH4rOKsAW7xLEGNWMlNX0+UT5Ixad0MSqhl3UG19KSw96woJKXy?=
 =?us-ascii?Q?Oq+lZoQ1jKguKBxNFI7fru7LqH/G/S+UelTL6nuIRbcsSCriKV3D4TSgpY52?=
 =?us-ascii?Q?t5/tEw1LG/JRMHWI4cL/+VrgS/bIJ5pW7wekefCAUvhqsjd255iMUgRjvjID?=
 =?us-ascii?Q?VxoglKSIZrwRNAN7INqWNKbHim9qZTmJ5Eche5FUPUlFqRRDmyBS7NdAsiDT?=
 =?us-ascii?Q?E7dfqHBLLVr02bUKW3Tg6eIG2RlBOXHiD2d6p2J6kFjq+TuSdQtHsvmpKIUE?=
 =?us-ascii?Q?7BbhqASg/bAfWh2Jc6wfK304DS8CWeTLdtn84volk8WeIw9p2NuuCFcbdFh9?=
 =?us-ascii?Q?rjP+6FIr2z9bbqHA8gTq5ctRDayynsqrEj4Piyso0bT8Ohc2upvYNq2XPo5c?=
 =?us-ascii?Q?kokksiGe1UtuvQr/IIZc90zGVuG11/nw12aVjDsSbRdv99N6d3xv949DjKTD?=
 =?us-ascii?Q?fotw7AKyA3uxo2xBK2JUj9DD2+wfHKq7nXci2fb1I2ckzcdVoimdkOBXDJFa?=
 =?us-ascii?Q?ERBcSlBYLBRUAuwz7tttTirJLTte7Au2vkmiybFYgAi6Kvx9k7QKa9HQLjmd?=
 =?us-ascii?Q?6T5JftDP8SCSRmfSnCymSXx4Dg8zbnW4Luk5P8HsdUylLIdNVUsPGYEQa4PX?=
 =?us-ascii?Q?4guX9Rh5DCHYMk0RQ74nL9f4kFr7+KKYlUuzhFKzuYPqg/zdgbbzcE6r5y08?=
 =?us-ascii?Q?AY0nl9sxPbueoSje7CeoiT/WxDfJUQf9jsRkRvyBjXwQrf+f/1fSobZhqnHp?=
 =?us-ascii?Q?PHaS/IqUFXP5Cyddtmf2HxZV0ElcTaAGZyLnu/IdnrtnI548lxxxCphd7LBv?=
 =?us-ascii?Q?3Yj3+qZeokjyhOpv26V2ahX/1P6FHeSfCw5J1Z9ufxDrc17PJh2CtBIuGbaM?=
 =?us-ascii?Q?eWUkNZSHqHc0vQh8n9qHGQ4Dy4WvuI+gjeXGozZAyMQmcCKmKWoOYSU5jBPW?=
 =?us-ascii?Q?66MtSGnehVon0l8jSjOJy9H+jO+DPjRxWSDD+5bwrp17P9pZWjd2GI+dPwFj?=
 =?us-ascii?Q?KYYzQzeAlAEhVgmIrKdT5MgPThercq3BXwQgVnGWkiAJdviSbYq888vb173z?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?usw6DEgLghYMeQ4WeM/tmDetu0a8wgWDNcidPc/dYOADm65pHghgAEAmDZ8B?=
 =?us-ascii?Q?gnRxz9qeL0xZly/1tdkpDJ/jB4PrzxAlAeWoElWhE4Omknd8y3VT/EXmKFQc?=
 =?us-ascii?Q?rEVtiYi4EOEF8WCOsn2TTd7C3AhpayF2cLQUtFOCYW2j08HcTLnYjXD2gbbz?=
 =?us-ascii?Q?RvwQsXFb92nrZe3/xcVq4q7ZAjBVKDN4tkzMUz2DmQ9bBpcDw3ID+ddZhcY8?=
 =?us-ascii?Q?kLuXJk1O6gLPCoPcYMNUSvXmZKARnWsPLdYA93kbwpvZsjdjWQh7dicK4YxG?=
 =?us-ascii?Q?H4WkQAQazGI0N8xlwA5I8Lcb4lAlLgMTO3iKviv9t+N5dnEZnuPjWFbKUXlo?=
 =?us-ascii?Q?FXbyWmrEblF7gvjtiXU1CCtgtgoRftXFKgXhX2Ua1e5yxhHeOpXApkHoQpYz?=
 =?us-ascii?Q?VOx3SAJcucwLf10BS5lMlzEciFNx+WOOIaDeUwy2UkscaU0Wo78i1Loe3iS4?=
 =?us-ascii?Q?ZUyusoHRbLOVZWlnYwDKNWKIU4Rw0Te4E5KJNNh0hyCQH9wRIssZ+wggAKAv?=
 =?us-ascii?Q?mIZuzuPiAyPEL7LBiEGAV/RcEsspfylOzYTHEVRYLO4Qr48oVbyFtWUEx5VT?=
 =?us-ascii?Q?baDxFqQdSFHnZ7cxKDKzNeBPXQwvHBJ6MjCxU3qppq+oqS0OgTRpyxeaumRM?=
 =?us-ascii?Q?eKeY9EUlHTqpz1X6JffalQMrFVwz1eNIxFRNGuYZ5JGMV96OOefr4ypfEwt/?=
 =?us-ascii?Q?mcNxu6nHp8zRQxJhzaCIAYT4Z07Z6zUEoN52UVCB1t2PoNFPucgYOGioqztN?=
 =?us-ascii?Q?ekKpZN5iuajxmxuns8txsl0p0ntoTmKfWvvS674HC/O/YJl3IyDc8/tYZlFX?=
 =?us-ascii?Q?l2MHJB6nnzPnJVSSuyixFvyViipC9SBzkgUHwaMUkXLrnnS5LQQvasbAupWy?=
 =?us-ascii?Q?q2G0SQoUwb+q02xzMfQQT/o4pX3qMKDqYKay4XR999STDMmtInj2Z1XtOlwA?=
 =?us-ascii?Q?z9Itx9Cqx6Oqv8Oofsr4cfTr9i8fsWXybBNmoO1a8jm6UF1wRmsHZQxPqK+K?=
 =?us-ascii?Q?ooDqBii+RPp6bGZTXKBawNylTHqctMT6WYoy6vWRLO2WeWsMzewi08pyH8nY?=
 =?us-ascii?Q?1OEoR6KCnI71WD14JqvNF9nln6m/o84uhupKuPctqNbeWapyyLA+s10Ljdye?=
 =?us-ascii?Q?vjiowQZiWsn3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 867574f3-d34c-44a4-b093-08dbbb8d81fb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:01:05.1940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAkRNhLzyKJV3uccim+AnI+0nbuALx3V8ZolJXFXVC6hvbMPjlIIou8LAW1vnjNcfCT/OiD2mYiED4rZQ/84Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_15,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220146
X-Proofpoint-GUID: 5y7pMNyMK9Auo7PYKTn0gdyhCZiVXl9z
X-Proofpoint-ORIG-GUID: 5y7pMNyMK9Auo7PYKTn0gdyhCZiVXl9z
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/23 16:19, Muchun Song wrote:
> 
> 
> On 2023/9/22 05:58, Mike Kravetz wrote:
> > On 09/21/23 17:31, Muchun Song wrote:
> > > 
> > > On 2023/9/21 09:12, Mike Kravetz wrote:
> > > > On 09/20/23 11:03, Muchun Song wrote:
> > > > > > On Sep 20, 2023, at 10:56, Muchun Song <muchun.song@linux.dev> wrote:
> > > > > > > On Sep 20, 2023, at 04:57, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > > > > > On 09/19/23 17:52, Muchun Song wrote:
> > > > > > > > On 2023/9/19 07:01, Mike Kravetz wrote:
> > > > +/**
> > > > + * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
> > > > + * @h:		struct hstate.
> > > > + * @folio_list:	list of folios.
> > > > + * @restored:	Set to number of folios for which vmemmap was restored
> > > > + *		successfully if caller passes a non-NULL pointer.
> > > > + *
> > > > + * Return: %0 if vmemmap exists for all folios on the list.  If an error is
> > > > + *		encountered restoring vmemmap for ANY folio, an error code
> > > > + *		will be returned to the caller.  It is then the responsibility
> > > > + *		of the caller to check the hugetlb vmemmap optimized flag of
> > > > + *		each folio to determine if vmemmap was actually restored.
> > > > + *		Note that processing is stopped when first error is encountered.
> > > > + */
> > > > +int hugetlb_vmemmap_restore_folios(const struct hstate *h,
> > > > +					struct list_head *folio_list,
> > > > +					unsigned long *restored)
> > > How about changing parameter of @restored to a list_head type which
> > > returns the non-optimized (previously) or vmemmap-restored-sucessful huge
> > > pages?
> > > In which case, the caller could traverse this returned list to free
> > > them first like you have implemented in bulk_vmemmap_restore_enomem(),
> > > it will be more efficient. The meaning of returned value should also
> > > be changed accordingly since update_and_free_pages_bulk() wants to
> > > whether there is a vmemmap-optimized huge page being restored sucessfully
> > > to determine if it should clear hugetlb flag. So
> > > hugetlb_vmemmap_restore_folios()
> > > could return how many huge pages being restored successful, if a negative
> > > number is returned meaning there is some error in the process of restoring
> > > of vmemmap.
> > > 
> > I had similar thoughts.  An updated patch based on this approach is below.
> > When creating the patch, I discovered that using the function return code
> > for both number of vmemmap restored pages as well as error code was
> > unnecessary.  Just checking !list_empty() of non-optimized pages tells us
> > if any were restored or could be freed.
> 
> I also thought about this. But there is a little different. If HVO
> is disabled, we will always clear the hugetlb flag twice since the
> list couldn't be empty, I thought it is an optimization for HVO-disabled
> case.
> 

Ah!  Good point.  We will clear twice with with the patch below if
HVO-disabled.
The reason I did not initially want to have return code be both number
restored and error code is that type int is not sufficient.  Number of
pages is usually of type unsigned long, but we need a signed value for
error codes.  type long should be sufficient for this case.

I will change it and associated logic.

> >  From b79f6eeb7a11644830bddfc43d2219c149d26405 Mon Sep 17 00:00:00 2001
> > From: Mike Kravetz <mike.kravetz@oracle.com>
> > Date: Sun, 10 Sep 2023 16:14:50 -0700
> > Subject: [PATCH] hugetlb: perform vmemmap restoration on a list of pages
> > 
> > The routine update_and_free_pages_bulk already performs vmemmap
> > restoration on the list of hugetlb pages in a separate step.  In
> > preparation for more functionality to be added in this step, create a
> > new routine hugetlb_vmemmap_restore_folios() that will restore
> > vmemmap for a list of folios.
> > 
> > This new routine must provide sufficient feedback about errors and
> > actual restoration performed so that update_and_free_pages_bulk can
> > perform optimally.
> > 
> > Special care must be taken when encountering an error from
> > hugetlb_vmemmap_restore_folios.  We want to continue making as much
> > forward progress as possible.  A new routine bulk_vmemmap_restore_error
> > handles this specific situation.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >   mm/hugetlb.c         | 94 +++++++++++++++++++++++++++++++-------------
> >   mm/hugetlb_vmemmap.c | 36 +++++++++++++++++
> >   mm/hugetlb_vmemmap.h | 10 +++++
> >   3 files changed, 112 insertions(+), 28 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 70fedf8682c4..11de3f885065 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1834,50 +1834,88 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
> >   		schedule_work(&free_hpage_work);
> >   }
> > -static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> > +static void bulk_vmemmap_restore_error(struct hstate *h,
> > +					struct list_head *list,
> > +					struct list_head *non_op_folios)
> >   {
> >   	struct folio *folio, *t_folio;
> > -	bool clear_dtor = false;
> > -	/*
> > -	 * First allocate required vmemmmap (if necessary) for all folios on
> > -	 * list.  If vmemmap can not be allocated, we can not free folio to
> > -	 * lower level allocator, so add back as hugetlb surplus page.
> > -	 * add_hugetlb_folio() removes the page from THIS list.
> > -	 * Use clear_dtor to note if vmemmap was successfully allocated for
> > -	 * ANY page on the list.
> > -	 */
> > -	list_for_each_entry_safe(folio, t_folio, list, lru) {
> > -		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
> > +	if (!list_empty(non_op_folios)) {
> > +		/*
> > +		 * Free any restored hugetlb pages so that restore of the
> > +		 * entire list can be retried.
> > +		 * The idea is that in the common case of ENOMEM errors freeing
> > +		 * hugetlb pages with vmemmap we will free up memory so that we
> > +		 * can allocate vmemmap for more hugetlb pages.
> > +		 */
> > +		list_for_each_entry_safe(folio, t_folio, non_op_folios, lru) {
> > +			list_del(&folio->lru);
> > +			spin_lock_irq(&hugetlb_lock);
> > +			__clear_hugetlb_destructor(h, folio);
> > +			spin_unlock_irq(&hugetlb_lock);
> > +			update_and_free_hugetlb_folio(h, folio, false);
> > +			cond_resched();
> > +		}
> > +	} else {
> > +		/*
> > +		 * In the case where vmemmap was not restored for ANY folios,
> > +		 * we loop through them trying to restore individually in the
> > +		 * hope that someone elsewhere may have done something to cause
> > +		 * success (such as freeing some memory).
> > +		 * If unable to restore a hugetlb page, the hugetlb page is
> > +		 * made a surplus page and removed from the list.
> > +		 * If are able to restore vmemmap for one hugetlb page, we free
> > +		 * it and quit processing the list to retry the bulk operation.
> > +		 */
> > +		list_for_each_entry_safe(folio, t_folio, list, lru)
> >   			if (hugetlb_vmemmap_restore(h, &folio->page)) {
> >   				spin_lock_irq(&hugetlb_lock);
> >   				add_hugetlb_folio(h, folio, true);
> >   				spin_unlock_irq(&hugetlb_lock);
> > -			} else
> > -				clear_dtor = true;
> > -		}
> > +			} else {
> > +				list_del(&folio->lru);
> > +				spin_lock_irq(&hugetlb_lock);
> > +				__clear_hugetlb_destructor(h, folio);
> > +				spin_unlock_irq(&hugetlb_lock);
> > +				update_and_free_hugetlb_folio(h, folio, false);
> > +				cond_resched();
> > +				break;
> > +			}
> >   	}
> > +}
> > +
> > +static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> > +{
> > +	int ret;
> > +	LIST_HEAD(non_op_folio);
> > +	struct folio *folio, *t_folio;
> >   	/*
> > -	 * If vmemmmap allocation was performed on any folio above, take lock
> > -	 * to clear destructor of all folios on list.  This avoids the need to
> > -	 * lock/unlock for each individual folio.
> > -	 * The assumption is vmemmap allocation was performed on all or none
> > -	 * of the folios on the list.  This is true expect in VERY rare cases.
> > +	 * First allocate required vmemmmap (if necessary) for all folios.
> > +	 * Carefully handle errors and free up any available hugetlb pages
> > +	 * in an effort to make forward progress.
> >   	 */
> > -	if (clear_dtor) {
> > +retry:
> > +	ret = hugetlb_vmemmap_restore_folios(h, list, &non_op_folio);
> > +	if (ret < 0) {
> > +		bulk_vmemmap_restore_error(h, list, &non_op_folio);
> > +		goto retry;
> > +	}
> > +
> > +	/*
> > +	 * At this point, list should be empty, and there should only be
> > +	 * pages on the non_op_folio list.  free those entries.  Do note
> > +	 * that the non_op_folio list could be empty.
> > +	 */
> > +	VM_WARN_ON(!list_empty(list));
> > +	if (!list_empty(&non_op_folio)) {
> >   		spin_lock_irq(&hugetlb_lock);
> > -		list_for_each_entry(folio, list, lru)
> > +		list_for_each_entry(folio, &non_op_folio, lru)
> >   			__clear_hugetlb_destructor(h, folio);
> >   		spin_unlock_irq(&hugetlb_lock);
> >   	}
> > -	/*
> > -	 * Free folios back to low level allocators.  vmemmap and destructors
> > -	 * were taken care of above, so update_and_free_hugetlb_folio will
> > -	 * not need to take hugetlb lock.
> > -	 */
> > -	list_for_each_entry_safe(folio, t_folio, list, lru) {
> > +	list_for_each_entry_safe(folio, t_folio, &non_op_folio, lru) {
> >   		update_and_free_hugetlb_folio(h, folio, false);
> >   		cond_resched();
> >   	}
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 4558b814ffab..f827d4efcf8e 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -480,6 +480,42 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
> >   	return ret;
> >   }
> > +/**
> > + * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
> > + * @h:			hstate.
> > + * @folio_list:		list of folios.
> > + * @non_op_list:	Output list of folio for which vmemmap exists.
> > + *
> > + * Return: %0 if vmemmap exists for all folios on the list and all entries have
> > + *		been moved to non_op_list.  If an error is encountered restoring
> > + *		vmemmap for ANY folio, an error code will be returned to the
> > + *		caller.  Processing en entries stops when the first error is
> > + *		encountered.  folios processed before the error with vmemmap
> > + *		will reside on the non_op_list.  The folio that experienced the
> > + *		error and all non-processed folios will remain on folio_list.
> > + */
> > +int hugetlb_vmemmap_restore_folios(const struct hstate *h,
> > +					struct list_head *folio_list,
> > +					struct list_head *non_op_list)
> 
> non_optimized_list or vmemmap_intact_list? The abbreviation is not
> straightforward.
> 

Ok, I will be more specific.  non_optimized_list is better.

> > +{
> > +	struct folio *folio, *t_folio;
> > +	int ret = 0;
> > +
> > +	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
> > +		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
> 
> hugetlb_vmemmap_restore() has this check as well, so it is unnecessary here.
> 

Not necessary in this code, but if we want to know if restore operation
was actually performed to return 'number restored' as discussed above,
this test and an additional counter will be required.

> > +			ret = hugetlb_vmemmap_restore(h, &folio->page);
> > +			if (ret)
> > +				goto out;
> 
> Maybe we could drop the label ("out") and just breaking or returning from
> here is enough.

Yes

> > +		}
> > +
> > +		/* Add non-optimized folios to output list */
> > +		list_move(&folio->lru, non_op_list);
> > +	}
> > +
> > +out:
> > +	return ret;
> > +}
> > +
> >   /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
> >   static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
> >   {
> > diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> > index c512e388dbb4..e6378ae5c5b6 100644
> > --- a/mm/hugetlb_vmemmap.h
> > +++ b/mm/hugetlb_vmemmap.h
> > @@ -19,6 +19,9 @@
> >   #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> >   int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
> > +int hugetlb_vmemmap_restore_folios(const struct hstate *h,
> > +					struct list_head *folio_list,
> > +					struct list_head *non_op_folios);
> 
> It is better to keep 3rd name (non_op_folios) consistent with where it is
> defined (it is non_op_list).
> 

I think using non_optimized_folios everywhere will be consistent and
more descriptive.

Thanks for all your comments and suggestions!
-- 
Mike Kravetz

> >   void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
> >   void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
> > @@ -45,6 +48,13 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
> >   	return 0;
> >   }
> > +static int hugetlb_vmemmap_restore_folios(const struct hstate *h,
> > +					struct list_head *folio_list,
> > +					struct list_head *non_op_folios)
> > +{
> > +	return 0;
> > +}
> > +
> >   static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
> >   {
> >   }
> 
