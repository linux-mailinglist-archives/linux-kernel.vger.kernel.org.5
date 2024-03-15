Return-Path: <linux-kernel+bounces-104554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0904487CFC5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F71FB20E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B073CF6B;
	Fri, 15 Mar 2024 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dkEX6ct8"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B631B3B79E;
	Fri, 15 Mar 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515079; cv=none; b=YIaRPKE5Il4cK0A8cQlv4/0jRd7LAk8Plev2U1AqQ6BB0U1CPnX4XJatrIL7Wi6BQWBWgCisQDrTiwsTywHw8LtFevLyFUGGsIcKGr67vJc2uMUuDcV/63PBfCg/rC8WkZXgoiifekMYqCTQr59WFrvDYKpP9gcU5pKFkxAVx10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515079; c=relaxed/simple;
	bh=JjMkGoGOpVHuBppEVlwRVBzxpdqGJlEG4RAZ7zYSQRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttaC7jWocYVp8GvhShzj5GFyzXu82T6OyfveZiixMInCuaNVKPF/aHsuKA4VgbLu1kRb0o2Nc7Ozd2mEwWPptf/23Jdh3zqBqV9bPGgpM+mCkLiKAR0ITHmpLAHDnMfHOsOvR2MLsYXEZyc6h7QuER2oM+i0x9uPlySJuAOeljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dkEX6ct8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=JEDll7qlKJ2VdVRT6RgHb/sGcHWUgJy9vc+jPo1L+X8=; b=dkEX6ct8Gd55cQn0s2bWVGOSm3
	02KKbH0OlC32ZxZ2rE0U1E5JLzgHEvvqXqXRc83zl7wmnNQGpGOJ7Z5yKTYmzURXcNo8sYSZ0VjsR
	zdhtmd2uL6EEi2zq6QaeRSOvCbPlUovEXMHYu8OUNYJ1cYn8wB53z1H0BP/OWrWnDAgkKJ8j6QPWr
	eEPjjBsbcmptSzRvkdINu+lvL1n1tj3KlCAij39E/qQ3697ZyzEcWZS5i0u52C7qc8Bq0TO/TRLze
	vn1IS8fuAsTFhkFmaBpaxAbd/4PhArjHR8aDddZSvgdpDnl0z8/IbP7M/+vru/0JgAUPM9jgHLX8u
	vbQdEWGQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rl96l-00000000bLU-1g5C;
	Fri, 15 Mar 2024 15:04:31 +0000
Message-ID: <68f799ae-2746-4576-a7fc-d93deadfb052@infradead.org>
Date: Fri, 15 Mar 2024 08:04:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] platform: arm64: Add Acer Aspire 1 embedded
 controller driver
Content-Language: en-US
To: Nikita Travkin <nikita@trvn.ru>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240315-aspire1-ec-v5-0-f93381deff39@trvn.ru>
 <20240315-aspire1-ec-v5-3-f93381deff39@trvn.ru>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240315-aspire1-ec-v5-3-f93381deff39@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/15/24 06:51, Nikita Travkin wrote:
> diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
> index 644b83ede093..07d47879a9e3 100644
> --- a/drivers/platform/arm64/Kconfig
> +++ b/drivers/platform/arm64/Kconfig
> @@ -16,4 +16,20 @@ menuconfig ARM64_PLATFORM_DEVICES
>  
>  if ARM64_PLATFORM_DEVICES
>  
> +config EC_ACER_ASPIRE1
> +	tristate "Acer Aspire 1 Emedded Controller driver"

	                        Embedded

> +	depends on I2C
> +	depends on DRM
> +	depends on POWER_SUPPLY
> +	depends on INPUT
> +	help
> +	  Say Y here to enable the EC driver for the (Snapdragon-based)
> +	  Acer Aspire 1 laptop. The EC handles battery and charging
> +	  monitoring as well as some misc functions like the lid sensor
> +	  and USB Type-C DP HPD events.
> +
> +	  This driver provides battery and AC status support for the mentioned
> +	  laptop where this information is not properly exposed via the
> +	  standard ACPI devices.

-- 
#Randy

