Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F4779DDA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbjIMBfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjIMBfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:35:05 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazolkn19013050.outbound.protection.outlook.com [52.103.11.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A4110F6;
        Tue, 12 Sep 2023 18:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlF2m4rLdwr4XT9CCwkeszfRvnn1P2V6rqjCX0Miob3IZPnKiW6nNsL5cCkILTaDfKZMPa6ffqhXFejrI0ytHbbQfZ9Gpt/kYilImLBcg+CieVl1rgkUWF1hlQioAKakj+A1NCTOAEAEuNfV0T1A07kk0fbTDs50YzKwBbQgxGg3I+BraFl3DsApZ5WMAlxERY+aHzvCGvUq56uH4fNVqsTYPo5KIt+5W7QNgwGgu11uh0YjAeOR4jkvZ8NodGRO6RHX4tZf++0ZF3DXh1ocgVeYFZ517sLpUvimJAucTErmDgwMLWSdvblsiRqEDoW4JwJodOLwksbwmUSm4AKu/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXVLcwbqLjqM2QNMeqz+Jj6XoD9n2u/dKbetrraAbh4=;
 b=cRNK3qidcrWdxCVY1bnu9KP5iFKPOGMcLigBtuS9tYhcyWyMvvEPxIqIpKrI7y6c4Pu4yVlDhgYJoZSJng0gCRvsHEtK+WGZIkJRugbCIY1RaqxNdXb3eByFFFvr74Qx9Id9eitqJYEAGJF+laY1ydLn1Q8K7T32CgGB7QHySGXFa947deS9XeOYLpfQySHEcG4BdgweVmQc3SwTCE/yiikaDXHmCKqN1mqEVODFAsZZ/jtbnfEcTpNe97q+0EnL/HZCwkuSbys1n7WRWrAXJeNtap7dGdxxfi+T6VYbNXyIh6MOy4LNRLShkJPLz+RkaUS5I4M3n9UpFnqEWQAzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXVLcwbqLjqM2QNMeqz+Jj6XoD9n2u/dKbetrraAbh4=;
 b=m/8Dc5Bq4P71taW4zuduS4z5df9TNl1k98yLKvYzxGlC2Y8wycWTS18YTxM/rsBuf50SMYv10kTLLA5QQuPYEcRZzaH5xDdafRxJqIFS1E7aqFFhFHC6X4sYa3XirSAa1sTMLcNqIOxEl2xBJWneSv1WReBvkEoyHNe5ySUEnSsFXzjBhkLcJ5FXUcukoCZ/a1blPK+D2+VUVPwePQ6Oejyw/VqVXdO3rZZifEYkjoDRRkOWHjKuSbdKHKQO6Q/w6SQR3Ji8YMBYtXwg9Hgi2xW54EBsqYb2Z4qOO7lEl9kgY4XOcqhZSzSiN7WQ0L6L9J/XGhTfpSqjkDyWruayVg==
Received: from CY8PR05MB9378.namprd05.prod.outlook.com (2603:10b6:930:91::8)
 by PH7PR05MB9858.namprd05.prod.outlook.com (2603:10b6:510:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 01:34:59 +0000
Received: from CY8PR05MB9378.namprd05.prod.outlook.com
 ([fe80::3ea2:7971:7c79:b09f]) by CY8PR05MB9378.namprd05.prod.outlook.com
 ([fe80::3ea2:7971:7c79:b09f%3]) with mapi id 15.20.6745.034; Wed, 13 Sep 2023
 01:34:59 +0000
Message-ID: <CY8PR05MB9378C5CE9BDB61987D6D68D4CDF0A@CY8PR05MB9378.namprd05.prod.outlook.com>
Date:   Wed, 13 Sep 2023 09:33:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V2] xfs: use roundup_pow_of_two instead of ffs during
 xlog_find_tail
To:     Dave Chinner <david@fromorbit.com>
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <63b3742c-0efe-c096-c737-a0e0419480bd@outlook.com>
 <CY8PR05MB9378060FDF6C7E15589EB668CDF1A@CY8PR05MB9378.namprd05.prod.outlook.com>
 <ZQDp1fNUgmJevXLr@dread.disaster.area>
Content-Language: en-US
From:   Wang Jianchao <jianchwa@outlook.com>
In-Reply-To: <ZQDp1fNUgmJevXLr@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [nyvBSkCY+UKLxaFi6gHn4vmmLdTrOhUbHCzVRHraC64=]
X-ClientProxiedBy: PS2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::22) To CY8PR05MB9378.namprd05.prod.outlook.com
 (2603:10b6:930:91::8)
