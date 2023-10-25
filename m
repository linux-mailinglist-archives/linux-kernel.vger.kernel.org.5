Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C22A7D77A4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjJYWMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYWMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:12:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A8A13A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 15:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNA6RicH+eV7dPRJAEnj3CgtCO7qr8h1Ouau9i3LDpiRpPV4DTdXNE/LSVdVI60u+lXhhFjCHTUDWf4e3LZ3gjHpgwUdb5kjM61+oDeKs7CnWBBb5LHHzlGgRjSB7u6FyQFJunOGNrmOtAlkYwvCVFoO0UIZJGvU1HAzUYQPxsvd1zmjvvZ+kVnxS3uopiLrl/9tPJ+BoA5+c2vTl4NxUEXFfG2pc58GJOQPAEEr25IvfiPWGp14M13V/nuCQImSjAKF+Ffwd7e+mjnGIpGa78RlaZZzNrkmkRkFHMSISTs2kP2YfxL3JdTyv/1GsLBnmQF7W8jyQBqbuAXZ1oqQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzHlocHAwzCZcDExP1gWKKl+zBR1gL/RRwb5nybkOG0=;
 b=iTUZqWOUwCWxHKzE+CG2ZEi6OeuK2z/6hQdKTyXUHI7PKCGrKdr39BQxnAyNkhW4L2JL+00mHXWqcoqi7t8xBuxlxi1EFuIts82TKw5xLU++bVMjxIZYVKKrFXBVhErp4bS64dBxEEc7Xv8vyD1jCTmoVDaWWKrU44S0xmx11YxuOtzK6qXNcd4roM1T4s9KvGLEI3CeaM/IvQS1rf+PyQr/Lt8iC+CT4c0v2SO4fL5yha0xup07cB0YN4cQlxYQ5LfgSwc5dVtJP0TCy8glfkQpwLqtuWYnQiQn0Zllng41q/0bahxvkCzd9q3mPxarHfHqpsEuLYajPLm19bNgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzHlocHAwzCZcDExP1gWKKl+zBR1gL/RRwb5nybkOG0=;
 b=nWUduoYgbUJ+9bNQn7P1jtSvpFRtcyh2DCxoebs1cCJge6BCCO8i1btZxlTvcq4omMNn2Sp5+N9DJfXlotQfWmttA0XGg7aWUt/lGXHcV2lCZTsMypM1iiIicbgsKQEB0qlJjaJymk8LhwI/mxA0VYdBJxvDf0nQLMc3FSrY4NA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 22:11:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Wed, 25 Oct 2023
 22:11:56 +0000
