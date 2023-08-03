Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED39576E736
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbjHCLpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjHCLpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:45:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6365D1B2;
        Thu,  3 Aug 2023 04:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+c2JSLr/Dppsx1FKcs+T3uXnZ1COzWko2a319TodFvo6BMuuL8VoK+Csw6FoIxllTM4hmx3mwWQdtoifWlXUiF5+Z4MHXXVlsc5zNRTloPgpBrS5P1pE0e1ilG3vxziv8OdeYnqZDhKBsIrwQgg8pdlLo8RDVUAlS7v6/nMX8tTXZN9QNWxrO3eD/IO4QJVHrTiO0NMs8Ojw1K5euyfvt7hkIgZRWBMuEMTDQQv9idy1iEL9dNt/MNIL+TPqYSylLQQwk48VpaPJROSuA2FgLPC4AqL76BxI3lTUjlDOoSfeADOLKEdqawb4YMpD7Iqw9I1OaYTBXFuDaAeVjDpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lu+wC0PxVjJ7uGLbs6/xXrfQy4Dg0pk0PPmTnmf0HiQ=;
 b=aVOj6/KkQUk/4urbtkun7hPHF9RTqVOwhL1UMsbGbym8TKis0Uez6mBqN//p+zH6ACzopKQeZ7Qm7Fz19/v9ANE1OtRIdSC2u9i1JZHd6nyunbFJ1snTejP9dzJe/KUf1oYA6/nHZPLMCwQgSaD+f3GKck2zhuSBG8ofv9VYBHaHiTD+kkFK4cP5+zMOHBIdE5gf3kyCzhLgGjitpUkSEfHCjog3O+YiesWBaDPsGFx3BW26YxkcnIlsmWLIxkjeNLFk2QyGJacjhKZvuzyknN1y7GdDq+DuEt7akrym13teYg3SiFDly1JMPfFACjBAEo/MR2AT33CkmyhPcUX6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu+wC0PxVjJ7uGLbs6/xXrfQy4Dg0pk0PPmTnmf0HiQ=;
 b=aRUYBIkOiTj4+41YSfHGLUJ+flnTnKH3Xey5vKuiHIfWIz5t+2jY+txlzs4TRGdNKvDYc0U+LBjRh35R0W/xS6ZNNa8c4g3nKVRdVwdgYbfsYeKLyJR5R2QLdOcuKlDB1WQXMJ6BCLPz8Q3gsRYR9iZs9VVqLIXCcOFw8HUlYcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 11:45:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 11:45:36 +0000
