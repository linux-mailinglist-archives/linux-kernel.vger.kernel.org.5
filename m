Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4120A76B8A5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjHAPci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjHAPcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:32:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7D5212A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXQYj3L3owSAfitx5txZJSBmjRkC3JcAuQ7GO0ytG4BHFr/Jidi4JXOhz9xnrfRZtcjMuvx3aPwGhoG4/yYtuuylHQ0bv8nbmHv6pcTiBB7LLyZwk6skej7UpgWeWpiCO+OJFFgTU79ezzNFScngDZ15Iw8LUg08OAkMd/e7RHnlDI7dvZX42CwW7vByvEaHGnmDRlnTi64+XcThKnRln9AlgoACV45p3ALBubAUtCWaWyuSVkmEu48e9RX1N170EKiKqChTYpWNZgSsAjnHBiiFg6UNxdx53lPx/Skn25sj0DQfpMACmzUX7MpOvzBB2+r+2iYOf80XSTP3wasECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRAUcAoe4zS0WAsCYE/cT5dtUrZ1zMAE51I7prn2smI=;
 b=aibijHpnftk7NgN+TVPoJCN/DbWx+Ig0Qk6zBQrAkRSdFYoqQ5zQmjWl0QUyQLFJrUkYvRwsTC84T8PP3DwnaIU2t5foEQ6uSmQk45hEa/JUaD+MalE38RCsV92VK4rbvc4Iv1lPyi3p43YE2EjRwvXnEjOsqEFaFmQyhtV7jlZsaZMhFK2+WPkbAa033KBPO1rVUDipT81IHrsGoKPacq0aK7pmw/mX4bIas6EV2U5N6q4Ia7YEBlcXTN5u8QKRsNRmOQlH6YfWKpPl9A+tPBqbK9aHMDAl1UUZVybVoVvZsPdXSk/28AXlN45ljeGWVAG6sBWX3IwtZDMkIO9/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRAUcAoe4zS0WAsCYE/cT5dtUrZ1zMAE51I7prn2smI=;
 b=sbJHeEQF0sTRyQibdv/QFz16NpR3ichQEm7WXZLMbhFgQ68dXIqtL4w7kt/EsB9UyHheDmDMAmN4plMBeIX0aj9yvF4p9dr5Cwj+0EeWBS/fASeccptwfC5+upbmd4bWy1QZXkbdAX/Cl7SB/4V+5WBQPoXiPa26WNn8Rtn/zIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 15:32:30 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 15:32:30 +0000
