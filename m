Return-Path: <linux-kernel+bounces-22412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E963829D54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C757C28143A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078874BAAB;
	Wed, 10 Jan 2024 15:18:54 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27F54BA81
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5e784ce9bb8so33949857b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704899930; x=1705504730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iI/Hu6Gs4/tJXvwOT57UbLfYusspd0Zm1u4JsSZ3X3A=;
        b=SJFouqWMMndMKJLGGgQFk4k9ayrBygizHnsSMH+ToBB9nm07MrzlXi7tjy2zCF72Ag
         iPBL6QUkAoJeS6NDyyKhr12oX0PU4HSQYyg225rTnjfsfmGZ6xlCRo48FXKtARDlHeMS
         7JhmQMqHmGWYii8WO3y1149NJL6SvP74MX3PZt2f+4lvBWeNq1N77CJ7YePiACmY5pGz
         TOGzCMrMjKJXFOOWjODCYhtD5OPvMe8B9y3l2IUnfhaq8rnmJ5AQjRN5a/EquoDHsax8
         oIVyWgklzHv9ysneBF8zDjxDiUnJoPajPi83JvORGCiG1sKVMC1SwEvq9+BtMAjHh63v
         aTxw==
X-Gm-Message-State: AOJu0YynPwMAtng+nvaYIWKs2UYX/oBI+VAFMvCTKfZ5k6ng8Vg6NJkW
	kcE9IkThpYoJ3YOW5m2r9KXgwTlKswA+Uw==
X-Google-Smtp-Source: AGHT+IF6UJfpr+GSZXs0tBH4wQsz3W/YAhX9KNz0AdZ/zV5JN5IBwtYv/LXVAOXe6jjqR00d5JjMKg==
X-Received: by 2002:a81:9243:0:b0:5e5:3342:c600 with SMTP id j64-20020a819243000000b005e53342c600mr158700ywg.9.1704899930548;
        Wed, 10 Jan 2024 07:18:50 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id p71-20020a0de64a000000b005d8ce4ca469sm1638135ywe.99.2024.01.10.07.18.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 07:18:50 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5f2aab1c0c5so40111037b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:18:50 -0800 (PST)
X-Received: by 2002:a81:9982:0:b0:5e7:7811:84e9 with SMTP id
 q124-20020a819982000000b005e7781184e9mr128070ywg.35.1704899929856; Wed, 10
 Jan 2024 07:18:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109214828.252092-1-tj@kernel.org> <20240109214828.252092-3-tj@kernel.org>
In-Reply-To: <20240109214828.252092-3-tj@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Jan 2024 16:18:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWD==XWQrcZVfxaL0wSjG5hFPoUubpi6mjrJSPU+nOoJg@mail.gmail.com>
Message-ID: <CAMuHMdWD==XWQrcZVfxaL0wSjG5hFPoUubpi6mjrJSPU+nOoJg@mail.gmail.com>
Subject: Re: [PATCH 2/3] kernfs: Rearrange kernfs_node fields to reduce its
 size on 64bit
To: Tejun Heo <tj@kernel.org>
Cc: gregkh@linuxfoundation.org, andrea.righi@canonical.com, ast@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

On Tue, Jan 9, 2024 at 10:49=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> Moving .flags and .mode right below .hash makes kernfs_node smaller by 8
> bytes on 64bit.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Thanks for your patch!

> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -206,6 +206,9 @@ struct kernfs_node {
>
>         const void              *ns;    /* namespace tag */
>         unsigned int            hash;   /* ns + name hash */
> +       unsigned short          flags;
> +       umode_t                 mode;
> +
>         union {
>                 struct kernfs_elem_dir          dir;
>                 struct kernfs_elem_symlink      symlink;
> @@ -220,8 +223,6 @@ struct kernfs_node {
>          */
>         u64                     id;
>
> -       unsigned short          flags;
> -       umode_t                 mode;
>         struct kernfs_iattrs    *iattr;

Note that there is now a hole at the end of the structure on 32-bit
architectures
where the alignment of u64 is 8 bytes.

Hence, sizeof(struct kernfs_node) grew from 104 to 112 bytes on (at
least) arm32 and rv32.
It did shrink by 8 bytes on amd64, arm64, mips64, and rv64.
Size is unchanged on ia32, m68k and sh.

I didn't check any other architectures.

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

