Return-Path: <linux-kernel+bounces-22932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D6F82A5A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1ED2890EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C874D1858;
	Thu, 11 Jan 2024 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh0of29+"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8563117C1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-337874b8164so79652f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704937371; x=1705542171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=573C8j1oW9pjIQTawxUe9zQgrGOkmk9aCSFBWOlk+GA=;
        b=Uh0of29+/sBQ1ViJPMxO5QKddz+h4K0hWldINK+oSMOS7Hv8mF67nsFcZVne74VmvP
         SUz8N5qLJkdO+l4Erb04lqWkSdctn+DqvB3VD8yP0RcZoUwcDb4V2/1REH7BeqCGdTus
         6vptcLGlcDHNcMs3FQV/gUkwcibInltenR9rtL8JdFi2cvBM1qU1uOH6NXLGA+oX45f3
         jbvJaa72OKoTyyYvs4lJ8bc4XH+zyLYHNj0A1Yi/tWU3AmbV/gnh62kaydqvoor3/pH0
         OfKKXE8QsYt3M5zcCHzi3iUYZyd91Zn1yKqVSrkCQQixNSTIjL2bPbMEAeJdAeIJ+U4P
         C6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704937371; x=1705542171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=573C8j1oW9pjIQTawxUe9zQgrGOkmk9aCSFBWOlk+GA=;
        b=BPHxtWa0wSl5rCosdvXKIxSKg2dz9NsNyRnNJjLxU9EYY7oxSkvzf3Z6m3Wo99dk3V
         jYaails/ALKfmTcgKmfSi9KBedUCOmpV5Q/eG9Ls0CO9rR/Y/PcbZ/EiXpCdBT7i3M70
         r48zd+Bi7rCdOzucbCCv6JdafagVYhydb1V26/YgbizzwZwLWiIEjwGMDevjrV/uPEV3
         /Lp7jYnpgfY8Vxynu2nb9h2md0SNwBmp6T2JMf2ZkPQUJ13Waem9eBElNjY7Vpe+c+mq
         nVoflxKbHUo7G+Jr9xDeMROCPCvWMwK+mr16JuUdekwwvk094eIyaZy2zquQHC/LSfAD
         v2Sw==
X-Gm-Message-State: AOJu0YyZDW8UHChAH1z+uQaOQCX5Iq05FH6zFg5hElMMBZf2kKLr+JAv
	Q6ZsmX2HjI1gk/UDtIbSTIxcZBTzD0amynovYQY=
X-Google-Smtp-Source: AGHT+IF1QQxMj+kJ7E5CkPp9//yJvfVwqEeCmFKFHCWTvnFQD7/ODwzXbyzBUE4kGeCpdOfe72f4HAr3EIT9SF4xZWk=
X-Received: by 2002:a5d:6249:0:b0:336:6e22:672c with SMTP id
 m9-20020a5d6249000000b003366e22672cmr152305wrv.88.1704937371516; Wed, 10 Jan
 2024 17:42:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZb2f0U4qTWDjCGj@FVFF77S0Q05N.cambridge.arm.com>
 <CAJNi4rOpzmQAW1Fjst-Em=SQ7q8QsQh0PWhVxUizrOW9JukOgQ@mail.gmail.com>
 <ZZvS8rigFJR8L56c@FVFF77S0Q05N> <fb6c8253fd90e66c036a85954c3299bc2c047473.camel@xry111.site>
 <CAJNi4rPj0Wc7ByqrS-GVLUUEnOFPZi8A5nLLCEEJErqAe16EZw@mail.gmail.com>
 <9aef98eed96ed32962ce90499291cb30ad5e3e14.camel@xry111.site>
 <20240109074843.GI19790@gate.crashing.org> <4ee8067e72028b070d92e10fa33ddde3a498cb48.camel@xry111.site>
 <20240109082647.GJ19790@gate.crashing.org> <CAJNi4rM_w5JKjug1PtV+tHyk11DUhRJ-K1pSDE6P1x8KSU2wrg@mail.gmail.com>
 <20240110141005.GL19790@gate.crashing.org>
In-Reply-To: <20240110141005.GL19790@gate.crashing.org>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Thu, 11 Jan 2024 09:42:40 +0800
Message-ID: <CAJNi4rMw1rN64hGZbraoDwtOJOMOumVWL_8iLaCb=TYXAhD2Jg@mail.gmail.com>
Subject: Re: undefined reference to `__aarch64_cas4_sync' error on arm64
 native build
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Xi Ruoyao <xry111@xry111.site>, Mark Rutland <mark.rutland@arm.com>, gcc-help@gcc.gnu.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 10:12=E2=80=AFPM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Wed, Jan 10, 2024 at 01:59:53PM +0800, richard clark wrote:
> > A ported driver in linux kernel calls '__sync_val_compare_and_swap',
>
> That is a builtin function.  It does not necessarily expand to an actual
> function call.  aarch64 will typically expand it to inline code.
>
native gcc version:
gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
cross-compiler gcc version:
aarch64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0

Interesting, the same '__sync_val_compare_and_swap' in the .c file
will be 'U __aarch64_cas4_sync' in the .o file compiled by native,
will be 't __cmpxchg_case_mb_32' in the .o file compiled by
aarch64-linux-gnu-gcc... don't know what the reason is

>
> > the cross-compiler 'aarch64-linux-gnu-gcc' doesn't complain
> > '__aarch64_cas1_sync' undefined reference, but the native compiler
> > will complain. As Mark mentioned, I double check that both cross and
> > native compiler should have  ''-moutline-atomics' option enabled, do
> > you know the reason for that?
>
> Ah, so you are requesting external functions.
>
> I am no aarch64 expert, but apparently there were some problems in
> GCC 11, maybe that is what you saw?  Or with some distros, anyway.
>
> It also matters if you have ARMv8.1-A enabled, the LSE instructions.
>
> Open a GCC bug report if you have more details?  Thanks,
>
>
> Segher

