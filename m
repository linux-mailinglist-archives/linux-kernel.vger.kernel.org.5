Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4663C77FCCF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353882AbjHQROt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353955AbjHQROk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:14:40 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2472E30C5;
        Thu, 17 Aug 2023 10:14:32 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-58e6c05f529so486987b3.3;
        Thu, 17 Aug 2023 10:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692292471; x=1692897271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qX4G/OI6N2BYYRxDPA8JDeQVrYSPjpWaqZt/JBYrZs=;
        b=omLREJo8UuQXEtOo+S3FkqpftCB/gC/4AiW72jvQdJSMVPbfwYBiZ2pOT8NM2Mb5kA
         Bu3GT9tyi2gWO1yOOSjEsjhC8joxak8nCo6F9YK04CKI/ncLxMFs1fOm5qnCrRLFScnj
         NvowKOE7N0dqsb77RJjjVm6b8MO1SigOZa4wB1ykpE8skHlQv20g6WHAHP6ZW1Po1/Nx
         nYawNU3qWqDr2Aqe7fb5szwNFjeUNhmDqU/CHHaml1zCSxDMysYflPZH8huy4EV3l4xV
         mfyhI8V38bNdNoMPGB/Agx4gG8tZZnaLMffXK8vZJRUeKDF8TdR86UQ4agv3y8hHBWW3
         zXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692292471; x=1692897271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qX4G/OI6N2BYYRxDPA8JDeQVrYSPjpWaqZt/JBYrZs=;
        b=dq8Pg3ZJOPS0HwwYL+pvjNBv4+dOJIYGmqFMV0x8tk1/YLT9vMF9LxsjQ64PghcT/r
         w8jBJy8p7vNeNiIcvYqYQJJ4TTebuh5nLI9tE7c9ZjHkIt96Q4ElUquCXdsc9PVM0wnf
         4u6OwbkvOAyxP59FLc0AqRKABWSf1c/SkZ+uNv8T4kfz2vLsVeK08QGfZRwdbyeteMe9
         wLILuzRud1qSLszyqs+SHEC3k0a/wLYW5bq0gbhU8V5vZ5oj8p1tBOLQdynW/kcXMIFp
         npxsgxhQMh9hX5JWrqwQ5MNjNw7tcgGGU7BJdtrojMzVBODmvIdpvrzIvQ45qbakonzm
         TWNw==
X-Gm-Message-State: AOJu0YxEXqOPVEG9HbsQmO3HXF01wSh3d05frA+qAKyMnq2O39Ws8e4l
        jwOeXcNJsa0VETC+OY6R1Wnofr/zh6hFmDq5BKs=
X-Google-Smtp-Source: AGHT+IH2YMvFrKGCpJObtd+Jujx79UtRUHSU/oEY13hy1nwxFRasaZpMthnsdU1lAivOcInwYJWkXZpUNLSgzC70u4c=
X-Received: by 2002:a25:d10a:0:b0:d12:3108:f931 with SMTP id
 i10-20020a25d10a000000b00d123108f931mr133018ybg.56.1692292471238; Thu, 17 Aug
 2023 10:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
 <2023081411-apache-tubeless-7bb3@gregkh> <0e91e3be-abbb-4bf7-be05-ba75c7522736@lunn.ch>
 <CACETy0=V9B8UOCi+BKfyrX06ca=WvC0Gvo_ouR=DjX=_-jhAwg@mail.gmail.com>
 <e3b4164a-5392-4209-99e5-560bf96df1df@lunn.ch> <CACETy0n0217=JOnHUWvxM_npDrdg4U=nzGYKqYbGFsvspjP6gg@mail.gmail.com>
In-Reply-To: <CACETy0n0217=JOnHUWvxM_npDrdg4U=nzGYKqYbGFsvspjP6gg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 17 Aug 2023 19:14:19 +0200
Message-ID: <CANiq72=3z+FcyYGV0upsezGAkh2J4EmzbJ=5s374gf=10AYnUQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Rust Socket abstractions
To:     Michele Dalle Rive <dallerivemichele@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Davide Rovelli <davide.rovelli@usi.ch>,
        rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
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

On Thu, Aug 17, 2023 at 4:53=E2=80=AFPM Michele Dalle Rive
<dallerivemichele@gmail.com> wrote:
>
> The idea behind this patch is that, as of now, Rust is not a viable optio=
n for
> any OOT module that requires even the highest-level network support.
>
> I am wondering whether the `net` subsystem is interested in reviewing, gi=
ving
> feedback and eventually accepting code that is currently OOT-only.

It is unlikely kernel maintainers in general accept code intended for
out-of-tree modules only.

To be clear, Rust for Linux's focus has never been out-of-tree
modules. In fact, the whole effort since the beginning was about
adding support for Rust in-tree, unlike other projects that e.g.
linked `rustc`-built object files into an out-of-tree kernel module.

We do support out-of-tree modules, and have a sample of that, but that
is just only to the degree that the kernel supports out-of-tree
modules in general.

The abstractions that have been upstreamed so far are those that have
(or should soon have) a user in-tree. Sometimes we have had to bend a
bit the rules in order to split the dependency chain or make things
easier, but abstractions (in general) cannot be upstreamed that do not
have at least an expected and public user that is going upstream too.
Here, by user, we generally mean an actual driver or useful component
(rather than a sample).

If I understood correctly from Zulip, you cannot (right now) show your
use case because it is confidential and therefore you cannot upstream
it, so we will need another user (and, of course, that is a necessary
but not sufficient condition for the code to be accepted).

> Also, it would be interesting if you could provide us any module or
> functionality you are planning to get in-tree which might use this interf=
ace;
> it could be useful in order to understand the applicability of these
> abstractions and find a concrete in-kernel use-case.

I think it is easier if it is the other way around :) That is, the
people/companies that already have a use case for the abstractions
should come forward and publish them so that the abstractions are
justified.

Of course, this does not preclude discussing about them or having a
`rust-net` branch or sub-subsystem or similar. That could be quite
useful so develop those users and to experiment. In fact, we are
actively trying to onboard more people (and companies and other
entities) to the Rust overall kernel effort, so please feel free to
join us.

> I included in the email a couple of sample OOT modules that showcase the
> functionalities of the socket API; they will be attached as an actual pat=
ch if
> there will be a v2.

The sample should not be an out-of-tree module, it should be an
in-tree one. However, for upstreaming, just a sample is likely to not
be enough for most kernel maintainers, as mentioned above.

By the way, I am a bit confused -- the patch seems to add an in-tree
sample, not an out-of-tree one.

Cheers,
Miguel
