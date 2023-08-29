Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE5D78C9E8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbjH2Qs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbjH2QsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:48:09 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DF8B8;
        Tue, 29 Aug 2023 09:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXijfVJPF4MiUpIyokrPLmk9K6PtnwPGwuABuXS8Li9IWuPrqJriC16/gDEqC9g16MARMbdm1/DZH67xNWCuN0aA6HaohOYooHOnl8SrFmareyz4lYNnB3WErpgOyWXLAJMDyp9z9CoSnXxQt6fthOgj6O0+PNxtllNq05ZzOPH2mBwk8MsFQCot9zobnUesx1P6A1J9jFSqVAAX6AQ2M34n09tl5EPSxgCbfT9h0nZR6AXWL2CeAjgPnXerxIxTaXKXiJxrpQ1chLvGPZcwMsCgrxbcraZ+5sLUiBqEvFulM9k8ZNiROJ5fgZN5etVMGVg6pbgue3Vuxq8wqussiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8rrH0WBA+tqejrAEZ9JglB/SRB4szdE5yxe0xt9cnQ=;
 b=PcNKXNyvbbCdWTn3APvhyxEoiEibvoq5T1PWHCSClez62xe8oK1jvr9d4h2vaiFXWpomwRyq1FD0Y9GCn1B3wTY91Hmi7mc4J9EoKt1Tx10Ec7rJslgYCV0VUWpglwb34FsLwqsl3pqXBOv2f0tQIQjOsjLICfyRhjTEqqtYI825uc9TXqT5oYQDT4LCpiaCIQv8Yuz/SFJOHfhsJylHKvOe6rVSE/fA/9mRv3Teq2mOprDoCh/UpH+VYOsfFQTqEoGHM2Gk1Qhqwh5kWLstOVistbuQU+5bvzOX1hJzYrHrFlJNgfNmVka8I+nVM94dcWSIYgDjXMjlv7uu+Rjb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8rrH0WBA+tqejrAEZ9JglB/SRB4szdE5yxe0xt9cnQ=;
 b=Et7CmgL+wyWSNXP1xKHrWnF5QeQGlHUUxdlh52A0Ci7mh8HGESZrZJ7Et7MSQ5mKJBFjk9mPn/qs5WM6oy4NJIzGuYbbNPpvnDsaCqdgP6Z3JWjS7Bv4AubIr3TSF2sPBHJq5iVjlKKKt5izyDXrtH3ayQ3A2pQKPC2qm8/bGyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3818.namprd12.prod.outlook.com (2603:10b6:5:1cf::24)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 16:48:03 +0000
