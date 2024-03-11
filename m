Return-Path: <linux-kernel+bounces-98568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4D8877C10
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C49B20C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B82F1426D;
	Mon, 11 Mar 2024 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KmGulzZO"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514F0381AA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147546; cv=none; b=hcqU+4RQ+pA9eZd8ku1apO2F1wHk+v5C34IiaQJKobka2DA4MHWPEQl2Tv2x5FnES70cVQ09DoOMCC2C/Pl5gl6VDBdDF0tHf1ZaLtpdt/ml0wbZz3PXHusWJWI0WgtVqMeqsXRSv4DijT98ExcdtJ5+udWBL9nBClo9ZtJQySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147546; c=relaxed/simple;
	bh=+Q+fZIf/3tpaLdCAvKpIPWxPOj8fd2CONGt5XGoTfV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1OVf6FY8sR5f6oadwPQ9mvidkUHtXHe6oAznfsXYmGUT/0bYnD7eFKO/s6NqYnNBwOAIFrZj47be7VaoLQ+9lfLgj9OuEGS9Dp9sB+WhzDJl0DJqlcOc0C+tlacQ8+e0w9JyvkfLOqf0XXaL/A1mR0eBQi+mxpdJRkAAmFm274=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KmGulzZO; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513a06ef9b6so1858926e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 01:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710147542; x=1710752342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6quCqTERuQXSWVpIHU/UfMAkW79KK4YYk+htmPUgKvQ=;
        b=KmGulzZOwxWrjjRZ5kfLWHTOBc/0i8syTchxXuTGJVyWpw2zuWCTrjvzAIho2BgZvN
         0pnUrxcMdG4cdScd+I2Mzkpnkozvau6lr6aUFuf+Pl0HUtZXFu6uN6AReTxwVqwjmQgF
         J0ly0XiPyz6xlnBu4ECIkHsFpexeKN34xPPUKf83Rv4ZWu7XMs6IXrGa4MR2m2UmnQh1
         BFTAWjd5j15Uwsn/BPv/8IymCvUhyWGgGqSISiO4IxwgFsuO+cgRl9yEGtsQC9+8Dl7C
         qn/CffrRVLZa123Vhaye5W1Im9QCAaUnQQLMfdjg6dJFxD62rGXISUPLsOHBzTpigocc
         swnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710147542; x=1710752342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6quCqTERuQXSWVpIHU/UfMAkW79KK4YYk+htmPUgKvQ=;
        b=Lk9ZyhsqGvdj868cBb8VLW6A248JXnf9L9HYQNt7wByc/H9IrmdZ0h7IkjBRJXJ2vG
         7A4XorgjC4dDmFY2j0vzp6E8Tw9VdLSWrNEdmt6Oa3XddU/Wk41dgXnyObdIgbjHlgja
         qCRuHrxA27oqfV0c54sSVVdi7CUozBAMDrjGexBBPbYs3MM57eOTeqLxm2+x01hdCHyU
         bFR3al9vz4HAPB0GonvYLB0GZS0iqv3Sy3589pJfHFKuD5zTFTNIZkN+ukVpiDzfFVgb
         vqKauI/viRrxhY4LY+cN7yPAv+6xVq2OTl70jgnmJKZfXy3aqmLdFTRlNvQ09iYTHb4/
         d9Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXM1/JXxu/jZvw43ZyJQJB3zkkQ/1OBYiDLV6ke5KCKz/mwEciVMCSvuzW/A2mk6+CU+Sdk/0dK5BigCxbhbzAMEBKc0bJQRQXfi/T1
X-Gm-Message-State: AOJu0YyYnqAN87qY5l23C+nDiPmxLLVB4WY15Fwh+kl7EhlhGDA6DMQ2
	wBOLXU8Y3yez1E0UetA+3QJcbaeO3WbEUgBtiJPco2SpC628/D2erw7ztfxLazO4SMFMRYmWkEh
	57mGSIl9qNpqhx1TjWC31ccw03SdafYb8tlpQ/w==
