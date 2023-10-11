Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0817C603B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjJKWRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjJKWRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:17:13 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93FA91;
        Wed, 11 Oct 2023 15:17:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAe1Pi3KRsm83jZZlX7cXn1pxi4TaUy+eDWvSFfONQSX/LdT2gS/U2UqCgWn5b8qXiXeF3gMzLDWCZv6maYJwz6U9lboEvzFnSTPj6BKVwBw9+znL3Lo0P5dKSqL5u2PxjOp/pxeaJlHLTpvvv+7AW0zyCYd/+k4nTMTmPB3FBH3yNllsIykxfZzvGIZI/C1QItgueFCV9S+U3DQYa1yrAYgKvTfqSF8YxiL40g7N1GX5VRmCXb+8yW3f0yXuxmTHIo+D6T2Tam38mmF1Dwk2C9AkM7g8kriRvL6FUyHzDSTWF7uEGgfIl4fIaU7NFqXXMy16UTU0q7JnYYVcUl3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYz03LnvIU8O44jtQpAHEdb2+oSXbdgks8YK03sGt4A=;
 b=CU23BxDwFQPcwwtP3UV5m7EC0fFgMs7afZvmcw2oAmWyKfjBJl3TJ2f6gtanRh2VgCQnIuDEZ11DQT3Dv9a8I+TXcZSUN/p8df2AX+UkwfSH3TuW1uN6SlW8aw/BKHxLolKvHtCmY2WJLEPWHaRka9dOV9rnO31/ZjzNCuQTZ9/I8JHLedU3rfs3BrA0A2IM/WEEbIZX26q8CN8AQStFog9rXPqjB3COQdn9IpdTPI5rfeNFTXWrZT3hBI+Rb8BffcSZO4HWa/7F9SaI0FVKMCOTSC8H2maX4pKHMwRXweMDNN8Kn86iDwKfFtBxP98D2G7s4ncbYQLGCicPBOoAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYz03LnvIU8O44jtQpAHEdb2+oSXbdgks8YK03sGt4A=;
 b=V6d33GKVb+nZJD/2wSUBWdIzKlk01iGKesl9z4A3ntvFS0zGe6sWvxSYuKxxyeUE2NQjvwvobxA7Xv7oFHwZbttMfP0oxL+7hLgMZ8s7K/qghC5tZoH4o02CpEiT5hSOY0+Tm5XRAf5LX8mNTR0kl5lnO/C3EZc+ZbfSbbn1EUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SA1PR12MB8886.namprd12.prod.outlook.com (2603:10b6:806:375::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Wed, 11 Oct 2023 22:17:09 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e31c:de3c:af9d:cd2c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e31c:de3c:af9d:cd2c%5]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 22:17:09 +0000
Message-ID: <cadf72fc-2c0b-428a-b445-0f6a34c18d9b@amd.com>
Date:   Wed, 11 Oct 2023 15:17:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ionic: replace deprecated strncpy with strscpy
To:     Justin Stitt <justinstitt@google.com>,
        Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_main-c-v1-1-23c62a16ff58@google.com>
