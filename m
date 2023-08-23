Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B15785057
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjHWGI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjHWGIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:08:24 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2071.outbound.protection.outlook.com [40.107.241.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A989FB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 23:08:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj32mPhnyZrfnVqXJnqhl0nINyd4GetF/NCDMtkgLxmNn3YlnMAlign/BF4Dt5tSNh+eUBSr3uGKXt521nHs/jznsGfVnqhyOZqIOW6XyvlhpYJngtl0niNfNly3iRK803mg78tcOJVBirFyqWEy8jyZbbIGVfhUCKliGy79JE6pvYVavfS+2XX8sa9NmOmELU7Z5JCkykFFHKrjghDgLfcjdhlNiLfLbEcQoOYM+1/abaMETIYwCxaKnRJ5kGqUSHzOJf7G8wgoN89DN6cYD4jsd+1yXxtCkF8FsvCRrDmh56L+8wxHONlj20txiF5MVmYDilC+xFy9qvGto1Qpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxi6qo5pkslrcdKAd+BMc1peNIDoTBs6wUsMBuBbnuA=;
 b=D2KOvRd2b3VnzJU1xAhu7OV0Mic9ZXFofr1rvP6GLDfWav9OTOoA/JyDHAXcHIE+bNOAxcn4GyNM5WfLznniBEqcXyCgGTHTvgXMaXTmv2tZqT319TSU2XzwTLllctlosFOUMWjcp1cpKthvkMwaJN3TnAZjjW4a0/FPoKvI54KzPaPaytIBj7jzWOeqUwuzE0PYw6zla4O9rOwNpp2aen4bcPxmFwsldqwfQ6DmVX/UGVMccB97pGZbN+F/eR1LoVJoQDYpMB6X7qgiiqynXOGYPcSbhupmRveJGyLT/f7wgXJeDLWn/75HccgEgjzrNyuxXF0ll6/I2NLPzJYH5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxi6qo5pkslrcdKAd+BMc1peNIDoTBs6wUsMBuBbnuA=;
 b=kdD+aiOyvPwtCx9NwdwTisneRbHlhlXrcj/Ohj/EwDuSgryayqnc3vZqAroZYSkgOZduxRg9gZ02tZZ8rxz8YBM7NzQe7UF2MkZQ3SsLrmEUdPtVJ3R3wrq4yDh3GyOmSvs1IlDhsmrpp+NaOdzw8LiHBqn3wPbu11TFiXr6BZF74hrjx8prQ2BO34kEPGfLM9sGyq0CYF6Nm3U7Aae6jYlolDx9UtZyV99eGCBhOMamhke7ph8j/F1F0LwIO28Fz/abBYnyDvMyJrc/Zoy35A/lNeawxdjUm1to3RPpN6ziRnwI1TMzGQYEgb9dY2WV66OJT5vvdyBfn5iITRpSRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by GVXPR04MB10024.eurprd04.prod.outlook.com (2603:10a6:150:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 06:08:18 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6699.025; Wed, 23 Aug 2023
 06:08:17 +0000
Message-ID: <d9df6c99-9fc7-f47d-5486-5787503177b5@suse.com>
Date:   Wed, 23 Aug 2023 09:08:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC 4/4] x86/srso: Use CALL-based return thunks to reduce
 overhead
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>, David.Kaplan@amd.com,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
References: <20230821112723.3995187-1-andrew.cooper3@citrix.com>
 <20230821112723.3995187-5-andrew.cooper3@citrix.com>
 <20230821151636.onk2e6tlhmjg5yz5@treble>
 <810fa94b-9417-0076-1232-d263ef882027@citrix.com>
 <20230822022229.xlctyccmgdxiy6ic@treble>
 <9565380a-4654-f267-c8ac-a4d6ab81156a@suse.com>
 <20230822221828.htnwidmr22gtjhcd@treble>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20230822221828.htnwidmr22gtjhcd@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR02CA0057.eurprd02.prod.outlook.com
 (2603:10a6:802:14::28) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|GVXPR04MB10024:EE_
X-MS-Office365-Filtering-Correlation-Id: 72723639-b864-4b45-a4a7-08dba39f57db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEvvB24MnBgIeyZKiYLpl/eQB0Mdgmtu75+7cltrx2y94b0dpp2Rz3kSiqRnbT256SMiIFgMlRN8H2IDPqwn0vb/cGMhI8MHA7d9VKh8bzMzOuz2AK2cfv0VdPgUGJke/E3s/Kh6VPNsg7eSvvUhHVKsUuread/N1VazjtWjf87yJbTeZ0augzGkkpcV/iBt1lt3cIsJq6g/sB1iORqgni+0SfHH1zp2fGH96awdJf6hFfqy4pUYTCpfXkS35NKrFm16ypjUq9NTMgd8YqtRXNAqIOtCm6iZxBFc7eMRrV5prHXx9GUQ4FWXaBbWOHR7pUBDNur5ytNkw+fL6kEWRvR31DcUYsDwJVo3tV86whxoHPIhVF6v0v+iOVM/v3gjrKq4oiXhEaBF51frTurd9hHfC29bMCjRuo14+sQdL2u8gkSFlI2GCmHEYfVkN//xI4MT8MXMFssf16COhsvWELOIJwMsGt4/U8qSpZW+hxAzKWYxPj1zmxrTop62WfupjtV9NJAHychlsaPpj0BS54zxvmi3lBRoQ6OS8cPckXOtVZNzzBxkCDd6XBVgnflypiDFcZAawm3d+cDTAHKJ2fDeCe9kkGX4EFJxNveZMaeFe0zr1yVj6uuVfTBTfpdA9hI75eQBKFMEGDkA/KFUVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(1800799009)(186009)(451199024)(478600001)(966005)(6666004)(6486002)(6506007)(6512007)(41300700001)(2616005)(2906002)(26005)(7416002)(8936002)(4326008)(66946007)(316002)(54906003)(6916009)(8676002)(5660300002)(36756003)(31696002)(66476007)(66556008)(53546011)(86362001)(38100700002)(66899024)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlBmYzBhM0tTQzFxa2VjR0NlRjJjdXJuNEhidzFlTm9wNHF1UnRhcVEwd0Y2?=
 =?utf-8?B?OXRtK2xtQkNIdk1RS1Bjbm5QZUJNT2V0V21uZ1FGZk5HR0RrZkVYbm8xQXlh?=
 =?utf-8?B?N3k2b2sydFBqYWRIVEVNcmF3Mk9oU3dNeHgzYXMwcEJBQStJT1ZydEFOdm05?=
 =?utf-8?B?Sk5QaXpnQkgzNCt6dWZkazNqbjIzUWt3ellsWXgxclV1WWZMYUxaelhIMm10?=
 =?utf-8?B?b05LejBKTHc3c0JxdTZZQ3VGcThjcVhvOGZnRG1TY3JnV1NCWjVGcDRZN3A2?=
 =?utf-8?B?UnFlS3BVaFMrN1NkQVduRTBoSnVWOVIrNi8vNGFuaEt6VFdDOWhzeVlTeDlI?=
 =?utf-8?B?Q2x3bEtJVUFRZm9HY0NrcGQzVGFZb0Y3N0l3S2RMUW1BWkEybktOclVYRnM0?=
 =?utf-8?B?dnk5NUY3dUE1dzV5bUpXeDJZRlR2aGNaZk54NU81VmV4d3p2QUxYVzIvWko4?=
 =?utf-8?B?Z2VrQ2w1LzJaYUpLTHhJaC9iZDF3Ym1IWXRYdlc2SmtycTAwODVzbHJZNlNW?=
 =?utf-8?B?TWdVSmVKKysvVDFMVHBqUTJ0NW5tWnkvQ21yeEdKQVdjSGpwU1FRNnZ6RXls?=
 =?utf-8?B?ZFJZYWM0ODZ1SHBCV2NkSlh1d0JpdGRERjZzaXV3enFxUlVUTWlWYVp6WG1m?=
 =?utf-8?B?TE1iNUhoc3VOZCtxdEZDaW05MDBrdytsdWVjU0FUck5qaEJvdGZ3SGlibEth?=
 =?utf-8?B?QUNoUDBGWkRlRm9tT1RxTWovWXUza1dISjBKV2pzc3FEZCtrT0p3bXhUdzVI?=
 =?utf-8?B?UGVxbHRIaG5GYzRkMENMTExPK2hROHZwcWl3V1RHYWZXUURiY09pTDByRWF3?=
 =?utf-8?B?ckI3Tzh6OUFuTEN5aXJLUkhyTlJpbkNmQk1UT3pVRDVWcG5XcEg2YUc4RC9T?=
 =?utf-8?B?Yi95YXorNlB5UHlUSCs1UDVjUWQzbUwzZEVsZXVZYzB5RWlSK3pPamVyQ0tl?=
 =?utf-8?B?YkFKNWlwb09vdjdDMUlYbUdFV1ZWMHlBdzEzZkNNN1VwbjVYa0swbmZXR240?=
 =?utf-8?B?K0M3RXcrSWpqM3BXTUJXcUF3ZjNCN3Rmb3lzWFFzSFdrMHB1ODZwWDA0RWRL?=
 =?utf-8?B?dEpoUklhemFzdngxbXk3YUtrTGNuOHppOU9KTWUwTURNaVRKUTM2Unp5dDdQ?=
 =?utf-8?B?VFZBcHl2aTlmanU2U0ZXcWdERkI4c3o3eVk5QUdaRlYxTkEvVjIwRHJ6d1NF?=
 =?utf-8?B?OGk0RldTZDNnVWRTZlpHdnF1Wk81QTZnb0I5c2VaUVVhNHAwSTRlYzF3S0Vh?=
 =?utf-8?B?eGdpN056QWFjV0prcFh4VktSMEk5RnhHUXk3NnQ1OEVYeVRJVlVzY3ZoTHRi?=
 =?utf-8?B?Qjd1TENDcHRnUUord3RuYmFrZlNQcURjdlRhT2JOWTM3Q25SakREckc5T2Z6?=
 =?utf-8?B?d3pVblpBVFFnT0xrNUZOd1plMEg3eEppZjU4eUREUjNuWVFMM0tuWlBSbGdo?=
 =?utf-8?B?Zlo0aHFqa29BQWJZeVpQOUdMNnRkV21Pam9nVXhWK3RMcFd0SWE3SDZkd2lo?=
 =?utf-8?B?Z0t1T0R0RXJCNDdCZGVyQjhzQlVwUGVXSTdqM29OWGFkVkNkOHpNbHlnTTVP?=
 =?utf-8?B?M1lZV1BvRVQyaGQrMmhHekdDTXVkRlU5Z0pwQU53VGs2TTlXWHYvM0NQWXNy?=
 =?utf-8?B?R2dFUnFXanBhc205TVEzY1k5MTUvV0hrSTN1K1o2Mm1vcXBTbG9TWFVDeEZj?=
 =?utf-8?B?eDUxcHZGc0RUaUViOTZzNjVNV01ieG12ODdyQ0wrNWtSa1dIMGpicGRZUjBJ?=
 =?utf-8?B?TVJXcmRVM1c4YjlXc3d4YXZtN1I1UU1VOG5TYURpNGdDaHpLZ0xoeXBibXRq?=
 =?utf-8?B?dzE2bUxqbllnMWR0ZTJCdVhrVFNZOSt0c0FoS3dFVGJ4MFZhVjZsQ0dxSjFn?=
 =?utf-8?B?b3lja0VYNUh1dHNGdE1Kc3lwaGsydXp3bnBtdUh5eFpQdUlGL0xVY3QrQTV1?=
 =?utf-8?B?eXJDZGdma2k1N2hmT2dVLzd1NUU0Wm9VdkVPRzdsZ2lseFR5MW10Ynlpc0Uw?=
 =?utf-8?B?eHVMTnA1Q1hWbXN5Z0RqSDY4TmF2S3RsYTZLR0Z1QWNVbmtFSFlGTWVXdFhy?=
 =?utf-8?B?ZkpCWjdmOXlocXF4bWUxWHR2WWhiY1ZyOVZHdDMxR0RjdlphUFZFRU9McFNq?=
 =?utf-8?Q?V1OOuw3HF3IE953RnhFpqAAwl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72723639-b864-4b45-a4a7-08dba39f57db
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 06:08:17.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6jzaOuh4plLMLhnrrBv1i01fBdP4DwfEwlLeicEJk85on93axRlKs94ylFqwfCQ66qY5ePcENzMYF8dl+MMGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10024
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.08.23 г. 1:18 ч., Josh Poimboeuf wrote:
> On Tue, Aug 22, 2023 at 09:45:07AM +0300, Nikolay Borisov wrote:
>>
>>
>> On 22.08.23 г. 5:22 ч., Josh Poimboeuf wrote:
>>> On Tue, Aug 22, 2023 at 12:01:29AM +0100, Andrew Cooper wrote:
>>>> On 21/08/2023 4:16 pm, Josh Poimboeuf wrote:
>>>>> On Mon, Aug 21, 2023 at 12:27:23PM +0100, Andrew Cooper wrote:
>>>>>> The SRSO safety depends on having a CALL to an {ADD,LEA}/RET sequence which
>>>>>> has been made safe in the BTB.  Specifically, there needs to be no pertubance
>>>>>> to the RAS between a correctly predicted CALL and the subsequent RET.
>>>>>>
>>>>>> Use the new infrastructure to CALL to a return thunk.  Remove
>>>>>> srso_fam1?_safe_ret() symbols and point srso_fam1?_return_thunk().
>>>>>>
>>>>>> This removes one taken branch from every function return, which will reduce
>>>>>> the overhead of the mitigation.  It also removes one of three moving pieces
>>>>>> from the SRSO mess.
>>>>> So, the address of whatever instruction comes after the 'CALL
>>>>> srso_*_return_thunk' is added to the RSB/RAS, and that might be
>>>>> speculated to when the thunk returns.  Is that a concern?
>>>>
>>>> That is very intentional, and key to the safety.
>>>>
>>>> Replacing a RET with a CALL/{ADD,LEA}/RET sequence is a form of
>>>> retpoline thunk.  The only difference with regular retpolines is that
>>>> the intended target is already on the stack, and not in a GPR.
>>>>
>>>>
>>>> If the CALL mispredicts, it doesn't matter.  When decode catches up
>>>> (allegedly either instantaneously on Fam19h, or a few cycles late on
>>>> Fam17h), the top of the RAS is corrected will point at the INT3
>>>> following the CALL instruction.
>>>
>>> That's the thing though, at least with my kernel/compiler combo there's
>>> no INT3 after the JMP __x86_return_thunk, and there's no room to patch
>>> one in after the CALL, as the JMP and CALL are both 5 bytes.
>>
>> FWIW gcc's mfunction-return=thunk-return only ever generates a jmp,
>> thunk/thunk-inline OTOH generates a "full fledged" thunk with all the
>> necessary speculation catching tricks.
>>
>> For reference:
>>
>> https://godbolt.org/z/M1avYc63b
> 
> The problem is the call-site, not the thunk.  Ideally we'd have an
> option which adds an INT3 after the 'JMP __x86_return_thunk'.

The way I see it, it seems the int3/ud2 or w/e sequence belongs to the 
thunk and not the call site (what you said). However, Andrew's solution 
depends on the callsite sort of being the thunk.

It seems something like that has already been done for the indirect 
thunk but not for return thunk:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102952
> 
