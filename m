Return-Path: <linux-kernel+bounces-162035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83308B54ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB74D1C21993
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6A32DF84;
	Mon, 29 Apr 2024 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDOf5vAp"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAF28DDA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385889; cv=none; b=m3OqSutTSQVSGRzqx0nEeijm5FMWMBm0diq/ddhPuoKkTlZVtfkkRS5txMW8EKBAwdXj/ulG+Jnhz9c2b87wwfr7rozMSHIEzbTz5pspxz0VQnNejQ7L/xlrYgPBCPDOH6rhGYeCuX5V/MfhNAIWSslC1E7UrWJqJnubkxFyBSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385889; c=relaxed/simple;
	bh=9OxJdSJcTIMwB7q8iwXx3F7KXUKFeRcnzCHH/BGixRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jttvhHJqYsP2bg98qMSIQL0d5c0KViR6n3qOyh+Nr4c+0PfsoYevGmOpfO441Q7hB6jwyteyy57WPXM/qIoSbi/b5sg814e74F880B8dsEgo2qj5bCFM4DW2IBEm2igeikakTpgwws3kwAiV6sPw0FUaRden7jM2kJZnJUiMZEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDOf5vAp; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so5893927e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714385886; x=1714990686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vG6mjxjJjtSQc9TlcX9p2HiWVoqe/DTppVNc6Ca1Fjw=;
        b=CDOf5vApIBiK9z6PPzJabJnl9G2ghSmjySK3Gqpn1WDrzmYkk1bBmvLiioHfgzBxKg
         tpXjr8U0TesD5Af0a0U0ssWzDIsEF5JzFGxS9NfakvDEZacwdiXLrF+iFnuP/GT6JM7b
         1YSy9u5Q1JI6LAjyw0l8CcdD6cGMRoAf86AjVTF9cvoKpKEQ3Nr3/iydnQwDaS0fCT+p
         1rvnSLVGzqPN+93NGvr3YRTYgbF2SfGhlVsaBywINm08GwcWYg2riFzHw5BJvdhIaGEb
         +LwyI+2ZNm3ocZcxnf1U9chVAKkE+F+7DHfOk+f46OIy4zwxMzh5QSixkyDZnOcomuCD
         gFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714385886; x=1714990686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vG6mjxjJjtSQc9TlcX9p2HiWVoqe/DTppVNc6Ca1Fjw=;
        b=FPCvBk1OPNzh0O3y3AC3W/o6IYLwOpYMxYrvThJs1X1daKPXDO0xLdH4lKeY+58Abe
         Qk6unAJBpv4fwaG6EjuJL+v1fzy8WI6OhehiEaLmPLkJzvDHWEQxQf6SZ/UkhrzLd8PM
         Z9FC6p5orNOeU7UeQpsG0vRcWxEXa4hpi9n7MdUHfYa3NwcSz/hJMmbJThsvAozdgSUw
         +Bl/m+h8tM6InBq537B+R9Po28n55BDF2+S6ANqynN+ATNLyfOIpfWaETf3zrls9UFGo
         r4WWvIzP59YDWYqMgdO9KlVx1KUSF/nkXE9YCEJaNbaFXIHiZYoK6zE4aJ2dDZTRd9hg
         qCUA==
X-Forwarded-Encrypted: i=1; AJvYcCV7OnO0sSgpp/hVPnU/V/RDs3o9zXP0zUJnmH9Llizk+0iF5jWtEInukiPVIPlcGAL/ap8AQ1GFSrXshRTX5unDpcQm7ewshBjlRZFC
X-Gm-Message-State: AOJu0YxDqdJ4n2F5LqLE19bWMMDXkowJwZuFFzaqVO6bSnUxFNKCi7T0
	0nuH5LVtFxao4QKUahTv/uYuE58xUbsjpVhYHED68d7CusG2l8sU
X-Google-Smtp-Source: AGHT+IGSPN4AviRPoM7S/IqlvAqi7BcS43DcAWjVIhaXsVDMUZAhq3NeMgdQEQTPx+YFHwV8TBrUJQ==
X-Received: by 2002:a05:6512:ba1:b0:51d:162e:bf9e with SMTP id b33-20020a0565120ba100b0051d162ebf9emr4663078lfv.15.1714385885569;
        Mon, 29 Apr 2024 03:18:05 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id eo14-20020a056402530e00b0057259943ba2sm3435405edb.12.2024.04.29.03.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 03:18:04 -0700 (PDT)
Message-ID: <94d947d9-7722-44be-877e-fdb39df1a12e@gmail.com>
Date: Mon, 29 Apr 2024 12:18:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/kmb: Replace of_node_put() with automatic cleanup
 handler
