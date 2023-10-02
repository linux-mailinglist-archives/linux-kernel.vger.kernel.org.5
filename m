Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858447B5341
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbjJBM3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbjJBM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:29:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E50410B;
        Mon,  2 Oct 2023 05:29:47 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-406618d080eso24251635e9.2;
        Mon, 02 Oct 2023 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696249785; x=1696854585; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Z0fPrHFEa9nkjOAEG6EVjtNAzWmIJKQAHce/juD4dg=;
        b=PplZscnZS6kCfC0P9vLW2oMYXRvOgyQ9a3TVV3NxxWGF2MvKMcOTuF0iJkYlG/pHVg
         DVBCU8do2bWW3b2pBCHz2/gwZLK9qnjhzTqrrrU4z7OkrbHiC+/nWyS8t/xuuPQQ/Eac
         I/qPn0Lg8GsYJmVw9NojzzdmtEsLNFbAqpP46URlmujarBVq/VHgRDG76iPqkiTFFhdg
         UNZgxytQM2Fz1AF1FdlBf+DVy1m15lDlffTXb5Tdls0lbctMlWVoYpUGzSHa1dFnzj7G
         4HPh46n5npAp7IWOhmbyUnxQF/p9SNfY48gZSZ9sr5V1PQ1LmNihDg2a4KV7hAeFwiuM
         P6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696249785; x=1696854585;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Z0fPrHFEa9nkjOAEG6EVjtNAzWmIJKQAHce/juD4dg=;
        b=tIbN7Z+cz3+TV0V0uMQBabhqcgc2ECHgN5OD8cq/KQkMk5ZZGhZ7UFbcf2yKwnvkgF
         UbGe1XT9I3rPBVkZ+gtE9WmF4C7Enf3truO0YEGZNLXGXbK5A9P8aH4kWNMhEwjfYKDy
         oW7wddLCI4uDrxYbfwaiPa3PuLjDuz4kod7uU1hbv8z7upU6Gy+B3O9Nbv/y1PU8++9o
         yZSE5ElYSqWqTjvYgjGARub8ehzKzOPHxdgLuJM23MEfPTqNZufKwT9qrGZzQX/0/zoe
         6xPqOQD7e2QALB6GMUfDFApocGAb7Q+ydP2/fifji1zcIFhBepUu+ihUJuIT+n3a7c1x
         FoeQ==
X-Gm-Message-State: AOJu0YyS5f4R0E8UKXpoVwQj/gXiudoj7vo0rDBqMNMlg+948nf0meTH
        7Lwr9ekTRphswuMD1rnx1vBkDuwYGEk=
X-Google-Smtp-Source: AGHT+IGHwYg7Qrz6bLRE2viP7h0QHkA3r0DuEv3bOzVZxN12evX9inbIYCNXUQglnd9gyl4BLSs0RA==
X-Received: by 2002:a05:600c:5101:b0:406:6964:7e96 with SMTP id o1-20020a05600c510100b0040669647e96mr4282239wms.13.1696249785131;
        Mon, 02 Oct 2023 05:29:45 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c280500b0040535648639sm7189510wmb.36.2023.10.02.05.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:29:44 -0700 (PDT)
Message-ID: <651ab7b8.050a0220.e15ed.9d6a@mx.google.com>
X-Google-Original-Message-ID: <ZRq3tD70jmNB/ZIo@Ansuel-xps.>
Date:   Mon, 2 Oct 2023 14:29:40 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Eric Dumazet <edumazet@google.com>
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
Subject: Re: [net-next PATCH 1/3] net: introduce napi_is_scheduled helper
References: <20230922111247.497-1-ansuelsmth@gmail.com>
 <CANn89iJtrpVQZbeAezd7S4p_yCRSFzcsBMgW+y9YhxOrCv463A@mail.gmail.com>
 <65181064.050a0220.7887c.c7ee@mx.google.com>
 <CANn89iJqkpRu8rd_M7HCzaZQV5P_XTCzbKe5DOwnJkTRDZWEWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJqkpRu8rd_M7HCzaZQV5P_XTCzbKe5DOwnJkTRDZWEWw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 03:42:20PM +0200, Eric Dumazet wrote:
