Return-Path: <linux-kernel+bounces-96423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1F3875BE8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6735B214A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828C3224F0;
	Fri,  8 Mar 2024 01:14:30 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177C0224CC;
	Fri,  8 Mar 2024 01:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709860469; cv=none; b=ljxcEZjygLX3RAMLBylzCfXoW1R1EiiHsc/hGyhY9ogpNjrBxOMeAG1eaS/qH+Oj0bti0t3yIwN73BeIVpupuKVnuYspU2niFfCc42lnDLeELHPE4aX5odvQq+NqGAeVTZWG+QdaYD4AaIsvybXsMcA3nHNaCmjY9TB8BU0bcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709860469; c=relaxed/simple;
	bh=6DLoLRfIvnW++px44Y/21mjPNbxrYAB9FR08pnzPg/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdGokzCMPlpO2DIAzvZKiwoCn7Nkc/gtPdYlPjYkIBTX6o2GI9z0v2p0aJ9uwcChlXteHFeqnfUaNgSrbmaLYtSo1p7hdm5puNuKXFWt7BQU6xzhGhCMiGxCS2/g29E+ZOAc/9iRs54ThoTrN/1XqyCvRRXMKiRqU83tjHEWS2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8BxyuhvZuplFiMWAA--.35104S3;
	Fri, 08 Mar 2024 09:14:23 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx7c5qZuplEMpQAA--.18370S3;
	Fri, 08 Mar 2024 09:14:19 +0800 (CST)
Message-ID: <18a69517-9796-476b-973e-291319e121ce@loongson.cn>
Date: Fri, 8 Mar 2024 09:14:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] gpiolib: legacy: Remove unused
 gpio_request_array() and gpio_free_array()
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Corbet <corbet@lwn.net>,
 Alex Shi <alexs@kernel.org>, Hu Haowen <2023002089@link.tyut.edu.cn>,
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
References: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com>
 <20240307135109.3778316-4-andriy.shevchenko@linux.intel.com>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240307135109.3778316-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx7c5qZuplEMpQAA--.18370S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxKFWfuw4xtry3uFy3Gr18CrX_yoW3Gr1fpF
	sxtF4SyayUXa4DKryDJay7C3W7K39rXr13C3yak3yrZFn0y3sYvF4DtFy8XFyayrWkAF4x
	JFZ5Wr98JFyqvFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	kF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
	MxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0L0ePUUUUU==


在 2024/3/7 21:49, Andy Shevchenko 写道:
> No more users.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   Documentation/driver-api/gpio/legacy.rst      | 16 --------
>   .../zh_CN/driver-api/gpio/legacy.rst          | 16 --------

For Chinese:


Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng

