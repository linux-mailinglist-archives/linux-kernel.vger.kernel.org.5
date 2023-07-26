Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A8C763771
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjGZNXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjGZNWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:22:55 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3BA212D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FC9L3PkbAXWSx9l3Ey7kVPY9NsYVvIOpSNREnw7x6PP1FbqTEuZBe1iNjhoAzA8/WX4ND+UIi8PZw3JWnUXrTbczZdPEnI1/Uu6Xk4Ab7R5CsHj87ghK/c2sXVID4Q08AVZoExpP8i6/YPVuDAgn0FW78CWbaOdeLFj6ZzaWui4wwA/zT2+R0s97K9U09h0cCP5iiVL3gIUvSgfzNqM63+l/k38ViBgYKr7GMns/whT0Td9/kstKEv5S8IjQrmfV/rRFjTHU5R08LAqj79ep6KKVvEq841LvaHMePUCbgD6804sUeIs1oE1z8OFFnWmlEukuYT3eu6B5WA2tAiGYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWXNKwERX7klsMZXejkjv/itaFoqOfVeHYCh0X2H5CE=;
 b=ZVUIy4YS//beD+wY5TQxG67P8eGU3zoZixVZuGjvs3ete7/y3I2hVS/uwba6f7xMyOphVXqa32YjeOUd3kno83HQ0BgMsumnraMNjsDNkGwN2RrgFIbG6PljrWhw7WDgGgRT/2b7YDzsOMDNWFv1p9kS1FwdRj5f6z6n37+IHRfkDzk5F34n/hdb9764Bl+FdxGWWWt7d86Cs+unOYFJcZVLeoDTUXqT4Lzqbv7hn0cjgmAby3TewwIBy/Yeu08ogSjpmgZ4ekymxE7BR71q5Kkkwxq+n9eMCI1vBO+iKVjVYuadGqcnyrbKb17PySFVuQcywnVb5Fa4OUWDv/GlPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWXNKwERX7klsMZXejkjv/itaFoqOfVeHYCh0X2H5CE=;
 b=tur1aHRzTvPxzhXa9nqqzAx/XK7k0549hPmdmp8sXmGJUFPehWLmpLt4k5CcxPEcfxS/6rT3r0Kvx9mJPJtPglQi/gueb6atNAQzdAK4GOnk2jYOhmH7mJ/V2H+Vh0EuZTSmiCvzzlnKpJ9sQaZ4HxhxEMzPid/OBeixpcFDXmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 13:22:47 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 13:22:47 +0000
Message-ID: <867d53e7-2d56-0f8d-2987-a0b2320dea43@amd.com>
Date:   Wed, 26 Jul 2023 08:22:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] x86/sev: Mark boot_ghcb_page and boot_ghcb static
To:     Li Zetao <lizetao1@huawei.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, hpa@zytor.com, rppt@kernel.org,
        kirill.shutemov@linux.intel.com, michael.roth@amd.com,
        nikunj@amd.com, linux-kernel@vger.kernel.org
