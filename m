Return-Path: <linux-kernel+bounces-133324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3211789A234
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A3EEB26AE5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C219171646;
	Fri,  5 Apr 2024 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ZYgnhfdF"
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5117106F;
	Fri,  5 Apr 2024 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333637; cv=none; b=eYrR2/AAmKNv6f6yu5US+heIwiWbn6fdqtZ9tQYhHS84g2GreQq4j0ZvFrlUxY0bmq1RUWjBVx28vLnOwpk+IarwAGefZkKQeuk/0y6W0VFZ/1BTnz6mfTeeNGFMD6RvrTPEMXaAif9iaclTuRYSiLf0tzzB57eN5VUK9D5OUWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333637; c=relaxed/simple;
	bh=446fASRPfRilsIGps55d8+e8J1yR6wjH51douWekheQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKoHUCRseNWuPYH8r4lsgv2FZledEy76lYy7WcfgzCFTWFCN4GKgka2t8NV3hEaFRQxQIJaK8n9VfCqeRTPZg5hpoLx3Yd47Wk3P01PIKn3UTXvgzLC64k3nDUMewbhgw9KxCwhGV6Cypg0LcP960CQFyfp4QcOxqjKBHstxpNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ZYgnhfdF; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id smBFrrKFnOOBFsmBFrIsHA; Fri, 05 Apr 2024 18:12:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1712333563;
	bh=+pRBTJW1OUjq+2ZwP12ZfPfemwchotgOt0zCg7URj1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ZYgnhfdFYv+mDKfMzNZkz/qslvBPz900MkpdvyJtqDOTA225CsdZIExPUfZoKLX4f
	 zN7lOiIxrRVPTfLXEREQpIvw99Lv7BK0SFkd5ytl92qBJvbyZ+xOgexhxClWSEB/mg
	 AGBeSvyEppu0FA0/SpxxG2BuKihQ3Up0H/nsx3xCnoQzYOxOtnAZ2lQTrb4Mmv3p7/
	 SygZM83/mbjkh29Y2rCekJwGCCo49NUdnwoXnLf3Ei+FsDrzIOYaMLLncER6mngWO7
	 BFteKWE8SlSrE5hMCO74rr8AizuKrMy9toXp3dcGJxP796SfhBRRa168K4IRkzoXtH
	 EmDHi6oHTMzXg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 05 Apr 2024 18:12:43 +0200
X-ME-IP: 86.243.17.157
Message-ID: <ed5153e1-f4de-4268-a9d0-e74b779d2587@wanadoo.fr>
Date: Fri, 5 Apr 2024 18:12:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] usb: dwc3: exynos: Use
 devm_regulator_bulk_get_enable() helper function
To: Anand Moon <linux.amoon@gmail.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240301193831.3346-1-linux.amoon@gmail.com>
 <20240301193831.3346-4-linux.amoon@gmail.com>
 <52158bf6-16fe-4ce2-b9b6-bbc6550a6e14@wanadoo.fr>
 <CANAwSgTCaSSMN2QCw5fr=RBp0WwWaLuebzQDO=scnABNFNctJQ@mail.gmail.com>
 <e85ad80f-af7d-4eaf-9d14-dff13451f7e5@wanadoo.fr>
 <CANAwSgRrOw+6MHLPDP8RwLwzwB1EVGBTovtR2ChhqR3b5uWowA@mail.gmail.com>
 <CANAwSgQk10=K6Z5OzvT3OUncfr6BWyx7oH2JKN5CJAnS+uO7QQ@mail.gmail.com>
