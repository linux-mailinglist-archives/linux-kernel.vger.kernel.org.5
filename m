Return-Path: <linux-kernel+bounces-34218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505E18375BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F7BB2228F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D3A48785;
	Mon, 22 Jan 2024 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqW4IbvL"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3D48783;
	Mon, 22 Jan 2024 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960822; cv=none; b=H/Ypq2GOaQroksUCZot7B0uTvU5eA89BTYd1Oi/wcNIyU/FVxLMO2Qk/I8DO51RDfkLS0AP/62mUnrDN2qPtWbdm4dffza4AYClu43uHlZyqeWNi9OzPV/4s5DPj2HlPIxpTvWAVATxOhGpuEYecj60TrT2JbSXZmbj6HtPM9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960822; c=relaxed/simple;
	bh=pApvADJl9fMA7demmpX7fsFUg2W2TRHf3DlG6DAc1KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALBCg9R+5vECL51JpE6XAFpM7SGCzwSpISEWYkBUdIS4+e1IVw7rmlKAF2FSRNTvqxN2uwBy3ddRTVuHy6dOxijtDJzToz2Z5te2fxuMvajHS68OzavfgCNrj0ynHW0ogOMjbJfgMZNX7zqZqLy+IDDcDBpzFs+/mRHKwYjJ+XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqW4IbvL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6daa89a6452so2299188b3a.2;
        Mon, 22 Jan 2024 14:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705960819; x=1706565619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KOxKklqKxAhixHhGO9IYZU8YD3pfPEEr+M26aVvkW1I=;
        b=NqW4IbvLkEFNpyFV416wHqmvDq2YxzQHyBQlWFn/sthADbKHVi+l+pkrwVI/uCCCTy
         +G2SB5KBL3TlxDYepazs/PmBOR3adSVRav8fLZ/Z2AHFupsxJTajYKiynfeuyyvzyp1u
         Fyrx3vfuRPJY3t6ATo/EK68BeT6E4Joy7L/+oB8L4l173WfrHWczQ5eikpxHdaaZNgxo
         oYEQS7FIu7NifM4YkC/IEWPFGuKTDmonavpt/w5kvIzJHuF7We41u9MQtRxYCBUGrXDx
         etWgt71ywLnXipari79p3GcytKkWnuJo3Dk27IoO7fEFevAtvn3uwNA+S8quoGKq1Nrf
         5zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705960819; x=1706565619;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOxKklqKxAhixHhGO9IYZU8YD3pfPEEr+M26aVvkW1I=;
        b=pbn2S2zfSVGIOoEbhISGpaz4/fp74V+s076LEAPAp4u664ezve59bhV7q16TK6Z6GW
         LlHxddQpfktV3oEysl6zH4JpesK45eo5HH7KFfew/1+j0zu6ApGFBzaA9IV8kenw6mqm
         yQ7/vMrm4p2NQOnhah0HiPl4avyTTMPtAr8IkRy13bxksLF8qc1ytb3rhLp7xfcQaY/s
         0Yh3DoNvtuudcnUNkGceOeNm5uREZXn/2bwUJySwk97YLNpCVHsHDJmL1c0FouxbQ/GT
         4f/iFVeH5XxICu7B/kGfc//JMdR5plgdJs8danenle8RTZsgAcDuABXtxn3v6j56/0fb
         wEzQ==
X-Gm-Message-State: AOJu0YzeXtSazuuSl6nxzb5LqqJEBPkxUvhHU1nil/RwF+8Pbr2LxCOC
	woTC37JI1JM36eNX3rgW4REj7XgC3tH1bLp7E5S8aLs0UzyJYTuW
X-Google-Smtp-Source: AGHT+IEer+di7GG9CZ717Lyqskd8xlF/qrzwHf/cemAmLSige+muAWV8KP2DvDinSAzoXgy/d4sqqQ==
X-Received: by 2002:a05:6a20:160a:b0:19b:5666:1a2f with SMTP id l10-20020a056a20160a00b0019b56661a2fmr2665924pzj.72.1705960819098;
        Mon, 22 Jan 2024 14:00:19 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a00198d00b006d9bcf301ffsm10066068pfl.194.2024.01.22.14.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 14:00:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <12c09939-0f85-4492-b636-c3fb5b01dd66@roeck-us.net>
