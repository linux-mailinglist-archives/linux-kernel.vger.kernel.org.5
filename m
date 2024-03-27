Return-Path: <linux-kernel+bounces-121398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE2888E76F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE201F31C74
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F801422CA;
	Wed, 27 Mar 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC5WpOj4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B79130AD0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711548030; cv=none; b=hyctA0e8B/btJgRYycHYNXvcsxTJM1ON9yK9mFTfES0wLsw4LYeqrNwmkUSA+imOlV/gTrQ7ljci7CkVjiYU74d/2vKKW+ZJbS/W1VDM8/Yf/d1E83Q0jeMqhSNHxVDrWPd2qVchU0kHzmli/gCLAIe92ZqqoMVdW/3lwcxEz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711548030; c=relaxed/simple;
	bh=BA+TuURoQlOCduEndpylZLvO0UX6c1g+Nv7/szZ91Qk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XPzu4xRoj91U7rWJLzfBklO0JtAWJN7bTJ3JtUt4Lmfud+IiNjk2+mzOJZaOr3UEotus7BbhO6vO0Lemf7nueZ36a6VQzl9uvFzD5LxwQIdXl9wToZz/6HI3PonjEkoGXeWiRN9R40KAJr10VINcbERCPWcbEexwNGx5UK/+F7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KC5WpOj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B1F7C43390;
	Wed, 27 Mar 2024 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711548029;
	bh=BA+TuURoQlOCduEndpylZLvO0UX6c1g+Nv7/szZ91Qk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KC5WpOj4Ln1dTIld9MMKLLVD3fI+1ThHwdLlTTLxXJ4Ri1kQYJypOuvSpD52bO2XB
	 t3sxXsZTmh3vxAdJ5FJDV2K1LxEAxQHHCbc22KLFAtX/G1MZ4wjilN+AsxF/315OPe
	 +rWVRaFSMqD5ztKUxu3LyTDkcI+0YV0SXiGOGpLpmAJ5BV/oVqO3sZH6b51fH3+oEf
	 i+WdPFB7VR/ABSMgGvZBzNIY9M0mKBVjr7Wn5l9BO7JtmgyZoG3Y5JiXym6SZkvi4k
	 /8dI2vpTg+YPy5DdZdsZ1OEShEhH9HQkgQZZzq3kL7NZPJaWyhGuQd2Cwunix27AZE
	 v1Nk4JsFfUdog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B13DD2D0EC;
	Wed, 27 Mar 2024 14:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: compat_vdso: install compat_vdso.so.dbg to
 /lib/modules/*/vdso/
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171154802956.9827.4136336790290384825.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 14:00:29 +0000
References: <20231117125807.1058477-1-masahiroy@kernel.org>
In-Reply-To: <20231117125807.1058477-1-masahiroy@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 17 Nov 2023 21:58:07 +0900 you wrote:
> 'make vdso_install' installs debug vdso files to /lib/modules/*/vdso/.
> 
> Only for the compat vdso on riscv, the installation destination differs;
> compat_vdso.so.dbg is installed to /lib/module/*/compat_vdso/.
> 
> To follow the standard install destination and simplify the vdso_install
> logic, change the install destination to standard /lib/modules/*/vdso/.
> 
> [...]

Here is the summary with links:
  - riscv: compat_vdso: install compat_vdso.so.dbg to /lib/modules/*/vdso/
    https://git.kernel.org/riscv/c/4b0bf9a01270

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



