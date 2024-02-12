Return-Path: <linux-kernel+bounces-62359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DD1851EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E08E1F2355C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D64487A7;
	Mon, 12 Feb 2024 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fx6X2FZm"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5D947F7A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707771316; cv=none; b=ob9u6tYLAJEIrTuImoKzh+xVXthaQilAPNBIf72eZCCumdNGan9eiwRgss8rXGjj9VHcrJ9h9Eye5utFGkPPJPkcbQZpsgTYJKYYaHZ1WxJD4UHTcdklT1olieHLBbaIyI6OFeyEZncIvjNR6N0bvD6d07ITfcF4cxpC7kF/ELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707771316; c=relaxed/simple;
	bh=hYrwD2jyM1YoV8NSAy83Vgp5NfJRs9jP9j3gkH0cboE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rtxipgbr9ww+tt4QdpOha+msgWKdGqpxtnjQ1jOeN+0lWBOVTJ+yPGzNJO8MMBLaSACVnvUNjFdeQbPs+u/3EAduK/SBWYUIQqGBgwmnZX/915Pkipw54irH5D9b5m7mB+PEFneziw0tDZ3XqaQmG2uZuc9KfSrQZj31XG+HYU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fx6X2FZm; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 12 Feb 2024 20:55:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707771311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jg+S1eA0mQzeAlYCXpsQrlGlqFnthigQE9V3fAICXlU=;
	b=fx6X2FZmzNXQV2YECP4e4BbYmms09hnPPo30mpZJ6dQkvs0BcZBOrPY1HgwJKFD2nfrPMP
	tfrP/TfFxIvrJUc1UUnxCWRPH56IsEQfyDm8IB5xrQ3H3vHDyKRL92mPMwhW6mixiJP4qM
	g6ZzuPUSdy7kXr1jGEC9gi0RBBVzSKA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH] KVM: selftests: Fix GUEST_PRINTF() format warnings in
 ARM code
Message-ID: <ZcqFpn9y4eHfkRJX@linux.dev>
References: <20240202234603.366925-1-seanjc@google.com>
 <ZcqEk16eBKovb-hb@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcqEk16eBKovb-hb@linux.dev>
X-Migadu-Flow: FLOW_OUT

Dammit, forgot to actually CC Anup. I'll blame jet lag.

On Mon, Feb 12, 2024 at 08:50:38PM +0000, Oliver Upton wrote:
> +cc Anup
> 
> FYI -- this patch is touching the arch_timer code. I did a test merge
> with kvm_riscv_queue and there weren't any conflicts, but in case that
> changes this patch will appear on kvm-arm64/misc in my tree.
> 
> -- 
> Thanks,
> Oliver
> 
> On Fri, Feb 02, 2024 at 03:46:03PM -0800, Sean Christopherson wrote:
> > Fix a pile of -Wformat warnings in the KVM ARM selftests code, almost all
> > of which are benign "long" versus "long long" issues (selftests are 64-bit
> > only, and the guest printf code treats "ll" the same as "l").  The code
> > itself isn't problematic, but the warnings make it impossible to build ARM
> > selftests with -Werror, which does detect real issues from time to time.
> > 
> > Opportunistically have GUEST_ASSERT_BITMAP_REG() interpret set_expected,
> > which is a bool, as an unsigned decimal value, i.e. have it print '0' or
> > '1' instead of '0x0' or '0x1'.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>

-- 
Thanks,
Oliver

