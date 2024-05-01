Return-Path: <linux-kernel+bounces-165187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A588B8947
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EEA9284F76
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6F67BB01;
	Wed,  1 May 2024 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6Jf84Lb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495D055E6E;
	Wed,  1 May 2024 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714563276; cv=none; b=ZiK97VaAcKrD49Ewr4SLFiQ9z1ZbFetjqhjLR2N10DYz5OW4gTa57HAdi+zBTsMes9CyA4Za0FNr3KSmp1Y/Bixz7ahQzCkWQ1QVFzqUEWc3hQzdNAsMzD8dRLzBaGvgOLAkcew7pw51wvs6oYGcL8R0ljl3JFrnepFy1LXKkZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714563276; c=relaxed/simple;
	bh=gNVXVVA4JrNDjG/CYhU8DTulUJJ3tV8kEgoCtEvzwlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBpuPrqxdGj9TFHNNz2Xay/+yFxV9xBY5Zbh2gkdzt6l488P9W+Iw1Ds+mmagoUy43D/xOBgOye0FRRfviewYVF+0O9F64hF1wo8iaUZPG3jEjKs8656xMxH1dX4fvo/f1j0X3rlvj7S+atc26ZBcXLgtrjuTJ4/o4nBx1I7Q58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6Jf84Lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD96C113CC;
	Wed,  1 May 2024 11:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714563275;
	bh=gNVXVVA4JrNDjG/CYhU8DTulUJJ3tV8kEgoCtEvzwlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6Jf84Lb7OSzNkOBHmrluwd1Qw2UgreCgNCnKDIZ1qbbhZlfuaCzduRvjj+X2Hewm
	 vSkHgpf5p3Jato0fN76UIFhTvMUAz9yDiR+NXuwaeyHerBfQz7vzYgXHmxQ0yyjpgS
	 4isuv3respvSeOAKFjlMyAImEFFVJ2MzeRxucF3otrISbx6/2m9EaMCvN/p2xFzKho
	 sxD2IpK9qIjzwI7zMhpNmTWNdfZSIszZtgPLz/RT7ATXydjrT3cVToAvNYSXRrNrO2
	 GoSM/hADBBjliLL8un/oiKoFF3p5R3pI0XI5q2/4l0P3qU1k4LdlDtBwF8uEnBhD87
	 8bRf6dpiWKoxg==
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
Subject: Re: [PATCH 6.1 000/110] 6.1.90-rc1 review
Date: Wed,  1 May 2024 13:33:04 +0200
Message-ID: <20240501113304.164608-1-ojeda@kernel.org>
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>
References: <20240430103047.561802595@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Apr 2024 12:05:32 -0700 Greg Kroah-Hartman wrote:
>
> This is the start of the stable review cycle for the 6.1.90 release.
> There are 110 patches in this series, all will be posted as a response
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

