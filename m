Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD56F77C170
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjHNUVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjHNUVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:21:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A2011D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDM8ebWTnzHtLyzkn1zE75PhgstqMVI30zqARKncc5Y8l49D7K095omglN4aSq+TYW0hANgdGbxB0qQ1HFJvNZDwJlPXmc4Ysi0P1N3nB6+ybzaCHWa9cjb27z3fauL2KNP/lEwDxLafhYQcOBlLerrsCgqf+Nop1vZ4nR+V5JisYsKqNE9kYmEd9mtYgx5Wgeaa8kadifpVmumlQ2xlQLeRYnG2bLmHSNugWHnudevEtHqADL+UMcUn1w+nKKoiw6rsYG0b5Ol9+H1egco3rM8eIUh5RdmZhd6ScSg1fFubuQaldXIRnyqrWikh0IqJfMIrwg+rbGWz1KB4uBCDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNu8njR0lhnKPbzIsauYNmXVs+lhNl0hmIkdeHFokBU=;
 b=KpL8bTdm9OrySCpH7x2dik6wKPQupz0hAwlXAnYVruFRpEPvcQ5r9S2hFo5S2psLY8kHCE3p1r+6okhtFCK3lMa67+xiAvzwT6zVdyWndoN2zkR4jwHUs3TUIB8kReECP04Iq0tOv5Bru6YjSkvalf6W3XAUj/USh4DfhP9Az+g8KeRsDL3li+cUsWq0AwlsUEB8NJfhrZDKhTYbNnEZN2v6SIVB2ekIG4HNVCudlWUZk0An43e4scp1CRojF8w+DWiX/XuN/yQY0lHx5f21ag8sIibN+ijvcNj/A6FirKUKQWoWScQA4r7GVa+12EDsTkQQ4gxnkv/szzUW6ScyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNu8njR0lhnKPbzIsauYNmXVs+lhNl0hmIkdeHFokBU=;
 b=AN2XVMLzlM1y6F4K3vGKmS8OxRPcja9herCSo/QwfrU1IzpNHaRvb4g4XSYEVpgrbODHJF7aWwd8E6u8pKxNAdjgyiwxp29JZJSb/jYkrAy1A+xiBZxBCtH+yCedqctQiGLR/P0h35/uJZ40qjTEqfJGiVtvTZJD4BCOJmL3DoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 20:21:40 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 20:21:40 +0000
