Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A887FF38A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346306AbjK3PZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346305AbjK3PZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:25:01 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC83410E0;
        Thu, 30 Nov 2023 07:25:06 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-67a3f1374bdso5931186d6.2;
        Thu, 30 Nov 2023 07:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701357906; x=1701962706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYxckIwC9xbehezW7h9apLIAUAGmTaUwXE2pwY1GWQE=;
        b=lZRhiFQBXHvVsL353F44BE+L3vRTbhaV4okHoj6nsepw8bJMP80C099GqUqsQRa75I
         af9suGQt+qR/bE5wWeq+Ls5aKt6dCPp6QXFTTNnXZ/sr2ZkQFVEg1dTcSxRrLUbUKUZn
         aS+RMnw2kjp8PrE190hzh6bip9nBVwUr2tcXFTIYOfR/Q/PB4GcT5On/T9dLHwrah14u
         hSk+1zB1/r0HTpeBEAV544QP3uFNsztplwDxHVsUFMJkNc0ZR2JjLDjHKi1G5SuA1wvN
         oVGpowIhxkCskCWZVL3OTU05lstfQMXj6yYS4M1ASnl6gXOB0hQnNfQvXqVSRzRGRZax
         1HKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357906; x=1701962706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYxckIwC9xbehezW7h9apLIAUAGmTaUwXE2pwY1GWQE=;
        b=iL5RSWfPLIOvug3PcR5BUHvGVCCOUXQvepk5z/fCNq/NDbg2W/HrU4uFORrArNj2ME
         sRuoheIjJ69UfhTOMGxCkwLxCKCAIhFhTVhZTXhNQOHrK8MCxUH3aM8/y5kko3+iTCPw
         YuxlOBncL3KsbLFJucKf921qqta85hTY9VfmcuwogRYWm9OB6XNj3c44btugCG/DY1xh
         EYzwk4w26RrL9ubRkfCtyQ+mvKa8xwb0z8/6Drb3xR4RGebdjNgyaPOI7eNTVx/UtIYi
         K5jsVzhRpjPOB4sjg6MICDD9LFGRACx1HnJrP7D9dq968iPemk9UPt1bc7CwhNhbrP76
         3+Iw==
X-Gm-Message-State: AOJu0YxM5ImDLTV5bTS7cm9ql1FonbXnApPkixH7uQSjkTyDczkq5ZFz
        7cXLHSv74XiUNEJZZ6fyBH4=
X-Google-Smtp-Source: AGHT+IGYKAB7Rm1Ig/GKPQgPdLfR9ZiX98pKpWHGlLUCA9EIQ7LZNda66HQcT7bQvwSH2nx4TDR1yQ==
X-Received: by 2002:a05:6214:5581:b0:67a:65d9:6c53 with SMTP id mi1-20020a056214558100b0067a65d96c53mr7128461qvb.1.1701357906005;
        Thu, 30 Nov 2023 07:25:06 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id a13-20020a0ce34d000000b0067a28752199sm584504qvm.10.2023.11.30.07.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:25:05 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id AC26927C0054;
        Thu, 30 Nov 2023 10:25:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 30 Nov 2023 10:25:04 -0500
X-ME-Sender: <xms:T6loZf8Cbq1-7yH_cPzJSa0NAoLqUxoeNCt7xpKFIYjqI41xT7j0ww>
    <xme:T6loZbt8ktt839eSyjrnW7OJZ9tEshpHbtHlhvEwND-k_X8euXgjpTXKC7NC4JSuQ
    Vr6NRjPVZMsLtTuWg>
X-ME-Received: <xmr:T6loZdB1Mzc6h8Df0OQrv45wcrQj3aDYVdyJzUJSeHnrA55d7l4U2EX86A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedgjeeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:T6loZbd1Zf0tXvcvRUqz_qvwWrflkmrZx90cRrP1pIBzdKuhPCGA0A>
    <xmx:T6loZUNN7X49LlG1y1Hmh6ACPa3grQ6ja5BPNvia0bhl1ZoOgLB-cA>
    <xmx:T6loZdmzHhO-zUP0mrsFVFc_qMmBup_EAgyj070eofPLAH3gkVCROw>
    <xmx:UKloZXiOE3anisBEA2h_yZkN0uamiSK1sjwWvq3VOqPkD_KZSyhy2g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 10:25:03 -0500 (EST)
Date:   Thu, 30 Nov 2023 07:25:01 -0800
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
Message-ID: <ZWipTZysC2YL7qsq@Boquns-Mac-mini.home>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
 <ZWdVEk4QjbpTfnbn@casper.infradead.org>
 <20231129152305.GB23596@noisy.programming.kicks-ass.net>
 <ZWdv_jsaDFJxZk7G@Boquns-Mac-mini.home>
 <20231130104226.GB20191@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130104226.GB20191@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:42:26AM +0100, Peter Zijlstra wrote:
> On Wed, Nov 29, 2023 at 09:08:14AM -0800, Boqun Feng wrote:
> 
> > But but but, I then realized we have asm goto in C but Rust doesn't
> > support them, and I haven't thought through how hard tht would be..
> 
> You're kidding right?
> 

I'm not, but I've found this:

	https://github.com/Amanieu/rfcs/blob/inline-asm/text/0000-inline-asm.md#asm-goto

seems to me, the plan for this is something like below:

	asm!(
		"cmp {}, 42",
		"jeq {}",
		in(reg) val,
		label { println!("a"); },
		fallthrough { println!("b"); }
    	);

But it's not implemented yet. Cc Josh in case that he knows more about
this.

Regards,
Boqun

> I thought we *finally* deprecated all compilers that didn't support
> asm-goto and x86 now mandates asm-goto to build, and then this toy
> language comes around ?
> 
> What a load of crap ... 
