Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8527F3371
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjKUQPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjKUQPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:15:43 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01olkn2055.outbound.protection.outlook.com [40.92.66.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110A3D5C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:15:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rz2IIS9VT+vNNypS5OTm+GAxfq2rx2j635xrLr1MEhveBspw3FziVv5XEHACPVdN5CJ6kepfgft2yNr2HSB+pC44flHv3t4GdqqDhCQHC2cv4Wcg09uxKqEGN5j9HtCRJnR0zbC7DVIBpfQy0YzE4ukcjXy6og42LzG+xFO36GEtS0ugSxLOpQgfCNipx87JGEI1vf+hPFXs4rV4rUEeHRMNr7kZSnGN+Iske/YW8y420McR1JZUvL3O8EZEvUi1k4LbgUsD03xuL6CzCkLtGLuJp+usKMsLGf3guZN0+88sqFS8VqRWfAnQUItaiPHicYBczOlh0Vh6FwEX+NEwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUzNLr+cwGdy045lqg+bNpl3hY3ODB4hHXj2I01kkIw=;
 b=GxErmJjo2MhJkE5u3WE6CAdE93PmEpmf4/gNIMCjyxZholD6UyBLjx5875FubrUQ20xraY8+nsxHf7wVjWVUZq3cLjkRAp6F7B6v11Kz/hQATf2RlDlv3zwr3NQEueXtTTlVQl1Ss+U0KxTMuX9YrgOjt0t9E/r9q16+2AMdTGGa9QYqadJQSSVq/tbL5SEhBZ8l/eqhNHxzUyjcnYjG6y9fpe5jhB+yjb3dioHruKmICnnR4jtzl6ytoQ4ZyABy4ZsLS6n8i0kN1fMknaMoKxmG5LkQz89IKO74iec7IxLuVZbX4VVwJux7V6SXqnNTc9arJq0tO2vNNGO9DZQonw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUzNLr+cwGdy045lqg+bNpl3hY3ODB4hHXj2I01kkIw=;
 b=nCTJJq/Q5nwnnjeHJdRktWGhBt1E6TFAVf0pHTw48gRcdcFBs9n+CsV+FmL9DSqmE6nIwURWhsKLSLRYKGanBQk9TBl36V3/1cHNqrnnz+YV1cTBXcFyGc8b471bnnqfn2w2HallWGABMAyUYYNTxPQ7k9Qa2PGW2uuzda024sxjuYy8W+5cHJCrgcLv+hAdHvsRR9GGz1r3BHuAMhPEMS8CyNezb/E3aBGZbCwyaKQ+jeh+ulVukwWz+wXa9ERjV4iS2w7dA0hHOE0COqDi2BY7TkHAfwoS+INtoKRWZSIIDqFyp9ElYKAD8arnsyEYtxtXeX3LLvGxQ55PmabGIg==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by PR3P193MB1117.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 16:15:38 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::fdd2:7dbf:e16c:f4a4%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 16:15:38 +0000
Message-ID: <VI1P193MB07527A880D3276B6415F29E499BBA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Date:   Wed, 22 Nov 2023 00:15:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kasan: Improve free meta storage in Generic KASAN
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev@googlegroups.com, ryabinin.a.a@gmail.com,
        glider@google.com, vincenzo.frascino@arm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <202311212204.c9c64d29-oliver.sang@intel.com>
 <VI1P193MB07520067C14EFDFECCC0B4C399BBA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <CA+fCnZfTJwfmO-OYcUst0fsWhRa+MzDtkv1N_bMob9_1BivdJA@mail.gmail.com>
From:   Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CA+fCnZfTJwfmO-OYcUst0fsWhRa+MzDtkv1N_bMob9_1BivdJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [qJuxwt9riZ4A+iesZwU7TztC3P0OFlIS]
X-ClientProxiedBy: LO2P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::16) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <29437f37-f64b-4d40-be3f-3dd5f568a53e@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|PR3P193MB1117:EE_
X-MS-Office365-Filtering-Correlation-Id: 6610bd59-392c-44d5-0d4a-08dbeaad193b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7il+3OTQjRSM4i0SxyTbBIytEMqcR6eWkSPbzrmC4JDOU32nhJmH24275QT5dRXysby6hqbyGcXO6yzlWrMg4DgNV8ue2vypL4NFiZE9xcjlBzfFCnIm5o0YD9TE65kCn1LlDNVjUaAVxm3qsd9FZ7bQcoaJ+Wylh+Vuxr5q0NefIE4F6bp7va/NAYFrRZVAJVdZOur3uvdFPH57ChC8dWrYuCnZGJdscTgsddWEETXIyDNOI7cqYfhdn7G3b5PfcRRTXgC8399cqnPtRyUseWxzDxfi7TaDDmho6ErvIe9sIYP2qX7ZUxDtpWzxsq7iGjoCjnWN6FB/Iawglkyv84XcRJ9pTk3cE4cQe+ZNbI5gBz+xP7QDsk/mWOcFfEPfcwAUWn1uBngQu84986fJL1tfeKh5+T/iZ37zEyRGevwAXoII4NuvTi2aQjJiXPGTs4jS2ge67MMYb+eC3UcTxzetxqRaOcDSFeII1sYLtkM9YzjLMG1ylTaMI+e7atvA2WcDqNUSCUIWLvDcxY1sdXcqQMn1UzGqC1F6FimZjwyhys6hG3vYt5tfQwePRVO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q25rbWNIc0tUR2hESGVvVTU4a2hhd0NjQ1ZYYlFGaW1ock9uSWV1S1hWWk14?=
 =?utf-8?B?R3pZNlA1alFPTnZIS3MrbWJwZUVQRDVML3ZlY3V3bzN5R05YU1ZnKzkwTUFs?=
 =?utf-8?B?MEpNY2JiVDBzR3lZckVCVC9iR2I2RVRtZkxuNmE0Q2gyRnJDTHEvdGE2c2dn?=
 =?utf-8?B?V1JtQUJXWUlBd2xkamJzVGRBUWNxbW8yODQ0YnViTDNZTDBSSXhVTGlYRHNZ?=
 =?utf-8?B?UWZ6eVZTTW14c0tLOWZ2dUlWUlM4RnQwOUlEYzhpZnU0cDRITC9RTTVCSmcx?=
 =?utf-8?B?Qld0VnBtNG9DdEtreWRSVWNxc0VhREYvMUZucGFrTU9DU09Ha2JFNzExYjkz?=
 =?utf-8?B?YXNaK0VrTVNzQ1RlaXNUM2JRblRxR0VIOFV6ck5LUmdMY1JxbWZEcTA2UGRm?=
 =?utf-8?B?eEpvbW9KQngxOVloZ2NuY2JPaVhHQWhTMWxZdEhNcVN0WDNkOGcvN2ZibCtG?=
 =?utf-8?B?c1pqa0VrVFE3K2RrL1NVZTc5K1ZwT1lMVEtySjdEek83ZFdTTFV6ZUx5NGVO?=
 =?utf-8?B?ZjQwbjZ6K3N3WHZTTGdMUlVNSzhxWkJzWmM0RFA1d2NZTG9LRkdSbnF2NnhW?=
 =?utf-8?B?SjVZYTZxcDZKVG1zRXZuRmEvQko1cWNhSDFNdDRKcnpXek1zZDJiOVpua0I2?=
 =?utf-8?B?Vk55NVN4bzhIamtSZGI1Mmp2R2NIbVhNamtYLzBZU2dEWWkwZW1CUlpKU3Fj?=
 =?utf-8?B?VGtkMGZSam1ONHg3c1pQeDNsaDFFWnY4U2ZyM0tUcFVtOVJSVDhNOTNNczY3?=
 =?utf-8?B?eDVqbjZ5QnlyTncrU3VRRVpOdzZkcnJod1VKeDVzYU05OHZ0WFB1dzQvVWQx?=
 =?utf-8?B?SGsyNXZzN2Z5VFFEZ2dwUUJuOEVqdG9oREhyYnltVXI3NGt5WGtJcWl2S21J?=
 =?utf-8?B?aEhyVTVJM2hHUW9yK2ZCeUtZWVcyb0UvSlhXQ1hnY2MzZUlGMFpwVVFlU2dq?=
 =?utf-8?B?SFVnbUl4SFpzRVErMXFZY3FOVHZELzV2NDluZ29KUjhIc0dkNW5wa2tuNTNw?=
 =?utf-8?B?clczTEc0NUVQSGROWm5DTVZOQW1LVVdNdVMySVd2a2ZOMlBNblFLYkxiUito?=
 =?utf-8?B?UE0xcmVhc1dCd3o3eTJoQTNtNlJPaXByaS9PdGIxbk9WbTl4aElGUGlhSzEw?=
 =?utf-8?B?bUQ4WUxyTGNUVFZnUFdFRUNiY1lNaTlVQjR5cXcycDQwQ2xnV0JYUkp5dkVG?=
 =?utf-8?B?c1RKTzRUTXAyK0duaGNCcFZSVytlNHdmckZoN3V6b2lHVDZvc2lxNVZwU0dx?=
 =?utf-8?B?Z3FIWUZaQjhoc1dJNnlKZ1hqZjAyK3JJKzNHUE9wSUpUYmFia0FOM29ya2FY?=
 =?utf-8?B?M05zUnBydmxHVG15UURrdy9Ua3NLVlJ1UGNyZGpwUlpTOTlQcmtLVWxKNE5u?=
 =?utf-8?B?eGtQemdSZ2dIWnBGaHdScUdYaUR1a1hkdHRkZVFCZFlwdEpLT3ZDbU1JYVJs?=
 =?utf-8?B?MUxBWVRLKy8xalNSVE1kcWMyTDlBMFIwZ1BxOExsOGdEbmRDQ3BjR2tBTm00?=
 =?utf-8?B?YVFXd2hzeE5RUmZKZGx5ZWlvTkdrWXFSRmtOd0RZaE9iUzhZVkMwajZXcUlM?=
 =?utf-8?B?QzFDVEVFOFA0YVVlZlc0dS9OZ0pvS3FFTm1PbysrWXpyVTVIU2thY3FkdEF0?=
 =?utf-8?Q?FYcXP8rzkChSWAJNGoVJl82Sh8fFdtO3nveJToDJX7VU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6610bd59-392c-44d5-0d4a-08dbeaad193b
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 16:15:37.9322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB1117
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/22 0:05, Andrey Konovalov wrote:
> On Tue, Nov 21, 2023 at 5:03 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> This bug is caused by the fact that after improving the free meta
>> storage, kasan_metadata_size() continues to calculate the metadata
>> size according to the previous storage method.
>>
>> I will fix this in a separate patch.
> 
> Hi,
> 
> Please send a v2 with the fix folded in instead.
> 
> Thanks!

OK, I will send patch V2.
