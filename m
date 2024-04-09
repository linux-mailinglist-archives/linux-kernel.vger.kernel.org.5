Return-Path: <linux-kernel+bounces-136976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C089989DA96
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CEB1F2159F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C27130493;
	Tue,  9 Apr 2024 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYiEWSxn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CCE1304BF;
	Tue,  9 Apr 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669921; cv=none; b=QaV80N9X9kp4bJvq2PgR67XfAFEwqahSqay5cAHr1fnolk5Bo6+OrttmnfOIBadHqT7WebfzdD0vezqAkmacGeAw3eWumM25lNGt3zEFCKT/JM/p0XIyca8INrtFUrq+/EfwWerZjqrqit9bN7sYYweRxS1YdGUaFp6v1W3EjxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669921; c=relaxed/simple;
	bh=HRfRkbHD8zcpi5gl/4LkNF4bPGm+koDa1Cv2ivwUNKs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=dckDdwJJNziDyTNoq1VL41pF3sAo1tJvRG3WI069kyr2HjcBOqLKTDTGfhyjhzHMf/Mi1hvVbcRBiQLjJB7nU/le+3Tw+/2DiBjaKYCD9L1hoMllSdCC0Giv0NepSU5pERvSsxGZtGVIq9pYEkdWLrY0CjklpNgWqh7KeJhvwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYiEWSxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6562C433F1;
	Tue,  9 Apr 2024 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669921;
	bh=HRfRkbHD8zcpi5gl/4LkNF4bPGm+koDa1Cv2ivwUNKs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hYiEWSxndHETdib5iYRWGK6lLaBRG1V77qREot8UIVwIHJJhwvBexsk3VXe9s4raq
	 YaVNFyudOI2CpS/bNqohGr4yQuR/elqRTm8zQcTb7+s4NP7pLWWcqEAsek5b3ie0b9
	 l97GRsdXJxqbKaG+AiEOmAVItII5sX7hsafY5/xcqw51DyCnXoG6hxmAeHqoWYELbH
	 2Np4Mu9B5m0sOEKs+uM/g1fjfnZ90rGRgAzc0MWiMk1vPk8HzjRoRcXS/KUzIIH1TF
	 EiJIKkq1EXpR5PwZqOuXCmMDO2aHCi2ar0ssKD7z+NkaCZngK7NvtT5RfBLtmPh476
	 dTNG/Cc2ippFA==
Date: Tue, 09 Apr 2024 08:38:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Raymond Hackley <raymondhackley@protonmail.com>
Cc: linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>
In-Reply-To: <20240405120803.20754-1-raymondhackley@protonmail.com>
References: <20240405120803.20754-1-raymondhackley@protonmail.com>
Message-Id: <171266958282.1032427.12690493888215530209.robh@kernel.org>
Subject: Re: [PATCH 0/3] arm64: dts: qcom: msm8916-samsung-fortuna: Add
 accelerometer/magnetometer


On Fri, 05 Apr 2024 12:08:19 +0000, Raymond Hackley wrote:
> Some Grand Prime use a Bosch BMC150 accelerometer/magnetometer combo.
> The chip provides two separate I2C devices for the accelerometer
> and magnetometer that are already supported by the bmc150-accel
> and bmc150-magn driver.
> Some Grand Prime use a ST LSM303C accelerometer/magnetometer combo.
> Core Prime LTE uses ST LIS2HH12 accelerometer.
> 
> Add support for them.
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y qcom/msm8216-samsung-fortuna3g.dtb' for 20240405120803.20754-1-raymondhackley@protonmail.com:

arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dtb: magnetometer@12: 'mount-matrix' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/magnetometer/bosch,bmc150_magn.yaml#
arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dtb: accelerometer@1d: 'interrupt-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/st,st-sensors.yaml#






