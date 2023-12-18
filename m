Return-Path: <linux-kernel+bounces-3889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 844A18174CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2372830F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2231F3A1C1;
	Mon, 18 Dec 2023 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Je5jofGL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3CD3787D;
	Mon, 18 Dec 2023 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cr0TonvgOMT88z8MU2SEoZfmerH1WjCJ0ilH+CQCR6yQH0FDG4WccIdo9P3Z0lgKH/bNFC9EMPpGJgwVRUly2xfh+yAZfhAgTjsdQvPpzKf4iDO7XDeTa/TOU3zNtMcWq/0KvtlPl2K6wHtVb7xI6gJ6MKDG/SiXuf1PSFcu2dzQ2Ld2KSvtEBLMt0WUJ6e0c5LhbL1lgc2gYbbz39RwZ2kHo3/othkzoINT9Icv7oH0xEFvcjf0gE8FuXnp+9M3mdQlCnSJT/4ZE99GBRxxdN2Xe+3VBJ0G7lD9c1ECSZThC0tXMcxnxV74Ohed9npWbYuVlgd39zLR8qkL3gwA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQBXLXtdWK6JNy8F8RlEqEwSwtK5JNLHIAiveUHo/wQ=;
 b=d80y8D6tp9x3YRFGmFaPc2UCkZ+OGeWn8PMWH9MAZbn9VqfUOFOgsAmfFgZz17VLsWQXC43a+lpMzOOmRlNGhBduwP9HNwbIuc/7B8jNO+qoTJoV9ZF88+MjSp863YYs726J296pExyM28avcHPn6Cvh43u8z726utN7eVc+WGumiBIJL2/qaNtZ/0I7RoQ4xL6rN94UmjwbgW5WmXv5p2/Wo1zpfySvC/D0hYcLoP1ZUA8a6bvbHZq8TF+tXezlRqvtxF+OXBsgw3hExvXyKK/SiMN57vAkxAIyNG4+h+bkUZRNms60lgZX/q8fAhPCbkYah6ZQDjYsXUlVLINznw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQBXLXtdWK6JNy8F8RlEqEwSwtK5JNLHIAiveUHo/wQ=;
 b=Je5jofGLebgpuu8wIAyZdXoAxAwHDwBbg5/UJx8H4+S9npHXkitpUR53Nz57iQWQMMskNyFMaOEg9QEAXsFoSTFyCOaCka+D2b7ZrHrjL7nY7OXDeTTqHlWzvNC+BOy3PWc9DshkceozsScZq6eSUr9v+8PX7/jMHzYDlh1stv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from AS8PR02MB9529.eurprd02.prod.outlook.com (2603:10a6:20b:5a5::16)
 by DB9PR02MB9828.eurprd02.prod.outlook.com (2603:10a6:10:456::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 15:08:02 +0000
Received: from AS8PR02MB9529.eurprd02.prod.outlook.com
 ([fe80::1bda:1dbf:c056:e09]) by AS8PR02MB9529.eurprd02.prod.outlook.com
 ([fe80::1bda:1dbf:c056:e09%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 15:08:02 +0000
Message-ID: <7b0599b5-15ae-7104-5298-805b6377f39d@axis.com>
Date: Mon, 18 Dec 2023 16:08:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] Introduce new iio resolution standard attribute
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20231212-vcnl4000-ps-hd-v1-0-1c62a95828c0@axis.com>
 <20231217141046.4cf3e34e@jic23-huawei>
Content-Language: en-US
From: =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <20231217141046.4cf3e34e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0100.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::18) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|DB9PR02MB9828:EE_
X-MS-Office365-Filtering-Correlation-Id: 0154892a-1a62-404a-b904-08dbffdb2109
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XceDBPMYxk4WP+Gg3tYAuZI36mY5n+hx+/uoJQiRBEjtxLSSBKX7JllsWYh3okDPGEA6tE1RjnTXxdE1NwVs7BuGLBqA3PpQJfrkAr57Ry6/CkJaI3BGZdQuipjss6fiD3AP7SpACGCLbe0wr3AqkV6NAlTk6LVCax6ISFglfKXMiCKytGaZpVoOWRfhl2ebMnnQSVh9hyC3lBpFjA1bJlbeMR3MkOQ52KV6wQqEG9BGDxafZDC5dZSwEh4Y/1DoH3QlgwnV7/nChVmlIcv8SBpyaG6UMmsRc0QTFNC1YJLtXiXshmRfVs33sNdNzJ2+mtjb+FdqGldaNadRGDx8Sf0IszY+nkxMBcmmprHzsNQ3zdSXguZ6Evbd6VmVfDJgIm1qAoAOMi82i4dfG7UFnlT1FBo2w+saKqEqeSrvAgBG97Lbm22q9lftORXrHwIDV4SS1Hr/zwCjajPrguywR8BiAh1jxR5FvcHlFnYmF/Q/EYF9yZgmVomo4AzAIRlyKYDLGNOXST/PIfOn43CIsxEvDLe+affc4RdwbRHYOmD7K+KlVnk8StJ8o97K+KSs6KfbQ2DYrdnzUW7HgTGfl9afg2Zf/1OJIuoQRHD1MqFumXeChVfLFuoniYe8U4ie0r+Ezp+8Vb8ArV3OZtR7ew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31686004)(38100700002)(2906002)(31696002)(66556008)(2616005)(26005)(83380400001)(107886003)(53546011)(6512007)(6506007)(5660300002)(6486002)(41300700001)(36756003)(316002)(478600001)(6916009)(66476007)(4326008)(66946007)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3FPZER4MGJtNGVodGRMdC9mcEhjS2FYRzV6QlpnOStRTHB4Y2hGSlE2Tlcx?=
 =?utf-8?B?NWhyVGpGbm80bmp1T2x1dk9kbHB0aUd3NFE4UjY4SEgrWW03YjJpMS9vc3dH?=
 =?utf-8?B?M3d1c1BTcWlsMVlNNEJsSmlRdTczWUFwWE0zNG5rOEh2dVEzN2RHS21WN1Bp?=
 =?utf-8?B?Z1hLWHlNZW95RURhUzZLSE9yelhqanZaTjJXOE5VYW9zd0g0NGtTcjgvUkVt?=
 =?utf-8?B?QkMxWTlXMEVWVHhWUWxkOVlCVnBtNVNpRGs4cElhQndhei9hMjZ5NzhyOXJD?=
 =?utf-8?B?SWN1MWw4QjhSdHRUTmFKRmRQQytvZ1h5UHBIZXZZYU42VTZZQkJOaGJWOVJ4?=
 =?utf-8?B?N3RvaGx2SWdPbTgxbFlRMU02elQrcTB6UG9jUFJoOU9lVFUwQk1KdXZMMVRS?=
 =?utf-8?B?NXR5c3ppeEJPRUxjMnE5U3hNR2RRTU04YlFOVkVjZG5RUTdyOG5KN25Iczh6?=
 =?utf-8?B?cy9MVldtWG9vYlFvOWkvb2ZkQ1h4azRHdnVPY2NwNGovcm5OeDl5RVhOWmdE?=
 =?utf-8?B?SUd0anN2U0tTekV4U04yQTdTTmNycXZRR0lsdTYvamVXemd5N1MxQVpiSHBn?=
 =?utf-8?B?aWVjSjdlcXBTVm1CQ1NNZWdFc290QVdBS3JiZEU1R2VKMVdnODBVWlI1eXh5?=
 =?utf-8?B?cUgzdEorS1JlVEtPYXg3WmI5ZFhxODNFbjZ6YzlYMWRDYkpFeUwvQmlZaXhz?=
 =?utf-8?B?ZnpnQ3dtRzNKdGc1S3pHMXhDOTBobVc3VHBVbWtEdnJ5aXNmQVVLQ2hFK2lt?=
 =?utf-8?B?UDNMZzIvT2o1OEY5WE43M05rWm04RW0wR0VrcFZ4YlBoSllPTVVGQlVaK1Jh?=
 =?utf-8?B?V2xMTEhpVlE3RXJDR21nL0N4Ym5MODdSbFdzN1VlY3FNZVVLYTAvdmMvWjFh?=
 =?utf-8?B?UUNFVGM0Z3BtbFhCY0RhZlRNWEtMVGNyVEdkVktoem5pS3NGUEtyVHhRNVc2?=
 =?utf-8?B?dmtLcVRaREoxWWd0UkF1ZDFGMFpsSk5KOXMvSFFYWHJRRTlUd01qQ0wyeXVJ?=
 =?utf-8?B?aTE0S1NydTc3VW1IVS9hajZjKythZkN2SjN2VjlFb3RtM1VoZXN6cWUveXpS?=
 =?utf-8?B?RWRneWVxak9LazQzR0hOQlJYbDhldkN1QVdkYVNBT0xFazdiaXRUQXQyeTM5?=
 =?utf-8?B?cUwwd3QxTmxCblpwN0JXaEN0SFErRFNhNU9odjR0TEpFN2V5SXhsNmpRWEEr?=
 =?utf-8?B?UGRuUm50WFFvbzBiTnlKSWwycVd5TWNJdHZEU3IwVlVFMTVaWGJKaTd1ZzhJ?=
 =?utf-8?B?U1kwWkIyVmhSUW9lVEJ2a0R0QitiSGtUblN4d0VRQ25hMHcxTXdBZ2pZYW1K?=
 =?utf-8?B?bFFnNjA5RW1pMlkwQ2hDQ3B1b1RmSWZwUDU2UGFJOVg5TmxWQ0VyZXY5U3B6?=
 =?utf-8?B?ZmlxM2lEN2p1b3FYRmFLN04rNkoweTZjV09JMy9Sc3lYaVF2WmlidStNYnZz?=
 =?utf-8?B?RGtrNkJSc2VnVGdmZDJRUndjT0Y3WG9FeDZUbVNMZ25BZ0M0ZVJnaWJnNCtZ?=
 =?utf-8?B?N1JwZXpUOFU2Y1Q0d0NjTU1EQ3B4WFdpdkltbCtSaTVLQzZXeWR2N21KaEhK?=
 =?utf-8?B?ZlRRZjV6bGNFdWpIZjNPRnArMWVOMTc0MmhiK2hlQSttMzI5RHZidzk0L1hV?=
 =?utf-8?B?U1NaZjA2N3lqZ0FFUFFHR2ZjbEUyTXF4WUtrWEdmR0ZTVVBUbGdTR0VuVGVz?=
 =?utf-8?B?bjNZVFlGNkVVdXdVR3U4dUxJSzFmbnpTdHBLQnk5eDZIY2VGZEpTV0tZOFlC?=
 =?utf-8?B?V3JvVW8yVE1sY3ZMeEl3WE9XVVhkR2d0T0tGN0Q1aXllcVFGSWVnekVYOUNK?=
 =?utf-8?B?QTk3c25ySkoxV0FvTzlad3B2QTBaaEd2bkhjZGV6Qk0zTVluZ2lNd0tGRElD?=
 =?utf-8?B?L2pJWWdhbVR6SUlkakRWOHo4NFplQlhvejdOaXZBaDdTMzluRVZUNFEweFQv?=
 =?utf-8?B?TjF6OVJZWUJ6NnVzNE1HUTNTMWExZUs2KzB4QWkrbmVGL3FzRnRuU0NlNHc2?=
 =?utf-8?B?WEswRExURWRXM3ZUbHdoamV5R0xMZ2gxWmlZVTd3b1hmdW00bkNLcEVscVZ3?=
 =?utf-8?B?NGJSc3lKeHR4dCtvVGdqY3pFcWdwOWtZRkFzNUU3UFVtcjJPVHRVQVRhNWlL?=
 =?utf-8?Q?zkzM/XWgkO53aPNrP2/I97eNZ?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0154892a-1a62-404a-b904-08dbffdb2109
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 15:08:02.2182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/w5uTFvncLiDumWXRRdF+vOT7TF0F2DKznrHpwwTizzpME803pSHWJEqkmts0pBWigXZNW5jgtYMy+ssRNoQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9828

