Return-Path: <linux-kernel+bounces-95780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6AC87527D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640D01F24788
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9613B12EBFB;
	Thu,  7 Mar 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWCP23kJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFE712EBCF;
	Thu,  7 Mar 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823356; cv=none; b=BK9CQxCTXEYpRAXMZC15ctqqYfsmvuc3A4EAGgCvZAgTHHxx3r3Cx83FEPgj6c4nr3J0MAaenOfS54kUH8WOqKgo7VYe4Zos2EwfLTFlQ7Q+KEROSpt5/o74hK/3EdvTjGn2hjq+wdTDnE9eI0M16Qy9EHPemPd+IKZsAv1EMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823356; c=relaxed/simple;
	bh=oqhDzxC67zeXNLqWajQizZnAUbeIRSZcp2oI/hXjhXI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J3EaGpnVkEu5qgYY4FPfRzF15naV7wVxWUOOBRoQjxIx1HnBTCgsu3f8SNZOP32gbj/Pv3CFRavd2yNpInvrjcqjlDAfM68pyWpbqHfU/ue0fXwkCZXdz+P0Em1Dxq3Me/majeBs2nXgoCCvb7CVjJ3rSTqx8EjHhc+gmZgUJvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWCP23kJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D7AC43399;
	Thu,  7 Mar 2024 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709823356;
	bh=oqhDzxC67zeXNLqWajQizZnAUbeIRSZcp2oI/hXjhXI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aWCP23kJr1IGD+gS0oeZnwCPUYgOnKzyX55IGTU6LbwMQLWQrVwKHT3xz69JAdjvu
	 75gjrr7K6keatM+f+VyKZPJPixZIszJV+3JAbvtrulU/39sD98dnnekPmMGAI7o/hz
	 N2oHoLGCd55c3Pr9p7uGb6+X0aVzVWgm8ciLjzD86fdlJZsh/mC4vhEK+s0va9WpP5
	 cmTfXAZkmG6mTfL72A1/PZYE0G1Rurn/r16cbggfIHsyggKEzdA6VxYaCn8gXkT4Gg
	 7WfVOQzyhsTqrzrhgskkjdI+2rE9RJq2MYDuVAJPitBSkNiVcRMLcuH4ZAy6uNujsX
	 Pd2YNzIqZwMfQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240307105516.40250-1-rf@opensource.cirrus.com>
References: <20240307105516.40250-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cirrus: cs_dsp: Remove non-existent member
 from kerneldoc
Message-Id: <170982335522.46708.14853262664678961079.b4-ty@kernel.org>
Date: Thu, 07 Mar 2024 14:55:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 07 Mar 2024 10:55:16 +0000, Richard Fitzgerald wrote:
> The kerneldoc for struct cs_dsp refers to a fw_file_name member but
> there's no such member.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cirrus: cs_dsp: Remove non-existent member from kerneldoc
      commit: 5d51a794414359dd387c3da7a2ea7602c67f84a6

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


