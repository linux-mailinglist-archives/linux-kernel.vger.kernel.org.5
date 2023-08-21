Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CA0782350
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 07:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjHUFun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 01:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjHUFum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 01:50:42 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02579A6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 22:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUAn9RqodKcNQ8Gs6XFUbfrkC4l0+j1MI+1CKttKgBjrAlkVJhA5C6oaVe6q2w8RXuZTM9WazlGdOwupEV/Mz1Q1b6GkHJ5bvAs9L7VU6cPt58aP6DID6kk4n/MfSQf6OfMj+ixtEhUCDaR3cjyOijLN8L6iW6/3CN4EeC4gnhXQn/R9XO1HdyC0K4IR9fYmJjoq1IWSquUG2DleZ4P2o/Ri/MxfGnLqroKhHKywo98PhbadbEQSl0eqes+ra4L6gFCwhu+UTFs4V6uQoZuVK8d89VWblW9mGXTNzMSVJpVX7W0ykZDR9TtkV5Vkxz0e2BeDlMd5f5LhuRTfwjVOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArdBoDyG8LAuV3cBx1xZscdLtns0m6y2hagTb54niUg=;
 b=aLFBzf6YfBq/LZKDhLwntkI7uIvFJAODRDIDfvb3c2B9jmEwBUm8J3bFcXThev1OI9OicFAiCzdFSoxxMdhYQTviD0AdHGkCJ0vFIdellnXOhqwQCC3jIOw7aYr29ujKfNTCSX7RZxG5JtFl1cdCDBy/YCn28P6aNd+9U8PIvl/yYdSlXqo4FyYvYh/XOO2jXbLfeyoCBznsrA08LygWifc1gsrp8Z5et1PGJ0gm8CzItM52ifI6f3e0hK7eOTevNzOelPn0zaPK21sb5VknKHK8f5cQjhEjVw54g7feKzA/RjJwlhJyBl8vexIiM2Snvpma0F6FMxnDjxM4/L2Rjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArdBoDyG8LAuV3cBx1xZscdLtns0m6y2hagTb54niUg=;
 b=gvDotMPEvfnToJlHiM5EvkiD3l5AFhj5ePNd7kSvEpJO5a0DsvpHP4ig9TWE0VC0OvNd/WYyhOU++BQ6ujg5fZznfJ/e3i92VbH2ECSfzMcKe3dB18qE+cZJi+/dofyCR1Hm4pmE5eJaN81flMU0YFIBSfXbCrlFphnv0W7cr3ZAD3cPfW8Yy2F6fNYcOQujz3KUdmBamQUDIDraJ5/1Euz06F1UCWns4hB5HzvOjwBI85XXUifAtgkZd6u0QXvg6zC/ebGIbydFrECpIlCCVRhf1cxhZfuBLb9WIZ5vA5iaBDsIC7kyiT3MeCEoMMxAXJVXLIM6o4kt4ZxXGuOYag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM9PR04MB8083.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 05:50:38 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 05:50:38 +0000
