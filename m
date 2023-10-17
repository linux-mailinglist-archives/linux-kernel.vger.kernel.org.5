Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E389F7CCC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344327AbjJQTkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343897AbjJQTkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:40:05 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2065.outbound.protection.outlook.com [40.92.75.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F77BC4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5sol7ZUCTRO6Z3/4Zz4xf9jlFHDKwrb5eMKrcfY0ZSkc96WjdTFonFI3AGn0hCrKJeQeb3OfbjkQS3wh73m+Dvt6Kwp+MDCQb7YC0tEyjHcnwfnvlH4WWNRo7dkZZnM5ZHIwiH+81DGYPLGvgfPHEIiyXDG5AoQhcdZhVrOOfMX7jG/AEL8pH1UE+7sUQjezORbYtx2gngJ5aNLf/F4PHDM3fB4s+JaC00DV6fhWWeRJqhYxD9BN2bXMLPwcmMoa1t/an5KZN74X8ot0kLkDmPEW0cLzgUhhjj8YtdCvQZGbLjwNatCRnk272leU0+El5pgnMN1zcdVDPQZh50PpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1ZEJfJwgCo78Asz1ZD2KDfn5+bZC8UTiZ1X83PPJ98=;
 b=B15MMiuoZUyZWCvnhqdS9B3TiIvuHfMILQ7Nk4aHVJhfSWwnY8OWmXCxmeMqyErEnXtxAn5bgnCbFEO7NS4JcJBX3GqMo/uAc8iapCwFC7lZEuRx4msdnxdG0dQud0XtFVlkveK9G+V26imt95oBPIM9ZehhXznG/Sgm6wEuGSnAMPLzV4f/GZO2bWJiGWKPadz8rntrMc47lnHxXlzSA0iUTEIRISo4kapbldPdkXjaLb07uIC2vB/mXU9IV/OP9RdWjRrfzZY3tPrqRZsWyuQTVkh3QWBm5DEWeFmlBq6HI/3TYAMBkmbOQwOGbADF8+pIKl4ouxHrpXCWRWkLZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1ZEJfJwgCo78Asz1ZD2KDfn5+bZC8UTiZ1X83PPJ98=;
 b=dGDyKoxnKLUpK5WSWx8bDfc2vbULOBv/FEFDqz40DbwbQJX5fNyX45hAUCNmMJczn58DE6rVg3kYD9+YbniT7TyzhDDeMHJPM8nmyI5NuCRDWqpxrYSmy/wEmuQphHfHelWFYL7gWZs16lsIFrHJMA0oymbfonAhUOHgJzuvlRRCXEvbb03oyeXxCSGPWAV+Zp8Tu2JG4fTikoCvWJfFRaWpkRm+YPRvFJsuII5Jds0iuedZWgqKIgRf+L64wJS2L5loqTt7W4B6AMjSPMkpZfuCtKgptDHy9OZJNUSwCw0G2emc9Uo2/cXSrw3ZUyl8WkEIbcyXJSa79o5LlRbaYQ==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by DB8P193MB0645.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 19:40:00 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::af68:c2a:73ce:8e99]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::af68:c2a:73ce:8e99%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 19:40:00 +0000
