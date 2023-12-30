Return-Path: <linux-kernel+bounces-13311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9771C820355
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 03:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AFB0B2219E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 02:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BDBB658;
	Sat, 30 Dec 2023 02:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jZGNaKcM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E6B651
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 02:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5eefd0da5c0so21287147b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 18:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703903451; x=1704508251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zi7zPeVB3x2mGJ1Nu2v7GBTLEy5HH9AALnbu4XFSRD8=;
        b=jZGNaKcMno1yrsTZbTucehVAg0hhqlcSaF1W29ZNUxV/1cwrCIavCtFoBjJ0plBNP+
         4cRdcKBvRNz6Smqcnh4SExXLQ3HBXAm2COKRs+W+TDoVLg5Q0nES1yEgmRLrUK9awsvH
         AIu1/gfqwPG4El9mJu/HgHcnv0+CHvZHsj03jujetBvUwqNztkiyfz5qQQQ2WeRUF1SF
         rlI4bydNkF35dvYK//GE3prObd3ts7Mscgc7F/bVhkE3/A3HUKe8NazWrW3Vy4rI5VX9
         ihp37zX67KfoAgrNwWRYLJjZy5qY52gVWGcZ3G+zag7xc21ruhhCyo1Lq5ZOhRJpof60
         NZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703903451; x=1704508251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zi7zPeVB3x2mGJ1Nu2v7GBTLEy5HH9AALnbu4XFSRD8=;
        b=syyiVplFu6KBlIUb7nQMRRqc9zMidqd+6aqeoifENyeUc8zUxX1cjS4sHSrLqOmN5y
         VZLy9kck9KPrS2a9mqnOdAoXnBoDekpUVEd0lZC8/HFIHvl9npCVxaWED0a3jXm+0F/1
         CIr5pzL0bv1ylKxe2E4rABhyRB9EC/1TMChUuooq5RAaA21uS5ozjfwlbQ8lSvgyvEtO
         6fD8k+yssP3pcSSBRPxl1nC+yGhH64j0uH74eZLZOdAjUUOj/qzwXI9Sfi+oX3pVXtvy
         m6iE9WpVnRlP9b7uaoiYH+4LWBI6qSRp6DfXLBYLvmiYDWVZFClxVvdMMhQlyxsV7Igp
         bgcQ==
X-Gm-Message-State: AOJu0YwwNkd3fJIVqPAblAnTB2vIb8dAV11XPdYRkNWRQCvkCVBBHOJR
	M4mH8eUmHuRQp3LIM0D+GY/P7ud92nEgzAVejdNcDZr8QDh4kQ==
X-Google-Smtp-Source: AGHT+IFIZhu7nrGBZ7lGSPHP5/PBJHTcxsM11IKduP4jZ50sNyU/5ZWTHQb4Xxkd/JSjq8K0ZVaiUYv5KetvFgnbmJQ=
X-Received: by 2002:a25:d6cc:0:b0:db7:c8b7:3f1d with SMTP id
 n195-20020a25d6cc000000b00db7c8b73f1dmr7030642ybg.19.1703903451078; Fri, 29
 Dec 2023 18:30:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222235248.576482-1-debug@rivosinc.com> <20231227134514.13629032c39decdf1dddcc75@linux-foundation.org>
 <CAKC1njTry42zAkZWq3pAgoe3YFaHN6UcB4i56BDQRxYbTEigRw@mail.gmail.com> <20231227142441.f9a76fa3c8b9b79eea8f93a2@linux-foundation.org>
In-Reply-To: <20231227142441.f9a76fa3c8b9b79eea8f93a2@linux-foundation.org>
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 29 Dec 2023 18:30:39 -0800
Message-ID: <CAKC1njTPBqtsAOn-CWhB+-8FaZ2KWkkz-vRZr7MZq=0yLUdjcQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm: abstract shadow stack vma behind arch_is_shadow_stack_vma
To: Andrew Morton <akpm@linux-foundation.org>
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 2:24=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 27 Dec 2023 14:20:36 -0800 Deepak Gupta <debug@rivosinc.com> wrot=
e:
>
> > On Wed, Dec 27, 2023 at 1:45=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Fri, 22 Dec 2023 15:51:04 -0800 Deepak Gupta <debug@rivosinc.com> =
wrote:
> > >
> > > > x86 has used VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) to encode sh=
adow
> > > > stack VMA. VM_SHADOW_STACK is thus not possible on 32bit. Some arch=
es may
> > > > need a way to encode shadow stack on 32bit and 64bit both and they =
may
> > > > encode this information differently in VMAs.
> > >
> > > Is such a patch in the pipeline?  Otherwise we're making a change tha=
t
> > > serves no purpose.
> >
> > Yes I do have patches in the pipeline for riscv.
> > On riscv, presence of only `VM_WRITE` (i.e. (flags & (VM_READ |
> > VM_WRITE | VM_EXEC))
> > =3D=3D VM_WRITE) would mean a shadow stack.
> > And yes there would be  relevant patches to ensure that existing consum=
ers using
> > `PROT_WRITE` gets translated to (VM_WRITE | VM_READ)
>
> OK, please plan to carry this patch in whatever tree contains the above.
>
>
ACK. Thanks