Message-ID: <a056ff8f-1dab-72b4-133f-a6578c7216ad@amd.com>
Date:   Tue, 1 Aug 2023 10:32:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 01/14] virt: sev-guest: Use AES GCM crypto library
Content-Language: en-US
To:     Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com
References: <20230722111909.15166-1-nikunj@amd.com>
 <20230722111909.15166-2-nikunj@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230722111909.15166-2-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0113.namprd11.prod.outlook.com
 (2603:10b6:806:d1::28) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e4c028-1965-41cc-5ab7-08db92a484e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85Y1GLWbLtNChMn6eTGuSamsKNSgHtmTuyif6LKkapDH4P/azjEWwbqci/YzNA9ueXilDbK0eOga+wytx8fY0sPDEC3Y674Rpf2mG9WdyeCQATE87dVx2g1liAUKQULGWXIWy9YtEEJ//3sayZFKf5Q6fTYcywPrNbGq4KKuVPbr9OEAMKh9FodVIi0f5rrPGwwOuJAGb4cKoMTr0bU1ibB80YQzaMzgTnoCk3Uw8Lk/300mArEfpWihCwhvJE7FqkDWyu1yskmKFQHiT6DzrjP3CVU4qEM0ahzuc4tN8uURBSUQSo3Xr55LrPMAGS6yUA0fqxOTuCCpA14oOuXDF/e28qhtaO58Bo+5lqaIEMGqnGH+OsOiKFBXlnq9I4DpVP6WzxM4oZnbMMG1xj3R7ZVNF+e1o9MOanqi2zbWc2v5soY5eOaV9JL1MPzIvuR0gaEQHyd7tA1QgneRY1fO7l+xAypkwcsLLqdN5wr2RZ6rWod3YBTQQQh5/qcIODim38+DQItqFDHuBFLBINz4w2bs8ktckmegYP77fqCzbsS0UwpWXH4uxty7L42ybWwSPofmD1izWWnGYGll8zN80xBz/SjGDsmVZoADPjqIKfiM0lMaKqa4olzXT9N5iiO8Mu3TDEWppVdInRFgyfEGWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(4326008)(41300700001)(5660300002)(8676002)(66946007)(8936002)(31686004)(478600001)(316002)(2906002)(66476007)(66556008)(6486002)(6512007)(966005)(38100700002)(53546011)(6506007)(186003)(26005)(36756003)(83380400001)(2616005)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFFKQ0ZNdjlrZmV4bkl1d2dDQm1wc3pGVXpTazVROWVCVkdVSXA1Tk1QRmdx?=
 =?utf-8?B?RU1wVitsYzFqTVVXa1BTZnN2TVczeVFrZEgwelVlUTJUU25nOFdPbW5sRklK?=
 =?utf-8?B?YzhsbldSdHRJaWhudnJFbWdaditiMmFsSVFmOFNPeG5JOTN6WmZoYW9xdHov?=
 =?utf-8?B?OG9wUXdBSFBFTjk2S0FDMzlSVU1pNjhVSXRDcGtMY1hEdjZ1bnoyV3NpVW9Z?=
 =?utf-8?B?K25SZFVLeFNMTDRZMHRTb002SkxHbFA2UTBCa05FQnMvVzJxak1uQVFiM011?=
 =?utf-8?B?VmlKd2MwMXF1dE1JSUMrdUQydnRtU0FkMW9KSUhTVjVBUEFDbU1Zc25GNnRZ?=
 =?utf-8?B?RER1QVZTU3cyNDJtaVNzMm9rc3RqdmJtYllDb01VbEFhUDZEQ01zbjlOWU1N?=
 =?utf-8?B?M3lSZlRySFNBcDRNQWd0Q1VwNy9xMTJBVGx3WG1zVndVelVCakR4OWMrSEZt?=
 =?utf-8?B?SlVhVjNPL1FUNUJTNnBTTEF1TDVwUnJGM1g3eVdWbU1WUk9RTGN5T1VuWUtD?=
 =?utf-8?B?bHZLQmpZeDVPMnlZcFN4U0VRelNNYWU3ZSs1UmEwcjNjUUc2YzBYSjFrOGJM?=
 =?utf-8?B?ckNxYXRQaDR3OEMrRkplNVh4aXdkSVR1aElHcFpISEpIdE41d2I0UmNDVnN2?=
 =?utf-8?B?VGRLWjdTYlBLR0RoVGticnI1Q0h4MUpncEhYZUY2cUtlNXIzWEluYVVKa1Bk?=
 =?utf-8?B?bzNtS2NnY1lQQkkrU2xMcFpsN1F3WkNOS1VtazNjcXFQQmdRczVtQWN3OTcz?=
 =?utf-8?B?ZlRDNnc5WW1WSC94N05oNk1lMHNjN3Uxdnppd3NYazQ0Z2YrNGZ0R0V6UWdN?=
 =?utf-8?B?N1psL3NVd2hCZTJETHRuOFVIM1RLWS90UFFjQlVpemVaN28wQzNxSW1iV010?=
 =?utf-8?B?ZHNBTDIrR1NLY0kzV0EzYVRKQWM0R04wV3NCS21PZWdtMlBXdmlubmo3U3hE?=
 =?utf-8?B?S244bnRjZGlzTnV2WFJEeW82NHNLTVFOTXhQOEJhT2lKRGNBUlZpVDZPWC9T?=
 =?utf-8?B?V2RSTDdEQ3k0aTFscGtFc0RaM2JOQTNjcVJLakJDZWpKNkFiWkZtaHZLbGQz?=
 =?utf-8?B?bk9KZzRwN3hIeVF3SFJoYzVGZHNEME5VQldXaStkQlFRdzlDeEsyTDJoTzg2?=
 =?utf-8?B?d211b1o1K2FhajV3U2RZTGs5SjJpV1J4SXdxVUNGbElrWHczbE9wR1VwY2FT?=
 =?utf-8?B?cXgwWnErR3BPdXYybHI0bG1YdXZrMjUvd1NzWmNhWmZybGljM1AzUXFwMGVi?=
 =?utf-8?B?dlVTOE1FaE40ZzRYbUlLcUFGS1pjeGhKdVBuQVV0bzYydUdvSWsvUUgrbmh4?=
 =?utf-8?B?dDlKZEFCQkk1Y2pLZHpIUzhoYWVhcFYwWVcrUVpXaHhNN2RKZkdINEFqeXBU?=
 =?utf-8?B?eW1VdTNEajdhSkdKQUdTZXN1QmRSWkZpQXJodi9NNFQ2VlYxUysyeUFvQVox?=
 =?utf-8?B?MHRuSWpEM3UyZm4wNHlXRElpdGgrbmFkaGphb0RxWUtMb0U1N0VnUXg5UEhQ?=
 =?utf-8?B?emZNRGc0SDhhNEk2eWRaNlpXWVdaeDBWM1RvR3RDendweGRZaS8xZjQxRUdl?=
 =?utf-8?B?WnNqclVTMkRxZTBhaWtBWWczajI3QVJDaWhZZ3J2QlRBS2dGeXdicHFBendt?=
 =?utf-8?B?L2ZOTGZkTndaem1HMGtBbzJ6NDhIdVhqTk44NG1raDg1azlIK2ZWTG9TR3Uy?=
 =?utf-8?B?NndUbG1jTEhXVUZTR3diY29oaTExNnBxcCtGUVVQMXJqOXFkRVRjblRUeGJi?=
 =?utf-8?B?bkhvWXFwSUVPd1BEYnpKTFI2TUhDUGlWQUJEQlltSnY1WUpzT0NjeFdlazBM?=
 =?utf-8?B?MFFsQXQ1bzdnSE5LQkxYMXpkOGFHQlJtV0ZvZHE4YkVWWXJkbkN5MDRkcjNC?=
 =?utf-8?B?cnZ3NEF0ZDRIYXl2OVcyUDFPYzIrRDB3OUVoY1A4bCtEMElZZEZBOVFtSmtt?=
 =?utf-8?B?U3hBZXhGTjdBUkdBRS8wM09CRDhvWXZTbkx6UG0wQ1NRQXNORkxNaEl3MFVp?=
 =?utf-8?B?d0MxRUtMRU1VSCtvRk9IcWx3ajdRMEJQY3o5a0Q2elVmczdvOTJsME9XZUZD?=
 =?utf-8?B?KzBjRjFaUnptSlU3cnBZbXVOTFdlSWg2RTZVRjB4V0NJaDkycDlOSW11Uk04?=
 =?utf-8?Q?mb8vxLboIK/H31OkQaZIKzixN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e4c028-1965-41cc-5ab7-08db92a484e4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 15:32:30.7284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gonAQJ3Z9yrJNvDhmQG5Q1bmw+iaPA1Smx3zrekUdm+GiZHoB5sCNbzkgG/lAPb/05lqhQGNCWx00NKpudcLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/23 06:18, Nikunj A Dadhania wrote:
> The sev-guest driver encryption code uses Crypto API for SNP guest
> messaging to interact with AMD Security processor. For enabling SecureTSC,
> SEV-SNP guests need to send a TSC_INFO request guest message before the
> smpboot phase starts. Details from the TSC_INFO response will be used to
> program the VMSA before the secondary CPUs are brought up. The Crypto API
> is not available this early in the boot phase.
> 
> In preparation of moving the encryption code out of sev-guest driver to
> support SecureTSC and make reviewing the diff easier, start using AES GCM
> library implementation instead of Crypto API.
> 
> Link: https://lore.kernel.org/all/20221103192259.2229-1-ardb@kernel.org
> CC: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/virt/coco/sev-guest/Kconfig     |   3 +-
>   drivers/virt/coco/sev-guest/sev-guest.c | 172 +++++++-----------------
>   drivers/virt/coco/sev-guest/sev-guest.h |   3 +
>   3 files changed, 53 insertions(+), 125 deletions(-)
> 
