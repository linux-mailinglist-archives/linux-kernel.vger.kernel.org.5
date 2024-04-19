Return-Path: <linux-kernel+bounces-151760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 335E58AB38D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B548CB23B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF461134CF2;
	Fri, 19 Apr 2024 16:44:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437B7132800;
	Fri, 19 Apr 2024 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545054; cv=none; b=M2G9rsptJsNJ1Yh/LHa0jlmV6ZsDSNT25jWWDh2Sf/vRWTPE+ZggV1L2j3J2qVZJq6ZjlGwAnWHwZ3YSTJdAIgPJQAUgdHvdMnnGiE051M9FeakwAYpMJqmUVp36/QrYQSIE6o6+AX/wyvKFxdfOpIsrancGlGhXD1m3CnkqGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545054; c=relaxed/simple;
	bh=g6dfOkD7e/Rsui1E9vwCOjhb2lg0fOpMCgFt3OAgUNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6djVsazQpWQmEpTTwN5fz41S2HbPYD7Qb6Pz3MWmn4H4L+5RmrlMiw9g9MVH9bq47tMeOkYea+6JjJ8Zug/fxD2ft+7SJioK+TTxv0OYAsnkhijVgb4dJ0xduarjteapV/rsrXpjWdMTfTut3inP7ClyZOO1merMeV50M/Udjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3AEC2BD10;
	Fri, 19 Apr 2024 16:44:10 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	rppt@kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	akpm@linux-foundation.org,
	ryan.roberts@arm.com,
	wangkefeng.wang@huawei.com,
	ardb@kernel.org,
	david@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	xiongxin <xiongxin@kylinos.cn>
Subject: Re: [PATCH v3] arm64: hibernate: Fix level3 translation fault in swsusp_save()
Date: Fri, 19 Apr 2024 17:44:08 +0100
Message-Id: <171354500626.1387030.2608430533776260920.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240417025248.386622-1-tianyaxiong@kylinos.cn>
References: <20240417025248.386622-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 17 Apr 2024 10:52:48 +0800, Yaxiong Tian wrote:
> On ARM64 machines using UEFI, if can_set_direct_map() return false by
> setting some CONFIGS in kernel build or grub,such as
> NO CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT、NO CONFIG_KFENCE
> NO CONFIG_RODATA_FULL_DEFAULT_ENABLED.Also with setting rodata=off、
> debug_pagealloc=off in grub and NO CONFIG_KFENCE.
> swsusp_save() will fail due to can't finding the map table under the
> nomap memory.such as:
> 
> [...]

Applied to arm64 (for-next/fixes), thanks! I tidied up the commit log a
bit.

[1/1] arm64: hibernate: Fix level3 translation fault in swsusp_save()
      https://git.kernel.org/arm64/c/50449ca66cc5

-- 
Catalin