Received: from DM6PR12MB3818.namprd12.prod.outlook.com
 ([fe80::7c3:6646:9b4f:258f]) by DM6PR12MB3818.namprd12.prod.outlook.com
 ([fe80::7c3:6646:9b4f:258f%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 16:48:03 +0000
Message-ID: <bdfa557d-434a-46fa-8e43-3517bd863f40@amd.com>
Date:   Tue, 29 Aug 2023 22:17:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: amdtee: add support for use of cma region
Content-Language: en-US
To:     Alexey Kardashevskiy <aik@amd.com>,
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
 <cd226133-ed18-101b-6401-a6dcd89a1db8@amd.com>
From:   Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
Organization: AMD
In-Reply-To: <cd226133-ed18-101b-6401-a6dcd89a1db8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::9) To DM6PR12MB3818.namprd12.prod.outlook.com
 (2603:10b6:5:1cf::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3818:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d5eb3a-dad9-49d1-1ee7-08dba8afb5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAy9vsjQKNJNLRT3gt8lnR0DvAg3WhQunZ4K9eviG++z3HdBWsyc/BUNgqcQ/p9yAfY7q5J8efpV1AAQmbRb1p5YHqwVgUgaAvhp+wqzGn0bIlQopXbP8K6k2QDcIMIj+JfqtjSEj0e8VTo4lq2shtWDbtA+tlIFLZbKharmUIY2mB8Tl7cHuJiuddkWZf/1cJ1KVR6ko+YONzubVD1Uid99mIbwxYZ5a+BRDTEn29JacQZAryPMtbwYJ4IErteQHhvOrG7jNHj24GpItjadRhuEQLckhx1BwrO7fY+GAimHtNxh1l91Ckr14gSWrbfE1CuEEnNZD6AErYpWLIBdmuOpe5AadY8K76/HcQ8as4dRxbkAdOuRJSd3uvqzQ5ZO0x914X4wtx+C2FK+0uqkXkPkovuyoVMsmdcVUjdOMV2mZ89g+I4VLoQTTxT65QNDDejSd1teESG0ldKcWwdORHXrBK7eD3gxOqAuUgTIbtUHuFn/qpklivwsPU4SvUaT5wd/O5a6EPVLLdhizVNqo8zA+C1q8W4rYn6b5B0fQ9ITahMpAHDeHffPfHwd+AuSpKxMDRW+m5F/uqdTgSF4OisNi8IaAY23xUcdueYi5sz5Hr5aQ6uNUNbqObbBRmJjyK9bN/2dLB40Pqqd5yM7q5ZPlAp3iVPvAA89IBBm9GQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3818.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199024)(186009)(1800799009)(31686004)(6666004)(6512007)(6506007)(36916002)(6486002)(86362001)(36756003)(31696002)(38100700002)(921005)(2616005)(478600001)(2906002)(30864003)(26005)(83380400001)(53546011)(110136005)(8936002)(54906003)(41300700001)(66556008)(66476007)(66946007)(5660300002)(8676002)(4326008)(7416002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNvc1Bjcm54OVN5Q2tKRm52RWpLMTVjZ3lGZUxnNHNVV05GSzlpNWZSenNJ?=
 =?utf-8?B?S1ovVTQzc0wxTEYzS3NPdVMvTk9NYWdqVkFXSjl2WmZ0UVhVbTZkZXVvN0NT?=
 =?utf-8?B?bkVjMElQZzJEV3k1WGZGMW5UeklQYVVneEJENU5QT1JoWmZ3ZVR3NnRlZTVm?=
 =?utf-8?B?V3JCTnNEb0tOcjg0QlRucHFLSjFha3VnWTM0WEdiSHI0ZTJCbWNSL293VEo5?=
 =?utf-8?B?dEdPQmZhRnJYUGlLRHMwSUwydmtIT0w0WnkrcWtsRjA2Tm5QcFdKTmtOMmJv?=
 =?utf-8?B?bVkzZHhCM0tZUGVKVjc1OHY5Szlyd0E4UHhuNFJjcCtWZW8wQnF1dUJST3hD?=
 =?utf-8?B?MFBra0ZLV2lNSVZ1VmE0RDBYdHd0RXpzNk1iMDFSQklBd3lxLzRtQ054WG9Z?=
 =?utf-8?B?RmxHLyt6NmdIQUZ3K1k3T3VwcWtoY1BVem5JQzhZK1VHS2ZIdldmWVR0dlZ5?=
 =?utf-8?B?cytkSlNEK01rZnluR09VdHZSS0RNbFVGQUMxWFpVenozaUdZRHJ1V1B3V0c0?=
 =?utf-8?B?dXlxdWRZY2UxZ3lybm0wTktyNlpRaUh6V2RiRlp4QUlEYXR3NXZ2UFBxR0or?=
 =?utf-8?B?S3FaSm9rRjdmMllLU2dNN3J3cGh6SWVua2kvODhhMkJaeHFUcmZ2eEZJRkxv?=
 =?utf-8?B?b2RCTk1hRy9tcDBvTFVheWtpWVVQMDJhUzlEdkVlWEpYTjFaQmNPelZMQklv?=
 =?utf-8?B?dThCeStLSGNmRmVaUG5iaU92Ym44dzBlS0dkZXVHd21mT3N0SVkxdlFjUXVT?=
 =?utf-8?B?Zm5weU52WGh0Q3NjUDhNTmtId0JjN1c2amErT2tKbGRKOXlsUWtna2FHNDRH?=
 =?utf-8?B?TWgwYUoxTzIrU3Vmc085NjF5bFlBeXZWYUVLTktuUEliSGh3Y0tVN0lZR2gw?=
 =?utf-8?B?bU90RitsdDRNWkEraFB5T2tFZzZoNTQ2aFVLTEVReWR6a0hrbEZFVGtEdXds?=
 =?utf-8?B?Umo2RzBIT0pBa2RtV2JuYzlQWGNHRDhFWXgvRWRiTEt6QW8rRGRzRWVQcHBz?=
 =?utf-8?B?VjZ1b3QvNWI4ckhyNC9RaDFWR3hsM1QyL1hWalhKTHk5SGQ0UmoraFFTT1Vk?=
 =?utf-8?B?MnlabWlXcDF4VUJLTSszV0llRCtEc1RlZEQ1L0FYRHV6UWZrQTYrZERQc09t?=
 =?utf-8?B?RVdYaGx6QUp6Z3BUSy8xTVZ1ZEJ1WWJsazdnUUdhWklaUExlenVqZW02VitV?=
 =?utf-8?B?bTRrU3ZHQW01UXRnVEhOaU83TEcyYjhIeTQxVzVOb0JVNHk4RXFESm91ZHIr?=
 =?utf-8?B?SDFxdnZOODFBNzhWY0ZvZFU2aU5MNEhuZWdVZ3I4WWhkcWVBTS9UZnlxdlU2?=
 =?utf-8?B?M2s4eXAySHR2VUJubitGa1o5VCt6ZjllazgrVEYzZ2JNMVNIamRjNUpnQ0lu?=
 =?utf-8?B?L3ZJQ0h6YkpIZ0hrbUl2WkZrRVpqcGozamdvTzU2VDJOSmU0d2lUM3RianNk?=
 =?utf-8?B?YzlwRTNTZ202RWZ3REkwRTVITFJiWWFXSGJaNmhpNXlKd3AwbkRBVHVOSTd6?=
 =?utf-8?B?QmRGckZmellwNWdCV3kxd1Q2UzlUT3h4Z3IwOGloVW5aaUhZS3ovQk41dDl0?=
 =?utf-8?B?dHMzQXVlK1daNGVKeDhvaTZDcjEyMmNPbHFHazBHZ2o5ejdDUUVNK3lCYzRt?=
 =?utf-8?B?dHk4Q0t0WW5FVmdmTzQzRHpPYkxSbFExUkNmcTd1d040bklrVG5ncktYc1pi?=
 =?utf-8?B?aDVzQ3BFdnpLRnQvS1NBb2dlQmRPMms0ZGVzRmtQeUVqRHZCSytlanRRRyta?=
 =?utf-8?B?ZVhKVzRBbTJSdzJGcUxnUXVFL0VCQ0dSRlN4bWdEY2ltMmNKYmxUUHI4MmE2?=
 =?utf-8?B?NGxKRjUyQlM1bkE5a09TWWlzazZEWWlONE5WMldZR2pDVGNrcGtyU1NBZkUw?=
 =?utf-8?B?Q1M1Q2VlVlJSZUNLRVdaZVQycytCNHNVWUlLZW9nY0p0SEN5NnhxVER1R25J?=
 =?utf-8?B?TWdRbjlTSHFndkp0M2N1amRyYXVUV1o3dXJzOXNUSXp4ZE9WWk9PcUxubGx5?=
 =?utf-8?B?dUY4aWcvV3diM2lRSnY4ZnIvYzV6MlNEN001YXJyK1NLcm5JSlpNM2thNXRX?=
 =?utf-8?B?NjZzR2VhRGI2TWQ1MmJOWlhRT2pGTU5tV3lFaW1rb041aW5ud2MraVc3OGtR?=
 =?utf-8?Q?zpdZvyCg71iTRB1TL8UC8fXSb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d5eb3a-dad9-49d1-1ee7-08dba8afb5fe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3818.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 16:48:03.2973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yf57sRv6p0KDaMkc20h1lME8QPCFpyTz9QBe3ZepdT5yL/spSqGgmpE0VMmnqyBabs2bUQHb3qtVl/dWeQVTig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/19/2023 4:03 PM, Alexey Kardashevskiy wrote:
> On 19/8/23 00:42, Devaraj Rangasamy wrote:
>> In systems with low memory configuration, memory gets fragmented
>> easily, and any bigger size contiguous memory allocations are likely
>> to fail.
>> Contiguous Memory Allocator (CMA) is used to overcome this
>> limitation, and to guarantee memory allocations.
>>
>> This patch adds support for CMA area exclusive to amdtee.
>> The support can be enabled if kernel have CONFIG_CMA enabled.
>> The size can be set via the AMDTEE_CMA_SIZE config option
>> at compile time or with the "amdtee_cma" kernel parameter.
>> (e.g. "amdtee_cma=32 for 32MB").
>>
>> Also, cma zone is utilized only for buffer allocation bigger than
>> 64k bytes. When such allocation fails, there is a fallback to the
>> buddy allocator. Since CMA requires a boot time initialization,
>> it is enabled only when amdtee is built as an inbuilt driver.
>>
>> Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
>> Co-developed-by: SivaSangeetha SK <SivaSangeetha.SK@amd.com>
>> Signed-off-by: SivaSangeetha SK <SivaSangeetha.SK@amd.com>
>> Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  7 ++
>>   arch/x86/include/asm/setup.h                  |  6 ++
>>   arch/x86/kernel/setup.c                       |  2 +
>>   drivers/tee/amdtee/Kconfig                    |  9 +++
>>   drivers/tee/amdtee/Makefile                   |  1 +
>>   drivers/tee/amdtee/amdtee_private.h           |  6 +-
>>   drivers/tee/amdtee/core.c                     |  6 +-
>>   drivers/tee/amdtee/shm_pool.c                 | 32 ++++++--
>>   drivers/tee/amdtee/shm_pool_cma.c             | 78 +++++++++++++++++++
>>   drivers/tee/amdtee/shm_pool_cma.h             | 38 +++++++++
>>   10 files changed, 176 insertions(+), 9 deletions(-)
>>   create mode 100644 drivers/tee/amdtee/shm_pool_cma.c
>>   create mode 100644 drivers/tee/amdtee/shm_pool_cma.h
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt 
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index 722b6eca2e93..5e38423f3d53 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -363,6 +363,13 @@
>>                 selects a performance level in this range and 
>> appropriate
>>                 to the current workload.
>>   +    amdtee_cma=nn    [HW,TEE]
>> +            Sets the memory size reserved for contiguous memory
>> +            allocations, to be used by amdtee device driver.
>> +            Value is in MB and can range from 4 to 128 (MBs)
>> +            CMA will be active only when CMA is enabled, and amdtee is
>> +            built as inbuilt driver, and not loaded as module.
>> +
>>       amijoy.map=    [HW,JOY] Amiga joystick support
>>               Map of devices attached to JOY0DAT and JOY1DAT
>>               Format: <a>,<b>
>> diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
>> index f3495623ac99..bb5e4b7134a2 100644
>> --- a/arch/x86/include/asm/setup.h
>> +++ b/arch/x86/include/asm/setup.h
>> @@ -66,6 +66,12 @@ extern void x86_ce4100_early_setup(void);
>>   static inline void x86_ce4100_early_setup(void) { }
>>   #endif
>>   +#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA)
>> +void amdtee_cma_reserve(void);
>> +#else
>> +static inline void amdtee_cma_reserve(void) { }
>> +#endif
>> +
>>   #ifndef _SETUP
>>     #include <asm/espfix.h>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index fd975a4a5200..e73433af3bfa 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -1223,6 +1223,8 @@ void __init setup_arch(char **cmdline_p)
>>       initmem_init();
>>       dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
>>   +    amdtee_cma_reserve();
>> +
>>       if (boot_cpu_has(X86_FEATURE_GBPAGES))
>>           hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
>>   diff --git a/drivers/tee/amdtee/Kconfig b/drivers/tee/amdtee/Kconfig
>> index 191f9715fa9a..5843c739a7b8 100644
>> --- a/drivers/tee/amdtee/Kconfig
>> +++ b/drivers/tee/amdtee/Kconfig
>> @@ -6,3 +6,12 @@ config AMDTEE
>>       depends on CRYPTO_DEV_SP_PSP && CRYPTO_DEV_CCP_DD
>>       help
>>         This implements AMD's Trusted Execution Environment (TEE) 
>> driver.
>> +
>> +config AMDTEE_CMA_SIZE
>> +    int "Size of Memory in MiB reserved in CMA for AMD-TEE"
>> +    default "0"
>> +    depends on CMA && (AMDTEE=y)
>> +    help
>> +      Specify the default amount of memory in MiB reserved in CMA 
>> for AMD-TEE driver
>> +      Any amdtee shm buffer allocation larger than 64k will allocate 
>> memory from the CMA
>> +      The default can be overridden with the kernel commandline 
>> parameter "amdtee_cma".
>> \ No newline at end of file
>> diff --git a/drivers/tee/amdtee/Makefile b/drivers/tee/amdtee/Makefile
>> index ff1485266117..a197839cfcf3 100644
>> --- a/drivers/tee/amdtee/Makefile
>> +++ b/drivers/tee/amdtee/Makefile
>> @@ -3,3 +3,4 @@ obj-$(CONFIG_AMDTEE) += amdtee.o
>>   amdtee-objs += core.o
>>   amdtee-objs += call.o
>>   amdtee-objs += shm_pool.o
>> +amdtee-objs += shm_pool_cma.o
>> diff --git a/drivers/tee/amdtee/amdtee_private.h 
>> b/drivers/tee/amdtee/amdtee_private.h
>> index 6d0f7062bb87..9ba47795adb6 100644
>> --- a/drivers/tee/amdtee/amdtee_private.h
>> +++ b/drivers/tee/amdtee/amdtee_private.h
>> @@ -87,11 +87,13 @@ struct shmem_desc {
>>    * struct amdtee_shm_data - Shared memory data
>>    * @kaddr:    Kernel virtual address of shared memory
>>    * @buf_id:    Buffer id of memory mapped by TEE_CMD_ID_MAP_SHARED_MEM
>> + * @is_cma:    Indicates whether memory is allocated from cma region 
>> or not
>>    */
>>   struct amdtee_shm_data {
>>       struct  list_head shm_node;
>>       void    *kaddr;
>>       u32     buf_id;
>> +    bool    is_cma;
>>   };
>>     /**
>> @@ -145,9 +147,9 @@ int amdtee_invoke_func(struct tee_context *ctx,
>>     int amdtee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 
>> session);
>>   -int amdtee_map_shmem(struct tee_shm *shm);
>> +int amdtee_map_shmem(struct tee_shm *shm, bool is_cma);
>>   -void amdtee_unmap_shmem(struct tee_shm *shm);
>> +void amdtee_unmap_shmem(struct tee_shm *shm, bool *is_cma);
>>     int handle_load_ta(void *data, u32 size,
>>              struct tee_ioctl_open_session_arg *arg);
>> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
>> index 372d64756ed6..448802dccf13 100644
>> --- a/drivers/tee/amdtee/core.c
>> +++ b/drivers/tee/amdtee/core.c
>> @@ -336,7 +336,7 @@ int amdtee_close_session(struct tee_context *ctx, 
>> u32 session)
>>       return 0;
>>   }
>>   -int amdtee_map_shmem(struct tee_shm *shm)
>> +int amdtee_map_shmem(struct tee_shm *shm, bool is_cma)
>>   {
>>       struct amdtee_context_data *ctxdata;
>>       struct amdtee_shm_data *shmnode;
>> @@ -368,6 +368,7 @@ int amdtee_map_shmem(struct tee_shm *shm)
>>         shmnode->kaddr = shm->kaddr;
>>       shmnode->buf_id = buf_id;
>> +    shmnode->is_cma = is_cma;
>>       ctxdata = shm->ctx->data;
>>       mutex_lock(&ctxdata->shm_mutex);
>>       list_add(&shmnode->shm_node, &ctxdata->shm_list);
>> @@ -378,7 +379,7 @@ int amdtee_map_shmem(struct tee_shm *shm)
>>       return 0;
>>   }
>>   -void amdtee_unmap_shmem(struct tee_shm *shm)
>> +void amdtee_unmap_shmem(struct tee_shm *shm, bool *is_cma)
>>   {
>>       struct amdtee_context_data *ctxdata;
>>       struct amdtee_shm_data *shmnode;
>> @@ -395,6 +396,7 @@ void amdtee_unmap_shmem(struct tee_shm *shm)
>>       mutex_lock(&ctxdata->shm_mutex);
>>       list_for_each_entry(shmnode, &ctxdata->shm_list, shm_node)
>>           if (buf_id == shmnode->buf_id) {
>> +            *is_cma = shmnode->is_cma;
>>               list_del(&shmnode->shm_node);
>>               kfree(shmnode);
>>               break;
>> diff --git a/drivers/tee/amdtee/shm_pool.c 
>> b/drivers/tee/amdtee/shm_pool.c
>> index f0303126f199..9aad401387be 100644
>> --- a/drivers/tee/amdtee/shm_pool.c
>> +++ b/drivers/tee/amdtee/shm_pool.c
>> @@ -7,19 +7,30 @@
>>   #include <linux/tee_drv.h>
>>   #include <linux/psp.h>
>>   #include "amdtee_private.h"
>> +#include "shm_pool_cma.h"
>>     static int pool_op_alloc(struct tee_shm_pool *pool, struct 
>> tee_shm *shm,
>>                size_t size, size_t align)
>>   {
>>       unsigned int order = get_order(size);
>>       unsigned long va;
>> +    bool is_cma = false;
>>       int rc;
>>         /*
>>        * Ignore alignment since this is already going to be page aligned
>>        * and there's no need for any larger alignment.
>>        */
>> -    va = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
>> +
>> +    /* if CMA is available, use it for higher order allocation */
>> +    if (amdtee_get_cma_size() && order > 6)
>> +        va = amdtee_alloc_from_cma(shm, order);
>> +
>> +    if (va)
>> +        is_cma = true;
>> +    else
>> +        va = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
>> +
>>       if (!va)
>>           return -ENOMEM;
>>   @@ -28,9 +39,13 @@ static int pool_op_alloc(struct tee_shm_pool 
>> *pool, struct tee_shm *shm,
>>       shm->size = PAGE_SIZE << order;
>>         /* Map the allocated memory in to TEE */
>> -    rc = amdtee_map_shmem(shm);
>> +    rc = amdtee_map_shmem(shm, is_cma);
>>       if (rc) {
>> -        free_pages(va, order);
>> +        if (is_cma)
>> +            amdtee_free_from_cma(shm);
>> +        else
>> +            free_pages(va, order);
>> +
>>           shm->kaddr = NULL;
>>           return rc;
>>       }
>> @@ -40,9 +55,16 @@ static int pool_op_alloc(struct tee_shm_pool 
>> *pool, struct tee_shm *shm,
>>     static void pool_op_free(struct tee_shm_pool *pool, struct 
>> tee_shm *shm)
>>   {
>> +    bool is_cma = false;
>> +
>>       /* Unmap the shared memory from TEE */
>> -    amdtee_unmap_shmem(shm);
>> -    free_pages((unsigned long)shm->kaddr, get_order(shm->size));
>> +    amdtee_unmap_shmem(shm, &is_cma);
>> +
>> +    if (is_cma)
>
> No need in is_cma here and other places.
Ack.
cma_release() do have inbuilt validation, and returns true/false as 
result for valid cma buffer release.
>
>
>> +        amdtee_free_from_cma(shm);
>> +    else
>> +        free_pages((unsigned long)shm->kaddr, get_order(shm->size));
>> +
>>       shm->kaddr = NULL;
>>   }
>>   diff --git a/drivers/tee/amdtee/shm_pool_cma.c 
>> b/drivers/tee/amdtee/shm_pool_cma.c
>> new file mode 100644
>> index 000000000000..99dda9adb1c6
>> --- /dev/null
>> +++ b/drivers/tee/amdtee/shm_pool_cma.c
>> @@ -0,0 +1,78 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA)
>> +
>> +#define pr_fmt(fmt) "%s: " fmt, __func__
>> +
>> +#include <linux/cma.h>
>> +#include <linux/mm.h>
>> +#include <linux/tee_drv.h>
>> +#include "shm_pool_cma.h"
>> +
>> +static struct cma *amdtee_cma;
>> +unsigned long amdtee_cma_size __initdata = CONFIG_AMDTEE_CMA_SIZE * 
>> SZ_1M;
>> +
>> +static int __init early_parse_amdtee_cma(char *p)
>> +{
>> +    int cmd_size;
>
> Not int but unsigned long long.
Ack.
We have reverted new exclusive cma zone.
>
>> +
>> +    if (!p)
>> +        return 1;
>> +
>> +    cmd_size = memparse(p, NULL);
>> +    if (cmd_size >= 4 && cmd_size <= 256)
>> +        amdtee_cma_size = cmd_size * SZ_1M;
>
> Change the doc to use 4M and 256M instead of plain 4 and 256. Or stop 
> using memparse().
>
> /me sad.
>
Ack.
Thanks for review.
>
>> +    else
>> +        pr_err("invalid amdtee_cma size: %lu\n", amdtee_cma_size);
>> +
>> +    return 0;
>> +}
>> +early_param("amdtee_cma", early_parse_amdtee_cma);
>> +
>> +void __init amdtee_cma_reserve(void)
>> +{
>> +    int ret;
>> +
>> +    ret = cma_declare_contiguous(0, amdtee_cma_size, 0, 0, 0, false, 
>> "amdtee", &amdtee_cma);
>> +    if (ret)
>> +        pr_err("Failed to reserve CMA region of size %lu\n", 
>> amdtee_cma_size);
>> +    else
>> +        pr_info("Reserved %lu bytes CMA for amdtee\n", 
>> amdtee_cma_size);
>> +}
>> +
>> +unsigned long amdtee_alloc_from_cma(struct tee_shm *shm, unsigned 
>> int order)
>> +{
>> +    struct page *page = NULL;
>> +    unsigned long va = 0;
>> +    int nr_pages = 0;
>> +
>> +    if (amdtee_cma) {
>> +        nr_pages = 1 << order;
>> +        page = cma_alloc(amdtee_cma, nr_pages, 0, false);
>> +        if (page)
>> +            va = (unsigned long)page_to_virt(page);
>> +        else
>> +            pr_debug("failed to allocate from CMA region\n");
>> +    } else {
>> +        pr_debug("CMA region is not available\n");
>> +    }
>> +    return va;
>> +}
>> +
>> +void amdtee_free_from_cma(struct tee_shm *shm)
>> +{
>> +    struct page *page;
>> +    int nr_pages = 0;
>> +
>> +    if (amdtee_cma) {
>> +        nr_pages = 1 << get_order(shm->size);
>> +        page = virt_to_page(shm->kaddr);
>> +        cma_release(amdtee_cma, page, nr_pages);
>> +    } else {
>> +        pr_err("CMA region is not available\n");
>> +    }
>> +}
>> +#endif /* IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA) */
>> diff --git a/drivers/tee/amdtee/shm_pool_cma.h 
>> b/drivers/tee/amdtee/shm_pool_cma.h
>> new file mode 100644
>> index 000000000000..d1cde11cbede
>> --- /dev/null
>> +++ b/drivers/tee/amdtee/shm_pool_cma.h
>> @@ -0,0 +1,38 @@
>> +/* SPDX-License-Identifier: MIT */
>> +
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#ifndef SHM_POOL_CMA_H
>> +#define SHM_POOL_CMA_H
>> +
>> +#if IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA)
>> +
>> +extern unsigned long amdtee_cma_size;
>> +
>> +static inline unsigned long amdtee_get_cma_size(void)
>> +{
>> +    return amdtee_cma_size;
>> +}
>> +
>> +unsigned long amdtee_alloc_from_cma(struct tee_shm *shm, unsigned 
>> int order);
>> +
>> +void amdtee_free_from_cma(struct tee_shm *shm);
>> +
>> +#else /* IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA) */
>> +
>> +static inline unsigned long amdtee_get_cma_size(void)
>> +{
>> +    return 0;
>> +}
>> +
>> +static inline unsigned long amdtee_alloc_from_cma(struct tee_shm 
>> *shm, unsigned int order)
>> +{
>> +    return 0;
>> +}
>> +
>> +static inline void amdtee_free_from_cma(struct tee_shm *shm) { }
>> +
>> +#endif /* IS_BUILTIN(CONFIG_AMDTEE) && IS_ENABLED(CONFIG_CMA) */
>> +#endif /* SHM_POOL_CMA_H */
>