X-Microsoft-Original-Message-ID: <3f6fe965-67f5-c7f8-4468-decc8f0ad3bc@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR05MB9378:EE_|PH7PR05MB9858:EE_
X-MS-Office365-Filtering-Correlation-Id: 668c6587-e50a-468a-f1bc-08dbb3f9a3ed
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: diCbBEsFGOyw6IcpWfOoRZoFb9b9RAGB9SgrYRRn6zsA4t5sz166TG3BNXD7pnfpCcWAVA++mkr3OzGzuHbwhyq2OsA4L6TRvafqqaySbA6gMGOQFLcFciL4fTBRl0rpxr4El8kQ5qq+k34Ao3NRI1XQqroZWwWngRoOCzTLuHtUBLz6Uym4j5Z3/Bbd3rW2AKHwnHw3ccXN1rTdMY/EzbeA/aDo2jGlqO7Psol/imWz8YKn6hbW0sPhu9bKWW+GuHj1IPr8KYqRq4yRWD4INRpFyh2ewyiRsFIXIq3XKQR+GlEIkBXTZTmmxZGkHlTpq+zrfCue9wbzYBfeaHu+ZlbTPn9YLESW2de4FK2sEakkLCG6WQjpwar5SqxqvLqDQMA+Qq2VvidXHKdiLDjGmlOZ4BocHOOQxWWOX8qx3x6cfjOmKgoxiL8yweo7ZppnKbNqEVeSI+V0cfSLHRUJ2D4SnruPXtZhSD3KJR+B7ZLxq+Gw2acO5HKthe2uZNoCS/V89okAoRfTMYW/cahhU+HWIVziaUT7KNa3TTqidPdgY1e9bBCI4uMXYM/JaRKe
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlYzUXYxOTBSNFQyRGcyWkNOYk5oSzlEZ3poaERRYmNCdm5WYVUwcm9ZNE5W?=
 =?utf-8?B?VUszMXVES2hySlhyd3NJU3Q3UCsvN0NIUTRBS0x3Y25rTmpaY0xwSU1ET002?=
 =?utf-8?B?Rm1wUHRGNzBaeGVyOFhhN2ptbXJzY3ZqeUtCdXMyZmRDclA2ZUY2a2tSK2ps?=
 =?utf-8?B?akFBNWViQnR2SkR1QUVSa1RQTTV0QjBaQlZjVHVCTXVWNi9XekV4ZGJBRk55?=
 =?utf-8?B?cmpTTGFocUFid0YweGsrelUzU1BIdXROQlBDSG1UeWVqVXkrKzBNNjJKQ1pQ?=
 =?utf-8?B?RURtYVQzVFpFcU5mbmpWRUxlSFlGdEkwR0E4Ull6bWh1TjlyK2kxOTdydjVy?=
 =?utf-8?B?QmZsZmJkUHd6N1hmZGxIQTlZS3ExdjZWQ1A2TmlEM2tMSDBVQjN1YWJxRVhI?=
 =?utf-8?B?amxHM2oxL0wrRFl6ZWkvZFNmaVc5Y0RWYjNWZWhVT1N1eHB3aGVtTDVLMzlx?=
 =?utf-8?B?WVV4RGFpb1N0dXdWcmxzMGp5UFR6YjJ0bFVVamoveitVV0J1N3BUMmY1a1ZP?=
 =?utf-8?B?WHZwWG5YUU96cGRERGtUNGJQRXByclZFckFnZjAzU2VzMzNDNWJlUURuL3FJ?=
 =?utf-8?B?R0JieGRoK1p0cjhCNURUQ2V6TnUwRURWMDZWNUFBOEludlFhd3Q5NjZCN01Y?=
 =?utf-8?B?NWRBckFFQTFQZVdxVnRTVThKQ3lvVmtOZDE1cmZNSVE5WEROZGkxL0xTS3Jl?=
 =?utf-8?B?UVQ0MHduR0liRWQ5emdFWDd3WFA1RkxieW1lNUdmeVR4anBWTHBlOFk2UTZU?=
 =?utf-8?B?QTFoU0JRK1RYRUNjb2U1dlE4djNKbUdyS0dJTkRaZzlhVXh6dVJzWkpNR0Vv?=
 =?utf-8?B?TG1tU096UlRKY1BzUk5uN1Q0RTB3R2NjM0p3VktkRDhyZFU1QXBBT0g4K20x?=
 =?utf-8?B?blFUQjZ6NWJwVFpBUnhjSDJUK2FXZTVtWEhJVkswTWRTYUVGZmtMWUptOHBY?=
 =?utf-8?B?bzY0bFUxU3NUNVQ1MEZrdy9lRThxQ2VIdjJsMGNkWThtSWx0a0M2L2I3MXdY?=
 =?utf-8?B?UE5KblV0bFVQODNrMWhHZnlQTzNrV3ZjNmVyaElnU2hCeTRLRlNOSlhaVmRB?=
 =?utf-8?B?dXVVVnFyOThYNnlKdEtvbmVGWFRkeXZkdGNKTnUyTyt6ZFRLN2psVHZiVUhC?=
 =?utf-8?B?TDVjWDZwZTEyMWJNTkk2NlJkTUJ4cXpNSnEzR3pjL3RyS1Q5Y01ENG8ra2Ni?=
 =?utf-8?B?cHdmUktmbnJ6UzJOcVVNTVZhL0prMVlPTlB4VG5ldzBOUGE3Uko3Q1pZclg4?=
 =?utf-8?B?TmRBQ2NVWHJsUmlzWnk5bTJ6RWJnK3FRTGRndloxejRQS3hGOTJJUUJyT3BQ?=
 =?utf-8?B?RzdvakkwdFRPanJjdEpJREh0eTN5WWUwOUpRNDhuWXhpMkdmeTc4MXZwSXVY?=
 =?utf-8?B?Sk5TTzU0OWt5MmxydHVVRHRFS0tVbkt6V2tnY1Fub212eWFHNjQyQ2hFRTVN?=
 =?utf-8?B?VmhqQlFOR0RGTWZkK253YlJEMUJKc0IwcDdmc2lYcVNYbHErTUplZFpBNGFM?=
 =?utf-8?B?ZEpWL2o3eHBVY3VQR0RrMm1IU3lHK0xvNEQwQzZjTHNYS1EzVlY2TzloQ3Zr?=
 =?utf-8?B?NHZwL3JaREs4eTQrbjZLOGZSWDRmdlp6WUVnT3NWZHBzUHFsV3c1Z1NaMTdk?=
 =?utf-8?Q?7ydiHmQL7ug5iske8tM6wHyD0G0LnBeOMJcDkrmnoiQ8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668c6587-e50a-468a-f1bc-08dbb3f9a3ed
