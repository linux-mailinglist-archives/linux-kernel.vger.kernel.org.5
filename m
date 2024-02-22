Return-Path: <linux-kernel+bounces-77442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9D5860564
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3401F231DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C643F12D21D;
	Thu, 22 Feb 2024 22:05:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C37112D21B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639526; cv=none; b=kkfJ6hkrW/JFsG6LciXB94/MX71RFts3pSiXl8N+L2pxWR7jrzoUNoWQA5plbFT78tl4eGRVavY/ese3d2HJskvUEyr3hAnV+CZ55zecF0FdkN7cCsOxeqpP/TxLnbWzKD6nzzfh4OhNDuO2HVhG9p29k8YKD/whjAMFIhGEM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639526; c=relaxed/simple;
	bh=+mZhHWe7xSKT8W0e3WXpAxvn0hKPCW1nUJ0c++/2jew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKLcGNLDI75cNAXBSPDdYUV2zU0kaQOlWFFhX+UdmkZMxikYJyrISvS7W3hmQIofZFHex6IVOPgbCMHaTxN7SI4DojESEmajskdBxQAB5VBXQnaY3CJzb8yTl52r9cx68wEc293X0Fz4irNnKINYGqKvUEc27vmD4Wncibu5JcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1156BC433F1;
	Thu, 22 Feb 2024 22:05:23 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Cc: mark.rutland@arm.com,
	mcgrof@kernel.org,
	jpoimboe@kernel.org,
	j.granados@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com
Subject: Re: [PATCH] arm64: remove unneeded BUILD_BUG_ON assertion
Date: Thu, 22 Feb 2024 22:05:21 +0000
Message-Id: <170863948630.1616990.3978730044792626566.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202040211.3118918-1-dawei.li@shingroup.cn>
References: <20240202040211.3118918-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 02 Feb 2024 12:02:11 +0800, Dawei Li wrote:
> Since commit c02433dd6de3 ("arm64: split thread_info from task stack"),
> CONFIG_THREAD_INFO_IN_TASK is enabled unconditionally for arm64. So
> remove this always-true assertion from arch_dup_task_struct.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: remove unneeded BUILD_BUG_ON assertion
      https://git.kernel.org/arm64/c/bce79b0c8097

-- 
Catalin


