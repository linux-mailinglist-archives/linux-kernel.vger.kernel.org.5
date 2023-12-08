Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91B980A005
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573459AbjLHJyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjLHJyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:54:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D211724;
        Fri,  8 Dec 2023 01:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702029263; x=1733565263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FEzV6DVjh/Ga3HaHooYTXKaezfC0C7UbGiGx01741DE=;
  b=cSAFltPc2dnI3ZBwEBThccKs0yNEScJTTwPeUtgYakmmanb4/u6/cUwc
   iiIFNIRuUkjwxMcP+WTsp02ra3K+TINOXDxYmTyFrmgObBtzd6COTYyrl
   UCUnpwhlEqnqp/5M+GMwehmNt5KgyeWlwUSBVJCXFLOFO2ZXD8MgGo6Ln
   oD1wLnOpX7YnqI/dKNh82+r20pu8nvqGA4xVRwKNVH2FU3rXzeyBSFc56
   nqAGRv2UQWs2BAl/R30rQEJqYAuVAidDwI3Lvqj6vHZcsGD2f33StEkzc
   PK85xSa2SrVTBFLy+sshclDgWgqW3plG7z1oEccQl2iNhgmsKJeFEsvxU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="393252575"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="393252575"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 01:54:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="806353117"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="806353117"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 01:54:14 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id C7C0011F995;
        Fri,  8 Dec 2023 11:54:11 +0200 (EET)
Date:   Fri, 8 Dec 2023 09:54:11 +0000
From:   "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
To:     Zhi Mao =?utf-8?B?KOavm+aZuik=?= <zhi.mao@mediatek.com>
Cc:     "conor@kernel.org" <conor@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "yunkec@chromium.org" <yunkec@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
        "gerald.loacker@wolfvision.net" <gerald.loacker@wolfvision.net>,
        Shengnan Wang =?utf-8?B?KOeOi+Wco+eUtyk=?= 
        <shengnan.wang@mediatek.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Yaya Chang =?utf-8?B?KOW8tembhea4hSk=?= 
        <Yaya.Chang@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "bingbu.cao@intel.com" <bingbu.cao@intel.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "10572168@qq.com" <10572168@qq.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "macromorgan@hotmail.com" <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/2] media: i2c: Add GC08A3 image sensor driver
Message-ID: <ZXLnwzeD_DSuIyil@kekkonen.localdomain>
References: <20231207052016.25954-1-zhi.mao@mediatek.com>
 <20231207052016.25954-2-zhi.mao@mediatek.com>
 <ZXGtqwjYruBQVaUr@kekkonen.localdomain>
 <129e3a8b-5e91-424a-8ff8-b015d5175f1a@linaro.org>
 <20231207-outcome-acclaim-d179c8c07fff@spud>
 <0580bc5be77c5e293770f42b661a41c80e1986dd.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0580bc5be77c5e293770f42b661a41c80e1986dd.camel@mediatek.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhi,

On Fri, Dec 08, 2023 at 02:07:36AM +0000, Zhi Mao (毛智) wrote:
> On Thu, 2023-12-07 at 17:44 +0000, Conor Dooley wrote:
> > On Thu, Dec 07, 2023 at 01:30:35PM +0100, Krzysztof Kozlowski wrote:
> > > On 07/12/2023 12:34, Sakari Ailus wrote:
> > > > > +	ret = gc08a3_parse_fwnode(dev);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	gc08a3 = devm_kzalloc(dev, sizeof(*gc08a3),
> > > > > GFP_KERNEL);
> > > > > +	if (!gc08a3)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	gc08a3->dev = dev;
> > > > > +
> > > > > +	gc08a3->xclk = devm_clk_get(dev, NULL);
> > > > > +	if (IS_ERR(gc08a3->xclk))
> > > > > +		return dev_err_probe(dev, PTR_ERR(gc08a3-
> > > > > >xclk),
> > > > > +					 "failed to get
> > > > > xclk\n");
> > > > > +
> > > > > +	ret = clk_set_rate(gc08a3->xclk,
> > > > > GC08A3_DEFAULT_CLK_FREQ);
> > > > 
> > > > Please see:
> > > > <URL:
> > > > https://hverkuil.home.xs4all.nl/spec/driver-api/camera-sensor.html#devicetree>
> > > > ;.
> > > 
> > > 
> > > Oh, that's cool it was documented!
> > > 
> > > The canonical link would be:
> > > 
> https://www.kernel.org/doc/html/latest/driver-api/media/camera-sensor.html#devicetree
> > 
> > I believe this is that answer to the "why are these needed" that I
> > asked
> > on the previous version and never got a response to. Instead, they
> > were
> > just removed from the binding etc.
> 
> About "assigned-clocks" & "assigned-clock-rates" in v1 patch, as they
> are not used in sensor driver, I have removed them in sensor dts-
> bindind file. And "clock-names" & "clock-frequency" are also the same,
> they will be removed in next version.

Ack. You should only need "clocks" there, indeed.

-- 
Regards,

Sakari Ailus
