Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F517FB41D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjK1Iap convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Nov 2023 03:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344131AbjK1Ial (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:30:41 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7FB10A;
        Tue, 28 Nov 2023 00:30:44 -0800 (PST)
Received: from i53875bf8.versanet.de ([83.135.91.248] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r7tUD-0002DK-Ck; Tue, 28 Nov 2023 09:30:29 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andy Yan <andyshrk@163.com>, Andy Yan <andy.yan@rock-chips.com>
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        s.hauer@pengutronix.de
Subject: Re: [PATCH v2 04/12] drm/rockchip: vop2: clear afbc en and transform bit for
 cluster window at linear mode
Date:   Tue, 28 Nov 2023 09:30:28 +0100
Message-ID: <15178289.EVyyLHbfrO@diego>
In-Reply-To: <ebe46d19-954d-4dbb-82ba-a443058e9f4e@rock-chips.com>
References: <20231122125316.3454268-1-andyshrk@163.com> <3927498.QCnGb9OGeP@diego>
 <ebe46d19-954d-4dbb-82ba-a443058e9f4e@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 28. November 2023, 09:03:46 CET schrieb Andy Yan:
> Hi Heiko:
> 
> On 11/27/23 23:02, Heiko Stübner wrote:
> > Am Mittwoch, 22. November 2023, 13:54:25 CET schrieb Andy Yan:
> >> From: Andy Yan <andy.yan@rock-chips.com>
> >>
> >> The enable bit and transform offset of cluster windows should be
> >> cleared when it work at linear mode, or we may have a iommu fault
> >> issue.
> >>
> >> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> > I guess same here?
> >
> > Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
> 
> 
> I'm not sure if we need a Fixes tag here,  in fact this issue never happens on
> 
> rk3566/8 , because the cluster windows of rk356x only support afbc format,
> 
> they don't have a chance to switch between afbc and linear mode.
> 
> Of course, the lack support of linear mode of rk356x cluster windows is a thoughtless
> 
> of IC design, if it really support both afbc and linear format, we indeed need this fix.
> 
> The situation is the same as patch 03/12.
> 
> So I hope follow your advice, if it need a Fixes tag here.

ah ok, thanks for the explanation. Then I guess we don't need a fixes tag
when the rk3568 is not affected by this.

Same for the other patch. If you're re-sending you could add this information
to the commit message though. (existing support for rk3568 only supports
afbc cluster windows and is therefore not affected)


Thanks
Heiko


