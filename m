Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56841797351
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbjIGPXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbjIGPWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AFD170F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AL8m0ZJvqFrRbpXQCBQmKKVS+hV585b3ULctioo+5tXlR4TGCaGjS8AAaUA3zeJwFDkpIZfbCbIcPjFgJCxKMKmIbOF4phKmTEP8VzIvQcaq39YvCaoAOvA3tiisnlGa2w5ypRXCjj4q69+sIVrKTE5vrc99jkH4UQli4caM1raekWKu9kPda1TS60dDi75gKQTfSRION0DE6Wa6DCcRnjy4XPwPuQfZaVsDQLLagAhBqBFuNyfwSHv3qObG1/g6OV6iuB0W0Q6unC/HJgpQMYRKlP7h7ReroQ9k+zcPEVs7uMBaki8xLP9nytXW4umkezHZVl+to5nBe1WAC+0uyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGs5yLcbAo4GPEGyP7Ppsec87ZHfxMeaR3L8wIB/swg=;
 b=EvW7cHcXA5ENj53Z4FN/LZaDrUl6Q+DnmfpB8vSMBhwFgq+38RFYzOg0TLtLKrMyT7w/G39VguZlXup2n11VTI19ZyiWYnJ7NKjwiF4MOPCYAvx0PoKaTCXZMNZO+EIndZTYL+dypMHEP5ncHYEd47LzrWhJlONqXT9lsJPYC14Cm4vyuYwHK2eGXqLgCwyXFo/quFj5gTZOHHWL2MBVVCggLNV/DeUQ6eH+yuiEG3O6o5w3AFy5+2qxMtqkHTT6pl8QBh0TVGb6cdSJu9UEivqm8lZ3WZIgCQUAMMnOc+Nz1BvYv/pmfGFHy/yJxW9z/NCr66+V4aHg2v2yRF3Cxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGs5yLcbAo4GPEGyP7Ppsec87ZHfxMeaR3L8wIB/swg=;
 b=kiIvgH1RzPoU37n6cjTtj5UBMKm0tCBMk4m0nJJT76jqZek1WqPtlyEJGzb4ONo7LKXddEH106Pc9CPxDdqNWZHEN52NqxKz8DFEqeArQCRLZn6z292rSkoiSbX6buhdCR0ypW9zLj6UUyJ8Dc+XtPhUJ/q5XlW3eguJ5etcrbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 08:59:26 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::9760:1a6e:8715:e4cb]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::9760:1a6e:8715:e4cb%6]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 08:59:26 +0000
