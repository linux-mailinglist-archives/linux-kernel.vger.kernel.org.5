Return-Path: <linux-kernel+bounces-166706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCC28B9E63
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8ABB2606E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E9D15E5B9;
	Thu,  2 May 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ+4jtcF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED715AAC5;
	Thu,  2 May 2024 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666800; cv=none; b=hHaX/oZxX86+RwK4K1JJQ0cKLpvQBPOTx28OP0KaduBHPx3px69uZd/lgCMq9Qfws2AYTIovA5oC0TM9ksSpgwqw/w6zUCWjijYOPVFiB46BQ5eN4yqOFbdij+n3/+vNmVeOR0/UFPx2vp2ILQx83EqDXbcEnZZ/+28iKvluBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666800; c=relaxed/simple;
	bh=wthRQDYG9peyYfbmJkk/3Lt0EmD/2SFlNx2py7XS71Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BqKtcNFcklkl47YzX9C497fHdmyYhfwzikAXad4EITnwi1dCxdDZhisN+4FWK0NmPCVbSPgXAqS+qMEFAd0hYNqBFLNzFe5Xj/BMTcWNQNpCzaJFt6NefNX3/T7Ye1FHjBZ/SW8eB3xOWV99I9x5iGu2K8ZBgvHVNOOgLa1vJW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ+4jtcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C8EC113CC;
	Thu,  2 May 2024 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714666800;
	bh=wthRQDYG9peyYfbmJkk/3Lt0EmD/2SFlNx2py7XS71Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VQ+4jtcFuH6z70kyMbC3fUfPjAapVbzS/iBsYj7VzhbjGFZjxvlImPgz0yBo4StJL
	 jYDpiE7cKNeG8bbyjAa7j6waclBpLHuLXXqFF3beZcLQ1iTGEq8Na+F10CciZArcMK
	 htUhwsUK4UK7ghci0ppsy/pHozhxGHZGHVjhpJjZLLihmrj2sP1J80Yd4umnK4KCeP
	 Qg7toH+c4tz792EiaZnEfXGfDpaVD5xnrVSPrtyX9fxLEm2HTf3F2Yf+zm4DDMGstt
	 DXUwlNFhGnBSUGQjaaGLDPGal+eTKdE8w+mmr86DNe/c8U0pgqAY346i8o6H6UihT8
	 Cvxk1Mu6YfFaQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240415102632.484411-1-colin.i.king@gmail.com>
References: <20240415102632.484411-1-colin.i.king@gmail.com>
Subject: Re: (subset) [PATCH][next] mfd: timberdale: remove redundant
 assignment to variable err
Message-Id: <171466679912.1192680.16107294908184867521.b4-ty@kernel.org>
Date: Thu, 02 May 2024 17:19:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 15 Apr 2024 11:26:32 +0100, Colin Ian King wrote:
> The variable err is being assigned -ENODEV and then err is being
> re-assigned the same error value via the error exit label err_mfd.
> The assignment is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/mfd/timberdale.c:768:3: warning: Value stored to 'err' is
> never read [deadcode.DeadStores]
> 
> [...]

Applied, thanks!

[1/1] mfd: timberdale: remove redundant assignment to variable err
      commit: 3f2706adbc2b8b6aaf313cc66271642d901d90e0

--
Lee Jones [李琼斯]


