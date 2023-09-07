Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542CE797DF4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241153AbjIGVb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjIGVb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:31:58 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2097.outbound.protection.outlook.com [40.107.102.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66561BD7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dC7SQvqzx8J9wvXkrWTUalCVHlYB1uKSsAi/qs7YLCgagsInbGdqd4B91y0f8Wn4mh21KxuPxHoVt+6dsT2HpxnoZdBz3cLK5LH/eSF3puiZpS/j6Sg7W6eKNwEY8VKF8Cz3iqRDyrfiyjzIXGplBp+kTxE/SqbGF457MvLLGF/Uzj3JMKRrGqTNVKB87h/+Ks84ngTfIH7YIZx3zhRZ1+3cBe3Xyrwfe5wxaYeg5d1q+87j1CAdWVjzN0lCLTuRavTIX2SK/RJTY0ZF5V/b3e4sEjKOupIuAYb6oGFZNjOJgwCQNA2yzgwC/sTjH0LON+u7kmQUy4nUz+SZw6WXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MLSKgpmNr457NZPYxA8hhaBHM7eCizt/PCmx/YRWZc=;
 b=Ny1+Pp9Eu7EESa8DP/MXizeFRfnIyejQqs2xBBO81yUfQ/lx6Sm1dSWQJsMJSmupo8WUPEEEaQUlxDY0K2VEBUWUUqibCNrxFk6NoKvn0/peG5C5T2KljQy6RXvzzxSNOzPX0f/j6aOUPPPHHkOVIWVhJry0kxJ6LqLPuKurRrCYaSI+4PbIx67xYse6Yh7ZNBet6MF0jmCGUvMuaHbj5fcFCdz/8QBN6aZQGWQXkhTvxoXqqZ1+pfJ0RcbXl4TTCd0s0ifL8QvUG0j0okBSJzVmbz5IV5fe6eMeAbd5g66rV3GpDUim8aeUmlHaTTFExOowmEIIgrCfpVTp2LoHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MLSKgpmNr457NZPYxA8hhaBHM7eCizt/PCmx/YRWZc=;
 b=RDhm2X1l8Ai4aItNVrDKEXx3TGujs4SnQcLJF2KJg/xWzPTJKUmAUYlO4oJBY0Z1g0UoSrf4QoVFHUKHSXTHqs9OO4Df6b5EzOoQvkXIHbiCNht23FDSdgGGaRM9U5vPrhm/XVxkIEBRg9ZIorvt9pftilMl8/UXcmF3pItMd6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA1PR01MB8062.prod.exchangelabs.com (2603:10b6:806:335::13) by
 CH0PR01MB7186.prod.exchangelabs.com (2603:10b6:610:f8::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.36; Thu, 7 Sep 2023 21:31:50 +0000
Received: from SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::ecb8:39f9:1677:39c5]) by SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::ecb8:39f9:1677:39c5%5]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 21:31:50 +0000
Message-ID: <e7b4dce7-7197-0976-c302-a81444b712aa@os.amperecomputing.com>
Date:   Thu, 7 Sep 2023 14:31:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V2] coresight: tmc: Make etr buffer mode user configurable
 from sysfs