Message-ID: <22e7d982-ec1e-ac97-04e9-007eb24047a3@amd.com>
Date:   Mon, 14 Aug 2023 15:21:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] x86/sev: Move sev_setup_arch() to mem_encrypt.c
Content-Language: en-US
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>
References: <20230609171214.31846-1-alexander.shishkin@linux.intel.com>
 <20230609171214.31846-2-alexander.shishkin@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230609171214.31846-2-alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0038.namprd06.prod.outlook.com
 (2603:10b6:5:54::15) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d5f42d-a291-4c8b-d8bf-08db9d041152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 07USkpVtCzrbeO6znvYyTN+0pnFxXdT8o4wjyuTxKb1awwddeQdXLdSgf2Yx01qYB1ihfAMLe445qd7YPBSU84P68X0UlT7ScfQm8W/Xtv1USMRlEdYZENSo5jWrXktZ9kc/jfWvizahJZiMZNhDAN+M1HoMT71wVVA/wDXODDOew6Hzw2GTo7IKXKEGkI8jP/wgX2sWFBQ7xt1/zhsk0KQzKyr+w7SCOPpM/eOpYU32mO3nkNzLmyQJJ7PFHw1gbxQIZZQC+10FHuI+Mb6U//52suQn1O+gyKQ6/6kHAPWki1eJ/hi/yMn4Bk+FtUFQ5Z5KVFYoU0IEjZhGSqBrSlslhXk5rZ2X6D5pcNXXtYG/gPA+Y/gdO6j8zXgaqKcOCvI3ztv3cR92m7NjTV4t2MfN9/vrBKBjCur4WUg+L3eKuq6HfAHltvwbyweff7qPcpzHOkoKVFmhy4RvFrKoM6sDtH86FKLUNsM4eTaHHFTA2rVS6pM0Ih47HVwbAVeKNSkkmxpbiwr+/OP8Yf3kbMQ8PoMb38syBafICsqkNZvsnGMTYSkF20FaWMaoHUSThSbdhyxc9S64HbdycTe/cnnUbBalwkH3yzm/z0PSys4fmndpTeAGZVQt/nSeCuDguZ6wJWeirEY4S/0Z3nhQ9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(186006)(1800799006)(36756003)(7416002)(5660300002)(2906002)(86362001)(31696002)(31686004)(83380400001)(316002)(66556008)(66946007)(66476007)(54906003)(38100700002)(41300700001)(26005)(2616005)(6512007)(53546011)(6486002)(6506007)(8936002)(8676002)(4326008)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnlPVXFYUUZDdVFnUEV5R3hicFlaeGtwaE5SYXFlbm5VSnUwZ0hacmtwTW1T?=
 =?utf-8?B?OE91ZDBzYVBJOHVGdFdEOGkvZUMyMmtLVEJibERldnROb1A1NnJaaVdRZ3E0?=
 =?utf-8?B?aFZJTi9kUmhsWU55RmZ2VTJLZ3VYcldIOXN2aU8wWW5BYmZ2VjJQbTJFbWNv?=
 =?utf-8?B?ZFZzTnZQbHRZcS90U013RmVWWkozUUVRcTlreklpcmJ0VTZ4bW9lYVZZdGZ3?=
 =?utf-8?B?VnhnQlNoSXhiL1d2ajRtWDJGMFl2dHZVRmhDaUREaUxvMm16ZmQ4ejlhUXVn?=
 =?utf-8?B?R05Ka0xFVVBYNjh5QlZQSzdIejc3YXpXZkRTanJMM250ZjJtNE1HeDNKSFNp?=
 =?utf-8?B?azRHSFRjaVhNekY4Yk1wMHhhd3RxUjhVVERDVkRsbVRoMlJxVnBKZUxoZ2xx?=
 =?utf-8?B?blBhNVFlVU1URGtGckFHTzVFZnVCbld1QlFZSk50RlNZeUJtb2x1NldZc0JQ?=
 =?utf-8?B?U0g1ckhxOEFYQ0daTldsczZwcTlITnZqS3Y2bm1qOFdyNkV4SldCbmhqUFM5?=
 =?utf-8?B?S0c3SHNxRWhmZ3VmcWsvT1k3NjFmYXpWamt4R2Z6OHZHWDYrR3lLMTg0ckcr?=
 =?utf-8?B?RHo2U1FEcHBFTGU5VGwxd2xzM1Z1OC9XdFFFdE5tRVpENFJpNlVxS21TaU1G?=
 =?utf-8?B?Y0k0WmNSOWh3VEtXNXB1TjVtRnJFL2orT2NsRlB6b2lVc2RZRjRDbG5CcDgz?=
 =?utf-8?B?SlVKUXI4MXhnbEVsWm9qQjZ0YjBGQ2ZHWGkxL3NqTGtwWTEzdlMvUFo4MEFE?=
 =?utf-8?B?OURTQzljTU5ZZ1Fic3E2aEg1c2Yvd1ZUbTNidHVmcExVRUNsTXZuVWM2RU9p?=
 =?utf-8?B?OHdNcjg2bG1TbGczSmM0N3VYeldPS21yOTJQbW5yeFd1N0FMaTNOQzhKTXdH?=
 =?utf-8?B?NlNsS3E4WmdWOTc5L294dCtIU3RKVGdNZnBuM3NReXhSN0Z6c2hOYXA2ekc2?=
 =?utf-8?B?aGwzN2FUVEh3cGxEV256VmtRbWtPL3NkVmNvL0dabHhWVjdDZytYVzJxcks1?=
 =?utf-8?B?TzI0em9aQ3VJckIxNUNHc09hVnFLM0hBUzJDL2MvWEUzeDA1MXBCa3NROGRv?=
 =?utf-8?B?c2Nnc3FYRmExVnk1T0Y0WHhTdGNXbkJTWU42eUtTTktQSUIxa1kyQWdDOFJN?=
 =?utf-8?B?dFprdHZybTR5d0Z0NmZaQ3hmMCtQeHAvUzVWUUYzaEhuVC9BL3Z3WTRlbTBl?=
 =?utf-8?B?QnN6NkVwS3EyT3FUSURveU12aFJVUlltZmlzeWRWU3hyL3c0UnM3cUU2bExw?=
 =?utf-8?B?amZvZ0kyb2ZQZGRnb2RRbUxKQjRjNXFmNUo3UFdXZVFqOVBGbzlYVVd0Y2Qv?=
 =?utf-8?B?eEc2Zk5HRjZjTVJxdEtjUm5lT09mcjVxdTY4ZmFDWGdtMEdBNk5vUGR2Q0hX?=
 =?utf-8?B?UW1VRi91eVpzTWdkZjRTVnJQOG9oc2pzbHJ2U1pTSkFrd2xzUFdMV3FEeG11?=
 =?utf-8?B?SzhIYlYrU0tlVGNXMS9NcFRWL0kweml6VElWS2lwWUpiZHdvdUpkM0cwaGFK?=
 =?utf-8?B?WElySXBpTHFKRyszWlgyRkVxY3g5MytENmxPNXVXZVpWRXZURU04OGdoWk14?=
 =?utf-8?B?ZWNzdTBhbWxidG5xaFFuOHR0ZFZ4UHFFVzV3TkRNbTV4eUFzVldyWTFEaVdU?=
 =?utf-8?B?T3BwSmZ2UmhnRTh2bm9KVDJOSGwwajBtZENFUVVyMkh3NW9xdERqL3FGeldr?=
 =?utf-8?B?N25TcWpadXlmUjlPNGZJSHQrMU1XcjBtWEZTTzVGR0JsWTg1VHRSWjZTYXVJ?=
 =?utf-8?B?MGZTYUEzMFowQnYwSVhZc1pyNWZsaGx6R1ZJR21SWlVHVzZPbG9DS3N1SXFN?=
 =?utf-8?B?OWU5QVcvTzluZEVybmdvMWt2aHVPcXdlVDUzWityZ3pDZS9udklhU2FTRG82?=
 =?utf-8?B?UzBUTmdQdGxSZEJwRlp3b1NGK2ZVRnNKQ1V4cEY5YUFlSFR2Mzd1UGNOdjJs?=
 =?utf-8?B?U05MZ3VDQzRxQ1hQbzRNNUJZTUp1L0lYT2NRc1dWdHMvYm84Q25CcFZCa2la?=
 =?utf-8?B?bCtJS0o1NmtFaUhQa3dKUEhQN0cybHFVVktkYWZSTGUwaWF4MHRjdEk4aFRz?=
 =?utf-8?B?bmlVQ2FjQVQ4WUs5WndramtxamFlRXNhQzFSVVBPV1pYVnd5V20wWUMwOUla?=
 =?utf-8?Q?HTGiTSMbET+70AKHVKHuZj3v5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d5f42d-a291-4c8b-d8bf-08db9d041152
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 20:21:40.0302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/xSAiNgmklYpKCTdGn5CMeU1VQTPJBXgfaDdCDFqihm9lNtnYc8nioFgZ2lXRRsaacbhfYWyR5WDQuR7948Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/23 12:12, Alexander Shishkin wrote:
> Since commit 4d96f9109109b ("x86/sev: Replace occurrences of
> sev_active() with cc_platform_has()"), the SWIOTLB bounce buffer size
> adjustment and restricted virtio memory setting also inadvertently apply
> to TDX: the code is using cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) as
> a gatekeeping condition, which is also true for TDX, and this is also what
> we want.
> 
> To reflect this, move the corresponding code to generic mem_encrypt.c.
> No functional changes intended.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>   arch/x86/include/asm/mem_encrypt.h | 11 ++++++++--
>   arch/x86/kernel/setup.c            |  2 +-
>   arch/x86/mm/mem_encrypt.c          | 34 +++++++++++++++++++++++++++++
>   arch/x86/mm/mem_encrypt_amd.c      | 35 ------------------------------
>   4 files changed, 44 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index b7126701574c..4283063c1e1c 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -37,7 +37,6 @@ void __init sme_map_bootdata(char *real_mode_data);
>   void __init sme_unmap_bootdata(char *real_mode_data);
>   
>   void __init sme_early_init(void);
> -void __init sev_setup_arch(void);
>   
>   void __init sme_encrypt_kernel(struct boot_params *bp);
>   void __init sme_enable(struct boot_params *bp);
> @@ -67,7 +66,6 @@ static inline void __init sme_map_bootdata(char *real_mode_data) { }
>   static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
>   
>   static inline void __init sme_early_init(void) { }
> -static inline void __init sev_setup_arch(void) { }
>   
>   static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
>   static inline void __init sme_enable(struct boot_params *bp) { }
> @@ -92,6 +90,15 @@ void __init mem_encrypt_init(void);
>   
>   void add_encrypt_protection_map(void);
>   
> +#ifdef CONFIG_X86_MEM_ENCRYPT
> +
> +void __init mem_encrypt_setup_arch(void);
> +
> +#else	/* !CONFIG_X86_MEM_ENCRYPT */
> +
> +static inline void __init mem_encrypt_setup_arch(void) { }
> +
> +#endif	/* CONFIG_X86_MEM_ENCRYPT */

