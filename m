Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C50380B370
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 10:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjLIJ2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 04:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLIJ2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 04:28:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154021700
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 01:28:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31ABDC433C8;
        Sat,  9 Dec 2023 09:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702114119;
        bh=MIsat85nOQkIEwt3WRkO5DGJ295mcp3uCca4s0RWya4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qlmu6LiADO/xn3OqfYhWyqtFTO6cK5VnCwZad1VZ5qbk3C32P38p42/+DGOoN39lO
         qnEkHFwIL6aaSi6izYQ+so5HbDiluggTRFOk470XxwRamtMJOlV4tFNv1DDOpPwhPV
         SI7JW/vbl9sZK3z44e5h6BMTXsQxHb+9VXRzvEEE=
Date:   Sat, 9 Dec 2023 10:28:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Pavel Machek <pavel@ucw.cz>,
        Kalle Valo <kvalo@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de
Subject: Re: [PATCH 0/7] pcmcia: Convert to platform remove callback
 returning void
Message-ID: <2023120930-possum-ignore-e8df@gregkh>
References: <cover.1702051073.git.u.kleine-koenig@pengutronix.de>
 <ZXNsLJfqs9DLHb1Q@shine.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXNsLJfqs9DLHb1Q@shine.dominikbrodowski.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 08:19:08PM +0100, Dominik Brodowski wrote:
> Am Fri, Dec 08, 2023 at 05:08:05PM +0100 schrieb Uwe Kleine-König:
> > Hello,
> > 
> > this series changes all platform drivers in drivers/pcmcia to use the
> > .remove_new() callback. See commit 5c5a7680e67b ("platform: Provide a
> > remove callback that returns no value") for an extended explanation and
> > the eventual goal.
> > 
> > All conversations are trivial, because all .remove() callbacks returned
> > zero unconditionally already.
> > 
> > There are no interdependencies between these patches, so they could be
> > picked up individually. However I'd expect them to go in all together.
> > It's unclrear to me though, who will pick them up. Dominik? Greg?
> 
> Both options are fine with me. In the latter case:
> 
> 	Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

I can take these, thanks!

greg k-h
