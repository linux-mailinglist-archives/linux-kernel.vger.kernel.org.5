Return-Path: <linux-kernel+bounces-139337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5678A018A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF0D1C233ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106621836E4;
	Wed, 10 Apr 2024 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5eAqxz5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C43181D0E;
	Wed, 10 Apr 2024 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782542; cv=none; b=RgmMsjJkfv9Hwajk/MHjXgS/v0DFiv7MuD3utFghwW5VKIghefLE00+s+zi7rtLZotqBiYDmanFpFqdmEHpT3mFkrA8F9sWyJ/TTTG0yiVKZnkaZ8v9Y5njiU90hs82NYipF+gXHfgJmDwbxmUwu5JnZqwFMyllN0cKlT05cy1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782542; c=relaxed/simple;
	bh=1fYUihKmz+w7nrA/FjAUTSJZtMWHKfN+hN2ym7MkZjs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jQf8r2Cqs0oaWKB5TGJKrMtbbI/E1/vun2JVxh5XnOO2vb9r6yCxje9nUezsHgKw6+pfnvzORW55OlHZf03r3wXvuysVzSBA9PqEpmU2v6hLNimD69Mo2Gn0F2B6X5pmizKHcGjR4hWkuqyj5mBcGgLSSh8ulkWnb2F74CydRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5eAqxz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAE1C433F1;
	Wed, 10 Apr 2024 20:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712782542;
	bh=1fYUihKmz+w7nrA/FjAUTSJZtMWHKfN+hN2ym7MkZjs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=K5eAqxz5q0e5EObEd5IkijNDnbvJmUPvi/B+Ab3V9XvW6Qvt1ESAaEuoEdX568kNj
	 pEJJa285qRtMQ9MEmwiLnbqDG3HFx1ljDuni6Q3bXzpswlWbyckivHc61n/4NYn3oe
	 ZlmWqn7arkxqPLJQiVqiuEHPdh04JGkQ+Sj+o3ABRvdDCmCliheE5HdMvlzyGveYsn
	 gYBQbnbAuOcnzW/3bwzY84U4yse3R8hqcnu4907hdD7lT0zexUu2kBrL1m5guA7ZuU
	 ePBJMLBS5FH6qLki7+L36qCVWMAF2lTuIS/i5orFB18tWerTcwQeUR1LqNKbxeuKEH
	 G1OFuqrfzA7oA==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240410161312.22313-1-rf@opensource.cirrus.com>
References: <20240410161312.22313-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Include array_size.h
Message-Id: <171278254083.69181.1643120705707152702.b4-ty@kernel.org>
Date: Wed, 10 Apr 2024 21:55:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 10 Apr 2024 17:13:12 +0100, Richard Fitzgerald wrote:
> Explicitly #include array_size.h for the ARRAY_SIZE() macro.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: Include array_size.h
      commit: 4693b120299a5893034d1882ddbbe08af1d2ff07

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


