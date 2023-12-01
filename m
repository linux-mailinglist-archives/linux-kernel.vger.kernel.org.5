Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594D5800137
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjLABsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjLABsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:48:05 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A79A10FF;
        Thu, 30 Nov 2023 17:48:11 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-67a92e8ff1dso4033296d6.1;
        Thu, 30 Nov 2023 17:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701395290; x=1702000090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Jy3SbvpkTZLCuL4B9TlWmAJlDf++gUgXWUkUNiA6pU=;
        b=IVFKoMPXuzd0puZQpxtbN01Xg1OfzzU0zEoLzm29QnsO33wEM2jiZH73GC7u4lMPPQ
         rInuZL352qBxEvXTvkibCflOnhQKPN7EhhPqfpf7ShUgTbmzSEYSFVErR9cap56cpz1Z
         LFCxYEVVUty1cXt+ii3ZRKOCHcaSz4NGpjkrfnTTU9vHcrzFPWRmXy5ctTanCbU0af4z
         7SLx5ZzrOU5TD9YwPfefXKrEn00AB9Rnq7xo8pzMw9e9U2NNtHLbu+/R5EyEOhEIoznV
         No7EfRkdwd/bGJv+auKyasoJpqlo7slQcZPeWA4FgzoyyiWe8mIm/5GtGGmHmxI7saev
         3DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701395290; x=1702000090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Jy3SbvpkTZLCuL4B9TlWmAJlDf++gUgXWUkUNiA6pU=;
        b=BdG903suuubHBN8RNvOfVdgzt7U9E3Eroc4TTfk6JOVlk9vvdJtnETiSJ5xwh6pydx
         62nQw7patkpRNKUCCXH+CQoBJLBKS8d7uDIcxTo2GzaHwCn4P8vehG0DRHUSkB9yqKaf
         b0AFJoNLbc2kJ2+LB0oNnkAtHfqWmgpsTtETGizKOggQ36szZ2bs2FagkVJ90lkjDo7H
         daYx8uALAcZ98R4eh8u0PI6anojadc7ibDLCB65Rrdq/T2yLvrdFEFWZOlC0tsGgkj06
         ekHiRXqeGbOn/YznNMLO91A9HcN6QclMBgIGB35+qFd3rP+UbyDpCitc9BNa+B/+GWi2
         pQ+Q==
X-Gm-Message-State: AOJu0YyQF3nn6zkK0aSNlObljIyHCeyT1tYbxhiR0DZ9+Y2iJB3l8oS4
        AcJ+6c60/WWbJwpJ2aTqWDk=
X-Google-Smtp-Source: AGHT+IE8rfKZX+MV37Eqjb3CjDKvBkbb31/WuJREPHacWFrVG0YagHLwx81BM3uGnsp46rHwBSWxbg==
X-Received: by 2002:ad4:4ea3:0:b0:67a:2b26:392c with SMTP id ed3-20020ad44ea3000000b0067a2b26392cmr31102186qvb.30.1701395290433;
        Thu, 30 Nov 2023 17:48:10 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id i1-20020a0cf101000000b0067a4a6db71bsm1015030qvl.88.2023.11.30.17.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 17:48:09 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4433D27C0054;
        Thu, 30 Nov 2023 20:48:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 30 Nov 2023 20:48:09 -0500
X-ME-Sender: <xms:VztpZRRc_MmS8nBWH_saoO6ucXUNKaNLe5afz6qHjKsQfBMm5_O5Ng>
    <xme:VztpZaxIkz1Sr7N6Isxi6kExHrUzEOv-QEXqlE8euU9qhk7vPTeGGREpkD9QxTDLB
    VruERAQPa6Dw2_g7g>
