Return-Path: <linux-kernel+bounces-108050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D1E88053B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6947F282934
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AEF39FD0;
	Tue, 19 Mar 2024 19:04:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C1239ACD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710875084; cv=none; b=mODh5kAeKocAP2+u+usQvIgEJ5Ft9XY1j4sZ6V+3lzEqNmUvLi+6GfYknsqP6qKRMiHUn1HSNcixip5mPyd5jx/ApIBXnttfJl81YAc2SRQtIOaW6Fdgp12ovprNQ1EscRDNC9g9ROj44TzAJlxI74IO8xyPryICgi7lI3qXxWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710875084; c=relaxed/simple;
	bh=o/SWWvz1xb/IpAzeQQg5tL9tpyHbQATMXZTQqEQbamE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bV74ufWSQ8DOcstDziPQwKxiUsUzM7tTYZoVIc9GHNeCjXWdy/TOTsfHpdOyjpETeG4BJVMQTGVMORlVdzYocOxqyXCZpvGJ25M0hK/YQ5qPt5Mb/i0zTfZg2Mp/iBOSdKW8fCdZL0qPcC/EnF2iir1yK0Fn+EYQWhCaaddXID8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A3EC433F1;
	Tue, 19 Mar 2024 19:04:42 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf: starfive: fix 64-bit only COMPILE_TEST condition
Date: Tue, 19 Mar 2024 19:04:40 +0000
Message-Id: <171087507362.45404.9535094447088311477.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318-emphatic-rally-f177a4fe1bdc@spud>
References: <20240318-emphatic-rally-f177a4fe1bdc@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 18 Mar 2024 15:35:04 +0000, Conor Dooley wrote:
> ARCH_STARFIVE is not restricted to 64-bit platforms, so while Will's
> addition of a 64-bit only condition satisfied the build robots doing
> COMPILE_TEST builds, Palmer ran into the same problems with writeq()
> being undefined during regular rv32 builds.
> 
> Promote the dependency on 64-bit to its own `depends on` so that the
> driver can never be included in 32-bit builds.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] perf: starfive: fix 64-bit only COMPILE_TEST condition
      https://git.kernel.org/arm64/c/1d63d1d9e5c5

-- 
Catalin


