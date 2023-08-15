Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB8F77C838
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbjHOG7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbjHOG6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:58:52 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2020.outbound.protection.outlook.com [40.92.98.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE0110C8;
        Mon, 14 Aug 2023 23:58:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YN2AngCXDelhro229k4kRMJU8z7x4XKsBrgrs5FXfZ6IphJ2M/Et1tP46O+fCCYAbvmz8P34slULS7RRMiXb67pJQlYk+07EEEm/P8kRGQW0c/kaVS+uGfugRJIY+MWPMF3Zkr51up/xXk7Hoy1OkIR4LeaTVSFj943VyZLhRkrgQwpmjnkyf7BeTOVj34gQLht1lOs36yGEj2t76T86nQN7eB27+RUBnLZVkI2Mrb6p1OfbyscAY0E88PflBXxJJc5EOJBEKwBxb8cRAUGjyCsZZCIVNPp98mdqkFfHzU66DoiEdyWDkGpGSjQlGBAErZL5YJo9opsq8CNrj7IX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjAxVR6IlXQ3xJy1ABKUpPmF6k4mUm+jWSYXYs8UhHo=;
 b=W7PovNUHk3NQ7zAZHwda51tZ42yFbCD2IEX48qndx58Jmg0O0q2M7hUvXK9HgUOrLX2JFSJ5yUN8cxoT3ZD+7ZyfIY0R8ZTp76LZ2ckuNIi1A5A4pLBq2kzPJaz4uRUZWUaPPF2np0iT+SPoCV71l6vFe29meWkeJOaD4Pxzx8upp2Jj/wbJsdm4TVwsxHJDg93kGgO1ZAjp5wFr9Kn3wOmA8sZp3HcjKlWVCbiYApB6KDYkwWUeRWOhaRhQnBkjUEvymkSvZ+Te6WLAtzxizXZlTpmq2ZORSDkCZxgj7HOlfk1uG1AoXCQ17bim6s3d45fGE+4iC3ZdYkDnYgtlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjAxVR6IlXQ3xJy1ABKUpPmF6k4mUm+jWSYXYs8UhHo=;
 b=kehRb4cSlJoiCoeTSmHtnyIpE6px3/hLgrAZwOOdznSTEn8OU/t/QhEIP0/zFDzUAW1jAM0o9JixPiFnQ+AQBDum3XWFSpkWmFxH821IHiQ2DvuC8lKMNXgBavvZeIoEUYcqe23s/6l1mL3eLLSju+GHs28t+Z4CDBagf09TLul4rs/ntgJvIyzV0Ue/ZahqrPynWAqi+ORmsk9T6XOXde/kKnu7CJCOSaos/CDbwP8PHp2uU9/BHSr87xWcfqAK0FgGW3pc3Izoe/OASs7MICVZsS5CFWz9rQswQrmCZCE+kuHTFFDiQmMYAzdpFdnolvQ7oA7jB2Q9hiqz/1GIkQ==
Received: from TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:242::11)
 by TYWP286MB2005.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 06:58:45 +0000
Received: from TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
 ([fe80::320e:3328:32e4:a3ce]) by TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
 ([fe80::320e:3328:32e4:a3ce%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:58:45 +0000
Message-ID: <TYCP286MB2607175E9C15DB17A2102AEAB114A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
Date:   Tue, 15 Aug 2023 14:58:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] HID: i2c-hid: use print_hex_dump_debug to print report
 descriptor
Content-Language: en-US
To:     Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        dmitry.torokhov@gmail.com, linux@weissschuh.net,
        hdegoede@redhat.com, rrangel@chromium.org,
        u.kleine-koenig@pengutronix.de, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>
References: <TYCP286MB260706B19C5E30EE2774784EB129A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
 <nycvar.YFH.7.76.2308141126330.14207@cbobk.fhfr.pm>
 <TYCP286MB260715E63D023C52591264C5B114A@TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM>
 <87fs4kn77j.fsf@protonmail.com>
From:   Riwen Lu <luriwen@hotmail.com>
In-Reply-To: <87fs4kn77j.fsf@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [Y7mqAzjJEZ19iku/rNwQBXpHrYq0UAbA]
X-ClientProxiedBy: TY2PR01CA0017.jpnprd01.prod.outlook.com
 (2603:1096:404:a::29) To TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:242::11)
