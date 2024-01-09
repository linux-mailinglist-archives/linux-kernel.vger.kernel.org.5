Return-Path: <linux-kernel+bounces-20309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF2D827D17
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3DF41F2444B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290712907;
	Tue,  9 Jan 2024 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7U5yZ1X"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273752573
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e490c2115so7502315e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 18:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704768961; x=1705373761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyON8xZGng1CZkDRa+8BV36Ox5Lq78pRG6dfrn1SZXM=;
        b=k7U5yZ1XXKAngb/P9g7dc00FZfxy4AKE5IDe8Ge4J5+yuVigj6yWphAryShMZE/vym
         DufCKg2fQqe7gnHgxJP4JNhHOi56JKdHHjWdhzwrfulVbttv2ftv6btFrkaqCgsPdXTk
         fOD5vMbBw23yMLsMpeR+cGye4HH3GcMzOBe6AYyd7itDIwziVpB2xgYRAXbTmdu0nYAw
         68KbjeN6mMxzVoJvqo7JGaF6IhpjFDHVoX44bqzfkxWawRJL5l6HJJp6lwI70r41dEDR
         hJQ7XrdMz3lULM6PafxdWmfrLWMz4TiowfNMuIRS9pj51xpCWdZJV9aardzV6tH+zASq
         3yRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704768961; x=1705373761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyON8xZGng1CZkDRa+8BV36Ox5Lq78pRG6dfrn1SZXM=;
        b=HFV4N7kpX+KAHnnd5kj/LYmJoQuWb3G3soLsbbRIYLKI8KQBeucRhZwOCcFPDxLGvj
         yzwDRhNyYwBm7eqbjXMt46PEQb3nXnDrbA8XLWwkWwANh42FcJVnJGfifNm77zWr0UFU
         yIrIL0zEaTUatfAp2SKr0ArMXCCXaZohNJunJgSPnPSENF4Ei7uCqduAVdqH8a4ei5F0
         sIFaq/yTUDL5xfDgAlPL3N9EC/VWjF4SNnLnjNsXpxhGAnBHaUlYkHB6fnHU/OOl64n8
         0sUqUNfdXBqb7QpZChsZqdvmkiNfJCtgsJ5Y0B2hmAaapWi/hWBEQtyUT4f1dh2zz9RB
         EuDA==
X-Gm-Message-State: AOJu0YyQ66o7OYSIcN+Ba/JlgCN8/lbJbF6L9vrQlgBybjWCAsnwlEv3
	JtwVJvYXoLRSpyLn2ONQU6tDwAeq5HRwqlKaUZc=
X-Google-Smtp-Source: AGHT+IFQahMQEIqv/er66u3KOIYu5ox9+pZ8qCZwDtxYY/lZjrZUUB8mdgD+XYxBeayuSAoL8sheCUR2Va1DP4vUTcU=
X-Received: by 2002:a05:600c:501e:b0:40d:5ce8:d3e0 with SMTP id
 n30-20020a05600c501e00b0040d5ce8d3e0mr21225wmr.11.1704768961127; Mon, 08 Jan
 2024 18:56:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJNi4rO+Dw5qYDtyJVbuo0OqAoXpGq_Qq6xjH9cvMCAUnW+77g@mail.gmail.com>
 <CAJNi4rMHtM=39jzkzwqt++kVpSp0=XfDrVdY94WoW6B34oKwDA@mail.gmail.com>
 <ZZb2f0U4qTWDjCGj@FVFF77S0Q05N.cambridge.arm.com> <CAJNi4rOpzmQAW1Fjst-Em=SQ7q8QsQh0PWhVxUizrOW9JukOgQ@mail.gmail.com>
 <ZZvS8rigFJR8L56c@FVFF77S0Q05N> <fb6c8253fd90e66c036a85954c3299bc2c047473.camel@xry111.site>
In-Reply-To: <fb6c8253fd90e66c036a85954c3299bc2c047473.camel@xry111.site>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Tue, 9 Jan 2024 10:55:50 +0800
Message-ID: <CAJNi4rPj0Wc7ByqrS-GVLUUEnOFPZi8A5nLLCEEJErqAe16EZw@mail.gmail.com>
Subject: Re: undefined reference to `__aarch64_cas4_sync' error on arm64
 native build
To: Xi Ruoyao <xry111@xry111.site>
Cc: Mark Rutland <mark.rutland@arm.com>, gcc-help@gcc.gnu.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 6:56=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> On Mon, 2024-01-08 at 10:51 +0000, Mark Rutland via Gcc-help wrote:
> > > AFAIK, the native build for the kernel will not link to the libc.so
> > > but the userland application does, the builtin atomic primitives are
> > > implemented in the glibc:
> > > target-host $ objdump -t /lib/aarch64-linux-gnu/libc.so.6 | grep __aa=
rch64_cas4
> > > 0000000000130950 l     F .text 0000000000000034 __aarch64_cas4_relax
> > > 0000000000130a10 l     F .text 0000000000000034 __aarch64_cas4_rel
> > > 0000000000130990 l     F .text 0000000000000034 __aarch64_cas4_acq
> > > seems the '__sync_val_compare_and_swap' used in the application will
> > > be renamed to _aarch64_cas4_{relax, rel, acq}. so the kernel will
> > > complain it will
> > > link to an 'undefined reference'. But interesting, why the
> > > cross-compile kernel will not generate the 'undefined reference', the
> > > cross-compile/build kernel will link to the glibc?
> >
> > This is due to a difference in default options between the two compiler=
s; the
> > kernel isn't linked against libc in either case.
>
> And even if it's not the kernel but a normal application, it still
> cannot use these functions from Glibc as the objdump output contains
> "l", meaning these symbols are local symbols and they cannot referred
> somewhere out of the libc.so.6 itself.
Actually you can call those builtin atomic functions in you normal
application without link time error, even execute the output binary in
the target machine in case of cross-compile, only if the linked .so is
in your target environment.
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

