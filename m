Return-Path: <linux-kernel+bounces-12015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820A581EEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 497B1B20D63
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236A244C76;
	Wed, 27 Dec 2023 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYee9cWR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2444C6E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33678156e27so4816648f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 04:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703680511; x=1704285311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=epGZ+q6UP32u7muTF0woV3dsSCz73pHRzHknNCbCjuk=;
        b=NYee9cWRFPvsEpx0dF5LnheMrt8B/W4GJ4PMZuBgyx1tvM6mkncvmzEfVc/6Af3lsy
         HU24YMFOOWLczA068ikGJ2ov7XYhxLMq+ZrV3qFtmgWG53NSEnYCOLTjMDf3EOw967EB
         9luacZZIPIUMTezcKQdbNv3XYw8kH2Rt0b5HzLkrCQ7818+eUgTEK72pJeckSL58j2t+
         T5uxsMncSBfIOAWDig3h9MLQ/DiWAzGzXE7zyPFvtUGnn/I2dz2sJOIDKo3rlTTbdPz1
         ThAOmW65oVuwT1vPd2pqnew2nA//zOi+4Veuj/tEqf7FSNHQwroLeDneoCv4djPJ9Sko
         Go+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703680511; x=1704285311;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=epGZ+q6UP32u7muTF0woV3dsSCz73pHRzHknNCbCjuk=;
        b=O1UK3+v/pfN4tWNHvLDxc9DOIfwvCxSRT9dKTzhFxTYzyOmG7wXVOk1uMlPB3vplD9
         qEAUzF9AdyC1+MUM2hmUziDgbIZ0R/4VyDg20Vx0kctT1IHKjNoMEGY0ht5790Ql9pBt
         rosVoAg9dIKpJzKlIX0ZkWeqwIemHWzxsEtezQy2Kayy4T3nxUpkU6ufjDd/o3aGo2PP
         6mt4Wo7Q/pvprCxWazwokqinBAIX+uhwMCF1JyzmzLYJPdxdHCeCXcmgPsitY8d8Xv9F
         ZYc33S4I4S+0Tfu7uVr1DQtDp6OosE9q6h1vTeKoJyggc4AhpMfVhWYc4lcUhn9jlB4f
         uL7g==
X-Gm-Message-State: AOJu0Yxn74ub2ZVidOrM/tc4AOqDee3to3bqsMBETZvdLI20JtD3z89N
	rVlrQFOVRKW2c4UADWyeF91TCMnFMSs3pQ==
X-Google-Smtp-Source: AGHT+IH2LTK8BtQpyT3te/10HSe9eiLkrR1TeIv9Jc4wR6leMJ4eWm8bv8fbJ+b0b7TPx4oZzw5Xgg==
X-Received: by 2002:a5d:5404:0:b0:336:1aef:7352 with SMTP id g4-20020a5d5404000000b003361aef7352mr5001123wrv.109.1703680510694;
        Wed, 27 Dec 2023 04:35:10 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d49d2000000b00336751cd4ebsm14772953wrs.72.2023.12.27.04.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 04:35:09 -0800 (PST)
