Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DCA7E5344
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbjKHKZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHKZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:25:27 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE451BD5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:25:24 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5aecf6e30e9so90677587b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699439124; x=1700043924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIAH7ULmpEPckNqECutwwAimtLz/dzVilEA+c10APxg=;
        b=do9sAGK5lQJS/QE6LEK0Li7YydhFzWqzWF95+6xGnOh4yuGy0GHB0EDQQgmivUrShr
         rPgUPAwjqGU/H4JQInCdEDvkaqC3TriKQG3iODiUBz0vMRxYh3PcFVjLRBwe/dwVVDgn
         pVMZZPsS5HgVCSbX3HsebvXP8MFsR0K4MvhwnnRKNrAksQBTABAyeSppiJRKOZt5huxL
         tcZuku9jt/5MxVIZAz8TDQEBDH8sRqLzu1t+q7I5Q7po4s/ISgotBzqTtLDN8RwgRk7/
         aoddngW4kPPeywTX1NTbWT5zG24LDj9ONOajhmw6U22rr5EoN438T10f90nR3eZbpLfi
         I4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699439124; x=1700043924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fIAH7ULmpEPckNqECutwwAimtLz/dzVilEA+c10APxg=;
        b=kYsDV8oDOB6bmKvRlhB/mBXMbhtF3RW5qnKWmid29g8fMhKNAtioVq8pLfs8iFIyo7
         R3aEKsG3mz8A9AkIMzOxz2/pLG6Z/K40z5W3zOYph1jwB6JFS9f8K1s4GRISFwdwly/O
         D6HtKav1t7D3m0rToUev5rssjBHP54EtiRq12zyjpzuFM3pmkpV3qZnfVky+BSc9KI26
         p578vgaxi0euc1o8veOjx3MIvEjvto8jGuuZm00bQhAePNF3n19hPjvFKpXv1KkcQyT3
         DMkywbhIdEq0i5111e9JZlOb30aA3KV0f12qyvdixyCOwWaAT7g4Nd0SZL9ydQjDKX6j
         Ijeg==
X-Gm-Message-State: AOJu0Yy7aaWQxj/oUQWawk9ehN29zqTE3C4YzQskLV4iGJ4JqQb4llm1
        tXhNACPBB9uAjbID8p/FtxkdmJbTXS0zdDs=
X-Google-Smtp-Source: AGHT+IGtZC0V8m4itDc/HxEmRCPbDkWdSXexw5klfcLaXoMbRICY+WuL310XErMoKd7j9oxQ3u+qc6g80fVGyeI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:4712:b0:5be:a336:4a6 with SMTP
 id gz18-20020a05690c471200b005bea33604a6mr12477ywb.3.1699439123981; Wed, 08
 Nov 2023 02:25:23 -0800 (PST)
Date:   Wed,  8 Nov 2023 10:25:21 +0000
In-Reply-To: <sRVdoCqLbxM1-EH0iKVlb9eOEU-wt410-WT5rFTQNNYgmiW6EEpKvCCJyVppOmFYhXBcCN3SsXUXULzpmmweYBGDVHW619pjsIZvorv8Fc8=@proton.me>
Mime-Version: 1.0
References: <sRVdoCqLbxM1-EH0iKVlb9eOEU-wt410-WT5rFTQNNYgmiW6EEpKvCCJyVppOmFYhXBcCN3SsXUXULzpmmweYBGDVHW619pjsIZvorv8Fc8=@proton.me>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108102521.523413-1-aliceryhl@google.com>
Subject: Re: [PATCH RFC 02/20] rust_binder: add binderfs support to Rust binder
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com,
        gary@garyguo.net, gregkh@linuxfoundation.org, jeffv@google.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        maco@android.com, mattgilbride@google.com, mmaurer@google.com,
        ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        surenb@google.com, tkjos@android.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
> On 01.11.23 19:01, Alice Ryhl wrote:
>> +/// There is one context per binder file (/dev/binder, /dev/hwbinder, etc)
>> +#[pin_data]
>> +pub(crate) struct Context {
>> +    #[pin]
>> +    manager: Mutex<Manager>,
>> +    pub(crate) name: CString,
>> +    #[pin]
>> +    links: ListLinks,
>> +}
>> +
>> +kernel::list::impl_has_list_links! {
>> +    impl HasListLinks<0> for Context { self.links }
>> +}
>> +kernel::list::impl_list_arc_safe! {
>> +    impl ListArcSafe<0> for Context { untracked; }
>> +}
>> +kernel::list::impl_list_item! {
>> +    impl ListItem<0> for Context {
>> +        using ListLinks;
>> +    }
>> +}
> 
> I think at some point it would be worth introducing a derive macro that
> does this for us. So for example:
> 
>     #[pin_data]
>     #[derive(HasListLinks)]
>     pub(crate) struct Context {
>         #[pin]
>         manager: Mutex<Manager>,
>         pub(crate) name: CString,
>         #[pin]
>         #[links]
>         links: ListLinks,
>     }

Sure, it would be nice to improve the ergonomics of this. However, I
don't think it's that important either. The current solution is a bit
verbose, but good enough for me.

Alice

