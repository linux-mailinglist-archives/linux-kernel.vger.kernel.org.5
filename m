Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBEB77C39F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjHNWn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjHNWnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:43:15 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E21FB3;
        Mon, 14 Aug 2023 15:43:14 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d3d729a08e4so4753419276.3;
        Mon, 14 Aug 2023 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692052994; x=1692657794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhP5hF7gsV/m6mRR8ob32YvEhTw2xPeRNUv47TvhXGs=;
        b=jFQc46cJTRErw+hng9tAokPjEOHl5jJIUhAjcuox1Slixjuhcu1DIUGSAs1PWoZrLE
         hiiIqXMEagsfhNWwOLggpXHYZ6rveONq5vpWW53M1urIa+/Iyg0RE3ROaMpkg5MuiRhE
         KhYQEI2TL4wc+ahPZbS0kzDzDC2ICyI9xIvs+1lOJUdVbNLk/LZiiLk+DJso6fdYtvUn
         Iy3FY70rsN2Ed9FCS6u6Ne33Nmz1jCwOk8RhdG6ofReL11UtsNlJAg4QWNxCbl2SG48u
         UIM2vEwhMgRn/KtNrFVtSQeBziX2jH+NF6pQ29w1yBZN55rFi7uneB1kg8fRB83uHJzR
         RNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692052994; x=1692657794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhP5hF7gsV/m6mRR8ob32YvEhTw2xPeRNUv47TvhXGs=;
        b=ACikICOp7GlzR1cGskpXlylShxcz/o0EBG4eckPqk4M9Q7kxR04lluEe5DIbvDu+o6
         yiMNNi6nPDghs7QIIjZwnQVwEeZEoEkHxfzDE7vsf9n6Bwm6RrCwjF75R3tQX9M2ag/0
         QfIjlE3Sju70hnMlmJUhqjL9RX+sK5sa0Hol0GjkORg48jSs0hn/smNK9xiuMfEpfgZ1
         7T+GLzVBKmLq7o9a32W5Er7IEIKjXhEp8esiGoVEWIUyYJKuOcB7Sgew0vxThxY81Y9h
         4uDES/FHg/BmgTOhnM8gmO6n27KIYGMps7NAUbrlrc/DhYIcO2dRbwlCYPR77V9G5ft6
         arZg==
X-Gm-Message-State: AOJu0YwrPN2jstgQDwTk7AlS/YHqChloNvyNcJ4AoRfBAM9FC2YMZxLN
        JLhYi0+L2JOZpKytkr84CLU/7FSOpQkuKO7DS18=
X-Google-Smtp-Source: AGHT+IFpuYEJ/0nuvpgDua6ryUMqdgSSiGqdAodGAyLQ574FbDaMTr2TGX40TqotWWwvWMfuPrxQaWSx7DG1U9ivXLM=
X-Received: by 2002:a05:6902:4cf:b0:d43:e64f:bdcf with SMTP id
 v15-20020a05690204cf00b00d43e64fbdcfmr10448281ybs.0.1692052993673; Mon, 14
 Aug 2023 15:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230612194311.24826-1-aakashsensharma@gmail.com>
In-Reply-To: <20230612194311.24826-1-aakashsensharma@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 15 Aug 2023 00:43:02 +0200
Message-ID: <CANiq72mq34Locyu4EZ7WRmGdTHkSP77sNZt3Xfo0ZWx_bMLMcA@mail.gmail.com>
Subject: Re: [PATCH] rust: bindgen: upgrade to 0.65.1
To:     Aakash Sen Sharma <aakashsensharma@gmail.com>
Cc:     corbet@lwn.net, ojeda@kernel.org, alex.gaynor@gmail.com,
        wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        bjorn3_gh@protonmail.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, masahiroy@kernel.org,
        me@kloenk.de, aliceryhl@google.com, benno.lossin@proton.me,
        dev@niklasmohrin.de, lina@asahilina.net, hca@linux.ibm.com,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 9:45=E2=80=AFPM Aakash Sen Sharma
<aakashsensharma@gmail.com> wrote:
>
> * Rationale:
>
> Upgrades bindgen to code-generation for anonymous unions, structs, and en=
ums [7]
> for LLVM-16 based toolchains.
>
> The following upgrade also incorporates `noreturn` support from bindgen
> allowing us to remove useless `loop` calls which was placed as a
> workaround.
>
> * Truncated build logs on using bindgen `v0.56.0` prior to LLVM-16 toolch=
ain:
>
> ```
> $ make rustdoc LLVM=3D1 CLIPPY=3D1 -j$(nproc)
>   RUSTC L rust/core.o
>   BINDGEN rust/bindings/bindings_generated.rs
>   BINDGEN rust/bindings/bindings_helpers_generated.rs
>   BINDGEN rust/uapi/uapi_generated.rs
> thread 'main' panicked at '"ftrace_branch_data_union_(anonymous_at__/_/in=
clude/linux/compiler_types_h_146_2)" is not a valid Ident', .../proc-macro2=
-1.0.24/src/fallback.rs:693:9
> ...
> thread 'main' panicked at '"ftrace_branch_data_union_(anonymous_at__/_/in=
clude/linux/compiler_types_h_146_2)" is not a valid Ident', .../proc-macro2=
-1.0.24/src/fallback.rs:693:9
> ...
> ```
>
> * LLVM-16 Changes:
>
> API changes [1] were introduced such that libclang would emit names like
> "(unnamed union at compiler_types.h:146:2)" for unnamed unions, structs, =
and
> enums whereas it previously returned an empty string.
>
> * Bindgen Changes:
>
> Bindgen `v0.56.0` on LLVM-16 based toolchains hence was unable to process=
 the