Message-ID: <7309421c-b373-19da-33eb-8940ac8f06d4@amd.com>
Date:   Thu, 3 Aug 2023 06:45:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] tpm: Drop CONFIG_HW_RANDOM_TPM
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     jarkko@kernel.org, peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jason@zx2c4.com, dragonn@op.pl
References: <20230803015015.915-1-mario.limonciello@amd.com>
 <20230803015015.915-4-mario.limonciello@amd.com>
 <dcbf7a17-67e3-d97d-bd18-9b0bd917a6cf@molgen.mpg.de>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <dcbf7a17-67e3-d97d-bd18-9b0bd917a6cf@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0110.namprd05.prod.outlook.com
 (2603:10b6:803:42::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f9a364-b9cf-4de4-111a-08db94172701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LcSLfWCOeQfhNoe4fioEJqJQw/ub0NONrhzs6sabM7G6Ug7PJXW/cAAkJW2Jb5oYFqaij6FYolxcJbjra2o7cm3KLs41alkDsGdtHXcD/g63jpgzFBpkmay6wn3i7GsgkrQ7SwEU6ismpJz0OahqWaFyrPpuegdfAJrbiWeWf0hlSFeq26RI6Fm2EvXTFzaVp9nhl2DrDPk/O5t1MugK9DMa0vUaqmfHFhuFEUoUV9HJPX9A2ZsWQ7M/qdk76+hjFxUlsMWRCQ+htVCHxeWDkMXNJnqzLsU2OPfb2btdRU0P1whsC5K/yq5p2aEu7aHOmZHXCezOfQquE9tsLSwt3elhz1ELvEvDlsJlTYcPyWiA9ogQ5XjCfl+QCJf5jpxwBIRnFt29p735XYSumPlcuI1VoC6w6I6Ps8lVL+ckK4Q7d011v126aGDh+ktbCZFOmhQ/AK5K/TtIPYZVNbqe20+v4HNbofLzw3tgB3Oha/PwwxBueZ9Hijv2iHglX+RwP8zCiNmsuf6QwnYAHHAZW2iwbGFPtgjbxVr/QFtCrNMGeoWKrLOXD9IIqiMfydH218TERnm0SDoirPlOcSrWDJVI6mxaPcRskbIk6CRiObqVeb57igX8NF5VJjfmQBUIAM0YvP3Nn+BZn8WrOV1QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(2616005)(53546011)(6506007)(83380400001)(186003)(316002)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(6916009)(44832011)(41300700001)(8676002)(8936002)(6486002)(6666004)(6512007)(478600001)(38100700002)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eCtIRjFsdDFZa1V0N2g0QnhKZnFZcDZLbVpUNHhHZzJZV283dnN5U0hTOHF0?=
 =?utf-8?B?a2lLNnhRSXpHcXBHb1l5WS9JZDhOK2ZSdEJkTUNCSDUvTWRCZHcvcXVRc09y?=
 =?utf-8?B?VTloZmhTU2o0WE4rbEhGRlp5NGdhaEZwMlZuYnR5MG1Vd29ZRk5GSzRHTHQ1?=
 =?utf-8?B?aVRrdmdzTUNxR3hZdjhTMVRJRi9ncWtPVnJZQ08rUjVzL1kxY2NieU0xRlY2?=
 =?utf-8?B?b3hFTVNsOFVsVDZtWGdtbGFLTWRTV25pOU5OUXVQWTFWd1lqQ0pkOXNRZ2xz?=
 =?utf-8?B?ZnM3eHBLMmRQamdheXc4cEk2US9XTzMybEJneUp4WE54QnBEbVZpUTZDNjQ2?=
 =?utf-8?B?SE95ZjlZZFI2aC9VUHlod3U5VHdPQ2tGMzcxdGNHdlBndXVvUVlLV2JmYkdy?=
 =?utf-8?B?ZGNhVGlscEJidWcxZVYvalRKQ3A2Sy8ybE5oTldBMzVoTnNOYVZNRVFZQkds?=
 =?utf-8?B?aDFPemlRWmw3ZFp0Qkp3V3VkRloxWnIxM0ZCeHpTSW1rb0MyY3Z6MFVJNzE2?=
 =?utf-8?B?T1U4ZURFUGRtcEN6d2ErbHVUclV3WHVJYUNNdHlKWEVoWHNaNXhLWjd3Y2tF?=
 =?utf-8?B?SXMzcjhLL0VuRTBXUm5TK0RRRTZBK2J2TjhiaXhUVGN2T1RrcklYMnlCWnVj?=
 =?utf-8?B?QWcrNWs3bXRhT3F4cnRlOGdUWi9TNXBPMXlMOTBEWDhaS2hkKzBnb1lYc2wz?=
 =?utf-8?B?ak9xKzBxUmhSS2VKaU50NTBUV0dnT0lKbDRja3ZIU1JzbElRWERVcG1FSEMw?=
 =?utf-8?B?MEFmcDlzVUhIR1M3UGhENFVSWkxPUUZBV3VNUlhBTUNCeU5OTktCZnMva1Ni?=
 =?utf-8?B?UzZTblBpbGxNeG5lbnR5QTVsL3VzREY4aGxwdGtNRkpXcC9zdDJ2WlNUcnUz?=
 =?utf-8?B?Q1AwTTZyS0g0bzRlNUtQZ09lUmVoaks5YmVRemFBRE5VQzdmWTliTWZWaDJG?=
 =?utf-8?B?Rlp1UmxCeTNJU2FpUFVhK2FFaHVORExzRkk2bnBod1dWbFlJdklqemdPOWNV?=
 =?utf-8?B?T3JwUEdWVEovNGRVa3FxWE9WQnJDbkJHS1AwaU5ub1RVaHBzMGZyUnRNS0pJ?=
 =?utf-8?B?Y3Jlamc0ZXhYbXFDaVdKMGk0SlliVnVMYldVQTZNL2FyMmM1UENTd1pUWnRL?=
 =?utf-8?B?cEZrMzVja3NYUitkdFdGZEF1ZzBNT3gwMnprMDBYSHJiQm04K2R2Y2w5S3Z3?=
 =?utf-8?B?aGVPYlBrUUhnODRBaGNLNTIrb0ZZSWRqTjJIa3grSTk5Qms1aW5JQVFzM213?=
 =?utf-8?B?bk13cGJpY2hmb0pmNWI1Q0hsdHZaUDFHUnUrdk9ibzdQVkZqbkVlR1RDZ1Bz?=
 =?utf-8?B?RVJvMFlRM244YmNnRlpRWjVYSCtRWEp3TU8weEVNVnFPZ29VQVdlMGxHWnpv?=
 =?utf-8?B?eHdtU011OER5WG5hN3dwTitlNnQ3SjNpNzhrdHdDVVZRR2FjdGEybC92Qzhx?=
 =?utf-8?B?elpsYUZNMGdVcVlIM1ozVGhjcnVWNmlkM1E2OGZtdGxlSXRFeDNmeWp6VmdW?=
 =?utf-8?B?ZGYrc3BvNmpVYkh4K2RhTjNRR2hhRFpieWJwRk1wMlFNTlBYMTIza2NqSnBx?=
 =?utf-8?B?V3lxL2ZIU3A5UkFSMWxRejMzYTIyWGtMQi9SemcyZFdONXVzOTQ4UVpTcXp5?=
 =?utf-8?B?M1djUEpDUno5MlZFRWk0ODR0UFhPS0xCL0FOK2lTUTVTbDRybXRHSDlCUm1p?=
 =?utf-8?B?eVUyYm9RSXpFNHBWMm9aQ3hScWJOaC9sQkE5S2NuSkVFVWkzaEdyUTBlY3d4?=
 =?utf-8?B?dlR2M2J6NUhFNjFLVlcrT25leFJidHZRdG9pVmNLeXlWWnVDQTlzM1NLLzBL?=
 =?utf-8?B?Q1pQQkEwK0RPSWtDdkJPL3RGSS9OcHRBUHRPdFdrWXJsbDZCK1N1RmUrY1Ix?=
 =?utf-8?B?d0lwNzZDWnpFUXNIOUtnK0dpUWFCNi9iYm1MMFdQNTgxbzAxWWhsR3BjdGda?=
 =?utf-8?B?Rnl0NzlXUDc1RG9wMnhnZnpCcGtrQ0NCcVBSTnBTZTRBWHNXaDNROUUzNGhl?=
 =?utf-8?B?WkpNa1UzNkRETGdQRDZFeUxlOXVrcjU1UkpPTUVqVGEwRlplL0xkR3NxK2tV?=
 =?utf-8?B?ZWVSMGIvL25BY3ZMaEhnNVMyTmhTckJCc3c2c2FCaER0OE03MTJQM0QrRVBv?=
 =?utf-8?B?VmQveWI1TVZKWFM2U1lweDg2cjNCUWhPdyt1M3RWZDdYTXlRQUtsTHM4MkpL?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f9a364-b9cf-4de4-111a-08db94172701
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 11:45:36.5501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sk3c8QwDagiXYPzv4WsffePwFd/alhv06lLsL4Y64qTKUg2dJ+48InYBTFxNRtIUUdLt5CDSQLKo4QLJwgdquQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 02:22, Paul Menzel wrote:
> Dear Mario,
> 
> 
> Thank you for the patch.
> 
> Am 03.08.23 um 03:50 schrieb Mario Limonciello:
>> As the behavior of whether a TPM is registered for hwrng can be 
>> controlled
>> by command line, drop the kernel configuration option.
> 
> Shouldn’t this be left in to be able to set the default without having 
> to change the Linux kernel command line?
> 
It's the same thing as these commits:

b9b01a5625b5a ("random: use random.trust_{bootloader,cpu} command line 
option only")

d97c68d178fbf ("random: treat bootloader trust toggle the same way as 
cpu trust toggle")

So it matches the behavior of those.

> 
> Kind regards
> 
> Paul
> 
> 
>> Cc: Mateusz Schyboll <dragonn@op.pl>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/char/tpm/Kconfig    | 11 -----------
>>   drivers/char/tpm/tpm-chip.c |  6 +++---
>>   2 files changed, 3 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
>> index 927088b2c3d3f..69aaa730dc208 100644
>> --- a/drivers/char/tpm/Kconfig
>> +++ b/drivers/char/tpm/Kconfig
>> @@ -27,17 +27,6 @@ menuconfig TCG_TPM
>>   if TCG_TPM
>> -config HW_RANDOM_TPM
>> -    bool "TPM HW Random Number Generator support"
>> -    depends on TCG_TPM && HW_RANDOM && !(TCG_TPM=y && HW_RANDOM=m)
>> -    default y
>> -    help
>> -      This setting exposes the TPM's Random Number Generator as a hwrng
>> -      device. This allows the kernel to collect randomness from the 
>> TPM at
>> -      boot, and provides the TPM randomines in /dev/hwrng.
>> -
>> -      If unsure, say Y.
>> -
>>   config TCG_TIS_CORE
>>       tristate
>>       help
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index 8fb42232bd7a5..0d69335743469 100644
>> --- a/drivers/char/tpm/tpm-chip.c
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -533,7 +533,7 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
>>       if (!trust_tpm)
>>           chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
>> -    if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || 
>> tpm_is_firmware_upgrade(chip) ||
>> +    if (tpm_is_firmware_upgrade(chip) ||
>>           chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
>>           return 0;
>> @@ -639,7 +639,7 @@ int tpm_chip_register(struct tpm_chip *chip)
>>       return 0;
>>   out_hwrng:
>> -    if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && 
>> !tpm_is_firmware_upgrade(chip) &&
>> +    if (!tpm_is_firmware_upgrade(chip) &&
>>           !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
>>           hwrng_unregister(&chip->hwrng);
>>   out_ppi:
>> @@ -665,7 +665,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
>>   void tpm_chip_unregister(struct tpm_chip *chip)
>>   {
>>       tpm_del_legacy_sysfs(chip);
>> -    if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && 
>> !tpm_is_firmware_upgrade(chip) &&
>> +    if (!tpm_is_firmware_upgrade(chip) &&
>>           !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
>>           hwrng_unregister(&chip->hwrng);
>>       tpm_bios_log_teardown(chip);

