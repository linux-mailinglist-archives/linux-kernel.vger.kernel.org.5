Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BE1773F26
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbjHHQns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjHHQm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:42:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3AC1657A;
        Tue,  8 Aug 2023 08:55:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF71262415;
        Tue,  8 Aug 2023 07:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497D9C433C7;
        Tue,  8 Aug 2023 07:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691480151;
        bh=ggJxxHrpO5MN3RQIEaFOMF+tpJRgPPk/jwHSNu2FkOA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CcRZf88ia64ohD7SbYh76bcOiLJpVBY+fAcN8ukqtuX6uiolV1mGeCNsiYOtRPtcJ
         +iWcOkn+K0g47lRrOS1cVV40+k9Oyi7Zafe0hF3w6wzHM6Hdw8o4eyhBUFd46zW2iE
         oCS51eoYIOJpJqnAedYI/7Dv9rsPycTKRGGM3fmDyawCeKjAPe591k0Ex2dBkwkE12
         ATybmCxHTUBKajxOvaHs7FnCQCWt9rnQjfj3nYbAkaSsl/J4mF45Zv5OWwwx15XY5w
         2a8Imgm8pbHwpTZCWQYWT6BCoMkDevW6NsQ6xsfrMC+mIWLt4Ex1G6JOPCK/DRWG8E
         mbPLImdCOrkqA==
Message-ID: <298675a5-7c42-fecb-f79d-652b4d485c4c@kernel.org>
Date:   Tue, 8 Aug 2023 09:35:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: add EMC181x
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Mathew McBride <matt@traverse.com.au>
References: <20230808013157.80913-1-mark.tomlinson@alliedtelesis.co.nz>
 <20230808013157.80913-2-mark.tomlinson@alliedtelesis.co.nz>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230808013157.80913-2-mark.tomlinson@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 03:31, Mark Tomlinson wrote:
> The EMC181x range are I2C temperature sensors with a varying number of
> sensors in each device. Each has one internal sensor, and one to four
> external sensor diodes.
> 
> The default range is from 0°C to +127°C, but can be extended to -64°C to
> +191°C.
> 
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by
automated tooling. Performing review on untested code might be a waste
of time, thus I will skip this patch entirely till you follow the
process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

Limited review follows:

> ---
>  .../bindings/hwmon/microchip,emc181x.yaml     | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc181x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc181x.yaml b/Documentation/devicetree/bindings/hwmon/microchip,emc181x.yaml
> new file mode 100644
> index 000000000000..5967f98ad7ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/microchip,emc181x.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +

Drop blank line.

> +$id: http://devicetree.org/schemas/hwmon/microchip,emc181x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip EMC1812/EMC1813/EMC1814/EMC1815/EMC1833 temperature sensors
> +
> +maintainers:
> +  - Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,emc1812
> +      - microchip,emc1813
> +      - microchip,emc1814
> +      - microchip,emc1815
> +      - microchip,emc1833
> +
> +  reg:
> +    maxItems: 1
> +
> +  emc181x,extended-range:

Incorrect vendor prefix.

> +    description: Allow for reading of extended temperature range (-64-192C)

And why would we disallow it otherwise?

Missing type... so this wasn't even tested.

> +
> +

Just one blank line.

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
> +        temperature-sensor@7c {
> +            compatible = "microchip,emc1812";
> +            reg = <0x7c>;

Include optional properties in the example as well.

Best regards,
Krzysztof

