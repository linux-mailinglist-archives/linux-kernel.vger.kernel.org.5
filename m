Return-Path: <linux-kernel+bounces-139267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8D98A00B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631A51F225AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5710018132D;
	Wed, 10 Apr 2024 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3cqpK6e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ACD17BB11;
	Wed, 10 Apr 2024 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777851; cv=none; b=HO8y2u8XPRPL7D+IOsNatfwQoBZ8RqLUgazWWHncmaDeCOzGWj1u2Gm0LLtfzxzQGtZ4UYzCkVrqaXBFFbknb7iH9eFQb4ZBGn6cUcFjuHIatEUZd8m43rTsdwE/1mT/bIr17kJ5Ea9hlF9Fnv+PtrvKqVT3/HFJ8xH4m9lnmbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777851; c=relaxed/simple;
	bh=w6hJGaeHzD2gaTjgLqIvwC0rZeyvDeCqC/y9xDZvMYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ImkitcYIAG58AruXIZfzA7/b9T7dky35277rvvBC59kd/N5RJASK55LYXdN602JZQ8Jwr3QhfOOoqijYXPEidiJHSeNZQMfMi34n8C0sofsMEIXOc8NoeJYBbaMK3jFGwxWXuA08Sd3x71YCSo3WU7f0wQUu0mg2G1dxsBnj9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3cqpK6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2784EC433F1;
	Wed, 10 Apr 2024 19:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712777850;
	bh=w6hJGaeHzD2gaTjgLqIvwC0rZeyvDeCqC/y9xDZvMYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=J3cqpK6e39xYpoZNY9xeNzWdXVesbDB57qaZz67kNO0vjAtpE4eskU16t3k09zbls
	 w9HEA+4+Z2Ds5FIneC9VdJe9pq3BHCvYTSxL9UblxkIBKyei0o5/xm/KCI5+SVWqCo
	 wrvWQKQNBnQwuVyu2e+O6XWnw57jSQhYsQiBxVAQt5OscQ7eBmayXxYtn276tOAExy
	 Ezgyk8OYkUo7nLsEPAmF371KcawyHHigpI/CAy4IjpqtQDHqK8CzcAIUQ7HzeYxBeo
	 FbQkcBvu8rHFy1dkSd2p3AsNuNZx1qaauNylvnesr1p3oVEHgXzMeqhksDLl2gYvSM
	 uGzoPvOhDzTcw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kousik Sanagavarapu <five231003@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Julia Lawall <julia.lawall@inria.fr>
In-Reply-To: <20240410130205.179069-1-five231003@gmail.com>
References: <20240410130205.179069-1-five231003@gmail.com>
Subject: Re: [PATCH] spi: cadence-xspi: use
 for_each_available_child_of_node_scoped()
Message-Id: <171277784885.58234.7125195961063638133.b4-ty@kernel.org>
Date: Wed, 10 Apr 2024 20:37:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 10 Apr 2024 18:31:16 +0530, Kousik Sanagavarapu wrote:
> Refactor code for "is the node's child available?" check by using the
> corresponding macro instead, which reads more clearly.
> 
> While at it, use scope-based cleanup instead of manual of_node_put()
> calls when getting platform data through cdns_xspi_of_get_plat_data().
> 
> This removes the unnecessary "node_child" declaration out of the loop's
> scope and auto cleans up "node_child" when it goes out of scope, even
> when we return early due to error.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-xspi: use for_each_available_child_of_node_scoped()
      commit: b0f3e56938f8cc8c4d606846270b879650ae7741

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


