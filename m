Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FAF7D0B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376619AbjJTJSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376586AbjJTJSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:18:01 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB494D51
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:17:57 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso8406011fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1697793476; x=1698398276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewr0VgrpxOh4pcI8VnPDwCTgEV+obWfuNKFRv3Q2C3w=;
        b=g2i/QZnzfAW5tnfDVv4EiB40ltuilP0yBTBkRK+zDJeUC404BaUCRMxATKu6nw06h/
         jy3PSCMkGopwCabmwsjb7CKfz30fdgu23TxR9+pqW/Efixigzdr5pwIQzV8M0ZUYuNdK
         ypgLTUivscCylQWYOoIz2kEPnSQQolBHmEVz4vjVLCpBvzxH5yuQetwVZKBinVq23xZq
         BAG/z8S6uQ7RUPTz6JrOL1v1Zr1t6/55yp5aF2/E/0tY1PryfVpcZva50PIsuBjXHPpB
         jzeEFBdy0v9s4FF3TAkkgqZFbmiyUKlR/Q02IPRnLrhrG22zVYvLABO67d+ICM2sgP+T
         gDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697793476; x=1698398276;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ewr0VgrpxOh4pcI8VnPDwCTgEV+obWfuNKFRv3Q2C3w=;
        b=i1bRhUorBB7ydWA8rAV+4MvhLFMfykYVNRNSP0VCMxhftZDiDCKodlzycTV903JLCt
         sOFpgyrJapCgWdRf2GQVowTGV6ASryF+qvw+EKtrsiFM+PbxkzauwM5At2XnlqxoRpIF
         Tt0hDN/0E91o7bD6DKFdxcAW58Z4ASGavUsOjB9f/OH5XuLAOr+mAFa5WF7ZG9kU0bDK
         mWAZVYzBTFoJEMu6H1Hs1d7nCzVRUfCl2mS+go9LHqRZ2gCTupZA5o580i/EBqVkp3VI
         thzz+EGaZYmnl6m9q6sDGvc5Z6emNIFRV0+l31MFui7SkNMQUTouM/2YAWXSEvotudVo
         0EHw==
X-Gm-Message-State: AOJu0YxGrqKgbYK+Icja9+KJCxjd4awAtETXMZA5bcDyh7rkIJUCoB7k
        L6Bd1zTGPCJexCe62S9oDoSVJQ==
X-Google-Smtp-Source: AGHT+IE5IamQ1cJ1ao670l0NPAbOnWUtWHjpk8jFWkpNVke+n8eofIlzbwZbsT3ZRweX7oG5ER6MLQ==
X-Received: by 2002:a2e:9904:0:b0:2c5:a6e:4bcc with SMTP id v4-20020a2e9904000000b002c50a6e4bccmr983274lji.39.1697793476049;
        Fri, 20 Oct 2023 02:17:56 -0700 (PDT)
Received: from localhost ([165.225.194.196])
        by smtp.gmail.com with ESMTPSA id w15-20020a5d608f000000b0032dbf32bd56sm1257799wrt.37.2023.10.20.02.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:17:55 -0700 (PDT)
References: <20231019171540.259173-1-benno.lossin@proton.me>
User-agent: mu4e 1.10.7; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: macros: improve `#[vtable]` documentation
Date:   Fri, 20 Oct 2023 11:06:46 +0200
In-reply-to: <20231019171540.259173-1-benno.lossin@proton.me>
Message-ID: <87fs25irel.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Benno Lossin <benno.lossin@proton.me> writes:

