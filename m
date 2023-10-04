Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CCB7B7DCA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242139AbjJDLGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjJDLGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:06:15 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB33A1;
        Wed,  4 Oct 2023 04:06:12 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B76135C0376;
        Wed,  4 Oct 2023 07:06:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 04 Oct 2023 07:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ftml.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1696417569; x=1696503969; bh=QmTK4qF8bJkFxhIME1kS98D3S1rwh87nee/
        G/j+p6hE=; b=dNHvnA+FXEoYw28tPnYoekKUOl2jPEuaNs2UEODok7F+axlC2/m
        BKDU0d4R3IUa/5dyqfHaj11liKqH1DhIBA1Mwa1HmzR1K+wVVBGlhGtaCdwe9EnZ
        9au0JYDa9f82kwz1oMMh4TJOOz9+9elN5YfTlrVXgKlhOeiSnCn5pAk9LMqj4cGb
        2f4PzLFjfkrTh6yo+ZEDjXna2Kq9dzKsWsgOHrTP7VTwxyChgW/W4YtiBZPj1eRd
        6axgv0EzMRrse4xlQaoqx+2227A8rSjRSdtcvzBdcLzPXqTbxQpP+UpRmFte2krF
        PS075JtWbJHqv1cXOV9162urDaqL9wCSTrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696417569; x=1696503969; bh=QmTK4qF8bJkFxhIME1kS98D3S1rwh87nee/
        G/j+p6hE=; b=MmaO5j+gl7OH+eAPMfy35YTsJQvw3OZUL7WV7xD+Wp8Lri9KRlL
        YpTC2zrvnHVCW8B0zEymmwk5/ABhLnKIFibPRm59OeSp1K8V9IST7ADOI7VZGCBd
        aS48Q8qtikX0zBUc4hy/hAij8txujpKzTIekQTaAqFVzrXsFZ5JO/EkGALmfEt0w
        QYiAKWJFJFfd/KEkJ3/aug10b+FLjGMdd3x/6vfwNrjTHsihpqwrWx9CEpKjZUPx
        Azzc/w53BJMfL4e2H5NBfJG+E0oZ7rkTqOgPTuaGbJdMEUmcy3JxNLpTZUnajB59
        WnLGzZayYV+KBJ2ABQL23WDh2V/Z2iQ1aHg==
X-ME-Sender: <xms:IUcdZa34R-Ophd5zGq2ks1hGowcpxkoD6d1pbZW0zas2h3Deg5mCCQ>
    <xme:IUcdZdFrgvzRniVTysYW3AfWz6x08WM4MXD6168A-GWMg49vIkb1fWSoyGghJDiJu
    UlbIMBeD6QKU4vN8GU>
X-ME-Received: <xmr:IUcdZS4GckphUKct-Cfgb818GOteuFutIQ9L2PQWs_Ls1K-M7xDmzvgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgedvgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegggfgtfffkvefvhffuofhfjgesthhqredtredtjeenucfhrhhomhepfdfmohhn
    shhtrghnthhinhcuufhhvghlvghkhhhinhdfuceokhdrshhhvghlvghkhhhinhesfhhtmh
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeejffegkeeujefhfeettedtffefveeuteeg
    kedvjefhkeevkefgleffgedtgeduteenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehkrdhshhgvlhgvkhhhihhnsehfthhmlhdrnhgvth
X-ME-Proxy: <xmx:IUcdZb1hZf9u9k5_ppuYNA2-6RE7yS2hXYEUnWMf7jTnytv0Gbyw_Q>
    <xmx:IUcdZdEvehBK98uW53CAojBpPQ2sxI1dY6GEr5PhlteASCn9_KMhHQ>
    <xmx:IUcdZU--jp6DAGseK0A5deNm26t12yCu-VQ42HMA_kPiFZHFVLylNA>
    <xmx:IUcdZVEds98sRdlU769Q6mZq0II6C42MBxyjb8hv_yn8iqutdyGGcQ>
