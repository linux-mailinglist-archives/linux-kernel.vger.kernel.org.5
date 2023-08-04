Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF227703E0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjHDPFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjHDPFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:05:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF0846B2;
        Fri,  4 Aug 2023 08:05:04 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C141012E4;
        Fri,  4 Aug 2023 17:03:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691161437;
        bh=tr+A81mL8nDcTz82HPvWaHO5DYHcvkl8gnXU6YqP/oA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NwnKqGOISSHCoT4g/onIOtdggT3c8VNVe6JntI6V+8rCGpENwgWORyCFsw5KPHQPn
         z9aUrJ9sF4Ag2/bqkXDyI2JmTZAejBZ21hI2p9CWsqv8wQDHzHf9Ryv+MgK5XnDPal
         Bm3mUPZxQnzBSY8IvBa5/qa4AO6u5zgCBJbM3K2k=
Date:   Fri, 4 Aug 2023 18:05:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Louis Kuo <louis.kuo@mediatek.com>,
        Phi-bang Nguyen <pnguyen@baylibre.com>,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        devicetree@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 sensor interface
Message-ID: <20230804150507.GI12951@pendragon.ideasonboard.com>
References: <20230630100321.1951138-1-jstephan@baylibre.com>
 <20230630100321.1951138-3-jstephan@baylibre.com>
 <da891ec5-473c-5bef-d88b-661fac70ed25@collabora.com>
 <72ixohoacq4vgj7nqg4l5gt5bs5e5ewain6a5ovqs3winx3qzz@sbg5lfohq5mq>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72ixohoacq4vgj7nqg4l5gt5bs5e5ewain6a5ovqs3winx3qzz@sbg5lfohq5mq>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 04:50:05PM +0200, Julien Stephan wrote:
> On Mon, Jul 03, 2023 at 01:02:02PM +0200, AngeloGioacchino Del Regno wrote:
> > Il 30/06/23 12:01, Julien Stephan ha scritto:
> ..snip..
> > > +
> > > +static const struct mtk_seninf_format_info mtk_seninf_formats[] = {
> > > +	{
> > > +		.code = MEDIA_BUS_FMT_SBGGR8_1X8,
> > > +		.flags = MTK_SENINF_FORMAT_BAYER,
> >
> > Each entry fits in one line.
> >
> > 	{ .code = MEDIA_BUS_FMT_SBGGR8_1X8, .flags = MTK_SENINF_FORMAT_BAYER },
> >
> 
> Hi Angelo,
> 
> Actually not all entries fit in one line. The last 4 ones don't:
> 
>        { .code = MEDIA_BUS_FMT_SGRBG10_DPCM8_1X8, .flags = MTK_SENINF_FORMAT_DPCM | MTK_SENINF_FORMAT_INPUT_ONLY },
> which is 115 chars..
> 
> so what is the best? put all in one line except the last 4 one? or keep
> them all as is?

I'd keep them all as is.

> > > +	}, {
> ..snip..
> > > +	udelay(1);
> > > +	mtk_seninf_input_update(input, SENINF_CTRL, CSI2_SW_RST, 0);
> >
> > Is there any way to check if the CSI port did reset, or is it *guaranteed* to get
> > out of reset in a microsecond after deasserting SW_RST?
> 
> I will double check this
> 
> > > +}
> > > +
> ..snip..
> > > +
> > > +	val = mtk_seninf_mux_read(mux, SENINF_MUX_CTRL);
> >
> > rst_mask = SENINF_MUX_CTRL_SENINF_IRQ_SW_RST | SENINF_MUX_CTRL_SENINF_MUX_SW_RST;
> >
> > writel(mux->base + SENINF_MUX_CTRL, val | rst_mask);
> > writel(mux->base + SENINFMUX_CTRL, val & ~rst_mask);
> >
> > that's better, right? :-)

With mtk_seninf_mux_write() instead of writel(), yes :-)

> right :)
> 
> > > +	mtk_seninf_mux_write(mux, SENINF_MUX_CTRL, val |
> > > +			     SENINF_MUX_CTRL_SENINF_IRQ_SW_RST |
> > > +			     SENINF_MUX_CTRL_SENINF_MUX_SW_RST);

-- 
Regards,

Laurent Pinchart
