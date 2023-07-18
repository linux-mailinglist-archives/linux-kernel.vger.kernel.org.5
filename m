Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B040758267
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjGRQrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjGRQri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:47:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F341B1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:47:36 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IGiRjn000351;
        Tue, 18 Jul 2023 16:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=nsEtxWnG7M+Ci3E6XIBNhh9w5WK300eT9NyDG1elKI8=;
 b=b7p+csNtu23F9+72dyxf/k4n8gzFf+Fvj07H1caaRkPZ63GjA0IRoHfxtbAxOONuqCH7
 1DXkyvLbECsdlfhyT173L9eDZsowQGJ7nXXD5vcASi5KTQ8olnuxaoXrkB5bpG5cQVSF
 shU3Nt2NsigtEsuFQEl/Jkerkyi7kHs9AgHNmUkml73qE4H/jWS0DJSAQQU8MpWQbDws
 AinkzV9aNlB5JGxEXrap14BwmNPzsTdyuP3q/WeLzFlHtXBASIXW9wTq6/BPlw6h17ae
 DmaV8EpXpX9x/yFEvF5MtNrWU6J2XhdmvfNkTM5NrmhWCAYdDqcWvuo9eo5+YeXtZJ3K xg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88nm8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 16:46:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36IGfCDD000921;
        Tue, 18 Jul 2023 16:46:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw5ctv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 16:46:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFeGU8lu4Q5TBxu78SGDnjgdXcx5z2EzVp+Iw3RG3+c2jGCWaNdYk8WqQzJyajzkSxS9f80lWkcsRCQbNeAoADJlvq92sKgTZhoklD6bRz6MjBZRKidjZf0/PhvPBrV52/gmEMPurJtHkI4tP0tGTEjHSDa0vYIy2sGX5SB3woPoQFOvhtVtO/bLhjdENHnWfciO4G2EesYXWn7iTYyxoqh5A3RnkwQKy5FL/EXoqzjHgruxcHuj3hFa1yI8xkvwJj2ruavA43c875cPPD/Jf02IN9NvaSYBujXuBgYU5V8wYy/WS9TYCUD7ux2tYL4rZWZGIVKCIWGwyqc3keFdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsEtxWnG7M+Ci3E6XIBNhh9w5WK300eT9NyDG1elKI8=;
 b=QK4sxd3U3+9b9FSPKCQjdk37WjecpXaeJThzXqDyuo7eDaocjjknL4G+EPVrNHNYuuTd9j7EteYR+eh/UjTGdqMyf5WEYivIle/9v/dqUE4Z+V4cYkMiaW1yRGP6myNMqeEtLPmY4307E7v9D20p3kBYSP692EKpA05jFqfYKVboVvC2eosd2DGzuNP3tdUEiQ7fELGByaFfprzCE/RteBJfko9riRy/kMsIQWbO+ILZwPYD3Sr2KOhUaiRsepE1V4MCpZIn/AjZaLziPYnvg74EhqcReR/8qfayw68vvqIFSvxYCViJUcIV4GhoTzXbR+777MoL9YTe4AbRjBt8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsEtxWnG7M+Ci3E6XIBNhh9w5WK300eT9NyDG1elKI8=;
 b=SH/HcgxPmGVRBYNTjdMAheGfdSwmcwlceTv+nRpcP/PcKQESrI5dQ0t7dj1UnWFFwnjRmWlsEsc6BpFnt84eP155Pp+DaZdeXw/6icEAvVKf588URH5l6wwmRpWWfWPDOlvMmNhuEskLu57j4KoKlAQ4g3oB6XIVokADxdDWTXw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4216.namprd10.prod.outlook.com (2603:10b6:610:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 16:46:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6588.017; Tue, 18 Jul 2023
 16:46:49 +0000
Date:   Tue, 18 Jul 2023 09:46:46 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] hugetlb: optimize update_and_free_pages_bulk to
 avoid lock cycles
