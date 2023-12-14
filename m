Return-Path: <linux-kernel+bounces-72-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DED813B91
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CA51C21B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557666D1AC;
	Thu, 14 Dec 2023 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LZbaDfiG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADA66A35B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a1da1017a09so1033487966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702585977; x=1703190777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u2BdSCgUChjTXVvCDYH0x028T7FO0mEYayRY84Xmsbc=;
        b=LZbaDfiGbvu7scE2g1l/Bh72jZvSMAklZE/D2t9JVQf6/i0SDxJHWQLEUHsILsPSEN
         HRsgberVcaU2uuaDqGm9nKgUeWKMFw2X3gDGC4wN+mEXrUsSK7FmL/lal4EgZRtnSEWy
         BSAvFmNjAhn29An4WA5Bk91v0+u2nz7APQZpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702585977; x=1703190777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2BdSCgUChjTXVvCDYH0x028T7FO0mEYayRY84Xmsbc=;
        b=FpIZ9NSbQYEJirfbJQJ3IVoHUfuLLdsY9hO6WcUk8xxtmHvPOhbd7tOw4ZvJQPfsPF
         wAtkftVUyCt0VVZZiH9pwh45B46y3wM2Rsnwe+PEqLF1n2yiCh1QRVMKN+CO+dw1lCta
         f89i+A9lGKV+F4o133LM5TNLWSiN+GCwVmFNpPothAcLbx9ATeSNF7TcwrHWfEheyORy
         41kk0kYKYIHzPAsBUDRv6mgOAE2tjUacmt7GjevAHVBcSDK8REg2AXKF1T46H56NHFfI
         lFhoX3cfrtXh8lAvn4mxRCxJzj/H7reYddDVcxkgvTkgRTH1owQjFsbvpVckXI1Y+aag
         GpBA==
X-Gm-Message-State: AOJu0YzR7QGSawGnpzuBY1x44EytpKADhAo/MCOAcltOdUZqBiAYttmF
	qZmutlGt9M1p/0RsxEF1IZ/15GdH3qAczLtBYH5MkH8+
X-Google-Smtp-Source: AGHT+IEG2nt6Jdw08ajO7Z+Itxt5yed+084SSMFewcitOAr2dauiCRDxJmBuKiuXtTVpQxw4xrDCgw==
X-Received: by 2002:a17:906:7854:b0:a19:a19b:78b5 with SMTP id p20-20020a170906785400b00a19a19b78b5mr5480241ejm.120.1702585976560;
        Thu, 14 Dec 2023 12:32:56 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id vw18-20020a170907059200b00a1712cbddebsm9837864ejb.187.2023.12.14.12.32.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 12:32:55 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a1d2f89ddabso1034308866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:32:55 -0800 (PST)
X-Received: by 2002:a17:906:d8cd:b0:a19:a19b:78bb with SMTP id
 re13-20020a170906d8cd00b00a19a19b78bbmr4577583ejb.126.1702585975559; Thu, 14
 Dec 2023 12:32:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125433.03091e5e@gandalf.local.home> <CAHk-=wiKooX5vOu6TgGPEwdX--k0DyE4ntJDU4QzbVFMWGVXFw@mail.gmail.com>
 <20231214151911.2df9f845@gandalf.local.home> <CAHk-=wh5XgB4Jb9cRLe6gh_C_wXK3YevqCLi1BFRk5z1pJDkQA@mail.gmail.com>
In-Reply-To: <CAHk-=wh5XgB4Jb9cRLe6gh_C_wXK3YevqCLi1BFRk5z1pJDkQA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2023 12:32:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHf48o15sugNeZkzNy2sJ2XUjaJLUWskTB0FnrnFGDeA@mail.gmail.com>
Message-ID: <CAHk-=wjHf48o15sugNeZkzNy2sJ2XUjaJLUWskTB0FnrnFGDeA@mail.gmail.com>
Subject: Re: [PATCH v3] ring-buffer: Remove 32bit timestamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Linux Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 12:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Read my email. Don't do random x86-centric things. We have that
>
>   #ifndef system_has_cmpxchg64
>       #define system_has_cmpxchg64() false
>   #endif
>
> which should work.

And again, by "should work" I mean that it would disable this entirely
on things like arm32 until the arm people decide they care. But at
least it won't use an unsafe non-working 64-bit cmpxchg.

And no, for 6.7, only fix reported bugs. No big reorgs at all,
particularly for something that likely has never been hit by any user
and sounds like this all just came out of discussion.

              Linus

