Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F007A76E702
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjHCLfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjHCLfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:35:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B861982;
        Thu,  3 Aug 2023 04:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKRs98AZ8f6TI0reVUnpurmWIMSbjO/U2DuWLp473M2HFUBkOHYhejHxc88XAlf1giQJM2mfY3gccmQ+ilOC8MGMOdtGtOH3s3dhgm8mYUiiePrhWV7ypFZGuW30cB+1BXaLL+INZA/nhVAj3m2j9R1yy+P2f1sKXV0G82WzoQu7vWiJqGIBg8hJME0nMHsqmgn43KxXAu/XMURNB6e7TgIqaDtb2Oio6K8hFs4HyIc9FwbekbAw6iQ5VnpgTzc2xbsgHwx4SOyPQ2NJ5XfQTsKlAD0jJrHTjOTdKfCSDgbYBLIuNBdZgPm3qJffsHpS5wYUlDI2TAKzIG4QkG3m7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhuGZbHsMRSPfME5wzrIIu5ADe7bTyxNq43ELcFPBns=;
 b=Wyxf8Gxp8wFsMjhnumdHxPdC7f/ggHB7eE6tcxv4XdC6w27shgZDSMYT5bEEPyc3uEOBLQG24zbCVFxoL0TgM3vOLdQH652QHqBYgRjkPnn8id54TSsypGGnWoWL43zkQ98GS0S3dO8Y7BSDL8V1qiNrlBzYFbIi5hDViwnx2IkSBfBTzWVRmvydpHAKdP+pd6yWrzdpCW55mniwcK/+9J+2SXNqihf0NiGBDrGzLyje1Qs0TIPqm610o+ipuX/KAoeuBchWFqzBZvUrJxtYeMV12Lcb5D5munyxXz11KAUr7FbR5wp5aimbWbA0MpnlORJJhk97xanRDpNeQU2mDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhuGZbHsMRSPfME5wzrIIu5ADe7bTyxNq43ELcFPBns=;
 b=D5MJ4NOUdrcHfFVrOnWn8ymlrKJV45/oNcK+/9092JO0OAkr012LlkcJ8NAyAYG9Xkr9H8s1b9TjM//z7ZRHhzeHzuE6OowJ+I3JSMgOEMC9+lWpFRXEJIhAvlgofsyO0iZhfiOKKUf6iWBTkpQL4/2X23A0WKXAh/19JQqoXTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8001.namprd12.prod.outlook.com (2603:10b6:806:340::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 11:35:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 11:35:39 +0000
