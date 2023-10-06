Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0500F7BC21F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjJFWPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJFWPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:15:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE45BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:15:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFWW6VLSnvwxuSejS5rRezmGEq00OkknAFUBlMkT7ijREwQ7Xgajy3OHwP4xc2MhIU2HLu71zdn6hZL1pbRkN96s0CN7L2Su8CysETVUt/rQIy4XZQK2oukBqLPy0vYv29rWLzkHO3Wj2ZgcBTPxdzCKnc28oc7kE5vCr4jqElbSE5qS7ebYZYe/wRQeHocHEePVjbJXy20BzTUhin+Kmo6OqpXbTBcgSEXh4JZbqDXoO/Vk8hcUfcZ8X6pj+nHk/bwP/+IiMmFUcKeV6iwLloQ+d72MRewcGn7E/qoAOAX/u0qZ4Dm6Thfnhr3HOueV9zp1wE2s19LDJEdNqAV8Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dN6Z5QszQ5EpAPvPSOFOQMNg0o2WKKCZIlVxJUigaUI=;
 b=k/Q5tIGgr6B4i8r6NFclbXoK77B9j9kfrALKY0Ca3ENrL/7ub8BOZXPI8KY3gvzPnwstlSG6PwanN2ntLZD6FzR9G7kOY290bfl/GcrOqNbIa4De1RavMRWddeGeFE5oQUjnxLZPHBvYkvBFey/G1ytMqOll0pB/Je8OBnQZNoAVGiCHk+kcPdou+Kik2JVvxpUeHPNpo23j81Dz1MNexxxn394pc/HkVsPDrsY20aBESI/g4V0cNhZDHjm3gI8S+E99QtNR5g/I7oXrN/MIV8QMkcY0fl2jWq+K5zaiPZa/OBRiutSIKnu2hnO74fQf9NnelNQ7hSlp6Tnx80pQVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dN6Z5QszQ5EpAPvPSOFOQMNg0o2WKKCZIlVxJUigaUI=;
 b=WhBDK4hUsrwZ6Ae0URItePlrL2hnpd+BZhuvi5c6fhsn1tSwoWM30Ju5W5SSmicLDelAIAsrG9hDNIYhzd6yJr0jG2r2KMrLPJcTyNkInx0obhuV0RM/ALJzJ9OQ4fD/KupWmN1G8VWuqvFRD0/jp89d6GQ0PKhXLh8wRJ5pTck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 22:15:40 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::6ac8:eb30:6faf:32b2]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::6ac8:eb30:6faf:32b2%5]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 22:15:40 +0000
Message-ID: <ef24ca9a-383e-196d-fcfb-9b4f2e62d60a@amd.com>
Date:   Fri, 6 Oct 2023 17:15:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 10/13] x86/tdx: Convert shared memory back to private on
 kexec
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
 <ZSAge6W4vF6ePudw@google.com>
 <20231006151151.2m6t7fcu36hlrtzj@box.shutemov.name>
