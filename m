Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67C180A836
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjLHQIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjLHQIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:08:07 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02FF1738;
        Fri,  8 Dec 2023 08:08:11 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rBdOQ-0000BK-RJ; Fri, 08 Dec 2023 17:07:58 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andy Yan <andyshrk@163.com>
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v4 00/17] Add VOP2 support on rk3588
Date:   Fri, 08 Dec 2023 17:07:57 +0100
Message-ID: <8765245.NyiUUSuA9g@diego>
In-Reply-To: <20231207075906.651771-1-andyshrk@163.com>
References: <20231207075906.651771-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Am Donnerstag, 7. Dezember 2023, 08:59:06 CET schrieb Andy Yan:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> This patch sets aims at enable the VOP2 support on rk3588.
> 
> Main feature of VOP2 on rk3588:
> Four video ports:
> VP0 Max 4096x2160
> VP1 Max 4096x2160
> VP2 Max 4096x2160
> VP3 Max 2048x1080
> 
> 4 4K Cluster windows with AFBC/line RGB and AFBC-only YUV support
> 4 4K Esmart windows with line RGB/YUV support
> 
> The current version support all the 8 windows with all the suppported
> plane format.
> 
> And we don't have a upstreamed encoder/connector(HDMI/DP) for rk3588
> yet, Cristian from collabora is working on adding upstream support for
> HDMI on rk3588.
> 
> My current test(1080P/4KP60) is runing with a HDMI driver pick from
> downstream bsp kernel.
> 
> A branch based on linux-6.7 rc4 containing all the series and
> HDMI driver(not compatible with mainline rk3568 hdmi) picked
> from downstream bsp kernel is available [0].
> 
> [0]https://github.com/andyshrk/linux/commits/rk3588-vop2-upstream-linux-6.7-rc4-2023-12-07
> 
> Changes in v4:
> - fix the POST_BUF_EMPTY irq when set mode
> - use full stop at all the description's end.
> - address Krzysztof's review about dt-binding in v3
> - keep all VOP2_FEATURE_HAS_xxx macros increase in order.
> - address Sascha's review about debugfs
> - Add const for rockchip,rk3588-iommu compatible

very nice, the error messages on "mode changes" are gone now.
Display and even combination with panthor still work of my rk3588-board

Tested-by: Heiko Stuebner <heiko@sntech.de>