Message-ID: <VI1P193MB075256E076A09E5B2EF7A16F99D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Date:   Wed, 18 Oct 2023 03:39:59 +0800
User-Agent: Mozilla Thunderbird
From:   Juntong Deng <juntong.deng@outlook.com>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com,
        akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: [RFC] mm/kasan: Add Allocation, Free, Error timestamps to KASAN
 report
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [n68INaFdX0AQ9ixRWTnYzMxHobQbJ5ct]
X-ClientProxiedBy: LO6P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::7) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <951f648d-2dcb-4438-993a-c9fafed0128b@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|DB8P193MB0645:EE_
X-MS-Office365-Filtering-Correlation-Id: bf333dce-9b20-4534-f3ea-08dbcf48d9bd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1md31kUyyaT7+1p69ggEWbAqYF5o4s2dDXa/WSmHrH/WL09w/KkL++6Xz0gWnGDitUU34XBqlzj77V/rMdjj1DfGu+u1Wk3gEc9rxb6q3FeUR+Yj2Yt84btAoPvjv5/Ude9Z8fWKcxmEH51LJ0Emi33+u5iM8G69zpRi+m0RjRTfZaWlRLTyFNX0wVCqlzAimN96BRPt2xXqFUi81DPJqcJMv+YtnmwfqO3YbTXT8vdsltAGGxh4ZjrYi6nEKapsE/AQgRsKCqpqMfEzf4Oh4man6qmL+vS0O5njK19s4t6S2rqzPuP5stXMpc9Jw8ttrfDd5QVVPT8kjcZwKDC2L2TkvNMB9KsMRWImMXHhTqJ9HELOfdQBG8qiJzhyXkIbbFyNe9MpLzoZTcq7+DZIB71SdLmygzHCwVq/YNPMMy1M0HAmcws01rxDZKz1PuBR92So76S+M+5sWtr0DxIiVruZkVfwJvA5teysKFD3qyLcgCX+jtv8H5cfwQ3dv5dBCjc8EP+G7dPINdNjj1CNxF6FBFry6nuwogLxm6RS2siFLcPVHwAby9mThlSp9xV
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFdPdHo1STFYa0Z1TEdPUkRJN0NiSzRJbHpaTzYwTnJ0YVZaUVJ4eDM5OVJN?=
 =?utf-8?B?NXFJdkFGZkNzclV5a3p2WlVpcWY5QTBPMkpUR25vc1p3S2J3SXF6QUNZTEZv?=
 =?utf-8?B?OXo0UG0rTkUyRVo4WXdzTjdIQUNlTkU3TDRJSEZYRnBjT2E1aW5zNkFhZjgz?=
 =?utf-8?B?eFFBY0NHVUl0ajVydWQxS2xYaHc4R0k4My95aWo5cisxMkppQ1pESDllNVVN?=
 =?utf-8?B?NmRLV0JGMFdLc1NKcEU1dnhSVHdKelB5RXNhZytDRGl1R3V4cFJIYWZuTmM3?=
 =?utf-8?B?dUdvaksyc1BmWGFqN0FTK0Z2VWhxb1VZbXUwdm1RdndRY0VHV2MzYmxGYWlh?=
 =?utf-8?B?ZUplZTN5WUVrQUpOZ1ZiMGRLbU00VjM4akYvZUpYNjhTRGZPNldVUURrVEhW?=
 =?utf-8?B?NUMxWno0SlNRWDRTKzhaQTZYeTVqSFVTRGVGZkZQL3JGa3BSNm5mWFRNWENp?=
 =?utf-8?B?a0tadEhPNEhJZHVITGxYU3ZZTFZ4V0NWYUZNNG1HamVSQTJnUnh6czRqSDVu?=
 =?utf-8?B?UmNEVnBSSm0zTGZWUDU2MCtHQnc1SVZucUxDQ0VCejVpaUFVcGhjWTZjVHEv?=
 =?utf-8?B?NlkyL3lmL2ZraHBlc3FFcHRNVFJ1S29NTmJlYkJhYjdzdnRxTjRweGRrRGhY?=
 =?utf-8?B?R1krRnMweEZXeTREbklmQ1hlLys3Skd4OHd5bXZnU1hmNy9oaVNDWmtmNmxH?=
 =?utf-8?B?U3ZqN0RVQWdhWXB2OXZVeFM3WXhIVjdHTmxlbTdIVEV6N3VXMGtDaUpPNk42?=
 =?utf-8?B?TTAzdGVGTjBRM2N2ZkNrZ3h0eENNWnBOeGkzRGllVlA4NWNuc3FlRjl3Y3Ni?=
 =?utf-8?B?Sm9WNVNuSUVLOForZXhOWVJFN1E3cU5LWVZrL2NmQWIydmgzaW1vLzR0Q0N2?=
 =?utf-8?B?elBGcFpZY3JlQ1c5dTRCNHdFT2IxWkVjSER2Y1o1ZWtjQjlLbWtJYUpCTGIw?=
 =?utf-8?B?OG1IbXMweEZSTFNjVmxPRElZOGNTSGpLd1FyYVpZWHc3YUxCLzBpaW1XZm1D?=
 =?utf-8?B?eGxEZlYvSnA2V3VaVkxMY3Vsbmk5bE5jSzhFZW9FZWgyTHVsOEhkN0pINXBy?=
 =?utf-8?B?eFJJTFVVS3oxd1djYU5MdU5keUdaNlpIandpcnBhV29nN3A3Mzcxa09UQ3NE?=
 =?utf-8?B?MVlvM1FmQ0ZTZURXVGtGNnZ0RnMwSVpRVlp1NmoyTnZhcnQva2hMRDcrdFdX?=
 =?utf-8?B?aUlod2hYR21VNzlsTXJBYU44S1JvOHNFbkEwbDFHcXpUbzZ6dXBDQzVGYUJp?=
 =?utf-8?B?aGZONkdiNEV4UkhIdXBqZGhTQy9WZXZ6MzhEa2JWYnphZkJUYWxXUkIzL2Vr?=
 =?utf-8?B?cEUyVXhrQ0toS3JZVHBPU3J6OXkwNnNCTEUxUEFRTks3WHpFd1lXZEFrdHdO?=
 =?utf-8?B?aWFFV1o0Y1NJTEVweFlRaUdPM3RiUFR0NGp0YUZDWnU3dzRFaWxLdnJXYkJQ?=
 =?utf-8?B?SFJtb3FxaWd4SGxpVkttRnBwOEhVQ3A5Uk9UZ3NpbGZTbThVTkF2cU5aZ0Zy?=
 =?utf-8?B?dWdncm9WQi80UUE0cVpCV1NwNjRWdzB0dWZVNkFwUVY1Z2E0NXJTL1ZxTFRY?=
 =?utf-8?B?SmNZd2JEYUhZOW9qZHArMEtPeDFEZ201TkhQMVhKTXJ4SkFvcWVuWE5RcmpP?=
 =?utf-8?Q?ENv95TQUg7ryBMVEkHHFq/s64UbPQM7T2ouJrOwbrGYY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf333dce-9b20-4534-f3ea-08dbcf48d9bd
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:40:00.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0645
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea came from the bug I was fixing recently,
'KASAN: slab-use-after-free Read in tls_encrypt_done'.

This bug is caused by subtle race condition, where the data structure
is freed early on another CPU, resulting in use-after-free.

Like this bug, some of the use-after-free bugs are caused by race
condition, but it is not easy to quickly conclude that the cause of the
use-after-free is race condition if only looking at the stack trace.

I did not think this use-after-free was caused by race condition at the
beginning, it took me some time to read the source code carefully and
think about it to determine that it was caused by race condition.

By adding timestamps for Allocation, Free, and Error to the KASAN
report, it will be much easier to determine if use-after-free is
caused by race condition.

If the free time is slightly before the error time, then there is a
high probability that this is an error caused by race condition.

If the free time is long before the error time, then this is obviously
not caused by race condition, but by something else.

In addition, I read the source code of KASAN, and it is not a
difficult task to add the function of recording timestamps,
which can be done by adding a member to struct kasan_track.

If it is a good idea, I can do this part of the work.

Welcome to discuss!

Juntong Deng
