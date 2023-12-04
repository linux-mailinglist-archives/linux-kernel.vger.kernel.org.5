Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1088980410D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjLDVli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbjLDVlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:41:36 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2138.outbound.protection.outlook.com [40.107.220.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96E2101
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:41:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih9SW1WmnZfXH/vinxqy58kJdIZq2/6uFoxaVQreEpW39ljoqpYXuZQgtPFdIhP24u2xKbuSRhEDK5x3IunNOiPYMG+KmsXL3dHvsme71eMIEBp3ArfZTzEeKl+l6eapjzDJjYRasxPr7Lp9i/6bafRNJoLDljTEf1zH9X6VyJv/pnNCmvw8f2wlIGFB1OslQZg0eWBIJP0ignp5IUdYVkm1Mv1fYBM04i6HkukX8YVMVtX/yitjgoo3mj0JtwTBtuCwOnTS19p5dz9DcYe8iGYtJSV2vQ+DbNympp1XLFHvOjGxLYtNub4d6nt4lPbebyfVzlz7RdUa0NDC68W6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEB2J76dJXAkUolKsFFFTROXeGLkRpgoPRL7Tuh7Nec=;
 b=QNSZZkObmZUtLXgiAcX2k0aPFrJMxU+fSHVjSd5lSSy4Nrc22eR7IMcxomVMgHUiB2/1tti5es4jpSGl6pWBAZolb49Ya8Q4xA2Q/xWnaXXQwfp8HoMXJSL7G/jMes/udA+i9fyUg8UBcZPfBYWpEeXfNcPgC7rnHsjReV/H0vEPjEucL4QbKtzQKFerdbWnnqDtggUJ2Jd44Wno/RiMGezOGKk3F5bI12j9V8mm5+u0EX57R8BIPHRzu4IRqflc3LslFGcco43XRnOQv0fh629udtifY12eGl8k9RDBN6ZN6tmrlWH5D5KMa+tYrxQPx1ycUJnqIytFKB0Re7ySwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEB2J76dJXAkUolKsFFFTROXeGLkRpgoPRL7Tuh7Nec=;
 b=kCnBKhrDZdMsiFGpgp2v20fY6TMmZj4r8H8kZQTSxIDcF7s1UQvdUVHXdqB6vl/WfmYCr5OUKY6Ixaay4lJtSVYRC1pejn/Pby4eZPamkNlMD5lL/JpmYapkc9ERRZS2nJd6ZEpdw8sWmJ8FH3OvjO4YgSi/hlovMFLV0F4xUcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA1PR01MB8062.prod.exchangelabs.com (2603:10b6:806:335::13) by
 SN7PR01MB7952.prod.exchangelabs.com (2603:10b6:806:34e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.33; Mon, 4 Dec 2023 21:41:37 +0000
Received: from SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::e26f:a461:8f0f:f714]) by SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::e26f:a461:8f0f:f714%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 21:41:37 +0000
Message-ID: <25f46f87-2090-46ca-9ef7-1310b4360801@os.amperecomputing.com>
Date:   Mon, 4 Dec 2023 13:41:32 -0800
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V2] coresight: tmc: Make etr buffer mode user configurable
 from sysfs
