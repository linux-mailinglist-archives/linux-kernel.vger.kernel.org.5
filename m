Return-Path: <linux-kernel+bounces-135910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5575189CCFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8C3B24401
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1DB147C89;
	Mon,  8 Apr 2024 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="V+c/5SYg"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD437482;
	Mon,  8 Apr 2024 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712608518; cv=none; b=NpTWQdWqfq0pUKB5aI9cJZFOOgpUoWhNcaduRTIZJpC1d3TGbtxpKWkTc+uEVYU6QTSP0jysP9BVLDI6BQ2J7XKjPdNUR2H2sV5oeDydXN+W61ZzsCR9Z9q6zOkBdywg23I5g78lNbCmJDGF+IgZQpGTI3Xh+/HDDrOgUBtJGrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712608518; c=relaxed/simple;
	bh=6wIbXijNZnjnOQq/sRLb9m1wVYCIfcRdMHTfHRaLA0s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SLkOaSd71aTTkUPKQGK1nsBHMmjJ1LR+uL4nbLgxX1t1+ZUlN/rfHjzoqVOK3A9yGz98cNKEODt3GwJKXcAFy0DnZ6lyvA6E6Z4P3O9LqttgYolDW3YxFOr/Mkrezpk09jibI7ED7EOrCTe35CPBKLqQ5aq1BJEso9oPr3ZVtE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=V+c/5SYg; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id tvZIrDqpwcdQQtvZIr8sCw; Mon, 08 Apr 2024 22:26:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1712607983;
	bh=GgXY2ZURZjB5f6jznbBiGTWLjQntZx7NuXSDPoPAJoY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=V+c/5SYgM+nv6Z4DXzXctxKJC5zWfV353MCYZ/bLp6iRpydM5VYGzPiKynORj8fXM
	 6CXHzEAOfpcCrnhm35VAUnbjZwus6d9tY51DBtyVZPXG3UBBr0rpW/bGBrLsVuI/do
	 LfZzGR7qLiJKflrTNoEdH6/KBtxlDARrpTIhp97wtnnHMDmkwDBIyDgxj2TzGImrma
	 qoW4i/SxjRF/CLUd658+iW/GUjUXvQgdbr2/+atsRYcXmSpx5/LOhk5LtCN8Mp9yp9
	 ugbiL5thw9/W4WTUkMKsRqZWeAUULX6AyjR8ijnRMi6/KFCt1iQvGqmGgeDbj95jrB
	 G7saZ67RahwAA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 08 Apr 2024 22:26:23 +0200
X-ME-IP: 86.243.17.157
Message-ID: <6450334d-596b-4982-8a17-eefc8585e036@wanadoo.fr>
Date: Mon, 8 Apr 2024 22:26:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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
 <ed5153e1-f4de-4268-a9d0-e74b779d2587@wanadoo.fr>
 <CANAwSgQ6_bxpKmanPwXvKEQJ0p7AvwTs3on9ubOegaDn3nkdxw@mail.gmail.com>
