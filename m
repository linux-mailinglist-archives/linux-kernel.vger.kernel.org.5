Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EF07892AA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 02:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjHZAPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 20:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjHZAOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 20:14:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2137.outbound.protection.outlook.com [40.107.244.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC2D10D7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 17:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpLrOlSMrZwihX2gYkkmQSXXv6859F6LfOfMDsbxc1ZRbTkvlbPPkJJGUyKS5I0b4C2d9bdXqyn355H0ElWEFPvRLhDXXgJjc2IWFVidF3EpNRZbefxY2g0rrp9/Zad1sGZ5M4cPGHBL5WdtHYc0ZVXb5xSzXdherEXdZGzFXFKNYgY60dhswyQAh+SggIO56PFnB4s/qIWkPsYVWVc2q03/uWsjO0i97ATCCm5fSC8wnQ9tmGAm++J5NRyujOAYenKJbZIMLXs2jj2elI9DxNBHozxUs5DfXdzf/zKoFZTgJjkrudceonRWqOWnmeHs5s8bom8MfgGmIeaqPcZhCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/p/kmllxMOi5Z2l5EoJLmtm1xsrYdCMIw1BDksJxqUQ=;
 b=ENRDZvfnHxgSafcL3G8mAgWwmIOWwYp9TaBkLNcA/Mae/yXW6lgSoUQ6kvBv/m4Bq5q3zi+oDmnHItmss3PmlfAf1H0gdusFlxyZymHM9ShtnJKPVLq55mwTdAV368xPY/kZCJZ6dVZUpcApqtnrtg+ddEzNP3Sbn10eA8ECGx+MBccPaP5OQcfjVRKwsKV0e3V2c/1JagGZhxV6+R6lJlDRuT6IKC8OHj7e0B3kqKjvllXMzJ7sKnujbOlGY+MTLZs2HzpZxLOo5IMdKEBUZnppCs9NmFm7GRhR4BK8H9m5RPF7yz0lTRNPIQe7/nlSzX3wULtfZvjkIsmRIcWnog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/p/kmllxMOi5Z2l5EoJLmtm1xsrYdCMIw1BDksJxqUQ=;
 b=rTEYLc4qT+nOwTmSYAd9uhd41tVBwXIAMQorOayFzVjbRWkR7SYhkgADjEsIv0NMVVyl70Z6Roo4uzzNZO3q76q2q6AFyDSwTPUMApyRIiQUmy1+a68FFKb9RHkiS18To01hnMDrH/qQzaTkDOTrOMkLTGaPWaiG3z40Pw5FRNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA1PR01MB8062.prod.exchangelabs.com (2603:10b6:806:335::13) by
 LV2PR01MB7672.prod.exchangelabs.com (2603:10b6:408:173::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Sat, 26 Aug 2023 00:14:47 +0000
Received: from SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::ecb8:39f9:1677:39c5]) by SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::ecb8:39f9:1677:39c5%5]) with mapi id 15.20.6699.027; Sat, 26 Aug 2023
 00:14:47 +0000
