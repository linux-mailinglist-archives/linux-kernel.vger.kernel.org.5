Return-Path: <linux-kernel+bounces-79467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C17F68622A3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 05:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38F6B23A11
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 04:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F51171C8;
	Sat, 24 Feb 2024 04:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ssRcDIyG"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8F4414
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 04:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708749610; cv=none; b=WCZjCYXtamrYsfQt0nE9qSuVqeqJrNLtfsGmlfwGKWVdooaqmNwGp8ExYMtYGOboE/+x6nnXz1H7LB6h3hYkQwmuz9oasSVFvTAmqB98ImHMwQm4bDe4EA2EZRaphq4uOka7yvJiamqsCgb9RB7F0foDUET2Qy4q/qPxHegqUqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708749610; c=relaxed/simple;
	bh=zoqMpwnFsGkBh/sRDdECm4eJ8KKnOivu3YrPBj84JVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gg6/lm64QQaTXi5XAtdFoC4fcKPEx73/0ED7C4Zf5SKuyGdF1ejN1Jye/6rC4FnOOymz0qoFl3YOc2JTsSUV36tHk7Zyr//mPRs24ABsiXaDbTtdqzDk6GFY1W0VZuOOPPlb9xKUuMK6PfclacrbqHKB1X1Ugv8OC90P7/pMA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ssRcDIyG; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2cd87332-b3f9-e415-6458-57eb3615c43e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708749606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbH2yQi8V2/4J04upwXVMsEwYXEoMfqMqtz2IJ1i/Lk=;
	b=ssRcDIyGPEfqOOGtmp+JiT5miQaMt+ZWaNkR0+GRxu1U9hjba9yC2Qbv2wLJWYFJtceGwF
	jYVsGHfdW216TnhyJW6nAavLlXt8lprzCIR6OPocNHthQfPaR6NwtBx8xhG9nzdOGGg325
	0R2Kq2wns/e6U2i/fUB5kM+kOebH+Qk=
Date: Sat, 24 Feb 2024 12:39:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5/8] KVM: arm64: Fix typos
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev
References: <20240103231605.1801364-1-helgaas@kernel.org>
 <20240103231605.1801364-6-helgaas@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20240103231605.1801364-6-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/1/4 07:16, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos, most reported by "codespell arch/arm64".  Only touches comments,
> no code changes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Zenghui Yu <yuzenghui@huawei.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.linux.dev

Oliver, mind taking it into 6.9?

