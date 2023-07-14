Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E66575450D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjGNWkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjGNWkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:40:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EDC30DC;
        Fri, 14 Jul 2023 15:40:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-521662a6c9cso1096041a12.1;
        Fri, 14 Jul 2023 15:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689374421; x=1691966421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyVQwJRyPUDMG57VW2kmBb8+m6wWl6Yo/DMAStv+wfk=;
        b=JKefLS3j0ryWTJYc3YhdmruzyZ/f/0/ExJZK+31vVBXtpcCZTwzeZ+WIJbZQ6XXci/
         V+XGyfOSfIM22tHREHxxBxXrbPRJ+kERt8m/BpYwrx2onU4YeDmZ83Vcng+axgyWR8R3
         w8Mk7t2v1Ozk4H7LoGbPAt6ytGW/iwGmVWbD/94JsvRGPPfuTHYMKNjJ3Ffc41N1FB9j
         L402nZ0PWPC7jjxXmW28A+R4Atnd7NHSdf23jnfpXXzqkMxcSZrqYkzRWEUBQDW/CepU
         MubLZPavLDe7L1Ys6Yo7CAvC1ruY9iiPJKi9qY0Ak7ncfzPjsG4Y8kEsMGy+93IFOY+H
         GlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689374421; x=1691966421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyVQwJRyPUDMG57VW2kmBb8+m6wWl6Yo/DMAStv+wfk=;
        b=PZuEacs6HvHbZOHUTPIu11gfGEDzjpuRFQRKt9o3FlkXXM59X4sxRxdetPs99zenRS
         XD1C6TigyP30WZVQtl1cWgyKhoMiv+/iUGDjmHO/qo86px5urXXGg3n9QjZCE2kIEi1t
         SBwRSzccYVfwLEYnTxZMPzFlBN60/8kXM9DfskwekejZgXPt9yHK/95RZAa8NsssZL3s
         fMVN95zMVcZ5RqHsvuhOa1s/sDe/k6VVdsz/bKb9dxBIHsWIjuFMapxyveuRe42/+qzz
         2Xukf73oJh8IUwW4A3IL4c3APJn12vC64VftC/WW+i+tsvlOafzD3LNp7Zc2m02wg2OO
         FjZg==
X-Gm-Message-State: ABy/qLZqkaamvc3Y9euvPV+uucnMhpU5On+cCcPyX7ZtXsrqiu450K9/
        KTcIXRHPpDcIDGkmdQuC7JI=
X-Google-Smtp-Source: APBJJlETqgUuvOol/5AoCQ+TMaFuKv7bmXYkwX0JuZU3w7GMEPN7PUuUnHG56mfFSxypOnWyKVXDzQ==
X-Received: by 2002:aa7:dd0f:0:b0:51a:3159:53c7 with SMTP id i15-20020aa7dd0f000000b0051a315953c7mr5314807edv.30.1689374420424;
        Fri, 14 Jul 2023 15:40:20 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id b4-20020aa7cd04000000b0051fea485845sm3282602edw.27.2023.07.14.15.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 15:40:19 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9B4A727C0054;
        Fri, 14 Jul 2023 18:40:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 14 Jul 2023 18:40:17 -0400
X-ME-Sender: <xms:0M6xZF11k71uh4jwdI9OGDE44q3PkOr6CKlRw10de8cWsP8MZAHVWQ>
    <xme:0M6xZMGi7FIOiMdvm2UtWHSsKAQtSrekcKUdcb2RwbBBZYCOeW99sdpL_rrfSgDGx
    Xm5HwXvYyKBIX4Hcw>
X-ME-Received: <xmr:0M6xZF4KR0i1P7RamBnmsh_7te_bF_oJUHepGRRJpL6zblRDauakwIfi84M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeejgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepjeffgeeijedvtdfgkeekhfejgeejveeuudfgheeftdekffejtdelieeuhfdv
    feegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:0M6xZC1KG_G2m0ydz-w6F0UsKCwyW4RHZkMwDbwuDl4QfaFFShDsLA>
    <xmx:0M6xZIHHAtGqZ9h1rwtH6rGmUHDI_4XMxq613-u8CxCeB6QEd-n-SQ>
    <xmx:0M6xZD90P8dQZh_FC2JpmBXcuJNj-hcXjXmsnx_Kvmt3EqPnFc_BBA>
    <xmx:0c6xZMHYh8Emw3hzJOLQKV5IwAsGafdpcX2bvsFI4hq7m45VOaayBQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jul 2023 18:40:16 -0400 (EDT)
Date:   Fri, 14 Jul 2023 15:40:12 -0700
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
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andreas Hindborg <nmi@metaspace.dk>
Subject: Re: [PATCH v3 9/9] rust: workqueue: add examples
Message-ID: <ZLHOzBgtUQqmtQvR@boqun-archlinux>
References: <20230711093303.1433770-1-aliceryhl@google.com>
 <20230711093303.1433770-10-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711093303.1433770-10-aliceryhl@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 09:33:03AM +0000, Alice Ryhl wrote:
> This adds two examples of how to use the workqueue. The first example
> shows how to use it when you only have one `work_struct` field, and the
> second example shows how to use it when you have multiple `work_struct`
> fields.
> 

These examples are nice, but look like we need the following based on
the whole patchset to make them compile as doc/kunit tests[1]:

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index d99f55a021dd..1ccc511dbe87 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -34,6 +34,7 @@
 //!
 //! ```
 //! use kernel::prelude::*;
