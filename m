Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E2E7C55FB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjJKN6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjJKN6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:58:05 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B452F90
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TT3nK0XBY4ZrtSIEWeRAxl6IignVke9qlbKCq/vN7P5+F6fGZEMYqKdlhBTJ3Xg2uHWQWKJuH3FpAIu0zK0dFYyQTNmWXipM4f8uqjSw43YaOYRTYdhR/RqUXusmypqiGBdDdBILRzJNO8I2fPc4gepXuWWOuTaValR6gZKLrm+WWQgL6nRWbCdPDJQgdDZ4eMOhkWOk4o81XDSVG1xlD1ftheXdYb3RZOnJiW8c+9n4KQ/wxKNMJzP3x1SAQLMWfeu9dmq+Mi/9JGdX1hnYrE1lhwzlP5mEyN/7Z2RXcX79JWOLuo/PsNytWKmEVkKQMwF/8CgJBvGlQafmjV7vMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FCtFBTve7gwWpvT3gJvKrtCRsM/wp2D8FQvxVBjdSs=;
 b=nbK5WZimgL+NXTDqiCuJzyHQ3P8B5qAt4e6+/HYiet8kccQebp6R5aGls2dQmVOk1+RmSc5kmEV3owTW9eVogAd67U6T+mTpUy/TRCa+c3bjcLju7wdQvrYKFu9YJabNtz88ERM7la+f0vIM0TNnAmEMXsW1ZQipONEncQ9Laz6XBnSMC+pJNtXLRzkWbIdL68k6YIfoE/02SwmzDL9iKarQOM7/aA+zxGScuxGfgfC1Ci/u6ABA8xxAtAeFPZkv+WLTtT8ksJ14KdvEoYB3NY5Ot3YEj7iN76BpJaWMM7CpL9scz+wI7hi/bbnhCDYkz36okDN+JxSsITJLAQA98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FCtFBTve7gwWpvT3gJvKrtCRsM/wp2D8FQvxVBjdSs=;
 b=TPsKlQ0BqmTRp4oROTkY5iEycFumrNgX0sCS5cPrjw7O2VTmykzGwcDKHlfH8xwo2mm96FTxx00sIBwPhRjvdMyll3sqFCXkModXfZI7CCVuRLcUHf89elbOrQh+JbV1yAM5KXlgXnevEn7A6KYYZxNkaE4KtIubbQG3l99gV74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from AS1PR02MB10348.eurprd02.prod.outlook.com
 (2603:10a6:20b:473::13) by AM7PR02MB5894.eurprd02.prod.outlook.com
 (2603:10a6:20b:10b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 13:58:00 +0000
Received: from AS1PR02MB10348.eurprd02.prod.outlook.com
 ([fe80::31ee:1e73:e80b:d9ce]) by AS1PR02MB10348.eurprd02.prod.outlook.com
 ([fe80::31ee:1e73:e80b:d9ce%4]) with mapi id 15.20.6838.040; Wed, 11 Oct 2023
 13:58:00 +0000
Message-ID: <d76cafc0-572f-4a5e-b4e0-5baa060a1256@axis.com>
Date:   Wed, 11 Oct 2023 15:57:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH 2/2] scripts: coccicheck: Separate spatch stdout
 and stderr
Content-Language: en-GB
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
        linux-kernel@vger.kernel.org, kernel@axis.com
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
 <20231003-coccicheck-v1-2-07d2d900a52a@axis.com>
 <alpine.DEB.2.22.394.2310072140340.36842@hadrien>
 <5c76da14-e34e-afbd-4265-493c66e0bc60@axis.com>
 <b37c26-154a-2db9-4944-26a8aa8af7af@inria.fr>
 <d6ab6509-9969-4f36-96fe-b6ce6bc74b73@axis.com>
 <e695187c-e83-c844-7f70-7bb9d952569@inria.fr>
