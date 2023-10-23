Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DF37D3675
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjJWM1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjJWM1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:27:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C75FD;
        Mon, 23 Oct 2023 05:27:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07D3C433C8;
        Mon, 23 Oct 2023 12:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698064053;
        bh=Xp7fzzJQf8eXvhJSrsZLSWle47TqztytXWqSnLv99rM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=byT2dQKwYWhtzx2BDkCplAtpYbiDfYz/JV/dnQa49Kq4+kJpVstynSBMyR9/Kf6To
         NHXOvxc+DjZUM6e0PAmipBej82Nl5/yOylNYjN3f13u7VuQDm77qZwCjMQ/NvL/p0p
         3xKFjglcKAYSRNmmRkA8cfw+34Jhe6HPTeuVi80I=
Date:   Mon, 23 Oct 2023 14:27:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v5 2/2] leds: ledtrig-tty: add new line mode evaluation
Message-ID: <2023102320-princess-issuing-be13@gregkh>
References: <20231023094205.2706812-1-fe@dev.tdt.de>
 <20231023094205.2706812-3-fe@dev.tdt.de>
 <2023102341-jogger-matching-dded@gregkh>
 <7e8860574413505c314bdfd0f3e10188@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e8860574413505c314bdfd0f3e10188@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 02:15:55PM +0200, Florian Eckert wrote:
> > Again, I thought we had rx/tx already?  If not, how was that controlled
> > today?
> 
> It could not be controlled! The LED flashed when data where transferred.
> This was the only function that the trigger supported.

Ok, then maybe this needs to be a bit longer of a series.  One that does
the "tx/rx" feature, as that is needed today, and will be the more
complex one, and then one-per-line-setting that you want to apply.

That should make it much easier to review overall, right?

thanks,

greg k-h
