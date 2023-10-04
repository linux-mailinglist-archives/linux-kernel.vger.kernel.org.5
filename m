Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936CC7B8284
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242827AbjJDOjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjJDOj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:39:29 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D28BF;
        Wed,  4 Oct 2023 07:39:26 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-668d9c1f70fso12793526d6.3;
        Wed, 04 Oct 2023 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696430365; x=1697035165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyzgdoMLwkq9+lVrAUZEty4x9uo3GaRubMI72epRsDU=;
        b=ZgAQYSmucOo1FtSisfoy8tPBmPz70r8lR9YhBJkRsttTmb97RcFMP0aNsWD8oZyIFP
         9pewtWDpu2qAwlTi1Cq6DInbVthcEdC3cToGEWyFScQ+2kcW/2/8Ld9x2ezHjBU5yCbz
         iEEqRRzDV7csLqvdXSRFsltanqlqJCmPtoZMO6oDRT2GK0nNx1l4+x9qvU3s6R4Alin4
         RBO1CX0aR6y3L7Tl2F1M3ZcPydlYTS47UeFBDoD71zebRxAiOTeHeRT0JJHHngYcCo+V
         w4uHF0V23Dq3CW4XCNngwwe4PueneZkO+1mQqAT42p9cTiSTXvWLrm48snCnQYNwNORa
         xwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696430365; x=1697035165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyzgdoMLwkq9+lVrAUZEty4x9uo3GaRubMI72epRsDU=;
        b=KXmniBuUr4yeqp86M36iTUzSrEWoGcQKTpJ8KgUF/1Kz4SfGOzWWRuh6T3jXMYNHh5
         MArZnOnhLT/7szxoobfyGV9Zrek3Okyvvrz5XfmfvUpoG7nofygWk9aUk4c2MQ6aJS33
         GIaYTW42bfbB7ne0D7hs0l4/87yo+DPGfFg742/mKILbf8rvV5wxhRkrqU1nW8aP2cak
         dq4RoM/OzIhMAjpHuYMP7eJ8dj5RoqonIsZz8/jHDbfsqKY2Y/rI+RwxqAb4LwHkz2dh
         M+CXWHb0ppVwF0wuT096jIlZ43HHRF4Cul5PwlGbAOFexYCC0jOtxs0gsqQ76P3PlF3S
         KGWA==
X-Gm-Message-State: AOJu0Yyj37LZ0+mnRL2cwOgCFZaa/ycXw3szYRboSE+6o9k49ghSy2QX
        KqMgvfxoIzYFH06lRMMX6UM=
X-Google-Smtp-Source: AGHT+IF1KZEFuDL4DVpwHFXUCLmxHbYge1cna81g9hxaNFnX+rH3ehgWL+MRSDKRalkM35UsNCfRuw==
X-Received: by 2002:a0c:e308:0:b0:635:e0dd:db4b with SMTP id s8-20020a0ce308000000b00635e0dddb4bmr2454308qvl.37.1696430365398;
        Wed, 04 Oct 2023 07:39:25 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id n15-20020a0ce48f000000b0065b10dbcd53sm1370449qvl.120.2023.10.04.07.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:39:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 64F0227C0054;
        Wed,  4 Oct 2023 10:39:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 04 Oct 2023 10:39:24 -0400
X-ME-Sender: <xms:G3kdZVVmcY7_-70pgDG9kuuthDFV7dMHOu8neNr5s12ePPXjCqoa-Q>
    <xme:G3kdZVkMi9zr3Rk3x9rg6vTanyh3A0A9MlI0p-MJtUDbeA42vq1afPW4cyRWGB0G6
    csB8jJUmlNE9YQPBA>
X-ME-Received: <xmr:G3kdZRaQuFuxNur8kMhnSeeaBGfVWwGMi1z80PTd2LXNoXObpTRviwLG9Mo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgedvgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:HHkdZYWJNAwjFRgNfFT-6OxgxzMv7XKtBW_thbwsQj8X3NLjOdzjDA>
    <xmx:HHkdZfnPy741u5Ox_W-EkQlS_9GOZfPvFJ20vZqSYKCvLNHhA5ZT_Q>
    <xmx:HHkdZVffE4I2lRUx1JcnW1Y8bbaL6ojF431YuH3DJnjJFa9z7kqXZA>
    <xmx:HHkdZU83Rq-yatnIL9TkOF13EgeYk0Px9G1jRP47mFA-k8ujiHwm_A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Oct 2023 10:39:23 -0400 (EDT)
Date:   Wed, 4 Oct 2023 07:38:26 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Konstantin Shelekhin <k.shelekhin@ftml.net>
Cc:     Alice Ryhl <aliceryhl@google.com>, alex.gaynor@gmail.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        nmi@metaspace.dk, ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com,
        yakoyoku@gmail.com
