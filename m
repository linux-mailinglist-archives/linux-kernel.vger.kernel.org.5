Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B277610D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjGYK2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjGYK2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:28:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B11A1FC7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:27:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CC23615FB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1ACC433C7;
        Tue, 25 Jul 2023 10:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690280826;
        bh=dEUftBuVlThgLNzSUzD39UsyTnVeI1zwp2BGdviWBrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TEFDw1rUnewSFxDujnX4M1bWQ+pQFPlX+Lb7Ad/oSwZZUFC8Ddv/bwQU3FZjnj0/M
         VH9ULWCbJYwG0CX7eBIPJnutCyK4L9qLtpDTVBkom9tefKT6WBiV8SiIR5397ehmsd
         LQwFdgo2IsrCFeicn26DIUu5LnmlbXd4ZkxHyDdIbiz8rgrSEu5JGsjSbt38Zv2rYn
         9iT74l3K4xfq+HPUGI85UImETX95HtkqrolHY9kOiw8c/X1CRkvBpbvV1w7KWW1EQz
         tYanXCqFUPi9jChfp5dEd52cvuJV/3tbUk3iQusCjvqEZaBi/B1MAfnV2KU1xYqgDS
         GReDuBZkhRi+w==
Date:   Tue, 25 Jul 2023 13:27:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ilia Lin <ilia.lin@kernel.org>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jeffrey.t.kirsher@intel.com
Subject: Re: [PATCH] xfrm: kconfig: Fix XFRM_OFFLOAD dependency on XFRM
Message-ID: <20230725102702.GP11388@unreal>
References: <20230724090044.2668064-1-ilia.lin@kernel.org>
 <20230724181105.GD11388@unreal>
 <CA+5LGR3ifQbn4x9ncyjJLxsFU4NRs90rVcqECJ+-UC=pP35OjA@mail.gmail.com>
 <20230725051917.GH11388@unreal>
 <CA+5LGR2oDFEjJL5j715Pi9AtmJ7LXM82a63+rcyYow-E5trXtg@mail.gmail.com>
 <20230725093826.GO11388@unreal>
 <CA+5LGR1K-=-c8_pjyPTbT9B=SinHv8f61jzeOnjRDODffrPbsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+5LGR1K-=-c8_pjyPTbT9B=SinHv8f61jzeOnjRDODffrPbsQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 01:15:12PM +0300, Ilia Lin wrote:
> On Tue, Jul 25, 2023 at 12:38 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Jul 25, 2023 at 12:11:06PM +0300, Ilia Lin wrote:
> > > On Tue, Jul 25, 2023 at 8:19 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Tue, Jul 25, 2023 at 07:41:49AM +0300, Ilia Lin wrote:
> > > > > Hi Leon,
> > > >
> > > > You was already asked do not top-post.
> > > > https://lore.kernel.org/netdev/20230718105446.GD8808@unreal/
> > > > Please stop it.
> > > >
> > > > >
> > > > > This is exactly like I described:
> > > > > * xfrm.h is included from the net/core/sock.c unconditionally.
> > > > > * If CONFIG_XFRM_OFFLOAD is set, then the xfrm_dst_offload_ok() is
> > > > > being compiled.
> > > > > * If CONFIG_XFRM is not set, the struct dst_entry doesn't have the xfrm member.
> > > > > * xfrm_dst_offload_ok() tries to access the dst->xfrm and that fails to compile.
> > > >
> > > > I asked two questions. First one was "How did you set XFRM_OFFLOAD
> > > > without XFRM?".
> > > >
> > > > Thanks
> > > >
> > > In driver Kconfig: "select XFRM_OFFLOAD"
> >
> > In driver Kconfig, one should use "depends on XFRM_OFFLOAD" and not "select XFRM_OFFLOAD".
> > Drivers shouldn't enable XFRM_OFFLOAD directly and all upstream users are safe here.
> 
> Thank you for that information, but the XFRM_OFFLOAD doesn't depend on
> XFRM either.

Indirectly, XFRM_OFFLOAD depends on XFRM.

INET_ESP_OFFLOAD -> INET_ESP/XFRM_OFFLOAD -> XFRM_ESP -> XFRM_ALGO -> XFRM.

Thanks

> 
> >
> > Thanks
