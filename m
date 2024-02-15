Return-Path: <linux-kernel+bounces-66913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08786856384
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3E71C23744
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3F112E1D8;
	Thu, 15 Feb 2024 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/MtHXi8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1496812DDBB;
	Thu, 15 Feb 2024 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001088; cv=none; b=TXBKvnHy0p4CypsMPfyaP9/fUJ/jFdvuv92ss1EztO4gOiRNGZUiHWXeUty5Dm6BU/8RAEDIg/esI6V39ZmundsUlX7kG7w1V/mbZMH+SZirr4oMG1v9H/AqcFNoyekXerWQ8TawwAhbZOunH2K7zWccwikdczR40Sp0GxeDzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001088; c=relaxed/simple;
	bh=EdmufWQaVwffxLhQdQ6E7nT/EWdxxAEZpxmh/Eg8Yig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=US1h/SeB38LekCG3quvX+XG6lrK5NOjPSnuf6hfduD9V+wedKK2ISeTJnwpVQJz+iQU6f25lUOAULorz9Sse7Aeq1jqwZDQ5pGWRUqJgbxWR5WRWALM2HGU5Ds9sKCD1sXkJzXgzDAfQVme1I37JJo/toQioeGJjJI7l5nuy6Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/MtHXi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE682C433F1;
	Thu, 15 Feb 2024 12:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708001087;
	bh=EdmufWQaVwffxLhQdQ6E7nT/EWdxxAEZpxmh/Eg8Yig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V/MtHXi8TXRaLI/EM3ODSpXgDDCPQdOxCps6ATcUHyNUss4BXT8xxpK5xF3T1kfC9
	 mqEue4P6Ypu8e1Rv1EHR22aX0fYeal74X2pwdhVjjyxiolwBB6qMuy0bygf16ZpUWx
	 m1YuhBdq3iINziHsfVCE4ax6YK/pBnifXyBfgwMvRcLWQ/tg5w5y1OK6dPFRIMHP3O
	 RCcZj+UmU1eS3Kt0UqPvGR0DJNIpuPmOtCGiHP44Jf9vyo0UOuHeBRRSTx65SDRA4t
	 lngLtn4MGguAQ9dwGzrSPX9y0Hj91DqI1Bb1lyyuUn6e9nWZT6CkLjMcmxE3FV+fen
	 gr6tApkDqqlmw==
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Rob Herring <robh@kernel.org>,
	"moderated list:ARM64 PORT AARCH64 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andre Przywara <andre.przywara@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata
Date: Thu, 15 Feb 2024 12:44:38 +0000
Message-Id: <170799764265.3746091.15823620803100752366.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240214175522.2457857-1-eahariha@linux.microsoft.com>
References: <20240214175522.2457857-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 14 Feb 2024 17:55:18 +0000, Easwar Hariharan wrote:
> Add the MIDR value of Microsoft Azure Cobalt 100, which is a Microsoft
> implemented CPU based on r0p0 of the ARM Neoverse N2 CPU, and therefore
> suffers from all the same errata.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata
      https://git.kernel.org/arm64/c/fb091ff39479

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

