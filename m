Return-Path: <linux-kernel+bounces-108938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF30881248
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185E31F24C64
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF9041C86;
	Wed, 20 Mar 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aVFQoHPn"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F71405C1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941141; cv=none; b=sv//7Flk/PJ7rA4FsZwVJ/ha4ywyED3UBze5I6DpfP4EwTj6PnacwihRxIGRsw4ziJkKkkz0FX+BAnf8eMpAy/kzkbhYDZgRm44PinOdon7TthlTEop5s4uPXDplWzbSkYJf+1y/PAhjm1zxrHksuWkYDG+6J9ZwQLK9g8pqucU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941141; c=relaxed/simple;
	bh=gR/FUHdn3EPInPai+cCRTw8sGb1MxWEDTW6umqaTPzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+vG8VXkvpoVJPSLAQq0W38Di2tVugNtpiDSIllkrwBqXK+MjRY2tY11r9t46d0Pqk1BzlkEL939iAnpbZeRPMT7+s25acCxOeggLrqMhKYSA+J5LSAPb1N3LXDSQRRcUfGLhWBTrsk0V25k5IefaisJr+Mh5DbK5lAl5dbKW38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aVFQoHPn; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513d23be0b6so7241094e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710941136; x=1711545936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U+O+9Gk/MHV5z7NRBi1Il6wqa6Gb+IZES0piBkUl54A=;
        b=aVFQoHPnaDKgDkToXBGA9isd3Vv3eaDU7zEEbuvYX1cKKxj4JqNKgWOd9J2VrCtYBE
         sJzPNHrBP5lcy1mi4MDaASavoEfeH5A8XaXqSYDGT0Fz22YKu+ssgnLSjhSM3KkYTBXP
         v926fNbNLG7rNft8VuCRCjDPY9atrnVvR4Pxxh6AbsCpHqhI3VkRI8vzZxPZul4uH9WA
         VtlIJIUhVVeTPoAFHiw1dfhdXD3oc1OorBFt9WJYD/d3SflqmT19/zXNniNPtGzswt0C
         PhpttKHR5lfIc2jqyArjkx/kGZlL3MtuKhUJJ3l3322kZ2hM1DNX/YazsoWA5l4hvpon
         KSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710941136; x=1711545936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+O+9Gk/MHV5z7NRBi1Il6wqa6Gb+IZES0piBkUl54A=;
        b=tVf8Vbq6rlq612v6DTeIu0rwtXZR+ixOSW5+vx9k6IoXbeSMvW2oCl8RN/5zFKeVxP
         VvRQkXTLmXHK6B7l+Ork0/M5ZXLLFBdrAbXP9LkCTvC2EYgnyfNBjO/yYdoVLO+MohIT
         U4qtxKUEm5RsyFre0W2aAQi2rvZA/TcLIp0hRyiXHULx7ToVz8rUOGlub4evwBjBAyv1
         UClGjY3y9lrJFpS/bkEMxX+TjVcJN5X4T98y7Xw8sJtpfpExh2VFBTzvRuErYQang8Be
         C88DYmjkCwwiFTKsQpL1e5+b/GaeEc9VmB7fB/4ReaaQUXwcmTQQ/HBCF1gYGW0zjLrh
         9TgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7vC6aSzyQNsPVwPWhXsrie/lcYgEJRcphXkHQGpwKrqlt6wQxmH4cGR638eR7wRdTFqo/r7rDJ0SW6jnKWJCBXlj3IldLdkk+CsSQ
X-Gm-Message-State: AOJu0Yy1ysTDSEEVk0Msnqx81lYICXyzdKL/dmRczYBLM0sYOxrwOAoR
	QpHd1NHHCbfwdn0rIpAunBkv+IIDqB+8vI/G/99hkdLOidJmVXHQHWJFtF6c/eI=
X-Google-Smtp-Source: AGHT+IH1JTkwnk04Rj4pxpdQhzrL58EhI+ZavY62ptJIN0Og8Gbp4eITtl6DxXmmvXUKf33XTdi5ZA==
X-Received: by 2002:a05:6512:311c:b0:513:30fb:d64 with SMTP id n28-20020a056512311c00b0051330fb0d64mr1597089lfb.44.1710941136269;
        Wed, 20 Mar 2024 06:25:36 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id a8-20020a05600c348800b004146bee69aesm2077725wmq.40.2024.03.20.06.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:25:35 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:25:34 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, grundler@chromium.org,
	christian.riesch@omicron.at, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: asix: Add check for usbnet_get_endpoints
Message-ID: <ZfrjzjOuK8deu0Fp@nanopsycho>
References: <20240320073715.2002973-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320073715.2002973-1-nichen@iscas.ac.cn>

Wed, Mar 20, 2024 at 08:37:15AM CET, nichen@iscas.ac.cn wrote:
>Add check for usbnet_get_endpoints() and return the error if it fails
>in order to transfer the error.
>
>Fixes: b4cdae20ef95 ("asix: Rename asix.c to asix_devices.c")

Are you sure this is the commit that introduced this? Too lazy to look,
but most probably this just moved already buggy code.


>Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
>---
> drivers/net/usb/asix_devices.c | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
>index f7cff58fe044..4732a2951bf2 100644
>--- a/drivers/net/usb/asix_devices.c
>+++ b/drivers/net/usb/asix_devices.c
>@@ -230,7 +230,9 @@ static int ax88172_bind(struct usbnet *dev, struct usb_interface *intf)
> 	int i;
> 	unsigned long gpio_bits = dev->driver_info->data;
> 
>-	usbnet_get_endpoints(dev,intf);
>+	ret = usbnet_get_endpoints(dev, intf);
>+	if (ret < 0)

I don't think that usbnet_get_endpoints() can return positive value.
Better to have just:
	ret = usbnet_get_endpoints(dev, intf);
	if (ret)


>+		goto out;

just "return ret" here. I know that the rest of the function does this
too, don't copy odd pattern.


> 
> 	/* Toggle the GPIOs in a manufacturer/model specific way */
> 	for (i = 2; i >= 0; i--) {
>@@ -834,7 +836,9 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
> 
> 	dev->driver_priv = priv;
> 
>-	usbnet_get_endpoints(dev, intf);
>+	ret = usbnet_get_endpoints(dev, intf);
>+	if (ret < 0)
>+		return ret;
> 
> 	/* Maybe the boot loader passed the MAC address via device tree */
> 	if (!eth_platform_get_mac_address(&dev->udev->dev, buf)) {
>@@ -1258,7 +1262,9 @@ static int ax88178_bind(struct usbnet *dev, struct usb_interface *intf)
> 	int ret;
> 	u8 buf[ETH_ALEN] = {0};
> 
>-	usbnet_get_endpoints(dev,intf);
>+	ret = usbnet_get_endpoints(dev, intf);
>+	if (ret < 0)
>+		return ret;
> 
> 	/* Get the MAC address */
> 	ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID, 0, 0, ETH_ALEN, buf, 0);
>-- 
>2.25.1
>
>

