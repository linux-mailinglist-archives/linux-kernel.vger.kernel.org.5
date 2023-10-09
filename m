Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7047BEA63
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378322AbjJITOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346660AbjJITOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:14:52 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D43F8E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:14:49 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a2379a8b69so59610347b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 12:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696878888; x=1697483688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJkxWpfY6BylSbHsECCWxvdWvw5Xy177dBQc6H0SaVM=;
        b=hXWoJyQLgoTUKPLXUo0OsDP6QlHu+vpi6ZjXxufvB4kQ0fcr2pH1yOq+jbv0/u1Oyz
         b3910Jb5UJoKX7LExSy0W6hOT0JggAFRON3VcZSS+IZzOTH86I+LA0y27PR4DHiglOZM
         rLX24z9JaBfPsV9c0NrlYssTzYTn23F2mQQXQjrnQMxrHjk/ylh/aGK23qk9ybyaD5tr
         CbvqwVWN9HhQr2X1HXBhDkfl4fkjx2xzTWP73ld95iJadqtXzxHDL4i2ES9CYdnC5K8S
         2fY9dGy79C8KbMzwsS6cseWJwNmqz/OJEy23WHNCYG7Uc5ECvWuMDcpkyCsyYKzNf/C8
         Zjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696878888; x=1697483688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJkxWpfY6BylSbHsECCWxvdWvw5Xy177dBQc6H0SaVM=;
        b=d78zF6ZwFZnKXLqyMyCXWRemWdCtCbAtauwVzn3psMfAj8b6fUXKzYWHaTwvVmRF2a
         2HV023etGaTyeLvZ8gvYvoKbq6l6ntbq8bVz/21v4qX5aA9jMhqtB+wYHCz91ehPnQ42
         T6PaIRQmuZjgZbpo0kz/EYgDHA5aAw4QgAbg43tlhZ8bVu2NNKboSF+4l+9jdhzp3GcU
         vXTiz7QvceX2It96+dNePDEYFhet7cOsRfOnAqlpMEqs0YE5vbH3wvIP1uL5f9nIQaW5
         Bt5DtReIWCcZ0DNJSeWrgJsrmjc9edrqNAY3dinqIYLV8nNCOOjMpH8U4s/jbGOVcO4p
         zc/A==
X-Gm-Message-State: AOJu0YzFjJbYILfv0JxP54Lb/Vp6ajvlUiGzvy3PsExVLKZpZ/WI1m5K
        9J7kceecjPiEFpQ9ZPXVpO5LO/hd+ys9KEaKO33JiQ==
X-Google-Smtp-Source: AGHT+IGoOGPmyv61/skaGAXztPhoFbdiRTQNoHUWul1/cEM2B5AjDtUCSOLoHBtqQYYPCDEmcZ2ozReE5JYRpwKHe1g=
X-Received: by 2002:a81:9c14:0:b0:598:5bb5:1801 with SMTP id
 m20-20020a819c14000000b005985bb51801mr14787290ywa.50.1696878888662; Mon, 09
 Oct 2023 12:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231008094816.320424-1-tmgross@umich.edu> <8a6a2133-92a0-4478-8f3a-e1c7ba38ff18@gmail.com>
 <CALNs47vj=whnF1FcmmXHz=msB2j=GAnrnwx-OKHciW6iR+GUMw@mail.gmail.com> <CANiq72mn3f1w0RZo58BrzDuDHjcGNyBr3FhygVGfSx_xbYwgLg@mail.gmail.com>
In-Reply-To: <CANiq72mn3f1w0RZo58BrzDuDHjcGNyBr3FhygVGfSx_xbYwgLg@mail.gmail.com>
From:   Trevor Gross <tmgross@umich.edu>
Date:   Mon, 9 Oct 2023 15:14:37 -0400
Message-ID: <CALNs47v9Vk14Up2MMQsqZGtGzbvyA+b7QB_nmTH05zSBpbyxJg@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: update 'paste!' macro to accept string literals
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 6:49=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Oct 9, 2023 at 5:04=E2=80=AFAM Trevor Gross <tmgross@umich.edu> w=
rote:
> >
> > Good point, thanks! I'll add that if there is a v2 (or Miguel can
> > probably add it if not)
>
> Yes, I add them myself when I notice they are missing (e.g. most
> recently 2 of the ones in `rust-fixes`), but patches should definitely
> come with the `Fixes: ` tag themselves, i.e. it should be the
> exceptional case.
>
> However, is this actually a fix? The title and commit message make it
> sound like it is a new feature rather than a fix. And the docs of the
> macro says literals are not supported, right?

I suppose it is something that augments current behavior and "fixes"
the linked use case by making it possible. I am not sure what
qualifies as a fix.

> So this probably needs to update those docs too (and ideally add an
> example with the newly supported construct too). Or am I
> misunderstanding?
>
> Cheers,
> Miguel

I will update the documentation, thanks for the catch.
