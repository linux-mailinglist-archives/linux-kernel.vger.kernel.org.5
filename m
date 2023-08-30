Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4723978D295
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241818AbjH3Dov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240661AbjH3Dob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:44:31 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016AD1B0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:44:28 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4036bd4fff1so187861cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693367067; x=1693971867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jer61DAaUrTDR+SwmVVUg+r+KPj9qeJLbgBsssAgRXk=;
        b=o1lC2CAzVbqi9EN0i3nOT8lZz/k4so/6dDpdR3zIchGVk3v4QMG0iM7IL0fK1UXpyO
         YrDfShOFQXZ5KYlODZK72srvr/HGv0UiFgdjuuJB0xBrMz1/d5pRNgm+WVmdLA8+7i+e
         qDk1Alq7vuwywxksgnJSTfnkZ6qV5TOOGrwMOmHKsolmAQAEv30ro7E4NUkhwHgKwjVf
         /t0UQC9CfxNu07dP7mP31SiPdthZWo39y+ujf+h2fIMxcX6J4D9BIIbKpGh9JPTDmYD6
         dVlioQSPT0h53rGzoIoAopMV8n3jObh8oGXUUAjcHcyMuSkr3xmbbrGibWpNXMtH6BZ9
         dLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693367067; x=1693971867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jer61DAaUrTDR+SwmVVUg+r+KPj9qeJLbgBsssAgRXk=;
        b=CfMcrK3PF+0Xpz26Tq//iUWQ0Ck5JVyJzAt05BK1PBldG0Rw9wYGs/Gl4KjYKiS8La
         2WrxMlQdxSZFfNumo1UrpPsIfpohbhLlWC80IAK3gB3cQOVkeBrdDGBrTsq906SlBWlr
         Hz4YL9kPTEmqSoY3i+5oYxDdg+UpoaNZXfoxbxid5ta13W6sFpO39rqwaCAAI0AQ7Kk2
         67i6uKA7tBhbhBcqy/VwE0r+eVvGm/KnTOICqBYzdQv+pEselS1Klsq5v6yHSkxgLoku
         29rS388jr3xLWMv6jVximlOHPgCMDfZX9DbjqlA3qx8TGr2yPV5iiBV/UnHhQ3+yt7UW
         3UgQ==
X-Gm-Message-State: AOJu0Yz3Gj3q1OD+jlclJ+JrSpi0wLka7ZEdvCE9JdQ9vXEITsM3NdL2
        i+XlZssN+bj8+0T7/NCdgv0yrh0CfN15cpEdLTMjSQ==
X-Google-Smtp-Source: AGHT+IE4GK4wJT4oisQbhyI+jQmldyVAMNSAPb4UnLZig/NheUo25tu9HPU1ry6SGYmSB1eTupRTOb5thEY/GXj6Izw=
X-Received: by 2002:ac8:7d91:0:b0:410:385c:d1e0 with SMTP id
 c17-20020ac87d91000000b00410385cd1e0mr364023qtd.25.1693367066914; Tue, 29 Aug
 2023 20:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230828233210.36532-1-mkhalfella@purestorage.com>
 <64ed7188a2745_9cf208e1@penguin.notmuch> <20230829065010.GO4091703@medusa>
 <CANn89iLbNF_kGG9S3R9Y8gpoEM71Wesoi1mTA3-at4Furc+0Fg@mail.gmail.com>
 <20230829093105.GA611013@medusa> <CANn89iLzOFikw2A8HJJ0zvg1Znw+EnOH2Tm2ghrURkE7NXvQSg@mail.gmail.com>
 <20230829222418.GB1473980@medusa>
In-Reply-To: <20230829222418.GB1473980@medusa>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 30 Aug 2023 05:44:15 +0200
Message-ID: <CANn89iKHTaiqyBohSd3sRJJwG1CUD2M_vy6gwLjW=U4VS3EJtQ@mail.gmail.com>
Subject: Re: [PATCH] skbuff: skb_segment, Update nfrags after calling zero
 copy functions
To:     Mohamed Khalfella <mkhalfella@purestorage.com>
Cc:     willemjdebruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        David Howells <dhowells@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BPF [MISC]" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:24=E2=80=AFAM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> On 2023-08-29 12:09:15 +0200, Eric Dumazet wrote:
> > Another way to test this path for certain (without tcpdump having to ra=
ce)
> > is to add a temporary/debug patch like this one:
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index a298992060e6efdecb87c7ffc8290eafe330583f..20cc42be5e81cdca567515f=
2a886af4ada0fbe0a
> > 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -1749,7 +1749,8 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp=
_mask)
> >         int i, order, psize, new_frags;
> >         u32 d_off;
> >
> > -       if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
> > +       if (skb_shared(skb) ||
> > +           pskb_expand_head(skb, 0, 0, gfp_mask))
> >                 return -EINVAL;
> >
> >         if (!num_frags)
> >
> > Note that this might catch other bugs :/
>
> I was not able to make it allocate a new frags by running tcpdump while
> reproing the problem. However, I was able to do it with your patch.

I am glad this worked, and looking forward to a v2 of your patch, thanks !
