Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE8C7B4038
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 14:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjI3MLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 08:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjI3MLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 08:11:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B5CBD;
        Sat, 30 Sep 2023 05:11:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50444e756deso19471972e87.0;
        Sat, 30 Sep 2023 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696075878; x=1696680678; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WtnC/PPyPj74Iu0UvHPPAxPUeaSVlrJc75BjIoxyTKw=;
        b=WZOm/hwhmdw+dhzk2Sh9GVgZGexCfEBgqKvIz+kvKzmUiuCf7LcXU0+AmmCKRFOP6d
         fcMY2NN8LAPw3VDJDPyYf/pYV5CpHLbQvvIA9DURzAXYXZka7sGijr5FDeTnPvKganeO
         oAvMjXlsqCipq+BCYsae+d+ItpB9+Z+F1s7G9EclDCkCmJGdDTAsSXyPYu8m/qdT6CU/
         snKy0vcUVgnF5JvB+k5YxCH9iFmmmx6xG6v6x8Dfl1hj1Byq+kswkJ0uw0whB7aLgLAr
         /i/pUzqeVJoXcQOEwFgv2I1G20clNAgaYMXOlTv2OHk1gF/cD9CR/QfvHNFElTtocmCj
         tfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696075878; x=1696680678;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtnC/PPyPj74Iu0UvHPPAxPUeaSVlrJc75BjIoxyTKw=;
        b=wuRqZZAAcrcsKu5pCp2hb8A23NbduxHnBNEPo726qs90V9KJJ6tZZLjS2PZXe/vYpl
         kIouPWOqcyzcgfvl6Qikt8ixDNUlNWRKWKyh3he9/OerZrb9IKhY/9+/rruY00tFdYcD
         3uu3rY5+IwpHkWgV2Yrk9FxW48FhBPTzkFLMOokx6+DgHtOUFvy+v7Hgt+aDSWJRGRer
         j9AtXFabeixvBfmtCRrbt+ggGdXYlUC287nMtnSLpErXQ50HLikPaP7zyWpTdMqJHQ0e
         BZzvevQycUYttoSXAoK0SAIwnuCaCrBYKsI3aWUGl9CyPaDUmsnxQHusu9ByxzXRdRCp
         YjDA==
X-Gm-Message-State: AOJu0Yw1xEcv8A1yKlyAEfLZRrd4PhHfTUPoofKj4XgTxTp1j84CHBsQ
        t/JY1cEj+mlLdEmoPUsFo9A=
X-Google-Smtp-Source: AGHT+IGHesckMWtWKsZ4Gjdi7ogmxfGi0Ya7zSMnahJcG3tTdZGHYYgMrSOA2n+sXZuEk6OdWLlAWA==
X-Received: by 2002:a19:2d0b:0:b0:4fb:8f79:631 with SMTP id k11-20020a192d0b000000b004fb8f790631mr4892124lfj.46.1696075877588;
        Sat, 30 Sep 2023 05:11:17 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c298100b0040586360a36sm3291365wmd.17.2023.09.30.05.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 05:11:16 -0700 (PDT)
Message-ID: <65181064.050a0220.7887c.c7ee@mx.google.com>
X-Google-Original-Message-ID: <ZRgQYriLmsH4HiBx@Ansuel-xps.>
Date:   Sat, 30 Sep 2023 14:11:14 +0200
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJtrpVQZbeAezd7S4p_yCRSFzcsBMgW+y9YhxOrCv463A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 01:59:53PM +0200, Eric Dumazet wrote:
> On Fri, Sep 22, 2023 at 1:13 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > We currently have napi_if_scheduled_mark_missed that can be used to
> > check if napi is scheduled but that does more thing than simply checking
> > it and return a bool. Some driver already implement custom function to
> > check if napi is scheduled.
> >
> > Drop these custom function and introduce napi_is_scheduled that simply
> > check if napi is scheduled atomically.
> >
> > Update any driver and code that implement a similar check and instead
> > use this new helper.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/ethernet/chelsio/cxgb3/sge.c  | 8 --------
> >  drivers/net/wireless/realtek/rtw89/core.c | 2 +-
> >  include/linux/netdevice.h                 | 5 +++++
> >  net/core/dev.c                            | 2 +-
> >  4 files changed, 7 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/ethernet/chelsio/cxgb3/sge.c
> > index 2e9a74fe0970..71fa2dc19034 100644
> > --- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
> > +++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
> > @@ -2501,14 +2501,6 @@ static int napi_rx_handler(struct napi_struct *napi, int budget)
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
> >   *     process_pure_responses - process pure responses from a response queue
> >   *     @adap: the adapter
> > diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
> > index 133bf289bacb..bbf4ea3639d4 100644
> > --- a/drivers/net/wireless/realtek/rtw89/core.c
> > +++ b/drivers/net/wireless/realtek/rtw89/core.c
> > @@ -1744,7 +1744,7 @@ static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
> >         struct napi_struct *napi = &rtwdev->napi;
> >
> >         /* In low power mode, napi isn't scheduled. Receive it to netif. */
> > -       if (unlikely(!test_bit(NAPI_STATE_SCHED, &napi->state)))
> > +       if (unlikely(!napi_is_scheduled(napi)))
> >                 napi = NULL;
> >
> >         rtw89_core_hw_to_sband_rate(rx_status);
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index db3d8429d50d..8eac00cd3b92 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -482,6 +482,11 @@ static inline bool napi_prefer_busy_poll(struct napi_struct *n)
> >         return test_bit(NAPI_STATE_PREFER_BUSY_POLL, &n->state);
> >  }
> >
> 
> 
> In which context is it safe to call this helper ?
>

test_bit is atomic so it should be always safe. Also the idea of this
check (and from what I can see this apply also to the other 2 user) is
somehow best effort, we check if in the current istant there is a napi
scheduled and we act.

> I fear that making this available will add more bugs.
> 
> For instance rspq_check_napi() seems buggy to me.
> 

Mhhh why? Am I opening a can of worms?

> > +static inline bool napi_is_scheduled(struct napi_struct *n)
> 
> const ...
> 

Will change in v2. Thanks!

> > +{
> > +       return test_bit(NAPI_STATE_SCHED, &n->state);
> > +}
> > +
> >  bool napi_schedule_prep(struct napi_struct *n);
> >
> >  /**
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index cc03a5758d2d..32ba8002f65a 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -6523,7 +6523,7 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
> >          * accidentally calling ->poll() when NAPI is not scheduled.
> >          */
> >         work = 0;
> > -       if (test_bit(NAPI_STATE_SCHED, &n->state)) {
> > +       if (napi_is_scheduled(n)) {
> >                 work = n->poll(n, weight);
> >                 trace_napi_poll(n, work, weight);
> >         }
> > --
> > 2.40.1
> >

-- 
	Ansuel