Content-Language: en-MW, en-US
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CANAwSgQk10=K6Z5OzvT3OUncfr6BWyx7oH2JKN5CJAnS+uO7QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 05/04/2024 à 08:10, Anand Moon a écrit :
>   Hi Christophe, Krzysztof,
> 
> On Mon, 4 Mar 2024 at 17:16, Anand Moon <linux.amoon@gmail.com> wrote:
>>
>> Hi Christophe,
>>
>> On Sun, 3 Mar 2024 at 00:07, Christophe JAILLET
>> <christophe.jaillet@wanadoo.fr> wrote:
>>>
>>> Le 02/03/2024 à 17:48, Anand Moon a écrit :
>>>> Hi Christophe,
>>>>
>>>> On Sat, 2 Mar 2024 at 21:20, Christophe JAILLET
>>>> <christophe.jaillet@wanadoo.fr> wrote:
>>>>>
>>>>> Le 01/03/2024 à 20:38, Anand Moon a écrit :
>>>>>> Use devm_regulator_bulk_get_enable() instead of open coded
>>>>>> 'devm_regulator_get(), regulator_enable(), regulator_disable().
>>>>>>
>>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>>> ---
>>>>>>     drivers/usb/dwc3/dwc3-exynos.c | 49 +++-------------------------------
>>>>>>     1 file changed, 4 insertions(+), 45 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
>>>>>> index 5d365ca51771..7c77f3c69825 100644
>>>>>> --- a/drivers/usb/dwc3/dwc3-exynos.c
>>>>>> +++ b/drivers/usb/dwc3/dwc3-exynos.c
>>>>>> @@ -32,9 +32,6 @@ struct dwc3_exynos {
>>>>>>         struct clk              *clks[DWC3_EXYNOS_MAX_CLOCKS];
>>>>>>         int                     num_clks;
>>>>>>         int                     suspend_clk_idx;
>>>>>> -
>>>>>> -     struct regulator        *vdd33;
>>>>>> -     struct regulator        *vdd10;
>>>>>>     };
>>>>>>
>>>>>>     static int dwc3_exynos_probe(struct platform_device *pdev)
>>>>>> @@ -44,6 +41,7 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>>>>>>         struct device_node      *node = dev->of_node;
>>>>>>         const struct dwc3_exynos_driverdata *driver_data;
>>>>>>         int                     i, ret;
>>>>>> +     static const char * const regulators[] = { "vdd33", "vdd10" };
>>>>>>
>>>>>>         exynos = devm_kzalloc(dev, sizeof(*exynos), GFP_KERNEL);
>>>>>>         if (!exynos)
>>>>>> @@ -78,27 +76,9 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>>>>>>         if (exynos->suspend_clk_idx >= 0)
>>>>>>                 clk_prepare_enable(exynos->clks[exynos->suspend_clk_idx]);
>>>>>>
>>>>>> -     exynos->vdd33 = devm_regulator_get(dev, "vdd33");
>>>>>> -     if (IS_ERR(exynos->vdd33)) {
>>>>>> -             ret = PTR_ERR(exynos->vdd33);
>>>>>> -             goto vdd33_err;
>>>>>> -     }
>>>>>> -     ret = regulator_enable(exynos->vdd33);
>>>>>> -     if (ret) {
>>>>>> -             dev_err(dev, "Failed to enable VDD33 supply\n");
>>>>>> -             goto vdd33_err;
>>>>>> -     }
>>>>>> -
>>>>>> -     exynos->vdd10 = devm_regulator_get(dev, "vdd10");
>>>>>> -     if (IS_ERR(exynos->vdd10)) {
>>>>>> -             ret = PTR_ERR(exynos->vdd10);
>>>>>> -             goto vdd10_err;
>>>>>> -     }
>>>>>> -     ret = regulator_enable(exynos->vdd10);
>>>>>> -     if (ret) {
>>>>>> -             dev_err(dev, "Failed to enable VDD10 supply\n");
>>>>>> -             goto vdd10_err;
>>>>>> -     }
>>>>>> +     ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators), regulators);
>>>>>> +     if (ret)
>>>>>> +             return dev_err_probe(dev, ret, "Failed to enable regulators\n");
>>>>>>
>>>>>>         if (node) {
>>>>>>                 ret = of_platform_populate(node, NULL, NULL, dev);
>>>>>> @@ -115,10 +95,6 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>>>>>>         return 0;
>>>>>>
>>>>>>     populate_err:
>>>>>> -     regulator_disable(exynos->vdd10);
>>>>>> -vdd10_err:
>>>>>> -     regulator_disable(exynos->vdd33);
>>>>>> -vdd33_err:
>>>>>>         for (i = exynos->num_clks - 1; i >= 0; i--)
>>>>>>                 clk_disable_unprepare(exynos->clks[i]);
>>>>>>
>>>>>> @@ -140,9 +116,6 @@ static void dwc3_exynos_remove(struct platform_device *pdev)
>>>>>>
>>>>>>         if (exynos->suspend_clk_idx >= 0)
>>>>>>                 clk_disable_unprepare(exynos->clks[exynos->suspend_clk_idx]);
>>>>>> -
>>>>>> -     regulator_disable(exynos->vdd33);
>>>>>> -     regulator_disable(exynos->vdd10);
>>>>>>     }
>>>>>>
>>>>>>     static const struct dwc3_exynos_driverdata exynos5250_drvdata = {
>>>>>> @@ -196,9 +169,6 @@ static int dwc3_exynos_suspend(struct device *dev)
>>>>>>         for (i = exynos->num_clks - 1; i >= 0; i--)
>>>>>>                 clk_disable_unprepare(exynos->clks[i]);
>>>>>>
>>>>>> -     regulator_disable(exynos->vdd33);
>>>>>> -     regulator_disable(exynos->vdd10);
>>>>>
>>>>> Hi,
>>>>>
>>>>> Same here, I don't think that removing regulator_[en|dis]able from the
>>>>> suspend and resume function is correct.
>>>>>
>>>>> The goal is to stop some hardware when the system is suspended, in order
>>>>> to save some power.
>>>> Ok,
>>>>>
>>>>> Why did you removed it?
>>>>
>>>> As per the description of the function  devm_regulator_bulk_get_enable
>>>>
>>>> * This helper function allows drivers to get several regulator
>>>>    * consumers in one operation with management, the regulators will
>>>>    * automatically be freed when the device is unbound.  If any of the
>>>>    * regulators cannot be acquired then any regulators that were
>>>>    * allocated will be freed before returning to the caller.
>>>
>>> The code in suspend/resume is not about freeing some resources. It is
>>> about enabling/disabling some hardware to save some power.
>>>
>>> Think to the probe/remove functions as the software in the kernel that
>>> knows how to handle some hardawre, and the suspend/resume as the on/off
>>> button to power-on and off the electrical chips.
>>>
>>> When the system is suspended, the software is still around. But some
>>> hardware can be set in a low consumption mode to save some power.
>>>
>>> IMHO, part of the code you removed changed this behaviour and increase
>>> the power consumption when the system is suspended.
>>>
>>
>> You are correct, I have changed the regulator API from
>> devm_regulator_get_enable to devm_regulator_bulk_get_enable
>> which changes this behavior.
>> I will fix it in the next version.
>>
>>> CJ
> 
> I could not find any example in the kernel to support
> devm_regulator_bulk_disable
> but here is my modified file.
> 
> If you have any suggestions for this plz let me know.

I don't think that your approach is correct, and I don't think that the 
proposed patch does what you expect it to do.

Calling a devm_ function in suspend/resume functions looks really 
strange to me and is likely broken.

Especially here, devm_regulator_bulk_get_enable() in the resume function 
allocates some memory that is not freed in 
devm_regulator_bulk_disable(), because the API is not designed to work 
like that. So this could generate a kind of memory leak.


*I think that the code is good enough as-is*, but if you really want to 
change something, maybe:
    - devm_regulator_get()+regulator_enable() in the probe could be 
changed to devm_regulator_get_enable()
    - the resume/suspend function should be left as-is with 
regulator_disable()/regulator_ensable()
    - remove regulator_disable() from the error handling path of the 
probe and from the remove function.

I *think* it would work.

CJ


> -----8<----------8<----------
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> index 6d07592ad022..2f808cb9a006 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -34,6 +34,8 @@ struct dwc3_exynos {
>          int                     suspend_clk_idx;
>   };
> 
> +static const char * const regulators[] = { "vdd33", "vdd10" };
> +
>   static int dwc3_exynos_probe(struct platform_device *pdev)
>   {
>          struct dwc3_exynos      *exynos;
> @@ -41,7 +43,6 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>          struct device_node      *node = dev->of_node;
>          const struct dwc3_exynos_driverdata *driver_data;
>          int                     i, ret;
> -       static const char * const regulators[] = { "vdd33", "vdd10" };
> 
>          exynos = devm_kzalloc(dev, sizeof(*exynos), GFP_KERNEL);
>          if (!exynos)
> @@ -166,6 +167,8 @@ static int __maybe_unused
> dwc3_exynos_suspend(struct device *dev)
>          struct dwc3_exynos *exynos = dev_get_drvdata(dev);
>          int i;
> 
> +       devm_regulator_bulk_disable(dev);
> +
>          for (i = exynos->num_clks - 1; i >= 0; i--)
>                  clk_disable_unprepare(exynos->clks[i]);
> 
> @@ -177,6 +180,11 @@ static int __maybe_unused
> dwc3_exynos_resume(struct device *dev)
>          struct dwc3_exynos *exynos = dev_get_drvdata(dev);
>          int i, ret;
> 
> +       ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
> +                                               regulators);
> +       if (ret)
> +               dev_err(dev, "Failed to enable regulators\n");
> +
>          for (i = 0; i < exynos->num_clks; i++) {
>                  ret = clk_prepare_enable(exynos->clks[i]);
>                  if (ret) {
> 
> To support these changes we need to export the
> devm_regulator_bulk_disable function.
> -----8<----------8<----------
> diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
> index 90bb0d178885..97eed739f929 100644
> --- a/drivers/regulator/devres.c
> +++ b/drivers/regulator/devres.c
> @@ -318,7 +318,7 @@ void devm_regulator_bulk_put(struct
> regulator_bulk_data *consumers)
>   }
>   EXPORT_SYMBOL_GPL(devm_regulator_bulk_put);
> 
> -static void devm_regulator_bulk_disable(void *res)
> +void devm_regulator_bulk_disable(void *res)
>   {
>          struct regulator_bulk_devres *devres = res;
>          int i;
> @@ -326,6 +326,7 @@ static void devm_regulator_bulk_disable(void *res)
>          for (i = 0; i < devres->num_consumers; i++)
>                  regulator_disable(devres->consumers[i].consumer);
>   }
> +EXPORT_SYMBOL_GPL(devm_regulator_bulk_disable);
> 
>   /**
>    * devm_regulator_bulk_get_enable - managed get'n enable multiple regulators
> diff --git a/include/linux/regulator/consumer.h
> b/include/linux/regulator/consumer.h
> index 4660582a3302..ce7d28306b17 100644
> --- a/include/linux/regulator/consumer.h
> +++ b/include/linux/regulator/consumer.h
> @@ -214,6 +214,7 @@ int __must_check regulator_bulk_enable(int num_consumers,
>                                         struct regulator_bulk_data *consumers);
>   int devm_regulator_bulk_get_enable(struct device *dev, int num_consumers,
>                                     const char * const *id);
> +void devm_regulator_bulk_disable(void *res);
>   int regulator_bulk_disable(int num_consumers,
>                             struct regulator_bulk_data *consumers);
>   int regulator_bulk_force_disable(int num_consumers,
> --------------------------------------------------------------------------
> 
> Thanks
> -Anand
> 
> 


