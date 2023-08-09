Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD9776451
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjHIPqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjHIPqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:46:09 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2087.outbound.protection.outlook.com [40.107.249.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1832690
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDB4dZfVtYKgWbd2E10Evfisz92iB3uy1sOa57xWZoThZFHm5AQ21JHtlIdohg2RciQm+cJSNWFhszer6E2azKkYJR1izU4fc82gezXu6Y70H4HBQ9wEI5jKVfPSifQyOdfPznyi474DFm0rWu/I9no6PFvPX/ZSQuP8XDu9x+y+MFF1WHgcIIcfcdSFxTSrMlg0re78WXNLBpYjomEDFA3yhNhiW76vXnIFRkyjnt7IHweIUMSNDegPlEsw0EVOTQsw3Fju1Ym0+tpO6cOy/uEybsM5M4nDA30BDiUQbPlotXXIAMDuroI4HCnv1K1vFLQ9MwIMXHSPqWYo399KeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqRHXAei9jYixVuzo07NvFFUz0JpLCopNFjGuyQkFUo=;
 b=W6GZbpKXrYfpm/lYoFJRg0lzfcUx6d/Wf/PToKKv6N0HS53BcTsO58MUsfMWJYpgoq1SAY5N96oshxb5m6QDRxw11ek3LlJ4jnyGtpq/AWNp68Pod2/SMEg8JiLYl/D06TzckTDEBPSAebtlr+450n8x+Yzhx1DuolV35Vwe4j/oGDiYP+3h03wYrZEr2aNa+y+KWoaSlDMScKuzGCunJSKgPWY8yJSvIdfOvpMfRXpiNA3k7dvBAnk5p74iioEH6tFbvispORjaAYAUR+lsqoQ0A0HHqseymgXwuyZ1quNYJSgC4KJcv8ZraIy6zwbMm49tDv1W6FH1jZ9zyd/uTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqRHXAei9jYixVuzo07NvFFUz0JpLCopNFjGuyQkFUo=;
 b=dO1IR8Kw+cmxiFAZW4ZXIVe97ae4VdUJF0n+7yMc0bLGsvx4V8mc0R6gaEQI0d6VaYBtKAJ0AG/IrkAZMVWRGt+ABv4RfHbvFLfzfwXnj16iI0Lj9g2xCkiUgzbFjd1ecAvvd6EeYuKLMjIEHBgsG2ohPv1Ivq/fLDSkjNF3H/YVlqNcSVNtV2o80d9+2UKiG+/Rzg0ZG39HY3drAO5HaIBtRcO6+7kWGF7PJbYvLmpC7HpBBrjptQh6tDw79dFXsHbBDrwvTOuWDjFD4eA6YiQUZwHgwHHLSgg0f0VSd9IcVslEQNdc3aqNhG2I+oHCNu8xUK7+ByDoDMKvN4GHmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by VI1PR04MB7120.eurprd04.prod.outlook.com (2603:10a6:800:124::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:45:59 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 15:45:59 +0000
Message-ID: <e72b4099-5098-67cd-d9c4-b111a7619808@suse.com>
Date:   Wed, 9 Aug 2023 18:45:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC][PATCH 02/17] x86/cpu: Clean up SRSO return thunk mess
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
References: <20230809071218.000335006@infradead.org>
 <20230809072200.543939260@infradead.org>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20230809072200.543939260@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0061.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::38) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|VI1PR04MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5e1cff-4a79-4c7d-04ce-08db98efb9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJyr0jSPOqvM+7tJIFnI9eB+9bwZ7abmKFnQunmL+jfonuCjBs6m5rPQABhJZPR8nX6ToWPJR+ERLTW9QNLWe3U5EnPunkJVcbKHAUlIXigFqXu8Pc1Wbck/UhYbfJZGjm+hfPI9IVxDwfRJTupFnPQta9Axbh092FQU2iLQyxIPRqmwwicl+DN49gdCmoMyg2f3c5HRMk+wwDmsqGfpQRPhu0N0Vx2pjwAQiZ2y7GsjTU5UaPTu/u/RFpZgeL6qGA/yIOGhROHQhlehlWonhTQTXrulyVOyZbxYwV7pxgei2LrhXxqamwyFDr2SZDNpqzlLWHZgqU1iRXUwmfeYpV4ilIVGmb3AkPSkLZ1q3RIieX7va8L69CL/AZT0goYwE4syynzAE0/gTZVEtGY0wycJJyjRj1sEBc80jEWAUKVeMyJ8cs8u2W5/OdX/84bG2x3CgIwi3NxxBjTTMGzTYNMu/fKyy3HujxnyP2IK4zjHsnN/FEzpzy6BlsyR4w08THatxSxnr8yK/cgBhTD6YGXaRizhrn15FXSBgoV39zBMWwLROgXK70Hcm182yhfQ4ZRWV2r8i9CuH8ekdS1RAhgS4w31oUYD/EKqb1+auXS2XA4YUMXBqzST+ZWJikDmwNof5xbLSeByaf+KINKv1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(186006)(1800799006)(6506007)(41300700001)(66476007)(26005)(6512007)(6666004)(86362001)(31696002)(6486002)(478600001)(2616005)(36756003)(31686004)(316002)(66946007)(66556008)(4326008)(8676002)(38100700002)(8936002)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEs4REtvWlV5ZlpCdzVxNllIVXpuVytZeWxvV051MXhia0sxQmpFc2U0bEtp?=
 =?utf-8?B?M0p6UlUwZTRxRktGN1lqSzVkZmlDYmh0MHNERS9qMTdEbmdyeTFkR3VnQVRO?=
 =?utf-8?B?ZzM4WTlLeUwyRnZ5WG9lUkhnM0ZySVhoYytnTUpDcUZsRFRXbmNuWkc5eHVZ?=
 =?utf-8?B?WFF1V3FEbjNhbmtNdFpiaVU3Q0hlczRsMXBSMHIxQThVR1lzbG85ZXFvUzJx?=
 =?utf-8?B?NUhmWDNDcjY1OC9UMW1YZXJGYW9NdU96VEpjSlBBNWZlYlN2N20xMUJpWXJE?=
 =?utf-8?B?bFQrQmc3d05tR0s3a3RFb0I5RklQaFNmRURMTUJ5bHFqbDgvYi9Qem5IS25u?=
 =?utf-8?B?MXpwU0JVaVVrNWhvMXF3RkF4WlowcmNXNks2VGdUUmphVWhxcDZqMW9UMStJ?=
 =?utf-8?B?R1owMFR3eHk0MFZ6NW56OGZMd080VVZNYXF0bm9ObUZ5Uzg0Tm9qM2FZYnhC?=
 =?utf-8?B?ZGdsWVpwenUyM0E4S3llem9lOEZibTJncXE2ay8wUW4wcnYvRXhlT3dsSFB5?=
 =?utf-8?B?bi95bTFiVlA2RDNKZUY0NWZkZnZJaER6YmlOWlVJeFBsK29hME56SkFRdVg0?=
 =?utf-8?B?bWJGazc5T21kSU5aelRwem92TjBDS3A4MHBhZFh5d3ZiNy9oNC9RZEIzMzZJ?=
 =?utf-8?B?Szh6azFCOFlRckhaVVg0R0ZERXdJN2FJVEtJa0xrY2lMS01Tc3psaUxBZ0Vy?=
 =?utf-8?B?cGxSWnVXVVRPL1d1RGQ3Ti9ySlpUMXFlaFpYZzZ1dTlFbU96RllrdEx2cHcz?=
 =?utf-8?B?czVxTkZsVXRQait5clpqZkdRVjB3RjRCbm0zMGd4TExtazExejRzM2JQZEda?=
 =?utf-8?B?ZFQrVjU5WG50emQ1VVlvUVRraFVETHFCUU1IYzJJcG56QUNlK1hOZ3N0aG9a?=
 =?utf-8?B?Z2pWcXRuRnlBK2xBRmFibHBmeXB6Y3dvVkp2Vk93VUlvK3VtbHN0aUhYS0o2?=
 =?utf-8?B?V0lhRThwc2ZVck9ya3EvZ04weTlPS3RZWTNhNHNJYnlHYk8wWDBzMHpYSFRa?=
 =?utf-8?B?d0hPOHNaQ2V1K3RSa1dreW5pRVUyU0JYQ1lmZU5JYlVmYmw3L0dJWHc5MVZ6?=
 =?utf-8?B?WVdoUm52TEttaWxUUXBRNkN2OWRqOGxzOEJqMFNxbyttYUV2elJ1NmNodUJa?=
 =?utf-8?B?YjVyZUROWUdHbmNOaXozMloydjdFYUNkQ2Q4VHdGWVYvWnRQbWViUlRxckVN?=
 =?utf-8?B?YVplUURLV1cySTI5Yk5va3JFTlM2L2grWjV3Zm8zR1NnQjZHd25qc1c0SzFz?=
 =?utf-8?B?VXpYamVXK2J6QjQ5VWVsSTRuQTlVK1lIeEt2V2lmV1RHSThzNHNqc3kwaEls?=
 =?utf-8?B?d0h0ZURDdFl2MXEzVlh3eit2enlVZHZNdUJIT3preDZEcFkrY2E1N2xzbnUr?=
 =?utf-8?B?Zm1rYzhLQnpXZ3UvN3hqcnp5K2wwbnVteHFvMnNhaUxaSXpOWThkanBFeEZ6?=
 =?utf-8?B?ejVwNEZJSTRXbFIwL0ZIV1dWM21CcUttVTZFY2F4SE1Gc1o1ZHpJWWk4M3dX?=
 =?utf-8?B?NnJEcTlmVHhsZ2Rha3RxdzZkdS96OHpUdUJQTUh3SVpJY3JBVnFnVkJJZUQv?=
 =?utf-8?B?Z2pKcDdyYUczdTJEcWY5eFpqMThCbno2MHNmMjhka2pNeEpvNjJDcXQ2SjBO?=
 =?utf-8?B?d0FUTGtQSm9ZUXl6Q1FzZCsxa3B4bXp2VFo0NHV2aXFXYnRWeXVkWmVEOVl4?=
 =?utf-8?B?Rit2VEkzV1NYaFEzMVViNGsxN2wvd0lLZG11NXoyd1FwNHZIMDd1SUtqS0li?=
 =?utf-8?B?SVBjVTBaeWdTM3dteDVjMngrYm1uNVNjYVZxdXR5T29mUkJVeXVrUHpMQzVh?=
 =?utf-8?B?WGRRdjhKWlI1N0NGWlJjNWFJbHVyMVdRQk1RTkl2aHpVT2xuRlBQSGE4Sk8z?=
 =?utf-8?B?UTFUdWNQUGF4TUt6NmVxcnZZQ3NZcldTcnF0ZExxZnJ6aWM5U0Y3QUN0KzRp?=
 =?utf-8?B?VmJSQUVxMlF2anlTQ202ZzVRUGIydlduWGp1aFZ6VmZoR3F6ZE1Jc1NLUExl?=
 =?utf-8?B?U09tK3JHWUs1ZUR4YklWQ3drKytQU045NGZGdm1heGJDVFk5VWRxaFNIL2ZH?=
 =?utf-8?B?cDdrY3lmWGdKNTl3YUJZZ2ZDSmEwUWlYQWJFYndiSTFhZ2tWbk5GczdMTW9N?=
 =?utf-8?Q?ks/Ac04sztSLTKnB+OeainKfJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5e1cff-4a79-4c7d-04ce-08db98efb9fc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:45:58.9607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fP+LcGmwiDDdThHv50YOzXFGKEVCtji317cQ+eDxus6/j+hMQhV6T7V/SUd/MiUZA0PrZgHEl8HUW4RWVMIEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7120
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.08.23 г. 10:12 ч., Peter Zijlstra wrote:
> Use the existing configurable return thunk. There is absolute no
> justification for having created this __x86_return_thunk alternative.
> 
> To clarify, the whole thing looks like:
> 
> Zen3/4 does:
> 
>    srso_alias_untrain_ret:
> 	  nop2
> 	  lfence
> 	  jmp srso_alias_return_thunk
> 	  int3
> 
>    srso_alias_safe_ret: // aliasses srso_alias_untrain_ret just so
> 	  add $8, %rsp
> 	  ret
> 	  int3
> 
>    srso_alias_return_thunk:
> 	  call srso_alias_safe_ret
> 	  ud2
> 
> While Zen1/2 does:
> 
>    srso_untrain_ret:
> 	  movabs $foo, %rax
> 	  lfence
> 	  call srso_safe_ret           (jmp srso_return_thunk ?)
> 	  int3
> 
>    srso_safe_ret: // embedded in movabs immediate
> 	  add $8,%rsp
>            ret
>            int3
> 
>    srso_return_thunk:
> 	  call srso_safe_ret
> 	  ud2
> 
> While retbleed does:
> 
>    zen_untrain_ret:
> 	  test $0xcc, %bl
> 	  lfence
> 	  jmp zen_return_thunk
>            int3
> 
>    zen_return_thunk: // embedded in the test instruction
> 	  ret
>            int3
> 
> Where Zen1/2 flush the BTB using the instruction decoder trick
> (test,movabs) Zen3/4 use instruction aliasing. SRSO adds RSB (RAP in
> AMD speak) stuffing to force a return mis-predict.
> 
> That is; the AMD retbleed is a form of Speculative-Type-Confusion
> where the branch predictor is trained to use the BTB to predict the
> RET address, while AMD inception/SRSO is a form of
> Speculative-Type-Confusion where another instruction is trained to be
> treated like a CALL instruction and poison the RSB (RAP).
> 
> Pick one of three options at boot.
> 


So this boils down to simply removing one level of indirection, instead 
of patching the body of __x86_return_thunk you directly patch the return 
sites with the correct thunk.


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
