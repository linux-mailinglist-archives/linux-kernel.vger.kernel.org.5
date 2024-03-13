Return-Path: <linux-kernel+bounces-101530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EA487A854
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585001F2367B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34D547793;
	Wed, 13 Mar 2024 13:27:55 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5453145010
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336475; cv=none; b=Hmv6MCBqaIw0gum7vWNq4K2WgtxUUyLbY/T6L7XXCyr2tr3Y+hInYkfLkTD20HCuPAmQGg/uEJXNfDpsup+1KwJOsCzCQIEEegcq4t413xj7ziohZvJTprlvfHGv+f5wPf3M2wck3DCrlw0a6tEirQpKOi9SEQpI+R4UcTUtWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336475; c=relaxed/simple;
	bh=cJ+rQ4JlHxzBKTZwdGlaoR61MV5w43ulOU+XKZxbjHU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SunyAv9YUPB63xMD8wlH4bgup/vOd9YXBNUBMSo89qP5FD6nym/LYXZeAN4Dj8/jtqCY69ouWc7GSl/cKNf4pqhl4y1D9PkCjXg47r8SgGuCPi/DzWd4p2cYl8VkNatxGVZ9otLK+Z/W//s/V5fOC0B41wyaN7MwhDNSj7F5oGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tvrsz4S0Kz4x1c;
	Thu, 14 Mar 2024 00:27:51 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <85a86e51b4ab26ce4b592984cc0a0851a3cc9479.1708076780.git.christophe.leroy@csgroup.eu>
References: <85a86e51b4ab26ce4b592984cc0a0851a3cc9479.1708076780.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/trace: Restrict hash_fault trace event to HASH MMU
Message-Id: <171033598336.517247.1756148879387291088.b4-ty@ellerman.id.au>
Date: Thu, 14 Mar 2024 00:19:43 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 10:46:43 +0100, Christophe Leroy wrote:
> 'perf list' on powerpc 8xx shows an event named "1:hash_fault".
> 
> This event is pointless because trace_hash_fault() is called only
> from mm/book3s64/hash_utils.c
> 
> Only define it when CONFIG_PPC_64S_HASH_MMU is selected.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/trace: Restrict hash_fault trace event to HASH MMU
      https://git.kernel.org/powerpc/c/9e00743aba832f3f30ecb017d3345baf1f372140

cheers

