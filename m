Return-Path: <linux-kernel+bounces-101738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D85687AB2A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8A91F216FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4570C4AEEA;
	Wed, 13 Mar 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHI/1PbS"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD2542AA7;
	Wed, 13 Mar 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347556; cv=none; b=BRkyLUlDEe2c4SOQpXMlSaoLIqVn/vDZAtuGtQl/FtW+dlu1Dbd0rLk5+SqKwgMuYLj0n/SgTEfBNzVqUzjETx+q8ChPvdy05oTED9erSyc+JZq8C8Ksy9OGq8mFC8bse2/KBVClQk+AdNz7rItGEtciWedlT+6wR5ZZps9AHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347556; c=relaxed/simple;
	bh=T340r0eaGEDm2J0w84aaUxoHEAdYPn4wuvnJZyI5Grc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioxvBLt4XvCNyqOv+lktrbc97dDZNWxC1msYh4TxLTTRiEokGyi2LRzfkQMbx4HYfA9T5RR8Ii624o+/IR872d06MZRvnERRjp7ury0orG7/xv8i49RMZ9t6U9KhsITs/ULmjpb4RuXb5BjHvEw3Q4Hp8JIbv1puLsGZ9ZyfTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHI/1PbS; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513ccc70a6dso69023e87.1;
        Wed, 13 Mar 2024 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710347553; x=1710952353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3p5pD/BQaomOSMR0XMz7Tlj6AWEWBtJ2cyD42C7Czc=;
        b=UHI/1PbSRmbBhLH8FW7BxfQ0mB211Zwy3F6hlhIxGfBrxuzFuWZZZwKVFsiBOXNj6k
         MIhH8Fkzapjru7xVV1uYEcnYrhNYbZYDe8n9WInAGzVC/9PVp1TueTyRX5ACQkuFpPHE
         erpxqVlKLZKJ7VIux0P/8mMlgn0wCA7LNSpsVuCH53Gzb5Ykf2fOH5nieZXpT6u8g1l1
         eHpJ0/txXFeoCeMHZWLTrqirWiqp2V31WT9R7tBkO1P8ngWSfd6syPrE7HJKhl9voAyh
         jtSQ+RZEkziLRt1zbrC7j8T++1Cxln1l2hskEFxYON7pUxve1kYF61j+hfgpztTG0XKZ
         212g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710347553; x=1710952353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3p5pD/BQaomOSMR0XMz7Tlj6AWEWBtJ2cyD42C7Czc=;
        b=EEqxUaqLF8HwDmad16CFbjIl1f/VNyxygXv7tT5UvM18zt17fP6+uOGlOCFoLOWGer
         Wcd5JZijdIJMdFvJ0ODwiZhA8aSLUg3Myixpj1Fbh0fbEJVY16wZLLNpjRQw17ASAhnM
         LbepuHNHyb6arlPTL7VBQvUpSJXG6w0H/AnMFwsuSfWs+YqEmkFLvkGgpkkJQP5q0jSW
         4ih140Bypa+LZWRxcEqo3KpLYFyl5QoQoIS/l+kVAN8LwC8mZQDEp5OX17BipBnMHTJ7
         LrxDx6Xd5iB4wEhoVC6+z2QHboxXrGnt8Nwz7FUKOMY2XwxkLZA/Vjh9OyMUNRwvop2v
         hrpA==
X-Forwarded-Encrypted: i=1; AJvYcCXjsNTBq2d1WUtrP8gu5yK7iANBW/Gkbb6dN/cQCViW495vQtdEof8VuOf8PWEk7m7DmA1eywrUjPl+uuL56LU2fezJODXfPyFuuA==
X-Gm-Message-State: AOJu0YxX8/medzztjGrkplQBMQX1nzbzHZreWCoOei1ghgROAaPJNijo
	4/5NaEPNxvXtoVhVkeswBMF2JLItl7GIHzs03+RlN/OKoMKtBxtKbaLNN+E3DdD4HAK3NGG+vt9
	TLEYtBpqLPmLtFDZEn/kcNRvvf/o=