From:   Anton Eliasson <anton.eliasson@axis.com>
In-Reply-To: <e695187c-e83-c844-7f70-7bb9d952569@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0009.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::24) To AS1PR02MB10348.eurprd02.prod.outlook.com
 (2603:10a6:20b:473::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR02MB10348:EE_|AM7PR02MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd1d9bd-efac-47d2-ad7e-08dbca6214ae
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hFDGU9yVH1SEQgLP2XOo0AqTuRiphmeTxylKRhZhcO3PXWxCDs94nHx094fQz29n111hTRtCaOwWVkOHtMwDw4S73nN5fv+I0wm0ixCifxoXGuSgVSD8keUYxQFD709nKnNBfZmvhw7o0o1EzSwaf2Hx01aF293XtU6XDntVxgi+sNFiCzr0G2UV1qauLIrgROWWEbMyyhYBldWXP82c5szRzOjvcT4d/KNQXcZ3Sp4KdCxCQAU6w1nNC88kK6v8aXYFf35FUiKneuGOsxj0liexlNa2cIAKYFxjTYfp5wsycsTehNzOfM5kRpB8SzmU9VhKfCnrB5v1biPcyEpVxdG7JKCxAVuMbfX1X0kTboxSh+5jSHT2reLED3T0cUMnha/XcFzo+c3aETiQb6JcaiYf+P2h3S02UJg2nOoSmi75tEbuRTJLclQByXpHtw+WwV4vbf3te488KlojhH3Xcj4OE6pUu/i8nTkQSO4SEs9rEEoL7ZO4pTV7vdAHlgYJVVt3xrDxHXllfYhnU70W+Ado6F3LGUdhOru/yMEiQ/y8uDNNIn71cvgLOuRnV5XSH5Cp2TAljoJRgSauQVYbh2a89jCDoFKDZ7CmiSfaMFMkr/0IW6D68Ew7977o+vUfEBV2/89xYemaOnqpcezfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR02MB10348.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39850400004)(136003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31686004)(83380400001)(107886003)(2616005)(66899024)(26005)(6916009)(66476007)(66946007)(316002)(38100700002)(41300700001)(66556008)(2906002)(8936002)(8676002)(4326008)(44832011)(5660300002)(36756003)(6512007)(6506007)(31696002)(86362001)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGZnMFBCNDBTZk5qV1BLRWRJUm9ZRzV6ejZZZjRleWpodG1qZ3NscThMQ29t?=
 =?utf-8?B?bTlhOXBZakZiZHF5bTdsSXhaaFF0bmtxY3hlNG0rb09GM2NKY1BkamNuaEJM?=
 =?utf-8?B?MVIyWHBIN2ZUOCtra3hKVHY0QmdUUGVCK2FEdXQvd0thSU4xRkF1ZDhzMzJQ?=
 =?utf-8?B?UUZEajFaRWNYNEplYWt2UDhBdTF0WFg4eU82bkxieHZPSGUrRnpxTGNzMi8z?=
 =?utf-8?B?VXpEYllXeTE4ekwxc2s1TFlwaGlzbjBhemF6QVRYMXFITGtiM1VULzBrdVdK?=
 =?utf-8?B?anRwNDFBZFF2SWlNdGttNDcwRzJzZlI5T1NvNkdnd003Vm8rYVVHTVJLY1Bt?=
 =?utf-8?B?M0J1NHZEWDVKTTdmd2ZaZ2M5QXczdGJNT2ZEZGZDYnBnbEVsKzNEUkdERDc3?=
 =?utf-8?B?b21vb3JvaGcxeG1uR2M2YjNHYnJPbk9LYlpHb21vQ0sva1pxUlV5REpKQkdw?=
 =?utf-8?B?dkZpc3E1RDZwR3FnTVhGSVU2OS9qQ0JXRFhzWW9EYVBtczZFc1BjTzBtL3B3?=
 =?utf-8?B?WE1EVGdPY2oyU1d1MmZySDN4ZkNlK2NRNUV1dDdhbzhEMGJEa2RERzl3RGs4?=
 =?utf-8?B?U253dEJVUE9VaVhucWVIUzR2WXRXR1B3d25mOGRBOEpHRnE5TkNPNnhOLzl1?=
 =?utf-8?B?ektiQXJJWGU5TGp6VEt1TW1TdVRLcWJKeUFJK09NRGl5TjNQbVJGREtRbmZx?=
 =?utf-8?B?ZlNpLzd4c0JtRVJySEpuamR4OGlFeDBvdGpETjNuS3JmQSsrdEVETUY0WUo0?=
 =?utf-8?B?czR3YkRxbTF1c2F0V2RORkZmVXp2cTlHSUJmb3pFK3o5cXN1ak9Ra1c3NEFN?=
 =?utf-8?B?YmlxclpHdTE1Q09qMGM0WkdaQnNrWU9UUFhvMmYzd203VTd6ZDBkVHdFaEhH?=
 =?utf-8?B?c29UTHBOZEZPWVBnWVZHcU1kbXkvZEc0R2ZzSDJGODdhcTB5elN4NU5uanhB?=
 =?utf-8?B?anI0Yk1FVTV5RnV6TE1DQ0RsbmpoK0t2VE1scldGUzBrRzBpRSt1OXI2WFRv?=
 =?utf-8?B?TjVCN3QxanYvdFpLUGpNOVlmcEJ6eXV6QlN0YjRiLzBrb3doRHlzbTkyWTMv?=
 =?utf-8?B?RHB0OXpNZzUxMEd0b29LMGp1bzJXSVhVMjUrM21GZVNJdk9lL3NJVEZ0Z2RT?=
 =?utf-8?B?VExoNm85cjRmSWpJazlhN0s0SG55M3h5NXcxV29CVE1uUmFhZEEyeVIzSjZP?=
 =?utf-8?B?c3VSNmVlL1JML1F3bmp6Q1NqMzR4NUs5VjhQYUlRS1k2eStTV1NyaElBc2tr?=
 =?utf-8?B?cVVaeUpuNzV2SHNJcXJMWWF2QWhXRFc1azJrQmhpWmhkZVN4MllScGZnbzFp?=
 =?utf-8?B?SFlqUTNPVWZueHhQcDZGR1E4ajBzVmowNjR0eHlMWXNxOTArQXZrUGkxT3hz?=
 =?utf-8?B?VkxEcXJqdVRRN25OVDhjaUV6L3Z1UkpXaVNKeDR6SzBnMFF3blpEd0Q3dXFs?=
 =?utf-8?B?blVZY2VtUjZubWI3Q210NmZyKzdhaXltNTZCdGpVazlYTm52SU9Od1Q3VEF1?=
 =?utf-8?B?MDZIZEkvYmU4WlhweFp4blpMZW9Qa2cweFQ1OW1MRDR4dm1xSVZCdHpkVzAw?=
 =?utf-8?B?L0tTcW0xUWF3K0hNZW9Bcit1YUQ3TnlBeSs0dm4xYStMY2p2blAzOGFzQmVS?=
 =?utf-8?B?bkVNUnVXSVJrVjUwYURIUTIyMDBTeWgxR0ZaZy9Fdk55K1dJd1A3M0laRzNE?=
 =?utf-8?B?SVBWTFRtSWJNczRYeWh4MFFTd2syTHFtaWIwa3NXK3ZnazVPcURWRDR2UWhs?=
 =?utf-8?B?eWg2a2x3VWc4SGszbnlTb0ViYkRJSXgxL1R6MWMzL2tLb3RTeVVKekN1RG51?=
 =?utf-8?B?bENGb0JUQmE4RkVUdDllcytuVStxdVlzOHB0dFBZa3k2QUhsTTFGU2swbS9w?=
 =?utf-8?B?dFFtRWdFQmJPL1ZZdkZDZE00TzB5U0w5bkVnNUd2cjNUeTBvQU1qTHdReFhX?=
 =?utf-8?B?ZVdOanJzTGdEVWQyWklMbzdmNnk2MnFzUitLd0FTdEtMWmppa3NiS3U3OEVE?=
 =?utf-8?B?cUxSZmpZejZIMlhBd3lYSEFSeDk0UHNDUGdlaDdCRTFnb0tqKzNTQmRrOVlG?=
 =?utf-8?B?N2U2cFc2L0o3R2d0aE9ubDRMaVRNNmsxOFVzNVkvdlpFdVNGdWxOYlJ6THZt?=
 =?utf-8?Q?cOBI=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd1d9bd-efac-47d2-ad7e-08dbca6214ae
