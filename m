Return-Path: <linux-kernel+bounces-119986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4E488CFBC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E8B328F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE3213D625;
	Tue, 26 Mar 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8kZ7O8M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF3412B151;
	Tue, 26 Mar 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487429; cv=none; b=A5lk2regOJ0eouXaq67KyAYmiiYxET4VR+52054DRT7hSuaRnLhHZvEMApEPGawglaudcHRh1XU7dlfSZJY9Y81Z5xLPpriRZB8zDKN0XGpteZiBJnTn0vZJFlzNKTOG99HcDXQd372l/lkE8QF/VPjTUimD7o6pj5FdHHF54rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487429; c=relaxed/simple;
	bh=cmg/gfbaHxKApJm02IgCoAJKmmpQOZUMbvz4pjlnRu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K5PgZORPin7FlwvEyqXonhF80d+qEtTjeSLffhFTwRImPYRlAkNbmavYSBb3vs5D7B+9hI7ll8IhZZDK+OeJR/oZvZBsaW9ENpgyoHYj9kpPGYBoqyFoGINb66nDlUQpJxbZKQcV4cKcsQnbVtrLarw0Q7xWYEDZZLfT6++IMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8kZ7O8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E392C433C7;
	Tue, 26 Mar 2024 21:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711487429;
	bh=cmg/gfbaHxKApJm02IgCoAJKmmpQOZUMbvz4pjlnRu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X8kZ7O8M4Cz8kl2noXtB0nNd1//akN6Tc3BUOm8lCvjrK5MuOrQBRay7llaio6Wr0
	 uO2XtXTKTuyMqbTZ6Zn5Nd23OWDBat3a+WIbEPBLb9ze27c2ISnowQyG821w3lAuom
	 vLyCTZTWYFg808+R6UfwOh+ly2CTqhfhQHpWrCDQMFmYUrHKzsH+B4qepRolI3IUbx
	 mYoQcrgNkwxaKPcCTEPVd2HB4W6ik8mSQcnNQKQJeNKcsv6ENFXWLHmOfYxl3cD8d9
	 X3/pah795VETR5lXWimFHkiZCpgg4Erh9lKMX+aABTR755qqyYrZ+4mLoAhcWgHuSQ
	 GJPsRaxhihPig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A157D2D0E9;
	Tue, 26 Mar 2024 21:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix spurious errors from __get/put_kernel_nofault
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171148742936.11448.9647028655336928846.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 21:10:29 +0000
References: <20240312022030.320789-1-samuel.holland@sifive.com>
In-Reply-To: <20240312022030.320789-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 11 Mar 2024 19:19:13 -0700 you wrote:
> These macros did not initialize __kr_err, so they could fail even if
> the access did not fault.
> 
> Cc: stable@vger.kernel.org
> Fixes: d464118cdc41 ("riscv: implement __get_kernel_nofault and __put_user_nofault")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> 
> [...]

Here is the summary with links:
  - riscv: Fix spurious errors from __get/put_kernel_nofault
    https://git.kernel.org/riscv/c/d080a08b06b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



