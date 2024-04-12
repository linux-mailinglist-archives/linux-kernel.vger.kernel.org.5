Return-Path: <linux-kernel+bounces-143162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 463C18A3532
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776BD1C2231F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CAC14E2D7;
	Fri, 12 Apr 2024 17:57:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F7914B065
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712944639; cv=none; b=k6TERBy1G6pYgyv7cASx0QALibDVo3od+VlcVU5i6t3Wc2G+qkXEMnypaIcD9aqJTjsqp/TcWivS03b4Xk7a3+1OteyveIs/P3X6DCesPRMbfCK2QNzXYCfvmLX+W7MCGKN8/N0KiE0ExH6YZcgkpKDhzTVTfP2bI7L0m2a8Sok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712944639; c=relaxed/simple;
	bh=H9PyJgs9eYTkrJRAzSc6plpJxcYB1axKbtuQcNsQdAA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bLFKeFuWwHnm7gI0TgmZgK4zmJEQTNn2nQt7WWPLDqQhY2E8rKnREvM1bzCx3wNFRA0iLLZRDxLwqDOy5XmdgtiT9ZitX+r1eOKyxHb2GuG+pMeipWGpWDr2Um2raCzPCIQSlwWQTr/GwEhXbfxQ4/zMNDvPD8NcStf7dKWi/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFA7C113CC;
	Fri, 12 Apr 2024 17:57:18 +0000 (UTC)
Date: Fri, 12 Apr 2024 18:57:16 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fix for 6.9-rc4
Message-ID: <Zhl1_IacWOADYI4K@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the arm64 fix below. Thanks.

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to e3ba51ab24fddef79fc212f9840de54db8fd1685:

  arm64: tlb: Fix TLBI RANGE operand (2024-04-10 18:22:28 +0100)

----------------------------------------------------------------
Fix the TLBI RANGE operand calculation causing live migration under
KVM/arm64 to miss dirty pages due to stale TLB entries.

----------------------------------------------------------------
Gavin Shan (1):
      arm64: tlb: Fix TLBI RANGE operand

 arch/arm64/include/asm/tlbflush.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

-- 
Catalin