Message-ID: <a6c2ddf8-422a-0b4d-2f83-ba43523d8acc@suse.com>
Date:   Mon, 21 Aug 2023 08:50:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 16/22] x86/srso: Unexport untraining functions
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <3f72ac3b503c69ab65d86b4372ca54909d730d7a.1692580085.git.jpoimboe@kernel.org>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <3f72ac3b503c69ab65d86b4372ca54909d730d7a.1692580085.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR08CA0004.eurprd08.prod.outlook.com
 (2603:10a6:803:104::17) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM9PR04MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: e73d639e-3a55-47da-3a68-08dba20a8b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2IdkQTuLGx4xrh6s3dSQcBaMmAeNBBeKR5thiwKujFqdVzt/OvkRK1g/DFW8t9fk7Q6bizH/RA1RhjU6GfdVMGNXyTVtPMBR53fKEARceThMAt40hpTWwpvRzbmFn5rQkwoCEbFN/WzqxDcDPViomIpgSVJ1mTXYSTDSbPKe5iUrqaDn35FWcMI9MM3DTCOlVlWctCJgrn9wSyuXD3pIs5GYb1887DYCu6Iocl0N3jgHwdmzuaITSgD02xJ5J1oJ+LiUuyw/FX6wubGIf6o5BnDLAa03rpaNesf02Z8VmZWXLyWM6Lp+DWdABHaNSqtPX3Q4Dj2Zs263AWeJ8XnYlgok+iVgKKD6SgcEOqoOjDUzibcFkp9C1EqbN7QXSKd0qPHK6R/l4oecbzLhhR/QmmCj9vMo4lG0WaqpruLKJqmoIREGZa3aDVCHnRclxVDqy98UYioZjT4ry8qcj9VSFm1NQhFKeMdAAZ4hUGn8b4DWzXaBeq9dNK5QhZagLGMUrhXqjshf7M3JYw7RRb4X9qcs1IcmKYwHbl5+SA0jOL+EmMOd4viEP8YuPbFDvLJMlMAR6GlTXXVQZDKfPIYWLawNNgwDHpMA0x8L1Os+GO+PDTaHGCtgyY3jUNVkGUpDwOrpKzKi9ybZniXdgNjSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6506007)(6486002)(2906002)(7416002)(83380400001)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3MrV1hGUnZTRGdhZEZ0YW5GcVZleHlCTDhMb0FGckFwWE9FRDk5NkxTRzRq?=
 =?utf-8?B?VTNWY2VpbXB5TExKY2tVUDd2U0xvNmlVTG0rWS9yQlBsTFQ1U3N2ck5jenNl?=
 =?utf-8?B?NmhkOWxrL1Uwc0dSblVTZTNNSkRSSnlOdEdKRm9uUHoyUW5RTW56dDRQWEZE?=
 =?utf-8?B?VHNUV081N3QrK0lIZy9oS2doK25iVGcwWllZaFFuRHJrOC9BS0xoS1ByL0Qz?=
 =?utf-8?B?ZjJnSFZVWk5kc09WOXNBOVZZSFB4Y2Q3K2Zhd3ZSNUFKNFd1WXcxb0JBUE4z?=
 =?utf-8?B?dkFrSFpPcjhhUndJazhYQzdYdHE2NllpQ2tjOS9YeVJlSEFxRFB4eXphZENY?=
 =?utf-8?B?S050b0ZjOTdyZWxNZnFjYzZSSEFVU25ZbVVzSUQyUVNmM0s5MGhoYkwzY0tT?=
 =?utf-8?B?eC90K3Mvc05RcGdkS2VNWjU4MDJXM1hCN0VZWS9leDd6bXRDK3A0Z2IvSFNX?=
 =?utf-8?B?NEhlWHRBdGFnZ21mOE9IdFUvZ2lkempGM0ppTFgweHVnN0xzeWYrOGZqUEl2?=
 =?utf-8?B?clNKUGxoem52b0RHT0MyUkVkRHR1eTVQNjN4S2ZURVFnQkFseTZMbW5pWmhU?=
 =?utf-8?B?cmJ3ZFAzSE0vbEJXN3FRYllPaFRlck5lNkdBdXVVc0hMOHZBSXFiZFVIMG50?=
 =?utf-8?B?UVpyTlFrVjlGc3NkNWtEL1hMRFZBdUMrRXpTSElGVVdhY012UGVxa3MxZGZ5?=
 =?utf-8?B?bW9tSlRJcUFJUjQzUi9RRHh6WUZRNkplZnVHNFQ3TkUwc1E0U3JTV0NldXVZ?=
 =?utf-8?B?WFZsaFBRR0l4VVBBVjBycmg5Nkcyd3Y1dE4xTk1ESFVDUjcvL0JaRUhzTmpZ?=
 =?utf-8?B?UTZwRjEvaWN3TGZpVXd4Mkt1ZmtPazh1Vi9qWVpXTFV1Z0pBcWt5ZndFY1Jv?=
 =?utf-8?B?c0VFUzFzdHFTcEo1L244dnJTeEZJSUVReHFpU1VUU3VzQ0o0WXRaeko2WGpV?=
 =?utf-8?B?eEhKUWZ5YzVwbHI5VVEyZHdhQXhZcFcwQURTU3hCOHNSSFlVR3pLTmFQaHpM?=
 =?utf-8?B?WUQzZER3OVJCVVJseXlBTDV6UmZPeEVKRS95bE5MU1orbUVac25KUG5acmRr?=
 =?utf-8?B?ejlKZDVYKzQyNjcvbjNZNGd5eE56WEc3YmtwSXpLS1p4TWZXeHJ0ZVRvdWNL?=
 =?utf-8?B?bDJtLzFnc2VlcWluQ0VMandmZlJvRkdMQ0hBZmtxWW5qQjZsYnlYdDloRmxI?=
 =?utf-8?B?ek5SSE9QTlVIRUZEdVQrRHBpeFR3YnBBZjFTdVQvc0lvaUQvMWFhL0J1OFVM?=
 =?utf-8?B?V0dOeVVBOW1oM1hKcDcxZldMak5JUFE1bmRvdVdlaDJ5Tyt3ZzBodFdQM3Ux?=
 =?utf-8?B?L1c2RThMOGh5YXlVUmNBOFZRdWNEWmc2Z0RXV29EcWcyK3M2UTIzTmw0Vkpm?=
 =?utf-8?B?a0RGSW90QmRnUTlBaHBDWnFYZFdSWjUxeWFuVHlDZk81Ni9uVDNUMW5MRTR5?=
 =?utf-8?B?RkowVU42VmhESTZMRndTUWd5clFMckVWeS9JUlVhTGFINU1RR3Q0N0ZGeHBT?=
 =?utf-8?B?b1JVekRZQTRSdXJrRWMvQThuTjFVRjhBREpJQWFHVG80WFNXSmUwMll3RTlR?=
 =?utf-8?B?NXVzcS9rZU41Vit4VzhMOVBBWERLRmN3a3NPakptS25GN1FPZlVJWUNsd2U3?=
 =?utf-8?B?enNQRkZoUTNtZHJxZ3FPNmpWYU1vTGpRMkxwOW5QSUR1eEs1WlZBRUtwd1RX?=
 =?utf-8?B?cjhaWFVseHNybzJ4cEVHaDJPZnBYdUF2cmt0V3paVFIybkY0WEY1L3NLZWU1?=
 =?utf-8?B?amE0Z1F5SVVCNFNhWmZSU2Y2QXB4enBRdG9lQUt6NEhZc1hoUXpKWlRPUnA0?=
 =?utf-8?B?WFp5bitBSmFrd2R3VnFhMGRYTmxOSm84R1UwclJCZjJzUG5BZit5anRDRkFH?=
 =?utf-8?B?RkxZZVQyWWNSVnZ5RDRCNkJzT1kydGhXTDhzQW1ndm5ld09mSnlzaGUyN0RQ?=
 =?utf-8?B?OW9kVkdOUzVSMjZxQitmWnl2Z1NId0Rqb1ZobUppSEVYdHBvRFY5eFZqZkZ5?=
 =?utf-8?B?dWtXTlMwcXA0K3htRm1TbWd1SHFvcnBrRkxvdDZkbGIrWVdFM3dvN0hka3JZ?=
 =?utf-8?B?V1BOS0k3bG85clJzcFdtcEd3YTJ3bEJsbUpYV3lOb0FWb3FyYmhEOS9JdEc0?=
 =?utf-8?Q?M5wqf/+rFNb7+ePIb5tOsbcjM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73d639e-3a55-47da-3a68-08dba20a8b9b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 05:50:38.0178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KeMViWtXFGrnzqHUoR0MW/tW/bNRxP6mpoi6rfcuu4MEIKkD1NwPj3ouKDiu6QRqPhAIs2rwWOumJQzCulwm6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8083
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.08.23 г. 4:19 ч., Josh Poimboeuf wrote:
> These functions aren't called outside of retpoline.S.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/x86/include/asm/nospec-branch.h | 4 ----
>   arch/x86/lib/retpoline.S             | 7 ++-----
>   2 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 197ff4f4d1ce..6c14fd1f5912 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -352,10 +352,6 @@ extern void retbleed_return_thunk(void);
>   extern void srso_return_thunk(void);
>   extern void srso_alias_return_thunk(void);
>   
> -extern void retbleed_untrain_ret(void);
> -extern void srso_untrain_ret(void);
> -extern void srso_alias_untrain_ret(void);
> -
>   extern void entry_untrain_ret(void);
>   extern void entry_ibpb(void);
>   
> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> index cd86aeb5fdd3..5e3b016c6d3e 100644
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -157,7 +157,6 @@ SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
>   	lfence
>   	jmp srso_alias_return_thunk
>   SYM_FUNC_END(srso_alias_untrain_ret)
> -__EXPORT_THUNK(srso_alias_untrain_ret)
>   
>   	.section .text..__x86.rethunk_safe
>   #else
> @@ -216,7 +215,7 @@ SYM_CODE_END(srso_alias_return_thunk)
>    */
>   	.align 64
>   	.skip 64 - (retbleed_return_thunk - retbleed_untrain_ret), 0xcc
> -SYM_START(retbleed_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
> +SYM_START(retbleed_untrain_ret, SYM_L_LOCAL, SYM_A_NONE)

nit: There's already SYM_FUNC_START_LOCAL_NOALIGN


>   	ANNOTATE_NOENDBR
>   	/*
>   	 * As executed from retbleed_untrain_ret, this is:
> @@ -264,7 +263,6 @@ SYM_CODE_END(retbleed_return_thunk)
>   	jmp retbleed_return_thunk
>   	int3
>   SYM_FUNC_END(retbleed_untrain_ret)
> -__EXPORT_THUNK(retbleed_untrain_ret)
>   
>   /*
>    * SRSO untraining sequence for Zen1/2, similar to retbleed_untrain_ret()
> @@ -278,7 +276,7 @@ __EXPORT_THUNK(retbleed_untrain_ret)
>    */
>   	.align 64
>   	.skip 64 - (srso_safe_ret - srso_untrain_ret), 0xcc
> -SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
> +SYM_START(srso_untrain_ret, SYM_L_LOCAL, SYM_A_NONE)
>   	ANNOTATE_NOENDBR
>   	.byte 0x48, 0xb8
>   
> @@ -299,7 +297,6 @@ SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
>   	ud2
>   SYM_CODE_END(srso_safe_ret)
>   SYM_FUNC_END(srso_untrain_ret)
> -__EXPORT_THUNK(srso_untrain_ret)
>   
>   SYM_CODE_START(srso_return_thunk)
>   	UNWIND_HINT_FUNC
