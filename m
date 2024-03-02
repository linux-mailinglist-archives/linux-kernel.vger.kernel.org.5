Return-Path: <linux-kernel+bounces-89553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4954386F1EC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67B7282D9B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491BA36B1A;
	Sat,  2 Mar 2024 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ZV8VkP4Z"
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AC82C696
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709404888; cv=none; b=ZeVjUAKnJmLLyHr0yP+ZggrCmHlOY4GGS8M4jp4RUjOnXYDbnCwgMuD/zj0v0wtWum6WIbvWhJKbXs/HvSdqvfd5Ykt7i4Sk8hXm0+Yk2vcF87xT3ca/FcsQmlyZD8kbLr2Zi4lJ/OG1T4DKyfCEHemvYSd0mN+V+W+GsqmbDs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709404888; c=relaxed/simple;
	bh=ozjaB3jCmim+JTKyCZ/nHpMyry5eJz1C1R8Vij0hwZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUmXr+ngXyEF3yecQskUddLso45rMCMMMRbmwuVQbQROUUlgxU212v+tE90uSq7MJTUkP83aVARY7mjlZ2k9LHXT1XiafilFRh4htwTlyx4opYppUI4068ACXjYe3se47jMAt6ZrcYxzg6aRy7ViHyIGW2neTKGZMDWxJhhN58E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ZV8VkP4Z; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id gUINr95pG9TLjgUINrtlYS; Sat, 02 Mar 2024 19:41:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1709404878;
	bh=RFUJ/5KBiEKNUs0yBIB9gekJSDB/hWKunNk1f7N0Eug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZV8VkP4ZBMxzAEa4nupAeTRsXIwcp9Q1vtYcsQ+xQA1HQCed4BWvw3/M00nhUmn7D
	 OWWA3j9/3/+6MjW2KxInw+GebGACR9SsqFIXqtKGMMWnGat4deqy7iRo4n1FCcBt0V
	 /ACLuK3096SBDotpFdDzcV9nWxHozE0Hwcz3zSnB/fT/Dx0UJ32JZeDCe38OxvCTB5
	 sXPYsey7XdjpOtMZ/0OjmVwonZxD4xQiJBdJWyC273FUbwcKRI0sHVIRRTyWbunVuY
	 WvkA4FlC5tlnVyvdgsFVV/WtpaZ7mbmwX+jWfQDLbfjRqfeOFbSYuFsqUs0LddGA6M
	 DkYpI0eyzsIyw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 Mar 2024 19:41:18 +0100
X-ME-IP: 92.140.202.140
Message-ID: <aee270dc-80b2-48c1-a7cb-b1692b5a7677@wanadoo.fr>
Date: Sat, 2 Mar 2024 19:41:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] usb: ehci-exynos: Use devm_clk_get_enabled()
 helpers
Content-Language: en-MW
To: Anand Moon <linux.amoon@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240301193831.3346-1-linux.amoon@gmail.com>
 <20240301193831.3346-2-linux.amoon@gmail.com>
 <3d1c7682-d163-4bcf-bd41-d7db0c8f61d1@wanadoo.fr>
 <CANAwSgR0aQ7nt1y5xknvVjHSnfvTaC8JZMLWurb8z2D0Oxg6Rw@mail.gmail.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CANAwSgR0aQ7nt1y5xknvVjHSnfvTaC8JZMLWurb8z2D0Oxg6Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 02/03/2024 à 17:35, Anand Moon a écrit :
