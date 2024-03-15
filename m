Return-Path: <linux-kernel+bounces-104501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE3987CECA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92D11F21A07
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8525C3A1B5;
	Fri, 15 Mar 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu6KPjK+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B4139AD7;
	Fri, 15 Mar 2024 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512769; cv=none; b=oRpWtKK6E6quLktI0UhkZGfqFIiEo4JVH2L2dchNEacyyIMXJ/FTmIQtEp9YmQTzTmZ0B8BvPe5EjzzNJ+uiGlmjjtd1xMJU5gf+mRTN9z+Tttyxc+dE3sCq4mMRd6MQbCbmdKFOYnAzhZacDPTu+ZaSEaRQz16c8A2F7Mvn2Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512769; c=relaxed/simple;
	bh=3K2I9e6Lt1JlJf2uXJhAY880Fw9lya18uPyCx2nVL70=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tiuVmu9CiKZj+Q1kPPm8qxxDP2nrVr8IH11s+aJMGaX5oXbKr778BWk52Cys0l7EHz00a8UMNcK59yYwMEQdeTCNrV58PKhnVvN3aAlKk5LF85sWJohZgUasKtKbeLshslhHjxpPBzOcZJ9G0Tj3diFLhe27ovclXgQTMAck9MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu6KPjK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EF6C433C7;
	Fri, 15 Mar 2024 14:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710512769;
	bh=3K2I9e6Lt1JlJf2uXJhAY880Fw9lya18uPyCx2nVL70=;
	h=Date:From:To:Cc:Subject:From;
	b=Zu6KPjK+w8uYoQ0ESUcsHrBVhGV/1i9b7pKLXw9487Hop0hLhVYIhYGmYFsfG80dx
	 eNMcNiENHbCxqWoEHjxFl8UlCTkzLbDUOrcSfe3TVO8QabHYI0uKhrKha/aFKPcUlK
	 RpWZKhShlVrKfGnSnSlYaiN3+4Ful39wa6UT6h/+E7wXnlvcbZ+KfKqNQh3kZtk0sh
	 yvtilPHA8f0ymgENn2dMTzZx8P0jYBt39AwJecnMpIBYJXjFyG8Bnq3OGQ/0l/YWJB
	 mBYMuggwGkZT8cxuUfkURdIuDpXnVXy76ma+xZDmr4NXKfdvnFo2iA3hBw/TxBQA9B
	 Loi5stZN0duKA==
Date: Fri, 15 Mar 2024 07:26:07 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 18.1.1 uploaded
Message-ID: <20240315142607.GA73955@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 18.1.1 to
https://mirrors.edge.kernel.org/pub/tools/llvm/. There should be no
functional difference between 18.1.0 and 18.1.1, it is only fixing
LLVM_VERSION_SUFFIX to remove 'rc' from the version string:

https://github.com/llvm/llvm-project/commit/b92012c777e602d557124583651313a0afa33484

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 18.x
series is no longer supported.

Cheers,
Nathan

