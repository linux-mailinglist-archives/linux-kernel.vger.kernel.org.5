Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3FE7CC4E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343876AbjJQNkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjJQNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:40:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508E5F0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:40:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66226C433C8;
        Tue, 17 Oct 2023 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697550009;
        bh=Iux2S6qho2rTgeWzeBYd0Yu7vcjQMmCIVq4EvLtB6TU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clSb5/6ZoZlCvDEEmQezAhlI/9FJ+Ky5yHtWVzD6AUU9P9kPIHFxCN2OmR6Af2twB
         CzaBv6u6g7t+zPjUOau6iQi61AT1HZyQUEwGCOOzE43haZpU94+ZMMcfDbBQZeOihD
         f+ziwNspp3t6eQouy0WPnKqqlTI8nTz1vc3X/g+A=
Date:   Tue, 17 Oct 2023 15:40:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>,
        forest@alittletooquiet.net, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Rename variable bUpdateBBVGA, byCurrentCh, byCurPwr
 and byBBPreEDRSSI
Message-ID: <2023101747-goal-curing-5577@gregkh>
References: <cover.1697495597.git.gilbertadikankwu@gmail.com>
 <0f6661a4-7281-4d26-8c26-ba03a567fcaa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f6661a4-7281-4d26-8c26-ba03a567fcaa@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 08:19:49AM +0200, Philipp Hortmann wrote:
> On 10/17/23 00:58, Gilbert Adikankwu wrote:
> > Make the variable names adhere to Linux kernel coding style and mute
> > checkpatch.pl errors.
> > 
> > Gilbert Adikankwu (4):
> >    staging: vt6655: Rename variable bUpdateBBVGA
> >    staging: vt6655: Rename variable byCurrentCh
> >    staging: vt6655: Rename variable byCurPwr
> >    staging: vt6655: Rename variable byBBPreEDRSSI
> > 
> >   drivers/staging/vt6655/baseband.c    |  2 +-
> >   drivers/staging/vt6655/channel.c     | 18 +++++++++---------
> >   drivers/staging/vt6655/device.h      |  8 ++++----
> >   drivers/staging/vt6655/device_main.c |  8 ++++----
> >   drivers/staging/vt6655/dpc.c         |  2 +-
> >   drivers/staging/vt6655/rf.c          |  4 ++--
> >   6 files changed, 21 insertions(+), 21 deletions(-)
> > 
> 
> Hi,
> 
> -       if (priv->byCurrentCh == ch->hw_value)
> +       if (priv->current_ch == ch->hw_value)^M
>                 return ret;
> 
> ERROR: DOS line endings
> 
> What does the "^M" at the end of the new line?
> Did you run checkpatch on your patches?

I don't see that on my side, are you sure this is there?

thanks,

greg k-h
