Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DFF781913
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjHSKo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjHSKoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:44:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52854DA8B;
        Sat, 19 Aug 2023 03:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Po3w0SYbug+Vazx6oZdJnkRc7HwO0Usqq6CIFaKgRhVuLTsJN13VEc1P7uCpXJYBSaGw/tZEz9EqTHI/aNDU4WiVvVploqNgyN2SQGfhflTaEfTnhMTtYxuJBRYtkQxaHWU5aEmooxZUAcurrUEwCPDrdqHVtxBQCHmOkMyZ/GIb1wbWL6tHY9xZAOZF2JsOMCz6nPKwdSPOAyJ0xx4ZzBvp+YG/zSnpPnfobOx3NbnlSwqdnHpgJehisTPwF5u8j0Xl4KZMtNU/E4GLur81NvabMGiwEhMnWFYi9zt6uTUTLJWmsLtr3ykTfRYmdeeBuUYsh7DpltO7JRUOuwGvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsKdvsuFV3ztJdWZrcEnDelp2Acr5QS+fInxczrSYcw=;
 b=NIqvWN9TKRyyc1fCdMq7vgeKZsNGYW+5Ih3xR745Pn0HuJJvjgH4fuSPDlF5Rwa+wSbEAkAoBbqGfkFJ26EKBtJ5fxkODp0PuQV93VCN3ZFHv8Py/EThWEro0rwi5m7fv1HqZeoeSUCtCG2/ettgqLGnMFvUW12248ijbSfnBHDPoFRJMz9jP4Er3NGisyel4Sy5B1dZQYpke4GI1RiHE49Wk3DVHSghYPD7jxoIToOjGXf32XF/MIPUbr+jJppcWaGNvAFnSKRr3jpgGq/SGvGJpIeUdz6VPjbLqIuFXwGQuKHE8bE6JJEv06VXiZV+u2L8T3V9jgw9EFXYiSkU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsKdvsuFV3ztJdWZrcEnDelp2Acr5QS+fInxczrSYcw=;
 b=mZFeOtks05Dzt2WfZn671fG61GXKv90LUpKSGPL0uYAqR1JgiH9kuFY9tUY+9LH+r68kxNrtn8IQEO1E43wCVy2R3/RoH70Z9zI7bbhduH8FXFejL+3GK6tOdR3hwKIg+YovPoJh0jQ64bVT9irgTippS5HW7yG/g4xWd7OGqoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Sat, 19 Aug 2023 10:34:03 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::e64e:9886:22bf:e7e7]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::e64e:9886:22bf:e7e7%7]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 10:34:03 +0000
