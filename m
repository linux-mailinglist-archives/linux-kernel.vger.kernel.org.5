Return-Path: <linux-kernel+bounces-62269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA1F851DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5AE4B22A98
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF7F47F4D;
	Mon, 12 Feb 2024 19:19:38 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4647A6B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 19:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765578; cv=none; b=VH6hIhLU3IvX1D7XTVPco2HrjM+0oicofjJDOFzMX+gkybtLcosMbqSUhzvMbalk6hvXY7c1uFVxb1hfHYtTYo21zCXrxGcwS8seaz0vSbyqSb4yjurXLOT1h8MCtTUGaIavmsF7jJ8nNyY6lXltqGmYgmbdL+j5ZB5D2Ueg+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765578; c=relaxed/simple;
	bh=B55WGqfzVHw8le/HWyqKt2nh3k99aFEENxs6pJxMDRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BN1V4r/kLUGkpuxKrFcAVINnll10VRDGrjeX1raLGFShrhr+MpJEDeHoAA0b9hcocL049VUCEqdGFjiU0fRO63Hnr6hCWpINLVpCLT7iM0mvqh/DfgZBile/MEEa0HFg27A7LHZgllR8Qbig0bbakd7yXSnlK/GCTT5juQLflKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc745927098so2982775276.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707765574; x=1708370374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6GjgFueoDqMOuDA9UzqgtUxPlfanNs+VyQkqEQBDVs=;
        b=n+y1KdJLnB8X+j+Qn1trPFm0c1o2edEH6jjcNe6I4OuaarPO2Xnaf1T4//68P19aWz
         V4ni99c7f6E1qviszmxdQThaVAllsiA7K1EimGQjmIAtugchwSxtlP+9j6xHRI+3jUMa
         0vbNxn5VvDikBsSzEthjVxlqWPVnOfJjVvxTr5raMfuXoKzyN+TTQ30v6F5xeHxwSZ0h
         7oz3yBqI+1oD0owyxGFB24gvbtWX9luEEvGS9c3z8tH3tFmJYmITUFbPUCdACWKdobi8
         L+3kYxIwfj3t4pAWlGO2Z54orTD4F8HsxHe9IUER+51hpi1EZ4zMfBP0b3qol5h7EswK
         qiyw==
X-Forwarded-Encrypted: i=1; AJvYcCU+hId1MuQu5ejQDd1PeAknmt/VJ6OGRghNi7Ub0BwTLl/xgkTgmdnu7tWJKsWCheBoILDD9Y8GNz5mJARmeOhYc7kBokjj6vHu1uUn
X-Gm-Message-State: AOJu0YyrLGl/rrIfzzOH+tKdKP+LwNTQ6OdOM5Dyxm8OweUKzYw7jX1f
	JY8HiWQk1rOaEqHRobsGardVrpaUaWB+Jteu/akQo/+Y2atrG8SODHdQYFLzVW4=
X-Google-Smtp-Source: AGHT+IHfijRSD63QfXCgQm/KqnTf6on+M4+5zGx7QB+ym7C0rUWvy3WD0BQN1i90/jpsfjgl2Hwwuw==
X-Received: by 2002:a25:26c9:0:b0:dc6:d2d9:3096 with SMTP id m192-20020a2526c9000000b00dc6d2d93096mr5779246ybm.37.1707765574625;
        Mon, 12 Feb 2024 11:19:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUO0UsNVDaosBldKmjNDv8CL90+EBuvms4gC5Sw3KbGMRX3IdAW44M3P9JC9vZ4eoRHhXlaEymQQsBUjqJts/MNZ4Q9OrcAzRZCJa5Y
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id i3-20020a25b203000000b00dcc234241c4sm69744ybj.55.2024.02.12.11.19.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 11:19:34 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc745927098so2982720276.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:19:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeeBQW5qSC0BBxJW98rn1Q9vgdnJ0AD8vXywQisUuvT9y+4DmCo0rBA4rwNZs47Y2epe0a0qBO/urUmlx5FqLOS5PzRHYSzK9fjvkn
X-Received: by 2002:a25:bc8a:0:b0:dc2:5674:b408 with SMTP id
 e10-20020a25bc8a000000b00dc25674b408mr5941166ybk.57.1707765574018; Mon, 12
 Feb 2024 11:19:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuRwO6FLZ4do1wR0RdiZh9NGpRLKckQcKN2aAkqBH7k0g@mail.gmail.com>
In-Reply-To: <CA+G9fYuRwO6FLZ4do1wR0RdiZh9NGpRLKckQcKN2aAkqBH7k0g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 20:19:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUpqSeJ4XpEzrOwVsUs9DgaTkApQmmAHCr8YkfyjbhwDw@mail.gmail.com>
Message-ID: <CAMuHMdUpqSeJ4XpEzrOwVsUs9DgaTkApQmmAHCr8YkfyjbhwDw@mail.gmail.com>
Subject: Re: Powerpc: ps3av.c:(.text+0x19e8): undefined reference to `video_get_options'
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	clang-built-linux <llvm@lists.linux.dev>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Javier Martinez Canillas <javierm@redhat.com>, Geoff Levand <geoff@infradead.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 7:36=E2=80=AFPM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
> I encountered the following build warnings/errors while compiling the pow=
erpc
> kernel on Linux next-20240208 .. next-20240212 tag with clang toolchain.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> powerpc64le-linux-gnu-ld: drivers/ps3/ps3av.o: in function `ps3av_probe':
> ps3av.c:(.text+0x19e8): undefined reference to `video_get_options'
> make[3]: *** [/builds/linux/scripts/Makefile.vmlinux:37: vmlinux] Error 1
> make[3]: Target '__default' not remade because of errors.
>
> Links:
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2cFkli5H02fikrp=
ga6PluAWLAMa/

https://lore.kernel.org/linuxppc-dev/43ed64aa-17b0-4d04-a1f3-a6e13f59a743@s=
use.de/T/#ma2e81d77ee4a708c75d09c4e46904072b3f7b70f

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

