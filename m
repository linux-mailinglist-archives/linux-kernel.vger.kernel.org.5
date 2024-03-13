Return-Path: <linux-kernel+bounces-101534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0576487A860
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDF51F210DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113EF4CB57;
	Wed, 13 Mar 2024 13:28:01 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181774C635
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336480; cv=none; b=AV36l5oHxGonszqZE3tRsQYEw/MkxgvLB8cBZy3mYdIupvwkVb19mPDbKcTvBUkQ8hmFyMtkrmWNw7swKxxMGo+3hjjmxE3zj6L6gly6RMXtLBwrTwqJzbeOJThjNsNqTy73vDsqy4fQAsek/MPyf9OAXZ/kslnCIKpXLaAt48M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336480; c=relaxed/simple;
	bh=vRs3n5/VvktrDKffUva4cA+VkrhArBq2AHk083ajy2w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ecA2I/drrv5UDjrH75IPv8N+6Sr8hlemA4Uq63ZQbDRC4BwXCabnWs0xgF6h0Lz5AUFBq/jf+iteqGo2/+UDUWX2WxZhQVE4dSJ9kJV7nSIJQfVD0OqH0X/nwrXfjxox6sh9ubD2DBLWi5actzq8oDPkdtwzarCitHDAWQQjtQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tvrt5453gz4x3j;
	Thu, 14 Mar 2024 00:27:57 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: christophe.leroy@csgroup.eu, robh+dt@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231214103152.12269-1-mpe@ellerman.id.au>
References: <20231214103152.12269-1-mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/5] of: Add of_machine_compatible_match()
Message-Id: <171033598342.517247.6905314816188419212.b4-ty@ellerman.id.au>
Date: Thu, 14 Mar 2024 00:19:43 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 21:31:48 +1100, Michael Ellerman wrote:
> We have of_machine_is_compatible() to check if a machine is compatible
> with a single compatible string. However some code is able to support
> multiple compatible boards, and so wants to check for one of many
> compatible strings.
> 
> So add of_machine_compatible_match() which takes a NULL terminated
> array of compatible strings to check against the root node's
> compatible property.
> 
> [...]

Applied to powerpc/next.

[1/5] of: Add of_machine_compatible_match()
      https://git.kernel.org/powerpc/c/c029b22f8a98e14988f800d5c0176a9eaec3c8db
[2/5] of: Change of_machine_is_compatible() to return bool
      https://git.kernel.org/powerpc/c/cefdb366dcbe97908b6055595a15bf7689556bf8
[3/5] of: Reimplement of_machine_is_compatible() using of_machine_compatible_match()
      https://git.kernel.org/powerpc/c/1ac8205f907517a306b661212496fedce79d7cc5
[4/5] powerpc/machdep: Define 'compatibles' property in ppc_md and use it
      https://git.kernel.org/powerpc/c/28da734d58c8d0113d0ac4f59880d94c9f249564
[5/5] powerpc: Stop using of_root
      https://git.kernel.org/powerpc/c/2a066ae11861257223500d7515e1541199cb7832

cheers

