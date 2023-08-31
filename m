Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F289D78E730
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjHaHaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjHaHaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:30:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954D21BB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:30:01 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf092a16c9so3823215ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1693467001; x=1694071801; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kHkD8InmtdxNYFBphrJMG48olpat1cNrjKg/T++oikw=;
        b=X2LJhVLDLe3qiBlg6znrNnaI62Id/93YkpkURgRh3gEty6ipgaRXVK/bZIy7KA2JHL
         7CqZfO+R7upsJaReVacXqxYhFSWyjS2uTl2PFkerymU9wuobdqp0nRleNM8V+GO6ROT1
         Seg9vo2SNrxpCSUACFD5RCX0kU4sKFCmGke3soI0bQeglm02KGiHiAt62dBMVR6O/Dx0
         cHJysZpTc0KMZHesn4KDuqxlx3JCM8FLskTtYa+HCwSnsrYvMvNCOgUw614bP39G2rGM
         MWFCuT0fgaICHCoEM+SCeJ2WgVjtcMq8+9M/jQ3fNDVijtWbc7BhfVC3+0gQxvhRPAkj
         kLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693467001; x=1694071801;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHkD8InmtdxNYFBphrJMG48olpat1cNrjKg/T++oikw=;
        b=kXlemzYMZoXxpQwL1M1H523jlW9tp5mDJQiKwHgjUI3o4w8RfMAnwrsNlXliSDUQji
         mlYYESowrEOK2dYCeuPtxZntIV6sHgAmiQnQOs/7Kex+5Odsh9N6ZRk2b1MfXl/JmGQ3
         9/+fLAlzHgbJhYU2f2KGK4y9I+/Yz4mpd+1fw4qVw4UR6dlEEFmEzPVf0k2liT5ZFyBd
         bCHuEVJ93v3k36SUMph6BYCGfBzn87q6jDOjQooBcpcEfhqYsUIePAOFL75V0926O6RX
         BB7CIgS4C1VyGtO48fiI7BYULTBeca1VliKKbljmBpb/LbNgSnkHubOYMxraf/zuFTib
         zwNg==
X-Gm-Message-State: AOJu0YyY0qhyn+2Ra3wVnm90FAkOWVUrZZ3vKPE0F+KA3Cw0K7GUZr/Q
        GUMgpWSAAEmd+/QDgQvLTKWzqQ==
X-Google-Smtp-Source: AGHT+IE5O2NqR8s3cBctEV1BFg7RgqUoh1WdEYsOUTORcefwrWw6BJhLjj6CuS6Bcy8/aQitmNUHGw==
X-Received: by 2002:a17:902:d4c9:b0:1c0:d777:3224 with SMTP id o9-20020a170902d4c900b001c0d7773224mr4655799plg.50.1693467000995;
        Thu, 31 Aug 2023 00:30:00 -0700 (PDT)
Received: from medusa.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id ji5-20020a170903324500b001b80d399730sm647892plb.242.2023.08.31.00.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 00:30:00 -0700 (PDT)
Date:   Thu, 31 Aug 2023 00:29:57 -0700
From:   Mohamed Khalfella <mkhalfella@purestorage.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     willemdebruijn.kernel@gmail.com, alexanderduyck@fb.com,
        bpf@vger.kernel.org, brouer@redhat.com, davem@davemloft.net,
        dhowells@redhat.com, keescook@chromium.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, willemb@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] skbuff: skb_segment, Call zero copy functions before
 using skbuff frags
Message-ID: <20230831072957.GA3696339@medusa>
References: <64ed7188a2745_9cf208e1@penguin.notmuch>
 <20230830232811.9876-1-mkhalfella@purestorage.com>
 <CANn89iJVnS_dGDtU7AVWgVrun-p68DZ0A3Pde47MHNeeQ2nwRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJVnS_dGDtU7AVWgVrun-p68DZ0A3Pde47MHNeeQ2nwRA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-31 08:58:51 +0200, Eric Dumazet wrote:
> On Thu, Aug 31, 2023 at 1:28 AM Mohamed Khalfella
> <mkhalfella@purestorage.com> wrote:
> >         do {
> >                 struct sk_buff *nskb;
> >                 skb_frag_t *nskb_frag;
> > @@ -4465,6 +4471,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
> >                     (skb_headlen(list_skb) == len || sg)) {
> >                         BUG_ON(skb_headlen(list_skb) > len);
> >
> > +                       nskb = skb_clone(list_skb, GFP_ATOMIC);
> > +                       if (unlikely(!nskb))
> > +                               goto err;
> > +
> 
> This patch is quite complex to review, so I am asking if this part was
> really needed ?

Unfortunately the patch is complex because I try to avoid calling
skb_orphan_frags() in the middle of processing these frags. Otherwise
it would be much harder to implement because as reallocated frags do not
map 1:1 with existing frags as Willem mentioned.

> <1>  : You moved here <2> and <3>

<2> was moved here because skb_clone() calls skb_orphan_frags(). By
moving this up we do not need to call skb_orphan_frags() for list_skb
and we can start to use nr_frags and frags without worrying their value
is going to change.

<3> was moved here because <2> was moved here. Fail fast if we can not
clone list_skb.

> 
> If this is not strictly needed, please keep the code as is to ease
> code review...
> 
> >                         i = 0;
> >                         nfrags = skb_shinfo(list_skb)->nr_frags;
> >                         frag = skb_shinfo(list_skb)->frags;
> > @@ -4483,12 +4493,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
> >                                 frag++;
> >                         }
> >
> > -                       nskb = skb_clone(list_skb, GFP_ATOMIC);
> 
> <2>
> 
> >                         list_skb = list_skb->next;
> >
> > -                       if (unlikely(!nskb))
> > -                               goto err;
> > -
> 
> <3>
> 
> >                         if (unlikely(pskb_trim(nskb, len))) {
> >                                 kfree_skb(nskb);
> >                                 goto err;
> > @@ -4564,12 +4570,16 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
> >                 skb_shinfo(nskb)->flags |= skb_shinfo(head_skb)->flags &
> >                                            SKBFL_SHARED_FRAG;
> >
> > -               if (skb_orphan_frags(frag_skb, GFP_ATOMIC) ||
> > -                   skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
> > +               if (skb_zerocopy_clone(nskb, list_skb, GFP_ATOMIC))
> 
> Why using list_skb here instead of frag_skb ?
> Again, I have to look at the whole thing to understand why you did this.

Oops, this is a mistake. It should be frag_skb. Will fix it run the test
one more time and post v3.
