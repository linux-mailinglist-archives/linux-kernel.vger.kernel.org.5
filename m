Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075B07AC9BE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjIXNiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjIXNhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:37:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215DD13A;
        Sun, 24 Sep 2023 06:37:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A859C433C8;
        Sun, 24 Sep 2023 13:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695562636;
        bh=TVJdevvARUIrBLpf5akeM/JIJrKVvaPxAtgWXGhCwPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d970cuka0WGtZyztHBndGHiWYWY9DGZCG0Eoa7LwatPU+j1NNisFBD+JLwt2ndy05
         JoKv1W1xsxhCUI79dbXUrXD7sWMfnrkvfC/Y4AdPtzBrvl+Dz0Myb+vx4tBsxoSRlJ
         IaFp1BStHgk34+Hb0B9rUQaf5cx/lxJy1jyikxcUHf6NqS3dXpGniAg9bNWmBPjN/A
         8xnNipC5xq5/urQJoTcpjK8kG5oACN6A7q59f75I64XuawB2Xi0JDGoOhckTN4es/9
         Jm87iR1a1SbO+cx/5eTMWaggvZdEF0haRcySAuqIXjmRY1aUj+yGHgPFNKg8pIiBHI
         CBg3sV355PopA==
Date:   Sun, 24 Sep 2023 14:37:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] dt-bindings: iio: imu: Add DT binding doc for BMI323
Message-ID: <20230924143710.7c6edc4a@jic23-huawei>
In-Reply-To: <20230918080314.11959-2-jagathjog1996@gmail.com>
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
        <20230918080314.11959-2-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2023 13:33:13 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Add devicetree description document for Bosch BMI323, a 6-Axis IMU.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  .../bindings/iio/imu/bosch,bmi323.yaml        | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
> new file mode 100644
> index 000000000000..9c08988103c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/bosch,bmi323.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch BMI323 6-Axis IMU
> +
> +maintainers:
> +  - Jagath Jog J <jagathjog1996@gmail.com>
> +
> +description:
> +  BMI323 is a 6-axis inertial measurement unit that supports acceleration and
> +  gyroscopic measurements with hardware fifo buffering. Sensor also provides
> +  events information such as motion, steps, orientation, single and double
> +  tap detection.
> +
> +properties:
> +  compatible:
> +    const: bosch,bmi323
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    enum:
> +      - INT1
> +      - INT2
> +    description: |
> +      set to "INT1" if INT1 pin should be used as interrupt input, set
> +      to "INT2" if INT2 pin should be used instead

Why not both?  Sure driver might elect to use only one, but the binding
describes the hardware not the driver and both might be wired.

Lots of different sources of interrupts so might be advantageous
to split them up across two wires.   A simple case being to route
errors to one and everything 'good' to the other.  No obligation to
support that in the Linux driver though if you don't need to.

> +
> +  drive-open-drain:
> +    description: |
> +      set if the specified interrupt pin should be configured as
> +      open drain. If not set, defaults to push-pull.

Two pins.  Might be different so you need two controls.

> +
> +required:
> +  - compatible
> +  - reg

As mentioned, need power supplies specified and marked as required
(though they may be provided via always on regulators and rely on stubs
being created by the regulator subsystem on a given board).
Looks like there are at least 2 supplies.

> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    // Example for I2C
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        bmi323@68 {
> +            compatible = "bosch,bmi323";
> +            reg = <0x68>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <29 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names = "INT1";
> +        };
> +    };
> +  - |
> +    // Example for SPI
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        bmi323@0 {
> +            compatible = "bosch,bmi323";
> +            reg = <0>;
> +            spi-max-frequency = <10000000>;
> +            interrupt-parent = <&gpio2>;
> +            interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names = "INT2";
> +        };
> +    };