> On Sat, Sep 30, 2023 at 2:11 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Sat, Sep 30, 2023 at 01:59:53PM +0200, Eric Dumazet wrote:
> > > On Fri, Sep 22, 2023 at 1:13 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > >
> > > > We currently have napi_if_scheduled_mark_missed that can be used to
> > > > check if napi is scheduled but that does more thing than simply checking
> > > > it and return a bool. Some driver already implement custom function to
> > > > check if napi is scheduled.
> > > >
> > > > Drop these custom function and introduce napi_is_scheduled that simply
> > > > check if napi is scheduled atomically.
> > > >
> > > > Update any driver and code that implement a similar check and instead
> > > > use this new helper.
> > > >
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > >  drivers/net/ethernet/chelsio/cxgb3/sge.c  | 8 --------
> > > >  drivers/net/wireless/realtek/rtw89/core.c | 2 +-
> > > >  include/linux/netdevice.h                 | 5 +++++
> > > >  net/core/dev.c                            | 2 +-
> > > >  4 files changed, 7 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/ethernet/chelsio/cxgb3/sge.c
> > > > index 2e9a74fe0970..71fa2dc19034 100644
> > > > --- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
> > > > +++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
> > > > @@ -2501,14 +2501,6 @@ static int napi_rx_handler(struct napi_struct *napi, int budget)
> > > >         return work_done;
> > > >  }
> > > >
> > > > -/*
> > > > - * Returns true if the device is already scheduled for polling.
> > > > - */
> > > > -static inline int napi_is_scheduled(struct napi_struct *napi)
> > > > -{
> > > > -       return test_bit(NAPI_STATE_SCHED, &napi->state);
> > > > -}
> > > > -
> > > >  /**
> > > >   *     process_pure_responses - process pure responses from a response queue
> > > >   *     @adap: the adapter
> > > > diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
> > > > index 133bf289bacb..bbf4ea3639d4 100644
> > > > --- a/drivers/net/wireless/realtek/rtw89/core.c
> > > > +++ b/drivers/net/wireless/realtek/rtw89/core.c
> > > > @@ -1744,7 +1744,7 @@ static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
> > > >         struct napi_struct *napi = &rtwdev->napi;
> > > >
> > > >         /* In low power mode, napi isn't scheduled. Receive it to netif. */
> > > > -       if (unlikely(!test_bit(NAPI_STATE_SCHED, &napi->state)))
> > > > +       if (unlikely(!napi_is_scheduled(napi)))
> > > >                 napi = NULL;
> > > >
> > > >         rtw89_core_hw_to_sband_rate(rx_status);
> > > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > > index db3d8429d50d..8eac00cd3b92 100644
> > > > --- a/include/linux/netdevice.h
> > > > +++ b/include/linux/netdevice.h
> > > > @@ -482,6 +482,11 @@ static inline bool napi_prefer_busy_poll(struct napi_struct *n)
> > > >         return test_bit(NAPI_STATE_PREFER_BUSY_POLL, &n->state);
> > > >  }
> > > >
> > >
> > >
> > > In which context is it safe to call this helper ?
> > >
> >
> > test_bit is atomic so it should be always safe. Also the idea of this
> > check (and from what I can see this apply also to the other 2 user) is
> > somehow best effort, we check if in the current istant there is a napi
> > scheduled and we act.
> 
> I think testing a bit here is not enough to take any kind of useful decision,
> unless used in a particular context.
>

Ehhh the idea here was to reduce code duplication since the very same
test will be done in stmmac. So I guess this code cleanup is a NACK and
I have to duplicate the test in the stmmac driver.

> >
> > > I fear that making this available will add more bugs.
> > >
> > > For instance rspq_check_napi() seems buggy to me.
> > >
> >
> > Mhhh why? Am I opening a can of worms?
> 
> Yes I think :/
> 
> Because only the thread that has grabbed the bit can make any sense of it.
> 
> Another thread reading it would not really know if the value is not going to
> change immediately. So what would be the point ?
> 
> It seems rspq_check_napi() real intent was maybe the following,
> but really this is hard to know if the current race in this code is okay or not.
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c
> b/drivers/net/ethernet/chelsio/cxgb3/sge.c
> index 2e9a74fe0970df333226b80af8716f30865c01b7..e153c9590b36b38e430bc93660146b428e9b3347
> 100644
> --- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
> +++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
> @@ -2676,8 +2676,10 @@ static int rspq_check_napi(struct sge_qset *qs)
> 
>         if (!napi_is_scheduled(&qs->napi) &&
>             is_new_response(&q->desc[q->cidx], q)) {
> -               napi_schedule(&qs->napi);
> -               return 1;
> +               if (napi_schedule_prep(&qs->napi)) {
> +                       __napi_schedule(&qs->napi);
> +                       return 1;
> +               }
>         }
>         return 0;
>  }

-- 
	Ansuel
