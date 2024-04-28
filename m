Return-Path: <linux-kernel+bounces-161590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E0A8B4E63
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED041F20F88
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBB110A1B;
	Sun, 28 Apr 2024 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQXi3i91"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376BCB667
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341635; cv=none; b=Jjfu0d67pgljn5KMO6SM/X5/vqlQK+CqZtTLgt0qUdutKs+jXCf/r8AEsPtP5VQVxWpWjDe4VTCr0GqjTz9evcV0tJR79hrg8PRMl/KoD2C/ps3hf28CpRV3VcX+U/akulXDc4pODPEnPXpVpIpp4I3+LbP5TPF+wMW6AV35bsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341635; c=relaxed/simple;
	bh=EWNgKDcuM8qhXi6R5O9suAUlCk52QhzDL58YgOELfUU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ihp0DhVEtcRtwIL5lk/ahYJJJ4UnJThbYX6VULRaqwejUX1NknRgapkB+efkBDKdvwFXPnilWWBkgv2ED+EtyAnCT/2jOw7SaiWFUAvG+UrlktV/29yPv/A2cwJYTnXWZNZIl1b/PAMaD8tdz4QLG65DeRLE8IrBwuEuTq09PzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQXi3i91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3285C4AF19;
	Sun, 28 Apr 2024 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714341634;
	bh=EWNgKDcuM8qhXi6R5O9suAUlCk52QhzDL58YgOELfUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eQXi3i91aFyaGqoT/ZUdD4q6ZoCVdjv6wnJeOYr+FWzF+cIl2S+IQg2+XJOXuzfU3
	 M9X/f/kKs5ZavZDsQsJyMiV+W5wnMaS+h7PiGo8ImFH74GGFp1+O3SPdDQTMH7sTgx
	 2TZ6E32JcFwqw6P0o9W6n3FFazMKJC/dJEPUyfBHecn72onXYJKVJezPSDNRKw2IPA
	 QlwVFn3Eg3zYklt7Qc3/0ZL41IuwqAls4YxGyiI8+3/50UwCsX97ea4J0Y14NgkYWL
	 iXsPxauNlrFHjQStyNbK89kX+oYO/R/RyW0TE/Cajz3azYxjLHCMzMaBVnBQ0mjEFi
	 fTZJoPdEmjFOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C18DCC4361B;
	Sun, 28 Apr 2024 22:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Minor cleanup of pgtable_l{4,5}_enabled
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171434163478.22130.15340003456801994230.git-patchwork-notify@kernel.org>
Date: Sun, 28 Apr 2024 22:00:34 +0000
References: <20240320064712.442579-1-dawei.li@shingroup.cn>
In-Reply-To: <20240320064712.442579-1-dawei.li@shingroup.cn>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 20 Mar 2024 14:47:10 +0800 you wrote:
> Hi,
> 
> This is a trivial series of minor cleanup of pgtable_l{4,5}_enabled.
> 
> Change since v1:
> - Split into 2 patches, as suggested by Alex.
> - Add Reviewed-by from Alex.
> 
> [...]

Here is the summary with links:
  - [1/2] riscv: Remove redundant CONFIG_64BIT from pgtable_l{4,5}_enabled
    https://git.kernel.org/riscv/c/3a0dc44899d4
  - [2/2] riscv: Annotate pgtable_l{4,5}_enabled with __ro_after_init
    https://git.kernel.org/riscv/c/7a04dd8fd75b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