Content-Language: en-US
From:   "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_main-c-v1-1-23c62a16ff58@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:180::38) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SA1PR12MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b047a1-9380-4531-6cc3-08dbcaa7cf60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cq3DKr7ttAtQwJktn7NMNU+R6H3wCK/vER2qDmfj1atGvRxb9P/TcGSPk8YAFpGyb3VmHuhMLfvRSmHx/71v8WhF40nE+f4vfuNZWvR7W8IrnEJfubYO4vqDgAyqpsJK11QiHMnlS6Yivls2gX/2YiKiq0en5omzaoPHXU/SH1KnUQOy51yZq3MlSEGXQ7fQincf+M2vlyY2WvUuWlrkAVqb1gp96tW4rhFukplkKaML3mOnk8iJ7UlFuCJrMn7oWf9tgo5iCEqFKXL0433JLukX86aoYORMpQivYL698oClCddmrmGrapaRmslBaMqZ7w25Iq7yJUAj8Rj6RZbAShVcK3lCSd/nmTzwxkp3ha6pQ7blA/YEUu97pPtC0qJG/BA6Aawj12YxhSi1FF52M+80h5HSJXef5AycT1wxLH/cxiFGG8DUa5vF2TRjFmz95YYhOWMKrUNkBDcKk9e8MdpksmZtsuTF21O/EygQu3ayVgtWIUzG4E7zb7hGefoU0wb2zYsPYdfICVp5kMHkZVskweSqQfKkmyLdolyrRmTjlix6GTqKv43cr7xfjwijhWxjMWWiSYzlmk8J6CHnYH8HqPk7d2juW9kOq5y42tGDrhH9vBqH2/45e3YB/7CWXVE5TjtMsu+x4xtkNUVLhbIzz9zJBguPjipa4wpoFDpIC1n/7fg+H6NeiG1saloTmWc0Mf5NsP9iWQANv9gnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6512007)(53546011)(478600001)(6486002)(966005)(6666004)(2616005)(2906002)(26005)(83380400001)(110136005)(66946007)(5660300002)(66476007)(316002)(4326008)(8676002)(8936002)(41300700001)(31696002)(6506007)(36756003)(38100700002)(86362001)(66556008)(31686004)(156123004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVd0QjhSbTdieExGLzdYeXM3VFd3alQzVHEvM2tjRFBvMkNJcWtKNVkyL0lY?=
 =?utf-8?B?N3NYSUVpcHZwNkxGcmcrOUNUSHdLb1RubC9JYm56czN3NHFPUHN6ZFkvVElS?=
 =?utf-8?B?NkMxOUJiZTdBZ09XN3N6MC91NkZJeDBVNGkvRkNLNk4rUXZSWDRUbE8vYm1W?=
 =?utf-8?B?UDlycUhHV1hmb1VrWFF1RHZhQUdpVFRsK29rbEd2Vk5RUzVBRDJ5c1ZZbHNy?=
 =?utf-8?B?RUk0SVV6aHJ6UloyS0U3a3c3QXVYSDNrTU4vMkVFanlBNHZncGZoZzBweC9j?=
 =?utf-8?B?alVLd3EvcFZGYVAzdEpyRVFxaHcyMlc0b0ZZMVBUL3dEM3F5SHhCL0p2UmxY?=
 =?utf-8?B?YjNTNXRHODIyU29HTi9jNFVhbkZDdFdQMGNQRUxwV0RuTVVvbTJpQUg3bjRi?=
 =?utf-8?B?QW4vTlp1QkM2MWN1ZkpsR1U1R2J2SkM1aGZTQk1YR2NsVGp0VHlJcFlkeXpw?=
 =?utf-8?B?aUozUEhHNExFN2RBWmk1U3BtaG9OaS8yV0RrZHl3MlFxc2J4c2NWd3FpMDhw?=
 =?utf-8?B?SXZML0R4VElGUHhiaFI4RER6TlpPRE1JdDFwenVucWVldkRFdXQvcXVsZC9o?=
 =?utf-8?B?Y0FyTjdzcEdQZmpQejdERGhRL0hWYXJ2NTdGQUN6OE1nYUxIaVFzUnQwNFlL?=
 =?utf-8?B?SG8yK0wrTnZ2YTVtQTVhNXlzSHJZOUJYOUdlSDFZandXdEpzbEFQRDNPYWQ4?=
 =?utf-8?B?MEdFMzBOTCt3MUhFU1hIQnh1UFMranhJK3VUTExNdll6Rk5ReGJncVNsZ0Ru?=
 =?utf-8?B?WFdQbjhrWWpMdU1rbmNtMzNLT3UvU216UkM0UDQyN1JrY0JmL1ZNdlBRRE43?=
 =?utf-8?B?cWcxKzVLYnNsQi9zdW9lbXJDcnYxN3hRQkxrc1BQR0NWL1pGWGlXUml6MUxi?=
 =?utf-8?B?eFdTMjJTeEx0Qm1qVVRSQ2JReUFJdkxCSVpHOXV2RUgxNXBQRHhtQVByVzNq?=
 =?utf-8?B?WSttaHUvK21zcjAzelVsRTRBRzlCOXM0Q0tPLzY5U0VFSk9EdzBHN3R5RmtM?=
 =?utf-8?B?dG14L1VUWUg2dkR5ZHlIc2Iwb3NpakNrZ25oSFQ2alFxZ1BXaGdwWkpHSU9t?=
 =?utf-8?B?VHFDeVlHTnFETGpjeGxCcWthQ2FraC9MSGRRZnpFTytXM3VUUnhiTTYrYlE2?=
 =?utf-8?B?YXpLQ294ZXBoUmRNWW9iR1VYT3J2Y0xEQTE1Y3laME1IN015RWVKT3haaThj?=
 =?utf-8?B?UytYNXhEMkJ4R2VXVGFWanU4bU5wOWlBM3E1dTUyaGhNSmNpQzU0bGFKbVlB?=
 =?utf-8?B?UklycHFMY05mOHB4TDNFOGJUTlk5Q3E5RzZHQ084dXlMNkZQcGFPNithT29h?=
 =?utf-8?B?MXNhcWV6TlVGMVdMbmRiRHNMOHVXa0psOG43czBqQ1czV1BZQlZEaGJ6Tkhw?=
 =?utf-8?B?NnBvME9WY1hiejNLUHBxZnNlWXF1YmFKelI3cFQzbmp4M0lxZnJKZDRmTWc1?=
 =?utf-8?B?ZVhaYlRQdG9aS0hRRlU2M0d1NUFrMHVOdTVyeXZXMnFnL20wcXd3d2xIcXA3?=
 =?utf-8?B?K1hKaGRQL1JESkJVbUd2MEFQaSsvN214YytrZ0xjcXhwRlpKVm5uV2VLU3Vm?=
 =?utf-8?B?L2NjZXQxajJSb3I4S2tqbC80QjJ6MkZENU9xa2RyTDY2LzR3WXRNalNjY3VQ?=
 =?utf-8?B?WlliMzRjaWJSMVcxWTZKS0IvMnVyVXVIM2dWcGRBR3BISktSS0Y1Y244RzZF?=
 =?utf-8?B?Y3c5em0xMHUvNDQvZ1o0S0EyNVUrekgyckM2VHBVeWU2NEZiYXJQY1UrWjFR?=
 =?utf-8?B?ck5qbGVVVThpUXdRanNtT3lJZUl6N0JXck1GaThVVm1CRkJibDBWdXhrVHIv?=
 =?utf-8?B?Q2FHZTQvQWZmZVBOL3Y3STV3dlkwaEx6em5BRFY0NHBwcTFESVBNYkhCbmIz?=
 =?utf-8?B?NG9CVWRBVnFSOC90SHVzZnkzV2hwQzFnakNGQnpnNzZxY3kzNjR1S1ZTWG1R?=
 =?utf-8?B?NStmYzcwTmUrOTR0RlNHQ0lwNytFcXFwUmY2T2xuZlRkd0NtcjhUdUcydzVa?=
 =?utf-8?B?UjlNVEhMY0MyQzNxV2FqMWwwTDlOVXRJaDEvTmo4cFpkZStJZDJVK2hMbXZQ?=
 =?utf-8?B?dnNLRE9nem9aTUVpUnFNbi80MXRvOWVyKzkvRGZhYm9nbEVLaVB4MWFlMStG?=
 =?utf-8?Q?nJ/v5lQYIyN0TKSsr/QClL+Wu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b047a1-9380-4531-6cc3-08dbcaa7cf60
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 22:17:09.1856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xxiod5hcEYVRPA/r92GrlEjlpqKBglHu6taWYOYAkdDs9huIsxXf6Vr1K2KIx/cUc2XUSmbi0zVfGu/IYKwrlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2023 2:53 PM, 'Justin Stitt' via Pensando Drivers wrote:
> 
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not needed due to `ident` being memset'd to 0 just before
> the copy.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks, I suspected this was coming soon :-)

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>


> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
> index 1dc79cecc5cc..835577392178 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
> @@ -554,8 +554,8 @@ int ionic_identify(struct ionic *ionic)
>          memset(ident, 0, sizeof(*ident));
> 
>          ident->drv.os_type = cpu_to_le32(IONIC_OS_TYPE_LINUX);
> -       strncpy(ident->drv.driver_ver_str, UTS_RELEASE,
> -               sizeof(ident->drv.driver_ver_str) - 1);
> +       strscpy(ident->drv.driver_ver_str, UTS_RELEASE,
> +               sizeof(ident->drv.driver_ver_str));
> 
>          mutex_lock(&ionic->dev_cmd_lock);
> 
> 
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_main-c-709f8f1ea312
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
