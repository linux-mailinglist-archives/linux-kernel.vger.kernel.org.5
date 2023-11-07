Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4467E483E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbjKGS1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKGS1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:27:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B3E119
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:27:50 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7GeY23009487;
        Tue, 7 Nov 2023 18:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xrY4LH34/RPwD78N8Umitji77S2UsBjaMcNBwy/6OrM=;
 b=d+cWHbTUGpRdkqmbF3fvcoQ5FxK+7Iv7xVkLioPcN+ZCjxufkdKcpHSHWNNufIouD0u8
 TMLGN/QQst9PUL0cFogSXqbf3QkCl3RA1k3uyPA6JU5b6pd9bLe2Fnh6KaMjN8r279pF
 dsCse2vDTlQLSvO5RI+lAYoO/SjAnxzNAuxLgDqbjhqsAWtjFIOt0HFBS5+pHkB4Tfmv
 BTVQlelyo60ZpsGTrzjW+Mba2ZIZyu7AEMZZgAXKet8E6aMtEiMBGnS9QqZ0EEC4Oh0C
 Ycf0QVLLRx7dnp7tH2+lyAHsGJtaccm0ED03oiiOOJRkrNUXrIE+N4hg7EmHfX9D66pC GQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5ccdxs5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 18:27:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7HOWNV023541;
        Tue, 7 Nov 2023 18:27:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cd71c65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 18:27:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khP8FbBTukvkw0F4CBBZXk6E8acUxYTcLDcDWPXHtB00gZacsQaslWfTzVZhJprUp0XopDmyl83bHCpJmpSuiEeuQb8AGwbDxrDv9/wtBpwRtEOlhOSAfCpNtdmGn8xVy/UnKSanshqrP3PSb40AphQvmdL/GtUdJTufKPfCjoKVpwIXF9/5MiVjwjVSZzl+4f7VNYvdFJRTO5bXIGdnpcWsvuau8j5M1Vqv9hPtwf0sPgcROkQaW53lUI7duQhIv02vgSUdJqzgKzrr01r6Q8GkaLgCeeTm6RTmyA41F7juDsLqKl5UwBeuGihoCCnuyj00hEQuw+UV5uXHZOEvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrY4LH34/RPwD78N8Umitji77S2UsBjaMcNBwy/6OrM=;
 b=l5n5uOzeewvILQdXzwSV8wfTzJDdQkgylEYVH8e+r8EGTYGMPYfh1hvqPOyRTjilzkNUg+JAxgwMqz6JeF+66E+A21J5etFmVPz4WCLBPZKOHjKbuIjTPWwvuVFcMX1vu5ODW6TiGYmZs/fRtL26NLp4cXbvH5pLSw/bCvl4c9/1S/ddEHwX999lmIuYHAaCQyFlkqIKY++i6++0e7RUMhol/DAcknD0BwRX2M0oVNuYf3bmugn1Cr0k8aKA4GCzQ+SeQHDmnkcqQFceau2L7x499Mr6oFKiolnUwsNC7IzhIdERM9T/LJP1Nugs7aXsd248CoRoaZNXlVbHGP59YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrY4LH34/RPwD78N8Umitji77S2UsBjaMcNBwy/6OrM=;
 b=B72Y4ogP9U48XwB9adNTnrBj4rjw23/z56cJZ7og4hP3Wq+8VRTGjgY4dqsqq6nUB88Jt4zg4RMi3R/+m6qOvhtjtIEerc76UwPKvo1Qen79gTHLs1ootrjTtOePhzPpGPESnCADf344+uYk1nTj6tXkTiAzt2EMX7SOIS/BXto=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5767.namprd10.prod.outlook.com (2603:10b6:a03:3ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 7 Nov
 2023 18:27:27 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::1530:5eee:7ef2:f0ef]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::1530:5eee:7ef2:f0ef%6]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 18:27:26 +0000
