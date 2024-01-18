Return-Path: <linux-kernel+bounces-30640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFF483225D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25228B22E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0641EA91;
	Thu, 18 Jan 2024 23:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+F0HgWB"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CEB28E01;
	Thu, 18 Jan 2024 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705621501; cv=none; b=kNp4R+HzG8axviu8vwE9beIfW66w1GbVmgzE/6pZC094w9ddID+qGOZGnIK/KDhXhkOZGIFy8y+jAUtc2B7XBlt9c3grjr9y562E0b/swkav/n/0xq/C5zJmVG8bS1TVeC/X99o6isQaN9p1qgC+n6bG91SK9iBDheOv6rsjUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705621501; c=relaxed/simple;
	bh=aMNVLFTdi0wFxCWZ3XYNwXhJs/hL+2wuSEvdlhOwDiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDZmU6lcKTmla6vHz3MooWFEZLr7VqTlhEJrJfaRQJ+mM7iLAzLFWYgCuLZK9Sad5SN//Vbk+MToeSeezEjxrWHVej9L0JGNSnTMIzIkgjtboPNydkU9a6bWz3LWIGiZyIKeAb8t6NAJF1P4ZwxmlxjU0iIiC3Mh4juIHsGUxxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+F0HgWB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so277683b3a.0;
        Thu, 18 Jan 2024 15:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705621500; x=1706226300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JbKVsGP4/MpRrRwfY67K8Ab07+uO9p/eeTxIc4Yvmc=;
        b=b+F0HgWBLPdla5mHloY8puv83a7JL2/InmxMRFWwKAl2e6br0NNlaSpwkZMfgwpBk1
         mw8DKVtcoxEfG4Wsfsg7EAZgXntulHbBwSrnTCyQwxkm6HsHsdytaDniGntKboNnvIso
         gTF6nWiPjXj2QA26gDogPE+ShPMKseJGjHeMSOfPIrtnMUWPsragTHBYLmB0Yfodk5p7
         Kl3h0lBm4UQ3605106RgqYMyNRA9k4ytT2C3EN8btbTZfc/MA8wiCHNS5ibwcm3TXy+L
         sbBsL0O5bKvduVZ3hsa/bfPJ+Fv3pFa/yaFBieuSqiNqJr7jiKxgr7hrBGrOeDyhJbS2
         goBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705621500; x=1706226300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JbKVsGP4/MpRrRwfY67K8Ab07+uO9p/eeTxIc4Yvmc=;
        b=EqJzoPjS7R2S3rLiTq2FdU9eyon7IJ3JohlwQcjPmuR/E1VJFYZHXBUa9nBQ98fmQa
         9tfeVLn7+e6/Xin49tUjLkSegx4UhIEx/kGZ9gk2SpRHm6pAP9GYeZ2ENDtfum+FGqpV
         eqjlEtcFVDHtGpbTMCqYKa/RkjPe/KGFRv/K6Sm6TrdgwLswAMPlwFa/z2aHXa9V5i4m
         K5VrtWpEwr2b+i6t2VTcS/ULpsn7sKoLE3prDm0+p1tIF11vVQLiMPAp3lAJPYinZF79
         l9mBhCs2MZSEW9H3CgqB3YaxdViVeHCpWWfDtUNXV1o40nuCaPb5bWXy+27GvPkjv3Aw
         wH/g==
X-Gm-Message-State: AOJu0Yy/iual0XuipcMC+rm/BLtrKuEuv5e+rg1tkzrBZDa7d2S6gGdw
	hI3F1IPjjtTf4+jIyZleoL3C/68uglienXiUNGZeHovGzqkr+5WK
X-Google-Smtp-Source: AGHT+IE2/9Q6E88+TmRzE54Dvvf/54yPBfAzSl22qzTBvPa1812KBvKBni8YzRoyqSlgOjoA1rejfQ==
X-Received: by 2002:a05:6a00:4fca:b0:6db:7038:fcc1 with SMTP id le10-20020a056a004fca00b006db7038fcc1mr1956072pfb.11.1705621499984;
        Thu, 18 Jan 2024 15:44:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fj2-20020a056a003a0200b006d98505dacasm3842876pfb.132.2024.01.18.15.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 15:44:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 18 Jan 2024 15:44:58 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lukasz Majczak <lma@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Radoslaw Biernacki <biernacki@google.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 3/3] mfd: cros_ec: Register EC-based watchdog subdevice
Message-ID: <afc0a32f-4352-4ce7-a57d-9c5900ba91d1@roeck-us.net>
References: <20240118195325.2964918-1-lma@chromium.org>
 <20240118195325.2964918-4-lma@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118195325.2964918-4-lma@chromium.org>

On Thu, Jan 18, 2024 at 07:53:24PM +0000, Lukasz Majczak wrote:
> Add ChromeOS EC-based watchdog as EC subdevice.
> 
> Signed-off-by: Lukasz Majczak <lma@chromium.org>
> ---
>  drivers/mfd/cros_ec_dev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 603b1cd52785..d0140a285f69 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -91,6 +91,10 @@ static const struct mfd_cell cros_usbpd_notify_cells[] = {
>  	{ .name = "cros-usbpd-notify", },
>  };
>  
> +static const struct mfd_cell cros_ec_wdt_cells[] = {
> +	{ .name = "cros-ec-wdt-drv", }

Assuming you drop "-drv",

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