+//! use kernel::impl_has_work;
 //! use kernel::sync::Arc;
 //! use kernel::workqueue::{self, Work, WorkItem};
 //!
@@ -76,6 +77,7 @@
 //!
 //! ```
 //! use kernel::prelude::*;
+//! use kernel::impl_has_work;
 //! use kernel::sync::Arc;
 //! use kernel::workqueue::{self, Work, WorkItem};
 //!
@@ -380,6 +382,7 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
 ///
 /// ```no_run
 /// use kernel::prelude::*;
+/// use kernel::impl_has_work;
 /// use kernel::workqueue::Work;
 ///
 /// struct MyWorkItem {
@@ -456,6 +459,8 @@ unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
 ///
 /// ```
 /// use kernel::sync::Arc;
+/// use kernel::impl_has_work;
+/// use kernel::workqueue::{self, Work, WorkItem};
 ///
 /// struct MyStruct {
 ///     work_field: Work<MyStruct, 17>,

[1]: https://lore.kernel.org/rust-for-linux/20230614180837.630180-1-ojeda@kernel.org/

Regards,
Boqun

> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> ---
> v2 -> v3:
>  * Use LockClassKey in constructors in examples.
>  * Add Reviewed-by from Martin, Gary, Andreas, Benno.
> 
>  rust/kernel/workqueue.rs | 104 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 3a3a8b52bfd9..482d3eeae7d8 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -26,6 +26,110 @@
>  //!  * The `WorkItemPointer` trait is implemented for the pointer type that points at a something
>  //!    that implements `WorkItem`.
>  //!
> +//! ## Example
> +//!
> +//! This example defines a struct that holds an integer and can be scheduled on the workqueue. When
> +//! the struct is executed, it will print the integer. Since there is only one `work_struct` field,
> +//! we do not need to specify ids for the fields.
> +//!
> +//! ```
> +//! use kernel::prelude::*;
> +//! use kernel::sync::Arc;
> +//! use kernel::workqueue::{self, Work, WorkItem};
> +//!
> +//! #[pin_data]
> +//! struct MyStruct {
> +//!     value: i32,
> +//!     #[pin]
> +//!     work: Work<MyStruct>,
> +//! }
> +//!
> +//! impl_has_work! {
> +//!     impl HasWork<Self> for MyStruct { self.work }
> +//! }
> +//!
> +//! impl MyStruct {
> +//!     fn new(value: i32) -> Result<Arc<Self>> {
> +//!         Arc::pin_init(pin_init!(MyStruct {
> +//!             value,
> +//!             work <- Work::new(kernel::static_lock_class!()),
> +//!         }))
> +//!     }
> +//! }
> +//!
> +//! impl WorkItem for MyStruct {
> +//!     type Pointer = Arc<MyStruct>;
> +//!
> +//!     fn run(this: Arc<MyStruct>) {
> +//!         pr_info!("The value is: {}", this.value);
> +//!     }
> +//! }
> +//!
> +//! /// This method will enqueue the struct for execution on the system workqueue, where its value
> +//! /// will be printed.
> +//! fn print_later(val: Arc<MyStruct>) {
> +//!     let _ = workqueue::system().enqueue(val);
> +//! }
> +//! ```
> +//!
> +//! The following example shows how multiple `work_struct` fields can be used:
> +//!
> +//! ```
> +//! use kernel::prelude::*;
> +//! use kernel::sync::Arc;
> +//! use kernel::workqueue::{self, Work, WorkItem};
> +//!
> +//! #[pin_data]
> +//! struct MyStruct {
> +//!     value_1: i32,
> +//!     value_2: i32,
> +//!     #[pin]
> +//!     work_1: Work<MyStruct, 1>,
> +//!     #[pin]
> +//!     work_2: Work<MyStruct, 2>,
> +//! }
> +//!
> +//! impl_has_work! {
> +//!     impl HasWork<Self, 1> for MyStruct { self.work_1 }
> +//!     impl HasWork<Self, 2> for MyStruct { self.work_2 }
> +//! }
> +//!
> +//! impl MyStruct {
> +//!     fn new(value_1: i32, value_2: i32) -> Result<Arc<Self>> {
> +//!         Arc::pin_init(pin_init!(MyStruct {
> +//!             value_1,
> +//!             value_2,
> +//!             work_1 <- Work::new(kernel::static_lock_class!()),
> +//!             work_2 <- Work::new(kernel::static_lock_class!()),
> +//!         }))
> +//!     }
> +//! }
> +//!
> +//! impl WorkItem<1> for MyStruct {
> +//!     type Pointer = Arc<MyStruct>;
> +//!
> +//!     fn run(this: Arc<MyStruct>) {
> +//!         pr_info!("The value is: {}", this.value_1);
> +//!     }
> +//! }
> +//!
> +//! impl WorkItem<2> for MyStruct {
> +//!     type Pointer = Arc<MyStruct>;
> +//!
> +//!     fn run(this: Arc<MyStruct>) {
> +//!         pr_info!("The second value is: {}", this.value_2);
> +//!     }
> +//! }
> +//!
> +//! fn print_1_later(val: Arc<MyStruct>) {
> +//!     let _ = workqueue::system().enqueue::<Arc<MyStruct>, 1>(val);
> +//! }
> +//!
> +//! fn print_2_later(val: Arc<MyStruct>) {
> +//!     let _ = workqueue::system().enqueue::<Arc<MyStruct>, 2>(val);
> +//! }
> +//! ```
> +//!
>  //! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
>  
>  use crate::{bindings, prelude::*, sync::Arc, sync::LockClassKey, types::Opaque};
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 