Message-ID: <cd226133-ed18-101b-6401-a6dcd89a1db8@amd.com>
Date:   Sat, 19 Aug 2023 20:33:47 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH] tee: amdtee: add support for use of cma region
Content-Language: en-US
To:     Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        SivaSangeetha SK <SivaSangeetha.SK@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Cc:     Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>
References: <7531423fcb3b18ff78737ae5eabc84b0e3cb2909.1692369704.git.Devaraj.Rangasamy@amd.com>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <7531423fcb3b18ff78737ae5eabc84b0e3cb2909.1692369704.git.Devaraj.Rangasamy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0040.ausprd01.prod.outlook.com
 (2603:10c6:10:4::28) To DM6PR12MB2843.namprd12.prod.outlook.com
 (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: 0def1362-400f-46e5-aec0-08dba09fce7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dN99c4FNkD0DimtR/FHUIipu9o5YYMSNmvJoElYS3ZIMn8b15Yr8Ar/2tWG00armtIu2iBauE2Wk8u8TdDmJvPHFY3/Hlio136aTEJXCARvx1YN7rReuXEfmAaSwXvhhtRhBF1WVZ8CXY+zYwhTDnSpZPrvkyPle2mHjLgWWobnUPGf/sQADwKRIwMPPp+7BCCm9miXx42T7xjOkZR5AqlTUFkYlrQxgOQqdeb9ahze1O9q6et2kb2jTQHIjskvJ/e2aWD2lnKuZdKfotHfGP9HfhHtKWRIf3ySD4boqAt5zL3NgBlxFhbpBdgMbmSiSb/0af9Ye3ePm1tYCucGj0bgF/ggkksCci1XLdq43jUcslzrSdOZg46HuTGoZYO3BEE7SK2hrIZvfSq9D347eiABLkPY8mjVNyzm2T11wY5NhwDMMyOPNb29MQBkaDJCGtpjUB0WhPMPfGAXlRIdKBQ880gW1/lPbiL8DCgBDnVGWOOs7Rv9/1JLgwGqgdbVAcOd/n1UfJX/Y3b/zln+39lQPvIqkZdQ6V20NCIl8PYPWSbotjTyZvJwTg9mmfQnbE+5LkJHo429c2b1qZqVuUaADA9NDNvdT57r1X4PpuwDvkmyg7antmge8H1PDQ6HlHED7Om5aCKeIPzabjQ9uz77fIZeQsnw+I8Whfnp7w2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199024)(1800799009)(186009)(31686004)(31696002)(36756003)(38100700002)(921005)(2616005)(110136005)(6666004)(66946007)(66556008)(66476007)(316002)(6486002)(53546011)(478600001)(54906003)(6506007)(5660300002)(26005)(6512007)(8936002)(4326008)(8676002)(41300700001)(7416002)(2906002)(83380400001)(30864003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0ttS2dQTmR4TVlTWkdaRzlLMW9OTm45T0hmckl4cmtBQ3N4OWhsb2Z4dDdk?=
 =?utf-8?B?SGVHa3RRRHFXc0VhdGdQbmg2M0FiZktlYWtEK2YrbWc1OS9FNFZJSTR3VGNZ?=
 =?utf-8?B?Z0UxeENvU3BKRE5iNkEwOTcvcFJtMjJOQ3hXOEtHNUNNRTB5TlpaZUhqZG9Q?=
 =?utf-8?B?REFrM0tYQk9EbWtCR2ZGM1kwbTlHT3IxYVM1dkJGTnhreEErRFVJNXpQbHRP?=
 =?utf-8?B?YVlQbzZyYlZVZjVNZURGQ0xNekcvUXIwUG5ieC9oMEt1YVMvOGZ2MEFHWUlB?=
 =?utf-8?B?MW5uODRNS3FEczBkeFlBV1J1Z1ZlVDJSeEZDQ0h4V2VYbGRHSDF4aFROaVBF?=
 =?utf-8?B?bko3a1FBT2VxMGkwbndtbVlCZi9qSFhkWXd5N1ZSajRZZEJUYllMV2luWitW?=
 =?utf-8?B?ZjRMY01pOWQrZzdmR21nUVVxN0hBd0FqZzcyS0I4V05Vbnh6anBvUkVvK3VR?=
 =?utf-8?B?Q1FZVWNDTGxaQ2FKajdqdyt2TWZ5dVlPUzg3Zy8xM1FUMWp4S01Uamc3VDl6?=
 =?utf-8?B?QzdVa09Gc0thVkVTK2NwbDN5NUYyUVZQdUdBQmVaWmtTUEhET1V5aTFoQ3Vk?=
 =?utf-8?B?TnFIOEMwNHd6ajlETjlucnlOampyZ3Fsb1NVWDBqSEt0TEgrenlXeGlhZnM3?=
 =?utf-8?B?YzJuTERFeUppaklpTlFlUXZ4UTNjRTByWHNndjRlZnZiL1dxcFdaWHV3ZzI2?=
 =?utf-8?B?ZitndSsvcWJBcmZiTi9jS1c1cUFxZnltVVVqVUlNLy8zQ0h3N3V3ZFl2M0k5?=
 =?utf-8?B?RjhKaWhNRmpYWnpCNW5BOHNjYmFKbXZDY3pXcG12NlRhL1J6NnVJTWJjdjZv?=
 =?utf-8?B?U1krMVErQU0rbnBsMVNyamRRWDRuK1lQUlYvc0wzUHBzWnhYTlBHSFk4dHpm?=
 =?utf-8?B?RWUzQVhlS3pybkNTa3cwcSs3VHoxdndjSE9ocmNjNTRNcEM5UDI1RTg1cktj?=
 =?utf-8?B?dTBKaWpldE1aMVd4S0E3YnpMbFdiN3BBUTZSVTlwMmNKclU2c0VyL01MRlln?=
 =?utf-8?B?T0I1REIyVy83TEMwY1UwNitma3V4K2pHSW5ydGtkOGdMdzVGMThaN3p3T3Er?=
 =?utf-8?B?UHpnbHZpY3BTR1psZExkODFQOHZISENKODZDSHFaSzRWSDJZQWFmaElHS0My?=
 =?utf-8?B?QlMyM09VeVlpQ0dYQy9rdnFubnlWVThNa2VLV0FILzUraUQyMG5mZndmQVFM?=
 =?utf-8?B?aGhONkp3cVlTcGhMWjlFeUh5UUZYV1FGSWN4b05ST2p5K0EySUI5YXBpdE1j?=
 =?utf-8?B?d3hkd0hPNG90ZHdqcVdJV0hTOGNweHdEOVUwR3I1VGYzT08xZ04rUVNLeS8r?=
 =?utf-8?B?NEtxanZSaVVnZ2NremNOWHpXUDd6aDNWL0dCa0QzQzFOaENMQlU5dFk5clJH?=
 =?utf-8?B?UHl2dE4wZS9YK3NWcE0yVHV6Zk5ITmJ1bE5ESW1taTRTYXpNclAzUzZmZjZ2?=
 =?utf-8?B?V0tIWW9xRmo2ZTBtdlg3ajlXMnVzRnpFcU1zdFBCc2w4MWg4enNWeUlUUHNG?=
 =?utf-8?B?aXhKdCtrdWNwR0VwcEk1V2lkck9UYlRHL1E3a2hhRlNYcnIvWkhWMmh5VU5V?=
 =?utf-8?B?S3Y1V3hVNDhnNFo5SDA2V1BjVzAwT01JRVZXKzJ3dmJ1N24veVBTRVhxMWlM?=
 =?utf-8?B?b1JDOXNobExFOTdNL3BXS1VMUmxrRVAyellCSjQwTkNVTGV1U0t6cThtRWU0?=
 =?utf-8?B?ZGx2THR3NTZ6THExMlZvSXRjaHFLeUQyQUdIY25EcC9iYk9zaTAxUzFnRDI3?=
 =?utf-8?B?dnZId3JyaXgrcS92SjNGdUdaekp6S3kxM2x1WG5UREVqR25EN2cra3pYdDEv?=
 =?utf-8?B?VjQwTHMwNHQxNWl5VGYyWjM3TjJkR1RhOWlqL3g2UzB4QVdSblN4L09HWDlU?=
 =?utf-8?B?YTJyZ3J4aU9BdEdZM0FCVW44ZElQYzZENld4YkhrWDhWdWh1RUdyemg5WWxO?=
 =?utf-8?B?bkt5cE5SUzRhbm5Bd1k1M0VwNWt1Y3dHUE9JREljMTVpcmlVYytSYTVQN1Q2?=
 =?utf-8?B?YlNEQ0owVmRScmhOcS9iRWh5YXJEeHN6NWF4d3ljS1k3ejFHVmpRSVY1aCtT?=
 =?utf-8?B?dU40aXM0TWtPT2xFMTh3aHJQUkpaOGlqWTJ2TDN5MG44dGhiNmRIejdpYkgx?=
 =?utf-8?Q?gVo7J7W0mGvKDdecDGsxXMLgT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0def1362-400f-46e5-aec0-08dba09fce7c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2023 10:34:03.2642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VjVucDg3g/jQmYbn86eOn14YctRYKrw6BSMvn7Nk0++DmhKNp1GvOGuyas9ryCCfe4mUfnhXMOuO/sbURyqBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/8/23 00:42, Devaraj Rangasamy wrote:
> In systems with low memory configuration, memory gets fragmented
> easily, and any bigger size contiguous memory allocations are likely
> to fail.
> Contiguous Memory Allocator (CMA) is used to overcome this
> limitation, and to guarantee memory allocations.
> 
> This patch adds support for CMA area exclusive to amdtee.
> The support can be enabled if kernel have CONFIG_CMA enabled.
> The size can be set via the AMDTEE_CMA_SIZE config option
> at compile time or with the "amdtee_cma" kernel parameter.
> (e.g. "amdtee_cma=32 for 32MB").
> 
> Also, cma zone is utilized only for buffer allocation bigger than
> 64k bytes. When such allocation fails, there is a fallback to the
> buddy allocator. Since CMA requires a boot time initialization,
> it is enabled only when amdtee is built as an inbuilt driver.
> 
> Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
> Co-developed-by: SivaSangeetha SK <SivaSangeetha.SK@amd.com>
> Signed-off-by: SivaSangeetha SK <SivaSangeetha.SK@amd.com>
> Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  7 ++
>   arch/x86/include/asm/setup.h                  |  6 ++
>   arch/x86/kernel/setup.c                       |  2 +
>   drivers/tee/amdtee/Kconfig                    |  9 +++
>   drivers/tee/amdtee/Makefile                   |  1 +
>   drivers/tee/amdtee/amdtee_private.h           |  6 +-
>   drivers/tee/amdtee/core.c                     |  6 +-
>   drivers/tee/amdtee/shm_pool.c                 | 32 ++++++--
>   drivers/tee/amdtee/shm_pool_cma.c             | 78 +++++++++++++++++++
>   drivers/tee/amdtee/shm_pool_cma.h             | 38 +++++++++
>   10 files changed, 176 insertions(+), 9 deletions(-)
>   create mode 100644 drivers/tee/amdtee/shm_pool_cma.c
>   create mode 100644 drivers/tee/amdtee/shm_pool_cma.h
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 722b6eca2e93..5e38423f3d53 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -363,6 +363,13 @@
>   			  selects a performance level in this range and appropriate
>   			  to the current workload.
>   
> +	amdtee_cma=nn	[HW,TEE]
> +			Sets the memory size reserved for contiguous memory
> +			allocations, to be used by amdtee device driver.
> +			Value is in MB and can range from 4 to 128 (MBs)
> +			CMA will be active only when CMA is enabled, and amdtee is
> +			built as inbuilt driver, and not loaded as module.
> +
>   	amijoy.map=	[HW,JOY] Amiga joystick support
>   			Map of devices attached to JOY0DAT and JOY1DAT
>   			Format: <a>,<b>
> diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
> index f3495623ac99..bb5e4b7134a2 100644
> --- a/arch/x86/include/asm/setup.h
> +++ b/arch/x86/include/asm/setup.h
> @@ -66,6 +66,12 @@ extern void x86_ce4100_early_setup(void);
>   static inline void x86_ce4100_early_setup(void) { }
>   #endif
>   
> +#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA)
> +void amdtee_cma_reserve(void);
> +#else
> +static inline void amdtee_cma_reserve(void) { }
> +#endif
> +
>   #ifndef _SETUP
>   
>   #include <asm/espfix.h>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index fd975a4a5200..e73433af3bfa 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1223,6 +1223,8 @@ void __init setup_arch(char **cmdline_p)
>   	initmem_init();
>   	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
>   
> +	amdtee_cma_reserve();
> +
>   	if (boot_cpu_has(X86_FEATURE_GBPAGES))
>   		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
>   
> diff --git a/drivers/tee/amdtee/Kconfig b/drivers/tee/amdtee/Kconfig
> index 191f9715fa9a..5843c739a7b8 100644
> --- a/drivers/tee/amdtee/Kconfig
> +++ b/drivers/tee/amdtee/Kconfig
> @@ -6,3 +6,12 @@ config AMDTEE
>   	depends on CRYPTO_DEV_SP_PSP && CRYPTO_DEV_CCP_DD
>   	help
>   	  This implements AMD's Trusted Execution Environment (TEE) driver.
> +
> +config AMDTEE_CMA_SIZE
> +	int "Size of Memory in MiB reserved in CMA for AMD-TEE"
> +	default "0"
> +	depends on CMA && (AMDTEE=y)
> +	help
> +	  Specify the default amount of memory in MiB reserved in CMA for AMD-TEE driver
> +	  Any amdtee shm buffer allocation larger than 64k will allocate memory from the CMA
> +	  The default can be overridden with the kernel commandline parameter "amdtee_cma".
> \ No newline at end of file
> diff --git a/drivers/tee/amdtee/Makefile b/drivers/tee/amdtee/Makefile
> index ff1485266117..a197839cfcf3 100644
> --- a/drivers/tee/amdtee/Makefile
> +++ b/drivers/tee/amdtee/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_AMDTEE) += amdtee.o
>   amdtee-objs += core.o
>   amdtee-objs += call.o
>   amdtee-objs += shm_pool.o
> +amdtee-objs += shm_pool_cma.o
> diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdtee_private.h
> index 6d0f7062bb87..9ba47795adb6 100644
> --- a/drivers/tee/amdtee/amdtee_private.h
> +++ b/drivers/tee/amdtee/amdtee_private.h
> @@ -87,11 +87,13 @@ struct shmem_desc {
>    * struct amdtee_shm_data - Shared memory data
>    * @kaddr:	Kernel virtual address of shared memory
>    * @buf_id:	Buffer id of memory mapped by TEE_CMD_ID_MAP_SHARED_MEM
> + * @is_cma:	Indicates whether memory is allocated from cma region or not
>    */
>   struct amdtee_shm_data {
>   	struct  list_head shm_node;
>   	void    *kaddr;
>   	u32     buf_id;
> +	bool    is_cma;
>   };
>   
>   /**
> @@ -145,9 +147,9 @@ int amdtee_invoke_func(struct tee_context *ctx,
>   
>   int amdtee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
>   
> -int amdtee_map_shmem(struct tee_shm *shm);
> +int amdtee_map_shmem(struct tee_shm *shm, bool is_cma);
>   
> -void amdtee_unmap_shmem(struct tee_shm *shm);
> +void amdtee_unmap_shmem(struct tee_shm *shm, bool *is_cma);
>   
>   int handle_load_ta(void *data, u32 size,
>   		   struct tee_ioctl_open_session_arg *arg);
> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> index 372d64756ed6..448802dccf13 100644
> --- a/drivers/tee/amdtee/core.c
> +++ b/drivers/tee/amdtee/core.c
> @@ -336,7 +336,7 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
>   	return 0;
>   }
>   
> -int amdtee_map_shmem(struct tee_shm *shm)
> +int amdtee_map_shmem(struct tee_shm *shm, bool is_cma)
>   {
>   	struct amdtee_context_data *ctxdata;
>   	struct amdtee_shm_data *shmnode;
> @@ -368,6 +368,7 @@ int amdtee_map_shmem(struct tee_shm *shm)
>   
>   	shmnode->kaddr = shm->kaddr;
>   	shmnode->buf_id = buf_id;
> +	shmnode->is_cma = is_cma;
>   	ctxdata = shm->ctx->data;
>   	mutex_lock(&ctxdata->shm_mutex);
>   	list_add(&shmnode->shm_node, &ctxdata->shm_list);
> @@ -378,7 +379,7 @@ int amdtee_map_shmem(struct tee_shm *shm)
>   	return 0;
>   }
>   
> -void amdtee_unmap_shmem(struct tee_shm *shm)
> +void amdtee_unmap_shmem(struct tee_shm *shm, bool *is_cma)
>   {
>   	struct amdtee_context_data *ctxdata;
>   	struct amdtee_shm_data *shmnode;
> @@ -395,6 +396,7 @@ void amdtee_unmap_shmem(struct tee_shm *shm)
>   	mutex_lock(&ctxdata->shm_mutex);
>   	list_for_each_entry(shmnode, &ctxdata->shm_list, shm_node)
>   		if (buf_id == shmnode->buf_id) {
> +			*is_cma = shmnode->is_cma;
>   			list_del(&shmnode->shm_node);
>   			kfree(shmnode);
>   			break;
> diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
> index f0303126f199..9aad401387be 100644
> --- a/drivers/tee/amdtee/shm_pool.c
> +++ b/drivers/tee/amdtee/shm_pool.c
> @@ -7,19 +7,30 @@
>   #include <linux/tee_drv.h>
>   #include <linux/psp.h>
>   #include "amdtee_private.h"
> +#include "shm_pool_cma.h"
>   
>   static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
>   			 size_t size, size_t align)
>   {
>   	unsigned int order = get_order(size);
>   	unsigned long va;
> +	bool is_cma = false;
>   	int rc;
>   
>   	/*
>   	 * Ignore alignment since this is already going to be page aligned
>   	 * and there's no need for any larger alignment.
>   	 */
> -	va = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> +
> +	/* if CMA is available, use it for higher order allocation */
> +	if (amdtee_get_cma_size() && order > 6)
> +		va = amdtee_alloc_from_cma(shm, order);
> +
> +	if (va)
> +		is_cma = true;
> +	else
> +		va = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> +
>   	if (!va)
>   		return -ENOMEM;
>   
> @@ -28,9 +39,13 @@ static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
>   	shm->size = PAGE_SIZE << order;
>   
>   	/* Map the allocated memory in to TEE */
> -	rc = amdtee_map_shmem(shm);
> +	rc = amdtee_map_shmem(shm, is_cma);
>   	if (rc) {
> -		free_pages(va, order);
> +		if (is_cma)
> +			amdtee_free_from_cma(shm);
> +		else
> +			free_pages(va, order);
> +
>   		shm->kaddr = NULL;
>   		return rc;
>   	}
> @@ -40,9 +55,16 @@ static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
>   
>   static void pool_op_free(struct tee_shm_pool *pool, struct tee_shm *shm)
>   {
> +	bool is_cma = false;
> +
>   	/* Unmap the shared memory from TEE */
> -	amdtee_unmap_shmem(shm);
> -	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> +	amdtee_unmap_shmem(shm, &is_cma);
> +
> +	if (is_cma)

No need in is_cma here and other places.


> +		amdtee_free_from_cma(shm);
> +	else
> +		free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> +
>   	shm->kaddr = NULL;
>   }
>   
> diff --git a/drivers/tee/amdtee/shm_pool_cma.c b/drivers/tee/amdtee/shm_pool_cma.c
> new file mode 100644
> index 000000000000..99dda9adb1c6
> --- /dev/null
> +++ b/drivers/tee/amdtee/shm_pool_cma.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + */
> +
> +#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA)
> +
> +#define pr_fmt(fmt) "%s: " fmt, __func__
> +
> +#include <linux/cma.h>
> +#include <linux/mm.h>
> +#include <linux/tee_drv.h>
> +#include "shm_pool_cma.h"
> +
> +static struct cma *amdtee_cma;
> +unsigned long amdtee_cma_size __initdata = CONFIG_AMDTEE_CMA_SIZE * SZ_1M;
> +
> +static int __init early_parse_amdtee_cma(char *p)
> +{
> +	int cmd_size;

Not int but unsigned long long.

> +
> +	if (!p)
> +		return 1;
> +
> +	cmd_size = memparse(p, NULL);
> +	if (cmd_size >= 4 && cmd_size <= 256)
> +		amdtee_cma_size = cmd_size * SZ_1M;

Change the doc to use 4M and 256M instead of plain 4 and 256. Or stop 
using memparse().

/me sad.


> +	else
> +		pr_err("invalid amdtee_cma size: %lu\n", amdtee_cma_size);
> +
> +	return 0;
> +}
> +early_param("amdtee_cma", early_parse_amdtee_cma);
> +
> +void __init amdtee_cma_reserve(void)
> +{
> +	int ret;
> +
> +	ret = cma_declare_contiguous(0, amdtee_cma_size, 0, 0, 0, false, "amdtee", &amdtee_cma);
> +	if (ret)
> +		pr_err("Failed to reserve CMA region of size %lu\n", amdtee_cma_size);
> +	else
> +		pr_info("Reserved %lu bytes CMA for amdtee\n", amdtee_cma_size);
> +}
> +
> +unsigned long amdtee_alloc_from_cma(struct tee_shm *shm, unsigned int order)
> +{
> +	struct page *page = NULL;
> +	unsigned long va = 0;
> +	int nr_pages = 0;
> +
> +	if (amdtee_cma) {
> +		nr_pages = 1 << order;
> +		page = cma_alloc(amdtee_cma, nr_pages, 0, false);
> +		if (page)
> +			va = (unsigned long)page_to_virt(page);
> +		else
> +			pr_debug("failed to allocate from CMA region\n");
> +	} else {
> +		pr_debug("CMA region is not available\n");
> +	}
> +	return va;
> +}
> +
> +void amdtee_free_from_cma(struct tee_shm *shm)
> +{
> +	struct page *page;
> +	int nr_pages = 0;
> +
> +	if (amdtee_cma) {
> +		nr_pages = 1 << get_order(shm->size);
> +		page = virt_to_page(shm->kaddr);
> +		cma_release(amdtee_cma, page, nr_pages);
> +	} else {
> +		pr_err("CMA region is not available\n");
> +	}
> +}
> +#endif /* IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA) */
> diff --git a/drivers/tee/amdtee/shm_pool_cma.h b/drivers/tee/amdtee/shm_pool_cma.h
> new file mode 100644
> index 000000000000..d1cde11cbede
> --- /dev/null
> +++ b/drivers/tee/amdtee/shm_pool_cma.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: MIT */
> +
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef SHM_POOL_CMA_H
> +#define SHM_POOL_CMA_H
> +
> +#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA)
> +
> +extern unsigned long amdtee_cma_size;
> +
> +static inline unsigned long amdtee_get_cma_size(void)
> +{
> +	return amdtee_cma_size;
> +}
> +
> +unsigned long amdtee_alloc_from_cma(struct tee_shm *shm, unsigned int order);
> +
> +void amdtee_free_from_cma(struct tee_shm *shm);
> +
> +#else /* IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA) */
> +
> +static inline unsigned long amdtee_get_cma_size(void)
> +{
> +	return 0;
> +}
> +
> +static inline unsigned long amdtee_alloc_from_cma(struct tee_shm *shm, unsigned int order)
> +{
> +	return 0;
> +}
> +
> +static inline void amdtee_free_from_cma(struct tee_shm *shm) { }
> +
> +#endif /* IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA) */
> +#endif /* SHM_POOL_CMA_H */

-- 
Alexey

