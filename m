Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE32806CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377970AbjLFK7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377948AbjLFK7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:59:13 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C27F1712
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:58:55 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-333630e9e43so630875f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701860333; x=1702465133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O3mpdPex6lh7bJVJMIdkNFWjq5uuLmHMpFZ5pnAPzNg=;
        b=uRHbrcUD/OfVro1OBuUzpYGIJN9ljDvX7dD/kXlFTmKsACZ/sTll0wV/fEvkzvV+8r
         syRP3SjIPsh0RML0VHdn/mnozNiLCQ5+CVC78U+0MLxQOD02FdGkVF4cajG4huhRlqi7
         QZ33FFljMk5GwXhy6lC5nDFldJDJ/G0zB5ZGKPUAdpozwLAf8N7Z61GaZwFcTZzdrlFs
         Y7Hr8+CLI5pjAf674nS+zxMkrDVjpVsqiyW9A8f7cetRmjNxesoczZq2Lb36iiSb3NjZ
         nezp1TUy5LeugYWGUyHGc7SVrvCyWiJNiQW405Rfi6qKESh7fGpJjyl/RhG21K4pFOJ1
         B6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860333; x=1702465133;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3mpdPex6lh7bJVJMIdkNFWjq5uuLmHMpFZ5pnAPzNg=;
        b=qpPw2/DIlFakM4BDrknrtCSKm/Pp1oLlAo2q2aBjaMCLXcBksXVIhAYH033YEsliLY
         CawgTwnnjNt7Bt+ffx5UIQz9aNVCyCoVosF9yVoyijwTQzzI3zoRWITOp8E335hzRKuL
         PO99LMy4WxfrOfap1J/kRoa9HBmRxL7ltumz2VIUOMurww3fV0DTWv6e91L1aNbcOzpC
         6s9XyvrMb7RdfbLR+ypyiD0lXtsG5vVjaLvGnz+gNXyvTepl9oWsjkqWlN1IwaNV06WI
         5cfNGmpDc8ErL88T46pIfaqT49BpmchogXHkujaMzDnvKCo7tTt8Ejpk3jLvR+hhadv0
         1vWQ==
X-Gm-Message-State: AOJu0Yz1HpdsIi2UXH7MJjMoMA7/SxKze5PptyiwJavNzGDaj7DDGq3W
        5ejpYcgNZ02gJH92jOzdB2o6sdzT3/84XTHTPTw=
X-Google-Smtp-Source: AGHT+IEOl+MelLmBmtFdVdvn1J+ZJMEq8jYidu4KGNSNgt1h5HYgRtR40mE1owJ1PXc27jtaQ85fAw==
X-Received: by 2002:a5d:66c6:0:b0:332:fffe:d93 with SMTP id k6-20020a5d66c6000000b00332fffe0d93mr342007wrw.12.1701860333303;
        Wed, 06 Dec 2023 02:58:53 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d4b8f000000b003333a6b9b27sm11318968wrt.106.2023.12.06.02.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 02:58:52 -0800 (PST)
Message-ID: <9989e81f-3a53-4833-ab3c-a23619fc1e1f@linaro.org>
Date:   Wed, 6 Dec 2023 11:58:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] Input: Add Himax HX83102J touchscreen driver
Content-Language: en-US
To:     Allen_Lin <allencl_lin@hotmail.com>, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231205100552.723620-1-allencl_lin@hotmail.com>
 <TY0PR06MB5611228C6B67733DC93842C99E85A@TY0PR06MB5611.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <TY0PR06MB5611228C6B67733DC93842C99E85A@TY0PR06MB5611.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 11:05, Allen_Lin wrote:
> Add a new driver for Himax  touchscreen series touchscreen controllers.
> This driver supports Himax IC using the SPI interface to
> acquire HID packets.
> 
> Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> ---
>  MAINTAINERS                    |    2 +
>  drivers/hid/Kconfig            |    9 +-
>  drivers/hid/Makefile           |    2 +-
>  drivers/hid/hid-himax-83102j.c | 3176 ++++++++++++++++++++++++++++++++
>  drivers/hid/hid-himax-83102j.h |  927 ++++++++++
>  5 files changed, 4114 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/hid/hid-himax-83102j.c
>  create mode 100644 drivers/hid/hid-himax-83102j.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cadcbf7294a6..d0d5ab7ea1e6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9507,6 +9507,8 @@ M:	Allen Lin <allencl_lin@hotmail.com>
>  L:	linux-input@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/input/himax,hx8310xx.yaml
> +F:	drivers/hid/hid-himax-83102j.c
> +F:	drivers/hid/hid-himax-83102j.h

drivers/hid/hid-himax-83102j*


>  
>  HIMAX HX83112B TOUCHSCREEN SUPPORT
>  M:	Job Noorman <job@noorman.info>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 4ce74af79657..896af236c1f8 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1324,7 +1324,14 @@ config HID_KUNIT_TEST
>  	  Documentation/dev-tools/kunit/.
>  
>  	  If in doubt, say "N".
> -

Why?

> +config HID_HIMAX
> +	tristate "Himax touchpanel CHIPSET"
> +	depends on HID
> +	help
> +	  Say Y here if you have a Himax CHIPSET touchscreen.
> +	  HIMAX controllers are multi touch controllers which can
> +	  report 10 touches at a time.
> +	  If unsure, say N.
>  endmenu
>  
>  source "drivers/hid/bpf/Kconfig"
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 8a06d0f840bc..a0f0fc3261e0 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -156,7 +156,7 @@ hid-uclogic-test-objs		:= hid-uclogic-rdesc.o \
>  				   hid-uclogic-params.o \
>  				   hid-uclogic-rdesc-test.o
>  obj-$(CONFIG_HID_KUNIT_TEST)	+= hid-uclogic-test.o
> -

Why?

> +obj-$(CONFIG_HID_HIMAX)		+= hid-himax-83102j.o
>  obj-$(CONFIG_USB_HID)		+= usbhid/
>  obj-$(CONFIG_USB_MOUSE)		+= usbhid/
>  obj-$(CONFIG_USB_KBD)		+= usbhid/
> diff --git a/drivers/hid/hid-himax-83102j.c b/drivers/hid/hid-himax-83102j.c
> new file mode 100644
> index 000000000000..fa1b22477457
> --- /dev/null
> +++ b/drivers/hid/hid-himax-83102j.c
> @@ -0,0 +1,3176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*  Himax Driver Code for HX83102J to simulate HID
> + *
> + *  Copyright (C) 2023 Himax Corporation.
> + *
> + *  This software is licensed under the terms of the GNU General Public
> + *  License version 2,  as published by the Free Software Foundation,  and
> + *  may be copied,  distributed,  and modified under those terms.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.

