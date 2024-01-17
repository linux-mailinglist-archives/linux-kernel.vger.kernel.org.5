Return-Path: <linux-kernel+bounces-28618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAFF8300C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD46A1F250DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1655FC121;
	Wed, 17 Jan 2024 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcaCoWLo"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A431118D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705477977; cv=none; b=Ivgim5096vgXKqAk2lPcAsX+5APRcIRdFWG211TcXTmSXGA84uRgp3OfPlNxd8M6XLmMzfVemueT3NOS+d/kv4ijmRGlrzU6L5y65Xcq2fl9sYdHKcZRfHosSUhnagftgnnhQNgYPTn/OJ+UryN4CvfJzFpnS8gDriQf08x5x9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705477977; c=relaxed/simple;
	bh=vkwsIUf+4GKH0Wt0J9vNBvR2nXIGyJtfH+L4SrHmTXs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=u/t1Fi1xs5Yk+QxloO9T2K+R6qByX0IP5Gik8KOVmeCgMH6kYlK1e7+JBkjbBZSRbV+Y8Eir7zmUMLyedb+CCJdqAe6lkBAYcSOaXDKeqfuB1n1Pam26VebjwArkzdgxWy9jZUHgv65Pi275fpt7V7edUUTwmhEFpGYHbk/WEBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kcaCoWLo; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eaabc36bcso13293986e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705477972; x=1706082772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+K2InB5c7pevqOKaItUOOAK91DVhFyytK6/2No2oNQ=;
        b=kcaCoWLo4XxuQcAGLYK07boM9eO4wPw7jC7fpAZObv6HOs/n3AJ2mKGQOuvwRbuPys
         qU5ILYuZlNXKCjbtxeHnnKcbcl55KL+mvV0VTrt1fH0PcgTIGCxGnvLmjyKniSR1iGhQ
         Z+cAZ05IjJ6INY4JUcg/SD2xBSgXznt8GnoX+YgZpQ6cxTxs5jgRJWscmbFPsqxbO4Y5
         UW79pnFuTyVP7fQmGQ7Jm5SyLAH8rFXDWIUxzE23hW1pQacfUXR55jMiRY9cmH7no6Tk
         OH4dV8LCZR3XWNW82fu/Cwf7xwfQXNBgJd45/SzjJWlXMjPCC+HWGTCm/mn3s1e8Cb0I
         7TiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705477972; x=1706082772;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+K2InB5c7pevqOKaItUOOAK91DVhFyytK6/2No2oNQ=;
        b=uADuKDrejEfePRp1W5tHAUaCy8OwJKuWO24JN3zWMPL0+28KBzkCiuihIHYAJ8rY15
         rWLQD8cjtfEsnXb9US2CeTXPeUBRswUt9IfyyPPaCDgPQ0SvZW26QQNTxQhAiyWSz8U/
         GAz/9VleHvn0aor71mVNgKTx7pzTpjNaKmHR0yzVXe05n0/SMVbpngXYxj858OI2y2xD
         QJvNac0lUcXefRZBiAy/LSMNLf1wlOzh4P1IwaKC4k0M7VbtNjIza9GB2coMne+GsJbU
         ikyLVcEA+k9hzDGYJoDpPmp5GqPZpQRBpO2H5xWOXCq4SwQs7FW9o6h74X9LZDq5aRZI
         Qu8Q==
X-Gm-Message-State: AOJu0YzrxpTY6xl/0hEuypykaguB/f2v+jbDGK38a0PsrmQbrKYwIfF0
	LmeLj4AiU1+ddm9PzM4lkPrhTkk931DtwA==
X-Google-Smtp-Source: AGHT+IF2xiWl8vNXGE6vO/fEBuFw5+uLeoXH4/xHaaSSx9KWmrL0q7zvDIJBPPiaEGFb/o/5gZ7YZQ==
X-Received: by 2002:ac2:5e27:0:b0:50e:b3bb:12aa with SMTP id o7-20020ac25e27000000b0050eb3bb12aamr3460970lfg.59.1705477972384;
        Tue, 16 Jan 2024 23:52:52 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id rh5-20020a17090720e500b00a26b44ac54dsm7372797ejb.68.2024.01.16.23.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 23:52:51 -0800 (PST)
Message-ID: <3aef2fc5-f213-42e0-9b72-619364ef6c76@linaro.org>
Date: Wed, 17 Jan 2024 08:52:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: fpga: Convert fpga-region binding to yaml
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
References: <2a48c720bf0efce77d68a0bef10b47671b35506b.1705413862.git.michal.simek@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <2a48c720bf0efce77d68a0bef10b47671b35506b.1705413862.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 15:04, Michal Simek wrote:
> Convert the generic fpga region DT binding to json-schema.
> There are some differences compare to txt version.
> 1. DT overlay can't be described in example that's why directly include
> information from overlay to node which was referenced. It is visible in
> example with /* DT Overlay contains: &... */
> 
> 2. All example have been rewritten to be simpler and describe only full
> reconfiguration and partial reconfiguration with one bridge.
> Completely drop the case where fpga region can inside partial
> reconfiguration region which is already described in description
> 
> 3. Fixed some typos in descriptions compare to txt version but most of it
> is just c&p from txt file.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---

..

> +  --
> +  [1] www.altera.com/content/dam/altera-www/global/en_US/pdfs/literature/ug/ug_partrecon.pdf
> +  [2] tspace.library.utoronto.ca/bitstream/1807/67932/1/Byma_Stuart_A_201411_MAS_thesis.pdf
> +  [3] https://www.xilinx.com/support/documentation/sw_manuals/xilinx14_1/ug702.pdf
> +
> +properties:
> +  $nodename:
> +    pattern: "^fpga-region(-[0-9]|[1-9][0-9]+)?$"

