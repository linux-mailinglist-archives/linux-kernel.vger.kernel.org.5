Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CDE78B56D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjH1QgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjH1Qfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:35:44 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2138.outbound.protection.outlook.com [40.107.100.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE9411D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:35:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqtzi+5W4eIk3FD4tpKrPYF+jGv44I2HB99aZoXX8ERE0dMfeqGIkSU2xH4ZyOqSnHnH/bywXrDhRPOKwusaZofkXmjrJqp0WLnB2Yv964qli0YioDD8OGn/iYulEcBaj54jSixTQ8mN9q3bRCLsngPX5Y88MmQa0kxxTDR/OaHRMo44gqlgUGxqgWvhUaKqjsq9ytpWAgatS9NDoauiFt8Zr9ibta5TJOF4sn4BakTJeR8+jlxS7ok3yRs8bo3h5yVH51i9yJYfBkQ9Pg3GxduUGInaUCzWgv+qQ3mbJW39gYUfrf/HVyLH9GNLGBCyMJU7QPrazUxU85pPtcJR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkeyWwmlNCy2ehzyrwgFVyjjD/o/76etnB+FjMY+Rt4=;
 b=m+rKxTOsdlDIDguTr+A9CKeJQdmgwDZ8H5gqzqTnREbfz//wxqxvDPEXNcY1gcu49Ttci0GoyiQsaObV7XrcSPr27HegXNnb9whRlbzuHoxWujOjXbHYu4rx/krj+OfTa7lIJNjuusABQ1MSW7xvBOW+D8Kar+nyPcc+TrejVNUq2qsBSu5sPnqaGlPShkBZEEERmGVe9QBRKHyuZz7L0ReW8Jr+KioAB3mBgroc1+h/14oQM4NdRUeKvdgN6H8o+IZvlpTbppLDBV4vqEQrGP6CcPKm617LBBDAhL88c70ih6GiSwRzb44oL+xHKUec8iAjqv4FnQe5LZDSclhNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkeyWwmlNCy2ehzyrwgFVyjjD/o/76etnB+FjMY+Rt4=;
 b=B0mH1ygyRiyAECVXU1D+kestubs+ZQQYRZY+jMTtkZh9LNmmAVsIT1dUpkNGURY9l9UPu3ukoleQ093mLqJGfT9wU8+Ynw5vWgSmuBGKlSPt7TUul3TkjVaOO9i/Ht7M1j4LTPtWgmixU5WEV1YxGJMn0BFcfjVxp96jyEc0h98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA1PR01MB8062.prod.exchangelabs.com (2603:10b6:806:335::13) by
 MW6PR01MB8273.prod.exchangelabs.com (2603:10b6:303:23f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Mon, 28 Aug 2023 16:35:35 +0000
Received: from SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::ecb8:39f9:1677:39c5]) by SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::ecb8:39f9:1677:39c5%5]) with mapi id 15.20.6699.027; Mon, 28 Aug 2023
 16:35:34 +0000
Message-ID: <cc1b1082-2bcb-9d76-afc7-0e12edd694f0@os.amperecomputing.com>
Date:   Mon, 28 Aug 2023 09:35:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
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
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20230818082112.554638-1-anshuman.khandual@arm.com>
 <bedcf27e-b273-075f-3d7b-eb99b07e7c91@arm.com>
 <b2cf0173-c404-d7d6-9eb8-054e160ca4e5@os.amperecomputing.com>
 <ffa90e80-c249-42d5-26f1-dc022d91e5a9@os.amperecomputing.com>
 <391951c3-7da9-3965-acf8-f3b31f822879@os.amperecomputing.com>
 <1b2a035c-489e-ace9-f851-c1ec157ff9fa@arm.com>
