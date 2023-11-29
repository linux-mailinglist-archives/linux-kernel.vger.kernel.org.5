Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60677FD27C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjK2J12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjK2J10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:27:26 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2053.outbound.protection.outlook.com [40.92.98.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F99B9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:27:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhsrnSlTUfgYnvLKCsjd/Ou/YLQtQQOMXkDTSGRAbG5fEFDGvgJ3TS+5/XkdQJz1z40CzgywofNWvV/krSAxYzraJRmpka4YsQ+ATp2W66JjpPW8Kmgt+vftxbDaXTPZWU1wInMcrSXq2Ixm+4XZo+0Ana8RJ2v+xFH3PXlmBzoxmgbmgpcd7wpXeG+ai03GgpdV7+JjGVJ4Cej3oGlg+OHaNtqpPVvSVn2YhvZCXsm+Q97aYeFAjlwuPr/tdFX0nNqN36ClU+wp7XyMqO810j5CUG1fYNwn1JPINDQR1VACZ2fNi9uK/zrC7k3ELbfbB/XD6Q80W2heN4FoEkfMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtaE4133gx1Gp0L6YPYqappdzK/yirUx41H2kTyIWAU=;
 b=BKctucIPPcW3dDvSXgiKnRjdt5r/awzVZ7YdERFKSxoYUoNrugYPpMpfeEKhAs7VWgWLhbUMS5BZnh3t7NcSO9jSlAWbavVERxMw1eNdrgdfftHLg6AEzfHQGNUsJ37Nc0L42FN4AGwF/nnRAzl4X/nXYSPOxKTqTTEg1GZJ2ygs1SGBoPDUV6s0jtN5qUq7vRJJbO369GOKFH1pSgVe9tcqSyFcpq+2OoNHHuyaSTmwFMTzdca6icaegpIbgnTs35G5Xmji3ql4BZoE1i6b+CStBxHEN78dKMaId+aOBjyUMS4X2fjkE0weIRf8eQWevHvAULkHst9JzG+D75QFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtaE4133gx1Gp0L6YPYqappdzK/yirUx41H2kTyIWAU=;
 b=Fjlwmisofpui+U/9qN204TJbp3wPo0gyZJ7AMNJB3mt87NaMnOHP3IYYzqtI/8wmLxpQmUgoFY7Zm45lzFx9ZKvmpHzQbtTbdiPPUDaSRbzfxCMTtVX6b2SZR3Nrbl00YGIGE7lc8NyB8L/VkRD/s5+RQrHh63Ugff/zWEineGH0GpuQL6a3nzdPCDHrqs8IWxn0+Kj89iQPVPlsGczHhlFO4Q9b3A5lvQQHQmXbpdEk+SW83Gly5w/lEgzAfSYKrqXMEOAOL6q7oIiUgEHzUEElz1u+PSfnPEio6zjQq6MoiVeFFt9/k2SdDjTZtuMj5OBGBd2KZ4BcdERkSfXMZw==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by TYVP286MB3101.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:299::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 09:27:29 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a621:9714:c1cf:e4f0]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a621:9714:c1cf:e4f0%7]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 09:27:29 +0000
Message-ID: <TYCP286MB21464057C493F196982232AAC683A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
Date:   Wed, 29 Nov 2023 17:27:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tick/nohz: Remove duplicate between
 tick_nohz_switch_to_nohz() and tick_setup_sched_timer()
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        liupeng17@lenovo.com
References: <20231127083049.145447-1-pngliu@hotmail.com>
 <TYCP286MB21464DF5148B8FF8B142ADF7C6BCA@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
 <ZWYbqwZrP+WfvT/N@lothringen>
