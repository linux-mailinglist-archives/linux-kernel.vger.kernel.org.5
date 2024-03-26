Return-Path: <linux-kernel+bounces-118919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAD788C13A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D591F62C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795366E61D;
	Tue, 26 Mar 2024 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZHnyN/l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACCE548F0;
	Tue, 26 Mar 2024 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453778; cv=none; b=BrLuztPq4+v7c2IIusnvxk2gdRXFD5sriYWLjl8cKoNm/UkztkEkYEQOAHtYlM0R5gSnDI+5pI+E7VXaM8ThtZX1gS5wby60nsKwidc2gyiwdc6J8sV+VZwJUOZRps6fT3ReCHE+UVHLYp8KcHgX66BXPjvzY0AghijTzh6vKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453778; c=relaxed/simple;
	bh=BFJiq54VJ20G77R+5TuJjaEBvW4xwFaEM9rhhP0Ncb0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZeiOkvNmNMbWeZV8Qr1EC9bEW7DeFjpEH7vj4mRdLGkxbzoELinWymDYIIi4yAUoDAfxolNZ61YWg+I6uojWK/7pAemLhZWnmV3TOC8lh/hhmi+PLn6EADnWK4OVTvwXzTO2ONJAZKD16UDHcM+sArlzrOX5qviBMhfmZR+JsSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZHnyN/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E00AC433C7;
	Tue, 26 Mar 2024 11:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711453778;
	bh=BFJiq54VJ20G77R+5TuJjaEBvW4xwFaEM9rhhP0Ncb0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rZHnyN/lxkJ4rEPC4b/yDmCFVNZcBBMryLgCqqnuFy+L5PopBPEvkDFxKQbNXZhe1
	 CzAgNucLOHLSxf0ZOxDDf2FRJQEA+Nvzk0p9npnbmHMzVxhQQzHkyN00i+s+O1gB3K
	 kThRq2wIvrF49mIjpl8KkuLiuRL/V5oq1cgtfNWSlPKejp52VHRMa4tVnOyS6iVVee
	 PDjdDTO215U7x0pF0aF7PEOFw1iBflI/mV1GQH2B00pGld+6xZTKXww3xAtUlT/gto
	 pd2aSLd1sEER8Ooqubtcw+veag0FJnPaUPzEnexz1D06jxhfqsWbGgejX66xYKKbAp
	 PTnwtrCSsL5Tw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, Kartik Agarwala <agarwala.kartik@gmail.com>
Cc: patches@opensource.cirrus.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 javier.carrasco.cruz@gmail.com
In-Reply-To: <20240325181943.116733-1-agarwala.kartik@gmail.com>
References: <20240325181943.116733-1-agarwala.kartik@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: wm8974: Convert to dtschema
Message-Id: <171145377605.25584.16707436600302080995.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 11:49:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 25 Mar 2024 23:49:42 +0530, Kartik Agarwala wrote:
> Convert WM8974 audio CODEC bindings from text to dtschema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: wm8974: Convert to dtschema
      commit: b340f56a74b62d8ce8617650c8ab4a26c87ba5c5

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


