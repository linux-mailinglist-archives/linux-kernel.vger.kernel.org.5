Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C99C7C57C9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjJKPJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjJKPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:09:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB17A4;
        Wed, 11 Oct 2023 08:09:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B52FC433C9;
        Wed, 11 Oct 2023 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697036996;
        bh=NK7/zcAL72Zfq6YQF/vUxdXthgBdgQPxmKzGhiyQLLU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xb6qwA4CNigU6EZ/vw5T4xI8CNKktxyPfYHFobP8vYN2PS2b1eMTa9KzZKmWYJkoe
         pxLr/TfiXbtGtSv4Ny3qNUk0mGT1kUDVTUtoM3aAUACYa8LrGH2Wh9gRXuPsfdyMzu
         wdGvEANVijWWQy5xhw0vLEI84yrhOKDgZZbu6yvhb6C+GHmDJDZ+3J+YB5MF+JqQvV
         wdVpy4pJU+N6cQUD6oyaWVmu2nSS7rcfV6qSIHvCQZn3s5SPTNwTl2W4zvbZC+DJnc
         HPe03ERpdteJ8l7louBWQScthVQJhkzQxtKNd9oPhGB/7XODTLKlchESt+mK7MRLhO
         Llduy5PyXKIMA==
Date:   Wed, 11 Oct 2023 08:09:55 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Pavel Machek <pavel@ucw.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
Message-ID: <20231011080955.1beeb010@kernel.org>
In-Reply-To: <87r0m1fwg9.fsf@kernel.org>
References: <20231010155444.858483-1-arnd@kernel.org>
        <2023101051-unmasked-cleaver-79b3@gregkh>
        <87y1g94szz.fsf@kernel.org>
        <2023101139-pyromania-game-2237@gregkh>
        <87r0m1fwg9.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 10:29:58 +0300 Kalle Valo wrote:
> > No matter what the time frame is, it's never going to line up with all
> > distros, or catch everyone properly.  
> 
> Yeah, that's true.
> 
> > I recommend, just delete all the ones you feel are not being used, in a
> > patch that removes them one-by-one, so that it is trivial to revert if
> > someone shows up and says "hey, my device stopped working!" a few years
> > in the future.  
> 
> I'm starting to lean towards this as well. We have talked about this for
> so long now but no practical solution ever found so maybe just bite the
> bullet finally. What do others think?

FWIW in Ethernet we do what Greg says. Delete it, if someone complains
we revert back in. The revert did actually happen once, it was pretty
painless (Greg even took it into stable tree, IIRC).