Feedback-ID: ib7794740:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Oct 2023 07:06:06 -0400 (EDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 04 Oct 2023 14:06:05 +0300
Message-Id: <CVZLU74VWMKA.GQXYH7WUNPS4@pogg>
Cc:     <alex.gaynor@gmail.com>, <benno.lossin@proton.me>,
        <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
        <gary@garyguo.net>, <jiangshanlai@gmail.com>,
        <linux-kernel@vger.kernel.org>, <nmi@metaspace.dk>,
        <ojeda@kernel.org>, <patches@lists.linux.dev>,
        <rust-for-linux@vger.kernel.org>, <tj@kernel.org>,
        <wedsonaf@gmail.com>, <yakoyoku@gmail.com>
To:     "Alice Ryhl" <aliceryhl@google.com>
From:   "Konstantin Shelekhin" <k.shelekhin@ftml.net>
Subject: Re: [PATCH v4 7/7] rust: workqueue: add examples
X-Mailer: aerc 0.15.2.r131.ga5d6a70
References: <CVZ2KU4KK5YH.2HVL1F6X93YLL@pogg>
 <20231003222947.374039-1-aliceryhl@google.com>
In-Reply-To: <20231003222947.374039-1-aliceryhl@google.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Oct 4, 2023 at 1:29 AM MSK, Alice Ryhl wrote:
> On Tue, Oct 3, 2023 at 10:13PM Konstantin Shelekhin <k.shelekhin@ftml.net=
> wrote:
> > +//! #[pin_data]
> > +//! struct MyStruct {
> > +//!     value: i32,
> > +//!     #[pin]
> > +//!     work: Work<MyStruct>,
> > +//! }
> > +//!
> > +//! impl_has_work! {
> > +//!     impl HasWork<Self> for MyStruct { self.work }
> > +//! }
> > +//!
> > +//! impl MyStruct {
> > +//!     fn new(value: i32) -> Result<Arc<Self>> {
> > +//!         Arc::pin_init(pin_init!(MyStruct {
> > +//!             value,
> > +//!             work <- new_work!("MyStruct::work"),
> > +//!         }))
> > +//!     }
> > +//! }
> > +//!
> > +//! impl WorkItem for MyStruct {
> > +//!     type Pointer =3D Arc<MyStruct>;
> > +//!
> > +//!     fn run(this: Arc<MyStruct>) {
> > +//!         pr_info!("The value is: {}", this.value);
> > +//!     }
> > +//! }
> > +//!
> > +//! /// This method will enqueue the struct for execution on the syste=
m workqueue, where its value
> > +//! /// will be printed.
> > +//! fn print_later(val: Arc<MyStruct>) {
> > +//!     let _ =3D workqueue::system().enqueue(val);
> > +//! }
> >
> > I understand that this is highly opionated, but is it possible to make
> > the initialization less verbose?
>
> The short answer is yes. There are safe alternatives that are much less
> verbose. Unfortunately, those alternatives give up some of the features
> that this design has. Specifically, they give up the feature that allows
> you to embed the work_struct inside custom structs. I need to be able to
> embed the work_struct inside of custom structs, so I did not go that
> route.

My concern with the approach of using traits instead of calling an
initialization function is that a some of existing code uses the
following pattern:

    static void nvmet_file_submit_buffered_io(struct nvmet_req *req)
    {
            INIT_WORK(&req->f.work, nvmet_file_buffered_io_work);
            queue_work(buffered_io_wq, &req->f.work);
    }

    static void nvmet_file_execute_flush(struct nvmet_req *req)
    {
            if (!nvmet_check_transfer_len(req, 0))
                    return;
            INIT_WORK(&req->f.work, nvmet_file_flush_work);
            queue_work(nvmet_wq, &req->f.work);
    }

    static void nvmet_file_execute_dsm(struct nvmet_req *req)
    {
            if (!nvmet_check_data_len_lte(req, nvmet_dsm_len(req)))
                    return;
            INIT_WORK(&req->f.work, nvmet_file_dsm_work);
            queue_work(nvmet_wq, &req->f.work);
    }

As you can see a single work struct is used here, and dispatching
happens beforehands. While it's possible to do the dispatching later in
run(), it's IMO cleaner to do this earlier.

> There are also some parts of this (mainly `impl_has_work!`) that I am
> unhappy with. I would be happy to see a solution that doesn't need it,
> but I couldn't figure out how to avoid it.
>
> > Because the C version looks much, much cleaner and easier to grasp:
> >
> >     struct my_struct {
> >         i32 value;
> >         struct work_struct work;
> >     };
> >=20
> >     void log_value(struct work_struct *work)
> >     {
> >         struct my_struct *s =3D container_of(work, struct my_struct, wo=
rk);
> >         pr_info("The value is: %d\n", s->value);
> >     }
> >=20
> >     void print_later(struct my_struct &s)
> >     {
> >         INIT_WORK(&s->work, log_value);
> >         schedule_work(&s->work);
> >     }
>
> Although I think that a part of this is just whether you are familiar
> with Rust syntax, there is definitely some truth to this. Your code is a
> lot closer to the machine code of what actually happens here. Perhaps it
> would be interesting to see what you get if you just unsafely do exactly
> the same thing in Rust? It would look something like this:
>
>     struct MyStruct {
>         value: i32,
>         work: bindings::work_struct,
>     }
>
>     unsafe fn log_value(work: *mut bindings::work_struct) {
>         unsafe {
>             let s =3D container_of!(work, MyStruct, work);
>             pr_info!("The value is: {}", (*s).value);
>         }
>     }
>
>     unsafe fn print_later(s: *mut bindings::work_struct) {
>         unsafe {
>             bindings::INIT_WORK(&mut (*s).work, log_value);
>             bindings::schedule_work(&mut (*s).work);
>         }
>     }
>
> (I didn't try to compile this.)
>
> The problem with this approach is that it uses unsafe in driver code,
> but the goal behind Rust abstractions is to isolate all of the related
> unsafe code. The idea being that drivers using the workqueue do not need
> any unsafe code to use it. This means that, assuming these workqueue
> abstractions are correct, no driver can accidentally cause memory
> unsafety by using the workqueue wrong.
>
> The main difficult part of making this happen is the container_of
> operation. We need to somehow verify *at compile time* that the
> container_of in log_value really is given a pointer to the work field of
> a MyStruct. Other than the things that are just how Rust looks, most of
> the verbosity is necessary to make this compile-time check possible.
>
> Another thing it does is handle proper transfer of ownership. In my
> original example, MyStruct is reference counted (due to the use of Arc),
> so the workqueue passes ownership of one refcount to the workqueue,
> which eventually passes the refcount to run. When `this` goes out of
> scope at the end of `run`, the refcount is decremented and the struct is
> freed if the refcount dropped to zero.
>
> If you wanted to just have exclusive ownership of my_struct, you could
> do that by using Box instead of Arc. In either case, the ownership is
> correctly passed to run, and you cannot accidentally forget to free it
> at the end of log_value.
>
> So, ultimately there's a tradeoff here. The code corresponds less
> directly to what the machine code will be. On the other hand, it will be
> *more* difficult to use incorrectly since incorrect uses will usually
> result in compilation errors. The claim of Rust is that this tradeoff is
> worth it.

I get where all this coming from, I just really dislike the idea to
write all this code every time I need to pass something down the
workqueue. Maybe it's possible to hide most of the boilerplate behind a
derive.

Something like this, for example:

    #[pin_data, derive(WorkContainer)]
    struct MyStruct {
        value: i32,
        #[pin, work(fn =3D log_value)]
        work: Work,
    }

    fn log_value(s: Arc<MyStruct>) {
        pr_info!("The value is: {}", s.value);
    }

    fn print_later(s: Arc<MyStruct>) {
        workqueue::system().enqueue(s);
    }
