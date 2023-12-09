Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5F880B4D3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 15:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjLIOE7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 9 Dec 2023 09:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 09:04:58 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05DDED;
        Sat,  9 Dec 2023 06:05:02 -0800 (PST)
Received: from i5e860d1d.versanet.de ([94.134.13.29] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rBxws-0003yF-PB; Sat, 09 Dec 2023 15:04:54 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andy Yan <andyshrk@163.com>, Andy Yan <andy.yan@rock-chips.com>
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com
Subject: Re: [PATCH v4 15/17] dt-bindings: iommu: rockchip: Add Rockchip RK3588
Date:   Sat, 09 Dec 2023 15:04:53 +0100
Message-ID: <2860437.jE0xQCEvom@diego>
In-Reply-To: <bbf4d7a5-a6f5-447a-9f3e-1cd6f2acc7c9@rock-chips.com>
References: <20231207075906.651771-1-andyshrk@163.com> <4012684.R56niFO833@diego>
 <bbf4d7a5-a6f5-447a-9f3e-1cd6f2acc7c9@rock-chips.com>
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

Hi Andy,

Am Samstag, 9. Dezember 2023, 02:26:25 CET schrieb Andy Yan:
> Hi Heiko:
> 
> On 12/9/23 00:29, Heiko Stübner wrote:
> > Am Donnerstag, 7. Dezember 2023, 09:02:35 CET schrieb Andy Yan:
> >> From: Andy Yan <andy.yan@rock-chips.com>
> >>
> >> Add a Rockchip RK3588 compatible
> >>
> >> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> > 
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > 
> > In the next iteration, please split this out into a separate patch and send
> > it to the iommu+dt maintainers.
> > 
> > Supporting the iommus on rk3588 can be realized separately and the
> > patch needs to go through a separate tree anyway.
> 
> Okay, I will split this patch out of this vop2 series, does this mean that
> I also need to split out the iommu dt node as a separate patch from current
> PATCH16 ?

no :-) .

The vop-iommu can stay together with the vop core node.
As adding the actual vop iommu is very much tied to the vop node.

For the iommu-compatible it was different. The compatible just declares
that the iommu acts similar to the one on rk3568, so is related to the iommu
driver itself and should go through the iommu tree.

So all is good here.

Heiko


