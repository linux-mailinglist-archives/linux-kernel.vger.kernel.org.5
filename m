Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97DB7978B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244380AbjIGQxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245263AbjIGQxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:53:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE02F210B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBixdjMwTa0i5RdjRSYPQGSS6kZ2JOwdBVAJK+y9UdEbdS836YfSC57etrlORhuoW8u8Qd0ltU+dHhxsrXUT8qVy/UcsdCHCUFMwMmJI+4xhPh/B+LfKIYduO93iT9+n8rDxzwa4+s+nS6c2mAZb1+MXLEclDywN2ccYx5Pz+vFkYxUwf78bFooSi+OyJhfMXsPYIXNbxKu0tgMFN+xz7KJQAg0UN19DOeK3Q33dmC3N9H3V+VzuvEVomOTKu9+bQaB1sOvc8Q6GLcl2+jrEeApkyNpIDmmz/K/tpQhbGoRnUxj9PQUgLV2xuNnubQZzKu65n5myMoomIjLUOldOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odkQZh00453h2PomTn+SyKIuLxcA1FUKLrkueKm4SUM=;
 b=gz+uZY2wl5txe1s8zKmlhWyBI7QnNQiIqFQCJWxNlVUbk1I8fyECKA+T8It/JWTO8ymxCyrnnIVdinuyUiE63TZWsjRfaqrPxJLW1pdockQnG4LUEnigWPyop4legCpIkoWSX2WUdZ5s64AS0QNbW0qpDHRVARm3SU0Hkh6gHMcJ7pc7c9w0FOvZsXCBZirQtF1/o8LtlGebL3uB5oM2GD+ALlmwUYiFTT5AccmfMMa2SZnSoSt1rZDZrM/gIeDyy3r7OMR0kRLCFsm7tKj6C44aE89fNlELc+/b+Buzap+k31F4r1KMfngU3PiMb3SNVEvnJyYoKM17zd2Mc0/POw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odkQZh00453h2PomTn+SyKIuLxcA1FUKLrkueKm4SUM=;
 b=J8Zo3ipehvNxcCESPxPcESM16n+yr9fSXZQrJ4ivWCfFO7Hsyut7OPTkP6CmNwb7Luz9P1jt0uKlqHfWEffDbilrxyTgAnLxSVBElHqpqlYBVN+i+rpw/g92O45t//y7GaEU4aJqESDT7L6xIgeqe/0yBmQYiVKv9h1H7F+BoJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 16:50:18 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 16:50:17 +0000
Message-ID: <905c359a-19d6-6cba-4540-92d03b936525@amd.com>
Date:   Thu, 7 Sep 2023 11:50:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v9 5/6] x86/sev: Add SNP-specific unaccepted memory
 support
