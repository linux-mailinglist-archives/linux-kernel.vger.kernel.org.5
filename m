Return-Path: <linux-kernel+bounces-134063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE2289ACB7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 20:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A2C1F211D1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793B14CB45;
	Sat,  6 Apr 2024 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="aC1J19Ic"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014512E400;
	Sat,  6 Apr 2024 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712429836; cv=none; b=I/U9s57DeagUOeLWfgowvla7XVja6ocgXenOwFh1GY1b2KvVgLvOLlR40hFqvR9yggVvZ72RkLfl/9COLX2uO8ek04y8Y0vLzNhFgXf52qhPz0k2ggImargp9RyewfihDBoAlGPeSRsOXNYd8w+POECgpbJm6NYz5STEIXleezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712429836; c=relaxed/simple;
	bh=WAwIw/MLBYLUVgD0m6GquIMTDruiOiSlIHl+3RfeCVA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KIiWqPJMuajyl89FlP21xrQ+bxnmnx7gff5FtcebAz7CGFGVj6EM0+hRdzOjuw4CXfpQluVUiU5eZDJ4T6OmUrUyr1U3BRaiCtTJP0SZAJU76JKd3hPZHnRFsHvvqfNjz0XKK867ZuUCq8Udfh2IzgIpo6MFu46W7BfYmZrnBWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=aC1J19Ic; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712429822; x=1713034622; i=w_armin@gmx.de;
	bh=2aOurW5Cd5Uw6SZMXDN5iRUn26UMquU9Ugd7mKHNdMY=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=aC1J19IcXiqcTkXk7BmYQRxgY17tHtAbSAgNjBu5177GrbLNfwvp8IWbyYagCEAJ
	 6/HuVG5vrwNxoMcjzlziMBgtzbRchb837qnCqCITuUXH2BHVzx18eMBS3eYROqiNx
	 WbNJnhm6IMnMSXRHJpCzTyFBrNKFMgToYFQsuSffAJbyz/UCzgaQw9cvrkfxe1q5V
	 OA9Y3uN6ajdOMJz6kuNXQudNcT9zpERCT7xhyxilNlBKBEt/ih9HSakvw60XmMKv5
	 xHfDiK/cttNypgSbw4uFiP175ocq/v18VhUYKjhZq96DvExhjx4d07XdPC+LBMPqC
	 hZ+zIx2wEA+lWfnLQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwwdl-1shxHp0Q1r-00yNK9; Sat, 06
 Apr 2024 20:57:02 +0200
Message-ID: <f662fab0-0f47-4b71-ab71-2b9492253483@gmx.de>
Date: Sat, 6 Apr 2024 20:57:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: quickstart: Fix race condition when
 reporting input event
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327214524.123935-1-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20240327214524.123935-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gYZ/ru4E3uFgyw1J6uyPIn4b2hNb0LEhUIeZjSbNAegQD7IZbcx
 rUZOjGGZxnThA5UazhG8iaBfi8xu2mZ27ic0jtz3aTMaKkW/HPtvSUyiB9tZvpO+1z1WZMr
 lbpF60dbucJK1Mep/oj4oEJk81nIU5k+c7yJqYRfmsqwx9mk4s8eKONttfQRlF2mmopo4lR
 5Dm+r1yZ7S3ueb85W4vCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pASYl1kF/LE=;j5zV2jq4yTXSOqJNJYnPNOQ6jGZ
 LB7GSHjl/MwG1g2XUNwOvN5yc/EPERVXgoKudEwYVf1ONmUPmJuTZqfe0F6wArPWqdJgVhHvf
 ssmVn/KW81TWpIm2SYBbdBF+7gOpeBdc5W/qL7AZDJPeF30auSdvijlLpoIU2RHNNHDWQIsel
 CgBWcHGuPbhnLysqFLAKxdm/vpm9a5rwwAPDTpWjToQ2nvdJO2moXNo9zvjFegvk9fzGnDiyb
 ISc2rtQasUzEcVABzufCcc2sZ2Xxkll3wphWr04A/sR+bgL2jVdn3DZEo04g8CN8OO4AXnmo2
 F7fHV2bmAngyy57SNdCiGrd3DF7r/3TbJAyV6jKjy8N5Ie3+7wMjWngxHJZsCUNZ73iZsGXQM
 TQWpums83MLPn2qiq3qKIunp7NHXOgVJcToOH3urqsR7o3mAN2lC13aP2ISFN5qpyHUjkChJ4
 2PuBfjKbAtQyQFl0J84vh2ows4yF+/5I+xt/tnTGV+ohsYnFh4nbQwLA3IIMM2QZQJrlJwHpV
 izdO8GrA0Qwv2ets5xrRB5bC9m51uO83MLp4wCiqAjdt35YOR5/HzJTt+ag9+S0XxxYfpEyT2
 JERFDXKJLWl+7iR02vzCwnDZzvHfIbBlyRM1qniOQ2+aivp94LdgX4nIFzU02vAdN7b3Em6nQ
 gJLtV61Actqh9M8eS+z55EVkA5iNU5FLCOUy03ne5Sjuxg418naNjZLwUROAEPDYAP8zsYsg2
 4i6d8FBynQpB/lBJ6qk0lWCt1ZO+OByeLVaKgWLDn3K0WhW8FocH6KCzYaDZ8q1ztgDXM4h/G
 vWtYi9i8zt2r7V3I84ugJCUIxVfKZBccNxDgNlKmniZIo=

