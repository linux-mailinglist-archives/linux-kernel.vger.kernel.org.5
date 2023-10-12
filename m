Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9157C6468
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 07:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377132AbjJLFPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 01:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjJLFPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 01:15:21 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEC190;
        Wed, 11 Oct 2023 22:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2ITh1H+bn/PKIFk4xIKixWhdMTOmBk0i+bww6/Q1aw2gJ0/2AyS983YguYx9RERTS/cYZkix3vcSIpWVh9jL31R7ZhCw1F+bGj00bCSxapXO81gW8Sxjo5HjoZfOForEwWLJcqvbIX5bwcglyib9KPZpOX8nIwttCsPb5b/ibHJzyOLuv31I9nN/tEl8+Gn3P+eA4tAhXUPNRy5FlsuJ6a0iTMypWt2zBXB6a0/IizSttY/kd5F1s2FU+mTEkiGw6kZwitXiL1zhRFz5NXmmluInDYaw9aACtdOKWQqC2LkGtrI5dDsANGRmDq20nVUySxU669TbWNOWa+xM99XIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDyUBOxWZRmE65ZHgG+4Npsi8293cKvALUhauMOPYSQ=;
 b=MuuDEqPfIzJ0qG+gSE4kjJjfpmMdqxRGHe9i8F0e7Tmugwq9E0fKvoQCibzjT6668NzzSWi74WKSZV8mhxxvKkOmnGggnmeBuTc5hQxpENF2qb9aI23+cTbsDc215Pd5i29msfHLMdlw/8URAt5Mtc4NkaWCT4k49gq9tjHqG4iv3Ir3dtGxAGIgpliefZsmc6sjk68/fWRpcc4Iax48QZCRks5RPqMjOq2+PdElxFpepno4/d82M5bS7ChIfedxa5Zu9nLzL3eBNlaTxvZGV9wN18gk3b1vH4Jayw6Pa7XBypQx89lh5GAv/Q+c7o0WfjKzURdWFIY8vM+vGev0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDyUBOxWZRmE65ZHgG+4Npsi8293cKvALUhauMOPYSQ=;
 b=BCdAG/tOvsq51lPgFQTXzqz2fPkxfY+rL/3tJyfHBppG+v+zMuMMez0UiIbD+tAcqcoEyCd3NSGit0Ji8p46h6msgmZH/zRBAepQBAABxRFnuNIAY2E7F/qdjU2sr0Gh9LHFclLZKUV1exkm45x+QjEV+eirXWhnI4rJciqTPVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.43; Thu, 12 Oct 2023 05:15:16 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98%4]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 05:15:16 +0000