X-ME-Received: <xmr:VztpZW3R8Kj50M3fvWZ2pFmaAaMd09qAHhojoj-HQqrsqPr30xs-PqlU_PY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeikedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:WDtpZZCFECYIP1JjCTRmaQLryzYPFO31nMCuPVs9c_bfpziqN0TSyQ>
    <xmx:WDtpZagCDErKmBT9pK2Efhw5c7wQ3FOSFwIKWvedtXQ9Y_0cMrwHbw>
    <xmx:WDtpZdqtRvWi_XCCgHgDpucjAlX3Z7ii02Waf_c3aZxURtf12rZ8_A>
    <xmx:WTtpZTYpyHFDCRVwv5z03IS38nLincazxP-FknGUjfLhpzkCS3w2ZQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 20:48:07 -0500 (EST)
Date:   Thu, 30 Nov 2023 17:47:18 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Jamie.Cunliffe@arm.com, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>, will@kernel.org,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] rust: Suppress searching builtin sysroot
Message-ID: <ZWk7JuvsyYGoDEDL@boqun-archlinux>
References: <20231031201752.1189213-1-mmaurer@google.com>
 <ZWZYQbxWmLdwAska@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWZYQbxWmLdwAska@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 01:14:41PM -0800, Boqun Feng wrote:
> [Cc Catalin as well]
> 
> On Tue, Oct 31, 2023 at 08:10:14PM +0000, Matthew Maurer wrote:
> > By default, if Rust is passed `--target=foo` rather than a target.json
> > file, it will infer a default sysroot if that component is installed. As
> > the proposed aarch64 support uses `aarch64-unknown-none` rather than a
> > target.json file, this is needed to prevent rustc from being confused
> > between the custom kernel sysroot and the pre-installed one.
> > 
> > Signed-off-by: Matthew Maurer <mmaurer@google.com>
> > ---
> > 
> > This patch is prompted by the issue I encountered at
> > https://lore.kernel.org/all/CAGSQo01pOixiPXkW867h4vPUaAjtKtHGKhkV-rpifJvKxAf4Ww@mail.gmail.com/
> > but should be generically more hermetic even if we don't end up landing
> > that patch.
> > 
> 
> I'm able to reproduce the issue you mentioned here after
> `rustup target add aarch64-unknown-none`, and your patch fixed that.
> 
> Tested-by: Boqun Feng <boqun.feng@gmail.com>
> 

Looks like I spoke too soon... we need another fix onto this:

diff --git a/rust/Makefile b/rust/Makefile
index eda32ff757b1..c573d8881686 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -178,6 +178,7 @@ quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
                --extern build_error --extern macros \
                --extern bindings --extern uapi \
                --no-run --crate-name kernel -Zunstable-options \
+               --sysroot=/dev/null \
                --test-builder $(objtree)/scripts/rustdoc_test_builder \
                $< $(rustdoc_test_kernel_quiet); \
        $(objtree)/scripts/rustdoc_test_gen

, this is for kernel doc test as kunit test.

Needless to say, I also have tested with that and confirm it fixes the
issue.

Regards,
Boqun

> Regards,
> Boqun
> 
> >  rust/Makefile          | 1 +
> >  scripts/Makefile.build | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/rust/Makefile b/rust/Makefile
> > index a27f35f924ec..0403e88e19fd 100644
> > --- a/rust/Makefile
> > +++ b/rust/Makefile
> > @@ -400,6 +400,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
> >  		--emit=metadata=$(dir $@)$(patsubst %.o,lib%.rmeta,$(notdir $@)) \
> >  		--crate-type rlib -L$(objtree)/$(obj) \
> >  		--crate-name $(patsubst %.o,%,$(notdir $@)) $< \
> > +		--sysroot=/dev/null \
> >  	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@)
> >  
> >  rust-analyzer:
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 82e3fb19fdaf..6e4ee513cc3c 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -275,6 +275,7 @@ rust_common_cmd = \
> >  	--extern alloc --extern kernel \
> >  	--crate-type rlib -L $(objtree)/rust/ \
> >  	--crate-name $(basename $(notdir $@)) \
> > +	--sysroot=/dev/null \
> >  	--out-dir $(dir $@) --emit=dep-info=$(depfile)
> >  
> >  # `--emit=obj`, `--emit=asm` and `--emit=llvm-ir` imply a single codegen unit
> > -- 
> > 2.42.0.820.g83a721a137-goog
> > 
