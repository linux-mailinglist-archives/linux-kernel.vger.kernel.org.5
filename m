Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE59B79A3C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbjIKGrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjIKGrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:47:43 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DB8133;
        Sun, 10 Sep 2023 23:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1694414856;
  x=1725950856;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/6KmqRJkE27f+wvLvCaf/Z5Z2V3U+zRyNDxmt9gnJZI=;
  b=MW9l9zyhclPuAnLpxjuqGryJVzP4ItyPOESzXIfZ1MRZjxXkHKew/2Iv
   xsyXdjUUQM1I36sRSdnfQzenovn+Cg1PQ2jt0Okyd04gw78LTT4C4h+SO
   KdbVizIhr4qUiVh7mc8smnE0vK9TihIWVpoRGN9UQwLaYMma+tjPhVVoi
   qMBrcLRrp3p7aL3WoSvHCgS+1kTAEk2VHBa20jryEcSd0CfyhyZAMMCYK
   XqmiIOZhNPzrUeoJQAG4wIMdeKId7r0kfI5vbGI4hXcpRBpS/WXCgiQe3
   z7247QG76Jj+ykRNy8maDu+4u+ll/sZ5wUlem79OemvbYstYlheq3kC+Y
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2hZuHLgqtzDrxRmxC4yriM+Xgrz/6rHgZcRDM3wHIadRoq6wmAJQLikMahV/ZatqAKOV6ca8ctaG7NtSaw0VUidSxnR8Qq80VAZN4hX3R2mh7jFyC5eRZWmWKx7DmjHL9WCYv+Ga9GoISsccqIFJzW4YI6kDZGAA8v+X4yTUAPUciEl/v+CW3C6y93HKw0Gv6yosNV3cofi3rfDQORRSLkHtiRoSajIuSpa/AgATB1C5GSVpIes26X5ksLpHLOgiFo24AwesdQ52uGD/rQkXpe3/UjQz32ptt/SK1BrFnSeq7eElp7n+UZhsdhRG4Pypv9RNo8k0kazgWOp8DChAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6KmqRJkE27f+wvLvCaf/Z5Z2V3U+zRyNDxmt9gnJZI=;
 b=TPM+EMx+DLbEY1zEqCqwEWqN/qa2GHuQ5qfdHPxPcBREuWeTscgjUrEL+2fEiDiLUur2ExeNS0Xw+K8b2ygTZjtrzEvyDHeD6VAC7Kp38gLsTmCrUY0QVRIgkdQiq6xQBJ+VQQNHHsekz26K/+W/TU+p5Px/2jUqRykOLWZLpLWv2OgEpsqgdbV5/a/9j7jeKV5zE+mR9ffAxHgTumuYu7RMLLDiIjA7lctJSIiMhxf4jWAcDz/baJ3h6rSpHG0MPyGbgY5YMXqult0RcA7CmmIkoQb9JmbEYlRQVvS1sTKliISADjdRNrosX1zOroCV3lwz28AhyL71Z8dBZQ+nZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6KmqRJkE27f+wvLvCaf/Z5Z2V3U+zRyNDxmt9gnJZI=;
 b=oPEKMa2kNqsWUfMKfl6BMDlOtBze1gP5VduuZhQjK0XEFCChKYG+WDO57eJWraBgvS8ASNHBsIGdM2KH6ESPTi5HQm2thf/yQy1NNfaOOdZ3mvNiM4mToTXTE2GdgNSyOQ1I4tvn5gZbO+TQ3QnppYHQ0hoSJyrb8nqtY4w4RHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <63a9a3c2-bdb7-0b33-6f08-5b0481ea9e3b@axis.com>
Date:   Mon, 11 Sep 2023 08:47:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] iio: light: vcnl4000: Don't power on/off chip in config
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
References: <20230907-vcnl4000-pm-fix-v1-1-58a11c1d5a6c@axis.com>
 <20230910143235.16a924bc@jic23-huawei>
