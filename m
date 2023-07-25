Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20330761379
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjGYLKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbjGYLK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:10:26 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A55B19AD;
        Tue, 25 Jul 2023 04:09:36 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BA2F6558;
        Tue, 25 Jul 2023 13:08:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690283316;
        bh=7+4Il3IVc/Zbx80Gpy5A1lPMlipCJSb39p9XylhbdCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVJz0cSZAewPPEQ3YAJpcHbDNvfn4ykHHKGUEqIBMQC3vzvCxrfbjUZ/T4EW1lKjP
         S5b0BvCJYCzXqsSKhCCTRAlKcEbrnRFu5PC82egC+C/yGq6qU0zliKQrVPu7E/gwY7
         D5a64R6qTWA8yiIsH+58SLMCDzKbwLYPiOrtGhts=
Date:   Tue, 25 Jul 2023 14:09:42 +0300
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
Message-ID: <20230725110942.GB31069@pendragon.ideasonboard.com>
References: <20230724120742.2187-1-petrtesarik@huaweicloud.com>
 <20230724171229.GC11977@pendragon.ideasonboard.com>
 <31ad16fe8f1435805185ba8e889512ec181a867e.camel@physik.fu-berlin.de>
 <20230724174331.GD11977@pendragon.ideasonboard.com>
 <314b21abaade55ba55ccdd930f9fdf24028cadf0.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <314b21abaade55ba55ccdd930f9fdf24028cadf0.camel@physik.fu-berlin.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 07:50:56AM +0200, John Paul Adrian Glaubitz wrote:
> On Mon, 2023-07-24 at 20:43 +0300, Laurent Pinchart wrote:
> > > arch/sh is being maintained again, so it's save to keep these boards. At some point, we're
> > > going to convert the architecture to using Device Trees which should reduce the maintenance
> > > burden anyways.
> > 
> > Keeping the architecture is fine for newer systems, but is anyone really
> > maintaining the Renesas SH board ?
> 
> I own Renesas evaluation boards, including SH7785LCR-based and
> SH7724-based boards.

Will you have time to port them to DT, or would you rather focus on
J-core systems ? Do those boards still boot a mainline kernel ?

Dropping Renesas SH board files doesn't preclude anyone from moving them
to DT, all the information will remain in the git history. Unless you
plan to move to DT in a reasonably near future, I think dropping support
for the CEU at least, if not the whole board files, could be a good
option.

-- 
Regards,

Laurent Pinchart
