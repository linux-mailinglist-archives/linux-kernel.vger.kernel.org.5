Return-Path: <linux-kernel+bounces-40683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD17F83E40A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 628EDB23848
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763AE25547;
	Fri, 26 Jan 2024 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHeDa9TY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE754250E2;
	Fri, 26 Jan 2024 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305090; cv=none; b=cavSt8mDwlAunqRdsVxpGgIf5vdb/GXleZzuEUJKQ7YWjfbncQLEoWQ7sVocoSDtNAOU8/iLC9kfnDeTmh9Uq4jiwQOK2EKK/Tltv3TKIaKkX03RnLTSlVkFSI/4U7zDkOrwELB6Zo+fXs+XhWlbp02iDzyPBd0kZemaj+uGEJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305090; c=relaxed/simple;
	bh=vO6Gr5GyXh5tlWuEvRivZoIQNu/GhJ0SdDW9dLqaJkg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gM30hHWjP6KpzB/e/4+YvL280Ckeynp7Lzg/gy4MQ5THROdwzClODOxyyj91QeGNyfID+8egSEUO//D7+WjdjHEz0gocAPB2FRH0XwT3PuALiim3sF9j8M92/VSI5NDbYPPG9jwtEgSV/8RQ4IMg43XV71YxsKXMgMO9sADdawA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHeDa9TY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCF7C43390;
	Fri, 26 Jan 2024 21:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706305090;
	bh=vO6Gr5GyXh5tlWuEvRivZoIQNu/GhJ0SdDW9dLqaJkg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RHeDa9TYwvcqsrOul/V08dEjXxkklKvSiB/1GrgwNiiiet6avB1yuRnw6cOugZEuG
	 4wYEXLEBw3cs5xlosy23yCoErorCYs0HqxBs4ndaE8chH2XRKZcvzY+uLUudnOfFyf
	 RTYciPkiCxdqh3d/fGukDze3BW4B1vGDtgEK6jXwEyXJxuLjBhV7je7zjZKAxRZaBt
	 8Q7rC1KioTEF9lYJWu9uL4qb8Tys4Bqz/uCbQmHlagSymIZ69fJeP3VZ2sqTV/uRZ4
	 j32iHo71jimMQfEHGT9J3sHR+zBsGFKbdGcDqgl9NGVlz90hfK7i0UlyDobeQdKkIe
	 9IUjcy+GfvZNg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Rob Herring <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240124190808.1555263-1-robh@kernel.org>
References: <20240124190808.1555263-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: audio-graph-port: Drop type from
 "clocks"
Message-Id: <170630508850.52716.5172843197960717999.b4-ty@kernel.org>
Date: Fri, 26 Jan 2024 21:38:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 24 Jan 2024 13:08:07 -0600, Rob Herring wrote:
> "clocks" is a standard property which already has a type. Users only need
> to define how many clocks and what each clock is if more than 1 clock.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: audio-graph-port: Drop type from "clocks"
      commit: 01dffdcaa094858a03e3694694815f1a4915940c

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


