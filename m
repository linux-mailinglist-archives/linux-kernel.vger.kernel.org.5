Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBEE7670F8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbjG1Pty convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jul 2023 11:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbjG1Ptw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:49:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF352681
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:49:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qPPim-0001iv-S3; Fri, 28 Jul 2023 17:49:40 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qPPil-002jwn-ME; Fri, 28 Jul 2023 17:49:39 +0200
Received: from pza by lupine with local (Exim 4.96)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qPPil-000H6q-11;
        Fri, 28 Jul 2023 17:49:39 +0200
Message-ID: <f7b72ee90009f6749700a7bd79a3a63786a82a32.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add compatible and DT
 bindings for Amlogic C3 Reset Controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     zelong dong <zelong.dong@amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, kelvin.zhang@amlogic.com
Date:   Fri, 28 Jul 2023 17:49:39 +0200
In-Reply-To: <20230719060954.14864-2-zelong.dong@amlogic.com>
References: <20230719060954.14864-1-zelong.dong@amlogic.com>
         <20230719060954.14864-2-zelong.dong@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2023-07-19 at 14:09 +0800, zelong dong wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> Add new compatible and DT bindings for Amlogic C3 Reset Controller
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> ---
>  .../bindings/reset/amlogic,meson-reset.yaml   |   1 +
>  include/dt-bindings/reset/amlogic,c3-reset.h  | 119 ++++++++++++++++++
>  2 files changed, 120 insertions(+)
>  create mode 100644 include/dt-bindings/reset/amlogic,c3-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> index d3fdee89d4f8..f0c6c0df0ce3 100644
> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> @@ -18,6 +18,7 @@ properties:
>        - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
>        - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
>        - amlogic,meson-s4-reset # Reset Controller on S4 and compatible SoCs
> +      - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
>  
>    reg:
>      maxItems: 1
> diff --git a/include/dt-bindings/reset/amlogic,c3-reset.h b/include/dt-bindings/reset/amlogic,c3-reset.h
> new file mode 100644
> index 000000000000..d9127863f603
> --- /dev/null
> +++ b/include/dt-bindings/reset/amlogic,c3-reset.h

Given that this is only included by
arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi, should this header be
moved to arch/arm64/boot/dts/amlogic ?

regards
Philipp