From:   =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <20230910143235.16a924bc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0061.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::21) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|PR3PR02MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: c8649e51-bd9e-4a6d-b488-08dbb292f976
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BwCbM3qYw+/vKNT/J6+yurRHx/IYwm0Al2X1Y9JQCzEenPYups8LYNy9jjMCTpGVGBQEkQFaK42t1/B8NTgk4wjSfUIyf6GVLkmonPsN+GXyWLl/1gZEwx9UaxqYIj8QjPSpkoem5SriJivZdejedjUz3VEhaEtDjBk2D/Cha22Z6xkWgebIdJ2JyfdS8yacAbX3WRprRm6i0zQhkpbv7msbxUiay8E/9iOmMQnMCAhcu/kWWnOvfXpTwmWKGEYwEzaANgmtamUwv5KIHJXHA9d8sv71WJA2xrmc1T+7fcxG4/FxVhxoBA4dm89pV9kwUSg1iyrWCrqn8tBmc/p4ySx9uXmVj/cL941UKZgUcDv1uGvMdpQLSDiOwbwgSmbzcO0gBh/Brr+9R5zr4egHIuAZ4bHY9kbZAgfrOciOa83K2wUgAUDOUUrTfpLxva5Ope9nG5goLJDScdxBKP2LiIoeFI5qjmmj62tUhm0WiKXdNVL1/xzxjHFr+wCzg1SNzn6IYUk2vIsUeWCkLeiYkyIgr6YSMhy7yLRqbL6a1Rd5qS0KoXlFCRRS9xSNrwiW1wB4uiAKvCGkLKY6TDKIE78iewsRhv3fbIWtbwaYQo8WgV5CBBuF4IA+qKusz8TmVE8BMaLrT2YtiI0M3e/9ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39850400004)(186009)(1800799009)(451199024)(26005)(107886003)(6512007)(53546011)(2616005)(38100700002)(31696002)(36756003)(83380400001)(66574015)(5660300002)(2906002)(478600001)(41300700001)(8676002)(4326008)(8936002)(6486002)(6506007)(6916009)(66556008)(66946007)(66476007)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0xhWjRKVThtZlBWRjFIdFEyam9sMzZsS0ErakdXL0VDNjNaWHU4RnRaU1ZD?=
 =?utf-8?B?amM0T2VXSE1jaU5tUEMyMTlCTjJwV1BkKzhqcnhDNVcrSmtKdEdpUmx0ZnRG?=
 =?utf-8?B?cTByMmlYVzl4b1NRbFVHenEwTEoySTc4Qnh2WEZlOEcveFlUQ1FrRHRpR0ND?=
 =?utf-8?B?T3o1bXpBdnFkVCtvQW1GbUFPUTVoNHpWZzh5blpDQzJ0WFpvSzUxZlR3RVRC?=
 =?utf-8?B?cWE3WWEzbi9oQ3JzZnk3K002b3RDdVpXN0p6dTRNaitXc1ZNbnIyYzF0Um1m?=
 =?utf-8?B?RDU3YzltOEQwdy9aSXVvd1ovV1VSVWE2cjJKSXd4Qmg4QzNpUHVSQ2dlZzFP?=
 =?utf-8?B?bXF5SnRCaDVhMlA4a1ZZN1JwOHFOMEx3eHpCMllpOFQ5T1RVdnQzWWMxem9X?=
 =?utf-8?B?blJqRnV5bmZBQWNRK3g5aXFkSU44c0ZIeFgwZWFJWk54eEdQRXBYZjUrR0Vl?=
 =?utf-8?B?bU4wREd2UlpYcU1ESE5EblVwaHlyL29TbzNSMHFwTWQ4cGlXbU9hRzUrZ0lp?=
 =?utf-8?B?ZlpzT1UxZzJCNUFlVUFPbUd1ZURFNkxwSE42NHRPSnBJYjNUaGc1RkpCVjVI?=
 =?utf-8?B?V1VJbE5ML1pMb3IvSEFUZVdjY3lnV3U0UEEwbEs5NWtsTy9WQXJRUXg0YVZH?=
 =?utf-8?B?bnl6bDJSS09kNzNPckxackVubFh5VDJxR0ZZY1o0WU52cElkTGlrSzJmRyta?=
 =?utf-8?B?YjFHcGZxUWxnWlZUTXRDWkZPY2FCMEErTTVzSHJIcGpsK3k2bUhtVTFFbUQ4?=
 =?utf-8?B?ajlKMm5aaUVuM1JReGFqNm5RVUhnV3U1TE45VU5LRHlJanlwZkVMeXFzUy85?=
 =?utf-8?B?aWxnb0NreDlHTjZCcWhCZ284QlVxNkxSTWEwT3FPdTl0aXZkekhyOHQ2b0NQ?=
 =?utf-8?B?ejd4bFFRL1ZvVjJqNlRER3BKYkFWU3owYW4xVktwd2I0S3U5Tzlvd3NtalZL?=
 =?utf-8?B?aU9oRUVrOGR5VmVKQlQvU0dCc0xtWWpldjAxWDQrMWh0YnV1WFdYZnlnTzJv?=
 =?utf-8?B?cFZmbGVjR212a08rcHVIYWNhMXFod0xOSmd4aStsSStLQWFuSXVoS1I3VzNS?=
 =?utf-8?B?TlFHMDRGbnorVGEyMTZmdEs3UnJTNGZ4Y1RvcHQwdlZlODRXK3pkUDVFaTdv?=
 =?utf-8?B?aVQ3V1c4UjJsWWxFRWd2Q2hUZkY2ZXpzMTlORFNodEE4a25iK1lUcEYvSjRZ?=
 =?utf-8?B?T3RjdzF1M0VHWFRkSEE4UHp6TGY3eGd5aGpFRVh5V252N3VVcHVHMEFjLzh2?=
 =?utf-8?B?bk9CQWpRNTlkdG8zMDhkSGJndWVjUWlKRzl3MzFEUCtTakREZlNLZ0VLOWI1?=
 =?utf-8?B?c3NwNVlPNytNMVRlVUNNc1FqelU0OFNiUTYwU0NlTVZRTlZBeE5qeVFCdHY5?=
 =?utf-8?B?V3c1aUNIYVFEU3pJUmZmeTdONjVIV0tMbFBYOS9YL3JIQ2VhYTJad3lxSkFI?=
 =?utf-8?B?NVdtcStwN2NYVVRoRkNYb3daelE3VE9CZ3JYUk05YXBRbFRWZDZ4V2hJd2Fp?=
 =?utf-8?B?dUR4djNVS0xZWVZaL0NndTdUbWpPeHhyY3Y1STNjMUhpdWJCVDRjNVhhcERU?=
 =?utf-8?B?bkw4akZuRWdVQjhZN1hobXcvcTh5Sm53UFliZzJrOFZmc1JSL3oydkVNVUlQ?=
 =?utf-8?B?V296cDd2bVBOM2NTZWU3cTFuajIxYmpIeUdudFg2emNoT2ZuME5xdVY2U3hO?=
 =?utf-8?B?clU2WjE4OW9SWEI3aGZHT1lZeGlPbHhKc3hOZGlkcXFCcjF1ejk0UVAwV1B4?=
 =?utf-8?B?SEhEZTBEeHRVMmErTEpueWFJYVNrYTJVbVY2bHYzN3VEaHViMWdpMGhGN2hv?=
 =?utf-8?B?OG1icEc5bW8zNVVrRW95RFNnUlQxcTAzRUVUTzQrcU1HWW9Mc1BkS3hsYnBh?=
 =?utf-8?B?NjdZcGQxVEhxb2NsWVpvTm94QjVscm5RMm4raVcveFBKRUlsdXVWVHVVMGZp?=
 =?utf-8?B?QjBycGgrUE1kUFJKc0xCd3dXS0ZvUXc0VnRNS0NEbFFNK1pUQmZVeGtGRzFU?=
 =?utf-8?B?UjMxMjJiMnBUaGczRDRjdkplOXNPVkNYWCswcVBVZzNGb1FvWkpTYzdiclcx?=
 =?utf-8?B?ajdVQklpMXpJTDd4T00wUDVkS2oxZDRMcEJ0ODBrQkp4R3pVU3U5SmhFOVFz?=
 =?utf-8?Q?7EiSK8LxEMSvQCCxtwVaFb8iV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8649e51-bd9e-4a6d-b488-08dbb292f976
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 06:47:32.4544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXk2WdBDslIDDVeGR32n91Un3eCw8XF/z4ydXf0X5RgLF2dnUdia6RkIN0ziXVILSnUIarnqvJzHHSQBfFOPxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6428
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan!

