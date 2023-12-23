Return-Path: <linux-kernel+bounces-10464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE1A81D4B2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99311F224F9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115E7DF5C;
	Sat, 23 Dec 2023 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ezK37pn+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2120.outbound.protection.outlook.com [40.107.121.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2FD305;
	Sat, 23 Dec 2023 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hy3u7NNsPeB+0Sh70sorkeM9YTMnXWLb2t+bdF1apoz35ZGDWXIHCwn5WsEQJJzVEuF7TuFoKjfjLC3hr9P2xsWaFGBL5P3dZOBEP9HZURO8SfbbesaG/SbbkaRW50qN4zuhi4CKM1eDVaipU7OYmxTkIb3D8o5WPqaMi5gCqe83w2CLtxKmd7Zl2hsjH4UjQ1yvx2iBkG17qpjogGWrVdvJ00JcjoQj5bljPzRZpvr+wAHwJEpVXcEhTPw6Bdddc5f/tsmN6/XNbQCsYgZUYAAujXjHgOmMt2yIjYI9d/FVDqfrasm3opr38ZZavN3QLUIFhJf+UxBPBPKs4WvICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZN1BinRJPlb/Bgl7JNcTJZbHGZzx8dY7sHNGoap3mE=;
 b=bs2hLg+PqXyRJYzuAzocaIB8j10KEPDB3F9Rl518/sh2Qi0j7FmOHjALrvcTNhU6WjmESd4DndOqxToepIPc4MH+nmlN/iCM3hTu9R8raVHw8VRH2600nXaVZfYDqhAUia02UjLTTlsnDMijwAB/sPgIdnrdXpXOXVEy26vG27xdTdELZfKc068pY4sx445tgJtkhkPaCByX9lGzgVGVfZr+Ldx0ieXlJtTlFknobP/82IlPwJ65uRjln5lx2piH+wyMcYrqYBZ4ug0KhISrHcc5NMGswxEoA8kinnvXAppprIc17JVIQ6W95hNQ+b6SjBamQwoQk6sCFqznQ1P1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZN1BinRJPlb/Bgl7JNcTJZbHGZzx8dY7sHNGoap3mE=;
 b=ezK37pn++2IYxUSaUHsFYZ5tVHKWskc2gs4maKv7UOqi0GkdPwa2hgr9HVkFLHaCuZuoNXAfwnc3ACrWyNfasn9eP5T1lRLwK1fF2V/hR9w+gyZBs59hm8Hny/uNA118MJF2ddwbw+YN53A1uU1nNJq8ZlBsNojokkCwjjrUkyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB1908.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:49::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.22; Sat, 23 Dec
 2023 14:42:20 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ec07:aa7e:ffbc:ba47]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ec07:aa7e:ffbc:ba47%4]) with mapi id 15.20.7113.023; Sat, 23 Dec 2023
 14:42:20 +0000
Date: Sat, 23 Dec 2023 14:42:17 +0000
From: Gary Guo <gary@garyguo.net>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo
 <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rust: macros: allow generic parameter default
 values in `#[pin_data]`
