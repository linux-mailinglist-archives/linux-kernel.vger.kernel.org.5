Return-Path: <linux-kernel+bounces-64193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E32853B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A251F23F50
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51606089A;
	Tue, 13 Feb 2024 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kF5v5gCt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4F4DDB2;
	Tue, 13 Feb 2024 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853886; cv=none; b=kO4CCU3SnnlqWGeYZpOcT+Ydpi6082y6e6nC7UvGwEZ2JBAlMnigdWXEddAJH3r3EwUMQwLZN64pFlTeK6vpuvUotkgnuBXbNJVALUI+1zXVJo67WywCWyczGgqz3l2aMA7zmSLMtcE56Ju5x0So6H/xaDPZ6gCilRNE9izBgLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853886; c=relaxed/simple;
	bh=KuK5uyDDIiIDiDO2w1KdFqOt7xFCRYumWnA866RirUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEInS8ZL/aFUSrzbHZSMCf8ruAt85usUJXUIKUdwPPjaOTooT9kR452wwLaPKLSJYA7meKPqs74SNxbBxkOGoiTu7x1spKMv+TwR4u7jiPqXAbnzwCw4MSnaausZZEpee5CX132JMXS6BMpozqJSz7td9b05aaasTP7zg7gcis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kF5v5gCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B6AC433F1;
	Tue, 13 Feb 2024 19:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707853885;
	bh=KuK5uyDDIiIDiDO2w1KdFqOt7xFCRYumWnA866RirUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kF5v5gCtazd2CXADufMj6ONmf2H6VAxsK/MJdXfLRCaiyo1ZYoyPk9zHvy+nmkT94
	 Z/l6vb4+FYsL0u49fJqfyU5k1zpOn2CN/UZT8ncyKGiRX3OhSdUw2QQnUUHZr5EmzF
	 L6M7hm8Nsbyy+5igU+dE4Gtl3EQBl/M6g/8XkztEQLh36OSuhDvSY6+8qg3OCcBXh3
	 13YnjIpnGgNI2tR57ZjehAg4oWzZ5w3SAz+2f6dmKQIHEiA4YFa1+zeKZxX2UDEQjm
	 hLaJDlHheg3OCSpM2V+166g/n6aDyR4FbqgCFJrwBEjq+OG9E5WEaor7N0zf55Jtsr
	 1DTiMkXSHRehQ==
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
Subject: Re: [PATCH 6.6 000/121] 6.6.17-rc1 review
Date: Tue, 13 Feb 2024 20:51:14 +0100
Message-ID: <20240213195114.752663-1-ojeda@kernel.org>
In-Reply-To: <20240213171852.948844634@linuxfoundation.org>
References: <20240213171852.948844634@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 Feb 2024 18:20:09 +0100, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.17 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.

Built and QEMU-booted for Rust:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel


