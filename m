Return-Path: <linux-kernel+bounces-73880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A836785CCF0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3853BB21207
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530017468;
	Wed, 21 Feb 2024 00:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cks+HwHU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C506FBE;
	Wed, 21 Feb 2024 00:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476528; cv=none; b=iQyAzSveSyKcW01/W168DiqNdKP9r393pku/LYivfExObWgbnCTzWUlfDQnyl+Fu9iPc185+knDXzYiG6NM3ozgPjcj0zKGrhATgc0iKm4TdtDFCGc23eDXnlghV1qepKL2l3asGONkp3a0DPu1ueqaMjEjrRRjgM218QnzD7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476528; c=relaxed/simple;
	bh=Z26wBzvMatb73janE/pjbUd/FUwUvp+X7ENzvMeozC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rfgRHiRfsB15XHG8mQkt1QtTHabdbVBSnhQjAaaewAq1Z/9FJWuWdWiaO2yU9fy5Q2NUpkfXrcnlUm5bucbxj2LMJM4pfwUKsO/NsnhqE0DPBv+R27Bn6O1Yf2AtX8Meus7Dz1Yxgo3oH75RUo3ciEtDXKWanRrg+ouzRwevVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cks+HwHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C64EC433C7;
	Wed, 21 Feb 2024 00:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708476528;
	bh=Z26wBzvMatb73janE/pjbUd/FUwUvp+X7ENzvMeozC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cks+HwHUpf66KkyPRfCtDhk0NzUfRpCREYYcUP/i8K1bjpTPBSuI3mrAm6pb72hau
	 6JZGfhhZD22Ki/NEDLMx78gDod6ltpH9LqeNWDABaxL+rXUihhuBzDalrKjak3BHfO
	 NbSZUXjjLmOIz9x/cqFI6XBmAjpGO+oK//F9PEyYdKb+5B/JL3sxUk1VzhFhTPY2fj
	 yTELobOJYPD2O1TduG/qV4I5Chh/f1J6e40W7vsDr4AnpKZVNYvqRZTyhdd+HCgudR
	 IRqz28x/23rnv2LwA++sKc0ctrMX+wtPA2XuL4hO2s+whO6/TeZVcmLprSi40qQz55
	 wU7Y3wn7OL6Qw==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240216142219.2109050-1-colin.i.king@gmail.com>
References: <20240216142219.2109050-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: tas2781: Remove redundant initialization
 of pointer 'data'
Message-Id: <170847652597.70487.7579277890832174117.b4-ty@kernel.org>
Date: Wed, 21 Feb 2024 00:48:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 16 Feb 2024 14:22:19 +0000, Colin Ian King wrote:
> The pointer 'data' being initialized with a value that is never read, it
> is being re-assigned inside a while-loop. The initialization is redundant
> and can be removed.
> 
> Cleans up clang scan build warning
> sound/soc/codecs/tas2781-fmwlib.c:1534:17: warning: Value stored to
> 'data' during its initialization is never read [deadcode.DeadStores]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Remove redundant initialization of pointer 'data'
      commit: e480c0991db00b24b39010bfd56eda5ec2417186

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


