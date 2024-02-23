Return-Path: <linux-kernel+bounces-78724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC1E8617D5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1EA1C21A56
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F8984A47;
	Fri, 23 Feb 2024 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6+fgbfs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25B4A1D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705577; cv=none; b=bi4DhN/Xb/1WMfWtIbV9WOtGaQgtQIO3GX6Ejo9QU/HVzGxMA85ArV7UfBJGKt3n3qdO6fReG/OV/ksqZWEAbU/Zw3D+nGdTe1/zgyvvVRDJDZlYbMd5vgjkN4IQVfyGpgyHQ6MmfuBd3FxtB6/qBjIpS4KiY3rnR72TCvpE8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705577; c=relaxed/simple;
	bh=WX1Ptr5MXdIc0+fkhXnsF3zZ5pUXVm3V4lAy+w79y9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToMZ9rVV6epB0XVGqJaBt02CkpY1o4D+eHU3izW8/uz0RAQJtoEwhOxeYqrcfKCN2GJ61zOhuNIPOJ19/dVj8a7PPBV+Q5yCMQBnehRXibKtt/9J8G5YLrH/X56JtKg+8P/DkdBlZcGfkRIQ9TlzplWH0mTA0MVVBwpFCjir68s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6+fgbfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EC0C433F1;
	Fri, 23 Feb 2024 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708705577;
	bh=WX1Ptr5MXdIc0+fkhXnsF3zZ5pUXVm3V4lAy+w79y9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6+fgbfs/zm2KiJXOLPn3sIszNeCGqJJ6KhHQiK4iV60sC2ZGeymHjkqECeeJ3n+g
	 REH5qAfdtesKubt5xTRi/6cRe9scO0XypCbkTJV+1KCSEGL0i7Flwta4Lk9C2mh52Z
	 ipW6lWIH23w2uYKC9fvcrHnlxZiMM7kwLLzA5ZviX+bkYtPJwsCc8nOEWnegpQ0Cqo
	 vDadDBs8FiQS9MaTACNLJzcrdN/1W1AQ4EUGWPEvCaY0GPeARlIWTfvEYQ1CfuLNeh
	 pC/3LDyuD0wGezqanVA86cOd5uYSEHDXfiLjP75jiq+8vNFENTO14Iz+llZZXQNwui
	 sQCCQ69tHGB+Q==
Date: Fri, 23 Feb 2024 16:26:13 +0000
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Convert some regulator drivers to GPIO descriptors
Message-ID: <20240223162613.GK1666215@google.com>
References: <20240220-descriptors-regulators-v1-0-097f608694be@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240220-descriptors-regulators-v1-0-097f608694be@linaro.org>

On Tue, 20 Feb 2024, Linus Walleij wrote:

> Despite the work to convert the regulator core to GPIO
> descriptors, there are some outliers that use legacy GPIO
> numbers in various ways. Convert them all over.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Linus Walleij (5):
>       regulator: max8973: Finalize switch to GPIO descriptors
>       regulator: da9055: Fully convert to GPIO descriptors
>       regulator: lp8788-buck: Fully convert to GPIO descriptors
>       regulator: max8997: Convert to GPIO descriptors
>       regulator: max8998: Convert to GPIO descriptors
> 
>  drivers/regulator/da9055-regulator.c        |  48 ++++-----
>  drivers/regulator/lp8788-buck.c             |  64 +++++-------
>  drivers/regulator/max8973-regulator.c       |  36 +++----
>  drivers/regulator/max8997-regulator.c       |  85 +++++-----------
>  drivers/regulator/max8998.c                 | 150 ++++++++++------------------

>  include/linux/mfd/da9055/pdata.h            |  13 ---
>  include/linux/mfd/lp8788.h                  |   9 +-
>  include/linux/mfd/max8997.h                 |   1 -
>  include/linux/mfd/max8998.h                 |   6 --

Acked-by: Lee Jones <lee@kernel.org>

>  include/linux/regulator/max8973-regulator.h |   6 --
>  10 files changed, 143 insertions(+), 275 deletions(-)
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240212-descriptors-regulators-f455ccf0119c
> 
> Best regards,
> -- 
> Linus Walleij <linus.walleij@linaro.org>
> 

-- 
Lee Jones [李琼斯]

