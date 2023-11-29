Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3AA7FDD86
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjK2Qps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjK2Qpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:45:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A0290;
        Wed, 29 Nov 2023 08:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AUrTChoc66XeV0GsgVjdZSx4wAh33cl3WQaLI1/3Bjg=; b=V3inMrDzxw2OJuvwPapGdJEJrC
        JrPe614IpXtpeM8ebzEKMhI59QCRqs8hwyRKeBSBrgCWdzd8q3yFl3mOUps8p61eHxn8UHfntgGL4
        5h4VY0Cru0v0fPAdfkPpPE+0R6M3497GsVD0XICjo6pbV0XDOdG9mYnJgsDzl2QuWidqxGV8bOn3F
        H0ArBjc4ZrYsXV6QnLOOVI4c9mMSMCrcm3sEVx0ppLABbpVYwE1hJBY5O385tYdGmwwEa3ZqN/dmT
        NTkMeLeGF85LFZg4zceNlFwsyq4Jr1FXbOejhERdSiMvQxi0dk5c6Ude5glYxvAC3bbrH6VxIYFPw
        8qlXurfw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r8Ngq-00Dab0-83; Wed, 29 Nov 2023 16:45:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F72830017D; Wed, 29 Nov 2023 17:45:31 +0100 (CET)
Date:   Wed, 29 Nov 2023 17:45:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     willy@infradead.org, a.hindborg@samsung.com, alex.gaynor@gmail.com,
        arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com,
        dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, surenb@google.com,
        tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
        wedsonaf@gmail.com
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <20231129164531.GH23596@noisy.programming.kicks-ass.net>
References: <ZWdVEk4QjbpTfnbn@casper.infradead.org>
 <20231129164251.3475162-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129164251.3475162-1-aliceryhl@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 04:42:51PM +0000, Alice Ryhl wrote:
> Second, there's potentially an increased maintenance burden when C
> methods are reimplemented in Rust. Any change to the implementation on
> the C side would have to be reflected on the Rust side.

C to Rust compiler FTW :-)
