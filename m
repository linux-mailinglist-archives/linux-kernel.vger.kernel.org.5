Return-Path: <linux-kernel+bounces-43606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D08C841689
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C471B1F22EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F7C2AD1D;
	Mon, 29 Jan 2024 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anLwcBlC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527DD51C38;
	Mon, 29 Jan 2024 23:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706569728; cv=none; b=Ioz5I0I+GUtJ66+P1pqYTgDUaSAlxXD+6pFDtBM2+p9sPyRfMAZE2Iu3iM0PRKRzxyu7HGYiTivzcB5EPsbTr2Fnr8+Z98gRO+SkBAViw9JI8H6Obnc1cBLc9qrlDqx2WrHJ0ZvX5L6JKjs8gbkthrcBb1HVB53FNUUE4j5Ajy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706569728; c=relaxed/simple;
	bh=WpjL8udaT7mXrtLXoK5bhYoyhAJ9SBcm4G6f1hxbSHg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kVBNtOSSOxZBMkYeMFdKnnC+dUeg/wcy7oKBSRdP3yIrkkrm4Q4GszRw0Y1SkdujqNCF36wKmpS6EQN1Bn4QWQNYRagppg6Gx53sjpjnzh1iN0NnnUDxphlYKe2gs+Shkp2wzh3coYhoIxOiKIqfGrCygOYkiBx/sxBPeJ1FkKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anLwcBlC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D3FC433F1;
	Mon, 29 Jan 2024 23:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706569727;
	bh=WpjL8udaT7mXrtLXoK5bhYoyhAJ9SBcm4G6f1hxbSHg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=anLwcBlCjDMudDdNwqvbnuDC2vP3itrRiNfhTotMkEkk60RnXXHAt2WQe7pCakLR6
	 dbyaIOq5G2SedbBJVC7z2OJ/UK6qD1hlQtQSoKURysinidt2IQo4Bu43CbWKfofgf1
	 BrBnk3T2qhkccJL4gjgR5Vrvz3sHM9IBkoz1iS9Hm6J4cgq57dnpVL6jdQ4/IhCtrE
	 i3FVc37/efg4+coVrpI4q8zus6+s1eQGdW2Z3zvwRnYmsWo9K10GrHD0JeSeZP/OrL
	 5U54Amqkb+eIaDdckXN3HWbVQ8t3PW7kbcJVvA1cZ7awnjRkVkVynX/sMMEVvNuPOe
	 1Xp98gfVtDGpQ==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Marian Postevca <posteuca@mutex.one>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, 
 Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20240128172229.657142-1-posteuca@mutex.one>
References: <20240128172229.657142-1-posteuca@mutex.one>
Subject: Re: [PATCH] ASoC: amd: acp: Fix support for a Huawei Matebook
 laptop
Message-Id: <170656972577.167619.10975309830352021265.b4-ty@kernel.org>
Date: Mon, 29 Jan 2024 23:08:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Sun, 28 Jan 2024 19:22:29 +0200, Marian Postevca wrote:
> Previous commit that added support for Huawei MateBook D16 2021
> with Ryzen 4600H (HVY-WXX9 M1010) was incomplete.
> 
> To activate support for this laptop, the DMI table in
> acp3x-es83xx machine driver must also be updated.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Fix support for a Huawei Matebook laptop
      commit: 5513c5d0fb3d509cdd0a11afc18441c57eb7c94c

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


