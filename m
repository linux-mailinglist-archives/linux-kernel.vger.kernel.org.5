Return-Path: <linux-kernel+bounces-162467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DD18B5BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C0C28120A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CF97F7C7;
	Mon, 29 Apr 2024 14:42:58 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF68D7E105
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401777; cv=none; b=ccvbrn0C9HggkryE9rZJM+p5j5KwDAFqkTb3PF9P/kvWtuPBPIqgSRwP0PUdG8IzeL61d1qJw8sk6+ZBw8NKV06XfFxajEMCayc2W0RSzEm+8gcXzR9eIiyCta8o6u6xPvQiCEj3ZDyIvDP2OIzakSCGIcobZwBt94sTtlxamms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401777; c=relaxed/simple;
	bh=4KHo3K0yMqAtatyZFcanNVB7mzLD4SlZydyr9+0iJPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1Tb6KyZbAVxHy8ShV+MnHH3Nk8XzXZ9lzFx+Fy79Ppua5+IKOkoui7RmLS+gB66uAQVAc/AKuzmQJnJzkC/hDEoU8TcHFOTbF5Y0yy8RaHLn6bmGpodxCVYNJckOX2vQH+nuiSQ8lVtYNM849ar4NqrRONcKl1B+PIqtkylIT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61be4b986aaso2532007b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714401774; x=1715006574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9Gzfsp8ljXq//x61giKmA5xlVQsBt5j2vtHzz0iF6k=;
        b=QP3q505S5TZnpnDx9hpy7Dnl1A6aEukK9nX2DYq5R7gwPWhV6/KP3BL4w0hbyoqVvG
         LmFxNit85C3YYFJ/UUlB5jkK5jTLnsbKuW+A5xvq+PsEAQf+7Q8BiylMNYTDr5q2PCxy
         hGQkD0ArZ2bdzJxhLCNtZ8aidKOsI7ZB+Q1uQG6t4aMsmo53dmrtRYxiBlR+5nsiIgEp
         S2wm/F01gfeHCYLHSNZizCvanfe5LRwdI+4EfclhXatdacKIey+SyWu57iw+enn5Dt6P
         ArPWKvJxMR3sfw8DIjQCBeN76DJFThvOVNGpqgR4bYr3IRgXpPdUpXE6s3KKofsXqx9a
         gLyA==
X-Forwarded-Encrypted: i=1; AJvYcCU1F3vLrAbaXgIbkK1Trvx7J1KGeOB8iUTiGhhewVTVXHX+V3V1t0Dr0bH/D7aif44H58KBT+RSeGkf+mIzU2KdNbcZOiIJdzUcDsVy
X-Gm-Message-State: AOJu0YxjTaAlODUmF1Z67c3VD+1cLO+C/Bi+JriLwUM/QKr2JF54WG5Q
	CaWq9Ger1Pt0/mf9yqMT9FZT3yMyxCmlSsMbUtj9arfL8oMSUqqqnPcZzkAf
X-Google-Smtp-Source: AGHT+IHU9KWt1ZrDIAJYSsZ0DUJ4dojY5EZPSjlSsTLUI54iDWNcIuMyDPugFY0Sq08kPlNXxbgTKA==
X-Received: by 2002:a05:690c:708e:b0:618:91a0:70f with SMTP id jg14-20020a05690c708e00b0061891a0070fmr9320444ywb.6.1714401774377;
        Mon, 29 Apr 2024 07:42:54 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id u17-20020a81b611000000b0060a046c50f1sm5447110ywh.58.2024.04.29.07.42.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 07:42:54 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de5a7b18acdso3714387276.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:42:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXMsFDvmMc6TV4dXunDQ0M2Y71RYxSakhgMhFRax0AzrpjawGibrD169ik1u8OX0G0LU16pnzJkTxxTbV/4iGhxP3y7P9GcWqCl+2dP
X-Received: by 2002:a25:b286:0:b0:dcd:2f89:6aac with SMTP id
 k6-20020a25b286000000b00dcd2f896aacmr11362965ybj.10.1714401773859; Mon, 29
 Apr 2024 07:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330175720.126122-2-thorsten.blum@toblux.com>
In-Reply-To: <20240330175720.126122-2-thorsten.blum@toblux.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Apr 2024 16:42:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW==FUNJe79TPi_3r8VP1jUo6LOL1MvJgEr4uRgd1yr3w@mail.gmail.com>
Message-ID: <CAMuHMdW==FUNJe79TPi_3r8VP1jUo6LOL1MvJgEr4uRgd1yr3w@mail.gmail.com>
Subject: Re: [PATCH] m68k: amiga: Use str_plural() to fix Coccinelle warning
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 6:58=E2=80=AFPM Thorsten Blum <thorsten.blum@toblux=
com> wrote:
> Fixes the following Coccinelle/coccicheck warning reported by
> string_choices.cocci:
>
>         opportunity for str_plural(zorro_num_autocon)
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.10.

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

