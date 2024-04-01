Return-Path: <linux-kernel+bounces-126765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AF6893C6B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329DF1C212A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C474502D;
	Mon,  1 Apr 2024 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYEoLEsX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE97240872;
	Mon,  1 Apr 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711983471; cv=none; b=oY7Lz22sV4q1Mgf9SONteHGSpw5cB7H/uXtI1B41wIwCL3dbD7ZVyPIELnT/h/OMbcKctruszcsATseqMd/tLGeri915Iw1bVGftrAzpFZC8pC35f82rNymRF2J+hIB/ZXQdWpXBRGNXQA5juIzT8V+OtN8R5ekAmEgJM0CFroo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711983471; c=relaxed/simple;
	bh=s/Kq0rz7zLu9YXogoVE0wyeYA30vKKY0Jd2nsR5FfWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eunr/9dCJmDpahVCT8kz3s1fc7aD4i7oqwtDU00WWCpKCJw7zOoTRaJlwszbuiCHD2lH/6aR0uan9eaOHN/SLbF1yPCbO0bkzSHd4iBaUQbMdfX7aMDYh+DCSKrG5jChcr1YoQZX8YssiqFPciO58ao/hoUgtdVVcDKEGZyHoHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYEoLEsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296C3C433C7;
	Mon,  1 Apr 2024 14:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711983471;
	bh=s/Kq0rz7zLu9YXogoVE0wyeYA30vKKY0Jd2nsR5FfWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYEoLEsXkFl7p10gvrZ1Wk5QHBxQVt+EFOdrWhph1e9/qsMyGexSBW6NZ1o1ruMN0
	 alFvVY1mFnaOMYx/EiL3ikLRN1Drv0Vfv3BWicg2qPUaHmNnvFppBpgEUF+m+y1xDf
	 6WXsYJf9iLDB/hKVCqsKvFSNeHKmo0NvhZFyz4pL5ZM14W8PWzbOZYOJ87z0K5SAXG
	 SYxDA4MEMYO+pYyhOWBJ6sjaTeVNE5NUKmWwiwY485YvOM8vAw+yuYe8vAcLMBxkfC
	 +Nv/PVRxS6w8SqOhin72KVz0oV+csNZj3QCEuRPDxvG6HD/+ZBVVc0GGxU3Aa+pAt/
	 FUYPe1vdfDKvQ==
Date: Mon, 1 Apr 2024 09:57:49 -0500
From: Rob Herring <robh@kernel.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: sboyd@kernel.org, neil.armstrong@linaro.org, jbrunet@baylibre.com,
	khilman@baylibre.com, rockosov@gmail.com, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	kernel@salutedevices.com, devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org, robh+dt@kernel.org,
	mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org,
	martin.blumenstingl@googlemail.com
Subject: Re: [PATCH v1 5/6] dt-bindings: clock: meson: add A1 CPU clock
 controller bindings
Message-ID: <171198346654.607486.15665713709092404506.robh@kernel.org>
References: <20240329205904.25002-1-ddrokosov@salutedevices.com>
 <20240329205904.25002-6-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329205904.25002-6-ddrokosov@salutedevices.com>


On Fri, 29 Mar 2024 23:58:45 +0300, Dmitry Rokosov wrote:
> Add the documentation and dt bindings for Amlogic A1 CPU clock
> controller.
> 
> This controller consists of the general 'cpu_clk' and two main parents:
> 'cpu fixed clock' and 'syspll'. The 'cpu fixed clock' is an internal
> fixed clock, while the 'syspll' serves as an external input from the A1
> PLL clock controller.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  .../bindings/clock/amlogic,a1-cpu-clkc.yaml   | 64 +++++++++++++++++++
>  .../dt-bindings/clock/amlogic,a1-cpu-clkc.h   | 19 ++++++
>  2 files changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/amlogic,a1-cpu-clkc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>


