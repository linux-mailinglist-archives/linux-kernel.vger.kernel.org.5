Return-Path: <linux-kernel+bounces-1467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB793814F35
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8C91C24769
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128B947F4C;
	Fri, 15 Dec 2023 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RFGpfQdk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E646557;
	Fri, 15 Dec 2023 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5/cpTBHcv4GYnm7hrdKOWO+/CYP0I7oIdUwAtYdrC/Iyjxb0WjjirgKRoaQw6DvKX+bRoU7SBSjmf2n+YDWJ7TENZmoCetc9bWj02UyUMzFm5F1C7zfERdCxL8y56Jvu1sWQWzLtRjWzQhuHthmniw2tKoB3OE3/VHpx9FgmR0ETQeIAC4qDQwMwyVCZp/MmuTeedlujFVyJPzF1r7f4Wqb6WKkpIu/3s1mGv2ewhyvBPPWbxEP7i6yOlLbFe6odZcNSgcknFn0PKQsbOvHW964R1BTZMuc7cd+1FdV/idhIL/kygHdzREhTDSRLRG0GlX2iw0VCRlFLK+hf1Knig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyXp1SaIjcNJpgswMsi52AzPpgkJp9EtwycMg72N4oE=;
 b=AlrKx7CDtp4xcEYdK4WJOyX1sVt8gYXpgWs5C39AqKYQW/nh1YwXBNfm7co2G5/Jy+oXxHcT+aQs+UEJ/W5R/34r3PK2bJGAmElfVGLZnG2bpJVsAdcBVBXaprogoJj3K/r4mB+ZdtQB/c1SWQt7d5eatGPzh6vYAQIgITNiLkHSv9C7vkh1YFoFGbZBpye1fj61qRCis3tLjE/nONC2xgfHHiZfpJ0e7kCjm9/vKrgUILCbON/8ReVcCANJFJAeW/412Z7MQdU/6RITiIsi9KQoLl6U8cwr/hai8ccse0Yv/Yb1sIpw5mzvYmSC7OLltIJbLIFCEwav5psDxgIWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyXp1SaIjcNJpgswMsi52AzPpgkJp9EtwycMg72N4oE=;
 b=RFGpfQdkTRsoPh1zdOr0weRD1WdtwoQN0hTNPIeMVmyJ0AfbMDOd7zHwMN8gYkCKa4GGPOE1kwW/s5uszwyM0Nc7jLnqxCvCgLYx/Qsjr7ygbQjHTCv685Z+NdlIrUAP67YRPX7px0Zmp229ajfFX5HwIki89Ch/a7d/o8ASoh8saEDEd5vMPf8sIUt0XPDLVhdoye6M/wP5NudHX+E+/1TmP1ehmN4Jfb+EAB6HGpbgSf9D32P1NBaVXzyjeRzPlSdlXCjSpTBHWwOHyj0pdi+S2LwedQ2/+2/N8igF7tyvq9OfbKwBv8wJdJaCgiaWfQitXBOoiqWP1scs3/58zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 17:48:56 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::6b9f:df87:1ee2:88ca%6]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 17:48:55 +0000
