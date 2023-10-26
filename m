Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2147D854D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345331AbjJZOyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345412AbjJZOyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:54:00 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6CF93;
        Thu, 26 Oct 2023 07:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SL4WWK4U2lnEBhzrTflOyaxamN3boePBjiQDne5kpMqR0nETe6n+u9W/4gpD2blo7Q6T9UrM9WAba36YKy3dJTlPL7mbjyTFSHyuEcAJFyKpSNZDq1GwqTgK1iA8aBS24yu0IGK/dsYThbC0P8SCxGczoxdG7Fk9dBIxKdJiF8MCLr1UrJJVgP0Mfc8lTU/dPJvJ4JgiriSV34jplE4xh3cRZYOXG91IGcOK6echgD82iO0rOAByktAwtBGPhRMwzbZ0GDk4CmHEab6HWjKD7gWplXvsofKS6aQ5rtm9eKuEk4QSHrToXWqjYx7h4yuCV+WSPKJITZiCVS3uKWwfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtoRE8mnH2S8d3GJEqxUEqK+UoeaGJh4O2e2N02O4OQ=;
 b=hF98OVoKmDrhYnVcAdKUe5xWsUM/B89ZncIr5G2vOu81W5sxzxFwbjJjNH/dCycKeV1+tVW7r7wBN3TdxtSDDiGRZNxPvWTRF7WZxnfWUG03rZrHK0V1T9A9CqXt3QTbguY2ej/N4p4yipKCIixN11C50y2FQQrxbEQypYMxBqYAqHqtLRd1TZk80FpV1Tf2xscvJ5k1SLWjaVZ5sit+koiREymGWMSLCFsyKADsK3yDq10+9SMeiiTRBhRJcs9jFxBaojJSQVB9wZaWos3h1RKOlZEDMeY3Pg+EzSLicbtCO1qzZspaNvWkROwamsDl4G1pan1CAo9awSIpsJzVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtoRE8mnH2S8d3GJEqxUEqK+UoeaGJh4O2e2N02O4OQ=;
 b=P8HNCLGi+pYYl+f83pKcZzsvxiYOPxsl8wBUidJqN+syayY3jBqL3yl90qbcCp/nOSFw2+qd1qTx6Ecfv1u9KOXwONXQwKoFr9r9ofTqK1sZuQ08zkK3E31u++2rjADTwmRWUhgZ1QsRqJmWf1aAeAQohNjDRr7j9Be/BH3gAvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 14:53:55 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::e16e:d7f1:94ad:3021]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::e16e:d7f1:94ad:3021%7]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 14:53:55 +0000
Message-ID: <b743d759-8f6b-b4f8-afc6-d8f11a5562ff@amd.com>
Date:   Thu, 26 Oct 2023 09:53:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/3] Introduce DMA APIs to allocate and free TEE shared
 memory
Content-Language: en-US
To:     "NK, JESHWANTHKUMAR" <jeshwanthkumar.nk@amd.com>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     john.allen@amd.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, jens.wiklander@linaro.org,
        jarkko.nikula@linux.intel.com, mario.limonciello@amd.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Mythri.Pandeshwarakrishna@amd.com, Devaraj.Rangasamy@amd.com,
        Rijo-john.Thomas@amd.com, nimesh.easow@amd.com
