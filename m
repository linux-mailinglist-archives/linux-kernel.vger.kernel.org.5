Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBE3784DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 02:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjHWAPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 20:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjHWAPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 20:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A9DCF9;
        Tue, 22 Aug 2023 17:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99CB860FA9;
        Wed, 23 Aug 2023 00:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5563EC433C7;
        Wed, 23 Aug 2023 00:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692749726;
        bh=m3QxC+UW70yVwLmza6iDNCXkPCmq/liyu1hcsOb0IsE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hwz9Nl+1z+jtRA2DpiRq32cQoFsmVxS4DEL/2vTmJgHTaQ7TgL/1LcgbHEPoBzUz6
         YElDzl8+4g3C2NGEhHkRnIUTbvEq9ih4wJ5mbBnntSKiLoS4ab14VsZhHA8WIVKpnS
         cGY0mQUFGIpf4U1b7azz363yW3q5Y+Tw5Kal+A4Ez7orTCicEBTnx1fFEpSFHN+K/X
         8hvQwpLwoRSJcOilFv1tTQg4H1Yr7O2O8O/k5cNNEMdv55EJpgre0FYex2oL21JOY+
         IdGRw+TLiqt/YWiCPwmS9bXG+RMRAENYE302bXWOlgU2DWv302qTcNdqbvZs5/9X8v
         cjc2gqirf/nuQ==
Date:   Tue, 22 Aug 2023 17:15:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v5 1/2] dt-bindings: net: snps,dwmac: Tx queues
 with coe
Message-ID: <20230822171525.692bd2df@kernel.org>
In-Reply-To: <20230819023132.23082-2-rohan.g.thomas@intel.com>
References: <20230819023132.23082-1-rohan.g.thomas@intel.com>
        <20230819023132.23082-2-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2023 10:31:31 +0800 Rohan G Thomas wrote:
> +      snps,tx-queues-with-coe:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: number of TX queues that support TX checksum offloading

Is it going to be obvious that if not present all queues support
checksum offload? I think we should document the default.
-- 
pw-bot: cr
