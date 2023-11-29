Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B357FDA29
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjK2OpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbjK2Ooj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:44:39 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207751991;
        Wed, 29 Nov 2023 06:44:38 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8D776896;
        Wed, 29 Nov 2023 15:43:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701269038;
        bh=hZ34+8XvuP5jUGm15VlG9omBwOmZ7i4xuna7zyqqhWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sB7Pw4l6wug0GxVw/0oM6yITWUCoa8OGlJ/whLhe4SQhKjrpmErBfMiNE+LaPJWw3
         RpWiKYKBqbuHEs+s4i6552FLVb8fR28igQkYohG+t3dFNlnYdLbe9Ocr3t2rdkTAAe
         0nlFHur4gLV4CLcD1pzJ8g6/U90LuHJ4ZnCRy56U=
Date:   Wed, 29 Nov 2023 16:44:41 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        kieran.bingham@ideasonboard.com, tomi.valkeinen@ideasonboard.com,
        umang.jain@ideasonboard.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Frank Li <Frank.Li@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp: Add DT nodes for the two ISPs
Message-ID: <20231129144441.GF24293@pendragon.ideasonboard.com>
References: <20231129093113.255161-1-paul.elder@ideasonboard.com>
 <20231129093113.255161-2-paul.elder@ideasonboard.com>
 <CAOMZO5BPQCyCQKPvc9HHqANk5rKic25EkUGCjBdf-d78zGDR0Q@mail.gmail.com>
 <CAHCN7xJyqEN_3GFCRogii_ST3oC354CBG6d029HGRnBKh=H_rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xJyqEN_3GFCRogii_ST3oC354CBG6d029HGRnBKh=H_rQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 07:49:31AM -0600, Adam Ford wrote:
> On Wed, Nov 29, 2023 at 5:59 AM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Paul,
> >
> > On Wed, Nov 29, 2023 at 6:31 AM Paul Elder <paul.elder@ideasonboard.com> wrote:
> >
> > > +                       isp_0: isp@32e10000 {
> > > +                               compatible = "fsl,imx8mp-isp";
> >
> > This compatible string is still not present in today's linux-next.
> >
> > Will it be merged soon?
> 
> Fabio,
> 
> Paul posted a series to the media mailing list adding support for the
> i.MX8MP ISP:
> 
> https://patchwork.linuxtv.org/project/linux-media/list/?series=11776

Paul, this is the kind of information that needs to go to the cover
letter, along with anything else that reviewers may need to review the
patches. Otherwise, as Fabio pointed out, it gets confusing. Please
expand the cover letter for the next iterations of the series.

> I am guessing it'll have to go through the review process.  I was CC'd
> because I did some previous testing before.  I have a Sony imx219 that
> works in 4-lane mode.  I'm likely to review and test tonight or
> tomorrow.  I am guessing he posted the DTS changes via a different
> series since they usually go through Shawn's branch instead of the
> media one.
> 
> Hopefully that helps.

-- 
Regards,

Laurent Pinchart
