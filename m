Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C3E7800E6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355677AbjHQWM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355741AbjHQWMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:12:20 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C677135A4;
        Thu, 17 Aug 2023 15:12:01 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-44bf5a8598bso85434137.3;
        Thu, 17 Aug 2023 15:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692310321; x=1692915121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKzW1qsagZiZ5SXKF1K93AuCKmfVAku4MiXPKUa1AjA=;
        b=YJ4CAftZ6cebuEFArgjUXd6zZAE9Bmc0GbTAAGrG9MDrNZsiz7VP47CJ69a7DJgEQw
         qRTHywmYKZKMiXiSzVPxSONBS3th3eRksa0KiTnzEmja+EAFizfUQOWbAcQeAVcVpotD
         Dl4DxS/nPm2CLH1UZBXhilYTpuaZg2JVn4udB0qiAc4ZpGrE4+K7lzk0nwb9JSjO35my
         QxJ2sRkawWF91Ls0s95E/5Ch2uNARiiGVvYmqoe2j4gTb1/IzCkv3PAXfbeNxBBlzcSK
         bDB9gu4hgvK+R53zT0G93dWu3fkKJnWaG1PeqB+DY7F9FxP0LAHxQNcKMQO7uvSjavkk
         ip3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692310321; x=1692915121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKzW1qsagZiZ5SXKF1K93AuCKmfVAku4MiXPKUa1AjA=;
        b=GGgHfCk2+9H8ZQVxF1sLkyjUHExFy9rPRDv0AOIeureFyFcLFyOdwA5m7gcrAee8uP
         RcJoucWA7K2Vp/oQb08/vitEPoMHU8He16tj4d6b03+eY8mOznCDtSAVy3vfsDU1BWw5
         IyJyTXYqS0Ico/akUM1XWA2V4RJgoX1NZQ+fUtBCAk/gDoWoscaRIHhaBOI//EHxpBB5
         f7ZRHALoYRpCRs6AS/DnTxBlTTkHjKol5Kd64tEJPz+canvahavN+z40sXXQ5vWibS/d
         zib4+MVg5HkPACBlt6TqUQYc0sjC3Dktv5zNpAnKSsBzDFyvnROERJl1YifyNhZPCQSA
         Mqbw==
X-Gm-Message-State: AOJu0YzYtKEgXXrghdbpWbf1yPOA9sqDG0BL70W9kJ7AVXuZ89KzsCko
        4iGnUtFleBHNtYyIE3toi188vLsAGWBJMjNUnSc=
X-Google-Smtp-Source: AGHT+IHcirvC7P0ygxXyBj7Mkj7tszYFqc+LRkF5wAjhDS0F9kxYDwjIKRPlVOikYWoGUpYMMVFAVRJ5sDlOKd/y7jo=
X-Received: by 2002:a05:6102:411:b0:443:a4d2:86b9 with SMTP id
 d17-20020a056102041100b00443a4d286b9mr1031239vsq.0.1692310320840; Thu, 17 Aug
 2023 15:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230817151941.18692-1-feliu@nvidia.com> <CAF=yD-KN=-2fhc2nxxzr-bJ5kwQVFken_iTo4sBbuAkjmbn3fQ@mail.gmail.com>
 <b2edfbbf-1018-745e-2ce4-946ffe27e5e5@nvidia.com>
In-Reply-To: <b2edfbbf-1018-745e-2ce4-946ffe27e5e5@nvidia.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 17 Aug 2023 18:11:23 -0400
Message-ID: <CAF=yD-LBHYk=+ty1zTNnN_cU4NoJe0=VZwHy2zVkQiPVx_9gqw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] virtio_net: Introduce skb_vnet_common_hdr to
 avoid typecasting
To:     Feng Liu <feliu@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Simon Horman <horms@kernel.org>,
        Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 5:52=E2=80=AFPM Feng Liu <feliu@nvidia.com> wrote:
