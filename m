Return-Path: <linux-kernel+bounces-69-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C83DC813B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722FD1F222E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552A3BB48;
	Thu, 14 Dec 2023 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="My6ZdEZ7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857B6A346
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso11617986e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702585829; x=1703190629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JS5aqGDyH1ekW0+NktEKhGSSqL1J+90vZeAFR9levjM=;
        b=My6ZdEZ7Jf21J3USf1CEIqz4HaqYBsmty6wkzLp8X8zFs6D3MLuEcD5K/CjumRzmgr
         azvyFHbDT088Rzl3WKeDOQ+2DRvOCnE2JBYVceFiomkZYXpRAOSkBJt6THZ5gSg5HHPc
         Jv9AwiTDRPODUK9VKQxp/yomn1YtJHHkpqv9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702585829; x=1703190629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JS5aqGDyH1ekW0+NktEKhGSSqL1J+90vZeAFR9levjM=;
        b=eLNErphjo0FtyiYnYpbLumMSc8XIfwhByv7O+06DFnUIYOrF1Uhkoqiwz12MJBn++E
         wxc2qkpLQULgJ8c2NBCpLXNQ4gROrvBf2v7YzcbsnQJrtI1KRldDHSDFPileleU8p8QB
         BvWACBUT6U+a4AgdJ5fmsCpv0/0k0tQTxADK3SCEllaToqjQhsBStB509t/3u/ip8BG3
         D9VQR22MEi+/+KK8i/ZHCBLAi06uBCWJ7vBkgDk3bwKTeYfCl0GsiKx4tUU+fzJqtQWK
         j8W8Tr4B+LBbEGKrDDdDvIshzDb2wAZ2ppc5puPhFnaa3PDXSEYUMUFKFph4TjQp13Hr
         BdeQ==
X-Gm-Message-State: AOJu0Yxuoh3cw6/sujs1LVXKEn9vruAVjIbHx5DdxRsf8zHx1aA4MYQz
	n9Nm/Tfn6g2QwjEfFS9EZKZyP5oB22FttfKLGPtD9V5+
X-Google-Smtp-Source: AGHT+IF9kvRFS6K5R4uG/fi55/4iq3nt2dj/emlneuqAujV+Iys3XMr/dxmPE0tkF9zcdFcgobn+6Q==
X-Received: by 2002:a2e:994d:0:b0:2c9:fece:5bf6 with SMTP id r13-20020a2e994d000000b002c9fece5bf6mr5277466ljj.78.1702585829175;
        Thu, 14 Dec 2023 12:30:29 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id ez1-20020a056402450100b00551ca461bd7sm2618508edb.48.2023.12.14.12.30.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 12:30:28 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-54c846da5e9so8028808a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:30:27 -0800 (PST)
X-Received: by 2002:a50:cbc7:0:b0:54c:5d34:980c with SMTP id
 l7-20020a50cbc7000000b0054c5d34980cmr5413656edi.82.1702585827509; Thu, 14 Dec
 2023 12:30:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125433.03091e5e@gandalf.local.home> <CAHk-=wiKooX5vOu6TgGPEwdX--k0DyE4ntJDU4QzbVFMWGVXFw@mail.gmail.com>
 <20231214151911.2df9f845@gandalf.local.home>
In-Reply-To: <20231214151911.2df9f845@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2023 12:30:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5XgB4Jb9cRLe6gh_C_wXK3YevqCLi1BFRk5z1pJDkQA@mail.gmail.com>
Message-ID: <CAHk-=wh5XgB4Jb9cRLe6gh_C_wXK3YevqCLi1BFRk5z1pJDkQA@mail.gmail.com>
Subject: Re: [PATCH v3] ring-buffer: Remove 32bit timestamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Linux Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 12:18, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> For this issue of the 64bit cmpxchg, is there any config that works for any
> arch that do not have a safe 64-bit cmpxchg? At least for 486, is the
> second half of the if condition reasonable?
>
>         if (IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_X86_CMPXCHG64)) {
>                 if (unlikely(in_nmi()))
>                         return NULL;
>         }

No.

Read my email. Don't do random x86-centric things. We have that

  #ifndef system_has_cmpxchg64
      #define system_has_cmpxchg64() false
  #endif

which should work.

NOTE! The above is for 32-bit architectures only! For 64-bit ones
either just use cmpxchg directly. And if you need a 128-bit one,
there's system_has_cmpxchg128...

                 Linus

