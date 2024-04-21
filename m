Return-Path: <linux-kernel+bounces-152624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD348AC1AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A52A1C204FA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CD946439;
	Sun, 21 Apr 2024 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEj8+X54"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053D71BF20;
	Sun, 21 Apr 2024 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738576; cv=none; b=jj78+FYk9KOBRrLTO/FXsN1VCUD/hn56llHAo4NVTaK9j2RMiA5P4c0y0GdLemRUBxTXJkHdVDIDU88zlw+PKJx6ZstE/+LeVMWPXgJWf8jKr1DTxkpmE8yjAaS47Vx91xf+X8D3wF99wMcYpkZ1aEZls7tIelssQjhmjXiH0+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738576; c=relaxed/simple;
	bh=fjnlmQG/zKSKyaaI2gI7CgNgrI3kSndRTJARTY1T4RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eS40Fs4kWsZBATLKQehLdIuyf32wwhy1lGXFlQtRSlijePlJpKr87QtHbPlHlqye3fjq7DWsflnN6yi+chphX2HVeqRLOv2I8240V4VjWChca5MY8TXur7vXteTTRwc6IXZJ15GBf63YwVsBHYvxXD/L8F+nU+hsDTTkwxcUZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEj8+X54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA173C32782;
	Sun, 21 Apr 2024 22:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738575;
	bh=fjnlmQG/zKSKyaaI2gI7CgNgrI3kSndRTJARTY1T4RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kEj8+X547u9fY1btlugAPTJsSQLuUJC87uOLwpPB0gOaTnZG7/SnflMPQOl297p0I
	 bllUMVaDealwqLcRwTRgJKFDw7jVqWwR3V0yNihGCddoXpTcBKvYMx4J6EYDsaFuwC
	 hTDkoeKLLWc4L7Tto4b20/XhRiVLsXfQHUuml0dOkFW7GYzKHQGMZRZG+46Fn2Z8Ry
	 OJTSqunJgeU7Xki2zWPMiTdL88qvwRLlnIwr9yggHMVTdGK39O6Z/16OiDjbbLMOY4
	 XfcKIMERVBNACvmgkC22mPjgoMNMjPRF3oySJRGQfbTmbuD7VCWyxGOsEITrAqdv4l
	 AZZkp6DMly2Cw==
From: Bjorn Andersson <andersson@kernel.org>
To: pavel@ucw.cz,
	lee@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	konrad.dybcio@linaro.org,
	Danila Tikhonov <danila@jiaxyga.com>
Cc: linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] Add LPG/PWM support for PM6150L PMIC
Date: Sun, 21 Apr 2024 17:29:09 -0500
Message-ID: <171373856765.1196479.10666864440233558408.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306172710.59780-1-danila@jiaxyga.com>
References: <20240306172710.59780-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 06 Mar 2024 20:27:08 +0300, Danila Tikhonov wrote:
> This series adds LPG/PWM support for PM6150L. Was tested on SM7150
> (xiaomi-surya).
> 
> To: Pavel Machek <pavel@ucw.cz>
> To: Lee Jones <lee@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: linux-leds@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: pm6150l: add Light Pulse Generator device node
      commit: 11525960fcf40fcb772b62dd5117c59fdc27eb57

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

