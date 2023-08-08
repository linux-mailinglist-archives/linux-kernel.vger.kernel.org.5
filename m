Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8531773786
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 05:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjHHDRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 23:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjHHDRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:17:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD08121;
        Mon,  7 Aug 2023 20:17:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKKwvLAm8YRYX0UssyxtmuEN7PEyIH+NqAhIXcBPXy7+fiVQMESJNa5WIORepdJxmaBXO6QYqAoPzmhJMv1u+tVe0ncgSwMKFoioOPT65HvlbQLuz/DAHhZ+R4PyaBBQA7u8i6UK0K8HO9SRY8oq64Hr0acKEr2q5Le+SHaXay3sbVKXbPXWLbHmQLJ09cq2xu2HKkJz/sNurjmT/D6VwUfFBO+0f4r4L5s7723sLkhripXgcsevFJKJWEqkP1QTXmJ7DVCWXkzaMSLv5E3AmklPza52XznQIBEFoonPrM6TJ9J2EbgaDSJQJ9n/W3ZNErOpDHthLkQB7mXuKG7vyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdfdwSKY+8sgskLtvJ6VrPmwBgz8azui54rjacT5+nA=;
 b=BE1lfrx7TgAGs5UNncxTTJ5oVIBXz5+SjfB6lcTMRVzvQ4pA9WxvwBZo3aV5/OMEvdYiGRP/ZLougXL/OwAcb+j2uMvpQJVi1R9Qo083EBeaLONtvToNe71/YHffVCdB7s1R/v44kPZE69QVLF98Mxm003OBgeML1zD3X6pA16bvOsrMMDhmm3r4NFuSPQB9a0lznRUlNywmm3QTnK9nAVandCZ4d1mpRLvGU+PJxqPPsdpG9v04gMb5DYKL8Xzl9grHwNiemNFIplDlvxRd09KSyiiLF231UB/dcGP6RYahfZ4fGezEXCwy0vjE5tIGBRmyAtwYCsQIq8BoChHFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdfdwSKY+8sgskLtvJ6VrPmwBgz8azui54rjacT5+nA=;
 b=NENwyMqGxAgHbh3jYCqMHhvzMNz+sjVAXiWk4JckZqMVjAKzZB6Ayst7ZardSYhMwUxl/lq5g1T44DJ5utvHFtNr12tBhZO0XOWsjCGHwRoc44xgLZ10b5GTdH1xPti6HnbD+qVAV7WH1iDQNJ+lEcJ9xznUhHJD/lZBrHPQvnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB5013.namprd12.prod.outlook.com (2603:10b6:a03:1dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 03:17:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 03:17:32 +0000
Message-ID: <894b3737-1a0a-4139-9c73-686a95481795@amd.com>
Date:   Mon, 7 Aug 2023 22:17:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] platform/x86/amd: Introduce AMD Address Translation
 Library
To:     Yazen Ghannam <yazen.ghannam@amd.com>, bp@alien8.de,
        linux-edac@vger.kernel.org, hdegoede@redhat.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org, avadhut.naik@amd.com
