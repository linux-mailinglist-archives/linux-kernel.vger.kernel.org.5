Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC587D72D1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjJYSED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjJYSD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:03:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C62E5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnfBWEKYd8XellaeHj6V3JQ+mkfvRSfEB5rzY/2bNIQsm1t2YZMghwvM1r/lmvGxnjh6HtPSuLzYm/J5fSZtNqGZ6jngt4OeCSIJUFpbIhyRS3mflhYasbRyN6ghUqr5Tou+ak55YIwa1uIDPJwu3f/Jpc8UKthBz27skyxkwUtzZ/O3KPGp5xF9tLL7eVQHojb0hf6KDHhq/ApCI2k6TUQ7VVsTP5AR2UeoZBP6MwjABLODB8iA3O8cvFelenuVZ9Nn79hyciczRchaOOJzfLODaHT/7BTB8IrigEI2UHMZuE4+YQIPgVQOjc2ZN5npvq2qleUK/9e5Mq4yo0GYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzX4gsT7Sx6aqtQ1h7/U13tWzkgN51VzSiYdEHgLMHY=;
 b=CFQr+KwP6etFhhdJbFioH3yRZeOfBv1PkmicqNmZ4OLYe9sCb9F2i5Nn1nqVco5cO1TUYbjQNpRsqlQZom3rC89H4zuRlBL77P1bcgoqxgnmjo6sQVwCeWfQ9hVdyloQG2Psf+zcgObcmofcCnO9gKzIUjSOwQoIXqhnTwW9UCuJbZLQp50b8VWGgmZiOCSTkW27Qmiis5XLylAzcKpXNulMVou6bdltjwVOUYuWzR+GPgaHoYBPNk0IrTeyIIJ/IoQ3fFFPCyB/auCHtEhCaFIHgm1E0uoPy7iwSetdsB0Kumn/jGnkp+NHS5iS22N14Hflg8ufs19JFxu2xQ5GXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzX4gsT7Sx6aqtQ1h7/U13tWzkgN51VzSiYdEHgLMHY=;
 b=mzF/KZjNtFwsSgPI/xhN6cP9ILttfJqfej6kzk208nQfB40Ga8ppvgDj7zHcTP/uwgO3HMYoqmaYZyQTfMz0KLEJ5oFfmIcuPEqRsu5PDvIUWbbDQV4A5sgqczRph+hUjOYJm371BoB8fykb9/f4c1qaD+hYxArRxET9PPdhzqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM3PR12MB9390.namprd12.prod.outlook.com (2603:10b6:0:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 18:03:51 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::e16e:d7f1:94ad:3021]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::e16e:d7f1:94ad:3021%7]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 18:03:51 +0000
Message-ID: <29564bbe-b7a0-fcc5-47ee-093a032a11b6@amd.com>
Date:   Wed, 25 Oct 2023 13:03:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, kirill.shutemov@linux.intel.com,
        elena.reshetova@intel.com, isaku.yamahata@intel.com,
        seanjc@google.com, Michael Kelley <mikelley@microsoft.com>,
        decui@microsoft.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <20231024234829.1443125-1-rick.p.edgecombe@intel.com>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20231024234829.1443125-1-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:805:66::16) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM3PR12MB9390:EE_
