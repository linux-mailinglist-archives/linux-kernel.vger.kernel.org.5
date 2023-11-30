Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D90A7FFE21
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377079AbjK3V72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377044AbjK3V71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:59:27 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64331D48;
        Thu, 30 Nov 2023 13:59:31 -0800 (PST)
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id C664E1F8C9;
        Thu, 30 Nov 2023 22:59:27 +0100 (CET)
Received: from livingston (unknown [192.168.42.11])
        by gaggiata.pivistrello.it (Postfix) with ESMTP id 15BA07F848;
        Thu, 30 Nov 2023 22:59:10 +0100 (CET)
Received: from pivi by livingston with local (Exim 4.96)
        (envelope-from <francesco@dolcini.it>)
        id 1r8p3t-000149-2p;
        Thu, 30 Nov 2023 22:59:09 +0100
Date:   Thu, 30 Nov 2023 22:59:09 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Christian Loehle <christian.loehle@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <ZWkFrY1k2C_7LovQ@livingston.pivistrello.it>
References: <2023112458-stature-commuting-c66f@gregkh>
 <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
 <2023112435-dazzler-crisped-04a6@gregkh>
 <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
 <20231124185725.GA872366@pengutronix.de>
 <2023112520-paper-image-ef5d@gregkh>
 <20231125085038.GA877872@pengutronix.de>
 <a85b2d7e-4036-4bab-addf-45e0c2f6c335@arm.com>
 <20231127113611.GD877872@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127113611.GD877872@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On Mon, Nov 27, 2023 at 12:36:11PM +0100, Oleksij Rempel wrote:
> On Mon, Nov 27, 2023 at 10:13:49AM +0000, Christian Loehle wrote:
> > > Same problem was seen not only in automotive devices, but also in
> > > industrial or agricultural. With other words, it is important enough to bring
> > > some kind of solution mainline.
> > > 
> > 
> > IMO that is a serious problem with the used storage / eMMC in that case and it
> > is not suitable for industrial/automotive uses?
> > Any industrial/automotive-suitable storage device should detect under-voltage and
> > just treat it as a power-down/loss, and while that isn't nice for the storage device,
> > it really shouldn't be able to brick a device (within <1M cycles anyway).
> > What does the storage module vendor say about this?
> 
> Good question. I do not have insights ATM. I'll forward it.

From personal experience I can tell that bricked eMMC devices happen because of
eMMC controller firmware bugs. You might find some recently committed quirk
on this regard.

Waiting for any additional details you might be able to find, given my past
experience I would agree with what Christian wrote.

Francesco