Message-ID: <7bd6bbbb-25d1-c74a-b5df-6cc914430690@amd.com>
Date:   Thu, 7 Sep 2023 10:59:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/5] mm/slab: Add __free() support for kvfree
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
 <169342401666.3934343.5520453508283712955.stgit@dwillia2-xfh.jf.intel.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <169342401666.3934343.5520453508283712955.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::9) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|IA0PR12MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6eecd1-77ab-45f4-0a6c-08dbaf80bcaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bg3sEyZFSQSMovtwAqpSBu7CDLoN22l33aKJ1Lrje+COU+hctU+5FLR6QDHis8Q00rXW1RKtkv4ZiAc7goO2BJiVzFZO4TrZNF/V9DUwqn1VL2PM+8pr1RtoaobCc5x5diB7R4p+1ZqvxO5TPSx2r4wnDN/9l/wQhaq0c0XlRCqP5a8kRXuT/XidTC88BIT67f5MAf6SdByR6IcAskxwN7U7JRQR0t3WKADyO3ShG4JWScZQvrMNk/SFvX/ZpJwgukQR9Sk/KixVs/YXpmPzF/CO3Nzzjqgobot+ML9HnLSGGJNsV4wNVg9ShKxU2Ktd8wpZaKu7vAkguA6HkxPuT+1KhLc0D6e9nqkkKxV4Zw2AHAngR9AOezRvlfRo3OAESD+9zIY0RuNzdyGrxDwmHTOXO+6e7F+JvMu5P9aUQcK4/rs26Ifw4NY0p8DOUYnFIsZSnr67f1kFRzvY+FpxFs1Zpnum/YyJ5lEPwYt+lS4x1sM8PKDI55fhUfZg19klrCpsG+Vnr1JQKkOMnryZx5LFlpUHeDVYtkRzs6u7nzTeK4Zpxo9k6aawEHnoTl/S4+RygY5xYIBP1P0clUJoPwR5bT5hQmhfwsWne9AQ+5/+1zYUo13x8ewwTHJ36yRWvqXw+BozFJK9O1bodMDjTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199024)(1800799009)(186009)(2616005)(66946007)(53546011)(66476007)(6512007)(6506007)(316002)(54906003)(41300700001)(66556008)(8676002)(6666004)(4326008)(8936002)(5660300002)(478600001)(31686004)(26005)(6486002)(966005)(2906002)(86362001)(31696002)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDZsYXBPZUlMSlVRcnlPL1o3cmhmcUxmRXY0KyszZnJXT1g3Zy9ReTFiaTNO?=
 =?utf-8?B?aXFXdVdiQlpmc0hiNUp4Qkt3Uks2dVJXMmt4RUhtRWRtNndDZEtaVTF3K01N?=
 =?utf-8?B?VkpMU0RGd29XL2M5VjhrRHZNcEs3eHVEWXNSa0tlbkJwQzVwY3d3aHg0TXhB?=
 =?utf-8?B?V0wzeHkzTEJiandhV2wzMDkzY0l3amVCSERDYkpESlNtV1dnZTRKTjZ4VXRo?=
 =?utf-8?B?VDBLRUQzcldkd0J5b3ZOaThkOEk5WHA0ODNudVhrNzJoaitMRitIQzZNODRv?=
 =?utf-8?B?WXRnYW4zeG5FRWI5NGJVR3c0d3ZGaFB2NHNnUEVsSTVUaGlHZDIyclp2ZXpJ?=
 =?utf-8?B?eEk5SzBmZU9lOTQzdFgxdEJTRjNPcVVQWXNhemQzZG5sRHdQTHY4MjhyZzNl?=
 =?utf-8?B?MmJwR0NBVnZjS1FRU2dxRjRmVnc5Q01WNWIxaFpLWnNUMzNOc1lDaEZWRWZy?=
 =?utf-8?B?Qk11S3NZMEdLazQrZmd5cENTbnhVVXNCeUJFeUpTdS9ZS2RsQjRWRGI0aHU0?=
 =?utf-8?B?eTJTbXhFMFBWTEFyZitkVXkyQzVreGRrMnc2T1hxTnA2WVc0YThMMllMSDI0?=
 =?utf-8?B?bHJnaVBaZFg1bmZMSFlWUi9pRU02UlA1WUlTdk5kTm1jbjdaYTZRc1NPb2o2?=
 =?utf-8?B?WlFMRUJNNG14eVdqUnNwRzlWaVNkeGJBNVREeDVJL0JWT1RjQUo3S0YraUVr?=
 =?utf-8?B?NkN0SERRbHZkWVkxODFrdG1tUVNZUDN2amxaSWJmRHNyTjJrYTNVQmVSMlV4?=
 =?utf-8?B?c0dKRTNRUlhwZy9yMU9sakROSkI2RnM0MjRxeUJFSmdEV25PQVRyZmtjOVFz?=
 =?utf-8?B?cTlWQm8rdFhZK2x5U3llL3gyaC81SG5iZUhHdkNia0ZYZys0dW52cFlhbmFj?=
 =?utf-8?B?dCs1bzZxSEF1NkJWNDRHRjRDM3RQWDBzVkRVVFFjem4zUmwrMmI4NnlQZUFS?=
 =?utf-8?B?bHZDSVlCOU9uaythcGhTM05xY2lwNmRJVDRhK0M5QlBzS1NhQU84RFJKa3pp?=
 =?utf-8?B?S0R5YW5FeEFOMSs2Rks2djd4Nkd5bFA3VVN2aW5MKzVwY2dnMXEwM09LUVRj?=
 =?utf-8?B?cGdMc3VNOVFHeGFidjg0WWpZR2xVN1NXS2FPN3BWRzIraTFKNlpqSVZGTmdG?=
 =?utf-8?B?ekNZK0xFdFVZaVFYNmJwYXZtd0tjKzVrSWx1SnNSOThiTzh4dnJtbWR2OUFB?=
 =?utf-8?B?VHEzSmFiZkhpdlVKRmJzNzIvWjcyNU9zendMT0doTWFTb282RUZUV0FUd2Vt?=
 =?utf-8?B?L1R1aEVxQ3Y5OUtQVGg5YUE0R0VuL3VKUmhuQXRURTFZT0VHM0F0Y2VGS2VK?=
 =?utf-8?B?Rm1wMWZpeTMvRUkxd0diUTNhNElRemZ2MWQvTWVyZkVZTzVTTktoYWxaWG53?=
 =?utf-8?B?WGhIaExMQmVnbkZGVGNQY2xpVnFDVjQvdlJEOFBBeHZWZjdmNjdzYnNKTTFh?=
 =?utf-8?B?RGprS3RuL1FSVjdqZHZxYjV4VGxWWmxoYmIvcm9ORitFU3M0V3NKbUEzVFlP?=
 =?utf-8?B?SDZGL2p1TFNYUWJVMG1vdk12WTQrOE9sRmM2TGpKa05TREhFdk5BOWdrN0pj?=
 =?utf-8?B?V3lsTWhMSndHYmpQOXNSa05CSnplVytaN3JKWUZsWG1JclhkajRDQThhaTBj?=
 =?utf-8?B?ZXcvN1orWllKVnB1S3cvcDJmUkdobk5kZTloUFJBSjVDZ0ZTY3Z0S0I2Y01B?=
 =?utf-8?B?dWFzZVJ4VFpiNWtzeVZSalZYZEc5LzFKSGdUR3R1U013b1YzMWRZbU1MME1w?=
 =?utf-8?B?a09IZjU1V2Fxa1dkVkpMVW9SNDFIdXpmRGFodFdNclpsTERDRHhndDN0dy9Q?=
 =?utf-8?B?RkJWUVVCYTRHZkdpc2ZQRzFQK0xOaHFZQ1ZzVTJ5dkZIN1YyOVArTU1UNVhO?=
 =?utf-8?B?aDNuZlZRVGplVExQclBNc00yQm1LbFZsbVV6b3FxaGF2UEJGajFIRWhsKzhn?=
 =?utf-8?B?YkZ0aXRVN1RYM0hUeDFHdkN1c3lVMnZDZHgvVi8xNWNQUWJ4S0tOQzRzVTM1?=
 =?utf-8?B?dnBIY1dTc1Rjem5QN2o2MCtnaHhOU055WEs5K3FYTmhjMm9LUGZ6RkFjN3N2?=
 =?utf-8?B?UU9iaTBpY3FYQS9FdFlrVjdMME5PY1NzVHhSSkl3VFpqRlFNUjJuWjJIVmhW?=
 =?utf-8?Q?A6YMErGk/c84OnTv8ZTwLG0a/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6eecd1-77ab-45f4-0a6c-08dbaf80bcaa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 08:59:26.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcG7m+dfIqLNjoVoKQBqV+rkZZ6s5JT/mxA1UU85++q6LoyWS8eAcbWojH/9CIJjk/VrLXizwXDKyy8WQZcJQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/2023 9:33 PM, Dan Williams wrote:
> Allow for the declaration of variables that trigger kvfree() when they
> go out of scope. The check for NULL and call to kvfree() can be elided
> by the compiler in most cases, otherwise without the NULL check an
> unnecessary call to kvfree() may be emitted. Peter proposed a comment
> for this detail [1].
> 
> Link: http://lore.kernel.org/r/20230816103102.GF980931@hirez.programming.kicks-ass.net [1]
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   include/linux/slab.h |    2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 848c7c82ad5a..241025367943 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -746,6 +746,8 @@ static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gfp_t fla
>   extern void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
>   		      __realloc_size(3);
>   extern void kvfree(const void *addr);
> +DEFINE_FREE(kvfree, void *, if (_T) kvfree(_T))
> +
>   extern void kvfree_sensitive(const void *addr, size_t len);
>   
>   unsigned int kmem_cache_size(struct kmem_cache *s);
> 
> 
Liked this patch and use in the patch5. Still cannot comment on the 
attestation part of things. So, for this patch:

Acked-by: Pankaj Gupta <pankaj.gupta@amd.com>