>
>
>
> On 2023-08-17 p.m.2:26, Willem de Bruijn wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Thu, Aug 17, 2023 at 11:20=E2=80=AFAM Feng Liu <feliu@nvidia.com> wr=
ote:
> >>
> >> The virtio_net driver currently deals with different versions and type=
s
> >> of virtio net headers, such as virtio_net_hdr_mrg_rxbuf,
> >> virtio_net_hdr_v1_hash, etc. Due to these variations, the code relies
> >> on multiple type casts to convert memory between different structures,
> >> potentially leading to bugs when there are changes in these structures=
.
> >>
> >> Introduces the "struct skb_vnet_common_hdr" as a unifying header
> >> structure using a union. With this approach, various virtio net header
> >> structures can be converted by accessing different members of this
> >> structure, thus eliminating the need for type casting and reducing the
> >> risk of potential bugs.
> >>
> >> For example following code:
> >> static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> >>                  struct receive_queue *rq,
> >>                  struct page *page, unsigned int offset,
> >>                  unsigned int len, unsigned int truesize,
> >>                  unsigned int headroom)
> >> {
> >> [...]
> >>          struct virtio_net_hdr_mrg_rxbuf *hdr;
> >> [...]
> >>          hdr_len =3D vi->hdr_len;
> >> [...]
> >> ok:
> >>          hdr =3D skb_vnet_hdr(skb);
> >>          memcpy(hdr, hdr_p, hdr_len);
> >> [...]
> >> }
> >>
> >> When VIRTIO_NET_F_HASH_REPORT feature is enabled, hdr_len =3D 20
> >> But the sizeof(*hdr) is 12,
> >> memcpy(hdr, hdr_p, hdr_len); will copy 20 bytes to the hdr,
> >> which make a potential risk of bug. And this risk can be avoided by
> >> introducing struct virtio_net_hdr_mrg_rxbuf.
> >
> > You mean virtio_net_common_hdr?
> >
> It is a typo, will correct it.
>
> > I'm not sure I follow the reasoning. Because then hdr_len might be
> > sizeof(virtio_net_hdr_mrg_rxbuf), but sizeof(virtio_net_common_hdr) is
> > larger. So the same issue remains?
> >
> static int virtnet_probe(struct virtio_device *vdev)
> {
> [...]
>         if (vi->has_rss_hash_report) {
>                 vi->hdr_len =3D sizeof(struct virtio_net_hdr_v1_hash); /*=
 hdr_len will
> be 20 bytes */
>         }
>         else if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF) ||
>                  virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>                 vi->hdr_len =3D sizeof(struct virtio_net_hdr_mrg_rxbuf);
>         else
>                 vi->hdr_len =3D sizeof(struct virtio_net_hdr);
> [...]
> }
>
> When VIRTIO_NET_F_HASH_REPORT is enabled, hdr_len =3D 20 (as above); and
> the size of virtio_net_hdr_mrg_rxbuf is 12, so virtio_net_hdr_mrg_rxbuf
> is wrong, should use struct virtio_net_common_hdr here.

I understand in this specific instance. I'm just saying that using sizeof c=
an
be wrong both in the new and old case.

This does not fix a real bug, as memcpy just uses hdr_len, which is correct=
.

> > Indeed, everywhere this patches replaces the one with the other, you
> > have to verify that nothing was using sizeof(*hdr). Which would not be
> > visible from the truncated patch contents itself.
> >
> Have checked. Nothing is using sizeof(*hdr).

Thanks.
>
> >>
> >> Change log
> >> v1->v2
> >> feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> >> feedback from Simon Horman <horms@kernel.org>
> >> 1. change to use net-next tree.
> >> 2. move skb_vnet_common_hdr inside kernel file instead of the UAPI hea=
der.
> >>
> >> Signed-off-by: Feng Liu <feliu@nvidia.com>
> >> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> >> ---
> >>   drivers/net/virtio_net.c | 36 +++++++++++++++++++++++-------------
> >>   1 file changed, 23 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index 1270c8d23463..03cf744de512 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -303,6 +303,13 @@ struct padded_vnet_hdr {
> >>          char padding[12];
> >>   };
> >>
> >> +struct virtio_net_common_hdr {
> >> +       union {
> >> +               struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
> >> +               struct virtio_net_hdr_v1_hash hash_v1_hdr;
> >> +       };
> >> +};
> >
> > Perhaps even add in struct virtio_net_hdr. As that is the original of
> > the three structs, and all the initial fields overlap.
> >
>
> But I didn't use virtio_net_hdr in this patch, is it redundant to put it
> here=EF=BC=9F what do you think?

