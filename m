Return-Path: <linux-kernel+bounces-75946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7291A85F104
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7061B2301B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F133210A12;
	Thu, 22 Feb 2024 05:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yA3a6G4Y"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7BD8C11
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708580407; cv=none; b=rGPftGY48WURXWWC2e3jyoTemwi4T2BSMmsakeOgCfICl12Rssqt3Kju0r6ZYt1fKQMK3tEZemAj2Su9+kSuNw/cJD93rzA2Ei3NPH+gonU9ZNGZ+vMEQumC5C4+xdaMsKwfSwgGhQtTzIJt5Uj9Y02YJ6RwOCcEE2yj36vBiMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708580407; c=relaxed/simple;
	bh=yQg5gh5MmRiYiePzpcNDaEGQQlXwpQVZ5S9UlbGqOKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+ng9vepjYd/0Gda7hahoIhX924zRoZ6QmSXgVtdFvM4hkapFTCFXzmV+w+ivf7Li4WsvurJPQP8uuxGI5jWdYOac5zK3qbA6lQxE1KWVuVQJFPETqd5n+/eyG4VJRrzNeLeuI6q7O1UovTRS75Fmzwsk1mhgf+ipmDhuvhLFxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yA3a6G4Y; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc49afb495so3347595ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708580405; x=1709185205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Y9cstFcLJ3tBNiN3xZNH0htetDh7AF1BjirZ0v0JP4=;
        b=yA3a6G4YY3W2ec4pZWFbuAw3o8YsO/DpZ2v/bxDBVZXjb6RSSNLWbRjCuTBWSjjxEM
         NyvHIpg3xvN1xo+e+aK7q6SvTF5gmP+L3n9C9rK9DTl7RiGPhjecrrI7cOaaHt8ovH+u
         yPk7P4y5E/ka7uJVrXEv6qbPkytJrSy0syBAT7GvC8p5AqgVtfVdopE9xAcae3DeY3WB
         TOZt0F3khXRZZnQTqCZyZnre/ku4PmO2gMhG4oHu3ITmO9tOHYhAJ6ZTYrrB+AO0/QKn
         RnVYum/M8Bqh/dhKJF17oH6GkQm/lKR2J+IgntYQiwuTQGzzkgP3JDMT6/ZacTRN6tDu
         YPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708580405; x=1709185205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Y9cstFcLJ3tBNiN3xZNH0htetDh7AF1BjirZ0v0JP4=;
        b=bnfosHN8l2c6OqZIGugZEchDjr+aJFTzyb5aXjiLLAfJAaSyexrMeW0yl9mTTDNZz7
         8AlBYomm5EeajbwTjVZ6uTJF7irbuO/B0BEcKFKldk9FOB9DzOU/YoYTEAYT2u3ntd1Q
         WQUa1H5PcwpTWMzWUIdUgxSQKjBV1D2TEQ/+5wlSSRkpZX/AAIYeB7koFJ1GNa/UBeiP
         TsLzz4aGtErpOzmKFzimMRqnJC2EvY8jltJUJTQp10cvXJH4WqOeXGYqCkpouY6LUXQC
         vJkLg6wCHsJKzOK/6XDJHOqV/br4TYAokK1YyQhjdjCDyl7Rv1ZyQw8lfm5YeHzUomwz
         ldRA==
X-Forwarded-Encrypted: i=1; AJvYcCVrOgma/Bgk9uZoauUX9xAbufhbhypha2ZNv0RjeSGrWE8Z/xhRBR4zb8ak0ozVJ6xakkCj7yXcjEpshz+9YLyGnAyNmCFF3sL+gg4j
X-Gm-Message-State: AOJu0YxXrRgFijnsnejJhdtTwCuhC7wSEt62ewA/iSqHSIc0pJjptXYx
	nFuXxDmR8hxhLSOdt+7otrNv8v1dH6dN6YwCEzcxFOK8n8dleUgS5zcSBRWpYw==
X-Google-Smtp-Source: AGHT+IFn4K4spZaFAlnGs4H1E3Uij1heQB4mMHjFctMYMEn7odiUXiBji21giUzbHQ3n3f4SslXQMg==
X-Received: by 2002:a17:902:c402:b0:1db:28bd:2949 with SMTP id k2-20020a170902c40200b001db28bd2949mr28591618plk.0.1708580405108;
        Wed, 21 Feb 2024 21:40:05 -0800 (PST)
Received: from thinkpad ([117.193.212.166])
        by smtp.gmail.com with ESMTPSA id lf5-20020a170902fb4500b001db43f3629dsm9043678plb.140.2024.02.21.21.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 21:40:04 -0800 (PST)
Date: Thu, 22 Feb 2024 11:09:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/21] arm64: dts: qcom: sc8280xp: Add PCIe bridge node
Message-ID: <20240222053958.GF3374@thinkpad>
References: <20240221-pcie-qcom-bridge-dts-v1-0-6c6df0f9450d@linaro.org>
 <20240221-pcie-qcom-bridge-dts-v1-9-6c6df0f9450d@linaro.org>
 <9d6c617a-bc3a-47c4-a988-b41b804d8cfe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d6c617a-bc3a-47c4-a988-b41b804d8cfe@linaro.org>

On Wed, Feb 21, 2024 at 01:39:01PM +0100, Konrad Dybcio wrote:
> On 21.02.2024 04:41, Manivannan Sadhasivam wrote:
> > On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
> > for each controller instance. Hence, add a node to represent the bridge.
> > 
> > While at it, let's remove the bridge properties from board dts as they are
> > now redundant.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |  8 -----
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 40 ++++++++++++++++++++++
> >  2 files changed, 40 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > index def3976bd5bb..f0a0115e08fa 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > @@ -733,14 +733,6 @@ &pcie4 {
> >  	status = "okay";
> >  
> >  	pcie@0 {
> > -		device_type = "pci";
> > -		reg = <0x0 0x0 0x0 0x0 0x0>;
> > -		#address-cells = <3>;
> > -		#size-cells = <2>;
> > -		ranges;
> > -
> > -		bus-range = <0x01 0xff>;
> > -
> >  		wifi@0 {
> 
> This doesn't seem right, pleas use a label
> 

Why? A node label is useful if we want to reference it at the root level in
board dts, but here it is not.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

