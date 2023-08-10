Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3427782A2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjHJVTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHJVTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFE32D40;
        Thu, 10 Aug 2023 14:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8954C65FDE;
        Thu, 10 Aug 2023 21:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E412CC433C7;
        Thu, 10 Aug 2023 21:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691702383;
        bh=4kGVfgLy4tWMQ3Bm3kTeHSuZdGBBUrsV8AAjFrGH5/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qr/ga7T4dkt08vmjv9uk+R3afcK8sHFsNzTqjq0/LgXfDeC7S1CnrOViWLUtPX//r
         r5p/svzqpLj8E5BooNFvaDbgd2wwfgvHlVfK2aiTkNB/rPw3+X6UPcTmsXX9nSX8nM
         s7FDYVm6VdZVltTX0HlZWGtFk8nnwzlpTbKpegVRcEtTOj9rtWJ9c8LyaktNpuu2Vt
         LmwpYld9JNG/meKH4RyvO3R+90KtCLG5O0moadhgEsI3MaMzTnHj2rcft5z0eP6/4v
         SWjksQB6OMdAQuN3VA0hLm0ap1VOCb8pXnED+gCzlxJDZF7UA3cNR/elVJ++VEFKVD
         lM6WGvV0gMVBw==
Received: (nullmailer pid 1207316 invoked by uid 1000);
        Thu, 10 Aug 2023 21:19:40 -0000
Date:   Thu, 10 Aug 2023 15:19:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        David Airlie <airlied@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: display: panel: Add panels based on
 ILITEK ILI9806E
Message-ID: <169170238026.1207230.3686279612864971969.robh@kernel.org>
References: <20230810144116.855951-1-luca.ceresoli@bootlin.com>
 <20230810144116.855951-2-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810144116.855951-2-luca.ceresoli@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 16:41:15 +0200, Luca Ceresoli wrote:
> Add bindings for LCD panels based on the ILITEK ILI9806E RGB controller
> connected over SPI and the "ShenZhen New Display Co NDS040480800-V3"
> 480x800 panel based on it.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changes in v2:
>  - remove T: line form MAINTAINERS entry
>  - reference spi-peripheral-props.yaml
>  - add 'maxItems: 1' to reg
>  - use unevaluatedProperties
>  - remove out of scope backlight node
> ---
>  .../display/panel/ilitek,ili9806e.yaml        | 63 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

