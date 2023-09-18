Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83BA7A4993
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbjIRM0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241982AbjIRM0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:26:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A506711F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:25:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-530ab2d9e89so2936491a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695039952; x=1695644752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nh7sVBi8Tr0GCkJ5LEg4c3aaDQBLO8oy7P4IhXqjoh0=;
        b=tgWQe8tMVLxLX0migf21dRYpneXO5RhjgI2Z64g+PCM+TsjPsAMD92Xf5cKADSGKBW
         kipqwJSQAqwZ4dONxqPn7cEz7meAgsNwXB/9rIfPrxuxNCpcqQsGF3jaqx4zkzJ555so
         6Zi1r474jA45Bu7qrjJyjA9JvCJEu1bVSby4ikExPPYmenY+xqj5M/Z2eYMRa38ZOML1
         j7tikX1QCSwyEj8qri0cqxkiyOPRbYuwafYvNqTKt9n/0Ba3yPtxR7imNSGcQQCNyapM
         zNZ9JEjVbbjFh2g0UDWRXHFvPTpTeYV58TPSVqB8xypwaF1uTRePp9X8E/eVKz1L3sZc
         V5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695039952; x=1695644752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nh7sVBi8Tr0GCkJ5LEg4c3aaDQBLO8oy7P4IhXqjoh0=;
        b=rW7U/7gTaFO7mUDZiAB9IFY+n3ELT6nND5tXz/CpkEgXNByXe6LqmkCSS6R9e/hiKb
         l+I8XoIfw6Zu80WoAiq0Vw0IdeDtvTc4Zt3NOg+siw89O3XoVyUFumSlb3ma+5oKHLFh
         NZtygbTO+Y1H5rmcQMPR5/4Vcsq90tK/jOzSLqLCd1gYXZ465OAY4hN/c5n7DH3YgytF
         uWMrNh2i3a4ekGg/wZBjNxmVRapCe7sgociagCcLr7asLMZWEx9rqBmD10QjrZ3Fio/A
         /QSRciQmoVsHYxAY1373XDJl7ghkMFaMGU18G0ijbWNWnC9ObCTDzOTgbwFdWUd7Gphc
         9DCA==
X-Gm-Message-State: AOJu0Yw5jkORzT+oa8Y+Z9r81EDiozv4l2HmhSHkGrsY19IohwMpPeZw
        Osi1vgNS+BoskyB4+eWQod+oGg==
X-Google-Smtp-Source: AGHT+IFUsmBxk+UST91vkvG7DlspBA0d9tLOkRo5UFxKQJHZ0oiyt0tGaJ1O4VjssoKueW88iRybFw==
X-Received: by 2002:a50:9358:0:b0:530:db1d:bd99 with SMTP id n24-20020a509358000000b00530db1dbd99mr4044416eda.13.1695039951975;
        Mon, 18 Sep 2023 05:25:51 -0700 (PDT)
Received: from [172.25.80.114] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id s25-20020aa7cb19000000b0052333e5237esm5993474edt.88.2023.09.18.05.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:25:51 -0700 (PDT)
Message-ID: <b27b58d9-9e55-b803-dd61-dd86a78e7c5c@linaro.org>
Date:   Mon, 18 Sep 2023 14:25:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC 1/2] dt-bindings: iio: imu: Add DT binding doc for BMI323
Content-Language: en-US
To:     Jagath Jog J <jagathjog1996@gmail.com>, jic23@kernel.org,
        andriy.shevchenko@linux.intel.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-2-jagathjog1996@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230918080314.11959-2-jagathjog1996@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 10:03, Jagath Jog J wrote:
> Add devicetree description document for Bosch BMI323, a 6-Axis IMU.

I don't know why this is RFC and cover letter does not explain it. Shall
I just ignore it? Patch is no ready? Recently at least two times someone
was disappointed that his code marked as RFC received my review.

A nit, subject: drop second/last, redundant "DT binding doc for". The
"dt-bindings" prefix is already stating that these are bindings. Four
words entirely redundant and duplicating what prefix is saying...


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

Do not need '|' unless you need to preserve formatting.

> +      set to "INT1" if INT1 pin should be used as interrupt input, set
> +      to "INT2" if INT2 pin should be used instead

And what happens with other INT pin? Remains floating?

> +
> +  drive-open-drain:
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      set if the specified interrupt pin should be configured as
> +      open drain. If not set, defaults to push-pull.

Missing supplies. Are you sure device does not use any electric energy?

> +
> +required:
> +  - compatible
> +  - reg
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
> +> +        bmi323@68 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

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


It's the same as other example. No difference. Drop.

Best regards,
Krzysztof

