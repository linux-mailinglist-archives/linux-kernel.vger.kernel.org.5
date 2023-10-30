Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EF67DB47E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjJ3Hje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjJ3Hjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:39:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C760BA7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:39:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c3c8adb27so611547366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698651567; x=1699256367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=un1B+HdCY4rb6l+yNfK1fdIrKdS9fURStbp/Gin4628=;
        b=YL2zWM4SBRfjz3WDVAlK3i7bukpWyy3ZEoNjHVJ9YmlQTcmbFy8e+JyBxByeeL8Oc0
         9uWqvtODjE+W4++cgVXuyyHX7+pC9aeWKaGMtZMxSU8XKvTNW3OKdHaYIQ0yXbxLjsqg
         B1Fv1XdR2RhYblU/vZriE1JqNR/yNST59hvFcZDn5ELne8yI76wUbCYf133+KCppuXQ9
         il3Ornc1Bxg6N1Fe8GQk5PO7g69ojqsZhUQhIc4KVATSOSoZboT4jRh02jFa5gnnOD0O
         oLrL/Oc4LdaFSXMGXsEMmMuhwqxvTyp8e/XrLLWwSe8EWsz92Doh+hoNcsAiujvorvEd
         ngIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698651567; x=1699256367;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=un1B+HdCY4rb6l+yNfK1fdIrKdS9fURStbp/Gin4628=;
        b=EYnDv2y8t0ea5lbSHgK9v3agfMEB8uWra46Te6f94EKZYZxWqvAHFTO3Buq1fQGStZ
         csHuYs/PoYUXh16B1frxykZYuuBY2akbE0JffuVjkKUyFfTHD5aW702ztKzPy9bfWLrd
         tD+yJR16urvMJo9F8Q9UGKEhPliciXOIhql2TQZLxKrUxGEpG2Gg8fpF78OeucDiK26u
         2LllcIhx67It/LeaG/IMqxPg+VKdihjg429763Cr9CfKO2/Tb6SDb5vY7o0avyAsAmc9
         Lu/pRRSi9JC2SIQAd1Z0hkOEvgzzNMW+so4J+yS1z9kAz9Aql3wTXjoOsYrqRXzcUmI+
         KMpw==
X-Gm-Message-State: AOJu0YzLrxdr4m2c1S6PJbswZWRouy0CWT2Gp73irOX4ksvaaj7W5OD5
        7fmo4sKRWSRRWQzVpdiM71B+ow==
X-Google-Smtp-Source: AGHT+IF8Ef++OJHXVJllrD3R72IaUiIgCv3FiU91UCPPrjv6o6Nke2xQzDc/J+zev/lhkV/+SQoJDw==
X-Received: by 2002:a17:907:2910:b0:9be:51ce:e91b with SMTP id eq16-20020a170907291000b009be51cee91bmr5536966ejc.68.1698651567082;
        Mon, 30 Oct 2023 00:39:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id x22-20020a170906149600b009b2b47cd757sm5490088ejc.9.2023.10.30.00.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 00:39:26 -0700 (PDT)
Message-ID: <baf6a0c3-e76a-4d9d-8866-b3f4fdae162e@linaro.org>
Date:   Mon, 30 Oct 2023 08:39:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
Content-Language: en-US
To:     Jyan Chou <jyanchou@realtek.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, jh80.chung@samsung.com,
        riteshh@codeaurora.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        asutoshd@codeaurora.org, p.zabel@pengutronix.de
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        briannorris@chromium.org, doug@schmorgal.com,
        tonyhuang.sunplus@gmail.com, abel.vesa@linaro.org,
        william.qiu@starfivetech.com
References: <20231030062749.2840-1-jyanchou@realtek.com>
 <20231030062749.2840-3-jyanchou@realtek.com>
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
In-Reply-To: <20231030062749.2840-3-jyanchou@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2023 07:27, Jyan Chou wrote:
> We implemented cmdq feature on Synopsys DesignWare mmc driver.
> The difference between dw_mmc.c and dw_mmc_cqe.c were distinct
> register definitions, mmc user flow and the addition of cmdq.
> 
> New version of User Guide had modify mmc driver's usage flow,
> we may need to renew code to precisely follow user guide.
> 
> More over, We added a wait status function to satisfy synopsys
> user guide's description, since this flow might be specific in
> synopsys host driver only.
> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> 
> —--
> v3 -> v4:
> - Modify dma mode selection and dma addressing bit to statisfy
>   linux coding style.
> 

I asked to fix several coding style issues so it will look a bit as
matching Linux coding style. I don't see improvements.

Please read carefully, more than once, the Linux coding style. Then
document in changelog what you fixed. If you document nothing, means you
ignored the feedback.

Fix every warning from checkpatch --strict. Then document in changelog
what you fixed. If you document nothing, means you ignored the feedback.