From:   Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <1b2a035c-489e-ace9-f851-c1ec157ff9fa@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:610:50::32) To SA1PR01MB8062.prod.exchangelabs.com
 (2603:10b6:806:335::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8062:EE_|MW6PR01MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e26fdf-5282-478e-3a11-08dba7e4cd9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEUeOfxqB/d2YpyOUjvB2yKWD9IP2FlOOaKDCbjJ75TagyOYrd0bgXNNjudBBqn2R2qHhMg2Y/DGQNY1w358GyV/EfAmIZdx2SD+7/vgETgnTiimVtX8/7fiKHBbrBIWPDWivhfpHJQCcKTuXvONm8OeocfjNfiTFBnw2vC2/xUfYro0z89tRV6GllAkL0Rj9bFWOW7FAzMnMVBRLRyu4O4VymDMw8CiD/f/w0RjvqhiA6CAh10ZkuT8xbAKwdd62TjMsCdti0amVxky0/M1Znujq6LeZYCgG7+sCscdtH2BdS4HFZZa2h4dBPsNG9c4e3xJjqLNUiBC3Flmtt0cVh/0fVmmsb+zqfb3kfXFC19knHetVnJMc8ZMVbAhqF9BdFyH2EEWD2JI9Lb0lvm2F3GC603MquvpTe9d3+N0JCFnrdy4eW1bDuLmzg0jURwIbBbU9jw8UPr+Z2HfFRfRJbtPDxGRCiHlUXPHTxSB4YpWLI7WgUhGS6CMcLzPFSm7ptwB+iN2UV44eR7a8FgTOldcBtkEeiMHqsf1so7/U0E/GEt7baPhhcWu8B+ayiEUJIDiADmf8UgAgTyczViMLFheaHt9zm8JmedUn7pkj0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8062.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39850400004)(346002)(136003)(376002)(451199024)(186009)(1800799009)(110136005)(6666004)(6512007)(6506007)(6486002)(36916002)(53546011)(478600001)(2616005)(83380400001)(26005)(2906002)(3450700001)(41300700001)(54906003)(316002)(8676002)(66476007)(66946007)(5660300002)(66556008)(8936002)(966005)(4326008)(86362001)(31696002)(38100700002)(31686004)(66899024)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHVtZXA5NmpkZkRnTGRQMFByUDNXSFFlZ1EyZjVUUCt2cCtRRUx3ZWs4d1Ji?=
 =?utf-8?B?TjVKcHdhN0NCRDZaVEh2K1hlR0ptWU9NOEdFSFV4QTE0b0VPa2tFcGtjQlJk?=
 =?utf-8?B?UExUUjVKSEUyT2JPK2d4SWwvLzNydWNIajM1SEg1ZjR0SlFvOGhRYmJQdW5X?=
 =?utf-8?B?azd0N2JCdUdpQUhOLzVwdDA1d1NQLzV5c3IybytFWklTdFJScWRLSFFvY3l4?=
 =?utf-8?B?YjBUYnhqRlRES05BK3VDalVPOU9TL2J3MXFxcjBNZnAvdW9mYkM4YVVmUldH?=
 =?utf-8?B?NGxhSnNWMXFhSjhsT1F3Wlh5WGtRQXBwWTRvcFRtOHo2dHpoZG1pRmlYdkU1?=
 =?utf-8?B?R2sxNUduQUpjbWZlWjNxVndYZDM2SldaWEV4bm9zTlo1WWppUDc1SHFYK1d0?=
 =?utf-8?B?SDFyc2hZWkJRcHNESnBVN2tsSmtCVWRyQW0zSnBzUVVRYVgrYWx6QTBiLzNU?=
 =?utf-8?B?WmlQSmk2d0gxeUgwOVFHZnZUSjQ5eG5CckFkd0YyQ2N0Sllva0FIbmk5ZXRP?=
 =?utf-8?B?VUN0OUdCREY4YVFRUFZxVHdQaUJOeStVNmtlOGJqQXZXZGs1cG1SS2xZTUVK?=
 =?utf-8?B?N3Z3eGVidGJkYzhsTFUvYSs0ZXNFK3F0anNhZ1AvWEgzZXZSbWE5OGtYL2Fo?=
 =?utf-8?B?ckhCSVFXcHZiQThXb2tBRXp4T2FPVmxjbmlGS05jU2VIS0IwZ1hYT1l6V2pw?=
 =?utf-8?B?eC9BVVpGTWJ2d0ZPbmN0eU9FU3Nic2pHbHJhYWFwMUh3VFR5aFlxbWM5ZEVu?=
 =?utf-8?B?VG5KQzUraHoybnZra0x6bG8xYWpiRzV2aFdGRGh5TGFSTEQyUkVTeThJMFZw?=
 =?utf-8?B?c3ZTQUhIMkt4aHE4YzFxY2FZd1g5YUdBV3loMlVUOEp6Y0NmdzFiUVI1cW9C?=
 =?utf-8?B?cFpoK1VDaHkyWVNrRnZ5Ym4rZm1CUDFtYlFSUm5kWW5BMmQ2Wm9xTEI5ZGZY?=
 =?utf-8?B?d2JsaGRMelpwVUxITzA0ZERFNXJBSVlyZnp0eWlkVDUrcjJnaVY4T2M5WUFM?=
 =?utf-8?B?MlJLVTVwNjY5TXo1RWFvMGtYQWlBU3BNdytHT3R4NHBTZndwUFVmbndkaDJE?=
 =?utf-8?B?ckRVYzl0QmxJUTZpN1RHdzZLamcyYkYvV21xa3pYOVpLSEhodFpGcld0Mlda?=
 =?utf-8?B?WStYeE9OU2pWWTdsK3M0WGJWZEZBWXZYV3ZaNERac1ZFWWxJalovMm4xVU1K?=
 =?utf-8?B?Q3dNdjc3dXJ3OEhFWnZ0NXk1VTF0TDNETTEydHl1dG4yTU9YNTVoNlZRVmVH?=
 =?utf-8?B?VHBGRWVzOXZnd08yM01MZ09JZTE5NXZUZEtzaGdUTmwycWtYeVdNOTBLOUZz?=
 =?utf-8?B?aC8yYy9lQytQVFNoMGZBSzE4dVdLM0g3ZmZVQ0thTHVFYXhjMGUwYitoam9u?=
 =?utf-8?B?TVJUTjh2THFjUXVQT1Q4MHZGSXZMVHY3OEhFbjBKQnMxSWhxKzkrck0xM0JJ?=
 =?utf-8?B?blF1ZFI1K0k0YjIwZGZrMXRhTkdFVll0N0RyL3NUYU5qV0Vjd0k1TVFZaERx?=
 =?utf-8?B?WDNRdUpzUTIySHd3ZFJUbU50Z0ZKNmNIMUgrYXh1RXdCRE1RZDZWV1YyaDhz?=
 =?utf-8?B?Z3FwSEZQdVdJRWdaWDlSRDQ5Y1ZRVm82eS9QdTRrYThsN1NxOVBYZThtaG9u?=
 =?utf-8?B?VngyNUx4QWU3bG42TTQzcVRjUlcxUHlpam9DZ3FVK082cDZ0b09QR0I3a0Fh?=
 =?utf-8?B?OFJValNkZGNlWlZwcVF3T3JkTktPM29NaEIzMjFtNDR3d3lyN0UzNzNkaTdn?=
 =?utf-8?B?U2IrNmFOL3dYaWEwN092SXhBdklpblkvUHRaTTF0a1lYY0F2cFV0bG9tdWYy?=
 =?utf-8?B?QkE5aHhXd2VwYmh5OGMzaGNPVWdpbENhNi91L2sxSzdKKytiQWJIWmVyUXRu?=
 =?utf-8?B?anNVeENnTE5kd0I1MUlsM21FS3k3alFEK21Wb1dOVFA1anhXdU85eGlsWGdZ?=
 =?utf-8?B?L2cwZEtoWFFidm9hOWRjM2N6ZjBIa2t5aGZsZnByMjZ4OVZkakRzYUk3Nkdy?=
 =?utf-8?B?NERkMndOcnZ4dEJkUUxpajFyK01ibjRBbmxZcEVoZTd3SXFGL1I4dldYcnh4?=
 =?utf-8?B?VjJFSUZ3czVwWW1zTDNlRzRnemdRYnZ1dlFpeCs5MzNDTzU0T2lTL2hxd3JW?=
 =?utf-8?B?WEZQclYvY3FyOXhSTjdmQUpHa05VWEZQckhta2VwMHl5NVFVMDRCeDl4elhh?=
 =?utf-8?Q?wkUTVPEzc+Bn/MnwKMdPVVA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e26fdf-5282-478e-3a11-08dba7e4cd9b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8062.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 16:35:34.8425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdr2fe/wn6wsLn61ruzv79E1PTwHbXy4ae0KkpkhxztBoRliTn7hnk9IjcVQrvTFR04bOSQLE1nx7YGy7+jgdNO7O91duE00/lSZtB3NDKahtti3m2ySE194EtpA2U/+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8273
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Suzuki,

