Return-Path: <linux-kernel+bounces-85565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C3986B7C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C03028842F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EB974405;
	Wed, 28 Feb 2024 18:59:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3454224D7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146764; cv=none; b=WFdk7+CqoKaEORKuw0v/EQwhEfERCKjrAx1gvrz43RAJT6Fj62FYR4SbxAeuO6nS/0uH+sNTR1L52RMJ9+Kv7wqlXqwpZ3xo/+5xlaxtDulBG1E9sHGIg9z3JEUgLnlbwqPVZlrcxECdx9QbMA4mdWmzJpXb8+vpm21oOk+VX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146764; c=relaxed/simple;
	bh=bKl0jugfkeXXkMRb5Od2By1Cttu/vMFPkzWzLPmtEKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNGwg+XNAdZ2DJlmQ9+LfQU9DRc3GcmOa4uQSOJa/Cs5sdmdOgyRFIohmE4/yg0kFchKDEJIhzG7d+2CBMYXDHLlt7+zNsZ1OSAB2PVbw+bJ2R4Jgj90ap+xCuTcLp9exf5PNm1n0h9QQkeHAOj4PDf8+iSHnuYB2fMBh22MZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC65BC433C7;
	Wed, 28 Feb 2024 18:59:21 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: mark.rutland@arm.com,
	will@kernel.org,
	ardb@kernel.org,
	rmk+kernel@armlinux.org.uk,
	Jonathan.Cameron@huawei.com,
	gregkh@linuxfoundation.org,
	james.morse@arm.com,
	takakura@valinux.co.jp
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/kernel/setup: Update comment on interrupt masking
Date: Wed, 28 Feb 2024 18:59:19 +0000
Message-Id: <170914663643.3370652.5243649129171435095.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228022836.1756-1-takakura@valinux.co.jp>
References: <20240225021812.4834-1-takakura@valinux.co.jp> <20240228022836.1756-1-takakura@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 28 Feb 2024 11:28:36 +0900, takakura@valinux.co.jp wrote:
> Thanks for reviewing!
> I agree that it is more simple/clear with the suggested wording.
> 
> Sincerely,
> Ryo Takakura
> 
> 
> [...]

Applied to arm64 (for-next/misc), thanks! I also picked up the commit
log from the first patch as it made more sense than this one ;).

[1/1] arm64/kernel/setup: Update comment on interrupt masking
      https://git.kernel.org/arm64/c/6d1ce806e17f

-- 
Catalin


