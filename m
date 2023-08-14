Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1443777BCDD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjHNPU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjHNPUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:20:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD1DE7E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB9E8615FB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF92C433C8;
        Mon, 14 Aug 2023 15:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692026445;
        bh=0MiIjS3nfvaQfGp1+RDGUO0INX5kTwftJzMwYEVSfrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irmSdkDT9pZgJSwZAGJDhazAQ/y05c6njIwaQceg/xx588uzbrG+oHACkn8QBatka
         2d1y2GOo20/LAYI/q1bCApPpUFkXvNoKvn8GMbMydGomdoHJYMmjdSJx/prMU1gQbs
         mwl13OKQwAT3KhZPZJk8QUrRY/Hm8jXmYa2Ge2lQ=
Date:   Mon, 14 Aug 2023 17:20:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavan Bobba <opensource206@gmail.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: replace camel case by snake case
Message-ID: <2023081442-cartridge-thaw-1656@gregkh>
References: <ZNOK2u1sJoRAxhIC@ubuntu.myguest.virtualbox.org>
 <2023081150-hamster-sulfide-4231@gregkh>
 <ZNfPiQAL3ixA7tjz@ubuntu.myguest.virtualbox.org>
 <alpine.DEB.2.22.394.2308122041160.3315@hadrien>
 <ZNolyVLwygowAzE2@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNolyVLwygowAzE2@ubuntu.myguest.virtualbox.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 06:32:01PM +0530, Pavan Bobba wrote:
> On Sat, Aug 12, 2023 at 08:41:51PM +0200, Julia Lawall wrote:
> > 
> > 
> > On Sat, 12 Aug 2023, Pavan Bobba wrote:
> > 
> > > On Fri, Aug 11, 2023 at 11:27:10PM +0200, Greg KH wrote:
> > > > On Wed, Aug 09, 2023 at 06:17:22PM +0530, Pavan Bobba wrote:
> > > > > Replace array name of camel case by snake case. Issue found
> > > > > by checkpatch
> > > > >
> > > > > Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> > > > > ---
> > > > >  v1 -> v2: 1. array name renamed from byVT3253B0_RFMD to by_vt3253b0_rfmd
> > > > >            2. typo in the subject line "small case" corrected with the
> > > > >               proper word "snake case"
> > > > >
> > > > > Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> > > > > ---
> > > > >  drivers/staging/vt6655/baseband.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
> > > > > index 0e135af8316b..cc8793256661 100644
> > > > > --- a/drivers/staging/vt6655/baseband.c
> > > > > +++ b/drivers/staging/vt6655/baseband.c
> > > > > @@ -499,7 +499,7 @@ static const unsigned char by_vt3253_init_tab_rfmd[CB_VT3253_INIT_FOR_RFMD][2] =
> > > > >  };
> > > > >
> > > > >  #define CB_VT3253B0_INIT_FOR_RFMD 256
> > > > > -static const unsigned char byVT3253B0_RFMD[CB_VT3253B0_INIT_FOR_RFMD][2] = {
> > > > > +static const unsigned char by_vt3253b0_rfmd[CB_VT3253B0_INIT_FOR_RFMD][2] = {
> > > >
> > > > Again, the "by" needs to just be dropped.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > hi greg...did'nt get your comment. can you please provide more elaborate
> > > info?
> > 
> > Drop the letter "by_" at the beginning of the function name.  It is there
> > ot indicate the type, which isn't done in the kernel.
> > 
> > julia
> 
> this is'nt a function name but an array name. is in't it fine?
> 

Not at all.  The issue is the name, why are you just adding a "_" here?
What does "by" mean?  (hint, this is a rhetorical question, I know, I
need you to figure it out so you know how to properly rename the
variable here...)

thanks,

greg k-h
