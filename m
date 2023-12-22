Return-Path: <linux-kernel+bounces-9664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD19981C93A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742441F2652C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F8F171B6;
	Fri, 22 Dec 2023 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fUPKGv+m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7041773B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-67f33cf014cso10587456d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703244964; x=1703849764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlozJj1f2kvO8UJMaafcew1dPPV20AWiBo6Zcv/BbcM=;
        b=fUPKGv+mO/JOOqFVoNjDreAj3vs5NpjWNV8ifBS29VPiYmaWbZLLkCH4r1VDeBzKB5
         TxhWJlRqZJjXweR0tKkO5IMmGuHMlZ51jabxFTPilbrxljKQarcO3ijDl1X9BOe8VkF5
         xBFFfr/JXGlDUSuq5HjBKjuXcOnxl3rn4ZYBo1Y/RRboapCWm6kogyjwsGRQdIPndaIx
         scYF2KJSPAM/fWWcitTjvL+iksY4JRIuST7T+HyFqWfosQBF6+yrg1ubBqoq7ViSE3r4
         SJPbsHMs10W3nm+NQCEL8NTuYjOcGY3aC1hywIAKyKpmNgqgYt7+9sV1cabT04F9jPd0
         /ZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703244964; x=1703849764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlozJj1f2kvO8UJMaafcew1dPPV20AWiBo6Zcv/BbcM=;
        b=uxkbNYFcy9FCREPhLJiemorHa0m1muxCproYgX3HKpsdq5uDt9BrDYJt1YqIz19/wN
         W4rlalJEWACUv1plSuuwB/kImhgYsY39/P6vIm1iwC/nZRgMFoBLTQ5oQag91BroEJoH
         e7NQyx35EthN0apHOcIIbZ+XItneFrRnhof78ioxjQykyqcTvoYH42TbpMd+v8mccf7E
         1x8WI+ompY7O74PeFJ1fzQDyfo7/aDrzs9N7I1FhXYB/Jjx97ng5sdjLx99u4rSnrohL
         s5iJoA5Rhz9cWvggjPXzOB+McPBbRxpvZ1ltdDZmUHEjJ9zcNI/v14pTpDwEXOXxAGkG
         uN5g==
X-Gm-Message-State: AOJu0Yx7wdBsCeG7TgSVAsEdGQSepdKSgt+7wA0HRL7+sT9ZUmk6xiVP
	b5DV3z3abTwO3+kXTpXpAo+Fa6pzZTG+hvqItuohSt4ZZrex
X-Google-Smtp-Source: AGHT+IFf/0l5PchUxoTTmnO+q1QqqQ0MLqXkv/Hk63Z/jliSYncZKvMaBddebIKgg5o5CVXYz4PTSIXPpaGQtUDONNs=
X-Received: by 2002:a05:6214:b62:b0:67a:c46c:64e1 with SMTP id
 ey2-20020a0562140b6200b0067ac46c64e1mr1305854qvb.8.1703244964059; Fri, 22 Dec
 2023 03:36:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213233605.661251-1-iii@linux.ibm.com> <20231213233605.661251-18-iii@linux.ibm.com>
In-Reply-To: <20231213233605.661251-18-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 22 Dec 2023 12:35:27 +0100
Message-ID: <CAG_fn=UNdruNOkyQ8c5mdWQGC1-xP+86GX9Zsdg3VSc=5itNaA@mail.gmail.com>
Subject: Re: [PATCH v3 17/34] lib/zlib: Unpoison DFLTCC output buffers
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:36=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> The constraints of the DFLTCC inline assembly are not precise: they
> do not communicate the size of the output buffers to the compiler, so
> it cannot automatically instrument it.
>
> Add the manual kmsan_unpoison_memory() calls for the output buffers.
> The logic is the same as in [1].
>
> [1] https://github.com/zlib-ng/zlib-ng/commit/1f5ddcc009ac3511e99fc88736a=
9e1a6381168c5
>
> Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>


> @@ -34,6 +37,7 @@ static inline dfltcc_cc dfltcc(
>  )
>  {
>      Byte *t2 =3D op1 ? *op1 : NULL;
> +    unsigned char *orig_t2 =3D t2;
>      size_t t3 =3D len1 ? *len1 : 0;
>      const Byte *t4 =3D op2 ? *op2 : NULL;
>      size_t t5 =3D len2 ? *len2 : 0;
> @@ -59,6 +63,26 @@ static inline dfltcc_cc dfltcc(
>                       : "cc", "memory");
>      t2 =3D r2; t3 =3D r3; t4 =3D r4; t5 =3D r5;
>
> +    switch (fn & DFLTCC_FN_MASK) {

It might be a good idea to add a comment explaining what this block of
code does.
(And that it is no-op in non-KMSAN builds)

