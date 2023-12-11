Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9925480CA8C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343613AbjLKNIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343592AbjLKNIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:08:54 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28141AF;
        Mon, 11 Dec 2023 05:08:59 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rCg1k-0008Ku-TG; Mon, 11 Dec 2023 14:08:52 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, robin.murphy@arm.com,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, Andy Yan <andyshrk@163.com>
Cc:     Andy Yan <andy.yan@rock-chips.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        joro@8bytes.org, will@kernel.org
Subject: Re: [PATCH] dt-bindings: iommu: rockchip: Add Rockchip RK3588
Date:   Mon, 11 Dec 2023 14:08:51 +0100
Message-ID: <5370401.0VBMTVartN@diego>
In-Reply-To: <20231209015038.1457967-1-andyshrk@163.com>
References: <20231209015038.1457967-1-andyshrk@163.com>
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

Am Samstag, 9. Dezember 2023, 02:50:38 CET schrieb Andy Yan:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Add a Rockchip RK3588 compatible
> 
> I split it from the vop2 patch series as suggested by Heiko[0]

correct, but something with the addresses did go wrong

# scripts/get_maintainer.pl -f Documentation/devicetree/bindings/iommu/
lists among the other people especially:

Joerg Roedel <joro@8bytes.org> (maintainer:IOMMU SUBSYSTEM)
Will Deacon <will@kernel.org> (maintainer:IOMMU SUBSYSTEM)

as the maintainers for the iommu subsystem and I don't see them
in the recipient list.


Heiko



> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [0]https://patchwork.kernel.org/project/dri-devel/patch/20231207080235.652719-1-andyshrk@163.com/
> 
> ---
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




