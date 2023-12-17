Return-Path: <linux-kernel+bounces-2613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF8F815F77
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBBE21F21DA1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAE34438F;
	Sun, 17 Dec 2023 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoOlbdvN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E61F44380;
	Sun, 17 Dec 2023 13:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B387C433C8;
	Sun, 17 Dec 2023 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702820476;
	bh=czOgyizie6+0WHtT+D4zbad4G/EaHbGm28IGylTfNsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SoOlbdvNX10qBzbXJxBRoqki5rDrAf96KVcZt5zXcOZDKWPOH/CLpGwUybxjn+Iu6
	 ZxcegYUrQcrR10vcUkbmn4j93xxX32cVfosBxzQ3LRjQxQHxYeYLPpV4FlVk2JBCOV
	 f37m9b8ao3ICMOTkahmlOAsyiA3UvcQ9vW/4dxhD/n9x6ndbAtGyHLpeaXmHiHBA6M
	 i4sxf/spSpUZnwemDhrW4YuxhBIN32et+lHh8zpF0TiqhwDYzMqKIREKMWR+AxBLM7
	 uoTQg1UMbLif2EhWg/EF5q55GHVtTr6P9vAlvb8hTlPcQvuySXSI7n+caHj2fcn/k3
	 ccQ5/ITP87trA==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	mark.rutland@arm.com,
	linux-next@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	linux-perf-users@vger.kernel.org,
	James Clark <james.clark@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	llvm@lists.linux.dev,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] arm: perf: Fix ARCH=arm build with GCC
Date: Sun, 17 Dec 2023 13:41:05 +0000
Message-Id: <170281440108.359132.7914631025593499836.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231215175648.3397170-1-james.clark@arm.com>
References: <20231215175648.3397170-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 15 Dec 2023 17:56:47 +0000, James Clark wrote:
> Changes since V1:
> 
>   * Instead of wrapping everything in #if, just use GENMASK_ULL instead
>     which fixes both issues in one commit.
> 
> A fix for the broken build with GCC currently in linux-next
> (next-20231214)
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] arm: perf: Fix ARCH=arm build with GCC
      https://git.kernel.org/will/c/bb339db4d363

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

