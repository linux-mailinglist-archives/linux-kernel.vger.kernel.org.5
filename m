Return-Path: <linux-kernel+bounces-147865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C758A7AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5E81C21052
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F23B665;
	Wed, 17 Apr 2024 02:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmu76OkR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EA6566A;
	Wed, 17 Apr 2024 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321970; cv=none; b=VQ+0D7gUETAbaZ+IOxI89YT3K8Q6riocO1XIcMl2KCv9D58Rjn+6fX4I6JBuzEeO5jNNZMBBCJh2ORckEC3LKUwf7QiEDmhBPyFQ7wnDEH7wbppw1FbQz7et3GvVH/OYoaWkOiljfuHnAzF+1blF9dk/qXCZOy9GaJtcUuO99Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321970; c=relaxed/simple;
	bh=0geOxcPu2vFPISpx3mi6jh0swem5/ro/Ekv6ugo9aRU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sGCkWyE7oDkvdrbeXXpQnYOSTVxzK33WdKyDO3aZ0bJR/ZA2RsYJBerj3XllTTE1nhcXn8+yBDttOvcP6H73j9lsldBA9K5fS/U4m5lIO+G8WuGphEFRmoPPtgIaQd11znYU0YI37r7HxjsX9Cg9EKFfalbiQFdeuPPDvXzalic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmu76OkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D56C113CE;
	Wed, 17 Apr 2024 02:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713321970;
	bh=0geOxcPu2vFPISpx3mi6jh0swem5/ro/Ekv6ugo9aRU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dmu76OkRYjpYSC5mAiu85c+M/QRwYQNK3faYw2clzHuyBncsiwEFGTdCMQLWgAAJ+
	 EEcf5dFK6ebJegYqmQC8/BapSc7WYi+oJz9RVPQlHtN60vuLOyOdki1h+9JH4i2olS
	 V2eAw40M/YSLysZDToAmzEff1Ri1TeaSeGwKNVfFcTnZ0/bOY8D7unHX4NGxtjqDAd
	 Y1neKsvb5y1aJarHfbJ9vElsCMUIdCJjm19iBIDT7+6vw19I6N7FXYj7eXeZyiNsDq
	 P+f+RtLPESb+MWh3A16vRzLwH/A5k1Mwe8udB+4gpiiOCrIRGD1W0jstedzvRerBhY
	 Rso0DrxgGQ+Rw==
From: Mark Brown <broonie@kernel.org>
To: f.fangjian@huawei.com, Devyn Liu <liudingyuan@huawei.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 jonathan.cameron@huawei.com, liuyonglong@huawei.com
In-Reply-To: <20240416015839.3323398-1-liudingyuan@huawei.com>
References: <20240416015839.3323398-1-liudingyuan@huawei.com>
Subject: Re: [PATCH] spi: hisi-kunpeng: Delete the dump interface of data
 registers in debugfs
Message-Id: <171332196865.1698999.16559660124050258336.b4-ty@kernel.org>
Date: Wed, 17 Apr 2024 11:46:08 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 16 Apr 2024 09:58:39 +0800, Devyn Liu wrote:
> Due to the reading of FIFO during the dump of data registers in
> debugfs, if SPI transmission is in progress, it will be affected
> and may result in transmission failure. Therefore, the dump
> interface of data registers in debugfs is removed.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: hisi-kunpeng: Delete the dump interface of data registers in debugfs
      commit: 7430764f5a85d30314aeef2d5438dff1fb0b1d68

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


