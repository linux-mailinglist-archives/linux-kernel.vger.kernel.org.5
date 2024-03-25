Return-Path: <linux-kernel+bounces-117624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B4588AD6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077F21C3D7C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19631137C26;
	Mon, 25 Mar 2024 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsc7wYOh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF01138483;
	Mon, 25 Mar 2024 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388663; cv=none; b=hP9nNgHOV9wdkHttDNT9zXSD/xjBcoNncRqjsEhHhzMc88hbxVp6MjtTIytMsbNk/Xmw3hg5hpxp7gV0EeQHPq7gUmZtUXupA+Q5/0Um3mKPxZLMxL0HQBmDl+LWhk/h25RGemImrPhSqMx13UMz9iMAicHkPeniK2jmoLoWhPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388663; c=relaxed/simple;
	bh=HlljRfHMf/NCDYPz3TGWCjR1ccq1BkXlPa2kqP/9HKY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tF77mIAMoZR0iLfJ1OGDh/pQW1eSU/8u6v09nj4DqixEg/tP8nJq5SFIn1Pk70va39W4E3Grt8dJe5EzKERkt0lPRMVX8i+/mFvDq2kR7LYDBO9R/5N1b8Fvd10r0G9P2dgasT5AtHikGr7D9p/62pR3pV/+7oLRF4h9bY+qnio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsc7wYOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CC7C43399;
	Mon, 25 Mar 2024 17:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711388663;
	bh=HlljRfHMf/NCDYPz3TGWCjR1ccq1BkXlPa2kqP/9HKY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gsc7wYOhgpEDVTcEDDVzWajrpaIq3xv9OA240ao53w2I96vPGodgHDHJuktQn3ehL
	 yxf5gceioW3vXyw0lugBgOYKGa2UkuSs6XmAH+KJXyos7FYKIO8W0WHLcyOhZltBPC
	 Lklsz4GSmiT50Mwm32LLwKGZLwpjsoiebOhWrXqsIobqWFFukFKkV1ugC/SWHt2l03
	 x023hxnvWtJp+nUzCOhLB9AXLOWPzzdSHrVvoQbALpBcNw3KJxNWxJU3o8iIXbEAxK
	 yB1MMJ/GV3O+3gIt3zVDrhAWrq887r+6X6Ml493ijgHoEuYN/ffKeoq6/k4y4oIo7X
	 g7QkEDnYeGnPQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20240321150401.2464783-1-Frank.Li@nxp.com>
References: <20240321150401.2464783-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] ASoC: dt-bindings: fsl-audmix: Convert
 fsl,audmix.txt to yaml
Message-Id: <171138866108.327140.7729342706027918016.b4-ty@kernel.org>
Date: Mon, 25 Mar 2024 17:44:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 21 Mar 2024 11:04:00 -0400, Frank Li wrote:
> Convert fsl,audmix.txt to yaml to let dtb check tools check audmix part.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: fsl-audmix: Convert fsl,audmix.txt to yaml
      commit: 33a499668eb6781a4518e4facf2d85cc8cd1a650

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


