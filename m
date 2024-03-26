Return-Path: <linux-kernel+bounces-119097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3630F88C41D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D231F6487A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF63182A3;
	Tue, 26 Mar 2024 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rbd/ueJt"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA01745DC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461036; cv=none; b=fHNOwz1sljHHMAgN39z/fvNhq0SxYv7w8/rFYiszWf3lHJsbQYx9Wzvmujbwkk+yolChbtWxKUeYRLGCV3p8N0/3S7oNKw36aKDji5qF8T4iKiUX5uu72QHDVja7Scai1zp4KS+tGzQvLsSgIW+jHEYgc0OQH7aD8WVwNcUe6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461036; c=relaxed/simple;
	bh=UvgaFUdgEd5btHJhSoBF6U+YeMzaKzxOEAJfVOIrDVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EST5Yd0jaKhp5yg81L4sTrwE5ib364+m2GfBty+EiE4shDra+g0DWFwHBiWYCM+50HhE8cP6gBgAHZKjSnb3jnocIiEhidDNbqvDd1kR0B/s7cEtHThrC+d86ZvWKswkSRRbUhj5ZFXl1TB9SgAIMwE3HPDcH9xLtxn4uFeQHNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rbd/ueJt; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711461033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ER674FgMuP3svanXhflD154bVOzHodoCfzGEp691dxI=;
	b=Rbd/ueJtGYzkdg7rIMpuJprqXiuOJUqqV7SpbejmsB8DwjI7NZcDnLOe3ye/tK/K1m5RJ7
	I0ucwcJiz8YlxqX5yJIuXqY3SRQyMJQz3HFwQ/NSqZwl8qbALUsF9gxZWAfiPXXOz7J2Av
	wOh1z/ezNq5bdy6yhpCF0biahr/74so=
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Fix __GUEST_ASSERT() format warnings in ARM's arch timer test
Date: Tue, 26 Mar 2024 06:50:06 -0700
Message-Id: <171146096643.372204.13848070547978765288.b4-ty@linux.dev>
In-Reply-To: <20240314175116.2366301-1-seanjc@google.com>
References: <20240314175116.2366301-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Thu, 14 Mar 2024 10:51:15 -0700, Sean Christopherson wrote:
> Use %x instead of %lx when printing uint32_t variables to fix format
> warnings in ARM's arch timer test.
> 
> aarch64/arch_timer.c: In function ‘guest_run_stage’:
> aarch64/arch_timer.c:138:33: warning: format ‘%lx’ expects argument of type ‘long unsigned int’,
>                              but argument 6 has type ‘uint32_t’ {aka ‘unsigned int’} [-Wformat=]
>   138 |                                 "config_iter + 1 = 0x%lx, irq_iter = 0x%lx.\n"
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ......
>   141 |                                 config_iter + 1, irq_iter);
>       |                                 ~~~~~~~~~~~~~~~
>       |                                             |
>       |                                             uint32_t {aka unsigned int}
> 
> [...]

Applied to kvmarm/fixes, thanks!

[1/1] KVM: selftests: Fix __GUEST_ASSERT() format warnings in ARM's arch timer test
      commit: 29b0075ed61cda250449f556fbe007a5c469440c

-- 
Best,
Oliver