Message-ID: <20231223144217.5c71727e.gary@garyguo.net>
In-Reply-To: <20231213220447.3613500-2-benno.lossin@proton.me>
References: <20231213220447.3613500-1-benno.lossin@proton.me>
	<20231213220447.3613500-2-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0132.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB1908:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a9e435-8a4f-43ad-672e-08dc03c55df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N0KZ3KAeROQflE1fXllOBTK8waYZqYDSNjzvOznXOoC5gVR25UI9r30QkY3POhkgxjVCevdKH+/+0b9rP25eVM7Fewd2QEkf8zq+Y5vEOvAueX0o0BwoUkFDWc+XG3jz4aPERYfik7Z/Rq1x8qZELZI0FlnFf9pvwMHU6rpMGlw+LrfK9wnTolt4hkB8uqwCWPlgp6dPcJTQqetOkWCh0JYHCDP/rFJwNknMDlip0fOmKMeH5xnmwbNPSIz5tuLvoRih9Lw+KXFnBBQrexv7Rej9opRc5CuFHBetS7J02LYqbBORQUQ7Vlu0HYnalTMJfIm4KeZsMTTygOkm5FVvFI9ivQVAN6ddNWaJu8skGjTGM+36BNp6ioFhU6T4or9HG0yXTiTeatD5eYQhs7x7CuYCNQDgNsIfAr7CvObD2JQxICKpUj68wMWZhNvtQL/GL/4yB3xatkomFLhBOO8xt+XIdI9+OIJu9qfv429qSNyZK+Y8siNnaAb+4eD5IxYnte7IA4ierQUlUvLF6eu3a2FzDRXwSNiQkogqbK6d1HgSvij2dlzUrcAseIv9aZqhzj9rJPXN3Z1uGkMWJXc3BFfhdFHrWQ+NUPRWECoSBJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(376002)(136003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(86362001)(66476007)(6486002)(6666004)(66556008)(478600001)(6916009)(66946007)(54906003)(316002)(6506007)(6512007)(2616005)(1076003)(8936002)(8676002)(4326008)(38100700002)(2906002)(7416002)(5660300002)(36756003)(83380400001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gwrIn0zxaVohoxpZAiTyDBXWxfBuE09axEyeH8bdtOK6sKml08YCiM/9p2v7?=
 =?us-ascii?Q?Y0luWKyHqH7xvoCXsmbpsMXBbbVYFfJG/xiv52aLTepzlnOgQlkwaiCfUUw7?=
 =?us-ascii?Q?QRaEq5VvlSkW4FWftgTLwV2u5zlvrvtSq3CAVXnL83gISFrJgRiOEyOH+ORM?=
 =?us-ascii?Q?yHBLkPVwBAcp69jRdmds1RPil51Ks4kmjcu8Dm8+X8nVSUIkV08XrkyG+qO9?=
 =?us-ascii?Q?EVoH7ds6McnZIfziL3ORr+5Oe39CEO7z5gJj2NOG5pJDReAns86QjrsUGo2e?=
 =?us-ascii?Q?DndJzWRuXwgjf4jHxINtIRRHC/TNfuTVqi4iO0Bt6tBHVtPxrnfRW4cpty5n?=
 =?us-ascii?Q?oDeVviPsBPuqtCJ5zLd9GMRNU1DEhjFhfnyyfwbteBgRqyecJawf41dF7dba?=
 =?us-ascii?Q?3zYSA9E8wlscPyjMr/7krXy101q6fWDa3DYi6WQp7cO2rFsZr1wLbTwgFVST?=
 =?us-ascii?Q?rF3t/xAwW76mEhZAdrPEanKXyyP6yHdyGFU/j5jskum67fnuiJeqSPACRbX/?=
 =?us-ascii?Q?9/WGk/i6FSeagmaUxZNZ3la0tBeKHTZVA0aZSlC4+/nN+E+Y3Jc6rPj7JDmI?=
 =?us-ascii?Q?h+iFXizINUnhAfPVVixzsEcMkAW+QhUDe+yguUPunVFy+OaqKnhtZJYAMyjd?=
 =?us-ascii?Q?csEI6BcFuS+x6Ch2tgQQKyBFt1+XITqWhdy4kDBgZH/dIyvDYo6cwcXTdWFx?=
 =?us-ascii?Q?y844AvhphyzCnAyeVVOBMSX/qdUK5nSQi2Rz5XeKz/8nXGFTYy1YR9qu2gCr?=
 =?us-ascii?Q?QE8uUCC4KcFsiE3bvT8Imr2VkwUeRDRjrOp7fGFfICYMsmS1V88occ/0WQ/G?=
 =?us-ascii?Q?YJCeDNq9P/+8EKMND/qytKDydZnNbIZx6u65umbRdZgSnGUajDjzdEMAXbSJ?=
 =?us-ascii?Q?i8oieS0tPftNF7FInyEaQxOUeK0G+D4J57oVrMN3kzb3NAY8gc7Xfh1gPuJ0?=
 =?us-ascii?Q?ZzaLXhdveuC6CikK/w2ElJ9DUMJ/B3cQP84K8ab2XJ2jTRzZSnH6WLxmdzgA?=
 =?us-ascii?Q?obJDedWPX9ZYs8Y1N8j7JPz+1hl0IW48gZso7jXphg4tDeVPM4mfc6vDNCko?=
 =?us-ascii?Q?j/y0E5ikakzGHrb2bZIQ+f3jhi/T1HImY6VZTD2gETtwAlcMINgv522wOLsW?=
 =?us-ascii?Q?QbAkp5bYzTTU1ix3V97E0nMkzlg1li7XZFL125jeMxX56t38TSjBOw18hZPQ?=
 =?us-ascii?Q?LgvG4x+/suRM3yUWNIumzkQVsTr4zWAsENre+F3C4ZX8NfKqEC6EPkE0NsG6?=
 =?us-ascii?Q?inps0Dzek80rblzMNI0NuNI7pmi4YTDY8XhrFHN7uDgFcqDmSJkwFN+1qxho?=
 =?us-ascii?Q?7wLogGBaL26c2gjdafCjgJJJ6y8p/rCX79KX+OJNNQNmTU55UOaFwAVkNC1Z?=
 =?us-ascii?Q?NTVKCEguHUCb1/joOvuwz/DE1ccHlCvMsT1d/P1cwTifYasyB8C88SvU951S?=
 =?us-ascii?Q?bg5kJG9IfHuZcorX0u+lp4bJWVzIdcihblNpLhQR+hqJYUQZSF+p2d7x0ld0?=
 =?us-ascii?Q?eumZKwQFX1zuUQYAyaaK3c2Apts+sdIh+wXybWMjA8EfUU6vF0XJ4MRu4eeF?=
 =?us-ascii?Q?WrQCKkEo/JMathyRFq7STC/ubWkDmBXT/vBTp2XCHi5MBqOZYSBWfGxstR4p?=
 =?us-ascii?Q?h2LY83hiD9+TJchDuX7wUVBBZIgDSaeVwpL/ZvsXvbGw?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a9e435-8a4f-43ad-672e-08dc03c55df5
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2023 14:42:20.0685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6fezBeLiWIq/Uwc0Iu1SjEnyfqa6GqMeXuQTC1R9843s6ByCCHUSu7dnMM3REg3YiWfB4Wx3MGyWCjnGEEH4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1908

On Wed, 13 Dec 2023 22:08:53 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Add support for generic parameters defaults in `#[pin_data]` by using
> the newly introduced `decl_generics` instead of the `impl_generics`.
> 
> Before this would not compile:
> 
>     #[pin_data]
>     struct Foo<const N: usize = 0> {
>         // ...
>     }
> 
> because it would be expanded to this:
> 
>     struct Foo<const N: usize = 0> {
>         // ...
>     }
> 
>     const _: () = {
>         struct __ThePinData<const N: usize = 0> {
>             __phantom: ::core::marker::PhantomData<fn(Foo<N>) -> Foo<N>>,
>         }
>         impl<const N: usize = 0> ::core::clone::Clone for __ThePinData<N> {
>             fn clone(&self) -> Self {
>                 *self
>             }
>         }
> 
>         // [...] rest of expansion omitted
>     };
> 
> The problem is with the `impl<const N: usize = 0>`, since that is
> invalid Rust syntax. It should not mention the default value at all,
> since default values only make sense on type definitions.
> 
> The new `impl_generics` do not contain the default values, thus
> generating correct Rust code.
> 
> This is used by the next commit that puts `#[pin_data]` on
> `kernel::workqueue::Work`.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> v1 -> v2:
> - clarify the change in the commit message
> - add motivation to the commit message
> 
>  rust/kernel/init/macros.rs | 19 ++++++++++++++++++-
>  rust/macros/pin_data.rs    |  3 ++-
>  2 files changed, 20 insertions(+), 2 deletions(-)