References: <20231025065700.1556152-1-JESHWANTHKUMAR.NK@amd.com>
 <CAFA6WYPKXFftMzqJ4GnXT-zqu21_Jzn8aKti_wU-pQ4KpEVNrA@mail.gmail.com>
 <4a261870-03e0-49f8-b968-4cbcf646d9eb@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <4a261870-03e0-49f8-b968-4cbcf646d9eb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::8) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a0056a-0921-475a-e915-08dbd6336067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vOqBcIRkiTKypFRq28Ri8+2IagldxwsIZVuGAkn2uEkjoNYAzt7DeoZp86vQkKxyWv2xHxp6VxH5bTjuLH/XdYO7tfiHB5COxeOmjAyXeSyJdTZwnR4yDxJOazCjqi+VROIz+5qhhh/p9IrWVkbfCdOGJ9K8LoNvZ781Zo0HycmW3mK8WwaqYbk8K27AEfP9/bKLur0k41FnsfMxjWsgxO42jINVmwS6Lvm6OzEsLf8b93y+WiyE9MVX0adeHHn61Ocy8g8/VbJNNau/HefcEAuKnfWmR6G7TzSHwrSS/2ERyleqciok/6fiOe5AN7BrsX0g1qxO6mFO4ATEwJnejgM6rCgBTlfbMx5FWCAXiVu5ZfyKPGIJR4xZNp2u0W0nkfmBrIGhXvJgQoDFfCcpE0MaQXsku/GVacHGgc+i4mL1z8ZflUpYOyrFKvCW64IzgMYXiA3yVWE5hmHHd/6+wdYCCodjvqL/i2JDOlXhjzFT1u+vrNtdQF6HuARa5yc8fc//gjUdigNes4mqTNoxhpLeY2z/FVh5TDz3LXDm4lnFLOm+Ybn7kerCkiSVi2+PUmWQtH1LD2nfkaz18RqUmDIh69SfWFRHNugo13N/5BoGJvcsv42iqElGe6dVriCJa0GT5jJRo5eK3EO2kOgBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31686004)(53546011)(6506007)(6666004)(6512007)(478600001)(6486002)(86362001)(31696002)(38100700002)(36756003)(2906002)(5660300002)(83380400001)(26005)(2616005)(66476007)(110136005)(8676002)(66946007)(66556008)(41300700001)(8936002)(316002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aERINXVmc2FEZnVtbEMwQy9qUkpPcGpSTi9jbFlCZnNTc0V6UllTMUdaMDVZ?=
 =?utf-8?B?UENUMjExSDJ0S2RLMWF0WXdkcmZ4UWlnaFhianZTdkVxQVpQM0FKeUdqSm1a?=
 =?utf-8?B?UmxUK1lrWFR3WUR5dEg5eHoycDFJWmFmcGlOeTc3SGpldys3OGtMWXA3MjJL?=
 =?utf-8?B?RDFkdVlMTUhEaXA0aFhwZnMzbVlwL0xOd1VSa245MXlEa2U5RVVwdjVYTFcx?=
 =?utf-8?B?UnFJVVBjM1EzNXk0aVhVS0c2dEJ0dU9Zci9EWmkrR3J6eFo0emFnQjVVUERo?=
 =?utf-8?B?WTdYVXZ1Vk5iNGw0dUE4TCtBVFJrSmtpVjk1NDFhcUY5VkQvckdDbTgwT1lJ?=
 =?utf-8?B?UGZITWxNVmYrU29YWGRLUjVNL2RjRDZNc08rak9YUlN6K0FvUEVXRjlTdmZK?=
 =?utf-8?B?L0hrbDVwSXdkaHNWVDgxYmN3c0w4NVhpZkx1Uk85WTdlbXpBSVpNSFhzbWhR?=
 =?utf-8?B?YTFjOWlSTDZOaGcvdkE2VEFvVEtwSS9NUm56b3NYdVJXSGU5V3V4Wm9CMVlW?=
 =?utf-8?B?dmcvSmpjV05uK21SOHB1bHllL3JQM1FmR243V0IyMmF6NjcvdlFwMTc1am84?=
 =?utf-8?B?VFdoMmZHT25RYkVrRU16dUo1empWUGM1cGQrUmk5WXl3YVRHTkc0R1hDRmVG?=
 =?utf-8?B?dWxSZ0hReEpaZ3pvWktuVVFadlFwclJOemtGQ25wcXdTdzVTendmc3pEcTk4?=
 =?utf-8?B?TG9JK2JBVzN1MkxpaWVPVFdkeGVrWWNra2JnTlhodXhCcVM5clhFbFY5K3pM?=
 =?utf-8?B?ZGlDTzhqQXArbWl2UEVtamJPaUlXK2FqRG5jZXNzTFBubkxHTHdaU1JId0xU?=
 =?utf-8?B?YmZ0d1NkbkN2Nkd6RU5KcE5uWHhSTDhGaHhTZUhNbUM5SXlVcFhFNlNud1Vv?=
 =?utf-8?B?dWp1R3BjWkk1dC8zTlhUVU53SWVRNk1oVDRCdFJSMFFRTlEwemhranFlVUs5?=
 =?utf-8?B?NGg5YVdEdzAwVkJWS0crSUR6NEh5WUMrdHRuMnNaNXUyNXZRTFNZZTJYOWls?=
 =?utf-8?B?Sm42eDFCcC9CMitIdjBZYVo4YlE3WDBoR2FiZ2Y2dTVwZTNpcU1KZUQrVXJX?=
 =?utf-8?B?bjVoNlozWnRYN0hZbk5MQ1o0bDNPSGhtNWI3cW80N0VEM2o3ZG1QM3JWTGg3?=
 =?utf-8?B?cEowS0lGUCt4dWxyWlFhMXlxSGxUS05SRHlzRGNYcFdQWXZvSzIvdm90cXZQ?=
 =?utf-8?B?WHhKVlRmY2NFNlRmTlkreXhzd3B6TUNySHNVOXdxZHR2ZU9zTEt4amd0WHRu?=
 =?utf-8?B?bG9MalBxSFVLdytwdGhERytFd3paZ2tCZUkyUnFzN2xIbGtsVzNLdkpCQ01D?=
 =?utf-8?B?WWUrNGtZY2xwdk1OQzB2OWw3akhITTBiNUV5RjlsVXRSdER2ZHNpYUNrR29r?=
 =?utf-8?B?d0FBa3Q4d05VM3FVNko4ckhsTG5ZTnpOWXpCNlM1OGFwLzlwWG8rajhabGVZ?=
 =?utf-8?B?UVUzRFRqM29CVkhNUU8vUk9kMzlLRjAzMTJxWG84VlczdU5TU0RWNWdqUlFP?=
 =?utf-8?B?QjdrRjEzYzFOTjcxSDV6V0Z6K1hsWVpxSFd0c1pqSUR0bUxBYzZkK2VnNlFL?=
 =?utf-8?B?K1o1bTlhd2NVaTh5WVI5bVIveGZ3d25BUWZwbEFBWWUzSkREYjRvVDB2ZTZn?=
 =?utf-8?B?RjdKaGkrVFdDb0RFcmRtS2UzR2JzZXhlMjNCYitja1ZXU05mQ3pBMzFDUU9C?=
 =?utf-8?B?T0oyQ1R3NUUycE5mS0Rna2NDM2ZVRnhQU0V1dE1LcFBBVUF1eUR4RFNUbGpS?=
 =?utf-8?B?NXphRytVbFAySkExcGJEOUQ5ZGhvR3VvWFd4cVNPTnFvN21yM2VjUjNoR25h?=
 =?utf-8?B?dDc2SnJiM3ZLQWVyTUJGNStENGFnSWxVaVpLNldtQVd6cnlLWTVrbXVTOTlV?=
 =?utf-8?B?OXdjMUEwYlZocktZRTNISEEyTFkrRWNnWGV2V0JPdHNHOVFMazUrb1FBazYy?=
 =?utf-8?B?eWlDMGRXMUlnYkZ3MnRCTHVhNmdkam42VlYzQllaV2wrSXl1T25UQTlheUhT?=
 =?utf-8?B?OWtUaVVyWS9TeGlWVnVPd2hnY2VZY0QrT3JkbDc1TTNxN1ViQjRpU1pIbUJW?=
 =?utf-8?B?M0FZREFJVkczLzMyRThRZXRzZTdTdHFScFlod1pIRTlhTkl6V0tSTnFaR3dX?=
 =?utf-8?Q?QlEQOUgjgTsalJwGBWSlylSOE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a0056a-0921-475a-e915-08dbd6336067
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:53:55.4427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O++25BqlXH5wbVwMkEggu9+7ES+glK7wlebqruMQE2FIa4k+gsYcFiCFOfz+yVEZ+5o+oNcBa/7Ldue8cpfA3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 05:30, NK, JESHWANTHKUMAR wrote:
> 
> On 25-Oct-23 7:01 PM, Sumit Garg wrote:
>> Hi Jeshwank,
>>
>> On Wed, 25 Oct 2023 at 12:27, jeshwank <JESHWANTHKUMAR.NK@amd.com> wrote:
>>> From: Jeshwanth Kumar N K <JESHWANTHKUMAR.NK@amd.com>
>>>
>>> At present, the shared memory for TEE ring buffer, command buffer and
>>> data buffer is allocated using get_free_pages(). The driver shares the
>>> physical address of these buffers with PSP so that it can be mapped by
>>> the Trusted OS.
>>>
>>> In this patch series we have replaced get_free_pages() with
>>> dma_alloc_coherent() to allocate shared memory to cleanup the existing
>>> allocation method.
>> Thanks for putting this together but I can't find the reasoning behind
>> this change neither in this commit message and nor in the patch
>> descriptions. Care to explain why?
>>
>> -Sumit
> Hi Sumit,
> 
> We see that there is an advantage in using dma_alloc_coherent() over 
> get_free_pages(). The dma-ops associated with PSP PCIe device can be 
> overridden. This capability will be helpful when we enable virtualization 
> support. We plan to post a virtualization related patch in future.