X-MS-Office365-Filtering-Correlation-Id: 3888550b-66e0-4471-64c5-08dbd584be5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ua3lPtI77Gmh3KQJeEKFnSHfIT6cghxxCmkvMCAFu/4d1U20vdkpTlMkSP2B3oMgbWJaGi7XaeTi6ihjUy6/0gyLpHryQyT7hA+qIw7RBmSWGEJIF0kuAIW3OJKrNiiZPKD6zeSNR9MYz0kvF0EkvMt3AxhA5PFimcXE+nEBditb9vClUDELOMGtPgYS5CQ5hTBCCt9XS9jFsjAOzG9U+CO6inNCGKD5iX9++s8JGV8SlwRDJnOlir+Lg+mcAtQjHPL69Vg9HcdXagYCy3RZBE3Lu8n7GcjSjPMvZbk8v9MJkcTdygC+RKfCIrWqGrsO+5byn1nmius2F24AT1LDzLPxHRrTRkn4EDb9dvg9M+Y9r7WB/uKw/py8RV9AHz67KKYOWV6FiUg0wn3JMpyZlkprXYEvTlQWVAYg8u2ncBemOrAxr53pRGwLO89QtmBmqQPslOVZyQkwhM99s0BGQ029Cj3QYgC+r8TkxqQDstPMcIa4wlCPyvWojzOyeQ6fNF1jkZXxkV6GVSUQPR1tNzjKe65vshK2a7Q1yRzfaG/egfZGunzICAD2wmnaJK+08cwMN/KFrvO2EB16U4IhOgXgNae2mn22ad7sEYSEjbUVHvrOomiJAcakwdWJAYm8bCOGYDRM8cU6EbQ7y74EHRKz5ga//UosUc4Udzd9NRmYyHt+bEVZnbsjOl3TTEq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(66556008)(66476007)(66946007)(316002)(110136005)(966005)(6486002)(8936002)(36756003)(31696002)(8676002)(2906002)(6506007)(41300700001)(38100700002)(6666004)(6512007)(45080400002)(7416002)(5660300002)(83380400001)(26005)(53546011)(2616005)(86362001)(31686004)(921008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck5PMEhBWDBmUm9yNVVIaXAxOGFGazJQcGJmR1BydVBpaGtGYVRYZE85Vlk0?=
 =?utf-8?B?N2JsNEJkK3U1L2I4SElNaTdZRDFaVW9DcnpCVEhjY2lQSTdLbjJXT3JZRStT?=
 =?utf-8?B?Rm5QdndhRUo0NkQ5Q2k2dndzZllzR3lsbGJOcFhhQ21QTlgyMUNqa1pudUNv?=
 =?utf-8?B?Si9pcnRqT1lZN2cycUNraW9Wa2JZaFpQcWZMZkpqZ0ZTdXA0K1NFZzUwejhB?=
 =?utf-8?B?QUVMd2t4L2ROYk5ZdTdyWFczeFJneEdmVWdFQVBodXIzT1RhTTExZ0pXU1A3?=
 =?utf-8?B?alBYTDBuemd4NElhK3NmMVBjbjM4Y0FJN0h6cDNqdkFZOU1idlY0Uk4rNFpO?=
 =?utf-8?B?eTl5VGtmSzljY25JZ2EyQWUyMEhHZjM3NWdmOVk5TEJORWVsTXUzNzFSbWVR?=
 =?utf-8?B?Q2VkN0xUYW1lTDA0S2dSV2tweTQ4U2praWx5ZjIwb25VWW5hc2JPcGZEZ0ds?=
 =?utf-8?B?ODVKZWF3V0tKT3RxdTY0MlF6R2lRR1pwT0krSXVPaGFrTmhBLy90WS9YTTVz?=
 =?utf-8?B?K1Q1VWdETFpYWDZDdXBObFdncVJtd0JJTjlraWtXOEI0WVFwdzZZeUFDT1pl?=
 =?utf-8?B?WHlsVTJWK1ovUGlJQitOQ21PQkFYUFZJVGliWVg1YjNneExzb0x3Zi84OGYz?=
 =?utf-8?B?Q3lpYTVpV2xpcFlaR0trSHFNajl0M2hKWi9oM0c1UmE5QzUyZHgzaUdxV1Rx?=
 =?utf-8?B?ay9RNGh6YmMxS3NBYjBEc0JkQS92aUx5dDUzM2ZPMkhxVCs5UHIrR2Ira1V0?=
 =?utf-8?B?RlNZRTdha3Z6RUdTRVlFcllXZTlzM2txTkJicXpYR1Z3UXB1RzVrekJDdnFo?=
 =?utf-8?B?Q0t4SW1kK3JMUzlmQ2MwNXVJV3pXYmcwS2g0ZVQraXNhTHZwbWFrbnJkZURQ?=
 =?utf-8?B?Q3p5RjBTYS9iZm9jS2NWekg1RWpXbG05MmtkK2pNK2huWkMrbVBkMk1WMmE0?=
 =?utf-8?B?MUUxZ3F4bVFGWnlSUExUaXNPR2NPT3pVUW1Ec25mYmNXN3g5bE9HS0psdktm?=
 =?utf-8?B?VzN5c0ZvNlF6R3pVeU9vNW1pcVRpVVcrVjRnQ1d1OGhkMS9aNWdFU0VnMExz?=
 =?utf-8?B?M2NKeEJQak9QVnpjd0MvOWFNUzUyOWRkZ04rOGFwV3lBTzg0SXlqWG50d0g1?=
 =?utf-8?B?SFZlU3h2SGhIZ0U2Uno2TzUyZlZvRFZGci9xSmh1RTlGOW5JTDY4THFEUWho?=
 =?utf-8?B?NFdodW1vZlFRMGh6d1l5Zm1ydEl1NklLK2FKV0d4Vzc2bWF3QW1IZndBbThC?=
 =?utf-8?B?a2QrWFc1RmVsSkVqNDF6dkxBaWtvOHhuemczNWRzS0hKV0JiYlR1Qk1TOHRz?=
 =?utf-8?B?R1BzeXljdEVhVnp0QTJSODBWYzNMYlZVZkkvZGh6YUxUdnNOdFIzVVJpY1Jp?=
 =?utf-8?B?TmtsamsvRVB2WFVTMVFYTDhRVHNUbHhTK1BUSDhCTW03eTRZdTFOcHBQbmlx?=
 =?utf-8?B?KzdSRjk3UkdPeGVQaVFPRG01OVVFSitacXlXcHdrMGY1NE5pVktnY2tLT3NJ?=
 =?utf-8?B?WkNPaEJZY3JSbkVGdlFkQk1KdGFqV3grb3h2MkczbHJaVGZBSEYrVlZ6L280?=
 =?utf-8?B?UThSVnVrV0VaV0JhL1ZYUDFMWHowdVJ6b3hMMlRLYmwvMjdGelFuMnpVVXVP?=
 =?utf-8?B?U3RyK3VBUHovSmlDcDFIOUx5ODdXRGlaLzNBWnMyS3NhTVVHVXc1T3dQYjla?=
 =?utf-8?B?dEtWOGFiMkhIYTJFRjcwb3R5bEJpNXlCL0t2TW02emNOcU1Kblk5cHJtMUM3?=
 =?utf-8?B?d0hQckZDWU5WdHk3WXR6N21LY01WelFUSDFJZlpudUwzN05PS3FycXpEWnhG?=
 =?utf-8?B?dCt3cFFWUWswQWx3WDhZRStUd0hGMDRQT0YzNlRMcGVXUDIvTTZQeEc2bTMz?=
 =?utf-8?B?LzJya1ZheXJiYmNjbjV3U0t2ZzQwSHRyaExvKzdoZFdlMExsNldpZmU5VUZQ?=
 =?utf-8?B?NXRqeTdIZFpFbDBmaWNIbHNFWHVJNGVnNytXZzFLV0JpTVA4eVFNa0s1Mm5p?=
 =?utf-8?B?cmJocERZazJHNG1Ka3pMSVYzbUxSSkxLSmkrbWNvL3pjbTA1Z2dhdk9xVHB1?=
 =?utf-8?B?cTlQSitwQUNYMFJKSEYyYUxKajZEck9GbjRsQkpUNHg5VGdZYWNzMDdYQ3V1?=
 =?utf-8?Q?RmOyWcN8yjGjALsTZ3+iXwtdW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3888550b-66e0-4471-64c5-08dbd584be5a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 18:03:51.0883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nr+SX9OlUyrOfnPIW4bEXGPThrgVpMo0YV+Ydn6oifBitGfkiCUKUILGYDN6fBaERhJcgRNZsj79wzzg5bvX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9390
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 18:48, Rick Edgecombe wrote:
> On TDX it is possible for the untrusted host to cause
> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to take
> care to handle these errors to avoid returning decrypted (shared) memory to
> the page allocator, which could lead to functional or security issues.
> 
> Such errors may herald future system instability, but are temporarily
> survivable with proper handling in the caller. The kernel traditionally
> makes every effort to keep running, but it is expected that some coco
> guests may prefer to play it safe security-wise, and panic in this case.
> To accommodate both cases, warn when the arch breakouts for converting
> memory at the VMM layer return an error to CPA. Security focused users
> can rely on panic_on_warn to defend against bugs in the callers.
> 
> Since the arch breakouts host the logic for handling coco implementation
> specific errors, an error returned from them means that the set_memory()
> call is out of options for handling the error internally. Make this the
> condition to warn about.
> 
> It is possible that very rarely these functions could fail due to guest
> memory pressure (in the case of failing to allocate a huge page when
> splitting a page table). Don't warn in this case because it is a lot less
> likely to indicate an attack by the host and it is not clear which
> set_memory() calls should get the same treatment. That corner should be
> addressed by future work that considers the more general problem and not
> just papers over a single set_memory() variant.
> 
> Suggested-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> This is a followup to the "Handle set_memory_XXcrypted() errors"
> series[0].
> 
> Previously[1] I attempted to create a useful helper to both simplify the
> callers and provide an official example of how to handle conversion
> errors. Dave pointed out that there wasn't actually any code savings in
> the callers using it. It also required a whole additional patch to make
> set_memory_XXcrypted() more robust.
> 
> I tried to create some more sensible helper, but in the end gave up. My
> current plan is to just add a warning for VMM failures around this. And
> then shortly after, pursue open coded fixes for the callers that are
> problems for TDX. There are some SEV and SME specifics callers, that I am
> not sure on. But I'm under the impression that as long as that side
> terminates the guest on error, they should be harmless.

