Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0330576DEE4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjHCDUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjHCDUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05ACE48
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 20:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691032801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xmkb37qJbuRIYrnthhPzfB/RS4kzPPnwHV1byRzva8o=;
        b=RepakH1PgeXbTvEtKe43IhWPsu16oB+OepPsHt3iYc4zQ3Jf1N5j+BnNk2lNUqwNl+OtvA
        OXAPhbtf0jxpOoRM/fxQOa1LeAnEJHXN+etIa0JufKVF7nN0kS5AA0VK49TKJLgZHvLEWd
        Crl93PT6oitvHmROqKkapnrtob12eKk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-NtzXlGWOOZeh-bSX8w8NHg-1; Wed, 02 Aug 2023 23:20:00 -0400
X-MC-Unique: NtzXlGWOOZeh-bSX8w8NHg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fe43c2562aso290571e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 20:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691032799; x=1691637599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmkb37qJbuRIYrnthhPzfB/RS4kzPPnwHV1byRzva8o=;
        b=ONY41327rXcfGINR9ANj1CEDU4+WfDa5EpDhZ37IMml2lTrTukuLC6DEwZQHIVlwqU
         HYrihpvySZz08pt+WrZpkslVMLP7jGEVz1zJE3EqigsMEjQI/AOJJ+BhG/N+E5VInNqA
         vdH9EybRgh1VRrBpHIWJf8jZDaGvSt3QPC0skPeI4eo7LXyVxNFo8FvTRwhl1yCmZu6g
         GDYniEKoRL9r2a1TKFevD4K1Y9Cz9Eu/oMz0cwh8OviNL9pCxKEss0gbhI13X/WuezZX
         5TEW2yJhCiPRq1tyCSe12DXXGSIti5fTKkQfdso32/KOaivcw81hWg9HtQE6g7cZjpLp
         E2/g==
X-Gm-Message-State: ABy/qLaCJ7p9oF05PEfEY1s/MjZeRCkIDzRQHc7ZPPudY4AVVr4P0gdD
        ZjCuAl+utbnihLshQjj6J2ql+iSNBkZfWzg2lLj0g/R+n9UJPY+shC9AEcjG2iWwj4Fnvjuij+z
        ek2jHzza657Iw8YoJth1zxdO7WfFBp+dRWP16bkW2
X-Received: by 2002:a05:6512:318d:b0:4fe:2528:8c69 with SMTP id i13-20020a056512318d00b004fe25288c69mr2854970lfe.17.1691032798913;
        Wed, 02 Aug 2023 20:19:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF/2NgzaADWkLGGauovzd/v5mfkcrtS8swlvzvX+94eAhVV/HxU7ilWql2b4M4tl1XuQseOwoaGVVK03x5KOcc=
X-Received: by 2002:a05:6512:318d:b0:4fe:2528:8c69 with SMTP id
 i13-20020a056512318d00b004fe25288c69mr2854958lfe.17.1691032798530; Wed, 02
 Aug 2023 20:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230801220710.464-1-andrew.kanner@gmail.com> <2cb34364-0d7c-cf0a-487f-c15ba6568ac8@kernel.org>
In-Reply-To: <2cb34364-0d7c-cf0a-487f-c15ba6568ac8@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 3 Aug 2023 11:19:47 +0800
Message-ID: <CACGkMEvukuV5UZqb=MOaPqWfuJKOokZW1986GE4cRwt=Vx9Unw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drivers: net: prevent tun_build_skb() to exceed
 the packet size limit
To:     Jesper Dangaard Brouer <hawk@kernel.org>
Cc:     Andrew Kanner <andrew.kanner@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, dsahern@gmail.com, jbrouer@redhat.com,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 10:14=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 02/08/2023 00.07, Andrew Kanner wrote:
> > Using the syzkaller repro with reduced packet size it was discovered
> > that XDP_PACKET_HEADROOM is not checked in tun_can_build_skb(),
> > although pad may be incremented in tun_build_skb(). This may end up
> > with exceeding the PAGE_SIZE limit in tun_build_skb().
> >
> > Fixes: 7df13219d757 ("tun: reserve extra headroom only when XDP is set"=
)
> > Link: https://syzkaller.appspot.com/bug?extid=3Df817490f5bd20541b90a
> > Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> > ---
> >
> > Notes:
> >      v3 -> v4:
> >      * fall back to v1, fixing only missing XDP_PACKET_HEADROOM in pad =
and
> >        removing bpf_xdp_adjust_tail() check for frame_sz.
> >      * added rcu read lock, noted by Jason Wang <jasowang@redhat.com> i=
n v1
> >      * I decided to leave the packet length check in tun_can_build_skb(=
)
> >        instead of moving to tun_build_skb() suggested by Jason Wang
> >        <jasowang@redhat.com>. Otherwise extra packets will be dropped
> >        without falling back to tun_alloc_skb(). And in the discussion o=
f v3
> >        Jesper Dangaard Brouer <jbrouer@redhat.com> noticed that XDP is =
ok
> >        with a higher order pages if it's a contiguous physical memory
> >        allocation, so falling to tun_alloc_skb() -> do_xdp_generic() sh=
ould
> >        be ok.
> >
> >      v2 -> v3:
> >      * attach the forgotten changelog
> >
> >      v1 -> v2:
> >      * merged 2 patches in 1, fixing both issues: WARN_ON_ONCE with
> >        syzkaller repro and missing XDP_PACKET_HEADROOM in pad
> >      * changed the title and description of the execution path, suggest=
ed
> >        by Jason Wang <jasowang@redhat.com>
> >      * move the limit check from tun_can_build_skb() to tun_build_skb()=
 to
> >        remove duplication and locking issue, and also drop the packet i=
n
> >        case of a failed check - noted by Jason Wang <jasowang@redhat.co=
m>
> >
> >   drivers/net/tun.c | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index d75456adc62a..a1d04bc9485f 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1582,6 +1582,9 @@ static void tun_rx_batched(struct tun_struct *tun=
, struct tun_file *tfile,
> >   static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file=
 *tfile,
> >                             int len, int noblock, bool zerocopy)
> >   {
> > +     struct bpf_prog *xdp_prog;
> > +     int pad =3D TUN_RX_PAD;
> > +
> >       if ((tun->flags & TUN_TYPE_MASK) !=3D IFF_TAP)
> >               return false;
> >
> > @@ -1594,7 +1597,13 @@ static bool tun_can_build_skb(struct tun_struct =
*tun, struct tun_file *tfile,
> >       if (zerocopy)
> >               return false;
> >
> > -     if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
> > +     rcu_read_lock();
> > +     xdp_prog =3D rcu_dereference(tun->xdp_prog);
> > +     if (xdp_prog)
> > +             pad +=3D XDP_PACKET_HEADROOM;
> > +     rcu_read_unlock();
> > +
>
> Isolated seen, I guess, this is a correct fix to 7df13219d757.

I think so.

Actually, I think we can probably always count XDP_PACKET_HEADROOM
here. Since there's a window that XDP program might be attached in the
middle of tun_can_build_skb() and tun_build_skb().

>
> > +     if (SKB_DATA_ALIGN(len + pad) +
> >           SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE)
> >               return false;
> >
>
> Question to Jason Wang:
> Why fall back (to e.g. tun_alloc_skb()) when size is above PAGE_SIZE?
>
> AFAIK tun_build_skb() *can* create get larger packets than PAGE_SIZE
> from it's page_frag.  Is there a reason for this limitation?

I couldn't recall but I think we can relax.

Thanks

>
> (To Andrew, I assume a change in this area is another patch).
>
> --Jesper
>
>
>

