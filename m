Return-Path: <linux-kernel+bounces-95934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF6487551B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C60A286AB2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC8E130AE1;
	Thu,  7 Mar 2024 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6kLnD0B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431A412D754
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832344; cv=none; b=JrQH70UlzUG483xAlpljIBKXRS8nh5RDRmHd0P3CXFXVuzBp2zDB6e5xOBooxUpfTRevULBiHMqUZPZ1gkwyk30w3MTZzfzaJuvTTtGmxEjRteVXGkmFZspUcbf2mpJWGf568v5NPwaysdtlaoGYJKgdV2SuWl15ZBdhK3gv7Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832344; c=relaxed/simple;
	bh=dynjC0AMIe3EZw5uMKQVJ84eW4CVPU6BJ6pGvhvM7T4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f9VzWBjJpSiS85goLnrSO9Eivdc3fBiP0iSqGvUL/0+iC48yhRrt1XLTqQajnGyaWN5fEviuVqfe3nakvXn2yU3dqJKBd5Qj/BQboJfXUjYpd2gS//FVAu4KqExNVe4EsEzfQRG8Rtu/8Ov42C7d6Ib8gxjhGQ0Y3lu3CD9JAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6kLnD0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87930C433C7;
	Thu,  7 Mar 2024 17:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709832343;
	bh=dynjC0AMIe3EZw5uMKQVJ84eW4CVPU6BJ6pGvhvM7T4=;
	h=Date:From:To:Cc:Subject:From;
	b=X6kLnD0B9JH0ECFeIFioJudYWoqjy0HadT2TAfHUu57LG0yRKZwWe6aLcj2sZBQ3u
	 3I1+P0SN4lTI+pjIVKvsOKz14lp724fzgZGLqgHciC3DpI/zhLzCZydyrYQiQqy+j6
	 IQbpjzG9juSz3ye4OHpBIT9xR5H4t+uBTC553N1D8vpzq8K6u8w1RWBXHI4Q95lonm
	 uMBtmLcBP8OqZCphXM+Vmv0JVmFsNHrfyTu8ljrylqrVW+9kabYUnzXx4w0Ee4nEl7
	 pr94H70oFM7eVfBO5e/sy/G5Xwx72ImBLTim39hIcKqDsrbwakOTcitc5qrgC0KP0o
	 sC/HmsooCQ7Ng==
Date: Thu, 7 Mar 2024 17:25:38 +0000
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fix for 6.8
Message-ID: <20240307172538.GA24546@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Linus,

Please pull this lonely arm64 fix for 6.8 addressing a kprobes regression
that we introduced during the merge window.

Thanks,

Will

--->8

The following changes since commit d7b77a0d565b048cb0808fa8a4fb031352b22a01:

  arm64/sme: Restore SMCR_EL1.EZT0 on exit from suspend (2024-02-20 12:19:16 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 2c79bd34af13de221ddab29d8dfc9d5eeca8fe9b:

  arm64: prohibit probing on arch_kunwind_consume_entry() (2024-03-04 13:00:00 +0000)

----------------------------------------------------------------
arm64 fix for 6.8

- Fix recursive kprobes regression when probing the stack unwinder

----------------------------------------------------------------
Puranjay Mohan (1):
      arm64: prohibit probing on arch_kunwind_consume_entry()

 arch/arm64/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