Message-ID: <ad3affd0-58d3-41b3-8014-cb0fc953dc6d@amd.com>
Date:   Wed, 25 Oct 2023 17:11:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re:
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        David Lazar <dlazar@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        hpa@linux.intel.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx> <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
 <87ttqhcotn.ffs@tglx> <87v8avawe0.ffs@tglx>
 <32bcaa8a-0413-4aa4-97a0-189830da8654@amd.com> <ZTkzYA3w2p3L4SVA@localhost>
 <87jzra6235.ffs@tglx> <875y2u5s8g.ffs@tglx>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <875y2u5s8g.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:5:134::46) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: be855356-c404-4e1d-605a-08dbd5a766ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FTRfaU+MAvxVEUCuDBCRC0mVtqklZ0SV7PpqHf4n3emdq6PeTpnaFHcNOISN6rQGuWanFvxxP3IxD4qgzhdfWcg4CRxLqzLQIQhaHEG500oH2VhyBFG8lfpVFlA8hhstFHU1kqew4IFM4HwpmP176pdHL1+kCz7l1wwhEdnNl4F3vjaRvVp0w/Gv1EiLmnlodmL1tGxBMarobmHp4XzCzUJ7e7OKkr0Wlawr/MXgRHN1WHx9qm8pjX3PoXpTVHLIgJ/JsThFl5FBx981XTrvpI3KOa917+z0jTGKotj0QzdtsO1rhMtApgxPGe+5Jd+ob2H3R4qg65ptGIrSUjL9S9yYK5vivKn9/9HvV0oBSNtECe8cWhxO+hirr7t3LvfAiLCwFr8Xw1HjkednONgKEFV9U3U+qqugj5NFb2FbIuV57VZAXWNCUPdQOgXib8Bc/NG11PYKpuNt4SAn704MWQGN4H9kTN58EL36PG9MbyNlT4Rv/98kNfoLaYoEgbr1dJuq9wSecHgMzFn0xzWstkY07TCnsXEt/mfy1DmnFGkdxW0+IfZFXHzFMjz3VKoNZ12UB+4AB/waeSn3HshfOy11Gurj3MiWlcc+OfJEWOC8L2QHIutvQ7mztOTiozPnrq1zYCSB6sePopQcrRBEOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(2616005)(110136005)(66476007)(66946007)(66556008)(54906003)(316002)(26005)(478600001)(966005)(6486002)(6506007)(6666004)(6512007)(53546011)(41300700001)(44832011)(31686004)(7116003)(38100700002)(31696002)(3480700007)(86362001)(2906002)(5660300002)(7416002)(36756003)(4326008)(83380400001)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVo4cy9MRjd4ZzA0d1ZZZTBDR3lQdUpEZ29hRHV1czNkMDRRait6SU00MW5y?=
 =?utf-8?B?NW1hclA2SGV0Z0RTejdDUVFnakxhT2J5ZTNGMkVzZU92MDdnTkt3aUVGNlUw?=
 =?utf-8?B?R3pxL1d4Mk9lUnZCanFENHRlUHVXVTB6WnJ6N08wWnJuck4ydmlGTlFyeWdm?=
 =?utf-8?B?RXhNc3g2SndKdjhtUEVFRGpyb041VHlTNTllWlFKTXlTV3hqNjBNMDc1NkFP?=
 =?utf-8?B?eGNnK2xMNDdyZEZMYmRUdzBCejFKSWZoZVlRczdlSzFSb0xHbWdHMTcrTXI4?=
 =?utf-8?B?SVZpMFN0S0gyeUtHM3VkOWhsR2YvRkZPOGE0TEdtRjNyV2lvcnZmSnpaSWxk?=
 =?utf-8?B?dzdSSnUzY01nY3FxNG14UjRDbXVKbWVVbTYrRGlMNmVWNmJjdWV1SnhsWTIy?=
 =?utf-8?B?NUJxRzN1cUROSVYzZTgrNGM4NUp1VUJ2clRrbEx6U1llT0VwNWpmcEhvN3lQ?=
 =?utf-8?B?T1VWZDdRSGdkVmFWQ2g5ODFIVlpqemhGU3hMeTdvUkVnUzUrZkVONTMrbmJZ?=
 =?utf-8?B?UG1SUlBBa0UyZ0VXV0xFVU5iaFJFTDFqcVVqQzRDemZwNVZpQmN6SmpLN290?=
 =?utf-8?B?ZS9OUHlBcEdqdk9ENjZZbmVwMmRXUUNSbGtlTjRkdzJKYXZYNUVuNWNLVmZC?=
 =?utf-8?B?N1E3NFFvemtpaldzT0lCazM1Y3dFWnhUZ3RwblNEZlRaMlF3cUc0Y3pwRkxW?=
 =?utf-8?B?M3dyRW05c1hBdjFRVkpBTGJDZjZ4dVRZK1FvVmkvc1p0L0dneTV4djZjN2RY?=
 =?utf-8?B?VmxrZ0xsZWJrdElNckFVUGtrNWozV2VDcmVOVjBBTGRreVNJM2RHeWROY2sw?=
 =?utf-8?B?UUFhbEw0aFlZTkdMU0hwbHdPc2VTMkFEODNmeWRDSWVXU0lMSXV3cm51NkxQ?=
 =?utf-8?B?dFRERkgxVGFpelprYmk3M0NUTE5YWHJJKzZDNFpqeTdNbk5RVDJIelRuVFZR?=
 =?utf-8?B?NE5sTmhTUDY4QmdDQ2lHd0xLNk5yS2FFV2cyNEd1aEczaXJPdWpoOHltNllV?=
 =?utf-8?B?MDVzNnV1RXpSUXI1R2VMdnZQaGRBeDhIMUhSMnZrME9JOXFIb0N3OEY0QlA4?=
 =?utf-8?B?c1R5Um1zcSswYS9hdXVKTHhLV24wMTBkelpudnhCOUlnc3gwZ1F4QTVHTFdF?=
 =?utf-8?B?VnZUUmwrTEszbCtMRWc4Z3lCOTE5NzJoZmxkOUpkdHB4TWpTdHpJOGYyZVpG?=
 =?utf-8?B?ZHRzb1NsYlF3aVhIOEhvTXlrV0VwaVdyWHdLZy9JK3Y1RkluYWJ0TnhCZ2FF?=
 =?utf-8?B?TDRNMEtBZlkyWGVsUzd3WXFRRWxBNStBUVIxL3RGSVlHcEFoRGQ4VXUwUDFl?=
 =?utf-8?B?QitUbVQrMzFkMmhUUXZUYXRGTCtwM25VV1hVd080UVhOTTFsb2ZtU2RpYUFH?=
 =?utf-8?B?aGs5OVBHMHVJT1hETUlLSTNtWVdGTjNIYlZCM0VvdzAzMlZpSDhZejJ1U0Jv?=
 =?utf-8?B?d0p0OFZTYTA3Z3lHWjNnbjFnNWJFN1JrTWJSMFJtbWhxd0REZ2cybHBUenlu?=
 =?utf-8?B?WFhqL3dlOElJYy84MGgySFRlTXlyK1BOQldWT1NVU3hyRkRodnhlN2lLMnpz?=
 =?utf-8?B?VDVzOTBkc0JIaWdBdEY0VXk2c0FURDVOZlhkVFZxaEk3bEN2SDFVMnBjYlJZ?=
 =?utf-8?B?QWlTUjBNaEFxUG5kWnJkdE1IMlJpc1loNGJZVVpNR2FNYUowR3d2UUtlV2ZX?=
 =?utf-8?B?UVlLU1JZT2c5WnhMbE4vNVBMTEhrL2RvRy91LzVtYlR6YjQ3ejdoTElJSkk0?=
 =?utf-8?B?OHJTVzB1aEIyZ091a05oTkRzZE5jSzBwbTlXL3UxbVU5WlM0eVQ0UzM5U3Vq?=
 =?utf-8?B?ZEpYQWJTc2hLU2piT25wbnU1eUttNXBoaG4xQ25BM2lIdUFOcU5vd3pNTUVz?=
 =?utf-8?B?VU55bWVCYmRENlJzOXdtRjlIdDBxUjlPS2JxaVM5MG9wcGd6dEN2N1BBWW94?=
 =?utf-8?B?aHVKMnBUZlNTVi9HZ1d6bEdIRjM0TFVsbVVwdXJybHhNNUZQNWdWRmFJR2pr?=
 =?utf-8?B?Y29DMklHZHg3cWJQR0s5Wm95VmJwNHdGYU5ydWdOVXN6alZVQUVPTmE2TWZm?=
 =?utf-8?B?M0lERnZVV3JtZk5uMkg5ZWZTR0NTVG14N3BoWXhaOW8zSUY2YmVkQTBNbG1B?=
 =?utf-8?Q?M8h+muNXWQIbCQ+bFOyQKNtOZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be855356-c404-4e1d-605a-08dbd5a766ce
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 22:11:56.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KU7bNTpFnxzFwU+yIJ5FtfJFnzR7ltkA9P9cqN0T5WrMCpzk08mIJYEuQg0KZGud/OhhIrkX4wDNnk2EyhkSMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2023 16:04, Thomas Gleixner wrote:
> David and a few others reported that on certain newer systems some legacy
> interrupts fail to work correctly.
> 
> Debugging revealed that the BIOS of these systems leaves the legacy PIC in
> uninitialized state which makes the PIC detection fail and the kernel
> switches to a dummy implementation.
> 
> Unfortunately this fallback causes quite some code to fail as it depends on
> checks for the number of legacy PIC interrupts or the availability of the
> real PIC.
> 
> In theory there is no reason to use the PIC on any modern system when
> IO/APIC is available, but the dependencies on the related checks cannot be
> resolved trivially and on short notice. This needs lots of analysis and
> rework.
> 
> The PIC detection has been added to avoid quirky checks and force selection
> of the dummy implementation all over the place, especially in VM guest
> scenarios. So it's not an option to revert the relevant commit as that
> would break a lot of other scenarios.
> 
> One solution would be to try to initialize the PIC on detection fail and
> retry the detection, but that puts the burden on everything which does not
> have a PIC.
> 
> Fortunately the ACPI/MADT table header has a flag field, which advertises
> in bit 0 that the system is PCAT compatible, which means it has a legacy
> 8259 PIC.
> 
> Evaluate that bit and if set avoid the detection routine and keep the real
> PIC installed, which then gets initialized (for nothing) and makes the rest
> of the code with all the dependencies work again.
> 
> Fixes: e179f6914152 ("x86, irq, pic: Probe for legacy PIC and set legacy_pic appropriately")
> Reported-by: David Lazar <dlazar@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: David Lazar <dlazar@gmail.com>
> Cc: stable@vger.kernel.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218003