Drop boiler plate.

This is a very poor quality code. Looks like taken straight from crappy
downstream code and sent without cleaning up.

There is way too many things to fix here... not mentioning even multiple
build warning and failure reports!

> + */
> +
> +#include "hid-himax-83102j.h"
> +
> +struct himax_ts_data *g_himax_ts;

Drop, no global variables.

> +struct himax_core_fp g_core_fp;

Drop, no global variables.


> +

> +#define FW_EXT_NAME(FWNAME)	FWNAME ".bin"

Drop

> +char *g_fw_boot_upgrade_name = FW_EXT_NAME(BOOT_UPGRADE_FWNAME);

Drop

> +struct himax_core_command_regs g_core_regs;

Drop

> +
> +
> +union host_ext_rd_t g_host_ext_rd = {
> +	.host_report_descriptor = {
> +		0x06, 0x00, 0xFF,// Usage Page (Vendor-defined)
> +		0x09, 0x01,// Usage (0x1)
> +		0xA1, 0x01,// Collection (Application)
> +		0x75, 0x08,// Report Size (8)
> +		0x15, 0x00,// Logical Minimum (0)
> +		0x26, 0xFF, 0x00,// Logical Maximum (255)
> +		0x85, 0x05,// Report ID (5)
> +		0x09, 0x02,// Usage (0x2)
> +		0x96, 0xFF, 0x00,// Report Count (255)
> +		0xB1, 0x02,// Feature (ID: 5, sz: 2040 bits(255 bytes))
> +		0x85, 0x06,// Report ID (6)
> +		0x09, 0x02,// Usage (0x2)
> +		0x96, (HID_REG_SZ_MAX & 0xFF), (HID_REG_SZ_MAX >> 8),
> +		0xB1, 0x02,// Feature (ID: 6, sz: 72 bits(9 bytes))
> +		0x85, 0x07,// Report ID (7)
> +		0x09, 0x02,// Usage (0x2)
> +		0x96, 0x04, 0x00,// Report Count (4)
> +		0xB1, 0x02,// Feature (ID: 7, sz: 32 bits(4 bytes))
> +		0x85, 0x08,// Report ID (8)
> +		0x09, 0x02,// Usage (0x2)
> +		0x96, 0x8D, 0x13,// Report Count (5005)
> +		0xB1, 0x02,// Feature (ID: 8, sz: 40040 bits(5005 bytes))
> +		// 0x85, 0x09,// Report ID (9)
> +		// 0x09, 0x02,// Usage (0x2)
> +		// 0x96, 0x4F, 0x03,// Report Count (847)
> +		// 0xB1, 0x02,// Feature (ID: 9, sz: 6776 bits(847 bytes))

Why these are commented out? Every piece of dead code must be documented
why it is dead.

> +		0x85, 0x0A,// Report ID (10)
> +		0x09, 0x02,// Usage (0x2)
> +		0x96, 0x00, 0x04,// Report Count (1024)
> +		0x91, 0x02,// Output (ID: 10, sz: 8192 bits(1024 bytes))
> +		0x85, 0x0B,// Report ID (11)
> +		0x09, 0x02,// Usage (0x2)
> +		0x96, 0x01, 0x00,// Report Count (1)
> +		0xB1, 0x02,// Feature (ID: 11, sz: 8 bits(1 bytes))
> +		0x85, 0x0C,// Report ID (12)
> +		0x09, 0x02,// Usage (0x2)
> +		0x96, 0x01, 0x00,// Report Count (1)
> +		0xB1, 0x02,// Feature (ID: 12, sz: 8 bits(1 bytes))
> +		0x85, 0x31,// Report ID (49)
> +		0x09, 0x02,// Usage (0x2)
> +		0x96, 0x01, 0x00,// Report Count (1)
> +		0xB1, 0x02,// Feature (ID: 49, sz: 8 bits(1 bytes))
> +		0xC0,// End Collection
> +	},
> +};
> +
> +const unsigned int host_ext_report_desc_sz =
> +	sizeof(g_host_ext_rd.host_report_descriptor);

Drop, use directly sizeof() in the code.

> +
> +union heatmap_rd_t g_heatmap_rd = {
> +	.host_report_descriptor = {
> +		0x05, 0x0D,// Usage Page (Digitizers)
> +		0x09, 0x0F,// Usage (0xF)
> +		0xA1, 0x01,// Collection (Application)
> +		0x85, 0x61,// Report ID (97)
> +		0x05, 0x0D,// Usage Page (Digitizers)
> +		0x15, 0x00,// Logical Minimum (0)
> +		0x27, 0xFF, 0xFF, 0x00, 0x00,// Logical Maximum (65535)
> +		0x75, 0x10,// Report Size (16)
> +		0x95, 0x01,// Report Count (1)
> +		0x09, 0x6A,// Usage (0x6A)
> +		0x81, 0x02,// Input (ID: 97, sz: 16 bits(2 bytes))
> +		0x09, 0x6B,// Usage (0x6B)
> +		0x81, 0x02,// Input (ID: 97, sz: 16 bits(2 bytes))
> +		0x27, 0xFF, 0xFF, 0xFF, 0xFF,// Logical Maximum (-1)
> +		0x75, 0x20,// Report Size (32)
> +		0x09, 0x56,// Usage (0x56)
> +		0x81, 0x02,// Input (ID: 97, sz: 32 bits(4 bytes))
> +		0x05, 0x01,// Usage Page (Generic Desktop)
> +		0x09, 0x3B,// Usage (0x3B)
> +		0x81, 0x02,// Input (ID: 97, sz: 32 bits(4 bytes))
> +		0x05, 0x0D,// Usage Page (Digitizers)
> +		0x26, 0xFF, 0x00,// Logical Maximum (255)
> +		0x09, 0x6C,// Usage (0x6C)
> +		0x75, 0x08,// Report Size (8)
> +		0x96, 0x00, 0x0C,// Report Count (3072)
> +		0x81, 0x02,// Input (ID: 97, sz: 24576 bits(3072 bytes))
> +		0xC0,// End Collection
> +	},
> +};
> +
> +const unsigned int host_heatmap_report_desc_sz =
> +	sizeof(g_heatmap_rd.host_report_descriptor);

