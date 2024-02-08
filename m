Return-Path: <linux-kernel+bounces-57902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA59684DED0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C45D1F2AD4B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4590A71B57;
	Thu,  8 Feb 2024 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6h59rw2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5806F532;
	Thu,  8 Feb 2024 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389562; cv=none; b=qO0cIB99PzpOsAEQ0QbvyZAJJG4jTfskmeTPMDqCQ9D9x4sy2M7Ic+WLg5Y45jmmqmfOYlSM0esle2U9eNnwItUwfq7sz9q8c7s5QCSh6+c4IHvxVnRe2kdVv0/iXPU2xlxFv/wcEibcn36/WRD8MbcThpaGYlcZxFk0OpfoV+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389562; c=relaxed/simple;
	bh=NjNSfhEcjSG5tAQPM6gOvRlfxb1YnyNXjNsO7vePUMw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=shMw5Ume/p2iig9Mn/QdOdTLLiHclnAJQIHBNOq+ubske0vqoZRTCRFWhXLnmQBDKB1HGsnBnvyjZbyNYMB1MvtuLxTd738GvkAkofeBupv5PxJBAR9L1CJkRlveoNjzWy9Neqad/hP3Wc0Z9U05Ku0LbGQ37rwLt0fc43tU03A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6h59rw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E7BC433F1;
	Thu,  8 Feb 2024 10:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707389561;
	bh=NjNSfhEcjSG5tAQPM6gOvRlfxb1YnyNXjNsO7vePUMw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A6h59rw2GM1lbtLDFzDaniCuHjjsEJxV4Ht+EAzuikpOsRmtVAKvLlrl3PbIn4QU5
	 t8itmryf0ubsnAsFVCb9MjM8wXRbTs64hEioQK/lPekWsa6pGr30a4x5DibrzWFlU6
	 n7786l7U9cVi59/mfJ7OoDChtBq1GbMQHuiWwwjbCdslq+pDmcNj5huSmtQ6VqzPDj
	 0Qeo+6eVXj3puhbFa0KTYWnd3ntngeil/eB2KfwQ8W+DjBgAvUsthWYleMe/3LH3g/
	 T2SKiarEDBiG081/fbWAeCKO8JKgkV+AD7PONePtyS98MPX9TBNc4jNWsPQC5J0rsf
	 BDuXznCWOIYkA==
From: Lee Jones <lee@kernel.org>
To: Daniel Thompson <daniel.thompson@linaro.org>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>
In-Reply-To: <20240201144951.294215-1-andriy.shevchenko@linux.intel.com>
References: <20240201144951.294215-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/4] backlight: hx8357: Clean up and make
 OF-independent
Message-Id: <170738956012.925871.18016345920241211144.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 10:52:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Thu, 01 Feb 2024 16:47:41 +0200, Andy Shevchenko wrote:
> A few ad-hoc cleanups and one patch to make driver OF-independent.
> 
> Chagelog v2:
> - renamed init to init_fn and typedef accordingly (Daniel)
> - added tags (Daniel, Javier)
> 
> Andy Shevchenko (4):
>   backlight: hx8357: Make use of device properties
>   backlight: hx8357: Move OF table closer to its consumer
>   backlight: hx8357: Make use of dev_err_probe()
>   backlight: hx8357: Utilise temporary variable for struct device
> 
> [...]

Applied, thanks!

[1/4] backlight: hx8357: Make use of device properties
      commit: d965a5ee7c95ce9414259181cbdccb1d2f1c1247
[2/4] backlight: hx8357: Move OF table closer to its consumer
      commit: 3d226ecdfd83c0d89c1d4a430706e8228022685d
[3/4] backlight: hx8357: Make use of dev_err_probe()
      commit: f0ed1589885ae933e2b2f9c63e16f5be3fb0324d
[4/4] backlight: hx8357: Utilise temporary variable for struct device
      commit: 27a4701c92250ae0aecb2edea1109f89cf344ba1

--
Lee Jones [李琼斯]


