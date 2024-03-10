Return-Path: <linux-kernel+bounces-98254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FAD877779
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 16:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD40F28156F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 15:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62684383A0;
	Sun, 10 Mar 2024 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAzEJqGU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8836B00;
	Sun, 10 Mar 2024 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710084297; cv=none; b=R3rGIK78jUlEy2OEYNv2BAmW7jWGAAr1arCHVD6K9Nd1+i+jn6skmD3c3g0YKfA4fY94SuuMoDXUaIwIUBMizWUMHw30FGYFLwgr/Sg02ujVfd7VaWPG4X0i0F5KRmZyje9DJJHlQk3XKTPv4eigx1sl9xTBzXmDjBhMZ3Y3uM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710084297; c=relaxed/simple;
	bh=6OIM+bhAgRt4x8cQAnblfO3WazqD7uQhJ07X0yZgtcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ek5T6krh74reXJNEWs3+Cnb+bXQxpdHjIzyX6tmu3P4cxi+NU9079c1UZy4i1kDEK3MCL8NDo2eBFLIH4zNlsXpvmXs2ouCC2ZzmcM43+v4mKQCzA6zKhxS88RolSTTrL14coIxpLt5ftNfUHKa8fDZQXAoEmsS83xchl/XwX/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAzEJqGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9ADC433F1;
	Sun, 10 Mar 2024 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710084297;
	bh=6OIM+bhAgRt4x8cQAnblfO3WazqD7uQhJ07X0yZgtcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EAzEJqGUOIG/oauO2Vs+SxEbmbeGv3rZAgmCaXt9BRIqUt4JKoCkGerF/flr/5NmJ
	 dN72UDRytMtraa8fMK/7SUW/if5YWiTQW7JqFvrrYsx+5k0DvhcVf0wHvnQlKiF9jd
	 eMkvumo7feiIkITaHJv+OnZUFFiMlS6cQzlrs7/zy3Z7465f9RPyDmLGLg2VO5558F
	 UKYgfvXuv+Ur+U+HMnNzKo/r+Qy4CjWAZ8iUqkDnmxv15uetbu6kIfSBzgmr9vWrnU
	 q7UuYLfjDc9liRaciB6ohTX1dmrOkQZpW9eu7EBGrtnkSN5pUl+wm5cD0cyZWuruOC
	 47M8fREDfAxdQ==
Date: Sun, 10 Mar 2024 15:24:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Li peiyu <579lpy@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/3] iio: humidity: hdc3020: add power and reset
 management
Message-ID: <20240310152443.4cbd7c4e@jic23-huawei>
In-Reply-To: <20240303-hdc3020-pm-v3-0-48bc02b5241b@gmail.com>
References: <20240303-hdc3020-pm-v3-0-48bc02b5241b@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 03 Mar 2024 22:54:19 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This series adds power management for the hdc3020 humidity and
> temperature sensor as well as control over the reset signal the device
> provides.
> 
> The hdc3020 carries out measurements automatically, which is not
> necessary in low-power modes. Furthermore, if the low-power
> configuration turns off the device, proper initialization is required to
> account for the setup times and initial status register value.
> 
> This device provides an active low reset signal that must be handled if
> connected. This signal can be used by the driver to keep the device
> under minimal power consumption during low-power modes if the power
> supply stays active.
> 
> This series uses char-misc-next as basis to include the last additions
> to the driver to handle events [1] as well as the fix to include the
> entries in the Makefile and Kconfig files [2].
> 
> [1] https://lore.kernel.org/linux-iio/20240214085350.19382-1-dima.fedrau@gmail.com/
> [2] https://lore.kernel.org/linux-iio/20240121135123.71506-1-jic23@kernel.org/
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied to the togreg-normal branch of iio.git and pushed out for 0-day to
see what it can find.  Note this is now 6.10 material and I'll be rebasing
on rc1 once available. It won't go into a tree next picks up until after that.

Thanks,

Jonathan

> ---
> Changes in v3:
> - Drop unnecessary casting to void in dev_set_drvdata.
> - Call devm_add_action_or_reset right after powering on.
> - Link to v2: https://lore.kernel.org/r/20240226-hdc3020-pm-v2-0-cec6766086e8@gmail.com
> 
> Changes in v2:
> - Trigger power off sequence if the power on sequence fails.
> - Check return value of hdc3020_power_on() in the probe.
> - Remove type casting for void pointer.
> - Link to v1: https://lore.kernel.org/r/20240220-hdc3020-pm-v1-0-d8e60dbe79e9@gmail.com
> 
> ---
> Javier Carrasco (3):
>       iio: humidity: hdc3020: add power management
>       dt-bindings: iio: humidity: hdc3020: add reset-gpios
>       iio: humidity: hdc3020: add reset management
> 
>  .../bindings/iio/humidity/ti,hdc3020.yaml          |   5 +
>  drivers/iio/humidity/hdc3020.c                     | 111 +++++++++++++++++----
>  2 files changed, 97 insertions(+), 19 deletions(-)
> ---
> base-commit: d4551c189d6e6a3fcf7f625bd4b273e770fad35a
> change-id: 20240217-hdc3020-pm-177983de3cab
> 
> Best regards,