Subject: Re: [PATCH v4 7/7] rust: workqueue: add examples
Message-ID: <ZR144pugIJQRAFjj@boqun-archlinux>
References: <CVZ2KU4KK5YH.2HVL1F6X93YLL@pogg>
 <20231003222947.374039-1-aliceryhl@google.com>
 <CVZLU74VWMKA.GQXYH7WUNPS4@pogg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CVZLU74VWMKA.GQXYH7WUNPS4@pogg>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:06:05PM +0300, Konstantin Shelekhin wrote:
> On Wed Oct 4, 2023 at 1:29 AM MSK, Alice Ryhl wrote:
> > On Tue, Oct 3, 2023 at 10:13PM Konstantin Shelekhin <k.shelekhin@ftml.net> wrote:
> > > +//! #[pin_data]
> > > +//! struct MyStruct {
> > > +//!     value: i32,
> > > +//!     #[pin]
> > > +//!     work: Work<MyStruct>,
> > > +//! }
> > > +//!
> > > +//! impl_has_work! {
> > > +//!     impl HasWork<Self> for MyStruct { self.work }
> > > +//! }
> > > +//!
> > > +//! impl MyStruct {
> > > +//!     fn new(value: i32) -> Result<Arc<Self>> {
> > > +//!         Arc::pin_init(pin_init!(MyStruct {
> > > +//!             value,
> > > +//!             work <- new_work!("MyStruct::work"),
> > > +//!         }))
> > > +//!     }
> > > +//! }
> > > +//!
> > > +//! impl WorkItem for MyStruct {
> > > +//!     type Pointer = Arc<MyStruct>;
> > > +//!
> > > +//!     fn run(this: Arc<MyStruct>) {
> > > +//!         pr_info!("The value is: {}", this.value);
> > > +//!     }
> > > +//! }
> > > +//!
> > > +//! /// This method will enqueue the struct for execution on the system workqueue, where its value
> > > +//! /// will be printed.
> > > +//! fn print_later(val: Arc<MyStruct>) {
> > > +//!     let _ = workqueue::system().enqueue(val);
> > > +//! }
> > >
> > > I understand that this is highly opionated, but is it possible to make
> > > the initialization less verbose?
> >
> > The short answer is yes. There are safe alternatives that are much less
> > verbose. Unfortunately, those alternatives give up some of the features
> > that this design has. Specifically, they give up the feature that allows
> > you to embed the work_struct inside custom structs. I need to be able to
> > embed the work_struct inside of custom structs, so I did not go that
> > route.
> 
> My concern with the approach of using traits instead of calling an
> initialization function is that a some of existing code uses the
> following pattern:
> 
>     static void nvmet_file_submit_buffered_io(struct nvmet_req *req)
>     {
>             INIT_WORK(&req->f.work, nvmet_file_buffered_io_work);
>             queue_work(buffered_io_wq, &req->f.work);
>     }
> 
>     static void nvmet_file_execute_flush(struct nvmet_req *req)
>     {
>             if (!nvmet_check_transfer_len(req, 0))
>                     return;
>             INIT_WORK(&req->f.work, nvmet_file_flush_work);
>             queue_work(nvmet_wq, &req->f.work);
>     }
> 
>     static void nvmet_file_execute_dsm(struct nvmet_req *req)
>     {
>             if (!nvmet_check_data_len_lte(req, nvmet_dsm_len(req)))
>                     return;
>             INIT_WORK(&req->f.work, nvmet_file_dsm_work);
>             queue_work(nvmet_wq, &req->f.work);
>     }
> 
> As you can see a single work struct is used here, and dispatching
> happens beforehands. While it's possible to do the dispatching later in
> run(), it's IMO cleaner to do this earlier.

This is not a problem until nvmet actually uses/switches to Rust, right?
;-) We can certainly improve the API when a real user needs something.
Or you know someone is already working on this?

[...]
> 
> I get where all this coming from, I just really dislike the idea to
> write all this code every time I need to pass something down the
> workqueue. Maybe it's possible to hide most of the boilerplate behind a
> derive.
> 
> Something like this, for example:
> 
>     #[pin_data, derive(WorkContainer)]
>     struct MyStruct {
>         value: i32,
>         #[pin, work(fn = log_value)]
>         work: Work,
>     }
> 
>     fn log_value(s: Arc<MyStruct>) {
>         pr_info!("The value is: {}", s.value);
>     }
> 
>     fn print_later(s: Arc<MyStruct>) {
>         workqueue::system().enqueue(s);
>     }

All of your suggestions make senses to me, but because we don't have
many users right now, it's actually hard to determine a "best" API. I
like what we have right now because it's explicit: people won't need to
learn much about procedure macros to understand how it works, and it
also provides better opportunities for people who's yet not familiar
with Rust to give some reviews. So starting with something relatively
simple and verbose may not be a bad idea ;-)

Again, I like your idea, we need to explore that direction, but one
dragon at a time ;-)

Regards,
Boqun