> +
> +	if (!host->bus_hz) {
> +		dev_err(host->dev,
> +			"Platform data must supply bus speed\n");
> +		ret = -ENODEV;
> +		goto err_clk_ciu;
> +	}
> +
> +	if (!IS_ERR(host->pdata->rstc)) {
> +		reset_control_assert(host->pdata->rstc);
> +		usleep_range(10, 50);
> +		reset_control_deassert(host->pdata->rstc);
> +	}
> +
> +	timer_setup(&host->timer, dw_mci_cqe_cto_timer, 0);
> +
> +	spin_lock_init(&host->lock);
> +	spin_lock_init(&host->irq_lock);
> +	init_rwsem(&host->cr_rw_sem);
> +	tasklet_init(&host->tasklet, dw_mci_cqe_tasklet_func, (unsigned long)host);
> +
> +	/*pio mode's parameters should be initialized here*/

Nothing improved.

> +
> +	/*Initialize the eMMC IP related attribute*/
> +	dw_mci_cqe_setup(host);
> +
> +	dw_mci_cqe_init_dma(host);
> +
> +	/* This flag will be set 1 when doing tuning,

Nothing improved.

> +	 * we add this flag because
> +	 * some vendors might use other cmd instead of 21
> +	 * to tune phase under high speed interface.
> +	 * we use this flag to recognize if the system is under tuning stage.
> +	 */
> +	host->tuning = 0;
> +
> +	/*Timing_setting is to avoid sending command

Nothing improved.

> +	 *before setting phase in hs200, hs400
> +	 */
> +	host->current_speed = 0;
> +
> +	/*Do the rest of init for specific*/
> +	if (drv_data && drv_data->init) {
> +		ret = drv_data->init(host);
> +		if (ret) {
> +			dev_err(host->dev,
> +				"implementation specific init failed\n");
> +			goto err_dmaunmap;
> +		}
> +	}
> +
> +	ret = dw_mci_cqe_init_slot(host);
> +	if (ret) {
> +		dev_err(host->dev, "slot 0 init failed\n");
> +		goto err_dmaunmap;
> +	}
> +
> +	ret = devm_request_irq(host->dev, host->irq, dw_mci_cqe_interrupt,
> +			       host->irq_flags, "dw-mci-cqe", host);
> +	if (ret)
> +		goto err_dmaunmap;
> +
> +	/*After the slot initialization,

Nothing improved.

> +	 *now we have mmc data and can initialize cmdq if user enabled
> +	 */
> +	dw_mci_cqhci_init(host);
> +
> +	return 0;
> +
> +err_dmaunmap:
> +	if (!IS_ERR(host->pdata->rstc))
> +		reset_control_assert(host->pdata->rstc);
> +err_clk_ciu:
> +	clk_disable_unprepare(host->ciu_clk);
> +
> +err_clk_biu:
> +	clk_disable_unprepare(host->biu_clk);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(dw_mci_cqe_probe);
> +
> +void dw_mci_cqe_remove(struct dw_mci *host)
> +{
> +	dev_dbg(host->dev, "remove slot\n");

Nothing improved.

> +	if (host->slot)
> +		dw_mci_cqe_cleanup_slot(host->slot);
> +
> +	if (!IS_ERR(host->pdata->rstc))
> +		reset_control_assert(host->pdata->rstc);
> +
> +	clk_disable_unprepare(host->ciu_clk);
> +	clk_disable_unprepare(host->biu_clk);
> +}
> +EXPORT_SYMBOL(dw_mci_cqe_remove);
> +
> +#ifdef CONFIG_PM
> +int dw_mci_cqe_runtime_suspend(struct device *dev)
> +{
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
> +		if (host->slot) {
> +			dev_info(host->dev, "cqe suspend\n");

Nothing improved.

> +			ret = cqhci_suspend(host->slot->mmc);
> +			if (ret) {
> +				dev_err(host->dev, "cqe suspend failed\n");

Nothing improved.

> +				return ret;
> +			}
> +		}
> +	}
> +
> +	clk_disable_unprepare(host->ciu_clk);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(dw_mci_cqe_runtime_suspend);
> +
> +int dw_mci_cqe_runtime_resume(struct device *dev)
> +{
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +	int ret = 0;
> +
> +	clk_prepare_enable(host->ciu_clk);
> +
> +	dw_mci_cqe_setup(host);
> +	if (drv_data && drv_data->init) {
> +		ret = drv_data->init(host);
> +		if (ret)
> +			dev_err(host->dev, "implementation specific init failed\n");
> +	}
> +
> +	init_completion(host->int_waiting);
> +
> +	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
> +		if (host->slot) {
> +			dev_info(host->dev, "cqe resume\n");
> +			ret = cqhci_resume(host->slot->mmc);
> +			if (ret)
> +				dev_err(host->dev, "cqe resume failed\n");


Nothing improved.

> +		}
> +	}
> +
> +	dw_mci_cqe_setup_bus(host->slot, true);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(dw_mci_cqe_runtime_resume);
> +#endif /* CONFIG_PM */
> +
> +static int __init dw_mci_cqe_init(void)
> +{
> +	pr_info("Synopsys Designware Multimedia Card Interface Driver\n");


Nothing improved.

> +	return 0;
> +}
> +
> +static void __exit dw_mci_cqe_exit(void)
> +{
> +}
> +
> +module_init(dw_mci_cqe_init);
> +module_exit(dw_mci_cqe_exit);

This part of code is just useless.

Best regards,
Krzysztof