Message-ID: <20230718164646.GA10413@monkey>
References: <20230718004942.113174-1-mike.kravetz@oracle.com>
 <20230718004942.113174-3-mike.kravetz@oracle.com>
 <CADrL8HVfBCmNYL5pM_LyHQNWyvihK=_GFnbtWB0tpTuLgiDybw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HVfBCmNYL5pM_LyHQNWyvihK=_GFnbtWB0tpTuLgiDybw@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0385.namprd04.prod.outlook.com
 (2603:10b6:303:81::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc35b7b-661c-4f46-e1dc-08db87ae94b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ai/uRse63KtjcktduF/Y1Ia83q0uWOcojDl9U/aF0KC4Wf7NFLxWNiw2wK+lsLQv3Ltjmj/6JAP/DeV6KZhTXj7YJW6MSpM1UNDA10d7a7uA7SPrEzHV2bUtbAf3Uy/KCUtOMTY07H804nwb+KxFZVk5IF3B/ff7m0zYqLIuuiKbZNA2FPeahPUDTjjSoCC/RtsbzYc0EcU4ML3jVBFzV7l7qNyFZXSgGVhr/dfq4dfgBhv3iU8Bf3RYQx6JuEZ6EkXPMrYgjZgjZqcxo7hXsbbshpEtiAokSil9Z3fgGliOFKxWBx3w+bJCSva/7EDwgHgkfVGt0aXyTgRhJFLx/MLuRWcerEehaubhvnTQZnP25xcUCP1674+CvOVl2BKr4XoYU80vDUS/UddkgTTyJOLBwDR1TKNENsf7zcUhye2+uY1U6QVwFHLOF0WnNSiTUKYCg15KiH6XWPuNOcHC0rqxvWQvqhHrNYduqqRYrAWFcFvJxIi3/Jfam4Jr+c6acp449luk5Pg26VMso3aQ+5gAp6j1j+bShg+jQqB0qWO5ViRxYV9ss4hlGRzd8ko2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(6666004)(478600001)(186003)(83380400001)(1076003)(26005)(9686003)(53546011)(6506007)(6512007)(33656002)(41300700001)(66946007)(66476007)(66556008)(316002)(6916009)(2906002)(4326008)(86362001)(33716001)(6486002)(38100700002)(54906003)(44832011)(7416002)(8936002)(8676002)(5660300002)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDdyc0ZpQjVRQ2drMlk0Tit0ZWhieGtKNUpMWUQzN09YYWFxbzJiQ04zOEZv?=
 =?utf-8?B?ZWVuaHlDSVZqZjNtZEtxS2RpZDh4RU5GYnZYREtuS2hHSExOdkxhdjVmb1Zy?=
 =?utf-8?B?ei9BMlA0UlZUbEpjYW5TZHdzbGpRRXpYcDBUa2lIWWFoZngrSTRISmExRmlt?=
 =?utf-8?B?RmRqcjIxa0NXTlEvSnJORVRGeXlBTHVOUlFjUm56NmxOR08zL0Jmdkc4RkN0?=
 =?utf-8?B?djV2eHQ0cTZsdkRMSVBoZE5WS050SmRJa2l5dElyd3EvZ01QTVY5VFM5dUdX?=
 =?utf-8?B?SEgwMWpyL1VPalVPd2VpZ21BYmhpOGtkZnI4QjRLMjVPVXFlN0RqTzZBMzN1?=
 =?utf-8?B?MXJYTk1GMk42NEgwL3EvRWR0R3ZzKzAxcUVSRExqS3k1dldyeWxFRmJVYTR5?=
 =?utf-8?B?YVRPbk5VL3V4d3dvRHBXYzFoWmxBb0dNSUxpME1ldklBVy8xc0x1cUs1bFVk?=
 =?utf-8?B?bUR2WVMyM3Q2cjBQRlFNQUxRT1JlaVl3VWt2ZHY0MWxMUDVkOXE5Z28zVUg5?=
 =?utf-8?B?VHFKdGhSYUxwMkpEaXhlek8wQ2krZVZwOVNsbURRTzBGNzdFWTloVkx2L2ll?=
 =?utf-8?B?WEJ2WVNhQzVLM29JUGdoaTExc0VWeE9zNkk0NE9rM0QvbmlLUHArTXVWUkFr?=
 =?utf-8?B?b2twUVNFQUlHMVY3ZzltWm9WQms5RDFZanNHSFRoOFRMVlltSC9UN1JKRG9v?=
 =?utf-8?B?Tjd6QmFCZlcwbEtiM21LenF5U1BmcEJ0YnBXNTF3MDVBWGsvWWd4WXlXODV5?=
 =?utf-8?B?Q21wU3R3R1pDNXlBMVp2dHliY2pONEdEY1J3ZHlkZFZneVVackNPeHFYL0J1?=
 =?utf-8?B?RTB0U2RwbkJjYmVjTFVoRHFDb1NBb1J1em50UXorVm5PQVFvMHhXR21qUXNH?=
 =?utf-8?B?SkhvSVJXTDRzUmFucStLY2ZqZEUyczlneW9iQWw0amEweTVxOU53bFJYa0Zp?=
 =?utf-8?B?NFhpaWZDMHZsTDRzS1pPRWJINVhkb2dIbEcrK01VdUFGMGVvK2plMS83eS9s?=
 =?utf-8?B?VGs3MVcvMjRuaHFKclhpNVVTSGNoQ1dlek1TRVNUbmZzY0dKYjh6djdUWThR?=
 =?utf-8?B?TWk1NjlNMmRxODMzQUVReFpSQXFtYUcycW1XVVZQSTdFakdNL3pjekNudVdi?=
 =?utf-8?B?dGZoUnBPSi80NzYwMEI4N3pzWTRMRUZOSnltKzkyemZaWEJGOEpsYkxrY3cr?=
 =?utf-8?B?RlVFRXNWN1BOL2pFV0lMWFdOOVA3clRmTEVmQmhtQVo4a01mTnZZN0lEcG9M?=
 =?utf-8?B?YlJ4NTdmUE9qNmhySmZFWEt3dXRlV0FjM3lPaVI3RElkQVFFUExlOCtOQUVR?=
 =?utf-8?B?dmJaUllocWl6c0NvK3B6VjJOelIwSnRtSnRCaXg0RWtVcUpFVUdqOENJUzhL?=
 =?utf-8?B?djRtUStwT1ErRklvRlhFejMvZUNkUUI4bC9oMHgzcjlSSkk3bCtjSFYxVmdJ?=
 =?utf-8?B?cVUvdjRTY01xcjJ0UEJxR2Z2N1NIekluQVNGNVpZS1VvcFNwY29kMkJ5dk1q?=
 =?utf-8?B?VStzQVZCd0NCeVNpSjBVN3dab0s0QjBWbTNNVFFuUUs3d3BZTWQwUjZjNCty?=
 =?utf-8?B?cU50ZVhrUDBDcDJVcXphSiswcWg1VnNqSHJKSThYSEpaQlRDYUw4RGJSb1BP?=
 =?utf-8?B?NFRwSUs4ZHVTNHU4YnNuK09QYkk2SVhValFuRDJJQkYrdWcyQUdwUUpyUGNT?=
 =?utf-8?B?dXhTbW12ZWg3aFArRU16b2cwMkNBWnMvRlFqVS9DckJRSjd5c0kxdk02OEFM?=
 =?utf-8?B?aTFsUlhoMmh1OEk2YkMwWWxUK21ZSUp4NThBNGRjSFJXSDBZNmIvWjNnbm1s?=
 =?utf-8?B?NEZzckJqWFNEa2tFUXdFU3RWQ1Qxci9oT0ZRNjVuSE9ueWg1U3ZTbFFMWHpG?=
 =?utf-8?B?RGhzekxSU2NkNWpoaXVNNjRIeWVhWGxlTk40WnZRYUZTeFhZTTZvQUpZZThP?=
 =?utf-8?B?MEdmQ2JKWHk3c0VOckxkbit3SXd3MCtKZlJreEN2K1p2Vzd4dEhJNmFGcFRh?=
 =?utf-8?B?dHdXcXF6RFVNSHhkcTIzZURZckZJWEtmenJlM1hQalNqYjZiZDZMbi9ObWE0?=
 =?utf-8?B?elJ0OXZnd3lBcHJKUVRId040RmhkbmRJL0M5emZoWnUxa1E3eGliOFVIL3hS?=
 =?utf-8?Q?W+xm0AmEJ2XQ5LlWxXiSfvb/+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eXJIa1V2ekY1Wk9qcC90MnF2STVnbStaWCtWZEg0a1p5RGdHZE5xRUVpS1ZY?=
 =?utf-8?B?dXRKNHEwWHl5Qlk1TXNMVUxuT2tidnZtU3hLNVRHTjZvaHlkUHo5U3RCZitm?=
 =?utf-8?B?YkQ5TGkrTlRXcHBIc0ZaM3VULzA5b1VlVm9mSlJ2RUVjUEJuU3NvV3N0L29U?=
 =?utf-8?B?Y1dEOEZaMVZWcUdBSHkxcjloQTY3T0lPY0lXamg3WTNGNFFVcDFQYmlBK3ls?=
 =?utf-8?B?THNmZmpxT0J6T2tZNFZ5ZlYwV0dhRjloWkVTSjJpbmZFZ2FBLy9XSEZQTlNj?=
 =?utf-8?B?MzFHNlVIM1M1ZEMwdUZneXV4L2Y4NjI4ZUVNaGlxUW8vUUhtdDFUR3pUbnpO?=
 =?utf-8?B?ODNIdXFjRDIrLzVMRld6dUJVSlhjclFJczd6VjFJUHB4SXJDSy9XNURPaW5C?=
 =?utf-8?B?MTdTU04yRUk3c2h5Z3l3MjFrOFRZZXN6QmcxVkNFeXNjcFJVZ1BucFlLNEYx?=
 =?utf-8?B?d3FsWWZYYm9BU2NLR1MwSU9PNW1BVG5wNUJWVjY5UWxIbm4vUk13RTVKenV6?=
 =?utf-8?B?WFlwQUo2NzdTMmtSWW9oZExoanphV3FwSEpaNmg5VklZWCsyVDZLczJ2ZlU4?=
 =?utf-8?B?V0hDNXNZQlkzMXdMbG1IYzBlVlgxOE1CL0hhdUI5dllLWU1HNDNvWXAxcHpI?=
 =?utf-8?B?c1l3bDZKWVZFb1FkelMvM0I4anlXQnhiaEZiTDQ2b0tFbnlxajhQeEpUblYz?=
 =?utf-8?B?RXpVTmk1cXU3cTNUTXNWNEZreTI4UzdnbW8vVzlPSGJEUDgrbTIwdmx4OW9Q?=
 =?utf-8?B?d09WZ1poOG9kSDk4MEJBNndFQ3NtTWk0aXhEQ2RtTWlqYVA3ZkIwQno4ZDEv?=
 =?utf-8?B?ZWV4azY2aEZVcmxxbmhxL0VWT2drSkZFVHhVbHRRblREQUo1V1NEYjFBbzN2?=
 =?utf-8?B?NkVGYVg4anlrbElVbDV5cGJzS1l0SXNpZDJlS2NRLzk4YUdydjhmM3NtVFVm?=
 =?utf-8?B?cHlMRm9RM0w4Um1aN1p6bXNNNDBmZlRuWmlEUHg1K3prbVkwZDBjZGtUT1BQ?=
 =?utf-8?B?N0Y5SzlwS25tN0Vwd0RmOW1sNlpkaWRWZDl4OHo3ZlF6T1h0OW1FMS9rT1NT?=
 =?utf-8?B?Qmd1a1BhQ1BCMU5mZEF1Ym1QVnM4dTZ0Q1V0TzVJMk9ORnI1NjhtMU42dVR3?=
 =?utf-8?B?cUpuWjVYSGNGYUFiM0RWay9QWEZ5alY4Q0dnUWJzOGVjQ0VWVHRGZXdEUXc0?=
 =?utf-8?B?Ukw5OXhsSlZHQnZ3ZEo5UmF5UjR4VGV6UFdCZXl2T3E3b0h1OFk5Y3lqTW9Z?=
 =?utf-8?B?Q2ljbDlHbUJuc0lxbjdCTjdHZmN4Q1VMb0I4SCsvYWRSVFVaZUU4cTY5Q3pX?=
 =?utf-8?Q?tsRaOb+1/pn5Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc35b7b-661c-4f46-e1dc-08db87ae94b9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 16:46:49.4422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+QxDjhVoh6e7+AiBGIa25uvhVXEcOmslCa1v7476M4lS4KjeRDDsqS8GxArYk5Lzf7YV1k1oYJauZI64MO1mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_13,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180154
X-Proofpoint-GUID: RLtSQ1jwMsN7NiqU-tzQGAPaiXpetxQB
X-Proofpoint-ORIG-GUID: RLtSQ1jwMsN7NiqU-tzQGAPaiXpetxQB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/23 09:31, James Houghton wrote:
> On Mon, Jul 17, 2023 at 5:50 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > update_and_free_pages_bulk is designed to free a list of hugetlb pages
> > back to their associated lower level allocators.  This may require
> > allocating vmemmmap pages associated with each hugetlb page.  The
> > hugetlb page destructor must be changed before pages are freed to lower
> > level allocators.  However, the destructor must be changed under the
> > hugetlb lock.  This means there is potentially one lock cycle per page.
> >
> > Minimize the number of lock cycles in update_and_free_pages_bulk by:
> > 1) allocating necessary vmemmap for all hugetlb pages on the list
> > 2) take hugetlb lock and clear destructor for all pages on the list
> > 3) free all pages on list back to low level allocators
> >
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >  mm/hugetlb.c | 38 ++++++++++++++++++++++++++++++++++----
> >  1 file changed, 34 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 4a910121a647..e6b780291539 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1856,13 +1856,43 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
> >  static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> >  {
> >         struct page *page, *t_page;
> > -       struct folio *folio;
> > +       bool clear_dtor = false;
> >
> > +       /*
> > +        * First allocate required vmemmmap for all pages on list.  If vmemmap
> > +        * can not be allocated, we can not free page to lower level allocator,
> > +        * so add back as hugetlb surplus page.
> > +        */
> >         list_for_each_entry_safe(page, t_page, list, lru) {
> > -               folio = page_folio(page);
> > -               update_and_free_hugetlb_folio(h, folio, false);
> > -               cond_resched();
> > +               if (HPageVmemmapOptimized(page)) {
> > +                       if (hugetlb_vmemmap_restore(h, page)) {
> > +                               spin_lock_irq(&hugetlb_lock);
> > +                               add_hugetlb_folio(h, page_folio(page), true);
> > +                               spin_unlock_irq(&hugetlb_lock);
> > +                       } else
> > +                               clear_dtor = true;
> > +                       cond_resched();
> > +               }
> > +       }
> > +
> > +       /*
> > +        * If vmemmmap allocation performed above, then take lock to clear
> 
> s/vmemmmap/vmemmap. Also is a little hard to understand, something
> like "If vmemmap allocation was performed above for any folios,
> then..." seems clearer to me.
> 

Typo :(
Yes, that would be more clear ... see below.

> > +        * destructor of all pages on list.
> > +        */
> > +       if (clear_dtor) {
> > +               spin_lock_irq(&hugetlb_lock);
> > +               list_for_each_entry(page, list, lru)
> > +                       __clear_hugetlb_destructor(h, page_folio(page));
> > +               spin_unlock_irq(&hugetlb_lock);
> >         }
> 
> I'm not too familiar with this code, but the above block seems weird
> to me. If we successfully allocated the vmemmap for *any* folio, we
> clear the hugetlb destructor for all the folios? I feel like we should
> only be clearing the hugetlb destructor for all folios if the vmemmap
> allocation succeeded for *all* folios. If the code is functionally
> correct as is, I'm a little bit confused why we need `clear_dtor`; it
> seems like this function doesn't really need it. (I could have some
> huge misunderstanding here.)
> 

