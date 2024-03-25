Return-Path: <linux-kernel+bounces-117630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF35788AD7E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FA53653E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56A213C81A;
	Mon, 25 Mar 2024 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yz8AQU2p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D42F37;
	Mon, 25 Mar 2024 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388687; cv=none; b=lkttYXWoL+EYu5uTy9Q/NkrHf6ssQrX/EddInwSXf1Xbzp8YGNiVz+9pE/v1T7KIiusge0pNtyAF2sAFBZ8ocjIaHGx3VVDYPFMfWGnzFrcxpQwGwEswCzzzMZfPut1YWl5aOP7bAJf2LNorMrTL0kk9Fqj+W7I4FSoPjSwvtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388687; c=relaxed/simple;
	bh=sGxgdgp8IdZweLfej/ZPALfocbt++oorzgjstiDxN2g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pnjVkdzfIwECXgDd4Wb2jo83E8JRIg9HDiMkYL3XdPYLRbMdsWpnzpdrBcFk5oYMqtd9swSAGo2c1BQZ09/JkbNF8DJmac7+Qv2kCK9SpcnpI/ZG8EvGKS0O0BEX29LYIEUZ1XI4BgGxRLWXoy0nBlLEyEJaVRCJtp6EK+ysv0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yz8AQU2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BF7C43394;
	Mon, 25 Mar 2024 17:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711388686;
	bh=sGxgdgp8IdZweLfej/ZPALfocbt++oorzgjstiDxN2g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Yz8AQU2pf0m8iCdqgpUDqgULidA/gav9A6k8kAFVuOmJpP4CsOW98If+/vkoh05yM
	 fXhNkOkr2v2lY3vyrYiV6e6RjYGmpbWteHnaJNxqO9WKpyXFfEEJnPK7GuHU0OakQM
	 jG1La1JOKMR/YS5hZkOfPfJMSkchrTwUFY1/nq9YBHy5m5xMWcTJPbzVzeQyutDfDt
	 /Kuz9bdAXkt70jMbd/JpGOgzaDvtAqo1X5cdNoRRPOg0IKEWdTOccn4PL5OkOOGcWX
	 OmxUTE6wLwzfnZ+sUtsSqZbhBdEsePVrp5HVzeYQASol3Gpg7yjb6ZReH7Ql7v3i5K
	 kW7fhrLJxzkFg==
From: Mark Brown <broonie@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <20240322-fp4-tcpm-v1-0-c5644099d57b@fairphone.com>
References: <20240322-fp4-tcpm-v1-0-c5644099d57b@fairphone.com>
Subject: Re: (subset) [PATCH 0/5] Add TCPM support for PM7250B and
 Fairphone 4
Message-Id: <171138868340.327260.16162463727167389208.b4-ty@kernel.org>
Date: Mon, 25 Mar 2024 17:44:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 22 Mar 2024 09:01:31 +0100, Luca Weiss wrote:
> This series adds support for Type-C Port Management on the Fairphone 4
> which enables USB role switching and orientation switching.
> 
> This enables a user for example to plug in a USB stick or a USB keyboard
> to the Type-C port.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/5] dt-bindings: regulator: qcom,usb-vbus-regulator: Add PM7250B compatible
      commit: 0c5f77f4eaef8ed9fe752d21f40ac471dd511cfc

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


