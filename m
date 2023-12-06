Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE7F80757C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378343AbjLFQmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjLFQmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:42:38 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7355D4E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:42:43 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7bb3e55c120so2067724241.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 08:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701880963; x=1702485763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8vjKdo8RtK9sF2zFHnjxxHr37Mkrh0m1wUp2s63Svc=;
        b=ujodJ7JU9IgtG962SsMEjXzR6OBrYNqON6p9GLOidwYPR2d3bQZoJAT3qX9T11QyCN
         qvMnHK7zP7Rw/BaTJcv5HELGDiawKkraqP0MTtFmrP5G/TEFIwNcrVCbnEdt6JHj97rY
         xIMpyMk1zqECXDyB183vn3KCQgrgC8Ci9vyOjVR8yI6Ky6LO2tu+gQp3PTXS4X/9/MrU
         9as3bBiJKI3eXeSYhNhINee9f7Kxz+azk08tuEZ9EVPbdavGjFRQpSreUkTu4fCEtDDn
         +PUQBzftUS/2cdKbVN1DPI96y/puz4DTTORMNBbe4D4XDuW95nJo0nyMJHf5T3I4SZVC
         i/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880963; x=1702485763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8vjKdo8RtK9sF2zFHnjxxHr37Mkrh0m1wUp2s63Svc=;
        b=UCMBs3NX89kav4jNIQFbsm2mnwCINSjjqywFeuQ26yQJGlKohUtGt0HitGGI9/xvzB
         99/ZAp5lVkYYKW/61/iHkCUi24DegoH5LsIA+S/Lm2KYEBsP48dUObblTwJwHRWICaDy
         EwgQm0nQewTMjo0r1fwv/jVvM1dx+xxqd9eADnTnatDuQGtVsfvmg3CIyY2gBRSN+EuB
         JAFQGO2l05OO1EPTfqaTTLyd7QLox84vOfTuAcqcmZ9EmM4Pu9uYPV2F4PHOpO2Mjstl
         nLp6v5vBLqHy04GhNGEMTxNihe0IbvkD8jTGkaJb/0SusOSALK9JKZ+m4QgHMDaBPxAi
         Dwyw==
X-Gm-Message-State: AOJu0YzTbE/KsH9rULOl+t0dRaaAuM9uTe7HAqxuYgkhXQmlD7Dgd8kf
        3ba1XofjquYRGGsIlEr2lpKKUDGwjha5La9yHqJWhw==
X-Google-Smtp-Source: AGHT+IFmX95hKsT+x9B1U9JgLud4gOx76wZ9d0sOYGnTy01xJB/RnRNZ08pYM4rj0hN9VQAvFzXxLZTCMqBtU1eTpHQ=
X-Received: by 2002:a05:6122:3c54:b0:4b2:dbb5:bc58 with SMTP id
 fv20-20020a0561223c5400b004b2dbb5bc58mr1380918vkb.29.1701880962567; Wed, 06
 Dec 2023 08:42:42 -0800 (PST)
MIME-Version: 1.0
References: <20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com>
 <20231206-rb-new-condvar-methods-v1-2-33a4cab7fdaa@google.com>
 <ZXChjmoKPj3XnJgG@Boquns-Mac-mini.home> <20231206163945.GC36423@noisy.programming.kicks-ass.net>
In-Reply-To: <20231206163945.GC36423@noisy.programming.kicks-ass.net>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Wed, 6 Dec 2023 17:42:29 +0100
Message-ID: <CAH5fLgi56i70MaFaoLcWVw+nf-ZvOLpmA8bHNVX=VXTBkcSa4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: add `CondVar::wait_timeout`
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 5:39=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Dec 06, 2023 at 08:30:06AM -0800, Boqun Feng wrote:
> > On Wed, Dec 06, 2023 at 10:09:24AM +0000, Alice Ryhl wrote:
> > [...]
> > > +
> > > +/// The return type of `wait_timeout`.
> > > +pub enum CondVarTimeoutResult {
> > > +    /// The timeout was reached.
> > > +    Timeout,
> > > +    /// Somebody woke us up.
> > > +    Woken {
> > > +        /// Remaining sleep duration.
> > > +        jiffies: u64,
> >
> > I have a Jiffies definition in the my upcoming timer patchset:
> >
> > /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
> > pub type Jiffies =3D core::ffi::c_ulong;
> >
> > Maybe you can add that (in a separate patch) in kernel::time?
>
> Urgh, why are we using jiffies in 2023?

I assumed that the correct thing here would be to accept the same unit
as what schedule_timeout takes. Should I be doing something else?

Alice
