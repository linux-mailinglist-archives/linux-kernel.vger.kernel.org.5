Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF75D7B4250
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbjI3Qq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbjI3Qq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:46:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7FFAB;
        Sat, 30 Sep 2023 09:46:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BC1C433C8;
        Sat, 30 Sep 2023 16:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696092386;
        bh=+l7w1us2k4b4fXC2GPQ+SDUJDkw/7AzjXhg4En0HmSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jEBB5dF6oBg1pw0t9b+SY8o2St/7j9GQI193IbUhLtVS4Mtwqb5Ov1rxCwkGHf3ha
         vKqbd1gyfLxKFZy9M6Ldoefw9zTlJ8ZwNNe3ggbDgLov9HZ1HRDkU/io/R73s1hx7W
         7eNnaGsBDtFvTzO2474mBNeJ6Pv4+dFvKaPygBaTWj/Ums35EUYWSfBiNQiJLVK55c
         RsWVRuh782Gb6HlZSc6V8uuDaakr2Y4i53wvEGpZjHcXXIjJiq88nd5y9/cy3rfpwc
         Z08M2GsesLIPYhgagao/eTV8HAqiUxD2fxa5D+Br4KCB+I+kyPkIo+NQpmG+7+ysmk
         h1AzHq02iZyFA==
Date:   Sat, 30 Sep 2023 17:46:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: adi,ad7292: Fix
 additionalProperties on channel nodes
Message-ID: <20230930174626.2346dd36@jic23-huawei>
In-Reply-To: <20230926164357.100325-1-robh@kernel.org>
References: <20230926164357.100325-1-robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 11:43:50 -0500
Rob Herring <robh@kernel.org> wrote:

> "additionalProperties: true" is only for incomplete schemas such as bus
> child nodes in a bus's schema. That doesn't apply to the "channel" nodes
> in the adi,ad7292 binding, so fix additionalProperties to be false.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
Oops.

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> index 7cc4ddc4e9b7..2aa1f4b063eb 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> @@ -61,7 +61,7 @@ patternProperties:
>      required:
>        - reg
>  
> -    additionalProperties: true
> +    additionalProperties: false
>  
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#

