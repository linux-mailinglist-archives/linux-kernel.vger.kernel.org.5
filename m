Return-Path: <linux-kernel+bounces-137440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D338F89E22D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6B1286EF4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C182156C5F;
	Tue,  9 Apr 2024 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSqvynlO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87515156C4A;
	Tue,  9 Apr 2024 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686100; cv=none; b=sBaNzQ+0fZuU0B9IkQ50VUh3WKBb67kKGBnxihbPBFYmLjW/6LroFvvDOZiYj+hZgii09k6g5BRPZbi7eAOXxHON6DzFA3LZDSWnlWgfsVI6WxgXNu/CgXNREzOYjtTJLqbSwKOtBkWE3T9RNOxPuRsfTKIbFjWWQDEkzMx+7d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686100; c=relaxed/simple;
	bh=HHFNJYwTjbYiNwN7KBQiqaYMGmiWrEeJk4tI3/073Ic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CBtPB0s4KwPhebo6vdtr6OPbIYy1tw+gcVh6LaPpkqyecTNkXJiGE5u55TUP9f+gBRo2TNZ2tu7ZyyRtq8gwxxrdKlcH0C1B8HkYMLRFN4tV7jwPQhXrOckB4KXmfEL+VYvQKdfBI69hTigBHeUNo+SevpxeQ1iQ2EAv5Gx7H5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSqvynlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B251DC433C7;
	Tue,  9 Apr 2024 18:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712686100;
	bh=HHFNJYwTjbYiNwN7KBQiqaYMGmiWrEeJk4tI3/073Ic=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MSqvynlO7AdmpCHYtNqlRDUVkxeAXpv3n8J3df1XEOeOwanWEi24e/T+VZ0xXbqAt
	 SHdffs9CYQkkZW3ZLvputSyTwOzxpjRvriydwoqFoHxvIpTbH5V4StELvg8HVqKi3o
	 Vb1Z5BBv7MSzg2L4NouiBqsC+f/Ug4hiZ0eGnFjcgrh85QJsl9TsM8Bc8tjZL8LQ8B
	 H4LS9NjV45+kUHwD1M6Ig+rh/hQgshizEutTDc/RSc1k1It34zkqXKVotOCkBB4IXP
	 0m80G1R5HKfcltGtpQEuzvcQllPpgAC2khZ0NqdWky+GJaZRNm8oEqSr4ex3FZg5FO
	 UWWsQdNex29KQ==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "end.to.start" <end.to.start@mail.ru>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
In-Reply-To: <20240408152454.45532-1-end.to.start@mail.ru>
References: <20240408152454.45532-1-end.to.start@mail.ru>
Subject: Re: [PATCH 1/1] sound: Support microphone from device Acer 315-24p
Message-Id: <171268609844.62778.6340689132993321193.b4-ty@kernel.org>
Date: Tue, 09 Apr 2024 19:08:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 08 Apr 2024 18:24:54 +0300, end.to.start wrote:
> This patch adds microphone detection for the Acer 315-24p, after which a microphone appears on the device and starts working
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound: Support microphone from device Acer 315-24p
      commit: 4b9a474c7c820391c0913d64431ae9e1f52a5143

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


