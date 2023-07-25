Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00B37608C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 06:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjGYEmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 00:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjGYEmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 00:42:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF0110EF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 21:42:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD9FF61518
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C66BC433CC;
        Tue, 25 Jul 2023 04:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690260123;
        bh=9xmLr5/SpwYPrO0t5OmP14xdMu9QQB8l/VYyS/cO+r8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ul69iYXkJmam1GUGJy/8oyYaGKYYZqCv1IooPEqIJAPloVQuj3Rkt7/pmw8X/pL/u
         9wb65jYb0pdr0t5nEni6wxFmmcsjwJEq+P6IGCohPPoRzMRny96OgqEicXxKFJm7nU
         HxnX0ZGs8ig7WXONybrQEMehS2VFJxDwsNw9Tqv8QReaVDgg4iaT+Q8lO8L9yAfCCo
         mtmjBLXslM5zmURhXe4fz2gY4klsbRgix89Dwm9m7pJYLhncabl0qVKteBaw3UOlxm
         L+XvCFL76dQz7P04UDQM2S9LEo1LkrD6NPmTviDPq+fHMSK77OjVx9lYzwpXmmsw4E
         HtB0FkF4SyXQQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fb7589b187so7721587e87.1;
        Mon, 24 Jul 2023 21:42:03 -0700 (PDT)
X-Gm-Message-State: ABy/qLas06e0YiMhptpW2X9WSMwAtiJHXILpFrUX2OBPj4TSEfTqD3xI
        BwldGqlo8WqwqaLAb/FwOD8gv00y1L5nL3AJBAQ=
X-Google-Smtp-Source: APBJJlFyAtElYyCfGJawPIpDGRfQKoZBHaUMfu6wlS9BjtKBT27GNCsuhDzHyvmFmL9/bO6ckhxumh8R8ccwgK3sBbE=
X-Received: by 2002:a05:6512:220f:b0:4fd:f84a:9901 with SMTP id
 h15-20020a056512220f00b004fdf84a9901mr3455408lfu.66.1690260121101; Mon, 24
 Jul 2023 21:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230724090044.2668064-1-ilia.lin@kernel.org> <20230724181105.GD11388@unreal>
In-Reply-To: <20230724181105.GD11388@unreal>
From:   Ilia Lin <ilia.lin@kernel.org>
Date:   Tue, 25 Jul 2023 07:41:49 +0300
X-Gmail-Original-Message-ID: <CA+5LGR3ifQbn4x9ncyjJLxsFU4NRs90rVcqECJ+-UC=pP35OjA@mail.gmail.com>
Message-ID: <CA+5LGR3ifQbn4x9ncyjJLxsFU4NRs90rVcqECJ+-UC=pP35OjA@mail.gmail.com>
Subject: Re: [PATCH] xfrm: kconfig: Fix XFRM_OFFLOAD dependency on XFRM
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, steffen.klassert@secunet.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leon,

This is exactly like I described:
* xfrm.h is included from the net/core/sock.c unconditionally.
* If CONFIG_XFRM_OFFLOAD is set, then the xfrm_dst_offload_ok() is
being compiled.
* If CONFIG_XFRM is not set, the struct dst_entry doesn't have the xfrm mem=
ber.
* xfrm_dst_offload_ok() tries to access the dst->xfrm and that fails to com=
pile.


Thanks,
Ilia Lin

On Mon, Jul 24, 2023 at 9:11=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Jul 24, 2023 at 12:00:44PM +0300, Ilia Lin wrote:
> > If XFRM_OFFLOAD is configured, but XFRM is not
>
> How did you do it?
>
> >, it will cause
> > compilation error on include xfrm.h:
> >  C 05:56:39 In file included from /src/linux/kernel_platform/msm-kernel=
/net/core/sock.c:127:
> >  C 05:56:39 /src/linux/kernel_platform/msm-kernel/include/net/xfrm.h:19=
32:30: error: no member named 'xfrm' in 'struct dst_entry'
> >  C 05:56:39         struct xfrm_state *x =3D dst->xfrm;
> >  C 05:56:39                                ~~~  ^
> >
> > Making the XFRM_OFFLOAD select the XFRM.
> >
> > Fixes: 48e01e001da31 ("ixgbe/ixgbevf: fix XFRM_ALGO dependency")
> > Reported-by: Ilia Lin <ilia.lin@kernel.org>
> > Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
> > ---
> >  net/xfrm/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
> > index 3adf31a83a79a..3fc2c1bcb5bbe 100644
> > --- a/net/xfrm/Kconfig
> > +++ b/net/xfrm/Kconfig
> > @@ -10,6 +10,7 @@ config XFRM
> >
> >  config XFRM_OFFLOAD
> >       bool
> > +     select XFRM
>
> struct dst_entry depends on CONFIG_XFRM and not on CONFIG_XFRM_OFFLOAD,
> so it is unclear to me why do you need to add new "select XFRM" line.
>
>    26 struct dst_entry {
>    27         struct net_device       *dev;
>    28         struct  dst_ops         *ops;
>    29         unsigned long           _metrics;
>    30         unsigned long           expires;
>    31 #ifdef CONFIG_XFRM
>    32         struct xfrm_state       *xfrm;
>    33 #else
>    34         void                    *__pad1;
>    35 #endif
>    36         int
>
> Thanks
