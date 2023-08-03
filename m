Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E4676E85C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjHCMfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbjHCMfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:35:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30C7D3A87;
        Thu,  3 Aug 2023 05:35:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6CDB113E;
        Thu,  3 Aug 2023 05:35:54 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E27C23F6C4;
        Thu,  3 Aug 2023 05:35:08 -0700 (PDT)
Date:   Thu, 3 Aug 2023 13:35:06 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Martin Botka <martin@biqu3d.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/6] dt-bindings: arm: sunxi: Add BigTreeTech Manta
 board
Message-ID: <20230803133506.0abafd03@donnerap.manchester.arm.com>
In-Reply-To: <222684DD3067C1E9+20230802220309.163804-4-martin@biqu3d.com>
References: <20230802220309.163804-1-martin@biqu3d.com>
        <222684DD3067C1E9+20230802220309.163804-4-martin@biqu3d.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Aug 2023 00:02:36 +0200
Martin Botka <martin@biqu3d.com> wrote:

> From: Martin Botka <martin.botka@somainline.org>
> 
> Add name & compatible for BigTreeTech Manta boards
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> index 5ae1b81af6fc..e9e46434dd1a 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -155,6 +155,12 @@ properties:
>          items:
>            - const: bigtreetech,cb1
>            - const: allwinner,sun50i-h616
> +          

whitespace error here above (leading spaces)

And there is no need to split those additions to sunxi.yaml into separate
patches, so just put them all in one (but drop patch 2/6, as mentioned
there).

Cheers,
Andre

> +      - description: BigTreeTech Manta M4/8P
> +        items:
> +          - const: bigtreetech,cb1-manta
> +          - const: bigtreetech,cb1
> +          - const: allwinner,sun50i-h616
>  
>        - description: Chuwi V7 CW0825
>          items:

