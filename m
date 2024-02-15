Return-Path: <linux-kernel+bounces-66945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27178563E0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B8A1C20D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B1112FB16;
	Thu, 15 Feb 2024 13:01:07 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF4128837
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002066; cv=none; b=M5KTnMaZw1olaytqV3TeUrf3nHBUKpmBi8IwE4brOoU2lMl1SVyJvaJ06QBQQJ4BUYq1+vBaQYNTNzDOkDyuyXC0M90igVctwYFrV/dxLWTTSZ/h7DBiTM0RIQg7Wa0aAD3zWgCoKc9mvUiNfas25MnNTu52pCB9oLhh4z655Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002066; c=relaxed/simple;
	bh=jc15789bDMt21egKqX/pmOgCvN19cqwTcBI3ocGrRmo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pMqs75Q0QG7pHJeBK1KQmwTCvJWBSv8VcEuyq3ERyBrYAMfwCZlMQz35E2gYjWexOYQLavJZD6AH9ZMnAwYsaSK2WYhikajVfT+HEaQBWn878l7FrAUc+zVUgTnyhMgBrkfGnVZIkz3r7whs644uAL44FD9Fg7QhTrlUJdB1IFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TbFYW3FMLz4wcM;
	Fri, 16 Feb 2024 00:01:03 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>
In-Reply-To: <bbd84ad52bf377e8d3b5865a906f2dc5d99964ba.1707832677.git.christophe.leroy@csgroup.eu>
References: <bbd84ad52bf377e8d3b5865a906f2dc5d99964ba.1707832677.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Force inlining of arch_vmap_p{u/m}d_supported()
Message-Id: <170800202445.601034.6210064022309317315.b4-ty@ellerman.id.au>
Date: Fri, 16 Feb 2024 00:00:24 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 14:58:37 +0100, Christophe Leroy wrote:
> arch_vmap_pud_supported() and arch_vmap_pmd_supported() are
> expected to constant-fold to false when RADIX is not enabled.
> 
> Force inlining in order to avoid following failure which
> leads to unexpected call of non-existing pud_set_huge() and
> pmd_set_huge() on powerpc 8xx.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Force inlining of arch_vmap_p{u/m}d_supported()
      https://git.kernel.org/powerpc/c/c5aebb53b32460bc52680dd4e2a2f6b84d5ea521

cheers