Commit 0a9567ac5e6a ("x86/mem_encrypt: Unbreak the AMD_MEM_ENCRYPT=n 
build") added a #ifdef for CONFIG_X86_MEM_ENCRYPT near the top of the 
file, it would be better to rebase and put these up with the 
mem_encrypt_init() definitions.

Otherwise, no objections.

Thanks,
Tom

>   /*
>    * The __sme_pa() and __sme_pa_nodebug() macros are meant for use when
>    * writing to or comparing values from the cr3 register.  Having the
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 16babff771bd..e2aa1d5b37a9 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1121,7 +1121,7 @@ void __init setup_arch(char **cmdline_p)
>   	 * Needs to run after memblock setup because it needs the physical
>   	 * memory size.
>   	 */
> -	sev_setup_arch();
> +	mem_encrypt_setup_arch();
>   
>   	efi_fake_memmap();
>   	efi_find_mirror();
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 9f27e14e185f..c290c55b632b 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -12,6 +12,7 @@
>   #include <linux/swiotlb.h>
>   #include <linux/cc_platform.h>
>   #include <linux/mem_encrypt.h>
> +#include <linux/virtio_anchor.h>
>   
>   /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>   bool force_dma_unencrypted(struct device *dev)
> @@ -86,3 +87,36 @@ void __init mem_encrypt_init(void)
>   
>   	print_mem_encrypt_feature_info();
>   }
> +
> +void __init mem_encrypt_setup_arch(void)
> +{
> +	phys_addr_t total_mem = memblock_phys_mem_size();
> +	unsigned long size;
> +
> +	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		return;
> +
> +	/*
> +	 * For SEV and TDX, all DMA has to occur via shared/unencrypted pages.
> +	 * Kernel uses SWIOTLB to make this happen without changing device
> +	 * drivers. However, depending on the workload being run, the
> +	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
> +	 * run out of buffers for DMA, resulting in I/O errors and/or
> +	 * performance degradation especially with high I/O workloads.
> +	 *
> +	 * Adjust the default size of SWIOTLB using a percentage of guest
> +	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
> +	 * memory is allocated from low memory, ensure that the adjusted size
> +	 * is within the limits of low available memory.
> +	 *
> +	 * The percentage of guest memory used here for SWIOTLB buffers
> +	 * is more of an approximation of the static adjustment which
> +	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> +	 */
> +	size = total_mem * 6 / 100;
> +	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> +	swiotlb_adjust_size(size);
> +
> +	/* Set restricted memory access for virtio. */
> +	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
> +}
> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
> index e0b51c09109f..b1edeb8642b8 100644
> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
> @@ -20,7 +20,6 @@
>   #include <linux/bitops.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/virtio_config.h>
> -#include <linux/virtio_anchor.h>
>   #include <linux/cc_platform.h>
>   
>   #include <asm/tlbflush.h>
> @@ -215,40 +214,6 @@ void __init sme_map_bootdata(char *real_mode_data)
>   	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, true);
>   }
>   
> -void __init sev_setup_arch(void)
> -{
> -	phys_addr_t total_mem = memblock_phys_mem_size();
> -	unsigned long size;
> -
> -	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> -		return;
> -
> -	/*
> -	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> -	 * SEV uses SWIOTLB to make this happen without changing device
> -	 * drivers. However, depending on the workload being run, the
> -	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
> -	 * run out of buffers for DMA, resulting in I/O errors and/or
> -	 * performance degradation especially with high I/O workloads.
> -	 *
> -	 * Adjust the default size of SWIOTLB for SEV guests using
> -	 * a percentage of guest memory for SWIOTLB buffers.
> -	 * Also, as the SWIOTLB bounce buffer memory is allocated
> -	 * from low memory, ensure that the adjusted size is within
> -	 * the limits of low available memory.
> -	 *
> -	 * The percentage of guest memory used here for SWIOTLB buffers
> -	 * is more of an approximation of the static adjustment which
> -	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> -	 */
> -	size = total_mem * 6 / 100;
> -	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> -	swiotlb_adjust_size(size);
> -
> -	/* Set restricted memory access for virtio. */
> -	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
> -}
> -
>   static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
>   {
>   	unsigned long pfn = 0;
