Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF6E7B5399
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbjJBM7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbjJBM7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:59:44 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A699AB7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:59:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so11614a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 05:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696251578; x=1696856378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQNNYMHbbXj3ScZMcNdV4XQ6wHyCHAuYoxBdko5O+4A=;
        b=0PDiaFSMm6iwO/VjG8wRRn6MiyBOZPfWWK+YtALG7HW+v5C40qXKFl86mS3Gk2Ms/s
         pcoJNxbU7a9jTnuCU06TDLjEmS1SdZJ3Gydj0DAuckO3QoE3jFeQ+wNsfsBs7SVSsRlT
         8vPrsInaQZPpt78+xIqHZaR91wZG74HfqfnkFFZ66RqW5FokfO+LTlBBAS7x3bksuyEy
         xkaJfNppxlxv/IBJzHDgz/nAzRuI7IMDz0MCFmXu4pY6hqWB2QFj1ts+xsqfUNTMot1M
         JG1j36oPbMuI3EfQsLmS8Y9i675L4QB7a7hX/jOH+Gs29aj/Ws1e5CATrPdUe3ld9OG5
         hIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696251578; x=1696856378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQNNYMHbbXj3ScZMcNdV4XQ6wHyCHAuYoxBdko5O+4A=;
        b=h6AuYXaSIuz5eVjhvgJhh8CZhlB/uVUgWYYBcloUDOwerLmPlm6d/VvY955Me1/NWM
         kux/F0EAgR/NqexRPxjMkihGVmrqJ8CX9yY267sRkyfBnFxggsuHTnYfyvqh8dGmgiG7
         lNe4kl26AS3uhf7sYBqHyub54N+2Uyr1CDLm70gAL5SHp1MCuXjYJP74SxEHs+v4Kq60
         nH6ncbTNJD+OdHaH24HV0HkJGxbnXO178hpBEtZVGdwLz2GcswdS7YvxtcYbEx56FMfX
         PLecUoEj0jPEgIh4oX9H72pwlRMpF9ME+S4znH93TlIRG6oYvyT5WrufSBClkDdvOeU1
         af8Q==
X-Gm-Message-State: AOJu0YyOrDmrssSarGVC+0vED3icQz92JjlL5os0zBXXvVeoKjsCR+0U
        xx+f+g80rDUtYuCL4RY0sDDvytkqeECoa5rwEujtqQ==
X-Google-Smtp-Source: AGHT+IHioJWOPzoI5EaTx/MPQvZESSXI2u2AEjqrkEOsD9g2pkbMR/w1XAKTmdUWaRmWmyFQohh7L3YNRqOavMQhIcw=
X-Received: by 2002:a50:8d17:0:b0:52f:5697:8dec with SMTP id
 s23-20020a508d17000000b0052f56978decmr116826eds.4.1696251577874; Mon, 02 Oct
 2023 05:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230922111247.497-1-ansuelsmth@gmail.com> <CANn89iJtrpVQZbeAezd7S4p_yCRSFzcsBMgW+y9YhxOrCv463A@mail.gmail.com>
 <65181064.050a0220.7887c.c7ee@mx.google.com> <CANn89iJqkpRu8rd_M7HCzaZQV5P_XTCzbKe5DOwnJkTRDZWEWw@mail.gmail.com>
 <651ab7b8.050a0220.e15ed.9d6a@mx.google.com> <CANn89iJqFC-Z3NZwT+CXEG7R9rc9g4LRwNm6Zm=nZKpD3Mon7Q@mail.gmail.com>
 <651abb07.050a0220.5435c.9eae@mx.google.com> <CANn89iLHMOh9Axt3xquzPjx0Dfn6obmSZJFSpzH51TKAN_nPqQ@mail.gmail.com>
 <651abda3.df0a0220.a04f0.12df@mx.google.com> <CANn89iLKBqsV6=jP1viSNMpA1W8r5mJEitjH3+RU5gEOQFYEtg@mail.gmail.com>
In-Reply-To: <CANn89iLKBqsV6=jP1viSNMpA1W8r5mJEitjH3+RU5gEOQFYEtg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 2 Oct 2023 14:59:26 +0200
Message-ID: <CANn89iKuTLk+pWGxR36VgWUVnz2inYdqPvJP6_e8nu4TRgUO=w@mail.gmail.com>
Subject: Re: [net-next PATCH 1/3] net: introduce napi_is_scheduled helper
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 2:56=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, Oct 2, 2023 at 2:55=E2=80=AFPM Christian Marangi <ansuelsmth@gmai=
l.com> wrote:
> >
> > On Mon, Oct 02, 2023 at 02:49:11PM +0200, Eric Dumazet wrote:
> > > On Mon, Oct 2, 2023 at 2:43=E2=80=AFPM Christian Marangi <ansuelsmth@=
gmail.com> wrote:
> > > >
> > > > On Mon, Oct 02, 2023 at 02:35:22PM +0200, Eric Dumazet wrote:
> > > > > On Mon, Oct 2, 2023 at 2:29=E2=80=AFPM Christian Marangi <ansuels=
mth@gmail.com> wrote:
> > > > >
> > > > > > Ehhh the idea here was to reduce code duplication since the ver=
y same
> > > > > > test will be done in stmmac. So I guess this code cleanup is a =
NACK and
> > > > > > I have to duplicate the test in the stmmac driver.
> > > > >
> > > > > I simply wanted to add a comment in front of this function/helper=
,
> > > > > advising not using it unless absolutely needed.
> > > > >
> > > > > Thus my question "In which context is it safe to call this helper=
 ?"
> > > > >
> > > > > As long as it was private with a driver, I did not mind.
> > > > >
> > > > > But if made public in include/linux/netdevice.h, I would rather n=
ot
> > > > > have to explain
> > > > > to future users why it can be problematic.
> > > >
> > > > Oh ok!
> > > >
> > > > We have plenty of case similar to this. (example some clock API ver=
y
> > > > internal that should not be used normally or regmap related)
> > > >
> > > > I will include some comments warning that this should not be used i=
n
> > > > normal circumstances and other warnings. If you have suggestion on =
what
> > > > to add feel free to write them.
> > > >
> > > > Any clue on how to proceed with the sge driver?
> > > >
> > >
> > > I would remove use of this helper for something with no race ?
> > >
> > > Feel free to submit this :
> > >
> > > (Alternative would be to change napi_schedule() to return a boolean)
> > >
> >
> > Think mod napi_schedule() to return a bool would result in massive
> > warning (actually error with werror) with return value not handled.
> >
>
> It should not, unless we added a __must_check

This was what I was thinking :

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e070a4540fbaf4a9cf310d5f53c4401840c72776..6aa2bc315411d1a0f7db314f1fb=
fb11aae7c31fe
100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -491,10 +491,13 @@ bool napi_schedule_prep(struct napi_struct *n);
  * Schedule NAPI poll routine to be called if it is not already
  * running.
  */
-static inline void napi_schedule(struct napi_struct *n)
+static inline bool napi_schedule(struct napi_struct *n)
 {
-       if (napi_schedule_prep(n))
+       if (napi_schedule_prep(n)) {
                __napi_schedule(n);
+               return true;
+       }
+       return false;
 }

 /**
