Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9877B9EF3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjJEOQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjJEONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:13:53 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30166A68
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 23:32:41 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59e88a28b98so5955817b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 23:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696487561; x=1697092361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGyR1Zzvv154X8Dccwt7gC98O0K89BtDve6Z1+jKdN4=;
        b=ST7za+wx14hPc8p+oEfAiYxQPwckRjhw+YiKKsBblD0cPk3ICdaaopJG2uuc9wmYJZ
         +4P4Mr4ARMZxKs6LndrbJxSmCGzMGD6IkR3mwR+5edGcK+t0xYzUAMoeJJk53QOP54rn
         txYrLgBRvu8NYny32HygIAmRVq2GjLaef/mkr0hKJZOutx6qZGv/D6Mv1dwpeou4UG6X
         dfIDZWkHxxhkJ571NLr5Xer0FjeBD7YvWApd6d9vlzYl2Fju78w9zRMJDLQr2YZyrMfo
         x6QBDxYu3aD7XTCJkdHK7NkMJ6CSveyrtEnFDjJ0jNbpmCqmHeo+beT60Cq27epMFlWQ
         fjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696487561; x=1697092361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGyR1Zzvv154X8Dccwt7gC98O0K89BtDve6Z1+jKdN4=;
        b=GcgkgXdy6SmMdEO5GMQBED+qc6fAm3bk6nOY1rUP3LrHAHzWTFsu0NnYqlxbZH1xxv
         rlYXd236zPdQudi5LBRKo8Fhmg5F+Hb5ruE/fecbtv/yZkUzk4h0UlScM8ImEChnCHeb
         ZzUmrIlAeV8cbFkAoavPr//aBnzCoYWR4M7Bj7lrPkJ1EywtRnowVFneN7oscOsCsBCR
         dVgm3C++sjiYpipB5rndS9QGT0gaQEeliNruVDMC9IMeDbIpde+nCSqi7On37X2TLMed
         vmTwneHV+o617LqT/ZIDv0hG8grQrIAiI/KqPeehViBbc3F5Rzu6sL8XAHiftHNCwHSr
         3ScA==
X-Gm-Message-State: AOJu0YzpN7zAdH4zErRdkv3tW/tv7JBJKWqmSD00EyAzNGG9IT26MRsV
        VNdREN+Y17+WVFtwucG+fRP8tvieRx/dkuii+2lMTg==
X-Google-Smtp-Source: AGHT+IHJAdiS+YNWfIdgWHzybEMmyvLq6s23YivEmEYidiPTA9ZiKm3Am2IIYO0pi7fIfuQ1zezOAfQglwsScJWCnr0=
X-Received: by 2002:a81:6086:0:b0:59f:6440:7eff with SMTP id
 u128-20020a816086000000b0059f64407effmr1449066ywb.15.1696487560949; Wed, 04
 Oct 2023 23:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <CVZ2KU4KK5YH.2HVL1F6X93YLL@pogg> <20231003222947.374039-1-aliceryhl@google.com>
In-Reply-To: <20231003222947.374039-1-aliceryhl@google.com>
From:   Trevor Gross <tmgross@umich.edu>
Date:   Thu, 5 Oct 2023 02:32:29 -0400
Message-ID: <CALNs47s1=fjaXjymDM__G0-Qzv0mkftJ1hzOt4SZJt5Uy0WA1Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] rust: workqueue: add examples
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     k.shelekhin@ftml.net, alex.gaynor@gmail.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, nmi@metaspace.dk, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        tj@kernel.org, wedsonaf@gmail.com, yakoyoku@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 6:30=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
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

For what it's worth, I think that using a binding for return items
usually looks ever so slightly more clear than passing a multiline
argument

    fn new(value: i32) -> Result<Arc<Self>> {
        let tmp =3D pin_init!(MyStruct {
            value,
            work <- new_work!("MyStruct::work")
        });
        Arc::pin_init(tmp)
    }
