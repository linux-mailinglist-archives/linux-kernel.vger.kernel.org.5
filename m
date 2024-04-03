Return-Path: <linux-kernel+bounces-130037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6782089736E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2354E28F6B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E4F14A637;
	Wed,  3 Apr 2024 15:06:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237BF14A631;
	Wed,  3 Apr 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156808; cv=none; b=DACsKzJGT/GHcDOZaBdPWZI2a53WrWTwZ0a+DyuvkQoLqe4iiZKKjvyE/EOSxX4ddL1Z7PF+MXjJORQC7rb/9ThsmyK/a033fAADCs5QSC0RWG2xs4n5aqg61IKJqQXZgy5VinqaQbUJ5A2HA5cxHL4SkyD601TjjdZ4E6FFGMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156808; c=relaxed/simple;
	bh=6uartsKX+D52YF4pByay/DlB6SdJHJgzwA9W7s18Uy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sV/bwrHmh/xmX7Bkn6G1a+0FV/cKTdSJWc97NjJXYqr95jcUmQKXGgxmkfknPO34gBO7adBqbn1thLS9hMw0b9BYsFCCRjrZ7s1dAaa9phXBbKe6JpIaB1l64FM3YHkfGQ0RSKc3fD6tx0YT5BYSFstmtiRHoBGHv3gISxY7To0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E263C433C7;
	Wed,  3 Apr 2024 15:06:46 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/ptrace: Use saved floating point state type to determine SVE layout
Date: Wed,  3 Apr 2024 16:06:38 +0100
Message-Id: <171215679415.2136188.8838449707596683303.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325-arm64-ptrace-fp-type-v1-1-8dc846caf11f@kernel.org>
References: <20240325-arm64-ptrace-fp-type-v1-1-8dc846caf11f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 25 Mar 2024 16:35:21 +0000, Mark Brown wrote:
> The SVE register sets have two different formats, one of which is a wrapped
> version of the standard FPSIMD register set and another with actual SVE
> register data. At present we check TIF_SVE to see if full SVE register
> state should be provided when reading the SVE regset but if we were in a
> syscall we may have saved only floating point registers even though that is
> set.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/ptrace: Use saved floating point state type to determine SVE layout
      https://git.kernel.org/arm64/c/b017a0cea627

-- 
Catalin


