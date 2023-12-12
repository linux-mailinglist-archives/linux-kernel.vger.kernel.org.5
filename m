Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D5880E283
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjLLDFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLDFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:05:49 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8639C;
        Mon, 11 Dec 2023 19:05:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+cQnK3Le7yP70ui7Y9pPI6ALz0HnB1za/0t26Ip0CSmCdSBtHdHe/BpTJgWAxcHHlCC6CtgYqV7VI3k4L1WoddscP7Uh8RyFMxvLcRuwo3YF2nIZF4tsAsFiKT47h0JlOkwXJyEgTC3wlU9B0ZGd7bkb7pLJ9FFssuVHWctenrtttIeWkD3OsEdQRbRlSLdndSkcoxTsttForsmNqoWtHwKs9mlNeOvfEswWpDYnRMWLDpGMD+fQNrmFwtnBcm5RSMKBoi4NElpgTTX5ZsnYeCms+e8KXz2BpYN1dSpsLs+U5+Z5AVIYsE7f6cnUdc2ZDhxoY5yMTfysl50oPnKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+uOmGCxv5jQ3S56nDb+2034q75jWaVWeqO7sJV4S1o=;
 b=mrINM26TmXWDGHwjo7Orj8NzplepgwYhR2enNShd5F+rV7W6AcYUtngb84tHjLAZELhyW0YoJ0cTRDfd/unylbZ2lAzeiWNDUIapTyAgqmmdcBV4JtbcGj8i62ZxiMkLe9mg07M7zLzI7K8NlBHzL1YaW9ULfdl9yrVAoUSe4KntzbqMh35YPsr8378z/LJ3rMy3+kQVyxDQAJJ2UUXJFrsw8SLkoDPincBzZe3ItkQQrJIpxGUanQRENt3vg3C/Qnb6qLGLjnEfsY8EPwM5gksN+AhhopK+Y8z49akJ8pFp73PH5wmkPDoa8md7NiClw17ifnuOnjXQGlCLQVyOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+uOmGCxv5jQ3S56nDb+2034q75jWaVWeqO7sJV4S1o=;
 b=BfyJwxeGfF+qxRBVeHH7KCJMvfFYsW4ixajTsBoF/gW9fR2mD9SZqyD8Yt7y0/uBQxr9NFM9wKHnkWjYWKCDSWPbCll6z5Ql/A70lLP9ZT6Zb8Tb/lJjCtIefF+UB2C6e6XLoPS2r2TZh3tzevQFSCUVgOpGPsCgDPQGVk+n1pv//LZJRjnQiy6YNLCin9lZVD48BqRqRcMne0W1GgOJXABNn237UNOgzCbzsGj/oio7Lvc3zMgo3lffYb/S7e2NXWNTmi3qJYQMMQi430BAZzmu3KzqXgKbr1fqojL0WmgDt/pmMJRKZxS4cZBtfmVBmbmbmlUbGoP7p7YvJTIPwQ==
