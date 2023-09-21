Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6F47A97C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjIUR1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjIUR0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:26:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B01E57
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:03:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4EFC32781;
        Thu, 21 Sep 2023 14:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695306914;
        bh=Ashko9Vqxtf3QtmQTLjdXa1bJRP7FL+fu06wAfd3F7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FRMShh9/zX9wUDM9v8+QIfE2SHrgP+e4G8jiMmiY532CnUx1xx/BPojQLknskBGaV
         /tZuyOapRtkzGcTUI++k8EOhvB2FjvEDZpcWizWGkS3m2Gs6GV3ltV2UBvht06CInz
         GEPoh/stnSW9Sd3S0EaxIKvqU8O+UtDXE9lw9Bv1en7UzL6Xd5AkJO4dNNPPwBxA4h
         FxPhfiyO87F4c1lg/byqQEeOfnnYRPJcGfXSs1NDe5kJZmEj15AmnMWMkJyV/DGTau
         X6ah1ms2I5mjEosoSOYhpAXbs9WmDccDu41kAk+yb9oQUdHgu85ZAT+o+VrHlv1HWM
         TqwKyW4jUw2MA==
Date:   Thu, 21 Sep 2023 16:35:11 +0200
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sandor Yu <Sandor.yu@nxp.com>, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kernel@pengutronix.de,
        linux-imx@nxp.com, oliver.brown@nxp.com,
        alexander.stein@ew.tq-group.com, sam@ravnborg.org
Subject: Re: [PATCH v8 2/7] phy: Add HDMI configuration options
Message-ID: <ZQxUn3MEVuxU3h6I@matsya>
References: <20230808083243.3113192-1-Sandor.yu@nxp.com>
 <20230808083243.3113192-3-Sandor.yu@nxp.com>
 <c485b64e-3c83-4616-b8d8-76c2c7d56b0e@linaro.org>
 <ZOS+IQgFZYxN503B@matsya>
 <CAA8EJpokkjw_Q36YMh4p6NR+r4JGgM7_b+_QXtbmcPr6GzA=ug@mail.gmail.com>
 <ZQxMmtbqDTqgECnE@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQxMmtbqDTqgECnE@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-09-23, 16:01, Vinod Koul wrote:
> On 22-08-23, 20:22, Dmitry Baryshkov wrote:
> > On 22/08/2023 16:54, Vinod Koul wrote:
> > > On 17-08-23, 13:05, Dmitry Baryshkov wrote:
> > >> On 08/08/2023 11:32, Sandor Yu wrote:
> > >>> Allow HDMI PHYs to be configured through the generic
> > >>> functions through a custom structure added to the generic union.
> > >>>
> > >>> The parameters added here are based on HDMI PHY
> > >>> implementation practices.  The current set of parameters
> > >>> should cover the potential users.
> > >>>
> > >>> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > >>> ---
> > >>>    include/linux/phy/phy-hdmi.h | 24 ++++++++++++++++++++++++
> > >>>    include/linux/phy/phy.h      |  7 ++++++-
> > >>>    2 files changed, 30 insertions(+), 1 deletion(-)
> > >>>    create mode 100644 include/linux/phy/phy-hdmi.h
> > >>
> > >> I think this looks good now, thank you!
> > >>
> > >> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >
> > > Should this go thru drm or phy...?
> > 
> > I'd say, PHY, together with the other PHY patches. If you can merge
> > them into an immutable branch, then it can also be merged into
> > drm-misc (?) to provide the dependency between drm and phy parts.
> 
> phy/topic/hdmi should be pushed out in a bit for that

Sorry we need the drm header, so best to merge thru drm tree:

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
