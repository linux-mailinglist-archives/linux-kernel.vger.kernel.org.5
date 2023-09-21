Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BDA7AA07A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjIUUiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjIUUhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:37:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AB986108
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338FDC4E74A;
        Thu, 21 Sep 2023 14:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695304861;
        bh=fBOyl4wnZj0qgJkc8bc1nWtNS7FruFf11iwwBxp/N8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XWV8ExU3oehstOxt6ss9ARdQ3g9ez+u6+VQS3HyjR5ECimrVni6bFZFstl0+/V0kw
         JpxRzExfIzPRzxjCdzv/dwZYuunuD7rRqne/9aQzuFb8xTgHxkdcU/Mpk++SgAM+WA
         ZDwqmGnB18k7KpGmtHgxu3t6Tx+DKqea37FrFud5B801Zq3BwF2aKzk8gcGfa5teC+
         hTwNlEJ+7HGWYQW4gdIsLidhqUypVI02ioF/spHiNPhbReMhpxAsOaOHYUTtgTDztn
         U6H9xDeXUUcCOYMwfzxb7Gb6HQRSiajHQ5awBJZH+bjOiP4068zL0P30B9/Pn2e/+H
         JEj6Y1JM6q45A==
Date:   Thu, 21 Sep 2023 16:00:58 +0200
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
Message-ID: <ZQxMmtbqDTqgECnE@matsya>
References: <20230808083243.3113192-1-Sandor.yu@nxp.com>
 <20230808083243.3113192-3-Sandor.yu@nxp.com>
 <c485b64e-3c83-4616-b8d8-76c2c7d56b0e@linaro.org>
 <ZOS+IQgFZYxN503B@matsya>
 <CAA8EJpokkjw_Q36YMh4p6NR+r4JGgM7_b+_QXtbmcPr6GzA=ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpokkjw_Q36YMh4p6NR+r4JGgM7_b+_QXtbmcPr6GzA=ug@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-23, 20:22, Dmitry Baryshkov wrote:
> On 22/08/2023 16:54, Vinod Koul wrote:
> > On 17-08-23, 13:05, Dmitry Baryshkov wrote:
> >> On 08/08/2023 11:32, Sandor Yu wrote:
> >>> Allow HDMI PHYs to be configured through the generic
> >>> functions through a custom structure added to the generic union.
> >>>
> >>> The parameters added here are based on HDMI PHY
> >>> implementation practices.  The current set of parameters
> >>> should cover the potential users.
> >>>
> >>> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> >>> ---
> >>>    include/linux/phy/phy-hdmi.h | 24 ++++++++++++++++++++++++
> >>>    include/linux/phy/phy.h      |  7 ++++++-
> >>>    2 files changed, 30 insertions(+), 1 deletion(-)
> >>>    create mode 100644 include/linux/phy/phy-hdmi.h
> >>
> >> I think this looks good now, thank you!
> >>
> >> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > Should this go thru drm or phy...?
> 
> I'd say, PHY, together with the other PHY patches. If you can merge
> them into an immutable branch, then it can also be merged into
> drm-misc (?) to provide the dependency between drm and phy parts.

phy/topic/hdmi should be pushed out in a bit for that

-- 
~Vinod
