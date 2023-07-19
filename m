Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9AE75A13E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGSWDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjGSWDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:03:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276D11FED;
        Wed, 19 Jul 2023 15:03:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B539261840;
        Wed, 19 Jul 2023 22:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E64C433C7;
        Wed, 19 Jul 2023 22:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689804188;
        bh=KOgi8CERrMjLLXKLLThWHTz3IzE2ZDRnAYr0l6w1cV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5uU/zL7eSWJFP59qyxLOGErAG6fABHjC27seiVbBucmowy96x29ttLvQ1Aq9/lMO
         7eowFv+vX4unF90J6kXi7m31vtp0gnCJcr8t8JZ9JFl3yR6ycpoyA8xu/ySVOiIwl1
         susjhI5r3G5uDTqb5+9zSfjld1V3S9Sp8d6zUbBtUTAcbUHz/PLY4FCZuYsadZmToc
         rcJ/v+pGTkH0251T8w0CyPl87uqZESdVhpYR4Q0rtE5NL2bPiSh9T9/K2VDOSRsF3w
         iwZfDA0Z3psDRoPNcMIt6yC/GO9x136HMBIt+8I9YyHmW034+E3/DtdTR5vG/Jl4jg
         MM4MVLjZqFyFQ==
Received: (nullmailer pid 859465 invoked by uid 1000);
        Wed, 19 Jul 2023 22:03:06 -0000
Date:   Wed, 19 Jul 2023 16:03:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     zelong dong <zelong.dong@amlogic.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kelvin.zhang@amlogic.com, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: reset: Add compatible and DT
 bindings for Meson-C3 Reset Controller
Message-ID: <168980418539.859406.10286895243062279504.robh@kernel.org>
References: <20230718123550.13712-1-zelong.dong@amlogic.com>
 <20230718123550.13712-2-zelong.dong@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718123550.13712-2-zelong.dong@amlogic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Jul 2023 20:35:48 +0800, zelong dong wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
> 
> Add new compatible and DT bindings for Amlogic's Meson-C3 Reset Controller
> 
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> ---
>  .../bindings/reset/amlogic,meson-reset.yaml   |   1 +
>  .../reset/amlogic,meson-c3-reset.h            | 119 ++++++++++++++++++
>  2 files changed, 120 insertions(+)
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-c3-reset.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