Message-ID: <ff007e3a-9951-bd6e-2780-e46e70321665@oracle.com>
Date:   Tue, 7 Nov 2023 10:27:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/6] mm: memory: use a folio in do_cow_page()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
References: <20231107135216.415926-1-wangkefeng.wang@huawei.com>
 <20231107135216.415926-5-wangkefeng.wang@huawei.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20231107135216.415926-5-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::13) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe78830-2431-4d3c-7f27-08dbdfbf314e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7h9zT2KmaUWdpg6J8n7pXI5vWoYOE7gCzUW6cIGhV02YafD9wLxMf/zpyHXclv9NbWRX+qEZG6CypZxFOZZyitCut6V8Gv6MoVTyKcz9M1TufhfnBquk6GNvifbVFsAekP+0/jI9YYD/bqfzdS+qMwc0E4t/CwO8iqmYTSxRv/3oD+xTN9lRm6B2gEmBCgbNz+vVWCzxHivGqxrxB4lipDqlZa/J0lqddszKwbD1MZSIJTQeeIZ0y42nPAed/micKJMrXKHfXq9umI+Gq0LNRCEKYeQAlHwaDm7zgXDSZPK4pJZ8IXJWTQoFUae5GHeOr6MkuUYepHt7nxGefrckpLaVM6+oD0qWNOToHSdkMrVR0+BrTh22Qw0+LdzV3rEKeJVz/0UnKKhCgAsbuQqAdOY1xje4eBs4wmowFt39ca62Yh7AlGRkxfoGv/XoypFo53/k3H0Xh2Rhj5iqG7mLhcsXQChysMJ3mYSOfa1857wa3/58CBv5k5gstVW9BxVEvH5wisZmZGYayLbkGTe0U3ygY1bfvVgaGb6fBULCkl0o3tbslXaa/KdPSthcmEuP+xGJJYX6fxn4VCs5GQZnc1VJo+wL1TBrXDr6ZBKVxr9tYwFrYeZ2n/6TvNkTB0/AEywH+mAbYrI2nvH/L5qbkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(83380400001)(53546011)(6512007)(6506007)(26005)(2616005)(478600001)(66556008)(36756003)(316002)(66476007)(38100700002)(8936002)(8676002)(4326008)(110136005)(66946007)(54906003)(2906002)(41300700001)(5660300002)(44832011)(86362001)(31696002)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNUN1Y3TUdkYnNvVGpSeElvdlBHcG9nNzhWUE5oNEVVcEtlYzhwMjYzc25P?=
 =?utf-8?B?Rysxa1RYTDVpaHk3RTFFLzNtcEtZRjJ3UzVSTFZIRE81UU95bFY4bFhYakVh?=
 =?utf-8?B?T21ha3V6OWlFQ2I5c2oxcllwVDRvbklXb051VEpmaWZ1MWtpQXdsK1dXS0tR?=
 =?utf-8?B?b3NUaWVhR2ZkZ1pIb25pS2hnYmF2d1ZuY290TXNKaWp3bVFwR2tQeG1RWi80?=
 =?utf-8?B?T2xJWWxyNXlLYURIVk5QSzhiVVBENFJJQUphVXVXcXdSbGk3UXg5SDJrRU1C?=
 =?utf-8?B?ZTRkOEtOYWUzWWkwak5za1g4NWlUWmM0MXM3a1U2UkR1eWVQVDcwTTBOZy9E?=
 =?utf-8?B?K2w4MUp6Uy9UYTF0MDJmYWJGR2o4a202MDRUNjlLRTF1RE01VTVxTU1LM1dX?=
 =?utf-8?B?ZFJLTG9NQ0lkeWQza3gvdFBGYzhkNERXaHRDZnhrSTkwd2ZMSmlkNjV6Rzd6?=
 =?utf-8?B?TTQzTUtzcng4M1VPeTM2MXB3QzhmdGY0d252d2pWMTdWMGlhY0hRUlhNR1pD?=
 =?utf-8?B?eUQvV1NzdlZTajljR1VGbmxJSldQcFE0TWxhelMyTldhTU5OZ3BPWHVXbGVC?=
 =?utf-8?B?VVhiaFBTT2VFeVZ6SytNY2dkUXVGMEpQZDBNQlh4UHlpMHFzRjFxS3kvQVRv?=
 =?utf-8?B?SGR1OFd5T0IyZmh2MVg3bndmMERwWTcvcFludnBkQ2ExblVkN2hZUmMwbmFq?=
 =?utf-8?B?Wjd2ZENtQ3FwSlhTTjc4dWdZMmZrTGw4TGJuVHFGa29WUlNZMVcrWXByV2dF?=
 =?utf-8?B?N2hwYlN0L29XTDAxRUh4anZCYkFJTkRHZXhuM1kyYnhpUHhVYmV6RUxONFc1?=
 =?utf-8?B?dXN2K2p2K0UwL0tibUVCVEdjVXJKN2FQUFdjVFVVN29SdE16QitWdVBLZ01K?=
 =?utf-8?B?WE83Wm4xbCthd2UxZWo3K01FM0pFbElzbzFuc2VLN1c4QTFxdFFIR1FYeUxx?=
 =?utf-8?B?UTNSSnJ5Mm5RRGl3WXhMQUc0bkNycUZtR0FvZWxScXFyQ2dEZXJTNWY1N1cz?=
 =?utf-8?B?SUFqdjlKanY0UGlQdUlucCtXWkgvOFN2bnk5cXl1S3JFb1JYTWVOWURLVS9C?=
 =?utf-8?B?V2FpeG54T2kxNWxIWXlHQ2ZWRWRXT1VRMjRCd1lYUTNGbXpDbEt1cEM4WU9D?=
 =?utf-8?B?TncwRTcrNFBoWlBFWWl5RW83ZHRFM1RUSThtS1hlWWVJYm9iaUp4TjJzWnBa?=
 =?utf-8?B?KzNNdld2NlVudUU2WFVkQWRFWWJSeVlhaWMwbVk2ZHJlMTF6TFRML0RCWElh?=
 =?utf-8?B?NENxMjJTVEgxVm9XRC8vV1FTZjlVZlNIbklUSlUxeU05cWczZmtoWTJYVDVn?=
 =?utf-8?B?MVZmaGFYa0t1NXNiNEFXWlUwZkl3MDRua0ZaTG15N1RtTG9rM3RaOXJSQVN0?=
 =?utf-8?B?LzVpVmRWbkpKWjRxVXdualZia2s2MHVCeXJDNHBTTFBZRFdBM3J1TDNQeUhP?=
 =?utf-8?B?dzFNeUlzaFZXMVJodTlsVXF2YytmT1ZhanhDWTVDcnpyZGxtdE1KOGk1SlBi?=
 =?utf-8?B?YUZuKzVnR0tLMkpsSlREcExveWx6Z1FsZlE2ODFlVW5rZkl2dm9SdERPNWY0?=
 =?utf-8?B?dUZZbzN2VEF0THhMUURxMTd1alEvTDBXa1B2TExBTEdTdGZGYXFpeE4vSFlN?=
 =?utf-8?B?RlBTOEV4a01sZHJ4ZHU0MlZiTDVnS242T0hVV3dDK28yZmt6ajVJYWwzUzR5?=
 =?utf-8?B?RllISHd3bG5pWFRGMmpycU9wbGhiSU9rSDlielFXWmVKekljNFphY1dMdjFi?=
 =?utf-8?B?UEt1V04xdTVWTzVYTkErQ21RR3hSaWQwS3ovU1VTVmhaZVhDOWdzVnU0eHFj?=
 =?utf-8?B?c3Z4dVlsc29BdnpTRXNsYVpmYjkvZCt1RnBSd1Z2WHgrWlMvSUl0WDRrWXN1?=
 =?utf-8?B?ak5qL1RZSzF5S01Ma0pGWnJ6TmxvSFI5ZnNveVFtQUhqYkNmeXhOTmh0RDNK?=
 =?utf-8?B?RGdzcThYVk5LM1NSMnYwcWFqbjhMbXhHLzdmZW9KV0VRbGZtY3hER0MrdzNq?=
 =?utf-8?B?c1dkZmd4VVNvZUpqVGx4aHl1SEFNTmx1TUM2N2JVNkU2U1ZPVGxOOGdsdzBs?=
 =?utf-8?B?SjAvNVdRczVXWE5KekxBQ29YNnNLbGlub3ZTYnpNVW9FdWZrU2QzLzRneHZ5?=
 =?utf-8?B?Um5vd1pleGhlNjlVKzg5ekVTYi91d0FHT3U2WkJwNXorZjRiczRuVWFwbUZo?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RXpLVllKZkpyRUFheGFPbUJrL29tY3hlOWdKZzZaLys4VDFLczBjNkV2VHpw?=
 =?utf-8?B?ZXR5NHZwanlhUkU3K1B3UlFWQk14dCsyR1FEWnN0TGVkU1RCRGUydVlZVnVR?=
 =?utf-8?B?NmNjTGtlNk9jUC9lVVNBUUVlcVJoMVJWV2YrY0dTVkxlT1VqSE1mTTlEOUhM?=
 =?utf-8?B?cy9IdVdBY1BLSE1hTTdUeEFOajA3K29QZTBZS2tmK3BMRWltMklWN2ZBZG8x?=
 =?utf-8?B?L2dMWEExVnJYb2VsYStzaGQzcTZJODFTT3ROM3NZRkljYUZxMXVZME1IYXZo?=
 =?utf-8?B?ZmE2Wm9QY3g0WmtXamxRYStObGJTa0FITzkvRnZqdWVaL2p1ckdCNStrZmlS?=
 =?utf-8?B?ejJkUllyVVNYTXB6bXBiOVlyd1NiWDJhMEp2QW90cy9ydHp2UmtsclpucUNW?=
 =?utf-8?B?cENUZW5UZGRLUEU5eVZWeTM1bWc5MmhmZnpEYzkyWGdrWERLZFVJODB2Vk96?=
 =?utf-8?B?MnEwZE9VaFY3M0xtR2tBOVVJY2xBbkVIVmlFU2RaZFhzMWxOVHpwb0tlY3VF?=
 =?utf-8?B?NXRRVkhpM2RvMXYzclRmME44M3pEaWtJYmZmdFlaZVN4K2JaTG5PVE50dE9k?=
 =?utf-8?B?Q2QvTjdOQnFxLy94dVF6NWgrSUdxZDhmQ256eFdSek92eWY4RjB5bk4vMDAr?=
 =?utf-8?B?RGEvb2k2Q3lNdFpvL090VDc2N21oNjFJMmZmY3k2TXRIc2Y2MmFuYnpHNXRL?=
 =?utf-8?B?WFF3YnY5SmFpOGtRQU5Na0NmVm5ud2NRSHo5b1VyeElvMGJxMFk3WnduWnhF?=
 =?utf-8?B?dVlaQjBibHVNNU5yazluVHp2aFExTVhyVTMrY1ZUdElESndJY0dtSmJnTGdq?=
 =?utf-8?B?VHZYVUUrakhXbTJ2alNTWldEdzVIR2cxNVR5MmR0RjB6YTV6dDhmMUxqeDlw?=
 =?utf-8?B?Znd0NEtYQ1k2TStIaStsYTFVaWhOUVJPZ2g4QXpqb1BoSDRsYWRmeXM1RW1k?=
 =?utf-8?B?eFl6T0lld3JzWGZHclE0REpHUlRYVDVGdHR5OVFVRkgzQ21vVFVMYjlVa3dS?=
 =?utf-8?B?ckdPVmZIT2MrblFBQ2lBUm1SeldtMjBudXJRQmdZYmtjRmtWZllTTGlwSTVq?=
 =?utf-8?B?Szk3ek5sVVBScWpLQmtZd2hxRjhneEthYmFWTUt4Z2QxMXFSOHBsSHEyMXJC?=
 =?utf-8?B?ZTFBSlRLZGN3WXE5aEYwNjJiSVdJRWhXbUo2Q3hGMVdKbW5jNGFtZmxNVno3?=
 =?utf-8?B?dURNOWptelZxS3NtT3BlVzFJdXRZenFOQklFNXluYUJXeHcrUlRBSStpaHgx?=
 =?utf-8?Q?M3yeaOFmTj4+9AR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe78830-2431-4d3c-7f27-08dbdfbf314e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 18:27:26.4316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yf1V922d3AbRTGymjR/oHPbpb0PtPo8z0tzJA1jfoSmizxrX4aGJNS7+Tjsia+G/k6yGmMjrNd+/bcfoxVeuYL5ubDedCAjFVceLCr8i7Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_10,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070152
