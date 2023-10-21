Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6FA7D1E25
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjJUQIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 12:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjJUQIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 12:08:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8371A4;
        Sat, 21 Oct 2023 09:08:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248A9C433C7;
        Sat, 21 Oct 2023 16:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697904488;
        bh=tuFYRsk3bNOuOUygXDv307K/7wnAfdhkWPE8kanea+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=StDeu3OOC+2jrDsncVeHBeXpPdFLk3JuiPQtvKWd5Plgnk4rr3cio2qvGG2/BgalO
         6EF6/N0r5IVaulFK7kQLzlDmXs1te5TMGpQmkVtg2m/5YYq/Y2lM0CUSJOVZaDY+hC
         oGhmKxCQj3RoZgH+QXWcO0ZP9PjAwXVOn5CgikIA=
Date:   Sat, 21 Oct 2023 18:08:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        ansuelsmth@gmail.com, m.brock@vanmierlo.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v4 1/3] tty: whitespaces in descriptions corrected by
 replacing tabs with spaces
Message-ID: <2023102114-ominous-flavoring-d41a@gregkh>
References: <20231019112809.881730-1-fe@dev.tdt.de>
 <20231019112809.881730-2-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019112809.881730-2-fe@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 01:28:07PM +0200, Florian Eckert wrote:
> Tabs were used in the function description, to make this look more
> uniform, the tabs were replaced by spaces where necessary.
> 
> While we're at it, I also replaced the 'ndashes' with simple dashes, since
> only those are supported by sphinx.
> 
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>

I'll just take this patch through my tty tree as that's where it
belongs, not through the led tree as there should not be any dependency
on it for any new features as you are only doing comment changes here.

thanks,

greg k-h