Message-ID: <7533e359-2024-b69a-2bcf-1906c1a8dbca@amd.com>
Date:   Thu, 12 Oct 2023 10:45:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] hardening: x86: drop reference to removed config
 AMD_IOMMU_V2
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, iommu@lists.linux.dev,
        Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231012045040.22088-1-lukas.bulwahn@gmail.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231012045040.22088-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc2b740-2e80-4276-c34c-08dbcae2384b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXxOe89VzBPXEkrb4M24ry82G8vqAAUc2NAvRZPHnBw+3Zy8VRljlYJi7pkUugtR6Ql4XeH3Do0LcTEw9HjjAzmBe/67fw3cb55CYvhgGK//bgFKCOlA/zAsPFZDl+5Y9ixGbLhcelRxYW80rL9VhN1YmboKF6huHUgG6Kfc6bPgwwCoPlK7J4TbK7HeFwqahTgBGQfa+T7YBgKEvZO/Ds4rhvx0woNaOKLENrT3IusdqM3W12IamfiEyvcXvgJM0cUOiSXLpeWlmVXn0X1LpuoHH5eJaKwXhhBQqiF7drEHxEMDztfax5JBG1lDyIBwBUxqEnQzsKyjKTpJE5j3SQQNnc+7xjRfXrPS2sV/+0f/bC18Yrh6Mthn4TFPHwx1ym33GDTOm6KmTwzSNIxiSRfQ9Xgvo6DVFL1l3oLcYRs7IKj8wBquhRT02PDcBDFuVevLGN3I6mAjMeFeMuCM1CqU/E1JIhJZZ291j6hXV9AfAY4hvi6rdMWFJnOWXHL5OtLxvqJfTe3PCYMypnrCTmxqCn8/abdtOtVAny70TrGzfy2qILmZcokULM32IeQ8a9D5ayJPfsjnk7pcfkKtBE+OzKFcDk2mXkoLqZ9Bi1zfLt7sGD1zYjq+rafDUNCFcKJKWqSoG6wYqORoO3tvpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31686004)(2616005)(83380400001)(26005)(6512007)(54906003)(4326008)(5660300002)(44832011)(66556008)(6636002)(66476007)(316002)(8936002)(8676002)(6666004)(38100700002)(66946007)(2906002)(110136005)(41300700001)(478600001)(6506007)(36756003)(53546011)(31696002)(6486002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3pnUnpaS29XY3ZkdHYxSjNaRExsNkhhMlhnSlJYeGdWYTI5Yzl5RzlGZC9j?=
 =?utf-8?B?UC9BdDM3RXpFZzVrbWE3amtCS0QwcVY3ZGdkSG8zU2xOS1hnNXdCbU1wOE9L?=
 =?utf-8?B?cUVHbGJQUlJWcldVMHhxVStWNGd1TExveVl5d1ZpMkRTVUdSWWw1N0FRc1FC?=
 =?utf-8?B?K0NvZ2NFSm5kb210U0hza0tRTTBSdm16aXZQOWNQaU9td0gzVzJyVHN2STZH?=
 =?utf-8?B?N3k3RU5OYTRTZkpBZTVMMnVXZGxpUTcva3FxY1RpQ0d1REp5VmpraE5QeHBT?=
 =?utf-8?B?Mzd3ZGUzVU9wOVdoemdLd210SzFIcUhvczljLzVKaDZ6dFhaTVdKTk9xVzNZ?=
 =?utf-8?B?bmVhMS8rN1dnNGpONlpjcGg4Um5KTjlNM2xRdDErVTYyNE1BbDNBZW13c0FF?=
 =?utf-8?B?RUtWZy9aaGVTd2ROWFFQUm0yTFpwOWJheFBXcGFNK3VZc3BkbUZOclVrM09T?=
 =?utf-8?B?dHVKcFV5Vjd6WEdZTVVMQWVjVE5XN1l4SXNGR042RDU1TlhsV3RzUjR2Q1hn?=
 =?utf-8?B?dFZseUtUcW1vNGphdzBIYjdaNlNxaDl6WWJlWkhEM2IwNHRTTllrZlNyQno1?=
 =?utf-8?B?M28yT280ZnM2MDJod0RCZnAzajk0L3plUkJmbjFJSXBZOXBzT2VVZXhNYzNK?=
 =?utf-8?B?Y1NKMjVXVktGU3VwendET0NacTJjbEdhL3JtS0NzTFdrN3J5ZVFhd0JqM2th?=
 =?utf-8?B?VzRDR3NzL0gzcjFyTVpWaVdzbGZsTVVkeVlpa09ndHlXQjNvUHhuVXAvZGRo?=
 =?utf-8?B?QU4zczFBaldCaVMrTkc1K1llN2dLRlhnb2tncUE1ZlZ5WXMyNVRueXN4dEJI?=
 =?utf-8?B?Q1NxRHFTcGV5bk01ZlZnUm15Wm16ZmQyS0R2a0Q5ZENoS3plRVZWaUlIK2o4?=
 =?utf-8?B?VTVQUzlKdVVhYlBRdzNPUXpuSHgwZnBKWmdjaFBGTUQ0emdvQUoxQUFkbkpO?=
 =?utf-8?B?NCt3ci8ycytpQVJRSmFLZWlaSXhtMWwvdWtjeVZTM0NuN0s5bmxOV2FqMExX?=
 =?utf-8?B?WnY1MEVRQ3Vyanc0UGcvOTJ0OTllNEpnOC9ZWnJZaXBtdlpYYWVwN3JyWlE5?=
 =?utf-8?B?My9oMXVjYzF0ajNWQ3I2cWFsTWgvOE9jUFFoZ2tCTFlxZEJjWjhtMzI2Tms3?=
 =?utf-8?B?OTA3VFQ0WEhyUnFLd0hmdHkwT3E4UUtYcnQwTFVva1RnVjhzNWVKSlBrY2Fr?=
 =?utf-8?B?VEZldk4wY2ZZaUQrdEpCL2lyL0VLTmNDMjNzZmQ1ZEIwWmcyNjNGd2RXZ1c4?=
 =?utf-8?B?d2U2cFI4YlRCdXJyalFkaWMzZEdnVWVGeGtJUGRPY05QTFVLQnVRWTVyeEVT?=
 =?utf-8?B?Y1BPNEJUckhiWWZhTU5rZmZKSWl4bVIzKzVieTJ2R213QWFxRzhBZ0N6amNv?=
 =?utf-8?B?U3JZUTVGYU8vRnU0d2pmamNLSFpXdUwwZm13cXRxeXFubTRvTlppV1B2YnEx?=
 =?utf-8?B?T0laNnpTMzBuL0c2bHg1dlVIL1ljdG5aRzlRYW5kaDIzWnByODlLMWV2aTVG?=
 =?utf-8?B?alkwZW5uQ1hYUEUrd3Z1QU9lNFU3TExhQzd6Vjhkbk5zR2J5WUpjQ2JHQ1pu?=
 =?utf-8?B?MHd0WitLNXhNenI5QmQ3ODZhV1lzK0drMnNWdG9KSDJ1OEVQdFYrUWhtcHhu?=
 =?utf-8?B?TGJQLzJKaE1mYjVYb3FESUVmcWNNK1BrYXRnUEFIMzBUcXU3N0FSV1pQNnFU?=
 =?utf-8?B?ai9vcEFIdWdNOHlJc1lueG9ualBVQnRFdTZGT1NGdjQwS0RvTGlJZXViYmxG?=
 =?utf-8?B?S0dJbG5jK3FMbXRHKytJQ0l6cjZzdC93TWFoUnNYT1lCUGZYazBKcE9rblkv?=
 =?utf-8?B?QjBDMFBzSkJ0V3htVlRDUzdObHZudi8rVGVuN0dDRjdFcFJkSDU3MU50WU1m?=
 =?utf-8?B?aUNVekVRUWM3WStYLysvVktSNjUxM3JLdTRSaFNZMFZFYTFrV0FtQlllNDgz?=
 =?utf-8?B?dFZOZ3lOeWR6NWE5Wk5STVZSbWNHbEQrQ2hrVW8rQm90T2QyNmlWRURqQm1y?=
 =?utf-8?B?bTNEZVhEcHNsYk0wQlpyMk1MaDNTaWdIeHV6SWQ1Q1BWaSt1ZnViUUJSK1BH?=
 =?utf-8?B?d2JaSzNOZ0RMUkI2MFMzSHdmOFZPRHgwYlF4Z1RKRnMyRDhHbnkzRG02bUcx?=
 =?utf-8?Q?h9ZLHekgVI1qlsn3uGyv369oy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc2b740-2e80-4276-c34c-08dbcae2384b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 05:15:16.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uGwdPTmIqSfOVbCQkC+m/Wx6DtVO0eSgT+wjAJlMAxgM/QRTMZqsBmPCxWg6zhkDBXSmd4lV6awNGe4hxLxmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2023 10:20 AM, Lukas Bulwahn wrote:
> Commit 5a0b11a180a9 ("iommu/amd: Remove iommu_v2 module") removes the
> config AMD_IOMMU_V2.
> 
> Remove the reference to this config in the x86 architecture-specific
> hardening config fragment as well.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Joerg, please pick this patch on top of the commit above. Thanks.
> 
>  arch/x86/configs/hardening.config | 1 -

Thanks for the fix Lukas. But I don't see this file in upstream linux tree. Am I
missing something?

-Vasant


>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/configs/hardening.config b/arch/x86/configs/hardening.config
> index 19bb0c7a7669..7b497f3b7bc3 100644
> --- a/arch/x86/configs/hardening.config
> +++ b/arch/x86/configs/hardening.config
> @@ -9,7 +9,6 @@ CONFIG_INTEL_IOMMU=y
>  CONFIG_INTEL_IOMMU_DEFAULT_ON=y
>  CONFIG_INTEL_IOMMU_SVM=y
>  CONFIG_AMD_IOMMU=y
> -CONFIG_AMD_IOMMU_V2=y
>  
>  # Enable CET Shadow Stack for userspace.
>  CONFIG_X86_USER_SHADOW_STACK=y
