Return-Path: <linux-kernel+bounces-139953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BCF8A098D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B8C1F25011
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A744A13E3EA;
	Thu, 11 Apr 2024 07:18:40 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26020523A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819920; cv=none; b=COmBfZ8v8ix9hRRIWNARqikoOgAG5PCrQbnmyJk61VAv423q0VDNBTjMWR8OoPuw4HHHHh+X5kPLpcuk8YcVp8ZcF4l2cBnONBnDrgxqEp5qNdHnEGrE8RUnUQwbl8nwdPv1e1LQYWQ8EP213TqtYfed2rDCaXGCiNIwrQOqy1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819920; c=relaxed/simple;
	bh=tBtvx4dMmrleDMYZSLo0ElpBgRoQ8IL2kHWR53HksZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTPjxdyh3G9D+NleKYLJQroKWzVXJ3zC7uPUfFF9gdFCIk9Lbryc0OnkYvZZDIV4jSNqGnRH8hdLbEOWlzHu1Tysqdu4fVxvOZSDNZz+umCXf6xA3t9yBGzqdfRG6OC3UHH5zdHiEJrf++iRvHvatFRdTXQk2lKNKtvQIwaa/i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6181237230dso43381447b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819916; x=1713424716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyyHX5dV7MCxGvkmYzkqxhN0YFNA8hymSV0fS/0VAvA=;
        b=oQpo1tleKLWaVaYYO3LLq2oGHmqKQ+JaQzvF/fDkxp7Wy6vWXLcI2snkd26wrn3O6v
         lM/2H3sJ7oNB6AlZNwuUTiz+NGEqAZDuglIa1pe0QcPQh5XGaH/G4PHM8bf5WYAwy5Cs
         VKjfM7V9Vt5X0mZ2x2Uqw1dEgD6xMEf/0XuHV91+o9pWjagFtGi3mnhn4bJ879SNzxeg
         eniioRKTu+Orj6c0GJ3JwfmeYB4WIT6nsT30xRbdcyAnRKvDFd+bHxFF6aW5/RZcmN/2
         7iexwoU4vwrn4IJMF7RSOBTyIpPUXkyrOUBevdWVlCS+vyLIR3HyqgLyifieChevwF6T
         mTAQ==
X-Gm-Message-State: AOJu0YxFuLvC62Fm2IRyDkHhOjfGlBo//Q7zru5fgeeEqC9SIzj4t1FQ
	D29dfLBTqeCnMg5CXy2D6CULeDe4upbzoiNKAveLWVlGxcJplpnHXE04VevB
X-Google-Smtp-Source: AGHT+IFCG47WEmVaootSTji8+p3PRcTnaPlPszrqUdA5M9ywP8y10zWD09fRQa0EX26H2Y8FFrOC+A==
X-Received: by 2002:a0d:d441:0:b0:615:22ff:b57d with SMTP id w62-20020a0dd441000000b0061522ffb57dmr5740977ywd.42.1712819916063;
        Thu, 11 Apr 2024 00:18:36 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id ht9-20020a05690c64c900b0061184113183sm189093ywb.138.2024.04.11.00.18.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:18:35 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ddda842c399so7802107276.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:18:35 -0700 (PDT)
X-Received: by 2002:a25:b207:0:b0:dcc:f5d4:8b43 with SMTP id
 i7-20020a25b207000000b00dccf5d48b43mr5230107ybj.9.1712819915043; Thu, 11 Apr
 2024 00:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411041200.225356-1-ytcoode@gmail.com>
In-Reply-To: <20240411041200.225356-1-ytcoode@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Apr 2024 09:18:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWA_cX9sbMjoZa-LoXfiH5bTAWmQNXS-srEwhj9X5knGw@mail.gmail.com>
Message-ID: <CAMuHMdWA_cX9sbMjoZa-LoXfiH5bTAWmQNXS-srEwhj9X5knGw@mail.gmail.com>
Subject: Re: [PATCH] init/main.c: Remove redundant space from saved_command_line
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "ndesaulniers@google.com" <ndesaulniers@google.com>, Tejun Heo <tj@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Krister Johansen <kjlx@templeofstupid.com>, 
	Changbin Du <changbin.du@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC Masami Hiramatsu <mhiramat@kernel.org>

On Thu, Apr 11, 2024 at 6:13=E2=80=AFAM Yuntao Wang <ytcoode@gmail.com> wro=
te:
> extra_init_args ends with a space, so when concatenating extra_init_args
> to saved_command_line, be sure to remove the extra space.
>
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  init/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/init/main.c b/init/main.c
> index 2ca52474d0c3..cf2c22aa0e8c 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -660,12 +660,14 @@ static void __init setup_command_line(char *command=
_line)
>                         strcpy(saved_command_line + len, extra_init_args)=
;
>                         len +=3D ilen - 4;        /* strlen(extra_init_ar=
gs) */
>                         strcpy(saved_command_line + len,
> -                               boot_command_line + initargs_offs - 1);
> +                               boot_command_line + initargs_offs);
>                 } else {
>                         len =3D strlen(saved_command_line);
>                         strcpy(saved_command_line + len, " -- ");
>                         len +=3D 4;
>                         strcpy(saved_command_line + len, extra_init_args)=
;
> +                       len +=3D ilen - 4; /* strlen(extra_init_args) */
> +                       saved_command_line[len-1] =3D '\0'; /* remove tra=
iling space */
>                 }
>         }

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

