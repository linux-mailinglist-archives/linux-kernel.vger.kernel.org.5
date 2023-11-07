Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CE27E4817
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbjKGSTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344003AbjKGSTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:19:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478C995
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:19:21 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7GeK3B024816;
        Tue, 7 Nov 2023 18:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1g+y+V9LyKXUJptoFf9Skbq3ph5mee8ST6DrSQdOx3c=;
 b=ao43Z1XHO9PPpoYr+Zjs5vaAnPz5rgZdbj2e5mOrqDWluENZ80L035dHA30KnmHFmJxV
 SrBTN/KHAsM36445n0T0g4mzl4HnEASoM3sfjT4jnQOLpyEyX7Ns8XmCHwfrB7mioEpw
 ef0RSoZYu4GqTwtAndif85cNMUUUijBYV/O8qWvSB6yN4+9kCJpWu+x+UNlrqpUl1tgo
 z0MfIqqWQqtHSeDn6BnMsoVzxQAlZ1fnqGkEgoUn08i5hl9gcacL8fZHLhQjlEZKmN5C
 c9DzgTXQ/LlOQB82xI05oeHmzk7z4Y3kQJQN1HAIAT1hNzUAs/DwN7U1IfE5/5R1L4an wA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5dub6qe0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 18:18:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7HUTYY026809;
        Tue, 7 Nov 2023 18:18:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cd78b6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 18:18:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZW5zZm2aae3ul0lZ/Q3WEn55GAZCSOt6LxT/a1xBTZZv5xCV9IBIBwHWTSJanve3/jKNlh0EnsC8000RhJ/2LjVKsfZUyluBnGrRBOd9giE8AizFYWuZoi4c4BwR4C4QkViJPEGzsqTdDsw8OMv7H47PKWJxzp0i71+NKUuRE4iuRsfYShOf8khz4blnGI3ZesbxXih08+Ru2DBOEQS40ilfcsjbZDFvQTfPthFx5d54s5z9rDzUKDOTViUeOzB4auE1R1cZmq0gQrXDjkgFK0EEaDPHE4Xqyqliix7qjNGjyEkPs3nNEO5RKMsxHqQ/yxVyoZD5LljlimeHu2kp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1g+y+V9LyKXUJptoFf9Skbq3ph5mee8ST6DrSQdOx3c=;
 b=D4/+T5EGFx3Qw5viqePHr25sPm9IARajd2FxLk5PKvaJYigET0y0iBR9iTGNs3NHAxFQ2zdUSAEuPrEZE9zMcWdEbrqOOeJ280djpfy3Xt8e53BcVQYhDNuK9jegTHmZCC/+RC0d7gKqchmUYyskOcc3lzOefBxejN1NH9xjidRjEvZF3ty8APzIfZ6g/5E5PdXlUFByTIq43sPC/CNEoypGIKb1XqIDE0ZtHoALWdYDhVFJ3GgttFlmztNQQXkon9VWW7JU8PLhvrtNjS5+QvHhXPYScaTCeQ/8qjwelZ+sJxDmpPv0i4NDnj7CznEd+V0SZ4S7Z+W5krrdVbDi+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g+y+V9LyKXUJptoFf9Skbq3ph5mee8ST6DrSQdOx3c=;
 b=Zqa/GqImRTqa+FJGsGUtFPfdn/T0MXO6R1G+HLKY7BpXND6r7T2VFA/VLdoh1Tf8XpTJflywkLvup0gcggKt+oyYgvgB4myVUg4yAeCshdZVoyfkq9TPg+OvgKgxlUw+3648cEUnWWQ1jn+kM/2gCUIl15QW2NahsZZQ2G8Ki34=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH0PR10MB7481.namprd10.prod.outlook.com (2603:10b6:610:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 18:17:55 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::1530:5eee:7ef2:f0ef]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::1530:5eee:7ef2:f0ef%6]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 18:17:55 +0000
Message-ID: <e3dc3bf8-28e2-4215-738a-7150f8165737@oracle.com>
Date:   Tue, 7 Nov 2023 10:17:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/6] mm: memory: use a folio in
 validate_page_before_insert()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
