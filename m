Return-Path: <linux-kernel+bounces-38952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE34983C8EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648951F214CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA00131E2F;
	Thu, 25 Jan 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOKGvZic"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8606E2D3;
	Thu, 25 Jan 2024 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201242; cv=none; b=nhvd/bouGlYicf3HBVzmCjpQiO4Rj9nVepg7HlxkQ5koglpTtb8GhV3nUhTCq7f3ntBLSUp53O0YS3D5jm+SA9pxZLPtkeTUxgTjRrIO24OBWDAXDzReyJJblbXlbIPOy4N34If55uA6Jkqa+H9F+Ow2dXOptNJ0+oqjYs4CuCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201242; c=relaxed/simple;
	bh=NFemxOI2cc8k2DxiN/A8WFDYbdWSFXDkfp8bKArUP94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQJvLsQmNnPSWqSIyNhAu0mlP4za7f9GKLg3IDTB30xM1A+RFDA4g3j+MxBRrYSvZNGL0PG7E6r7vmP/Rz7BryTixZseVr6JMAbjXC+f6CFRfUmwbFAZE8t/nsViX6uFyj89SeNsrTgVgynxhlGwEAmqYLiC3JUWrEQcskUaM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOKGvZic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB92DC433F1;
	Thu, 25 Jan 2024 16:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706201242;
	bh=NFemxOI2cc8k2DxiN/A8WFDYbdWSFXDkfp8bKArUP94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOKGvZic0F9wlxfEiQZx1MvA6Z2R0ChX9vrS41daTyv4CVEhlyBV2iZ7ulBaVmB5h
	 t4+zmRul6ElXJa64qIgeal6xVShEY/9GwuJtmGLn7eXV81r1jKOP+pJ0IbzzhXOAc0
	 E/jsqgjdwaDctR1yGrxELjQNmwf4fEIlZV1tmBd9EQWOMs7tDtcaX3HigPZY/s0REx
	 wzVQvcHZrtaphHhfnStKa/CJRen1eVBs73FOVu2W8IQg8JwSBV18GLSkFXu/njGwge
	 H/c0IYMQhBjUoRxCRtocqx6ZUc58FRb1HXnTUONyN0ccUl1ICPJ3RQsumgwBWZwwxV
	 1GbkpZ4XmUsAA==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	allen.lkml@gmail.com,
	conor@kernel.org,
	f.fainelli@gmail.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.1 000/414] 6.1.75-rc2 review
Date: Thu, 25 Jan 2024 17:46:32 +0100
Message-ID: <20240125164632.211911-1-ojeda@kernel.org>
In-Reply-To: <20240123174510.372863442@linuxfoundation.org>
References: <20240123174510.372863442@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 23 Jan 2024 at 23:17, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.75 release.
> There are 414 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jan 2024 17:44:16 +0000.
> Anything received after that time might be too late.

Built and QEMU-booted for Rust:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

