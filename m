Return-Path: <linux-kernel+bounces-54682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB7984B266
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239F91F2410F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DA712E1E3;
	Tue,  6 Feb 2024 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CIwIaf1l"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EE812E1D8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214872; cv=none; b=gtH/2V/n81W18A5KMNwhehD6niG8rAHhowrq1nNiJG6Kid1ORA5ge3J/Bwhy/Fa8CybXKxdIVYrbEINE/KTAr4DtEKZCZy2egXPf+IrSCIQJolph+mvMmjuXWUFxF4+Igz6nlDjw+DkwZlPuhRQiD7Li/TCqa5O/udyCouSYVhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214872; c=relaxed/simple;
	bh=zkrm7vWjb5TlNLl6ut2ZcpSsrkfaKSqBjDIajS6sOaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fcfd/IbUw9zUWqd/iKmvrVgJGdV5+IEfTfpfIHUNs3+kKxFlA6hJYweE56cstTlFBYBQXLtPU+0XF+g6anQOp6mY4aeuLivLYMHmVE8HJEqj+kG3fEX7j9NUlwSmT1D4AQHlWjT0jMuvkvOpxqwMaWLaAbGISateBHpCsjVkro0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CIwIaf1l; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-511616b73ddso65615e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 02:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707214868; x=1707819668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddGPB+LLLc9/aN93b+elzzc4F9rC5w8WyII5OFv7+Lg=;
        b=CIwIaf1lQrjXkybR4tulB22dRdpnhmjkUhxyPYr/ySIq7xMIFE3bYnXAAY+gaJ3mv7
         ornldEa0tEs2PTHqXEco+mggxPZBhM7FXwhqc9Bb5JJ0peJCPzBKZWOeevQ5sA2Lw3IT
         hQhjzuHxVcC71e8XRcu+ewgUI9EE3GNYriJFUPiovxPGNjNR6Sp3bdjrLeghwF72Rctp
         rp1OYC+GsYxpVEySUnOoM6AJ5wTPOS71sdT5aD6AFGIKuOn9v4eTF8TGsfCB9bgBMZvE
         o/9SCPkkk7TnMp5cFS6Z8XemE6iUB554N8fe8h7mK5BKzU6YKN7Apj9rDxBemSH5aa8r
         izhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707214868; x=1707819668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddGPB+LLLc9/aN93b+elzzc4F9rC5w8WyII5OFv7+Lg=;
        b=jwMpWzMdCes+5YIzwrIVVshtOQIdox2h0XT+t/hMBLsvsMDoLl0FL9BKnBywKW95dI
         Xu6VZt8WVwlmlHRDaW8mBFrdkchyhDRE2gwJzZSye/tXZVVFj7P0Uaeeti6q7swtf+t+
         FXBN0byb0QAiFdiCZFKQa+ZQgq86bAKUGmsGccT+m/uFCA39l5TptEVfDT2y3k5dBCZB
         ESHgXeTll1yDFgCYYvaMO7eqmq5NS8oAnFEOF639d7FkzyKLnpcFR21ukRKtBqMyUYVs
         yQosSLDw3XaxwJwdXlrfPZTUpC4JdKGJXTP/SaMDymZFjh+VjDIjUS9DB8YvU4UY24Es
         L5Yw==
X-Gm-Message-State: AOJu0YzdPTOa2zNw8bqTyNWerh6Qx8Fym/wBvnbfsFPX/CoGd5AoIV0L
	Vv6eFAhSAjdH94kR2VOgtCAGrSTvXG5C9k4ADF0sNbFsUfqlV1Wc/v9ZJzlUhOM=
X-Google-Smtp-Source: AGHT+IEnv5j1Olls2cgZZ9SzUTxfs8lwblvAGT/whC57OaCwavnO6FnxSuG1NGb00K/WCEof+Jm48A==
X-Received: by 2002:a05:6512:2091:b0:511:46f4:619b with SMTP id t17-20020a056512209100b0051146f4619bmr1258782lfr.22.1707214868107;
        Tue, 06 Feb 2024 02:21:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVLKKcBDpGTIyPEMV1ib/i/xPTMMLGy/Pf36OYW6TEme9I66HSsHPN+8TGGODltNTpe7AW/G+TyiSMxMeXjnpdpRcgsG71bcCzDt0lKnw5ewjZKMV105goPJyJgYJagK7DS3Rpf6DgvDLgujEeZ49e6JlR0PfrxnP1g9+0LSlXNr9reklxyEW6XYCiLLpjPCkbJItNQWjzF/UrhLjCBXjYoAq2mepouPdmNH47/log3+F8=
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id sn24-20020a170906629800b00a38382c34c9sm333674ejc.120.2024.02.06.02.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:21:07 -0800 (PST)
Date: Tue, 6 Feb 2024 11:21:06 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Zhe <lizhe.67@bytedance.com>, Pingfan Liu <kernelfans@gmail.com>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] watchdog/softlockup: Use
 printk_cpu_sync_get_irqsave() to serialize reporting
Message-ID: <ZcIIEqBbNyLt-ybx@alley>
References: <20231220211640.2023645-1-dianders@chromium.org>
 <20231220131534.2.Ia5906525d440d8e8383cde31b7c61c2aadc8f907@changeid>
 <87le9mk2iq.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le9mk2iq.fsf@jogness.linutronix.de>

On Fri 2023-12-22 10:36:37, John Ogness wrote:
> On 2023-12-20, Douglas Anderson <dianders@chromium.org> wrote:
> > Instead of introducing a spinlock, use printk_cpu_sync_get_irqsave()
> > and printk_cpu_sync_put_irqrestore() to serialize softlockup
> > reporting. Alone this doesn't have any real advantage over the
> > spinlock, but this will allow us to use the same function in a future
> > change to also serialize hardlockup crawls.
> 
> Thanks for this change. For me, this is the preferred workaround to
> best-effort serialize a particular type of output.

I agree.

The good thing is that dump_stack_lvl() and nmi_cpu_backtrace()
use this lock on its known. Also nmi_trigger_cpumask_backtrace()
prevents parallel calls. It means that the particular backtraces
should be serialized for most callers.

> Hopefully one day we
> will get to implementing printk contexts [0] [1] so that message blocks
> can be inserted atomically.

I didn't think about this possibility. You are right. It might be even
better than the printk_cpu_sync_put_irqrestore() because it allows
passing the lock to a higher priority context and
supports timeout.


Best Regards,
Petr

