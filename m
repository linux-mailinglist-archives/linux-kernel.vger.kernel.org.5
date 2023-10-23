Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E869A7D3A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjJWOo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjJWOoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:44:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7215211B;
        Mon, 23 Oct 2023 07:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZFeGHdjMfbGCwltERCKim1Dm469R7GfiiN/dKQ7VASrSe/QfEfaWXlDBitifobD9IdYAJwpeXHQhTXvK4j5pK8HRq9l4GSZhf577pywyWB3sQ1fZJwmVodQ3b5aQkxa5Hqkeh2SXaxBSEPgxedy5AbNF+aQ+50DNhuc6rENKqVlryvyKOvPoQt1WYkBfit7BBRUyqXp8S3pgnGmTM2luYTcgD1Rmxkfvd1Rc/rU9Fb2k/VQFHVpSmN5dt7X+f1gxjcfd1RxrkFnhtr0p0xTtezlNCJJjwrPrjJtswTKYgQfFt72ToyL0wU/6aoe1HVLeh3oP1vHshqi4/5UCPUaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMGCjnvqOOeQR+fzdI7/zsiugtvJENjMZV7BxCmaszo=;
 b=GngoTLbHfC4iQQ1vY9VPRl4/J1ZUv7H0EK09QUrq26JseGLU7Dbt+LN1irsNqKm64ZthvRfjg/XtDO5qDAehKActWYA/s2yf/QRxvqF+zzoFvKrqHNof3xNh1pjgj7IGhtc/7rN2CAOURxPtB0KeItmmTI6KU8i8ruBAQ5EaAE01zWK6U57IoT83R5EGJwp/VQh0yECfZwTuIlik6Ojgj8HsIn1H9BCrXur7vszOdrW6NfCjDLJsh7my7HQZRk+lbnSm0lAtsRrkM5O/M8fITmdDVq1BSNi4OKWI8SQMCRvUDcUWHiP7l+pX8GLJb0vSITL52VTq9aRrB0j2Qmly6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMGCjnvqOOeQR+fzdI7/zsiugtvJENjMZV7BxCmaszo=;
 b=nZG8rSNclXWAsGIIfVW9+/KUYIYQTnu+uX7zjiWI/4o0Wz0BB19909mcNY/xNDvTlPL/06Tk/S0SRRd/cS+m2ifVJ+YOf3R+dm8Q55Ed9UhZu1Z6jdd08E9cgvv//OmnwLDSHCB7GpXs/dI32AUZjZ94KSgxSHg/LQv98Kee3lU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Mon, 23 Oct 2023 14:43:18 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::7e38:5c00:e469:bde]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::7e38:5c00:e469:bde%6]) with mapi id 15.20.6907.030; Mon, 23 Oct 2023
 14:43:18 +0000
