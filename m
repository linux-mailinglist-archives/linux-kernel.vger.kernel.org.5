Return-Path: <linux-kernel+bounces-125671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71150892A66
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFBB8B21DA4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD29364AA;
	Sat, 30 Mar 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMinF1tH"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE62C6B2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711794499; cv=none; b=dLs0Bto/oAik4Yo0/5QFkUIxrEWnvlKo9ez8B2iG8ivSJZUwSy3605MqNIyb5ZGznJFGNB6H597MLmsPfBHgC2EiyMzgxV+r6vwP56RbPVPPaA6d/d3WwfJ7rG/togiTHbx8rLXjwMd+lTBb/c270ZXuXhCQeba4+8PzhRX9V9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711794499; c=relaxed/simple;
	bh=goxT1F0OOUgc28Ie03t52iaMBH6QKyd4Cb5c+kC1eBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezhhjlYnGi4/jCK3y5IE0OL8ky6bkgKq3MU4BXhlELuCY+7avmKHOhwdjclHTkUXQ1jcOTSYfB6By6XeO7eqaP0RPdtN+eTfl3E6Jq7LU+fE+RrrMdzMv9EYEPSdp4PvPHd8lU/bB0cJ+iYc5qN2f1hQ58QH6AL4/rAOmK8QE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMinF1tH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c08d1e900so2986063a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 03:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711794496; x=1712399296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uShT+txdGXzCe5qZzKrUtpznNyjC6YyC/AXKXaNev4g=;
        b=kMinF1tH/g3YDIOlTTKnSPnbaKMPOoq/ThQ5VGVD9Tly+PiGGjgLjCWUa6Ao9CK7dP
         aKG5OpXEK8/ZovmJHTe18jlFPTrKY9olV2ZqjgQxi3lwQ5IKFQKUc2CoIEjRGDpELs9p
         y35yoEGmuzSKuYFnrBDiYSQ9m3D5u7kApSDEUl+VR9Lx+azIaRd/PfDRmA0a5zjuMJmD
         yzOf+rwneskUl+x48O7NmnN9YNaR1l52prA0bcKK9PndfUiD5QbIYJ1mzEqCsntkyQHJ
         0psRk/8jpT3B6aXdXPanq8inDK4cC3tFbN21gtHiPM28dmviZNzPT77ykzMROfc+E5pg
         z/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711794496; x=1712399296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uShT+txdGXzCe5qZzKrUtpznNyjC6YyC/AXKXaNev4g=;
        b=kEAlkbVeegKVhe2k7atCHKp4xJVoqiowxBwrs7Jgm1TjZRW6y/5Yjf4PsJAWk6a4sh
         3XiPLyUEXrskkZjVNaLW87un1U2llVAn4bcZhYepFbUIjQwrepSay1aEhzwEchD1aqq0
         w47/3VH2a/UB/vYOSIJZ1hSgJSuPbqyU4a9h1II0yCNmrLDg4sOsuJQRKuEYp7qXDNzS
         KGmcm9shNgLUF1mENTKuhawHipSzx9pQGcJY74rUEKaI3m2GrnWF3ZdsiywCtz7ZGSOP
         GrXIDgVaO9z4N1XFayUybR5zYK4Yap5HQVKW6GJU1aLjxmbVpKF4fIfpe9CtWDi1HDC0
         Km4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXA6enQi30HZRxiPzMTzwuyyQuGq0swNjfwWHrndLnXBSCi33XbmkCBMZYoJis7ersI9L8/P5D/cxm3iDxNOFrS3Q6qLN64dRithaLF
X-Gm-Message-State: AOJu0YzO3j0Xp4LxmRPA+CML5cHpPjCDfjn3kV+2N3Zgw3D8je334l7y
	XUcy/lasRbjq1UTni5XQDto1nHuGP1TPKnHE0bOkXKBqewU+rGb+
X-Google-Smtp-Source: AGHT+IE1XCc3NzNn7sOVmCIexBN6QzbUDRQqdTy6+1IuzdTJ/6qbI8pp90mZq27FHdh/CdWr51Edeg==
X-Received: by 2002:a17:906:4f82:b0:a47:2d4f:6fad with SMTP id o2-20020a1709064f8200b00a472d4f6fadmr2884236eju.39.1711794495588;
        Sat, 30 Mar 2024 03:28:15 -0700 (PDT)
Received: from gmail.com (84-236-113-97.pool.digikabel.hu. [84.236.113.97])
        by smtp.gmail.com with ESMTPSA id u8-20020a170906b10800b00a473774b027sm2927305ejy.207.2024.03.30.03.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 03:28:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 30 Mar 2024 11:28:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: wenyang.linux@foxmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3] exit: move trace_sched_process_exit earlier in
 do_exit()
Message-ID: <ZgfpPFYmvSg4WC+c@gmail.com>
References: <tencent_F5D82FE0B9A0CA9C3A29C866F225FD915905@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F5D82FE0B9A0CA9C3A29C866F225FD915905@qq.com>


* wenyang.linux@foxmail.com <wenyang.linux@foxmail.com> wrote:

> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> In a safety critical system, when some processes exit abnormally, it 
> is hoped that prompt information can be reported to the monitor as 
> soon as possible.

If this event is so critical to catch, a probe can be put on do_exit(). 
This will be superior to your patch, because it will notify about the 
event even sooner.

> Commit 2d4bcf886e42 ("exit: Remove profile_task_exit & 
> profile_munmap") simplified the code, but also removed 
> profile_task_exit(), which may prevent third-party kernel modules 
> from detecting process exits timely.

Could you point out an example of such third-party kernel modules, and 
why we should care about them?

> Compared to adding an extra tracking point, it is better to move the 
> existing trace_sched_process_exit() earlier in do_exit(), since any 
> tracer interested in knowing the point where a task is really 
> reclaimed is trace_sched_process_free() called from 
> delayed_put_task_struct().[1]

I disagree, I think this scheduler tracepoint should be moved even 
*later* in the exit sequence, and be combined with 
sched_autogroup_exit_task(), so that the scheduler only has a single 
exit-notification callback in essence.

Until this is all done cleanly no tree should pick up this change:

    NAKed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

