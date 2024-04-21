Return-Path: <linux-kernel+bounces-152528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C69D8AC008
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535E11F21118
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE2A376FC;
	Sun, 21 Apr 2024 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+Accpq3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE0424A03;
	Sun, 21 Apr 2024 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713715633; cv=none; b=BlVfbNM8PJonUdlLcyGvzysDgkRdRlm0Gm2nc217b0nPRKy0SVIB7YeommoZXG9MzvSXu0NQ85S9HT8oRQe/CRlr+2xUvApbYdU3x9evxKHl4NzLLdm8F3dRh2zuesqM4nMW+a0mcmANaO6ChMRds94MiFQUMZXH9sEwMoWA2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713715633; c=relaxed/simple;
	bh=k8ouJEDnPjHW77IdXvL48XXyrgLgpjXfup/v/JZtYXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3gcGAGJQkUZxwngmst1WUl8zkM/tMpT/0vOuZvMPBCYECHAlislMbVK1602w+oeI0L9BCjNNs3cQ4ybxc64wPGrSB1+VsGCScCVc0iITA41DhRs3YJ8JVaMRqCFB3+uysmbxOzrq/HhQTRnWS20/SrNSRenzYMTrBd8IJ/pCDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+Accpq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997F8C32783;
	Sun, 21 Apr 2024 16:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713715632;
	bh=k8ouJEDnPjHW77IdXvL48XXyrgLgpjXfup/v/JZtYXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+Accpq3xJNt4gM7EaOV6tEJbjf2V5S1VPNrPf4q5Qk7rCfVQuq+5DBFravH2mwZY
	 rUW0u7Sh/u0hAkNaUiSFqfdGIX25mL1Z8PnWbU7Fv26HG2hno3cKENTfPB2dOU7p+y
	 HNmQ9bZyADYzF+lSuGBr2/2rJsc73dKhXacx2xhdwWxiIIqzg4++a3qK6IKcIVymON
	 6O48Eby7AOrbSYDkCU7B9LU5jjYBl8kg+VqqJ9OxYdwjWErFOv2Y5UNGXjhdkzESpD
	 TqJ429sv1c7Egw7X3GNfHtQKAPLEp3nEnR3F93Ury5Jebnu/QvJPKIbppqvdW2YShp
	 7nzi0yM9DL4Xw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcm6490-fairphone-fp5: Add USB-C orientation GPIO
Date: Sun, 21 Apr 2024 11:07:05 -0500
Message-ID: <171371562482.1174524.9194500934821003879.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411-fp5-usb-c-gpio-v1-1-78f11deb940a@fairphone.com>
References: <20240411-fp5-usb-c-gpio-v1-1-78f11deb940a@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 11 Apr 2024 09:06:11 +0200, Luca Weiss wrote:
> Define the USB-C orientation GPIOs so that the USB-C ports orientation
> is known without having to resort to the altmode notifications.
> 
> On PCB level this is the signal from PM7250B (pin CC_OUT) which is
> called USB_PHY_PS.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: qcm6490-fairphone-fp5: Add USB-C orientation GPIO
      commit: e788ef2bdac7fdbd61b626f65fdf7528a1c6fd3b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