I think you miss here one set of (). Please look at my previous pattern
and test yours. This should fail, e.g. on fpga-region-0

> +
> +  compatible:
> +    const: fpga-region
> +
> +  "#address-cells": true
> +  "#size-cells": true
> +
> +  config-complete-timeout-us:
> +    description:
> +      The maximum time in microseconds time for the FPGA to go to operating
> +      mode after the region has been programmed.
> +
> +  encrypted-fpga-config:
> +    type: boolean
> +    description:
> +      Set if the bitstream is encrypted.
> +
> +  external-fpga-config:
> +    type: boolean
> +    description:
> +      Set if the FPGA has already been configured prior to OS boot up.
> +
> +  firmware-name:
> +    maxItems: 1
> +    description:
> +      Should contain the name of an FPGA image file located on the firmware
> +      search path. If this property shows up in a live device tree it indicates
> +      that the FPGA has already been programmed with this image.
> +      If this property is in an overlay targeting an FPGA region, it is
> +      a request to program the FPGA with that image.
> +
> +  fpga-bridges:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Should contain a list of phandles to FPGA Bridges that must be
> +      controlled during FPGA programming along with the parent FPGA bridge.
> +      This property is optional if the FPGA Manager handles the bridges.
> +      If the fpga-region is  the child of an fpga-bridge, the list should not
> +      contain the parent bridge.
> +
> +  fpga-mgr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Should contain a phandle to an FPGA Manager.  Child FPGA Regions
> +      inherit this property from their ancestor regions.  An fpga-mgr property
> +      in a region will override any inherited FPGA manager.
> +
> +  partial-fpga-config:
> +    type: boolean
> +    description:
> +      Set if partial reconfiguration is to be done, otherwise full
> +      reconfiguration is done.
> +
> +  region-freeze-timeout-us:
> +    description:
> +      The maximum time in microseconds to wait for bridges to successfully
> +      become disabled before the region has been programmed.
> +
> +  region-unfreeze-timeout-us:
> +    description:
> +      The maximum time in microseconds to wait for bridges to successfully
> +      become enabled after the region has been programmed.
> +
> +patternProperties:
> +  "@(0|[1-9a-f][0-9a-f]*)$":
> +    type: object

You put (0|[...) to disallow @0001? I personally would not care, dtc
handles this, and the pattern is confusing. Just @[0-9a-z]+$

> +
> +  "^[^@]+$": true

I dislike it. How is this binding supposed to be used? If in standalone
way, then you allow any property so what's the point of this schema? If
fpga-bridge.yaml is referenced by other device-specific binding, then
all properties will be evaluated here, so the same: you allow any property.

Depending on the usage, this might be just like other generic, common
schemas, so end with "additionalPropeties: true".


> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - fpga-mgr
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    /*
> +     * Full Reconfiguration without Bridges with DT overlay
> +     */
> +    fpga_mgr0: fpga-mgr@f8007000 {
> +      compatible = "xlnx,zynq-devcfg-1.0";
> +      reg = <0xf8007000 0x100>;
> +      clocks = <&clkc 12>;
> +      clock-names = "ref_clk";
> +      interrupt-parent = <&intc>;
> +      interrupts = <0 8 4>;
> +      syscon = <&slcr>;
> +    };

I suggest to drop this node. The contents does not really matter for the
bridge.

> +
> +    fpga_region0: fpga-region {
> +      compatible = "fpga-region";
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      fpga-mgr = <&fpga_mgr0>;
> +
> +      /* DT Overlay contains: &fpga_region0 */
> +      firmware-name = "zynq-gpio.bin";
> +      gpio@40000000 {
> +        compatible = "xlnx,xps-gpio-1.00.a";
> +        reg = <0x40000000 0x10000>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +      };
> +    };
> +
> +  - |
> +    /*
> +     * Partial reconfiguration with bridge
> +     */
> +    fpga_mgr1: fpga-mgr@f8007000 {
> +      compatible = "xlnx,zynq-devcfg-1.0";
> +      reg = <0xf8007000 0x100>;
> +      clocks = <&clkc 12>;
> +      clock-names = "ref_clk";
> +      interrupt-parent = <&intc>;
> +      interrupts = <0 8 4>;
> +      syscon = <&slcr>;
> +    };
> +
> +    fpga_bridge1: fpga-bridge@100000450 {
> +      compatible = "xlnx,pr-decoupler-1.00", "xlnx,pr-decoupler";
> +      reg = <0x10000045 0x10>;
> +      clocks = <&clkc 15>;
> +      clock-names = "aclk";
> +    };

Also drop both nodes.

> +
> +    fpga_region1: fpga-region {
> +      compatible = "fpga-region";
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      fpga-mgr = <&fpga_mgr1>;
> +      fpga-bridges = <&fpga_bridge1>;
> +      partial-fpga-config;
> +
> +      /* DT Overlay contains: &fpga_region1 */
> +      firmware-name = "zynq-gpio-partial.bin";
> +      clk100: clk100 {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <100000000>;
> +        bootph-all;
> +      };
> +      axi {
> +        compatible = "simple-bus";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +        gpio@40000000 {
> +          compatible = "xlnx,xps-gpio-1.00.a";
> +          reg = <0x40000000 0x10000>;
> +          #gpio-cells = <2>;
> +          gpio-controller;
> +          clocks = <&clk100>;
> +        };
> +      };
> +    };

Best regards,
Krzysztof