From:   Peng Liu <pngliu@hotmail.com>
In-Reply-To: <ZWYbqwZrP+WfvT/N@lothringen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [93H09Il508IWFOLJdIeM+IdyI+UuTupJ]
X-ClientProxiedBy: SG2PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:4:91::18) To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <0f423608-05b6-4366-953e-c0a7f3ded9e4@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2146:EE_|TYVP286MB3101:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b97d38-0a10-4635-39d4-08dbf0bd6827
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phr8Z2gGGhCifpPSIsfpmReFmmmNvYA5kAcGW+4T72JYpYgXPW/SQbnlR7Aaf0Xo5sVblwYo4ht3DG2soWI1YZQmSEW3B4RwzqTYXuUZve5G0eWQqWJq1jJTp3NpQMbPbigw76GujD4PiSsm2L98xa88QXXjbklNvHieIm5QzOZQBXZ5A9P2SBf5bOjsSOBPqnt6uqz2L0kNgovaWb8k+Ulqm8y4FpWuuOYF5phiBYH+7C/iIhtcksHpkChVExBtBJlw+eMliDOgnkahnVXSxaTVj1Jt+GWz/4cprAPRUI6cQC6euPMxwxikhCbl3nx1yuAd+MRWk44FGHeYngSw+v5taDpLWhLdswqa3a9cPFVZ2fI8TkcpZbspoVy5IQyamqiQBM4ZdJ/stCPKcBKSQBE1l+a8n/c6HS13E5DpNniCvNvxMleLEDJQYLaETlLJBnEgCgcrhgRfKKtHrkfqGI8ldoy/8IL3a61fzn3HtsvkP5K6eqz0Cj0urkM2q00ayeXvtowFuflxaNss//LVRCF1D4DhyBHK396ntHFuebvH57GYNmrrD38UKONcH6Sv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TURITHRQUDNSL1M3dUs0eC9MZ3RMMi9qOGNVMStlMFZCNHlOZnFRN09IRFRj?=
 =?utf-8?B?K29mQm1vOUIrbzkwdE1zR0dVM1BEOGtwSDVteHVna0IrYk5MdXRIS2ZtSS9W?=
 =?utf-8?B?VDVMeDE3cml0ejhvNXNhMzdpNm5CZkVNQm4ydTNGNkJCYWhVa3h5UE5HdjlO?=
 =?utf-8?B?OVJ2VFUzU0lxUzRvalNHaW00TFVJRWJnSTA5OTROdzBrQlpkZnQwZmp3MUdt?=
 =?utf-8?B?NFlEeHVINndWVmRNMWNJdENiQnJMQ0M0ZGhMNTlCdWJLbDh4REhoMWlVVUhM?=
 =?utf-8?B?NVpFUTFseUp4NmJPSERqTHNzVW1QbGNYSCtyVzF3MGdvbGxIdzE0dDRmbHNQ?=
 =?utf-8?B?bEF0MzFjTVNMaGFhYTlkd0dRd3FNT2M4dFZKcGNYMWN1RzFXU0NQK0FKU0wv?=
 =?utf-8?B?aEg1MXBsdnFTd1B1VjRoNzBXQ1pVOVBxbjU4UDJrNFJhNlBndlAxRGVXbitk?=
 =?utf-8?B?RVdlRWNCdVJWWkVLRzh6M3ZDMUZFVlBlU21MelZ2YkU3cTYzYlp3OEtUbEcr?=
 =?utf-8?B?RGpRU1ZvdEhNZFRaM3NKOU9RUlprN0g1TWtVNzlaanpOVTBNUkhIbWxKZU9i?=
 =?utf-8?B?YkIrMmZiVHNpM0pyN3VzT01QWFZ6WXRLZXQvUXZDZVQySllIc1VGWjFwL3Y2?=
 =?utf-8?B?UEFmY1UvN2haV0ZaRnBHS3k3Um1KQTBzQURNM2tiYmxHMjVJVFM3dEhWWmlj?=
 =?utf-8?B?UURWZ3JBVHJ6MmlCbEpFNWU2eFFnN3NGODRkcGtzdmtsMnV0M201YVJ2MFlm?=
 =?utf-8?B?SzRrcVVPSDlyajZoMXBlUnVxRjE0dWZsSGFJMHExSkxNZnllcmVXSHNqU3I1?=
 =?utf-8?B?cUFvNkJ2dnVVTTNZYS9TQ1NMbU15MCtpVnMyczkrWmZ4bitLL2ZKNHlxWTly?=
 =?utf-8?B?VUJ4YTlxSUxUbWdla1N6a0xnUXFBcDV4MmZxYlo3S3NkSXZsckp6L05JUU9R?=
 =?utf-8?B?Y0gxR1NiUXo3Umxjdjd3VzNCYUE0Z1RQeXJUNG5CanUvaFdFUW9ocUhCYWhk?=
 =?utf-8?B?R2pDVVMyaS9Ya3FEL2Q4YmJNVnM4TERkcHNjSERVNUJlWC9DZVh5UUxxdTZu?=
 =?utf-8?B?YjhFai94cU5tbGZac2taSHgwZ3Fuak9TNVpYcWpGOG5tSHpiMHh1L0ZBWk1i?=
 =?utf-8?B?L0tYZEo4bTVHbHE1Slo2WU5QVUdrZTMrdE1jZzgzcm1ad3RLcW9zcUtZUnp0?=
 =?utf-8?B?S3RvdnJQQzZXZGdGQ1Zmdm5FOVU4SWIwQ01lcEo5cjBOVHdKSXlNSE9uelN0?=
 =?utf-8?B?U2tWajNUWVhjMy85WFVWUW5TaWlsMUtLb3VvNnhraGsyTzdCZFZVMzNxQjZr?=
 =?utf-8?B?THZReXQydGcvRE1mWjdiVDBrTTNQSldpUlpzY3VscVJQbHlabjVpamR4TGcw?=
 =?utf-8?B?cjB3c3ZUd0EvK2d6ZlMyMzdvTlc1aTI5Vkp6SVdkM0Z3eWM0Tk0zSHNRZ3ZE?=
 =?utf-8?B?RkpTUFhQcjMxR01Uc3Y2eTN3WDR6WGpKRjNXQ0FMemNNMjVGaUJJSU45UG12?=
 =?utf-8?B?OENZOW9PQ3R3NjBpalNwMEtPOS9ma1J6eG9kdXJ2aWQ2UFFQaTN5cFc2d05U?=
 =?utf-8?B?U1BibWUxbmpqSExnTlJES2Uwa25Xdm5OSThoK1JXNUtuQWU2c1VYd3Q2NHcr?=
 =?utf-8?B?K1RFZC8yaEkzM1F4Q3ltc3ZUcGlGU1E9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b97d38-0a10-4635-39d4-08dbf0bd6827
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 09:27:29.3730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3101
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/29 0:56, Frederic Weisbecker wrote:
> On Tue, Nov 28, 2023 at 05:23:54PM +0800, Peng Liu wrote:
>> @@ -1529,7 +1519,9 @@ static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
>>   
>>   	return HRTIMER_RESTART;
>>   }
>> +#endif /* HIGH_RES_TIMERS */
>>   
>> +#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
> tick-sched.c is only ever built if CONFIG_TICK_ONESHOT=y and
> CONFIG_TICK_ONESHOT is basically (CONFIG_NO_HZ_COMMON || CONFIG_HIGH_RES_TIMERS)
>
> So probably the above is not needed and if you like you can even send
> a subsequent patch removing such ifdefs within this file :-)
>
>>   static int sched_skew_tick;
>>   
>>   static int __init skew_tick(char *str)
>> @@ -1542,15 +1534,19 @@ early_param("skew_tick", skew_tick);
>>   
>>   /**
>>    * tick_setup_sched_timer - setup the tick emulation timer
>> + * @mode: tick_nohz_mode to setup for
>>    */
>> -void tick_setup_sched_timer(void)
>> +void tick_setup_sched_timer(int mode)
>>   {
>>   	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
>>   	ktime_t now = ktime_get();
>>   
>>   	/* Emulate tick processing via per-CPU hrtimers: */
>>   	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
>> -	ts->sched_timer.function = tick_nohz_highres_handler;
>> +#ifdef CONFIG_HIGH_RES_TIMERS
>> +	if (mode == NOHZ_MODE_HIGHRES)
>> +		ts->sched_timer.function = tick_nohz_highres_handler;
>> +#endif
> That ifdef could simply be removed.
>
>>   
>>   	/* Get the next period (per-CPU) */
>>   	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
>> @@ -1564,12 +1560,15 @@ void tick_setup_sched_timer(void)
>>   	}
> That invisible part above is the skew_tick thing, which can probably work
> on low-res mode so why not but please tell about that in the changelog.
>
>>   
>>   	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
> Looks like this can be hrtimer_forward_now() and you can remove the now.
>
>> -	hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
>> -	tick_nohz_activate(ts, NOHZ_MODE_HIGHRES);
>> +#ifdef CONFIG_HIGH_RES_TIMERS
>> +	if (mode == NOHZ_MODE_HIGHRES)
>> +		hrtimer_start_expires(&ts->sched_timer, HRTIMER_MODE_ABS_PINNED_HARD);
>> +	else
>> +#endif
> And probably that ifdef could simply be turned to
> IS_ENABLED(CONFIG_HIGH_RES_TIMERS).
>
> Thanks!
Thanks for comments. I will update my patches, and also try removing
(CONFIG_NO_HZ_COMMON || CONFIG_HIGH_RES_TIMERS) in another patch.

Regards,
Peng
