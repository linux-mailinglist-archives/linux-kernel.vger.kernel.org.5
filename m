Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B15764672
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjG0GIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjG0GIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3AE1710
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690438073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKhfa5geZjKIfZjztjHk2uQ3PoNr/mdgmW/R/LWd24U=;
        b=JjvTkOXzjWsZ8pHdAEqsYUMnD47wkxIvqnnBelEjue23AIFXG1cOAI7CZPXzIuIskthQJd
        i6hTclbvyrvorSrFDIrCYVVhMojZAxlWMA9mhonNn+ULR0DWyIbsMJINAUHl/wWFLkem+7
        LjJI5K1WeQ5gXjNQSMylXnnt7/K6NvE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-Wz2YR4rBPWqqRE5x1Bf1IA-1; Thu, 27 Jul 2023 02:07:51 -0400
X-MC-Unique: Wz2YR4rBPWqqRE5x1Bf1IA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9bb2d0b47so5040451fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690438070; x=1691042870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKhfa5geZjKIfZjztjHk2uQ3PoNr/mdgmW/R/LWd24U=;
        b=c64P+0m6FuX1wzL3F3wlSUdgtf7DmwvtcLH9jWNPDYDpptY7JgpZo/zEaLxRMmnE8C
         /dwXxSYqDV2jalj3qfuH+VSD2MZ0IZw2p1vO2MMiLR/TpJKhvcZEYdfynyj+FYdhLjMV
         L+hP9mxdWRKu6xw0aJidET7qXTuh1Wl3SGO0U+/lv8xPfjIgob7Li4yH9gnS/hWM3ooE
         C1KGsvjpZ20Y8AdB7V8OsMyVZ/yZ0dJV3NEeELEHXvJ8VnhkTDNwZ7aR8YZpmmn2RDP+
         4p3wxkOehwgxhRyB/Ggb/QLuRfPRDirk7OdHywr6gbVLA5oOu/zg71Au4BYjwMffPSCZ
         wLuw==
X-Gm-Message-State: ABy/qLaEC7NKU2us6qEhduLcXFVm13PrdENoYkLk7rOIrnPZ7m9wWpb/
        C/yMeHNMRHGAy0WiPZU8qZur2J/cQ4A54jWjTKWGJbRtK7uycdFVyQJeT6YSd7AqA4gTt4tAF+d
        G+is55rCgHAw/sx7AENDMP1hzbOdz4+GoEhhs3I1e
X-Received: by 2002:a2e:3812:0:b0:2b7:3b73:2589 with SMTP id f18-20020a2e3812000000b002b73b732589mr895696lja.32.1690438070199;
        Wed, 26 Jul 2023 23:07:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHhLW0YWxwG/nhKIg4TI3VlNVlEPvQjoVNWQ3o+mluSfSG1OIO7xuG9XQONNUkjDZfZnn1ooiv1FXY+Mm9NyQs=
X-Received: by 2002:a2e:3812:0:b0:2b7:3b73:2589 with SMTP id
 f18-20020a2e3812000000b002b73b732589mr895672lja.32.1690438069811; Wed, 26 Jul
 2023 23:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230725155403.796-1-andrew.kanner@gmail.com> <CACGkMEt=Cd8J995+0k=6MT1Pj=Fk9E_r2eZREptLt2osj_H-hA@mail.gmail.com>
 <ab722ec1-ae45-af1f-b869-e7339402c852@redhat.com> <179979e6-eb8a-0300-5445-999b9366250a@gmail.com>
 <0c06b067-349c-9fe2-2cc3-36c149fd5277@gmail.com>
In-Reply-To: <0c06b067-349c-9fe2-2cc3-36c149fd5277@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 27 Jul 2023 14:07:38 +0800
Message-ID: <CACGkMEsYzd1FphP-Ym9T9YjA9ZNBw7Mnw5xQ75dytQMJxDK3cg@mail.gmail.com>
Subject: Re: [PATCH v3] drivers: net: prevent tun_get_user() to exceed xdp
 size limits
To:     David Ahern <dsahern@gmail.com>
Cc:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Andrew Kanner <andrew.kanner@gmail.com>, brouer@redhat.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 8:27=E2=80=AFAM David Ahern <dsahern@gmail.com> wro=
te:
>
> On 7/26/23 1:37 PM, David Ahern wrote:
> > On 7/26/23 3:02 AM, Jesper Dangaard Brouer wrote:
> >> Cc. John and Ahern
> >>
> >> On 26/07/2023 04.09, Jason Wang wrote:
> >>> On Tue, Jul 25, 2023 at 11:54=E2=80=AFPM Andrew Kanner
> >>> <andrew.kanner@gmail.com> wrote:
> >>>>
> >>>> Syzkaller reported the following issue:
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> Too BIG xdp->frame_sz =3D 131072
> >>
> >> Is this a contiguous physical memory allocation?
> >>
> >> 131072 bytes equal order 5 page.
> >>
> >> Looking at tun.c code I cannot find a code path that could create
> >> order-5 skb->data, but only SKB with order-0 fragments.  But I guess i=
t
> >> is the netif_receive_generic_xdp() what will realloc to make this line=
ar
> >> (via skb_linearize())
> >
> >
> > get_tun_user is passed an iov_iter with a single segment of 65007
> > total_len. The alloc_skb path is hit with an align size of only 64. Tha=
t
> > is insufficient for XDP so the netif_receive_generic_xdp hits the
> > pskb_expand_head path. Something is off in the math in
> > netif_receive_generic_xdp resulting in the skb markers being off. That
> > causes bpf_prog_run_generic_xdp to compute the wrong frame_sz.
>
>
> BTW, it is pskb_expand_head that turns it from a 64kB to a 128 kB
> allocation. But the 128kB part is not relevant to the "bug" here really.
>
> The warn on getting tripped in bpf_xdp_adjust_tail is because xdp
> generic path is skb based and can have a frame_sz > 4kB. That's what the
> splat is about.

Other possibility:

tun_can_build_skb() doesn't count XDP_PACKET_HEADROOM this may end up
with producing a frame_sz which is greater than PAGE_SIZE as well in
tun_build_skb().

And rethink this patch, it looks wrong since it basically drops all
packets whose buflen is greater than PAGE_SIZE since it can't fall
back to tun_alloc_skb().

>
> Perhaps the solution is to remove the WARN_ON.

Yes, that is what I'm asking if this warning still makes sense in V1.

Thanks

>
>

