Return-Path: <linux-kernel+bounces-101528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 844A187A851
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BB41C209B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E7D45BED;
	Wed, 13 Mar 2024 13:27:54 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6D0446B4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336474; cv=none; b=B083INA5z7GTBlFl92mfxDZmwZ9oqB4bhJgO5uA0jLrI5DAzALo5vUIdUlN7gobgoUfsPs2hfVwtrP0Ja6fEFvsEqxW51GTv7Xi9t4GNekDn8ibuiuT8FmiU5ZTsw32NTuR0V32yyZ3qIAKCwfpNupfBPWsov3CPlOp18PoPdKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336474; c=relaxed/simple;
	bh=IVoZ5Nk3c6TGvvv7OnFOEg0/tyh6L7IZfnEYAfEFQSs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BAE65IpU7AmrM18Y8zXoQM6QXCQuOqBZHsRRQVoFqOo5snjJy5uUJwWRvoQ9Y7JnsAgGhfvaMHVRgqNhQnL/yzTwEpXk+KyWM1Nbrv7yvbaait7M90l51wBiGs7LrJcwO4xLQW1Cqm3s/mZCM4s7HHBtvX/n663zyRuA9iJeKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tvrsy234rz4x1P;
	Thu, 14 Mar 2024 00:27:50 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <3656d47c53bff577739dac536dbae31fff52f6d8.1708078640.git.christophe.leroy@csgroup.eu>
References: <3656d47c53bff577739dac536dbae31fff52f6d8.1708078640.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc: Refactor __kernel_map_pages()
Message-Id: <171033598337.517247.16293947196038207498.b4-ty@ellerman.id.au>
Date: Thu, 14 Mar 2024 00:19:43 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 11:17:33 +0100, Christophe Leroy wrote:
> __kernel_map_pages() is almost identical for PPC32 and RADIX.
> 
> Refactor it.
> 
> On PPC32 it is not needed for KFENCE, but to keep it simple
> just make it similar to PPC64.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc: Refactor __kernel_map_pages()
      https://git.kernel.org/powerpc/c/3c8016e681c5e0f5f3ad15edb4569727cd32eaff
[2/2] powerpc: Don't ignore errors from set_memory_{n}p() in __kernel_map_pages()
      https://git.kernel.org/powerpc/c/9cbacb834b4afcb55eb8ac5115fa82fc7ede5c83

cheers

