Return-Path: <linux-kernel+bounces-71673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ED085A8D5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24CDDB23024
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786F03CF76;
	Mon, 19 Feb 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBdlZSZ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9FB3C082;
	Mon, 19 Feb 2024 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359829; cv=none; b=eOA1Kc6THdeYaR6KPj+CyCMTc+MIyRr3lnEQrkG1LMdHkpGL0qT8Yf0CPewgOygohnmSKTHyl/PtVVyD6x/jOdR10akeFmgAXumcV1TzfjYmJr1c9h+DD5Q+fX0uaD7Q8IEqhu7AC1z71l2PHpP4RLiSIq1fggy3LIiBvycVbE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359829; c=relaxed/simple;
	bh=3TaEMNwc1sACneFvya4ZgRhN24IEHV8XP900tswpqOU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eBy01xf0a/TfRRtjM9AcomSXViPrIHoyPLkIxor6/bwVbyZN0n9+45c6/QZepdUmMZQiQ75hMg66p4GUFwKTBw0862rhf9Q+SDdt8/fC7aL7HNhG4Fcg3IT8elYiwF8q98cF7/vOuZUCWA84+ieeO60vwDgkHTmBkvPzmgelaAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBdlZSZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05658C433F1;
	Mon, 19 Feb 2024 16:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708359829;
	bh=3TaEMNwc1sACneFvya4ZgRhN24IEHV8XP900tswpqOU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QBdlZSZ3/jh0t5RrjsMfWFAd8OECarSKuRBgKWCIQv31MZqKChPKwlLazCFZ6T5YF
	 11dFD41YY33Ki3ZhTy1Fm9jBmArtxi6RFa1CNWMIXi6UAwQ2SdXMa+z1ywpv09ft7k
	 KLe3SSwhuNW9+be6rm08IdoICuoFiL80aajLLOhFXRl9VTXIBISnWcMFsvsMVSLLl1
	 GqQ4HKDme3x5BnRP1cFQ5hKxssAG3Mtad+D4jxQfbqIBIw3WwHP5WuU8NP8ZDCknFm
	 4Jd8yPc9k4v8bp9oAmqLwIzqFQKs/0ygQUKo1d5aHTcgcLdKT/nLNj3UgoU/j5i4eT
	 d2D+cmXBcT90g==
From: Mark Brown <broonie@kernel.org>
To: andersson@kernel.org, konrad.dybcio@linaro.org, lgirdwood@gmail.com, 
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 bryan.odonoghue@linaro.org, gregkh@linuxfoundation.org, 
 quic_wcheng@quicinc.com, Danila Tikhonov <danila@jiaxyga.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <20240217163201.32989-1-danila@jiaxyga.com>
References: <20240217163201.32989-1-danila@jiaxyga.com>
Subject: Re: (subset) [PATCH 0/3] arm64: dts: qcom: pm6150: Add typec
 support for PM6150
Message-Id: <170835982675.1195521.16416838868807847765.b4-ty@kernel.org>
Date: Mon, 19 Feb 2024 16:23:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Sat, 17 Feb 2024 19:31:58 +0300, Danila Tikhonov wrote:
> This series adds typec support for PM6150. Was tested on SM7150
> (xiaomi-surya).
> 
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Liam Girdwood <lgirdwood@gmail.com>
> To: Mark Brown <broonie@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> To: Wesley Cheng <quic_wcheng@quicinc.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] dt-bindings: regulator: qcom,usb-vbus-regulator: Add PM6150 compatible
      commit: ec29a4d9b7c7329afc61e7932cb91e9b292b2b74

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


