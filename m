Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420D77AB988
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjIVSpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjIVSpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:45:41 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DDDB9;
        Fri, 22 Sep 2023 11:45:35 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59c0281d72dso31432327b3.0;
        Fri, 22 Sep 2023 11:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695408335; x=1696013135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/RXg7qoPV29Yjmc4Aum7okgMz0oycXOx15sVeIcRmM=;
        b=c8xGCiNh42xlD3RgXriO06cl8/WOztLGxAeV/LHN0gH5RAQm9eDDvLKJzhhvnd48BC
         aHmmen3es2ZekPjTrWLG3U0iWX4cISMMIuwxCUtbZPuPUDvdMKHFLXfx11xtn4RoKrXQ
         t65GLuXXaTSGZQ6+STHjED9nFW2NgQfTXRDDkTKMVOxLop+xYriqIUSBcOTOprQZgd9R
         D1Bix1D3JfCmS9Mvg/fzVwDhKftSnHj1s1oP7dzSPSsoILuyzuelUVNaTIXlmgDkIORK
         f+aObheFPpVidLn2ofITcYS2kEGUhzlk5jvCZ52f8yNJaxV2XNA8hE52UAgxC1knkRMS
         +1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408335; x=1696013135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/RXg7qoPV29Yjmc4Aum7okgMz0oycXOx15sVeIcRmM=;
        b=aW46rhVbcTURyCgF3lQejRTv1QRkHssESYe8ZhOr50tICHE+kHX6kpGSdmqjE1BHd+
         OBRAD0vbAi9rBzKy6iTc1AVIYU8hBT5rdsh8d05Pqc5uIfxex32YPkh5rlz3EuV8jBCd
         KBOICB/1yAZfUpG/+NIz94ctf/uG7w7UuNydxV/WCdSOLXWglz3FEknMvC4RQcWTAsUl
         oQAM2RSc98dpc4q6Zklkc/uyWn5foZRWC8g2eMRdPXPWIhezw6gkr0dzEyvGdJpjxEyn
         VlKHzMl1xEzGaNDo6UY2OvkoATNC/lWz1mfoPEwWScKlHvFLIQt/wF0AAlpU7e0+8lkA
         jSUg==
X-Gm-Message-State: AOJu0Yyvznd666GDAMzJ6VUP6nD3F3dd4RHQpaXCGoZ/E4fD4PlQVE8I
        WSXNCwZbUBR5UZ2i1PBMkWIBU94O5ac1bAjLleePk3TW3Cv9CicZ
X-Google-Smtp-Source: AGHT+IEJGuXkGoE5AoXH2Ej5LLIiwCK3pJP5rkiNaJ+MP8w/xC9pPc/vjysUkvkG7okFXh2JN6w+5WqePXRZgsUvips=
X-Received: by 2002:a0d:c084:0:b0:59b:1763:bff9 with SMTP id
 b126-20020a0dc084000000b0059b1763bff9mr606135ywd.49.1695408334726; Fri, 22
 Sep 2023 11:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230830165949.127475-1-ojeda@kernel.org> <ZO+CBdxxuDBrdDR8@gpm.stappers.nl>
In-Reply-To: <ZO+CBdxxuDBrdDR8@gpm.stappers.nl>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 22 Sep 2023 20:45:23 +0200
Message-ID: <CANiq72kMS8UoYpg0hW1=UDAAkytEoeyqGzg+Sys8VSaucr+HzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: update Rust webpage
To:     Geert Stappers <stappers@stappers.nl>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 7:53=E2=80=AFPM Geert Stappers <stappers@stappers.n=
l> wrote:
>
> It looks like "mdbook" and "webbrowser view-source" confirms it is.

Yeah, it is, with some pre- & post-processing to add some extra features.

> Where to find the source for the MarkDownBook?

It is now published at https://github.com/Rust-for-Linux/rust-for-linux.com=
.

> Reviewed-by: Geert Stappers <stappers@stappers.nl>

Thanks!

Cheers,
Miguel