Message-ID: <391951c3-7da9-3965-acf8-f3b31f822879@os.amperecomputing.com>
Date:   Fri, 25 Aug 2023 17:14:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
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
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20230818082112.554638-1-anshuman.khandual@arm.com>
 <bedcf27e-b273-075f-3d7b-eb99b07e7c91@arm.com>
 <b2cf0173-c404-d7d6-9eb8-054e160ca4e5@os.amperecomputing.com>
 <ffa90e80-c249-42d5-26f1-dc022d91e5a9@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <ffa90e80-c249-42d5-26f1-dc022d91e5a9@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:610:cd::19) To SA1PR01MB8062.prod.exchangelabs.com
 (2603:10b6:806:335::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8062:EE_|LV2PR01MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 80188b11-99d2-4719-0627-08dba5c974f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBSDEpyZWIFJdiFCqdk0m0YPQ0MU/yV7gFvvkubvR6lHwKkgHwJpGakTsohMzI3GGLNw/fyTpsR4EACZR0xpsnEAeuEH/fqY5C2s6nNJgnizhQX48J6J/R6e4QZmgN1jJeqGdh8MouSfrAkcSxRdnR0Z6xmdxRHfzsRJb60WHW6rETQLtmr2cKHsjwZPdYn/iPfeOOAySYchEDBcI62qe58c3T3NKmaLQrfk54q4UlxCo0x1DdmrNpqRwU/j5dWCKSIwpBA996Z+GyiUbJqlZtmtcAzBxVtNd6xffHZfww/FkaRCD6dtp3ud+m/vnNZm9IzSxnTiDVcNblbxsvSk4scz0lq0sVwxmQee1ZCO60ZH2+CuCtZtXT1LWJlKqIO2dhP4Fwniquhtwz4rP+B44Tmt6ZnC28IGziU9MvaymD8joOJhOhi5wz82Pu9EgwClSaT9b93ZXOmtBs5p61e1Gn9EGPL0574QcTCDuzwIeIL4vA8Dkf2CgPN4vWRjn+pV1Tp8dHBdselS6lchBL1Yv6U/cVDib7eGvOZGDdEiZYsD3xIC3+xec+wnavRC1rZqNcQGMPd+DTL5GqnmDT8TqXjy34K7+giBytvuA2QVBVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8062.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39850400004)(366004)(346002)(136003)(186009)(1800799009)(451199024)(2906002)(66899024)(3450700001)(83380400001)(38100700002)(31696002)(86362001)(41300700001)(53546011)(6486002)(36916002)(6506007)(110136005)(6666004)(316002)(66946007)(54906003)(66556008)(66476007)(6512007)(478600001)(966005)(8936002)(31686004)(26005)(2616005)(8676002)(4326008)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkFRZ2dWWjhMRnErWXorZ1BkdnR4cldnSThwSW5LSFFNYzBuUnlZZk9IcElQ?=
 =?utf-8?B?QnZTMHJKajVubEtOTnNPYTVaZjYzOEYrSlNMWERxVG9SdGtzT01yenQxVlkv?=
 =?utf-8?B?bTYwWC8zNjh2SEFtSC94MGowL1pTOVRyVVRMZ2lSNmRDRndCYjBXc0ZQeFF2?=
 =?utf-8?B?Yy9pWFQ2VGQ1aU9rWTRjTkVMZ0Q0MGl3SWxMSlZlYm1MS2l2RjA3aHJOTThN?=
 =?utf-8?B?SkxUNjYzNXZwTnArYTlpa2RoelBxZmhZNDlTRlEzTFhrMzZkU1ZJcnVDcFpP?=
 =?utf-8?B?UllXNjd0UlR6Y2xTS1lERVNVYUtwM1FLK2NRL1VBNW9MWHdXNUdiMkw3TFJP?=
 =?utf-8?B?cGR1TFZyOWlzdm1laU1hRjhQRWpoQXpQcnRpeXF3MGFvU0xWWXNOM1hQZWpm?=
 =?utf-8?B?ZzR5UmM5V3BJcUhBbE5BRVNRTVQ0WE1GNU1Oa0hkZHRyM0MxUXdnMGUrNXA5?=
 =?utf-8?B?UENyUHpQMzVmYyt4R0pLZEtuTUpPSlFnQUhNS1ZYSVNEdVNTVW1LWFA2V3I3?=
 =?utf-8?B?TndDb05qby9xYVIrYkU1WGdTMjJmQkNJT0EwVHBUSzZNQnY4K3VXRlRDR1FQ?=
 =?utf-8?B?K015bEtkenFYdm1qOFk1Vkl5dW1XUis1cU4vZFVZN3FsdUpwcEdIcVVyYkIw?=
 =?utf-8?B?cWxEZk9HQWFNZ3luUTVoSi9kRkRCVWJsOExMcldDaG1oSVc3RVBmM1BXeW40?=
 =?utf-8?B?RlU1Q2g5OFZ4OSt3TGgrVHk2RDhUR3grZXFraW83RDdPL1hjYWNCeXIydS9j?=
 =?utf-8?B?VlFneSt4SkdEcmF6TUpzMXdub0hSWU9WVlR4Z0I1RnNPZUFhZXJEeUpiL1hQ?=
 =?utf-8?B?TEtXWnBhQ3kzTUJPZVVuMjhSQnVvK3I4SUp4LzFBRXd6ZGxXeEZ3dFd4WExh?=
 =?utf-8?B?dGZUUWNPUmQ3QUdjOWJVUmllbkoxaXpaTjJYcnUyTVRyVTRFaHFmNFVnZzFr?=
 =?utf-8?B?NGVyNXZsbEVUSFlDMGNwbStidGRKSk1vS0Z3bzVaZGx3M0ZLYW4vUjFTSzN4?=
 =?utf-8?B?cUZoZ1JPdWFkc0IvN1NxdmxEMWxwUERpUkZHUU55bXZrSnAzVnN3REVrWUt2?=
 =?utf-8?B?K1FSSnpYZEprT0hLSlI5THBYN2VHTFkrNTZZRlpxc0g3R3VEaHh3cFBZWVA1?=
 =?utf-8?B?aHc0cHp3dlFUVE9Jc25IaHh5NTB2V1UyZTVWdzlGb3k0STBabjZuWlpHWEFj?=
 =?utf-8?B?WHUzL1ZvQUpQdEFzNXlyL1FvZWt3ZlZ5VTdrbHRRZ1BBY2RmWlI1VUpQU3lt?=
 =?utf-8?B?RDB1QVJiSTF1Q0VJelR3eVZPa0hCVTB1M3lGWklwenJ6TUN0anFzUFFYcHpa?=
 =?utf-8?B?ZUVTbDlwcEV1aUQ4cHNDTDczUjVmNmtNNDJjOHlFUElQcXVHOTFXcWhqdTkr?=
 =?utf-8?B?NzdEVXlGVGdUUHFNVmFERndmMVdUNzZocUR0VklKenJqOFRGL1hVQjU4am5J?=
 =?utf-8?B?dWxSeWZrbTZuNWRnaG9mRE1PeGRXaUtPTncyanVyRWtycC9QbFkxK3JIaHBZ?=
 =?utf-8?B?WXB6ellnc1VTMWdRZHVhQ1MzTzFLRXRMYU5PKzF5TUFyNWlZY28zUlZVTk9q?=
 =?utf-8?B?WWYwaFdXMGt1dkQ4YW1mZmZYRE0wbFg0U3hxODhQK0grMjdWZktxWlhtaGZy?=
 =?utf-8?B?RDF1OHJEaVFZZnFzS3dpTjlmLzBuYUNmL2Z3SllqQmt2NXFQVlNmYnA2czVX?=
 =?utf-8?B?eXo2WS9NbFlaeURqWWh5bmQxRUhYaG1zNThxQUNJZlZaa2pxOWxIdmE3MDMr?=
 =?utf-8?B?K0Jtb25jY2Nuc1R6cGdHYlIybTRTVjhkTGpnMGQyRVVsWTl1U3ZyZWpaTzJ4?=
 =?utf-8?B?SC9RenY4RXFMd1g4Z1ZmdVBQYnRkelVoZEJqbE96SjZsQ2RodCtoQkdSWjBX?=
 =?utf-8?B?TEw0SEZrK3BLMHBPVUlrWE00R1djR0dSS3JsYWF1TTF4NVJTRGtIUW1ibUhK?=
 =?utf-8?B?dURDUDV4NENMelN4aTFMcTJadmNwY1Z0RU83SnBpSHJWOCtBRE5HVld1VXJz?=
 =?utf-8?B?RVBWSjZVemVlbGlaWC93STI1RU1yaEkybFlXMGNHYUZWQlo5cHQxOUM4aVFo?=
 =?utf-8?B?dFJhQkNFUTdFYVNQWjRPQnpScVdqdm9OR2treGROSUthNVhVVzVOV2hNaWF5?=
 =?utf-8?B?em5ndkFvZGYwRHV6UTZPRVdBMDczNG1KVmQrNXc4eFNUSXNtejFoRGlPb2o5?=
 =?utf-8?Q?/BgOkTMHIgd9vPcye6VJRWLo3nEeY2LU8eo8PGyQSUNO?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80188b11-99d2-4719-0627-08dba5c974f3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8062.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 00:14:47.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gjX+GEMvtnfZJHRGHj3UnCy46436xvN+VYrcqrFLtXECyUl1/2+6Dx30v2cBadtZg/m6mWP4TZjhNnXik57cpqwQwH8QrwZGuciplnpu0Ay5yH5YjvDdvmGPk4C0R9v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7672
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Unfortunately, I tested with the original patch not [PATCH V2]. I've
remedied this. My results below:

