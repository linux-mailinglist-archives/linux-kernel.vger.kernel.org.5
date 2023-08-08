Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568B677427F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjHHRqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjHHRpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:45:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E9125ED5;
        Tue,  8 Aug 2023 09:20:39 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKnQh6vVcz67tKy;
        Tue,  8 Aug 2023 17:07:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 10:11:44 +0100
Date:   Tue, 8 Aug 2023 10:11:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Holland <samuel@sholland.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Mattijs Korpershoek" <mkorpershoek@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Baolin Wang" <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH 1/2] devicetree: bindings: Add keypad driver
 ducumentation
Message-ID: <20230808101143.00007bb4@Huawei.com>
In-Reply-To: <20230808072252.3229-1-Wenhua.Lin@unisoc.com>
References: <20230808072252.3229-1-Wenhua.Lin@unisoc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 15:22:52 +0800
Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:

> Add keypad driver ducumentation.

documentation

Though naming convention for dt-bindings patches does not look like
this. Take a look at what has been accepted as bindings recently.
Also you aren't going to get much review of this without cc'ing the
dt list and maintainers.

> 
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  .../bindings/input/sprd-keypad.yaml           | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/sprd-keypad.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/sprd-keypad.yaml b/Documentation/devicetree/bindings/input/sprd-keypad.yaml
> new file mode 100644
> index 000000000000..51710e1eb389
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/sprd-keypad.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2023 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/sprd-keypad.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Device-Tree bindings for GPIO attached keys

Seems rather more specific than that!

> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +description: |
> +    Keypad controller is used to interface a SoC with a matrix-keypad device.
> +    The keypad controller supports multiple row and column lines.
> +    A key can be placed at each intersection of a unique row and a unique column.
> +    The keypad controller can sense a key-press and key-release and report the
> +    event using a interrupt to the cpu.

CPU

> +
> +properties:
> +    compatible:
> +    const: sprd,sc9860-keypad

Make sure you follow the guidance on test building your binding and example.
See Documentation/devicetree/bindings/writing-bindings.rst and submitting-patches.rst

This has a lot of issues covered by that document.

> +
> +    reg:
> +        maxItems: 1
> +
> +    interrupts:
> +        maxItems: 1
> +
> +    keypad,num-rows:
> +    description: Number of row lines connected to the keypad controller.
> +
> +    keypad,num-columns:
> +    description: Number of column lines connected to the keypad.
> +
> +    debounce-interval:
> +    description:
> +        Debouncing interval time in milliseconds. If not specified defaults to 5.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +    default: 5
> +
> +    linux,keymap:
> +    description: An array of packed 1-cell entries containing the equivalent
> +        of row, column and linux key-code. The 32-bit big endian cell is packed.
> +
> +required:
> +        - compatible
> +        - reg
> +        - keypad,num-rows
> +        - keypad,num-columns
> +        - linux,keymap
> +
> +unevaluatedProperties: false
> +
> +
> +examples:
> +  - |
> +	keypad@40250000 {
> +		compatible = "sprd,sc9860-keypad";
> +		reg = 	<0x40250000 0x1000>;
> +		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&aonapb_gate CLK_KPD_EB>,
> +			<&aonapb_gate CLK_KPD_RTC_EB>;
> +		clock-names = "enable", "rtc";
> +		keypad,num-rows= <3>;
> +		keypad,num-columns = <3>;
> +		debounce-interval = <5>;
> +		linux,keymap = < 0x00000001
> +				 0x01000002
> +				 0x00020003>;
> +		status = "okay";

Status shouldn't be in an example.  Formatting wrong.
IF your binding example doesn't build (this won't) then it won't be accepted
by the dt-binding maintainers and their review is needed for it to be
merged.  

Jonathan


> +	};
> +...

