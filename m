Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82EE7F8AA2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjKYMMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYMMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:12:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E4810C1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:12:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0756C433C7;
        Sat, 25 Nov 2023 12:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700914374;
        bh=HaPs6rO9d02viq7dWMbdaoM03RBF1QX65JlhKX2KKcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tjJVHMw53dN8MvofGbFCvqRLyBp8d4KD3v9p3MR2ir5f2sqPK/Yi2pCsrlUXUqEU1
         PZsoI54sw3oatvY01aMh71m2kgvNQ/tSD64kB3wt2ShKlQIaIrMzY3bFNnShrs5M1A
         br965+pL9uE44PkwUOr1gFvNbrHDJXR7lXdKAgK4+sZxZGZ4vBl48tPHGkL/JMzgmP
         rtom8SJ1Af1Cs9BedYeDJubTAB6jQFpp+HkKpEM479SNzc8JsMH2gr/dDCeAfECyMI
         ZyhsXzMePWmUzIipB7kJ23N5gbryxnE6h2VagHBIa0Ox5bNdowsWeUl1bMwmIoY51E
         JNf5JYCYE8N0w==
Date:   Sat, 25 Nov 2023 12:12:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: chemical: add aosong,ags02ma
Message-ID: <20231125121245.6664470d@jic23-huawei>
In-Reply-To: <20231125100139.193584-2-anshulusr@gmail.com>
References: <20231125100139.193584-1-anshulusr@gmail.com>
        <20231125100139.193584-2-anshulusr@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 15:31:37 +0530
Anshul Dalal <anshulusr@gmail.com> wrote:

> Add bindings for Aosong AGS02MA TVOC sensor.
> 
> The sensor communicates over i2c with the default address 0x1a.
> TVOC values can be read in the units of ppb and ug/m^3 at register 0x00.
> 
> Datasheet:
>   https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
> Product-Page:
>   http://www.aosong.com/m/en/products-33.html
> 
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> ---
> 
> Changes for v4:
> - Changed node name from 'light-sensor' to 'voc-sensor'
> 
> v3: https://lore.kernel.org/lkml/20231121095800.2180870-2-anshulusr@gmail.com/
> 
> Changes for v3:
> - Fixed commit message
> - Removed "asair,ags02ma" compatible
> 
> v2: https://lore.kernel.org/lkml/20231115125810.1394854-2-anshulusr@gmail.com/
> 
> Changes for v2:
> - Removed device from trivial-devices
> - Added standalone binding with vdd-supply property
> 
> v1: https://lore.kernel.org/lkml/20231107173100.62715-2-anshulusr@gmail.com/
> ---
>  .../bindings/iio/chemical/aosong,ags02ma.yaml | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
> new file mode 100644
> index 000000000000..c176a6e102ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/aosong,ags02ma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aosong AGS02MA VOC Sensor
> +
> +description: |
> +  AGS02MA is an TVOC (Total Volatile Organic Compounds) i2c sensor with default
> +  address of 0x1a.
> +
> +  Datasheet:
> +    https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
> +
> +maintainers:
> +  - Anshul Dalal <anshulusr@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aosong,ags02ma
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true

Similar to other review (I put more background there)
Convention these days at least is to always require powersupplies
that the device cannot work with out (even if you can use a fixed
supply and rely on the regulator framework papering over that).
We want to distinguish generally optional supplies from ones we might
not specify in a given DT.

Jonathan

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        voc-sensor@1a {
> +            compatible = "aosong,ags02ma";
> +            reg = <0x1a>;
> +            vdd-supply = <&vdd_regulator>;
> +        };
> +    };