Message-ID: <d19d0e9a-a788-8b33-506d-8a080d566366@amd.com>
Date:   Thu, 3 Aug 2023 06:35:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] tpm: Add a missing check for
 TPM_CHIP_FLAG_HWRNG_DISABLED
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason@zx2c4.com, dragonn@op.pl
References: <20230803015015.915-1-mario.limonciello@amd.com>
 <20230803015015.915-2-mario.limonciello@amd.com>
 <CUISBN0W36B2.1DXXNNGS6P7JC@suppilovahvero>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CUISBN0W36B2.1DXXNNGS6P7JC@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:806:120::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3bb26c-618f-416d-d360-08db9415c2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: td0iX+m+xJOzlKrjSLsadKWio1gtnMTz+fHCcsc499TKvjEwAfWBMtcdBu5XoJPBYp5Xd38XXfkW6c/dL/RzzLwmAjjBWsXW0D+SxGl5OQfG9zGEcvMJ+u1Gtd002ZsUqec/01HeXT9LWKilrtIpBcagy3JYApwDZpF9NeTSxfPkcrNPgJkHV/KDtjJwgPkxyU7NTxLroQ7NmvT6hJszkkDvhfhAC/WDg1+DyDwgSAVnbvq3q16bDW24SkuNMtGc19TaxFmE52KE2XYDZwC69PfpykMwct/g+DeT7GR65dTAvi+fk+oE+zeMF3wvmSVRnbc7ih3s2WfcdLiokxQfIx3ylv79yYS/fmTcN1N0NEZAVDFRLq2VpxdNbcXRnADG1atmPkdrWSsUXfANeThZ8xYKCIajs0/wwr02MGiMqyyQ2sqnhzVD2sCmw/YeRaHSvtcz4LQCGu9U8pQ0pEqsHvymqd/5bQszyE7aSSzJVkXiDXWhoKKKdeI3KtbK+Nie0jw1w0ysCI3iF+dBKDjzkAIkxUkJqcVRh2t6YSmfSXzNi8SkBU/qMynFJjLQkbJf0NvooMwtqmffBdN+torekE8jLnfzPQIiU4vwT46KlKlHfgVjjZnsz2tjvDWggszJ36mcvY7tev9u9J4x6fYcNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(2616005)(53546011)(6506007)(83380400001)(186003)(316002)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6486002)(6666004)(6512007)(478600001)(38100700002)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTNpZ0dHWlU2U09pdURZMHdDTldTbnkzZjlqUVJ6bmF2NG5YbE1SRUc2TmJF?=
 =?utf-8?B?Qk1yS3RvK3J5MXlvZkY1TWNoYjdITlhjZW00YlNXcUVWRzNQMHRBTVYrNllD?=
 =?utf-8?B?bkhEa3IvUW0wMEp2aStiTkhhd0tUVjhUZDZkRkxDSHE2aWRDTGpYTzNicERy?=
 =?utf-8?B?QjFYNGE4RVdVNEJuTG02dWN0TnZGb1dObDhqaGUyVldPNVF6Mlp4L0thRnpo?=
 =?utf-8?B?elNFSXRaamJKR3BFbHBjaUQ3bTU2WUxGTFdVcTU1NUNIRHNhZEJHTDZYS0tQ?=
 =?utf-8?B?bTlxcWJYSm5DKzYzcW55V2NkaDJicmltcDI2U2RDQVcwS2RBRHcxRnJhTURF?=
 =?utf-8?B?VnFMVlo4a1VVR2dhTmxpa0hxY0ljL081K05GTk40Q0NoQ3pSdEdRbVozM0lr?=
 =?utf-8?B?VW9Xd01LYXg4OUR5d1dwLzJqbU9KRTNaNVVOR0NzcTM1RDlSNmZGalR0d1Jq?=
 =?utf-8?B?bDcrNVFFaUxWTGtlT01leUFtVEU4R00zSEgvZmpFeEFGemQ2OHZmcW1SVGJV?=
 =?utf-8?B?MEwyb25EWC93cEFncUFxejBTMWpJWEVhSnhZbUlmb0hjQmIzb3JzWnJtUnQw?=
 =?utf-8?B?alZPdFBFSDR0UmRiY1RQdHZ4SXpvSE1LL1lLQWk4akdFUVVzK1FDcGZBcEdI?=
 =?utf-8?B?VkUyOWJUQkc4Ni95RS91dEhZN1ZIMmYwTXhJRExQcm5yNkVzQTYzSWVhOHIy?=
 =?utf-8?B?a0dPV1ZZS3llSDBLNlE2U3BObTZqaUlQRm5xVGhtVSsvd1J4clN2ZU10aE5J?=
 =?utf-8?B?MnVSRFh4MnhyY2s3NEhxUW1lK3hUcXlQcTlBbklDN2tuYWtUQVhrNkpiZ050?=
 =?utf-8?B?MlVNTUhYcXJmVVFreHFiUzMzYmVmQTdRK3Z2QWMyNzVCbFJ5VDlyb0xVaUF3?=
 =?utf-8?B?NnpjWm9HRFkvcnA4ZGpIaVRPM2xlTFNDTHdlSmp0YmNabW9QT3NzL1NJdlBZ?=
 =?utf-8?B?QjVnNlhhQ1RQWWhwMVRCZyswdHNoVVM3Y2N4cjdCa3RkVHpEbGgra1hGaHBu?=
 =?utf-8?B?M0pUSG5iNThWT0xkOFBUcFBFaHQ5a1BTWXZSS1BzRVJ2eWJYRHlheG5vcFRS?=
 =?utf-8?B?QXRoeHlONHErSmZ5aWsvTklIWGpCK2srUmdzNDIxSjFVVEt5aFF5aTVhZmRS?=
 =?utf-8?B?c3B2L3JwWXRXdkRXSEVUaDhNNUk3N3pqbDdQYkN0WnpMZ2JFYytabVdLajJH?=
 =?utf-8?B?OW5sN1B0WDlQNVBaREdXaE1YQ1QzRmMzd2ljN3lEdzZ1SmR3UmNwdkNnOVFj?=
 =?utf-8?B?NFBMSnR2cGdpbTZOSlYyL0NyWG9IL1VIQUFhR3BpS2tPeXdFemhrd3hXS3VF?=
 =?utf-8?B?S0ZXY1lla0xQeXU2bkFXNGJlUTdDM1cvWlRUeUIvNGNZZTVPSDROU0xsMHR3?=
 =?utf-8?B?QXJVOStQUVlrY0R3S3QvZmpXWlZmYndFQ0VrSTd3Y1hvaDhDeTVDd1haNDdJ?=
 =?utf-8?B?bGJtWEM0RFI1TFNwYlBXY2REcW5Fd0dDL05lYUQxQjN5VUhDaHVCNUNpS3p1?=
 =?utf-8?B?aTdOMXRKQXh1UFMvQ1JTS1F3OFY2WWVzM1J3dnByTzJUNUZoVk9OZkFRVXM1?=
 =?utf-8?B?cjlKRkp6U3BVL3A4MnoxWGRDbXJyV2VHMUFWcm43N1h3UFE3b3QrZm9ER3cw?=
 =?utf-8?B?RVhPNzJIMzE2Z3FXM3ExaWV4dFpMRFRnWlBIdVU3NWpocnM1SWc2cDNvK0dZ?=
 =?utf-8?B?aDFPK1ltQkxOT0l5QkNSY0tDT2VpVHJxSmlNU3NEMVMxb3lXVTB2TURMTllN?=
 =?utf-8?B?S0xoQ3NKZ3pta0xtMFlOSTR4UytUcThpSVhJU3V0NkJjalZueEZxUkpUcE9u?=
 =?utf-8?B?ZDZlV2NqaE1LUWpIbkNsTzRXZzhObGtRN2tUdW93OVFySFVXM0EyQTZWdHd0?=
 =?utf-8?B?TWlwR0paaDJuZ3hucCtKV3ArWlU0N29Td1AvU0kzY3lZZEU1Zkh0dkNnWUpi?=
 =?utf-8?B?TitDNXhhNDRPQmk3YXg3K1QxeHVRUnE3SVo4K2hzcUVwL25aNUZDRkFOTlhV?=
 =?utf-8?B?MmJGZzcyRFA2MFBPVFNGNEdOeDA0MDVWS0x1M3ByZ1lvQ2tMRVVLY0JsdHJW?=
 =?utf-8?B?dDBUN3hteXdLWVRvb2htVEVRRFpmamdDekZubG5PV2x0cHJSN2FYRDZnak1F?=
 =?utf-8?B?bzRUT0RUczIwWGc2RG9nRGFjRE9OOUZDV0RLcmx6RkszZmFJWXN1S3h6R0xv?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3bb26c-618f-416d-d360-08db9415c2f0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 11:35:39.0819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4BTVzotBve8YXbgNmH5H6QdfZsFr2CAKKbrHAHKSBDSAhej1+KNbon9gzzJ+0y8xc/IE+S2WrtvRFbQ7q+4+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8001
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 03:59, Jarkko Sakkinen wrote:
> On Thu Aug 3, 2023 at 4:50 AM EEST, Mario Limonciello wrote:
>> If the TPM is opted out of hwrng the error handling for
>> tpm_chip_register() needs to know this so it doesn't try to clean
>> up an uninitialized chip->hwrng.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/char/tpm/tpm-chip.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index e904aae9771be..8f61b784810d6 100644
>> --- a/drivers/char/tpm/tpm-chip.c
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -629,7 +629,8 @@ int tpm_chip_register(struct tpm_chip *chip)
>>   	return 0;
>>   
>>   out_hwrng:
>> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip))
>> +	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) &&
>> +	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
>>   		hwrng_unregister(&chip->hwrng);
>>   out_ppi:
>>   	tpm_bios_log_teardown(chip);
>> -- 
>> 2.34.1
> 
> Please add a fixes tag.
> 
> BR, Jarkko

I didn't add a fixes tag because you hadn't sent a PR for the other one 
yet so I wasn't sure the hash would be stable.  Also I thought it might 
just make sense to squash into it.

If the hash is now stable, could you just just commit and add that tag 
with it yourself?  Or do you want me to re-send as a v2 with that?
