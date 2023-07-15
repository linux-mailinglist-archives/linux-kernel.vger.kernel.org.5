Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F1A754981
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjGOOwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGOOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:52:35 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2098.outbound.protection.outlook.com [40.107.11.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15F72D40;
        Sat, 15 Jul 2023 07:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNvS4zEtyG8zaXI23VmKjTUTl86kuWKrLs1UmHuJn3wfMzOi5CHtTgctmCvLVBdmp1QxVd7ZKAKJwrfHRZaGUf1lerEOTGE8f4Vg1c7AsqQ1l+/2nrZapgKxIeFbL7XtY0IfzKN/f0yXDmZNz9534Lg0U8KNhTA+KWi+fahmY+8M9nxFv50/Ub9wQ9SPziDb4cF7KkuKY3k86nZ0NaMKNtM0gMBgkwLfLLLS0tNpRdoCWtln3ccBCIoh4PI/raZdTbGiIqw1Fl2J88HjKJkdxLZY5Kkw888F1rD4DI3YJF/MzdsjCBhClZeeRRgDNTptIHqkqCzr2H2le31l07HVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPWATc+9D19MzC4IbUaWB1fhVmvN6k2Zas2FyV/Sn2M=;
 b=oWMM4nSwITZUfpgpOYtLAPBWjo1cB36aVtvlOLwjr6OOxJq8CZn3vptA3Z30VjFPDxhXjeh/k5UhcyYvT487Uij5OBktHOxo3Ok5F+b7ttJUJAXODAf6swJQOuIHo50gs6CYDnMW0/Uv5IPC1++QA7ZL7/oX2MAdyCudBllnjR/Ievf1VWRENTwv4iqeFlxjZLa0l8v9bovkLm974ezSVlpJrdVHKLRqpxs+cO8arF8ikwMyzwrIddjNZa1rnfeKtEmEKCvbzpb42fQAEhZXlctrjGod8Htl3rB+kfu9Bje25z6skDW3aa+THyizLmxwRX1B88xic7CyHPel9ZK5uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPWATc+9D19MzC4IbUaWB1fhVmvN6k2Zas2FyV/Sn2M=;
 b=xM+fLaH0dFxbNUR/crDrJvauZKOYkCoMteIMpLmYrHtA0WreXUfkFaIz9N1Ib7cEiiNSvyKCT7WFZ6jw4W3fNUjA5bH584KiAac5WAXc4wkfnZ3UlqoKKB/z1UfBPX6GblFS7YlErATVAnstv+KPDiLhx7alNGy1hU3MCCdS0lM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB7180.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sat, 15 Jul
 2023 14:52:31 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 14:52:31 +0000
Date:   Sat, 15 Jul 2023 15:52:29 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH RFC 04/11] rust: siphash: Add a simple siphash
 abstraction