s/Link/Closes/

Presumably you will add a proper subject when this is committed?

With adding title and fixing that tag:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
> ---
>   arch/x86/include/asm/i8259.h |    2 ++
>   arch/x86/kernel/acpi/boot.c  |    3 +++
>   arch/x86/kernel/i8259.c      |   38 ++++++++++++++++++++++++++++++--------
>   3 files changed, 35 insertions(+), 8 deletions(-)
> 
> --- a/arch/x86/include/asm/i8259.h
> +++ b/arch/x86/include/asm/i8259.h
> @@ -69,6 +69,8 @@ struct legacy_pic {
>   	void (*make_irq)(unsigned int irq);
>   };
>   
> +void legacy_pic_pcat_compat(void);
> +
>   extern struct legacy_pic *legacy_pic;
>   extern struct legacy_pic null_legacy_pic;
>   
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -148,6 +148,9 @@ static int __init acpi_parse_madt(struct
>   		pr_debug("Local APIC address 0x%08x\n", madt->address);
>   	}
>   
> +	if (madt->flags & ACPI_MADT_PCAT_COMPAT)
> +		legacy_pic_pcat_compat();
> +
>   	/* ACPI 6.3 and newer support the online capable bit. */
>   	if (acpi_gbl_FADT.header.revision > 6 ||
>   	    (acpi_gbl_FADT.header.revision == 6 &&
> --- a/arch/x86/kernel/i8259.c
> +++ b/arch/x86/kernel/i8259.c
> @@ -32,6 +32,7 @@
>    */
>   static void init_8259A(int auto_eoi);
>   
> +static bool pcat_compat __ro_after_init;
>   static int i8259A_auto_eoi;
>   DEFINE_RAW_SPINLOCK(i8259A_lock);
>   
> @@ -299,15 +300,32 @@ static void unmask_8259A(void)
>   
>   static int probe_8259A(void)
>   {
> +	unsigned char new_val, probe_val = ~(1 << PIC_CASCADE_IR);
>   	unsigned long flags;
> -	unsigned char probe_val = ~(1 << PIC_CASCADE_IR);
> -	unsigned char new_val;
> +
> +	/*
> +	 * If MADT has the PCAT_COMPAT flag set, then do not bother probing
> +	 * for the PIC. Some BIOSes leave the PIC uninitialized and probing
> +	 * fails.
> +	 *
> +	 * Right now this causes problems as quite some code depends on
> +	 * nr_legacy_irqs() > 0 or has_legacy_pic() == true. This is silly
> +	 * when the system has an IO/APIC because then PIC is not required
> +	 * at all, except for really old machines where the timer interrupt
> +	 * must be routed through the PIC. So just pretend that the PIC is
> +	 * there and let legacy_pic->init() initialize it for nothing.
> +	 *
> +	 * Alternatively this could just try to initialize the PIC and
> +	 * repeat the probe, but for cases where there is no PIC that's
> +	 * just pointless.
> +	 */
> +	if (pcat_compat)
> +		return nr_legacy_irqs();
> +
>   	/*
> -	 * Check to see if we have a PIC.
> -	 * Mask all except the cascade and read
> -	 * back the value we just wrote. If we don't
> -	 * have a PIC, we will read 0xff as opposed to the
> -	 * value we wrote.
> +	 * Check to see if we have a PIC.  Mask all except the cascade and
> +	 * read back the value we just wrote. If we don't have a PIC, we
> +	 * will read 0xff as opposed to the value we wrote.
>   	 */
>   	raw_spin_lock_irqsave(&i8259A_lock, flags);
>   
> @@ -429,5 +447,9 @@ static int __init i8259A_init_ops(void)
>   
>   	return 0;
>   }
> -
>   device_initcall(i8259A_init_ops);
> +
> +void __init legacy_pic_pcat_compat(void)
> +{
> +	pcat_compat = true;
> +}

