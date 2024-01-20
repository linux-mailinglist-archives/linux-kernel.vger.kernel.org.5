Return-Path: <linux-kernel+bounces-31677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D924E83326A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ECE52843D4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F05DECD;
	Sat, 20 Jan 2024 02:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEVXSzsl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4247BA52;
	Sat, 20 Jan 2024 02:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705717136; cv=none; b=bTerE6ii+CSOf5Q/DHefO8i39/FhBgGRbzbiFHBAcpLji+RSFhNRxy0CzJDE+DI+M+aLjtLRn9Mj5uLTRyxG9iITdNDySxFIk4cXNv+5QizYGfkLcsRxsK212PKFf86HFk6BGtxir4YMT9y+UXxkqFYLZCouMEIkLGo2Xnxuc4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705717136; c=relaxed/simple;
	bh=ZrcEBW4GytdgEE69kv62JO8lw6WJ/+YvLK7DWu+lxPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpknxE2V6KHC7cKyTFgLof9s6pxIKV21oH2uHYpPlKivVPfgZg53PhcpqlnljkilcFi3X+gPTtXzMVgVZp2REHgAmvC3hO4e2CAMyXHqRR2pBpkre4q2GEglEP0HhG4R9Y9ceuUR1LPqBuEeU4ZG7rTYvDx/FUiu4C52Zc1OoQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEVXSzsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6D1C433C7;
	Sat, 20 Jan 2024 02:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705717135;
	bh=ZrcEBW4GytdgEE69kv62JO8lw6WJ/+YvLK7DWu+lxPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CEVXSzslodxuv4nYD7xPyTgjVjkZxDYF8TK5WWT70AD+4eVmTxQ8gbl7mwCWMM7t3
	 PSeheLuv/rq2/ugNC3eHwOBiKfLUAHsqA8eAj8unqD3xMdicIwNT8oMd+/kzjdwJ1q
	 9WzQ5I0DRuckjasEqG0D7Qp/r2rnlIWZOV+S7Q96BIZWnhEdWAZhhrPask//pEbd2v
	 OciQGuuF7YXlGbPzmpYZhUU0MXU+EiqQPAno8BnSa+Towvn8k36GaB65kJSWg6ou3R
	 Hp4noZzxalgwoyPSIOMUuCLCgS8Z9lmGTQpIwbzuzgx9pmoPbV04Cd8i0o8K7rkBrV
	 gNONgCqdvMRLw==
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
Subject: Re: [PATCH 6.1 000/100] 6.1.74-rc1 review
Date: Sat, 20 Jan 2024 03:18:39 +0100
Message-ID: <20240120021839.126002-1-ojeda@kernel.org>
In-Reply-To: <20240118104310.892180084@linuxfoundation.org>
References: <20240118104310.892180084@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Jan 2024 11:48:08 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.74 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Built and QEMU-booted for Rust:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Including checking that `--lang_exclude=rust` is passed as expected with a new-enough `pahole`.

Cheers,
Miguel


