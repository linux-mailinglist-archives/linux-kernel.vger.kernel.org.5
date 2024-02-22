Return-Path: <linux-kernel+bounces-77443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D00D3860565
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71681B241BD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42289137922;
	Thu, 22 Feb 2024 22:05:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9AD12D1F9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639535; cv=none; b=Zc6rfalgfS6RpC+BVk6mjEYh7VQ1hZDuh4NhUBe6Bx5WBHk2Le9tF5TKADUGO1GN1692QTR4XMVLpq2+a1CL/y4TIV4rAE5cCrrL1HvtqNZNIWONJlyMPd6dsInowy6m+wx9LO7Ut8eWmRm4TSlMnJ/jWnRUuZuRZBSqT9oAmzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639535; c=relaxed/simple;
	bh=fescA2HCA+KDAyGQ4evjhwnLChU3ktYbPThY1amsb0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAHmYL/K6Aqw8gMj8b5E7qjQ1vSuNU4rVmhO+TkgXK6dRgV5fzNUMl7OKSQItG+RBS3KS8m9lDx6tTbnupQcXJZ89utugTtwgOkQxEy8fBzuy9azkFs2HVY0avpDU6i6wRslTOhSlWP4bEHBoY/qQ3mUJUFJTlCg+gOfme8kmJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E040C433F1;
	Thu, 22 Feb 2024 22:05:33 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	revest@chromium.org,
	rostedt@goodmis.org,
	mark.rutland@arm.com,
	arnd@arndb.de,
	pengdonglin@sangfor.com.cn,
	Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: make member of struct pt_regs and it's offset macro in the same order
Date: Thu, 22 Feb 2024 22:05:31 +0000
Message-Id: <170863948634.1616990.12613009434270992544.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130175504.106364-1-shikemeng@huaweicloud.com>
References: <20240130175504.106364-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 31 Jan 2024 01:55:04 +0800, Kemeng Shi wrote:
> In struct pt_regs, member pstate is after member pc. Move offset macro
> of pstate after offset macro of pc to improve readability a little.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: make member of struct pt_regs and it's offset macro in the same order
      https://git.kernel.org/arm64/c/58a0484eaf5e

-- 
Catalin


