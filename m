Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0780729F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378975AbjLFOj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378970AbjLFOjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:39:24 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A844DD5B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:39:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso9450a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 06:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701873569; x=1702478369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tW4rpGHQhN9YNVTV5oiqqcaigarX5iDMhMQO+9Q6sBI=;
        b=0kvVHlQkWbFbLJ/N6mDI4+2NwPNiFc1a1bqcH8YyRBUQQnRM33ptdGgPouOmKzj+vM
         31mSR5wENDfbI9HdVmVFXn10nAvx7T9AE8e0dl5QPz4CrYm1zQ80eoKbeir1dM6feypY
         RMuX71mOq0zXtYG7YtLaFvqKaAiwza/AYqltw8gL2Pi4bvaBbslUEQdMHDHjTuKs6R73
         XpixfnL86MnfuWBppF9Whr77kuDbZnn37OTaWF9QE8B+gQs+YMCJVnaDOqfZLaukZ/RJ
         FgxefBeVtvx4Vrr/bKufL1uayeOXrVHP5IUvuKhoqk3W79hoThx3IDTJl0zPa8QZTcJw
         zlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701873569; x=1702478369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW4rpGHQhN9YNVTV5oiqqcaigarX5iDMhMQO+9Q6sBI=;
        b=raGxpx0tQLw8GP+t/2qN8P/xiPJXLfjUAK42No8VTZnoYCjOLk42x21XU/vA6IpanV
         NiCMrGkBxPnfsHuN7xtJE2av+vcsLaUv8vymKdZaZl16zt4+nIQFHYs6SKRtNPgwpmC/
         I15Iy3gpEh1hJ3haI1KO4tY5A7RkItojfsIZAJXR0g5jjnivV/GYpkPc3v0I/UlaRDBl
         Aehqt4WubgXF+UvPLaKDakjcx3gvUgcYd7YlDOgej/aaHftx7bZMyad1ja/Eb0oAaxs5
         5u8rDxyMIQXE0L7jbq96RbOLJoT0eeCDDDpjpQc6hebMapEHtL5k04h1QDN/ydDV8u0H
         Eu0Q==
X-Gm-Message-State: AOJu0Yz41x5yaiAdmauXolPd1yo1OepbCrSk4xxala9KVx5kEdiwj6pp
        kGcaOIe+zjiLvV5+El6hWQCJhRJFaj5LBq/XSoQqxA==
X-Google-Smtp-Source: AGHT+IHOApoAkKvH3wtbpKAIohGjJybdA9WJOGcJGuGDhFjsElRi+QiZLT+HeS9ho01lLQhVQILt1AqrvqJ5qf9gzrA=
X-Received: by 2002:a50:c35d:0:b0:54c:79ed:a018 with SMTP id
 q29-20020a50c35d000000b0054c79eda018mr96470edb.2.1701873568956; Wed, 06 Dec
 2023 06:39:28 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez0TfTAkaRWFCTb44x=TWP_sDZVx-5U2hvfQSFOhghNrCA@mail.gmail.com>
 <CAG48ez1hXk_cffp3dy-bYMcoyCCj-EySYR5SzYrNiRHGD=hOUg@mail.gmail.com> <20231206-refinanzieren-werkhalle-22db5334f256@brauner>
In-Reply-To: <20231206-refinanzieren-werkhalle-22db5334f256@brauner>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 6 Dec 2023 15:38:50 +0100
Message-ID: <CAG48ez07dJ_=KUzRONVhMmr2koW9PwiZ5KxMHfx8ERPA=j4cUw@mail.gmail.com>
Subject: Re: Is xt_owner's owner_mt() racy with sock_orphan()? [worse with new
 TYPESAFE_BY_RCU file lifetime?]
To:     Christian Brauner <brauner@kernel.org>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
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

On Wed, Dec 6, 2023 at 2:58=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Tue, Dec 05, 2023 at 06:08:29PM +0100, Jann Horn wrote:
> > On Tue, Dec 5, 2023 at 5:40=E2=80=AFPM Jann Horn <jannh@google.com> wro=
te:
> > >
> > > Hi!
> > >
> > > I think this code is racy, but testing that seems like a pain...
> > >
> > > owner_mt() in xt_owner runs in context of a NF_INET_LOCAL_OUT or
> > > NF_INET_POST_ROUTING hook. It first checks that sk->sk_socket is
> > > non-NULL, then checks that sk->sk_socket->file is non-NULL, then
> > > accesses the ->f_cred of that file.
> > >
> > > I don't see anything that protects this against a concurrent
> > > sock_orphan(), which NULLs out the sk->sk_socket pointer, if we're in
> >
> > Ah, and all the other users of ->sk_socket in net/netfilter/ do it
> > under the sk_callback_lock... so I guess the fix would be to add the
> > same in owner_mt?
>
> In your other mail you wrote:
>
> > I also think we have no guarantee here that the socket's ->file won't
> > go away due to a concurrent __sock_release(), which could cause us to
> > continue reading file credentials out of a file whose refcount has
> > already dropped to zero?
>
> Is this an independent worry or can the concurrent __sock_release()
> issue only happen due to a sock_orphan() having happened first? I think
> that it requires a sock_orphan() having happend, presumably because the
> socket gets marked SOCK_DEAD and can thus be released via
> __sock_release() asynchronously?
>
> If so then taking sk_callback_lock() in owner_mt() should fix this.
> (Otherwise we might need an additional get_active_file() on
> sk->sk_socker->file in owner_mt() in addition to the other fix.)

My understanding is that it could only happen due to a sock_orphan()
having happened first, and so just sk_callback_lock() should probably
be a sufficient fix. (I'm not an expert on net subsystem locking rules
though.)
