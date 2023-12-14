Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D3F8129DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjLNH7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjLNH7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:59:33 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC913CF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:59:39 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9e9c2989dso105061531fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702540778; x=1703145578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n9wEnUDIRvKLyzOqX0O3tx30Tvjspr7MEcA9HRHm9qk=;
        b=PGqKjB11cnsez4TKVIE9XCSDSIWcs/diMkYEeVYu3nJupUISGrnSNXC7rONfLCrnVu
         Yy8AH1T8x10lgUeHHG+JnXK+HCoW7LrIja/9COwD3tidKDjr6Ann02/lqUPoaV2GIlDe
         CN0PCHETk/AUlZy/4QW1lMQLlvf96GWKmhKNNkNpNrVX9P6zF355YHNjhDx/4eJCWkvF
         70/tKn3Tf3ORrywuqL7+4gE5pLs3qfezvgj1DaeO+mdgMUimipeCVKV3ObbZYFWDCDrM
         Rn64CZ0toDo6smKpUY0fTQHe1mHczt09aKhPKMBb3s4SGwc1ML4KwqktyBwm0PHfLCsN
         RkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702540778; x=1703145578;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9wEnUDIRvKLyzOqX0O3tx30Tvjspr7MEcA9HRHm9qk=;
        b=q/K52e5nzo7hhu4H9Mu4RyiL1O4OYKseDETB44PYLKfc9/29DQep089vU6B04aQuG4
         jnmEBz3VkJUYpwncKRQPbVFszkWctcwV3ioMO35SwdEWTWhaznf6Be/RWHU2WwmbGom1
         pT65/0LapBjvJAEDR+T8mY/jclmOCKfPBX8Kh8iXSKNcUxKWuwWINBS8aRQe8mi4uX6R
         GPcYRzOef2Rrlod3hwyWpnK0xJHjiNk3pIyixzt4yn5Fc+CzGh/tnv2+pgMaEEDUbYDo
         ng8GTiH8J+68rkDhKXLaVHaqHV17XAKAuuRxTBojWBava7O/ewXwBdna6Hu6BhJbHHAO
         zvjQ==
X-Gm-Message-State: AOJu0YzrajdPPa1kz4hoP2Nyk6NWdGXjtMVawrYOU2y8pe5qBXCDfAa1
        wlmbPn8QvTaXZw3aRZIYwaidMQ==
X-Google-Smtp-Source: AGHT+IEe1lSgOXPocDgp9kCh/V3KjoKfM051nF7MsjqFJM+J46Ouy4zBpfOW7arvRyUz2R2cq6bW8Q==
X-Received: by 2002:ac2:51b0:0:b0:50b:fd52:e629 with SMTP id f16-20020ac251b0000000b0050bfd52e629mr3702789lfk.125.1702540777832;
        Wed, 13 Dec 2023 23:59:37 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id rm6-20020a1709076b0600b00a1f6f120b33sm8476917ejc.110.2023.12.13.23.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 23:59:37 -0800 (PST)
Message-ID: <ada0b523-d0a9-405b-a7f3-d4d58c6a6696@linaro.org>
Date:   Thu, 14 Dec 2023 08:59:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] soc: nuvoton: add NPCM BPC driver
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, arnd@arndb.de,
        pmenzel@molgen.mpg.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        j.neuschaefer@gmx.net
Cc:     openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213190528.3751583-1-tmaimon77@gmail.com>
 <20231213190528.3751583-4-tmaimon77@gmail.com>
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
In-Reply-To: <20231213190528.3751583-4-tmaimon77@gmail.com>
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

