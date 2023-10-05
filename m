Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991FD7BA492
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbjJEQHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239448AbjJEQEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC17B0AF2;
        Thu,  5 Oct 2023 08:53:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67BCC433C7;
        Thu,  5 Oct 2023 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696521187;
        bh=1dXXUZoNd9H1ku/DZn+PYTr1rKUcUy43D3zKcJqbN1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyDh9I9IS6Kq/vnk+ueHz0ITrnRncC59csi5DKO8bkmY51giHoMt/oeOwnrEBugAG
         +zn7tOatkRCYSiJd50CPwWxeQswqhzzYIrbZ2YMQ71LZnv8AZGnd1IejUPG+kT62ik
         VdFVnXAQkNkJWhBv8J/jxnspSh7sNGd2hdFlZ5I1beXvfSFzQ3Hgx5H89Gk3ek4s8M
         HKx3OJQGaWfwEHGGghM+LyRpe+cVtIQIPIsQUtm7n0bO7hijtZ2MP2JVlnif+daHlj
         WPfzVQnOg7HpD8QO/Ua/MPTn7l8iaM630PHg+/hODmJm7mZLM0g9N7FY92UroUYTEu
         FdSdT/FOKGNBw==
Date:   Thu, 5 Oct 2023 16:53:02 +0100
From:   Lee Jones <lee@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/2] Match data improvements for pca955x driver
Message-ID: <20231005155302.GC808963@google.com>
References: <20230930175615.13301-1-biju.das.jz@bp.renesas.com>
 <20231005131140.GC681678@google.com>
 <OS0PR01MB59221DB73988292DE753DF6F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS0PR01MB59221DB73988292DE753DF6F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2023, Biju Das wrote:

> Hi Lee Jones,
> 
> > -----Original Message-----
> > From: Lee Jones <lee@kernel.org>
> > Sent: Thursday, October 5, 2023 2:12 PM
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: Pavel Machek <pavel@ucw.cz>; linux-leds@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Biju Das <biju.das.au@gmail.com>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>
> > Subject: Re: [PATCH v3 0/2] Match data improvements for pca955x driver
> > 
> > On Sat, 30 Sep 2023, Biju Das wrote:
> > 
> > > This patch series aims to add match data improvements for pca955x driver.
> > >
> > > This patch series is only compile tested.
> > >
> > > v2->v3:
> > >  * Added Rb tag from Andy.
> > >  * Dropped tabs from struct pca955x.
> > > v1->v2:
> > >  * Added Rb tag from Lee Jones for patch#1.
> > >  * Adeed patch#2 for cleanup of OF/ID table terminators.
> > >
> > > Biju Das (2):
> > >   leds: pca955x: Convert enum->pointer for data in the match tables
> > >   leds: pca955x: Cleanup OF/ID table terminators
> > >
> > >  drivers/leds/leds-pca955x.c | 71 +++++++++++++++----------------------
> > >  1 file changed, 29 insertions(+), 42 deletions(-)
> > 
> > These no longer apply.
> > 
> > Please rebase and submit a [RESEND] so I can apply them.
> 
> Can you please point me to the tree I need to rebase?
> 
> I believe previously I have rebased with [1], Please confirm.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git?h=for-leds-next

Yes, that'll do.  Or if you're prepared to wait for the overnight-sync
you can use Linux Next tomorrow.

-- 
Lee Jones [李琼斯]