References: <20230726170659.2474934-1-lizetao1@huawei.com>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230726170659.2474934-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:806:121::7) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 92bc0e55-92db-4a1c-c4e7-08db8ddb6715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NpUBhyME2D9t51vLtg01g8Ncturd67zJXSyAPrU7aLmKhz591t0f/Qrk/RdNM+f/+RPSPUjH4H2w0wV/oxBFx5MQZ4BH0jmfw4rFrhSGwVC+0i2VJyGEpPd9zScQ5nyGwhAVg+euIOli36+oCGwOGKzWTeyQk5bxxBZvrzSTM3qpNYvlHjp+FrioE5+yJmO7sXH31johtPjZBFeLHUht5UDvcGoboXFEGfWw+4QUt88KzzbSczijSN8yMz6U7Y5NSVgErzil1DC1hV4DMMk7lJkgjY8u+jjHJs45+/fICcMAA8fuCIcmSTXRk9fbG67l9lS6bVy/xLuQpIWzQLTtug7fwpa60mO4qbm0TerhhFm67TpJ1QawIHti2VLLCdYGmffRb4fEkfdTROgrbh+zzQAbzkft0HoYW6cLxDiwDxGQcV0l8v8WJyYEJU1pTFURg5Gu5Wjsf99Hs0p5LGXhJb3xvTQjRCVkUg9+Y7Sfkac+NU1YifdCXWALr1DDxh5Unzs0JOBKAYVcI6bZ04tej8UmzfNIixMItRrsJ75ZIb6/ioqJCmh5BUYjo7Y/lIMWTgJDwqBSaZo0926hc2K4WkSZboeruMDpdfUfp9C17Oyo8XbArpAiBpekRPPrt7FGrn6t61dso34HUMM0ZN16yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199021)(2616005)(26005)(186003)(6506007)(53546011)(83380400001)(4326008)(66476007)(66556008)(316002)(66946007)(8676002)(8936002)(5660300002)(41300700001)(6666004)(6486002)(6512007)(2906002)(478600001)(38100700002)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTYyYWx6MDR2cUxNODh0V2tmZ2U2SnBiWWM5ZGtSR3ZEQ01KUmpHUnZNbjh6?=
 =?utf-8?B?MngwQisrd2QwL2N2L3Jqb2htN1kyMjlSekIzd2RaeHlTWkxkZ1dCTTNvOFpx?=
 =?utf-8?B?aEthQWpoNkJSdyswWlFTcUZKdlJMcWcvdkt1dWQxZnE2d2dQbDUzYXdUbnZT?=
 =?utf-8?B?djYyYmwzQkM0cGNLaEJiWHh3UHBiVHpickxTQ055aXVwYXRZUVdqQ0VOajh1?=
 =?utf-8?B?OUdUazk3Q0hMQ0pDNW43NFNYMDcxRlVrVHIrTFZvYW1wUGUyS29SQ2F3ZjFn?=
 =?utf-8?B?UUxnTVJnUVZNeFBvSGc4d3pxQk1Ja3MzNEQwM2ptWFlXSGlCWlBpZEI2Um1C?=
 =?utf-8?B?d1pXbDMxelpGUDdQZXFXOThNazFmMC94K1VZNFFJbFY5VWZTYy9DNzZpa1dx?=
 =?utf-8?B?d3Z6L28vZGxibDBlNzVkOS9FWTE5ZlpWMVI0V1crL2Q4SmxQSzYvSGNjV3Zm?=
 =?utf-8?B?UEJNelp3VnM4YTQzSW1jNmF0VVVhMldUK0xCM0IrNmtHS1pjNngwdTVwZHYr?=
 =?utf-8?B?UnVPN21LcHdqaXoyL0IwYVhydGtFSzdFNGxGOWpFT01VcG03bHRYR3oySnpj?=
 =?utf-8?B?Q0JRVFRDRm1XSmQwODZ0SE9MMHd1SldETjJWTDJsSU16dHdrMGx5b1lNc0lD?=
 =?utf-8?B?Ym1xUDc1UUhkN3VyRmo1eVE5OVdoaWNEamxWN21JYk1ZazZXYlFiYWV1Myty?=
 =?utf-8?B?TUlxTlAvQzd6MzMrSzJFNUFlUGVVSmVvVXYxRi9DN05obFJpblh6bGh2cjRF?=
 =?utf-8?B?NDl1MjhVRlhuT0p5U2t6ZzV5U2ljRzBubHprdmxiNzJkaStOUUttc0dPRzNi?=
 =?utf-8?B?b1oybWQveDY5MUg4QUtwdUFsbWZxWC84WHZSK1FROEFkNEwrN3lOVXJxdTJI?=
 =?utf-8?B?WjN5VkVadzlsWjNZRGgyd1FLblFvM25KeDFSS2tjWTdveWF1RnArTjFlOVgw?=
 =?utf-8?B?cUNaWDlYMzZ6czRzSWFCd2ZaVDM5aUszK1RDajVXYmxKa2FPbkZ0Mk1hVXcx?=
 =?utf-8?B?d0E4WTFWUGJMMkkyZXpEaHpUNjlBK0lCRDhiYnc2V01TdTRaa1hLZTFwaFRJ?=
 =?utf-8?B?WmhQU1lJanZOUEFrdTFqRGNlU1VuUUlvUlNqQ2QwbVN2K01sY3dPVnJqd0Qx?=
 =?utf-8?B?eUM0OVUxbmwwYnV4c25ZRU9nRTROMEUrQS9jTFJiTUVEZ2xFenM4eGt0eHRo?=
 =?utf-8?B?bVpXRTdJQUMwdmk3cThNT2g2d2hVUGkxeUxGbjI5OENrQ0NHblpHT1RZS0Rn?=
 =?utf-8?B?ZEd4K1NKVVNudlBKTlVTamVqc3NRV2FYeHB5Rk81UTE5WXNOYy92S2JYSVgr?=
 =?utf-8?B?MVVuRitSUnJCSXMwZk1oUGp3ZThzZk9sSXdZeE8wNlIrNGlGdFVxUzRzS1lY?=
 =?utf-8?B?c3pTRk56anc3OUlWMFp6SzVJMjRkcy9mWE0zbTJBWFBvdkJyM3FZdjBVRVhu?=
 =?utf-8?B?T2Z1c3lpT3JWUVB2WmtpY29xN21hek1YcFkxcG5KbmdkL3pHWE5VdG9BdG9m?=
 =?utf-8?B?dTJYdSt0eFJTbTVGYmsvdDVPeG5tZnNkUGhuM2U2ODZLeWNpdm5UTWRtRkRi?=
 =?utf-8?B?RzM3S2tNa0Y5LzY5TnpwUytNYU11QjVTNEx0eEFZNjNEVTZhQUIzTU5YNDhM?=
 =?utf-8?B?cHVmSnFBQ2l2VDNiMTBzSnpJbWk0TW1FYmtPdExxV2VxU1BFME90Y28vaWRa?=
 =?utf-8?B?N1p6Qm13dzc4d3hLa2Q4ZkhPdEVoRm5hT1ROcEo4bU5BOWVZT1RCWDgzWnJ3?=
 =?utf-8?B?Y2VBejM5RjZRQStUUk82Y0VmTWdPMmxYQ0t5aytRa21iUmZCNzgyZ1FLSUUw?=
 =?utf-8?B?SFE5NGhFbGJ5akJHSzNLSnhqUGN2TERZSDJhSWY3dFAremRVK0hzZmw1ZTB1?=
 =?utf-8?B?M2xCajJJeUErd1hRckRjM3VEZk9yUk1wcmE2U09IR054czZrK3doZDJXeFJw?=
 =?utf-8?B?WE5UY3FTQ0dTWHkvZGFuaUlrWmwwSE9hNnhQZ1A5bGo4ZFV0T0Myd1lIVDFl?=
 =?utf-8?B?WHBlNy9qdUMwRVc1Smtia2wyOXJQNkd5RGRqR2RBc1MrNjI5cENMaWJVd1Nh?=
 =?utf-8?B?Uzh4aGR4UjhrdDBXTERUeEVaZzF2bXU5RittM3ZUZlF2ellBSHNxWFFWZWdz?=
 =?utf-8?Q?ZGb1gF1FCIH2887QO0jBqghbN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bc0e55-92db-4a1c-c4e7-08db8ddb6715
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 13:22:47.1902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKG6BGKax7WxMpBZV7nmhwTmRneP04fLIrKAL9wABQO5lLP4MWJDCkSCoQAGjGeuoctz12cWraoFMvFd2y7qZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 12:06, Li Zetao wrote:
> This patch fixes the following sprse warning:
> 
> arch/x86/boot/compressed/sev.c:28:13: warning:
> 	symbol boot_ghcb_page was not declared. Should it be static?
> arch/x86/boot/compressed/sev.c:29:13: warning:
> 	symbol boot_ghcb was not declared. Should it be static?
> 
> No functional change intended.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   arch/x86/boot/compressed/sev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 09dc8c187b3c..323f6298a6b2 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -25,8 +25,8 @@
>   #include "error.h"
>   #include "../msr.h"
>   
> -struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
> -struct ghcb *boot_ghcb;
> +static struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
> +static struct ghcb *boot_ghcb;
>   
>   /*
>    * Copy a version of this function here - insn-eval.c can't be used in