From:   "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20231006151151.2m6t7fcu36hlrtzj@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR01CA0030.prod.exchangelabs.com (2603:10b6:5:296::35)
 To SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c38b52-7e09-4fa6-b8db-08dbc6b9c60c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYBl3FvqLo7rEh44MBpoCHiAUJuEJPJGgjh6ncECYJFWR16h5zmZGbmEQJiPOPNNVBk+5OMPfOh5/hBNuKIBxygFQjzOUutrHC6YEI+P8c5rx+qdoeEIe9dKss4xkkIq6T12F6B6A/jff17LSomPy9A/g+P969RUfMzPyZAYn2tIL9ThhsOXXMsVacFK+PDflPEN4EtyRymrxRtDYDDmSaIOC4ip8s6uykZTPumx0VXlHVkPbH/kMB0ZIz7fY1fJD7OGd9YlCaNsVUT3zoJ5Z/BYjXsOaL4gfGcvG3R4KI+Ay80HLPOyCA/hSKAVRnWzZTxy+nejPyl+e5PTql9SWBC1vZPJeX7ELGwm2YPQNcIZg7oStxP76XpzLvuX7t22cR1U03Hi1WjjHk0Q0kYtMDSDVuJLtl0VZTC9rDSWFfkynKlLH3nBSRzo3G5Ol0dETfwbTc28JYqkVDA9qeqSOEbAXDIp7ElSG++RRHSc/1LZkGvJCVNoyDryaWf94Akph0Cgt6s/WO9SMYiVtRSF6nOt49I1+HGxdIsGUsBMLTMxKYKneviN5J39M4xti24CKs0wq+EMc8TWv9LiALKKS/mN1olmkAcM9pJ1i7ROknY7KKMI986fokFOnzDIS3q1G3RR9LCfMxxORybX06IpQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(53546011)(31686004)(66899024)(4326008)(8936002)(38100700002)(5660300002)(31696002)(86362001)(8676002)(36756003)(7416002)(66476007)(66556008)(316002)(66946007)(54906003)(478600001)(6486002)(2906002)(41300700001)(26005)(6512007)(110136005)(6506007)(2616005)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlNUNUYyU2hnRHEyaHRCUkpvV3JNTkNPbHUwWDFmeW4rR2hkNFdrWHJDaTVy?=
 =?utf-8?B?YjNMYmpIWFk0b0lYYXhlSm5haTVZN1grdXBNNkIxeHhEUnJJV0E4OUVQMkQw?=
 =?utf-8?B?QUNPc3NRaXIrNmpWZExwZW1PajZ0UldZb1RrNW05b1YrVUV4OG9PSWx6UUt3?=
 =?utf-8?B?cnlFVVM4WUdNTzhCZDhzRW94cEJrTEhaazlPLzNJVG51eVZSMjN6QkhaS2RT?=
 =?utf-8?B?cGpvZ0hpTnNrc2FudVl2QXRyajlxbG9GeVdjd0pCZ2NKTmFkZzBlaHQ1M1Nr?=
 =?utf-8?B?RWc1ZEJKVENtOVNjMUJ1TUR3ZjZTR2RiMGx3dDUxcGVaWElBMkdJWllMODkr?=
 =?utf-8?B?REMxMC85NllGYjlpRXZNcTRDYVZMeGQ1elNRNmk4akhkdjZvdllka0VNaU1o?=
 =?utf-8?B?MU1HNDNuQjFnaUtOSk1aN1JpTmtkNjR3OXNOd3VwTERzS0xRWU5qNC9yRHFC?=
 =?utf-8?B?OEFNd1lkV1V2L1lZci8vVElDMXNxeXZxUmgxekxGUHg5UzJwT21nOHRQbmVz?=
 =?utf-8?B?cFVYMmNTYWs5Z1BQcm5XQitXMFhvR3IwUGIzcGhFdjRLWUNqMkV3T2pYdytz?=
 =?utf-8?B?b05qTGx5Yy9JSVpFOG13Ly9RcjZYc0dUd3RZdFQvbnlMOW15VUFFMVFCcUw0?=
 =?utf-8?B?OUlPcjY5OXBtckU0cmUvZXF4SXB1djk0QkY2M2t3ay9wbk9HMVdvTlBpRFBp?=
 =?utf-8?B?SVk4YkFjT3BrQXBFS0dpYjdFemZSRkZYaG53cDlUelcwNmcwaUlmYjJGWGJN?=
 =?utf-8?B?NWtUczh6RHNMYXZ0K3U1MmVRa3pFa0NISWovWEhBQjRuL2g5ZWc1N1UrNWJK?=
 =?utf-8?B?SWprWkMvUFVtQkVvbzB4d0oxVG1VMkVDTmVlT3JROUlyODYwYkVOYVV4Z1l5?=
 =?utf-8?B?OTdLbGJxZVRHSWFpUkw3Q05sYjFyNnpiQStkSU41NjNQWk41R1ZabEMxUUlL?=
 =?utf-8?B?STVHdlNNSDgrYzNrK1A3M2loQWRRNnZvenZjLy92NUl6ZjBwNWx5dUd4ZHpo?=
 =?utf-8?B?cmg5TU5GRXRCRTRTRFcrTlBPTlFuOVBGR2FBQ2NMK3Fwd3Rra2IzQkNjTVg3?=
 =?utf-8?B?Z004SlNtYUVtVWpJSHJPZ1BudVVwdWRxYmhPRFNuTTcyMDJlMDJ2U1VTeDFh?=
 =?utf-8?B?d2NzMC9rRnVFbFZpUUl6cWRockViYjFPRHJCYk85d0VqWSswcGZkYlBNNExr?=
 =?utf-8?B?QzZxZmpzWXl0UEU3QStzTk80WHplZGFaT3BCV3F0dTViZVNnVXNZZzAzWWtO?=
 =?utf-8?B?MWczZDUrMHVuR2VSNTJoSU83VUNjRnZWN1MvNjFZWGthQ3p0THlnQ3A5MWsz?=
 =?utf-8?B?WE9VOEtKRmJUd21MV0QwOWFLcCtnZHNPNDBHdDh3aFpwdEdGREZkMDJTaVkz?=
 =?utf-8?B?MTBta0Y3enk2REhYQXZFU3VMZlpsbmoxejB6eWdGR1Z2ZmM1NFB5VkdLNWJo?=
 =?utf-8?B?Rkt5RUFVOWVQZC9sTmR0SXpDM0VtVnpmRW11K0pEYUR4QmNqdGMvZ0ZpaFc0?=
 =?utf-8?B?THJCbm4xdUV4aTBlakhVZFJMWG1LaENIbG8yL0wra0lqd3FSQ2dZZEtpTllH?=
 =?utf-8?B?cG9BUXAwbHN0bW84YzBzeGJ2YURPOENELzhGN0pZak1JMVlBeUdPSGNkMU9t?=
 =?utf-8?B?L0NGek5laXRNZGh2YzBWZmZUNWppQlFtUmN3N215MmwxRGNrRWlXV0IwTG93?=
 =?utf-8?B?MUJGWDlTK2wwSllqdHpPNUtYZEpjOFVSTzE3cFVQMGIwVTNPWFpCODJVQlJs?=
 =?utf-8?B?Mml2emJTYlBmZEc4N3I3SUdROWFWR2ZhQzVXUTZ0bEl1c2x6MFlhUU92MENt?=
 =?utf-8?B?Q0tNMUdaNDVQOW4vcTdYc3JEQ0NUWldudTdRcXI4SnVvck1KenFyMFdjZjJE?=
 =?utf-8?B?cnl1NkJQRUxiZHArR2x3T3lPVUZJY0JqdmRVc0NVYjFjcExhLzl1LzhlRXY2?=
 =?utf-8?B?ZDZEazdiRnkvdHVkZEhnRGgxS0FMZ3RHVVplVW95M0tZRi9oLzh5NlBnMjVH?=
 =?utf-8?B?U2Y2SmFaclBWcUJLSXJoTlVsUnJ4RzA3UUFCLzcxYkhVNFRRNklmYTI2UFow?=
 =?utf-8?B?Y0t6eG4xcS8vMFZQVWtTaDVoUVY0bFJ3bE5MaUk1eWpmRDlVdHNGV0ZCaGsz?=
 =?utf-8?Q?1sRfbhdi9eyWeJKMjtssZ8TbC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c38b52-7e09-4fa6-b8db-08dbc6b9c60c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 22:15:39.8576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDoial1oDEytHioR+wWcj0cg157iepjCXGHNcJ2yZ3ySDXJwZ2QHSVP5Zh96EpiphunZpoBEX4yoBAMPllNaxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/6/2023 10:11 AM, Kirill A. Shutemov wrote:
> On Fri, Oct 06, 2023 at 07:58:03AM -0700, Sean Christopherson wrote:
>> On Thu, Oct 05, 2023, Kirill A. Shutemov wrote:
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index 7368d254d01f..b5acf9fb4c70 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
>>>   	select X86_MEM_ENCRYPT
>>>   	select X86_MCE
>>>   	select UNACCEPTED_MEMORY
>>> +	select EMERGENCY_VIRT_CALLBACK
>>>   	help
>>>   	  Support running as a guest under Intel TDX.  Without this support,
>>>   	  the guest kernel can not boot or run under TDX.
>>
>> ...
>>
>>>   void __init tdx_early_init(void)
>>>   {
>>>   	struct tdx_module_args args = {
>>> @@ -882,6 +1007,14 @@ void __init tdx_early_init(void)
>>>   	 */
>>>   	x86_cpuinit.parallel_bringup = false;
>>>   
>>> +	machine_ops.shutdown = tdx_shutdown;
>>> +
>>> +	/*
>>> +	 * KVM overrides machine_ops.crash_shutdown, use emergency
>>
>> This is going to be super confusing.  KVM utilizes the emergency virt callback.
>> The KVM paravirt guest code uses .crash_shutdown().  People that are passingly
>> familiar with virt and know what KVM is, but don't already know the difference
>> between the two are going to be all kinds of confused.
>>
>> I also feel like you're playing with fire, e.g. what's to stop the hypervisor
>> specific paravirt guest support from using .shutdown() in the future?
>>
>> And the callback is invoked for far more than just kexec().  I don't see how the
>> host can emulate a reboot without destroying and rebuilding the VM, e.g. it can't
>> stuff register state to emulate INIT or RESET.  Unless I'm missing something,
>> converting shared memory back to private for a shutdown or reboot is undesirable
>> as adds one more thing that can go wrong and prevent the system from cleanly
>> shutting down ASAP (for some definitions of "cleanly").
> 
> Okay, fair enough. I will look for better way to hookup into kexec
> process. That was the best fit I found so far, but yes it is not ideal.
> 
>> Lastly, doesn't SEV need similar behavior?  This seems like core functionality
>> for any guest with cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT).  Why not make the
>> "unshare on kexec" code common and gate it with CC_ATTR_GUEST_MEM_ENCRYPT?
> 
> I don't know SEV specifics. I am open to collaboration on this.
> 
> Tom, Ashish, let me know if you need this in generic code. I can arrange
> that.
> 

Yes, some kind of a generic interface like unshare_on_kexec() gated with 
CC_ATTR_GUEST_MEM_ENCRYPT is needed, we can then add SNP specific kexec 
functionality as part of this.

Thanks,
Ashish