To be specific, you are referring to Xen virtualization support, correct? 
Because I don't see how this works in a Qemu/KVM environment where you 
would get a GPA and not an SPA.

If that is the case, you should clearly specify that. Also, this looks 
like it should be introduced with the virtualization support that you 
submit in the future and not before.

Thanks,
Tom

> 
> Regards,
> 
> Jeshwanth
> 
>>
>>> Rijo Thomas (3):
>>>    crypto: ccp - Add function to allocate and free memory using DMA APIs
>>>    crypto: ccp - Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
>>>    tee: amdtee: Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
>>>
>>>   drivers/crypto/ccp/psp-dev.c        |   3 +
>>>   drivers/crypto/ccp/tee-dev.c        | 119 ++++++++++++++++++----------
>>>   drivers/crypto/ccp/tee-dev.h        |  11 +--
>>>   drivers/tee/amdtee/amdtee_private.h |  18 ++---
>>>   drivers/tee/amdtee/call.c           |  74 ++++++++---------
>>>   drivers/tee/amdtee/core.c           |  72 ++++++++++-------
>>>   drivers/tee/amdtee/shm_pool.c       |  21 ++---
>>>   include/linux/psp-tee.h             |  47 +++++++++++
>>>   8 files changed, 221 insertions(+), 144 deletions(-)
>>>
>>> -- 
>>> 2.25.1
>>>
