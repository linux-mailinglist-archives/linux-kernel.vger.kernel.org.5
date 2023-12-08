Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7317A80ACC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574665AbjLHTTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574649AbjLHTTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:19:14 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D4410EF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:19:20 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id EB8CE20157B;
        Fri,  8 Dec 2023 19:19:17 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
        id 267DCA0081; Fri,  8 Dec 2023 20:19:08 +0100 (CET)
Date:   Fri, 8 Dec 2023 20:19:08 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Kalle Valo <kvalo@kernel.org>,
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
Message-ID: <ZXNsLJfqs9DLHb1Q@shine.dominikbrodowski.net>
References: <cover.1702051073.git.u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1702051073.git.u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, Dec 08, 2023 at 05:08:05PM +0100 schrieb Uwe Kleine-König:
> Hello,
> 
> this series changes all platform drivers in drivers/pcmcia to use the
> .remove_new() callback. See commit 5c5a7680e67b ("platform: Provide a
> remove callback that returns no value") for an extended explanation and
> the eventual goal.
> 
> All conversations are trivial, because all .remove() callbacks returned
> zero unconditionally already.
> 
> There are no interdependencies between these patches, so they could be
> picked up individually. However I'd expect them to go in all together.
> It's unclrear to me though, who will pick them up. Dominik? Greg?

Both options are fine with me. In the latter case:

	Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>

Best
	Dominik
