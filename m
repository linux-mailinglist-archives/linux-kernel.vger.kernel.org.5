Return-Path: <linux-kernel+bounces-143004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B7C8A331C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287681F24214
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9E8149011;
	Fri, 12 Apr 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx/O81hL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA16148FEC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938013; cv=none; b=ldLqLrnIce2IcJiWOQjgLK3eJm64nsZKJLPs/m+rYqRE3d5V/LUro5gVwCOGoP97Kr+5ii5W/oJyxkauh56yQK3EhXgDPo/XRDWE3YEO64N6YeIX/nwguyEutqbhzUusySRaHMI/jjScGcyh9lcBckra72sytjfQxnWDD9cwv7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938013; c=relaxed/simple;
	bh=PJGJ67ht3268iKCLboefQhkpwdJV8r/DJ9VGMHsGW2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEByG31MhXUDXJnRNgfwhrdtM7tN2+d0jWc0EzsVNWA6Tui4X1wFD33g/Y6tyNO0/wjLgXpeytaxHf0xrxrZeiMqKdqdAZWmh6bbm7GwebIzpmPO1sB9raPKkvmxqakAOZj9B2nTfLjmTQlJRKs3WOYJM7BAZTLFuIpBwzVl9vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx/O81hL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187A6C2BD11;
	Fri, 12 Apr 2024 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712938012;
	bh=PJGJ67ht3268iKCLboefQhkpwdJV8r/DJ9VGMHsGW2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mx/O81hL5dT0O/edFDwB1kHRYfEpQxG++9cpDvIHlrAMj9Vekrumt3nL9WA4Ra1PA
	 4LRRRKvFLnKSe6Y4GTMl3B4SNHeE/GR81yaQiEtsv8TfcPKByJG1ErjoT9qLfbQYIE
	 FrL3uD4TCD8Cb+kwOmjsl/a4tOwGvnXPim5nTvJ6hzSqeKttTeiIN1X1ixH+JZ6yS+
	 Dk+V0jcrSedqcrIO0ZV8riMegq5kKIBFFyZWZImoJ8sTgv67Ac/r0+ZySGN1WGyEsL
	 KsUULpoET3DZOOrZkyaAetwYpXYoSs/dkMfGxC5S09iTx28LVU/vmGyaLZDbgsN/+e
	 SmztuwbLOoR9Q==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: Remove unnecessary irqflags alternative.h include
Date: Fri, 12 Apr 2024 17:06:40 +0100
Message-Id: <171276570998.830195.7238014942066048494.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240314063819.2636445-1-ruanjinjie@huawei.com>
References: <20240314063819.2636445-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 14 Mar 2024 14:38:19 +0800, Jinjie Ruan wrote:
> Since commit 20af807d806d ("arm64: Avoid cpus_have_const_cap() for
> ARM64_HAS_GIC_PRIO_MASKING"), the alternative.h include is not used,
> so remove it.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Remove unnecessary irqflags alternative.h include
      https://git.kernel.org/arm64/c/98631c4904bf

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