Content-Language: en-US
To:     Christopher Schramm <linux@cschramm.eu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <cover.1686063086.git.thomas.lendacky@amd.com>
 <a52fa69f460fd1876d70074b20ad68210dfc31dd.1686063086.git.thomas.lendacky@amd.com>
 <101c3910-a164-4b4c-9474-8743dc6d1199@cschramm.eu>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <101c3910-a164-4b4c-9474-8743dc6d1199@cschramm.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:806:a7::6) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: 51da48fc-415e-4076-4651-08dbafc283fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gtzWGJP6gIio2dhBbsw+6JHRJ9OYqEDupra8mwfunfT1seAQlY90nrNafmEKD8ZMHfdlCSJW+XOHPJ71wQ5xZUvrCU3hkBOCeAlHLAY0HGP+8NQ0YN0qH0i4GNsAR+oyIRaDVTYelJxuKN4VQzAz+wJG1bd72ui2R4ANEt8anvMt18J/FBjgMRSYWgqYWzpZff91wLASqrUkFmG9IoKdIsVtUSJU3MPdo+TpFPX+TjrrI7W/qktrRBf/WmsLRj2a2r6kZfye3uE+2nU9Qrs+QmqIBwNIpcyldbUwa/HVeeJ7qmm6jXpF5G+NbGuea48ArwBQNR8qvgjyFpOm8K8VGqKagaIwnXSvp0YxMnowMPfR9hTwx2AG9kl+EiNUZVWXU4e2AgzcI31HjobWquLfH3XKvgSYJ3irBeCGVa13Q20hgo+h6+yCXOnO5H1o3gXEiSWflnpnuwOhPoksBh5le9bBTJunVK7QTNsfkeOzUVrGAPslqyEnKPfp2bgga24M1vq3pU21ULpRkyvbmkAO+EftnKj87P5qGYgSeYO0/B+qnoVeKyU2HpFrW21Ny49wJuNoFSk1NKYc8VxUJxkUUUOt1CrJ0aMxGMQRkiYDBdHMFlqz3p7vlzZPv4NEtDfTXolwhFvu8ZEHgADrX4kEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(8676002)(31686004)(5660300002)(316002)(36756003)(66556008)(66476007)(66946007)(2906002)(54906003)(110136005)(8936002)(4326008)(7416002)(41300700001)(26005)(38100700002)(66899024)(6506007)(6486002)(53546011)(6512007)(2616005)(86362001)(31696002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlNPRWhlV0xNR3FIdzVIbHp5U3FKL1dnTC9BejFxOFIyd0Y4dzlmWkc3TTJH?=
 =?utf-8?B?aGdabFhDdFBnTHlSL1YySUhFT0kvaklWT05ackZCRUVMd3NGY1VzcFJaZE9y?=
 =?utf-8?B?d1NSTnA2eEt1VEtyVDM1dUZVNWk3VFN0cms0LzNSdEMzeWdHKzEyQUlUNTJk?=
 =?utf-8?B?Ymd4ejNyeEVXZ0VYZytZMElxRXkwK2ZMbnhoQ2duRGkwYXZ6N2pJOGN2ZHY5?=
 =?utf-8?B?Vlk1dE0zK0Z0ZXVGaEViY0hra3hCSEQ4R3Q5aTg0NXo2aXl6bTJZVWJRVjdL?=
 =?utf-8?B?Z2tWWE1QcWtHbWR0YktRYmtHRHgxY1BiN1NrTlN6VkhLUVdEa09qVVAvYnBP?=
 =?utf-8?B?UVU1STBob0ZwMlB1OGY5ZGt3OGViL3lPN1N4RjV0K0s3YVBtcC9pOUE5VWR3?=
 =?utf-8?B?TXlQdzQyZTdzbXRmeW4rUE9mSUNtOUl6Y1g5OE5JTHJ4QlN4empCd0FJVnVa?=
 =?utf-8?B?Qmtmbit2WXRxQmV1Q1d0ZzFLRTZleUkyOU81OVg0a3c1UXZsQTRhNDNDRHBR?=
 =?utf-8?B?U2N0dGU1bXlFTjJMN2M3SmNRUVBFWmNRemlPdGtqVHVFc2ZtbUFYM2Q2QWtV?=
 =?utf-8?B?YVBrQU9OZHAxU2hEQngrZVc1aWVIQkFOZXRzUGU3SzhJMlJQWGpvWWl3Yyt6?=
 =?utf-8?B?QXZzYW9LK2JqTW42RitCdFVqZ284OElDZWZUUm52L1YwZHRodkt5SHZ4YlZF?=
 =?utf-8?B?cnFjMC9KQ0ttUVRlZExyQStSUVNFTjhJYTk3OXFBNDNxUDFPMmU4SWg4TFA0?=
 =?utf-8?B?eXV6dmIxSUhtMm1PS2E0RFdhdkM4UWYzTjkxYnV1aE5iUGY3RGFNYXZXYkJM?=
 =?utf-8?B?UzkxYkVwVkEyR21yTFg0MlhmKzNQaEdmK1EzQllUbzB4Y004RSs2QjlmaGdI?=
 =?utf-8?B?M1BZTXRyTVpQZWpiOHZWMktlZlR4UHUzRWJWM08wS1g0U0lXMG1HOUZlZVNX?=
 =?utf-8?B?N05hNzY2L092TGNtYkpoQ0hlNUNDeE41T1NvMWNlWXFrbzJZamRQY1JJN2Vn?=
 =?utf-8?B?ekxmMHVYVjQ0eU9PL3A3bklBUUFpMXFacDJjeFBvZkpPV1NWQS8yaWlkLy9I?=
 =?utf-8?B?bVFkb0YvUWRBZCtLV0pVcUJEMWU4U2h4Y3ZDcEI0QlBkVUN3WDBoQ0pRaDVY?=
 =?utf-8?B?QXMrcFhodHhhYURNdTlubWxuRkVQYk5VZ3VDbStxWDNkK0o2aGNPOWNoQldz?=
 =?utf-8?B?MmVDYzlYZWZhUVJkdUoxby9vdFhpem0vVG1COWFtNkdHZm1LcEtHbDc3Z08z?=
 =?utf-8?B?ZG9UTFdaSWpNSXM0UWptNm14RnMwVlNYRFRFVHB5OGd1OU5kK0laKzFsSnRk?=
 =?utf-8?B?WVVLeGxiRjlWU0ZzbzFOVW52REdrcllEMmtpbEh2S0ZHZ0F3MFJaK2JtVzVv?=
 =?utf-8?B?YjMyRXV1NCtkdzNpWndCQlhUQ0VtdnNkT3VBOWcwcjFHSU5ja0M4L2pSYWNq?=
 =?utf-8?B?V3VUN2wxRzgyOFBzNytyTGdvMGMvQ0Q1b2FYbHRNQURsSUJTMkFtU3hXV0lh?=
 =?utf-8?B?MDlJMFBzMXBUTjJSRG1oK2FrOG4zTGoyempzRS8xRXJwTFRVa29rditjNjdt?=
 =?utf-8?B?Qk0vOHdaekxBWUZhQVlHRTdMR1BHUTRtZzhVczFQMjdqajk4OGJRZWpnYVEv?=
 =?utf-8?B?U2xkOGlHWE9FYmtHNTU0eElrUkxUcmtsYlpGNDNtRHRGeFhWY0M4Y3lXV2h4?=
 =?utf-8?B?YXRVRnM2dmZSN3FwQXhTWDFVNjg5OURZcjdNUWxGZ24xOVFVaVhWdTgzdmwx?=
 =?utf-8?B?SHRxQ1dkSkVZUVVyWkVsSDNwMlhqckxsam9QZFh4aEpqdE95eU5mM3VrWldG?=
 =?utf-8?B?b0svVmpDeUFEaG9YbzJCbkR5TzZCWTFMODBRVnFWbjU2OXVNTTVGL3NCeXIy?=
 =?utf-8?B?ZW5nenVhdmNhZUF6bnIzUUJ2bzdTSVpaTzBTZzdSYjBsNzdzUWhkbUZWVElW?=
 =?utf-8?B?UW13UmxlNHM4bXdrYzJYcnJndStXSjY0RktwcEMxckVQTnI2aTlYaVNnSmZ0?=
 =?utf-8?B?UlRtYXIvNkRqQUdiTFdXTzExZFYzNTFRUEpzNFpVVXRYSnRDemNFMEVFWVhF?=
 =?utf-8?B?WGk1aEY5SW9EakpNQ1ArSlkybDUxdlg2M2creVpCL3djMGFSOEF5VmNHck9G?=
 =?utf-8?Q?DCp62qpi2Ds+ye9Qty7yBAyCN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51da48fc-415e-4076-4651-08dbafc283fe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 16:50:17.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MI0ZfxQOby4cb+dY3TgOEfAomWK1rM89Vd9ADyxyvIdvXtG4XVdT59E8pZ3BfAA1QZoAw9zlwni1vQms9c9O5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 09:04, Christopher Schramm wrote:
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 5c72067c06d4..b9c451f75d5e 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -1543,11 +1543,13 @@ config X86_MEM_ENCRYPT
>>   config AMD_MEM_ENCRYPT
>>       bool "AMD Secure Memory Encryption (SME) support"
>>       depends on X86_64 && CPU_SUP_AMD
>> +    depends on EFI_STUB
>>       select DMA_COHERENT_POOL
>>       select ARCH_USE_MEMREMAP_PROT
>>       select INSTRUCTION_DECODER
>>       select ARCH_HAS_CC_PLATFORM
>>       select X86_MEM_ENCRYPT
>> +    select UNACCEPTED_MEMORY
>>       help
>>         Say yes to enable support for the encryption of system memory.
>>         This requires an AMD processor that supports Secure Memory
> 
> Unfortunately this makes AMD_MEM_ENCRYPT depend on EFI just to 
> unconditionally enable UNACCEPTED_MEMORY. It seems like an easy target to 
> make that optional, e.g. with a separate configuration item:
> 
> ---
> config AMD_UNACCEPTED_MEMORY
>         def_bool y
>         depends on AMD_MEM_ENCRYPT && EFI_STUB
>         select UNACCEPTED_MEMORY
> ---
> 
> Using that we can successfully build and run SNP VMs without UEFI/OVMF 
> (which we already did with earlier Linux versions).

This seems reasonable to me.

I would recommend naming it AMD_MEM_ENCRYPT_UNACCEPTED_MEMORY to keep the 
association and add a prompt along the lines of "AMD Secure Encrypted 
Virtualization (SEV) unaccepted memory support" (I don't really see this 
used with bare-metal, but who knows.)

I think there will need to be changes elsewhere in the kernel to support 
this, though. A quick build test with just AMD_UNACCEPTED_MEMORY not being 
set broke the build when EFI_STUB was still set to y.

> 
>  From a quick look at
> 
>    [PATCHv14 9/9] x86/tdx: Add unaccepted memory support
> 
> it actually seems very similar for INTEL_TDX_GUEST.
> 
> Ideally UNACCEPTED_MEMORY would not assume EFI either, but the 
> implementation actually clearly does.

@Kirill, is this something you are interested in having as well?

Thanks,
Tom
