Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8037EF64D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbjKQQhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346121AbjKQQg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:36:58 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2051.outbound.protection.outlook.com [40.107.247.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3306DD79
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:36:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZQJYiLEiy6N2UddRfy0a2ZR9jBHeyqHz+yJlaJ0gIl8k/bOeXzteqDjhx414/l2PjcWWP5Bkd+wxxaukqXKOoKhIzrBi7STdA524vpjLNqKurxvCeGFH0P8/hpAZaS/mFyzsgm5OMGQPXzatg36A1a/B3TkOF5wYzWFJTTpHh0sEtqm6TY00h8/jyXPBg3wscvjCRMlL/pB5dDRHkePcEmwdwUPp0YD+ehP+FXBrCsiRGDTnLEmCEFZSJJdBV+7Htd3igmbcSRkmrVbIEbCttvVhaM+KGggWM/23CRnZ8HLIa5eRPFkt8lCE/yunAcSGsx8oJV5Fa5QPkne9Ep0Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0c8C2TS2GEJJgPc6hKSMwhBS4S3clNHQiSd9/E+Icc=;
 b=ii9mbbfHgmZyvcAVuL+j0fr+JibG4w1zeyGgiTEAvOL19mFrhxjxEUQrZ685z2rntBJIbIP3QMTZrJbvH7lJ04BDxoCgaIGIer7MLwbM2GP3XUHYNt78KZ4LmPxDie/rgK4QUC1e5evtGyrWy+K4+ss3RKKYFe+Tf3T5BucXg0JkDMG+DknYTiMLnn2tJqRuvfHZrlA7ofYD2Bu2Wt+x2KUMDPUDSx9c4/WXiMJ8CdxFeNQpu0HR5ZSvbTE3OZ/7ka/IjenVy8UDSb9P9I4DhnplesDMZgwItnjwim2cNOeDhTdS1a+SBkjfMFctRc8WPlBc8gxYStrTWew8JKjROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0c8C2TS2GEJJgPc6hKSMwhBS4S3clNHQiSd9/E+Icc=;
 b=KtfrHs7PwRXqq6prRc97j0QAHQbbgOY5H5cL2TwCwcJxLTuraiNMmKJ05hAYwC5fjUyikoligLIbHVbDR6CELKTSVWyrHSQDhvdbdoCk7aT4Zq45KBaUESRhZmkUZdhWvJ4U+wr3uA6WNw2EkQn7fp85fI3mVOXV437sx1hkjdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from AS1PR02MB10348.eurprd02.prod.outlook.com
 (2603:10a6:20b:473::13) by DBBPR02MB10793.eurprd02.prod.outlook.com
 (2603:10a6:10:53c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 16:36:46 +0000
Received: from AS1PR02MB10348.eurprd02.prod.outlook.com
 ([fe80::32dc:a85e:a94d:8a7e]) by AS1PR02MB10348.eurprd02.prod.outlook.com
 ([fe80::32dc:a85e:a94d:8a7e%7]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 16:36:46 +0000
Message-ID: <0cee25a2-29f7-4481-8ab9-618f8491bf5b@axis.com>
Date:   Fri, 17 Nov 2023 17:36:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH 1/2] scripts: coccicheck: Return error from
 run_cmd_parmap
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>,
        Anton Eliasson <anton.eliasson@axis.com>
Cc:     nicolas palix <nicolas.palix@imag.fr>, cocci <cocci@inria.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel@axis.com
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
 <20231003-coccicheck-v1-1-07d2d900a52a@axis.com>
 <978265928.4471013.1698960475973.JavaMail.zimbra@inria.fr>
From:   Anton Eliasson <antone@axis.com>
In-Reply-To: <978265928.4471013.1698960475973.JavaMail.zimbra@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0065.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::23) To AS1PR02MB10348.eurprd02.prod.outlook.com
 (2603:10a6:20b:473::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR02MB10348:EE_|DBBPR02MB10793:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a5e188-83ee-4c6e-eb1c-08dbe78b63c9
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kA11kmjbO5CYadlom9GEI7I6sMQvHC8PTuyCaZwlDbXfF+WPGzD+YydKH/bDr7loEfubnjFmg1x6D97N+fWGC3BLjQB1heuEGL6oEjZZ3PMbDD2yWJc78lt1qCpiJ7gOqsXFlD6VZskfdn+ucXK1qXP/WU5qZPMyosMwR/U4s1fBchx38htnq1zUlCFf2mq20YyqRuOqeVgLUvR9HJ5TPq6NweiclwZsWmZ3Q/D/j0LpL+VpIy75Bznrwa1rHrLqvA4YBtCneGR9vqGVuetKL9crPr96IiwBm1rdOkhPTxDdydrX8UVpOtAilICSCgvzzuowbo4lFDypFzZAj40Z4q1q8y9eUCAmpawIE42GXsZTMyYbrP9jUmNDBYYMVrD8jOxbdcH3U4iY3MN9bIx0NteaSKjRwA+RD2yaDA4JR5AwYuQo3dmRICVCawC5ZgKKQLywO9ToyEszpqAAkiQ4w5NWDZeHzd4Hkq76QPL1Gp7KBHQIV0rDgKlfX9Kq1tMeoy/RkIgf/3QRyl2KlGEa1YfpvlbdWj48kj/jo1kNEZv6NaR74FEqePm27lVgRG+FQ+QxBtJ/QcJMdwng3EvvBGdVTwVv77q7LgWA1uowypzyPEI2T2HjHwW/8kTZl2SVmzc+TZxae0tH8VgAKcB0gQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR02MB10348.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(41300700001)(316002)(107886003)(54906003)(66556008)(66476007)(6636002)(36756003)(8936002)(8676002)(66946007)(110136005)(4326008)(38100700002)(478600001)(31696002)(5660300002)(31686004)(6486002)(83380400001)(26005)(6512007)(66899024)(2616005)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFU5dndBSDVFYnF2RTA1Y0hNc0sxdGlpVXhqRGpOeHhLMGF5eVQ4bFhxdVox?=
 =?utf-8?B?MHJpM0V3Nmx1TTlCSnZpNlpLVytnVnkzZnpVOGZmUGVWTFd2RU94NmFZeEZu?=
 =?utf-8?B?TC8xS1JnN1dnT3k4QjhydStNZGZFQ1hKUzY2ZHR4a3ErdnVla1ZvTDVhc1hG?=
 =?utf-8?B?TDZjMHAwd2I5QlA2N3cwMFFpQ0xrNDVYQnVZZ0JCUTA0elhjNmhhd0hGa0dH?=
 =?utf-8?B?OHV6QjVrTVNwZm1heSs4TGluU3dVSmtIMk5Xc3VZdDFhK3ZLUndwUDB1RXhJ?=
 =?utf-8?B?R01ObkZBZFE2N1pBclROWHplMC9xeU0xanYxWG9NRFRnNjVOZ2FkazlUT1R4?=
 =?utf-8?B?OSsyaFgwODYxWTBzY0tYY1AxUi9jRXB3ZCtLNW5VaWNhMktIOWZlY1pzcnVq?=
 =?utf-8?B?aldhV0tmMkRWZDQyQ0Y5QzNIMW05U1d1aS9WTGduNWlOc1NHczhyWjVOK0U3?=
 =?utf-8?B?U2hqdjJFbnprNDh4RzBwVHYydjkwZk1JLzMxcW1iaWJOVks5d2dCU3VYTllL?=
 =?utf-8?B?ZW4rbDd4UmRVeVZ2MTBDTjBUM01PRUJPZ0JmaUkzc3FKSGFnQzdjbE5DTFAx?=
 =?utf-8?B?dXJjdDZ0T290WjZxM1B4YWYzNHdPZDdZUnNLWGEwSEpoKzljNStkZmRJUjFJ?=
 =?utf-8?B?YlBXbDdrS0ljSm5LSlE1bkpjV0g3Vng4UTMrblFPV0lvcThjd0Z3RDhFY1h3?=
 =?utf-8?B?aEcxKytXbUpvK3BYSWErZHRjZEJ1a01tV1U2bzM4MHArZVJMVVlyQ2V1NUJ6?=
 =?utf-8?B?Y2cwdzk0RGJIZm9yanRLendud2RQc0Qza0xaSFM5QkxJUDN6d09CV29Rckgv?=
 =?utf-8?B?SWZXbFZFV0thTnFkQVhZSk01VzM0QXNkOHdQQ1RrUk5yVXFpU24yZWZDZnZi?=
 =?utf-8?B?UUR0czRUdTdXU29UOTVLT0lXalhPdjhFY1pDcXVwL0taQTZrSzdzd25UTGxq?=
 =?utf-8?B?SmxPMms0blBsZkYvVFVveTRhUDl6MklncTR1SVN4T1VmSVZiS1NETUV6MHc1?=
 =?utf-8?B?eTNNZTJaUGg2ZnlYQkdpTkJnZy9LYUgyQ1NUTkdsYnVWOW5DWmplUzVpejZj?=
 =?utf-8?B?VjF2aXQ4RjV5eVcrMTI2eW9MekxJTzNQZEgzUFNlNUd4NlFrMk5GRmZYNTlN?=
 =?utf-8?B?T3dkeU1VL0xtS3ZrTmU5WEJCc1FvcElGSS91bXZjOTBBMSsvRzVkZXdoNjI0?=
 =?utf-8?B?TldkdUtPYzIvQ0g1U0VEcGxtK0kvajNiYjBsTU5xZ09leTRuQ21abzRwYisr?=
 =?utf-8?B?MURMUmFJQ0VxblA5eTdNeDJnL3ByWVhpSkRqVEg0OGZzTDZrRzBZUlNvdzlP?=
 =?utf-8?B?ZDZsSlk3Rm9UbkppNjZ4UUIyeFRQTHZFcGRjenlWSmN6bSthcXQzcHlrWEJH?=
 =?utf-8?B?bHZBcm9FTm9lM1QyaE1oRUJ6TXEvOEQva2h0OEczZWx6OC9mZWVPblpmTTN5?=
 =?utf-8?B?QUI0UmZuNGNaK3NiYVlnSHBIUTZHeld2aExzQ1ZmSHFwSCtjZGRKWmloRzVu?=
 =?utf-8?B?Rk5IOEw2QTM2YjZLQ3JqYWhHam5sNnp0VkpmVVEzSVlRWmNRK2J5OFBTUjFY?=
 =?utf-8?B?UHM2SDJsZ3RaL0ZDMFJFSEdiTEJYUWlrNjZMMVJOUmRycTJjWE1xZW1pc1RZ?=
 =?utf-8?B?cWdxVnNRSTdIejVod1NvTXNEa1RCSk1ETm1zWjVnR3ZNSHU1cmw3MFBrdXFN?=
 =?utf-8?B?SHdaeHFBVEZkTWtYVUtkNFlHT0dYVmlMamtTL1ptRjRZTFRkdmg2Wnhtc3Ey?=
 =?utf-8?B?c1liUkRWYWlCbTRJYnhrWHpWc1R5aSs1NU4wS09jSHhRMW5ZWFFmQnp6ckZ1?=
 =?utf-8?B?TkNqM2YwSTBZR3BsaVFOeGxQT0l3RWlsN0dLbUZ3SzF3Rm9QRjd0QXIvOTBs?=
 =?utf-8?B?YWQvcUVFM3VJOG5qK3FwZE05bHdhVnY5UHA3VjFjWDMyQXFpajM1OXRQSG41?=
 =?utf-8?B?SU5TL2dFeUZkWmJjNlpYbCtDSFhvOGdzSzZCcTZnR1hNMU1PclhTZzFTc2VY?=
 =?utf-8?B?bUpES3NxNy9Cb0hFMjNDc2RKZEJ5UFZyaUlseElRMEhleXA4UElCcXZPQmhy?=
 =?utf-8?B?L1lCRGpwRWFZQUZxSWNFVGdjcXR3WFFaMC9xb055WE10Y3MzN1JCRmhlMzMv?=
 =?utf-8?Q?pxstbpwCRqQHo+CtDOjR/4G33?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a5e188-83ee-4c6e-eb1c-08dbe78b63c9
X-MS-Exchange-CrossTenant-AuthSource: AS1PR02MB10348.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 16:36:46.4751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fxeaptECSxqxBj4lBf0A5umjpTADS9DroLrwD1CDnQ5r4OVx61pj7sGprotNxmt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2023 22.27, Julia Lawall wrote:
>
> ----- Mail original -----
>> De: "Anton Eliasson" <anton.eliasson@axis.com>
>> À: "Julia Lawall" <Julia.Lawall@inria.fr>, "nicolas palix" <nicolas.palix@imag.fr>
>> Cc: "cocci" <cocci@inria.fr>, "linux-kernel" <linux-kernel@vger.kernel.org>, "Anton Eliasson" <anton.eliasson@axis.com>,
>> kernel@axis.com
>> Envoyé: Mardi 3 Octobre 2023 16:25:14
>> Objet: [cocci] [PATCH 1/2] scripts: coccicheck: Return error from run_cmd_parmap
>> Exiting on error breaks the chain mode. Return the error instead in
>> order for the caller to propagate it or in the case of chain, try the
>> next mode.
>>
>> Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
>> ---
>> scripts/coccicheck | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/coccicheck b/scripts/coccicheck
>> index e52cb43fede6..95a312730e98 100755
>> --- a/scripts/coccicheck
>> +++ b/scripts/coccicheck
>> @@ -153,7 +153,7 @@ run_cmd_parmap() {
>> 	err=$?
>> 	if [[ $err -ne 0 ]]; then
>> 		echo "coccicheck failed"
>> -		exit $err
>> +		return $err
>> 	fi
>> }
>>
> I tried disabling OCaml in my version of Coccinelle and then ran make coccicheck with this patch.  But I didn't see any improvement.  On the other hand, it keeps going if I just remove the exit line entirely.  Is that what is wanted?  One can still see the coccicheck failed message.
>
> julia
>
Hi again!

It only makes a difference in chain mode, I think. Without my change 
coccicheck stops after encountering the first semantic patch that 
doesn't support the patch rule (see the console output below). With the 
change coccicheck keeps going with the next semantic patch which is what 
I expect. Do you see a different behavior?

However, I found now that with the change it gets harder to cancel 
coccicheck. A single ctrl-c is no longer enough. I basically have to 
hold down ctrl-c until all the script layers have returned and exited. 
So that's maybe not ideal.

> $ git describe
> v6.6
> $ make coccicheck MODE=chain
> You have selected the "chain" mode.
> All available modes will be tried (in that order): patch, report, 
> context, org
>
> Please check for false positives in the output before submitting a patch.
> When using "patch" mode, carefully review the patch before submitting it.
>
> /usr/bin/spatch -D patch --very-quiet --cocci-file 
> ./scripts/coccinelle/api/alloc/alloc_cast.cocci --no-includes 
> --include-headers --dir . -I ./arch/x86/include -I 
> ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi 
> -I ./arch/x86/include/generated/uapi -I ./include/uapi -I 
> ./include/generated/uapi --include ./include/linux/compiler-version.h 
> --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 14406 files match
> /usr/bin/spatch -D patch --very-quiet --cocci-file 
> ./scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci --no-includes 
> --include-headers --dir . -I ./arch/x86/include -I 
> ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi 
> -I ./arch/x86/include/generated/uapi -I ./include/uapi -I 
> ./include/generated/uapi --include ./include/linux/compiler-version.h 
> --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 44 files match
> /usr/bin/spatch -D patch --very-quiet --cocci-file 
> ./scripts/coccinelle/api/alloc/zalloc-simple.cocci --no-includes 
> --include-headers --dir . -I ./arch/x86/include -I 
> ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi 
> -I ./arch/x86/include/generated/uapi -I ./include/uapi -I 
> ./include/generated/uapi --include ./include/linux/compiler-version.h 
> --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> 2146 files match
> diff -u -p a/fs/direct-io.c b/fs/direct-io.c
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1128,15 +1128,9 @@ ssize_t __blockdev_direct_IO(struct kioc
>      if (iov_iter_rw(iter) == READ && !count)
>          return 0;
>
> -    dio = kmem_cache_alloc(dio_cache, GFP_KERNEL);
> +    dio = kmem_cache_zalloc(dio_cache, GFP_KERNEL);
>      if (!dio)
>          return -ENOMEM;
> -    /*
> -     * Believe it or not, zeroing out the page array caused a .5%
> -     * performance regression in a database benchmark.  So, we take
> -     * care to only zero out what's needed.
> -     */
> -    memset(dio, 0, offsetof(struct dio, pages));
>
>      dio->flags = flags;
>      if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
> /usr/bin/spatch -D patch --very-quiet --cocci-file 
> ./scripts/coccinelle/api/atomic_as_refcounter.cocci --include-headers 
> --very-quiet --dir . -I ./arch/x86/include -I 
> ./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi 
> -I ./arch/x86/include/generated/uapi -I ./include/uapi -I 
> ./include/generated/uapi --include ./include/linux/compiler-version.h 
> --include ./include/linux/kconfig.h --jobs 16 --chunksize 1
> virtual rule patch not supported
> coccicheck failed
> make[1]: *** [/home/antone/git/linux/Makefile:2005: coccicheck] Error 255
> make: *** [Makefile:234: __sub-make] Error 2

