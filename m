Return-Path: <linux-kernel+bounces-9144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E674D81C142
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872FD1F26101
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E291776095;
	Thu, 21 Dec 2023 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq0NOrt1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC66A64A96;
	Thu, 21 Dec 2023 22:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5c875ee4f10so1708747b3.1;
        Thu, 21 Dec 2023 14:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703199547; x=1703804347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UA7JuCuRXrwN9iYkopGheqxmF3OuJypcH4hAT2fcOGs=;
        b=Eq0NOrt13h719dfuflvAm+c+ELNuiZrJZq219WO/OrFF+QgVGhg5sU6cg+H9flj6oQ
         U4C7oC4ZoJBhBtqqCYxxB4Zt/UxwQzmarU2hts8FnlpU6LeLsrPdswvNrVULK4BiPw9S
         +w0N9J40iH/5/odFem+e928GGhzdN3VJY50NY75E37vckRXGJUMEklR25dRHN+pDDGfj
         SKGFnHYqN50/41H8bGRCL8608NtPY+ThkL8ZvDvrCuU5Gy87a95o0PwcdTxG+zf2WD3Z
         d+j7uir3c6ASpBW5DkCeSJdHmxJBiWUO7h8Elu2ErdB+M1c/TG88zb+XXVPZbCjla7om
         59NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703199547; x=1703804347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UA7JuCuRXrwN9iYkopGheqxmF3OuJypcH4hAT2fcOGs=;
        b=GIdU0BIZWPJY3eys7TVKhooGd53exkyN8T1y0zjetX8cHlHzfersik09gHfF1DYHEU
         w0Z6E156lyqfUWU3zOiGB8LgU5cafIJtRCc/LyfOqejgdNXca68TiMQ+ObDjWWHOjWH+
         qrISICPIxh8RvpC1rSgTSYr3BxHl7rSuE/XIPP0bBPhz2yMfhF0UE9DQasw48W2FJG1A
         MvgGCS7ae1pYvYBWmy0rdonv+HjuhBjgJsqg582fUhfdND09th0mK79h7d2GpkolSNB6
         qvsopTePs1GUqhbEbXG9l34KnbvXw/Z9sbKm20YC8kKyj0mv8AZIj3XlXQouqYadz7Zz
         OpQg==
X-Gm-Message-State: AOJu0YyTMBDGJ/l+yqvfgUgrcmkmUec5Gu6NsJ2IpszRCkI9DGPWQmM0
	55M3BxTtUbaCv4CsxriNm3lWoGRWBGPfEUXlyhc=
X-Google-Smtp-Source: AGHT+IH98aNguFQwmz6TS2UWL28qUf0QyxgdrvnDWZeVOiFqWSLsuadHupqh7HhLO7eOvuZyvpmJ7+0dyVMd1JKzxns=
X-Received: by 2002:a25:df07:0:b0:dbd:5ad0:8a34 with SMTP id
 w7-20020a25df07000000b00dbd5ad08a34mr781405ybg.5.1703199546472; Thu, 21 Dec
 2023 14:59:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPnZJGDcNwPLbzC99qNQ+bRMwxPU-Z0xe=TD6DWQU=0MNyeftA@mail.gmail.com>
 <d4b227de-d609-aef2-888b-203dbcf06707@landley.net>
In-Reply-To: <d4b227de-d609-aef2-888b-203dbcf06707@landley.net>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 22 Dec 2023 01:58:19 +0300
Message-ID: <CAPnZJGBeV-E_AN8GnTfkaJvRtBmCeMYYCt+O0XMsc3kDULRuKg@mail.gmail.com>
Subject: Re: [PATCH v3] rootfs: Fix support for rootfstype= when root= is given
To: Rob Landley <rob@landley.net>, stefanb@linux.ibm.com
Cc: gregkh@linuxfoundation.org, initramfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Rob. And Stefan.

First of all, this patch got to linux-next (
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?qt=
=3Dauthor&q=3DStefan+Berger
), so it seems it soon will be in mainline.

On Thu, Dec 21, 2023 at 12:24=E2=80=AFPM Rob Landley <rob@landley.net> wrot=
e:
> Can you build tmpfs on a nommu system? Last I checked the plumbing expect=
s swap,
> but it's been a while...
Okay, I agree, let's not remove ramfs.

Still, I don't like this (already applied) patch. init=3D and rdinit=3D
are two different options, and this is good. So, I think we should
have two different options. Analogously they should be rootfstype=3D and
rdrootfstype=3D. rootfstype=3D should be read by kernel when deciding how
to mount real root (i. e. not initramfs or initrd) only and
rdrootfstype=3D when deciding how to mount initramfs only. This will
make everything cleaner. Also note that userspace tools read
rootfstype=3D and assume that it always applies to real root. For
example, this is Debian's rdinit:

https://salsa.debian.org/kernel-team/initramfs-tools/-/blob/cf964bfb4362019=
fd7fba1e839e403ff950dca8e/init#L103

As you can see, this shell script parses /proc/cmdline and assumes
that rootfstype=3D always applies to real root. So, if someone sets
rootfstype=3D to tmpfs or ramfs, this will likely break this script.

So, I think the code should look so:

+if (IS_ENABLED(CONFIG_TMPFS)) {
+        if (!rd_root_fs_names) // We assume rd_root_fs_names is set
by rdrootfstype=3D
+                is_tmpfs =3D true; // Use tmpfs if rdrootfstype=3D is not
set. To get all tmpfs benefits
+        else if (rd_root_fs_names && !!strstr(rd_root_fs_names, "tmpfs"))
+                is_tmpfs =3D true;
+}

Yes, this will slightly break compatibility. I. e. this will make
Linux always choose tmpfs if rdrootfstype=3D is not present. But I think
there is nothing wrong with it. If a user cares, he will set
rdrootfstype=3D . And early boot code will become a lot more clean and
logical.

Rob, do you agree? Stefan, do you agree? Then I will write a patch,
with doc changes (currently I use gmail web interface, of course I
will use git send-email when I sent actual patch)

--=20
Askar Safin