> anonymous union in `include/linux/compiler_types` `struct ftrace_branch_d=
ata`
> and caused subsequent panics as the new `libclang` API emitted name was n=
ot
> being handled. The following issue was fixed in Bindgen `v0.62.0` [2].
>
> Bindgen `v0.58.0` changed the flags `--whitelist-*` and `--blacklist-*`
> to `--allowlist-*` and `--blocklist-*` respectively [3].
>
> Bindgen `v0.61.0` added support for `_Noreturn`, `[[noreturn]]`, `__attri=
bute__((noreturn))` [4],
> hence the empty `loop`s used to circumvent bindgen returning `!` in place=
 of `()`
> for noreturn attributes have been removed completely.
>
> Bindgen `v0.61.0` also changed default functionality to bind `size_t` to =
`usize` [5] and
> added the `--no-size_t-is-usize` [5] flag to not bind `size_t` as `usize`=
.
>
> Bindgen `v0.65.0` removed `--size_t-is-usize` flag [6].
>
> Link: https://github.com/llvm/llvm-project/commit/19e984ef8f49bc3ccced156=
21989fa9703b2cd5b [1]
> Link: https://github.com/rust-lang/rust-bindgen/pull/2319 [2]
> Link: https://github.com/rust-lang/rust-bindgen/pull/1990 [3]
> Link: https://github.com/rust-lang/rust-bindgen/issues/2094 [4]
> Link: https://github.com/rust-lang/rust-bindgen/commit/cc78b6fdb6e829e5fb=
8fa1639f2182cb49333569 [5]
> Link: https://github.com/rust-lang/rust-bindgen/pull/2408 [6]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1013 [7]
> Signed-off-by: Aakash Sen Sharma <aakashsensharma@gmail.com>

Applied to `rust-next`, thanks everyone!

I also did these extra changes:

    [ Reworded commit message. Mentioned the `bindgen-cli` binary crate
      change, linked to it and updated the Quick Start guide. Re-added a
      deleted "as" word in a code comment and reflowed comment to respect
      the maximum length. ]

In particular, I have reworded the commit message a fair bit:

    In LLVM 16, anonymous items may return names like `(unnamed union at ..=
)`
    rather than empty names [1], which breaks Rust-enabled builds because
    bindgen assumed an empty name instead of detecting them via
    `clang_Cursor_isAnonymous` [2]:

        $ make rustdoc LLVM=3D1 CLIPPY=3D1 -j$(nproc)
          RUSTC L rust/core.o
          BINDGEN rust/bindings/bindings_generated.rs
          BINDGEN rust/bindings/bindings_helpers_generated.rs
          BINDGEN rust/uapi/uapi_generated.rs
        thread 'main' panicked at
'"ftrace_branch_data_union_(anonymous_at__/_/include/linux/compiler_types_h=
_146_2)"
is not a valid Ident', .../proc-macro2-1.0.24/src/fallback.rs:693:9
        ...
        thread 'main' panicked at
'"ftrace_branch_data_union_(anonymous_at__/_/include/linux/compiler_types_h=
_146_2)"
is not a valid Ident', .../proc-macro2-1.0.24/src/fallback.rs:693:9
        ...

    This was fixed in bindgen 0.62.0. Therefore, upgrade bindgen to
    a more recent version, 0.65.1, to support LLVM 16.

    Since bindgen 0.58.0 changed the `--{white,black}list-*` flags to
    `--{allow,block}list-*` [3], update them on our side too.

    In addition, bindgen 0.61.0 moved its CLI utility into a binary crate
    called `bindgen-cli` [4]. Thus update the installation command in the
    Quick Start guide.

    Moreover, bindgen 0.61.0 changed the default functionality to bind
    `size_t` to `usize` [5] and added the `--no-size_t-is-usize` flag
    to not bind `size_t` as `usize`. Then bindgen 0.65.0 removed
    the `--size_t-is-usize` flag [6]. Thus stop passing the flag to bindgen=
.

    Finally, bindgen 0.61.0 added support for the `noreturn` attribute (in
    its different forms) [7]. Thus remove the infinite loop in our Rust
    panic handler after calling `BUG()`, since bindgen now correctly
    generates a `BUG()` binding that returns `!` instead of `()`.

    Link: https://github.com/llvm/llvm-project/commit/19e984ef8f49bc3ccced1=
5621989fa9703b2cd5b
[1]
    Link: https://github.com/rust-lang/rust-bindgen/pull/2319 [2]
    Link: https://github.com/rust-lang/rust-bindgen/pull/1990 [3]
    Link: https://github.com/rust-lang/rust-bindgen/pull/2284 [4]
    Link: https://github.com/rust-lang/rust-bindgen/commit/cc78b6fdb6e829e5=
fb8fa1639f2182cb49333569
[5]
    Link: https://github.com/rust-lang/rust-bindgen/pull/2408 [6]
    Link: https://github.com/rust-lang/rust-bindgen/issues/2094 [7]

Aakash: please let me know if that is not OK!

Cheers,
Miguel
