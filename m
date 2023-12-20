Return-Path: <linux-kernel+bounces-7643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A70E781AB28
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DDF1C2333B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135304B133;
	Wed, 20 Dec 2023 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtuGwkoR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3754B13D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9344f30caso158459b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703115753; x=1703720553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JRk2JvA7cqmexFlms98ZkMMf7aYZ8QwDwKEHx8vdwk=;
        b=XtuGwkoRTRIk6nC6qxHyQcx/2URzwcoEnI4shuBwefi+p1JirtuRljA4qKIbUlG4BM
         sWK/iq2qa+ATicbGR41sukuhh/5qHISsE9nidrnbVDEoQ6c1UUkbBqIjiVvBn/uN3IGO
         NPZLY5/NTlsk8h6xdmfkG9jZOlDelolHYfPUHtUD5yYFO2deJsn2ZDCcTwxu9GKQ17VY
         cpATF1VR+ssvabRLnL8eTnjsQKTPdidY9ZuaRlAjg0zF2hmD3NmetquW5DTkGgAJbp+Q
         GYz7sLJ4xKu2guOQW+fAYGWOn1tiYmpvS6na9yFVeA7F+jH1lwLykHRJstFVYH4lredw
         pR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703115753; x=1703720553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JRk2JvA7cqmexFlms98ZkMMf7aYZ8QwDwKEHx8vdwk=;
        b=dmNC1eu5iIXaMOaR/aOzbsv4R8mP+j0HL0TH4T74Y6VmUiOIVH/CB0lHHSb+sYx8nM
         xjU1d+tffSCL+vIN/HdNPsWlXe6O/PYcXByeGif9kvpaTnOKJL/gOPqFWpDIE6g+RbJt
         X844Ykp9o8FrM6pnR2KI8zfZnNl1na+xvOi/n3o8vvH0YH4SPsU5yEVbJ0nC6WeBFBIN
         fDbd8z4k7AAQ8aD5D0FQBntfeveG9m1Q/4ojtrXcLe4Y4urMArcPmPM0Vih8ZcKGUlr5
         65i44qkvH9j+LMPOjelAYArLuNMbaZR7Bp3PGr7KJDlVwa25R3ptJ8iVzHta5P+64uix
         RjbA==
X-Gm-Message-State: AOJu0YyeL8SnESJFr9qQj2P4WxAiHVYaVPky3X8GKwkcP/jkfuAx3z3S
	lSJDMAtowebJMaj41SdWZ81TERqgif8g04//nXg=
X-Google-Smtp-Source: AGHT+IHNgg1j1HVSr9t2rXxcVOYERtXGUq0kvxnvedw/WKO898si7UTckjxNqiQnpURGR3oilhMqYQtGm9uwANeCR+4=
X-Received: by 2002:aa7:880e:0:b0:6d9:30b4:3247 with SMTP id
 c14-20020aa7880e000000b006d930b43247mr4182832pfo.18.1703115753386; Wed, 20
 Dec 2023 15:42:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220054123.1266001-1-maskray@google.com>
In-Reply-To: <20231220054123.1266001-1-maskray@google.com>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 20 Dec 2023 15:42:21 -0800
Message-ID: <CAHbLzkpZomZBHVkSpCiK-hZUoZi4x2N6MB=PtFj-cBHOVhYs7Q@mail.gmail.com>
Subject: Re: [PATCH] mm: remove VM_EXEC requirement for THP eligibility
To: Fangrui Song <maskray@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Song Liu <songliubraving@fb.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 9:41=E2=80=AFPM Fangrui Song <maskray@google.com> w=
rote:
>
> Commit e6be37b2e7bd ("mm/huge_memory.c: add missing read-only THP
> checking in transparent_hugepage_enabled()") introduced the VM_EXEC
> requirement, which is not strictly needed.
>
> lld's default --rosegment option and GNU ld's -z separate-code option
> (default on Linux/x86 since binutils 2.31) create a read-only PT_LOAD
> segment without the PF_X flag, which should be eligible for THP.
>
> Certain architectures support medium and large code models, where
> .lrodata may be placed in a separate read-only PT_LOAD segment, which
> should be eligible for THP as well.

Yeah, it doesn't have to be VM_EXEC. The original implementation was
restricted to VM_EXEC to minimize the blast radius and the targe use
case is for large text segments. Out of curiosity, did you see any
noticeable improvement with this change?

>
> Signed-off-by: Fangrui Song <maskray@google.com>
> ---
>  include/linux/huge_mm.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index fa0350b0812a..4c9e67e9000f 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -126,7 +126,6 @@ static inline bool file_thp_enabled(struct vm_area_st=
ruct *vma)
>         inode =3D vma->vm_file->f_inode;
>
>         return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) &&
> -              (vma->vm_flags & VM_EXEC) &&
>                !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
>  }
>
> --
> 2.43.0.472.g3155946c3a-goog
>