X-Google-Smtp-Source: AGHT+IFAt+Ec6pWboi/5fVwUAl3TFwJHaNefRNP7U6uhrpUJ6LTgofr7K/MrRdytjogdw+Urj2h4YeTdVa72h8YZXUI=
X-Received: by 2002:ac2:598b:0:b0:513:7e83:b3f2 with SMTP id
 w11-20020ac2598b000000b005137e83b3f2mr7920196lfn.45.1710347552712; Wed, 13
 Mar 2024 09:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYNiENwQY8yV1LYJ9LjJs+x_-PqMv98gKig55=2vbzffRw@mail.gmail.com>
 <20240313145218.GCZfG9ovrh2ukJ9uAO@fat_crate.local>
In-Reply-To: <20240313145218.GCZfG9ovrh2ukJ9uAO@fat_crate.local>
From: Sam Sun <samsun1006219@gmail.com>
Date: Thu, 14 Mar 2024 00:32:20 +0800
Message-ID: <CAEkJfYPzStpPfnNkojU-KvVP2GLxqPOiZ3=1DViPTyNUUQ0-1w@mail.gmail.com>
Subject: Re: [Bug] WARNING: ODEBUG bug in __mcheck_cpu_init_timer
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, 
	"xrivendell7@gmail.com" <xrivendell7@gmail.com>, syzkaller@googlegroups.com, 
	linux-edac@vger.kernel.org, hpa@zytor.com, x86@kernel.org, 
	dave.hansen@linux.intel.com, mingo@redhat.com, tglx@linutronix.de, 
	tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 10:52=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Mon, Mar 04, 2024 at 10:26:28PM +0800, Sam Sun wrote:
> > Dear developers and maintainers,
> >
> > We encountered a kernel warning with our modified Syzkaller. It is
> > tested on kernel 6.8.0-rc7. C repro and kernel config are attached to
> > this email. Bug report is listed below.
>
> See if that fixes it.
>
> Thx.

I applied this patch on the latest kernel mainline commit, and the C
repro could not trigger this bug. I think this bug is fixed by this
patch.

Best Regards,
Yue

>
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Wed, 13 Mar 2024 14:48:27 +0100
> Subject: [PATCH] x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Modifying a MCA bank's MCA_CTL bits which control which error types to
> be reported is done over
>
>   /sys/devices/system/machinecheck/
>   =E2=94=9C=E2=94=80=E2=94=80 machinecheck0
>   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 bank0
>   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 bank1
>   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 bank10
>   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 bank11
>   ...
>
> sysfs nodes by writing the new bit mask of events to enable.
>
> When the write is accepted, the kernel deletes all current timers and
> reinits all banks.
>
> Doing that in parallel can lead to initializing a timer which is already
> armed and in the timer wheel, i.e., in use already:
>
>   ODEBUG: init active (active state 0) object: ffff888063a28000 object
>   type: timer_list hint: mce_timer_fn+0x0/0x240 arch/x86/kernel/cpu/mce/c=
ore.c:2642
>   WARNING: CPU: 0 PID: 8120 at lib/debugobjects.c:514
>   debug_print_object+0x1a0/0x2a0 lib/debugobjects.c:514
>
> Fix that by grabbing the sysfs mutex as the rest of the MCA sysfs code
> does.
>
> Reported by: Yue Sun <samsun1006219@gmail.com>
> Reported by: xingwei lee <xrivendell7@gmail.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: <stable@kernel.org>
> Link: https://lore.kernel.org/r/CAEkJfYNiENwQY8yV1LYJ9LjJs%2Bx_-PqMv98gKi=
g55=3D2vbzffRw@mail.gmail.com
> ---
>  arch/x86/kernel/cpu/mce/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/cor=
e.c
> index b5cc557cfc37..84d41be6d06b 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -2500,12 +2500,14 @@ static ssize_t set_bank(struct device *s, struct =
device_attribute *attr,
>                 return -EINVAL;
>
>         b =3D &per_cpu(mce_banks_array, s->id)[bank];
> -
>         if (!b->init)
>                 return -ENODEV;
>
>         b->ctl =3D new;
> +
> +       mutex_lock(&mce_sysfs_mutex);
>         mce_restart();
> +       mutex_unlock(&mce_sysfs_mutex);
>
>         return size;
>  }
> --
> 2.43.0
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