Content-Language: en-US
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
From:   Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <134faf1d-d662-0e26-d9db-c98645ef6243@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:610:11a::7) To SA1PR01MB8062.prod.exchangelabs.com
 (2603:10b6:806:335::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8062:EE_|CH0PR01MB7186:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d248450-cd36-4bca-3e6b-08dbafe9d873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9M4Fd/EZ6q+AI5ofEHLHYt6ae0QN4pcElkbIh9l0WT6hUrjXMvHc9MTkzRYVkhyig4ih1EYSVJBc/IxYS/sfKk4XiGiI4bm/LtcvArIjp8ODsIMUz1KUjroezX4dxK8t521DY/pWpUfcC8FLpUqZgMUw0i49w2UcRk4Nj0sGkM8Jz/4Qx1aWQaxabg1pRZ+y8xZwuT7XiFz/Y8CX58Nse9174fFE8ga2aNoWrxsx04bRV/mDFuSWhPChSWut+c4Hx94CzNvZlakkvt84jrQ3S8Q8NR0IvjcRsotnvoqxyyzZYsbEInjJh1kunrvToNkqfOimQEUvtu8GELO8yzvG9siM7g9RxuOKldS9ioLNs6ufmjxiDL3SbC02QakIQdOJNKNPemi9sB/aDqgWq255mS2y86qtWU7UTUHk/+XV8ImqRgbLqQnjAJ0LAJGG7pT25tAc6+dpGg5VbvmtVk1pLEQN9El8/4iNJNtJsRZfJAKI6wYVt1P4o1SR07eCQM22eAQdz2JbezX0MeETHlxEesf7p9lWH9tvaGMl8BIY95WHX4aoKnHIBFfHWZaFDWxtMQeQC8ekb57urJdIUgegz3qKR218AoNRhB5bY4oasSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8062.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39850400004)(136003)(366004)(396003)(451199024)(1800799009)(186009)(31686004)(66476007)(54906003)(316002)(2616005)(6666004)(86362001)(110136005)(66946007)(31696002)(66556008)(2906002)(8676002)(41300700001)(4326008)(8936002)(3450700001)(7416002)(5660300002)(38100700002)(66899024)(966005)(478600001)(6512007)(26005)(6506007)(6486002)(36916002)(83380400001)(53546011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2VJRHJ5dkdxUk45eGd2cDVHT2EwSUhZL2ZyWlNFelZSWFl6UTUxR3g4OEsy?=
 =?utf-8?B?cHVXb0JwQU5oV1pDMXJKK25vNHFQUXVGLzNQQkVkRVUwcTROWlF2VnB4MEQy?=
 =?utf-8?B?bHhxSnZET0xhbHczUDhnekw1V1pSK3pQcUZYUlcyY2p3L0ZOaXZSam1KeVJJ?=
 =?utf-8?B?b0dHM0JwSVZUZUsvMlY3ZDQ2VVZac2RDSmxwVmRxWllhVy91Mmt6STl0VHJ1?=
 =?utf-8?B?QUNXQWpoZisrQUVFMlo5MmYrSmNKZzJQWWR0cHZWZzBlUytVTEYzRDhpMm0r?=
 =?utf-8?B?UjM5Y2x4SFdqU1dkaFk5SCttQ1hEOGFlWmV5ZTdZd2FLcEp6Ym1HeUdCSCs0?=
 =?utf-8?B?THlDTXNIaE9DNnNXS0lwbXpEbnFoNFJLNkNTR2FoRVRSUmwxVXI2NFdrcGRk?=
 =?utf-8?B?VUx4b3N0anJKUW1RdHlna1RrbWV1YTE5TjNPL3d5SnpIekYzUU0wbGNOcm1h?=
 =?utf-8?B?V3dmRWdCRzNrbGp5Z3ljNFhmdEVFMWVoajgra0U1bTVDWWlsQVJIOFBZUEQx?=
 =?utf-8?B?T0R1S09mM2RvYThRVWx6U3NpWEFYUEhVajdlVFJLWFRLaVVSck5vaGlFenpu?=
 =?utf-8?B?Qk5RdXp0bFpBNXppR01SSlRYOHh5TG9RQlVpTGdNVEdPNllyQXRYeWtpOGZP?=
 =?utf-8?B?Q2VSY29YQlVFQVV0QkIxb1AzcllWQVRpaFlZSjd5d043QTlJV1ZkNzRpUElB?=
 =?utf-8?B?djF6UzVxRUxYRG90Lzc2T1Z1VXUxUm84bWtQUkkybkdDblNTUVRMSTd3cm1j?=
 =?utf-8?B?QklaWEVCUnRSTDQvcWI4K0N6clpNVkZJNkxmMjN3clZSQm0wckhrb2NOT1pB?=
 =?utf-8?B?WmFhcXpNa25zeld2ak9qUUtvUFdFQWcvV3lhL3FITHlwQXJNRmVPZzhCaGVs?=
 =?utf-8?B?WVIySmU5eTcwam0xNC9JQVJFZkpOUDVCRzMwd1pnRU5wVEZCSVBRck5iUFU1?=
 =?utf-8?B?NHVydm5RNThqNkZYN0NqSmRoNUJ6Q1YzaWU3NFZDbkRCR25Zb0xaL28ycklv?=
 =?utf-8?B?Y0NIRmhmZFNteDllSnZtZlk2QjFmdWVmcVkxVnoxSjA0RTRqWGlzbmlmU21I?=
 =?utf-8?B?OEFDczVGOSt6MjM3T0ZCRnFSOVF0d0w0OUg5T2tmam1ISTIvaVJsQ0RvQ2tU?=
 =?utf-8?B?UW5JeERPSmtlZEVCM1N1VXZGbWhESUxjS0tQeEovK0MwQVJSOWl1Yk1MYWtT?=
 =?utf-8?B?ZXFDUVFNQmttTUlyQXFLbE5Oc01rTTlrZHJSTURhSHI4dlpKUThwWjhxdTVR?=
 =?utf-8?B?NmNkWlY1Q3lQWlJVa1E1N1VVdWtHZ25scUx5TlRONnp6MmhISEZqOEd1dkRo?=
 =?utf-8?B?VThEYmZCbXNUbkxnNUJKNlp5VHY4bmc4RVVzd1JqVmtBTnRUWUZsTnh5MXVp?=
 =?utf-8?B?M1VSWmNKRFFDWWZ2eDFGU2tkZTdhdktiSnljR2dDMXBHb3ZmdFNwdDdCMG5E?=
 =?utf-8?B?MVMyZmRpZU5MSUpjYWJGTm1IZE9oK2ZPV0orNXpvVXROQmQ2Ti9iQTBrUDBF?=
 =?utf-8?B?eDhpeXdkdmF0bzdkOWFiL2syWXZxY2J6bmZvK0Z4c2ZNRU9zUU9uOWRRZU93?=
 =?utf-8?B?WHE3RkVONjR2KzE4S0ZhVUNXSUtuZUtqMUJXWWw2K05peHZpUGFDVUFvVUpo?=
 =?utf-8?B?L2pPZXhDYVV3eS9hV0hhd21uQi9QUjFyS1czQWhDTU82RldMT0F5M3AwbVJX?=
 =?utf-8?B?TUY0NDFVc1BLdGFQUlZLUzdMS3JpcW8zSDQrNFMxS1pTc21QR1VRMGR3Umpm?=
 =?utf-8?B?RGl5d2NlQTdJb0pDaGNaVVdhTk10RmlRRFRwZW9rNHhMeUI2Vnp3ZzlSM2h4?=
 =?utf-8?B?NUI4ckpkcXZIK2hYUzcyUERoaHNEYmozaXhpOWdrMnZVd3dWWGZzTXBES2Ra?=
 =?utf-8?B?ZHVKNWtJcjQ5S3ZjZFBVOVBEZGRuMWptWHFoWUlNRkJGNnNsY0pkZlRCTzdp?=
 =?utf-8?B?VldHZFduS29ydFpDcGZRTCtHcXQ0bElmcWxzNmZlZ3p0Z0Z6T01Lc1BlZGVm?=
 =?utf-8?B?M0hHVWszckRoTEdHMU44S1paR3IwNDh5STFidi9RZHJnZkNGbDJCdllVR0cv?=
 =?utf-8?B?ai9DWFBWaWFVeEZhOGhFK0d2bWdOT2tqNlV2Qk9sOTFwWE9HUThWMG5jOXJO?=
 =?utf-8?B?N3NDU1lFaXF1b0lreGZUVUtYeU9ac3QrdDl2emlWMEpJTzV4WFg1TXU4MkF2?=
 =?utf-8?Q?N+PPib1Sdl8z5iGsEhDB9HIKtvUawn4MJKeaTGcT2rWg?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d248450-cd36-4bca-3e6b-08dbafe9d873
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8062.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 21:31:49.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SopF9KDW+RtzBg23/o9iF8dCUf+b2Ph2o3ZGbUv+G3lIeMUP2qDdBfat/M/lDRTKkWuE5iggMPz1DnpeFBwpxxi98ZRKtC9/aMVEB5x39M//Qh1B4Y24NmmWyYoB4Fqq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7186
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Suzuki,

On 9/1/2023 5:22 AM, Suzuki K Poulose wrote:
> Hi Steve
> 
> On 30/08/2023 17:04, Suzuki K Poulose wrote:
>> Cc: Sudeep
>>
>> Hi Steve
>>
>> On 28/08/2023 17:35, Steve Clevenger wrote:
>>>
>>> Hi Suzuki,
>>>
>>> On 8/27/2023 2:35 PM, Suzuki K Poulose wrote:
>>>> Hi Steve
>>>>
>>>> On 26/08/2023 01:14, Steve Clevenger wrote:
>>>>>
>>>>> Unfortunately, I tested with the original patch not [PATCH V2]. I've
>>>>> remedied this. My results below:
>>>>>
>>>>> [root@sut01sys-b212 linux]# cat
>>>>> /sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_modes_available
>>>>> auto flat catu
>>>>> [root@sut01sys-b212 linux]# cat
>>>>> /sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_mode_preferred
>>>>> auto
>>>>> [root@sut01sys-b212 linux]# echo "catu" >
>>>>> /sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_mode_preferred
>>>>> [root@sut01sys-b212 linux]# cat
>>>>> /sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_mode_preferred
>>>>> catu
>>>>>
>>>>> As with the V1 patch, auto defaults to catu.
>>>>>
>>>>> I expected to see tmc-sg (former default) as an available mode, but do
>>>>> not. As I recall, the buffer mode defaulted to ETR scatter-gather
>>>>> prior
>>>>> to this patch. Must this capability now be explicitly advertised? I've
>>>>> seen this done as "arm,scatter-gather" in device trees, but not
>>>>> used by
>>>>> Ampere. Perhaps someone can enlighten me.
>>>>
>>>> Yes, you must add that property to the TMC-ETR node (for both DT and
>>>> ACPI). In the past, almost all of the TMC-ETRs (except Juno board)
>>>> locked up the system while using the SG mode (due to the interconnect
>>>> issues, something to do with the transaction). Thus, we decided to
>>>> add a property explicitly enabling this for a given platform.
>>>>
>>>> When you mentioned, it was using TMC-ETR SG mode, how did you verify
>>>> this ? Please be aware that the table allocation code etc are shared
>>>> by both TMC-SG and CATU.
>>>>
>>>
>>> You might recall how this started. I had no way to test the CATU due to
>>> the order the ETR modes defaulted (Flat, ETR-SG, CATU). For test
>>> purposes, I programmatically swapped the ETR-SG/CATU order and could
>>> then verify CATU operation by the driver calling into CATU code. This
>>
>> So, were you using the DT based boot for the above runs ?
>>
>>> suggests Flat mode was bypassed, and the driver defaulted to ETR-SG
>>> prior to this hack. This didn't offer the user any control, hence my
>>> feature request. Note that most of the early Ampere self-hosted trace
>>> collection used ETR-SG. Now I can't select it.
>>
>>
>>>
>>> How is this property described in the ACPI? The "ACPI for CoreSight™ 1.1
>>> Platform Design Document" (DEN0067) doesn't describe this.
>>
>> This is not specified in the ACPI platform design document. I can get
>> it fixed. Ideally we need a property describing that the scatter-gather
>> mode is safe to use.
> 
> Looks like this is not straight forward copying of DT property. We are
> investigating this on our side and will get back to you.
>

The intent behind my request was to have a way to SysFS configure the
(available) ETR mode. Unless there's a change to the ACPI, the CATU is
the only SG option for Ampere in the near term.

Thanks,
Steve


> Suzuki
> 
> 
>>
>> DT uses "arm,scatter-gather" property [0] and this is what we now expect
>> in the ACPI based systems too.
>>
>> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml#:~:text=71-,72,-73
>>
>> Does it sound fine ?
>>
>> Suzuki
>>
>>>
>>> Thanks,
>>> Steve
>>>
>>>
>>>> Kind regards
>>>> Suzuki
>>>>
>>>>>
>>>>> Steve C.
>>>>>
>>>>> On 8/23/2023 4:10 PM, Steve Clevenger wrote:
>>>>>>
>>>>>> Here's some quick feedback. My system shows two modes available; auto
>>>>>> catu
>>>>>>
>>>>>> etr_buf_mode_current is writable. I expected to see tmc-sg (former
>>>>>> default) listed in etr_buf_modes_available but it doesn't show up.
>>>>>>
>>>>>> Note that both the auto and catu etr_buf_mode_current settings
>>>>>> default
>>>>>> to catu. My understanding is auto should revert to the default
>>>>>> behavior.
>>>>>> On my system the default was tmc-sg.
>>>>>>
>>>>>> More later.
>>>>>>
>>>>>> [root@sut01sys-b212 kernel]# cat
>>>>>> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_modes_available
>>>>>>
>>>>>> auto catu
>>>>>> [root@sut01sys-b212 kernel]# cat
>>>>>> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
>>>>>> catu
>>>>>> [root@sut01sys-b212 kernel]# echo "catu" >
>>>>>> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
>>>>>> [root@sut01sys-b212 kernel]# cat
>>>>>> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
>>>>>> catu
>>>>>>
>>>>>> Steve C.
>>>>>>
>>>>>>
>>>>>> On 8/21/2023 12:40 PM, Steve Clevenger wrote:
>>>>>>>
>>>>>>> Hi Suzuki,
>>>>>>>
>>>>>>> I may be able to test it this week. You've already pointed me at the
>>>>>>> patch thread(s). The main holdup is I need to merge the 6.6 pending
>>>>>>> platform work in order to use the Ampere ACPI. I couldn't get these
>>>>>>> patches to apply directly to 6.4 last I tried.
>>>>>>>
>>>>>>> Steve C.
>>>>>>>
>>>>>>> On 8/18/2023 2:39 AM, Suzuki K Poulose wrote:
>>>>>>>> Cc: Steve
>>>>>>>>
>>>>>>>> Steve,
>>>>>>>>
>>>>>>>> Are you able to test this with CATU ?
>>>>>>>>
>>>>>>>>
>>>>>>>> On 18/08/2023 09:21, Anshuman Khandual wrote:
>>>>>>>>> Currently TMC-ETR automatically selects the buffer mode from all
>>>>>>>>> available
>>>>>>>>> methods in the following sequentially fallback manner - also in
>>>>>>>>> that
>>>>>>>>> order.
>>>>>>>>>
>>>>>>>>> 1. FLAT mode with or without IOMMU
>>>>>>>>> 2. TMC-ETR-SG (scatter gather) mode when available
>>>>>>>>> 3. CATU mode when available
>>>>>>>>>
>>>>>>>>> But this order might not be ideal for all situations. For
>>>>>>>>> example if
>>>>>>>>> there
>>>>>>>>> is a CATU connected to ETR, it may be better to use TMC-ETR
>>>>>>>>> scatter
>>>>>>>>> gather
>>>>>>>>> method, rather than CATU. But hard coding such order changes will
>>>>>>>>> prevent
>>>>>>>>> us from testing or using a particular mode. This change provides
>>>>>>>>> following
>>>>>>>>> new sysfs tunables for the user to control TMC-ETR buffer mode
>>>>>>>>> explicitly,
>>>>>>>>> if required. This adds following new sysfs files for buffer mode
>>>>>>>>> selection
>>>>>>>>> purpose explicitly in the user space.
>>>>>>>>>
>>>>>>>>> /sys/bus/coresight/devices/tmc_etr<N>/buf_modes_available
>>>>>>>>> /sys/bus/coresight/devices/tmc_etr<N>/buf_mode_preferred
>>>>>>>>>
>>>>>>>>> $ cat buf_modes_available
>>>>>>>>> auto flat tmc-sg catu    ------------------> Supported TMC-ETR
>>>>>>>>> buffer
>>>>>>>>> modes
>>>>>>>>>
>>>>>>>>> $ echo catu > buf_mode_preferred   -------> Explicit buffer mode
>>>>>>>>> request
>>>>>>>>>
>>>>>>>>> But explicit user request has to be within supported ETR buffer
>>>>>>>>> modes
>>>>>>>>> only.
>>>>>>>>> These sysfs interface files are exclussive to ETR, and hence these
>>>>>>>>> are
>>>>>>>>> not
>>>>>>>>> available for other TMC devices such as ETB or ETF etc.
>>>>>>>>>
>>>>>>>>> A new auto' mode (i.e ETR_MODE_AUTO) has been added to help
>>>>>>>>> fallback
>>>>>>>>> to the
>>>>>>>>> existing default behaviour, when user provided preferred buffer
>>>>>>>>> mode
>>>>>>>>> fails.
>>>>>>>>> ETR_MODE_FLAT and ETR_MODE_AUTO are always available as preferred
>>>>>>>>> modes.
>>>>>>>>>
>>>>>>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>>>>>> Cc: Mike Leach <mike.leach@linaro.org>
>>>>>>>>> Cc: James Clark <james.clark@arm.com>
>>>>>>>>> Cc: Leo Yan <leo.yan@linaro.org>
>>>>>>>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>>>>>>>> Cc: coresight@lists.linaro.org
>>>>>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>>>>>> ---
>>>>>>>>> This applies on v6.5-rc6
>>>>>>>>>
>>>>>>>>> Changes in V2:
>>>>>>>>>
>>>>>>>>> - Renamed sysfs file etr_buf_modes_available as
>>>>>>>>> buf_modes_available
>>>>>>>>> - Renamed sysfs file buf_mode_current as buf_mode_preferred
>>>>>>>>> - Renamed etr_supports_flat_mode() as etr_can_use_flat_mode()
>>>>>>>>> - Renamed coresight_tmc_groups[] as coresight_etf_groups[]
>>>>>>>>> - Reused coresight_tmc_group[] for trigger_cntr and buffer_size
>>>>>>>>> - Fallback trying ETR_MODE_AUTO when user preferred mode fails
>>>>>>>>> - Moved ETR sysfs details into coresight-tmc-etr.c
>>>>>>>>> - Dropped etr_can_use_flat_mode() check while offering
>>>>>>>>> ETR_MODE_FLAT
>>>>>>>>> in sysfs
>>>>>>>>> - Moved struct etr_buf_hw inside coresight-tmc-etr.c
>>>>>>>>> - Moved get_etr_buf_hw() and etr_can_use_flat_mode() inside
>>>>>>>>> coresight-tmc-etr.c
>>>>>>>>> - Updated month in
>>>>>>>>> Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
>>>>>>>>>
>>>>>>>>> Changes in V1:
>>>>>>>>>
>>>>>>>>> https://lore.kernel.org/all/20230728084837.276551-1-anshuman.khandual@arm.com/
>>>>>>>>>
>>>>>>>>>     .../testing/sysfs-bus-coresight-devices-tmc   |  16 +++
>>>>>>>>>     .../hwtracing/coresight/coresight-tmc-core.c  |  15 ++-
>>>>>>>>>     .../hwtracing/coresight/coresight-tmc-etr.c   | 111
>>>>>>>>> ++++++++++++++++--
>>>>>>>>>     drivers/hwtracing/coresight/coresight-tmc.h   |   3 +
>>>>>>>>>     4 files changed, 131 insertions(+), 14 deletions(-)
>>>>>>>>
>>>>>>>>
>>>>>>>> Looks good to me.
>>>>>>>>
>>>>>>>> Suzuki
>>>>>>>>
>>>>>>>>
>>>>
>>
> 
