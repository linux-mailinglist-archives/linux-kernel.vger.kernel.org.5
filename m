Return-Path: <linux-kernel+bounces-75287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBA285E5E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0045D1F28438
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E2986AF8;
	Wed, 21 Feb 2024 18:24:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8806886642;
	Wed, 21 Feb 2024 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539858; cv=none; b=al3yCqwkb9dV/Z2fa1AOHxhqBerDN+ps2TfZVylXrwzSH6QdhZlvd2leJpmEEwCaRb6XfoIaiL4stB2p9FFBL4Hw8KFmsnyprEwgpeeSrPCVNFHlMvG34mW2y1gis4RB79+xKi6OgktK0y3H4f64cUCtJQy/1YvU10BIId1y/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539858; c=relaxed/simple;
	bh=SsWq71Y+Cr6ascOJFNfzIYlN4LosdqEOLES2wgxhEgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkdVZjKRmAx4Gs/J9hSJAABm+yKvtIUIo46Ws2P5mjWET4l72jr3lMnyiYk/ddv2j+UJc8N2NEboKktSAxMw/ZyXay6hSCSD7URaK9yKrWSCIRjd2I/ohYf4dBWghkYzNTofwHSJjz50K69IysGB8JgXii43JDo/+POVOrYOxQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8299BC433F1;
	Wed, 21 Feb 2024 18:24:16 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Dave Martin <dave.martin@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Test that ptrace takes effect in the target process
Date: Wed, 21 Feb 2024 18:24:14 +0000
Message-Id: <170853984971.1222572.14523924916832010338.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122-arm64-test-ptrace-regs-v1-1-0897f822d73e@kernel.org>
References: <20240122-arm64-test-ptrace-regs-v1-1-0897f822d73e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 22 Jan 2024 21:05:03 +0000, Mark Brown wrote:
> While we have test coverage for the ptrace interface in our selftests
> the current programs have a number of gaps. The testing is done per
> regset so does not cover interactions and at no point do any of the
> tests actually run the traced processes meaning that there is no
> validation that anything we read or write corresponds to register values
> the process actually sees. Let's add a new program which attempts to cover
> these gaps.
> 
> [...]

Applied to arm64 (for-next/kselftest), thanks!

[1/1] kselftest/arm64: Test that ptrace takes effect in the target process
      https://git.kernel.org/arm64/c/c745b15c1f9c

-- 
Catalin


