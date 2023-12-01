Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B117E8006AF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377994AbjLAJTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbjLAJTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:19:14 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4BE1713;
        Fri,  1 Dec 2023 01:19:19 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-4b29d7e3a37so613933e0c.0;
        Fri, 01 Dec 2023 01:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701422359; x=1702027159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1s6ku9jxSTJIcLU4eEo9sIfanosqAVFmhUz2VWVY2U=;
        b=gRS1Af3SvbygZE8Lp7szptVdlEDTF/7VW2b0uU38BNjEbi2pvVoDqxWCx3TuMV7VIE
         qWUUyL26fj8nkBfrMVSduSC3LCNcQePOspptgyPhH88dhdf3OLkOmPRSePu9htDAMJrY
         ++DVDauIMCiQemJJiJImnWmf3JL/Lmlz5st1RLNayOLDpOg2kS6O7UkFDbbj0ZzgUgaX
         7Hsm4sPtIuEv+F+HLunpOHUP1lfYuF7zIphsTu4q2xD0qlbaP+ybHBgr5X36792aEn6P
         HwIbSKcRlrb0NGg5iA0CIWFCKYvlefa1zoRyZjNC3LhePDyJCsiki2jrYei2W0cGpKuh
         qtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701422359; x=1702027159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1s6ku9jxSTJIcLU4eEo9sIfanosqAVFmhUz2VWVY2U=;
        b=JW7oL70ymO+3p7lXLjWRiWNyou9UldiPKAri+Wyza5hoTp8K8TLkGXGjOYs9tqWFez
         i7HG7/K57/frFi8CVcj0lcUOBp70Yn3gtfDS4Me1JCWJrGl+Jrt39DcKysGjltFpBU9m
         5Qa1t0dlvuPHG/3vzx2vQXiz1nFZr9MareX9eQbqMvfaVljroXGbNZc55tWHtEAQtlRt
         c1+20YaIcfF2OaXzPCwzg4gX180d4AA+Iq/pbqhdxREXGFH18Ciaypt7Y60t2lbvF/+u
         ogjkLaEYE5rTuolyiV26I0+IRR72gv2fTf9OCLVbWZ3equcCcqYFi8lOEK9I9235j9e6
         BbDg==
X-Gm-Message-State: AOJu0YxAKCXByST0Us7PBHV62uKQBEssPOqfWL5xqU2BjJzbwPEfh80C
        vnP09ToX1S6bGFCFKHC7o24=
X-Google-Smtp-Source: AGHT+IG3LSJ1DCsXNb0LC0NGqh4r7KjJmMKJql5UGVOjZr7aD6BsJX6RajBGyqUoRbd67DD1G6yIuQ==
X-Received: by 2002:a1f:f8cf:0:b0:4b2:777a:a860 with SMTP id w198-20020a1ff8cf000000b004b2777aa860mr11699340vkh.13.1701422358882;
        Fri, 01 Dec 2023 01:19:18 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i15-20020a0cf38f000000b0067a4059068dsm1299513qvk.139.2023.12.01.01.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:19:18 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9811527C005B;
        Fri,  1 Dec 2023 04:19:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 01 Dec 2023 04:19:17 -0500
X-ME-Sender: <xms:FKVpZSruAz3wCkAJGgGsEnuix9VDARrLVUG2gD87AqzOLk9TEDZKlQ>
    <xme:FKVpZQpAVMUQmlDTbQCDfRZcosrkXCK-qmx0T-eQCexAsoXw2p7QoOwfMNBa6DihT
    qiAjtbUWcOMCjh9rQ>
X-ME-Received: <xmr:FKVpZXOYAGMau57obswY-IU_R3EBtIj4igueT1pDba2L6bKzIUYHiKiMpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeelueeiffdugeeliedvjeethfettdeiffffueeiffelhfejgefghedtjedv
    ffffhfenucffohhmrghinhepghhithhhuhgsrdgtohhmpddttddttddqihhnlhhinhgvqd
    grshhmrdhmugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvge
    ehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhm
    sehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:FKVpZR6nHzkRQnplmHAZ2rB1zDeZ6O7oKEUINQLqNmdcecXjEX4iFg>
    <xmx:FKVpZR7gihJNYFl8WCaTU2YfEHR3JXjpdHwHVdYu-r8c21H5ScsYpQ>
    <xmx:FKVpZRj9CstpHzbdmyYqv7p9ZclW1aNo8kG2oAGINOuR8La5aHwvGA>
    <xmx:FaVpZdOqsurV2g3DL_yvGUFgUNfsFc4INr-ZMDnd8VsQEoseXuSs1Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 04:19:16 -0500 (EST)
Date:   Fri, 1 Dec 2023 01:19:14 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <ZWmlEiiPXAIOYsM1@Boquns-Mac-mini.home>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
 <ZWdVEk4QjbpTfnbn@casper.infradead.org>
 <20231129152305.GB23596@noisy.programming.kicks-ass.net>
 <ZWdv_jsaDFJxZk7G@Boquns-Mac-mini.home>
 <20231130104226.GB20191@noisy.programming.kicks-ass.net>
 <ZWipTZysC2YL7qsq@Boquns-Mac-mini.home>
 <20231201085328.GE3818@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201085328.GE3818@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 09:53:28AM +0100, Peter Zijlstra wrote:
> On Thu, Nov 30, 2023 at 07:25:01AM -0800, Boqun Feng wrote:
> > On Thu, Nov 30, 2023 at 11:42:26AM +0100, Peter Zijlstra wrote:
> > > On Wed, Nov 29, 2023 at 09:08:14AM -0800, Boqun Feng wrote:
> > > 
> > > > But but but, I then realized we have asm goto in C but Rust doesn't
> > > > support them, and I haven't thought through how hard tht would be..
> > > 
> > > You're kidding right?
> > > 
> > 
> > I'm not, but I've found this:
> > 
> > 	https://github.com/Amanieu/rfcs/blob/inline-asm/text/0000-inline-asm.md#asm-goto
> 
> Reading that makes all this even worse, apparently rust can't even use
> memops.

What do you mean by "memops"?

Regards,
Boqun

> 
> So to summarise, Rust cannot properly interop with C, it cannot do
> inline asm from this side of the millenium. Why are we even trying to
> use it again?
