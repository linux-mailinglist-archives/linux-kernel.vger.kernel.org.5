Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930CF7ADCFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjIYQZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYQZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:25:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046DDBE;
        Mon, 25 Sep 2023 09:25:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0251C433C8;
        Mon, 25 Sep 2023 16:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695659111;
        bh=k44ZVpNI7Cq7j38SfPe5poWW99evd2e78ncnRvDGIGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCG1NXeKouPC7336hAAj5rxp1TD7jepacPz8lMaAcry8WDFMqziGPKh/bUQ28hBp6
         qNOCEHGkT3HPYNlYR3gTKZeUFUWSUZfxxCgJArLTWYaFhyUh5/RuggBQtmN3MlJ/eO
         DboMVh5/khCO0nd2dkpHvW3m1Uf71ZhJcK6S9TEqSZaiXjPnsZgs+1yRTKaitbT5R/
         EH4OZOdE8YPGlR67hxEJRkk5Ka+iECOOncmTo3OG4m9WPPgMFPJvMUUlUgKwPvom7A
         v845EvVBo4i2h3lPEBvJiCO1bAxGXY54U1cfP3HhbwuXmZ8FMC9xAq1rdzlltRkRuf
         7uEpdd45B9eDQ==
Received: (nullmailer pid 1468913 invoked by uid 1000);
        Mon, 25 Sep 2023 16:25:09 -0000
Date:   Mon, 25 Sep 2023 11:25:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jeff LaBundy <jeff@labundy.com>, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: input: touchscreen: goodix: clarify
 irq-gpios misleading text
Message-ID: <169565910910.1468857.379234431707593994.robh@kernel.org>
References: <20230925032208.11698-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925032208.11698-1-luca.ceresoli@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Sep 2023 05:22:08 +0200, Luca Ceresoli wrote:
> The irq-gpios description misleading, apparently saying that driving the
> IRQ GPIO resets the device, which is even more puzzling as there is a reset
> GPIO as well.
> 
> In reality the IRQ pin can be driven during the reset sequence to configure
> the client address, as it becomes clear after checking both the datasheet
> and the driver code. Improve the text to clarify that.
> 
> Also rephrase to remove reference to the driver, which is not appropriate
> in the bindings.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changed in v2:
>  - reworded to clarify even further
> ---
>  .../devicetree/bindings/input/touchscreen/goodix.yaml        | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