Content-Language: en-US
From:   Steve Clevenger <scclevenger@os.amperecomputing.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230818082112.554638-1-anshuman.khandual@arm.com>
 <bedcf27e-b273-075f-3d7b-eb99b07e7c91@arm.com>
 <b2cf0173-c404-d7d6-9eb8-054e160ca4e5@os.amperecomputing.com>
 <ffa90e80-c249-42d5-26f1-dc022d91e5a9@os.amperecomputing.com>
 <391951c3-7da9-3965-acf8-f3b31f822879@os.amperecomputing.com>
 <1b2a035c-489e-ace9-f851-c1ec157ff9fa@arm.com>
 <cc1b1082-2bcb-9d76-afc7-0e12edd694f0@os.amperecomputing.com>
 <f9fddb60-6976-6d99-fcc2-8011d2fadeb7@arm.com>
 <134faf1d-d662-0e26-d9db-c98645ef6243@arm.com>
 <e7b4dce7-7197-0976-c302-a81444b712aa@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <e7b4dce7-7197-0976-c302-a81444b712aa@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:610:75::13) To SA1PR01MB8062.prod.exchangelabs.com
 (2603:10b6:806:335::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8062:EE_|SN7PR01MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c5b228-8d19-4ace-28b1-08dbf511cb0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+CS9bN48eQBtO7qCkT1l3cCSy7+u/tx03zYCu/telp5YU45tQPWNfbmoyFCELZzuuqVAASdeiuLbZ9RJi7j3bGS2qVvC2F4CDx3xFA11YqN/1zZNC16EVtERtQQGuImV5PeNA8chpZEbTcSytBdn0ZMp1uzId65F4IjbLX83QAl/hKctrcwZ84Cx5xlsDJLvFn74IHi1uYovPcs9WedAR2r81yogjY+Tu9WIyP9W3HTiLbNJfgVaoLc5Q5ZVcDlDxSUrsFVbi6/ehUAXZlwJRnfNOxA+7YJcKysH3tdd8cPHQK+fgUMNOiW7EXMxpSFfM6F6VHHCQr0l4qOyUEewHxrklAExY6OeTKRsvQin7T7XlCV2B3Ye0q/HY/Bdi1M/4uNE9N+ybvpUZsLfrnxbPzNaANGACoEdjfFaVqQbtu6+rb7oIY0R+vGGd57hN5wpjo0+mLymYHHGJjSckGM1ENH511+xBVheIy+DwIfnEHSHwfNNitKa4ZPnow4mttyB0o1r9vJByPBu+sMtF8V3y9gQoRMeuZf3RVAE68DQKNe3Y8PRmM0ZW5xd0q7ITSRflzTsW4EjaQkLK3DlmN4LsJ1w88Y8uBiI69K7W8DweA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8062.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(366004)(39850400004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31696002)(5660300002)(86362001)(4326008)(66899024)(3450700001)(8676002)(8936002)(2906002)(7416002)(30864003)(41300700001)(6512007)(6506007)(2616005)(53546011)(6666004)(83380400001)(6486002)(966005)(478600001)(26005)(36916002)(38100700002)(31686004)(110136005)(316002)(54906003)(66476007)(66556008)(66946007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlUwUHlBUjE3R0d2QkFueHgzWG9zdVFhc295VGU5T01BY1VBekcvOHVmQmc5?=
 =?utf-8?B?eCtrZGF5QnJueklyTmEzbEpnQXo5UHdKc2dzdGtqUUpkMnZKZVl3V3hzL1JL?=
 =?utf-8?B?RXlFUXNSTGRUczVDZUlNT2xDd3loZXBUeHg5bWkzT3RUMDBjcmFjNG1zaDZl?=
 =?utf-8?B?d2VRRUF1QWlTbUlMc2ZNT1IzZnJkdzlNZW1ZRUZSZU84QlBVRzhhNnlSUE8z?=
 =?utf-8?B?dFJYWVBTN0JWWG5Hb2hObklRdWlPcXhRdFgzVnE0VTc1ckNYQUo5R1dBbHFJ?=
 =?utf-8?B?VEQrY3pzaGdSRnppZkdQYkVrSERkSmFYQ2lmQkxWV1RqYUh2Uko4UlhJZXRy?=
 =?utf-8?B?MzBoRVJHMzJTb0t1K3VsMG5wa3lDZzg0WEhjcy9wdC9iT1F6bENxYWVCNHdx?=
 =?utf-8?B?by9IeXhsYmdCc1FSOVVWSlJ2bElWckdnSFVTRm90VWlRaWpVOFl3OEJvVVd3?=
 =?utf-8?B?VEtzS0drak9qYStvdXdtNDB3dG14SGFZc3cwR1YyMGhDcmY1RVNBSm8zL2Z4?=
 =?utf-8?B?L0MyS3c3akdnQnd4Q3lpbCsvaE1FV0VTcnJZTE1oVjlJV0YvUmxKbk8rbjdM?=
 =?utf-8?B?b3RsKzhlRzh3MzlPTXA5VWZ2YkZoUFkzc2hvNHFSbVlqTkJidjdjUk9ZTnFR?=
 =?utf-8?B?aFk4eDJCT3BjMVlXeGhIYVVZamdHSDUydmpMVkI5MTJ2WFRrSFk5T3ltOE92?=
 =?utf-8?B?RVdRNVVFbjlZWC9taWNERlA3RW94elh5MHpkNlpjbnNBM09seEpHcVUvcytn?=
 =?utf-8?B?OHFDYnNxNVB1c0hnQ2xjMStldG9JQVdIemVLZkJRVEZKUGpmbHNpYWtQbHBu?=
 =?utf-8?B?a0h4eUxNOTU1NlNGaUtHWERvR2ZiNjV5d1NLSHhYODNKMkh1VGVLZmlRd2pv?=
 =?utf-8?B?dENPTkZKeE93aHo0ZUdpR3M3RHI3UENoeTJiL0JITCthb2ZCN1NOdWtDU0dx?=
 =?utf-8?B?aXUrNDUvK0paN0lTbEtBNXBXTFpndTVJRkxmUWMwTVlDaGlJZEdnTFNqZklu?=
 =?utf-8?B?d2c4VDNMWkNkbkMwM0wyWGhOL0ptbE9JV2FYcmZrbmJ6SzFlOVdLb0ZMRFBP?=
 =?utf-8?B?Wk9xZDJFSHpiTTVEZWdKb2NzM0hkdVVWK0NvY0UzQzlEYmR5aEQ3TkZjS1N6?=
 =?utf-8?B?VTU0Nm5ZMC9UZ1NqOU1WODFZaitkMXRYekJNVVFCbkJWdDBmWFFCNm1vQkg3?=
 =?utf-8?B?cWk1aVo3S05kRENrVHJlUDd6Ym5EeTFzSmRRZFpWTHpRdTZrQUtJNXVuaGNL?=
 =?utf-8?B?M3dFb2x3RWIzdnEwd3ZmajBZWXo2L1J1YTk3U2VsRHM2SHFpMlFnNFFKV1lm?=
 =?utf-8?B?bEhERVppT3NMQThabXRBdjV4VkZkeWl2VkpGVkdzdTBFOHNzVnFnalFZUlcy?=
 =?utf-8?B?WkpEYXhhY0dRQVBWU2RaNHljWWlUdUF2bEhiaFR3Skc1YWE1MVRIbkMzbWZQ?=
 =?utf-8?B?alhBS1UrYWROdWdDQzlqbG1QZGphV1grYU5MY25GbmtDV3BZQ0ZOSXNPa1V2?=
 =?utf-8?B?US9EWWs0bE11TjByN0tYQlNTbXhPS0pibHo1Z1g1aDdVOHhWN1dHTGNVM2F5?=
 =?utf-8?B?R2pYZmJJQnNka0RDUmM1bTkxb1NiK3dBM3NtZ05TdHZJMG1MZUVTQW9ZcEJE?=
 =?utf-8?B?WU1kOFgxeHk2VElvV202RThVNUNpOWFaSzBJM3NhYUJzSW9uWUx4bkhsSXV5?=
 =?utf-8?B?ZU1qUjVVWXg5VGlaQzlETWZYL3FldmIrS3pxN2RsYVFEbnVqOUF5UWNuUXR4?=
 =?utf-8?B?cVBDYkRVdmErd2Z3K1dNVlJsT3ZGVVUxUWF0QzM1dHl1eXJpbXhxN25HNTR4?=
 =?utf-8?B?R3VpOVkxS0Nobmlpc1BqamtQb3paRkl1MXdYek0yOEJlQ0puZkpUREF2RFlU?=
 =?utf-8?B?YytHSGo4L2dzTEgzUDVPbVR4KzB5anIvSGdLUXlPeEFqMzFjUFU0NWh0VkVp?=
 =?utf-8?B?MjJHalZPMXRlVmxZUEZSb05sVkVaWE1HWVZvWWRRZDBFL0ZIazBZMGVxeFhz?=
 =?utf-8?B?UlNaTlZJekxLMENWbnJ4Zm5XMjNSL3hmbE9LTUo0RVNIbzcwUS9RSUVYdlpm?=
 =?utf-8?B?R3l1dlVxOXF0T0U4NEZqa1Y4ZnFzMDB3Y1hOdmFuRGJyTjZST280UUVhTDJT?=
 =?utf-8?B?ekt5bTVEeDNYTHZkNmxoSHZWRERacGM4ckc4bEJreG54a2IrYlM1ZHBQYUYr?=
 =?utf-8?Q?fv5hgIzCHchBqWBICJiHYk2y/HdZ0WfBRa0Wqz9pFXeI?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c5b228-8d19-4ace-28b1-08dbf511cb0d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8062.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 21:41:37.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rG+Mo9gtCQLD7KrjHu7w5do3InXfHL+zZssGVgFvPJqj4ja5tW6Ofg/b8oD1m7iSauWuzb23K6EZRM5deKs8XumEy8HR5OUAhyA974FPzk1+cxqxpPQI1J+EOXP/dehe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB7952
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Suzuki,

On 9/7/2023 2:31 PM, Steve Clevenger wrote:
> 
> Hi Suzuki,
> 
> On 9/1/2023 5:22 AM, Suzuki K Poulose wrote:
>> Hi Steve
>>
>> On 30/08/2023 17:04, Suzuki K Poulose wrote:
>>> Cc: Sudeep
>>>
>>> Hi Steve
>>>
>>> On 28/08/2023 17:35, Steve Clevenger wrote:
>>>>
>>>> Hi Suzuki,
>>>>
>>>> On 8/27/2023 2:35 PM, Suzuki K Poulose wrote:
>>>>> Hi Steve
>>>>>
>>>>> On 26/08/2023 01:14, Steve Clevenger wrote:
>>>>>>
>>>>>> Unfortunately, I tested with the original patch not [PATCH V2]. I've
>>>>>> remedied this. My results below:
>>>>>>
>>>>>> [root@sut01sys-b212 linux]# cat
>>>>>> /sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_modes_available
>>>>>> auto flat catu
>>>>>> [root@sut01sys-b212 linux]# cat
>>>>>> /sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_mode_preferred
>>>>>> auto
>>>>>> [root@sut01sys-b212 linux]# echo "catu" >
>>>>>> /sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_mode_preferred
>>>>>> [root@sut01sys-b212 linux]# cat
>>>>>> /sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_mode_preferred
>>>>>> catu
>>>>>>
>>>>>> As with the V1 patch, auto defaults to catu.
>>>>>>
>>>>>> I expected to see tmc-sg (former default) as an available mode, but do
>>>>>> not. As I recall, the buffer mode defaulted to ETR scatter-gather
>>>>>> prior
>>>>>> to this patch. Must this capability now be explicitly advertised? I've
>>>>>> seen this done as "arm,scatter-gather" in device trees, but not
>>>>>> used by
>>>>>> Ampere. Perhaps someone can enlighten me.
>>>>>
>>>>> Yes, you must add that property to the TMC-ETR node (for both DT and
>>>>> ACPI). In the past, almost all of the TMC-ETRs (except Juno board)
>>>>> locked up the system while using the SG mode (due to the interconnect
>>>>> issues, something to do with the transaction). Thus, we decided to
>>>>> add a property explicitly enabling this for a given platform.
>>>>>
>>>>> When you mentioned, it was using TMC-ETR SG mode, how did you verify
>>>>> this ? Please be aware that the table allocation code etc are shared
>>>>> by both TMC-SG and CATU.
>>>>>
>>>>
>>>> You might recall how this started. I had no way to test the CATU due to
>>>> the order the ETR modes defaulted (Flat, ETR-SG, CATU). For test
>>>> purposes, I programmatically swapped the ETR-SG/CATU order and could
>>>> then verify CATU operation by the driver calling into CATU code. This
>>>
>>> So, were you using the DT based boot for the above runs ?
>>>
>>>> suggests Flat mode was bypassed, and the driver defaulted to ETR-SG
>>>> prior to this hack. This didn't offer the user any control, hence my
>>>> feature request. Note that most of the early Ampere self-hosted trace
>>>> collection used ETR-SG. Now I can't select it.
>>>
>>>
>>>>
>>>> How is this property described in the ACPI? The "ACPI for CoreSight™ 1.1
>>>> Platform Design Document" (DEN0067) doesn't describe this.
>>>
>>> This is not specified in the ACPI platform design document. I can get
>>> it fixed. Ideally we need a property describing that the scatter-gather
>>> mode is safe to use.
>>
>> Looks like this is not straight forward copying of DT property. We are
>> investigating this on our side and will get back to you.

I noticed this work is queued for 6.7 (coresight-next-6.7). Do you have
an update to the ACPI platform design document Ampere can use to base an
update so the scatter-gather mode can be used?

Thanks,
Steve

>>
> 
> The intent behind my request was to have a way to SysFS configure the
> (available) ETR mode. Unless there's a change to the ACPI, the CATU is
> the only SG option for Ampere in the near term.
> 
> Thanks,
> Steve
> 
> 
>> Suzuki
>>
>>
>>>
>>> DT uses "arm,scatter-gather" property [0] and this is what we now expect
>>> in the ACPI based systems too.
>>>
>>> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml#:~:text=71-,72,-73
>>>
>>> Does it sound fine ?
>>>
>>> Suzuki
>>>
>>>>
>>>> Thanks,
>>>> Steve
>>>>
>>>>
>>>>> Kind regards
>>>>> Suzuki
>>>>>
>>>>>>
>>>>>> Steve C.
>>>>>>
>>>>>> On 8/23/2023 4:10 PM, Steve Clevenger wrote:
>>>>>>>
>>>>>>> Here's some quick feedback. My system shows two modes available; auto
>>>>>>> catu
>>>>>>>
>>>>>>> etr_buf_mode_current is writable. I expected to see tmc-sg (former
>>>>>>> default) listed in etr_buf_modes_available but it doesn't show up.
>>>>>>>
>>>>>>> Note that both the auto and catu etr_buf_mode_current settings
>>>>>>> default
>>>>>>> to catu. My understanding is auto should revert to the default
>>>>>>> behavior.
>>>>>>> On my system the default was tmc-sg.
>>>>>>>
>>>>>>> More later.
>>>>>>>
>>>>>>> [root@sut01sys-b212 kernel]# cat
>>>>>>> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_modes_available
>>>>>>>
>>>>>>> auto catu
>>>>>>> [root@sut01sys-b212 kernel]# cat
>>>>>>> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
>>>>>>> catu
>>>>>>> [root@sut01sys-b212 kernel]# echo "catu" >
>>>>>>> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
>>>>>>> [root@sut01sys-b212 kernel]# cat
>>>>>>> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
>>>>>>> catu
>>>>>>>
>>>>>>> Steve C.
>>>>>>>
>>>>>>>
>>>>>>> On 8/21/2023 12:40 PM, Steve Clevenger wrote:
>>>>>>>>
>>>>>>>> Hi Suzuki,
>>>>>>>>
>>>>>>>> I may be able to test it this week. You've already pointed me at the
>>>>>>>> patch thread(s). The main holdup is I need to merge the 6.6 pending
>>>>>>>> platform work in order to use the Ampere ACPI. I couldn't get these
>>>>>>>> patches to apply directly to 6.4 last I tried.
>>>>>>>>
>>>>>>>> Steve C.
>>>>>>>>
>>>>>>>> On 8/18/2023 2:39 AM, Suzuki K Poulose wrote:
>>>>>>>>> Cc: Steve
>>>>>>>>>
>>>>>>>>> Steve,
>>>>>>>>>
>>>>>>>>> Are you able to test this with CATU ?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 18/08/2023 09:21, Anshuman Khandual wrote:
>>>>>>>>>> Currently TMC-ETR automatically selects the buffer mode from all
>>>>>>>>>> available
>>>>>>>>>> methods in the following sequentially fallback manner - also in
>>>>>>>>>> that
>>>>>>>>>> order.
>>>>>>>>>>
>>>>>>>>>> 1. FLAT mode with or without IOMMU
>>>>>>>>>> 2. TMC-ETR-SG (scatter gather) mode when available
>>>>>>>>>> 3. CATU mode when available
>>>>>>>>>>
>>>>>>>>>> But this order might not be ideal for all situations. For
>>>>>>>>>> example if
>>>>>>>>>> there
>>>>>>>>>> is a CATU connected to ETR, it may be better to use TMC-ETR
>>>>>>>>>> scatter
>>>>>>>>>> gather
>>>>>>>>>> method, rather than CATU. But hard coding such order changes will
>>>>>>>>>> prevent
>>>>>>>>>> us from testing or using a particular mode. This change provides
>>>>>>>>>> following
>>>>>>>>>> new sysfs tunables for the user to control TMC-ETR buffer mode
>>>>>>>>>> explicitly,
>>>>>>>>>> if required. This adds following new sysfs files for buffer mode
>>>>>>>>>> selection
>>>>>>>>>> purpose explicitly in the user space.
>>>>>>>>>>
>>>>>>>>>> /sys/bus/coresight/devices/tmc_etr<N>/buf_modes_available
>>>>>>>>>> /sys/bus/coresight/devices/tmc_etr<N>/buf_mode_preferred
>>>>>>>>>>
>>>>>>>>>> $ cat buf_modes_available
>>>>>>>>>> auto flat tmc-sg catu    ------------------> Supported TMC-ETR
>>>>>>>>>> buffer
>>>>>>>>>> modes
>>>>>>>>>>
>>>>>>>>>> $ echo catu > buf_mode_preferred   -------> Explicit buffer mode
>>>>>>>>>> request
>>>>>>>>>>
>>>>>>>>>> But explicit user request has to be within supported ETR buffer
>>>>>>>>>> modes
>>>>>>>>>> only.
>>>>>>>>>> These sysfs interface files are exclussive to ETR, and hence these
>>>>>>>>>> are
>>>>>>>>>> not
>>>>>>>>>> available for other TMC devices such as ETB or ETF etc.
>>>>>>>>>>
>>>>>>>>>> A new auto' mode (i.e ETR_MODE_AUTO) has been added to help
>>>>>>>>>> fallback
>>>>>>>>>> to the
>>>>>>>>>> existing default behaviour, when user provided preferred buffer
>>>>>>>>>> mode
>>>>>>>>>> fails.
>>>>>>>>>> ETR_MODE_FLAT and ETR_MODE_AUTO are always available as preferred
>>>>>>>>>> modes.
>>>>>>>>>>
>>>>>>>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>>>>>>> Cc: Mike Leach <mike.leach@linaro.org>
>>>>>>>>>> Cc: James Clark <james.clark@arm.com>
>>>>>>>>>> Cc: Leo Yan <leo.yan@linaro.org>
>>>>>>>>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>>>>>>>>> Cc: coresight@lists.linaro.org
>>>>>>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>>>>>>> ---
>>>>>>>>>> This applies on v6.5-rc6
>>>>>>>>>>
>>>>>>>>>> Changes in V2:
>>>>>>>>>>
>>>>>>>>>> - Renamed sysfs file etr_buf_modes_available as
>>>>>>>>>> buf_modes_available
>>>>>>>>>> - Renamed sysfs file buf_mode_current as buf_mode_preferred
>>>>>>>>>> - Renamed etr_supports_flat_mode() as etr_can_use_flat_mode()
>>>>>>>>>> - Renamed coresight_tmc_groups[] as coresight_etf_groups[]
>>>>>>>>>> - Reused coresight_tmc_group[] for trigger_cntr and buffer_size
>>>>>>>>>> - Fallback trying ETR_MODE_AUTO when user preferred mode fails
>>>>>>>>>> - Moved ETR sysfs details into coresight-tmc-etr.c
>>>>>>>>>> - Dropped etr_can_use_flat_mode() check while offering
>>>>>>>>>> ETR_MODE_FLAT
>>>>>>>>>> in sysfs
>>>>>>>>>> - Moved struct etr_buf_hw inside coresight-tmc-etr.c
>>>>>>>>>> - Moved get_etr_buf_hw() and etr_can_use_flat_mode() inside
>>>>>>>>>> coresight-tmc-etr.c
>>>>>>>>>> - Updated month in
>>>>>>>>>> Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
>>>>>>>>>>
>>>>>>>>>> Changes in V1:
>>>>>>>>>>
>>>>>>>>>> https://lore.kernel.org/all/20230728084837.276551-1-anshuman.khandual@arm.com/
>>>>>>>>>>
>>>>>>>>>>     .../testing/sysfs-bus-coresight-devices-tmc   |  16 +++
>>>>>>>>>>     .../hwtracing/coresight/coresight-tmc-core.c  |  15 ++-
>>>>>>>>>>     .../hwtracing/coresight/coresight-tmc-etr.c   | 111
>>>>>>>>>> ++++++++++++++++--
>>>>>>>>>>     drivers/hwtracing/coresight/coresight-tmc.h   |   3 +
>>>>>>>>>>     4 files changed, 131 insertions(+), 14 deletions(-)
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Looks good to me.
>>>>>>>>>
>>>>>>>>> Suzuki
>>>>>>>>>
>>>>>>>>>
>>>>>
>>>
>>
