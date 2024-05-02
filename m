Return-Path: <linux-kernel+bounces-166637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A698B9D5E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B591F23E1F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0878415B552;
	Thu,  2 May 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bes9sLe8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8B815B55D;
	Thu,  2 May 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663459; cv=none; b=o95Fp4/P1+suPplv4bPRtBlFhDWZvY4fHIUdCGRhgiPBFrnahY++KJYGy8IJXQrpkhrOYrzT8j6ojPVMB7SIAjfo4ntejapxK8UnU1xknotgMNY2lH7OxxC+tjXpQK0skUMoaQpimZVU6AFJpvUG1/xl7f+3wD9mf/8LKCmGzH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663459; c=relaxed/simple;
	bh=N+4GjouHgxEanogq125kqyjV4umhAK3/mP92nSxyTak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J1sB8/Qo26jodUmahBmlsq31FwwvG913xLIZ/gf9c2nRJsQLw4StYsYbzYGXwjvS50BftvGDABZSEHW8oV5ZFVJq5eBmO59Y5ReU6gWJo3XjobhNYW4YMsx6z/f9x9DFz+O9n2F58j7sA3xqlRT8s4EVKnC0DOGVF1Y7YSUZlZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bes9sLe8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1B1C113CC;
	Thu,  2 May 2024 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714663458;
	bh=N+4GjouHgxEanogq125kqyjV4umhAK3/mP92nSxyTak=;
	h=Date:From:To:Cc:Subject:From;
	b=bes9sLe8BuQqk8AlqMKyll+CJj3RI/uQPCtS4N9Yxhc/A+h0sqvvBwQv5kMp37Vn7
	 0NuRl2XxrHD+PIFojzBZUnjqDMz7ysUbk7y0ncTqpA5vLrA+4JmR4vsg5178RWFnlP
	 L1Bx//XQPFsjddyae2EOO0VPDnDzWs+IvSuBi/vRYEf1o8Dpt+M6TYr40nJtqlTLhj
	 FixRvsGk5c7OrPJCoyhFiVifcqXi4loNPCv94HNHKw38NvjTRgvnNmCAukyrWq2J9a
	 wngN9AgMdRcWJ/hh9CmT9uMF7jNosL5s3LgO+4yNQVcPT0BKBwcnSQLcZhzHoMpytB
	 sARCVrOIzZRnw==
Date: Thu, 2 May 2024 08:24:16 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 18.1.5 uploaded
Message-ID: <20240502152416.GA3178126@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 18.1.5 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 18.x
series is no longer supported.

Cheers,
Nathan

