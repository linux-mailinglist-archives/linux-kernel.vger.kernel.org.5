Return-Path: <linux-kernel+bounces-132135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F84089901D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B010A1C218BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9AD13C808;
	Thu,  4 Apr 2024 21:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5bZNcC5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8C813BC17;
	Thu,  4 Apr 2024 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265805; cv=none; b=C5iODZvMUZs+cA+VnRcf5koYVvkJizXq+YElYrSIgsC4HMHZRpYOjkXsxdNI/gauxs/IshyOF8+vY5hv8k8COjPhBMaBqF/dRmZPSVA0uz8yQ1Nxk6lKLkJFxXGxaiwppx/rUAmcGuxHfCvpmxvM2V7ZcpETW5swlamXaEqNiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265805; c=relaxed/simple;
	bh=svx3D69MRXucD02cTQ/BJ/phkeSqnwIiiYNyw7eeYYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3a7d10ycuOZFbjlSZ56Mir0QTVmWkDLuHoSSFCTimzmjtc/phLMDmSldzjDQUqUWW7VxtHh64ihS4OJFE5xbSXuBShesLuELxENyan7LsvKtI4cQcF6ftCG28hrMGfkOaYli8ozKnoVIPEf8j3pwtB6L9/QQqxX8uARsf+G9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5bZNcC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BECC43399;
	Thu,  4 Apr 2024 21:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265805;
	bh=svx3D69MRXucD02cTQ/BJ/phkeSqnwIiiYNyw7eeYYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5bZNcC5R0Ga1M+RB7X+Gex48tz52f3dzzXOuRNQsC5BtVg+acx4gMQvTN9/TTyEz
	 XZOvLmZXSVKsm+HgjztLe/im5SOrPqwsIKe32sZY6UIj3+fIWrbDDmchoCdptlnf7U
	 ALa1wypsiGuwhEFCmhU6Mt/u+qtW6Qw5rmY9gGIsLOINx/QqhqaLfKuXOXjP/7vtbJ
	 MZOLQaFGtxLqVe+rGlmaG2kzTFnP0p1wgOBrlkNlSFNxJKtaczrZEo0YYIuWUf29cx
	 NR3l7GOikA6aOfzy7pvgKjGYtTR5Mnrz8u/LAs6MOKXSlwAoiKVrr8jkrNyGpjXDKy
	 pf5dUOuUpW4UA==
From: Bjorn Andersson <andersson@kernel.org>
To: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
Cc: Robert Marko <robimarko@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: ipq8074: Remove unused gpio from QPIC pins
Date: Thu,  4 Apr 2024 16:22:53 -0500
Message-ID: <171226578676.615813.15380025713922227401.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313102713.1727458-1-frut3k7@gmail.com>
References: <20240313102713.1727458-1-frut3k7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 13 Mar 2024 11:27:06 +0100, Paweł Owoc wrote:
> gpio16 will only be used for LCD support, as its NAND/LCDC data[8]
> so its bit 9 of the parallel QPIC interface, and ONFI NAND is only 8
> or 16-bit with only 8-bit one being supported in our case so that pin
> is unused.
> 
> It should be dropped from the default NAND pinctrl configuration
> as its unused and only needed for LCD.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: ipq8074: Remove unused gpio from QPIC pins
      commit: 5f78d9213ae753e2242b0f6a5d4a5e98e55ddc76

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