>   Documentation/translations/zh_TW/gpio.txt     | 17 --------
>   drivers/gpio/gpiolib-legacy.c                 | 39 -------------------
>   include/linux/gpio.h                          | 15 -------
>   5 files changed, 103 deletions(-)
>
> diff --git a/Documentation/driver-api/gpio/legacy.rst b/Documentation/driver-api/gpio/legacy.rst
> index b6505914791c..534dfe95d128 100644
> --- a/Documentation/driver-api/gpio/legacy.rst
> +++ b/Documentation/driver-api/gpio/legacy.rst
> @@ -225,8 +225,6 @@ setup or driver probe/teardown code, so this is an easy constraint.)::
>                   gpio_request()
>   
>           ## 	gpio_request_one()
> -        ##	gpio_request_array()
> -        ## 	gpio_free_array()
>   
>                   gpio_free()
>   
> @@ -295,14 +293,6 @@ are claimed, three additional calls are defined::
>   	 */
>   	int gpio_request_one(unsigned gpio, unsigned long flags, const char *label);
>   
> -	/* request multiple GPIOs in a single call
> -	 */
> -	int gpio_request_array(struct gpio *array, size_t num);
> -
> -	/* release multiple GPIOs in a single call
> -	 */
> -	void gpio_free_array(struct gpio *array, size_t num);
> -
>   where 'flags' is currently defined to specify the following properties:
>   
>   	* GPIOF_DIR_IN		- to configure direction as input
> @@ -341,12 +331,6 @@ A typical example of usage::
>   	if (err)
>   		...
>   
> -	err = gpio_request_array(leds_gpios, ARRAY_SIZE(leds_gpios));
> -	if (err)
> -		...
> -
> -	gpio_free_array(leds_gpios, ARRAY_SIZE(leds_gpios));
> -
>   
>   GPIOs mapped to IRQs
>   --------------------
> diff --git a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
> index aeccff777170..0faf042001d2 100644
> --- a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
> +++ b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
> @@ -208,8 +208,6 @@ GPIO 值的命令需要等待其信息排到队首才发送命令，再获得其
>                   gpio_request()
>   
>           ## 	gpio_request_one()
> -        ##	gpio_request_array()
> -        ## 	gpio_free_array()
>   
>                   gpio_free()
>   
> @@ -272,14 +270,6 @@ gpio_request()前将这类细节配置好，例如使用引脚控制子系统的
>   	 */
>   	int gpio_request_one(unsigned gpio, unsigned long flags, const char *label);
>   
> -	/* 在单个函数中申请多个 GPIO
> -	 */
> -	int gpio_request_array(struct gpio *array, size_t num);
> -
> -	/* 在单个函数中释放多个 GPIO
> -	 */
> -	void gpio_free_array(struct gpio *array, size_t num);
> -
>   这里 'flags' 当前定义可指定以下属性:
>   
>   	* GPIOF_DIR_IN		- 配置方向为输入
> @@ -317,12 +307,6 @@ gpio_request()前将这类细节配置好，例如使用引脚控制子系统的
>   	if (err)
>   		...
>   
> -	err = gpio_request_array(leds_gpios, ARRAY_SIZE(leds_gpios));
> -	if (err)
> -		...
> -
> -	gpio_free_array(leds_gpios, ARRAY_SIZE(leds_gpios));
> -
>   
>   GPIO 映射到 IRQ
>   ----------------
> diff --git a/Documentation/translations/zh_TW/gpio.txt b/Documentation/translations/zh_TW/gpio.txt
> index b9b48012c62e..77d69d381316 100644
> --- a/Documentation/translations/zh_TW/gpio.txt
> +++ b/Documentation/translations/zh_TW/gpio.txt
> @@ -215,13 +215,10 @@ GPIO 值的命令需要等待其信息排到隊首才發送命令，再獲得其
>   	gpio_request()
>   
>   ## 	gpio_request_one()
> -##	gpio_request_array()
> -## 	gpio_free_array()
>   
>   	gpio_free()
>   
>   
> -
>   聲明和釋放 GPIO
>   ----------------------------
>   爲了有助於捕獲系統配置錯誤,定義了兩個函數。
> @@ -278,14 +275,6 @@ gpio_request()前將這類細節配置好，例如使用 pinctrl 子系統的映
>   	 */
>   	int gpio_request_one(unsigned gpio, unsigned long flags, const char *label);
>   
> -	/* 在單個函數中申請多個 GPIO
> -	 */
> -	int gpio_request_array(struct gpio *array, size_t num);
> -
> -	/* 在單個函數中釋放多個 GPIO
> -	 */
> -	void gpio_free_array(struct gpio *array, size_t num);
> -
>   這裡 'flags' 當前定義可指定以下屬性:
>   
>   	* GPIOF_DIR_IN		- 配置方向爲輸入
> @@ -323,12 +312,6 @@ gpio_request()前將這類細節配置好，例如使用 pinctrl 子系統的映
>   	if (err)
>   		...
>   
> -	err = gpio_request_array(leds_gpios, ARRAY_SIZE(leds_gpios));
> -	if (err)
> -		...
> -
> -	gpio_free_array(leds_gpios, ARRAY_SIZE(leds_gpios));
> -
>   
>   GPIO 映射到 IRQ
>   --------------------
> diff --git a/drivers/gpio/gpiolib-legacy.c b/drivers/gpio/gpiolib-legacy.c
> index 3392e758d36f..5a9911ae9125 100644
> --- a/drivers/gpio/gpiolib-legacy.c
> +++ b/drivers/gpio/gpiolib-legacy.c
> @@ -72,42 +72,3 @@ int gpio_request(unsigned gpio, const char *label)
>   	return gpiod_request(desc, label);
>   }
>   EXPORT_SYMBOL_GPL(gpio_request);
> -
> -/**
> - * gpio_request_array - request multiple GPIOs in a single call
> - * @array:	array of the 'struct gpio'
> - * @num:	how many GPIOs in the array
> - *
> - * **DEPRECATED** This function is deprecated and must not be used in new code.
> - */
> -int gpio_request_array(const struct gpio *array, size_t num)
> -{
> -	int i, err;
> -
> -	for (i = 0; i < num; i++, array++) {
> -		err = gpio_request_one(array->gpio, array->flags, array->label);
> -		if (err)
> -			goto err_free;
> -	}
> -	return 0;
> -
> -err_free:
> -	while (i--)
> -		gpio_free((--array)->gpio);
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(gpio_request_array);
> -
> -/**
> - * gpio_free_array - release multiple GPIOs in a single call
> - * @array:	array of the 'struct gpio'
> - * @num:	how many GPIOs in the array
> - *
> - * **DEPRECATED** This function is deprecated and must not be used in new code.
> - */
> -void gpio_free_array(const struct gpio *array, size_t num)
> -{
> -	while (num--)
> -		gpio_free((array++)->gpio);
> -}
> -EXPORT_SYMBOL_GPL(gpio_free_array);
> diff --git a/include/linux/gpio.h b/include/linux/gpio.h
> index f4e5406554bb..56ac7e7a2889 100644
> --- a/include/linux/gpio.h
> +++ b/include/linux/gpio.h
> @@ -120,8 +120,6 @@ static inline int gpio_to_irq(unsigned gpio)
>   }
>   
>   int gpio_request_one(unsigned gpio, unsigned long flags, const char *label);
> -int gpio_request_array(const struct gpio *array, size_t num);
> -void gpio_free_array(const struct gpio *array, size_t num);
>   
>   /* CONFIG_GPIOLIB: bindings for managed devices that want to request gpios */
>   
> @@ -152,11 +150,6 @@ static inline int gpio_request_one(unsigned gpio,
>   	return -ENOSYS;
>   }
>   
> -static inline int gpio_request_array(const struct gpio *array, size_t num)
> -{
> -	return -ENOSYS;
> -}
> -
>   static inline void gpio_free(unsigned gpio)
>   {
>   	might_sleep();
> @@ -165,14 +158,6 @@ static inline void gpio_free(unsigned gpio)
>   	WARN_ON(1);
>   }
>   
> -static inline void gpio_free_array(const struct gpio *array, size_t num)
> -{
> -	might_sleep();
> -
> -	/* GPIO can never have been requested */
> -	WARN_ON(1);
> -}
> -
>   static inline int gpio_direction_input(unsigned gpio)
>   {
>   	return -ENOSYS;


