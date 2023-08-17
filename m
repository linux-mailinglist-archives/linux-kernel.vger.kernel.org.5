Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2695577FD77
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354212AbjHQSDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354259AbjHQSCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:02:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8728D3592;
        Thu, 17 Aug 2023 11:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 179CD65601;
        Thu, 17 Aug 2023 18:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE3AC433C8;
        Thu, 17 Aug 2023 18:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692295366;
        bh=DtO22LLw6nxuLzrFYnPX0EK5d0+xOc6W1qNnbGMl+L0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPSoMlrm+9w9fRZDshdjk35UzqU364iII8J8yDGRUFIq9Y62FPIowhK48SZ68G6Yl
         zJdD/mX5J3g5x8AbzlZ9GZioP9Ml+6elexPfZk6odFX4lEM+IVgraWfWt/qwQx3Sq6
         t+v/3eIcTbZc48Qtwgi8+EWwZzPyPsO7bHsglmdH41GGFlmhTKp+wUjGHTnaZl+Igk
         kiAdpIpPi8yADyrGgC5ChLOi/LGDwaN2/MTDz9XxaER6Fgt+nrOES070AR6/OpRlte
         1OmH2R19HRe+DIxJlaeWPVXvA2AwsazIub9Nf85i3gK8J0yU3cZVeaDP4hu1FKAkZX
         Omt5Cq1rv6fYA==
Received: (nullmailer pid 1880406 invoked by uid 1000);
        Thu, 17 Aug 2023 18:02:43 -0000
Date:   Thu, 17 Aug 2023 13:02:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jringle@gridpoint.com, devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Lech Perczak <lech.perczak@camlingroup.com>,
        linux-kernel@vger.kernel.org, tomasz.mon@camlingroup.com,
        l.perczak@camlintechnologies.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-gpio@vger.kernel.org, jirislaby@kernel.org,
        stable@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH v10 3/6] dt-bindings: sc16is7xx: Add property to change
 GPIO function
Message-ID: <169229536296.1880302.10602217647307724813.robh@kernel.org>
References: <20230807214556.540627-1-hugo@hugovil.com>
 <20230807214556.540627-4-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807214556.540627-4-hugo@hugovil.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 07 Aug 2023 17:45:53 -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Some variants in this series of UART controllers have GPIO pins that
> are shared between GPIO and modem control lines.
> 
> The pin mux mode (GPIO or modem control lines) can be set for each
> ports (channels) supported by the variant.
> 
> This adds a property to the device tree to set the GPIO pin mux to
> modem control lines on selected ports if needed.
> 
> Cc: <stable@vger.kernel.org> # 6.1.x
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> ---
>  .../bindings/serial/nxp,sc16is7xx.txt         | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

