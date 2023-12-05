Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920EB804B18
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344610AbjLEHYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344331AbjLEHYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:24:18 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C7ACB;
        Mon,  4 Dec 2023 23:24:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjNfGhMSyXI43NcapcaG8okbCLbraaAuMnE2SQarrD+u8hPc25qH2BNP93S5oP5M28FvP2gAcOjOVCubRvZoh0cTZdCaZvCAS7gluUzgIrYwgS3L6DDv3ducmYPs+mj0CoeMQ/puTtQz5ex96sbuUr4e7obLIEI1DISSCStZJRvWhLwOBFjTmaY02DNLludAJLOE1jEKgj7sZCIG1fybKHpLNHLXR5dvtEDp492mxMatvFRs+6v3m7vpLtxSBTIZE4+WtPr/oyXbW74rEH+3C8OvLq0wKQpPR5PH+zGBZZojO8l8hIKFvCYwqK866YHr57mwvNnIZQEwHfc3MQuwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zB8T9ioGtlg0ZwPiC9d7wk3Ce+msY8s1neTCZkdiJA=;
 b=ZSWCjedx4MBoUnDgVDA5bAok8b2dPXmetMC88woebNFkD02GtIxuLKnBdEISszL/Wl+07azQZJRQADjEwYGTkxhevPTYBzzDWL0K37OCVvJrIk//6DaEZtv6Fh8VcNaX4u6W3+BaS/dNb9Zy9Ty5gnWZBXGwTOd07VtZ9hx2x+py9PK8oagfGwGUAvcspfqfJK+Xc+jHRbrmSgUzDc9LbpwIwNlUajvOd2dCsY2jROJT0Lb3EiI0yOhi6ToI7Nwt63Anqqm72L4Oyw4p4niNq+PKa1v+ljHV3FAawh4nyRexRUx0WpiuNOSA/UeYW2W6MTDY6PF8DJSW8hL3UpuBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zB8T9ioGtlg0ZwPiC9d7wk3Ce+msY8s1neTCZkdiJA=;
 b=3tHLu37YEnrkck6cPvObYkOZ6Ipx4G8dRqV6ISWLuZf7PpQJlL8142w1VhUZ8PcE4smrdPVpBBAnLDSwdkar55A6Tc+4Y0nxGmWOPXSIjbIKRHCNEtU9COqtR9JXvZ7C6PIu7hqkADWmGEHCcNYAsJU9Ql1Q+HRI2ghdEGx/UiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 07:24:21 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%4]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 07:24:21 +0000
Message-ID: <2398c8f4-2ac6-4ebf-9b4b-03687d05206e@amd.com>
Date:   Tue, 5 Dec 2023 15:24:08 +0800
User-Agent: Mozilla Thunderbird
Cc:     majun@amd.com, Evan Quan <quanliangl@hotmail.com>
Subject: Re: [PATCH v14 2/9] platform/x86/amd: Add support for AMD ACPI based
 Wifi band RFI mitigation feature
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
        lenb@kernel.org, hdegoede@redhat.com, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20231129091348.3972539-1-Jun.Ma2@amd.com>
 <20231129091348.3972539-3-Jun.Ma2@amd.com>
 <0eb714e7-c30d-456b-aef5-0342dfc947c6@amd.com>
