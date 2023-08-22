Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD09783A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjHVGpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjHVGpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:45:17 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC09E9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 23:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7DHBKzobbFxNAPuUNr+iLLl2UMgw9vLUtObj99ggbIEYaMngNsQmUy2I+2b9l/8XGcYPpziNrRcZj920WEScu1xCyiLY3jb/os0Rkh1JokIwVIAehfFlEbt5F8atDF1mzFqydMT6OtPOV/ehgZlzeK7dd4jXkclqsXsxqXPddmpq7SPZdLDO5gBdU6L04lNBMMlGUeI51XfUw6KyJbNG6c2E2B8rIC5CbsgU5BdYfRPE/+g4KXb4D0M0YKG+VxCAXbomJkCtK6zyXKkyYoTCs+ph86J4Iz75LJ0LzpL/Tmxauq3RMigx/77opRNYX40qval6TVuxE6HnhlLZpFyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEiZbvlOEKBi8v9zwRHPNNEURqqM7bVsIa7tLsWSK5g=;
 b=bQiM54eYyohRcamfa7HEHXZOe0k/8TAvmPNDjtmoBXS/sw1v3CW6OI02x2Id6dRsVkh+5Qso8WDe0cJJEJ0kdtcuh7sYZnphJ/XgiG3vSMpi3EGnoW1NR73FRcRh01qST2tHkTMEcGSHBTrrcX5Wb+XFDzPFsIbDMqPOKU9XurIAqQ5Mee8tJmj/nqLfGO1KjW97WHT0GkF3evEro947p6f2cU4ndhQxehkRZAOiF7nzXsIobuIi4sZwZCVY0/TmOX44OkKdHnwGJJZyzFTN9VFTBC3QaXHFRY1zviLYy69n6/DQkfIfz7NHyitJexWElMq6pWIV3KbOlALVv7HMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEiZbvlOEKBi8v9zwRHPNNEURqqM7bVsIa7tLsWSK5g=;
 b=0RByKFGwXzlHaueEiHYQMeBskiV09qiKYFwpdGyakYrLj6zOlCdcONKg8br+UJ0T0zyViCxYKHaYBDYjFsrqL3WHEOyvWdfe0inHfDjeqrODsO2S6zVfcoU5J5Y9WXPxPJIW+lBIRZ853R2QLmLNmttSHssJnTyxrUD0R6pnJYvaCxQ7datwjEJzfrgAvf1sFRcMQfTqIVsR/TfLnzd1TlkyI1WCic7eI4YF80YqITqAQ3BwdmwIRouTgE1bouNlR2lS/bI1EyqleZvMQbZoT64CZwzEiCJI5OaVnZEfulCuTCEFCoai41E7O732d1m74BVQ4ESaSfLv/Buj7PxWxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AS8PR04MB8514.eurprd04.prod.outlook.com (2603:10a6:20b:341::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 06:45:10 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 06:45:10 +0000
Message-ID: <9565380a-4654-f267-c8ac-a4d6ab81156a@suse.com>
Date:   Tue, 22 Aug 2023 09:45:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>, David.Kaplan@amd.com,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
References: <20230821112723.3995187-1-andrew.cooper3@citrix.com>
 <20230821112723.3995187-5-andrew.cooper3@citrix.com>
 <20230821151636.onk2e6tlhmjg5yz5@treble>
 <810fa94b-9417-0076-1232-d263ef882027@citrix.com>
 <20230822022229.xlctyccmgdxiy6ic@treble>
From:   Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH RFC 4/4] x86/srso: Use CALL-based return thunks to reduce
 overhead
