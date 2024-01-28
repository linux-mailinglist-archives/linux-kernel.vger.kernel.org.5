Return-Path: <linux-kernel+bounces-41874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E7C83F911
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330FC1C2159C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697692EB14;
	Sun, 28 Jan 2024 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IT+88flT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62A92E65B;
	Sun, 28 Jan 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706465640; cv=none; b=vFApMQit5mmyv367x4X9CKWFDVcXhziZ1oYl1TFzFihv/wj1Je80L7yA40zq63Ai2qooo+SeL5RCW+kCKBbBlNwOAE81JWQmJWqORZOzP70XPh46ZI8f689/x4H+T01aJ7wjcok9iEuWzjfXWL4xeMpUrsA5Lb5F4mE5RLnahes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706465640; c=relaxed/simple;
	bh=Pspy7tReYW2Tp3Ac39vO7VVX9A2F0xhx28M1lXFnj7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHocjh4qOizFN1/p3LWQdnFahV9XZr1D2AaMPequ8Ft2e1OADPHCIKBo38NIiySZyCKi1pqjA0HssQATDJ3dDU6vJrS3wObvGkA3MHuS655vDtPot5tSsLhtDERR4VRoiySNalfzvwF4EZrfe9vuaBZXHad8g3QlcO20RyA0G8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IT+88flT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C86C43399;
	Sun, 28 Jan 2024 18:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706465640;
	bh=Pspy7tReYW2Tp3Ac39vO7VVX9A2F0xhx28M1lXFnj7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IT+88flTW0MqhUflwiWODLGB1I86wEqxyV9VCDyPsuyEmuo+5fOPQmUdggF2jH9YS
	 M9XgsgvvISHxeY57Ji8YafH2V1UeDKaqBvhYSxdaGI4RdkbDRk5/Td9Wrt1EWLQPOA
	 4TCN/2EM9awZPi2JnPIFXmOdMDGHpsJXogAVY4wZ7uJBatMDnCWgDGs/nz47NGqVAY
	 w2yd5n8TYk8YdTd9RqNM3pcmRsJhjEyHaaSXLX8BU+VS5hSzCLil4sLz4HSMN0wGaJ
	 obivrYaEQPQdDAZmnlZwySveAqpmPhkLXl+ag5ggN2IdY3ZfRHa3SFHGFkU1VD4QmZ
	 BgbeQRyP9ZCLg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Georgi Djakov <djakov@kernel.org>
Subject: Re: [PATCH 0/2] arm64: dts: qcom: sm8650: mark gpio74 as reserved
Date: Sun, 28 Jan 2024 12:13:52 -0600
Message-ID: <170646562753.66688.12278263670543931585.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111-topic-sm8650-upstream-qrd-fix-gpio-reserved-v1-0-fad39b4c5def@linaro.org>
References: <20240111-topic-sm8650-upstream-qrd-fix-gpio-reserved-v1-0-fad39b4c5def@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 11 Jan 2024 17:58:48 +0100, Neil Armstrong wrote:
> The TLMM gpio74 is also used to communicate with the secure NFC
> on-board module, some variants of the SM8650 QRD & MTP boards requires
> this GPIO to be dedicated to the secure firmware and set reserved
> in order to successfully initialize the TLMM GPIOs from HLOS (Linux).
> On the other boards this GPIO is unused so it's still safe to mark
> the GPIO as reserved.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sm8650-qrd: add gpio74 as reserved gpio
      commit: 361bb7c961403173be109d8892f3c23096dc098d
[2/2] arm64: dts: qcom: sm8650-mtp: add gpio74 as reserved gpio
      commit: df77288f7e3accf246785c53cd5f117fc5d81611

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

