Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DD97B539D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbjJBMzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbjJBMzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:55:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFA1B0;
        Mon,  2 Oct 2023 05:55:01 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40566f8a093so134037205e9.3;
        Mon, 02 Oct 2023 05:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696251300; x=1696856100; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=28IiggInfhdX5TRLSL71Si3g5qgj6uye3wMvj7LWpPw=;
        b=PJCtaiDbE641MoPV3Wx+U8rr/NazQtELrzEoeVG2lTd4O5kbQakKE9YdOqppaeQiXU
         MjByNpdi8Skb0OZquUvEH+90Q8uveMXu55gTaMS6QqjLjo4h66ejOZQ83vbFs2bkJdwp
         nPo8+Qm35g1VdnfoHM971Nil4rYYtUH+rjzwANfEMSl57iZm3CZfDGNijJCqxRn00WM0
         Lbhqv86t4Ouof8I/85OoxzxUnTzMNdNdbpBMsGq2XabmVf22kB3yxqvX/+Cepga+7dGr
         R6GRNfFs8TCyFoECbNhuKuPp/cHCG5WaK4vXEiGJjH4RnQE+OEEXauXD8aj4mwLmisAl
         Iqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696251300; x=1696856100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28IiggInfhdX5TRLSL71Si3g5qgj6uye3wMvj7LWpPw=;
        b=aWUG1PZtwlBxsOXDChiEDrTx4F98AH6d40/Mcr3dYkWWNI0glSbpZ2l/E+XTvztSfE
         uxy3xgiaNhJfH9yCdjWe/P6mzcMYaKCgCznPE8asZZ/yJDpcoyxKFj5iypGSrb0mUUWS
         hEBy4XRgi3eDX6nGVhshnw9ACDDPO5e1ekwMY2zN7ejRl4i91s4+Ve+sBQTt1rWVIf7Q
         PMUU1MiHrOepd2YKPftLJUpiJ+FoqfEF0Uz4dvKJOe1upFP1R/wusIzBPLndGaO4Fi0G
         NCbLXk2jEAovHR8DNGilW+oZZa+TS+HWVFWfTZUZIQEKV/qspqcssy0CA/qxhpBqzVWI
         c2AA==
X-Gm-Message-State: AOJu0YwUH920YwTMIaWUZ9ShubAmG/SF3juGisC+RbfIbMoFWqNWmK7W
        qBIhhrUHI4RXsCemFUNeUYE=
X-Google-Smtp-Source: AGHT+IGMOsBeJ1M30+rfvuzbSeaPC6dZyf97ZswVAua76P7jZFwmyAiqKyvI8+Y2NbdOgX4Bsybsag==
X-Received: by 2002:a1c:4b18:0:b0:404:7659:ba39 with SMTP id y24-20020a1c4b18000000b004047659ba39mr10368110wma.16.1696251299806;
        Mon, 02 Oct 2023 05:54:59 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id p10-20020adff20a000000b0032763287473sm4987101wro.75.2023.10.02.05.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:54:59 -0700 (PDT)
Message-ID: <651abda3.df0a0220.a04f0.12df@mx.google.com>
X-Google-Original-Message-ID: <ZRq9n/VYcTZOZmJ7@Ansuel-xps.>
Date:   Mon, 2 Oct 2023 14:54:55 +0200
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
 <651ab7b8.050a0220.e15ed.9d6a@mx.google.com>
 <CANn89iJqFC-Z3NZwT+CXEG7R9rc9g4LRwNm6Zm=nZKpD3Mon7Q@mail.gmail.com>
 <651abb07.050a0220.5435c.9eae@mx.google.com>
 <CANn89iLHMOh9Axt3xquzPjx0Dfn6obmSZJFSpzH51TKAN_nPqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLHMOh9Axt3xquzPjx0Dfn6obmSZJFSpzH51TKAN_nPqQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 02:49:11PM +0200, Eric Dumazet wrote:
> On Mon, Oct 2, 2023 at 2:43 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Mon, Oct 02, 2023 at 02:35:22PM +0200, Eric Dumazet wrote:
> > > On Mon, Oct 2, 2023 at 2:29 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> > >
> > > > Ehhh the idea here was to reduce code duplication since the very same
> > > > test will be done in stmmac. So I guess this code cleanup is a NACK and
> > > > I have to duplicate the test in the stmmac driver.
> > >
> > > I simply wanted to add a comment in front of this function/helper,
> > > advising not using it unless absolutely needed.
> > >
> > > Thus my question "In which context is it safe to call this helper ?"
> > >
> > > As long as it was private with a driver, I did not mind.
> > >
> > > But if made public in include/linux/netdevice.h, I would rather not
> > > have to explain
> > > to future users why it can be problematic.
> >
> > Oh ok!
> >
> > We have plenty of case similar to this. (example some clock API very
> > internal that should not be used normally or regmap related)
> >
> > I will include some comments warning that this should not be used in
> > normal circumstances and other warnings. If you have suggestion on what
> > to add feel free to write them.
> >
> > Any clue on how to proceed with the sge driver?
> >
> 
> I would remove use of this helper for something with no race ?
> 
> Feel free to submit this :
> 
> (Alternative would be to change napi_schedule() to return a boolean)
>

Think mod napi_schedule() to return a bool would result in massive
warning (actually error with werror) with return value not handled.

I will submit with your Suggested-by. Ok for you?

> diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c
> b/drivers/net/ethernet/chelsio/cxgb3/sge.c
> index 2e9a74fe0970df333226b80af8716f30865c01b7..09d0e6aa4db982e3488e0c28bed33e83453801d0
> 100644
> --- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
> +++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
> @@ -2501,14 +2501,6 @@ static int napi_rx_handler(struct napi_struct
> *napi, int budget)
>         return work_done;
>  }
> 
> -/*
> - * Returns true if the device is already scheduled for polling.
> - */
> -static inline int napi_is_scheduled(struct napi_struct *napi)
> -{
> -       return test_bit(NAPI_STATE_SCHED, &napi->state);
> -}
> -
>  /**
>   *     process_pure_responses - process pure responses from a response queue
>   *     @adap: the adapter
> @@ -2674,9 +2666,9 @@ static int rspq_check_napi(struct sge_qset *qs)
>  {
>         struct sge_rspq *q = &qs->rspq;
> 
> -       if (!napi_is_scheduled(&qs->napi) &&
> -           is_new_response(&q->desc[q->cidx], q)) {
> -               napi_schedule(&qs->napi);
> +       if (is_new_response(&q->desc[q->cidx], q) &&
> +           napi_schedule_prep(&qs->napi)) {
> +               __napi_schedule(&qs->napi);
>                 return 1;
>         }
>         return 0;

-- 
	Ansuel
