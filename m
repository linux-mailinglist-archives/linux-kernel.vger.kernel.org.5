Return-Path: <linux-kernel+bounces-35817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9F48396E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA44B27DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB0981AC9;
	Tue, 23 Jan 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaVmgOMv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06E811FD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032230; cv=none; b=bcaHiNCxH1chb1WZR9wQLAqyx5ivDe13J0qN71yWE5HYaMA1JVziMeL9wxEXHLobaZ0qszW0hj9E9R1BvBGUAPIHPZouLtujLyYNdlPfCApG+mMF3o4jlDK+Wv15crMwv6DB5GX8QrYU7N1mJYNnBNCIaAhGPEq6u5G/6EV9TAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032230; c=relaxed/simple;
	bh=u33xhrMBvP0hFGXf59MDOUATT/HE9dP7AK7MeLkj+j0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IUACevEY+aur/L/WRj7nNzKKWfxoJa2bz5AeoqYrH2Hp2f/yy97jRjQMOwokl1H+3TS1SsBgIl5tkGhxcSd4+q9C85H92f4DdRvN2tOEb584mKo6Fy5B45v9UQ5PpFTyaO45jOolSaMcg/PV4ST3loCRQUdOSCXIW4rWiPwAKYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaVmgOMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3B08C433B1;
	Tue, 23 Jan 2024 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706032230;
	bh=u33xhrMBvP0hFGXf59MDOUATT/HE9dP7AK7MeLkj+j0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JaVmgOMvIibr/9DU4fx/gNLTAI5Ho0oScX8yqWemKxp7k3ZLKE+ybjmkHz96+i5lG
	 5AyYwYKkMgtHLbeiUiYPPLsErlaHLUvE86IKaoh6meSFVz08n6J2RY3duFpWWVn8Zh
	 ba3h/PnZIW8czIS9BeW8uWS9rqjpgFpBQMmp6n+itEQv5upy/vweFekmoPDLRGmF0O
	 tElnEddkDNGxhgvOUz9CC+zyah9PVvXN/1jSLlBUKzlrUBJrdS3xTquo9qJRf9wskT
	 J/GESn0r+6F/26CMj92B94cZ37RCUqPOB7/hBXJud6BNcZ6spxjycqFcUFHKLjwkhT
	 Z9Ox82Z02FSkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBFA9DFF761;
	Tue, 23 Jan 2024 17:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RFT 0/2] RISC-V: handle missing "no-map" properties for OpenSBI's
 PMP protected regions
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170603222989.30461.11049056164459674443.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 17:50:29 +0000
References: <20230802-purse-hydrant-6f44f77364b0@wendy>
In-Reply-To: <20230802-purse-hydrant-6f44f77364b0@wendy>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com, conor@kernel.org,
 paul.walmsley@sifive.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 alexghiti@rivosinc.com, bjorn@rivosinc.com, suagrfillet@gmail.com,
 jeeheng.sia@starfivetech.com, petrtesarik@huaweicloud.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 2 Aug 2023 12:12:51 +0100 you wrote:
> Hey folks,
> 
> I was kinda sitting around hoping that someone who cared about
> hibernation would decide to go and work on some patches that permitted
> using it without having to use NONPORTABLE, but that has not yet
> happened so here I am.
> 
> [...]

Here is the summary with links:
  - [RFT,1/2] RISC-V: handle missing "no-map" properties for OpenSBI's PMP protected regions
    (no matching commit)
  - [RFT,2/2] Revert "RISC-V: mark hibernation as nonportable"
    https://git.kernel.org/riscv/c/e2d6b54b935a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