[root@sut01sys-b212 linux]# cat
/sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_modes_available
auto flat catu
[root@sut01sys-b212 linux]# cat
/sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_mode_preferred
auto
[root@sut01sys-b212 linux]# echo "catu" >
/sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_mode_preferred
[root@sut01sys-b212 linux]# cat
/sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_mode_preferred
catu

As with the V1 patch, auto defaults to catu.

I expected to see tmc-sg (former default) as an available mode, but do
not. As I recall, the buffer mode defaulted to ETR scatter-gather prior
to this patch. Must this capability now be explicitly advertised? I've
seen this done as "arm,scatter-gather" in device trees, but not used by
Ampere. Perhaps someone can enlighten me.

Steve C.

On 8/23/2023 4:10 PM, Steve Clevenger wrote:
> 
> Here's some quick feedback. My system shows two modes available; auto catu
> 
> etr_buf_mode_current is writable. I expected to see tmc-sg (former
> default) listed in etr_buf_modes_available but it doesn't show up.
> 
> Note that both the auto and catu etr_buf_mode_current settings default
> to catu. My understanding is auto should revert to the default behavior.
> On my system the default was tmc-sg.
> 
> More later.
> 
> [root@sut01sys-b212 kernel]# cat
> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_modes_available
> 
> auto catu
> [root@sut01sys-b212 kernel]# cat
> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
> catu
> [root@sut01sys-b212 kernel]# echo "catu" >
> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
> [root@sut01sys-b212 kernel]# cat
> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
> catu
> 
> Steve C.
> 
> 
> On 8/21/2023 12:40 PM, Steve Clevenger wrote:
>>
>> Hi Suzuki,
>>
>> I may be able to test it this week. You've already pointed me at the
>> patch thread(s). The main holdup is I need to merge the 6.6 pending
>> platform work in order to use the Ampere ACPI. I couldn't get these
>> patches to apply directly to 6.4 last I tried.
>>
>> Steve C.
>>
>> On 8/18/2023 2:39 AM, Suzuki K Poulose wrote:
>>> Cc: Steve
>>>
>>> Steve,
>>>
>>> Are you able to test this with CATU ?
>>>
>>>
>>> On 18/08/2023 09:21, Anshuman Khandual wrote:
>>>> Currently TMC-ETR automatically selects the buffer mode from all
>>>> available
>>>> methods in the following sequentially fallback manner - also in that
>>>> order.
>>>>
>>>> 1. FLAT mode with or without IOMMU
>>>> 2. TMC-ETR-SG (scatter gather) mode when available
>>>> 3. CATU mode when available
>>>>
>>>> But this order might not be ideal for all situations. For example if
>>>> there
>>>> is a CATU connected to ETR, it may be better to use TMC-ETR scatter
>>>> gather
>>>> method, rather than CATU. But hard coding such order changes will prevent
>>>> us from testing or using a particular mode. This change provides
>>>> following
>>>> new sysfs tunables for the user to control TMC-ETR buffer mode
>>>> explicitly,
>>>> if required. This adds following new sysfs files for buffer mode
>>>> selection
>>>> purpose explicitly in the user space.
>>>>
>>>> /sys/bus/coresight/devices/tmc_etr<N>/buf_modes_available
>>>> /sys/bus/coresight/devices/tmc_etr<N>/buf_mode_preferred
>>>>
>>>> $ cat buf_modes_available
>>>> auto flat tmc-sg catu    ------------------> Supported TMC-ETR buffer
>>>> modes
>>>>
>>>> $ echo catu > buf_mode_preferred   -------> Explicit buffer mode request
>>>>
>>>> But explicit user request has to be within supported ETR buffer modes
>>>> only.
>>>> These sysfs interface files are exclussive to ETR, and hence these are
>>>> not
>>>> available for other TMC devices such as ETB or ETF etc.
>>>>
>>>> A new auto' mode (i.e ETR_MODE_AUTO) has been added to help fallback
>>>> to the
>>>> existing default behaviour, when user provided preferred buffer mode
>>>> fails.
>>>> ETR_MODE_FLAT and ETR_MODE_AUTO are always available as preferred modes.
>>>>
>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> Cc: Mike Leach <mike.leach@linaro.org>
>>>> Cc: James Clark <james.clark@arm.com>
>>>> Cc: Leo Yan <leo.yan@linaro.org>
>>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>>> Cc: coresight@lists.linaro.org
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>> This applies on v6.5-rc6
>>>>
>>>> Changes in V2:
>>>>
>>>> - Renamed sysfs file etr_buf_modes_available as buf_modes_available
>>>> - Renamed sysfs file buf_mode_current as buf_mode_preferred
>>>> - Renamed etr_supports_flat_mode() as etr_can_use_flat_mode()
>>>> - Renamed coresight_tmc_groups[] as coresight_etf_groups[]
>>>> - Reused coresight_tmc_group[] for trigger_cntr and buffer_size
>>>> - Fallback trying ETR_MODE_AUTO when user preferred mode fails
>>>> - Moved ETR sysfs details into coresight-tmc-etr.c
>>>> - Dropped etr_can_use_flat_mode() check while offering ETR_MODE_FLAT
>>>> in sysfs
>>>> - Moved struct etr_buf_hw inside coresight-tmc-etr.c
>>>> - Moved get_etr_buf_hw() and etr_can_use_flat_mode() inside
>>>> coresight-tmc-etr.c
>>>> - Updated month in
>>>> Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
>>>>
>>>> Changes in V1:
>>>>
>>>> https://lore.kernel.org/all/20230728084837.276551-1-anshuman.khandual@arm.com/
>>>>
>>>>   .../testing/sysfs-bus-coresight-devices-tmc   |  16 +++
>>>>   .../hwtracing/coresight/coresight-tmc-core.c  |  15 ++-
>>>>   .../hwtracing/coresight/coresight-tmc-etr.c   | 111 ++++++++++++++++--
>>>>   drivers/hwtracing/coresight/coresight-tmc.h   |   3 +
>>>>   4 files changed, 131 insertions(+), 14 deletions(-)
>>>
>>>
>>> Looks good to me.
>>>
>>> Suzuki
>>>
>>>
