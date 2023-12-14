Return-Path: <linux-kernel+bounces-26-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCA0813AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049CE1F21656
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F31F6A001;
	Thu, 14 Dec 2023 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z3QNh04C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F62697B0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-551ee7d5214so1973602a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702583234; x=1703188034; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sjcQO6QUwn6LlRQi3EB5uy3LvsThnC1DrE9jgfSqzKY=;
        b=Z3QNh04CazCSd6G4OWax9HDBWX8m2ZnhHXBsMXgxTPvUXFbRq+q0q/NvEDTh03FWh4
         BbHUq8xVt5hXNxcRlkPc7D/rYp9eckL88i6XKKq2QfPqLcP8zHAjJ8tuZl8KzvdxLVre
         aZIEv9ExIETQPGA9RZookHs/Ngh8mZOYTa9mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702583234; x=1703188034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjcQO6QUwn6LlRQi3EB5uy3LvsThnC1DrE9jgfSqzKY=;
        b=JPFOe8fzVAaVSoLC0KGFSUXohnnj8lc3UMg41yUXvXNZ/oWMvifO8utWassuhcg2bG
         xLIrpsXfrn+GMuDXrH+SLcvSD3ztmRB/+r2Q49PSKuC7u/JxYcjYjtxjexIeeXgYj/WV
         hsoPI1kS9/DvtvpWy2XhAT3XWbon+0eh80euKjBkWNMJiPzp4UiEyWTRcM5C7yUpXdjs
         UNUigt48kDUwaaxStzPm2Spx0yZ8WJsYoi4tQxsUwiELmdsG33G1FXWQYywEPinLBRcF
         JOurG1A2re9y58E9v5L4+bOW7ByW4oroY+U341c/XkE5lgooMrf0ArtZ8XEC5g9NjLXX
         9sDA==
X-Gm-Message-State: AOJu0Yxau+UMKWCMl+P6XFzXtccZqoMgI9nCcsEfVH+4DXPHP7gVucBy
	lfHI+xQHmyUK6GDLjopdPE9P9bz1Gz6YqcSx+ZlbAQ==
X-Google-Smtp-Source: AGHT+IEKJ2CwHWHdj5YpHuob1T4IBbESwsMOrUsERe8aWaw+P3jC3wD70TYnLKVqR8Rwc/b0aIwNrQ==
X-Received: by 2002:a17:907:9729:b0:a1e:eebd:ecd with SMTP id jg41-20020a170907972900b00a1eeebd0ecdmr12178265ejc.32.1702583234113;
        Thu, 14 Dec 2023 11:47:14 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id kw20-20020a170907771400b00a1dc4307ed5sm9744902ejc.195.2023.12.14.11.47.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 11:47:13 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a1f6433bc1eso198152766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:47:12 -0800 (PST)
X-Received: by 2002:a17:906:109c:b0:a1a:5397:b67f with SMTP id
 u28-20020a170906109c00b00a1a5397b67fmr11674986eju.4.1702583232499; Thu, 14
 Dec 2023 11:47:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125433.03091e5e@gandalf.local.home>
In-Reply-To: <20231214125433.03091e5e@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2023 11:46:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiKooX5vOu6TgGPEwdX--k0DyE4ntJDU4QzbVFMWGVXFw@mail.gmail.com>
Message-ID: <CAHk-=wiKooX5vOu6TgGPEwdX--k0DyE4ntJDU4QzbVFMWGVXFw@mail.gmail.com>
Subject: Re: [PATCH v3] ring-buffer: Remove 32bit timestamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Linux Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 09:53, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> +       /*
> +        * For architectures that can not do cmpxchg() in NMI, or require
> +        * disabling interrupts to do 64-bit cmpxchg(), do not allow them
> +        * to record in NMI context.
> +        */
> +       if ((!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) ||
> +            (IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_X86_CMPXCHG64))) &&
> +           unlikely(in_nmi())) {
> +               return NULL;
> +       }

Again, this is COMPLETE GARBAGE.

You're using "ARCH_HAVE_NMI_SAFE_CMPXCHG" to test something that just
isn't what it's about.

Having a NMI-safe cmpxchg does *not* mean that you actualyl have a
NMI-safe 64-bit version.

You can't test it that way.

Stop making random changes that just happen to work on the one machine
you tested it on.

           Linus