X-MS-Exchange-CrossTenant-AuthSource: CY8PR05MB9378.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 01:34:59.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR05MB9858
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/13 06:44, Dave Chinner wrote:
> On Tue, Sep 12, 2023 at 03:20:56PM +0800, Wang Jianchao wrote:
>>
>> In our production environment, we find that mounting a 500M /boot
>> which is umount cleanly needs ~6s. One cause is that ffs() is
>> used by xlog_write_log_records() to decide the buffer size. It
>> can cause a lot of small IO easily when xlog_clear_stale_blocks()
>> needs to wrap around the end of log area and log head block is
>> not power of two. Things are similar in xlog_find_verify_cycle().
>>
>> The code is able to handed bigger buffer very well, we can use
>> roundup_pow_of_two() to replace ffs() directly to avoid small
>> and sychronous IOs.
>>
>> Changes in V1:
>>  - Also replace the ffs in xlog_find_verify_cycle()
> 
> Change logs go either below the --- line or in the cover letter,
> not the commit itself.

OK

> 
> Other than that, the change looks ok. The use of ffs() was added in
> 2002 simply to make buffers a power-of-2 size. I don't think it had
> anything to do with trying to maximise the actual buffer size at
> all, otherwise it would have made to use fls() like
> roundup_pow_of_two() does...
> 
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> 

Thanks
Jianchao
