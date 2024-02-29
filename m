Return-Path: <linux-kernel+bounces-87192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E7C86D0EA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DD61F25A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E6070AEE;
	Thu, 29 Feb 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKgMBtqc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C544E70AD1;
	Thu, 29 Feb 2024 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228397; cv=none; b=ZrWFKJkDoPEIRjQ2P4d+pNQeGyHZRraEtcYXXuMpnPTugnuFsIEtPDsFUuUp1FiU4EFsEbHUMFM9W7C9UmxYEf4UXBO8VEKpEdtYeiOpQa+gEUJgDO1e0MF/QdxepU3VmQPj945zxNDGJ4Sq47mHAUxqArwF54VaUxTHwZUlY3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228397; c=relaxed/simple;
	bh=1eHwbuoPQO9yJnCSyweWe53B9YJjQl9irdUPC/l7SEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nxnz9UMN7jga2oBu3/rQbyCpHTSitdG7ftQLbuwrZcb7OY6zn+rMUs3lvXfFkAb8WYN82wrmGB3MiJ7af5I6RmINUyMxkBscdUXnq85r+MLAiDSX9e493lWH7VfD7INiDaXSZ1/zf+7o5vFl74v68zBiuT+URTooXS33UfWAGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKgMBtqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78901C43390;
	Thu, 29 Feb 2024 17:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709228397;
	bh=1eHwbuoPQO9yJnCSyweWe53B9YJjQl9irdUPC/l7SEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WKgMBtqcUPkaIb2OH/ilf1KR4j+f4mL3dHcazLA+ZhsHWgMoaHR4ysqcPDviQUO+Z
	 0msTTA1gn7qFMUxeeiI5HVXuyS6MB2WJ+Yb5sO3LIt2wM8hDydHKbZE0kAjz8RHyp9
	 hAfaAW1J+ylL9L/8CEGCbcsY4TGLKLJ0UI0qk8ONFghK/p2KkAvOgXDiUcQyZMF1i/
	 5dxr6oKrWtkoMHDZneD/HvFLuvj1C+L3WFzPKgSLmZmEwWMzF/D70bgpBfav1lEhua
	 c/6tN0CtwXlCy8aw1Mg6FpQC/6DgXNlcKbzhNGzsbxk7agvA7+1sU1Dqmld0CewfkF
	 wzW4c4EGdpa9g==
From: Lee Jones <lee@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Daniel Thompson <daniel.thompson@linaro.org>
Cc: Luca Weiss <luca@z3ntu.xyz>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240220153532.76613-1-daniel.thompson@linaro.org>
References: <20240220153532.76613-1-daniel.thompson@linaro.org>
Subject: Re: (subset) [PATCH RESEND 0/4] Ensure all backlight drivers zero
 the properties structure
Message-Id: <170922839621.1624816.9819285232571855357.b4-ty@kernel.org>
Date: Thu, 29 Feb 2024 17:39:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 20 Feb 2024 15:35:23 +0000, Daniel Thompson wrote:
> [Sorry for the RESEND so soon... embarrassingly I got Lee's e-mail
> address wrong the first time!]
> 
> Luca Weiss recently shared a patch to zero the properties structure for
> lm3630a... and shortly afterwards I realized I should probably scan for
> a similar class of errors in other drivers.
> 
> [...]

Applied, thanks!

[1/4] backlight: da9052: Fully initialize backlight_properties during probe
      commit: fc159b40e7980e7f78dbaa72dcc4e8f523dbfd92
[2/4] backlight: lm3639: Fully initialize backlight_properties during probe
      commit: aeb7ab878e90041776eae839faa117570dbcce93
[3/4] backlight: lp8788: Fully initialize backlight_properties during probe
      commit: cd1995b6ac7384149ad755b74e3c3eb25195ab81

--
Lee Jones [李琼斯]


