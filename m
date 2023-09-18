Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD2A7A452E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbjIRIxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbjIRIxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:53:12 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A41E3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 01:53:07 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-415155b2796so370401cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 01:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695027186; x=1695631986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogW3H0R96ZMdosi7AtyKIErZk/fjmm07cRXWvBwHGak=;
        b=C21TsutBfma9IFapdSiTxUCteJGK+4aSUMP/MaEUlrJFMPJ/1MAvh1h7vye6ffb1HP
         GOVOhQ2GKOQXOjmGG7rb+v2s+5QPZ6J6+7aMXEoEMs3Mkvft8Vj2UsB5Bc6APRTF0gN0
         THwLTB3T7ATk+Qhz73IThXK/SGWWyRbbrnftahihrlokHMltrHrvFh6KHguT7LG9MmVn
         P7bkjhTA5Xc4KHGS9dh/A+173XdR1Nv7GXqUvYMQGbuBJ0iUuR+kypgrm+iuw0WE5XKB
         uLMsqlYgv8D/1I3PRSGjg26i87K8o9OBeKtEuFJkyu0ddL3trgIjAQ2ovGeRv7hiRy0V
         vAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695027186; x=1695631986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogW3H0R96ZMdosi7AtyKIErZk/fjmm07cRXWvBwHGak=;
        b=R3waGLeIE9M+7//MZkYO797bCZmvFV4up+aKKLq01wx1JpPPK0ijwRFxycCigLD36A
         nKdDs7uPkGJ9dFciToLAIoaA1HERO6CnAk3iSEEe1Bx6DNJOcWJrGc9UNA7+y/+vbl4c
         0txoVsQ1IWo5MH/wdguqLk/lfcYoAOSvBQ5UbB6hYITRoQYxcO9tMjP/qfnD6ogLDlRW
         I2/Nljx9bUhTCjXRMx9uxxo6eG1KDOL4rFFSRA7+gdjBlmqxfP9MVS5wJBGCWudXHK7d
         r7M3tJ7jI05d/0YUkhjOpmS2/qHhyFvc2HrDDqCFVTeTV5xKhjjOEoXQbU+AruPfIM5A
         uqNw==
X-Gm-Message-State: AOJu0YxvS17FSA/Pd54A5VPhxBNmUPs1T4j8JXoDIq5a74EhhxJQFsXS
        jQ1SiMfHIW+LECjvz4+WbnRm2uvdjLnc3DeKj4wk3Q==
X-Google-Smtp-Source: AGHT+IFT2iJsDrJ4oiAR0RgbZAYxO+7uW4xmH3x3Y2KCHkidrWH5VW869m/ySGLy2taFVEC9Lj2oDqs0L5e8Sp41s30=
X-Received: by 2002:ac8:5845:0:b0:40f:ec54:973 with SMTP id
 h5-20020ac85845000000b0040fec540973mr447970qth.22.1695027186029; Mon, 18 Sep
 2023 01:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230918074202.2461-426-nic_swsd@realtek.com> <20230918074202.2461-427-nic_swsd@realtek.com>
 <CANn89iJmdkyn8_hU4esycRG-XvPa_Djsp6PyaOX5cYP1Obdr4g@mail.gmail.com> <7235821eb09242adaa651172729f76aa@realtek.com>
In-Reply-To: <7235821eb09242adaa651172729f76aa@realtek.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 18 Sep 2023 10:52:54 +0200
Message-ID: <CANn89i+Tou=YwteEd5ceaHP54sZpkRotwcV6YWAs4jAUq=ocJg@mail.gmail.com>
Subject: Re: [PATCH net-next resend 1/2] r8152: remove queuing rx packets in driver
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "bjorn@mork.no" <bjorn@mork.no>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 10:39=E2=80=AFAM Hayes Wang <hayeswang@realtek.com>=
 wrote:
>
> Eric Dumazet <edumazet@google.com>
> > Sent: Monday, September 18, 2023 3:55 PM
> [...]
> > >                         urb->actual_length =3D 0;
> > >                         list_add_tail(&agg->list, next);
> > >                 }
> > > +
> > > +               /* Break if budget is exhausted. */
> >
> > [1] More conventional way to to put this condition at the beginning of
> > the while () loop,
> > because the budget could be zero.
>
> If the budget is zero, the function wouldn't be called.
> a7b8d60b3723 ("r8152: check budget for r8152_poll") avoids it.

Yes, and we could revert  this patch :/

Moving the test at the front of the loop like most other drivers would
have avoided this issue,
and avoided this discussion.

>
> > > +               if (work_done >=3D budget)
> > > +                       break;
> > >         }
> > >
> > > +       /* Splice the remained list back to rx_done */
> > >         if (!list_empty(&rx_queue)) {
> > >                 spin_lock_irqsave(&tp->rx_lock, flags);
> > > -               list_splice_tail(&rx_queue, &tp->rx_done);
> > > +               list_splice(&rx_queue, &tp->rx_done);
> > >                 spin_unlock_irqrestore(&tp->rx_lock, flags);
> > >         }
> > >
> > >  out1:
> > > -       return work_done;
> > > +       if (work_done > budget)
> >
> > This (work_done >budget) condition would never be true if point [1] is
> > addressed.
>
> A bulk transfer may contain many packets, so the work_done may be more th=
an budget.
> That is why I queue the packets in the driver before this patch.
> For example, if a bulk transfer contains 70 packet and budget is 64,
> napi_gro_receive would be called for the first 64 packets and 6 packets w=
ould
> be queued in driver for next schedule. After this patch, napi_gro_receive=
() would
> be called for the 70 packets, even the budget is 64. And the remained bul=
k transfers
> would be handled for next schedule.

A comment would be nice. NAPI logic should look the same in all drivers.

If a driver has some peculiarities, comments would help to maintain
the code in the long run.

>
> > > +               return budget;
> > > +       else
> > > +               return work_done;
> > >  }
>
> Best Regards,
> Hayes
>
