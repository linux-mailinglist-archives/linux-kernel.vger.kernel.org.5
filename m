Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA0F766BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbjG1L2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbjG1L2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:28:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3E43ABA;
        Fri, 28 Jul 2023 04:28:45 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DDE43755;
        Fri, 28 Jul 2023 13:27:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690543662;
        bh=zlio+8q8WgE1cCASCSlihC71qwk96p4bbXHtv0glq0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuWPhIO/YYEgbfTIXWn3aTKbMP5acyGC5ff9vDZeRXRQoQgQUa3qS8BRp/nClMsF6
         uAm2wil99ELCQFUzuc11RFuItkW5saS3ItEaW3rywSFgJeW7Jg9TwVinicYnnSNvwy
         DabGrmgnL5Lqnq3hy4clnPVNBvD1EKrI1kA4kDgY=
Date:   Fri, 28 Jul 2023 14:28:47 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Lee Jackson <lee.jackson@arducam.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        jacopo.mondi@ideasonboard.com
Subject: Re: [PATCH 0/2] media: i2c: imx519: Support for Sony IMX519 sensor
Message-ID: <20230728112847.GA5094@pendragon.ideasonboard.com>
References: <20230727154108.308320-1-umang.jain@ideasonboard.com>
 <169053432818.137962.5791887898514618663@Monstersaurus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <169053432818.137962.5791887898514618663@Monstersaurus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 09:52:08AM +0100, Kieran Bingham wrote:
> Hi Umang,
> 
> Quoting Umang Jain (2023-07-27 16:41:06)
> > Series adds driver support for Sony IMX519 sensor.
> > 
> > Lee, can do add S-o-B tags please to these patches
> > since I've updated your email IDs at various places from
> > info@ to lee.jackson@.
> 
> Can you dig and find out what your start point was here please?
> 
> This series should already be numbered at least v6, there are 5 previous
> postings. The most recent of which was already Signed off by
> 'lee.jackson@arducam.com' So that makes me weary that v5 was not used as
> the start point for this refresh.
> 
> Previous versions are identifiable here:
> 
> - https://patchwork.linuxtv.org/project/linux-media/list/?series=&submitter=&state=*&q=imx519&archive=both&delegate=
> 
> Could you check through any previous review comments and make sure they
> have all been addressed too please?
> 
> It would be useful if the cover letter or patch described a changelog
> from the previous version too to identify what has been updated.

I second this. A summary of the major changes in the cover letter plus a
detailed changelog in each patch is invaluable for review.

> I see the kernel test robot reported failures based on missing
> dependencies.
> 
> It's helpful to list any dependency information here in the cover
> letter too.

You can use the --base argument to git-format-patch to record the base
commit, and point in the cover letter to a public branch where the
series can be found.

> > Thanks!
> > 
> > Lee Jackson (2):
> >   media: dt-bindings: imx519: Add IMX519 DT bindings
> >   media: i2c: imx519: Support for the Sony IMX519 sensor
> > 
> >  .../bindings/media/i2c/sony,imx519.yaml       |  113 +
> >  MAINTAINERS                                   |    8 +
> >  drivers/media/i2c/Kconfig                     |   11 +
> >  drivers/media/i2c/Makefile                    |    1 +
> >  drivers/media/i2c/imx519.c                    | 2134 +++++++++++++++++
> >  5 files changed, 2267 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx519.yaml
> >  create mode 100644 drivers/media/i2c/imx519.c

-- 
Regards,

Laurent Pinchart
