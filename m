Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2257792B17
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbjIEQrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345339AbjIEEGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:06:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415E2CC7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 21:06:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3853PHpL011366;
        Tue, 5 Sep 2023 04:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OSUxTeGQYbpvX2qykR6xYqQMoTd6ZVGAlJyVnEt4WxA=;
 b=moXcTqLBdVBftkQRpO9cuQhIoDObk5up2MsBjqBaXVvM4yKd6XfOTb8B5DE1Om1Lx0kt
 wdsP2D6ZTYgV/ANLNq+KTa3XtllK256tzNQSHwWRCBNZjMHGSS2+ub3VXPDC9OrqEBSf
 QqFl1CzXLSeK3MYuV5ic+2wjNk5YBE7tn3not/FUmwSXRQ7OvnjcF51XyMwbCAgqJDTZ
 4SxzSDt1wFSpJ4BJmZIxbJQ97XDSJTpYTXAevscJAekBYA60bAIvy3YBAuz9Zea7g13A
 vGK/5G5nr8K6U7fL43X2EKL9Hri3PwOLxWHz/TajPsVxUulajKcjp2RZGeb/bNuYPOyP Mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3suuu3m9yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 04:05:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3850oKnN028173;
        Tue, 5 Sep 2023 04:05:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug48083-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 04:05:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMvHgQbxx2AXGdQdOo5x24lHLNVB25Cqv5e5S542olLLLpYKQ5ssTiGLAwe+AEVIRomtgP0s6UO6nAqrmfzvNddxt13FP0s++LmPzGuUWMjOtxAHzCp8jN3nMVwtGhOCLdf03aZsD2XFR6QmX3AV4h4SPGbqKWZiWrr2o6QYE9y9pSE+CjuvaINmxrqxX0J4tdMJeejnZS3rEqsxs3qNmVWjl6pxD21kgC37uqjf8zsFsbI4NM9K7IJ5oBmlu/nAHn+YF83rRpjjxmTSgrUW5m2W5q4I1FXBnoXhVtAgdf4sRvWUQlbjC7OOq0Cj/kWowIbohCV/sw5sm7e/AaxUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSUxTeGQYbpvX2qykR6xYqQMoTd6ZVGAlJyVnEt4WxA=;
 b=U8iLYZHwSixZ/fGwa2ZtTKX27Bv///zuPPSnrSoaKV0zYXuuE+ui1DP6U/RSs/zCZIpRIfxhOUQCl4UCIETd5GI188xCTw6BoGTVJtowTALEPjrq49yWptlwoB7pUciI0tdSzzezh+SZJBIQhVfyTNPdGA6YADItWMtaigydPDK3YpR8rzQu3P/bVXYsr//8L+hyQgqRTNYSaV9FGl/NoX66cEnuTz//ZHXvHEYR3Uh8OzsOo8boyJSQjkp/6qRpkKM6cYXXpjJl316KZfuHY+X3jzIrEa5xvKZUGHEw8DqCCEcXjc34ndHFan15JKLFJFoB/ohL4v8ja8NxOlaLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSUxTeGQYbpvX2qykR6xYqQMoTd6ZVGAlJyVnEt4WxA=;
 b=pcGMz4HBLqQd8SDzezCwOrxdgQ1OBskM79rUbVolX+IPhrwNm5don9oktj7SVJbCvtIoIIb3FTTXkAc9W59qe7nMAAkAjp7wWh43tD379zJprMwgkKwXx86tGUbtuBXJO2mB0ygZBvOCxrEEojsUVABBuC0hvL8s0cL9jLJ9P70=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB4470.namprd10.prod.outlook.com (2603:10b6:510:41::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 04:05:38 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 04:05:38 +0000
Message-ID: <c2519e75-2354-9dc0-d771-c7ad2bbcf80d@oracle.com>
Date:   Mon, 4 Sep 2023 21:05:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6] mm/filemap: remove hugetlb special casing in filemap.c
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org
References: <20230817181836.103744-1-sidhartha.kumar@oracle.com>
 <20230821183351.GA3377@monkey>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230821183351.GA3377@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:40::19) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d0a819-e91e-4c3d-b34a-08dbadc55d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fomMc0yDhAOf21thrx/yS6xIb+Tnzjt9j6QUEhxNZktDvesPTczljEG0ssHliBNQfAej5CE00llac15J7dU2dOXzvB4sEDNyiDcR7uALQ7s6hmjaY5RcnKFxIy8bpUCCKCg7gEBNrGBWgkifk0fhNzZ0yUNqlkqX580XRzMHQ6blCno+3Ypi7cKZj+owa1fvlrWrd7yzTOfcCQgcGeLsoWw0rm96DMr29kMGDNmRObCjh5QGI2kdbZgvGM2czTHLqqwmFBFQt6PVqV2EEFD0JijiYAiq50q8ImagYMgf4DWImjm5yEWEVcSWCOg8HcOpoS1yrJ6lQITJ+4YZ23CKCAP0f/L5516gBVVze1jWL0Md+EyK5QW4fEI2y/TgsGZFrN6nM7vANI3wW3wyoIr6hcYuzTaw4IvCNGakB9FMzU37L4S4uUQUtPPcA3bmTg2VXRg4CP2X6amSzY9Z9rPbvKF2g1RSwVLHIvFi7L9X4HNHm2Mm/3q63yonNDHamW+qWbmJVtRZWLrGHVhsh6mdF8zWyW8lXD9V19+10S3G6oOhcLgeYeCAYk9Zs7jZQNGuVOoZAifjUoHZQ/kteGNXlKfgWAGePat5mOWvQ/D5YSslGxQ//yRHw0O54fLxLWMQNuNRQlTOlKIAPwMfVCTKAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(186009)(1800799009)(451199024)(6512007)(6666004)(6486002)(6506007)(53546011)(83380400001)(86362001)(31696002)(38100700002)(36756003)(2616005)(41300700001)(6636002)(316002)(37006003)(66556008)(66476007)(66946007)(2906002)(8676002)(31686004)(8936002)(4326008)(5660300002)(44832011)(478600001)(6862004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1J6MjF3ZWY1Wis1anRVVzRXZXRFQ0tNeXVzTjVSVGZkZXpYc3pMN3VsK3Jx?=
 =?utf-8?B?RlljR2V5Q0dtK09NekFlRHVoa0pSVXNSQ0psUXBuTGJrOE9DQXRsNWpCcHpI?=
 =?utf-8?B?ajdHQWxBQW8zdUlNN1paNnc5eks0dXRQNjZteEw1YXBjTVNlTXRzNVByc29r?=
 =?utf-8?B?anFPdmFxNCtaaDlzZGZzRTlmT0hBdVdMamhaSWs1a0ZER2dLbFN5dU5CSjhm?=
 =?utf-8?B?dXBRa0Nkc2Y2Unp0SjczaGdaT0ViOHdVR3Bzb0YzSXA0L08xbEFzUUNydm1R?=
 =?utf-8?B?ZGdGSjFzUHlVeXVKN3ZPVTlmNGRuS3daeDh6aTBGbFFDZzV0ZXgrV0hRL1JR?=
 =?utf-8?B?RFNFQlZNQi95WkRJUkx3OXhzamVKSGZCOXU0dGlHc0FwN3F3TVhyS0V5Uktq?=
 =?utf-8?B?dkJuZHNadDIxR3RrVHVNakJpenNGU01pV3RXSWFrTVhkL1lmbjRIMlNzVVFa?=
 =?utf-8?B?ZE14WjhnbE5hTEpBNUEzUWx2d3dZMG1TblJoYWFUS3d3Z3lXWlJPVHlwUTR6?=
 =?utf-8?B?UUJIMGpoQ1gvMThyanhTSllUVSsxaXRCOVFYZHRYZkNMSXNJbk9ocmhkNDRG?=
 =?utf-8?B?Y2J3alF0MVBIaU96T3lZaFdvT0NhTEZHeGdtQnRnK2djSnhjdDhEL1pRMFZM?=
 =?utf-8?B?SEFFNGdaY1d3Rnh2TDFGL0tsZ0VOb1pWdzZ5Z1dtMkZBNnFGQUcxWnY3MnZk?=
 =?utf-8?B?Z01DOXgwbkE2RnByT1o1bVFUaWpRTkVUUjRzR29uQkVKc2xHWUxReHlZTktD?=
 =?utf-8?B?M1EzK0xJNDZEM1pHeWkyQ2xQT0ZXaXJNMnc3R1UyMVFEUy9rZlR5aEc0M2JR?=
 =?utf-8?B?MEtiaFZhVVZFY0pDK29MK05STmpIN3ZCVTY2eWVTVGtwdTd0UUZxK3M2cnlN?=
 =?utf-8?B?cjVIVFNGcTlrRTlqd2NDdDdKRzRhWXZqcDJmbnBvbUZDQmorcVlQQ1hKYkdD?=
 =?utf-8?B?MEQzTkR3U0VZUTlYbXFCWWdqdzMxL2N4Nlk0OVcvckpFRXhHTEtSazZaSm1L?=
 =?utf-8?B?WmcvQXAvazdOaHRwbGFHSnZpUlp2OThhYWFDWVBiaDl0cWRtY1B0YW42NUFE?=
 =?utf-8?B?T1dDVmErQzZtaUozYm9oQlI5UTdTTmNWaWZWWTBZMWZUQkdwNUs4ZkRYNE9V?=
 =?utf-8?B?MVhkT3lSdVE1RDVnZmpJQkM5cjNKaWxiWmJucHVlQTdTYXl1aWxFcm5vbmZt?=
 =?utf-8?B?SGZVNUdkdmVqaVZtVSt4M1hBZHBOZTVNd201MmNyenF0UTVaRHlvRHNYeFpP?=
 =?utf-8?B?QlFCbzhOTzdQUWxpZncyTXA0ZlI5ckdQdTV3TWlKdURpK2M4UFNjblE5Q0dB?=
 =?utf-8?B?dXJSVFYveG9uanFpc2t1TE9TcGVRYWJZdy9ieEFoRTlUK3UxZFpaNVlSajNC?=
 =?utf-8?B?cHIrUnFIdFN0a24wVEFFQ3grSXB6bktPNWt0NER4d0ZGTEtsZFUyT0gzZzZL?=
 =?utf-8?B?Y1Y0OEFQV0w3R3h6YzAvRmVsQVU5cGN6TWtBN0lLOGFhUU9mOEQ1cmJGT2lh?=
 =?utf-8?B?NktPRTJiMGd5d2JGc3d5bHhLTkJjdlZPQ2s4VkprOHkvNSt1UFgrMklISzJG?=
 =?utf-8?B?alpJRExYaGF0aER5VmxvTDNPOEhGcElsZlNvMUh6eFZpR0RTbE9PZ3F4UWtm?=
 =?utf-8?B?Sy9SUmp0ZFdkQzU4Q0t6cTZvUUJ1eDN6MTd3SXlXM0xoZmFvQWFlSkluM2RB?=
 =?utf-8?B?VkI2QmtkT0lBZTFjaEEzSzlUU3hPeFhpOE15emkvUlc5VUhENjNFR1g0aHdv?=
 =?utf-8?B?cHRRazhickZsOU9XNGJPRHJzaCtKc1hzQWR1dlA2UmdhNXc1d0tkZ2NmdG4v?=
 =?utf-8?B?RmxDS1hETE9Va05HU3pNU01ieXVGSURuRy9DVDRyaytQTG5hYnZDUG0zZWxu?=
 =?utf-8?B?eHhteEN0WVJTbWxVaUR6S1BaeEU1ejh3enVLRmFaOXlocEg1L2IyZ0dnMEZT?=
 =?utf-8?B?bnBUVEp2VnNOZ0FCYld3c3lrL1IzQnhTbllzbVA0cEJqMDkyN3M4WGVqb1Zm?=
 =?utf-8?B?SDhxZzZ6T0F2VldZOG4zdWtwdENaeDFwbWt4Yng3UmR5SnBJYWJscXh0Yld0?=
 =?utf-8?B?dU4xM3Fad2ZHdUdvVHgyV3BUMm42eWpSM1dDenJRUWoraFdoN0FCMjA1Qmdw?=
 =?utf-8?B?NXFJWTFiMUZ3QmtnRVdaRTFrS1E4UlJHVzI1VGJpVDdoeHpocUpaTkpFQUNI?=
 =?utf-8?Q?uEfcP/tSHdAgKpEjUHQY6CQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RoVq2NJVXw+pHO82Ul5oc5wg6ODNYIbF0soCDGoYrlUpK3FZZkyOKTaT38xs0du5dbHR6EJdfso5EdcHxIzCevELPTFaFFUs4bxfLo79MOFVRefeJqnbnTX6xjRx9Bfv3KuGBZb0B2nHAtaJGSwScMRrUOgKchBGq3QIx/At1xbELJhNv3AMbDdBjaccwXgS88o4aMXskZiGCFVllEmydoZkb/5jch0rJtaDSoCZjw2CeJF7WJO75Xt3JNb6+zddmaiJdjttxa5n0a0coNte5jBNLuOk+csGeEyJIcQohIpN3i2rMcOklof5w/V+CKRWUo0WVV5BQOtFwyBO0Zrm07XPtX8f804bQKFQqVXZTxmdRFf3tuyAyjr8Mzmq7ebfLsa1FbypI3Fi4+0cRDxYS6g6qNEHjnAgA2z0f+0d/wzzBkzPQmIkJX2Cdr7mEPE0s8sAken43LgYL2iSRQ2KN4BvT0AN47yhT7kWq0Ceny+3P8RygmPC4mglqv3AzDI9+92IEQNcZ7D9vftpmXQYJd16K0lmHhOoU6zHrptn4iHjwhLIO3/j5N4JhaQE1b4trGRUW5cLiAZHa68SmM/PNOokZj3Oc1tjBL8UbSPNU9bRRr/vJ8BFBxWhIWngh1gHXZczMXou89zfYELxfmNWSqJjjkCpDNIIcLp9r+csaKGU5S5luisqxJWaRwnz4B+bK9IuVxGgLg7ujhIcmmOU5b6uL30tzRJCdUPnGPVzomI43agE3aSeUN9h50hVyBdsEUXco79u0rlDDUCug6ozE20uK84xo11uMMxuDbpxr/pfNNxC69CKpmRWIxMKu4w7OBh0ndS8Xu9rUOOI8gPDYnSeHDpHKNCkOt44BECroM3pfK7VdMaylJ9qDwUz7I75WEAI0VWTgt9g5KGtpoXL8yIaaLT8UVxG0PUG/hq10go=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d0a819-e91e-4c3d-b34a-08dbadc55d0c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 04:05:38.6863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmxe/EuxV3swbiENhz1AfPsmXpgthvC2RigxxjJ9KPK4+Z6HIRt++WlmBYrKi6lRoV7uzAyAzf3/RxGv8Z0JnFpptBdlPbFw21TCdpTA9d0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4470
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_02,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050035
X-Proofpoint-ORIG-GUID: KSo_EJgrnsdF7XF2y_KEORkxkNecGwau
X-Proofpoint-GUID: KSo_EJgrnsdF7XF2y_KEORkxkNecGwau
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23 11:33 AM, Mike Kravetz wrote:
> On 08/17/23 11:18, Sidhartha Kumar wrote:
>> Remove special cased hugetlb handling code within the page cache by
>> changing the granularity of each index to the base page size rather than
>> the huge page size. Adds new wrappers for hugetlb code to to interact with the
>> page cache which convert to a linear index.
> <snip>
>> @@ -237,7 +234,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
>>   	if (free_folio)
>>   		free_folio(folio);
>>   
>> -	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
>> +	if (folio_test_large(folio))
>>   		refs = folio_nr_pages(folio);
>>   	folio_put_refs(folio, refs);
>>   }
>> @@ -858,14 +855,15 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>>   
>>   	if (!huge) {
>>   		int error = mem_cgroup_charge(folio, NULL, gfp);
>> -		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
>>   		if (error)
>>   			return error;
>>   		charged = true;
>> -		xas_set_order(&xas, index, folio_order(folio));
>> -		nr = folio_nr_pages(folio);
>>   	}
> 
> When a hugetlb page is added to the page cache, the ref count will now
> be increased by folio_nr_pages.  So, the ref count for a 2MB hugetlb page
> on x86 will be increased by 512.
> 
> We will need a corresponding change to migrate_huge_page_move_mapping().
> For migration, the ref count is checked as follows:
> 
> 	xas_lock_irq(&xas);
> 	expected_count = 2 + folio_has_private(src);
Hi Mike,

Thanks for catching this. Changing this line to:
+	expected_count = folio_expected_refs(mapping, src);
seems to fix migration from my testing. My test was inserting a sleep() 
in the hugepage-mmap.c selftest and running the migratepages command.

With this version of the patch:
migrate_pages(44906, 65, [0x0000000000000001], [0x0000000000000002]) = 75
which means 75 pages did not migrate and after the change to 
folio_expected_refs():
migrate_pages(7344, 65, [0x0000000000000001], [0x0000000000000002]) = 0

Does that change look correct to you?

Thanks,
Sid Kumar


> 	if (!folio_ref_freeze(src, expected_count)) {
> 		xas_unlock_irq(&xas);
> 		return -EAGAIN;
> 	}
> 
> So, this patch will break hugetlb migration of hugetlb pages in the page
> cache.
> 
> Sorry for not noticing this earlier.