X-Google-Smtp-Source: AGHT+IFlkp3e4CtgfZVZ28SL5BFEktrP86Rzjen4+ZM9NYBNVmupVzUpaE4EocAABRs/fT2Qa39ZpMmx84njJT6mxAg=
X-Received: by 2002:ac2:5e91:0:b0:513:9f3e:7a69 with SMTP id
 b17-20020ac25e91000000b005139f3e7a69mr3350212lfq.21.1710147542312; Mon, 11
 Mar 2024 01:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308152723.831620-1-dtatulea@nvidia.com> <CAC_iWjJyDUbK+2+u=Uqeo7r7-Hy5aZQ=12eTEKaBnm8qYnR_8Q@mail.gmail.com>
 <23514ae26df83dbc700474d74466734680657cd2.camel@nvidia.com>
In-Reply-To: <23514ae26df83dbc700474d74466734680657cd2.camel@nvidia.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Mar 2024 10:58:26 +0200
Message-ID: <CAC_iWjKtQ7O+CQOmjtm55Qhs1GN8mYu1o=etvhtMRLC6Re46ew@mail.gmail.com>
Subject: Re: [PATCH net v3] net: esp: fix bad handling of pages from page_pool
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, Leon Romanovsky <leonro@nvidia.com>, 
	"Anatoli.Chechelnickiy@m.interpipe.biz" <Anatoli.Chechelnickiy@m.interpipe.biz>, 
	"brouer@redhat.com" <brouer@redhat.com>, "almasrymina@google.com" <almasrymina@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"mcroce@microsoft.com" <mcroce@microsoft.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, Gal Pressman <gal@nvidia.com>, 
	"ian.kumlien@gmail.com" <ian.kumlien@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dragos

On Mon, 11 Mar 2024 at 10:51, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>
> Hi Ilias,
>
> On Mon, 2024-03-11 at 10:43 +0200, Ilias Apalodimas wrote:
> > Hi Dragos,
> >
> > On Fri, 8 Mar 2024 at 17:27, Dragos Tatulea <dtatulea@nvidia.com> wrote=
:
> > >
> > > When the skb is reorganized during esp_output (!esp->inline), the pag=
es
> > > coming from the original skb fragments are supposed to be released ba=
ck
> > > to the system through put_page.
> > >  But if the skb fragment pages are
> > > originating from a page_pool, calling put_page on them will trigger a
> > > page_pool leak which will eventually result in a crash.
> > >
> >
> > Indeed if you call put_page, you will leak a page. But won't that skb
> > eventually be freed by skb_free_head()?
> >
> I don't think it will: if you look at esp_output_tail (!esp->inplace case=
), the
> skb frags are put on the sg list and then the skb is cut off to have a si=
ngle
> frag (with a "regular" page from x->xfrag). So if the pages from the old
> fragments are not freed here they will leak altogether.

Ok, if they won't reach that function -- which calls napi_pp_put_page
itself, then this looks sane

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Thanks,
> Dragos
>
> > Thanks
> > /Ilias
> >
> > > This leak can be easily observed when using CONFIG_DEBUG_VM and doing
> > > ipsec + gre (non offloaded) forwarding:
> > >
> > >   BUG: Bad page state in process ksoftirqd/16  pfn:1451b6
> > >   page:00000000de2b8d32 refcount:0 mapcount:0 mapping:000000000000000=
0 index:0x1451b6000 pfn:0x1451b6
> > >   flags: 0x200000000000000(node=3D0|zone=3D2)
> > >   page_type: 0xffffffff()
> > >   raw: 0200000000000000 dead000000000040 ffff88810d23c000 00000000000=
00000
> > >   raw: 00000001451b6000 0000000000000001 00000000ffffffff 00000000000=
00000
> > >   page dumped because: page_pool leak
> > >   Modules linked in: ip_gre gre mlx5_ib mlx5_core xt_conntrack xt_MAS=
QUERADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat xt_addrtype br_ne=
tfilter rpcrdma rdma_ucm ib_iser libiscsi scsi_transport_iscsi ib_umad rdma=
_cm ib_ipoib iw_cm ib_cm ib_uverbs ib_core overlay zram zsmalloc fuse [last=
 unloaded: mlx5_core]
