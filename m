Return-Path: <linux-kernel+bounces-49581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5490F846BF8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119CD282550
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B567362816;
	Fri,  2 Feb 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VfPegHhC"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AFE5FF1C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706866238; cv=none; b=SBRmUDLoBgAs9xxt07JD3s3Az34BpotWOL2n/XiptOmsUcbuSaqTIG0SvxD86E37JmegWH2k3myDPyAKA/0w8wqeUOR8/gSwwFbE+EGf3oZLEM62JZuVXMI0tZpSuDPQIuSK48YjH8wYP6lJfD1tLXMN0YksY1sxLdnRpSr8u/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706866238; c=relaxed/simple;
	bh=p+46TvqdAXhckULFfAYGbT/ZoxUcLwUA59HHYSNSI+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSJZt8QiX5D5b0TFJhHJMEMv1DIG3fxnXTMoc/WPbowWKBOoUzVNhjrGCpKR7eFJwOQEinm/ret8fkw+8vNY5RSRB04BlkYU9zprZdUxVYbC347R2BGKGR5u+K29orgIGeCji60xGSawVL2yWJ8bzJnDfHkPRm3iJwTX4/4EhPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VfPegHhC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55fe4534e9bso963345a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706866234; x=1707471034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IYeK0EDaQICtIyVFt0QKH6yvhcCuAyaNDV82FqVf0lw=;
        b=VfPegHhCB0xivd6IauGZQtYc30S/AF5DaO9Pu6LFQHT0pmNOSYj8IvjJXZf1pJe6Qh
         ITslgT9lP4halIWXPztezLVtQIQpi4X0RdwiltUzuz9UkMD2KEzvTRNO83nEb8CwvxK0
         nrCUvNXsbcgK5QfKqUXOWa3qibwyV3aKEEIA/ZC+/BK4OitJA3EDUuLLi5yS71YhEUr/
         zdNjoRPmCYyF5nZE4TtVRvd61rUYdYmhgcrVhOIzKN10uRDI1PrQNXqSC9UYtDDmg5Sl
         QaYhczn+GqvVo7qpV5y1s9926r6S/0BMMTNhwx/fJAoVYDR+yJmm8We5u99N3KyaorZz
         gtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706866234; x=1707471034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYeK0EDaQICtIyVFt0QKH6yvhcCuAyaNDV82FqVf0lw=;
        b=A8oytHPbzo6RIA4i2IMZGduT0k/qsvYhaf0Lv16EyehCRqm62/bWjB693RvWk8ZeBe
         e+QzJYZVmYkz74n9AZ1W2fO05BqTHobDyTQUe+KhBeCzgqc0Qs1QfSFAdQcJK9f3M+YV
         liq0az9zRVYsk4YuCNqSnTpD1WcsomsincJ9rmd58dtZullJZWbDDjy/yY5ltfoFGS0u
         jJgrCe/k/9QIW7ZobGwPPwJMxvqrGEQfx7e6lEf0V0JJ0Ykruo1YO9EimARW8c5XmLrm
         bubUS38SxobRglxuFu56BLURUjwBUgtxxeeHY3c8RtMMYWTrag44Xj/9szjXrC5CKIv5
         8/jw==
X-Gm-Message-State: AOJu0Yzus9ooMZKiRrUcXHX17HjXxE3loKiznUIH4q5uB94M1A+AaEBr
	UOS8h/pBV0+MkvdgghR1RszY628uMFhObtEZkXVy8xLaJKeQPhiRsnBA/HO/wok=
X-Google-Smtp-Source: AGHT+IGRY8JbTgF32ql92Dpu+p6VA51ZOsWyjx47Nd0zPvabbpsoxpRo4JjSR+rIyB9K+cFyOAeSEg==
X-Received: by 2002:aa7:da52:0:b0:55f:d93a:2efd with SMTP id w18-20020aa7da52000000b0055fd93a2efdmr955881eds.17.1706866233980;
        Fri, 02 Feb 2024 01:30:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUG+PCHIrw8JbXLcb+MRMESogvzunfCB4yL3zmcuq9LmZWz2/wd76x2ix2sWPPtlr/PPdzL0UYAJ8jCJZtS8+bSAtfHAPL+piQ0wH8yEidz31N4q/Ki5MUqQNeRQ08burNF91YP0IJR9wgVYs6lZ5bExjMTabiBG+R1vUfyKL8OsII7rCfJGOcH9StHZIR0NHfQv+8AZ+2toKJMwNDUTyJmg7U0cpB+0J4n79T/cr1DG7CE384jSUoE/MRxsL7P0WSkkTQFWKPVQaBMA0OhqWeg3TgmpoRIMcpgOWvqcrc7PXqFkfBsYeDo9y/84x8bnn4uirAmJ1EEHszaCm3B2ior24bDx+oC9pFuiGqYD4jAJXIcyYISsKHXz/VXU1LieQLYsP5KjlnuSgMKq85UtSCfRoEI87Az9g==
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id es27-20020a056402381b00b0055c60ba9640sm640504edb.77.2024.02.02.01.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:30:33 -0800 (PST)
Date: Fri, 2 Feb 2024 10:30:32 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kees Cook <keescook@chromium.org>, Uros Bizjak <ubizjak@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH printk v3 14/14] panic: Flush kernel log buffer at the end
Message-ID: <Zby2OLaFFrob3BMl@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-15-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214214201.499426-15-john.ogness@linutronix.de>

On Thu 2023-12-14 22:48:01, John Ogness wrote:
> If the kernel crashes in a context where printk() calls always
> defer printing (such as in NMI or inside a printk_safe section)
> then the final panic messages will be deferred to irq_work. But
> if irq_work is not available, the messages will not get printed
> unless explicitly flushed. The result is that the final
> "end Kernel panic" banner does not get printed.
> 
> Add one final flush after the last printk() call to make sure
> the final panic messages make it out as well.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Makes sense.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

