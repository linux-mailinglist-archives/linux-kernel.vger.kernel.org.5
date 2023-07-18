Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2A375826A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjGRQsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjGRQsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:48:12 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABB010CB;
        Tue, 18 Jul 2023 09:48:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99313a34b2dso719702566b.1;
        Tue, 18 Jul 2023 09:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689698890; x=1692290890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxgES3BpLxLkuAQSfF376O2dgB3POpxIXa9v11XKlt8=;
        b=GSB/0slICBQXXeMd+NGpsRB5c+0ByDReXKw+orYgYQq2RJdstoprKFbPLEkKciBdsp
         rmEC282mW/pYkBzlUIIDtgNGg0F9kWgx4I+YNpijp55k4iIAt1eZKIsocpYsPxqg1fyh
         Q3R/w7Ldp09ABfQD3kKSAmvKS4aXXpru4Y7lzQWl23X0Lo0rA1h7fSLxlpcb7jwHCCSD
         Brv9LoM+swz+Q5OYqvmI6zwffricGmOIAu69PNSRun4FR0++xLrOCmoXORzQkmzenIjR
         tNQj7yE0ewDp9mPOCOP3wmnbxNdryAMHuiHvOYh6gsTa4t8CZ/gZUb9d1X32s+9XX4I4
         JjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689698890; x=1692290890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxgES3BpLxLkuAQSfF376O2dgB3POpxIXa9v11XKlt8=;
        b=IYRrtG7BBj24mVdlQLut4TqyprVTogp6VkCzKmiCbrBBNXAEA6jK+exj4ftV7phJXW
         sPIsy+R/a43R0ImAtNKp4xp6mqcq+Wx2GCXWYvgJ0/KtVEMb0l7xJlCn1m0EvjUXFQWK
         55IBbszleZIhjQBhbv2zSAZ9yrSA8opCxzEN6feGOnNKI05ysfY2grSxB7zFUJLd4Z/6
         q7QRXit2dc9IxkR0+VkmViVdHQ5cM//w7GIkgl60sa9w7eyfUz0U2S55Mc1L5DK94Ny0
         OO4CNaZ4iTHS2aznwSoxgaBuvpm1h7VDRePTh3wxA/5Q3tj8bmSdla12OMwbVkb/hy19
         7niQ==
X-Gm-Message-State: ABy/qLZR0RB8SrK8Rv5dm8anRx/xeIt76i9nMqy3LM/nK0TOfln7vARo
        wcJkjF/fM30/MKKIfwNQRUQ=
X-Google-Smtp-Source: APBJJlHVfpT7oRxHjFxKYYht0qM12l1bj5Q1nOdH5tkOxNUCra5xKYA87e6QCCsNRylAXwWgakq7zQ==
X-Received: by 2002:a17:906:fe4a:b0:982:cfe2:32fe with SMTP id wz10-20020a170906fe4a00b00982cfe232femr443653ejb.63.1689698889889;
        Tue, 18 Jul 2023 09:48:09 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id bn14-20020a170906c0ce00b009925cbafeaasm1228257ejb.100.2023.07.18.09.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 09:48:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id ADB8D27C0054;
        Tue, 18 Jul 2023 12:48:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 18 Jul 2023 12:48:06 -0400
X-ME-Sender: <xms:RcK2ZEQB5oiRym1RKTc6LFHCm7v0Gxlt_FbRdocm5iPe2wZ6qf-gUw>
    <xme:RcK2ZBy-t1kWHjOtlpaCfJipx_3zXKlcA9TBrRN24IagcFHfwa7oz8l8HnZw42uMP
    HpnHhAbOBeU68CweQ>
X-ME-Received: <xmr:RcK2ZB1yOcnDJFoirqM9KE377ZmM7BHe31H-ZaI_LY-YvJhqzWj3QrFHR8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:RcK2ZIAQm-dJWH5olI7z0f3vA6BqIffn9i86VDFjCNl8lT230ty2UA>
    <xmx:RcK2ZNjKHGBgrDcIimePN4BiPJXhkD3afhI2WhPJNli2kJUKhGpnag>
    <xmx:RcK2ZEoKh5oX7uSvujEEOzPxajdj7w0wOfW-QQuiR1ZyXp4x2ZrDfQ>
    <xmx:RsK2ZOYF2dFP5IZWCzcCuYhAvbbkpgh5-ICuEizrWA4RnTa5TF1EaQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jul 2023 12:48:04 -0400 (EDT)
Date:   Tue, 18 Jul 2023 09:48:01 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Gary Guo <gary@garyguo.net>
Cc:     Alice Ryhl <aliceryhl@google.com>, lina@asahilina.net,
        alex.gaynor@gmail.com, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com, daniel@ffwll.ch,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, marcan@marcan.st, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        sven@svenpeter.dev, trix@redhat.com, wedsonaf@gmail.com
Subject: Re: [PATCH RFC 00/11] rust: Implicit lock class creation & Arc
 Lockdep integration
Message-ID: <ZLbCQX4uS5kk8U1q@boqun-archlinux>
References: <f974e5a4-1211-5ad7-4864-f3e210499e5e@asahilina.net>
 <20230714135926.382695-1-aliceryhl@google.com>
 <20230715152554.5b585d22.gary@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715152554.5b585d22.gary@garyguo.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 03:25:54PM +0100, Gary Guo wrote:
[...]
> > > I don't think the fallibility is an issue. Lockdep is a debugging tool, 
> > > and it doesn't have to handle all possible circumstances perfectly. If 
> > > you are debugging normal lock issues you probably shouldn't be running 
> > > out of RAM, and if you are debugging OOM situations the lock keys would 
> > > normally have been created long before you reach an OOM situation, since 
> > > they would be created the first time a relevant lock class is used. More 
> > > objects of the same class don't cause any more allocations. And the code 
> > > has a fallback for the OOM case, where it just uses the Location object 
> > > as a static lock class. That's not ideal and degrades the quality of the 
> > > lockdep results, but it shouldn't completely break anything.  
> > 
> > If you have a fallback when the allocation fails, that helps ...
> 
> I am pretty sure lockdep needs to do some internal allocation anyway
> because only address matters for lock class keys. So some extra
> allocation probably is fine...
> 

Lockdep uses a few static arrays for its own allocation, but doesn't use
"external" allocatin (i.e. kalloc() and its friends. IIUC, originally
this has to do in this way to avoid recursive calls like:
lockdep->slab->lockdep, but now lockdep has a recursion counter, that's
not a problem any more. However, it's still better that lockdep can work
on its own without relying on other components.

Regards,
Boqun