> Traits marked with `#[vtable]` need to provide default implementations
> for optional functions. The C side represents these with `NULL` in the
> vtable, so the default functions are never actually called. We do not
> want to replicate the default behavior from C in Rust, because that is
> not maintainable. Therefore we should use `build_error` in those default
> implementations. The error message for that is provided at
> `kernel::error::VTABLE_DEFAULT_ERROR`.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> v1 -> v2:
> - removed imperative mode in the paragraph describing optional
>   functions.
>
>  rust/kernel/error.rs |  4 ++++
>  rust/macros/lib.rs   | 32 ++++++++++++++++++++++++--------
>  2 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 05fcab6abfe6..1373cde025ef 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -335,3 +335,7 @@ pub(crate) fn from_result<T, F>(f: F) -> T
>          Err(e) =3D> T::from(e.to_errno() as i16),
>      }
>  }
> +
> +/// Error message for calling a default function of a [`#[vtable]`](macr=
os::vtable) trait.
> +pub const VTABLE_DEFAULT_ERROR: &str =3D
> +    "This function must not be called, see the #[vtable] documentation.";
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index c42105c2ff96..daf1ef8baa62 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -87,27 +87,41 @@ pub fn module(ts: TokenStream) -> TokenStream {
>  /// implementation could just return `Error::EINVAL`); Linux typically u=
se C
>  /// `NULL` pointers to represent these functions.
>  ///
> -/// This attribute is intended to close the gap. Traits can be declared =
and
> -/// implemented with the `#[vtable]` attribute, and a `HAS_*` associated=
 constant
> -/// will be generated for each method in the trait, indicating if the im=
plementor
> -/// has overridden a method.
> +/// This attribute closes that gap. A trait can be annotated with the `#=
[vtable]` attribute.
> +/// Implementers of the trait will then also have to annotate the trait =
with `#[vtable]`. This
> +/// attribute generates a `HAS_*` associated constant bool for each meth=
od in the trait that is set
> +/// to true if the implementer has overridden the associated method.
> +///
> +/// For a function to be optional, it must have a default implementation=
. But this default
> +/// implementation will never be executed, since these functions are exc=
lusively called from
> +/// callbacks from the C side. This is because the vtable will have a `N=
ULL` entry and the C side
> +/// will execute the default behavior. Since it is not maintainable to r=
eplicate the default
> +/// behavior in Rust, the default implementation should be:

How about this?:

For a Rust trait method to be optional, it must have a default
implementation. For a trait marked with `#[vtable]`, the default
implementation will not be executed, as the only way the trait methods
should be called is through function pointers installed in C side
vtables. When a trait implementation marked with `#[vtable]` is missing
a method, a `NULL` pointer will be installed in the corresponding C side
vtable, and thus the Rust default implementation can not be called. The
default implementation should be:

Not sure if it is more clear =F0=9F=A4=B7

> +///
> +/// ```compile_fail
> +/// # use kernel::error::VTABLE_DEFAULT_ERROR;
> +/// kernel::build_error(VTABLE_DEFAULT_ERROR)
> +/// ```
> +///
> +/// note that you might need to import [`kernel::error::VTABLE_DEFAULT_E=
RROR`].
>  ///
> -/// This attribute is not needed if all methods are required.
> +/// This macro should not be used when all function are required.
>  ///
>  /// # Examples
>  ///
>  /// ```ignore
> +/// # use kernel::error::VTABLE_DEFAULT_ERROR;
>  /// use kernel::prelude::*;
>  ///
>  /// // Declares a `#[vtable]` trait
>  /// #[vtable]
> -/// pub trait Operations: Send + Sync + Sized {
> +/// pub trait Operations {
>  ///     fn foo(&self) -> Result<()> {
> -///         Err(EINVAL)
> +///         kernel::build_error(VTABLE_DEFAULT_ERROR)
>  ///     }
>  ///
>  ///     fn bar(&self) -> Result<()> {
> -///         Err(EINVAL)
> +///         kernel::build_error(VTABLE_DEFAULT_ERROR)
>  ///     }
>  /// }
>  ///
> @@ -125,6 +139,8 @@ pub fn module(ts: TokenStream) -> TokenStream {
>  /// assert_eq!(<Foo as Operations>::HAS_FOO, true);
>  /// assert_eq!(<Foo as Operations>::HAS_BAR, false);
>  /// ```
> +///
> +/// [`kernel::error::VTABLE_DEFAULT_ERROR`]: ../kernel/error/constant.VT=
ABLE_DEFAULT_ERROR.html
>  #[proc_macro_attribute]
>  pub fn vtable(attr: TokenStream, ts: TokenStream) -> TokenStream {
>      vtable::vtable(attr, ts)
>
> base-commit: a7135d10754760f0c038497b44c2c2f2b0fb5651

