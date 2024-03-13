Return-Path: <linux-kernel+bounces-101529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A61E987A852
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4768BB23E2B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA2B45C1C;
	Wed, 13 Mar 2024 13:27:54 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE682446BA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336474; cv=none; b=fjjIDbvg91QtTR+kN90m7R6COLCiAxuWa2FAAg2Vi4eQuydoiF0K6pAQwzsoYXedySAaA1uwrhkMHtN7Yh8vB855Y1bFid6TcEXZf+2k3l5+3AE2J1+bIOyqCVe8gRg9bJDYuJ9zxt2GbdHYc5KsDtHsOuDjljrLzokn8wCR3lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336474; c=relaxed/simple;
	bh=eL1XsV0l4zMXTYVeb/MatWCX51BHyDz25GHRHJzUBgA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZDgfqu22NIcz3DLaGXZlFXvBi9mr/mxTEeOC9RnMPNYcFomj/pKyBxVkfKSd1gUv260CwV9zPra/GwBL+Z7acFOXh0GS4ohp8bEaLtY5T0L0GbVoamh3XpxsrDIKQUhlgOIFJXzTxR2IbJcyNtlftBkEh2ZzhGwWw7BXizS7TvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tvrsy5b40z4x1R;
	Thu, 14 Mar 2024 00:27:50 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <dc9a794f82ab62572d7d0be5cb4b8b27920a4f78.1708078316.git.christophe.leroy@csgroup.eu>
References: <dc9a794f82ab62572d7d0be5cb4b8b27920a4f78.1708078316.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Implement set_memory_rox()
Message-Id: <171033598336.517247.4075878005606513732.b4-ty@ellerman.id.au>
Date: Thu, 14 Mar 2024 00:19:43 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 11:12:05 +0100, Christophe Leroy wrote:
> Same as x86 and s390, add set_memory_rox() to avoid doing
> one pass with set_memory_ro() and a second pass with set_memory_x().
> 
> See commit 60463628c9e0 ("x86/mm: Implement native set_memory_rox()")
> and commit 22e99fa56443 ("s390/mm: implement set_memory_rox()") for
> more information.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Implement set_memory_rox()
      https://git.kernel.org/powerpc/c/09ca1b11716f96461a4675eb0418d5cb97687389

cheers