References: <20231107135216.415926-1-wangkefeng.wang@huawei.com>
 <20231107135216.415926-3-wangkefeng.wang@huawei.com>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20231107135216.415926-3-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::21) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH0PR10MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d7dcfe-504c-4b57-9738-08dbdfbddd09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAkyIO5t0TT1cKiUIEI51VHfwjJxEEtow+ElMx9gmtjzlYCMMJbsfdzllq/MB8+ljBHA37CFG06LGtzE2VmWAzGhgrD8nj31AMJDhx1UnJ5ufj5ls678oc2f6aNdCSNx/juCGMNf/70HY2O3PsIno5GzSH86tStvYqew2tbCOyPO8fuJqsb/Rcz+aaslvGnOfyHPg6DqPpe1BYndh30bVlZYdDxnpX/wjhoFyempD3QjWKpDzn6TY30w/YcLGQSGMTJpC86f3OTGgGyiXWuURakPnEmlKxWo/x17dJOqIIMVsx55BlugCPoUe4UZO1detqgx8GcVrJjpWjB2DTpMp5C1HuExNxsqw7/H8hRJ3SFpa4wc5lMJaIjAnfII80UGUFUMDYXg5j5oB3IhmOnTf+8g8x8UyReZUiVzI55p3vmTOLnAB6Z3kS9GtF3sr9lf1o+1ySsXAREkkbX6uqze8av/HVjl1xvvJSUM+CsBUiWjXCX8TBMJHA3nJ273c1+LrwGmCg7zBb/y6S9zEv3EB6bFUzmYphcfEXIiNrRClIbHsJWQDzQroqWnGQ3VZLIr4+LEcgCedczb68U8g/M0r0wfxYKuhvaiZw07YTPI39n5VffKm8ras07k7YBXvpRsfBFsQ5VzGBYu+QKw/+ArBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(396003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(6486002)(26005)(66476007)(110136005)(66946007)(2616005)(6512007)(53546011)(41300700001)(54906003)(66556008)(15650500001)(4744005)(2906002)(316002)(8936002)(8676002)(4326008)(6506007)(5660300002)(44832011)(36756003)(31696002)(86362001)(83380400001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTQxSmVzdm8wQi9IK25mYk56QkRCOVdqOHoydkk3elg5bzVVd0k4dnhRcG56?=
 =?utf-8?B?dnpjMk5tcW5sRUE3SkxycWFWdUxhQ3dsa21tbTJRME16cU9OczRVMGpJOTE5?=
 =?utf-8?B?NDhSdHpwMjJOa0N6emZuVTRFcnZpaFpBMTRaNFlYdGdWVjFPV3ZWd1hnOXFD?=
 =?utf-8?B?eGFmT3JxT3RRcjJMWVNiYXJPSko1U3ZXNjNLbHR5bnJzR2Z6MWgveXBhV1FL?=
 =?utf-8?B?dUM5NTlSekZDdEdHNVBNQkIyVWEyK3F0dTVDL0RtZENuY21hMkhqK3VBT2pG?=
 =?utf-8?B?eDVtd2VSSGQzSVFWNmt0M29lOVJncy9VUTA5dllIRnZtOWJZNytLOE1vcG53?=
 =?utf-8?B?d25DUHU4QzBPSXByZHhqRTRWa2VtN0xyaDUydXEvOWRDNGZQTnZ5Um03YkJM?=
 =?utf-8?B?SWtmclhSMTJFbjA1ejk3bm80YWNHQ3B2ODRGdStyeHpoSU9WL09RKzJmb1p1?=
 =?utf-8?B?UUQ5aWRQb0swT3dvdjlWTkVyTFJiOWlKc2xTTHJYQkt6SHhDdnc3WGJLVWRr?=
 =?utf-8?B?ZFlzMjNJZExqS0N6bi9NcGoxS1RGYmVMcXJmMDBGeXRHMy81S0FwS1krQmUz?=
 =?utf-8?B?VFFIcmJtWFNrSmpRcHYxU1NEQ3A4alJyQzk0MERuWUtTVUVwWmVsYlY1ZGhH?=
 =?utf-8?B?Z0NicEdzYXltRllhWEozZ2lzdTZlWFN3UWUxaDFxR0I5U3dOcmFzdUFsVVNN?=
 =?utf-8?B?QlNLQW1rc0FBRFp4WmxBRFJOMGdmQmhrUkJmeldjUnFFcm1PUm53SWR3L2pk?=
 =?utf-8?B?bnJlWXpxbG1XUWRDMXZMcVZUbWlDTXdJTUZST1B2U0puMEVPeC8yTWdqbEJQ?=
 =?utf-8?B?VENqWG1kSlYyeWJIZlI2MjFXYTVoY3lJcVdXdTZpdTVoVWZWQ2U0Y1ZsTC9Y?=
 =?utf-8?B?S2dIelBqVWdyWUU5MnpIb0JHR1lJUE1DbmZRM2RkM0tDTERMbENsa1ZGbXZO?=
 =?utf-8?B?NnBJbjJERkEwa24wRjBkZ0R3YUFSa3BoT1NqcHdGSGhVTXJ2elVka1R6ZXZ1?=
 =?utf-8?B?NmVjM040UU92UjVsMDhKdEhxMWM0RFZpRFVnWGpPaEZOdFBLVDZtb1F6THdx?=
 =?utf-8?B?OStSNE93OWxyNXc3QVhnaVB6QjhKY2l2Sk51WTk3OU9sYTI2MGF2Y1BTMjZq?=
 =?utf-8?B?WGQyUGE5Yzh4dVE4d1htcWVvcmd0Ulc5d1EzRkpzMTVXS1VsMXRueXZJV0NX?=
 =?utf-8?B?ckFjUW1HWXpEUUNjZXRMa3daT0pNbHZLSndzVmJpeWlVRGpHWnd1WjVYcHB4?=
 =?utf-8?B?ajkySkFiSFhtakYxQlpteGc4cGlEbDE5RUZmYmlhRU0zanV5RlYvRlI3QjM3?=
 =?utf-8?B?M3VXSWpOdXRoQVc0VncyTTNOOXVvNXlCZytwRE8zSHI3QXpHYlB0QWRnK29J?=
 =?utf-8?B?VStPSUJ0eXVPa1VCQVlyRlNIcXBMc1Z6ZHZJL0poT2hBMVg5SGJ0cTFna3Jh?=
 =?utf-8?B?V01lTVpCL0d3dnhRMnV5a0FIZ2YrMU5vUjY0eTlhdjFuc1VodnVlR3liRnRX?=
 =?utf-8?B?Qmg1cGVnQTNsTzBvK3ZUdC9SUDRrN1dhMGYvVDlLMzRBTE5BSkYzbVNWemtz?=
 =?utf-8?B?cEpyMWQ0Qk1ncWIxbG9vam5DSE5zcEFLSE5OUFZpTzB1ZmI1anVFd0lYWWVZ?=
 =?utf-8?B?YTJuRGVBZlQ1aEF3MVY4SUxmNXdoT0Z2MUtzek05MWd1bWttYmJlRXlacmJP?=
 =?utf-8?B?TEliNWt3Y1NENlZnaVFuVUpldnJwOEJlQjdpQXJDRCtISCt5VmVZUDhWOVYr?=
 =?utf-8?B?QmNjYkl0ZE1wdGk5SElabnpPb0dWMUxLWFM1dlRORlBjK0NvNGozZDNSL2NG?=
 =?utf-8?B?TDVNZTlKZjhocTZXK2l5SkxwMzlLSmxqUjUxcHl5Z2xzNEZsOXF5dmhTN3o2?=
 =?utf-8?B?RmxteGIzbE5XWGY1L3VnblpyTWZtOXh1aGN5Z0E0S3ZLaUdVc2M3VGxJbVJC?=
 =?utf-8?B?NW9rSVlGT2V1Z2NYcEtEbzhERzhmU25mMmJnTGpoYWFTTlNsN0dlcWFJdVVx?=
 =?utf-8?B?M2ZlcmtqblpOZm5HU0RJUTkxcXluWG5WUmtTU3BhUVB6Z29qdjVSZ05IZy9n?=
 =?utf-8?B?VmtORlhDSWZWeGFnOXpyVUY0b1dzZGxLSElFL3VWZjVId0I4QlhQK2VtbWkv?=
 =?utf-8?B?Z2NJNURVOENjeVpHNzFYYjlPbGR4bjZhUk5LVm5BVWVMSnMwUHNEK0owZm96?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NTM3SUl0UmliNVpUVHlrdjVFZjQyY2lEWTNnQ1NKTTlXbWJhRXBQdlNsM2Ry?=
 =?utf-8?B?WWtIdm5JME1FaDh3eG5GL2Y4NTdrVnRIdzQ5U0NqN0kzZjZhbmw4YmNaZjVW?=
 =?utf-8?B?NU5naG5ZQXBhcHh3eVVBLzhuRHU3Y3NSTkFZY2VvSkxIVERuellOOUlOUThy?=
 =?utf-8?B?UVZsVmFKemlUbUtONmRHSE4yUEtmcUJkVTE4YlZPZm4vYjdYUXgrYXpBNFBq?=
 =?utf-8?B?UG9ZNUZNT2EyUUQ3NnZYRnk3elIwd3pHa1ZpY3JIVEQ3b05aNFYyMmdKS0pR?=
 =?utf-8?B?ekRQa1YzV3JNdC90bWIxZEEzcURGSEZpVWJlSDF5Z0lZM2YyQXJiaFExaFVk?=
 =?utf-8?B?Rk5rRjRhVmYrUVdIYzNYS0hJQk5KSzdVUVFKNkwyNFdSOU1FQUxNT3FoVG1i?=
 =?utf-8?B?WG5aT1RMWUNOUHFZYUVMOWZIN3B2ZklaVUpzbFE3TFNJamtLNVhVTHFlZ3p5?=
 =?utf-8?B?QS84VFE3ZUZMMFFwSFkrRExTdzR3MTlxTlpoeWZrK0dXc0lYYWRGRWJsZThp?=
 =?utf-8?B?VThiTWdBN0VIaDZoejhnOU44aE9yRVVZV2VCTGN2RHJ4RURaQk1vaTdFMTc3?=
 =?utf-8?B?SVUzZzJDdWJMOWRueDJOZWgyTnkvSWU0bnRlOWJ5RGV0N0lDTnZ3M2hzVlNp?=
 =?utf-8?B?RjNjUmhtaHozdlhaelVhQTVrWHZPREJFbzFWNHZrRjJpWWEzR1hzWE9VS3Nk?=
 =?utf-8?B?ZW0yb3JCdk1vZW5aR21tdUpyMXZlSTNCRkZkVU9qaks1WWJKR3NodkN5U3NP?=
 =?utf-8?B?UmxKaGJTaVJ6cHFOaDAyRkhmTjZUanJ2YTk3QWRScmh0bGpjVVZmMlZ6d2hX?=
 =?utf-8?B?d2hrOTBZMHBqRVdzQXN1VkdWelpOVGMwZis5Q3pZUGt3c01UdXdHbXgxd09V?=
 =?utf-8?B?ZDJYb1lwcDBaRGhXL2ZsMXJLeU10L0liN0IvWStmSVFHOFBUY0FXYlRPdDVX?=
 =?utf-8?B?b0FhM2ttaTR0THhQdXVoQ0xSTUdyVk8zd29kTXJaa090QmlpaUJoRlRoaTJS?=
 =?utf-8?B?LzFOelRZblBpZWdja0RWdHE0RkNsTlhyVElna1FFbHNDNEIwRTh5VjBnQWhE?=
 =?utf-8?B?bTJQcEg4K3N4alY5Mnp2VnE0TzZxU2RncytDTVB1VU1IbERwSUY3K2pKRm16?=
 =?utf-8?B?QlBOWXJncytVQ0tiV3RXVVNMSXVZZVp1OGxQWS81QjNSV2NFSCtIMXNaQTZv?=
 =?utf-8?B?aDZiK1pRNXIxa2pKWktFblFWVGRNeXhISmVxNTljMDlteHJ2dTZQZ1pWUGdh?=
 =?utf-8?Q?wDCTdDVKibx+abY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d7dcfe-504c-4b57-9738-08dbdfbddd09
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 18:17:55.5567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CedqzS3WdsgzUhjQRQLwyyfMDdjDLwBhEQI9Q6YBYnGJCvzeHxdrjTxiWbt1VyQ1yxHtCFB1hqgPdzXnZTfaVKCtDwFJ0kXBZTpRxId0nKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_10,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070152
X-Proofpoint-GUID: PNYH_CoOvgiS_QMWfqcR_jyf5UkouwGZ
X-Proofpoint-ORIG-GUID: PNYH_CoOvgiS_QMWfqcR_jyf5UkouwGZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 5:52 AM, Kefeng Wang wrote:
> Use a folio in validate_page_before_insert() to save two
> compound_head() calls.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   mm/memory.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 1f18ed4a5497..b1bff4d245da 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1836,9 +1836,12 @@ pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
>   
>   static int validate_page_before_insert(struct page *page)
>   {
> -	if (PageAnon(page) || PageSlab(page) || page_has_type(page))
> +	struct folio *folio = page_folio(page);
> +
> +	if (folio_test_anon(folio) || folio_test_slab(folio) ||
> +	    page_has_type(page))
>   		return -EINVAL;
> -	flush_dcache_page(page);
> +	flush_dcache_folio(folio);
>   	return 0;
>   }
>   
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
