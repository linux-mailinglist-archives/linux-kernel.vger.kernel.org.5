Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDE8782EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjHUQq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjHUQqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:46:25 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD11F3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giEDEfbejNWlfddmRlk4XSahW+YE9RGTBvYRzZk8oHwdFoKWHay+DZkCECmU2bMq0GFmD6XEj7FWIlZIWU7RukRErjhpIzKasVaKAAWu0M07Aj1Fn+3xjEQKg1n3J+fgANMiW+n3iyvp0+p9Mx1jkoZj5BmNA9mAG6jTwi+IbkTz2zpKaU7F2+LzPYyMJ/WMl80b4SnUmehbBmmJBxWuHeOWT/tzS6Jf+uVAAhr9vjRntSelMtY8NXqbpGkACD2n9fxffg6Ze/9i4iX+3snNg/sLbsP+Lhnn4cNZCxMuVgp7ARNx1cLF00cs706En4qV2p3N3GuMaBLAydCMJGFvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xoc8HQZlOV8QyQUiaJ8eC9TII9EWs/Jzj8NQRWRG5ig=;
 b=T2snR5NcICgAG4BfXqmuCyLJRlddGIF031S3slMuZFV4JMlfYpjO95csAvyY3WuNhLAN7zC+YWQh2voGv0vGObtOCl4mBndjSD4Dj/ciBTYrqImAZazInQJsAJ/g9For7d5KZUwMWJ1WcMGoA0GX/zuRXmjgT/aW2VrPPZYwgWYGliF/OxMuHZoQUKWbrhN9qlNVBMHT0AbVoJtn6igoA44ilmlBrcjA91rCEipCYr/DQjdeEqyRc16funm9JfgHwDy+1yqq9cSC88OUAt7z+QRS6BcMVwPvB1NET3h+W8KQ8QylGqj45t7CLYNNVDrTYHExJmKaadKCv0160FtSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xoc8HQZlOV8QyQUiaJ8eC9TII9EWs/Jzj8NQRWRG5ig=;
 b=JBF5nHyaiLJaTF83QC4XAc1aI88IBemUhEi9KKxozlOWy6cT7Qm0frua9uoimvSXKX7h47gVWwq4sB/cbrJgApeBCHvBeNiyTXb0VZo6miXONFicayTmOQc8Pm13u9epHloYiWqTuq+tPDVtHQX6YYhzTOqOplapMdaWpR1DWV/V9XJ3hJNQT1fbtYZmRQ8imLCyVPIYqE6T687gDKN/nX9XRgUXu5TriEhqxhOZXS693oucWheKM4ehd10nXw830CrPyd3d3lXzE7nLF8ABERfjirrO7myvAoNugQ8Hd2aPfAhNrNhi6zN5DE5xrnHPrEiEGhJkDosywBwoaLgoPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM7PR04MB7158.eurprd04.prod.outlook.com (2603:10a6:20b:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:46:20 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 16:46:20 +0000
Message-ID: <14f97819-11af-5072-d4f2-a7b4f16d734e@suse.com>
Date:   Mon, 21 Aug 2023 19:46:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 03/22] KVM: x86: Support IBPB_BRTYPE and SBPB
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, David.Kaplan@amd.com,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <a4d62162bcb501e50b0bb19b748702aa12260615.1692580085.git.jpoimboe@kernel.org>
 <45ef7bcc-d52e-3759-403b-e4b5a79a4a4f@citrix.com>
 <20230821162337.imzjf3golstkrrgd@treble> <ZOOSXc9NE1rMHDZ1@google.com>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <ZOOSXc9NE1rMHDZ1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::35) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM7PR04MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6ab71a-de05-43f2-3617-08dba26625b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sz1pRPhvZcIlyNb+fN5+Nl4ncNy+5G3zl3KX+nqIjW/XkI0+n53CwK7PrSHI2FArSl9DDR/BiYLgORjCM+YiP356CWCsFUyh4jBDuluspP5byPMiZWtEMVZ5yeLX1cIwOEtvLuRE/+nWqd4kESMxXMZnmkc5BFwDLPTvTJALLF+9N/r7k5DXRwQpQlbJLgDNtsXpsUIivlj9/aFoTbbK52TM/U+sf58LWZhAviMbjIAYbmXOPeYRdRG5SZf0JqAWOituBrnsHsgVDzwBv5nvEo8dQzEm878XG2ZE1QTqFQ21UIaCwEVk4eko9itSBcFPwsxVoayS2fauCXldmh0cBGDAtziKa+m51mV0O5btilUM8JDUiPvGeUt4iWr9rv1VO2WNL150GhzIfXsczAHzCFStnNcGwmG2tHibuQ12gOuxauhJ96OyPa+Cu5xVaYrM9HGLp3n9PP/jQTIIvYwxp6tXgLlj4rRGDd9riKL6MupyUTMlPoG2BlhrG2NDM8DVAiFxUufPSgrbYTzNJhO9xa0KO1rAFYmwMJMnwYM4in6jJB7Vi57HItuFOeOPCRXH1kfqQm7gsIiD8/j1UkivYjw3tieV4jPHdZtqLJRJ+dz3kOUNRXzT0k7c+OAwnKxdardxBEsdiirI5x16P9euRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39850400004)(346002)(366004)(186009)(1800799009)(451199024)(54906003)(66476007)(66556008)(316002)(66946007)(6512007)(110136005)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(2906002)(7416002)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmpkM2N0ekVjd052bitEZEZ6NGw1NFZHZ0t5OTZSYWpUVGFySmJIVXlSUlRi?=
 =?utf-8?B?QXFPdkVaaVl6ZjBJbzF6MzRobVYxcFRDckZzMCsyN3YvcGwvNlJ4K0NXdzZE?=
 =?utf-8?B?V292eWc4UjA2aXhhY3BYN3oxOUpmcjhvbnBSOWp1U05Wc2wwbHhoSzhoSnpp?=
 =?utf-8?B?ZHZrSUhrdHRkMVlZS0FmT0pZZWIxWTNnUnZWUjBlSWVSK1ZoU3lGelRVS1M5?=
 =?utf-8?B?NGVwaTM0K0RjN3JGYjJnWU1ub2U5cElmd1JxTkRtVkROQmhpdSsxcERiam1Y?=
 =?utf-8?B?TlZzWnlDaGlIUUJJWExHZURwcFJIV3VCdU1LUmdDMjdac2c3Q0VqR3ZOZGZC?=
 =?utf-8?B?UE00OS9pdzRvdnF3aHdRVjY1dnd0andOQXRSdmVnM0w5SHhnUzBHS09ZNDNs?=
 =?utf-8?B?RDVhOTZOV0V5RGlPSy9HdWN4dmJGbHdlYUFJb2ZXSDZDL0l4b2hmOUVHdlYw?=
 =?utf-8?B?K3VzQ0JQL1FKVFFEZkZFV040Qk5OVHJTM3FqWDVKUStqcEFOYWF6UnJEaDhT?=
 =?utf-8?B?aVc1RGlsdHptZEpvMFJrQ1hIL3NNZ2NOTDk2Z0gyT1VWaGtORm1oUWFQd2tw?=
 =?utf-8?B?bVZCU1lVdVlHaEE1UVZOSTZqRjRYdWhscHBLNlhtOExiZFpXVFJLVEsyQzRJ?=
 =?utf-8?B?dmJKUGE1S2JEWGgrNjdOUXgzck1LRDNMR0l1bFFHRUNnRWVpUU5Ya045TmUv?=
 =?utf-8?B?NHlSbmczMU56andBdXp2VXNaZ0JVUzU2eDd0VVpEbUM4UzFxRm9UbkFtVFE0?=
 =?utf-8?B?SEU0THV6RzhpVUgwL0dIdzVUZ0R0VGlOR3ZQWFNjMktTRURQdUEweWU0bGU2?=
 =?utf-8?B?RFplcTRQTUw5cXFzS0diQ2M5UTNNa1NBNkxUL2xxN1c4Z0tXZzlncjB3bmpV?=
 =?utf-8?B?Um5NU2Q1cE9mNExtQW5yUlB4ZmdnbG9Fd2lqTitXUW1BTUZQZzU1eUNxYk56?=
 =?utf-8?B?ZlJHaHVjVC81Mm5JVVpiUlphdkRTZW1VU09GZjV6UFBRNTlNVmlBc2pUbGJp?=
 =?utf-8?B?dTM5azB4WkxtdmFnWWp2NHp3MVZ3bDBGQldDLy9SYUF3aGNCRDMxeFpyV0Mw?=
 =?utf-8?B?NXVGQ0k4bm10cysrY1BobEVzdk8vbVkxYk9ycm1kWXkxM2RIMzlWN1dMejl2?=
 =?utf-8?B?MjNWbEJ5VmZXT1Zjc0dNZlpFbk5QZ1JCMkcxSHVkOTdnei9BSGJtT1FrOE83?=
 =?utf-8?B?VUl0c3dzaXh0YjZzK1JBdFlYNDlSS1dKWnBvZ2hSbFhEZEtEN2hiOG1IMnhQ?=
 =?utf-8?B?a2JkUkhzVEd5aDREeHBBNzUyeXZPNFZnRjdDc0YycFk3ZVpUMmtPZUJnWlhP?=
 =?utf-8?B?NU5EOXVkOXBtRjhJOHFQMDJDa1liRktERExXOVJVYStFRU8rUlJXU0lxcTRG?=
 =?utf-8?B?b1NGSUdjY3AwYjJiQVRHTGVQQXZqRWlNdTFYNUkyR1FlTnllZ29JYzlPODc3?=
 =?utf-8?B?enRoM2ZoQmNlNU1uMWp4SE9kN0VZK0owZkNyN2luQU5TSGVkYW02MnhqZHhX?=
 =?utf-8?B?K3hvQk51YzZabENsNkh6QjNXYVlFZzA1Nm9uUUowVmJDaHhUYmJCRGhIWk41?=
 =?utf-8?B?TGo2bDhsTVhXS1AzSWVBd1ZoZmUzaVBKM2JoQmtRMjBuZDlwRllONVZ4M09n?=
 =?utf-8?B?TDgzTEpLakhjZlQwVzV6MGtaR2VyY2dTOG5PamF2RXJua281aWRjUWx5WlJp?=
 =?utf-8?B?d0t6cDROMzNGMElvb2xJU2VqV0t6S1p2MkRpWTdCRVhtRDUwN24yRFNKNFRO?=
 =?utf-8?B?S2RpN1FBTndxdEdlbnd4ZG5MMUpieVplWjdzdVpYNEJ4TGIvMjVQSW1kcjRI?=
 =?utf-8?B?ZE1qQmNwOFhEV3lyTEo5MjYzdlVGQTh6MVFaOFNMUXVXVHNCQVRxd21kNkxS?=
 =?utf-8?B?cDl4QlJFNkFYZ21rTUV0OEM0U3FHR2dvYnAzdklFMmtkdjM1T1owaG1KaWVX?=
 =?utf-8?B?TTFCWFhlK0ZxcHd0QVdxMXVYZ3VoaXJaYWtTRGpQQTdxeEJRcU1lMkdUTk9h?=
 =?utf-8?B?MW9WSVBRMUVMbUlQZ0szNG1aM29XcC95NnVBMmh0UlhLQ2NUTElJUGdONnRS?=
 =?utf-8?B?K0pYTVdjNVkwaStReC9IRWh1cERZaE1Sb0JpaWd6cDJMd1orSmFUTDBzT0hS?=
 =?utf-8?Q?1f1cXLgOi0tn1+cH7vCGPIB5T?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6ab71a-de05-43f2-3617-08dba26625b7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:46:20.7386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAOSqTTyTTAX3XmcMl5xqlsVNIf1H0+SRAMzHM10AvdNSuUYqBzn4MzCEHJD00Ji7MA9BmogGTr5QtHmgd4RxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7158
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.08.23 г. 19:35 ч., Sean Christopherson wrote:
> On Mon, Aug 21, 2023, Josh Poimboeuf wrote:
>> On Mon, Aug 21, 2023 at 10:34:38AM +0100, Andrew Cooper wrote:
>>> On 21/08/2023 2:19 am, Josh Poimboeuf wrote:
>>>> The IBPB_BRTYPE and SBPB CPUID bits aren't set by HW.
>>>
>>> "Current hardware".
>>>
>>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>>> index c381770bcbf1..dd7472121142 100644
>>>> --- a/arch/x86/kvm/x86.c
>>>> +++ b/arch/x86/kvm/x86.c
>>>> @@ -3676,12 +3676,13 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>>>   		if (!msr_info->host_initiated && !guest_has_pred_cmd_msr(vcpu))
>>>>   			return 1;
>>>>   
>>>> -		if (!boot_cpu_has(X86_FEATURE_IBPB) || (data & ~PRED_CMD_IBPB))
>>>> +		if (boot_cpu_has(X86_FEATURE_IBPB) && data == PRED_CMD_IBPB)
>>>> +			wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
>>>> +		else if (boot_cpu_has(X86_FEATURE_SBPB) && data == PRED_CMD_SBPB)
>>>> +			wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_SBPB);
>>>> +		else if (data)
>>>>   			return 1;
>>>
>>> SBPB | IBPB is an explicitly permitted combination, but will be rejected
>>> by this logic.
>>
>> Ah yes, I see that now:
>>
>>    If software writes PRED_CMD with both bits 0 and 7 set to 1, the
>>    processor performs an IBPB operation.
> 
> The KVM code being a bit funky isn't doing you any favors.  This is the least
> awful approach I could come up with:
> 
> 	case MSR_IA32_PRED_CMD: {
> 		u64 reserved_bits = ~(PRED_CMD_IBPB | PRED_CMD_SBPB);
> 
> 		if (!msr_info->host_initiated) {
> 			if (!guest_has_pred_cmd_msr(vcpu))
> 				return 1;
> 
> 			if (!guest_cpuid_has(vcpu, X86_FEATURE_SBPB))
> 				reserved_bits |= PRED_CMD_SBPB;
> 		}
> 
> 		if (!boot_cpu_has(X86_FEATURE_IBPB))
> 			reserved_bits |= PRED_CMD_IBPB;
> 
> 		if (!boot_cpu_has(X86_FEATURE_SBPB))
> 			reserved_bits |= PRED_CMD_SBPB;
> 
> 		if (!data)
> 			break;
> 
> 		wrmsrl(MSR_IA32_PRED_CMD, data);
> 		break;
> 	}
> 
> There are more wrinkles though.  KVM passes through MSR_IA32_PRED_CMD based on
> IBPB.  If hardware supports both IBPB and SBPB, but userspace does NOT exposes
> SBPB to the guest, then KVM will create a virtualization hole where the guest can
> write SBPB against userspace's wishes.  I haven't read up on SBPB enought o know
> whether or not that's problematic.
> 
> And conversely, if userspace expoes SBPB but not IBPB, then KVM will intercept
> writes to MSR_IA32_PRED_CMD and probably tank guest performance.  Again, I haven't
> paid attention enough to know if this is a reasonable configuration, i.e. whether
> or not it's worth caring about in KVM.
> 
> If the virtualization holes are deemed safe, then the easiest thing would be to
> treat MSR_IA32_PRED_CMD as existing if either IBPB or SBPB exists.  E.g.
> 
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index b1658c0de847..e4db844a58fe 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -174,7 +174,8 @@ static inline bool guest_has_spec_ctrl_msr(struct kvm_vcpu *vcpu)
>   static inline bool guest_has_pred_cmd_msr(struct kvm_vcpu *vcpu)
>   {
>          return (guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
> -               guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB));
> +               guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB) ||
> +               guest_cpuid_has(vcpu, X86_FEATURE_SBPB));
>   }
>   
>   static inline bool supports_cpuid_fault(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 12688754c556..aa4620fb43f8 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3656,17 +3656,33 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                  vcpu->arch.perf_capabilities = data;
>                  kvm_pmu_refresh(vcpu);
>                  break;
> -       case MSR_IA32_PRED_CMD:
> -               if (!msr_info->host_initiated && !guest_has_pred_cmd_msr(vcpu))
> -                       return 1;
> +       case MSR_IA32_PRED_CMD: {
> +               u64 reserved_bits = ~(PRED_CMD_IBPB | PRED_CMD_SBPB);
> +
> +               if (!msr_info->host_initiated) {
> +                       if (!guest_has_pred_cmd_msr(vcpu))
> +                               return 1;
> +
> +                       if (!guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
> +                           !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBPB))
> +                               reserved_bits |= PRED_CMD_IBPB;
> +
> +                       if (!guest_cpuid_has(vcpu, X86_FEATURE_SBPB))
> +                               reserved_bits |= PRED_CMD_SBPB;
> +               }
> +
> +               if (!boot_cpu_has(X86_FEATURE_IBPB))
> +                       reserved_bits |= PRED_CMD_IBPB;
> +
> +               if (!boot_cpu_has(X86_FEATURE_SBPB))
> +                       reserved_bits |= PRED_CMD_SBPB;
>   
> -               if (!boot_cpu_has(X86_FEATURE_IBPB) || (data & ~PRED_CMD_IBPB))
> -                       return 1;


Surely data must be sanitized against reserved_bit before this if is 
executed?

>                  if (!data)
>                          break;
>   
> -               wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
> +               wrmsrl(MSR_IA32_PRED_CMD, data);
>                  break;
> +       }
>          case MSR_IA32_FLUSH_CMD:
>                  if (!msr_info->host_initiated &&
>                      !guest_cpuid_has(vcpu, X86_FEATURE_FLUSH_L1D))
