Return-Path: <linux-kernel+bounces-7452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7577581A812
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159DC1F23F35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC72495CA;
	Wed, 20 Dec 2023 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INDbM8uU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCF4495C1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8407C433C7;
	Wed, 20 Dec 2023 21:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703107903;
	bh=zR4NINfPxeA9HZvGqCRax+FlzhwX67Hcckuywh0bgBQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=INDbM8uUW8n6fw1LVIMWoIq/iOyDxHOXQo4mTLVdtx14NqQalFNWwPRQCEyCQSuza
	 LWhi3P9pFDjqbhkDCam1Lf+UX9/Y+3P9iSyRmfn2KRJlkbyJu85gR/SQwZKW+NIofL
	 ODs2RDIkDm4uJuhHgw24a/D4PIUOQ7I2UU+IO9r9CJeoHBmJB9JnrB6gUmdqqwtXyF
	 los3SmfOaWOtXDpRMWpSrlkkzd28xJt+x0ZmLdZXhmcjlW0c4MGKzat3aVel2YIPyz
	 VL9+PUOQMw99Amta5VkUl4SAftSQEUmzhT86s1CWvSz8c6gg45txXD/am8dnqz1z3S
	 P0Ijg39qxBHyw==
From: Mark Brown <broonie@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20231220175829.533700-1-dmantipov@yandex.ru>
References: <20231220175829.533700-1-dmantipov@yandex.ru>
Subject: Re: [PATCH] regmap: fix kcalloc() arguments order
Message-Id: <170310790265.23118.8891770750138347096.b4-ty@kernel.org>
Date: Wed, 20 Dec 2023 21:31:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Wed, 20 Dec 2023 20:58:19 +0300, Dmitry Antipov wrote:
> When compiling with gcc version 14.0.0 20231220 (experimental)
> and W=1, I've noticed a bunch of four similar warnings like:
> 
> drivers/base/regmap/regmap-ram.c: In function '__regmap_init_ram':
> drivers/base/regmap/regmap-ram.c:68:37: warning: 'kcalloc' sizes specified with
> 'sizeof' in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
>    68 |         data->read = kcalloc(sizeof(bool), config->max_register + 1,
>       |                                     ^~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: fix kcalloc() arguments order
      commit: 3b201c9af7c0cad2e8311d96c0c1b399606c70fa

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


