Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918EE7C6FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379004AbjJLNsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347289AbjJLNsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:48:38 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D537BA;
        Thu, 12 Oct 2023 06:48:36 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so458078276.3;
        Thu, 12 Oct 2023 06:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697118515; x=1697723315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jbsW+VEW2ckEOL33neXtq1kKRPj1Kbmo2QFoSTgB9hs=;
        b=aB5ZrvpMSLrsmFWEv/z+RnlfOLEUuHjtO94fLazqlZdv3vK6zH72Qwj6mUDf0xe2A/
         i0DrsYCRDeu0HJuQxq74/yxfDLf1GLOBkgAIRC5xcY8ySQLUz0E2nD+UNLyqoJ+9ajnB
         0fnAlMyOGvAeQzRei1lU8KnI3a7HZz1aNsVPdS8TEZ351OgOK0ScGf9TLzUPKX/ocAWX
         XffEkOMPhwwvXlzmEQJRDXGtSN9D6YR4zXH+WU/UZM9eLaJpjZc2StuhUF3uCRt56lcF
         +nXIATStpfy8f4B9aa+rUn6QXy6yGDkEqqKiyFs89NzGNcQrwlPegLIYQVBK7whyp3+f
         ObFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118515; x=1697723315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbsW+VEW2ckEOL33neXtq1kKRPj1Kbmo2QFoSTgB9hs=;
        b=cBdqovYQdQCcnF3YTIIKZcX+LFVofYf23P7/U1pCTjDFIyKesihSZEBHojl+VQUitN
         0djE7CzgvPyqde+JGmynqblkbT/3ZuJkLVfGW2LkDcqfSeO+WvUI246T5EoX++beLMDS
         yXoe02CV6ndjL4bem7ma+XiCnApDqoWp6E6Ltf/iUyAKrKO07tnmV/W5qVA/tquHXszE
         sgSZkt+yPZaR1T93Bjex+O/uU94aaURcX2bcMDI7KkXLYOTbAsyirWwR4FmFc4uJVtUi
         WIeLjTun6a4PCLuHvFl8eM1VoUgZGQgtbgx7f9US5t8oKCMvh+789fkDRvZxzKl5VUIr
         QkiA==
X-Gm-Message-State: AOJu0YyIHde2pYz+2IqMqy0gJbqUpkDbbPwCkNUq9LgjE+5CaWkJzidY
        5MydGeYOA4+RwIyzr27/7tOj8W63CIrha/zt+Rw=
X-Google-Smtp-Source: AGHT+IGT9O6yt5I0HCgZ4UVY5AlZSC/Ooh2p/JnY9MYIUX41pkLuypQ3Afi59+crNdF/jTI1GV6zDKwXYR8CZwhYWW4=
X-Received: by 2002:a5b:c3:0:b0:d62:6514:45b7 with SMTP id d3-20020a5b00c3000000b00d62651445b7mr22289127ybp.37.1697118515444;
 Thu, 12 Oct 2023 06:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231012132131.300014-1-benno.lossin@proton.me>
In-Reply-To: <20231012132131.300014-1-benno.lossin@proton.me>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Thu, 12 Oct 2023 10:48:24 -0300
Message-ID: <CANeycqqMsqHU1cUSSQh+W9435zjA+XZ=K3Yxi6mNn_d4yZOazg@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: improve `#[vtable]` documentation
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 at 10:22, Benno Lossin <benno.lossin@proton.me> wrote:
>
> Traits marked with `#[vtable]` need to provide default implementations
> for optional functions. The C side represents these with `NULL` in the
> vtable, so the default functions are never actually called. We do not
> want to replicate the default behavior from C in Rust, because that is
> not maintainable. Therefore we should use `build_error` in those default
> implementations. The error message for that is provided at
> `kernel::error::VTABLE_DEFAULT_ERROR`.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-By: Wedson Almeida Filho <walmeida@microsoft.com>

> ---
>  rust/kernel/error.rs |  4 ++++
>  rust/macros/lib.rs   | 32 ++++++++++++++++++++++++--------
>  2 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 05fcab6abfe6..1373cde025ef 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -335,3 +335,7 @@ pub(crate) fn from_result<T, F>(f: F) -> T
>          Err(e) => T::from(e.to_errno() as i16),
>      }
>  }
> +
> +/// Error message for calling a default function of a [`#[vtable]`](macros::vtable) trait.
> +pub const VTABLE_DEFAULT_ERROR: &str =
> +    "This function must not be called, see the #[vtable] documentation.";
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index c42105c2ff96..dab9a1080b82 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -87,27 +87,41 @@ pub fn module(ts: TokenStream) -> TokenStream {
>  /// implementation could just return `Error::EINVAL`); Linux typically use C
>  /// `NULL` pointers to represent these functions.
>  ///
> -/// This attribute is intended to close the gap. Traits can be declared and
> -/// implemented with the `#[vtable]` attribute, and a `HAS_*` associated constant
> -/// will be generated for each method in the trait, indicating if the implementor
> -/// has overridden a method.
> +/// This attribute closes that gap. A trait can be annotated with the `#[vtable]` attribute.
> +/// Implementers of the trait will then also have to annotate the trait with `#[vtable]`. This
> +/// attribute generates a `HAS_*` associated constant bool for each method in the trait that is set
> +/// to true if the implementer has overridden the associated method.
> +///
> +/// If you want to make a function optional, you must provide a default implementation. But this

We should  standardise how we write our documentation. In the `rust`
branch, we avoided using the imperative mood like you have here; the
rationale was that the documentation was describing how things
are/work, so we shouldn't be giving orders to readers (they may be
authors of traits, implementers of some vtable trait, or neither, just
someone learning about things, etc.).

In the paragraph above, you'll find an example: "Implementers of the
trait will then also have to...".

For the specific case above, I'd suggest: 'For a function to be
optional, it must have a default implementation.', or using the
passive voice, 'To make a function optional, a default implementation
must be provided'.

> +/// default implementation will never be executed, since these functions are exclusively called
> +/// from callbacks from the C side. This is because the vtable will have a `NULL` entry and the C
> +/// side will execute the default behavior. Since it is not maintainable to replicate the default
> +/// behavior in Rust, you should use the following code:
> +///
> +/// ```compile_fail
> +/// # use kernel::error::VTABLE_DEFAULT_ERROR;
> +/// kernel::build_error(VTABLE_DEFAULT_ERROR)
> +/// ```
> +///
> +/// note that you might need to import [`kernel::error::VTABLE_DEFAULT_ERROR`].
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
> +/// [`kernel::error::VTABLE_DEFAULT_ERROR`]: ../kernel/error/constant.VTABLE_DEFAULT_ERROR.html
>  #[proc_macro_attribute]
>  pub fn vtable(attr: TokenStream, ts: TokenStream) -> TokenStream {
>      vtable::vtable(attr, ts)
>
> base-commit: b2516f7af9d238ebc391bdbdae01ac9528f1109e
> --
> 2.41.0
>
>
