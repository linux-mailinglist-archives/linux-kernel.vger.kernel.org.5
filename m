Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6411C75FDFF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjGXRn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGXRn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:43:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A88AE8;
        Mon, 24 Jul 2023 10:43:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AECCD735;
        Mon, 24 Jul 2023 19:42:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690220546;
        bh=kwfmp/sqlsVQsVO7dpAssDpc5Dx/dhRaxzilZclgzQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgKJbJR4Zc39ihfoN4qeql+P/kgW41LZKuBQI5eTfMWwJXGBls/u80OgF8DzjLURI
         DPYoFUBdJIiBTVgu0+6HvejMFx5gCQ0HsQduF+1BlxRhNm3LmZaz2Wt1tnSZwTWGgG
         rNRMVtEUy+Bs47cKJ3ZhxOI3UTv4eujiqdT56R4A=
Date:   Mon, 24 Jul 2023 20:43:31 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        petr@tesarici.cz, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1] sh: boards: fix CEU buffer size passed to
 dma_declare_coherent_memory()
Message-ID: <20230724174331.GD11977@pendragon.ideasonboard.com>
References: <20230724120742.2187-1-petrtesarik@huaweicloud.com>
 <20230724171229.GC11977@pendragon.ideasonboard.com>
 <31ad16fe8f1435805185ba8e889512ec181a867e.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31ad16fe8f1435805185ba8e889512ec181a867e.camel@physik.fu-berlin.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 07:29:27PM +0200, John Paul Adrian Glaubitz wrote:
> On Mon, 2023-07-24 at 20:12 +0300, Laurent Pinchart wrote:
> > On Mon, Jul 24, 2023 at 02:07:42PM +0200, Petr Tesarik wrote:
> > > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > > 
> > > In all these cases, the last argument to dma_declare_coherent_memory() is
> > > the buffer end address, but the expected value should be the size of the
> > > reserved region.
> > > 
> > > Fixes: 39fb993038e1 ("media: arch: sh: ap325rxa: Use new renesas-ceu camera driver")
> > > Fixes: c2f9b05fd5c1 ("media: arch: sh: ecovec: Use new renesas-ceu camera driver")
> > > Fixes: f3590dc32974 ("media: arch: sh: kfr2r09: Use new renesas-ceu camera driver")
> > > Fixes: 186c446f4b84 ("media: arch: sh: migor: Use new renesas-ceu camera driver")
> > > Fixes: 1a3c230b4151 ("media: arch: sh: ms7724se: Use new renesas-ceu camera driver")
> > > Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > But given that nobody noticed for 5 years, maybe we should drop
> > renesas-ceu support from those boards ? Or drop the boards completely ?
> 
> arch/sh is being maintained again, so it's save to keep these boards. At some point, we're
> going to convert the architecture to using Device Trees which should reduce the maintenance
> burden anyways.

Keeping the architecture is fine for newer systems, but is anyone really
maintaining the Renesas SH board ?

-- 
Regards,

Laurent Pinchart
