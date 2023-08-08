Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D33773B28
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjHHPos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjHHPnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:43:21 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB0D273F;
        Mon,  7 Aug 2023 20:54:12 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-564b326185bso2354492a12.2;
        Mon, 07 Aug 2023 20:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691466852; x=1692071652;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wSsR6neICq2IPDxtf2SFrKDfgJjY79Gnl+/HMGkjnHw=;
        b=DNeBHpVZnHVbdzo0q9/FilvKcCIVYNDb4r4r5ijxJoo7gMtyLo1+iEqGhJgIKCHo8G
         8Bf4wJjBGHfagGcCo2Zk7PTcZ4uGiZt5n4/d7I9vIgwQRWO/I3FjixYVN5w/muo4FnUE
         omIX0hILceBlgD6xWhaNOAbSSL16ersSHve3OUoWhUHBxA1a02WcArvQxF1/yeZgeSk1
         I7n1dqFyNp08Azls76QDqQ0e8CA1h3aT/OW+9b2vn6FprOpb4TBSTX66S7ZXYFbsWH4F
         SvHq58xsihwxjEe4zA3+OAr9+UWl2GvY0aZ4tg7O33NKAsud+QTKcFOcr9O5S3czDknd
         0lZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691466852; x=1692071652;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSsR6neICq2IPDxtf2SFrKDfgJjY79Gnl+/HMGkjnHw=;
        b=g7iwIpF3BIhkhsSzggzQxUm6+2qW20uRsnIT2Db8McLEt+PSb4apZ/0IerQVyj4vdi
         w+nQPgMdAb04nDOH5MSNeQsKhzbqwQfgC7ivU6uCFd8J1gqw3jbHIHuwuWrQK24SNJHw
         NP6dSYeObwtV4r/bD9B46KI9PGnyDaTAWp4A3FNTHr3DPR6C25qNRLSsGgbF13jFp3KZ
         SnvD4mTkMtHPTMad5oUnaQ0EJ5ktS1vMFzjZn7wbxf0n5/ww03hvVqdXGNAZwMM8Dq3w
         tsPMQvrQdCTO6AGiSVMSrewZX9MWOPcZ5NsY/6et9IXh6ViCHuZwiVl4LDyJj8yhUHqe
         znIA==
X-Gm-Message-State: AOJu0YyNdFa8TTFafGLKv32DXkZLWZ1+XsPQIU6kWn52NaxFgcz/HF+l
        6k/64GT8BAn8Hae4oUrVAtwwqZ2/I9w=
X-Google-Smtp-Source: AGHT+IEBNx4cJkpnnEBaf0JG55S5daRW4F+43BHqH2kCyjpXkA4rAmfLKiySxmR3tcBK4fjtNC0h0A==
X-Received: by 2002:a05:6a20:13cd:b0:137:47d0:b76b with SMTP id ho13-20020a056a2013cd00b0013747d0b76bmr9210032pzc.26.1691466852245;
        Mon, 07 Aug 2023 20:54:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c24600b001b9df74bac6sm7696605plg.260.2023.08.07.20.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 20:54:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <42021fd9-484a-e761-6da8-f972cb562917@roeck-us.net>
Date:   Mon, 7 Aug 2023 20:54:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Mathew McBride <matt@traverse.com.au>
References: <20230808013157.80913-1-mark.tomlinson@alliedtelesis.co.nz>
 <20230808013157.80913-2-mark.tomlinson@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: add EMC181x
In-Reply-To: <20230808013157.80913-2-mark.tomlinson@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/23 18:31, Mark Tomlinson wrote:
> The EMC181x range are I2C temperature sensors with a varying number of
> sensors in each device. Each has one internal sensor, and one to four
> external sensor diodes.
> 
> The default range is from 0°C to +127°C, but can be extended to -64°C to
> +191°C.
> 
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> ---
>   .../bindings/hwmon/microchip,emc181x.yaml     | 45 +++++++++++++++++++
>   1 file changed, 45 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc181x.yaml
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
> +    description: Allow for reading of extended temperature range (-64-192C)
> +
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +

The chip has various other configuration options. I would have expected to see
at least beta compensation, ideality factor, resistance error correction,
and anti-parallel diode operation.

Yes, I understand you probably don't plan to implement those in the driver,
but the devicetree property description should at least try to be complete.

Guenter

> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        temperature-sensor@7c {
> +            compatible = "microchip,emc1812";
> +            reg = <0x7c>;
> +        };
> +    };

