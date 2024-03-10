Return-Path: <linux-kernel+bounces-98304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F54F87781F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317A81F21338
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6824D39FE0;
	Sun, 10 Mar 2024 19:12:19 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8746E39FC1
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710097938; cv=none; b=toXQzd0xyr3Du6SE1JQsDp39IfOoH40G07KNOoSRdVuWGhC7PYL6TMPhHW6ygmT47y7CG+8wcLxbNj8JNMgcdxKol6xt6EKz1kYKZLZjS/Webj7yiA6NnX1WGFlVdCW8JO/wb78IrB+OeHXRZvOI9+LsxBqlilMQFT+qcXF8ycY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710097938; c=relaxed/simple;
	bh=C0t0ECpNR2i0GS6Lmtt011ZFYoHERkN5L7Xt/3JJ50Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cn/J7HOxyUMkTc+KxwuhkSjxY3iE3uSHpAslff5lxOp70Ul0zFLLg3dlA9aTcMG1umff2qZtkDLb1+rleLEwwOZOYGbPAPRXIX2RnyJzCg+DVo/Sl131SZPRSxbvPjRauyqvSxBXdaywYcSJvleEW7CcWSeGjera045FljbfGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-609f4155b76so30985457b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 12:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710097935; x=1710702735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqlIXrDqVQwCZFArlxmjiPSGp1jODqDvdYbh7qpVWTs=;
        b=XI7nqc22tmNyp+RMXWwXwIPx0i98ooLBuYoIkqinAMovbhTafPC4Ayp73tRb+km5rp
         qfG5FztyxyMPtyzrGX0N6sNoD/zK0eg1S+e6S+M1CcfLf2i7OD9bweJIqBOOnhZPjkQV
         HUg0L2ozfZGGka5YzgXbwXyV2SIfQFDK63VTJKIqz9ztgXfMxyqKVYrolW/kFuz83RXX
         EORJzvWmiMnpZkrwztjdsp19/n17kbvGyhnEbMDPOo+lMByaOGYfsHEuMR7nEB+ARquj
         25wmbeM/5c8MyMhqYA0M5oHfPveL8C852IACj6knIR4pPY3r0v2ZZ+vAnLs0zLnJI0Wm
         SDDg==
X-Forwarded-Encrypted: i=1; AJvYcCUCa7fIa+OeYvSoRzf9aut3xTOvYnZRNNsxNBRhbYmMHfExT6kEix7vtyyPAvZ88OT9Us8FQIKin4O/ai9P1A7Ytxwjx4W34xgE+Gpk
X-Gm-Message-State: AOJu0YybFbDRd5YWpx/wjfYzwjH5vYjF9p/6Uy6w16lHtFxkDMRwYYuC
	mzdPN64QfJNxCyxo0R0eQVOk7+zbZJEm2E/6rU1/hU8YDM6XHOYi1Mdbltyt68s=
X-Google-Smtp-Source: AGHT+IE604WXQcDAsVg6sDJse9ByMNDKwaFQwBQnF8rLGlSNWeOEmXAvYqAsyYR1fJBOx09VTUn/pw==
X-Received: by 2002:a81:4ed6:0:b0:609:eb88:cc0a with SMTP id c205-20020a814ed6000000b00609eb88cc0amr3769937ywb.17.1710097935103;
        Sun, 10 Mar 2024 12:12:15 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id df6-20020a05690c0f8600b00609782a19dbsm914681ywb.18.2024.03.10.12.12.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 12:12:14 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60a0599f631so16658577b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 12:12:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+Rozg17qXY6190bTmx1jaZ0jVAeya8yMivtNAnD/gXVWOXdpYrx9x/PLZszN45VQ6fr/hG7LzNkBTavLpjpy/iux7Q8u1N3U92eiE
X-Received: by 2002:a81:6fd4:0:b0:60a:470:d1bb with SMTP id
 k203-20020a816fd4000000b0060a0470d1bbmr3998705ywc.20.1710097933601; Sun, 10
 Mar 2024 12:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306184244.754263547@goodmis.org> <550b6c44aa434b5b91e999a8d073527c@AcuMS.aculab.com>
In-Reply-To: <550b6c44aa434b5b91e999a8d073527c@AcuMS.aculab.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 10 Mar 2024 20:12:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUWqZ99vqqgm_qWtuLN0ndmk4oxEEAvBP+mNbCz5ckq6g@mail.gmail.com>
Message-ID: <CAMuHMdUWqZ99vqqgm_qWtuLN0ndmk4oxEEAvBP+mNbCz5ckq6g@mail.gmail.com>
Subject: Re: [for-linus][PATCH 0/3] tracing: Fixes for v6.8
To: David Laight <David.Laight@aculab.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Sun, Mar 10, 2024 at 7:16=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
> >   Another issue that was brought up is that the trace_seq buffer is
> >   also based on PAGE_SIZE even though it is not tied to the architectur=
e
> >   limit like the ring buffer sub-buffer is. Having it be 64K * 2 is
> >   simply just too big and wasting memory on systems with 64K page sizes=
.
> >   It is now hardcoded to 8K which is what all other architectures with
> >   4K PAGE_SIZE has.
>
> Does Linux use a 2k PAGE_SIZE on any architectures?
> IIRC m68k hardware has a 2k page, but Linux might always pair them.
> A 2k page might (or might not) cause grief.

Linux/m68k supports only 4 or 8 KiB page sizes, depending on the
MMU hardware, cfr. [1].  While the MC68851 MMU also supports page sizes
of 256 and 512 bytes, and 1, 2, 8, 16, and 32 KiB, that is not yet
supported by Linux.

I really doubt Linux will ever support pages smaller than 4 KiB...

[1] https://lore.kernel.org/all/20240306141453.3900574-4-arnd@kernel.org/#Z=
2e.:20240306141453.3900574-4-arnd::40kernel.org:1arch:m68k:Kconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