Thanks! I'll rephrase it and add the fixes tags.

Kind regards

Mårten

On 9/10/23 15:32, Jonathan Cameron wrote:
> On Thu, 7 Sep 2023 12:53:14 +0200
> Mårten Lindahl <marten.lindahl@axis.com> wrote:
>
> Hi Mårten,
>
> Agree with your reasoning etc (and I guess you've triggered this for real)
> so just a few patch description etc comments.
>
>> After enabling/disabling interrupts on the vcnl4040 chip the als and/or
>> ps sensor is powered on or off depending on the interrupt enable bits.
>> This is made as a last step in write_event_config.
>>
>> But there is no reason to do this as the runtime PM handles the power
>> state of the sensors. Interfering with this may impact sensor readings.
>>
> I think the following example could be clearer. I haven't checked
> the naming of states in runtime pm, but a few things seem backwards to me.
>
>> Consider the following:
>>   1. Userspace makes sensor data reading which triggers 2000ms RPM resume
>>      (sensor powered on) timeout
> It triggers a timeout to do runtime suspend if no access in 2000ms, not resume.
>
>>   2. Userspace disables interrupts => powers sensor off
>>   3. Userspace reads sensor data = 0 because sensor is off and RPM didn't
>>      power on the sensor as resume timeout is still active
> suspend timeout hasn't yet run out, so the runtime pm subsystem thinks the
> device is still powered up and doesn't need resuming.
>
>>   4. RPM resume timeout passed
> suspend timeout.
>
>> Powering sensor off in (2) risks a time window of close to 2000ms where
>> sensor data readings are disabled as in (3).
>>
>> Skip setting power state when writing new event config.
>>
>> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> Fixes tag - probably 2 of them. One for the recent change that added
> the || als_int part and one for wherever the bug originally came from
> with comments to say why there are two fixes tags.
>
>> ---
>>   drivers/iio/light/vcnl4000.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
>> index 3a52b09c2823..fdf763a04b0b 100644
>> --- a/drivers/iio/light/vcnl4000.c
>> +++ b/drivers/iio/light/vcnl4000.c
>> @@ -1513,7 +1513,6 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
>>   
>>   out:
>>   	mutex_unlock(&data->vcnl4000_lock);
>> -	data->chip_spec->set_power_state(data, data->ps_int || data->als_int);
> This will need manual backporting as this line changed recently and I'm fairly
> sure the argument is equally valid for the older code.
>
>>   
>>   	return ret;
>>   }
>>
>> ---
>> base-commit: 7ba2090ca64ea1aa435744884124387db1fac70f
>> change-id: 20230907-vcnl4000-pm-fix-b58dc0dffb5c
>>
>> Best regards,
