Return-Path: <linux-kernel+bounces-133448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC78889A3DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449F81F23822
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD74171E64;
	Fri,  5 Apr 2024 18:06:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F531D530
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712340409; cv=none; b=iyKXL2TTQLfhU/fVSu1ftm3l6VhkrPjA5+Rfh+tq8ckamYgWjA6B0Cv9aetDi+4kZecXgg28ocNZ5FuaDcTsmrdtxeWXEdnihcBos1n01TMMWQx9WcfTUqpHeXO/lfcY4cF/lBYbE78aeXgZIfr1j6C0JigNuhCRzDtQu5FIO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712340409; c=relaxed/simple;
	bh=GOwLusNRzXjyPeMBRzYJ80/xmsaudieEgkQoMPObTzo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=buDQ+kyXmQyFXosuESoHkDaTaGVCaSQH1nT2wVttVbt0esImLxN+VhZ+CjTpwGg3z8lrr1Tqb/aUPZ4zwFdN27T1L5otwvfBKLRiD2ier9rpzNAeml4OW0Nj+xMEJra1+T5kQoGjUzVxJs5BEbFf5eTfosSzxtug8m++StJNtmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2B9C433C7;
	Fri,  5 Apr 2024 18:06:47 +0000 (UTC)
Date: Fri, 5 Apr 2024 19:06:45 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fix for 6.9-rc3
Message-ID: <ZhA9tWAmdQ0LGg8t@arm.com>
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

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to b017a0cea627fcbe158fc2c214fe893e18c4d0c4:

  arm64/ptrace: Use saved floating point state type to determine SVE layout (2024-04-03 15:02:00 +0100)

----------------------------------------------------------------
arm64/ptrace fix to use the correct SVE layout based on the saved
floating point state rather than the TIF_SVE flag. The latter may be
left on during syscalls even if the SVE state is discarded.

----------------------------------------------------------------
Mark Brown (1):
      arm64/ptrace: Use saved floating point state type to determine SVE layout

 arch/arm64/kernel/ptrace.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

-- 
Catalin

