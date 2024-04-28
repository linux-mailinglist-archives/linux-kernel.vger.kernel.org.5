Return-Path: <linux-kernel+bounces-161467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8048B4C65
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B769B20F28
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F5A6F072;
	Sun, 28 Apr 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmUUQhvK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2801B58105;
	Sun, 28 Apr 2024 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714318425; cv=none; b=UtNt6TUJ6DFALv0SI8rx1UtrXBjGJI5xX26I/LIAch4C7M0EkH/Yh0jFDon42lkq120wIB95IN242PHfudEzW91nWNPqgfwDmOwee1IePbbkjhrgqGP/FIEwK7Twc9x/QNXpwdL+NF92OsrMRc4RmBG4lV7nb/ERa/kb4xiJheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714318425; c=relaxed/simple;
	bh=Bl5Jt/Gi7pD86ZXdSpC6cHLOrRDvkB2Iphv+mf7NzoI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9f7+Y35ZrtW5/HqoSE/0D/GxROEsWteTJzYRfaWEZECB9X9SE9alp6iSDNHknpOh4C6O5LWXQBt1tMgHI3r/dL7BtGFAN2fFcS1iY1K6dmr8Vs6jn4yp4fIR+K9eciyWLKceB1RENS28MBdktuH+7O1QzpcqcbO4kSvCQnOqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmUUQhvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3C2C113CC;
	Sun, 28 Apr 2024 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714318424;
	bh=Bl5Jt/Gi7pD86ZXdSpC6cHLOrRDvkB2Iphv+mf7NzoI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PmUUQhvKtrxhIlQp/UKL4HJOiswhX6tkK0FAOBtPixvX/Z9miUuXKtKMy7Q05t/Oa
	 BxZx7hkMROIasX2LlDZAxnOCVNyIorBLDnjI1wE4WvQRfbWeNehkWqlsSXMnnNciOr
	 VN7ojjAuEAp0iQOqdNKzCw02zlBe9MSFijV6sLUjAfLLIUBvnWc3EBjvpNU+Tvu+cf
	 2UjEkrdac4heopF6i+fpNw3Lp+3UWtZjI/iVK3q3LZXUM/IW2p33cLSLo64DY6nnKg
	 alf8IUhqLcuI8IWRGsJBuplLytdwt+y/9esz1ZOJfw2Vt2uQ0mYmGaSiKGikfVrqd4
	 WuZC50+B6Zi8A==
Date: Sun, 28 Apr 2024 16:33:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, corbet@lwn.net,
 conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
 Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: Re: [PATCH 5/5] docs: iio: add documentation for adis16480 driver
Message-ID: <20240428163332.1e1327d6@jic23-huawei>
In-Reply-To: <20240423084210.191987-6-ramona.gradinariu@analog.com>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
	<20240423084210.191987-6-ramona.gradinariu@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 11:42:10 +0300
Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:

> Add documentation for adis16480 driver which describes the driver
> device files and shows how the user may use the ABI for various
> scenarios (configuration, measurement, etc.).
> 
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>

LGTM.  A few minor comments, and the final section feels to me like
it belongs somewhere more generic.  I don't want to see much duplication
in these files and that sort of set of pointers to software stacks is
something that either needs to be in some higher level docs, or would
get duplicated.

..

>
> +
> +3. Device buffers
> +=================
> +
> +This driver supports IIO buffers.
> +
> +All devices support retrieving the raw acceleration, gyroscope and temperature
> +measurements using buffers.
> +
> +The following device families also support retrieving the delta velocity, delta
> +angle and temperature measurements using buffers:
> +
> +- ADIS16545
> +- ADIS16547
> +
> +However, when retrieving acceleration or gyroscope data using buffers, delta
> +readings will not be available and vice versa.

I would add a sentence here on why.


> +
> +See ``Documentation/iio/iio_devbuf.rst`` for more information about how buffered
> +data is structured.
> +
> +4. IIO Interfacing Tools
> +========================

This bit looks general.  Good to have, but given we don't want to repeat it in lots
of drivers, perhaps move it somewhere more general?

> +
> +Linux Kernel Tools
> +------------------
> +
> +Linux Kernel provides some userspace tools that can be used to retrieve data
> +from IIO sysfs:
> +
> +* lsiio: example application that provides a list of IIO devices and triggers
> +* iio_event_monitor: example application that reads events from an IIO device
> +  and prints them
> +* iio_generic_buffer: example application that reads data from buffer
> +* iio_utils: set of APIs, typically used to access sysfs files.
> +
> +LibIIO
> +------
> +
> +LibIIO is a C/C++ library that provides generic access to IIO devices. The
> +library abstracts the low-level details of the hardware, and provides a simple
> +yet complete programming interface that can be used for advanced projects.
> +
> +For more information about LibIIO, please see:
> +https://github.com/analogdevicesinc/libiio


