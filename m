Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24051812C32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443620AbjLNJvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443623AbjLNJv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:51:27 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928611FF6;
        Thu, 14 Dec 2023 01:50:47 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rDiMN-00023i-MP; Thu, 14 Dec 2023 10:50:27 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     iommu@lists.linux.dev, Andy Yan <andyshrk@163.com>,
        joro@8bytes.org, jroedel@suse.de
Cc:     conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, robin.murphy@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Andy Yan <andy.yan@rock-chips.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: iommu: rockchip: Add Rockchip RK3588
Date:   Thu, 14 Dec 2023 10:50:26 +0100
Message-ID: <14263703.RDIVbhacDa@diego>
In-Reply-To: <20231212005710.1837066-1-andyshrk@163.com>
References: <20231212005710.1837066-1-andyshrk@163.com>
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

Hi Joerg,

Am Dienstag, 12. Dezember 2023, 01:57:10 CET schrieb Andy Yan:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Add a Rockchip RK3588 compatible
> 
> I split it from the vop2 patch series as suggested by Heiko[0]
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

could you possibly pick this patch for the iommu tree?


Thanks a lot
Heiko


> [0]https://patchwork.kernel.org/project/dri-devel/patch/20231207080235.652719-1-andyshrk@163.com/
> 
> ---
> 
> Changes in v2:
> - Add maintainers for the iommu subsystem to cc list
> 
>  .../devicetree/bindings/iommu/rockchip,iommu.yaml     | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> index ba9124f721f1..621dde0e45d8 100644
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> @@ -19,9 +19,14 @@ description: |+
>  
>  properties:
>    compatible:
> -    enum:
> -      - rockchip,iommu
> -      - rockchip,rk3568-iommu
> +    oneOf:
> +      - enum:
> +          - rockchip,iommu
> +          - rockchip,rk3568-iommu
> +      - items:
> +          - enum:
> +              - rockchip,rk3588-iommu
> +          - const: rockchip,rk3568-iommu
>  
>    reg:
>      items:
> 




