Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E85754A4E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGOQ7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGOQ7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:59:42 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7622722;
        Sat, 15 Jul 2023 09:59:22 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-57712d00cc1so30567937b3.3;
        Sat, 15 Jul 2023 09:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689440362; x=1692032362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkwKqDqMbkOtqWw6yFwVR4kegIXKrWTAIScvGbyU1jU=;
        b=BnKtNdjVlvkMnku5NkPqRILy+GJTt9XtV71MlRnY3ZMlwG5fiLUlDNQlF7nbqEiJEM
         q2TNWePtkNf5MhwNDRwwl/3xmlm14pxsZpxMF/GhxrKb6Y359fXbfzSPsJVF3L+T3oSG
         GllIfhQLKJv9UNrPePC3oJD06D3edmunbmpTnBFlY+3KJMF9Cmi/gbb3Gx2cMQGtg1oL
         rxKwYNloi7wy/QAEynPlaPL8GKTnjWWwT78oB8wADtEqITLdzd6wr27/WnyfFIwsSkLv
         PEezrz6/PaWc77cuKb1O4Tazs8YURv0UJvMSYmdT0H7p/dHpYQ6ZtohUyGYjzTTxuOGm
         C+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689440362; x=1692032362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkwKqDqMbkOtqWw6yFwVR4kegIXKrWTAIScvGbyU1jU=;
        b=ctukUJmDNhXuhyVqcvDqhfip9qB5Q9OaJwpdWR9Jnd0DFxudeE3xXgmeMn9+WIXMeG
         xbUA1CqDLhU0j9/G+vd9hNlnoaYqAtfYImITUedOu1CPyA6sI7/3c/1Vsa8DpWesB9Jd
         LrrRQ9Jeli21CvUeeo0RpVIYkMbDHZ+4iNvluhPKZtFjFxIIHsSXCZdZk5/LI1LZ+cB5
         rId1rEfRKI1kHUToNFgd11MojjW+E8FyGWYKEthlM8vbkZG+hXCN3rND9Q8QC7pdJP2d
         XksOeEph736OEiQ5/aOf79t+E7rT8Wrk6J/0VblRTLsr15O24PHbZpujNqTrS8/BuZkP
         56yA==
X-Gm-Message-State: ABy/qLbMSytdBXLiMV3xqUg/nR+42h5tqbt8UjqTtkj5n4HtHyBq5wgo
        fpCJptici2iCwzSyaPXt7/t5JXTjhe9yYxsjczA=
X-Google-Smtp-Source: APBJJlFVGtaUmqAi43kd066x0bqQrwFhsufRYqWIwN/DGWquGg6EhdjPi0kmVIJV959ppuVAmflb+rDlM2qkbVsu9Zk=
X-Received: by 2002:a81:6306:0:b0:57a:3dd8:1038 with SMTP id
 x6-20020a816306000000b0057a3dd81038mr10194872ywb.12.1689440361767; Sat, 15
 Jul 2023 09:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230714-rust-time-v2-1-f5aed84218c4@asahilina.net> <20230714100525.2192448-1-aliceryhl@google.com>
In-Reply-To: <20230714100525.2192448-1-aliceryhl@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 15 Jul 2023 18:59:10 +0200
Message-ID: <CANiq72=NkgtT+mO4YUoqcNx3cXM1G2nJ2Y4rXihdT0paqW2QYA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: time: New module for timekeeping functions
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     lina@asahilina.net, alex.gaynor@gmail.com, asahi@lists.linux.dev,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        gbs@canishe.com, heghedus.razvan@protonmail.com,
        jistone@redhat.com, jstultz@google.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, sboyd@kernel.org,
        tglx@linutronix.de, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:05=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> In that case, you should explicitly use `.wrapping_sub` instead to
> convey your intent.

Also to prevent extra code and panics with `CONFIG_RUST_OVERFLOW_CHECKS=3Dy=
`.

> I guess you could also use `abs_diff`, which takes two i64s and returns
> an u64.

I think `abs_diff` sounds best. It introduces an extra branch in its
implementation from what I see, though...

However, since it is the same branch that Lina does for returning
`None`, it should be getting removed. At least in a quick test, LLVM
generates the same code: https://godbolt.org/z/61rafzx71

Cheers,
Miguel
