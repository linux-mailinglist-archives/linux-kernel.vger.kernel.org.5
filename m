Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1607BAE8B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjJEWBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJEWB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:01:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4951F95
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILlZvg/Ez4MH9Q3v5dbh80HANBMBgNiyhieUzFU48eaoCyQYYmX9q0BFkILUXkKfGk2FhegW8UMDaaKuGlmfltlOVeeuGKPl4yg68aFjgC7XsycZW+kDmwPhULpFgmtXqYs7KEEFOJ7hE5ZfV8wcEgoVH79Z7vtEnTtxrfLAjG/wbuxaJCAoON33eGCRUsM+S7/oR7LauCUjQnnTFStJPOS6NV60OnuyoCtBJJvP0Y6wF78t/vMYTHys3qcEhG0cVc0fpR700PmtyUnjyCJfxZ8nVnlNH5AuOAPE1FjEKS2EMWMpqA1tmD5s7cboU0VYENSNML9wv9z46or4ZpzZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YOUjXjhgnt3AKsdzIZrNF42fieVxjJsDSM68u1QEbU=;
 b=XDVOhcUnpEc7EaA30TJg1m0/Wij7La4EscgODkV/lp3GSU7FS8NpKzIyFu9tuDGhkWglJXkYuJHE4cBxljllW1bWqDDnnzVe0UP1EWi9nnSN9+wAavwZ1sIr7uQSHxoyqUk1fX3jmsa4jTmzCzzvLqHVytZHWHuBi4kL8cNYhD+83z2UBl193G/pn4ryIxgmxkfkijZ84aCZHiHq5e5YR5N04pygueL4l1QvKhL0O8z8Y2GIinGGOJO17kcNbAlmUj/p0zJskNxoRmcod+W7G+XONKshHix8dlGiP1mqhA8Rxw9/oIATbdVe1dQMlJm8kHE+j/9Kqipn0B6Dz44YTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YOUjXjhgnt3AKsdzIZrNF42fieVxjJsDSM68u1QEbU=;
 b=vs1ueKbHnZ56I46+WefqLm5AbZDIKB+TFkqWSTu2qASewlaECi/aglNXfE/XSSYNafK32mHaGb1uRtIVrh8SrFONXn3bQz9SOS0Lz6y3wWpxiTzl4bp13DEfO4lq46EYRwc6Q6LBGaASNa0GvpRkaDTM2eEemQG3gmc8Kzyy7V0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 22:01:25 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::6ac8:eb30:6faf:32b2]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::6ac8:eb30:6faf:32b2%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 22:01:25 +0000
Message-ID: <e0459b50-7e21-7548-8151-9010ee88b0a6@amd.com>
Date:   Thu, 5 Oct 2023 17:01:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 10/13] x86/tdx: Convert shared memory back to private on
 kexec
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
 <8d0e4e71-0614-618a-0f84-55eeb6d27a6d@amd.com>
 <20231005212828.veeekxqc7rwvrbig@box>
