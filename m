Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63CA763BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbjGZPy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjGZPyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:54:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9656B100;
        Wed, 26 Jul 2023 08:54:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26824c32cfbso795147a91.1;
        Wed, 26 Jul 2023 08:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690386864; x=1690991664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWApWdvVXHNiMFGGzJvmxw82QwhtiYRXTqYUjlHOECI=;
        b=dMRzsTH8qjyHfSTdW1IMt5u9fvauGMxWUVkXC+Kz4vCaIh32zzfJgAueG7ExSe8rP/
         sGhcyp/X5nT5aYHXOQHUARE33rRFM+vR5wS6RYRD6/6zTfr1eJe37auAIvreLclqpDdK
         9n+HqN3r4gdBoDZn5cuUmYReOjRLUvEV40MC8J2UkE30tDE1Z4CvysAIPncTy4N4XyVf
         HYfFRwE7mcVda2crEBbW4W9CByANlB8GU1gjsstr4LH2RfDXwlRryx6wMz7XacAMyOwL
         LNCzVvQ3I/sQiZZj7+nyxLIt46s/NS1gR0fDrqdkTPcvcie9sWEjyfTsMLRwFIsMzPU6
         8+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690386864; x=1690991664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWApWdvVXHNiMFGGzJvmxw82QwhtiYRXTqYUjlHOECI=;
        b=QxpMUZmexyaOSb980FRENJZduXLRJH4Auypb97wo+Z2QHfkEqguKJDAyW3q/qzCa++
         lFjCLwIJhqH2MVdrWlEFVQmtUD7cV2vPY0zqWdfS8MWAK/X4G1+KiZlsB/uHvFEOnqXy
         O+oVmiqO5Fnq7l2whoYctfy3AVs4aYR+ukgoOh6WW4Aq7N3o/olS6LPCZx8K+ACjp2fH
         fYkShyKO1kONY1IhiavhRLi5OxNlXWEjW+9qeeUjU1BdJNzyrs0Q6xcMqCDjZ/OTSZ21
         PtDo+Qg7/QWEko3uYqAqSAY7naGZaOZ/CNG8U1LOLZTvCehtEzklmHDmDv6igMDPD8Td
         mKwQ==
X-Gm-Message-State: ABy/qLb+Rz1CFJeru0K2zqa6Vp4v+o7ww3aecffG1cskNHUb+8vCV3Pf
        h1VmmkCzvDEAOBV5KHvTqtsApP66kH6AgIfQJ9aFH/2a
X-Google-Smtp-Source: APBJJlHfdBVOUf9sjLgrRDmx8vCS+lEbOouJtnBm1F0LekVFLrK2QaXJaHcPA1wH2PZSQ+dybNFZM1xlv9496/e9cYc=
X-Received: by 2002:a17:90a:fd85:b0:268:42da:25e1 with SMTP id
 cx5-20020a17090afd8500b0026842da25e1mr3102133pjb.8.1690386863941; Wed, 26 Jul
 2023 08:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230725074148.2936402-1-wei.fang@nxp.com> <70b71e7bb8a7dff2dacab99b0746e7bf2bee9344.camel@gmail.com>
 <AM5PR04MB31390FCD7DB9F905FCB599108800A@AM5PR04MB3139.eurprd04.prod.outlook.com>
In-Reply-To: <AM5PR04MB31390FCD7DB9F905FCB599108800A@AM5PR04MB3139.eurprd04.prod.outlook.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 26 Jul 2023 08:53:47 -0700
Message-ID: <CAKgT0Ufo8exTv1783Ud7EUg_1ei90Eb4ZoiHFd49zAbfhLgAsQ@mail.gmail.com>
Subject: Re: [PATCH net] net: fec: tx processing does not call XDP APIs if
 budget is 0
To:     Wei Fang <wei.fang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 8:40=E2=80=AFPM Wei Fang <wei.fang@nxp.com> wrote:
>
> Hi Alexander,
>
> > > @@ -1416,6 +1416,14 @@ fec_enet_tx_queue(struct net_device *ndev,
> > u16 queue_id)
> > >                     if (!skb)
> > >                             goto tx_buf_done;
> > >             } else {
> > > +                   /* Tx processing cannot call any XDP (or page poo=
l) APIs if
> > > +                    * the "budget" is 0. Because NAPI is called with=
 budget of
> > > +                    * 0 (such as netpoll) indicates we may be in an =
IRQ context,
> > > +                    * however, we can't use the page pool from IRQ c=
ontext.
> > > +                    */
> > > +                   if (unlikely(!budget))
> > > +                           break;
> > > +
> > >                     xdpf =3D txq->tx_buf[index].xdp;
> > >                     if (bdp->cbd_bufaddr)
> > >                             dma_unmap_single(&fep->pdev->dev,
> >
> > This statement isn't correct. There are napi enabled and non-napi
> > versions of these calls. This is the reason for things like the
> > "allow_direct" parameter in page_pool_put_full_page and the
> > "napi_direct" parameter in __xdp_return.
> >
> > By blocking on these cases you can end up hanging the Tx queue which is
> > going to break netpoll as you are going to stall the ring on XDP
> > packets if they are already in the queue.
> >
> > From what I can tell your driver is using xdp_return_frame in the case
> > of an XDP frame which doesn't make use of the NAPI optimizations in
> > freeing from what I can tell. The NAPI optimized version is
> > xdp_return_frame_rx.
> >
> So you mean it is safe to use xdp_return_frame no matter in NAPI context
> or non-NAPI context? And xdp_return_frame_rx_napi must be used in NAPI
> context? If so, I think I must have misunderstood, then this patch is not=
 necessary.

Actually after talking with Jakub a bit more there is an issue here,
but not freeing the frames isn't the solution. We likely need to just
fix the page pool code so that it doesn't attempt to recycle the
frames if operating in IRQ context.

The way this is dealt with for skbs is that we queue skbs if we are in
IRQ context so that it can be deferred to be freed by the
net_tx_action. We likely need to look at doing something similar for
page_pool pages or XDP frames.

> > > @@ -1508,14 +1516,14 @@ fec_enet_tx_queue(struct net_device *ndev,
> > u16 queue_id)
> > >             writel(0, txq->bd.reg_desc_active);
> > >  }
> > >
> > > -static void fec_enet_tx(struct net_device *ndev)
> > > +static void fec_enet_tx(struct net_device *ndev, int budget)
> > >  {
> > >     struct fec_enet_private *fep =3D netdev_priv(ndev);
> > >     int i;
> > >
> > >     /* Make sure that AVB queues are processed first. */
> > >     for (i =3D fep->num_tx_queues - 1; i >=3D 0; i--)
> > > -           fec_enet_tx_queue(ndev, i);
> > > +           fec_enet_tx_queue(ndev, i, budget);
> > >  }
> > >
> > >  static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
> > > @@ -1858,7 +1866,7 @@ static int fec_enet_rx_napi(struct napi_struct
> > *napi, int budget)
> > >
> > >     do {
> > >             done +=3D fec_enet_rx(ndev, budget - done);
> > > -           fec_enet_tx(ndev);
> > > +           fec_enet_tx(ndev, budget);
> > >     } while ((done < budget) && fec_enet_collect_events(fep));
> > >
> > >     if (done < budget) {
> >
> > Since you are passing budget, one optimization you could make use of
> > would be napi_consume_skb in your Tx path instead of dev_kfree_skb_any.
> That's good suggestion, I think I can add this optimization in my XDP_TX =
support
> patch. Thanks!
