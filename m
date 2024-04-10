Return-Path: <linux-kernel+bounces-139150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3DB89FF25
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A2C1F2170A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3261C17BB17;
	Wed, 10 Apr 2024 17:52:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62FC17F372
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771548; cv=none; b=ZgmsNqU+YY6SHfiNHyLnr5YOpmEwZDSfQxWaweo+rXXVSIGejMami9NL7iiBN8yJ0Uy5bGkE5xDJ4fAhp2jSw9Ujk5CQHXqKbTuWVE/9DSckOPobbMBDp64Bu3lz/FhMIYQNevnIm1hDprUkVjon3S3wcAcNE/jPjHxmkafpY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771548; c=relaxed/simple;
	bh=r74J1YWY8DiVppxzccI6gmjsglpX+WZcxHTlWlA/g+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bScnHNlWVcxnBpYTb7QsB9T9wcm/0hJWLJmgICT4jCGIemfBNBIj11c/h0yJYnEtCO7QK/Kvzjxg9GbI5M+w6EDFBU3f+Gy1RXiPiQ8kSxrCZ0wfpjKkCM0LYpq2DVULYEtoq9hALVn7TQ4XM3hxzL8M2Z67PS/7TmX1gcalTEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A7CC433C7;
	Wed, 10 Apr 2024 17:52:24 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>,
	akpm@linux-foundation.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	ryan.roberts@arm.com,
	apopple@nvidia.com,
	rananta@google.com,
	mark.rutland@arm.com,
	v-songbaohua@oppo.com,
	yangyicong@hisilicon.com,
	shahuang@redhat.com,
	yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: Re: (subset) [PATCH v3 0/3] arm64: tlb: Fix TLBI RANGE operand
Date: Wed, 10 Apr 2024 18:52:22 +0100
Message-Id: <171277153440.43830.14103365364273705175.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405035852.1532010-1-gshan@redhat.com>
References: <20240405035852.1532010-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 05 Apr 2024 13:58:49 +1000, Gavin Shan wrote:
> A kernel crash on the destination VM after the live migration was
> reported by Yihuang Yu. The issue is only reproducible on NVidia's
> grace-hopper where TLBI RANGE feature is available. The kernel crash
> is caused by incomplete TLB flush and missed dirty page. For the
> root cause and analysis, please refer to PATCH[v3 1/3]'s commit log.
> 
> Thanks to Marc Zyngier who proposed all the code changes.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/3] arm64: tlb: Fix TLBI RANGE operand
      https://git.kernel.org/arm64/c/e3ba51ab24fd

-- 
Catalin


