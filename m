Return-Path: <linux-kernel+bounces-155264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C588AE7C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25B01F24A91
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC58135A40;
	Tue, 23 Apr 2024 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwM6AiNi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0B131181;
	Tue, 23 Apr 2024 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878246; cv=none; b=qlIAwXNwW4WPcXtSkVR2yWXinRFFaIX9xSy2yMXDLvbciVZitteZ5yY5CKbdM9MCYK462lJaFOcwuGMsRmPzrOM2llpJ+xPpSMPpYalF+6EQWzDLi3A8PlkJjWf6jkXb0r7/1Lc6KfaGAZjoUkh48aYS4fy7RkrL0E2cGuWs7wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878246; c=relaxed/simple;
	bh=7Ku7Q5wY+ykOCuCG8Em+C4zLidaTyKXj5EIYCwPboEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbWTQ6+AvMj/E/ql36xYMKbIqBnykmPCHeHvV6NzPQOrKTd6BZSGXbNQu55lpa4qTCSSv366Q8+WjKsww+qAcTJuFG9i6ES6WCjvJDXe6afxc7AjHLOZqXzhmKmuUePvxCtAF/qO19a74UujCn7RFEyM3c5zZdauBQSuXNMqnj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwM6AiNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6674CC116B1;
	Tue, 23 Apr 2024 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713878246;
	bh=7Ku7Q5wY+ykOCuCG8Em+C4zLidaTyKXj5EIYCwPboEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwM6AiNi4j+yYcvwS9PdBrs+6W2+yQQ/B0xeFkIMGKuVKBqZjfuDIUgO3Btxfoebk
	 thmYeuTP0B3CLtm1EOtGqdtRX/7rIz/K6dV8F5vWwxJrgHGHCuo7Kn1sW05m11xFJ/
	 KmdSkHcpK6P45uvsk6knfMlMGYxEhG7d0BOGZz2nFGawSq688e8F8Zs4wnrc7naC5m
	 qExuq1NeeRD9+g2/NocuPgd987sjfciYoFeZ/HusQmZK1IisXz6KSeV89U3W55F+9s
	 K2OI6A6KFt0DsrG1rV9EfYklpXOi83A9qmJdZBn0pSUiuIA1skFV8q2DMuTkVZ7/xr
	 TgmEC08tdTpuw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rong Zhang <i@rong.moe>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: Re: (subset) [PATCH v3 0/4] ARM: dts: qcom: msm8974: Add Samsung Galaxy S5 China support
Date: Tue, 23 Apr 2024 08:17:23 -0500
Message-ID: <171387824043.1259129.8940126659494923463.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213110137.122737-1-i@rong.moe>
References: <20240213110137.122737-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 13 Feb 2024 18:58:35 +0800, Rong Zhang wrote:
> Samsung Galaxy S5 has many variants. Currently, the only supported one
> is klte. Samsung Galaxy S5 China (kltechn) is the China edition of
> klte, and it can mostly work with the klte DTB, with only LEDs and WiFi
> missing.
> 
> This patchset splits out the common part of klte DTS into klte-common
> DTSI, and adds DTS for kltechn by fixing up the GPIO pins for the LEDs
> and GPIO expander connected by the WiFi module. A "brcm,board-type"
> property is added into the wifi@1 node of the common DTSI to allow all
> klte* variants to load the same NVRAM file.
> 
> [...]

Applied, thanks!

[1/4] ARM: dts: qcom: msm8974: Split out common part of samsung-klte
      commit: 16dcf57734620edea32339df2ff8875da00a34c1
[2/4] ARM: dts: qcom: msm8974-klte-common: Pin WiFi board type
      commit: a730364f16ddc65268d828acdbf17f2a762e84be
[4/4] ARM: dts: qcom: msm8974: Add DTS for Samsung Galaxy S5 China (kltechn)
      commit: 01088e255a27f396dcbc412e10b26cd14be5ff19

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