From:   "Ma, Jun" <majun@amd.com>
In-Reply-To: <0eb714e7-c30d-456b-aef5-0342dfc947c6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ce0a15-dc7e-4375-f58d-08dbf5633322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1PgOOkQJlLPNjgVh5ccBJf+F2cF4HlpztEVBCTF1eVxVaJW0eqMshgFutU16paxmkp4Kk9MCt/sh/SYIe8wnk7SJnyaeFz26ho3Bn2uKtuPTqFsF1Iz+DT4LHgxIbYICBm3ncxQqhwhJhC3SonCh2tAWpRP2WnkH6poO4J3N5bhqjVdzOB7BF2FK7spRavfzipHh5vWdERdGb0veaqEF4KySBm+j+ecospgHJrWkOHrYkfQTIeys1dkkssGYMdTG/q+/cdLbZXCLe2vVnkC5NnLUP9N+oXn9/mKWQGg5RKknDHqUr6HJJ6M5VColZ8VG65TxznZ9WrfkX3WAdmcgu8h8M/xnocSMqvOvF0XupkLERiCyl+7WLvsbWiUqvuqn4nSRWWwcqi4lR7LRTb4dBmJoJ+uh7Wm5LKM4qR1SMBjsdNB1gUyYy+iV9d8Biv4uhr5ICYo4WEFeGFuHzuAA2Eo9YrT6Rgj9MJ929Y4Q1Wv8bXh/tLl2r5oq1qzDvqaa58Cm+C2iel7/+HuTrMtoZMIv1q4qCu5BF1XqYybO4sCvN8Ew+98PWmUJskq546xVaMivaIWmmFRkdGMxo22qDgoV8mVaat8OT+TdTGVLvqJnj0pHKSCeH4/+8xy0lrXGNiNxjqGPTQ2aZJ0USh17M1pSYEgNyiPL3d5X8svPxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(921008)(6512007)(45080400002)(478600001)(6506007)(8676002)(6486002)(53546011)(2616005)(6666004)(26005)(110136005)(4326008)(66476007)(66556008)(66946007)(83380400001)(8936002)(316002)(38100700002)(30864003)(7416002)(36756003)(41300700001)(5660300002)(31696002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzZrNlZBVnhtZVhhUDRZTU5adWRiR3FSWkJ4VzkzMDNnUWxWTVRkRTN6REls?=
 =?utf-8?B?RU82amRoZ1ZZRlY5aGFEOXpkQkFyT2szS0hIZURqNUVuYjEwdXRVRllUaEdT?=
 =?utf-8?B?N1BOcFpRdFMyRkxnTW9TZ3paeDhZV25Jb2VqdUlkenhKbnRIYzF4MFlWclRK?=
 =?utf-8?B?TmFIMEUxWUV6LzdZbVJNckwxelB6aVFIM2gwaEZOd3NHWEhwWkg3RGk3MFFt?=
 =?utf-8?B?eUJlTnM2QitUS0VGRm02MFduU0Nabkd4NE55M0RIZlFOcDZlTWlkYkNya2VB?=
 =?utf-8?B?dm5LK2tic3pycHlUZWZUZHJsQXhKcjlZbjNtUnpRcFhwZ1l3MW9icC9iMW9s?=
 =?utf-8?B?Ly8xbTVZYnFNc2E1N0s4K2FzMGUyRk8zY1lkYmVJeldVN1JTWVBLQm1xN3U4?=
 =?utf-8?B?dlpBdk05Mi90d05obzNKbXhQa1cxUlphSCtwUGpiZzRJd0RrU1VUM3JkZEtw?=
 =?utf-8?B?N0lsNml4TkorVVdtdm03ZzZ4ak95ZXYyc1E0MFZwNnRSRGFsVzRqVWRwOEs3?=
 =?utf-8?B?RFAxeTdoU0R0WE9kOVVGUTNGT21VcllDNGVQMksvVjNyZWhRYWcxc3Q4dU5z?=
 =?utf-8?B?K3IxUmhkYVlEWVBIQUF5TlhSc0dXMFQxL21HbDcxZ0ZSc1lMaUNCelJNbFUx?=
 =?utf-8?B?bEpGaktOUURNai9JMkNHNDNmMzRGbmdKR1lta0tuZVlwK0VPMlV2NzlMVkJz?=
 =?utf-8?B?Qko3U1VWS1Z3VUZKaTFaam5iTEJsRFl2U2piWVMwRGY2KzZ0a2VQSDJ0eVZh?=
 =?utf-8?B?Z2pxMml0ajhWYkxWcjVJMzdVL01zY2dpOGJ3bGJMODUxcHJTSEp1T2FBdFZI?=
 =?utf-8?B?VDlha1BycXFLY3ovMHcweTFSUFpQQWd2V2tlQWVLMjcwY2JBRlFGL1JSY2FJ?=
 =?utf-8?B?clFyOXN1d3ZSQnQzTThhdktmN3BCbk5tSGgwaGFQSTlmUEhlcHRnaElhZzhH?=
 =?utf-8?B?L05LdEpZdDJEUDNCTlU4WGFmWlZIc3A5Y2sxTUQvaUtBWE9saktVYnpWSVVD?=
 =?utf-8?B?ZW8wMm1tWWN4NmxkZ3hNWXNJWmI4Z1VpUDV2OVVwNUxhOHliTG9RUncvT25k?=
 =?utf-8?B?dGZHVFBBRWRxYlgxTHFqb1k0K3JIQVpRRGVQY0lFYStBR29YcmhsWFpoSmh5?=
 =?utf-8?B?bFlXK3p6clJDeHFwOUJqc2FIUzlGNDNpTVBEMWxuOXd2ekJ4cE1HTXdOME84?=
 =?utf-8?B?aEVBWlNOR0xqaUo1L3dGMk96SWFvQ1k4cElDWVFZL1ZMMmY1bXVVQVV1OFd0?=
 =?utf-8?B?U2pZSER6NFAycTFIS1h2S2h1aFpmendMZHpSQmViMkJjbnRzRlYzM3daUVBk?=
 =?utf-8?B?RUJ6aXo0SVdVYm1mRTBCRmo1NVlSY2FOcnBBQ0FDaysxTHh5MGVtMFkwKzJY?=
 =?utf-8?B?RFJ5VGIxc1JZUjIxSDNpN0RaellKekt0QWZBcTFrV2g2VzlGWDJsenFzVUdQ?=
 =?utf-8?B?WnQyYlRCeGR0RllkUTNLVzdlUkQ3UlJzdnRVYjdGeW0ycndQYURHN2Jyejl5?=
 =?utf-8?B?VEhmRVZReXpNWW5BSGFEN3hrUDRnVjNuZmNRQTJ5VzIxQ09DUlBKb0l1OVlx?=
 =?utf-8?B?SDM2dWhBalN0V2pIdmJZeGpRS2twVzBtbGtTQXp6WkRLaVAyMWxzNDhjOVF2?=
 =?utf-8?B?eExkSFlmOUx0MFViQ3d3dTNDWStKOFd1K1VJSkc5bjBTNVpMc25SQXFuUUd2?=
 =?utf-8?B?YVBFc0JEcitsVnk3U0JNZFpJdlRHanVDVzFpZG1meHFWTElWRTUzUzNpVm9C?=
 =?utf-8?B?M2llNHMxME41RHROZUhnUnBpeU41a1BpUVNjMjI3VE4xbm1aVW8wYUVFWHYz?=
 =?utf-8?B?Nks3dnV4THNucS8xTEg5MWNjSjk3MjhkVU9iSkErQnVrM1daYmVGQndzK0o0?=
 =?utf-8?B?YUduRzFEMnhkNU9pcnR4MFd5Rlg3OWpYd0JodUFBTXRPSmFZQmt3elR3eGxC?=
 =?utf-8?B?UFBET0JCTXRqZG00blFkN3RsYjNMcGJ3Mitja1dzVmpaUndkSlliZjJ3d2Jr?=
 =?utf-8?B?ekhEQS9sOVVWOHNSWDJxL2srZUJvakpTbnJqZjdMZXRnb05kVmhVTisvbGxK?=
 =?utf-8?B?NEQ5MEIzU2NKRU5WVUkxVjRLVUVGUHpYbUttSzVXcTdxQUk1dkMvd0FNVDVX?=
 =?utf-8?Q?gOprapMUIVeT2O8xUfJh529SW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ce0a15-dc7e-4375-f58d-08dbf5633322
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 07:24:21.2724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5PXDtbXLs7y+uF2NtjPYpOjveA/mjf6MIB//Jv7h9E58C8+6kAaSKk2RaOHS9G/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On 11/30/2023 1:24 AM, Mario Limonciello wrote:
> On 11/29/2023 03:13, Ma Jun wrote:
>> Due to electrical and mechanical constraints in certain platform designs
>> there may be likely interference of relatively high-powered harmonics of
>> the (G-)DDR memory clocks with local radio module frequency bands used
>> by Wifi 6/6e/7.
>>
>> To mitigate this, AMD has introduced a mechanism that devices can use to
>> notify active use of particular frequencies so that other devices can make
>> relative internal adjustments as necessary to avoid this resonance.
>>
>> Co-developed-by: Evan Quan <quanliangl@hotmail.com>
>> Signed-off-by: Evan Quan <quanliangl@hotmail.com>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> 
> I have one very minor nit below that if no other feedback is needed for 
> the series can be fixed when committing.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
>>
>> --
>> v11:
>>   - fix typo(Simon)
>> v12:
>>   - Fix the code logic (Rafael)
>>   - Move amd_wbrf.c to drivers/platform/x86/amd/wbrf.c
>>   - Updated Evan's email because he's no longer at AMD.Thanks
>> for his work in earlier versions.
>> v13:
>>   - Fix the format issue (IIpo Jarvinen)
>>   - Add comment for some functions
>> v14:
>>   - Use the apci_check_dsm and acpi_evaluate_dsm (Hans de Goede)
>> ---
>>   drivers/platform/x86/amd/Kconfig  |  15 ++
>>   drivers/platform/x86/amd/Makefile |   1 +
>>   drivers/platform/x86/amd/wbrf.c   | 337 ++++++++++++++++++++++++++++++
>>   include/linux/acpi_amd_wbrf.h     |  94 +++++++++
>>   4 files changed, 447 insertions(+)
>>   create mode 100644 drivers/platform/x86/amd/wbrf.c
>>   create mode 100644 include/linux/acpi_amd_wbrf.h
>>
>> diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
>> index 55f3a2fc6aec..ac2b7758a04f 100644
>> --- a/drivers/platform/x86/amd/Kconfig
>> +++ b/drivers/platform/x86/amd/Kconfig
>> @@ -18,3 +18,18 @@ config AMD_HSMP
>>   
>>   	  If you choose to compile this driver as a module the module will be
>>   	  called amd_hsmp.
>> +
>> +config AMD_WBRF
>> +	bool "AMD Wifi RF Band mitigations (WBRF)"
>> +	depends on ACPI
>> +	default n
> 
> I believe the "default n" is unnecessary as it's implied.

Thanks for review. I'll fix this and other issues your commented
in the next version.

Regards,
Ma Jun

> 
>> +	help
>> +	  WBRF(Wifi Band RFI mitigation) mechanism allows Wifi drivers
>> +	  to notify the frequencies they are using so that other hardware
>> +	  can be reconfigured to avoid harmonic conflicts.
>> +
>> +	  AMD provides an ACPI based mechanism to support WBRF on platform with
>> +	  appropriate underlying support.
>> +
>> +	  This mechanism will only be activated on platforms that advertise a
>> +	  need for it.
>> diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
>> index f04932b7a7d1..dcec0a46f8af 100644
>> --- a/drivers/platform/x86/amd/Makefile
>> +++ b/drivers/platform/x86/amd/Makefile
>> @@ -8,3 +8,4 @@ obj-$(CONFIG_AMD_PMC)		+= pmc/
>>   amd_hsmp-y			:= hsmp.o
>>   obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
>>   obj-$(CONFIG_AMD_PMF)		+= pmf/
>> +obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
>> diff --git a/drivers/platform/x86/amd/wbrf.c b/drivers/platform/x86/amd/wbrf.c
>> new file mode 100644
>> index 000000000000..36e90a1159be
>> --- /dev/null
>> +++ b/drivers/platform/x86/amd/wbrf.c
>> @@ -0,0 +1,337 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Wifi Frequency Band Manage Interface
>> + * Copyright (C) 2023 Advanced Micro Devices
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/acpi_amd_wbrf.h>
>> +
>> +#define ACPI_AMD_WBRF_METHOD	"\\WBRF"
>> +
>> +/*
>> + * Functions bit vector for WBRF method
>> + *
>> + * Bit 0: WBRF supported.
>> + * Bit 1: Function 1 (Add / Remove frequency) is supported.
>> + * Bit 2: Function 2 (Get frequency list) is supported.
>> + */
>> +#define WBRF_ENABLED		0x0
>> +#define WBRF_RECORD			0x1
>> +#define WBRF_RETRIEVE		0x2
>> +
>> +#define WBRF_REVISION		0x1
>> +
>> +/*
>> + * The data structure used for WBRF_RETRIEVE is not naturally aligned.
>> + * And unfortunately the design has been settled down.
>> + */
>> +struct amd_wbrf_ranges_out {
>> +	u32			num_of_ranges;
>> +	struct freq_band_range	band_list[MAX_NUM_OF_WBRF_RANGES];
>> +} __packed;
>> +
>> +static const guid_t wifi_acpi_dsm_guid =
>> +	GUID_INIT(0x7b7656cf, 0xdc3d, 0x4c1c,
>> +		  0x83, 0xe9, 0x66, 0xe7, 0x21, 0xde, 0x30, 0x70);
>> +
>> +/*
>> + * Used to notify consumer (amdgpu driver currently) about
>> + * the wifi frequency is change.
>> + */
>> +static BLOCKING_NOTIFIER_HEAD(wbrf_chain_head);
>> +
>> +static int wbrf_record(struct acpi_device *adev, uint8_t action, struct wbrf_ranges_in_out *in)
>> +{
>> +	union acpi_object argv4;
>> +	union acpi_object *tmp;
>> +	union acpi_object *obj;
>> +	u32 num_of_ranges = 0;
>> +	u32 num_of_elements;
>> +	u32 arg_idx = 0;
>> +	int ret;
>> +	u32 i;
>> +
>> +	if (!in)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(in->band_list); i++) {
>> +		if (in->band_list[i].start && in->band_list[i].end)
>> +			num_of_ranges++;
>> +	}
>> +
>> +	/*
>> +	 * The num_of_ranges value in the "in" object supplied by
>> +	 * the caller is required to be equal to the number of
>> +	 * entries in the band_list array in there.
>> +	 */
>> +	if (num_of_ranges != in->num_of_ranges)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Every input frequency band comes with two end points(start/end)
>> +	 * and each is accounted as an element. Meanwhile the range count
>> +	 * and action type are accounted as an element each.
>> +	 * So, the total element count = 2 * num_of_ranges + 1 + 1.
>> +	 */
>> +	num_of_elements = 2 * num_of_ranges + 2;
>> +
>> +	tmp = kcalloc(num_of_elements, sizeof(*tmp), GFP_KERNEL);
>> +	if (!tmp)
>> +		return -ENOMEM;
>> +
>> +	argv4.package.type = ACPI_TYPE_PACKAGE;
>> +	argv4.package.count = num_of_elements;
>> +	argv4.package.elements = tmp;
>> +
>> +	/* save the number of ranges*/
>> +	tmp[0].integer.type = ACPI_TYPE_INTEGER;
>> +	tmp[0].integer.value = num_of_ranges;
>> +
>> +	/* save the action(WBRF_RECORD_ADD/REMOVE/RETRIEVE) */
>> +	tmp[1].integer.type = ACPI_TYPE_INTEGER;
>> +	tmp[1].integer.value = action;
>> +
>> +	arg_idx = 2;
>> +	for (i = 0; i < ARRAY_SIZE(in->band_list); i++) {
>> +		if (!in->band_list[i].start || !in->band_list[i].end)
>> +			continue;
>> +
>> +		tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
>> +		tmp[arg_idx++].integer.value = in->band_list[i].start;
>> +		tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
>> +		tmp[arg_idx++].integer.value = in->band_list[i].end;
>> +	}
>> +
>> +	obj = acpi_evaluate_dsm(adev->handle, &wifi_acpi_dsm_guid,
>> +				WBRF_REVISION, WBRF_RECORD, &argv4);
>> +
>> +	if (!obj)
>> +		return -EINVAL;
>> +
>> +	if (obj->type != ACPI_TYPE_INTEGER) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	ret = obj->integer.value;
>> +	if (ret)
>> +		ret = -EINVAL;
>> +
>> +out:
>> +	ACPI_FREE(obj);
>> +	kfree(tmp);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * acpi_amd_wbrf_add_remove - add or remove the frequency band the device is using
>> + *
>> + * @dev: device pointer
>> + * @action: remove or add the frequency band into bios
>> + * @in: input structure containing the frequency band the device is using
>> + *
>> + * Broadcast to other consumers the frequency band the device starts
>> + * to use. Underneath the surface the information is cached into an
>> + * internal buffer first. Then a notification is sent to all those
>> + * registered consumers. So then they can retrieve that buffer to
>> + * know the latest active frequency bands. Consumers that haven't
>> + * yet been registered can retrieve the information from the cache
>> + * when they register.
>> + *
>> + * Return:
>> + * 0 for success add/remove wifi frequency band.
>> + * Returns a negative error code for failure.
>> + */
>> +int acpi_amd_wbrf_add_remove(struct device *dev, uint8_t action, struct wbrf_ranges_in_out *in)
>> +{
>> +	struct acpi_device *adev;
>> +	int ret;
>> +
>> +	adev = ACPI_COMPANION(dev);
>> +	if (!adev)
>> +		return -ENODEV;
>> +
>> +	ret = wbrf_record(adev, action, in);
>> +	if (ret)
>> +		return ret;
>> +
>> +	blocking_notifier_call_chain(&wbrf_chain_head, WBRF_CHANGED, NULL);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_add_remove);
>> +
>> +static bool acpi_amd_wbrf_supported_system(void)
>> +{
>> +	acpi_status status;
>> +	acpi_handle handle;
>> +
>> +	status = acpi_get_handle(NULL, ACPI_AMD_WBRF_METHOD, &handle);
>> +
>> +	return ACPI_SUCCESS(status);
>> +}
>> +
>> +/**
>> + * acpi_amd_wbrf_supported_producer - determine if the WBRF can be enabled
>> + *                                    for the device as a producer
>> + *
>> + * @dev: device pointer
>> + *
>> + * Check if the platform equipped with necessary implementations to
>> + * support WBRF for the device as a producer.
>> + *
>> + * Return:
>> + * true if WBRF is supported, otherwise returns false
>> + */
>> +bool acpi_amd_wbrf_supported_producer(struct device *dev)
>> +{
>> +	struct acpi_device *adev;
>> +
>> +	adev = ACPI_COMPANION(dev);
>> +	if (!adev)
>> +		return false;
>> +
>> +	if (!acpi_amd_wbrf_supported_system())
>> +		return false;
>> +
>> +
>> +	return acpi_check_dsm(adev->handle, &wifi_acpi_dsm_guid,
>> +			      WBRF_REVISION, BIT(WBRF_RECORD));
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_supported_producer);
>> +
>> +/**
>> + * acpi_amd_wbrf_supported_consumer - determine if the WBRF can be enabled
>> + *                                    for the device as a consumer
>> + *
>> + * @dev: device pointer
>> + *
>> + * Determine if the platform equipped with necessary implementations to
>> + * support WBRF for the device as a consumer.
>> + *
>> + * Return:
>> + * true if WBRF is supported, otherwise returns false.
>> + */
>> +bool acpi_amd_wbrf_supported_consumer(struct device *dev)
>> +{
>> +	struct acpi_device *adev;
>> +
>> +	adev = ACPI_COMPANION(dev);
>> +	if (!adev)
>> +		return false;
>> +
>> +	if (!acpi_amd_wbrf_supported_system())
>> +		return false;
>> +
>> +	return acpi_check_dsm(adev->handle, &wifi_acpi_dsm_guid,
>> +			      WBRF_REVISION, BIT(WBRF_RETRIEVE));
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_supported_consumer);
>> +
>> +/**
>> + * amd_wbrf_retrieve_freq_band - retrieve current active frequency
>> + *                                     bands
>> + *
>> + * @dev: device pointer
>> + * @out: output structure containing all the active frequency bands
>> + *
>> + * Retrieve the current active frequency bands which were broadcasted
>> + * by other producers. The consumer who calls this API should take
>> + * proper actions if any of the frequency band may cause RFI with its
>> + * own frequency band used.
>> + *
>> + * Return:
>> + * 0 for getting wifi freq band successfully.
>> + * Returns a negative error code for failure.
>> + */
>> +int amd_wbrf_retrieve_freq_band(struct device *dev, struct wbrf_ranges_in_out *out)
>> +{
>> +	struct amd_wbrf_ranges_out acpi_out = {0};
>> +	struct acpi_device *adev;
>> +	union acpi_object *obj;
>> +	union acpi_object param;
>> +	int ret = 0;
>> +
>> +	adev = ACPI_COMPANION(dev);
>> +	if (!adev)
>> +		return -ENODEV;
>> +
>> +	param.type = ACPI_TYPE_STRING;
>> +	param.string.length = 0;
>> +	param.string.pointer = NULL;
>> +
>> +	obj = acpi_evaluate_dsm(adev->handle, &wifi_acpi_dsm_guid,
>> +							WBRF_REVISION, WBRF_RETRIEVE, &param);
>> +	if (!obj)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * The return buffer is with variable length and the format below:
>> +	 * number_of_entries(1 DWORD):       Number of entries
>> +	 * start_freq of 1st entry(1 QWORD): Start frequency of the 1st entry
>> +	 * end_freq of 1st entry(1 QWORD):   End frequency of the 1st entry
>> +	 * ...
>> +	 * ...
>> +	 * start_freq of the last entry(1 QWORD)
>> +	 * end_freq of the last entry(1 QWORD)
>> +	 *
>> +	 * Thus the buffer length is determined by the number of entries.
>> +	 * - For zero entry scenario, the buffer length will be 4 bytes.
>> +	 * - For one entry scenario, the buffer length will be 20 bytes.
>> +	 */
>> +	if (obj->buffer.length > sizeof(acpi_out) || obj->buffer.length < 4) {
>> +		dev_err(dev, "Wrong sized WBRT information");
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +	memcpy(&acpi_out, obj->buffer.pointer, obj->buffer.length);
>> +
>> +	out->num_of_ranges = acpi_out.num_of_ranges;
>> +	memcpy(out->band_list, acpi_out.band_list, sizeof(acpi_out.band_list));
>> +
>> +out:
>> +	ACPI_FREE(obj);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(amd_wbrf_retrieve_freq_band);
>> +
>> +/**
>> + * amd_wbrf_register_notifier - register for notifications of frequency
>> + *                                   band update
>> + *
>> + * @nb: driver notifier block
>> + *
>> + * The consumer should register itself via this API so that it can get
>> + * notified on the frequency band updates from other producers.
>> + *
>> + * Return:
>> + * 0 for registering a consumer driver successfully.
>> + * Returns a negative error code for failure.
>> + */
>> +int amd_wbrf_register_notifier(struct notifier_block *nb)
>> +{
>> +	return blocking_notifier_chain_register(&wbrf_chain_head, nb);
>> +}
>> +EXPORT_SYMBOL_GPL(amd_wbrf_register_notifier);
>> +
>> +/**
>> + * amd_wbrf_unregister_notifier - unregister for notifications of
>> + *                                     frequency band update
>> + *
>> + * @nb: driver notifier block
>> + *
>> + * The consumer should call this API when it is longer interested with
>> + * the frequency band updates from other producers. Usually, this should
>> + * be performed during driver cleanup.
>> + *
>> + * Return:
>> + * 0 for unregistering a consumer driver.
>> + * Returns a negative error code for failure.
>> + */
>> +int amd_wbrf_unregister_notifier(struct notifier_block *nb)
>> +{
>> +	return blocking_notifier_chain_unregister(&wbrf_chain_head, nb);
>> +}
>> +EXPORT_SYMBOL_GPL(amd_wbrf_unregister_notifier);
>> diff --git a/include/linux/acpi_amd_wbrf.h b/include/linux/acpi_amd_wbrf.h
>> new file mode 100644
>> index 000000000000..15b54734a080
>> --- /dev/null
>> +++ b/include/linux/acpi_amd_wbrf.h
>> @@ -0,0 +1,94 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Wifi Band Exclusion Interface (AMD ACPI Implementation)
>> + * Copyright (C) 2023 Advanced Micro Devices
>> + */
>> +
>> +#ifndef _ACPI_AMD_WBRF_H
>> +#define _ACPI_AMD_WBRF_H
>> +
>> +#include <linux/device.h>
>> +#include <linux/notifier.h>
>> +
>> +/* The maximum number of frequency band ranges */
>> +#define MAX_NUM_OF_WBRF_RANGES		11
>> +
>> +/* Record actions */
>> +#define WBRF_RECORD_ADD		0x0
>> +#define WBRF_RECORD_REMOVE	0x1
>> +
>> +/**
>> + * struct freq_band_range - Wifi frequency band range definition
>> + * @start: start frequency point (in Hz)
>> + * @end: end frequency point (in Hz)
>> + */
>> +struct freq_band_range {
>> +	u64		start;
>> +	u64		end;
>> +};
>> +
>> +/**
>> + * struct wbrf_ranges_in_out - wbrf ranges info
>> + * @num_of_ranges: total number of band ranges in this struct
>> + * @band_list: array of Wifi band ranges
>> + */
>> +struct wbrf_ranges_in_out {
>> +	u64			num_of_ranges;
>> +	struct freq_band_range	band_list[MAX_NUM_OF_WBRF_RANGES];
>> +};
>> +
>> +/**
>> + * enum wbrf_notifier_actions - wbrf notifier actions index
>> + * @WBRF_CHANGED: there was some frequency band updates. The consumers
>> + *               should retrieve the latest active frequency bands.
>> + */
>> +enum wbrf_notifier_actions {
>> +	WBRF_CHANGED,
>> +};
>> +
>> +#if IS_ENABLED(CONFIG_AMD_WBRF)
>> +bool acpi_amd_wbrf_supported_producer(struct device *dev);
>> +int acpi_amd_wbrf_add_remove(struct device *dev, uint8_t action, struct wbrf_ranges_in_out *in);
>> +bool acpi_amd_wbrf_supported_consumer(struct device *dev);
>> +int amd_wbrf_retrieve_freq_band(struct device *dev, struct wbrf_ranges_in_out *out);
>> +int amd_wbrf_register_notifier(struct notifier_block *nb);
>> +int amd_wbrf_unregister_notifier(struct notifier_block *nb);
>> +#else
>> +static inline
>> +bool acpi_amd_wbrf_supported_consumer(struct device *dev)
>> +{
>> +	return false;
>> +}
>> +static inline
>> +int acpi_amd_wbrf_remove_exclusion(struct device *dev, struct wbrf_ranges_in_out *in)
>> +{
>> +	return -ENODEV;
>> +}
>> +static inline
>> +int acpi_amd_wbrf_add_exclusion(struct device *dev, struct wbrf_ranges_in_out *in)
>> +{
>> +	return -ENODEV;
>> +}
>> +static inline
>> +bool acpi_amd_wbrf_supported_producer(struct device *dev)
>> +{
>> +	return false;
>> +}
>> +static inline
>> +int amd_wbrf_retrieve_freq_band(struct device *dev, struct wbrf_ranges_in_out *out)
>> +{
>> +	return -ENODEV;
>> +}
>> +static inline
>> +int amd_wbrf_register_notifier(struct notifier_block *nb)
>> +{
>> +	return -ENODEV;
>> +}
>> +static inline
>> +int amd_wbrf_unregister_notifier(struct notifier_block *nb)
>> +{
>> +	return -ENODEV;
>> +}
>> +#endif /* CONFIG_AMD_WBRF */
>> +
>> +#endif /* _ACPI_AMD_WBRF_H */
> 
