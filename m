Return-Path: <linux-kernel+bounces-89552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BBA86F1E9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E751F21C33
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD5936B02;
	Sat,  2 Mar 2024 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="IyNRGGdk"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FC536B04
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709404743; cv=none; b=U0l8XCtv3OKKctKtBseWeQUv3EXJJlyoNVV4wl7u1m5IDhbBNrZgPkML2aFgtBehKI73+J88oAgpbWWJiUcY8B0Nc/LdpwwH7AXeRL+AK8TnNOy4w8HSg0VQDMaZ9cTjpDaBRClX86byM2DT+U5r7fLabZX3v84YRXqMMKJ5dmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709404743; c=relaxed/simple;
	bh=Jcr/+AJ6YoN/mVbX0QObePyIKSu1yomlBHR+PE564ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQCwBaSiAcxAUmKoKgvjP2dC2zlXTFHGgdmN+dQyoISK+wcXw7+j6FdEj+VS8+PJpwgXREPGRr0OAfqsHccIqK3UyPyi8aaDw4j5rk1z0gICr6LyKtgRc3dd0hkeSdJ5Wm96w7cVd7IM5efYlOmfYSWudD/Lnk6qK6+HtlPBOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=IyNRGGdk; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id gUF1r9tB5hB2WgUF1rzJz1; Sat, 02 Mar 2024 19:37:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1709404670;
	bh=4WSTihlA8apdaaO/0BzgYPCsmCNNnVvwhlLXTpRmpLU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IyNRGGdk4u/WLVlIqptD3EGHPIVWNMQ85mJNnIaiNWeI1UlO71kFPNRVoicmLrL8/
	 lVErBkAqiJcaXsIvMj1PEvhTHXD+LWg5FEg0NaW0csuctQxsE/Uj8ma7hubHCvwu7A
	 rxTiXHPbXpwgE6ZiERKhD+ncUjh70yY0vcdjcjfevkXl/1fTrnWlD8eonKp4t/q+ub
	 5Z3IcAME3MzoEdfPDlaIK6/f1jhNM8qTWZF2bsa5H8+mb6sfDQPR0pWCmmR1IHQgqF
	 +az1AWweAEZyWL/jk7qIPe75NXqNpGBPqiEu09qxnq+EqPDsPxFI3icF8mVlIRIYZT
	 kfS4jfL9Hb6Hw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 Mar 2024 19:37:50 +0100
X-ME-IP: 92.140.202.140
Message-ID: <e85ad80f-af7d-4eaf-9d14-dff13451f7e5@wanadoo.fr>
Date: Sat, 2 Mar 2024 19:37:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] usb: dwc3: exynos: Use
 devm_regulator_bulk_get_enable() helper function
