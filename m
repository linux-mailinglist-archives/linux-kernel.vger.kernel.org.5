Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968F8757915
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjGRKP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGRKP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:15:28 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254B8F7;
        Tue, 18 Jul 2023 03:15:26 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b74fa5e7d7so84779941fa.2;
        Tue, 18 Jul 2023 03:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689675324; x=1692267324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GXe7LFwnlImcwwdc4HmK7zzQjIhvPYwKBh4lGmmYrg=;
        b=NtnkAJyM/bdvTZLpt2kaVhVDxQ7lAX6OT/W1mXApdOp66sznwDa7JGotYTQU1TdL1I
         tEMfWIa2oOmEBdEtGq+yxx4Dp8ZxT466V6ByphSYWHKutAES2wNn2G3pd84C9UJcOx57
         Z/uGouCmgU0L4RBDPkY0pFApaep8Bi4cbyDZ2HmQBAsGnOvNdaZhVCgSfcydjjlm8yVa
         6sId7tl1vuC2Vyr48h2llpf4AL47MQyFeaOBmScsRX3AODMdPm/b3G0KGZF2eCvz/XbL
         snFCBfsFsqhV0qaoRnJxLS+2T6BbhqH4qdZx67D9jyvocJ6ANNDFZ5HYc96xLgiYGvML
         X4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689675324; x=1692267324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GXe7LFwnlImcwwdc4HmK7zzQjIhvPYwKBh4lGmmYrg=;
        b=I4LapaGbNUulGM7IRROoJAXk0Q0HhYMC5Oum3b6hWui2lub17m+09DvuwxvzPXvSxD
         mpdTTd4P3GDT/w4H7s1XeyIK8QheztLrPymXEMQPaJFbDsJyXyGyWwP9fHXHq/E+bbLx
         MTqHCdvLNHuj5AQ+uQiXxD/LM0jd8znNWzOFlCo6qWNEfwJN1SFKsYdEWcF6IYszDt8D
         GmwN/QNGR0zk1KGplhPOOEFr/6EEi9llAbuYAba8nvvKGktkIZtvljGEIJMYyFgNTNeH
         j4SD1MPiQhMQsYakS1FchGb9Tbn9znoKFNSxgC692SZmhzR95V/DjmnHl8//TLAHaR/z
         pGLA==
X-Gm-Message-State: ABy/qLY33dkP3WzBzsxM2Vij9an3PFoDqKpwVepx/TISVabzaQeTGaWw
        m39FqilVG5BbITCeWJEiZSz8FlheDzxHK02eciZi3fSFX+k=
X-Google-Smtp-Source: APBJJlFNnXmjwt743qX/9ZZNGHeS0sB/YYsR5RvgAVpXFPVatqxS540+8A+ue5axcNRrOFyuNSVAfxW7cLXrGkscR3I=
X-Received: by 2002:a2e:2c05:0:b0:2b6:d89e:74e2 with SMTP id
 s5-20020a2e2c05000000b002b6d89e74e2mr10095689ljs.7.1689675323984; Tue, 18 Jul
 2023 03:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230718092405.4124345-1-quic_ilial@quicinc.com> <20230718095242.GC8808@unreal>
In-Reply-To: <20230718095242.GC8808@unreal>
From:   Ilia Lin <ilia.lin@gmail.com>
Date:   Tue, 18 Jul 2023 13:15:12 +0300
Message-ID: <CA+5LGR0q6ut3CRgOx7VUC3MdZ5oJXU6E8RE0QVgN_m8yBxb57A@mail.gmail.com>
Subject: Re: [PATCH] xfrm: Allow ESP over UDP in packet offload mode
To:     Ilia Lin <quic_ilial@quicinc.com>
Cc:     netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
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

Hi Leon,

Indeed the policy check is checking the sec_path lags set after
decapsulation, but this has nothing to do with UDP encapsulation, the
driver will set them anyway.
Regarding the driver support, each driver may restrict NAT-T support
in their state_add callback, so in common code it may stay allowed.

Thanks,
Ilia

BR,
Ilia Lin



On Tue, Jul 18, 2023 at 12:53=E2=80=AFPM Leon Romanovsky <leonro@nvidia.com=
> wrote:
>
> On Tue, Jul 18, 2023 at 12:24:05PM +0300, Ilia Lin wrote:
> > The ESP encapsulation is not supported only in crypto mode.
> > In packet offload mode, the RX is bypassing the XFRM,
> > so we can enable the encapsulation.
>
> It is not accurate. RX is bypassed after XFRM validated packet to ensure
> that it was really handled by HW.
>
> However, this patch should come with relevant driver code which should
> support ESP over UDP. You can see it here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?=
h=3Dxfrm-next
>  xfrm: Support UDP encapsulation in packet offload mode
>  net/mlx5e: Support IPsec NAT-T functionality
>  net/mlx5e: Check for IPsec NAT-T support
>  net/mlx5: Add relevant capabilities bits to support NAT-T
>
> Thanks
>
> >
> > Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
> > ---
> >  net/xfrm/xfrm_device.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> > index 4aff76c6f12e0..3018468d97662 100644
> > --- a/net/xfrm/xfrm_device.c
> > +++ b/net/xfrm/xfrm_device.c
> > @@ -246,8 +246,10 @@ int xfrm_dev_state_add(struct net *net, struct xfr=
m_state *x,
> >               return -EINVAL;
> >       }
> >
> > -     /* We don't yet support UDP encapsulation and TFC padding. */
> > -     if (x->encap || x->tfcpad) {
> > +     is_packet_offload =3D xuo->flags & XFRM_OFFLOAD_PACKET;
> > +
> > +     /* We don't yet support UDP encapsulation except full mode and TF=
C padding. */
> > +     if ((!is_packet_offload && x->encap) || x->tfcpad) {
> >               NL_SET_ERR_MSG(extack, "Encapsulation and TFC padding can=
't be offloaded");
> >               return -EINVAL;
> >       }
> > @@ -258,7 +260,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm=
_state *x,
> >               return -EINVAL;
> >       }
> >
> > -     is_packet_offload =3D xuo->flags & XFRM_OFFLOAD_PACKET;
> >       dev =3D dev_get_by_index(net, xuo->ifindex);
> >       if (!dev) {
> >               if (!(xuo->flags & XFRM_OFFLOAD_INBOUND)) {
> > --
> >
> >