Message-ID: <43a1013b-9b88-4af2-a39d-a7f29894e4a9@nvidia.com>
Date: Fri, 15 Dec 2023 09:48:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: rust: remove `CC=clang` mentions
To: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-doc@vger.kernel.org, llvm@lists.linux.dev
References: <20231215124751.175191-1-ojeda@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20231215124751.175191-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:a03:100::27) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2974b7-cdba-4aab-611f-08dbfd961b90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k/mb/nskurjnqwuO8paGv73Kkml23YWaeaUQScJwm/vDUbOXaeMQBkVsnWCbzb5rmXHucAlVhJpoM6xpa6eTzE6bevx5ZCcmwUD48hysXCSWt7isitqT+N9wwSMzMmnBKmWr3K4ueAW89/UJW0bPTbA3LfS400bPJeDTMJi4z4utJLwJwKvp+oMjHbswzfYL/rsp3fThDLZtIjqgKNuVoAi+O4yQdL2Lgaw2xFpPXv6SyGRBfjwk0S7GeDYJF6FOuxRzmaVjNG+lYRD/QtfRCPZkyW4kH+NR8ymq0v77jLxulU+Nk4Nx2PHYHmV5euzSjVa5SezDcr5Ti0R4BILVq9Ys1tvpbsImbEenUU9HzaWfON28TWbX0a6cm7XevY10yC+lKVwFurv4Z7Ksda4F9iocpqv+LA+t/h/T9UeoFtBtKiWaPAI+vLi2iy1ECVPg47Vj7EvwWWR3AkcNPEwSnX89PqPJwBoDKADuyot6Tv4sQ5VxUFxRv+SNA6Zm6w93tUhjE5r+K/d+/2Sj7nPVQYR+XGSj4iRW/rAypYFvS4GS3XzsrteHYZaoXET2SUqAqIPV76jhUIzoZrZc1BazURlxkgmOkesUFGfcdANTaE9/N1BIMbSip9mjKNVgCQax5ejpkIdCqvkO9gAVutmXcoR4xsbYe3nsgoyFZMlctN9D5oIIWEILv1yhXMzNJqux5xm01LGb+jhr5Gwa3xH2wg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(6506007)(2616005)(86362001)(31696002)(36756003)(38100700002)(83380400001)(5660300002)(4326008)(7416002)(6512007)(53546011)(6666004)(316002)(66946007)(110136005)(8676002)(6486002)(8936002)(54906003)(66556008)(66476007)(2906002)(41300700001)(478600001)(966005)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGRBN1orZU9OTUtlRmd6bFRNWW51b2FnUzFDNlhwbVZYRmZKdXFDRzB2cUt5?=
 =?utf-8?B?Tnd4R2lSaVZRMTFUYisrYkZzUnhWRVIzcjN1L0pOeTd4NE00QS9FR21ZQVlE?=
 =?utf-8?B?ZzNYdjJYUy8ydXlXMDd4QUhNY25XY0pGZFpkVE9lMk52aVcxOEtUTEVHaWJQ?=
 =?utf-8?B?SmYwUGw3cEpRcnEwYzRYWjd2NUgyTkxHR2dVSEZFb0ZFblJqZWw4SEttZGRl?=
 =?utf-8?B?bmNQNmVqb1BCejJtbDBUVEtmR2Jlc2FvTXd1VDAzcjBqMzlOVGZpRHl2OVBL?=
 =?utf-8?B?NVB1elppWlhKUFlmS1RPZGkrT05MeGtwVmNTYUhGTi9lS1FqeHdsQkNyRjhR?=
 =?utf-8?B?UEw0M0xHVThCSW52WWdiRDNPdHAxRncrL2txZk90TlZLdDExcmphM09kd1d6?=
 =?utf-8?B?TU5CSXNTRVh3dWd4UGoyeXlMSzdiZy9NejFMeUhXN1oyYkZITFlkNTZPUnJ5?=
 =?utf-8?B?Zzh0cEpVK3E1Ukp4bVZrQk40djRpWXJYeWV1WkJMWVF6NGE0aWI1UXdOKzNQ?=
 =?utf-8?B?RVdreEtXSjBIenZsVFJ3R3RIQi9BdDNScnNqVDZHSEhXVXFJTGQvSSthT2xp?=
 =?utf-8?B?d3hOeEFLQXF6bkkwblQweldBb1BqNitzQkdtLzBobzczSmc1Uzk1R1hkamdJ?=
 =?utf-8?B?L3RuR2Jma2MvNGhZN0ZrT0tCUmxqUDVlUU5oYVY2eVB3b3hka083WS9xeUZP?=
 =?utf-8?B?RmFrdndHOXQxdFFUaEJUNzllbW0raEhrQkhWQ0dXV3EvdDU2Z0E5ZDh2QTB1?=
 =?utf-8?B?amlVVUNuaFFKMUdoendzUnIyZklKMWFIT2dwQVZMSUdkK3NWT2VaSnVTdXND?=
 =?utf-8?B?cjBxRk93NnFWaTNDL1VHWGtkUmdGam5Dcmc3NE4rL2tpTFJmNjF5K3I2Nm5H?=
 =?utf-8?B?UEJ5NWhqNTFsMkFtYWdSMldTVVpFOGFUc3AzZUNuYnNLZno4Qi95TEtoT2hC?=
 =?utf-8?B?aVY5VktJQk1HY1V6YVY2T3Z3ZzUrVWpXYi9seVkzQjZXS205MjZVMkdZUUUr?=
 =?utf-8?B?K2JMQ3NldkNMS0xsM3htL3JyUGFyeGdPcnE0aC9ZOWJieGQ3dTNaNERYM1BW?=
 =?utf-8?B?NWQ3T1hVSWtaekpKbW15bkYyOGozUEw3a0thRTMyUU1JKzFtdjZQKzhUUG5W?=
 =?utf-8?B?VWUzTnUrRGV4c2FoYm82VC8rZk9NUXFBb1REV0M0a3NNSDR5bmd5cU94U3kv?=
 =?utf-8?B?M0NNcDh4SjROekcxcFVOMm5Vd3p4eEZYNGJUQzJZeG5YNS9kMDdzdWI3Y3BP?=
 =?utf-8?B?YTMvUUhMRmlWREdYY1Y0d1N6dDduRG1yNm1IYjI1QTBibjV4NFF0blJsUlRx?=
 =?utf-8?B?c2dQY2ZxUjhBSTg2M3FjcFM5SFR3QmRIVnliSy9ZTVZQeWNTUDFJZzRHQlVt?=
 =?utf-8?B?RDV5ajRkWkI5UWROVWh3QWxZWHQvYkJRM1UzbVlzbXU3UUlUaGlKdlBPOUl2?=
 =?utf-8?B?YWdYcTVoMGV5dFJMZ2RyTHl5RE5uWTRrZnVwZ1drNjd3d2dybElsL1pncE9W?=
 =?utf-8?B?Z3ZhTktMb3hlWFJWbzgyU1laQ0ZMSkRoKy9BOW5xaWt3ZlZtRU16SXhtRnM0?=
 =?utf-8?B?aFlhV2x6aGFzSjR6SkhaVWVNVTVOSTJpRkJNd2hPVVFETnFpSGNEcHdBcy9h?=
 =?utf-8?B?R2NCOU1tODJTYlFWS1dmcFBHV2F1L3Q2TzhZVEFWNUg5SFpKNTZDakVVKzlq?=
 =?utf-8?B?OU5GOEVTYUQ3MXN6dGgvRnlzYVEySnhSYzFpUk5DQnNzTzJsZVc2R25JeCtB?=
 =?utf-8?B?VVljMW1KVFYvNkljaVkyZDNLUXZFTisvZ1QxbzdvV0tONnFRampjblNSdkd4?=
 =?utf-8?B?WVBwY0ZzRktPQlJZTnVhV2lYUk1YWjM0T1dhOFlEOFdXbmJBSktNVVRlMjFE?=
 =?utf-8?B?eDg3OGEyK3hmQ1FBendRWnJPa3NPSE1mOGxYUnhVeFNRbTgyM2grek1RZUo0?=
 =?utf-8?B?dFV0ZTFDLzJqdnkvd3RualVVVDhMUVp2SFlJYmVQdEV5a3lVdzF1WVBVVEc0?=
 =?utf-8?B?eXdrbTRNamhuWmVKZk5rY25acFZCRU85VXZuNHllQmp5c0lXVTF1YmpxYm1G?=
 =?utf-8?B?U0dCSHMxNXRDcTlWMThGcXNpVDJTRDRvVXhNLzVvT2IvYWRITmVYR05GVU1s?=
 =?utf-8?B?dkNBcU84WVpaMmZ6TXBJUzVCUlBoWkljYld5VSsvdnlyM29ZdGFtcER4aTUr?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2974b7-cdba-4aab-611f-08dbfd961b90
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:48:55.3854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4woBavSoFM3SNI+BUFsZoRmcLWEY3fzOG/KZNlvpmtwlUitHG49nMjNY32y6qFBY+Qm9EbDOYDHkU9HfCIKMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911

