Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB57F7867
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345945AbjKXP4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjKXP4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:56:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1492619AB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:56:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60918C433C8;
        Fri, 24 Nov 2023 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700841381;
        bh=ktg76xInNz3yDgDKOGDrZoRtJBgbawiwaapZiqgE40s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ee0EI2/5wbrPZb0t6H/nRBY5COnaGWkio79vCZ4JFyqmnZZyG6OWEVCUsop8dB6NX
         yN/0ECO9mkIq8lSvTO1wsYwq/Y0bwmkf6g8p7hd20C4fwGKmoXW7YYBPsSepUjd9jt
         1WweiLl581OiNu/jwpbQYnZApjHoPOFW0kA+wSYY=
Date:   Fri, 24 Nov 2023 15:56:19 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <2023112435-dazzler-crisped-04a6@gregkh>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <2023112403-laxative-lustiness-6a7f@gregkh>
 <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
 <2023112458-stature-commuting-c66f@gregkh>
 <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 03:49:46PM +0000, Mark Brown wrote:
> On Fri, Nov 24, 2023 at 03:27:48PM +0000, Greg Kroah-Hartman wrote:
> > On Fri, Nov 24, 2023 at 03:21:40PM +0000, Mark Brown wrote:
> 
> > > This came out of some discussions about trying to handle emergency power
> > > failure notifications.
> 
> > I'm sorry, but I don't know what that means.  Are you saying that the
> > kernel is now going to try to provide a hard guarantee that some devices
> > are going to be shut down in X number of seconds when asked?  If so, why
> > not do this in userspace?
> 
> No, it was initially (or when I initially saw it anyway) handling of
> notifications from regulators that they're in trouble and we have some
> small amount of time to do anything we might want to do about it before
> we expire.

So we are going to guarantee a "time" in which we are going to do
something?  Again, if that's required, why not do it in userspace using
a RT kernel?

thanks,

greg k-h