X-Proofpoint-ORIG-GUID: 7QpTtr6ncx4j9kjTN4kWhnS6OKsAPuc-
X-Proofpoint-GUID: 7QpTtr6ncx4j9kjTN4kWhnS6OKsAPuc-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 5:52 AM, Kefeng Wang wrote:
> Use folio_prealloc() helper and convert to use a folio in
> do_cow_page(), which save five compound_head() calls.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   mm/memory.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 062136d25da3..5ecee3eac29d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4648,6 +4648,7 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
>   static vm_fault_t do_cow_fault(struct vm_fault *vmf)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
> +	struct folio *folio;
>   	vm_fault_t ret;
>   
>   	ret = vmf_can_call_fault(vmf);
> @@ -4656,16 +4657,11 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
>   	if (ret)
>   		return ret;
>   
> -	vmf->cow_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, vmf->address);
> -	if (!vmf->cow_page)
> +	folio = folio_prealloc(vma->vm_mm, vma, vmf->address, false);
> +	if (!folio)
>   		return VM_FAULT_OOM;
>   
> -	if (mem_cgroup_charge(page_folio(vmf->cow_page), vma->vm_mm,
> -				GFP_KERNEL)) {
> -		put_page(vmf->cow_page);
> -		return VM_FAULT_OOM;
> -	}
> -	folio_throttle_swaprate(page_folio(vmf->cow_page), GFP_KERNEL);

Hi Kefeng,

I was wondering why this block of code is no longer needed after using a 
folio?

Thanks,
Sidhartha Kumar

> +	vmf->cow_page = &folio->page;
>   
>   	ret = __do_fault(vmf);
>   	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
> @@ -4674,7 +4670,7 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
>   		return ret;
>   
>   	copy_user_highpage(vmf->cow_page, vmf->page, vmf->address, vma);
> -	__SetPageUptodate(vmf->cow_page);
> +	__folio_mark_uptodate(folio);
>   
>   	ret |= finish_fault(vmf);
>   	unlock_page(vmf->page);
> @@ -4683,7 +4679,7 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
>   		goto uncharge_out;
>   	return ret;
>   uncharge_out:
> -	put_page(vmf->cow_page);
> +	folio_put(folio);
>   	return ret;
>   }
>   