On 13/12/2023 20:05, Tomer Maimon wrote:
> Add Nuvoton BMC NPCM BIOS post code (BPC) driver.
> 
> The NPCM BPC monitoring two configurable I/O address written by the host
> on the bus.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  drivers/soc/nuvoton/Kconfig    |   9 +
>  drivers/soc/nuvoton/Makefile   |   1 +
>  drivers/soc/nuvoton/npcm-bpc.c | 387 +++++++++++++++++++++++++++++++++
>  3 files changed, 397 insertions(+)
>  create mode 100644 drivers/soc/nuvoton/npcm-bpc.c
> 
> diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
> index d5102f5f0c28..ebd162633942 100644
> --- a/drivers/soc/nuvoton/Kconfig
> +++ b/drivers/soc/nuvoton/Kconfig
> @@ -2,6 +2,15 @@
>  
>  menu "NUVOTON SoC drivers"

...

> +
> +static int npcm_bpc_config_irq(struct npcm_bpc *bpc,
> +			       struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int rc;
> +
> +	bpc->irq = platform_get_irq(pdev, 0);
> +	if (bpc->irq < 0) {
> +		dev_err(dev, "get IRQ failed\n");
> +		return bpc->irq;

return dev_err_probe

> +	}
> +
> +	rc = devm_request_irq(dev, bpc->irq,
> +			      npcm_bpc_irq, IRQF_SHARED,
> +			      DEVICE_NAME, bpc);
> +	if (rc < 0) {
> +		dev_warn(dev, "Unable to request IRQ %d\n", bpc->irq);

return dev_err_probe

> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int npcm_enable_bpc(struct npcm_bpc *bpc, struct device *dev,
> +			   int channel, u16 host_port)
> +{
> +	u8 addr_en, reg_en;
> +	int err;
> +
> +	init_waitqueue_head(&bpc->ch[channel].wq);
> +
> +	err = kfifo_alloc(&bpc->ch[channel].fifo, BPC_KFIFO_SIZE,
> +			  GFP_KERNEL);
> +	if (err)
> +		return err;
> +
> +	bpc->ch[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
> +	bpc->ch[channel].miscdev.name =
> +		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
> +	bpc->ch[channel].miscdev.fops = &npcm_bpc_fops;
> +	bpc->ch[channel].miscdev.parent = dev;
> +	err = misc_register(&bpc->ch[channel].miscdev);
> +	if (err)
> +		return err;
> +
> +	bpc->ch[channel].data = bpc;
> +	bpc->ch[channel].host_reset = false;
> +
> +	/* Enable host snoop channel at requested port */
> +	switch (channel) {
> +	case 0:
> +		addr_en = FIFO_IOADDR1_ENABLE;
> +		iowrite8((u8)host_port & 0xFF,
> +			 bpc->base + NPCM_BPCFA1L_REG);
> +		iowrite8((u8)(host_port >> 8),
> +			 bpc->base + NPCM_BPCFA1M_REG);
> +		break;
> +	case 1:
> +		addr_en = FIFO_IOADDR2_ENABLE;
> +		iowrite8((u8)host_port & 0xFF,
> +			 bpc->base + NPCM_BPCFA2L_REG);
> +		iowrite8((u8)(host_port >> 8),
> +			 bpc->base + NPCM_BPCFA2M_REG);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (bpc->en_dwcap)
> +		addr_en = FIFO_DWCAPTURE;
> +
> +	/*
> +	 * Enable FIFO Ready Interrupt, FIFO Capture of I/O addr,
> +	 * and Host Reset
> +	 */
> +	reg_en = ioread8(bpc->base + NPCM_BPCFEN_REG);
> +	iowrite8(reg_en | addr_en | FIFO_READY_INT_ENABLE |
> +		 HOST_RESET_INT_ENABLE, bpc->base + NPCM_BPCFEN_REG);
> +
> +	return 0;
> +}
> +
> +static void npcm_disable_bpc(struct npcm_bpc *bpc, int channel)
> +{
> +	u8 reg_en;
> +
> +	switch (channel) {
> +	case 0:
> +		reg_en = ioread8(bpc->base + NPCM_BPCFEN_REG);
> +		if (bpc->en_dwcap)
> +			iowrite8(reg_en & ~FIFO_DWCAPTURE,
> +				 bpc->base + NPCM_BPCFEN_REG);
> +		else
> +			iowrite8(reg_en & ~FIFO_IOADDR1_ENABLE,
> +				 bpc->base + NPCM_BPCFEN_REG);
> +		break;
> +	case 1:
> +		reg_en = ioread8(bpc->base + NPCM_BPCFEN_REG);
> +		iowrite8(reg_en & ~FIFO_IOADDR2_ENABLE,
> +			 bpc->base + NPCM_BPCFEN_REG);
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	if (!(reg_en & (FIFO_IOADDR1_ENABLE | FIFO_IOADDR2_ENABLE)))
> +		iowrite8(reg_en &
> +			 ~(FIFO_READY_INT_ENABLE | HOST_RESET_INT_ENABLE),
> +			 bpc->base + NPCM_BPCFEN_REG);
> +
> +	kfifo_free(&bpc->ch[channel].fifo);
> +	misc_deregister(&bpc->ch[channel].miscdev);
> +}
> +
> +static int npcm_bpc_probe(struct platform_device *pdev)
> +{
> +	struct npcm_bpc *bpc;
> +	struct device *dev;
> +	u32 port;
> +	int err;
> +
> +	dev = &pdev->dev;
> +
> +	bpc = devm_kzalloc(dev, sizeof(*bpc), GFP_KERNEL);
> +	if (!bpc)
> +		return -ENOMEM;
> +
> +	bpc->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(bpc->base))
> +		return PTR_ERR(bpc->base);
> +
> +	dev_set_drvdata(&pdev->dev, bpc);

Why do you use pdev again? Look earlier, you have local variable for this.

> +
> +	err = of_property_read_u32_index(dev->of_node, "nuvoton,monitor-ports",
> +					 0, &port);
> +	if (err) {
> +		dev_err(dev, "no monitor ports configured\n");
> +		return -ENODEV;
> +	}
> +
> +	bpc->en_dwcap =
> +		of_property_read_bool(dev->of_node, "nuvoton,bpc-en-dwcapture");
> +
> +	bpc->dev = dev;
> +
> +	err = npcm_bpc_config_irq(bpc, pdev);
> +	if (err)
> +		return err;
> +
> +	err = npcm_enable_bpc(bpc, dev, 0, port);
> +	if (err) {
> +		dev_err(dev, "Enable BIOS post code I/O port 0 failed\n");
> +		return err;
> +	}
> +
> +	/*
> +	 * Configuration of second BPC channel port is optional
> +	 * Double-Word Capture ignoring address 2
> +	 */
> +	if (!bpc->en_dwcap) {
> +		if (of_property_read_u32_index(dev->of_node,
> +					       "nuvoton,monitor-ports", 1,
> +					       &port) == 0) {
> +			err = npcm_enable_bpc(bpc, dev, 1, port);
> +			if (err) {
> +				dev_err(dev, "Enable BIOS post code I/O port 1 failed, disable I/O port 0\n");
> +				npcm_disable_bpc(bpc, 0);
> +				return err;
> +			}
> +		}
> +	}
> +
> +	pr_info("NPCM BIOS Post Code probe\n");

Drop

> +
> +	return err;
> +}
> +
> +static int npcm_bpc_remove(struct platform_device *pdev)
> +{
> +	struct npcm_bpc *bpc = dev_get_drvdata(&pdev->dev);
> +	u8 reg_en;
> +
> +	reg_en = ioread8(bpc->base + NPCM_BPCFEN_REG);
> +
> +	if (reg_en & FIFO_IOADDR1_ENABLE)
> +		npcm_disable_bpc(bpc, 0);
> +	if (reg_en & FIFO_IOADDR2_ENABLE)
> +		npcm_disable_bpc(bpc, 1);
> +

Best regards,
Krzysztof

