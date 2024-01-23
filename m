Return-Path: <linux-kernel+bounces-35254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C71838EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D121B246C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4D75D906;
	Tue, 23 Jan 2024 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NonuuLgn"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B1955E60
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706013359; cv=none; b=FkC2y7e/Z9+RcOlgsr7o7NhofT1tIEyo/FmHThXt/Ze6DdGB8Rpn4mNGzneZzKP5QV9RxAbFr7R5G2EqK4z/IgmdZl8G01ElaCcnp45pnDexUtLUD5kIwgkZDyri9qp9HqWe1t9f2pSFWMSzt90bQXPeVvg/aSnGN5XGbb6vTjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706013359; c=relaxed/simple;
	bh=8/zTT+iZ/oo1tm0R1k3Sjrqd19V/Jx1/9DafHWx+Dag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvyDlgENjMWJDMMhE3E5VRQJ3O9nBxnww2gHU6D71EIdi/S/jxE+S1j6OBRyf6dhGTMCzn9gNPFWvmK7ZFPpG5M7XcG3SEAQjCnVi4h6Bgq58LmR3EG9tg6lHBvjtqq1Qn0kC8q6iOPJzjUCqMUftx5JOa9Pfvi/H/60OXjKZmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NonuuLgn; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5b0e1b73-9a94-4ab5-b30d-59caea8954cb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706013355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q104h3QlUtguKNU196gINZbfXFac0qkpzQO4Cu5ARaE=;
	b=NonuuLgnbwm4TnzPT2hLumdstqoqmJBJsfPv8LB60gKfqePWFPiJzILiH9PccobXB1PieG
	lO6t2H72mcCMoEa4wh3Cn6pJ5TfzFOVVP3C+sif+Hgd4yFWJCvb7ZloelXh72zvS+vJmNu
	3+nAiscLqw5LpVHBJkVX7VwpoButdoE=
Date: Tue, 23 Jan 2024 20:35:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] drm-bridge: display-connector: Switch to use fwnode
 API
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sui Jingfeng <suijingfeng@loongson.cn>
References: <20240122163220.110788-1-sui.jingfeng@linux.dev>
 <20240122163220.110788-6-sui.jingfeng@linux.dev>
 <20240123012026.GC22880@pendragon.ideasonboard.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240123012026.GC22880@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/1/23 09:20, Laurent Pinchart wrote:
> On Tue, Jan 23, 2024 at 12:32:20AM +0800, Sui Jingfeng wrote:
>> From: Sui Jingfeng<suijingfeng@loongson.cn>
>>
>> Because API has wider coverage, it can be used on non-DT systems as well.
>>
>> Signed-off-by: Sui Jingfeng<suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/bridge/display-connector.c | 22 ++++++++++++----------
>>   1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
>> index eb7e194e7735..2c3e54a458e8 100644
>> --- a/drivers/gpu/drm/bridge/display-connector.c
>> +++ b/drivers/gpu/drm/bridge/display-connector.c
>> @@ -243,8 +243,8 @@ static int display_connector_probe(struct platform_device *pdev)
>>   	case DRM_MODE_CONNECTOR_DVII: {
>>   		bool analog, digital;
>>   
>> -		analog = of_property_read_bool(pdev->dev.of_node, "analog");
>> -		digital = of_property_read_bool(pdev->dev.of_node, "digital");
>> +		analog = fwnode_property_present(pdev->dev.fwnode, "analog");
>> +		digital = fwnode_property_present(pdev->dev.fwnode, "digital");
>>   		if (analog && !digital) {
>>   			conn->bridge.type = DRM_MODE_CONNECTOR_DVIA;
>>   		} else if (!analog && digital) {
>> @@ -261,8 +261,8 @@ static int display_connector_probe(struct platform_device *pdev)
>>   	case DRM_MODE_CONNECTOR_HDMIA: {
>>   		const char *hdmi_type;
>>   
>> -		ret = of_property_read_string(pdev->dev.of_node, "type",
>> -					      &hdmi_type);
>> +		ret = fwnode_property_read_string(pdev->dev.fwnode, "type",
>> +						  &hdmi_type);
>>   		if (ret < 0) {
>>   			dev_err(&pdev->dev, "HDMI connector with no type\n");
>>   			return -EINVAL;
>> @@ -292,7 +292,7 @@ static int display_connector_probe(struct platform_device *pdev)
>>   	conn->bridge.interlace_allowed = true;
>>   
>>   	/* Get the optional connector label. */
>> -	of_property_read_string(pdev->dev.of_node, "label", &label);
>> +	fwnode_property_read_string(pdev->dev.fwnode, "label", &label);
>>   
>>   	/*
>>   	 * Get the HPD GPIO for DVI, HDMI and DP connectors. If the GPIO can provide
>> @@ -330,12 +330,13 @@ static int display_connector_probe(struct platform_device *pdev)
>>   	if (type == DRM_MODE_CONNECTOR_DVII ||
>>   	    type == DRM_MODE_CONNECTOR_HDMIA ||
>>   	    type == DRM_MODE_CONNECTOR_VGA) {
>> -		struct device_node *phandle;
>> +		struct fwnode_handle *fwnode;
>>   
>> -		phandle = of_parse_phandle(pdev->dev.of_node, "ddc-i2c-bus", 0);
>> -		if (phandle) {
>> -			conn->bridge.ddc = of_get_i2c_adapter_by_node(phandle);
>> -			of_node_put(phandle);
>> +		fwnode = fwnode_find_reference(pdev->dev.fwnode, "ddc-i2c-bus", 0);
>> +		if (!IS_ERR_OR_NULL(fwnode)) {
>> +			dev_info(&pdev->dev, "has I2C bus property\n");
> This looks like a debugging leftover.


Yes, thanks a lot for reviewing.
I will pick up suggestions and go back to improve.