Content-Language: en-MW
In-Reply-To: <CANAwSgQ6_bxpKmanPwXvKEQJ0p7AvwTs3on9ubOegaDn3nkdxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/04/2024 à 12:02, Anand Moon a écrit :
> Hi Christophe,
> 
> On Fri, 5 Apr 2024 at 21:42, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> Le 05/04/2024 à 08:10, Anand Moon a écrit :
>>>    Hi Christophe, Krzysztof,
>>>
>>> On Mon, 4 Mar 2024 at 17:16, Anand Moon <linux.amoon@gmail.com> wrote:
>>>>
>>>> Hi Christophe,
>>>>
>>>> On Sun, 3 Mar 2024 at 00:07, Christophe JAILLET
>>>> <christophe.jaillet@wanadoo.fr> wrote:
>>>>>
>>>>> Le 02/03/2024 à 17:48, Anand Moon a écrit :
>>>>>> Hi Christophe,
>>>>>>
>>>>>> On Sat, 2 Mar 2024 at 21:20, Christophe JAILLET
>>>>>> <christophe.jaillet@wanadoo.fr> wrote:
>>>>>>>
>>>>>>> Le 01/03/2024 à 20:38, Anand Moon a écrit :
>>>>>>>> Use devm_regulator_bulk_get_enable() instead of open coded
>>>>>>>> 'devm_regulator_get(), regulator_enable(), regulator_disable().
>>>>>>>>
>>>>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>>>>> ---
>>>>>>>>      drivers/usb/dwc3/dwc3-exynos.c | 49 +++-------------------------------
>>>>>>>>      1 file changed, 4 insertions(+), 45 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
>>>>>>>> index 5d365ca51771..7c77f3c69825 100644
>>>>>>>> --- a/drivers/usb/dwc3/dwc3-exynos.c
>>>>>>>> +++ b/drivers/usb/dwc3/dwc3-exynos.c
>>>>>>>> @@ -32,9 +32,6 @@ struct dwc3_exynos {
>>>>>>>>          struct clk              *clks[DWC3_EXYNOS_MAX_CLOCKS];
>>>>>>>>          int                     num_clks;
>>>>>>>>          int                     suspend_clk_idx;
>>>>>>>> -
>>>>>>>> -     struct regulator        *vdd33;
>>>>>>>> -     struct regulator        *vdd10;
>>>>>>>>      };
>>>>>>>>
>>>>>>>>      static int dwc3_exynos_probe(struct platform_device *pdev)
>>>>>>>> @@ -44,6 +41,7 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>>>>>>>>          struct device_node      *node = dev->of_node;
>>>>>>>>          const struct dwc3_exynos_driverdata *driver_data;
>>>>>>>>          int                     i, ret;
>>>>>>>> +     static const char * const regulators[] = { "vdd33", "vdd10" };
>>>>>>>>
>>>>>>>>          exynos = devm_kzalloc(dev, sizeof(*exynos), GFP_KERNEL);
>>>>>>>>          if (!exynos)
>>>>>>>> @@ -78,27 +76,9 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>>>>>>>>          if (exynos->suspend_clk_idx >= 0)
>>>>>>>>                  clk_prepare_enable(exynos->clks[exynos->suspend_clk_idx]);
>>>>>>>>
>>>>>>>> -     exynos->vdd33 = devm_regulator_get(dev, "vdd33");
>>>>>>>> -     if (IS_ERR(exynos->vdd33)) {
>>>>>>>> -             ret = PTR_ERR(exynos->vdd33);
>>>>>>>> -             goto vdd33_err;
>>>>>>>> -     }
>>>>>>>> -     ret = regulator_enable(exynos->vdd33);
>>>>>>>> -     if (ret) {
>>>>>>>> -             dev_err(dev, "Failed to enable VDD33 supply\n");
>>>>>>>> -             goto vdd33_err;
>>>>>>>> -     }
>>>>>>>> -
>>>>>>>> -     exynos->vdd10 = devm_regulator_get(dev, "vdd10");
>>>>>>>> -     if (IS_ERR(exynos->vdd10)) {
>>>>>>>> -             ret = PTR_ERR(exynos->vdd10);
>>>>>>>> -             goto vdd10_err;
>>>>>>>> -     }
>>>>>>>> -     ret = regulator_enable(exynos->vdd10);
>>>>>>>> -     if (ret) {
>>>>>>>> -             dev_err(dev, "Failed to enable VDD10 supply\n");
>>>>>>>> -             goto vdd10_err;
>>>>>>>> -     }
>>>>>>>> +     ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators), regulators);
>>>>>>>> +     if (ret)
>>>>>>>> +             return dev_err_probe(dev, ret, "Failed to enable regulators\n");
>>>>>>>>
>>>>>>>>          if (node) {
>>>>>>>>                  ret = of_platform_populate(node, NULL, NULL, dev);
>>>>>>>> @@ -115,10 +95,6 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>>>>>>>>          return 0;
>>>>>>>>
>>>>>>>>      populate_err:
>>>>>>>> -     regulator_disable(exynos->vdd10);
>>>>>>>> -vdd10_err:
>>>>>>>> -     regulator_disable(exynos->vdd33);
>>>>>>>> -vdd33_err:
>>>>>>>>          for (i = exynos->num_clks - 1; i >= 0; i--)
>>>>>>>>                  clk_disable_unprepare(exynos->clks[i]);
>>>>>>>>
>>>>>>>> @@ -140,9 +116,6 @@ static void dwc3_exynos_remove(struct platform_device *pdev)
>>>>>>>>
>>>>>>>>          if (exynos->suspend_clk_idx >= 0)
>>>>>>>>                  clk_disable_unprepare(exynos->clks[exynos->suspend_clk_idx]);
>>>>>>>> -
>>>>>>>> -     regulator_disable(exynos->vdd33);
>>>>>>>> -     regulator_disable(exynos->vdd10);
>>>>>>>>      }
>>>>>>>>
>>>>>>>>      static const struct dwc3_exynos_driverdata exynos5250_drvdata = {
>>>>>>>> @@ -196,9 +169,6 @@ static int dwc3_exynos_suspend(struct device *dev)
>>>>>>>>          for (i = exynos->num_clks - 1; i >= 0; i--)
>>>>>>>>                  clk_disable_unprepare(exynos->clks[i]);
>>>>>>>>
>>>>>>>> -     regulator_disable(exynos->vdd33);
>>>>>>>> -     regulator_disable(exynos->vdd10);
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> Same here, I don't think that removing regulator_[en|dis]able from the
>>>>>>> suspend and resume function is correct.
>>>>>>>
>>>>>>> The goal is to stop some hardware when the system is suspended, in order
>>>>>>> to save some power.
>>>>>> Ok,
>>>>>>>
>>>>>>> Why did you removed it?
>>>>>>
>>>>>> As per the description of the function  devm_regulator_bulk_get_enable
>>>>>>
>>>>>> * This helper function allows drivers to get several regulator
>>>>>>     * consumers in one operation with management, the regulators will
>>>>>>     * automatically be freed when the device is unbound.  If any of the
>>>>>>     * regulators cannot be acquired then any regulators that were
>>>>>>     * allocated will be freed before returning to the caller.
>>>>>
>>>>> The code in suspend/resume is not about freeing some resources. It is
>>>>> about enabling/disabling some hardware to save some power.
>>>>>
>>>>> Think to the probe/remove functions as the software in the kernel that
>>>>> knows how to handle some hardawre, and the suspend/resume as the on/off
>>>>> button to power-on and off the electrical chips.
>>>>>
>>>>> When the system is suspended, the software is still around. But some
>>>>> hardware can be set in a low consumption mode to save some power.
>>>>>
>>>>> IMHO, part of the code you removed changed this behaviour and increase
>>>>> the power consumption when the system is suspended.
>>>>>
>>>>
>>>> You are correct, I have changed the regulator API from
>>>> devm_regulator_get_enable to devm_regulator_bulk_get_enable
>>>> which changes this behavior.
>>>> I will fix it in the next version.
>>>>
>>>>> CJ
>>>
>>> I could not find any example in the kernel to support
>>> devm_regulator_bulk_disable
>>> but here is my modified file.
>>>
>>> If you have any suggestions for this plz let me know.
>>
>> I don't think that your approach is correct, and I don't think that the
>> proposed patch does what you expect it to do.
>>
>> Calling a devm_ function in suspend/resume functions looks really
>> strange to me and is likely broken.
>>
>> Especially here, devm_regulator_bulk_get_enable() in the resume function
>> allocates some memory that is not freed in
>> devm_regulator_bulk_disable(), because the API is not designed to work
>> like that. So this could generate a kind of memory leak.
>>
>>
>> *I think that the code is good enough as-is*, but if you really want to
>> change something, maybe:
>>      - devm_regulator_get()+regulator_enable() in the probe could be
>> changed to devm_regulator_get_enable()
>>      - the resume/suspend function should be left as-is with
>> regulator_disable()/regulator_ensable()
>>      - remove regulator_disable() from the error handling path of the
>> probe and from the remove function.
>>
>> I *think* it would work.
>>
> No devm_regulator_get_enable use the same logic as
> devm_regulator_bulk_get_enable
> to enable the regulator.

Yes, the logic is the same, but you get a pointer to the "struct 
regulator" which can be used to disable/enable in the suspend/resume 
functions.

With the bulk version, you can not do that.

See my first reply on your 3/4 patch.

> 
> [0] https://elixir.bootlin.com/linux/latest/source/drivers/regulator/devres.c#L126
> 
> So as of now I am dropping the changes on the regulator in this patch series.

I do agree that it is certainly the way to go here.

CJ

> 
>> CJ
>>
> Thanks for your inputs.
> 
> Thanks
> 
> -Anand
> 
> 


