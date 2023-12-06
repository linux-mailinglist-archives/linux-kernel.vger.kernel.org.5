Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A751B80754D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442589AbjLFQi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379366AbjLFQix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:38:53 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7782FA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:38:59 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7c461a8cb0dso1473295241.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 08:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701880739; x=1702485539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbcOYch65HQgwW4bXeNQNStE/Bld2otdL+K6EjO7ssY=;
        b=PmEKKJUIVcUp9Gxuf3aFfdxZyOViqVpHsUBLh/iW827KBOcUMfNFsu02LTOFjHOZWh
         GhSiWdukxLCDFabebhw+pYRkab2cJTcg98+oHdmaIRmGxvsOH5CFUXDCvbOqBhsG0zPv
         u2v6m3s4XX06toKFB1JeNiFtaN8IXDGTKVTOB3kPAqwOfw++t3kSECOWQdii6+VZwZEn
         tYuv2P+lhTmBUeuyuv6zdlYa0Fk0xIB9hzEc2UGwuI4y0mhm3TKDWLdHhGtd5DpC+Hss
         Jp+H8DdnblZ8IZdZ0Xkf9DUb7AdebwV5QLjNwNjclHa4BwLGIPsnl6DJAtEBl4HHGnqH
         R0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880739; x=1702485539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbcOYch65HQgwW4bXeNQNStE/Bld2otdL+K6EjO7ssY=;
        b=vZur8GA4VyoTh+NSy6aMUcSaOgvvndITiOTvAAjYMcp0P8jx5HAuAJJMGJZAxKOczo
         OazFui5xRxWJW2jSXyrK/kMVWJeBK3DB0VOMaoRjNKP0cODetrqQb3CICb/qN1zel73T
         R8UMY+sH3OXhMnZw4SmDpJ49g1BaDYAyloIKqjJymNo8jckzS762yMtx9R1QDm+4Iet8
         DSdX9fZtdOm1fNVt3HeyZ8m7QibVZPkCNELrbsA2+fTMeYXzRXgU0lnfGuzMkCitdxua
         UJdKN8ND8Y7teN1Pj0fIrUFuwiJK5gdRFXJOhGiaHyu5YALY9j+Afhep+7y/qbeCY/O8
         LnUw==
X-Gm-Message-State: AOJu0YxXrZe7m0G5AkqvMgdwNchWD0+tppFfnSR5rU+CFsD1C7OOWlm6
        R1sdac1zau1ewvoksIkt0N/pf5tVCMNxdrgZMH5ILMzkAy/xPGi1hxXw70uB
X-Google-Smtp-Source: AGHT+IERg2HJ276lhfxN7rCRC03VoISQfXlpwt3/L6+Zjw+3y0AvD8tv/uQ/BP1oHi3y+u0vTOleQejpyX++CRsJv2s=
X-Received: by 2002:a1f:c604:0:b0:4b2:b4a1:593f with SMTP id
 w4-20020a1fc604000000b004b2b4a1593fmr599469vkf.12.1701880738877; Wed, 06 Dec
 2023 08:38:58 -0800 (PST)
MIME-Version: 1.0
References: <20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com>
 <20231206-rb-new-condvar-methods-v1-2-33a4cab7fdaa@google.com> <096b7406-b57c-4daa-9a12-38338dbd91ef@gmail.com>
In-Reply-To: <096b7406-b57c-4daa-9a12-38338dbd91ef@gmail.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Wed, 6 Dec 2023 17:38:45 +0100
Message-ID: <CAH5fLgix=tV6=VvACx6mhSTe9_HiVjxdgGdt+5iTUJuGH6t_LA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: add `CondVar::wait_timeout`
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 4:53=E2=80=AFPM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> On 12/6/23 07:09, Alice Ryhl wrote:
> > Sleep on a condition variable with a timeout.
> >
> > This is used by Rust Binder for process freezing. There, we want to
> > sleep until the freeze operation completes, but we want to be able to
> > abort the process freezing if it doesn't complete within some timeout.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > [...]
> >
> > +    /// Atomically releases the given lock (whose ownership is proven =
by the guard) and puts the
> > +    /// thread to sleep. It wakes up when notified by [`CondVar::notif=
y_one`] or
> > +    /// [`CondVar::notify_all`], or when the thread receives a signal.
> > +    ///
> > +    /// Returns whether there is a signal pending.
>
> Remaining jiffies or zero on timeout?

Seems like I just copied this typo from the other `_internal` method.
I'll fix it on both.

Alice