Message-ID: <20230715155229.6cb338dd.gary@garyguo.net>
In-Reply-To: <20230714-classless_lockdep-v1-4-229b9671ce31@asahilina.net>
References: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
        <20230714-classless_lockdep-v1-4-229b9671ce31@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0079.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::12) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: ac078316-7ac2-438f-111b-08db85431ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rf+NcnqU/xtsXZmbLd6sBiHUNuoMVcSMIZ3jd88obzdn50noNQMA49mjrvhpAo5Q5FbAkKxbuI7HxGJi9sPsuNK9fyMqdCHFAOEVPwdzKwvaYAUdH733C423LUTf7dgCzp2ZN0sV6zlhod2dziLxyTLiOUbKKfTtTUQkWi5NZzJRRNj+Sja02FpSjWQuXqrFX7T4yGthR3mQtB18lNC0ea4ZDKbD+ZZJkHF3xPCDhRpzTUt5og2QeEBPHi4l4H7fUYQjGt6TexeljbeOxyvZELlAkedEgZ4BoV6xW78K9Z9q9pr5BvrvMmwSDc7eg5BOMUhxva3Iyog7ERt3Yb7hZUwSsWtLUJeO+dOxttR9eijBFVyndxVMrMidKY7pg1nT5bflTxOCVa4TJGcVTIke5OujuRkM7V3Xh+c/GUa702bAN7YNG58fY2wNRI2Z36O5tdRxzlUwFx3d6ZmjQYXVwqNsRD+jCKVCO6qeuM2G28hCOWio9Pd/jIVkrcuPwCl38+7WPH/eWirnVv+SuKQE/Nj6sR2aH2VibXL5XbagJQMaXGAlfG1UoUFSCo4nE7Qv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(346002)(376002)(366004)(136003)(451199021)(54906003)(38100700002)(6486002)(478600001)(41300700001)(8676002)(5660300002)(8936002)(66946007)(66556008)(66476007)(6916009)(4326008)(316002)(2616005)(186003)(83380400001)(6512007)(6506007)(1076003)(26005)(86362001)(36756003)(7416002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YSCalzzJpv1RyWdfFhyFcaTtzEm2L3AvLHW8RIhJhs95j9DnQst9CO1kw7/k?=
 =?us-ascii?Q?ZNbzZ0CwX2dCsRInWLc0JAXgxZK3+3Fb49b/I+69M+hhFDMx5ARiBt2WDyDy?=
 =?us-ascii?Q?/NAbCviG0OG0pFwAOeU0gtNSj63VIXiQo7p/li/QEMPTE31kOm+73U2KUn7O?=
 =?us-ascii?Q?1ikIftc2WxHWcOtKfnM46Kl05+xFVhPRF6FFReB+Q/3z8DfswITMH0GkiYPs?=
 =?us-ascii?Q?+FaGAGJ8VDJhqzXs1MF6THI39sf6HwSQfePsITXDT/1Va0gjll2luscUo+H1?=
 =?us-ascii?Q?HSaiZIOhv53LSaxF6Om11MDhxio+GU4pzl/9W8/Twr0rHGXEAEJ3zkL9eRe3?=
 =?us-ascii?Q?I9Rq6///bYT6hfKnLvgR+yjBTk0ye/yvRZz8lzBxeyeCVR++jWzgfDEfeMMe?=
 =?us-ascii?Q?rCaj5tlf8hLzYucokawM77i1RZAcGnz6dIkArolXNVN4ztq9OGGGoUGljXtK?=
 =?us-ascii?Q?0b9lCOiprz0VvThxanR/5zGB7v5MuP4qpsG7ASNlZrwhuTJMEVGmcz2l8efO?=
 =?us-ascii?Q?Cj1VUz8pIDg692cydkM2F6od1mcEeB9oEKof2CzowwWP1mZsubRmSdrbrhzl?=
 =?us-ascii?Q?KgP5oReZafec1PD6evP8VgtYQKFLaPrHmonwHJGit6KSqgll8I7nCH45cVch?=
 =?us-ascii?Q?5ch0ZdLEipPVm4X/ZgXtUB0PeBB40NShPQpoV4d0scewWaScWerRIm2nHNfZ?=
 =?us-ascii?Q?JvJM9j/tpjNyRX05+o7KjmMzLq6FKSzQTghD+DSf5Q2ypK2F9lKLKB5SumXx?=
 =?us-ascii?Q?ajzukKLXaZFJz53TmvrUMsup2ZnNgPpF5DWRQrnxeBRw5uEr9yPpXtv8qfMR?=
 =?us-ascii?Q?MA+VRMUiFoyNKE8MhTkKusQo8K36ppgAjQgLK4DKfs43ICHvETeNNNADJTo8?=
 =?us-ascii?Q?URC23f0fwPXIvH3ftGOr1McaV8jfnnYaV2ArV23p/AJbEQ/CFblewK+6xyAY?=
 =?us-ascii?Q?r2u3f+2g1171GIEvfg2RrxPQK1F62uqCZG97kqz5qjeJc3YeFq7j7Bob3rFB?=
 =?us-ascii?Q?TY/y25apZKvJJsVy1exp/kKVeOq7q4iOULLOOAV1ayVHUwbYk7BQH8/7ccHB?=
 =?us-ascii?Q?Hx/mAOruQG+ZMOOi8bOdRYzSnqVFqV8otCPNH9JwvIWHZvbBesDSFlt9dxFm?=
 =?us-ascii?Q?keCZC53mfQqFqlDP7kmWiGVY3ISlu16R1Ze/IYApRIqd4DV9zXK/l3kJGOrA?=
 =?us-ascii?Q?qIgm1f7U0IWAfsBR8Rfq2yj3Wy3pPeJErLNYkasfRlndvxO7zYAT5wOfKk6a?=
 =?us-ascii?Q?y5OtEvfSpvP3QiCEUX6qOlmZM0q0foYRC+10CoEceK2hRTi1iVqo0IISO/Gl?=
 =?us-ascii?Q?GyLXA0/PgXRXg7t3uElYKycvYuEcNJVS2xzSXwIulY1icR3Q1XmmUW8PaCf4?=
 =?us-ascii?Q?YF1F6NJH/tPiaMk9tGS1TmNfCBTBfAy0EQqbFSPUa5MnMWgSsxLzeBTg/hMF?=
 =?us-ascii?Q?9TDgI2oF7OziVwjZhq4D1NHNOfKVNg3mvNzv4Ws8LvkRVvFZHMYz1Ke9VoCT?=
 =?us-ascii?Q?oHWczmzw9kLkRErHX+7T2RSStrwCn5FL9zOpVa1D8xtUrKJbyexFdB0h2vPp?=
 =?us-ascii?Q?Yghyrjqji8dV1W0caQAG3aJx9IwntL70h11qAc+T?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ac078316-7ac2-438f-111b-08db85431ddf
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 14:52:31.4935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qEYOyXIpBFpdZzeU4yclYKLyCq+6/lj9Rx6I0/MyRkGe8lxxjHzweyCNtbPi7eD4FAN2M9mak6CK8UFxkx5e9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 18:13:56 +0900
Asahi Lina <lina@asahilina.net> wrote:

> This simple wrapper allows Rust code to use the Hasher interface with
> the kernel siphash implementation. No fancy features supported for now,
> just basic bag-of-bytes hashing. No guarantee that hash outputs will
> remain stable in the future either.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers.c                  |  8 ++++++++
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/siphash.rs          | 39 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 49 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 3e601ce2548d..52f32e423b04 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -10,6 +10,7 @@
>  #include <linux/slab.h>
>  #include <linux/refcount.h>
>  #include <linux/wait.h>
> +#include <linux/siphash.h>
>  #include <linux/sched.h>
>  
>  /* `bindgen` gets confused at certain things. */
> diff --git a/rust/helpers.c b/rust/helpers.c
> index bb594da56137..1ed71315d1eb 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -24,6 +24,7 @@
>  #include <linux/errname.h>
>  #include <linux/refcount.h>
>  #include <linux/mutex.h>
> +#include <linux/siphash.h>
>  #include <linux/spinlock.h>
>  #include <linux/sched/signal.h>
>  #include <linux/wait.h>
> @@ -135,6 +136,13 @@ void rust_helper_put_task_struct(struct task_struct *t)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
>  
> +u64 rust_helper_siphash(const void *data, size_t len,
> +			const siphash_key_t *key)
> +{
> +	return siphash(data, len, key);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_siphash);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 85b261209977..8fb39078b85c 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -36,6 +36,7 @@
>  pub mod ioctl;
>  pub mod prelude;
>  pub mod print;
> +pub mod siphash;
>  mod static_assert;
>  #[doc(hidden)]
>  pub mod std_vendor;
> diff --git a/rust/kernel/siphash.rs b/rust/kernel/siphash.rs
> new file mode 100644
> index 000000000000..e13a17cd5a93
> --- /dev/null
> +++ b/rust/kernel/siphash.rs
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A core::hash::Hasher wrapper for the kernel siphash implementation.
> +//!
> +//! This module allows Rust code to use the kernel's siphash implementation
> +//! to hash Rust objects.
> +
> +use core::hash::Hasher;
> +
> +/// A Hasher implementation that uses the kernel siphash implementation.
> +#[derive(Default)]
> +pub struct SipHasher {
> +    // SipHash state is 4xu64, but the Linux implementation
> +    // doesn't expose incremental hashing so let's just chain
> +    // individual SipHash calls for now, which return a u64
> +    // hash.

This is actually quite a big difference, which makes me think that this
hasher probably shouldn't be called `SipHasher`.

Actually, do we need a strong hash? Given that lock dep is only for
debugging purposes, I think we can use fnv, or even just fx hash?
They're all simple enough to be implemented in a couple of lines in
Rust and wouldn't need to call into FFI.

> +    state: u64,
> +}
> +
> +impl SipHasher {
> +    /// Create a new SipHasher with zeroed state.
> +    pub fn new() -> Self {
> +        SipHasher { state: 0 }
> +    }
> +}
> +
> +impl Hasher for SipHasher {
> +    fn finish(&self) -> u64 {
> +        self.state
> +    }
> +
> +    fn write(&mut self, bytes: &[u8]) {
> +        let key = bindings::siphash_key_t {
> +            key: [self.state, 0],
> +        };
> +
> +        self.state = unsafe { bindings::siphash(bytes.as_ptr() as *const _, bytes.len(), &key) };
> +    }
> +}
> 

