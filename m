Return-Path: <linux-kernel+bounces-140352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0958A1336
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE94B23164
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CA1149C73;
	Thu, 11 Apr 2024 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0n7KVm5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272D149C4F;
	Thu, 11 Apr 2024 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835586; cv=none; b=eOgoY5hEg4EHlVoWrixWnGH6uIHazJl1iu1XDh5vbTMl8fdgMugGrCQ2qjnTRT9VYM6fHbzLgjSceKSSV/YpnbvzHwKTvJfkiEBuarDeA2MFVbw87R9BnwaW0Mxuis3iMc0rmHpzyORLXzI8Fftw42zWjqdQR+QRqAPNY5+dUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835586; c=relaxed/simple;
	bh=7EFwvVMuQn70XRVguNSGzqoYr22N/NAtZcQsB+LnsEg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YL1KNiaSJp2pDeWQDs8DZYizlDyH46ifmU00IOXj58kB7de2gAh7PPMOCXT0XwsDGLpi5HuV43/FuP93WYYbYDhoD6FP7BVXf/0l1dUQfQ8fUiPKkHNn670yI4pFkk5cxWXqmsUYyiJloKy9BlDYk2UxPuU6QLMygGR4MTohNns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0n7KVm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B308C43390;
	Thu, 11 Apr 2024 11:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712835586;
	bh=7EFwvVMuQn70XRVguNSGzqoYr22N/NAtZcQsB+LnsEg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=b0n7KVm5wYeNXeZ+XnzXB1T2YmToafnWpN+T+r3+hpqq+Oj00V6TKtelpkSyu+xj5
	 b9VTXuRx29AZ6yNygBfIiVIGu1ZH1tRO6MKMNzl7vm1nyNofF7R6a+Cv0DbGGs12Kj
	 b4A1+kHJ2MCWrFtjFhT0K4tUVgekgi4QnuOHotZAmq4zCcgGjdxbFsxTcd57+g71su
	 VDThpy8LKz64KHkpZgG6LkF3jScn2grHEZCBT6MBzgBtRJALvSOU8xs269bb+C9Ivs
	 RqYmTVB4xUk3LKnZ0SKXrXBUOj3cxyFGBZIHI9wUYsJfSBpitIDOotCyI9mI26yM9F
	 M/VdILKn+BeQg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240327174714.519577-1-krzysztof.kozlowski@linaro.org>
References: <20240327174714.519577-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH] video: backlight: otm3225a: drop driver owner
 assignment
Message-Id: <171283558431.2316283.17972686274458544587.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 12:39:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Wed, 27 Mar 2024 18:47:14 +0100, Krzysztof Kozlowski wrote:
> Core in spi_register_driver() already sets the .owner, so driver
> does not need to.
> 
> 

Applied, thanks!

[1/1] video: backlight: otm3225a: drop driver owner assignment
      commit: 9db7677e33b646a7fd60d35cbd4ab99886057a85

--
Lee Jones [李琼斯]


