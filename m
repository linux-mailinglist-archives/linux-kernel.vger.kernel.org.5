Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39C677C216
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjHNVHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjHNVGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:06:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA925E65;
        Mon, 14 Aug 2023 14:06:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52364e9daceso6423414a12.2;
        Mon, 14 Aug 2023 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692047206; x=1692652006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BGnQRNiyVwSNbQlh18XOyksehaxGg2fPJZTp5rmqjrc=;
        b=hZy9jMAbJqx5t0whylgnWV3+kLvWLwn75nVX8i+sVfmXzgf2V+MQjfmsfVRUErdqD3
         BWL3R4tCdvPiGfsaYcod5T+8zgNKZvxmXEvjA4DGaoFwVzOuk30VvS6LwDj0s3MqZDEz
         6y3qQ37K65yj/lgncMXfmhgEPMTOqZBmWrJrPJ4ZrPG8GPFuXdmQ0myDE1e1QCqzt+DK
         UI3S4T40JH2BADgpT+1iU13CsH7Gwy0efEqBaDhrE8DiCV9pEhyiSofKuwxklmNivMjS
         x8eTubX0ZcN9+5xeSWyT7g5Cebv1wUmiyd1QUqaaEEMWHtzzN6gUb/LijcpU/G7Gm0c1
         T2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692047206; x=1692652006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGnQRNiyVwSNbQlh18XOyksehaxGg2fPJZTp5rmqjrc=;
        b=CByFCORvRMKnFjj7Gn2N1pwK2MnZMB18TpAI4kGltmkNgxq/E8gnXy/BcZRnMlw0y2
         2SXu9WQlUqN0rUVnp7NyzQsMbho76Tja8s8QryTJUux8FLgh4P0e3rY4M8XWJtzbK5u8
         9XDMSURsqaLPyMrpMsyBg5UINrWWSs37XXpW/8W10eey81U8HkFtE8GVC+X2/2AKbfa7
         RbcurdGFNMBY5+ipoXaR78412LlfWrPgbn+8kRhsYUwvppfgTiZM3lslm5jDhn0kAOYT
         odWDeH8hyGcQJfzAjoNHWqM5IdEq8pGWUzbU4OCdr2t6xWZaVmx6bi80hrDTzg47RPgt
         gHvw==
X-Gm-Message-State: AOJu0Yz+F/AJCeRZlBmi88qnezjTnZSYgphmWqH604KRLphxIlRFpj7k
        DAR/d51S10b9w2YgivHwksR9VRr9WF7eYLhRQxw=
X-Google-Smtp-Source: AGHT+IEgw1idU08AfDbthDkWP0ZE+35xEq4Rs685OP6MwdbFIqKicWP8OcHH9ADH2iu2pdS0K1x+C0mmzIyRFIyaFQs=
X-Received: by 2002:a05:6402:141:b0:522:b112:6254 with SMTP id
 s1-20020a056402014100b00522b1126254mr7482965edu.4.1692047205936; Mon, 14 Aug
 2023 14:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
 <2023081411-apache-tubeless-7bb3@gregkh> <0e91e3be-abbb-4bf7-be05-ba75c7522736@lunn.ch>
In-Reply-To: <0e91e3be-abbb-4bf7-be05-ba75c7522736@lunn.ch>
From:   Michele Dalle Rive <dallerivemichele@gmail.com>
Date:   Mon, 14 Aug 2023 23:06:34 +0200
Message-ID: <CACETy0=V9B8UOCi+BKfyrX06ca=WvC0Gvo_ouR=DjX=_-jhAwg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Rust Socket abstractions
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 at 22:23, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 14, 2023 at 05:25:49PM +0200, Greg KH wrote:
> > On Mon, Aug 14, 2023 at 11:22:55AM +0200, Michele Dalle Rive wrote:
> > > This patch series is intended to create Rust abstractions for Sockets
> > > and other fundamental network entities.
> > >
> > > Specifically, it was added:
> > > - Ip address and Socket address wrappers (for `in_addr`, `in6_addr`,
> > >   `sockaddr_in`, `sockaddr_in6`, `sockaddr_storage`).
> > > - Socket wrapper.
> > > - Socket flags and options enums.
> > > - TCP and UDP specific abstractions over the Rust Socket structure.
> > >
> > > This series is a RFC because I would appreciate some feedback about:
> > > - The structure of the module: is the division of the files and modules
> > >   appropriate or should it be more or less fine-grained?
> > >   Also, should the `net` module export all the structures of its
> > >   submodules? I noticed that it is done in the standard library.
> > > - Whether the documentation is comprehensive enough.
> > > - A few other specific questions, written in the individual patches.
> > >
> > > I would greatly appreciate any kind of feedback or opinion.
> > > I am pretty new to the patch/mailing list world, so please point out any
> > > mistake I might make.
> >
> > The best feedback is "who will use these new interfaces?"  Without that,
> > it's really hard to review a patchset as it's difficult to see how the
> > bindings will be used, right?
>
> There is a long standing tradition in Linux, you don't get a new API
> merged without a user.

Sorry for not being clear on that.

These abstractions are meant to be used by modules: having them, modules
can start using the kernel network functionalities through a first, high level
interface.

Since there is currently no network support in Rust, this patch series
represents a first step to provide access to networking to modules.
Sockets are just the highest layer of the network stack: the goal would be
to port structures deeper in the network stack, to give modules more
access to the network api. However, you need to start somewhere.

>
> There is not too much use of in kernel sockets. Network file systems
> like NFS, and SMB are one. These need to be careful with memory usage,
> you could be busy writing blocks out because the system is low on
> memory and trying to free some up, and asking for more memory might
> not work.  Sending kernel log messages to a server. But that needs
> care because of the different contexts it can be used in. Without
> knowing what it will be used for, it is hard for us the point the
> special considerations which need to be made.
>
> So please also let us see the code using this API.
>
>         Andrew

The lack of these abstractions was noticed in the context of a research
of the usability of Rust for the development of consensus algorithms using UDP.
Any kind of kernel module requiring network support can take advantage
of these socket abstractions, from a tcp echo server to any kind of complex
networking kernel module.

I could add an example kernel module in `samples/rust` showing an example
of usage of these APIs.

Thank you for your time,

Michele