Drop

> +
> +void himax_rst_gpio_set(int pinnum, u8 value)

Really, so nowwhere is static? Everything must be global? Sorry, but
this is not even kernel related, but basic C programming. All your
functions *MUST* be static.



> +{
> +	gpio_direction_output(pinnum, value);

Anyway, useless wrapper, drop entire function.

> +}
> +
> +int himax_gpio_power_config(struct himax_ts_data *ts,

static

> +			    struct himax_platform_data *pdata)
> +{
> +	int error = 0;
> +
> +	if (gpio_is_valid(pdata->gpio_reset)) {
> +		error = gpio_request(pdata->gpio_reset, "himax-reset");

What the crap is this? Isn't gpio_request() some crazy old legacy code?
Open some new driver and look how GPIO is handled there. You must use
gpio descriptors.

> +
> +		if (error < 0) {
> +			E("request reset pin failed");

Drop "E" whatever it is and use standard Linux functions: dev_err().
This applies everywhere.

Abyway, request of GPIO does not happen in power config but in probe.

> +			goto err_gpio_reset_req;
> +		}
> +
> +		error = gpio_direction_output(pdata->gpio_reset, 0);
> +
> +		if (error) {
> +			E("unable to set direction for gpio [%d]",
> +			  pdata->gpio_reset);
> +			goto err_gpio_reset_dir;
> +		}
> +	}
> +
> +	if (pdata->vccd_supply) {
> +		error = regulator_enable(pdata->vccd_supply);

error? Open existing driver and look how it is named there. Usually ret

> +		if (error) {
> +			E("unable to enable vccd supply");

This is not a Linux kernel code style. Open existing driver and look how
it is done there.

...

> +
> +int himax_chip_suspend(struct himax_ts_data *ts)
> +{
> +	int ret = 0;
> +
> +	if (ts->suspended) {
> +		I("Already suspended, skip...");
> +		goto END;
> +	} else {
> +		ts->suspended = true;

Why?

> +	}
> +
> +	I("enter");

Drop

> +	g_core_fp.fp_suspend_proc(ts, ts->suspended);
> +
> +	himax_int_enable(ts, false);
> +
> +	if (!ts->use_irq) {
> +		s32 cancel_state;
> +
> +		cancel_state = cancel_work_sync(&ts->work);
> +		if (cancel_state)
> +			himax_int_enable(ts, true);
> +	}
> +
> +	atomic_set(&ts->suspend_mode, 1);

?!?!? Why?


> +
> +	if (ts->pdata) {
> +		if (ts->pdata->power_off_3v3) {
> +			if (ts->pdata->vcca_supply)
> +				ret = regulator_disable(ts->pdata->vcca_supply);
> +		}
> +	}
> +
> +END:

lowercase

> +	hx_hid_remove(ts);
> +	I("END");

No, come on, drop. Drop such silly code EVERYWHERE.

> +
> +	return ret;
> +}
> +
> +int himax_chip_resume(struct himax_ts_data *ts)
> +{
> +	int ret = 0;
> +
> +	if (!ts->suspended && ts->resume_success) {
> +		I("Already resumed, skip...");
> +		goto END;
> +	} else {
> +		ts->suspended = false;
> +	}
> +	ts->resume_success = false;
> +
> +	I("enter");
> +	/* continuous N times record, not total N times. */
> +	ts->excp_zero_event_count = 0;
> +
> +	atomic_set(&ts->suspend_mode, 0);
> +	if (ts->pdata) {
> +		if (ts->pdata->power_off_3v3) {
> +			if (ts->pdata->vcca_supply)
> +				ret = regulator_enable(ts->pdata->vcca_supply);
> +		}
> +	}
> +
> +	g_core_fp.fp_resume_proc(ts, ts->suspended);
> +	// hx_report_all_leave_event(ts);
> +	if (ts->resume_success) {
> +		hx_hid_probe(ts);
> +		himax_int_enable(ts, true);
> +	} else {
> +		E("resume failed!");
> +		ret = -ECANCELED;
> +	}
> +END:
> +	I("END");
> +
> +	return ret;
> +}
> +
> +int himax_suspend(struct device *dev)
> +{
> +	struct himax_ts_data *ts = dev_get_drvdata(dev);
> +
> +	I("enter");
> +	if (!ts->initialized) {
> +		E("init not ready, skip!");
> +		return -ECANCELED;
> +	}
> +	himax_chip_suspend(ts);
> +	return 0;
> +}
> +
> +int himax_resume(struct device *dev)
> +{
> +	int ret = 0;
> +	struct himax_ts_data *ts = dev_get_drvdata(dev);
> +
> +	I("enter");
> +	/*
> +	 *	wait until device resume for TDDI
> +	 *	TDDI: Touch and display Driver IC
> +	 */
> +	if (!ts->initialized) {
> +#if !defined(CONFIG_FB)
> +		if (himax_chip_init(ts))
> +			return -ECANCELED;
> +#else
> +		E("init not ready, skip!");
> +		return -ECANCELED;
> +#endif
> +	}
> +	ret = himax_chip_resume(ts);
> +	if (ret < 0) {
> +		E("resume failed!");
> +		I("retry resume");
> +		schedule_delayed_work(&ts->work_resume_delayed_work,
> +				      msecs_to_jiffies(ts->pdata->ic_resume_delay));
> +		// I("try int rescue");
> +		// himax_int_enable(ts, 1);

You need to clean it up to look like Linux code. Sorry, it's just not
matching anything in the kernel.

> +	}
> +
> +	return ret;
> +}
> +
> +static void himax_resume_work_func(struct work_struct *work)
> +{
> +	struct himax_ts_data *ts = NULL;
> +
> +	ts = container_of(work, struct himax_ts_data,
> +			  work_resume_delayed_work.work);
> +	if (!ts) {
> +		E("ts is NULL");
> +		return;
> +	}
> +	himax_chip_resume(ts);
> +}
> +
> +#if defined(CONFIG_PM_SLEEP)
> +static const struct dev_pm_ops hx_hid_pm = {
> +	.suspend = himax_suspend,
> +	.resume = himax_resume,
> +	.restore = himax_resume,
> +};
> +
> +#define HX_HID_PM (&hx_hid_pm)
> +#else
> +#define HX_HID_PM NULL
> +#endif
> +
> +#if defined(CONFIG_OF)
> +static const struct of_device_id himax_match_table[] = {
> +	{ .compatible = "himax,hx83102j" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, himax_match_table);
> +#define himax_match_table of_match_ptr(himax_match_table)
> +#else
> +#define himax_match_table NULL
> +#endif
> +
> +
> +#define hx_acpi_spi_table NULL
> +
> +

What are all these above? Empty defines? Drop.


> +int himax_chip_init(struct himax_ts_data *ts)
> +{
> +	int err = PROBE_FAIL;

What is that? There is no errno like PROBE_FAIL. Does not exist.

> +	struct himax_platform_data *pdata = ts->pdata;
> +
> +	ts->chip_max_dsram_size = 0;
> +	ts->notouch_frame = 0;
> +	ts->ic_notouch_frame = 0;
> +
> +	if (g_core_fp.fp_chip_init) {
> +		g_core_fp.fp_chip_init(ts);

This is some weird code. You need to refactor all this to look like
Linux code.

> +	} else {
> +		E("function point of chip_init is NULL!");
> +		goto error_ic_init_failed;
> +	}
> +	g_core_fp.fp_touch_information(ts);
> +
> +	spin_lock_init(&ts->irq_lock);
> +
> +	if (himax_ts_register_interrupt(ts)) {
> +		E("register interrupt failed");
> +		goto err_register_interrupt_failed;
> +	}
> +
> +	himax_int_enable(ts, false);
> +
> +	ts->himax_hid_debug_wq =
> +		create_singlethread_workqueue("HX_hid_debug");
> +	if (!ts->himax_hid_debug_wq) {
> +		E("allocate himax_hid_debug_wq failed");
> +		err = -ENOMEM;
> +		goto err_hid_debug_wq_failed;
> +	}
> +	INIT_DELAYED_WORK(&ts->work_hid_update, hx_hid_update);
> +
> +	ts->himax_resume_delayed_work_wq =
> +		create_singlethread_workqueue("HX_resume_delayed_work");
> +	if (!ts->himax_resume_delayed_work_wq) {
> +		E("allocate himax_resume_delayed_work_wq failed");
> +		err = -ENOMEM;
> +		goto err_resume_delayed_work_wq_failed;
> +	}
> +	INIT_DELAYED_WORK(&ts->work_resume_delayed_work, himax_resume_work_func);
> +
> +	g_core_fp.fp_calc_touch_data_size(ts);
> +
> +#if defined(CONFIG_OF)
> +	pdata->cable_config[0]             = 0xF0;
> +	pdata->cable_config[1]             = 0x00;
> +#endif
> +
> +	ts->suspended                      = false;
> +	ts->usb_connected = 0x00;
> +	ts->cable_config = pdata->cable_config;
> +	ts->initialized = true;
> +	return 0;
> +
> +err_resume_delayed_work_wq_failed:
> +	destroy_workqueue(ts->himax_hid_debug_wq);
> +err_hid_debug_wq_failed:
> +	himax_ts_unregister_interrupt(ts);
> +err_register_interrupt_failed:
> +error_ic_init_failed:
> +	ts->probe_fail_flag = 1;
> +	return err;
> +}
> +
> +void himax_chip_deinit(struct himax_ts_data *ts)
> +{
> +	kfree(ts->zf_update_cfg_buffer);
> +	ts->zf_update_cfg_buffer = NULL;
> +
> +	himax_ts_unregister_interrupt(ts);
> +
> +	himax_report_data_deinit(ts);
> +
> +	cancel_delayed_work_sync(&ts->work_resume_delayed_work);
> +	destroy_workqueue(ts->himax_resume_delayed_work_wq);
> +	destroy_workqueue(ts->himax_hid_debug_wq);
> +
> +	ts->probe_fail_flag = 0;
> +
> +	I("Common section deinited!");
> +}
> +
> +static void himax_platform_deinit(struct himax_ts_data *ts)
> +{
> +	struct himax_platform_data *pdata = NULL;
> +
> +	I("entering");
> +
> +	if (!ts) {
> +		E("ts is NULL");
> +		return;
> +	}
> +
> +	pdata = ts->pdata;
> +	if (!pdata) {
> +		E("pdata is NULL");
> +		return;
> +	}
> +
> +	himax_gpio_power_deconfig(pdata);
> +
> +	kfree(ts->ic_data);
> +	ts->ic_data = NULL;
> +
> +	kfree(pdata);
> +	pdata = NULL;
> +	ts->pdata = NULL;
> +
> +	kfree(ts->xfer_buff);
> +	ts->xfer_buff = NULL;

Spaghetti... Why this is not devm?

> +
> +	I("exit");
> +}
> +
> +static bool himax_platform_init(struct himax_ts_data *ts,
> +				struct himax_platform_data *local_pdata)

Four inits... spaghetti code.

> +{
> +	int err = PROBE_FAIL;
> +	struct himax_platform_data *pdata;
> +
> +	I("entering");
> +	ts->xfer_buff = kcalloc
> +		(HX_FULL_STACK_RAWDATA_SIZE, sizeof(u8), GFP_KERNEL);

You must fix all checkpatch warnings. This is wrong wrapping.


> +	if (!ts->xfer_buff) {
> +		err = -ENOMEM;
> +		goto err_xfer_buff_fail;
> +	}
> +
> +	I("PDATA START");
> +	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) { /*Allocate Platform data space*/

Useless comment.

> +		err = -ENOMEM;
> +		goto err_dt_platform_data_fail;
> +	}
> +
> +	I("ts->ic_data START");
> +	ts->ic_data = kzalloc(sizeof(*ts->ic_data), GFP_KERNEL);
> +	if (!ts->ic_data) { /*Allocate IC data space*/

Useless comment.

> +		err = -ENOMEM;
> +		goto err_dt_ic_data_fail;
> +	}

...

> +int himax_parse_dt(struct device_node *dt, struct himax_platform_data *pdata)
> +{
> +	/* pid_fw_name size = length of default_fw_name + length of "_XXXX" +
> +	 * length of ".bin" + null terminator.
> +	 */
> +	static char pid_fw_name[ARRAY_SIZE(default_fw_name) + 5 + 4 + 1] = {0};
> +	int tmp = 0;
> +	const int pid_prop_args = 2;
> +	u32 data = 0;
> +	int id_gpios[8] = {0};
> +	int counter = 0;
> +	int i = 0;
> +	s16 id_value = -1;
> +	int dts_irq = 0;
> +	int err = 0;

Absolutely unreadable.

> +
> +	UNUSED(default_fw_name);

???

> +	if (!dt || !pdata) {
> +		E("DT: dev or pdata is NULL");
> +		return -EINVAL;
> +	}
> +
> +	dts_irq = of_irq_get(dt, 0);

No, use standard code.

> +	D("DT: dts_irq = %d", dts_irq);
> +	if (dts_irq <= 0) {
> +		if (dts_irq == -EPROBE_DEFER)
> +			E("DT: dts_irq = -EPROBE_DEFER");

dev_err_probe.

> +		return -EIO;

?!?! Why do you cast errors?

> +	}
> +
> +	pdata->of_irq = dts_irq;
> +	pdata->gpio_irq = -1;
> +
> +	pdata->gpio_reset = of_get_named_gpio(dt, "reset-gpios", 0);
> +	if (!gpio_is_valid(pdata->gpio_reset)) {
> +		I(" DT:gpio-rst value is not valid");
> +		return -EIO;
> +	}
> +
> +	I(" DT:interrupt=%d, reset=%d",
> +	  pdata->of_irq, pdata->gpio_reset);
> +	counter = gpiod_count(pdata->ts->dev, "himax,id");

NAK, there is no such property.

> +	if (counter > 0) {
> +		for (i = 0 ; i < counter ; i++) {
> +			id_gpios[i] = of_get_named_gpio(dt, "himax,id-gpios", i);

NAK, there is no such property.


> +			if (!gpio_is_valid(id_gpios[i])) {
> +				I(" DT:gpio-id value is not valid");
> +				return -EIO;
> +			}
> +			I(" DT:gpio-id[%d]=%d", i, id_gpios[i]);
> +		}
> +		id_value = 0;
> +		for (i = 0 ; i < counter ; i++) {
> +			gpio_direction_input(id_gpios[i]);
> +			id_value |= gpio_get_value(id_gpios[i]) << i;
> +		}
> +		I(" DT:gpio-id value=%04X", id_value);
> +		pdata->panel_id = id_value;
> +	} else {
> +		pdata->panel_id = -1;
> +		D(" DT:gpio-id not found");
> +	}

This is absolutely unreadable code.

> +
> +	// himax,ic_det_delay unit is millisecond
> +	if (of_property_read_u32(dt, "himax,ic-det-delay-ms", &data)) {

NAK, there is no such property.


> +		pdata->ic_det_delay = 0;
> +		D(" DT:himax,ic-det-delay-ms not found");
> +	} else {
> +		pdata->ic_det_delay = data;
> +		I(" DT:himax,ic-det-delay-ms=%d", pdata->ic_det_delay);
> +	}
> +
> +	// himax,ic_resume_delay unit is millisecond
> +	if (of_property_read_u32(dt, "himax,ic-resume-delay-ms", &data)) {

NAK, there is no such property.

> +		pdata->ic_resume_delay = 0;
> +		D(" DT:himax,ic-resume-delay-ms not found");
> +	} else {
> +		pdata->ic_resume_delay = data;
> +		I(" DT:himax,ic-resume-delay-ms=%d", pdata->ic_resume_delay);
> +	}
> +
> +	if (of_property_read_bool(dt, "himax,has-flash")) {
> +		pdata->is_zf = false;
> +		D(" DT:himax,has-flash");
> +	} else {
> +		pdata->is_zf = true;
> +		I(" DT:himax,has-flash not found, load firmware from file");
> +	}
> +
> +	if (of_property_read_bool(dt, "vccd-supply")) {
> +		pdata->vccd_supply = regulator_get(pdata->ts->dev, "vccd");
> +		if (IS_ERR(pdata->vccd_supply)) {
> +			E(" DT:failed to get vccd supply");
> +			err = PTR_ERR(pdata->vccd_supply);
> +			pdata->vccd_supply = NULL;
> +			return err;
> +		}
> +		I(" DT:vccd-supply=%p", pdata->vccd_supply);
> +	} else {
> +		pdata->vccd_supply = NULL;
> +	}
> +
> +	if (of_property_read_bool(dt, "vcca-supply")) {
> +		pdata->vcca_supply = regulator_get(pdata->ts->dev, "vcca");
> +		if (IS_ERR(pdata->vcca_supply)) {
> +			E(" DT:failed to get vcca supply");
> +			err = PTR_ERR(pdata->vcca_supply);
> +			pdata->vcca_supply = NULL;
> +			return err;
> +		}
> +		I(" DT:vcca-supply=%p", pdata->vcca_supply);
> +	} else {
> +		pdata->vcca_supply = NULL;
> +	}
> +
> +	/*
> +	 * check himax,pid first, if exist then check if it is single.
> +	 * Single case: himax,pid = <0x1002>; // 0x1002 is pid value
> +	 * Multiple case: himax,pid = <id_value0 00x1001>, <id_value1 0x1002>;
> +	 * When id_value >= 0, check the mapping listed to use the pid value.
> +	 */
> +	if (of_get_property(dt, "himax,pid", &data)) {

NAK, there is no such property.

This is very, very poor code with hundreds of style issues. This just
does not look like ready for sending upstream. Plus you stuffed here
many undocumented properties, so you bypass the bindings review.

...

> +
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/acpi.h>
> +#include <linux/spi/spi.h>
> +#include <linux/hid.h>
> +#include <linux/sizes.h>
> +#include <linux/fs.h>
> +#include <linux/gpio.h>
> +#include <linux/types.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_irq.h>
> +#include <linux/proc_fs.h>
> +#include <linux/version.h>
> +#include <linux/firmware.h>
> +#include <linux/stddef.h>
> +#include <linux/power_supply.h>
> +
> +#define HIMAX_DRIVER_VER "1.0.0"


Drop

> +
> +#define HIMAX_BUS_RETRY_TIMES 3
> +#define BUS_RW_MAX_LEN 0x20006
> +#define BUS_R_HLEN 3
> +#define BUS_R_DLEN ((BUS_RW_MAX_LEN - BUS_R_HLEN) - ((BUS_RW_MAX_LEN - BUS_R_HLEN) % 4))
> +#define BUS_W_HLEN 2
> +#define BUS_W_DLEN ((BUS_RW_MAX_LEN - BUS_W_HLEN) - ((BUS_RW_MAX_LEN - BUS_W_HLEN) % 4))
> +#define FIX_HX_INT_IS_EDGE	(false)

Drop

> +
> +#define HX_DELAY_BOOT_UPDATE			(2000)
> +#define HID_REG_SZ_MAX					(1 + 4 + 1 + 4 + 256)

?!?! More cryptic constants...


> +
> +enum HID_ID_FUNCT {
> +	ID_CONTACT_COUNT = 0x03,

???

> +};
> +
> +#define HID_RAW_DATA_TYPE_DELTA     (0x09)
> +#define HID_RAW_DATA_TYPE_RAW       (0x0A)
> +#define HID_RAW_DATA_TYPE_BASELINE  (0x0B)
> +#define HID_RAW_DATA_TYPE_NORMAL	(0x00)

???

> +
> +enum HID_FW_UPDATE_STATUS_CODE {
> +	FWUP_ERROR_NO_ERROR = 0x77,
> +	FWUP_ERROR_MCU_00 = 0x00,
> +	FWUP_ERROR_MCU_A0 = 0xA0,
> +	FWUP_ERROR_NO_BL = 0xC1,
> +	FWUP_ERROR_NO_MAIN = 0xC2,
> +	FWUP_ERROR_BL_COMPLETE = 0xB1,
> +	FWUP_ERROR_BL = 0xB2,
> +	FWUP_ERROR_PW = 0xB3,
> +	FWUP_ERROR_ERASE_FLASH = 0xB4,
> +	FWUP_ERROR_FLASH_PROGRAMMING = 0xB5,
> +	FWUP_ERROR_NO_DEVICE = 0xFFFFFF00,
> +	FWUP_ERROR_LOAD_FW_BIN = 0xFFFFFF01,
> +	FWUP_ERROR_INITIAL = 0xFFFFFF02,
> +	FWUP_ERROR_POLLING_TIMEOUT = 0xFFFFFF03,
> +	FWUP_ERROR_FW_TRANSFER = 0xFFFFFF04


> +};
> +
> +struct himax_ts_data;

Drop


> +union host_ext_rd_t;

Drop

> +union heatmap_rd_t;

Drop


> +
> +#define HID_FW_UPDATE_BL_CMD    (0x77)
> +#define HID_FW_UPDATE_MAIN_CMD  (0x55)
> +
> +int hx_hid_probe(struct himax_ts_data *ts);
> +void hx_hid_remove(struct himax_ts_data *ts);

Drop

> +
> +void hx_hid_update_info(struct himax_ts_data *ts);
> +int hx_hid_report(const struct himax_ts_data *ts, u8 *data, s32 len);

Drop

> +
> +enum fix_touch_info {
> +	FIX_HX_RX_NUM = 48,
> +	FIX_HX_TX_NUM = 32,
> +	FIX_HX_BT_NUM = 0,
> +	FIX_HX_MAX_PT = 10,
> +	FIX_HX_STYLUS_FUNC = 1,
> +	FIX_HX_STYLUS_ID_V2 = 0,
> +	FIX_HX_STYLUS_RATIO = 1,
> +	HX_STACK_ORG_LEN = 128
> +};

?

> +
> +#define himax_dev_name "hx_spi_hid_tp"

Drop

> +
> +#if defined(CONFIG_FB)
> +#include <linux/notifier.h>
> +#include <linux/fb.h>
> +#endif

Drop everything above, entire file is so far useless.

> +
> +/* log macro */
> +#define I(fmt, arg...) pr_info("[HXTP][%s]: " fmt "\n", __func__, ##arg)
> +#define W(fmt, arg...) pr_warn("[HXTP][WARNING][%s]: " fmt "\n", __func__, ##arg)
> +#define E(fmt, arg...) pr_err("[HXTP][ERROR][%s]: " fmt "\n", __func__, ##arg)
> +#define D(fmt, arg...) pr_debug("[HXTP][DEBUG][%s]: " fmt "\n", __func__, ##arg)

NAK on all these

> +
> +#define himax_dev_name "hx_spi_hid_tp"
> +
> +#define BOOT_UPGRADE_FWNAME "himax_i2chid"
> +
> +#define MPAP_FWNAME "himax_mpfw.bin"
> +
> +#define UNUSED(x) ((void)(x))

NAK.

> +static const char default_fw_name[] = BOOT_UPGRADE_FWNAME;
> +
> +#define DATA_LEN_4				4
> +#define ADDR_LEN_4				4
> +#define MAX_I2C_TRANS_SZ		128
> +#define HIMAX_REG_RETRY_TIMES	5
> +#define FW_PAGE_SZ			128
> +#define HX1K					0x400

?

> +#define HX_48K_SZ				0xC000
> +#define HX64K					0x10000

?

> +
> +#define HX_RW_REG_FAIL			(-1)
> +
> +#define hx83102j_fw_addr_raw_out_sel 0x100072EC
> +#define hx83102j_ic_adr_tcon_rst     0x80020004
> +#define hx83102j_data_adc_num        400 /* 200x2 */
> +#define hx83102j_notouch_frame       0
> +#define HX83102J_FLASH_SIZE        261120
> +#define HX83102j_ic_addr_hw_crc 0x80010000
> +#define HX83102j_data_hw_crc 0x0000ECCE
> +
> +/* CORE_IC */
> +	#define ic_adr_ahb_addr_byte_0           0x00

All defines MUST be uppercase


> +	#define ic_adr_ahb_rdata_byte_0          0x08
> +	#define ic_adr_ahb_access_direction      0x0c
> +	#define ic_adr_conti                     0x13
> +	#define ic_adr_incr4                     0x0D
> +	#define ic_adr_i2c_psw_lb                0x31
> +	#define ic_adr_i2c_psw_ub                0x32
> +	#define ic_cmd_ahb_access_direction_read 0x00
> +	#define ic_cmd_conti                     0x31
> +	#define ic_cmd_incr4                     0x10
> +	#define ic_cmd_i2c_psw_lb                0x27
> +	#define ic_cmd_i2c_psw_ub                0x95
> +	#define ic_adr_tcon_on_rst               0x80020020
> +	#define ic_adr_cs_central_state          0x900000A8

Weird indentation.

...

> +	/* origin is 20/50 */
> +	#define RST_LOW_PERIOD_S 5000
> +	#define RST_LOW_PERIOD_E 5100
> +	#define RST_HIGH_PERIOD_ZF_S 5000
> +	#define RST_HIGH_PERIOD_ZF_E 5100
> +	#define RST_HIGH_PERIOD_S 50000
> +	#define RST_HIGH_PERIOD_E 50100

Missing blank line.

> +enum data_type {

So here it is lowercase, then why in other places you use upper case?


> +	HX_REG = 0xA5,
> +	HX_DATA
> +};
> +
> +struct hx_reg_t {
> +	union {
> +		u32 word;
> +		u16 half[2];
> +		u8 byte[4];
> +	} data;
> +	u32 len;
> +	u32 data_type;
> +};

Pointless to have in header.

> +
> +struct data_pack_t {
> +	union {
> +		u32 *word;
> +		u16 *half;
> +		u8 *byte;
> +		void *ptr;
> +	} data;
> +	/* length in byte unit */
> +	u32 len;
> +	u32 data_type;
> +};
> +
> +#define BYTE_REG(_reg, _data) \
> +	{ \
> +		_reg.data.byte[0] = (_data) & 0xFF; \
> +		_reg.len = 1; \
> +		_reg.data_type = HX_REG; \
> +	}
> +#define HALF_REG(_reg, _data) \
> +	{ \
> +		_reg.data.half[0] = cpu_to_le16((_data) & 0xFFFF); \
> +		_reg.len = 2; \
> +		_reg.data_type = HX_REG; \
> +	}
> +#define WORD_REG(_reg, _data) \
> +	{ \
> +		_reg.data.word = cpu_to_le32(_data); \
> +		_reg.len = 4; \
> +		_reg.data_type = HX_REG; \
> +	}

What are all thesE?

> +
> +// set val to already defined reg/data
> +#define VAL_SET(_var, _val) \
> +	({ \
> +		bool _ret = true; \
> +		do { \
> +			if (_var.data_type == HX_DATA) { \
> +				memset(_var.data.byte, 0, _var.len); \
> +				do { \
> +					switch (_var.len) { \
> +					case 1: \
> +						_var.data.byte[0] = (_val) & 0xFF; \
> +						break; \
> +					case 2: \
> +						_var.data.half[0] = cpu_to_le16((_val) & 0xFFFF); \
> +						break; \
> +					case 3: \
> +						_var.data.half[0] = cpu_to_le16((_val) & 0xFFFF); \
> +						_var.data.byte[2] = ((_val) >> 16) & 0xFF; \
> +						break; \
> +					case 4: \
> +						_var.data.word[0] =\
> +						cpu_to_le32((_val) & 0xFFFFFFFF); \
> +						break; \
> +					default: \
> +						_ret = false; \
> +						break; \
> +					};\
> +				} while (0); \
> +			} else { \
> +				_ret = false; \
> +			} \
> +		} while (0); \
> +		_ret; \
> +	})

Drop entire macro.


> +
> +// set ptr/array to already defined reg/data
> +#define PTR_SET(_var, _ptr, _len) \
> +	({ \
> +		bool _ret = true; \
> +		do { \
> +			if ((_len) > (_var).len) { \
> +				_ret = false; \
> +				break; \
> +			} \
> +			memcpy((_var).data.byte, _ptr, (_len)); \
> +			(_var).len = (_len); \
> +		} while (0); \
> +		_ret; \
> +	})

Drop.

> +
> +#define DEF_WORD_DATA(_data_name) \
> +	u8 _data_name##_array[4] = {0}; \
> +	struct data_pack_t _data_name = { \
> +		.data.byte = _data_name##_array, \
> +		.len = 4, \
> +		.data_type = HX_DATA \
> +	}

Drop

> +
> +#define ARRAY_DATA(_data, _byte_len) { \
> +		_data.data.byte = (uint8_t *)_data, \
> +		_data.len = _byte_len, \
> +		.data_type = HX_DATA \
> +	}

Drop

> +
> +#define REG_GET_VAL(_reg) \
> +	({ \
> +		u32 _val = 0; \
> +		do { \
> +			switch (_reg.len) { \
> +			case 1: \
> +				_val = _reg.data.byte[0]; \
> +				break; \
> +			case 2: \
> +				_val = le16_to_cpu(_reg.data.half[0]); \
> +				break; \
> +			case 3: \
> +				_val = le16_to_cpu(_reg.data.half[0]) | (_reg.data.byte[2] << 16); \
> +				break; \
> +			case 4: \
> +				_val = le32_to_cpu(_reg.data.word); \
> +				break; \
> +			} \
> +		} while (0); \
> +		_val; \
> +	})

Drop

> +
> +struct ic_operation {
> +	struct hx_reg_t addr_ahb_addr_byte_0;
> +	struct hx_reg_t addr_ahb_rdata_byte_0;
> +	struct hx_reg_t addr_ahb_access_direction;
> +	struct hx_reg_t addr_conti;
> +	struct hx_reg_t addr_incr4;
> +	struct hx_reg_t adr_i2c_psw_lb;
> +	struct hx_reg_t adr_i2c_psw_ub;
> +	struct hx_reg_t data_ahb_access_direction_read;
> +	struct hx_reg_t data_conti;
> +	struct hx_reg_t data_incr4;
> +	struct hx_reg_t data_i2c_psw_lb;
> +	struct hx_reg_t data_i2c_psw_ub;
> +	struct hx_reg_t addr_tcon_on_rst;
> +	struct hx_reg_t addr_cs_central_state;
> +};
> +
> +struct fw_operation {

Why do you have 20 structures? This is real spaghetti...



> +struct rd_feature_unit_t {
> +	u8 id_tag;
> +	u8 id;
> +	u8 usage_tag;
> +	u8 usage;
> +	u8 report_cnt_tag;
> +	u16 report_cnt;
> +	u8 feature_tag[2];
> +} __packed;
> +struct hx_hid_req_cfg_t {
> +	u32 processing_id;
> +	u32 data_type;
> +	u32 self_test_type;
> +	u32 handshake_set;
> +	u32 handshake_get;
> +	struct firmware *fw;
> +	u32 current_size;
> +	// HID REG READ/WRITE format:
> +	// STANDARD TYPE
> +	// [ID:1][READ/WRITE:1][REG_ADDR:4][REG_DATA:4] : 10 bytes
> +	//  0     1             2~5         6~9
> +	// EXT TYPE
> +	// [ID:1][READ/WRITE:1][0xFFFFFFFF][REG_TYPE:1][REG_ADDR:1|4][REG_DATA:1~256]
> +	//  0	  1             2~5         6           7|7~10        8~263|11~266
> +	union hx_dword_data_t reg_addr;
> +	u32 reg_addr_sz;
> +	u8 reg_data[HID_REG_SZ_MAX - 1 - 4];
> +	u32 reg_data_sz;
> +	u32 input_RD_de;
> +};
> +
> +enum cell_type {
> +	CHIP_IS_ON_CELL,
> +	CHIP_IS_IN_CELL
> +};
> +
> +#define HX_FULL_STACK_RAWDATA_SIZE \
> +	(HX_STACK_ORG_LEN +\
> +	(2 + FIX_HX_RX_NUM * FIX_HX_TX_NUM + FIX_HX_TX_NUM + FIX_HX_RX_NUM)\
> +	* 2)
> +
> +struct himax_ic_data {
> +	int vendor_fw_ver;
> +	int vendor_config_ver;
> +	int vendor_touch_cfg_ver;
> +	int vendor_display_cfg_ver;
> +	int vendor_cid_maj_ver;
> +	int vendor_cid_min_ver;
> +	int vendor_panel_ver;
> +	int vendor_sensor_id;
> +	int ic_adc_num;
> +	u8 vendor_cus_info[12];
> +	u8 vendor_proj_info[12];
> +	u32 flash_size;
> +	u32 HX_RX_NUM;
> +	u32 HX_TX_NUM;
> +	u32 HX_BT_NUM;
> +	u32 HX_X_RES;
> +	u32 HX_Y_RES;
> +	u32 HX_MAX_PT;
> +	u8 HX_INT_IS_EDGE;
> +	u8 HX_STYLUS_FUNC;
> +	u8 HX_STYLUS_ID_V2;
> +	u8 HX_STYLUS_RATIO;
> +	u32 icid;
> +	bool enc16bits;
> +	bool has_flash;
> +};
> +
> +enum HX_TS_PATH {
> +	HX_REPORT_COORD = 1,
> +	HX_REPORT_COORD_RAWDATA,
> +};
> +
> +enum HX_TS_STATUS {
> +	HX_TS_GET_DATA_FAIL = -4,
> +	HX_EXCP_EVENT,
> +	HX_CHKSUM_FAIL,
> +	HX_PATH_FAIL,
> +	HX_TS_NORMAL_END = 0,
> +	HX_EXCP_REC_OK,
> +	HX_READY_SERVE,
> +	HX_REPORT_DATA,
> +	HX_EXCP_WARNING,
> +	HX_IC_RUNNING,
> +	HX_ZERO_EVENT_COUNT,
> +	HX_RST_OK,
> +};
> +
> +enum HX_ERROR_CODE {
> +	NO_ERR = 0,
> +	READY_TO_SERVE = 1,
> +	WORK_OUT = 2,
> +	HX_EMBEDDED_FW = 3,
> +	BUS_FAIL = -1,
> +	HX_INIT_FAIL = -1,
> +	MEM_ALLOC_FAIL = -2,
> +	CHECKSUM_FAIL = -3,
> +	GESTURE_DETECT_FAIL = -4,
> +	INPUT_REGISTER_FAIL = -5,
> +	FW_NOT_READY = -6,
> +	LENGTH_FAIL = -7,
> +	OPEN_FILE_FAIL = -8,
> +	PROBE_FAIL = -9,
> +	ERR_WORK_OUT = -10,
> +	ERR_STS_WRONG = -11,
> +	ERR_TEST_FAIL = -12,
> +	HW_CRC_FAIL = 1
> +};
> +
> +struct himax_platform_data {
> +	struct himax_ts_data *ts;
> +	u16 pid;
> +	bool power_off_3v3;
> +	u8 cable_config[2];
> +	int gpio_irq;
> +	int of_irq;
> +	int gpio_reset;
> +	int ic_det_delay;
> +	int ic_resume_delay;
> +	int panel_id;
> +	bool is_zf;
> +	struct regulator *vccd_supply;
> +	struct regulator *vcca_supply;
> +};
> +
> +struct hx_hid_fw_unit_t {
> +	u8 cmd;
> +	u16 bin_start_offset;
> +	u16 unit_sz;
> +} __packed;
> +
> +struct hx_bin_desc_t {
> +	u16 passwd;
> +	u16 cid;
> +	u8 panel_ver;
> +	u16 fw_ver;
> +	u8 ic_sign;
> +	char customer[12];
> +	char project[12];
> +	char fw_major[12];
> +	char fw_minor[12];
> +	char date[12];
> +	char ic_sign_2[12];
> +} __packed;
> +
> +struct hx_hid_desc_t {
> +	u16 desc_length;
> +	u16 bcd_version;
> +	u16 report_desc_length;
> +	u16 max_input_length;
> +	u16 max_output_length;
> +	u16 max_fragment_length;
> +	u16 vendor_id;
> +	u16 product_id;
> +	u16 version_id;
> +	u16 flags;
> +	u32 reserved;
> +} __packed;

Why packed?

> +struct hx_hid_info_t {
> +	struct hx_hid_fw_unit_t main_mapping[9];
> +	struct hx_hid_fw_unit_t bl_mapping;
> +	struct hx_bin_desc_t fw_bin_desc;
> +	u16 vid;
> +	u16 pid;
> +	u8 cfg_info[32];
> +	u8 cfg_version;
> +	u8 disp_version;
> +	u8 rx;
> +	u8 tx;
> +	u16 yres;
> +	u16 xres;
> +	u8 pt_num;
> +	u8 mkey_num;
> +	u8 debug_info[78];
> +} __packed;

Why packed?


> +
> +struct himax_ts_data {

Ok, this is final cherry on top.

You have 20 structures but it is not enough. You have now master
structure that for simple driver has 100 members.

Absolutely NAK.


Best regards,
Krzysztof

