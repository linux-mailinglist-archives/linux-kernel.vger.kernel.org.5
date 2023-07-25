Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92ED1760921
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjGYFT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjGYFTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:19:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3B0116
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:19:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AF5A614C7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F837C433C8;
        Tue, 25 Jul 2023 05:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690262361;
        bh=FTpOMJ1loIDWedIBp8bMdolnNSSRLdDcUGy5Kfd5820=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0BK/gW2XqdWD8kelMjt/3dU/vT03Tox7sWL1DG0QuSVnyLC5luP9yY8Tvc0HcYwg
         lbNEgpBi9jJ8s6MZHiG3kQ/B3sU/Zof9ocJFDXYi/HQYbKI5aIrmjZRwf72xLeoC8R
         tvO01Oz0P86XQ2JGksGRknEHWlQq9cHl9ners+mdv75CfNKPq4yFsn3Bfs7Gp8HaXY
         7l5hqjnos93WxOMDq2cRj09dwgW0RI3bgXyrQkn/fM0T6kPi2qZQv0QuXWGj+HTGo4
         Pur3MP/m/kCE5fSv/sj7DBmKjVgsUw1wiDm5G/hndw1DdrFttOj0I313NEJRkCTJc/
         6eZbE2/xdKl2w==
Date:   Tue, 25 Jul 2023 08:19:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ilia Lin <ilia.lin@kernel.org>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jeffrey.t.kirsher@intel.com
Subject: Re: [PATCH] xfrm: kconfig: Fix XFRM_OFFLOAD dependency on XFRM
Message-ID: <20230725051917.GH11388@unreal>
References: <20230724090044.2668064-1-ilia.lin@kernel.org>
 <20230724181105.GD11388@unreal>
 <CA+5LGR3ifQbn4x9ncyjJLxsFU4NRs90rVcqECJ+-UC=pP35OjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+5LGR3ifQbn4x9ncyjJLxsFU4NRs90rVcqECJ+-UC=pP35OjA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 07:41:49AM +0300, Ilia Lin wrote:
> Hi Leon,

You was already asked do not top-post.
https://lore.kernel.org/netdev/20230718105446.GD8808@unreal/
Please stop it.

> 
> This is exactly like I described:
> * xfrm.h is included from the net/core/sock.c unconditionally.
> * If CONFIG_XFRM_OFFLOAD is set, then the xfrm_dst_offload_ok() is
> being compiled.
> * If CONFIG_XFRM is not set, the struct dst_entry doesn't have the xfrm member.
> * xfrm_dst_offload_ok() tries to access the dst->xfrm and that fails to compile.

I asked two questions. First one was "How did you set XFRM_OFFLOAD
without XFRM?".

Thanks


> 
> 
> Thanks,
> Ilia Lin
> 
> On Mon, Jul 24, 2023 at 9:11 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Jul 24, 2023 at 12:00:44PM +0300, Ilia Lin wrote:
> > > If XFRM_OFFLOAD is configured, but XFRM is not
> >
> > How did you do it?
> >
> > >, it will cause
> > > compilation error on include xfrm.h:
> > >  C 05:56:39 In file included from /src/linux/kernel_platform/msm-kernel/net/core/sock.c:127:
> > >  C 05:56:39 /src/linux/kernel_platform/msm-kernel/include/net/xfrm.h:1932:30: error: no member named 'xfrm' in 'struct dst_entry'
> > >  C 05:56:39         struct xfrm_state *x = dst->xfrm;
> > >  C 05:56:39                                ~~~  ^
> > >
> > > Making the XFRM_OFFLOAD select the XFRM.
> > >
> > > Fixes: 48e01e001da31 ("ixgbe/ixgbevf: fix XFRM_ALGO dependency")
> > > Reported-by: Ilia Lin <ilia.lin@kernel.org>
> > > Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
> > > ---
> > >  net/xfrm/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
> > > index 3adf31a83a79a..3fc2c1bcb5bbe 100644
> > > --- a/net/xfrm/Kconfig
> > > +++ b/net/xfrm/Kconfig
> > > @@ -10,6 +10,7 @@ config XFRM
> > >
> > >  config XFRM_OFFLOAD
> > >       bool
> > > +     select XFRM
> >
> > struct dst_entry depends on CONFIG_XFRM and not on CONFIG_XFRM_OFFLOAD,
> > so it is unclear to me why do you need to add new "select XFRM" line.
> >
> >    26 struct dst_entry {
> >    27         struct net_device       *dev;
> >    28         struct  dst_ops         *ops;
> >    29         unsigned long           _metrics;
> >    30         unsigned long           expires;
> >    31 #ifdef CONFIG_XFRM
> >    32         struct xfrm_state       *xfrm;
> >    33 #else
> >    34         void                    *__pad1;
> >    35 #endif
> >    36         int
> >
> > Thanks
