Return-Path: <linux-kernel+bounces-51723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74B6848E9A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F31A281A08
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A580C2230C;
	Sun,  4 Feb 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0AG2rsL"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE16241E3;
	Sun,  4 Feb 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058013; cv=none; b=NYtMdYwPQU5OqIVj9hDX8r4KZWFajKnTRcKMVKH31oNJ279HYFGlvW/eM6WapgbrNQeEfTaBf5A3i0SHYd1cmfMBuoYrUF9PbEcakwZQYdm29KFiUP5VA6WKY1Nf1krsP0RZgaw2daIsPah1Y3JUzS5TXHLcdjjnCMr4hVksK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058013; c=relaxed/simple;
	bh=7y2NvLen3GNMbCESYJF9W+hFTZH+O92XeZuNmlIE7vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMG2954qEhs50qADLv1yzBP8xDZU34AsS+Ppdt1orakMJWCkVimYHmrnNKaIGerbFVVzTzjSMPgbE8SVukuEapCPaZrU9jbaBaJxdFYDbVzC/pStUB8xBC6EpBDaukeGBPKr3thxdvBqtLdXXfHVOdx4FVFhoiL29YmWRz3K9IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0AG2rsL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d958e0d73dso18013355ad.1;
        Sun, 04 Feb 2024 06:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707058011; x=1707662811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEgcIV1AjqJdg+kUtMkDo/LAy+LfU9r49ZbFPytym+0=;
        b=P0AG2rsLxRfcMO/tBhxoAeoH+TccCn2+1uHD6yhiDjL8Y6lWPh/uushtI/gchPOl3u
         boW1B3xXAgRR77jaJHxMRaXNQW6mcn8YXTJAjDeVjB2DO7gBijqysnGKfn7i1oZK2Gcb
         zegQyoeEv2sGuBS3+RE6A8PAGgDT+Zcmu8cmS4ZeXRCZFmXIJQkoZk2iUmofatyj8iIZ
         VWOBe+kvKdXq452mb6vWvdj5+KqVIMc2pevbUUuEJWzXprIdWD/N9GQy/iicvYW1j/Gd
         Czpwkxgobtc9aHg1o3cvWkpWlYoWZHdPkfszqFma2ITuKpim0iD90pZFt1fYRW+YGwPS
         zM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707058011; x=1707662811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEgcIV1AjqJdg+kUtMkDo/LAy+LfU9r49ZbFPytym+0=;
        b=XTN2eoSR2UHZHVesB6UNTQG1ZlkAKUmUwFQKtHEq3Y1kxpMFD0mcyMzTXss5odNVwi
         OTUcjzwsPOYJMFVSwxYnyd65dmSoyf9V8CRhE+bp8SpvEeFLoS1W7MuWie6s/v+e4gZs
         mGVtRV8jIBl4okA9SOoBuIOy3fktLpkkAwNC718lo8jA8GS8rDCxXQ2ySb6IO0o1hFHq
         k0mx1EW0050NUBVHg6SLC9BH5EEcjFT9Vawg4n2LHlu/BEQOUHBB2fV8fba+fVGdgc0f
         bTnm9bhVlzEy1MA/bvTXf/s/l/A289SGIphad1YIXCTO7MTW2gjLio9RFCyAo/rvn/zQ
         BgdQ==
X-Gm-Message-State: AOJu0Yx4RNj7O5yW0PlTcqM+z0fCq2T/rAltAH1nzHwDZSsGgD+Jqoi5
	LVjOwoiECjiAiko99VnwFtrH+9oACWvNwYwZktJydFd+D5ln7K/t
X-Google-Smtp-Source: AGHT+IHp2k2jKz4sQbG8bc5P52HozO7oKaXxmGP4VDpEd7y29Vl7lvrkoxrJPWbeDvh5P7bHmiwX6w==
X-Received: by 2002:a17:902:ce84:b0:1d9:8b6c:2167 with SMTP id f4-20020a170902ce8400b001d98b6c2167mr5635308plg.23.1707058011585;
        Sun, 04 Feb 2024 06:46:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXbOvv38kyDaN6fcwR+bQF6uvUZ4PUD4hG5Q6baQjc0ukz28VY/BQ1ExWkIjrdYxMLcqwe2CSffRlqSdC3RUu3ji8NEpxAwH85Q8kCtuC2X+XmqiglM/Zcpip9Ve8kC0clgUb4PzX4nQyQocvQKWug5GuyhzYy/KWFgmQErj3TZ
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b001d9351f63d4sm4637445plh.68.2024.02.04.06.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:46:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 4 Feb 2024 06:46:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Zhang Rui <rui.zhang@intel.com>
Cc: jdelvare@suse.com, fenghua.yu@intel.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 06/11] hwmon: (coretemp) Replace
 sensor_device_attribute with device_attribute
Message-ID: <6facad0d-ce9c-44c7-8921-af5eb83918ea@roeck-us.net>
References: <20240202092144.71180-1-rui.zhang@intel.com>
 <20240202092144.71180-7-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202092144.71180-7-rui.zhang@intel.com>

On Fri, Feb 02, 2024 at 05:21:39PM +0800, Zhang Rui wrote:
> Replace sensor_device_attribute with device_attribute because
> sensor_device_attribute->index is no longer used.
> 
> No functional change.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied.

Thanks,
Guenter

