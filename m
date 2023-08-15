Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7434777CF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbjHOPmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238188AbjHOPmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:42:07 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2356F10DC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:42:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A47q+fK3vSnJklcxAvfAtVlKEcb2tVTqyj9ecnovqcOuWg+/d8BOfyFDvyhUTMbV2bLXhc1JkzVcxu7Zj9puxMtXTlmi+/eLS+tKU52s77AkpCF14h/g7qwHnBu6rXhN+9MNP3Fn58CrFWt6e/q+OE8OnOPwIe/VFCHCQJlUwTcDsy4OTFONaTFsueyXTdoP2uQGyz+1X7M14SLkEmdG9FgUPESmOvvXHmPstnsl06hmPTn/xfa7pwe75DHWAkXPK1mqN5zDqzKGUCGZMclWwQBzI/f6tNMmclWy7cAs1CBHHM8S2F0swkrCVjRYbQK2huBEVb2VAO3hkwOjpR2qxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSEY2k9JOZv7EdTrbN6ZD2WnUvTU82XZk9WC4wxa+50=;
 b=SGE5fs9In8XkFKMc927xVg2rkF9nx9DXvBN6ttyWmTZjIAcomsjN8tomrntDxwVmFongMYiouhePThDegXS8ZliAjYKYhkt4PfwCEBjbSaZltqiwwkACF8h7Uo0ai6JnRdwAGfHRyEumpUpgjXCwCd2RVY1apUSf8blVezVNp3JrmzRZzzizsRe5DsgACm+CXMlSrUDPhSmuYn4XLQ4oR+ZFelH1iMjk6ihjj6X5355fXYUVr0LqHaEgC9nR/r1TKk+XQF/uyv02fTlO/meOvo465zOEebEmx95yTR/gvZDtp0biNwZZPq9lKelJvG4USnYXPrg8R4j86KJZdywJeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSEY2k9JOZv7EdTrbN6ZD2WnUvTU82XZk9WC4wxa+50=;
 b=ABnrYmEq1kctsayntKHfzYVzLA97ogyQR5YpJ2tdGuETOidbZJ8+dHbv8D3tMB1iMkfK0Uv5J7HjFkKYa1bx5npapzbOClZ+sZgYNg/jxEFc4b6sgyKJHGzPnvQXqI2R9DLnCVVzY2aZ2M2Ch10in79eYNVRsVldR0gYobhfzN/Lsihvw4CswM/PjNw8xyg/jQuHW+JeqOrlDFkpAJFg9wPJLCUPl5GkMD5czXPjj5qGWLP6eWpDNeHmFhA2Z+iZQ95EMOvllhw1noPDWmVmcelPLZNILEyotn4ZAYqvjB44fvxJhKue6+YeuCSjtBHsxRD4Dl+Q3Q/WsUcuDxduNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM9PR04MB8068.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:42:01 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 15:42:01 +0000
