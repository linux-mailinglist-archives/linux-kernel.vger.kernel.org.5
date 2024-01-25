Return-Path: <linux-kernel+bounces-38957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1850A83C8FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27951F27BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECB2133991;
	Thu, 25 Jan 2024 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbI2rlrU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45B133982;
	Thu, 25 Jan 2024 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201350; cv=none; b=aAG4XzexdOYqmgCW5qdeQOISrdx7/29CNV2U6NT5V7pj9HcLPpx84QOwQLkrl9Mln6W33KQTTVVsxjkp1w39rrgX1Q5rFuR2zgeP2M0m0beVHiKfBXz5CuVFVOgPhtK6GHk4PEsblOWXnC+yZw9waoIpMmpsCQAe6CEOf51ZX54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201350; c=relaxed/simple;
	bh=pIoSNO+1moku54+nWGOBL9QSYT0GE2IKHfFUu/z2s4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9ZQyhGmJfe8kBuJs2ezhSmTw7kebrYh3sKZ5pCbuaxtC0/M6QVS+t7Rxs4t/tey2AlppS031meDz/Cg+hz/lFzCXrnSLa4urNgwowjQnqqzGD0gTWa1iNAnfKinhguOoJD34ykVIb8DMbhnzjqhivvYaO1RzNQhP269i0AmxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbI2rlrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFA8C433F1;
	Thu, 25 Jan 2024 16:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706201350;
	bh=pIoSNO+1moku54+nWGOBL9QSYT0GE2IKHfFUu/z2s4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbI2rlrUN7CZv/wQEPc326QbX7Rkc9GzsIwP5CxTgLXjJhs5Fkx6D+o49Cs5eS+Ea
	 CDMudrfrT5pulzKyxZ4jSXCTec8sSeST7aVGX14yf8hh+WWdn9zgQSHbugL8fVzRe/
	 zCVEKwPKvh6n7j7b/p28pulKXdKjIaWN5ehAsTySXyr28R6nY0r7paf6D5Q3WJgy69
	 mlcha9gpfREsv9+46d8D/AUfDzEOcBrBjEFTFDiKEiPwdHg4fnR4EYUZV1HiPDcg/V
	 Yp/H3UHmPsiqxt8TRGwjm2U5vnNVh1slwOQiKhsUgZ3Sm3MxNbxwYlLGObEatOOJTs
	 lJOKypf4kQcPQ==
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
Subject: Re: [PATCH 6.7 000/638] 6.7.2-rc2 review
Date: Thu, 25 Jan 2024 17:48:58 +0100
Message-ID: <20240125164858.212025-1-ojeda@kernel.org>
In-Reply-To: <20240123174544.648088948@linuxfoundation.org>
References: <20240123174544.648088948@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 23 Jan 2024 at 23:17, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.7.2 release.
> There are 638 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jan 2024 17:44:25 +0000.
> Anything received after that time might be too late.

Built and QEMU-booted for Rust:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