On 12/15/23 04:47, Miguel Ojeda wrote:
> Nowadays all architectures except s390 recommend using `LLVM=1` instead of
> `CC=clang`, and since commit a3c6bfba4429 ("Documentation/llvm: refresh
> docs") the Kbuild LLVM documentation makes `LLVM=1` the way to go:
> 
>      We want to encourage the use of ``LLVM=1`` rather than just
>      ``CC=clang``. Make that suggestion "above the fold" and "front and
>      center" in our docs.
> 
> In particular, that commit removes the examples with `CC=clang`.
> 
> Thus do the same in the Rust Quick Start guide, i.e. remove the `CC=clang`
> mentions, especially since the architectures that have had their Rust
> support upstreamed (or soon to be upstreamed) are all `LLVM=1` ones
> anyway. And perhaps by the time Rust is supported for s390 (or new
> architectures), it may have moved to `LLVM=1` anyway. Otherwise,
> this can be added back if needed (or perhaps an extra link to
> Documentation/kbuild/llvm.rst).
> 
> This should also help avoiding potential confusion around `CC=clang` [1].

Yes it should. :)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> Link: https://lore.kernel.org/rust-for-linux/6df6e8e5-8d5b-4d3d-91b5-bc0e90c424ea@nvidia.com/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>   Documentation/rust/quick-start.rst | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
> index f382914f4191..75faa987079a 100644
> --- a/Documentation/rust/quick-start.rst
> +++ b/Documentation/rust/quick-start.rst
> @@ -76,7 +76,7 @@ libclang
>   
>   ``libclang`` (part of LLVM) is used by ``bindgen`` to understand the C code
>   in the kernel, which means LLVM needs to be installed; like when the kernel
> -is compiled with ``CC=clang`` or ``LLVM=1``.
> +is compiled with ``LLVM=1``.
>   
>   Linux distributions are likely to have a suitable one available, so it is
>   best to check that first.
> @@ -229,10 +229,6 @@ at the moment. That is::
>   
>   	make LLVM=1
>   
> -For architectures that do not support a full LLVM toolchain, use::
> -
> -	make CC=clang
> -
>   Using GCC also works for some configurations, but it is very experimental at
>   the moment.
>   
> 
> base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9



