Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ACC767650
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjG1T2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjG1T23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:28:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A72C268B;
        Fri, 28 Jul 2023 12:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C08C0621E1;
        Fri, 28 Jul 2023 19:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C954C433C7;
        Fri, 28 Jul 2023 19:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690572508;
        bh=tkxqkheUYV+9BQzGj3DyNe/PKGjQVH/d429jWysjUCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZWjdbViMNiV6YzFIlwDasV2ge2qYM+qQj62KAmzx3qY7wbPsT4WEGRbBASsxrTFN
         BINFjYdnnYEtvcr/9N6ArrwL2yyJIbh+qhQpxlA+/p2NNmfkCaxWMFa1JsX7t2quQL
         k2ItsPtMHjFfRRCs7dyb0ZFJDeij69Zu6zm4n/JXmYx+9lroBxY/2MOIGBBVJa5ELN
         DNuIIRxRkxJfCwt8qdm+j86T+JFZOvukM/1/TOffIGPZXwDVlGG956jzyHGKxBso2+
         tG4LLAPGWFZ6efLogbhCCtqJxJzC/0/r2MllzldvUSRWEMM5VQeE0cSgOoWYnVDpsd
         Dyq/u3HcYA9QQ==
Received: (nullmailer pid 1175706 invoked by uid 1000);
        Fri, 28 Jul 2023 19:28:24 -0000
Date:   Fri, 28 Jul 2023 13:28:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Kubiak <michal.kubiak@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: can: tcan4x5x: Add tcan4552 and
 tcan4553 variants
Message-ID: <169057250459.1175653.8334487301732394212.robh@kernel.org>
References: <20230728141923.162477-1-msp@baylibre.com>
 <20230728141923.162477-2-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728141923.162477-2-msp@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Jul 2023 16:19:18 +0200, Markus Schneider-Pargmann wrote:
> These two new chips do not have state or wake pins.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/net/can/tcan4x5x.txt          | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

