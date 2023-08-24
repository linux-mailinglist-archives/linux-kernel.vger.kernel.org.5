Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3657876EB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 19:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbjHXRVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 13:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242878AbjHXRU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 13:20:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8202110D7;
        Thu, 24 Aug 2023 10:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1939D67439;
        Thu, 24 Aug 2023 17:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443E9C433C9;
        Thu, 24 Aug 2023 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692897656;
        bh=sExzA+ev19jx8Yh8PaMathy8y9f6OIK5w1nNHVQbmFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AafaxhcCblZ3clnb1PBmWA0uKBBoteyLZbLCfslw8RPL69r7co5T59kXxI5X0qymV
         0mIL4j46su5fd0/NDKGtp9u2MMQRs4Kv7o20HsCcAKb5RD3K4RVUSR5kWncDYzKmsg
         lWkH2F6Fnf17GWpF39ZjZokvEQIooQQOZwkGybMM0m0DScHfHfnT+3TsoS6erObRAj
         6qtzxb+jsQustVq+PKlEd6MQrUutrDndX0isGq46Maa2JrlOcQGZGiASfoxLgiUfQW
         tpeyI2DqbFYCTqPg7Zk6A//8tTlaWk6XW5hbetk8UCKp2Bt++p5Eu2Q1/cMFUkPNRU
         DUsNbbz91HWrg==
Received: (nullmailer pid 1066767 invoked by uid 1000);
        Thu, 24 Aug 2023 17:20:54 -0000
Date:   Thu, 24 Aug 2023 12:20:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: display: novatek,nt35950: define
 ports
Message-ID: <20230824172054.GA1065406-robh@kernel.org>
References: <20230823081500.84005-1-krzysztof.kozlowski@linaro.org>
 <20230823081500.84005-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823081500.84005-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 10:14:59AM +0200, Krzysztof Kozlowski wrote:
> The panel-common schema does not define what "ports" property is, so
> bring the definition by referencing the panel-common-dual.yaml. Panels
> can be single- or dual-link, thus require only one port@0.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. Use panel-common-dual
> 
> Changes since v1:
> 1. Rework to add ports to device schema, not to panel-common.
> ---
>  .../devicetree/bindings/display/panel/novatek,nt35950.yaml     | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
