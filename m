Return-Path: <linux-kernel+bounces-20298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975C5827CFF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A8328514C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A088B2F44;
	Tue,  9 Jan 2024 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyRzwz9L"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6862228F1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3366ddd1eddso2626889f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 18:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704768754; x=1705373554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppkSdH3z1kt6voFQDn4E9SzAVclK+/ku7jNGmWCT8sQ=;
        b=gyRzwz9LE+fPAvkEvZyWjAP6Dc3kYo8wwA22+g26K96Q2T/4SOSni+e0fy5EPgHo9Y
         ZGUOMh8/E2QqUijbWZRJtgQ4yqmAg4TBiVHy7JYfy45qeb4CytUOGs88U+jdnAJR97Pl
         U5CGiLZnXt44XJw3kRPzEbT+/cfFbyY0BoVvQAHw2x2GCOYE7eSEA9ZMgkshKp5//qvC
         Y4R3q233q2MBsi785ulbCIT59IuYOAvTGRH3fBwzEQm+JDHWVbgxtJX1MOg3qwkI777y
         ELkHLNbF7rMeyj0onuk5Yv5Vh8zfeP268aGD9yNga1yG9hwtfEwr+6d959pk8z+U5FCc
         BVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704768754; x=1705373554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppkSdH3z1kt6voFQDn4E9SzAVclK+/ku7jNGmWCT8sQ=;
        b=xFCxUHCYwF5d5tNdqSLb9/phJG37VigLwkz8DPu2d6vVaadx3JsWIaEx12fvaxn6+P
         K81OSWFeMoA/PEpfelhGAnUw87SPFvf8yFJS9fZqbfUh+SVSzMDfkZEHXoUalXZftzXe
         TzRxaZ/ma0sxchvzaC0ZwfOoG5PzMT8c/gtbTEupPB6e1Qa6WjwgS4oLwrRak6TzsvCI
         Kp59cnfchfWXxYj5nOFCjTnom5WtwCj5hALIiVqCz35P3OCVxNt/GdsZnfZIlRsJzFvL
         CiXxEsNf+PU2FPZ+BgU6wEr68PKMlhfmoIfqSnESBP/N/ovk7Cg04GVl3mQc2FsbdafN
         +y5w==
X-Gm-Message-State: AOJu0YxGS+BA9/SL8ouKKnw1hZG/am1k2a/SgETq9nNqZMiX5jq2zoHp
	n1x/wJxWJosH33YI5vxeYWss5ZE42nP1EuwIXWw=
X-Google-Smtp-Source: AGHT+IGtn1fnIUdzHd6Qz1fAfiHmb6ZGBhgzjDw4ZpcE5gUgTHfBMMAVs6MZWeFte5JvO48iuqTlb8itIHbnqp6nw5I=
X-Received: by 2002:a05:6000:dc9:b0:337:57da:4a9b with SMTP id
 dw9-20020a0560000dc900b0033757da4a9bmr86668wrb.187.1704768754315; Mon, 08 Jan
 2024 18:52:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNi4rO+Dw5qYDtyJVbuo0OqAoXpGq_Qq6xjH9cvMCAUnW+77g@mail.gmail.com>
 <CAJNi4rMHtM=39jzkzwqt++kVpSp0=XfDrVdY94WoW6B34oKwDA@mail.gmail.com>
 <ZZb2f0U4qTWDjCGj@FVFF77S0Q05N.cambridge.arm.com> <CAJNi4rOpzmQAW1Fjst-Em=SQ7q8QsQh0PWhVxUizrOW9JukOgQ@mail.gmail.com>
 <ZZvS8rigFJR8L56c@FVFF77S0Q05N>
In-Reply-To: <ZZvS8rigFJR8L56c@FVFF77S0Q05N>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Tue, 9 Jan 2024 10:52:23 +0800
Message-ID: <CAJNi4rNTzkuZeya8f=tBVOn_dqgLbLf1A+3X4vHqiSa_sgDbUA@mail.gmail.com>
Subject: Re: undefined reference to `__aarch64_cas4_sync' error on arm64
 native build
To: Mark Rutland <mark.rutland@arm.com>
Cc: gcc-help@gcc.gnu.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 6:51=E2=80=AFPM Mark Rutland <mark.rutland@arm.com> =
wrote:

>
> This is due to a difference in default options between the two compilers;=
 the
> kernel isn't linked against libc in either case.
>
> Your native compiler evidently has -moutline-atomics enabled in its defau=
lt
> options. With that enabled, the builtin atomics generate calls to out-of-=
line
> functions which the kernel itself does not provide, and hence those resul=
t in a
> link-time error.
>
> Your cross-compiler evidently does not have -moutline-atomics enabled in =
its
> default options. Without that enabled, the builtin atomics generate inlin=
e
> atomic instructions rather than function calls. Since these don't depend =
on
> external functions there's no link-time error.
>
> If you pass 'mno-outline-atomics' to your native compiler, the problem sh=
ould
> disappear.
>
Right, this should be the root cause, just pass 'mno-outline-atomics'
to my native compiler, the kernel link time issue doesn't show. But, I
test a userland application with '__sync_val_compare_and_swap' used,
for the 'aarch64-linux-gnu-gcc test.c', the 'nm a.out' will output:
..
0000000000000960 t __aarch64_cas4_sync
0000000000011011 B __aarch64_have_lse_atomics
..
From the above output, seems the cross compiler has
'-moutline-atomics' enabled by default, also with
'aarch64-linux-gnu-gcc -mno-outline-atomics test.c', the 'nm a.out'
doesn't show the '_aarch64_cas4_sync'. The same result for the native
build for the same test.c, this result can't explain why the
cross-compile linux kernel will not generate the link time error,...

>
> Mark.

