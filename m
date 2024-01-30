Return-Path: <linux-kernel+bounces-44783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEA1842754
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC4A1F25E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B622281AD7;
	Tue, 30 Jan 2024 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlxlWpyZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28607E766;
	Tue, 30 Jan 2024 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626675; cv=none; b=gb8ZuaLSGCJFBkFlLINmmLrjoQMmzaXC3DSvHfmae0XPOgdxa9z/WMuidqVGdzP/Bh4O/igK2OO2yQg+ULnq/FhxsEk9zBhFcTgu9oceCkuv0xiNuFO8rAfvRnsFeQjxoyR7Ex/kkrodpAO3K+m+j0iHQrozEbPPY9QRZ/6FqQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626675; c=relaxed/simple;
	bh=+JA0PaxoN/9HVj+K9jAHPqlYuiNnPDoxJCsUI/49oLQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r1WMS4Td/8HXocM08JVmwASm+I73C8bDtjt00QjIgZkxh0U0AjW6oGn+UI+O8nzmnmkyOTap3ZXdfzVT+iFDqAuC5+H7BsV5UQ6iWHl5jMQ5SToLt10Bib1FK9TTSQiIlJh38pXD7NeibneJ6HjKL8CYPO3wNA0f+R2Q8IR/zxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlxlWpyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9C9C433C7;
	Tue, 30 Jan 2024 14:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706626674;
	bh=+JA0PaxoN/9HVj+K9jAHPqlYuiNnPDoxJCsUI/49oLQ=;
	h=Date:From:To:Subject:From;
	b=IlxlWpyZNG6OfflrGQ1aGkCcNjjkrWvam0I4Dc49gZYb/KfvYuX9A8uN6tYDYWhWW
	 XK3uc29Aul/LD90I+eHA1GDerODvNFEpqoEvKOYRG4iOpMzyprqjFHMIlfgcQGXAaJ
	 ifW8/g4yAgzqYM0xJ9oklIJwdrum2YrEQ8VUogO/YgfLO1mMhuZrB1qOa6KreM6cKC
	 OAQj19y71B++1j2QZq2WRqAjB0A6VIc/KZ8ytW9ZroUWPX8py+4VWGtY+Rv+IqSHId
	 R2zkFq5xOlt2TiPt2lWCsZa+Vtkl+yb+hHxJbo8ok02zzkeJrDuCi5iTBgu76W5LC+
	 R5U5t/NIef2LA==
Date: Tue, 30 Jan 2024 07:57:52 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Prebuilt LLVM 18.1.0-rc1 uploaded
Message-ID: <20240130145752.GA3166831@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded a prebuilt version of LLVM 18.1.0-rc1 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

As with Linux -rc releases, this is not the final version that will
ship. If you run across any issues, especially ones that were not
present in earlier LLVM releases, please consider reporting them to us
so that we have a chance to investigate and fix them before the final
release.

Cheers,
Nathan

