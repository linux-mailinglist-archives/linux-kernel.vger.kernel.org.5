Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15EB7B24E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjI1SJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjI1SJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:09:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057DE1B0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:09:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E394C433C8;
        Thu, 28 Sep 2023 18:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695924584;
        bh=PKCbG067dxLVfSBXY7LXY3siozP1w/bW3Ik0lSAKcHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPu1YZ2rL4UkOp0m0H3259f38mALHnc/dHdick1bsXfEFyYEyr9ofNxJwmYjIqw5b
         5zF8jQXPIzSfeVbQohQ3A5hP/aUUlDh7ynUvUG9IibFtXbpv2DJQfVuEZH5ZzFXBoD
         UtZjKagtK8OBfkXuzFk67WStkB+7TA9hCWe3PXxelAuq4vPNrxocFPp5FCex8XLwzG
         hy/mLT4HJAO4svKaX+tEWH7Yi74Jntotmp7eDyF8JhSnZrtf3cy+cq6zX6mDWJ7kOT
         ov6rWiYq45CpS4+6RhqtEo2ciXYC+uNdGcuVMTYBcUyt9oMc0CbkY8VTE1wIv7Qbjz
         BsB8S+j7TSJKA==
Received: (nullmailer pid 996093 invoked by uid 1000);
        Thu, 28 Sep 2023 18:09:42 -0000
Date:   Thu, 28 Sep 2023 13:09:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: Time Based
 Scheduling
Message-ID: <20230928180942.GA932326-robh@kernel.org>
References: <20230927130919.25683-1-rohan.g.thomas@intel.com>
 <20230927130919.25683-2-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927130919.25683-2-rohan.g.thomas@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 09:09:18PM +0800, Rohan G Thomas wrote:
> Add new property tbs-enabled to enable Time Based Scheduling(TBS)

That's not the property you added.

> support per Tx queues. TBS feature can be enabled later using ETF
> qdisc but for only those queues that have TBS support enabled.

This property defines capable or enabled? 

Seems like OS configuration and policy.

Doesn't eh DWMAC have capability registers for supported features? Or 
did they forget per queue capabilities?

> 
> Commit 7eadf57290ec ("net: stmmac: pci: Enable TBS on GMAC5 IPK PCI
> entry") enables similar support from the stmmac pci driver.

Why does unconditionally enabling TBS work there, but not here?

> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 5c2769dc689a..db1eb0997602 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -399,6 +399,14 @@ properties:
>              type: boolean
>              description: TX checksum offload is unsupported by the TX queue.
>  
> +          snps,tbs-enabled:
> +            type: boolean
> +            description:
> +              Enable Time Based Scheduling(TBS) support for the TX queue. TSO and
> +              TBS cannot be supported by a queue at the same time. If TSO support
> +              is enabled, then default TX queue 0 for TSO and in that case don't
> +              enable TX queue 0 for TBS.
> +
>          allOf:
>            - if:
>                required:
> -- 
> 2.26.2
> 
