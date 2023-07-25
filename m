Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F086C760F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjGYJju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjGYJjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:39:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C0AE4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:38:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73109615CC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E707C433C8;
        Tue, 25 Jul 2023 09:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690277910;
        bh=ctHfhoRdylUzYz2QPWQuPgSyO/aXFdULfe/vVVsiePk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FbNu7QEIfH6iAx/02yPCAFTBXbhvxiXFtM2E8QBtdEkdSncKPuC2RpMdVEt8FGtD0
         gkQQdbikxn2gU73QR584BJuGPjk/wSfODzYhKKWQQUTjIaj5QWB59f8uqURxk4VCgJ
         1rS5GPn7rQIsdMRXUXdNElFg52eDoJtmsHLzF95ItiLATTbyVOmHDJLiMbMa5Eu38P
         rn/smGIr0LeyvjnLItieNhtfw+oPuAqm4zYJ8/mKotfzSdfHRR63FSpNatDAZ7hp7N
         idUZkzkpF9PiR47vUenyBIDx6bpVM28valnultNU5skseNgV2C+BGBX7yDwlQvok+W
         5kvhWQ9gxWGMQ==
Date:   Tue, 25 Jul 2023 12:38:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ilia Lin <ilia.lin@gmail.com>
Cc:     Ilia Lin <ilia.lin@kernel.org>, steffen.klassert@secunet.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com
Subject: Re: [PATCH] xfrm: kconfig: Fix XFRM_OFFLOAD dependency on XFRM
Message-ID: <20230725093826.GO11388@unreal>
References: <20230724090044.2668064-1-ilia.lin@kernel.org>
 <20230724181105.GD11388@unreal>
 <CA+5LGR3ifQbn4x9ncyjJLxsFU4NRs90rVcqECJ+-UC=pP35OjA@mail.gmail.com>
 <20230725051917.GH11388@unreal>
 <CA+5LGR2oDFEjJL5j715Pi9AtmJ7LXM82a63+rcyYow-E5trXtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+5LGR2oDFEjJL5j715Pi9AtmJ7LXM82a63+rcyYow-E5trXtg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 12:11:06PM +0300, Ilia Lin wrote:
> On Tue, Jul 25, 2023 at 8:19 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Jul 25, 2023 at 07:41:49AM +0300, Ilia Lin wrote:
> > > Hi Leon,
> >
> > You was already asked do not top-post.
> > https://lore.kernel.org/netdev/20230718105446.GD8808@unreal/
> > Please stop it.
> >
> > >
> > > This is exactly like I described:
> > > * xfrm.h is included from the net/core/sock.c unconditionally.
> > > * If CONFIG_XFRM_OFFLOAD is set, then the xfrm_dst_offload_ok() is
> > > being compiled.
> > > * If CONFIG_XFRM is not set, the struct dst_entry doesn't have the xfrm member.
> > > * xfrm_dst_offload_ok() tries to access the dst->xfrm and that fails to compile.
> >
> > I asked two questions. First one was "How did you set XFRM_OFFLOAD
> > without XFRM?".
> >
> > Thanks
> >
> In driver Kconfig: "select XFRM_OFFLOAD"

In driver Kconfig, one should use "depends on XFRM_OFFLOAD" and not "select XFRM_OFFLOAD".
Drivers shouldn't enable XFRM_OFFLOAD directly and all upstream users are safe here.

Thanks
