Return-Path: <linux-kernel+bounces-116695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 560FB88AF19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07CB9B3882A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC2913FD88;
	Mon, 25 Mar 2024 10:27:13 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396B51509A3;
	Mon, 25 Mar 2024 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355096; cv=none; b=M/a45R0rf4gEbfcBTpz9aZgrv3csgIWLMyvH13H0/04JfZeG4HoTm7AoGYIZAlnuBJxAEYqpWDpxgZpJ+x3hzXNm3x1h3x+QQhS5EdQzIEjLIhzEwPniH2OgTgguVe2kcFtPb0U0lrT5vZRhOvlSR53PYdl3eRZdsf/DYv85ug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355096; c=relaxed/simple;
	bh=HdSwpyEJcq7QPVhfAp25p0Tw/TeM+r3NiX2oIuYDiE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+MwYvUJZnSB/k4Ok37XnD+aT46BgIeTclTTAXqZieq9pFAdoc9EKyiPmztsyVpnj/k1AjoUM83VVehh1Cd8jzZ38pUHyjAJIHNXftViSpc9HV4/Nbd3Hqv0lOV4qNMtTcwldAW1inzjrkIDS38vfGNuQOtRwyIQInDBLEDs6bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-609ff069a40so46203857b3.1;
        Mon, 25 Mar 2024 01:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711355091; x=1711959891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEfLIiCMu33AlwMloMoi4ICYWpFuuaEkY/DY4cDIgmE=;
        b=jOo68WsePLya0UTIv2mo5i4/kpavPY6FzloQwGpk/Hb87ae3OvvWibgRGJNpmcB9Ix
         jAOa0lxGK6X3n1oQd7CtLaycLmodX1mG6K3MRmxry/IsJ9efzUM8XKZSLWiRJoz7dxzm
         8LhF0Wj4aJlsigUWi5E83+xUtMtB1FiOnucflQLTGxc6RazDoyMqagCAS3Qwlctk0UW+
         nOTzdGqHmyXwwfc8o3CtdXkymG76zNYPiRKZ6X1hlvwmTqVLlotr8N+okyFk/NJ6C5zQ
         lCWYBar3zwCiH5Oh7jjor3B+JW4HDtGPhOO/+J0m7Vi5FQWQB5phXP/jMjr5OCkpIi6i
         pa+w==
X-Forwarded-Encrypted: i=1; AJvYcCUD6qLHe7qp+XRyqDyvBRnIchmFCkcZzhgztE842VmmMtxA1rlrDXJQQe3P14STXyTaGPaXgFKd8hiIxo4gPI9NjJc4/GRF0hthsv3PzxRCRD+NJdQDiFBnmVwSo3zPxJodU4aDdP59endufe2a1bFfJ8qIuBd+4rZWdSS2iB2TTQ==
X-Gm-Message-State: AOJu0Yz4nFJOEz4UUHf4gy/PH60aRJTGnwq8u/MyDsQX7jjzy1PQNP+O
	kbc3fOhf0webxK5FU2VN+sutlnSWbTDTcY8ypXqGcbD1bulNVNck2TkjheNHDkQ=
X-Google-Smtp-Source: AGHT+IEww2fSQ3Wu/wewUYOYe8KvgDN4m9NQCLgkoHzNH55wlqFjWJPXZrCNHaP/T2qgp1YHW40w6g==
X-Received: by 2002:a81:9e44:0:b0:609:e4b4:c2fb with SMTP id n4-20020a819e44000000b00609e4b4c2fbmr4842276ywj.27.1711355091363;
        Mon, 25 Mar 2024 01:24:51 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id t6-20020a81ce06000000b0060a4b02124dsm953873ywi.144.2024.03.25.01.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 01:24:50 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc71031680so3466484276.2;
        Mon, 25 Mar 2024 01:24:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkKKcySviIElzJ6y7iHyqgGKarKOKI+9+vGQxIlQ66PG47Bwsq0BZ/z4Y1MTBxEYjvhuR6Ro7Lu+r6wCVA7IsMZuEq4U9HDK5RIPEKSySxwUQKI8ijFMeqOgn+coEs8e4g8+xcKQ1x7FIqCvP0UhCtdiZbUycSnN2TT/wKlQN4BA==
X-Received: by 2002:a25:a2cf:0:b0:dcc:f0a:e495 with SMTP id
 c15-20020a25a2cf000000b00dcc0f0ae495mr4291545ybn.3.1711355089475; Mon, 25 Mar
 2024 01:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124051254.67105-1-bhe@redhat.com> <20240124051254.67105-3-bhe@redhat.com>
In-Reply-To: <20240124051254.67105-3-bhe@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Mar 2024 09:24:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVxKEGYj9C1=P-493vcrN_HmLNx8gS6i1nheXO9gH46oA@mail.gmail.com>
Message-ID: <CAMuHMdVxKEGYj9C1=P-493vcrN_HmLNx8gS6i1nheXO9gH46oA@mail.gmail.com>
Subject: Re: [PATCH linux-next v3 02/14] crash: split vmcoreinfo exporting
 code out from crash_core.c
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, akpm@linux-foundation.org, ebiederm@xmission.com, 
	hbathini@linux.ibm.com, piliu@redhat.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baoquan,

On Wed, Jan 24, 2024 at 6:13=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
> Now move the relevant codes into separate files:
> kernel/crash_reserve.c, include/linux/crash_reserve.h.
>
> And add config item CRASH_RESERVE to control its enabling.
>
> And also update the old ifdeffery of CONFIG_CRASH_CORE, including of
> <linux/crash_core.h> and config item dependency on CRASH_CORE
> accordingly.
>
> And also do renaming as follows:
>  - arch/xxx/kernel/{crash_core.c =3D> vmcore_info.c}
> because they are only related to vmcoreinfo exporting on x86, arm64,
> riscv.
>
> And also Remove config item CRASH_CORE, and rely on CONFIG_KEXEC_CORE to
> decide if build in crash_core.c.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
> v2->v3:
> - There's conflict when rebasing to linux-next in kernel/crash_core.c
>   because of below commits from Uladzislau:
>   commit 699d9351822e ("mm: vmalloc: Fix a warning in the crash_save_vmco=
reinfo_init()")
>   commit 5f4c0c1e2a51 (:mm/vmalloc: remove vmap_area_list")

Thanks for your patch, which is now commit 443cbaf9e2fdbef7
("crash: split vmcoreinfo exporting code out from
crash_core.c") in v6.9-rc1.

After this, there are still two references left to CRASH_CORE:

  1. Documentation/admin-guide/kdump/kdump.rst:

         Subsequently, CRASH_CORE is selected by KEXEC_CORE::

  2. arch/loongarch/Kconfig

         config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
             def_bool CRASH_CORE

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