> Hi Christophe,
> 
> On Sat, 2 Mar 2024 at 21:19, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> Le 01/03/2024 à 20:38, Anand Moon a écrit :
>>> The devm_clk_get_enabled() helpers:
>>>       - call devm_clk_get()
>>>       - call clk_prepare_enable() and register what is needed in order to
>>>        call clk_disable_unprepare() when needed, as a managed resource.
>>>
>>> This simplifies the code and avoids the calls to clk_disable_unprepare().
>>>
>>> While at it, use dev_err_probe consistently, and use its return value
>>> to return the error code.
>>>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>>    drivers/usb/host/ehci-exynos.c | 30 +++++-------------------------
>>>    1 file changed, 5 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
>>> index f644b131cc0b..05aa3d9c2a3b 100644
>>> --- a/drivers/usb/host/ehci-exynos.c
>>> +++ b/drivers/usb/host/ehci-exynos.c
>>> @@ -159,19 +159,12 @@ static int exynos_ehci_probe(struct platform_device *pdev)
>>>
>>>        err = exynos_ehci_get_phy(&pdev->dev, exynos_ehci);
>>>        if (err)
>>> -             goto fail_clk;
>>> -
>>> -     exynos_ehci->clk = devm_clk_get(&pdev->dev, "usbhost");
>>> -
>>> -     if (IS_ERR(exynos_ehci->clk)) {
>>> -             dev_err(&pdev->dev, "Failed to get usbhost clock\n");
>>> -             err = PTR_ERR(exynos_ehci->clk);
>>> -             goto fail_clk;
>>> -     }
>>> +             goto fail_io;
>>>
>>> -     err = clk_prepare_enable(exynos_ehci->clk);
>>> -     if (err)
>>> -             goto fail_clk;
>>> +     exynos_ehci->clk = devm_clk_get_enabled(&pdev->dev, "usbhost");
>>> +     if (IS_ERR(exynos_ehci->clk))
>>> +             return dev_err_probe(&pdev->dev, PTR_ERR(exynos_ehci->clk),
>>> +                               "Failed to get usbhost clock\n");
>>>
>>>        hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>>>        if (IS_ERR(hcd->regs)) {
>>> @@ -223,8 +216,6 @@ static int exynos_ehci_probe(struct platform_device *pdev)
>>>        exynos_ehci_phy_disable(&pdev->dev);
>>>        pdev->dev.of_node = exynos_ehci->of_node;
>>>    fail_io:
>>> -     clk_disable_unprepare(exynos_ehci->clk);
>>> -fail_clk:
>>>        usb_put_hcd(hcd);
>>>        return err;
>>>    }
>>> @@ -240,8 +231,6 @@ static void exynos_ehci_remove(struct platform_device *pdev)
>>>
>>>        exynos_ehci_phy_disable(&pdev->dev);
>>>
>>> -     clk_disable_unprepare(exynos_ehci->clk);
>>> -
>>>        usb_put_hcd(hcd);
>>>    }
>>>
>>> @@ -249,7 +238,6 @@ static void exynos_ehci_remove(struct platform_device *pdev)
>>>    static int exynos_ehci_suspend(struct device *dev)
>>>    {
>>>        struct usb_hcd *hcd = dev_get_drvdata(dev);
>>> -     struct exynos_ehci_hcd *exynos_ehci = to_exynos_ehci(hcd);
>>>
>>>        bool do_wakeup = device_may_wakeup(dev);
>>>        int rc;
>>> @@ -260,25 +248,17 @@ static int exynos_ehci_suspend(struct device *dev)
>>>
>>>        exynos_ehci_phy_disable(dev);
>>>
>>> -     clk_disable_unprepare(exynos_ehci->clk);
>>
>> Hi,
>>
>> I don't think that removing clk_[en|dis]abble from the suspend and
>> resume function is correct.
>>
>> The goal is to stop some hardware when the system is suspended, in order
>> to save some power.
> Yes correct,
>>
>> Why did you removed it?
>>
> 
> devm_clk_get_enabled  function register callback for clk_prepare_enable
> and clk_disable_unprepare, so when the clock resource is not used it should get
> disabled.

Same explanation as in the other patch.

The registered function is called when the driver is *unloaded*, not 
when it magically knows that some things can be disabled or enabled.

CJ

> 
> [0] https://elixir.bootlin.com/linux/latest/source/drivers/clk/clk-devres.c#L75
> 
> I have also tested with rtc suspend & resume and did not find any issue.
> 
>> CJ
> 
> Thanks
> -Anand
>>
>>> -
>>>        return rc;
>>>    }
>>>
>>>    static int exynos_ehci_resume(struct device *dev)
>>>    {
>>>        struct usb_hcd *hcd = dev_get_drvdata(dev);
>>> -     struct exynos_ehci_hcd *exynos_ehci = to_exynos_ehci(hcd);
>>>        int ret;
>>>
>>> -     ret = clk_prepare_enable(exynos_ehci->clk);
>>> -     if (ret)
>>> -             return ret;
>>> -
>>>        ret = exynos_ehci_phy_enable(dev);
>>>        if (ret) {
>>>                dev_err(dev, "Failed to enable USB phy\n");
>>> -             clk_disable_unprepare(exynos_ehci->clk);
>>>                return ret;
>>>        }
>>>
>>
> 
> 