References: <20230802185504.606855-1-yazen.ghannam@amd.com>
 <20230802185504.606855-2-yazen.ghannam@amd.com>
 <58934edf-4fad-48e0-bc5d-62712b11e607@amd.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <58934edf-4fad-48e0-bc5d-62712b11e607@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:5:74::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: 692cda97-9f38-492f-8885-08db97be016b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3I6WrxYPrVTyNi4NiySNw1Aigi5GTw2jLLmOu3uZq0aRXOi6RGeTHfVrU5Qc0RAwU0kPQIjSEulMao5HA3vNBxBnirJuyeyxUdrWFi60fTmpvVCYzRIrK24iW+C3ubC06CWG+157zuUvKNZL0fvevWxj8jrCkvjkpvmiTTDikjk+nOxwFds2eYAE+0rteB73XaydaRnbYoAroSxB/MjvimtX/zWIzUriUa7pJFWIclFfkhZZUkBoMJWc8p3eUdXNiD0FaUrkgSJpK1VCoL35Bga96YReI9X/8+ZKv/w1/hzF8XYhbiFgVPuuqmcdUji+pqo/Z4tnPY7E0d/jroj//TesqMOStsgoZGkx9LEXeGJD+rhclEcyfPBCxvCl01sn7h1WwQctYoPJ+XsLifwbIuInK0vJv0JJ6Bu0/DMqpF+hse/Y+OBqHFV3odCtaKis2dQWRp6lhFhPgFKK08x1b7Iy0jJu6NqMHsdd3I+51PilTJE8LafjJJJYksjssSWo4Npvfq7OwtfsHbM/ECDNjEU/ThPKPkjSkkrThZs+YPOIkDFjerhBEcVA/uunkAv4Idvz9SdfyBx2n9ioZslsifr05fVeA5/XjAYA8R9G7IhMgGUyqn6z2IqTZJ7cVbTu84SMofxVKiNWvgq9gurG0HH7DPbgISQlRZAn5BpWYWWlu+wS1GDHi2tCFth85IPgxFM5bpLDvjtJxIT6DqKryA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(90011799007)(451199021)(90021799007)(186006)(1800799003)(8676002)(8936002)(5660300002)(4326008)(41300700001)(316002)(86362001)(83380400001)(31696002)(2906002)(6512007)(6486002)(2616005)(6506007)(53546011)(26005)(36756003)(66476007)(66556008)(66946007)(478600001)(31686004)(110136005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHpLdmdUY3dHNkR6SWlqWVVyR2g1SXI0cUJPaEF2U01LazJRK3Uvd0lvOUlI?=
 =?utf-8?B?M1pkbHVoNGZsbkNSUXlsUVhmQ2Vxc3JXMENOLzVweWtoMW95UzBJRHl0MnRE?=
 =?utf-8?B?Ujl6aEhZOEk4RTdUMjdTUzFCME1CdGNQTGthaUNnYUUvTklVdk1tZWZSVVhI?=
 =?utf-8?B?ZDhUZHVTUEM2QTF0R0RGTU1KTEJKNlBvbHJWM0dla2E1TXhiS2tIbzRIb1Mw?=
 =?utf-8?B?SVhvRVhwOEFnTXQydEs4TGYxaitNNkVRSHpsN3MrazhPd0JtRElBMU9uRHhJ?=
 =?utf-8?B?cnFCbEViRXVtRjRrZkZsWE9FL0x2bUVKbE1mVmVzRktTMzVjd2pxSmJldkFF?=
 =?utf-8?B?QlY0dGxpejVMSExnclBJaXM1MGhSYWJWSUkwTVpiSXhiKzlWQnZhU3FqWWE2?=
 =?utf-8?B?SE9QcUV1aVJ2WWJzcU1ISDExMURLeklWSnorZEhTZ0JRUjJhcVBiakgrVUdx?=
 =?utf-8?B?a3IzVUZTSDk3Zk92RUVyaTRvak9INHRNU3hUOS9EWTVYSjJFWDhyaVg0R0o1?=
 =?utf-8?B?REcwaTJpY2kyaHhENGRvMEdPc0NmbStBLzNyM2JpbWhCY0pEdUpVMnlVdzhP?=
 =?utf-8?B?Wk1tYTFLZGlaeDRTTkpobVAxNHF6MldBK2pUeTAvVEpqL1M1Tkt0TkNhNlZB?=
 =?utf-8?B?dHlwU1gyQU83RndQZEp4S2NxeVFwY2FUZ1NBdWJvQXdOWjV5UDN3dUp2M2tW?=
 =?utf-8?B?V3NwZDVTVDgzWldzZXZUUVp3ZWtqcGNDdEgyeFBoLzkvRnY1aDNWY1J0STMv?=
 =?utf-8?B?OU9DemREdkZRK0xvL1dMWi8rNEp2czFKR0U5QlR5VU1FNFNQVk5DaCtnaDZi?=
 =?utf-8?B?ZDY5MStuYUQwV2tCRnJJa2lBWXZFT0xkOGxPL1F0RU1RSmI0S0V1OThocWtl?=
 =?utf-8?B?L0tweEVXTHVvbTBqL3N3N0xCR2owUkdWbFc5ZWxEZkU0ZkEwQUVxZUg4bkIy?=
 =?utf-8?B?NG5yUmpwVnFQOW9ES2oyUCs4SWpsMFJ6UGtYTjVwTWlDenNsMG0vclVXUUtx?=
 =?utf-8?B?dytDU1BvbHB0dzg4dXhxUkRUdlRTLzZ6Y3pLb2hKVWVlQVpUdUVHSkltSkh3?=
 =?utf-8?B?VHU0aFcrTjR6QVMrUnNPTUc4U3ZuR0JHL1RGakxDQWkxNDk4dFNBZjMrRk5y?=
 =?utf-8?B?bmFFT3pqSXlBakd5OWxtUnE3eU9sQVJIU0ZuSTBBRHVlVy81Zyt6RVRLZ1ln?=
 =?utf-8?B?bzgvd2VDaEZLNmpUNTIyWWNNTkljcG01UXptQmFGR0hRd09HWXo5RXR1YmE4?=
 =?utf-8?B?RTYwU1gwZHJranFmekdKWnpBNmFRQk84VWFFcGJ6YjQyTFpBbWMvejI3cXRM?=
 =?utf-8?B?ZnY3SjJyUzFJNW5TbU8xWXRBREJIU0VRLy9UM2pCRWJnVUM2WG9uaGxZQk1K?=
 =?utf-8?B?TEFCaE1QbDA3TDFYV3VxTkNvdTJkUXNFcFdsYW8zZVUwN2U4SUlHbHNSbjFx?=
 =?utf-8?B?NzRWbkVmM2RVOWc2YW9LcDI0am1DUWsrNFZubDRTTHJsMG0wTjE3ams4U0xx?=
 =?utf-8?B?S0pNNmNUU28rdXp1R3lsMU1vZ0lkcHpDK3c0aFBZQ0NRWjZ5dEVCbTJkQjMx?=
 =?utf-8?B?L3NYZGJ5OVlZZ0UrMjZMYk51TUZTQXF4YjU2YjRyUWVIRXhtU0NlMGtqemQw?=
 =?utf-8?B?SVB3MzUwcnBOYUx6QkNoOUtaZEdQdnl6SDFWTTFKdE5YWmxwUlRNLzFFOE5m?=
 =?utf-8?B?YUttdFpXL015UDJTL0NkSDJMdTBkS3dZaWIxcWxmZVl5YkFOWThneHlYeDZ5?=
 =?utf-8?B?aFdVVTlPYkU0MmtBQzQ3WEhac1BncXY3SnRITE5TeVNrcmV0dFR5bFNsZGt2?=
 =?utf-8?B?aHZMQVhKVkplS0NrcXd5eDZqcWhMVnpSSFhqaWQzSkEwcy9hQXhBcXR0TUlS?=
 =?utf-8?B?dllDM1RuODllT1dIQnoreFBOdVFKbVFoMnVQSWVKaHg2NWxqZXRVTkxwbVdL?=
 =?utf-8?B?U0JwNWJQbmdrc0ZQZHZmQklQYlpwVHR5WE1BbFlEMUZFL2hVZkYwdy9OUkVs?=
 =?utf-8?B?Tlh0L0ZNV0ZqcmVsYXZvNUZta1FiaTZCbXUwUTRSM2JQZXhPeU5ZNXA0dlRz?=
 =?utf-8?B?MXZQcEUwaFJ1RFZSQ0Y1SGV1OHJZZGdzS3Q0djZwc3haRlRCRTlBNDNjSlY5?=
 =?utf-8?Q?SdRsjIhL+Lt/IoMmcqkalV2ho?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692cda97-9f38-492f-8885-08db97be016b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 03:17:32.8628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9Cigs4b5HWbyPkErfMgmLcPt1wycp0MvALLyW8rmTPdoZceuPj9pwzO+hu2EtGzpvrnG1T3p7JCNqrR+9Ez+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5013
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/2023 3:44 PM, Yazen Ghannam wrote:
> On 8/2/2023 2:55 PM, Yazen Ghannam wrote:
>> AMD Zen-based systems report memory errors through Machine Check banks
>> representing Unified Memory Controllers (UMCs). The address value
>> reported for DRAM ECC errors is a "normalized address" that is relative
>> to the UMC. This normalized address must be converted to a system
>> physical address to be usable by the OS.
>>
>> Support for this address translation was introduced to the MCA subsystem
>> with Zen1 systems. The code was later moved to the AMD64 EDAC module,
>> since this was the only user of the code at the time.
>>
>> However, there are uses for this translation outside of EDAC. The system
>> physical address can be used in MCA for preemptive page offlining as done
>> in some MCA notifier functions. Also, this translation is needed as the
>> basis of similar functionality needed for some CXL configurations on AMD
>> systems.
>>
>> Introduce a common address translation library that can be used for
>> multiple subsystems including MCA, EDAC, and CXL.
>>
>> Include support for UMC normalized to system physical address
>> translation for current CPU systems.
>>
>> Future development to include:
>> - DF4.5 Non-power-of-2 interleaving modes.
>> - Heterogeneous CPU+GPU system support.
>> - CXL translation support.
>> - Caching of common intermediate values and results.
>> - Leverage UEFI PRM methods as alternate backends to existing native
>>    code.
>>
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>>   MAINTAINERS                                |   7 +
>>   drivers/platform/x86/amd/Kconfig           |   1 +
>>   drivers/platform/x86/amd/Makefile          |   1 +
>>   drivers/platform/x86/amd/atl/Kconfig       |  20 +
>>   drivers/platform/x86/amd/atl/Makefile      |  18 +
>>   drivers/platform/x86/amd/atl/access.c      | 107 ++++
>>   drivers/platform/x86/amd/atl/core.c        | 212 +++++++
>>   drivers/platform/x86/amd/atl/dehash.c      | 459 ++++++++++++++
>>   drivers/platform/x86/amd/atl/denormalize.c | 644 ++++++++++++++++++++
>>   drivers/platform/x86/amd/atl/internal.h    | 307 ++++++++++
>>   drivers/platform/x86/amd/atl/map.c         | 659 +++++++++++++++++++++
>>   drivers/platform/x86/amd/atl/reg_fields.h  | 603 +++++++++++++++++++
>>   drivers/platform/x86/amd/atl/system.c      | 282 +++++++++
>>   drivers/platform/x86/amd/atl/umc.c         |  53 ++
>>   include/linux/amd-atl.h                    |  18 +
>>
> 
> Hi all,
> 
> I'd like to get feedback on the most appropriate place for this code.
> 
> I want to move this out of EDAC, since it's not really an EDAC feature. 
> And it needs to be used by subsystems other than EDAC.
> 
> I thought x86 Platform Drivers, because the code is very 
> platform-specific. And there are already some AMD platform drivers. But 
> there isn't any platform control or management for this translation. 
> It's just reading registers and calculating values. So it's not really a 
> "platform driver" in the sense that it manages platform-specific behavior.
> 
> Another option is for this code to be in arch/x86/ras/. But I would like 
> the option for this code to be built as a module, at least for debug and 
> development. And I don't know that modules, nor platform-specific code, 
> should be in arch/.
> 
> Currently, I think this could go in drivers/ras/. This address 
> translation is needed for RAS use cases, so making it a part of "RAS 
> Infrastructure" may make the most sense.
> 
> Boris, Tony, (and others) what do you think?

Given it's 'library code' to be used by a bunch of things and also want 
to be able to use a module, what about putting it in lib/?  There's 
plenty of library code there as tristate.