Content-Language: en-MW
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
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CANAwSgTCaSSMN2QCw5fr=RBp0WwWaLuebzQDO=scnABNFNctJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 02/03/2024 à 17:48, Anand Moon a écrit :
> Hi Christophe,
> 
> On Sat, 2 Mar 2024 at 21:20, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> Le 01/03/2024 à 20:38, Anand Moon a écrit :
>>> Use devm_regulator_bulk_get_enable() instead of open coded
>>> 'devm_regulator_get(), regulator_enable(), regulator_disable().
>>>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>>    drivers/usb/dwc3/dwc3-exynos.c | 49 +++-------------------------------
>>>    1 file changed, 4 insertions(+), 45 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
>>> index 5d365ca51771..7c77f3c69825 100644
>>> --- a/drivers/usb/dwc3/dwc3-exynos.c
>>> +++ b/drivers/usb/dwc3/dwc3-exynos.c
>>> @@ -32,9 +32,6 @@ struct dwc3_exynos {
>>>        struct clk              *clks[DWC3_EXYNOS_MAX_CLOCKS];
>>>        int                     num_clks;
>>>        int                     suspend_clk_idx;
>>> -
>>> -     struct regulator        *vdd33;
>>> -     struct regulator        *vdd10;
>>>    };
>>>
>>>    static int dwc3_exynos_probe(struct platform_device *pdev)
>>> @@ -44,6 +41,7 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>>>        struct device_node      *node = dev->of_node;
>>>        const struct dwc3_exynos_driverdata *driver_data;
>>>        int                     i, ret;
>>> +     static const char * const regulators[] = { "vdd33", "vdd10" };
>>>
>>>        exynos = devm_kzalloc(dev, sizeof(*exynos), GFP_KERNEL);
>>>        if (!exynos)
>>> @@ -78,27 +76,9 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>>>        if (exynos->suspend_clk_idx >= 0)
>>>                clk_prepare_enable(exynos->clks[exynos->suspend_clk_idx]);
>>>
>>> -     exynos->vdd33 = devm_regulator_get(dev, "vdd33");
>>> -     if (IS_ERR(exynos->vdd33)) {
>>> -             ret = PTR_ERR(exynos->vdd33);
>>> -             goto vdd33_err;
>>> -     }
>>> -     ret = regulator_enable(exynos->vdd33);
>>> -     if (ret) {
>>> -             dev_err(dev, "Failed to enable VDD33 supply\n");
>>> -             goto vdd33_err;
>>> -     }
>>> -
>>> -     exynos->vdd10 = devm_regulator_get(dev, "vdd10");
>>> -     if (IS_ERR(exynos->vdd10)) {
>>> -             ret = PTR_ERR(exynos->vdd10);
>>> -             goto vdd10_err;
>>> -     }
>>> -     ret = regulator_enable(exynos->vdd10);
>>> -     if (ret) {
>>> -             dev_err(dev, "Failed to enable VDD10 supply\n");
>>> -             goto vdd10_err;
>>> -     }
>>> +     ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators), regulators);
>>> +     if (ret)
>>> +             return dev_err_probe(dev, ret, "Failed to enable regulators\n");
>>>
>>>        if (node) {
>>>                ret = of_platform_populate(node, NULL, NULL, dev);
>>> @@ -115,10 +95,6 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>>>        return 0;
>>>
>>>    populate_err:
>>> -     regulator_disable(exynos->vdd10);
>>> -vdd10_err:
>>> -     regulator_disable(exynos->vdd33);
>>> -vdd33_err:
>>>        for (i = exynos->num_clks - 1; i >= 0; i--)
>>>                clk_disable_unprepare(exynos->clks[i]);
>>>
>>> @@ -140,9 +116,6 @@ static void dwc3_exynos_remove(struct platform_device *pdev)
>>>
>>>        if (exynos->suspend_clk_idx >= 0)
>>>                clk_disable_unprepare(exynos->clks[exynos->suspend_clk_idx]);
>>> -
>>> -     regulator_disable(exynos->vdd33);
>>> -     regulator_disable(exynos->vdd10);
>>>    }
>>>
>>>    static const struct dwc3_exynos_driverdata exynos5250_drvdata = {
>>> @@ -196,9 +169,6 @@ static int dwc3_exynos_suspend(struct device *dev)
>>>        for (i = exynos->num_clks - 1; i >= 0; i--)
>>>                clk_disable_unprepare(exynos->clks[i]);
>>>
>>> -     regulator_disable(exynos->vdd33);
>>> -     regulator_disable(exynos->vdd10);
>>
>> Hi,
>>
>> Same here, I don't think that removing regulator_[en|dis]able from the
>> suspend and resume function is correct.
>>
>> The goal is to stop some hardware when the system is suspended, in order
>> to save some power.
> Ok,
>>
>> Why did you removed it?
> 
> As per the description of the function  devm_regulator_bulk_get_enable
> 
> * This helper function allows drivers to get several regulator
>   * consumers in one operation with management, the regulators will
>   * automatically be freed when the device is unbound.  If any of the
>   * regulators cannot be acquired then any regulators that were
>   * allocated will be freed before returning to the caller.

The code in suspend/resume is not about freeing some resources. It is 
about enabling/disabling some hardware to save some power.

Think to the probe/remove functions as the software in the kernel that 
knows how to handle some hardawre, and the suspend/resume as the on/off 
button to power-on and off the electrical chips.

When the system is suspended, the software is still around. But some 
hardware can be set in a low consumption mode to save some power.

IMHO, part of the code you removed changed this behaviour and increase 
the power consumption when the system is suspended.

CJ

> 
> [0] https://elixir.bootlin.com/linux/latest/source/drivers/regulator/devres.c#L330
> 
> I have tested with rtc suspend resume and did not find any issue with
> this.patch.
> 
>>
>> CJ
>>
> Thanks
> -Anand
> 
> 