X-Microsoft-Original-Message-ID: <9286003b-e964-7ef8-7d93-5b27fdc68094@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2607:EE_|TYWP286MB2005:EE_
X-MS-Office365-Filtering-Correlation-Id: a022d0d1-f291-4bfd-5437-08db9d5d1164
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agzR4d/RT4A2pQqbyFI85NaZtG4iAu3mj2KrbKbXrfMU8f8PgtitONldFEIW33mlMSMQEbqSbFwHsWXEW/bLMPh4eP74gfG3+M0eXOMT/XtXR1N6JWA3TjbmPG3+Wtl5qT2NUa5DbwxTvf1Jf5dHvSBCWwO20EPt1XBhcFfINomgGiVdCNg74L6twXrpnlebNskkmzltvI/ozzJZ+T6QAAIJuEmQVl86OvjSsib4mchuPNIjSrYy4m/a7edGrdf3IFZFZz9zUli4iJoSi2ugNFQi1ObIJEnJRAf/SsqHrejapmzvbgJsQqCTakXZEJvNAUy3swEz8BRby7NMxkPJgsDNA7nFkS4x54Yg+s0DZZFG5o4lUawipXdrUnR0qD1a12fV7k4MDhYXSXlXSOiBgLq6aTp6AiXTi8Yu6TzKPY1ZY0c3rlBkgEM6OjqXYDqbSdNASaqHTrGT+5J3PLRJnPV7YQKY5CFZvEHv16vACDofVo+BGql5bohhciS9QmMFNrJooVL4E8Bvus0441ndcS+HNlcy/eGiRvRGoVhR21i02clIUfCpu08PiJAQJqrs
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUxXYndpbzRzQ3kveVI1SVZpYVNLK3NJY2ZCWUFuQlNUU3hXakdhNWFGWUlQ?=
 =?utf-8?B?YkFpRVFrb2VTYkEwUVdjU2ZIUEJ4Z1hVYklYRUhIbGpGUUNYNGE1V0ZwTEtK?=
 =?utf-8?B?VVpjYkwwSXRDWXBNcGFtTTRHbzhoRkw2WWtUR2NwTldWUmY0eVVlc0tscDBL?=
 =?utf-8?B?TVR6d3lQTzVYVS94RjluVXp3UkNDRzdxU0YrbTBjSkhYQ3MreG5RNjN0KzlG?=
 =?utf-8?B?Rmt0cUpvckRGSTFhZmZsNG1hSmxnWmlvdmdObmh4SkhJd2lRaEE5NWFHaks3?=
 =?utf-8?B?LzVnblR5SzA5NHJLdjJGbk1jdU1maFZrbWg5Q2FiK0dVMjRtTUJPNi9kYVgw?=
 =?utf-8?B?RWdtbFRmNzFZWXhPV1hoa0tHYTk5TjNjQm9HbHNrckxBTlhIWnZQbHA4N0Mw?=
 =?utf-8?B?MXI3Rk9DaUNHS0dQU2R3T2xpQmtlTVBKY2NVSlZrS01TM3d0VzhlVFFUaW50?=
 =?utf-8?B?NmY3ejBlY2RtSlB1UE9OWTJEN3N5ZFlHazY3TXJyaFNqaTkweStUdk16VElj?=
 =?utf-8?B?cFBNRXJEcjFqbmlHejRLanY3VWlNNDV5K2FjazZXbkRUV1BOamYxS2hNeFlV?=
 =?utf-8?B?L2N4ZHBrdm1TMXdKSlJsSHQ0NUJGYkgrK3lzT0tMRmNtRjlYWDBsWTYzczVp?=
 =?utf-8?B?Nm5WRUtiUEQxQmJ2aWpDc2tBMmQ4YzlRVnZkQVBUZ1gzWlp0dk9nL2lVYXFs?=
 =?utf-8?B?V2JhNjZDQWZxL0V3c1lXOU9lUkNPRDdKdlUvYWZ2dHYrVkNYaDVvY0ZwbDhT?=
 =?utf-8?B?OU1YSVBZWlR5bmVLa0dUUjZ3VldpSHJORkwwUDZMSEN1VXZqN3kyUVUxbllC?=
 =?utf-8?B?emVWeFkzM0tUbjdFMUxjTTBsaVlVUC94bzBvVXZBd3oweFI0cjRvSm1oU1RX?=
 =?utf-8?B?YUcwNkQrYVVqd3QyME4yV1FETUVoQWVFY2FIRExXdjU1cU9IRlJHUmdzbUVk?=
 =?utf-8?B?SkxEOVVqckhMNFRyQlROakdjZlZVNmphNU5FUlVvT05xaUhxSkt3YitFeCtK?=
 =?utf-8?B?aTNhRm9uZVFpbHlFelcyeHUrbUVJL0liL2xhc0p1Yng5cnZ2S01jajVEbnFR?=
 =?utf-8?B?YzkxTFZySkZnZVlLcGd4RkIzS3drTmZQT1c0WjRZc09NcEpoMnlPbGJ6Nkdp?=
 =?utf-8?B?ckk2M0I0L0ZaZWZqV1NZMG9xV24raXd0bmpicXZnenU3S24wK2p6RGdWS2Rq?=
 =?utf-8?B?c0l3ZVo4SEE0R0lDcUNXbktCSHNaU2FWYVN1anJSejR1MEkranpPUlR3N3pI?=
 =?utf-8?B?MDBEY3lkY3VUcy9xc1RwZzZSOFBQckcrTjV0a0RlRUhQOHMxcEU4NmxKdk5s?=
 =?utf-8?B?Qk01STBEVWI0WCsvUVNWeEhJY0R5cUtiMGY4S3V1UGcwMlc4MTRwUE5ac0dM?=
 =?utf-8?B?ZE9XOU5IRitlSk9aUDdlVWEyV0IxT2E3YVpaNWZIdlEzQ2t1Vys0b1VvaENp?=
 =?utf-8?B?UHUvekozeGkyUjd3OWpidThiRWpmOCsyWmtCRHNHVlJEcVo4SEw5YTNoU1VL?=
 =?utf-8?B?bE9UUTRKekoxK3dJZG5pZEZVTk13dWQzbE5aTDNRR1gyd200RklQT3NWUDVr?=
 =?utf-8?B?aXA1bDBwTUMxeWJENlhwK1pOTW9sbnVEZnhHVXo0TEJxQk5PT3IwQWVLTWQ5?=
 =?utf-8?B?TTZEcHIyQmU5T054K29GRXBKRnI1SUE9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a022d0d1-f291-4bfd-5437-08db9d5d1164
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2607.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:58:45.4117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2005
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/8/15 14:35, Rahul Rameshbabu 写道:
> 
> On Tue, 15 Aug, 2023 14:02:40 +0800 "Riwen Lu" <luriwen@hotmail.com> wrote:
>> 在 2023/8/14 17:26, Jiri Kosina 写道:
>>> On Mon, 3 Jul 2023, Riwen Lu wrote:
>>>
>>>> From: Riwen Lu <luriwen@kylinos.cn>
>>>>
>>>> The format '%*ph' print up to 64 bytes long as a hex string with ' '
>>>> sepatator. Usually the size of report descriptor is larger than 64
>>>> bytes, so consider using print_hex_dump_debug to print out all of it for
>>>> better debugging.
>>>>
>>>> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>>>> ---
>>>>    drivers/hid/i2c-hid/i2c-hid-core.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
>>>> index efbba0465eef..8e97fc01c852 100644
>>>> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
>>>> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
>>>> @@ -772,7 +772,9 @@ static int i2c_hid_parse(struct hid_device *hid)
>>>>    		}
>>>>    	}
>>>>
>>>> -	i2c_hid_dbg(ihid, "Report Descriptor: %*ph\n", rsize, rdesc);
>>>> +	i2c_hid_dbg(ihid, "Report Descriptor\n");
>>>> +	print_hex_dump_debug("  ", DUMP_PREFIX_OFFSET, 16, 1,
>>>> +			rdesc, rsize, false);
> 
> Maybe it makes sense to use a prefix for the hex dump that is easy to
> trace rather than padding whitespace? This looks good when you do not
> see any other kernel message log lines get interlaced when written.
> However, if you have a lot of concurrent kernel message output, I think
> it can be tough to piece together the lines of the dump with this
> prefix. Just my opinion.
> 
That's a good opinion. I'll make a v2 version.

Thanks.
>>>
>>> But that would dump it unconditionally, while i2c_hid_dbg() is
>>> conditional.
>>>
>> Function print_hex_dump_debug() dump messages is as conditional as
>> i2c_hid_dbg().
>>
>> The function i2c_hid_dbg() defines as follows:
>> #define i2c_hid_dbg(ihid, ...) dev_dbg(&(ihid)->client->dev, __VA_ARGS__)
>>
>> dev_dbg() depends on the same macro as print_hex_dump_debug().
> 
> I agree with this point. Both dev_dbg and print_hex_dump_debug are noops
> if neither CONFIG_DYNAMIC_DEBUG is set or DEBUG is defined.
> 
> --
> Thanks,
> 
> Rahul Rameshbabu
> 

