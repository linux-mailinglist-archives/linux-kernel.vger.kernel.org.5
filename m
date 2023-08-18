Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD69D780C03
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359557AbjHRMm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376976AbjHRMmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:42:43 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B463AAF;
        Fri, 18 Aug 2023 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=0jubvQH8s1Fv3I0hA9yIVmKUUm71HOUT3IKIhSEZ3X4=; b=FkjGN3Mt84nVTJEssTzZgpuMqS
        IONqYjZCL0Tb9PIidAXYLXAavuj7MYtwicOS31Cfq3fTRVebeWUPIwJ1lVzgwWgfsJTPMtnoyeDBx
        RSqcSEOSaFOEcaw+r9r50ptK/vj3zUzHZGXmdreXyb7HUgmOgXZCJxL0pJCqzaIi+ffw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qWyo6-004UYT-Rv; Fri, 18 Aug 2023 14:42:26 +0200
Date:   Fri, 18 Aug 2023 14:42:26 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Davide Rovelli <roveld@usi.ch>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michele Dalle Rive <dallerivemichele@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Davide Rovelli <davide.rovelli@usi.ch>,
        rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC PATCH 0/7] Rust Socket abstractions
Message-ID: <c61a60ef-fa9d-44ea-9852-ae7b18bc1ab1@lunn.ch>
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
 <2023081411-apache-tubeless-7bb3@gregkh>
 <0e91e3be-abbb-4bf7-be05-ba75c7522736@lunn.ch>
 <CACETy0=V9B8UOCi+BKfyrX06ca=WvC0Gvo_ouR=DjX=_-jhAwg@mail.gmail.com>
 <e3b4164a-5392-4209-99e5-560bf96df1df@lunn.ch>
 <CACETy0n0217=JOnHUWvxM_npDrdg4U=nzGYKqYbGFsvspjP6gg@mail.gmail.com>
 <CANiq72=3z+FcyYGV0upsezGAkh2J4EmzbJ=5s374gf=10AYnUQ@mail.gmail.com>
 <bddea099-4468-4f96-2e06-2b207b608485@usi.ch>
 <0ba551eb-480e-4327-b62f-fc105d280821@lunn.ch>
 <c9c63da7-bc8a-7307-63f1-1f393b017da2@usi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c63da7-bc8a-7307-63f1-1f393b017da2@usi.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 09:50:45AM +0200, Davide Rovelli wrote:
> 
> 
> On 8/18/23 03:30, Andrew Lunn wrote:
> 
> > So you have an application in user space wanting to use this
> > protocol. I assume it is using BSD sockets to communicate with the
> > kernel and the protocol.
> 
> No, at the moment it uses procfs or a shared mmap'd chardev buffer.

O.K, so that will never be accepted. There is support for zero copy in
sockets. Look at the work Eric did. And you should look at netlink,
which might be needed for the control plane.
 
> > So you need an API below sockets to get this
> > traffic, i assume a whole new protocol family? But you have an API on
> > top of sockets for TCP/UDP. So i guess your protocol somehow
> > encapsulate the traffic and then uses the API your are proposing to
> > send over TCP or UDP?
> 
> Yes, we take a message/value from a user space app and send it to
> other nodes via UDP according to the chosen protocol. Mind that
> the term "protocol" might be misleading here as it can be confused
> with classic network protocols. Our API offers distributed services
> such as failure detectors, consensus etc.
> 
> > Which makes me think:
> > 
> > Why go through sockets twice for a low jitter networking protocol?
> 
> The idea behind the system is to be split: user space apps are
> normal apps that can present arbitrary jitter, kernel space services
> are isolated to provide low jitter. The same applies in the network
> via a SDN based protocol which prioritises our traffic. By having
> end-to-end timely communication and processing, we can achieve
> new efficient distributed services.

Having the services running in kernel space is going to limit what
services you can actually offer, if you need to go through getting
them merged every time. If you only have one or two, yes it can be
done. But anything general purpose is not going to be practical.  The
answer might be to write your services using eBPF. They can then be
loaded from user space and do pretty much anything which eBPF can do.

There is often a huge step from academic code to production
code. Academic code just needs to implement enough to prove the
concept. It can take all sort of short cuts. Production code to be
merged into the kernel needs to follow the usual development
processes, code quality guidelines, and most importantly,
architecture.

If you want to make that step to production code, we can help you, but
i don't think it makes any sense to merge API code until you have the
correct basic architecture. That architecture will define what APIs
you need, and sitting on top of sockets might not be correct.

	Andrew