X-MS-Exchange-CrossTenant-AuthSource: AS1PR02MB10348.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:58:00.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bvWD00iu7xxDv99GEJ6O6iHUDSeLQmKzCI1q82AVz/XWBePl7z+YczHxA7x0JVe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5894
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2023 15.46, Julia Lawall wrote:
>
> On Wed, 11 Oct 2023, Anton Eliasson wrote:
>
>> On 10/10/2023 18.11, Julia Lawall wrote:
>>> On Tue, 10 Oct 2023, Anton Eliasson wrote:
>>>
>>>> On 07/10/2023 21.41, Julia Lawall wrote:
>>>>> On Tue, 3 Oct 2023, Anton Eliasson wrote:
>>>>>
>>>>>> This helps automating coccicheck runs by discarding stderr and only
>>>>>> looking at the output of stdout. In report mode the only remaining
>>>>>> output on stdout is the initial "Please check for false positives"
>>>>>> message followed by each spatch warning found.
>>>>> What is getting dropped is the spatch command lines indicating the
>>>>> semantic patch.  Is this desirable?
>>>>>
>>>>> julia
>>>> It's not ideal but it's the best compromise that I have found. The problem
>>>> I'm
>>>> trying to solve is to be able to diff the output of two coccicheck runs
>>>> and
>>>> notify the developer if any new warnings were introduced. That requires
>>>> the
>>>> output to be stable. spatch is always invoked for each cocci file in the
>>>> same
>>>> order. However, the output from each spatch invocation is not stable as it
>>>> examines each source file in an arbitrary order.
>>>>
>>>> My workaround is to sort the output before diffing. The line-by-line
>>>> sorted
>>>> output only makes sense if the input is one line per warning found and
>>>> that is
>>>> why I try to discard all output except the single line per spatch warning.
>>>> While the terse output doesn't tell which semantic patch file generated
>>>> the
>>>> warning, it does usually contain the offending file, line number and a
>>>> summary
>>>> of the issue.
>>> Why does the command line pose a problem for sorting?
>>>
>>> julia
>> You're right. I was overthinking it. Since the sorted command lines will be
>> common for the two runs they will disappear after diffing.
>>
>> So at this point I don't have any need for this patch. I'll reach out to you
>> again if it turns out to be an issue after we have gotten the continuous
>> integration check in place. Thanks for the feedback and I'm sorry about the
>> noise.
> OK, thanks for the discussion.  I was also thinking about whether it could
> be possible to make the output always come out in the same order, based on
> the name of the analyzed file.  Maybe it is possible.
>
> julia

Yes, that might help to preserve some context. The difference between 
two runs could be presented as a unified diff instead of just lines 
added. That would probably contain the command line invoking the 
semantic patch that caused the warning, unless there are too many 
pre-existent warnings.


Anton

>
>>
>> Anton
>>
>>>> Anton
>>>>>> Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
>>>>>> ---
>>>>>>     scripts/coccicheck | 4 ++--
>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/scripts/coccicheck b/scripts/coccicheck
>>>>>> index 95a312730e98..7e7c44125f47 100755
>>>>>> --- a/scripts/coccicheck
>>>>>> +++ b/scripts/coccicheck
>>>>>> @@ -146,8 +146,8 @@ run_cmd_parmap() {
>>>>>>                     echo $@>>$DEBUG_FILE
>>>>>>                     $@ 2>>$DEBUG_FILE
>>>>>>             else
>>>>>> -                echo $@
>>>>>> -                $@ 2>&1
>>>>>> +                echo $@ >&2
>>>>>> +                $@
>>>>>>     	fi
>>>>>>
>>>>>>     	err=$?
>>>>>>
>>>>>> --
>>>>>> 2.30.2
>>>>>>
>>>>>>
>>