On 12/17/23 15:10, Jonathan Cameron wrote:
> On Fri, 15 Dec 2023 13:43:03 +0100
> Mårten Lindahl <marten.lindahl@axis.com> wrote:
>
>> This patch introduces a new IIO standard attribute to set the bit
>> resolution of the data *_raw readings dynamically using sysfs.
>>
>> The VCNL4040/4200 proximity/ambient light sensors support 12-bit
>> (default) and 16-bit ADC resolutions. This can be dynamically changed,
>> so to support this with the standard iio channel configuration a new iio
>> attribute should be added.
>>
>> The VCNL4040 devices will use this for setting proximity high definition
>> (16-bit resolution).
>>
>> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> Hi Mårten,
>
> What is the use case?  We've had lots of devices capable of doing this
> sort of resolution change, but never yet come up with a reason to do so for
> the sysfs interfaces on the basis the overhead of the sysfs interfaces is
> high enough the best bet is almost always to use the highest available resolution
> and don't worry that the read takes a little longer.
>
> Jonathan

Hi Jonathan!

My use case probably does not differ from others, in that 12 bits does 
not give enough precision. So it's just a dynamic feature that the 
sensor has, but as you suggest to hard code this to the highest works 
fine for me. I just didn't feel confident enough to do that :)

I'll make a single patch for this change instead. Thanks!

Kind regards

Mårten

>
>> ---
>> Mårten Lindahl (2):
>>        iio: core: Introduce resolution standard attribute
>>        iio: light: vcnl4000: Add ps high definition for vcnl4040
>>
>>   drivers/iio/industrialio-core.c |  1 +
>>   drivers/iio/light/vcnl4000.c    | 87 ++++++++++++++++++++++++++++++++++++++++-
>>   include/linux/iio/types.h       |  1 +
>>   3 files changed, 87 insertions(+), 2 deletions(-)
>> ---
>> base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
>> change-id: 20231212-vcnl4000-ps-hd-38d42abf9095
>>
>> Best regards,

