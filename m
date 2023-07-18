Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F91758889
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjGRWdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjGRWde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:33:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1A7199A;
        Tue, 18 Jul 2023 15:33:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78EB36129A;
        Tue, 18 Jul 2023 22:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE48C433C7;
        Tue, 18 Jul 2023 22:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689719598;
        bh=6MTyHxtYHfxixee7H4APrS6m+5lNQnJTGfCeYq0C57M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2TcgOiLAT9i4N5/MyNynSBpIypudtWwZXSRLPmdqjIzzj1UEXGBqP7rtSB3CLkid
         2AC+4AJNSv2m7r/VcXveFj/x2pfYhaorP2ZsMW8JH/uS2TOY5J5cCpcirqp2R15L9X
         aQwOHqV1t81As+vVAK+iWJe290SUEtQKxk8+jZ+sIVNJgaAlS6/NIDVlTULR0Dl123
         1GaHZ67hNDbmMPhn7BKM/ubQdvvpGcli6L9bSXoYoWClvrzAktqNVpE20zj3nY3vaL
         E4exEKKuvHqP8mfudddWyqYAlKrZM0VlGL882hOLhV6GE1/HGZV7NF0XWSXDtiiETq
         /GYSjb/zsae6w==
Received: (nullmailer pid 2131885 invoked by uid 1000);
        Tue, 18 Jul 2023 22:33:16 -0000
Date:   Tue, 18 Jul 2023 16:33:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sandor Yu <Sandor.yu@nxp.com>
Cc:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        festevam@gmail.com, linux-imx@nxp.com, daniel@ffwll.ch,
        oliver.brown@nxp.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, airlied@gmail.com,
        andrzej.hajda@intel.com, Laurent.pinchart@ideasonboard.com,
        vkoul@kernel.org, neil.armstrong@linaro.org,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        alexander.stein@ew.tq-group.com, sam@ravnborg.org,
        linux-phy@lists.infradead.org, kernel@pengutronix.de,
        jonas@kwiboo.se, jernej.skrabec@gmail.com,
        dri-devel@lists.freedesktop.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v7 5/7] dt-bindings: phy: Add Freescale iMX8MQ DP and
 HDMI PHY
Message-ID: <168971959565.2131824.2007290149769233766.robh@kernel.org>
References: <cover.1689580812.git.Sandor.yu@nxp.com>
 <a782c749ecf8192a4f89ba270e30c7fb1d245c51.1689580812.git.Sandor.yu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a782c749ecf8192a4f89ba270e30c7fb1d245c51.1689580812.git.Sandor.yu@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Jul 2023 16:03:51 +0800, Sandor Yu wrote:
> Add bindings for Freescale iMX8MQ DP and HDMI PHY.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>  .../bindings/phy/fsl,imx8mq-dp-hdmi-phy.yaml  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mq-dp-hdmi-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