From:   "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20231005212828.veeekxqc7rwvrbig@box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:806:21::18) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 92821f89-4c19-40ce-bb58-08dbc5ee9e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +A2y9vwl9TJ4qegqaWrbd+TzFAvigoh5M7Y8coL2tKBlXM0FVBnbSMxMHrolnjyVGpAkWOcObDP3FWCDbe0wvPFQLHAPXJ8QsnQCKUJfZYq9xYwBHLd0dOpqQZlHdZYUt/yERBAHb05mXx3BMQMkeVdINog0NSp2IDMOm2WxUYJVU2AXY+sVO2f0K5ID7qbAoZzc65vJ9058ITP/ZrUNcIuHigrf/isAQ7HfctHKUFXhQPUR56Qc/ab6BN2aNl66Bl9shJ9PFi5DcHvPgyagDc/1WAWAaF3AvHE6i2An3AsSHoFrMgnDIXMchDFthnCaN9cHYQsAeiSZvItbzZNwK6O/KX4l56RtaqrljYCpk4JtStXAVB+cAzX1poowN5x+DYNNNTMv9v91h5Fh39o/ALZmbxfIqySO0lCO7Y8KMQntAi4hSKo4NaV2auQMZzKpkjSC/CrkLSfuq3ugkQhpmiOhh9jYJ+gnUPWgdPH06GtW6sbZ+PGW+Ji5rKrjW2VIMhS1Toh2mc+ShJcuZ+IqrXiIBRvoAqfbR4ANw1wxqQ0h1LEScssBo8D7Qs8P2B3IWqFXg+GEOFevMkTl76DgdaPqnvidoWar6HOrxVhvGmbNxvWfov/LYQpF3ZACGHnDPJiwr/Ubu4u58fqo9J7IAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(6506007)(6486002)(53546011)(478600001)(2616005)(86362001)(38100700002)(36756003)(31696002)(7416002)(41300700001)(2906002)(83380400001)(6512007)(26005)(54906003)(8936002)(66556008)(66476007)(316002)(66946007)(6916009)(5660300002)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlFNRGNjUHlxM1NNT1Q5bTcrQkR6a0FrczZxTm81d1NUUXhTV1lSSE55a3NP?=
 =?utf-8?B?bWNsSHF3bjdZSUJzU3JRR0RkcWt4VUJPVVEzejJLSGZFREw1c1hzZXJ1OGRO?=
 =?utf-8?B?NWpXZmhyVGlmdWw1Q2d5T3NHd1dBMkQ4aVBHVEpUNDZzd0J6UlNhSld2Nnkw?=
 =?utf-8?B?T2YrQTc0NDBUM1ZaWTlYWURTSGw3MzRFaHJyZkpYYkdzclcwa29BRGRIaHU2?=
 =?utf-8?B?MnExZ1YzRDhHTks0cTIzTGs4QXJ6b2xuRmdPSFE4WGlZZHR1R29uNzY2UEQr?=
 =?utf-8?B?UGhvV29oZmhUUStHOXJMeHJXa1RkRDBRQVo0OXpDK0NYYWVQSFZmeVlBNlpX?=
 =?utf-8?B?dXljRW95aURlOXNjdUlLWnFrNnk0THZ2Vm9MR0pnZnFiNHlET0FaRm4ycVBr?=
 =?utf-8?B?OEpTWHdLeTBwalRabkx6SFFZSy9aV0U0ZC9iVURVdFhPdWNod2o4N2NkVGl2?=
 =?utf-8?B?QXlCdXpRMDF1VUVMZ1prZ3F6RldlSzNQTDVrR1ZzUThDcE9veGtDZGZYVyt5?=
 =?utf-8?B?ZlQ3YUhYVW9RMkhmL3dSMFZwN3k3YWNNdlRKUlVGcW8xa0l5b2VrZHBpQUxm?=
 =?utf-8?B?UUNMcmhxd0pKSlJCMElvTEFXRCtTUklRaDVCMTBjcXhQSXNYc0ZXSUVpYmtI?=
 =?utf-8?B?SjRWbGVSMlRiODU3cFlrYjAzUVF1SGJUOTUvdjF3eUt5akNvUkFHc3JMeSto?=
 =?utf-8?B?bU1JNVlGUkhVSkkyUzRqRCsreEltMU5uMlBwQW9HR3hwVkx0ZTFpR2cvNDRp?=
 =?utf-8?B?ejNGd3pPbFNxZVVLVWc0TmZzRzZac3BZRkNUZ0lqNzdnL2xXaE90SStaQTJI?=
 =?utf-8?B?blJjREtrYzBhV0tUQW8rT3k5eDR5Yy9EaEROd0R4dE43Si9ralFlYVZXZzVM?=
 =?utf-8?B?MWQ5R2paZmN6OE8wL1p4dXpWeDZxUFd3WWlNalNxSUFtSGJ0Z2hiMmc1WmRE?=
 =?utf-8?B?RGhISnhPY0JtV2pCL0pnc1YrcmExSFVuTWp2OVkybGV3UWQ3a2htb1NJZlND?=
 =?utf-8?B?czY2eUxJMXdSZWhQY05qT3g5R2lNYkk1ZmY5clRzcmJ2SjUrZ2RCUERFYnBT?=
 =?utf-8?B?MGwwc0tFUEMxVXZweE5tVVBPeDFhQ3N2OFkwYmVDWlptNGcxMndsdDZWQU5o?=
 =?utf-8?B?WXVidytaaG1zWktNK0s4eFpsMzFCNHF2NHB2MFBBNGY3MWxyTnFBYVJJaVlN?=
 =?utf-8?B?YWVjQkFub3pCYkJZalZZT1BnTUhTM3YrVW9GVlU5NDJKNnMyckxmcFhqeVNJ?=
 =?utf-8?B?R1JaamlvVXBLcVRiQXVsekszVnc5eGhSYjlKSDhDbks5WHdvNlREc1ZQYzk5?=
 =?utf-8?B?V3VLWThSZjNrRjdXVHVlaUlLVjNKTVhIWmVXMHAycXBmQjR1NklDdGFuaEpF?=
 =?utf-8?B?VmwyRVU2OEJIb1RxVStYRExTQVdVR2hUUlg0WTJKc2NTSU12OTFkMUFFU0Ez?=
 =?utf-8?B?MjhIU0tRQ09EOTdTa29JUWROeWp0ZWVIL2NTZzNUYWpHNVg2eXEzTHJDbDdF?=
 =?utf-8?B?b0RxSzZuYVhRSG0zcE9OOHhneUlIbmwzK2g2bTVEM0g4c2krdjhheWlTNWwx?=
 =?utf-8?B?YS9yVTRxcmpXTEw2MHdXR1VuQmVJdnhHUlZ1SDlWYzNRNGowQndLOSsxeTMy?=
 =?utf-8?B?VnlzNEIvZElGK3NaSitTWjU2Y3ZkdGgrUjhVb1lzUEdmU1lYWjFiajFlRktm?=
 =?utf-8?B?K3E5MnhzQnpndFZGeHRkQ09NU25TTVREMjdIS3pMNkdJK1owd0E5L21tN3Yv?=
 =?utf-8?B?cHMxd1cxTnI1NWlKLy92TUhUL2RaZU5MTWhpYVZ0ZUFBWmc2TFUydXVIYmF5?=
 =?utf-8?B?Qnc3ZTJBdFJ2UHYvemYvdXM0d1FBVE1KS01STlk3MjlUNWVVWWsvZllpcEkr?=
 =?utf-8?B?Nzc1bElRdjg3R216WFlIcDc0U3AzRTZRRDBDWkdVd1lzU1BHcHVNcHFDTVE3?=
 =?utf-8?B?ckI4eEt1T0wrN0p1eHJIUEl3Zy8zelJhQmpOUndpZHVEcHdzNWRUNkVwWHdn?=
 =?utf-8?B?cnpuRVM1TWlHa3RRUm0rMUZ0OFptdVFwTDJMeVI0SnE5Q1o2RG9CQUNvalJv?=
 =?utf-8?B?OXV5QXRkaUdBZ2lyZFZVV0ZVQW5lRVBqQUhVYjhYZ0RPQkJVdjhCQnhEWU5O?=
 =?utf-8?Q?H9fw1HoyJskideTrgWHMDCCqj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92821f89-4c19-40ce-bb58-08dbc5ee9e80
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 22:01:25.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ckdn0OHKCqi/zj9bMypgw751F0jmNae2I5KsYqgclC0oxL0k3YdWyq/Uv+AgUky+YfZWzjBZhzz/CXd0/Pdnew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/2023 4:28 PM, Kirill A. Shutemov wrote:
> On Thu, Oct 05, 2023 at 01:41:38PM -0500, Kalra, Ashish wrote:
>>> +static void unshare_all_memory(bool unmap)
>>> +{
>>> +	unsigned long addr, end;
>>> +	long found = 0, shared;
>>> +
>>> +	/*
>>> +	 * Walk direct mapping and convert all shared memory back to private,
>>> +	 */
>>> +
>>> +	addr = PAGE_OFFSET;
>>> +	end  = PAGE_OFFSET + get_max_mapped();
>>> +
>>> +	while (addr < end) {
>>> +		unsigned long size;
>>> +		unsigned int level;
>>> +		pte_t *pte;
>>> +
>>> +		pte = lookup_address(addr, &level);
>>
>> IIRC, you were earlier walking the direct mapping using
>> walk_page_range_novma(), any particular reason to use lookup_address()
>> instead ?
> 
> walk_page_range_novma() wants mmap lock to be taken, but it is tricky as
> we run here from atomic context in case of crash.
> 
> I considered using trylock to bypass the limitation, but it is a hack.
> 
>>
>>> +		size = page_level_size(level);
>>> +
>>> +		if (pte && pte_decrypted(*pte)) {
>>
>> Additionally need to add check for pte_none() here to handle physical memory
>> holes in direct mapping.
> 
> lookup_address() returns NULL for none entries.
>

Looking at lookup_address_in_pgd(), at pte level it is simply returning
pte_offset_kernel() and there does not seem to be a check for returning 
NULL if pte_none() ?

>>> +			int pages = size / PAGE_SIZE;
>>> +
>>> +			/*
>>> +			 * Touching memory with shared bit set triggers implicit
>>> +			 * conversion to shared.
>>> +			 *
>>> +			 * Make sure nobody touches the shared range from
>>> +			 * now on.
>>> +			 *
>>> +			 * Bypass unmapping for crash scenario. Unmapping
>>> +			 * requires sleepable context, but in crash case kernel
>>> +			 * hits the code path with interrupts disabled.
>>
>> In case of SNP we will need to temporarily enable interrupts during this
>> unsharing as we invoke set_memory_encrypted() which then hits a BUG_ON() in
>> cpa_flush() if interrupts are disabled.
> 
> Do you really need full set_memory_encrypted()? Can't you do something
> ligher?
> 
We need to modify the PTE for setting c-bit to 1 so that will require 
cpa_flush(), though probably can add something lighter to do
clflush_cache_range() directly ?

Thanks,
Ashish

