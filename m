Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1019276F5BC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjHCWad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjHCWaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:30:30 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAAC35AA;
        Thu,  3 Aug 2023 15:30:29 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C288312E4;
        Fri,  4 Aug 2023 00:29:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691101764;
        bh=LdfWIHFVh0wD7ytkzesn6ipqy1pHCP4s5brCJFt0pZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uBcmASI54b2A8zO/XorpCjFOoY63qQ4IWmiNFFz6/6Vzbl8XF6HbyQiLSUv8ohiFF
         V/i6P3OsBTCmnrz710MIIILwOCvVaSx+qhfWjf8NccoFQFHSurGnPB3k1ngJflvGdH
         KMch+ILrw2I4fNZXmXeUZr4f/yxSaHI2hOFqfJi0=
Date:   Fri, 4 Aug 2023 01:30:34 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
        Louis Kuo <louis.kuo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Message-ID: <20230803223034.GH9722@pendragon.ideasonboard.com>
References: <20230630100321.1951138-1-jstephan@baylibre.com>
 <20230630100321.1951138-5-jstephan@baylibre.com>
 <0430ddab-6a6c-9fa3-95bd-05ce8ac5b94f@collabora.com>
 <iq7jffjeaejdfb26a4ysjgjzuopov4ji2ecgzmv4563tdveaep@hh2gzgzkbdzj>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <iq7jffjeaejdfb26a4ysjgjzuopov4ji2ecgzmv4563tdveaep@hh2gzgzkbdzj>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 11:53:35AM +0200, Julien Stephan wrote:
> On Mon, Jul 03, 2023 at 02:21:17PM +0200, AngeloGioacchino Del Regno wrote:
> ..snip..
> > > +
> > > +	mtk_cam_init_cfg(&cam->subdev, NULL);
> >
> > mtk_cam_init_cfg() returns an integer, and this is probably because you expect
> > it to get logic to fail: in that case, check the result of that call here,
> > otherwise, make that function void.
> >
> 
> Hi Angelo,
> 
> mtk_cam_init_cfg returns an int because it should match v4l2_subdev_pad_ops->init_cfg prototype..
> 
> mtk_cam_init does not fail, always return 0, so I though it would be ok
> to discard the return value here. What do you think?

Fine with me.

> > > +
> 
> ..snip..
> 
> > > +	unsigned int bpp;
> >
> > Can we get any format that uses a billion bits per pixel? :-P
> >
> > u8 bpp;
> 
> I am preparing the driver for futur upgrades.. in a billion years ;)

-- 
Regards,

Laurent Pinchart