In-Reply-To: <20230822022229.xlctyccmgdxiy6ic@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0066.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::43) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AS8PR04MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df0484b-69dd-41ef-e84c-08dba2db549f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jab+AKN6c20DCaTqKVydIZn7nlKcJxDcTQn7Bn1qPBRFGIggTnY/wpJ/HRZ3kZ6ot503oj86bZ+EAT3Gbj4nc4jOFQ0JSw5+FtALDVahKKQT3pK3v7HnpZdAW14DD/UimixR61BcPLBfGEb6eYWcAMAwFxMQWAkyW7fQ8qzovFTQu+b6BJyBxQS7VAM/50ogjrgYfUSVLMaBh9yJHesenVGpFqks5sFdDx19CzIZ5R9g3skoPOqL8vKrsjy3bFvhsFCCKHChBPFP3ml4fzf35aNvXypUeTA8TX71lG4e6srRqtWfC/oUsOEQfLZjTNS34YUNlWYO9bwkQ3g/fCiATjji0x66wUHC4sWAW1hU6me7ywA7/UPrWw2M/eZfPnBzfrIqmxhOeI9UX5j+29rIono3qCKGpP0VWjbpm8z7C7DbcYNFonc9fq4reo9M8V7AQNiXv4myPDLjDYbU5PhoQ/ypY4AwUAugMhj5UrNGZY++HhLc8EaocJdfuWx3EJ1ntCeNyEMJ8FxMtytwo6fEcv6suBz72BZmvinYM1Gnp8wT8ljVvIKTxETxX/zin6H6L9i6q9ZVIQybOEpRd/EZcRnfo+TXR2WBFKVYcJgWwH+gVvo5N/85Ckh/qdkLFJ4C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199024)(1800799009)(186009)(2906002)(7416002)(53546011)(38100700002)(6486002)(6506007)(5660300002)(26005)(86362001)(31686004)(31696002)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(54906003)(66556008)(66476007)(110136005)(966005)(478600001)(6666004)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXVzMGNqU0hTQlVEM1BkT3lLV2lVWTV1Y0ZIaUZDdnJ2djJvRHU2VFdkYW1w?=
 =?utf-8?B?eGI1NEJaei9wS052b1ZsZUhTQUNZUDJpbVc3UHZhSm1ncHhSNElvaDJoMith?=
 =?utf-8?B?bGxwaHpTeGRZdXJKSUF0NGpJQ2NWbnZodlR4NWN5VXhXQ0hDOUpxV2FxbHFh?=
 =?utf-8?B?WlZnaTZIL3M4YmZKVXVnb2J5L056NzRiTUx5Yk85RGVwc1V0L3lMNUlpa1JN?=
 =?utf-8?B?c2VQY29vSWlIQ2QwV2N2eTc1bnppbEFuOHI0NTZoS0w1SVlMM1pRRDZhSE5l?=
 =?utf-8?B?WTQrVHgzalFxYWN1TTJudnVMdnFOMWJ5dExIYlh6akNTcG1keGJremRyQkJo?=
 =?utf-8?B?ZTAxU0VESVowN1l3UE43RmhaU2V2NGhXYVlqZ2QvMEpLak9TZ1daQkhnaFdL?=
 =?utf-8?B?TWhmTk5sUmphQ0xkUFRLOHF5TmdmdW9SbzQ3dWc2N2hNOHRTOHljM0Vlcjdy?=
 =?utf-8?B?MGkwQVEzc1I1WSs1am5YTnNMUTc5bThMdm1CL1Q1NDRaejErTEtTTGRBRlgz?=
 =?utf-8?B?MEdRSm9tYkFKQ3F5dVRTcStxZWtnTDdTcTRiMWNlYm54bzBGSTZSNVRQNG1r?=
 =?utf-8?B?UXFCLy9OaVVxUERLSWpRdzZWVFA2UDZIbWduK2Z5MnpGQmVES2pabyt3NGFL?=
 =?utf-8?B?eDhMUnY2TjlIaHpGVmtkRW1MZXJUQS9OSVQ1a0FzaDI3L3NBUUFFL3RUODcr?=
 =?utf-8?B?NmpleC9QSExNYTA5SG5oZzIzZjNEY0tzOHVrN25DYm4xbTVDeWlxemI0Z1R1?=
 =?utf-8?B?YjFSM3pnNDB0TThRNFc0L2dFS1VSUWZ0OUpUWUVjcU9WdEFHQmVIRitnekFp?=
 =?utf-8?B?elROWXdNTmlobEtGVms3OUYzVlJDT3RuOWJVNHF1bVVUMFFFYU1SbUFxbWdC?=
 =?utf-8?B?cFFFNUpJSnFwenFFSGhtUjJjM1JkMXQxaWNVMGtpWXQ4aFN1UVhjUlNSZE9I?=
 =?utf-8?B?TGM4UGZJVGw2NHBqaXQ5M09lTWdncXEyOFpCNG5BTHdIa0pOdnMzN3U1aHZL?=
 =?utf-8?B?Yk1VUWh1TkllcWt2aFB0LzBuVEhQOFdSUkRBK2lSYUVMdmp3SGdCQXpORG9W?=
 =?utf-8?B?d2RBb24rakgvZ1VqNVNRZXBJUUxJUGU0L2hteGYyT3RSblRYcTEyWFVYWE9U?=
 =?utf-8?B?ZmZveTljNFVwbTF5RzFxOFpMVTYzL1FqZ2tVcVJQbnVvc1ZxdElIZURRd1U4?=
 =?utf-8?B?cnRWbmY1SzE2eUROU0didDFiVU1nK2lscFpQYVRHaEpNOFdmNklVVmNqWUk4?=
 =?utf-8?B?ZlY2VzdVQlNSdnBhNEU5UUFMTHJIVGtKSmI3Ri9GMFBEUmZqY1JWUkxCbjBm?=
 =?utf-8?B?N3FPOHRhVGE4ZHZrQW9hcTNuRjZLemhuQ1p0dm1tOVZ2ZlRDaXBhYXF2UFo5?=
 =?utf-8?B?Qm5RRjBzZTRhREg0VXFZUmN5NG16bXFvVnBNenRSZTNyVjN4VTFsR3JmVmZj?=
 =?utf-8?B?a3FkbzY2ZnJRMG1HbGZqbklITVFrNzJzQVlFY3JBRVVDbmRiNzBnQ2xIc0tU?=
 =?utf-8?B?dkFlUmN6SlRwdkpWZDNMeWNkdzV4ZmlkcEZPRnZOd2Q3cWV4RG9HaktjNzEw?=
 =?utf-8?B?U3ZNR0FKOE55dkVyRExXbE1wZTdzZnpVK3JvK0hCcWVHK2ppejI0VHZwUVQx?=
 =?utf-8?B?SUo2VVVSWGNPVEcwWmtxL3NLdGRlTmhVUW5YN2cxekpiRVRiV21XRmNZTVlS?=
 =?utf-8?B?ellZejZzZGdad3ZVbHVTaDNqYTJBZTJmdzJ3MkFSZzI1dnZGUldybVp2V3Zt?=
 =?utf-8?B?SDV4N3ZBUGxET3RCN09nbVZRNDBQM294cVBRa2xyeXNxTDJHd3VaaE9mUGpP?=
 =?utf-8?B?alhyWkxweGs0N0JSNm9OVncycENacVZ1VGt1d0NKdlZVdzN2dk4rRTZ4STJW?=
 =?utf-8?B?Z1gyTnJ3KzFuM1NnZXN0Ujd3Z1NXVmRvTEVINUFQSUFuV2VFVVh6OGNjbFYw?=
 =?utf-8?B?ZlBSdkRmSmUvUHVVd1VaRzJLZ3k0T1BjVml4SThBZVZ2WGJPMldyMi9FRVJZ?=
 =?utf-8?B?L1pxU1NTZmdseW9Ba3VnQnVEZEtkYTdkYXlXbkZiU1hDeWwrcTF2Y2J4djE4?=
 =?utf-8?B?bmJEZXNtU3Zua25VSnBxMkR0NVpCcDB0RGNLUzNxdU4vcCtDcUR3M0dyenNi?=
 =?utf-8?Q?jltbLjSfXJtDJK48Uht6e18Rl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df0484b-69dd-41ef-e84c-08dba2db549f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 06:45:10.5125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5up/5RksCFpxBHa6tNxOdXwIuofSv7B4Jles5TWOSgIYVoB5yKGIOXm+A7psbqbbINvamIoG7Oz5cSOkiPIFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8514
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.08.23 г. 5:22 ч., Josh Poimboeuf wrote:
> On Tue, Aug 22, 2023 at 12:01:29AM +0100, Andrew Cooper wrote:
>> On 21/08/2023 4:16 pm, Josh Poimboeuf wrote:
>>> On Mon, Aug 21, 2023 at 12:27:23PM +0100, Andrew Cooper wrote:
>>>> The SRSO safety depends on having a CALL to an {ADD,LEA}/RET sequence which
>>>> has been made safe in the BTB.  Specifically, there needs to be no pertubance
>>>> to the RAS between a correctly predicted CALL and the subsequent RET.
>>>>
>>>> Use the new infrastructure to CALL to a return thunk.  Remove
>>>> srso_fam1?_safe_ret() symbols and point srso_fam1?_return_thunk().
>>>>
>>>> This removes one taken branch from every function return, which will reduce
>>>> the overhead of the mitigation.  It also removes one of three moving pieces
>>>> from the SRSO mess.
>>> So, the address of whatever instruction comes after the 'CALL
>>> srso_*_return_thunk' is added to the RSB/RAS, and that might be
>>> speculated to when the thunk returns.  Is that a concern?
>>
>> That is very intentional, and key to the safety.
>>
>> Replacing a RET with a CALL/{ADD,LEA}/RET sequence is a form of
>> retpoline thunk.  The only difference with regular retpolines is that
>> the intended target is already on the stack, and not in a GPR.
>>
>>
>> If the CALL mispredicts, it doesn't matter.  When decode catches up
>> (allegedly either instantaneously on Fam19h, or a few cycles late on
>> Fam17h), the top of the RAS is corrected will point at the INT3
>> following the CALL instruction.
> 
> That's the thing though, at least with my kernel/compiler combo there's
> no INT3 after the JMP __x86_return_thunk, and there's no room to patch
> one in after the CALL, as the JMP and CALL are both 5 bytes.

FWIW gcc's mfunction-return=thunk-return only ever generates a jmp, 
thunk/thunk-inline OTOH generates a "full fledged" thunk with all the 
necessary speculation catching tricks.

For reference:

https://godbolt.org/z/M1avYc63b
> 
