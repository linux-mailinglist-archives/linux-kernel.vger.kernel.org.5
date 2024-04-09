Return-Path: <linux-kernel+bounces-136978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA7F89DA9D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB981F23446
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFC0130E5B;
	Tue,  9 Apr 2024 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGx+HkF2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C9130E33;
	Tue,  9 Apr 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669926; cv=none; b=OPKX7zSc8Xzl81CjCVVSBkUC3UzBHIuaS9rw5f+bWpvUYltRqOn0TodrKTkl+ka7JUPAryZRMzTpcCJGfp+SlgzAs0S8NaG+CyHDqEHRlF8Jiq8vqXTaMv1EmdEeJbJL2qUqnfaOjOfkVFExafc1Ei74084K+DdQxrAFruEvIyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669926; c=relaxed/simple;
	bh=2FFXAtb0aR+SnxcNwCjo6jgc6EkslH9C5YRU5qz1cts=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Exqh8bOlB6KjlpoPBCCRRF0dWPJ9LwD6sR/++Z+hpSY/bIsRybKv+mjsCRWgUqqjJPKE0LuHwdmeyF9YvXu0pOuSF0l6aVGl1iwX29rF9z3KWcm6s6zKypqOkYFiMQkJTqGMrh1DbkRalmyEiqMajcIr2Urtw9XTMaRjlMVI5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGx+HkF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C85C433C7;
	Tue,  9 Apr 2024 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669925;
	bh=2FFXAtb0aR+SnxcNwCjo6jgc6EkslH9C5YRU5qz1cts=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=CGx+HkF2hLA+BNwmisb3UK+kBSlNFkU53nR83Ksg6tRYq5JMPUTx7JKOgBkTrtK5C
	 Fie/nz1bdtULZ6b9BtP51uSGBZjz9OqM7e4qdOVAydSypCkvqvx9nemKukms4XoIdp
	 g5RyM7u8kqlokigsQcCmLlSFQUVRBGCGuo0pfb40dol/OViBxwrcCkCMxEswpgslJa
	 4pV/x86uGUstSh2oEQTSx5BPxelPS8mAQcAoPdcg2qZkOefVQTCTKoypbct5I5eYHs
	 NM0z5oFLlbvq1iOHqP2TUUoRlCISouzNZUvmik0XmbupPHgPd9ofsBqiNnDWh2vtss
	 1PhPM0OsNVBVw==
Date: Tue, 09 Apr 2024 08:38:44 -0500
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
Cc: Nikita Travkin <nikita@trvn.ru>, Stephan Gerhold <stephan@gerhold.net>, 
 Rob Herring <robh+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240406111348.14358-1-raymondhackley@protonmail.com>
References: <20240406111348.14358-1-raymondhackley@protonmail.com>
Message-Id: <171266958356.1032475.3015828311924816695.robh@kernel.org>
Subject: Re: [PATCH v2 0/3] arm64: dts: qcom: msm8916-samsung-fortuna: Add
 accelerometer/magnetometer


On Sat, 06 Apr 2024 11:14:12 +0000, Raymond Hackley wrote:
> Some Grand Prime use a Bosch BMC150 accelerometer/magnetometer combo.
> The chip provides two separate I2C devices for the accelerometer
> and magnetometer that are already supported by the bmc150-accel
> and bmc150-magn driver.
> Some Grand Prime use a ST LSM303C accelerometer/magnetometer combo.
> Core Prime LTE uses ST LIS2HH12 accelerometer.
> 
> Add support for them.
> ---
> v2: fix accelerometer@1d: 'interrupt-names' does not match any of the regexes:
>     'pinctrl-[0-9]+'
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


New warnings running 'make CHECK_DTBS=y qcom/msm8216-samsung-fortuna3g.dtb' for 20240406111348.14358-1-raymondhackley@protonmail.com:

arch/arm64/boot/dts/qcom/msm8216-samsung-fortuna3g.dtb: magnetometer@12: 'mount-matrix' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/magnetometer/bosch,bmc150_magn.yaml#