Message-ID: <acd17a36-ea03-3db7-5333-d920bc65cb8a@suse.com>
Date:   Tue, 15 Aug 2023 18:41:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/srso: Explain the untraining sequences a bit more
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
References: <20230814114426.057251214@infradead.org>
 <20230814164447.GFZNpZ/64H4lENIe94@fat_crate.local>
 <20230814195153.2zxtp6zx552trgh6@treble>
 <20230814200128.ioas5lk2r3yzfkkv@treble>
 <20230814200916.GJZNqJ7H3MaO0ZTO5/@fat_crate.local>
 <20230815142600.GEZNuK+NyJdReK466b@fat_crate.local>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20230815142600.GEZNuK+NyJdReK466b@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::36) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM9PR04MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 47381deb-7c3d-43bd-ae03-08db9da62ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbEVBrC8/aM28qovdm4l3xRmILbSLc5zWHqijde1mZT2zCdCjGCAHprhrG9KoIMPwdVGXaO6a7eQKzyt6gLk2EFW/LfLu0JmPLSnAPhPYLm+JWwRdkG0P1Uv097ZBDo1QzG+gpWJ3kp2AD6SFnNyUOj8k1EFgM8o85NX45rM2QMmVoQHb2AsOgpxnM8SN0ahEYfJxFhmBR768PzOALtiEtTbfD9n0UmwIkENP+hzD4iLOU14qj0wFDxhjIr+KEon07hdHJRezpHG4d9iC9VPuoVv24uKPS9TN/KX/UTFUBoMQ7kO6eAN/SCpVg3w9pCBIDU8V7GCltO5VeYxUKixcYYGW1wZJ8XRh0kXVy8Pv9lfd4yYTLGT/fResGGgdQpR398qJWwKc0Zco0aw4AtLvH42ocrg/kDv3Fu9m0WrH1tJtVagVqkLsO2yXT3MA/HTRG3oqyhlxM0feZwWYJgl3SnNyAsPtECO9WIjR8AZYJ/lTq/HW8yFqaghrPWr8fPXViVj9AAoR3Cr1zsfDgQvMQPOkzVd/Q1CQu6PghTyL/mQummgZOyFZl2v4o6W682ELcAYPBZxR8lByo7x6uF7cVsmJoG0L33xj8BnKb8VnKHLQbeLD/0R4/23jh5GSzcH2PSwbOM6KZCZFVWLh2+bDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199024)(1800799009)(186009)(31686004)(2906002)(31696002)(5660300002)(41300700001)(6486002)(6512007)(110136005)(478600001)(38100700002)(66476007)(66946007)(8936002)(86362001)(2616005)(8676002)(4326008)(36756003)(6506007)(26005)(66556008)(316002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1JQY09TWU5UNnhEamwraWJoditJejc4T1JXQ1Q0K002Z2R5eVlJNUkxNnpZ?=
 =?utf-8?B?UTdMYUhjZEZjQWlvbkYxRDdacTdGYWVXMW1MenlsVlk3WWFkV3JwaFM0a1NL?=
 =?utf-8?B?VXVlTTQyZjc2TFJNSVZoYk5pd0hFejYrVWRrYjNPNStMcVMzWTdXYzIyQUVi?=
 =?utf-8?B?WHJhenZhVHZXSU1mNjNZMml2VnFqcjl2Z2tPdFJCSzUvN2FFeWJrTWRHc1VT?=
 =?utf-8?B?YmJQY2xFU05MMGxXWHh2TGV1T0JRY0grcjBBUjk4dVhmdTJsVTVKRjJCM2N4?=
 =?utf-8?B?U29qUnJPVjk0cGtZSXNTVGVyMkt2MVZENkN4NnM4RmhwT2dhWTh4VE5zbkxu?=
 =?utf-8?B?ZW5EL2Z0c21ldjgxcU5VV2ZlSzNnSTZQMjJVMi9NdTR1OEZ6L0g3azJKRU0v?=
 =?utf-8?B?OTJ2QXBvRWhDSWZBZFdVTEtmOUVweHowT05aYjVjTkovV0orcTVGYlp3Rk03?=
 =?utf-8?B?S3VyempmMUVURTUzSmhRQzkwdmFjMkQ4V09BVVQwbXV1WHdVYStPQmtSNmVI?=
 =?utf-8?B?YXIxbkVsWUFFYmxxSUgzekpMTFNrbHUwSk4zS2N5Nno2RW9oUmNZbk1ud1By?=
 =?utf-8?B?VnZVZmFBaWVpQ1lteXBhczY0VjFMcGhhK0RsM0w5WlN6cElUdFZidm5wUks1?=
 =?utf-8?B?ZEdML2xFcGhud3ZiY1hKMm9DU0lsNlhUeDNGTHhydGpFdTY0ZDRqY29oR01B?=
 =?utf-8?B?NGR0Y1hTTHREazhRc0VBY3pEL3V3cEMxYllEZHVJNEw4akJISU5EY2ZuQjdj?=
 =?utf-8?B?RStjT2UwMFdEZG5SQ0UveEFHZTFsZE4zdC9SdWpMTFJBMTV5blNaRWhRY0FX?=
 =?utf-8?B?eEFVMFNsdjhpVkZVa2VVeFdWSUhjQ2VkaVovN2RwVWc2RVlnaHVaT20ybmtL?=
 =?utf-8?B?aUxkcmF3VFM1WjVvVkxoSzlBSFNVVlZwdGNaNU5mcGlMVE12WkthclNFVU5h?=
 =?utf-8?B?M2lsYnRRb05UQlh2VzFFRWlZWElYakdjNFp2OWNJR3lzRFNpM2JzUXBPTjZa?=
 =?utf-8?B?ZVArby91aVV6YlpMQk5pYkd5V3VhcUtWY0FKdi9xMnMvUGFGaEN3QmhTSisw?=
 =?utf-8?B?eFZEMGc2SmxFNnNLNUY1Q201V1hCSUdqWTVWNG9PaHRURjZsQjhxR09ldnhZ?=
 =?utf-8?B?Q0dwbXhpVW1WczJIYTcyanV1Sk5vZEdTR3BHdXMrb2g4dVVLejRWZG0xRSt2?=
 =?utf-8?B?dGJ0ZFk2WHVPZDI4VmZnZUhtSHlPRjZLRGhHMzlZTm53RklObzZiY3NIWURQ?=
 =?utf-8?B?RGgvZWdKcWMzdFRjdFczK1FjOWJuQmprZXhzWURsZkg3OEtIcTVXTk5ncGdW?=
 =?utf-8?B?WXVXWGhJbENjWGdjRExTeG5ZSXo3cEdBeENBUnY2Wm82Q1ZvNHF2cWo5MUtY?=
 =?utf-8?B?cWtqN25iZkl6WU5Qay9qdWZLaWp6MktzbnpsUlQ2RC9HRzQ2YXpjTEQ1WWRT?=
 =?utf-8?B?dUl1ZVorUUlVVGxtSHFFRmpBWExkOXZ0THRLSTRzQ2tKNFBkdyttMWs2S3VS?=
 =?utf-8?B?dVBqZnh1Ui83elI1YnBrTFpEbG04TU9XNklKV1BMdmlWWnpHNmFXMEcvTVpX?=
 =?utf-8?B?N0FHNUZ2TlZ2a0VXdEgxSk5Fclo1WHhwNEdXSlErYmZ6M0FCWDY0TDBkOUhN?=
 =?utf-8?B?clIwTUgybFEwR1A3dS85eGtVdHl0Vnl1M1hSMUxvaEJSbkJNWWhUR0ZMdkpX?=
 =?utf-8?B?K1prd052aVZMZHRxMHBaSUhPR2duZkpxRzZhWkIyS2dhcjE1a01uWnpOU3pj?=
 =?utf-8?B?ZWx2TVFIcDFFR04yeGlpeEI5Z1FLc3BQR0VxN0xuRkh5WENmc2pjZU9VdGRU?=
 =?utf-8?B?K1laYVJwSm5wS3orcURPM043V2REc1BnLy9LQTRoTklRdjE4MFNoRUkrUGZp?=
 =?utf-8?B?ZmpxVUhaTjFHLzFNWlJXS1ltMVBJcXRYOWppS3BwUW1mWFZkVUlVdDVKL2pU?=
 =?utf-8?B?MXlOZGxucERVWXc4cVhxZEw1M2dCS1I3bDN1Wmxwd1QrQXBuL2trMGZjYzFV?=
 =?utf-8?B?MDlqRTByamNsd0szMnE3WWdaa201Sy9udzJhb29IQURQWlNjcDRUSCszRjQr?=
 =?utf-8?B?Q0JWcmVwY0JUYTkvY0dnd0JCaVZwUGxQU1JwK00rWCswYmVOWUY1RUhJY0tC?=
 =?utf-8?Q?a/boiQNhuNGeai5eYesLmLTdD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47381deb-7c3d-43bd-ae03-08db9da62ae7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:42:01.4775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbvniRojl3i9sm7x5Fo3XVIeIHK6GfEEDDTj2u4JqzqNFfpXGXaudAwHvj2COyTykyHMTQ5gt/nqUdNo8+1xNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8068
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.08.23 г. 17:26 ч., Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Mon, 14 Aug 2023 21:29:50 +0200
> 
> The goal is to eventually have a proper documentation about all this.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> 
> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> index 915c4fe17718..e59c46581bbb 100644
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -183,6 +183,25 @@ SYM_CODE_START(srso_alias_return_thunk)
>   	ud2
>   SYM_CODE_END(srso_alias_return_thunk)
>   
> +/*
> + * Some generic notes on the untraining sequences:
> + *
> + * They are interchangeable when it comes to flushing potentially wrong
> + * RET predictions from the BTB.
> + *
> + * The SRSO Zen1/2 (MOVABS) untraining sequence is longer than the
> + * Retbleed sequence because the return sequence done there
> + * (srso_safe_ret()) is longer and the return sequence must fully nest
> + * (end before) the untraining sequence. Therefore, the untraining
> + * sequence must fully overlap the return sequence.
> + *
> + * Regarding alignment - the instructions which need to be untrained,
> + * must all start at a cacheline boundary for Zen1/2 generations. That
> + * is, instruction sequences starting at srso_safe_ret() and
> + * the respective instruction sequences at retbleed_return_thunk()
> + * must start at a cacheline boundary.
> + */

Are there any salient generic details about zen 3/4 ?
> +
>   /*
>    * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
>    * 1) The RET at retbleed_return_thunk must be on a 64 byte boundary, for