Yes, it is a bit strange.

I was thinking this has to also handle the case where hugetlb vmemmap
optimization is off system wide.  In that case, clear_dtor would never
be set and there is no sense in ever walking the list and calling
__clear_hugetlb_destructor() would would be a NOOP in this case.  Think
of the case where there are TBs of hugetlb pages.

That is one of the reasons I made __clear_hugetlb_destructor() check
for the need to modify the destructor.  The other reason is in the
dissolve_free_huge_page() code path where we allocate vmemmap.  I
suppose, there could be an explicit call to __clear_hugetlb_destructor()
in dissolve_free_huge_page.  But, I thought it might be better if
we just handled both cases here.

My thinking is that the clear_dtor boolean would tell us if vmemmap was
restored for ANY hugetlb page.  I am aware that just because vmemmap was
allocated for one page, does not mean that it was allocated for others.
However, in the common case where hugetlb vmemmap optimization is on
system wide, we would have allocated vmemmap for all pages on the list
and would need to clear the destructor for them all.

So, clear_dtor is really just an optimization for the
hugetlb_free_vmemmap=off case.  Perhaps that is just over thinking and
not a useful miro-optimization.

Thanks for taking a look!
-- 
Mike Kravetz

> > +
> > +       /*
> > +        * Free pages back to low level allocators.  vmemmap and destructors
> > +        * were taken care of above, so update_and_free_hugetlb_folio will
> > +        * not need to take hugetlb lock.
> > +        */
> > +       list_for_each_entry_safe(page, t_page, list, lru)
> > +               update_and_free_hugetlb_folio(h, page_folio(page), false);
> >  }
> >
> >  struct hstate *size_to_hstate(unsigned long size)
> > --
> > 2.41.0
> >