> > >   CPU: 16 PID: 96 Comm: ksoftirqd/16 Not tainted 6.8.0-rc4+ #22
> > >   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0=
-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > >   Call Trace:
> > >    <TASK>
> > >    dump_stack_lvl+0x36/0x50
> > >    bad_page+0x70/0xf0
> > >    free_unref_page_prepare+0x27a/0x460
> > >    free_unref_page+0x38/0x120
> > >    esp_ssg_unref.isra.0+0x15f/0x200
> > >    esp_output_tail+0x66d/0x780
> > >    esp_xmit+0x2c5/0x360
> > >    validate_xmit_xfrm+0x313/0x370
> > >    ? validate_xmit_skb+0x1d/0x330
> > >    validate_xmit_skb_list+0x4c/0x70
> > >    sch_direct_xmit+0x23e/0x350
> > >    __dev_queue_xmit+0x337/0xba0
> > >    ? nf_hook_slow+0x3f/0xd0
> > >    ip_finish_output2+0x25e/0x580
> > >    iptunnel_xmit+0x19b/0x240
> > >    ip_tunnel_xmit+0x5fb/0xb60
> > >    ipgre_xmit+0x14d/0x280 [ip_gre]
> > >    dev_hard_start_xmit+0xc3/0x1c0
> > >    __dev_queue_xmit+0x208/0xba0
> > >    ? nf_hook_slow+0x3f/0xd0
> > >    ip_finish_output2+0x1ca/0x580
> > >    ip_sublist_rcv_finish+0x32/0x40
> > >    ip_sublist_rcv+0x1b2/0x1f0
> > >    ? ip_rcv_finish_core.constprop.0+0x460/0x460
> > >    ip_list_rcv+0x103/0x130
> > >    __netif_receive_skb_list_core+0x181/0x1e0
> > >    netif_receive_skb_list_internal+0x1b3/0x2c0
> > >    napi_gro_receive+0xc8/0x200
> > >    gro_cell_poll+0x52/0x90
> > >    __napi_poll+0x25/0x1a0
> > >    net_rx_action+0x28e/0x300
> > >    __do_softirq+0xc3/0x276
> > >    ? sort_range+0x20/0x20
> > >    run_ksoftirqd+0x1e/0x30
> > >    smpboot_thread_fn+0xa6/0x130
> > >    kthread+0xcd/0x100
> > >    ? kthread_complete_and_exit+0x20/0x20
> > >    ret_from_fork+0x31/0x50
> > >    ? kthread_complete_and_exit+0x20/0x20
> > >    ret_from_fork_asm+0x11/0x20
> > >    </TASK>
> > >
> > > The suggested fix is to introduce a new wrapper (skb_page_unref) that
> > > covers page refcounting for page_pool pages as well.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycli=
ng")
> > > Reported-and-tested-by: Anatoli N.Chechelnickiy <Anatoli.Chechelnicki=
y@m.interpipe.biz>
> > > Reported-by: Ian Kumlien <ian.kumlien@gmail.com>
> > > Link: https://lore.kernel.org/netdev/CAA85sZvvHtrpTQRqdaOx6gd55zPAVsq=
MYk_Lwh4Md5knTq7AyA@mail.gmail.com
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > > Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> > > ---
> > > Changes in v2:
> > > - Fixes in tags.
> > >
> > > Changes in v3:
> > > - Rebased to ipsec tree.
> > > ---
> > >  include/linux/skbuff.h | 10 ++++++++++
> > >  net/ipv4/esp4.c        |  8 ++++----
> > >  net/ipv6/esp6.c        |  8 ++++----
> > >  3 files changed, 18 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > index 2dde34c29203..d9a1ccfb5708 100644
> > > --- a/include/linux/skbuff.h
> > > +++ b/include/linux/skbuff.h
> > > @@ -3448,6 +3448,16 @@ static inline void skb_frag_ref(struct sk_buff=
 *skb, int f)
