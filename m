Return-Path: <linux-kernel+bounces-149698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A29F8A94BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C74B22280
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7258F7D3E3;
	Thu, 18 Apr 2024 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CfI3djQ9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hqX/pD5y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E97D09D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428145; cv=none; b=fm8kEP9OhYRwornFOVr2tmAmqa5Ze2lew6EFHt76zJBdZCUJImE0wtwBpEZRtVYpcXJnI+Y0aTjTwcr9Amf5H0G5nfs79Hb8bSHHQNG2YQaQf4ULqZ3dzNRkfNlp6XHqtQijcLmzJYRZ8nigFZIQCFWRPgUs4abpaRqNgXfxmKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428145; c=relaxed/simple;
	bh=qY8TRHbiLoSHUrFJlfHVKJcw3NtPqKXWe31Pe1H3Baw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pKAM2FNlYxhmrsQ6cfTLEliG48QMQF3ZWlrE+wobeDKaB8HnvqrjcHrbPdsmK+3yMXRdDh2KZykCOHqZN9ZDeyYZ6jFoNjLuJOFR1h9oux2SCeonE1wMalzoSFdRprzjkYF3a7WVT9Huxep+5Pb+dpizPcrBAUrR5Cke2jujyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CfI3djQ9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hqX/pD5y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713428142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jz1FVXnzBhQzNKwGnVDyTSu0HUlDL4lpXefYzxrfaSE=;
	b=CfI3djQ9H66gwlyH++suK3YecM1AUrHF16mca/rkrGmdXIKqINNiM91OURPK6rsJ3jQupQ
	+ONTrFq/Zv4x5AEyzy1EAl4XQaE0XJCsTaMzNV6gCsInol5X8RQ8HQiUuHiaocqQUKV5sl
	k4IQUuoclTxLJ4PsjPLMZhzMVFLJiAHkVNG3gB6oL1pScxLrXcXqBsDyEFLYJq7pPh+hOR
	jDguj+a/zlMz43ZIqp2MJXEPzrXUq8Xn78GZG/XDvAnWsC5smKV9XcFFqDSIUUiIAlkn2L
	L03ueW8r+07e27qUckB0uNsDKNmmyaKtVZi0LiPnoEsp7dv4f7pcBZ6OnTdljA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713428142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jz1FVXnzBhQzNKwGnVDyTSu0HUlDL4lpXefYzxrfaSE=;
	b=hqX/pD5y7ny4iALP0lCcCA3HSRL9dsO3yPOw9wJAebVZ/z6qMy1wjebi7lC+JCG/oALajM
	ACjx7sI+H1ju8nAw==
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Abaci Robot
 <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] hrtimer: Rename __hrtimer_hres_active() to
 hrtimer_hres_active()
In-Reply-To: <20240418023000.130324-1-jiapeng.chong@linux.alibaba.com>
References: <20240418023000.130324-1-jiapeng.chong@linux.alibaba.com>
Date: Thu, 18 Apr 2024 10:15:41 +0200
Message-ID: <87le5brsr6.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> writes:

> The function hrtimer_hres_active() are defined in the hrtimer.c file, but
> not called elsewhere, so rename __hrtimer_hres_active() to
> hrtimer_hres_active() and remove the old hrtimer_hres_active() function.
>
> kernel/time/hrtimer.c:653:19: warning: unused function 'hrtimer_hres_active'.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8778
> Fixes: 82ccdf062a64 ("hrtimer: Remove unused function")
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>


Thomas, please apply this into timers/core (commit, that is referenced
by Fixes tag is in timers/core).

Thanks,

	Anna-Maria


