Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5677F77C7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345746AbjKXP1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjKXP1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:27:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9691723
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:27:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31458C433C7;
        Fri, 24 Nov 2023 15:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700839670;
        bh=3S6A8b26Bij0bNrwt/t+xt24Lf0F8C0vOwZNJyVcNWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pm1F5ZgXuK/SorA+zOMKMQQC8CS03YW6cr2R8Nt24B2t2nTlEQkZAU+W4HJJEAWmA
         I1lhSuqKqGbN1E7I+fOG54BHhwfOifc7knWoGptLzU5KtVTKvdm7h12SPsPXAnYm9+
         LM0z2qHnBkOf2DxrOcgZTpZ3VLqT4xnhkoz4Uv+w=
Date:   Fri, 24 Nov 2023 15:27:48 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <2023112458-stature-commuting-c66f@gregkh>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <2023112403-laxative-lustiness-6a7f@gregkh>
 <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 03:21:40PM +0000, Mark Brown wrote:
> On Fri, Nov 24, 2023 at 03:05:47PM +0000, Greg Kroah-Hartman wrote:
> 
> > Anyway, this is ripe for problems and issues in the long-run, what is so
> > special about this hardware that it can not just shutdown in the
> > existing order that it has to be "first" over everyone else?  What
> > exactly does this prevent and what devices are requiring this?
> 
> > And most importantly, what has changed in the past 20+ years to
> > suddenly require this new functionality and how does any other operating
> > system handle it?
> 
> This came out of some discussions about trying to handle emergency power
> failure notifications.

I'm sorry, but I don't know what that means.  Are you saying that the
kernel is now going to try to provide a hard guarantee that some devices
are going to be shut down in X number of seconds when asked?  If so, why
not do this in userspace?

thanks,

greg k-h
