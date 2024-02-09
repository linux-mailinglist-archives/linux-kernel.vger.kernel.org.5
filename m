Return-Path: <linux-kernel+bounces-59802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D640284FBE0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6811F2A907
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F68480BF6;
	Fri,  9 Feb 2024 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqoNcjaX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54F857871
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503494; cv=none; b=GsnIQ1goV5cU+pD1Je76f69IQvad6EJdcIGFB23GpfICqgiBqsoyvai0keldHO2H4s5gAo4BrfYrZ27RR2UBzfjOTt1QV+kwoitlwKBDrokoeusZlQeNgKffGKJst9bK4MULQn3j3f+xcAWz/KssyiN4CoFo9VQQNJpcz2l0xhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503494; c=relaxed/simple;
	bh=hYphy7hwcZXPWGcrOAf7VnQgVSV5jKML/9gkAcnh6H0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2bQqeokU7XbBjjaWYQJ6qdsTYq2clPwLzC1t2l2TyZrj0LpzDwUrXBvByIDFEWimVe807xBJc20CETpRbmmCiGGPnaeffqdnbw0orllqD+qLpHfj3kWspoZ9+RvDvdKwH/BtNWxN3WTIAKSvD5sILX099lHDbXsncBkzr9zRm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqoNcjaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94804C433A6;
	Fri,  9 Feb 2024 18:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707503494;
	bh=hYphy7hwcZXPWGcrOAf7VnQgVSV5jKML/9gkAcnh6H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fqoNcjaXs0igQ6rGKAI1xnKBXjmnGf/qFymk6DuXLzrtxnvmZgMIM6EWIzAShTXbM
	 7xF5z0pJhPsgs4V1pixtBms3qjE06XgwLHTjQuB/Xa1js2Z/DwuZwZF9xFYasMN8sX
	 luXe7lQz8jl+2MIPw8CGG2dPqoLFX8KeB51+esrObX3U41gSuNd2blDJ7Mb5qT2LXD
	 kRgYB5Z1puJFIchRN8r7eziDW+Dz+o12MdcUVDDA9nsVMd70gWxE+7BUWU/RHkolvJ
	 zHmNsYtM9HDUYv1oo4U+o90kxRvPQdIY7Vu1Tgnpddh88V38d0vEAoyzaIzRGzAS1l
	 RHElABiWUK+/g==
From: Will Deacon <will@kernel.org>
To: oliver.upton@linux.dev,
	catalin.marinas@arm.com,
	suzuki.poulose@arm.com,
	mark.rutland@arm.com,
	broonie@kernel.org,
	maz@kernel.org,
	Seongsu Park <sgsu.park@samsung.com>,
	ryan.roberts@arm.com
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: fix typo in comments
Date: Fri,  9 Feb 2024 18:31:12 +0000
Message-Id: <170749765403.2629762.3573310365008007219.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240202013306.883777-1-sgsu.park@samsung.com>
References: <CGME20240202013414epcas1p28ce117bb1e5e7f03b68365ec0d3a9c89@epcas1p2.samsung.com> <20240202013306.883777-1-sgsu.park@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 2 Feb 2024 10:33:06 +0900, Seongsu Park wrote:
> fix typo in comments
> 
> thath -> that
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: fix typo in comments
      https://git.kernel.org/arm64/c/c0b26c06ed00

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

