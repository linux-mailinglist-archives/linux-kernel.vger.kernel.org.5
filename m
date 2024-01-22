Return-Path: <linux-kernel+bounces-32757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627AB835FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8401C24BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B58C31A78;
	Mon, 22 Jan 2024 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCu0/mcs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B878A3A262;
	Mon, 22 Jan 2024 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919515; cv=none; b=AnTRGq3HEHpb0Fs3dBJpVwmveZ2F3EaT5pP8cqTvH5FYKABHmRM8TmIEPI5QsCSVr2Kh1UGi2cWU9cXl6wGB/X7v27youXsuLl2A052fLx3AmGvYStSjKKrqzTPrgW9jYilcr/2uZj2rkdysfgQKYjpDcW//6To0RZ4uOsO31DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919515; c=relaxed/simple;
	bh=3MlX9iGWyIhVvgtO5vkH1utrGmEPUsa+siylSAZ+4FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pRNQF/BAz8y1rRyMUC4uiyKy9OVVzNp9KjkN0NIL4JiEkB5S6EoNqkdEBNZ+4xDj4KdLnA6KMgspUS4Ocr5JJhDMIGcRAO3ydUz3iVR5Zdewd1Ln4euUIRsNtWNXoo3cxvQ9rZjJkK3lfzGRMMbP2RDCMDtZ7RUwC2qC5CbBkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCu0/mcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BA2C433F1;
	Mon, 22 Jan 2024 10:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705919515;
	bh=3MlX9iGWyIhVvgtO5vkH1utrGmEPUsa+siylSAZ+4FE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rCu0/mcsmI0Ix8l017V62+/Elst5qRKhRr/59QLPK9ERjpJ+q8N8YY1RpBAw6NsOT
	 b5OqMB1FoXP9+S7e/LWXMMqQS+EEOn4SizRrzRil/xYA0YFW6hotcSLm3J5FuEA2hr
	 9cZxuzxGVe6t19KWiLPDKMT7iu0dwdmI7TlbOofJZFYSF6BoqFFp1DXcXT5y3c8hGB
	 hILUnPVGg0TSflYoV0VBDCAYoIFL4fUrUG1Ka+41Q/Pzguxfk++k3t1sGUj/H7EZoK
	 KHPNVPWk8NWXlhJTan+SODgvd674q+pcc9fhechF2jScASGfpmWEKvkZePOny9KVrL
	 MmFyBHyIA5C7Q==
Message-ID: <1e7b8590-7dc7-47a8-8105-6d01db627f85@kernel.org>
Date: Mon, 22 Jan 2024 11:31:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] watchdog: Add ChromeOS EC-based watchdog driver
Content-Language: en-US
To: Lukasz Majczak <lma@chromium.org>, Gwendal Grignou
 <gwendal@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Radoslaw Biernacki <biernacki@google.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Lee Jones <lee@kernel.org>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev
References: <20240119084328.3135503-1-lma@chromium.org>
 <20240119084328.3135503-3-lma@chromium.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240119084328.3135503-3-lma@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/2024 09:43, Lukasz Majczak wrote:
> Embedded Controller (EC) present on Chromebook devices
> can be used as a watchdog.
> Implement a driver to support it.
> 


..

> +static int cros_ec_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
> +	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
> +	struct watchdog_device *wdd;
> +	union cros_ec_wdt_data arg;
> +	int ret = 0;
> +
> +	wdd = devm_kzalloc(&pdev->dev, sizeof(struct watchdog_device), GFP_KERNEL);

sizeof(*)

> +	if (!wdd)
> +		return -ENOMEM;
> +
> +	arg.req.command = EC_HANG_DETECT_CMD_GET_STATUS;
> +	ret = cros_ec_wdt_send_cmd(cros_ec, &arg);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get watchdog bootstatus");
> +
> +	wdd->parent = &pdev->dev;
> +	wdd->info = &cros_ec_wdt_ident;
> +	wdd->ops = &cros_ec_wdt_ops;
> +	wdd->timeout = CROS_EC_WATCHDOG_DEFAULT_TIME;
> +	wdd->min_timeout = EC_HANG_DETECT_MIN_TIMEOUT;
> +	wdd->max_timeout = EC_HANG_DETECT_MAX_TIMEOUT;
> +	if (arg.resp.status == EC_HANG_DETECT_AP_BOOT_EC_WDT)
> +		wdd->bootstatus = WDIOF_CARDRESET;
> +
> +	arg.req.command = EC_HANG_DETECT_CMD_CLEAR_STATUS;
> +	ret = cros_ec_wdt_send_cmd(cros_ec, &arg);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to clear watchdog bootstatus");
> +
> +	watchdog_stop_on_reboot(wdd);
> +	watchdog_stop_on_unregister(wdd);
> +	watchdog_set_drvdata(wdd, cros_ec);
> +	platform_set_drvdata(pdev, wdd);
> +
> +	return devm_watchdog_register_device(dev, wdd);
> +}
> +
> +static int __maybe_unused cros_ec_wdt_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct watchdog_device *wdd = platform_get_drvdata(pdev);
> +	int ret = 0;
> +
> +	if (watchdog_active(wdd))
> +		ret = cros_ec_wdt_stop(wdd);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused cros_ec_wdt_resume(struct platform_device *pdev)
> +{
> +	struct watchdog_device *wdd = platform_get_drvdata(pdev);
> +	int ret = 0;
> +
> +	if (watchdog_active(wdd))
> +		ret = cros_ec_wdt_start(wdd);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver cros_ec_wdt_driver = {
> +	.probe		= cros_ec_wdt_probe,
> +	.suspend	= pm_ptr(cros_ec_wdt_suspend),
> +	.resume		= pm_ptr(cros_ec_wdt_resume),
> +	.driver		= {
> +		.name	= DRV_NAME,
> +	},
> +};
> +
> +module_platform_driver(cros_ec_wdt_driver);
> +
> +static const struct platform_device_id cros_ec_wdt_id[] = {
> +	{ DRV_NAME, 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, cros_ec_wdt_id);

device_id is not placed here, please open existing drivers for
reference. Why this isn't referenced in driver structure?

> +MODULE_DESCRIPTION("Cros EC Watchdog Device Driver");
> +MODULE_LICENSE("GPL");

Best regards,
Krzysztof


