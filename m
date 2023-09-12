Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA179C634
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjILFOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjILFOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:14:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33481AA;
        Mon, 11 Sep 2023 22:14:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so6214940a12.3;
        Mon, 11 Sep 2023 22:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694495687; x=1695100487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyqIIsunQYTKSmZgrrp/lV4JAtUjhb5FezapOWZ1nds=;
        b=Ejk8JrAfKEXHgaRFEEsPPfxa38mC4sdNWu4VScq/5qqaW/DayxGxH6GufFHfNFNTM1
         mEIl6sZNWqNkgKRvBGPSoskfFuXZzVZyW5rTP/9gi6+tLgAYoKr4pQVKdeaDVG4vXql/
         GOUGZebqLE5iM5I18idYCsFQyeeQpsdXdvpuKMCWE63RqBBOFP4aMg8mvzzfzdTBLP+u
         kbtTiXDyIAlxwOkCquhFr7GnJvkeoFbBPAqL1C4KBBmofOOxWQkh5QUsVR/1bi6aBn9M
         2LBjz5t18511nfDYUOfyenHwRtU4VW7izlTED/x0RyzgAUqaClNs5BnnfSslPv7WK4rC
         dJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694495687; x=1695100487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyqIIsunQYTKSmZgrrp/lV4JAtUjhb5FezapOWZ1nds=;
        b=vvX2cysy8OLA37fGrFZFOpcuw2o690v09MWGJcwg0j3XGvxnSNYM/DSSxvNBcoU0b8
         UCrngp1eWhySLXNMoOkUGvC5/RdZJfVTEh7H3EJv1hwS1qJEXVLTiJtIpTZb7pXzREwZ
         d6UqeZhhMmAsTlUSWbt+fbZeCUVlssgpAk/7N3Mihr6ryvHl7uX8tP09nGPt1qzU0nJ8
         YaBoiqwCrh1HCjhSt3PXJKC4h++lKm1LyTLF+93E+FnWIp4vegLzqfG2gsnImkOAydab
         dtxSD0XgzejTJ71x7Bat2mcRSvOUNEI0feZOstRjWojl+oWJBactp0wjc4IriVC37K+i
         ekhQ==
X-Gm-Message-State: AOJu0Yxx1R6Y1AWhBVhx3KmsKTEnXBkQ34AIRax3ZM+hoDov8Lne/tmY
        5VlXG+XJjp1K3n0SDYHy0oQ=
X-Google-Smtp-Source: AGHT+IFv/3bDs9+/Wsozcj7o/1ImmwL4pLK/TANqGEeXohmyJfUBXGbX7E9QLdTEXXF5EfRlTE/IlQ==
X-Received: by 2002:a17:907:7899:b0:99c:ad52:b00 with SMTP id ku25-20020a170907789900b0099cad520b00mr8755557ejc.6.1694495687343;
        Mon, 11 Sep 2023 22:14:47 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id hb19-20020a170906b89300b009a1fd22257fsm6218756ejb.207.2023.09.11.22.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 22:14:46 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 551CA27C0054;
        Tue, 12 Sep 2023 01:14:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Sep 2023 01:14:44 -0400
X-ME-Sender: <xms:xPP_ZDVQjqCnqE6tvCBFg7gBHJ3Gx0d4YTFJ2eYJ1J_UOULEYfsUbg>
    <xme:xPP_ZLngeWdfEH6yTo0MHbO3HOT4ydIZb0oQGND76cI0On8_3t6_8qVns2DVCVreL
    Nty4gBm67J0zYodwA>
X-ME-Received: <xmr:xPP_ZPY8tx6JL8LxbXeV3kt0c45RfigRdu_AxMRnkQlnxecWINRJj_au8Sc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeihedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:xPP_ZOVkdYD9jAY7PwHPTMmrJfTVyNl51Vnrib7n_ELMl03hd4esxQ>
    <xmx:xPP_ZNl3AQCafge42uT9S1U3RP-ksycvV95Fb_zXViSQdVftuLXHdw>
    <xmx:xPP_ZLeZP31AVoC6HrFrML_K2kPLcg0YsBlvGXtIc5MG4WTds9ikzA>
    <xmx:xPP_ZDeI29Frbg1PXQ5xZ7SmbJZUSqqOVqduN3s8qDMgkQEVw7PGLw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 01:14:43 -0400 (EDT)
Date:   Mon, 11 Sep 2023 22:14:41 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v4 0/7] rust: workqueue: add bindings for the workqueue
Message-ID: <ZP_zwc6UuirLSstf@Boquns-Mac-mini.home>
References: <20230828104807.1581592-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828104807.1581592-1-aliceryhl@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:48:00AM +0000, Alice Ryhl wrote:
> This patchset contains bindings for the kernel workqueue.
> 
> One of the primary goals behind the design used in this patch is that we
> must support embedding the `work_struct` as a field in user-provided
> types, because this allows you to submit things to the workqueue without
> having to allocate, making the submission infallible. If we didn't have
> to support this, then the patch would be much simpler. One of the main
> things that make it complicated is that we must ensure that the function
> pointer in the `work_struct` is compatible with the struct it is
> contained within.
> 
> The original version of the workqueue bindings was written by Wedson,
> but I have rewritten much of it so that it uses the pin-init
> infrastructure and can be used with containers other than `Arc`.
> 
> This patchset depends on the patch [1] that changes `Opaque` to be
> `!Unpin` for correctness. The patchset is based on the rust-6.6 tag,
> since that tag includes that patch.
> 
> Changes v3 -> v4:
> 
>  * Use `offset_of!` macro from standard library, and drop patch with
>    custom implementation.
>  * Add name parameter to `work_struct` constructor, and drop patch with
>    __INIT_WORK_WITH_KEY.
>  * Various improvements to documentation and comments.
> 
> More detailed changelogs can be found on the individual patches.
> 

For the whole series:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> Previous versions:
> v1: https://lore.kernel.org/all/20230517203119.3160435-1-aliceryhl@google.com/
> v2: https://lore.kernel.org/all/20230601134946.3887870-1-aliceryhl@google.com/
> v3: https://lore.kernel.org/all/20230711093303.1433770-1-aliceryhl@google.com/
> 
> [1]: https://lore.kernel.org/all/20230630150216.109789-1-benno.lossin@proton.me/
> 
> Alice Ryhl (5):
>   rust: workqueue: add low-level workqueue bindings
>   rust: workqueue: add helper for defining work_struct fields
>   rust: workqueue: implement `WorkItemPointer` for pointer types
>   rust: workqueue: add `try_spawn` helper method
>   rust: workqueue: add examples
> 
> Wedson Almeida Filho (2):
>   rust: sync: add `Arc::{from_raw, into_raw}`
>   rust: workqueue: define built-in queues
> 
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers.c                  |  13 +
>  rust/kernel/lib.rs              |   3 +
>  rust/kernel/sync/arc.rs         |  46 ++-
>  rust/kernel/workqueue.rs        | 679 ++++++++++++++++++++++++++++++++
>  scripts/Makefile.build          |   2 +-
>  6 files changed, 741 insertions(+), 3 deletions(-)
>  create mode 100644 rust/kernel/workqueue.rs
> 
> base-commit: 4af84c6a85c63bec24611e46bb3de2c0a6602a51
> -- 
> 2.42.0.rc1.204.g551eb34607-goog
> 