Received: from MN2PR12CA0015.namprd12.prod.outlook.com (2603:10b6:208:a8::28)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 03:05:52 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:a8:cafe::ed) by MN2PR12CA0015.outlook.office365.com
 (2603:10b6:208:a8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Tue, 12 Dec 2023 03:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 03:05:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 19:05:34 -0800
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 19:05:33 -0800
Message-ID: <1c535446-4e6d-44c1-8fc8-4fa248b7c4a9@nvidia.com>
Date:   Mon, 11 Dec 2023 19:05:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: rust: Clarify that 'rustup override' applies to
 build directory
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Benno Lossin <benno.lossin@proton.me>
CC:     Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        "Alice Ryhl" <aliceryhl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        <rust-for-linux@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <bf0d4ff21bc25d1ba3a31e49a32bde06dcaf6e44.1702030679.git.viresh.kumar@linaro.org>
 <4738ad1c-eb54-4ad6-98c8-3852de3e8fc3@proton.me>
 <20231211064742.63l4cmvxe4uso5us@vireshk-i7>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20231211064742.63l4cmvxe4uso5us@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb6b6ed-1cdc-4743-d7cd-08dbfabf3fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3qHzcwOjuNTZ4yE9NDzCwTnctR/JE6vZbFk4WP7QiA/LqBXVm1WuxR2ewqF0C0igbJ7x9b2+0REKUhVRob8DiuENIV4GxRBEiov+TJxeKR+f4Q/db1yELxtDXXhbNjBYHn2S0LLgK6+Bsdh9hHbrO6ZMIkeNpcFKWoSCc2KiewgXp7WLmw3JEn/CYoEcUQ/TCbBLEL1T+pgxN0p2UHMCSb+hdF+20zZqtvwJr8qvSfPx0GFSRyitUhbr9mmlsjAqJoG7Lb1AChFDPtvZGKGnZ1iSr9i8bFwSo2skWfj4oX76BdNqHOnWkV2zKhhYNuy4biG35Sweqoc/hO8oc94LuYGxcolxAEpRLWMKh3fxAy873nXNK+2DJf6JpYX87VvEMGyG5RkpLAZOjnxd1dyaSxhezlELKo4a1dv4AmlMEPCaR4cvQey9sjQ48hKOnI91Z4/GjdWmVL28Q3HsSBHV0867NJ3Dn1e7eJ/+2fM55+bedcZD+FCQBCAghQG3ybV1mIUT8uLhHNsRfI9PQhPhVK2GWkTylu6a1JTZirxcInUZCtOGfkA+9OPO7HeAr/nZI4+9sGYF+ZkRfh4PLJo0hAjHZLaaYfy3Ls8TTcZpCjHzxTYSCplQ71E7m7VlHiJ6TPOln/VOuZOt3tsBuqW+LGJnvx59eW8Kh9BVJIy2/DrtT9eiMuHZb5SJSIz1nEtezrn9K57zQrvzVrHtpcib7/fl49LrI+RQ7gm5EfVD6btCl6HSqFDRLNh09VCW9uUKxeWdW28o7+w+KUButMSGlE8HLc2936rEASdrbA1nkimPm1lG9mq49XnoBdjm6SvY
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(7416002)(40460700003)(2906002)(41300700001)(36860700001)(7636003)(83380400001)(110136005)(36756003)(86362001)(356005)(82740400003)(2616005)(336012)(478600001)(31696002)(426003)(26005)(53546011)(16526019)(47076005)(966005)(4326008)(5660300002)(316002)(16576012)(70586007)(70206006)(54906003)(8936002)(8676002)(40480700001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 03:05:51.6039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb6b6ed-1cdc-4743-d7cd-08dbfabf3fbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/23 22:47, Viresh Kumar wrote:
> On 08-12-23, 18:04, Benno Lossin wrote:
>> Shouldn't this be "Note that the override only applies to the current
>> working directory (and its sub-directories)."?
>> I think it would also be useful to continue with this: "But in order
>> to build the kernel, this override must affect the build directory.".
>>
>> And then you could also mention that in the default location for the
>> build directory is in the repository.
> 
> Based on feedback from Miguel and Benno, how about this instead ?
> 
> diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
> index f382914f4191..dee787f92d26 100644
> --- a/Documentation/rust/quick-start.rst
> +++ b/Documentation/rust/quick-start.rst
> @@ -33,14 +33,17 @@ A particular version of the Rust compiler is required. Newer versions may or
>   may not work because, for the moment, the kernel depends on some unstable
>   Rust features.
> 
> -If ``rustup`` is being used, enter the checked out source code directory
> -and run::
> +If ``rustup`` is being used, enter the kernel build directory and run::

That "enter the kernel build directory" phrase is much better than the
"enter the checked out source code directory".

I feel confident saying this, because I just read this document over the
weekend, while getting set up to build rust for Linux. And this phrase
was a little jarring and weird to me.

This is after all a minor point, but it's nice to polish up this getting
started guide. It's already a concise and excellent guide, by the way.


thanks,
-- 
John Hubbard
NVIDIA

> 
>          rustup override set $(scripts/min-tool-version.sh rustc)
> 
>   This will configure your working directory to use the correct version of
> -``rustc`` without affecting your default toolchain. If you are not using
> -``rustup``, fetch a standalone installer from:
> +``rustc`` without affecting your default toolchain.
> +
> +Note that the override applies to the current working directory (and its
> +sub-directories).
> +
> +If you are not using ``rustup``, fetch a standalone installer from:
> 
>          https://forge.rust-lang.org/infra/other-installation-methods.html#standalone
> 

