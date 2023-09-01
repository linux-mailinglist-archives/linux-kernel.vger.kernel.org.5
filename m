Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042747901C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350479AbjIASCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjIASC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:02:29 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777F2110;
        Fri,  1 Sep 2023 11:02:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS7KVwyIGhhtQqkeJ0+o4GKvuz/0j/Zf4vecDjR583W9l/0vVNkrjyFH1iZPfrhCXmeAP1ZGNMI/+NXa5Em1BqvUMQyg2MBwsZn4t/bVmjh9uc4+DXNsa/SSVAvoejOLNP8vKmcuP8kelDltqXMUaAqaUtulevxWoyK8SO2A2G1lCb6ju2csT667p9qKwGLRku9q5DppoEyGGJHaqcvR6/OLJ2fc9YgGUjuGFQq09SW3gb8OCXlRrZSTICAy6nAKM+HtZBj3QVyaYKchpDbmaV3g56pCAy7owzsMIOzTkG91DqZ80mq/wCk7+jKu0//bJY7M7QN/KNWGZLfN3+fbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2xweyyR24MP/wFl4mccX6mFkn/KkEfK7o8YsgJRuJM=;
 b=OXTWTJrnr+Nk4MqVCvOQ2vGGneVYuBNnC2x19fXDa/SdOqvChadaq7x8tMbWnp5BmYLcMs0CVAappQpblCYO5Ucpyt7E2rE9ZwO4rZTaRK5WhzzTnQvELoHOma6IBABCGUatVBBaKGt69+zLpDmH3k2HwOD6La359V0CHpAhjPbKGzyvViXPIvjYyhLXszSnnsltqXaKkw1bmvHojFjEdChP9Bejih1xLDelA0ecMC2enwxPsRMoNn5BbTfWZVDKkyVvIaHCC7Q63X4XevInKGjQ8J9EGYKmUNTFxTQ6QV/+VS4FeYu5UQDL/tnLXWoMBWAHdRsqmcqOl26rhgwTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2xweyyR24MP/wFl4mccX6mFkn/KkEfK7o8YsgJRuJM=;
 b=tHAQZyE0lMdtBw81QAZDRRlAdjeBejEIJGr24LUKRHM8zkJ92LAPFa3Em3lf+zfN8f33qC6fhw7i8bzu5ktUZEtQ7a/DytrmV+lwa/8kheCm9P/yYxXRX5dYVQ4Px2GqNEmPWNwE8p/twzPLfYcx2ZEkxV+/EwvqiQE46b9ZOvJ9u+ogZB/4vjyHxX42X3iY2YV/N0WAOE6noi3H8MH4xzfHZZ8uIhfSGlUytdO2sGzv5SxASZUQUWgsW07DBn9dxT+RPkA1E/1Hmxk/OfRO/8Ja8bwJ3l55LWK1dYnIZDUcMmm1FZX+SYkvwZ88RsvyDX9e626dG5RZkY6ZDcEQLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DUZPR04MB9981.eurprd04.prod.outlook.com (2603:10a6:10:4d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 18:02:23 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6745.026; Fri, 1 Sep 2023
 18:02:23 +0000
Message-ID: <6a09294e-2c07-585b-336b-20d07e7e08ba@suse.com>
Date:   Fri, 1 Sep 2023 21:02:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch 17/17] x86/fpu: Move FPU initialization into
 arch_cpu_finalize_init()
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>, semenzato@google.com
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.902376621@linutronix.de>
 <ba1b11e5-b3f0-457b-8920-d57d470626c3@roeck-us.net>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <ba1b11e5-b3f0-457b-8920-d57d470626c3@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::13) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DUZPR04MB9981:EE_
