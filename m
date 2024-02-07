Return-Path: <linux-kernel+bounces-56176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D92084C701
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29089282DF5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F796224EF;
	Wed,  7 Feb 2024 09:13:50 +0000 (UTC)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6B22309;
	Wed,  7 Feb 2024 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297230; cv=none; b=C3xcTpez7ySs7T+922ULQP0kQxrRZUz/4h6NB339tUUGfGyv4WKiHN4jqi3i/nHtJ/XgrJZpRBAnATE3BPNNktmyITfjxMe1R9szaFPZkI9L9aTp3Pkvsl8iVkErCTMfHWO3YHyaSbMcK/OJ/zU3PKsjpJAMCVbGq8dfiWCpx28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297230; c=relaxed/simple;
	bh=TqmxnL7LhKGRFaus9OcZ6Eu3Xvu+lsumuH85X4Jj9qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBFi3LDZDIu/BkpML+XiEZAD0fuZCOJQ6XtZdeztt0GAPkim0AzZ1FMh4f8C6M1VG6nRiAmGXul/ahho18uRhSa1jS8sQcZhEHbMKq3Jte4QapVyCkhNKmF1qI+EymS/ujVFoZrUVAxnS2ptKP0hZkTFb6wN8XXilx1ZgvZWzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6d94b9961so348756276.3;
        Wed, 07 Feb 2024 01:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707297227; x=1707902027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eg3v7z1mB1AjuBlJK36dadneR0u0gyBpWirpxI2xans=;
        b=I8xUGjZEOmVM7XjmboCxlNx8YmfwTeyyfDdZj9FFBKNhpeLli/s2xQ7JYY5diXLGnz
         apJKFVYZ6spBK9cZ+YsplNqQgDUKF0iUvLVu1N9WkrZykHQJUwjvUrcc/KxuIwc09glT
         7d0zgJMGZ5bHruXtwf4I715+JW7pbNW6cew+0EM1um1Ufjuoeh1EpuQrUoFpmLiPbWg2
         CfBE0nqrwia3rChUaZ2hgJT1V9yoCfOecqSVVaC7ROMwl/e0DJVUKhWN+35gEBTZn26r
         tZUBMEwPVytQ7q+QNEwGQhSWikv7uSDZa5P0s10Kb8xo4j4Kkz00Lfm12PVGm93ao4kK
         4QOg==
X-Gm-Message-State: AOJu0Yy20ecT6glK4IPGNmjo6ErVsYmuvSM2GlRWo5R718frUkLll6pf
	Sfg26wf3+eEysCXoeX/s3naTw43EgO4ke8paCpuVyOMxxRKZYJSahdOOPN/RxFo=
X-Google-Smtp-Source: AGHT+IEhMNuzZ2ZZ39P/sIpAG50u6k540KMC2zvDnMhDPcuh42e2t0YlNxOe8auveU/stq7mJZq3ZQ==
X-Received: by 2002:a25:8284:0:b0:dbf:ec4:311f with SMTP id r4-20020a258284000000b00dbf0ec4311fmr4325322ybk.58.1707297226775;
        Wed, 07 Feb 2024 01:13:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQcKBlbOWpzDn+O5Of/vJ6zmF9MagJ1hsI5m8UQ40wd0GP96hQEZih0Qh/kHS9SiS9CiK3E8NoNtrgGNNZRlYOYpGyJCBwTTXXnylFfHGE3bTMcEk8AvnXa6Z+G9CzDxeG1r8ofzHZ120uS+1W
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id a5-20020a256605000000b00dc36ad3af97sm146291ybc.50.2024.02.07.01.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 01:13:46 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6d5206e96so369576276.0;
        Wed, 07 Feb 2024 01:13:46 -0800 (PST)
X-Received: by 2002:a25:84c3:0:b0:dc2:65da:d3af with SMTP id
 x3-20020a2584c3000000b00dc265dad3afmr3965372ybm.65.1707297226259; Wed, 07 Feb
 2024 01:13:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e01cdb99-8497-4fec-b423-a0bfb483ac75@web.de> <324d4e02-6a5a-4112-a3a7-d7aeb5876acc@arm.com>
 <596b3bda-3bef-4e28-b9dd-08b96da97097@web.de>
In-Reply-To: <596b3bda-3bef-4e28-b9dd-08b96da97097@web.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Feb 2024 10:13:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXiszyYM0kc0iqSTDLAXKg_AKmYdc51_8oNwpQUbOWcVg@mail.gmail.com>
Message-ID: <CAMuHMdXiszyYM0kc0iqSTDLAXKg_AKmYdc51_8oNwpQUbOWcVg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/ipmmu-vmsa: Use devm_platform_ioremap_resource()
 in ipmmu_probe()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	kernel-janitors@vger.kernel.org, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:16=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 6 Feb 2024 15:00:23 +0100
>
> A wrapper function is available since the commit 7945f929f1a77a1c8887a97c=
a07f87626858ff42
> ("drivers: provide devm_platform_ioremap_resource()").
>
> * Thus reuse existing functionality instead of keeping duplicate source c=
ode.
>
> * Delete a local variable which became unnecessary with this refactoring.
>
>
> This issue was transformed by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>
> v2:
> The transformation pattern was adjusted based on advices by known contrib=
utors.
>
> Examples:
> * Doug Anderson
> * Geert Uytterhoeven
> * Robin Murphy

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

