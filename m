Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E991A7863DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 01:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbjHWXKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 19:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbjHWXKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 19:10:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2107.outbound.protection.outlook.com [40.107.92.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3391E51
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dk4JOlRRughuqtwtrRWXZ/80JTa0gPboZ/U3zTiVe8NpvgKoD4xdigLR97Wxg4epuPGp+JKGtXmNmpD2g+ti9vz5sUeSAOVfKRMZnYrcRkEpQvHuyLJPeZwGpx3mQLNgz22n3yAGAMB5vTe8mAmqo9He3ngFIAD6k0mu8iAm7ZnYjtMSkkMTH7JkwUCR3N5TwtD5NoWX3jQtlXjzO1Y0dOqMGxjBM2CgnkBwKtqTucsg6aL7X4AFZ3NfPf9zfqL5qh1gsqGklfOr1rPhETnLyFbpNcmtjbk6ceVDSr2R/pD61rVCSt0M+nBuTL48bKPulAxnWFN+uP+qL1Wd7mFD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmSVxChcZDx8ztY1SJmupmucGWxcixX9atEkM6bBJLw=;
 b=gKZKDyXyjDp+K1cD/yh6L63CEVT5sx81t/s+4Hkxjf3krVOKV30s2O4wqaJcHyV8Pkc+8nLBooiKHjEf5yeQ2yRAvIuMICif7rSLiLABZabjr8KcmS2iglibnMeQbpTAS1b93/jjrro70tVnLl3KJDGpRVwc/QZregQDFo/KqErWUfd8HwBrd6hiYHzEBYZHUdfiaBEZDIoLqW04deDXc4Bj2oTb903QCk3XoMC0MeycPtxfh4SqHZgSwgyO+1z0iRczYpS9voYvDpkWPKOwUIzHT7ycoXJ61zMM1pbYV3rmAvBGpXQGSAzazRsyS+LF2S+71AC6yF3I3nW88CI63A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmSVxChcZDx8ztY1SJmupmucGWxcixX9atEkM6bBJLw=;
 b=TsbULva3KZPGvvi3G7pRZrEL9ohVcaqOR+eGOW2qgN0jdhqYTqYH7iY53yaK4wlFeevBofsB9DBDpBEqQQjxLg8q60eypdTxZfd6nB5qRuhbLFMhnMs08MWrl+as0sNCSWvm2RhImGiC56I0ZRWkHJpTDm9o2n4zGCqhgloMPeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA1PR01MB8062.prod.exchangelabs.com (2603:10b6:806:335::13) by
 DS7PR01MB7712.prod.exchangelabs.com (2603:10b6:8:7b::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.20; Wed, 23 Aug 2023 23:10:08 +0000
Received: from SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::ecb8:39f9:1677:39c5]) by SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::ecb8:39f9:1677:39c5%5]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 23:10:08 +0000
Message-ID: <ffa90e80-c249-42d5-26f1-dc022d91e5a9@os.amperecomputing.com>
Date:   Wed, 23 Aug 2023 16:10:02 -0700
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
Organization: Ampere Computing
In-Reply-To: <b2cf0173-c404-d7d6-9eb8-054e160ca4e5@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:610:b1::8) To SA1PR01MB8062.prod.exchangelabs.com
 (2603:10b6:806:335::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8062:EE_|DS7PR01MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d160bb8-2c08-4b86-5677-08dba42e17ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1hkzgJd6WGIoN0EobPHhVeHQfN/s7otiFZTZSulK7jqjR/09rPEq2QnR2kdYjqQgV+Q1KeVkgXsLxXasIb0FLVM5OGH/cHGX5iobgfRO4mPwWM5Ne3wmp7fZxq/BskYERh5JABRp3rZEXT8xaxb2IMNZy3FBm0ybIWyWsIIMLtvzcaRTJAayeJY5ciJFX5ID+pvc0knMYoMaCKE4zzZrEgVpk3JixTx93ZoQkP8pG5Mt++U31b5BftCxtOzcbHub7q98M7zIQsTyTmqB4U/F+yMchVp3akzhugkrF4DFAmJj6Sepf0ztAD1EzODkqOTN8bmMKswPM1c0RIp1SzBO1x0pQVkMm70vlKvpdQsjHwHBVjzSdfRTt2a6WZPIAP3fi6n71erzWHi0zD8zJoEN1xti25aO8kU/LSsYc6Di8lesys+B6MzJlIxPRChGqbtJcX9yoMY8cgzFnWMnQlc5X61+1P/NcFQgEYYCbzA91leZEJohuvCenDP9s9dzHXLQe89V6g+LFL6O1dwG5qheX0O+wEPawx6oCurPTO8SEnxZDnX8uSyY/VM/O9IG0gNUo0M3JdL2zCVRAONtdhCeCQsCRH0RpdR9hDNrqGVILo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8062.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(396003)(376002)(366004)(346002)(186009)(1800799009)(451199024)(54906003)(66476007)(66946007)(6512007)(316002)(66556008)(66899024)(110136005)(8676002)(8936002)(2616005)(966005)(4326008)(41300700001)(478600001)(6666004)(38100700002)(36916002)(6506007)(53546011)(6486002)(83380400001)(3450700001)(2906002)(31686004)(31696002)(86362001)(5660300002)(26005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WSt5TTRxSlkrWjFiTU5WWmZPZHRZdmlqbEVOcVJQQjNYTVh4YTZlb1NPdHg1?=
 =?utf-8?B?di9sU25mbWszbCtZSjRhdXlwRm1Nb2Y0cVBmYWlDcWkwSlNYVWY1M0Y1OG13?=
 =?utf-8?B?VXVFSVc0WUtPcTNJZHI1VG1Eb0o3dGtvVlJHaUsrZ0dyM0dPOXJNanh0c0d0?=
 =?utf-8?B?MGFiU080VlhTMG1uMDViQ0NIdVVsRFA4S2NtZ0FSUWVBK1NFMVJoWVpKa0Qw?=
 =?utf-8?B?c1doc0ZodExGVmZqMlAxQ2krVmw4Z3VOUnllMGlhUXRRT0E3SGNDc2tDVTND?=
 =?utf-8?B?QkI1OFNJRDNZc0xRMXd2SEFFRFluNCs2NTlxTmxYallFM0tsenJBbjl5OTFZ?=
 =?utf-8?B?ZjJHQmxJZEUvK25IMHNabyt6bC9Rb0JXOUJYdS9xTzdod0JOT2l4VzJ1cGor?=
 =?utf-8?B?OTUrcjdDSWFMSVRxcTlweGVGQ0dyUlVJQXQxMU4xQy9ma2c4cVVZR3NSVmNX?=
 =?utf-8?B?ZU9HRENRQTV5SlpwOWJTWnpNYlRmbml1V1Ztd1EvT1F4QWtMR1o4bnVNaVdX?=
 =?utf-8?B?QTVDWStXOXBlNnRZVDN4NGRTYm5XZnljWHhFUUdUWlpZN2JJVk9qdlVMSEdn?=
 =?utf-8?B?NnNjMTZKbnFKZDlBZjkzTVpjclYrRHN1Si9YRWY5SjU5VmxjRm5SVlJCNERq?=
 =?utf-8?B?SkZJSkVXU0VRVC9DSStkMUM2WVAzUnZWYTluK1pTc3gwNEdyeGR3b0s4bmRy?=
 =?utf-8?B?cGRmREd6VVNnMXo3S3l0elFBRnRPc3FsQ244MU16ZjliQ3NTQzdUeXdyZ1ha?=
 =?utf-8?B?aDRtYVFaL0I1ZEdQTUh2WkhUM0R6a3grdWdFalgvdzB0RmVlbHQ3K2hDc2lx?=
 =?utf-8?B?RGh6d3kxN2N4TW54MmU3cGg0RlAvMkJJdk1mTVVNdFJYOVViUkNTREgyMkp6?=
 =?utf-8?B?RUJlUS9BZkdCQTRNNlE2MjNoVDZVQ0tpQTBNOHN5UnBIY1cwdkFOaFg3azhl?=
 =?utf-8?B?WWI1anZ3N1F5eGxva1paTjRtMnhTODhMVG1OWVRKNFJuS2JPNkpLUFNWNkgv?=
 =?utf-8?B?UkJkdzFMUkNwaVcrSVRmWDZ6bjFLZEZxMVZKL2VUU0c2Zjg2ejRGT25VWmlQ?=
 =?utf-8?B?eXQxS0VlOHp5R2VkczJkWVRrTnR4VkFtRGl1L1ZsQlFyNXQ2bmllQmdoeDg3?=
 =?utf-8?B?Nk5HME9sRlJqNDN6N2VRMTR4UVhnYzdzUjZKQlRPTVYwd1hXVEVPL3E2VzJD?=
 =?utf-8?B?OUM0ZU5qNzhGZWkzaTRtNzBydTlVQmNoTkhhdTN4WWtlK3ZZWmYrZFoxNk41?=
 =?utf-8?B?VDFKWEhldWUvUS9yWHdFZ09tV05ia1Z2Y01oeVVvWEpyTEJrTTR3aVRYRnhi?=
 =?utf-8?B?WTRaWkExZWVwTUZMQ3phOHVSMG45M3dLajlFQkhCNWp1U2pKcVlneFZpZktj?=
 =?utf-8?B?Vis2ZEx5MDQrTkhTaFFRNThqU0NIczd0L0ZlM1RSRnhBOFpJbXVQR0RLYVVu?=
 =?utf-8?B?R2d4aE5wNUxwZmFVU0NvMWF5eE1sZ3ZyOVg4OXBVcmVVenhCaGZzclJOdTlU?=
 =?utf-8?B?ZnNmMkFVZVZqUEtodHZDVVlmM3hCcC9QdzJUQ2czMEQ1SDZ4NlVDSGNLWEZJ?=
 =?utf-8?B?Ry9XMWd0N3psT01sa01vWHNkMXh3SnlST0JDY3hpaWpwUS9HNlZYNFNuZ0xX?=
 =?utf-8?B?cXBZU00wUGdqdXlnTUJ6ZXhOd1Z4ZVMzenZqaVJMb3pjUU9maFFVbFpKY3hL?=
 =?utf-8?B?OFhXTWxmeE9odUN2RkxnT3JOZHQvamlhMCsyN09VdVd4aVlEZnA4aTc4WEVq?=
 =?utf-8?B?QVpYSnFWdmJ2RXJnK0VYd3ZnYmtWN290MzNhTmczTjIyMTRON1dlaHpBY3pJ?=
 =?utf-8?B?YVVmYlJkU1E3UXRycWFvcnNzMHllZHBCSlV2R1BUMC8veFg0VEhvZkEzODlR?=
 =?utf-8?B?eDlkTTVlaUdVM0pEQXpTOFZuZldHcmttK0VOK1VJK1I3Mk5OOG5wdUQ5K0dj?=
 =?utf-8?B?cVBWSVNITm82WWNyNVhsTytwUW9yTk1kWTFQSTRqTURCMVhNeXIwS1NZSklU?=
 =?utf-8?B?V3l3T0kwRlJqWVlEVmwrekw4aTVETS8raCtJdDB6QnlJellvWlZZbkNEUXJ2?=
 =?utf-8?B?bzVLaDFhOG1jVWZWbFNuanVuWmtLM0VzWC80bk55R0pidkpVeGRFK1NTYjZy?=
 =?utf-8?B?bUxuTUEwc21rWG9iZzN4MU8xeVpURFc4NjF2TzkyY0lHV1V4eW1LNExlUGQ0?=
 =?utf-8?Q?CI/NZ+tgA5mYC4kgZcNac1Xf6ER60KiNMJ06JJHBql5z?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d160bb8-2c08-4b86-5677-08dba42e17ef
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8062.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 23:10:08.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WiskijGp9JSIYmE8f/HRbxLUKoZHCMmKFkTRFu4p3JwcsY0UFi3cSyuQJ3lZiNCtKwFxJzjeJ2kr9FIyQzK9PtVQvm9TZR9p0Bzo/V1vsUIH3X8+zasyqJ8yMZ7fI3W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7712
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here's some quick feedback. My system shows two modes available; auto catu

etr_buf_mode_current is writable. I expected to see tmc-sg (former
default) listed in etr_buf_modes_available but it doesn't show up.

Note that both the auto and catu etr_buf_mode_current settings default
to catu. My understanding is auto should revert to the default behavior.
On my system the default was tmc-sg.

More later.

[root@sut01sys-b212 kernel]# cat
/sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_modes_available

auto catu
[root@sut01sys-b212 kernel]# cat
/sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
catu
[root@sut01sys-b212 kernel]# echo "catu" >
/sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
[root@sut01sys-b212 kernel]# cat
/sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
catu

Steve C.


On 8/21/2023 12:40 PM, Steve Clevenger wrote:
> 
> Hi Suzuki,
> 
> I may be able to test it this week. You've already pointed me at the
> patch thread(s). The main holdup is I need to merge the 6.6 pending
> platform work in order to use the Ampere ACPI. I couldn't get these
> patches to apply directly to 6.4 last I tried.
> 
> Steve C.
> 
> On 8/18/2023 2:39 AM, Suzuki K Poulose wrote:
>> Cc: Steve
>>
>> Steve,
>>
>> Are you able to test this with CATU ?
>>
>>
>> On 18/08/2023 09:21, Anshuman Khandual wrote:
>>> Currently TMC-ETR automatically selects the buffer mode from all
>>> available
>>> methods in the following sequentially fallback manner - also in that
>>> order.
>>>
>>> 1. FLAT mode with or without IOMMU
>>> 2. TMC-ETR-SG (scatter gather) mode when available
>>> 3. CATU mode when available
>>>
>>> But this order might not be ideal for all situations. For example if
>>> there
>>> is a CATU connected to ETR, it may be better to use TMC-ETR scatter
>>> gather
>>> method, rather than CATU. But hard coding such order changes will prevent
>>> us from testing or using a particular mode. This change provides
>>> following
>>> new sysfs tunables for the user to control TMC-ETR buffer mode
>>> explicitly,
>>> if required. This adds following new sysfs files for buffer mode
>>> selection
>>> purpose explicitly in the user space.
>>>
>>> /sys/bus/coresight/devices/tmc_etr<N>/buf_modes_available
>>> /sys/bus/coresight/devices/tmc_etr<N>/buf_mode_preferred
>>>
>>> $ cat buf_modes_available
>>> auto flat tmc-sg catu    ------------------> Supported TMC-ETR buffer
>>> modes
>>>
>>> $ echo catu > buf_mode_preferred   -------> Explicit buffer mode request
>>>
>>> But explicit user request has to be within supported ETR buffer modes
>>> only.
>>> These sysfs interface files are exclussive to ETR, and hence these are
>>> not
>>> available for other TMC devices such as ETB or ETF etc.
>>>
>>> A new auto' mode (i.e ETR_MODE_AUTO) has been added to help fallback
>>> to the
>>> existing default behaviour, when user provided preferred buffer mode
>>> fails.
>>> ETR_MODE_FLAT and ETR_MODE_AUTO are always available as preferred modes.
>>>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: James Clark <james.clark@arm.com>
>>> Cc: Leo Yan <leo.yan@linaro.org>
>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>> Cc: coresight@lists.linaro.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> This applies on v6.5-rc6
>>>
>>> Changes in V2:
>>>
>>> - Renamed sysfs file etr_buf_modes_available as buf_modes_available
>>> - Renamed sysfs file buf_mode_current as buf_mode_preferred
>>> - Renamed etr_supports_flat_mode() as etr_can_use_flat_mode()
>>> - Renamed coresight_tmc_groups[] as coresight_etf_groups[]
>>> - Reused coresight_tmc_group[] for trigger_cntr and buffer_size
>>> - Fallback trying ETR_MODE_AUTO when user preferred mode fails
>>> - Moved ETR sysfs details into coresight-tmc-etr.c
>>> - Dropped etr_can_use_flat_mode() check while offering ETR_MODE_FLAT
>>> in sysfs
>>> - Moved struct etr_buf_hw inside coresight-tmc-etr.c
>>> - Moved get_etr_buf_hw() and etr_can_use_flat_mode() inside
>>> coresight-tmc-etr.c
>>> - Updated month in
>>> Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
>>>
>>> Changes in V1:
>>>
>>> https://lore.kernel.org/all/20230728084837.276551-1-anshuman.khandual@arm.com/
>>>
>>>   .../testing/sysfs-bus-coresight-devices-tmc   |  16 +++
>>>   .../hwtracing/coresight/coresight-tmc-core.c  |  15 ++-
>>>   .../hwtracing/coresight/coresight-tmc-etr.c   | 111 ++++++++++++++++--
>>>   drivers/hwtracing/coresight/coresight-tmc.h   |   3 +
>>>   4 files changed, 131 insertions(+), 14 deletions(-)
>>
>>
>> Looks good to me.
>>
>> Suzuki
>>
>>
