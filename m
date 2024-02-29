Return-Path: <linux-kernel+bounces-87621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C6586D69C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E9F2849CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF93874C05;
	Thu, 29 Feb 2024 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8u9tpQ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB036D53C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244635; cv=none; b=KkFzPM0rAh1wy/ZzM/lD2E1DDBw0qcT0s3PBiIFUrM1+QOMNo8bOfmytxtaaaKa0yN5T0LLG8tWDDww1lSPyJZzAifW1cxzjfIQPg18SMH5LzP6wIRpP/0N78ULrqmPDXL4W+d/CYpI1ETdYZhx9nH5tIhI1nQdXS4eVGbt2vTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244635; c=relaxed/simple;
	bh=W6eOc8kPa7vvpD1zip2/JSn/BkY9XxDFR3rIhaQnalg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dzJUJPpOrCCPxergN+i8x5LbmUz7DerIm69pQTCkhUPWjQy7iqrrjO+cAcpai/9H9DcsSPEBbCtnMJB2Atn4xOBOAcLxEf/uRabw0gFbolre2MElDb/osPSoSw6SxDrQH+BkrSuHDVk+c2d9JDFCLJqGI1CmCCIssfuxgsz0n5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8u9tpQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDF00C433A6;
	Thu, 29 Feb 2024 22:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709244634;
	bh=W6eOc8kPa7vvpD1zip2/JSn/BkY9XxDFR3rIhaQnalg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j8u9tpQ5Ka83UQtCI1wDmrXxj55f+GHizGHXKVMAsGT36l4Duj9VIIC2aJ/+CB/mZ
	 wic3jahFicHTkDCn3MaFBtR3amtTfqAp8Gaz9uN4sismYebkm7xbpFd04m1msA19Z+
	 psBHVGVO1uf4B90D/7QMm/CVknnVjArdAGgW4hgYeFYYN3V7i5EVwnGQqE9+sGUId5
	 T0h6+5i2j9uxHl7t5BleyhQh30RZnNnAo1KPAZw7hqlr0wawRvKIFTX3b86FO/LOvh
	 UKYYIkF/Vgl1PixoHKvGv7/TJ8OlBzR9onjDzFxlL7AElccDQhjM63HLna2y6wL1i0
	 jKIdrjOo7LoVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0543D990A8;
	Thu, 29 Feb 2024 22:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes v2] riscv: Sparse-Memory/vmemmap out-of-bounds fix
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170924463471.14902.12448827543196020525.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 22:10:34 +0000
References: <20240229191723.32779-1-dvlachos@ics.forth.gr>
In-Reply-To: <20240229191723.32779-1-dvlachos@ics.forth.gr>
To: Dimitris Vlachos <dvlachos@ics.forth.gr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 palmer@dabbelt.com, alexghiti@rivosinc.com, paul.walmsley@sifive.com,
 clameter@sgi.com, akpm@linux-foundation.org, rppt@kernel.org, arnd@arndb.de,
 mick@ics.forth.gr, csd4492@csd.uoc.gr, maraz@ics.forth.gr

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 29 Feb 2024 21:17:23 +0200 you wrote:
> Offset vmemmap so that the first page of vmemmap will be mapped
> to the first page of physical memory in order to ensure that
> vmemmap’s bounds will be respected during
> pfn_to_page()/page_to_pfn() operations.
> The conversion macros will produce correct SV39/48/57 addresses
> for every possible/valid DRAM_BASE inside the physical memory limits.
> 
> [...]

Here is the summary with links:
  - [-fixes,v2] riscv: Sparse-Memory/vmemmap out-of-bounds fix
    https://git.kernel.org/riscv/c/a11dd49dcb93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