On 8/27/2023 2:35 PM, Suzuki K Poulose wrote:
> Hi Steve
> 
> On 26/08/2023 01:14, Steve Clevenger wrote:
>>
>> Unfortunately, I tested with the original patch not [PATCH V2]. I've
>> remedied this. My results below:
>>
>> [root@sut01sys-b212 linux]# cat
>> /sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_modes_available
>> auto flat catu
>> [root@sut01sys-b212 linux]# cat
>> /sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_mode_preferred
>> auto
>> [root@sut01sys-b212 linux]# echo "catu" >
>> /sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_mode_preferred
>> [root@sut01sys-b212 linux]# cat
>> /sys/devices/system/cpu/cpu123/ARMHC501\:23/tmc_etr35/buf_mode_preferred
>> catu
>>
>> As with the V1 patch, auto defaults to catu.
>>
>> I expected to see tmc-sg (former default) as an available mode, but do
>> not. As I recall, the buffer mode defaulted to ETR scatter-gather prior
>> to this patch. Must this capability now be explicitly advertised? I've
>> seen this done as "arm,scatter-gather" in device trees, but not used by
>> Ampere. Perhaps someone can enlighten me.
> 
> Yes, you must add that property to the TMC-ETR node (for both DT and
> ACPI). In the past, almost all of the TMC-ETRs (except Juno board)
> locked up the system while using the SG mode (due to the interconnect
> issues, something to do with the transaction). Thus, we decided to
> add a property explicitly enabling this for a given platform.
> 
> When you mentioned, it was using TMC-ETR SG mode, how did you verify
> this ? Please be aware that the table allocation code etc are shared
> by both TMC-SG and CATU.
> 

