Return-Path: <linux-kernel+bounces-83919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4158086A01F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E503A1F220EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B136A1487D8;
	Tue, 27 Feb 2024 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0PbYcjC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3CD51C3F;
	Tue, 27 Feb 2024 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061805; cv=none; b=GrVsCdRvERTO8SbnQhVqZATYzzLMQp1GJx9mPotN853zKeJWodrgbU9lvp/3fKno1ACxTcN+d+OpibXp9I6ifblnrcuYosryCLcUjo0QRxfW0WyKbEfbzFrAFTq+tflEtpkQGeTdi9tVVjTo2pSkcwQ/rEgjOUn1Jx7q9wq4XgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061805; c=relaxed/simple;
	bh=7+3cTrbSrJIXx4SvxwTNw+CAbsnRMliJSEHVShFTXjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwXH5v6xFvzQV34dNtj7k7tBKMUcyOwYxppKHIO7zEUQYeWwwmGIizIhHKL0aKCG1HoFkQB8yCFgMj+T33gutKQEVow9dR7P7almN84+ULPrL7OMjR+QlBH30kwKQohkmQ+oerevK6K9NSTHXh2K+XYWYX6AZwfWsbFa7IW2Wno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0PbYcjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C767C433C7;
	Tue, 27 Feb 2024 19:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709061804;
	bh=7+3cTrbSrJIXx4SvxwTNw+CAbsnRMliJSEHVShFTXjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U0PbYcjCPiQm2m/1VgfJW5wDE3edWfd0Be64xmI/q7IJEOsDavwipdb1HE0hebFa0
	 S2TxYuHlQdCyAv4H2Z2eloTzb8Jjl3WzRa7tMbvuPd/qKImKMio4cCee6NJrzOWoN0
	 FkaMajT7xfXzB1QV0qpiHT5z2CgaXfrmdhuIIsj5ZrGZEtGuoJzzMHAmbUsgdHm1eJ
	 vxpjKwRXsRlUH2EsyyT8UX777P6BKrNdTAjPZdZZlIlVwA9guxxrQQ9IbJqUYOGC+b
	 kCp8Y9JMoKMt7FispgCYkepweREab9Gxp46GAOHAVZTjMzRfRQ2M6gjZ9vUGrmC7u2
	 NyIENNr2wzA7Q==
Date: Tue, 27 Feb 2024 19:23:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marco Felsch <m.felsch@pengutronix.de>, lars@metafoo.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 hns@goldelico.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: iio: gyroscope: bosch,bmg160: add
 spi-max-frequency binding
Message-ID: <20240227192308.52fd3a57@jic23-huawei>
In-Reply-To: <29cc9d21-6fb5-40fc-abba-c0913cd175af@linaro.org>
References: <20240221174305.3423039-1-m.felsch@pengutronix.de>
	<91f29265-36fd-4d0e-99b1-61eaada59601@linaro.org>
	<20240226124036.zzj5p7tlubc332r3@pengutronix.de>
	<29cc9d21-6fb5-40fc-abba-c0913cd175af@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 14:18:00 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 26/02/2024 13:40, Marco Felsch wrote:
> > On 24-02-26, Krzysztof Kozlowski wrote:  
> >> On 21/02/2024 18:43, Marco Felsch wrote:  
> >>> Make use of the common spi-peripheral-props.yaml to pull in the common
> >>> spi device properties and limit the spi-max-frequency to 10 MHz as this
> >>> is the max. frequency if VDDIO >= 1.62V.  
> >>
> >> The example uses i2c, so I would expect to see in commit msg explanation
> >> which devices are SPI devices.  
> > 
> > All listed devices can either operate in I2C or in SPI mode.  
> 
> Such information in commit msg would be enough.
> 
> with the changes:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

Added the note whilst applying.

Applied to the togreg branch of iio.git and pushed out (briefly given
timing) as testing for 0-day to take a first look.

Thanks,

Jonathan