Under SEV, when making a page private/encrypted and the hypervisor does 
not assign the page to the guest (encrypted), but says it did, then when 
SEV tries to perform the PVALIDATE in the enc_status_change_finish() call, 
a nested page fault (#NPF) will be generated and exit to the hypervisor. 
Until the hypervisor assigns the page to the guest, the guest will not be 
able to make forward progress in regards to updating or using that page.

And if the hypervisor returns an error when changing the page state, then, 
yes, the guest will terminate.

Thanks,
Tom

> 
> [0] https://lore.kernel.org/lkml/20231017202505.340906-1-rick.p.edgecombe@intel.com/
> [1] https://lore.kernel.org/lkml/20231017202505.340906-2-rick.p.edgecombe@intel.com/
> ---
>   arch/x86/mm/pat/set_memory.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index bda9f129835e..dade281f449b 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2153,7 +2153,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>   
>   	/* Notify hypervisor that we are about to set/clr encryption attribute. */
>   	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
> -		return -EIO;
> +		goto vmm_fail;
>   
>   	ret = __change_page_attr_set_clr(&cpa, 1);
>   
> @@ -2167,12 +2167,20 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>   	cpa_flush(&cpa, 0);
>   
>   	/* Notify hypervisor that we have successfully set/clr encryption attribute. */
> -	if (!ret) {
> -		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
> -			ret = -EIO;
> -	}
> +	if (ret)
> +		goto out;
>   
> +	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
> +		goto vmm_fail;
> +
> +out:
>   	return ret;
> +
> +vmm_fail:
> +	WARN_ONCE(1, "CPA VMM failure to convert memory (addr=%p, numpages=%d) to %s.\n",
> +		  (void *)addr, numpages, enc ? "private" : "shared");
> +
> +	return -EIO;
>   }
>   
>   static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