You might recall how this started. I had no way to test the CATU due to
the order the ETR modes defaulted (Flat, ETR-SG, CATU). For test
purposes, I programmatically swapped the ETR-SG/CATU order and could
then verify CATU operation by the driver calling into CATU code. This
suggests Flat mode was bypassed, and the driver defaulted to ETR-SG
prior to this hack. This didn't offer the user any control, hence my
feature request. Note that most of the early Ampere self-hosted trace
collection used ETR-SG. Now I can't select it.

How is this property described in the ACPI? The "ACPI for CoreSight™ 1.1
Platform Design Document" (DEN0067) doesn't describe this.

Thanks,
Steve


> Kind regards
> Suzuki
> 
>>
>> Steve C.
>>
>> On 8/23/2023 4:10 PM, Steve Clevenger wrote:
>>>
>>> Here's some quick feedback. My system shows two modes available; auto
>>> catu
>>>
>>> etr_buf_mode_current is writable. I expected to see tmc-sg (former
>>> default) listed in etr_buf_modes_available but it doesn't show up.
>>>
>>> Note that both the auto and catu etr_buf_mode_current settings default
>>> to catu. My understanding is auto should revert to the default behavior.
>>> On my system the default was tmc-sg.
>>>
>>> More later.
>>>
>>> [root@sut01sys-b212 kernel]# cat
>>> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_modes_available
>>>
>>> auto catu
>>> [root@sut01sys-b212 kernel]# cat
>>> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
>>> catu
>>> [root@sut01sys-b212 kernel]# echo "catu" >
>>> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
>>> [root@sut01sys-b212 kernel]# cat
>>> /sys/devices/system/cpu/cpu20/ARMHC501\:60/tmc_etr96/etr_buf_mode_current
>>> catu
>>>
>>> Steve C.
>>>
>>>
>>> On 8/21/2023 12:40 PM, Steve Clevenger wrote:
>>>>
>>>> Hi Suzuki,
>>>>
>>>> I may be able to test it this week. You've already pointed me at the
>>>> patch thread(s). The main holdup is I need to merge the 6.6 pending
>>>> platform work in order to use the Ampere ACPI. I couldn't get these
>>>> patches to apply directly to 6.4 last I tried.
>>>>
>>>> Steve C.
>>>>
>>>> On 8/18/2023 2:39 AM, Suzuki K Poulose wrote:
>>>>> Cc: Steve
>>>>>
>>>>> Steve,
>>>>>
>>>>> Are you able to test this with CATU ?
>>>>>
>>>>>
>>>>> On 18/08/2023 09:21, Anshuman Khandual wrote:
>>>>>> Currently TMC-ETR automatically selects the buffer mode from all
>>>>>> available
>>>>>> methods in the following sequentially fallback manner - also in that
>>>>>> order.
>>>>>>
>>>>>> 1. FLAT mode with or without IOMMU
>>>>>> 2. TMC-ETR-SG (scatter gather) mode when available
>>>>>> 3. CATU mode when available
>>>>>>
>>>>>> But this order might not be ideal for all situations. For example if
>>>>>> there
>>>>>> is a CATU connected to ETR, it may be better to use TMC-ETR scatter
>>>>>> gather
>>>>>> method, rather than CATU. But hard coding such order changes will
>>>>>> prevent
>>>>>> us from testing or using a particular mode. This change provides
>>>>>> following
>>>>>> new sysfs tunables for the user to control TMC-ETR buffer mode
>>>>>> explicitly,
>>>>>> if required. This adds following new sysfs files for buffer mode
>>>>>> selection
>>>>>> purpose explicitly in the user space.
>>>>>>
>>>>>> /sys/bus/coresight/devices/tmc_etr<N>/buf_modes_available
>>>>>> /sys/bus/coresight/devices/tmc_etr<N>/buf_mode_preferred
>>>>>>
>>>>>> $ cat buf_modes_available
>>>>>> auto flat tmc-sg catu    ------------------> Supported TMC-ETR buffer
>>>>>> modes
>>>>>>
>>>>>> $ echo catu > buf_mode_preferred   -------> Explicit buffer mode
>>>>>> request
>>>>>>
>>>>>> But explicit user request has to be within supported ETR buffer modes
>>>>>> only.
>>>>>> These sysfs interface files are exclussive to ETR, and hence these
>>>>>> are
>>>>>> not
>>>>>> available for other TMC devices such as ETB or ETF etc.
>>>>>>
>>>>>> A new auto' mode (i.e ETR_MODE_AUTO) has been added to help fallback
>>>>>> to the
>>>>>> existing default behaviour, when user provided preferred buffer mode
>>>>>> fails.
>>>>>> ETR_MODE_FLAT and ETR_MODE_AUTO are always available as preferred
>>>>>> modes.
>>>>>>
>>>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>>> Cc: Mike Leach <mike.leach@linaro.org>
>>>>>> Cc: James Clark <james.clark@arm.com>
>>>>>> Cc: Leo Yan <leo.yan@linaro.org>
>>>>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>>>>> Cc: coresight@lists.linaro.org
>>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>>> ---
>>>>>> This applies on v6.5-rc6
>>>>>>
>>>>>> Changes in V2:
>>>>>>
>>>>>> - Renamed sysfs file etr_buf_modes_available as buf_modes_available
>>>>>> - Renamed sysfs file buf_mode_current as buf_mode_preferred
>>>>>> - Renamed etr_supports_flat_mode() as etr_can_use_flat_mode()
>>>>>> - Renamed coresight_tmc_groups[] as coresight_etf_groups[]
>>>>>> - Reused coresight_tmc_group[] for trigger_cntr and buffer_size
>>>>>> - Fallback trying ETR_MODE_AUTO when user preferred mode fails
>>>>>> - Moved ETR sysfs details into coresight-tmc-etr.c
>>>>>> - Dropped etr_can_use_flat_mode() check while offering ETR_MODE_FLAT
>>>>>> in sysfs
>>>>>> - Moved struct etr_buf_hw inside coresight-tmc-etr.c
>>>>>> - Moved get_etr_buf_hw() and etr_can_use_flat_mode() inside
>>>>>> coresight-tmc-etr.c
>>>>>> - Updated month in
>>>>>> Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
>>>>>>
>>>>>> Changes in V1:
>>>>>>
>>>>>> https://lore.kernel.org/all/20230728084837.276551-1-anshuman.khandual@arm.com/
>>>>>>
>>>>>>    .../testing/sysfs-bus-coresight-devices-tmc   |  16 +++
>>>>>>    .../hwtracing/coresight/coresight-tmc-core.c  |  15 ++-
>>>>>>    .../hwtracing/coresight/coresight-tmc-etr.c   | 111
>>>>>> ++++++++++++++++--
>>>>>>    drivers/hwtracing/coresight/coresight-tmc.h   |   3 +
>>>>>>    4 files changed, 131 insertions(+), 14 deletions(-)
>>>>>
>>>>>
>>>>> Looks good to me.
>>>>>
>>>>> Suzuki
>>>>>
>>>>>
> 
