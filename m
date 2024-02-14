Return-Path: <linux-kernel+bounces-65748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3754855127
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C44B29AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A480812C53C;
	Wed, 14 Feb 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Je7DXNbE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8FD12BF38;
	Wed, 14 Feb 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933475; cv=none; b=Q3R0ASmqZFk9CncerxBHQQgmDQbtnV7WD7Y6wvoeLDw8Q8zeFPGopYQI2BPZVQwYy0gby7ourllZKK2Y2vP02FwCNACSFU4DXkXqHpH3DSnVJw1VlJxWzGw5hPpBCatOhOh74wircagQeQcpqXCd3Xp9lFvyCjRiJsPWlagnb2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933475; c=relaxed/simple;
	bh=SPHW5lALlYUpuEASe1CplMnZFiq/SqNSzdeDCWDc9CI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNCYX8581DZ05cX0t+7QVm7qoY5mDJbtPi1Ljsv6haeaBBfts7p/iWSEDrm2oHX54JIQNvnm7skN1YxtLnmvd5VVBar+p9tMwIpECWjbSKe6oA+8rao90ipyFwlzAKhjS8HHF3+tNTBY6EzOyvpUyeLEnJU6bAXzcTO+DbcVTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Je7DXNbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B80C43399;
	Wed, 14 Feb 2024 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933474;
	bh=SPHW5lALlYUpuEASe1CplMnZFiq/SqNSzdeDCWDc9CI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Je7DXNbEBNm4oVW2LTcPlhq0oglWjWXBA8XnS2w7U1EE5+c/KTKjzdxtB+zkt0VbH
	 hnm3hOKZ87VapSMFymry4Nd4PK/R0Np+M79ntdRFqRiSUWefDtRSqkf1dC9bwwO7Rk
	 yFzsgWcP2LOii7yyhME/eStE5zzPYdInvKFaTfBi2ERy5W2vrg8m18V355ICKTLAKY
	 QwGm9gJXhhQb5ZKzpkcjEsBnaYtcQ+MmxrZcOIoF+ARUs+MkqwZAi6ZV3Ibmd0rtsM
	 z0K79PoyVPiJczgK94yRIzi7B++QFz6IsMkDmmZxSHfHRG6BZmZXdTSUEcx+D6l8RL
	 bEoFNix9EvKTg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: x1e80100-crd: add sound card
Date: Wed, 14 Feb 2024 11:57:29 -0600
Message-ID: <170793345824.27225.14357966688713594384.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212184403.246299-1-krzysztof.kozlowski@linaro.org>
References: <20240212184403.246299-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 12 Feb 2024 19:44:03 +0100, Krzysztof Kozlowski wrote:
> Add sound card to X1E80100-CRD board and update DMIC supply.  Works so
> far:
>  - Audio playback via speakers or audio jack headset,
>  - DMIC0-3 recording.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: x1e80100-crd: add sound card
      commit: 4442a67eedc140aa0ce13cad99032a2b910cfb56

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

