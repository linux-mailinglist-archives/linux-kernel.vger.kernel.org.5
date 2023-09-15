Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075D87A22B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbjIOPnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjIOPnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:43:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0E2268A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:43:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620ADC433C7;
        Fri, 15 Sep 2023 15:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694792581;
        bh=9bRj4OGDHZcWypcbZ6nrLnPTFGOMENS0AvkmhkVoxF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4HmihmqyVuBI7ExjAGaEePXqlsxLyl0pyr7CY7q1/UigsvPNGqVIo4QlDeC3yvUX
         X/JN5TCdKnWoL1hVVy4NouqrfLZ7SDilBmkCRGokIfc2ZdpWb8V0DsEd2U6nzCVF4V
         /4NuE6QAjTGkDA99f1ZCYP+yVFCKRI34ceDSluxCSV7+rkVTBQl2TQjc55U+9wiowC
         2zHHTM/arQemdTlgHn7QqEVzOKXlsSX0W2W20JTfNnbfKfBknsuXKMFDGqGkT8GUXF
         AxzoGkYisQPGKRABk5LuQBUb5lWl00q1NA23Wzmmu6sylV/riYdgBaiNZMZgsqNvva
         K9izqTNKNkIIQ==
Received: (nullmailer pid 3773371 invoked by uid 1000);
        Fri, 15 Sep 2023 15:42:58 -0000
Date:   Fri, 15 Sep 2023 10:42:58 -0500
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
        fancer.lancer@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/2] dt-bindings: net: snps,dwmac: Tx coe
 unsupported
Message-ID: <20230915154258.GA3769303-robh@kernel.org>
References: <20230915095417.1949-1-rohan.g.thomas@intel.com>
 <20230915095417.1949-2-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915095417.1949-2-rohan.g.thomas@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 05:54:16PM +0800, Rohan G Thomas wrote:
> Add dt-bindings for coe-unsupported property per tx queue.

Why? (What every commit msg should answer)

> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc2..365e6cb73484 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -394,6 +394,9 @@ properties:
>                When a PFC frame is received with priorities matching the bitmask,
>                the queue is blocked from transmitting for the pause time specified
>                in the PFC frame.

blank line needed

> +          snps,coe-unsupported:
> +            type: boolean
> +            description: TX checksum offload is unsupported by the TX queue.

And here.

>          allOf:
>            - if:
>                required:
> -- 
> 2.25.1
> 
