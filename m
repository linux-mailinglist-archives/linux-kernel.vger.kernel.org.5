Return-Path: <linux-kernel+bounces-152526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 426298AC004
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AA91C20BB0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102141CAA8;
	Sun, 21 Apr 2024 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAPHVL2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C231BF2F;
	Sun, 21 Apr 2024 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713715631; cv=none; b=RR0/6lyRiewqgxiR+PcgdmdRpmJ76Bwi3SmCtn/2s7NhlFZE843n8MYgqut9uxM9DRn1lUkYlutp+gTlVG4yTAIUUkcFdiK2UBughHYSVVWiEUAXJ15Hn8zqYyIQdyCmJcK8v/bBY1Roc6cLIVm1iyE8Tt5ggF/5rSCRmt6yo1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713715631; c=relaxed/simple;
	bh=Efnt3l81Q793dglbwd4hVVRTyYvPXZXpbLZtb36MwFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIEXyjSppALfKiBTAHYyQi/bRpTGJeyUE88FKbyGr0YxnD14jUQ8u9fNwXgPyYJ9iKn1JKvdLj42tKQYIA6SiabcNihrc22cfY4UYQ4vk7If/FMRnPjpF+1UsuYDIri10SWc2U8t/TCCcLIt+vFQLGO9ON6ojJb4OKs0Rjjt3Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAPHVL2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251DCC2BD11;
	Sun, 21 Apr 2024 16:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713715630;
	bh=Efnt3l81Q793dglbwd4hVVRTyYvPXZXpbLZtb36MwFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAPHVL2uEiTipnL0Wh10LIi5KBbG24h6yqxc6MhQaC3aGgY5uT08edEIImmxra2s8
	 VECnQoGHPuVy5A79UuAOfhxE0Ruz/RfQxww+o1qyReRnUW3z85yyYjjfIFTYpe/1WK
	 tK0JspEyW6A75iPeYbXrODVXrAOFOwJTK7k9zJaI9FCEJCJ9LZXKCSvX379yJQSFc3
	 7LhywNpw5YTsiqwIBhZlS+ktEYkNTGMgncTi56wEg4XghQjuAXaeHXbRg2yp4ysAYy
	 kGPmJKM+rNt5VJQWMAWkZoSUVAvWaRCEGFaaNnBdGs3UlAykHD8eXG6L0dKnXxXM41
	 Ael2vEfJIKfQg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] arm64: dts: qcom: add USB-C orientation GPIOs
Date: Sun, 21 Apr 2024 11:07:03 -0500
Message-ID: <171371562483.1174524.3782383436002226614.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409-hdk-orientation-gpios-v2-0-658efd993987@linaro.org>
References: <20240409-hdk-orientation-gpios-v2-0-658efd993987@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 09 Apr 2024 17:28:10 +0300, Dmitry Baryshkov wrote:
> Populate orientation GPIOs for some of the PMIC-GLINK-based devices.
> This leaves only FairPhone5, RB3Gen2, SC8180X Primus and SC8280XP CRD
> without the orientation GPIOs declared.
> 
> 

Applied, thanks!

[1/5] dt-bindings: soc: qcom: pmic-glink: allow orientation-gpios
      commit: 254c101efde79ecf1264ba49be9cb9366542f150
[2/5] arm64: dts: qcom: sm8350-hdk: add USB-C orientation GPIO
      commit: defac2c098965534e36e257cf80712c54207d99b
[3/5] arm64: dts: qcom: sm8450-hdk: add USB-C orientation GPIO
      commit: 70b47e7b764ce0c31ed81fdb483738e3d9135e22
[4/5] arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add USB-C orientation GPIOs
      commit: e34d83d968165841250cc4e780921f4bb33247d9
[5/5] arm64: dts: qcom: sc8180x-lenovo-flex-5g: add USB-C orientation GPIOs
      commit: d2dbb1047e05d68b4f031fd50717cf3d2016268f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