To: Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Julia Lawall <julia.lawall@inria.fr>
References: <20240410-kmb_of_node_put-v1-1-4d802add6a89@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240410-kmb_of_node_put-v1-1-4d802add6a89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/24 22:45, Javier Carrasco wrote:
> Make use of the __free() cleanup handler to automatically free nodes
> when they get out of scope.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> The patch is based on the latest linux-next tag (next-20240410).
> ---
>  drivers/gpu/drm/kmb/kmb_drv.c | 13 ++++---------
>  drivers/gpu/drm/kmb/kmb_dsi.c | 11 ++++-------
>  2 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
> index 169b83987ce2..1a743840688a 100644
> --- a/drivers/gpu/drm/kmb/kmb_drv.c
> +++ b/drivers/gpu/drm/kmb/kmb_drv.c
> @@ -480,8 +480,8 @@ static int kmb_probe(struct platform_device *pdev)
>  	struct device *dev = get_device(&pdev->dev);
>  	struct kmb_drm_private *kmb;
>  	int ret = 0;
> -	struct device_node *dsi_in;
> -	struct device_node *dsi_node;
> +	struct device_node *dsi_in __free(device_node) =
> +		of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
>  	struct platform_device *dsi_pdev;
>  
>  	/* The bridge (ADV 7535) will return -EPROBE_DEFER until it
> @@ -491,28 +491,23 @@ static int kmb_probe(struct platform_device *pdev)
>  	 *  and then the rest of the driver initialization can proceed
>  	 *  afterwards and the bridge can be successfully attached.
>  	 */
> -	dsi_in = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
>  	if (!dsi_in) {
>  		DRM_ERROR("Failed to get dsi_in node info from DT");
>  		return -EINVAL;
>  	}
> -	dsi_node = of_graph_get_remote_port_parent(dsi_in);
> +	struct device_node *dsi_node __free(device_node) =
> +		of_graph_get_remote_port_parent(dsi_in);
>  	if (!dsi_node) {
> -		of_node_put(dsi_in);
>  		DRM_ERROR("Failed to get dsi node from DT\n");
>  		return -EINVAL;
>  	}
>  
>  	dsi_pdev = of_find_device_by_node(dsi_node);
>  	if (!dsi_pdev) {
> -		of_node_put(dsi_in);
> -		of_node_put(dsi_node);
>  		DRM_ERROR("Failed to get dsi platform device\n");
>  		return -EINVAL;
>  	}
>  
> -	of_node_put(dsi_in);
> -	of_node_put(dsi_node);
>  	ret = kmb_dsi_host_bridge_init(get_device(&dsi_pdev->dev));
>  
>  	if (ret == -EPROBE_DEFER) {
> diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
> index cf7cf0b07541..61f02462b778 100644
> --- a/drivers/gpu/drm/kmb/kmb_dsi.c
> +++ b/drivers/gpu/drm/kmb/kmb_dsi.c
> @@ -216,8 +216,6 @@ static const struct mipi_dsi_host_ops kmb_dsi_host_ops = {
>  
>  int kmb_dsi_host_bridge_init(struct device *dev)
>  {
> -	struct device_node *encoder_node, *dsi_out;
> -
>  	/* Create and register MIPI DSI host */
>  	if (!dsi_host) {
>  		dsi_host = kzalloc(sizeof(*dsi_host), GFP_KERNEL);
> @@ -239,21 +237,20 @@ int kmb_dsi_host_bridge_init(struct device *dev)
>  	}
>  
>  	/* Find ADV7535 node and initialize it */
> -	dsi_out = of_graph_get_endpoint_by_regs(dev->of_node, 0, 1);
> +	struct device_node *dsi_out __free(device_node) =
> +		of_graph_get_endpoint_by_regs(dev->of_node, 0, 1);
>  	if (!dsi_out) {
>  		DRM_ERROR("Failed to get dsi_out node info from DT\n");
>  		return -EINVAL;
>  	}
> -	encoder_node = of_graph_get_remote_port_parent(dsi_out);
> +	struct device_node *encoder_node __free(device_node) =
> +		of_graph_get_remote_port_parent(dsi_out);
>  	if (!encoder_node) {
> -		of_node_put(dsi_out);
>  		DRM_ERROR("Failed to get bridge info from DT\n");
>  		return -EINVAL;
>  	}
>  	/* Locate drm bridge from the hdmi encoder DT node */
>  	adv_bridge = of_drm_find_bridge(encoder_node);
> -	of_node_put(dsi_out);
> -	of_node_put(encoder_node);
>  	if (!adv_bridge) {
>  		DRM_DEBUG("Wait for external bridge driver DT\n");
>  		return -EPROBE_DEFER;
> 
> ---
> base-commit: 6ebf211bb11dfc004a2ff73a9de5386fa309c430
> change-id: 20240410-kmb_of_node_put-aaf1c77d9610
> 
> Best regards,

Hi,

according to Patchwork, this patch is still marked as "new", but also
"archived", and still did not get any feedback.

Apparently, this new cleanup mechanism has already been applied to the
subsystem's code (at least in drm/exynos/exynos_hdmi.c in linux-next),
and this one would not be the first case anymore.

Thanks and best regards,
Javier Carrasco

