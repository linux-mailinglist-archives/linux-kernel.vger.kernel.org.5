Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62047B5398
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbjJBM4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbjJBM4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:56:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DCDB4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:56:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50302e8fca8so6367e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 05:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696251396; x=1696856196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhnS1jID/E/HPZQRwttboOmGY8j/6QNBSIOKDXt9Rx0=;
        b=I5Z6P+M0ZQuBH9Gw4ld/bNeK6wb05j3yDpFTIcF7WMFacyW4b63iwq64h0ZAm4s7O3
         3m+UxOiBM/hFixTGMHmzZnn+IyRxcx88hmwwVZHSKLIxF0CIuM5WnoARIZ/RrqsGfVZu
         2Oc6+9hrzGYJ2XPtzWZUhOYoyDUpkymg2oTr80E2MRHyQErqLGY8MgG9nA1MHWvDGU7s
         o8tb4JObI7Tz1/8rX3+5p0yG7gyOv+sharKrtD3/hSQOJzSpg7Xyqi+lZuyrfcGQQX+L
         QpWdZoeZqhpzAS7A6pcHUdcv9fV70CRFxGCYlIszBjiPAMwaKFfAyKUExCcjvKpyqcl9
         9IYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696251396; x=1696856196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhnS1jID/E/HPZQRwttboOmGY8j/6QNBSIOKDXt9Rx0=;
        b=JqpuQelttytiANDbVRMtY2Djq/LkAUThwxgdU4m1UIMOt03lHvXVYUQKnumIQCZJN8
         d+xA4wNUP1fGkjmVjiiPB6QLagZsaXJ8nZJNt+8pupW71nnjTLaSjlZKycBh8yGDWieE
         hPngNjxq20rVNW2fhM2DD53O5xAQLz4p31KRdWnkO8QrdoUvxuq9xQtgsP5XDJ5y3OCr
         paRlSXgq/PxD1+2uLMLDsQN8wU4N+wjz9dzViGPWTyrnKdqBU7veMTdHlPyERsJfsJyW
         ZsEL4B1xZDoetby3meVAwgZvMDWHmvhn90/fktkbiydul23yhElTy/pnMNQUfzCl1BbS
         Wu6g==
X-Gm-Message-State: AOJu0Yx9alLyHeoAvjJUEmXDm+4y0ulV15oFyqN4//WvIU92NIlC5AJu
        mVlrKq5aygyfx5abDlmY8t31i4yTbVXLPSIwFg2FlQ==
X-Google-Smtp-Source: AGHT+IH2BpKCB5EMiwqckAjJ6wIMKO3DV/EsUH2KYkYKWp0emjrHOycC6QBqa5b6EXDe3hYKjUZFW0cUS4ODnBk/VRc=
X-Received: by 2002:ac2:544b:0:b0:502:c615:99b0 with SMTP id
 d11-20020ac2544b000000b00502c61599b0mr68351lfn.4.1696251395319; Mon, 02 Oct
 2023 05:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230922111247.497-1-ansuelsmth@gmail.com> <CANn89iJtrpVQZbeAezd7S4p_yCRSFzcsBMgW+y9YhxOrCv463A@mail.gmail.com>
 <65181064.050a0220.7887c.c7ee@mx.google.com> <CANn89iJqkpRu8rd_M7HCzaZQV5P_XTCzbKe5DOwnJkTRDZWEWw@mail.gmail.com>
 <651ab7b8.050a0220.e15ed.9d6a@mx.google.com> <CANn89iJqFC-Z3NZwT+CXEG7R9rc9g4LRwNm6Zm=nZKpD3Mon7Q@mail.gmail.com>
 <651abb07.050a0220.5435c.9eae@mx.google.com> <CANn89iLHMOh9Axt3xquzPjx0Dfn6obmSZJFSpzH51TKAN_nPqQ@mail.gmail.com>
 <651abda3.df0a0220.a04f0.12df@mx.google.com>
In-Reply-To: <651abda3.df0a0220.a04f0.12df@mx.google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 2 Oct 2023 14:56:24 +0200
Message-ID: <CANn89iLKBqsV6=jP1viSNMpA1W8r5mJEitjH3+RU5gEOQFYEtg@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 2:55=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:
>
> On Mon, Oct 02, 2023 at 02:49:11PM +0200, Eric Dumazet wrote:
> > On Mon, Oct 2, 2023 at 2:43=E2=80=AFPM Christian Marangi <ansuelsmth@gm=
ail.com> wrote:
> > >
> > > On Mon, Oct 02, 2023 at 02:35:22PM +0200, Eric Dumazet wrote:
> > > > On Mon, Oct 2, 2023 at 2:29=E2=80=AFPM Christian Marangi <ansuelsmt=
h@gmail.com> wrote:
> > > >
> > > > > Ehhh the idea here was to reduce code duplication since the very =
same
> > > > > test will be done in stmmac. So I guess this code cleanup is a NA=
CK and
> > > > > I have to duplicate the test in the stmmac driver.
> > > >
> > > > I simply wanted to add a comment in front of this function/helper,
> > > > advising not using it unless absolutely needed.
> > > >
> > > > Thus my question "In which context is it safe to call this helper ?=
"
> > > >
> > > > As long as it was private with a driver, I did not mind.
> > > >
> > > > But if made public in include/linux/netdevice.h, I would rather not
> > > > have to explain
> > > > to future users why it can be problematic.
> > >
> > > Oh ok!
> > >
> > > We have plenty of case similar to this. (example some clock API very
> > > internal that should not be used normally or regmap related)
> > >
> > > I will include some comments warning that this should not be used in
> > > normal circumstances and other warnings. If you have suggestion on wh=
at
> > > to add feel free to write them.
> > >
> > > Any clue on how to proceed with the sge driver?
> > >
> >
> > I would remove use of this helper for something with no race ?
> >
> > Feel free to submit this :
> >
> > (Alternative would be to change napi_schedule() to return a boolean)
> >
>
> Think mod napi_schedule() to return a bool would result in massive
> warning (actually error with werror) with return value not handled.
>

It should not, unless we added a __must_check

> I will submit with your Suggested-by. Ok for you?

Absolutely, thanks.

>
> > diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c
> > b/drivers/net/ethernet/chelsio/cxgb3/sge.c
> > index 2e9a74fe0970df333226b80af8716f30865c01b7..09d0e6aa4db982e3488e0c2=
8bed33e83453801d0
> > 100644
> > --- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
> > +++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
> > @@ -2501,14 +2501,6 @@ static int napi_rx_handler(struct napi_struct
> > *napi, int budget)
> >         return work_done;
> >  }
> >
> > -/*
> > - * Returns true if the device is already scheduled for polling.
> > - */
> > -static inline int napi_is_scheduled(struct napi_struct *napi)
> > -{
> > -       return test_bit(NAPI_STATE_SCHED, &napi->state);
> > -}
> > -
> >  /**
> >   *     process_pure_responses - process pure responses from a response=
 queue
> >   *     @adap: the adapter
> > @@ -2674,9 +2666,9 @@ static int rspq_check_napi(struct sge_qset *qs)
> >  {
> >         struct sge_rspq *q =3D &qs->rspq;
> >
> > -       if (!napi_is_scheduled(&qs->napi) &&
> > -           is_new_response(&q->desc[q->cidx], q)) {
> > -               napi_schedule(&qs->napi);
> > +       if (is_new_response(&q->desc[q->cidx], q) &&
> > +           napi_schedule_prep(&qs->napi)) {
> > +               __napi_schedule(&qs->napi);
> >                 return 1;
> >         }
> >         return 0;
>
> --
>         Ansuel