Message-ID: <e9bcea6e-922c-4903-996f-1677e6eb6e1e@linaro.org>
Date: Wed, 27 Dec 2023 13:35:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] reset: instantiate reset GPIO controller for shared
 reset-gpios
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sean Anderson <sean.anderson@seco.com>
References: <20231222150133.732662-1-krzysztof.kozlowski@linaro.org>
 <20231222150133.732662-2-krzysztof.kozlowski@linaro.org>
 <CAMRc=MdYPuW8C_+EAY4UTCjqNggx6RAkp9OmLU-hRxjZNRQRHw@mail.gmail.com>
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
In-Reply-To: <CAMRc=MdYPuW8C_+EAY4UTCjqNggx6RAkp9OmLU-hRxjZNRQRHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/12/2023 18:31, Bartosz Golaszewski wrote:
>>
>> +static int __reset_add_reset_gpio_device(struct device_node *node,
>> +                                        const struct gpio_desc **out)
>> +{
>> +       struct platform_device *pdev;
>> +       int gpio;
>> +
>> +       /* Don't care about deprecated '-gpio' suffix. */
>> +       gpio = of_get_named_gpio(node, "reset-gpios", 0);
> 
> Sorry but NAK. This is a legacy API, we've managed to remove all of_

No worries, I expected problems with this patchset. I should have title
it RFC.

> GPIO interfaces but this one. Please don't use it. Any function that
> deals with the global GPIO numberspace is deprecated. See below how I
> would approach it.
> 
> Side note: do we have any formal way of deprecating interfaces in the kernel?

"DEPRECATED" message in kerneldoc would be enough for me. This could be
later used by tooling like checkpatch/sparse/toolchains.


> 
>> +       if (!gpio_is_valid(gpio))
>> +               return gpio;
>> +
>> +       pdev = platform_device_register_data(NULL, "reset-gpio",
>> +                                            PLATFORM_DEVID_AUTO, &node,
>> +                                            sizeof(node));
> 
> You seem to make an assumption (in __reset_find_rcdev()) that this
> device will get bound to its driver before this function returns.
> There is no such guarantee. There are many situations where this may
> not happen immediately (think loading the reset-gpio driver as a
> module from the filesystem). You should set up a notifier callback on

Yeah, this code is poor. In the case you mentioned, requesting a reset
line would spawn multiple platform devices of which none would bind.

> the platform bus that will get invoked on bus events and wait for this
> device's BUS_NOTIFY_BOUND_DRIVER event.

Hm, good point. Thanks.


> 
>> +       if (!IS_ERR(pdev))
>> +               *out = gpio_to_desc(gpio);
>> +
>> +       return PTR_ERR_OR_ZERO(pdev);
>> +}
>> +
>> +static struct reset_controller_dev *__reset_find_rcdev(const struct of_phandle_args *args,
>> +                                                      const void *cookie)
>> +{
>> +       struct reset_controller_dev *r, *rcdev;
>> +
>> +       lockdep_assert_held(&reset_list_mutex);
>> +
>> +       rcdev = NULL;
>> +       list_for_each_entry(r, &reset_controller_list, list) {
>> +               if (args && args->np) {
>> +                       if (args->np == r->of_node) {
>> +                               rcdev = r;
>> +                               break;
>> +                       }
>> +               } else if (cookie) {
>> +                       if (cookie == r->cookie) {
> 
> As I said in private: there's no guarantee that the same GPIO
> descriptor will always reference the same GPIO line. It happens to be
> the case currently but it's an implementation detail.

I guess you commented on this further, so I will reply there.

> 
>> +                               rcdev = r;
>> +                               break;
>> +                       }
>> +               }
>> +       }
>> +
>> +       return rcdev;
>> +}
>> +
>>  struct reset_control *
>>  __of_reset_control_get(struct device_node *node, const char *id, int index,
>>                        bool shared, bool optional, bool acquired)
>>  {
>> +       const struct gpio_desc *gpio = NULL;
>> +       struct of_phandle_args args = {0};
>>         struct reset_control *rstc;
>> -       struct reset_controller_dev *r, *rcdev;
>> -       struct of_phandle_args args;
>> +       struct reset_controller_dev *rcdev;
>>         int rstc_id;
>>         int ret;
>>
>> @@ -839,17 +888,16 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
>>                                          index, &args);
>>         if (ret == -EINVAL)
>>                 return ERR_PTR(ret);
>> -       if (ret)
>> -               return optional ? NULL : ERR_PTR(ret);
>> +       if (ret) {
>> +               ret = __reset_add_reset_gpio_device(node, &gpio);
>> +               if (ret)
>> +                       return optional ? NULL : ERR_PTR(ret);
>> +
>> +               args.args_count = 1; /* reset-gpio has only one reset line */
>> +       }
>>
>>         mutex_lock(&reset_list_mutex);
>> -       rcdev = NULL;
>> -       list_for_each_entry(r, &reset_controller_list, list) {
>> -               if (args.np == r->of_node) {
>> -                       rcdev = r;
>> -                       break;
>> -               }
>> -       }
>> +       rcdev = __reset_find_rcdev(&args, gpio);
>>
>>         if (!rcdev) {
>>                 rstc = ERR_PTR(-EPROBE_DEFER);
>> diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
>> index 0fa4f60e1186..c0a99a8ea29e 100644
>> --- a/include/linux/reset-controller.h
>> +++ b/include/linux/reset-controller.h
>> @@ -61,6 +61,7 @@ struct reset_control_lookup {
>>   * @dev: corresponding driver model device struct
>>   * @of_node: corresponding device tree node as phandle target
>>   * @of_reset_n_cells: number of cells in reset line specifiers
>> + * @cookie: for reset-gpios controllers: corresponding GPIO instead of of_node
>>   * @of_xlate: translation function to translate from specifier as found in the
>>   *            device tree to id as given to the reset control ops, defaults
>>   *            to :c:func:`of_reset_simple_xlate`.
>> @@ -74,6 +75,7 @@ struct reset_controller_dev {
>>         struct device *dev;
>>         struct device_node *of_node;
>>         int of_reset_n_cells;
>> +       const void *cookie;
>>         int (*of_xlate)(struct reset_controller_dev *rcdev,
>>                         const struct of_phandle_args *reset_spec);
>>         unsigned int nr_resets;
>> --
>> 2.34.1
>>
> 
> I dislike this approach entirely. Here's what I would do:
> 
> In the reset core: parse the phandle of the reset-gpios property. Use
> the resulting node with gpio_device_find_by_fwnode(). If the device is
> not up yet, defer probe. You'll now have the GPIO device object.
> Retrieve its label using gpio_device_get_label(). Now you should have
> everything you need (the offset and flags of the GPIO you'll get from
> __of_parse_phandle_with_args()) to set up the lookup tables. See

I don't get exactly what do you want to use as the cookie for lookup
reset controller?
1. GPIO controller node? No way, not enough
2. GPIO label?
3. Or some combination of above? This would work, I guess, a bit more
complicated cookie than just one pointer/unsigned long.

> include/linux/gpio/machine.h. An example of that would be in:
> bcm2835_spi_setup() in drivers/spi/spi-bcm2835.c.
> 
> Then with a lookup table in place, you instantiate your device and
> it'll get its GPIO as it should. This is not ideal but much better
> than the above.


Best regards,
Krzysztof


