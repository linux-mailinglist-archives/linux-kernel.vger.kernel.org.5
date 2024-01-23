Return-Path: <linux-kernel+bounces-35251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C962838E96
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1E1B24A82
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005805EE95;
	Tue, 23 Jan 2024 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGJxTBq1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ACD5EE81;
	Tue, 23 Jan 2024 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706013128; cv=none; b=PWu2/Y35D6tWoN1KvHoDe7Kg1Z/Zq+AQcMt6NnY/Y+WZoldmto8DLAcfjaADtDA6wcEVw+qNohM5rOe+w73LsLxt8HXzQrqScq5M/xFs4KQ1FThIWQo8g0VVny47mVXaBVaywGv7ciPTPmK/wO+jMfilF91LLxcv3YeQA2eklMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706013128; c=relaxed/simple;
	bh=eIaoqD1aP7q0tX+n/D0HYnrED9MuTgaiRPG9ItAjvf0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HepSbw7MquwgX4L5Ndh1WGGynEggjD/npVgoetpP1okdCr6igLZmdzsnt3Lga6AUgOChx85VidYp0WwXMqNP7h/9I1VJC6fpCwGHM6x37wdm/XSD6iX9lw+vh9ATd2IWnEOl1GyyfGYmZbfl+b8zu+kp3CE0sikuaZhiSwcIevk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGJxTBq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAA6C43609;
	Tue, 23 Jan 2024 12:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706013127;
	bh=eIaoqD1aP7q0tX+n/D0HYnrED9MuTgaiRPG9ItAjvf0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LGJxTBq1W2wWu4ZanyaeSUle/YNC4Jsv286s4YxLoJJLAykd0LAlI94hB8j9qIkIw
	 3fc74pBHUz6/6Qvl+olZv9+/n6LH8fF2EayeEmA1LOT8QD+WPnTPEKd1AKveniRPre
	 2GgI4m8Jly9hcnsCpn3YWdNjsFk3aOAol6eQ1jZ7fM4okaoGgFbxNTv2CMSZ4SH1tl
	 hAb+ZZwWpsq4ei6edMwvwkJTZ0GJ/xbtaY9QxVL8l3aQP83E873KGTbCOTiEBaBfok
	 X2bOGpiUqrEC8rLNgDb0hgz+Ci0nNSJIYTI/b65wTBrApIGwj5s3/ZXzTvQ/FpKCSY
	 r2fa8rM87VamA==
From: Mark Brown <broonie@kernel.org>
To: conor+dt@kernel.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, han.xu@nxp.com, haibo.chen@nxp.com, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: yogeshgaur.83@gmail.com, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20240122091510.2077498-1-peng.fan@oss.nxp.com>
References: <20240122091510.2077498-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: fsl-lpspi: support i.MX95 LPSPI
Message-Id: <170601312541.19682.3072980412481035227.b4-ty@kernel.org>
Date: Tue, 23 Jan 2024 12:32:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 22 Jan 2024 17:15:09 +0800, Peng Fan (OSS) wrote:
> Add i.MX95 LPSPI compatible string, same as i.MX93 compatible with
> i.MX7ULP
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: spi: fsl-lpspi: support i.MX95 LPSPI
      commit: 6685d552a0cc3a86e10dbe6d98e1b51717a27a63
[2/2] dt-bindings: spi: nxp-fspi: support i.MX93 and i.MX95
      commit: 18ab9e9e8889ecba23a5e8b7f8924f09284e33d8

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