> > >
> > >  bool napi_pp_put_page(struct page *page, bool napi_safe);
> > >
> > > +static inline void
> > > +skb_page_unref(const struct sk_buff *skb, struct page *page, bool na=
pi_safe)
> > > +{
> > > +#ifdef CONFIG_PAGE_POOL
> > > +       if (skb->pp_recycle && napi_pp_put_page(page, napi_safe))
> > > +               return;
> > > +#endif
> > > +       put_page(page);
> > > +}
> > > +
> > >  static inline void
> > >  napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
> > >  {
> > > diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> > > index 4dd9e5040672..d33d12421814 100644
> > > --- a/net/ipv4/esp4.c
> > > +++ b/net/ipv4/esp4.c
> > > @@ -95,7 +95,7 @@ static inline struct scatterlist *esp_req_sg(struct=
 crypto_aead *aead,
> > >                              __alignof__(struct scatterlist));
> > >  }
> > >
> > > -static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
> > > +static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk=
_buff *skb)
> > >  {
> > >         struct crypto_aead *aead =3D x->data;
> > >         int extralen =3D 0;
> > > @@ -114,7 +114,7 @@ static void esp_ssg_unref(struct xfrm_state *x, v=
oid *tmp)
> > >          */
> > >         if (req->src !=3D req->dst)
> > >                 for (sg =3D sg_next(req->src); sg; sg =3D sg_next(sg)=
)
> > > -                       put_page(sg_page(sg));
> > > +                       skb_page_unref(skb, sg_page(sg), false);
> > >  }
> > >
> > >  #ifdef CONFIG_INET_ESPINTCP
> > > @@ -260,7 +260,7 @@ static void esp_output_done(void *data, int err)
> > >         }
> > >
> > >         tmp =3D ESP_SKB_CB(skb)->tmp;
> > > -       esp_ssg_unref(x, tmp);
> > > +       esp_ssg_unref(x, tmp, skb);
> > >         kfree(tmp);
> > >
> > >         if (xo && (xo->flags & XFRM_DEV_RESUME)) {
> > > @@ -639,7 +639,7 @@ int esp_output_tail(struct xfrm_state *x, struct =
sk_buff *skb, struct esp_info *
> > >         }
> > >
> > >         if (sg !=3D dsg)
> > > -               esp_ssg_unref(x, tmp);
> > > +               esp_ssg_unref(x, tmp, skb);
> > >
> > >         if (!err && x->encap && x->encap->encap_type =3D=3D TCP_ENCAP=
_ESPINTCP)
> > >                 err =3D esp_output_tail_tcp(x, skb);
> > > diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> > > index 6e6efe026cdc..7371886d4f9f 100644
> > > --- a/net/ipv6/esp6.c
> > > +++ b/net/ipv6/esp6.c
> > > @@ -112,7 +112,7 @@ static inline struct scatterlist *esp_req_sg(stru=
ct crypto_aead *aead,
> > >                              __alignof__(struct scatterlist));
> > >  }
> > >
> > > -static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
> > > +static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk=
_buff *skb)
> > >  {
> > >         struct crypto_aead *aead =3D x->data;
> > >         int extralen =3D 0;
> > > @@ -131,7 +131,7 @@ static void esp_ssg_unref(struct xfrm_state *x, v=
oid *tmp)
> > >          */
> > >         if (req->src !=3D req->dst)
> > >                 for (sg =3D sg_next(req->src); sg; sg =3D sg_next(sg)=
)
> > > -                       put_page(sg_page(sg));
> > > +                       skb_page_unref(skb, sg_page(sg), false);
> > >  }
> > >
> > >  #ifdef CONFIG_INET6_ESPINTCP
> > > @@ -294,7 +294,7 @@ static void esp_output_done(void *data, int err)
> > >         }
> > >
> > >         tmp =3D ESP_SKB_CB(skb)->tmp;
> > > -       esp_ssg_unref(x, tmp);
> > > +       esp_ssg_unref(x, tmp, skb);
> > >         kfree(tmp);
> > >
> > >         esp_output_encap_csum(skb);
> > > @@ -677,7 +677,7 @@ int esp6_output_tail(struct xfrm_state *x, struct=
 sk_buff *skb, struct esp_info
> > >         }
> > >
> > >         if (sg !=3D dsg)
> > > -               esp_ssg_unref(x, tmp);
> > > +               esp_ssg_unref(x, tmp, skb);
> > >
> > >         if (!err && x->encap && x->encap->encap_type =3D=3D TCP_ENCAP=
_ESPINTCP)
> > >                 err =3D esp_output_tail_tcp(x, skb);
> > > --
> > > 2.42.0
> > >
>