Message-ID: <89f0b430-3228-7dc1-a83f-7d4f35db967b@amd.com>
Date:   Mon, 23 Oct 2023 09:43:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] kbuild: remove old Rust docs output path
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20231018160145.1017340-1-ojeda@kernel.org>
 <20231018160145.1017340-2-ojeda@kernel.org>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20231018160145.1017340-2-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0146.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::28) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c35465-c6cc-4c9c-d048-08dbd3d66585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7+QKApUajQuHHGPeejf7HHyQgRqy+L/HOZQWWzW5lyp71Zs2Dyq6UAVP8OUABK69cjh5ijH04j0osbAc4G6Ru7ul7xOpkMkq0IGZiHGZLMvVzliFlnN1u6H+PPt6Z4/IR5tIZO7XoGVUWdkI6QIoRW5xunD54qq49R2VRi3LIlZXWH1SExGXfRj/g35IJpLIDqaJPz9nUdNyIfWSm7fr4It+tRJNXNYF0NAvans+izI/ZKDIYn0e0HfeTxMtthMuX/MOpkhun3NVV5cqn4qWG/mqjYYiLVjxhTLDxGFgPQBv+MIgmS7a3aAF+n4z+HHZKJLXBGJR8nFryhJ3wLSApXBbi2VBGWTzsOft4X5+FKOBmAfvINTwVpystlJafR/3zeRSz9cwt9bmScSRAwvzv9dsALidhOYmO9DNojbU69FRYj2c8FItbg3FfYS0SaGOemSxQRvqlnFA2Gx6741XRzTTgwRv02Y3wOn/TENW7Qc4xxWPqYmvGkf26pYz/0KDe8BxD8ILENm/CyyOZVPcDnQaxuNJK0Q5BNJIFZFVomi0o0Zwbv0uj49QpdCiol38kQ/hO3eea9338JiCvaiYopNbju/b1r8iREE9eS3/enhYJPQ+6PzzNgRNJgV6EQrM2RdmJd0kVrxBa2MhclReg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(31686004)(38100700002)(2906002)(41300700001)(44832011)(31696002)(5660300002)(86362001)(36756003)(7416002)(8676002)(8936002)(4326008)(6666004)(478600001)(6506007)(110136005)(316002)(66476007)(66946007)(2616005)(54906003)(66556008)(83380400001)(6486002)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGE0WlcrcWNWZXRKbVUwM09sZ28vSGtkcHZRMnYzWGFNQURhbTJNZ0tEM00y?=
 =?utf-8?B?V004MElqSjNjSGFRaFR0ZEtHZDA0bllKVjJkeEQ0MXVUbzBWTEs2YzFpMGM1?=
 =?utf-8?B?TFVScWpPOFUxdkkydTcwcWxjZDFqT2VPYlBldk5oWkR1SWR4bVRHVTJzQXY3?=
 =?utf-8?B?V2ZoaDdYb0xVWUZBMEIzQUlmQ2NIZE5lMHd1QytRcTRqaHZUaGhNTGw0Y0dm?=
 =?utf-8?B?V0RzTWRBZFlzT2ptUklQWDI4b2xwTHdxZzd5MGdtN2lPekNiS2VsTFJ0Unkr?=
 =?utf-8?B?aXVFc1JZSG5Qd3lBNUpVUXE4V0ZkSnVqT3YxTEtaUGpPcXFmN0h2WEg0RzBS?=
 =?utf-8?B?eC80WTBKU2Z1RzhlWERZOFFQdDRMZjYvNGlPQWZoMU55VEh4aHQ5dUJWc1BC?=
 =?utf-8?B?YVJTWmsrQWhyRmJoYXdSNGJtd3VSVkxGbEkvcy9VbjFHWFFYaHMwUDNhSlBI?=
 =?utf-8?B?UVlONjY0TFlwa0RESGY0MVFNR1dHMlRMQmF5Mkt1TzRqQXhPUTBKakR6T2o1?=
 =?utf-8?B?NXdyYjc0VStOd2FyTUdTdlNnK256WjdjbmU2M0hIZ0NZelppQmdaTmJVdENI?=
 =?utf-8?B?WEg4dW9pTTZQZHpNS3VZcUR1Ui84ZVR2T3RCTzVGTnBLNWZPQVdKMFVaVzJh?=
 =?utf-8?B?b0tidEJZYkJGcHdJUUVlUmVJZmZOeG1NSTRGNHg3ck5uT1BaSEF3SUVDdmhy?=
 =?utf-8?B?YzRBcmt1WWRvS08rbEFhTi9DK3NWQUhWNzNQZktGN2txRUwrUnA3QkhzSllv?=
 =?utf-8?B?Mi8yeTcvYnF0NGcvUDlya3RBUldZQlJTV0RaRm8vZEMvOHFkN25tRnZVcmVH?=
 =?utf-8?B?TU8rRzZMeUozWVZLZDRncWZaU1drTzBvT1hZNk9MVTNMcllwcW5GZ2xwcXA3?=
 =?utf-8?B?elBYVlZZWFdSdStESWxKdE5Ya0t5eWtLeHhOb0dSYzhpem9yNDVveFRrS1Zs?=
 =?utf-8?B?clNnY0hGVldnR3IzbFZnSFN6TVNDMlJYWllDVTlIN1dkZlRKaXR2Y3VLMkE5?=
 =?utf-8?B?SkhWK0N4ZDZYS0F4MzNUQnJZYlhXeC82NWMwWGdKUTN3MmFjUXNBUFBjdi9y?=
 =?utf-8?B?MmNHMkVDUk1Sb0cvM0ZSM1RQb0dZVlk2bjUrUVpJS2EwL1JDNmN2dk5KeUU0?=
 =?utf-8?B?WWlRMFJYaTdLdWNRbkN5cTVqcnRSdVUzWVFFcURQN1pQaSsvYmJzZWNYSDZv?=
 =?utf-8?B?VGhSdnFVNllpY0tmS2ZCdk1PWTY5TEFudWVLdjJCenZrYnM3NlVvYjh3ZTZS?=
 =?utf-8?B?VlFQM1puMUxLM2x5VTlmTWdndEd0TE5yb3FKRFY0aXI2Vjkrby9SQVFTeU1q?=
 =?utf-8?B?aTJIZUhRbGpodmEwVnc4ZTRUZXRzTUE2dG10R0IrN3o1bjNnMHUzUmhKM0VB?=
 =?utf-8?B?MDg3dXpNVDJnSi9ZNHRkaStib2lJQU9vMmIwWDlhUlVnK1J4a0JtbnljS3Rj?=
 =?utf-8?B?dk1jQmhReHp2OEZjWU5TNzVncGh5QTV0WWtRT2NXTFFTYm10d1FVRm9EVTBZ?=
 =?utf-8?B?VkhnWDNuZkwwZllPNEQwUWg2RW15WUkwY3dMQS9BVlRFSDZ2WWVJblpNVEdV?=
 =?utf-8?B?d0xjQlJqZHpTTExoa0lCeGpMQkJHUjJYYmJoZXR0M2pSSXBla0ZIbDllK0hH?=
 =?utf-8?B?UCthbUNpN0tBSm9VL2FPVXo5b21ZKzJrdEh1ZXUvdTMxQzN5VlZDakNxUXNi?=
 =?utf-8?B?cGJBWFMrQXhCRlpVREtBRldqQWg3SE8wQUFwMHdSbXN6aWVCRW00WjNoWmxZ?=
 =?utf-8?B?VHNZaTdVQjFPQTB6NWlwdStIT1JrMkdGTzgrY2JDU0pXd29hNVY4cjFIOENM?=
 =?utf-8?B?ODFNZlRTUXIrSHNvL3ppdEVxN3NaQXQvaDVHRDl5YUZyOTZDdEk4VURDaHFs?=
 =?utf-8?B?MjE3Rjltbk5PSFV3emhCZlcyam5qTGdyM3poQTN0bC9TWEQvY1VqUzBFVGZO?=
 =?utf-8?B?L2RKVFRON0czZmQzTUU5Y3QyQVhKY3lVbTJvdXRsUXBsTG44bk9XUE9rZjUy?=
 =?utf-8?B?TmM1bzRrc05CeW5IQ2pPeHlwdzZJWVBReFFteVdtejdTbGRDbnZjRTh3SjhK?=
 =?utf-8?B?UHRkdjBJZlNLbk81YS9DcEt0QW01bk1XU1M3cGxaUXByTVk2U011RW5aNkZ6?=
 =?utf-8?Q?eUeLCduo1nAb75BEKwSMORKVY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c35465-c6cc-4c9c-d048-08dbd3d66585
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 14:43:18.4321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: II4hw5+Xzxcw2Kc1igy7XlTB8KulhEs1611Tr7Hd1gl+lUo4ueRCh1U/Ajpinga5ctcebkNHleJ8c7psyUSQgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/23 11:01, Miguel Ojeda wrote:
> The Rust code documentation output path moved from `rust/doc` to
> `Documentation/output/rust/rustdoc`. The `make cleandocs` target
> takes care of cleaning it now since it is integrated with the rest
> of the documentation.
> 
> Thus remove the old reference.
> 
> Fixes: 48fadf440075 ("docs: Move rustdoc output, cross-reference it")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 373649c7374e..040018111f32 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1474,7 +1474,7 @@ endif # CONFIG_MODULES
>   # Directories & files removed with 'make clean'
>   CLEAN_FILES += vmlinux.symvers modules-only.symvers \
>   	       modules.builtin modules.builtin.modinfo modules.nsdeps \
> -	       compile_commands.json .thinlto-cache rust/test rust/doc \
> +	       compile_commands.json .thinlto-cache rust/test \
>   	       rust-project.json .vmlinux.objs .vmlinux.export.c
>   
>   # Directories & files removed with 'make mrproper'

Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
