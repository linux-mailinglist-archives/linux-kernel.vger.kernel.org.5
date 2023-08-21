Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8530178234E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 07:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjHUFse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 01:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjHUFsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 01:48:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B811A7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 22:48:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F06F60C95
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41793C433C7;
        Mon, 21 Aug 2023 05:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692596911;
        bh=YQFP4byjzjNAgKi0vhVTfVmJGzr/7b0FSyTH3jubeb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xfFEqGkSC7p2c2diveEBEhJvrtPnSJX2zU35C5nUg+oV8RkdHuQkf3z6NXTt88HI1
         b2pC+mAQ8L978D35YnbpcZ6Zq9gb4lstIMmdQNUkbwMKR76/XDfPyzTvAsrc2MPYFR
         X7wmEDhTtq2iNTqQeq3U+OWb4kxwtRMxBWXl3k7Q=
Date:   Mon, 21 Aug 2023 07:48:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eddie James <eajames@linux.ibm.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        linux-fsi@lists.ozlabs.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsi: i2cr: Switch to use struct i2c_driver's .probe()
Message-ID: <2023082119-volatile-vacation-ec45@gregkh>
References: <20230816171944.123705-1-u.kleine-koenig@pengutronix.de>
 <CACPK8XdP=t4fLioXE=hnxN_oA1Qyo9VZxjqoUSnNCBErWKRXEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACPK8XdP=t4fLioXE=hnxN_oA1Qyo9VZxjqoUSnNCBErWKRXEQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 04:57:52AM +0000, Joel Stanley wrote:
> On Wed, 16 Aug 2023 at 17:20, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > struct i2c_driver::probe_new is about to go away. Switch the driver to
> > use the probe callback with the same prototype.
> >
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >
> > this driver appeared in next just today. I intend to drop .probe_new
> > from struct i2c_driver after v6.6-rc1, so it would be great if this
> > patch would go in together with the commit adding this driver.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> Greg, can you please take this for 6.6?

Yes, will do, thanks.

greg k-h