That's true. But if we're going to add a helper to bind together alll the
virtio variants, then I think it should be there?

No strong opinion. Leave out if you prefer and no one else speaks up.

> >> @@ -1577,7 +1585,8 @@ static void receive_buf(struct virtnet_info *vi,=
 struct receive_queue *rq,
> >>   {
> >>          struct net_device *dev =3D vi->dev;
> >>          struct sk_buff *skb;
> >> -       struct virtio_net_hdr_mrg_rxbuf *hdr;
> >> +       struct virtio_net_common_hdr *common_hdr;
> >> +       struct virtio_net_hdr_mrg_rxbuf *mrg_hdr;
> >
> > No more need for this second struct now that we have the union. That's
> > its whole purpose?
>
> Yes, struct virtio_net_hdr_mrg_rxbuf *mrg_hdr is not needed. Writing
> mrg_hdr here is just to make the code look more concise, such as
> mrg_hdr->hdr.flags, if mrg_hdr is not used, it should be written as
> common_hdr->mrg_hdr.hdr.flags, I think it looks too long. what you think?

If we're going to continue to assign to different structs, then I'm honestl=
y
not sure how much this patch buys us.

Adding virtio_net_hdr to the union also shortens the code btw. Then it
can be common_hdr->hdr.flags

Also, just a shorter variable name than common_hdr. Fine to call it hdr.

>
> >>
> >>          if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> >>                  pr_debug("%s: short packet %i\n", dev->name, len);
> >> @@ -1597,18 +1606,19 @@ static void receive_buf(struct virtnet_info *v=
i, struct receive_queue *rq,
> >>          if (unlikely(!skb))
> >>                  return;
> >>
> >> -       hdr =3D skb_vnet_hdr(skb);
> >> +       common_hdr =3D skb_vnet_common_hdr(skb);
> >>          if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report=
)
> >> -               virtio_skb_set_hash((const struct virtio_net_hdr_v1_ha=
sh *)hdr, skb);
> >> +               virtio_skb_set_hash(&common_hdr->hash_v1_hdr, skb);
> >>
> >> -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> >> +       mrg_hdr =3D &common_hdr->mrg_hdr;
> >> +       if (mrg_hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> >>                  skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >>
> >> -       if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> >> +       if (virtio_net_hdr_to_skb(skb, &mrg_hdr->hdr,
> >>                                    virtio_is_little_endian(vi->vdev)))=
 {
> >>                  net_warn_ratelimited("%s: bad gso: type: %u, size: %u=
\n",
> >> -                                    dev->name, hdr->hdr.gso_type,
> >> -                                    hdr->hdr.gso_size);
> >> +                                    dev->name, mrg_hdr->hdr.gso_type,
> >> +                                    mrg_hdr->hdr.gso_size);
> >>                  goto frame_err;
> >>          }
> >>
> >> @@ -2105,7 +2115,7 @@ static int xmit_skb(struct send_queue *sq, struc=
t sk_buff *skb)
> >>          if (can_push)
> >>                  hdr =3D (struct virtio_net_hdr_mrg_rxbuf *)(skb->data=
 - hdr_len);
> >>          else
> >> -               hdr =3D skb_vnet_hdr(skb);
> >> +               hdr =3D &skb_vnet_common_hdr(skb)->mrg_hdr;
> >>
> >>          if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
> >>                                      virtio_is_little_endian(vi->vdev)=
, false,
> >> --
> >> 2.37.1 (Apple Git-137.1)
> >>
