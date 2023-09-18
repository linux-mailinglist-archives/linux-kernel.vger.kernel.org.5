Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CBA7A54E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjIRVOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjIRVO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:14:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADFD12E;
        Mon, 18 Sep 2023 14:14:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19CCC433C7;
        Mon, 18 Sep 2023 21:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695071658;
        bh=je+/dWfPoKyK7E4zFPFa+MHVux9u0JB/uftENHOI2A8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0LwmKoL/ErpTiRdXxKgdyU3004uknQdjkpAOb9y7Bo3tS7EcbETzF4r/3cpLTAzC
         SPNZOuNDU2pdjWgPHGcq1Ns565DNcUPDOu3HQydPTIdFv7DOn3Pi2xSFJG6IJpTKhz
         +lQ1k/KVR5/BfZy3JJSn9RTY0u4PW8CKz+braPQ24VJACNlj0ajgZ3INOTAv1m3ofW
         F2J5yS3pgpMCHpEGJDjdtzLByLGkvMvbBNjVAYk7LL2E6rV8PIZzawh+/Frzwyvl0t
         YAHz+DqSUhyp2HxhsJ53YTQi9ahg9vxPCpGI5KUVJlcEiGCeIEXfEVQY4b7hiC01Wh
         7QGbgf9FfKcPQ==
Received: (nullmailer pid 1771107 invoked by uid 1000);
        Mon, 18 Sep 2023 21:14:16 -0000
Date:   Mon, 18 Sep 2023 16:14:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: adc: provide max34408/9 device tree
 binding document
Message-ID: <20230918211416.GA1768763-robh@kernel.org>
References: <20230917211143.7094-1-fr0st61te@gmail.com>
 <20230917211143.7094-2-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917211143.7094-2-fr0st61te@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 12:11:42AM +0300, Ivan Mikhaylov wrote:
> The i2c driver with Rsense option for current monitoring.

driver? This is a binding for a hardware device.

> 
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> ---
>  .../bindings/iio/adc/maxim,max34408.yaml      | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> new file mode 100644
> index 000000000000..ae7c6ddb13d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Two- and four-channel current monitors with overcurrent control.

Drop the period.

With those fixes:

Reviewed-by: Rob Herring <robh@kernel.org>