X-MS-Office365-Filtering-Correlation-Id: bb83004f-ea47-4344-bc12-08dbab1597a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+2Qovj8t5YxLdA2tBZ5Vlu47dBw/vsKKGSGABvwgmKGMVQKKyAlftv+NlUDgt+WTytMvivQbdDQ54a3t1Bdal2XIAt6/5qVs8ej6MSz8BOVBgp8vXftpIJMEJJs79he53St+y9MrRsmsNOAmGtQPadKKgqjzwvaXPfgrQaiILcWddhvejvFN+QmuERhFc7TQEJBzU/FAN0YPFiKSNoYCGJQRz6hQXPkGs6bsBnXPIwxUTI446vPQRvjHKxdpV2ppH2vK+6eihZpnKcMDC9JR4iNRZLqnxa31diyDemH3DyXts21zgdfY/aA7tJr0MTbi5tXc1j5JM3AJ7MJeoC1D0vAOnh3wM9wWnXtSh5kq8UquWCZb6eZp6vneaRwlJ7hvY1di2YWXsEzRHH70DeAhHDTjeqgE4BQ/NthwSsIeA5uyI4fUEm876yS506zNWjtuVaf3JhvN5YX1YG8LbXBoSzivDbFJ4LPbIMgBbtR9LTmHb4seAndZFnb83CmFAFiBl8mojd1lkqcKiLb/C300p6KceMy4JH2K5uWTaStbiwHmynRatnc9T6cZf6usK27WZ3HBq8cwaLztfwXeMJJqwKZU1lwVR4c1fM6Il40M8wOVb470TZ82OZt4OtUi3qSzxirB72bPvEeVSes/TdTMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(186009)(1800799009)(451199024)(31686004)(36756003)(110136005)(66556008)(66946007)(2906002)(66476007)(316002)(5660300002)(54906003)(4326008)(8676002)(8936002)(7416002)(7406005)(41300700001)(6486002)(6512007)(6506007)(26005)(6666004)(478600001)(2616005)(83380400001)(31696002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVZyRUZMMk9yYlllRDZSOTZjOVRBUmxmTHp1YWVVa0FTTUVZeTZ0M2xrTUNV?=
 =?utf-8?B?bEVtUWlHRk00VXF3SlMrb2xyclgxSys1cUJ6RnV0bzZkdmM3TlRtU05mSW9T?=
 =?utf-8?B?eVNocU1ML1VMTWtGT1NyK2h5ZHRLblJlQmtMdk44OGljSEJBRGNuZy9GY1RD?=
 =?utf-8?B?K2FneElOL091VURKcnZKRFBJYnVnQzhGRERIZ25Nc2gvbGhtb1NDVEYyK2RW?=
 =?utf-8?B?Ynpqd3J0WGE2SnJvWDJWY0tCdllCRG9lTENQRkMvQ0tDY2tjZithaGE1ZEda?=
 =?utf-8?B?a0dlY1F3MFJiU0d4cGVEUUdYTlZaeEtiQ3k0SWlhY3RDM3N6N0lHaENLOVhT?=
 =?utf-8?B?bjVKSzhUaVczdE9iQkdHNS9CNCt0VUgwRk1SZW1EQXBNcGFZRVg4WkVEYkZm?=
 =?utf-8?B?a3ZLaVJLUmVicVh1V045SU0vZjduNVdYUm9zRENPTGdXVHorR1FaS204TzVh?=
 =?utf-8?B?TlhVU1g1cTdOR2EycnJFYlo2U0RiY1U3S3NSZUtQSGtnZkQ1ZVVvU2hGVXkw?=
 =?utf-8?B?SFhEYzZ3eWppRk5lMnFSWEMzSVl0M1VkeC9UQUVHczY2SktobEUvVlp3Mm12?=
 =?utf-8?B?ekJsTTROaUIrenpvT3c4ZlZpMG9JQmhtSUcxNWxEZGJFNVl4bld3eFlqazZR?=
 =?utf-8?B?WldpNDBreWxCWFMwNmhpOTBrT0tvc2tUY2lCSFFEV1cyZGN0Yjk0WlgvNXNw?=
 =?utf-8?B?Zk5udCt1UTQrL0VFNTVBelUvWW43YlZvamlPUDRJSWhxZ3dEWnBRYURJZmJr?=
 =?utf-8?B?aWQ4OG50NE1sOEFMVlBnbkZheitlR1Fpdk9Fb3BGOFRiY1Zsdm9RRTY0dlc2?=
 =?utf-8?B?MTZQK3o0Y0JjQ2lIZGpxUVR5emREVi8zdmR3THpuRHdOM2xMWm1ieUpKMHNp?=
 =?utf-8?B?eWovN1IxOXIxTm1vV2VaY0k0VlNzcXFrR3ppYktPOXk1TUh3V1NkOUhFNjJF?=
 =?utf-8?B?SzdwWE1kblQwT0QwOWN4SnJnVHRpN1NKY2Q2NmlxRUlURXEyMnB1NUpOWjQ0?=
 =?utf-8?B?WTVQdktUTkkyTGsvajl5cUc1SXVydDdXYjFVUmUxYUcyK3NqdUdEbGFMaVhr?=
 =?utf-8?B?NnA1Z3FoUzliUlNtNm1aYk1wMjU2Mzl0b284TnFTUVdlM1EzNHpIcFR1Q1lr?=
 =?utf-8?B?Tng3b0pJS0x0aHc0U211VzVXa3ZhQ3hoaTRGc1R6Y3ovMWFNNnJyMnZHTVoz?=
 =?utf-8?B?SXJvWDNrZzdkQkRkY0pTRFdlNkFOWXhXeUQyVjZ3MXpENDI2NVNuUTZGREk0?=
 =?utf-8?B?b2R3bk1jK3UrUmlGLzBMam85R21KVE5FbC9jNmpZSm5QRXlFcDJ2N3pYY1Rv?=
 =?utf-8?B?dmJuU0FWRzJ3NTdEYmxhbWdZRkdzR0NuSUZCYWVtRDlOUVM1djZIekFhSlpB?=
 =?utf-8?B?dEZybjlXTXp5bDZwZmsvQWFVSUJ6b29YRFdqbU43bG5kQnBNbnUzRnJiRzYr?=
 =?utf-8?B?cm1FMG83dytHN2ZISUdFd2NnWlNsMlRLc0dQdEIzSU9mcmMvVzAxbEhRZzZP?=
 =?utf-8?B?eUg2MFNEZVdRdkg2N3ZOVWgrN1BHUG4xQnFUVElGQ1VQSWl6ZlgyRlJFcVZW?=
 =?utf-8?B?UFNhaG5TN25XUzNDc3FNRDJ2M1hQQ2J5TENjSi9VSWFld2hMUUhhQXY5NWRV?=
 =?utf-8?B?MzFMcE1vZzZ2L0JVb3UxRUNlbnA0MWtvOVVoaVNldWE1YmQzQ3d4QjRlK0Jh?=
 =?utf-8?B?VDZWQU9qWDJxcS8yMGdwUEoxd2VZV0lycW5acXJPWGhVRUQyY1QvQ2lyMXNX?=
 =?utf-8?B?cEhHcWUreGljMmFWT3lOL1ZUZk1HZGVxTm5DR3pVeDJUM2dIWE5sNE9ROS9u?=
 =?utf-8?B?MzV5QnNGNUZBWDhzc2hoOWpLZmJ2V0t4bjNQZTZRL3lNOHQxY0kvR1AwWlc5?=
 =?utf-8?B?RkRKaFJvL2NpWkxrNVh5d1Ewb0lHVHJ6TTJGOUZHS1lnYVlQclVIbzk0b0N4?=
 =?utf-8?B?NDh0NE5LR3RNNzZqRzBTMW5zUXkrd1crdmFkN1Q0WG1XTUpVNUh5QXM2NW05?=
 =?utf-8?B?Rk8vQmJMdGxtRWxTdEhMeHdYK3U2enFGOFErYmhXRDFIMDZ4YlRxU21FSjJI?=
 =?utf-8?B?VCt2RnViNk1hNUJpNE9KcEpDREtGK0QvRWVYN0hUVlF4ODF6SksrSFN2N1JY?=
 =?utf-8?Q?5hvafIPDvEQqG0FCR93XfGa2Y?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb83004f-ea47-4344-bc12-08dbab1597a5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 18:02:23.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJOJHD3ay6BpFCoZZUZ/pB3PF7lGH3xB4OBxQ0DJ3kBJekWgFfCMzAiqli04LcqWl1xMZJiGhS5KsTAd7ewGDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9981
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.09.23 г. 20:30 ч., Guenter Roeck wrote:
> Hi,
> 
> On Wed, Jun 14, 2023 at 01:39:46AM +0200, Thomas Gleixner wrote:
>> Initializing the FPU during the early boot process is a pointless
>> exercise. Early boot is convoluted and fragile enough.
>>
>> Nothing requires that the FPU is set up early. It has to be initialized
>> before fork_init() because the task_struct size depends on the FPU register
>> buffer size.
>>
>> Move the initialization to arch_cpu_finalize_init() which is the perfect
>> place to do so.
>>
>> No functional change.
>>
>> This allows to remove quite some of the custom early command line parsing,
>> but that's subject to the next installment.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> The backport of this patch into chromeos-5.10 and chromeos-5.15 via stable
> relase merges is causing various Chromebooks (not all of them) to crash
> early during boot. Subsequent fixes have not addressed the problem for us,
> so we already reverted the patch from chromeos-5.15 and will revert it
> from chromeos-5.10 as well.
> 
> I don't know if this is a Chromebook specific problem, or if it affects
> mainline, so this is just a heads-up in case others experience similar
> problems.


Another thing - if you choose to revert the arch_finalize patch then 
bear in mind that the GDS' 'force' option is rendered inoperable as the 
FPU can't be disabled due to the way things are sequenced.
> 
> Thanks,
> Guenter
