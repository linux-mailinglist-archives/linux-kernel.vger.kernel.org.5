Return-Path: <linux-kernel+bounces-165190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D16DF8B894D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7BC284FF3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650567E777;
	Wed,  1 May 2024 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJxJM/vv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E0864A98;
	Wed,  1 May 2024 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714563370; cv=none; b=Zn6S5F0AKMIZqx/8qbf0A51sTdCDkHEm65Ka7Y0qsnwMAWgRmZFQY7TZMV5nxhCxemqRnSUddD5UE/unmsWbNUIBdcHjZtpG1asvIgqYe3XKmIdayu4VicSHmz2832G/qa0606K0XDFQm9bSTaf/iY6W/wwjLknKpFR/OUN+kVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714563370; c=relaxed/simple;
	bh=W1gAooAPoV3wDLnmgA+EEUzyuPq/TUOfoPkExhmYnng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxozvXl0IlxNLkRlekDRowQheCKGcsBaC+8rGMMnCG4Uilrp6Vm7u9fH+WFxiA+9E7O9IVjaGLtU2lHUmPSMDHo2a3i5qTxE8IzAqrWHgwmVNC9BqXtXGjorBKMkD+7uQQ3PEeLdYZ3GIZG8j1YTmoc50VhwMwwEtVZkaWjpWVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJxJM/vv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B39C32789;
	Wed,  1 May 2024 11:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714563370;
	bh=W1gAooAPoV3wDLnmgA+EEUzyuPq/TUOfoPkExhmYnng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vJxJM/vvEHbUluWku5C/odCn9nejR+HdSG24WlKnhFgapy8CglYchcsWTR+g7nMPC
	 X1RCEc4kSErPTOe+Hnk3djGO6++8lRw3i/HQhhELVtv2wvX4iG/yfAbwLrM3tX9zd1
	 91XiQ/nLgSsrKxqsu7+DYwbiTIv75MY+CyelYWInm284X5mphAMAAwALDfIl4N5s4C
	 MfBdS6zzAaPo5zDi0kavR0Jpl4ecMnjlEa+dGhXru0mY/uQXOPXHKiT/eZRPkreWsj
	 pMYg9AZImGL5v/3l85FsaLylYazMoHEdVq/XdAo6TnQDmIpC07PC20IsQpYY+5cnTz
	 xcXTSSZQLg9Ww==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	allen.lkml@gmail.com,
	broonie@kernel.org,
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
Subject: Re: [PATCH 6.6 000/186] 6.6.30-rc1 review
Date: Wed,  1 May 2024 13:34:52 +0200
Message-ID: <20240501113452.164810-1-ojeda@kernel.org>
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
References: <20240430103058.010791820@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Apr 2024 12:37:32 +0200 Greg Kroah-Hartman wrote:
>
> This is the start of the stable review cycle for the 6.6.30 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