Am 27.03.24 um 22:45 schrieb Armin Wolf:

> Since commit e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to run
> on all CPUs"), the ACPI core allows multiple notify calls to be active
> at the same time. This means that two instances of quickstart_notify()
> running at the same time can mess which each others input sequences.
>
> Fix this by protecting the input sequence with a mutex.
>
> Compile-tested only.

Any thoughts on this?

Armin Wolf

> Fixes: afd66f2a739e ("platform/x86: Add ACPI quickstart button (PNP0C32) driver")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> This applies on the branch "review-hans". Maybe we could somehow
> document the concurrency rules for ACPI notify handlers?
> ---
>   drivers/platform/x86/quickstart.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/quickstart.c
> index ba3a7a25dda7..e40f852d42c1 100644
> --- a/drivers/platform/x86/quickstart.c
> +++ b/drivers/platform/x86/quickstart.c
> @@ -18,6 +18,7 @@
>   #include <linux/input/sparse-keymap.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> +#include <linux/mutex.h>
>   #include <linux/platform_device.h>
>   #include <linux/sysfs.h>
>   #include <linux/types.h>
> @@ -35,6 +36,7 @@
>
>   struct quickstart_data {
>   	struct device *dev;
> +	struct mutex input_lock;	/* Protects input sequence during notify */
>   	struct input_dev *input_device;
>   	char input_name[32];
>   	char phys[32];
> @@ -73,7 +75,10 @@ static void quickstart_notify(acpi_handle handle, u32 event, void *context)
>
>   	switch (event) {
>   	case QUICKSTART_EVENT_RUNTIME:
> +		mutex_lock(&data->input_lock);
>   		sparse_keymap_report_event(data->input_device, 0x1, 1, true);
> +		mutex_unlock(&data->input_lock);
> +
>   		acpi_bus_generate_netlink_event(DRIVER_NAME, dev_name(data->dev), event, 0);
>   		break;
>   	default:
> @@ -147,6 +152,13 @@ static void quickstart_notify_remove(void *context)
>   	acpi_remove_notify_handler(handle, ACPI_DEVICE_NOTIFY, quickstart_notify);
>   }
>
> +static void quickstart_mutex_destroy(void *data)
> +{
> +	struct mutex *lock = data;
> +
> +	mutex_destroy(lock);
> +}
> +
>   static int quickstart_probe(struct platform_device *pdev)
>   {
>   	struct quickstart_data *data;
> @@ -165,6 +177,11 @@ static int quickstart_probe(struct platform_device *pdev)
>   	data->dev = &pdev->dev;
>   	dev_set_drvdata(&pdev->dev, data);
>
> +	mutex_init(&data->input_lock);
> +	ret = devm_add_action_or_reset(&pdev->dev, quickstart_mutex_destroy, &data->input_lock);
> +	if (ret < 0)
> +		return ret;
> +
>   	/* We have to initialize the device wakeup before evaluating GHID because
>   	 * doing so will notify the device if the button was used to wake the machine
>   	 * from S5.
> --
> 2.39.2
>
>

