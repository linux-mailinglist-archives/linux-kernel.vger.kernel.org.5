Return-Path: <linux-kernel+bounces-152666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063098AC27C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79844B20A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 01:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8507A23AD;
	Mon, 22 Apr 2024 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1AVS3FE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1381E;
	Mon, 22 Apr 2024 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713747613; cv=none; b=PSZgIMI2+DE77NFSXOhlzwToXisp397YxVRyd+ghdGuoI2EvcjMDW7vsZKCFBnh67XOSTD0748YBUbESLhTBYJecsV1qcFojSaaNkphhaK+i7V0ySR10MQU3L+zeZJavp6nJz1xqOjw6SZniKzfyJoMMpp+tfq0eRHLwVXwPxJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713747613; c=relaxed/simple;
	bh=Jo5GLpDVAtw6KmEtu1pSOOIeDDi2iY0lr7se6Z5MD58=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rGYKXkObwaOaSqQU3a+s4Zg/YqlU30cXEXAZvm6b/xpqMwGNbepvtdXVWo4k0vhI3TaNQdqwKROlQ3Q4QxxJFkzHjnHrt2I/+bKhMaLSGeyXCZVH8cWFIabRJICgAKsjHhG1Fdy5lZolbIGV8uEyJzEm7Q4pjavYLzo2hf2JxL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1AVS3FE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64954C113CE;
	Mon, 22 Apr 2024 01:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713747613;
	bh=Jo5GLpDVAtw6KmEtu1pSOOIeDDi2iY0lr7se6Z5MD58=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=k1AVS3FEVb1A5ZVqS0ZV5GbJR1SzZUNSF6np7NY/wRoQHEr8bD7IZyohxAeVCYFrX
	 zAd+72ya36ZqdRU6URDN9h9OOAwNKqLYWuw1uTx2+98zSSi/aTYeTS63zzX1fvA2ot
	 lyS5JyymbhiYijmFf3ZHkdJhM2jT8GFyJwpzJ4/x4o3fLRcs9bEwrWqyGl8JzMG0n8
	 JgOB7RXSLZWPQ9pKjfiwFdTJUrYvp0JQWIZRvPwPac7pqOnrMhXMoHXQOhujFly2ej
	 HqdbWzmbwYcyZYdKKgGVy8K3wKHTTz1XWQgqTlwjwCAexVrv6dHNpcezLfdHSR8iNw
	 QgjmEWKyCs2hw==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kousik Sanagavarapu <five231003@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240417052729.6612-1-five231003@gmail.com>
References: <20240417052729.6612-1-five231003@gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: armada-3700: convert to dtschema
Message-Id: <171374761101.1750169.10431464482219862357.b4-ty@kernel.org>
Date: Mon, 22 Apr 2024 10:00:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 17 Apr 2024 10:57:06 +0530, Kousik Sanagavarapu wrote:
> Convert txt binding of marvell armada 3700 SoC spi controller to dtschema
> to allow for validation.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: armada-3700: convert to dtschema
      commit: f63175733f91da6b668018c1c31786ec448adaed

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


