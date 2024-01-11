Return-Path: <linux-kernel+bounces-23736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702D782B0F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820211C23D88
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABFC4EB2C;
	Thu, 11 Jan 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq36s6XH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ED5495D5;
	Thu, 11 Jan 2024 14:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7DA3C433B2;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704984637;
	bh=gdgtNpyL3iGYpN5fWGoWRuJ8Tt8QZwxXPQpw0xnUJ6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Aq36s6XHWAapk7vNTgj1jWLUkf2EPJwSCz2dwnb24J+GQlMIe0827n+P+ELynHfdU
	 O5NtyLaHcUK8fP5GsyOU73TJNwxr8DChoQRYNi8NS1lgcnqmORtXclWor8WWvzi0kR
	 gLasGPPMysgi02WkD4SYV6Vy0+SePqrcaszLe94uoPhoZCtcRqWtsNs+w47NeKeDAG
	 cPAnFYoNOTSZjNK93f6YYamQ82/wwmz8GKNIsDr4Ds2RgfQvdMjvI5N1aBNmyMPVix
	 DFUIGwwxhtsr6Z6LX0J7IQbINGUA3FPplzFUFnxuf/sfMfPPrtDQUW44oua91/eI4Q
	 nk8CURcV3E/Wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B20BFD8C96C;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/6] riscv: hwprobe: add Zicond, Zacas and Ztso support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170498463772.20080.16524587804054627963.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jan 2024 14:50:37 +0000
References: <20231220155723.684081-1-cleger@rivosinc.com>
In-Reply-To: <20231220155723.684081-1-cleger@rivosinc.com>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, corbet@lwn.net,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 conor@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 rehn@rivosinc.com, gianluca@rivosinc.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 20 Dec 2023 16:57:16 +0100 you wrote:
> This series add support for a few more extensions that are present in
> the RVA22U64/RVA23U64 (either mandatory or optional) and that are useful
> for userspace:
> - Zicond
> - Zacas
> - Ztso
> 
> [...]

Here is the summary with links:
  - [v2,1/6] riscv: add ISA extension parsing for Ztso
    https://git.kernel.org/riscv/c/1ec9f381e848
  - [v2,2/6] riscv: hwprobe: export Ztso ISA extension
    https://git.kernel.org/riscv/c/5b4d64a819c0
  - [v2,3/6] dt-bindings: riscv: add Zacas ISA extension description
    https://git.kernel.org/riscv/c/cd7be4d02f41
  - [v2,4/6] riscv: add ISA extension parsing for Zacas
    https://git.kernel.org/riscv/c/188a2122c827
  - [v2,5/6] riscv: hwprobe: export Zacas ISA extension
    https://git.kernel.org/riscv/c/154a37061229
  - [v2,6/6] riscv: hwprobe: export Zicond extension
    https://git.kernel.org/riscv/c/3359866b40a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