Date: Mon, 22 Jan 2024 14:00:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] watchdog: rzg2l_wdt: Add suspend/resume support
Content-Language: en-US
To: Jerry.Hoemann@hpe.com
Cc: Claudiu <claudiu.beznea@tuxon.dev>, wim@linux-watchdog.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com>
 <20240122111115.2861835-8-claudiu.beznea.uj@bp.renesas.com>
 <a5a807c1-76ef-4cf7-a2cf-bc432c420ded@roeck-us.net>
 <20240122210553.GA2731@perchik>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240122210553.GA2731@perchik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 13:05, Jerry Hoemann wrote:
> On Mon, Jan 22, 2024 at 09:39:27AM -0800, Guenter Roeck wrote:
>> On 1/22/24 03:11, Claudiu wrote:
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> The RZ/G3S supports deep sleep states where power to most of the IP blocks
>>> is cut off. To ensure proper working of the watchdog when resuming from
>>> such states, the suspend function is stopping the watchdog and the resume
>>> function is starting it. There is no need to configure the watchdog
>>> in case the watchdog was stopped prior to starting suspend.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>> ---
>>>    drivers/watchdog/rzg2l_wdt.c | 26 ++++++++++++++++++++++++++
>>>    1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
>>> index 9333dc1a75ab..186796b739f7 100644
>>> --- a/drivers/watchdog/rzg2l_wdt.c
>>> +++ b/drivers/watchdog/rzg2l_wdt.c
>>> @@ -279,6 +279,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
>>>    	priv->wdev.timeout = WDT_DEFAULT_TIMEOUT;
>>>    	watchdog_set_drvdata(&priv->wdev, priv);
>>> +	dev_set_drvdata(dev, priv);
>>>    	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv->wdev);
>>>    	if (ret)
>>>    		return ret;
>>> @@ -300,10 +301,35 @@ static const struct of_device_id rzg2l_wdt_ids[] = {
>>>    };
>>>    MODULE_DEVICE_TABLE(of, rzg2l_wdt_ids);
>>> +static int rzg2l_wdt_suspend_late(struct device *dev)
>>> +{
>>> +	struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
>>> +
>>> +	if (!watchdog_active(&priv->wdev))
>>> +		return 0;
>>> +
>>> +	return rzg2l_wdt_stop(&priv->wdev);
>>> +}
>>> +
>>> +static int rzg2l_wdt_resume_early(struct device *dev)
>>> +{
>>> +	struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
>>> +
>>> +	if (!watchdog_active(&priv->wdev))
>>> +		return 0;
>>> +
>>> +	return rzg2l_wdt_start(&priv->wdev);
>>> +}
>>> +
>>> +static const struct dev_pm_ops rzg2l_wdt_pm_ops = {
>>> +	LATE_SYSTEM_SLEEP_PM_OPS(rzg2l_wdt_suspend_late, rzg2l_wdt_resume_early)
>>> +};
>>> +
>>>    static struct platform_driver rzg2l_wdt_driver = {
>>>    	.driver = {
>>>    		.name = "rzg2l_wdt",
>>>    		.of_match_table = rzg2l_wdt_ids,
>>> +		.pm = pm_ptr(&rzg2l_wdt_pm_ops),
>>
>> I think this will create a build error if CONFIG_PM=n because rzg2l_wdt_pm_ops
>> will be unused but is not marked with __maybe_unused. But then the driver won't be
>> operational with CONFIG_PM=n, so I really wonder if it makes sense to include any
>> such conditional code instead of making the driver depend on CONFIG_PM.
>>
>> I really don't think it is desirable to suggest that the driver would work with
>> CONFIG_PM=n if that isn't really true.
>>
>> Guenter
> 
> Guenter,
> 
> I'm working on a similar patch.
> 
> Is your concern limited to the use of the "pm_ptr" macro?  Or is it
> wider?
> 

patch 3/10 adds an error check of the return value from pm_runtime_put().
pm_runtime_put() calls __pm_runtime_idle() which returns -ENOSYS if
CONFIG_PM=n. That means checking the return value of pm_runtime_put()
is equivalent to making CONFIG_PM mandatory. My argument is that this
should be expressed in Kconfig to avoid the impression that the driver
works with CONFIG_PM=n. If the driver depends on CONFIG_PM, pm_ptr()
is unnecessary. If it doesn't, the variable referenced by it needs
to be defined as __maybe_unused, but then the driver should actually
work with CONFIG_PM=n.

Yes, I have noticed the recent trend of adding error checks to
pm_runtime_put(), but I only now realized that it has consequences.

Guenter


