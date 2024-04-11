Return-Path: <linux-kernel+bounces-141349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF458A1D11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5741F2408E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7501C8FA5;
	Thu, 11 Apr 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MskWJphU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FAA17597;
	Thu, 11 Apr 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854013; cv=none; b=Suuiz4WmTR0cZZrzy5bI/FBRSbTk3NkkJsie30tN//S4PvKu1f+ETR5bBSbra/8hBlCgYndgfFDKOF0PX+IPdvj/0dQZESlh/yoBKXrC+uYciyU7raQVxeCC49zuOP+Ir6nqLcAG2DBtDSHcSFVke8F1XmzYAM0WjEoGLkg2iQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854013; c=relaxed/simple;
	bh=iqgAjrhpdfo1ZrrUFTj02mkEqrpLz3bUdqwwQOLPe+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BwZbzucoGzgWf6HjfB0iSauvlhOnXR10h4f4aBiTG5fznnQiVWMvTZENulCpcSjnGCkpR/XPEopRV+Mx6p2h7isuCkhWyHV5kXWVsDtXoFX1jS/MtF6FfANO3DJhB7ZUMQlMB205AV7udMfEIoW7L+fbe2oS7Dtqx8hI/5Z9uWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MskWJphU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF05C113CD;
	Thu, 11 Apr 2024 16:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712854013;
	bh=iqgAjrhpdfo1ZrrUFTj02mkEqrpLz3bUdqwwQOLPe+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MskWJphUxfWv7FR14JCojqva5rU4CLn4jyrJi2Llb6nxfrhSBfhG6dav/LD6+rRzX
	 zN+UrwTlUuGNfqMnJAp+wkbgbEVkzr6aJjlqX1gZuxhjUNsXEEyGF+j0eo/RUzPxr9
	 51H5s0zPJsUfsz8uCnkDmrA3uU5FTEcVSzu9/5EfP5YZzrr+s4027Gu1iWdyzQFTM6
	 EVT7YNV+JgwOkW8sgH4pAG358oV+gfdfULuSuCyulF17XSNU2xCk2mx6KHg7+PeqhH
	 KhDeTidPIVMwr3hb9nqt28ibYXa8/4oSBuFbcB6bxS4xOr65qVtaZXDAR027BNrR4y
	 hPYXqxXCD6gUA==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Gianluca Boiano <morf3089@gmail.com>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20240402-pmi8950-pwm-support-v1-0-1a66899eeeb3@gmail.com>
References: <20240402-pmi8950-pwm-support-v1-0-1a66899eeeb3@gmail.com>
Subject: Re: (subset) [PATCH 0/3] This patch series introduces support for
 PMI8950 PWM in leds-qcom-lpg.
Message-Id: <171285401081.2497730.16156090653409135470.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 17:46:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 02 Apr 2024 14:35:41 +0200, Gianluca Boiano wrote:
> The first patch updates the device tree bindings for leds-qcom-lpg to
> include support for PMI8950 PWM.
> 
> The second patch adds a pwm node to the device tree for the PMI8950. This
> node is found on some msm8953 devices, such as the Xiaomi Mido, and its
> inclusion in the device tree will enable infrared LED functionality on
> these devices.
> 
> [...]

Applied, thanks!

[1/3] leds: qcom-lpg: Add support for PMI8950 PWM
      commit: 945d4f9fc2123ce2ca4f72fd83b61842bc0191fe
[3/3] dt-bindings: leds: leds-qcom-lpg: Add support for PMI8950 PWM
      commit: 4bac069633d433a8626b0c80a3f191800086e77f

--
Lee Jones [李琼斯]


