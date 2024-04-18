Return-Path: <linux-kernel+bounces-150347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F438A9DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478101C2217A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA29116ABC2;
	Thu, 18 Apr 2024 14:57:04 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2063238F94;
	Thu, 18 Apr 2024 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452224; cv=none; b=oP07qmWYvlTXcUNb/2Fe8A8UuOn2v3BJ71Ezc1r1NrpoowZ4A6BmVdG/qZKN3YwAsFOSqDKSNdhAjcKdJJT5aUt6fg5qhzUHmO6mXeQP8YcZiATEP1Y9ZKgOVfBs++tUUm8LlQ0ERNXjz9Q0PBEwX8xChxCSjSqHp10rLI/Ie48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452224; c=relaxed/simple;
	bh=99zFdr7f7pW36moWRYjqx7oFdIfJZDCDZ7X565EDoEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P73DmJYE3tSstCdHAQoUAAO8R04xBsgXkOXvOwulPtv2m51EMHMyiLZn5JXVuovMt/dkkD/Zwwbvhws5elOzVwS+iD8DMWTHLJjBLTJGzFvWSWzKZp2Piy5RmXV0lp117EIrwewYud7x/rT7wROG5Bgx21P+S/0AxvwvZAYp7SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61ae4743d36so10570847b3.2;
        Thu, 18 Apr 2024 07:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452221; x=1714057021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xr9Tyh0ygfrfVF1SBXD1C/Nz/HkQ5oZlmuTTcyMKogs=;
        b=XZ2oBhmwaHg7Bm1C2Klgo1AciiBIk5eOqnFgpeJmoHv4E1Kcs/vDanBt7Wwnjw8GI8
         s45Wzckql9WIAKa56epood1JsbMPrQxDKQXGDST56nYqca6ejnW82q6j8b1/NJzNN0td
         p2KvQhY3CIImJcM84AJ1A6igUAsb1eKm5/hpSdGkL34VC1h521ey26NGQ2Rtz3jWOOjH
         elUIXSeIW3VRVHIyXXATcA2fTg+jB0w+gvBhIrNMM9/HLDvWZ1FpXBe97vI0LOoqjciS
         UgUDqbaJA4QJ5UwDO01Sb0G9UMRJbVfAAmIjs4bdAb8oTsGdwOAibU7cDE/LXQPTZ+kY
         m6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+OIHCKI+A0wopQEG1Yg/2VO54uF9ivHqOBW4UUsJVPINUgppJbYm06tkoRGJuebfKtDqQdRT0iKTtjCESibu8HUKJm53+PBm6ylzW57ctoyQy6Ljzlxv6gQAUplzkbIeRmY1Df8GQI24nnaZLK/+XRZg5sY0olR1D7KLGd8JjTIh2hzrwaV5upM0=
X-Gm-Message-State: AOJu0YyxEHPQWetUyBsaWvk4sK0kjQRGweZafpmKF4thLoFjawLUQ4S/
	ykV5pw9a1pt+fIF8C/8IQNn72jvRxk1sgWrMfI99vLxblscd8MkRcdTIEM0V
X-Google-Smtp-Source: AGHT+IG+YIuRzgOgaut4xtN2kTcFx3Mn1DLKrirWi+ONk0n2FmtHn//lWh5Q3mQLOO8+jG7I08A2xA==
X-Received: by 2002:a05:690c:6d8b:b0:617:c383:42ac with SMTP id iw11-20020a05690c6d8b00b00617c38342acmr3176488ywb.51.1713452220937;
        Thu, 18 Apr 2024 07:57:00 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id i126-20020a0dc684000000b006158165c606sm364587ywd.136.2024.04.18.07.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 07:57:00 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1038914276.1;
        Thu, 18 Apr 2024 07:57:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkrlBZAydSblHHNu4C8glS6BOBXByEKvc+JuVobIT+g7sH8rJq7Ci+hcybj991VokrqizlV1Rj3FJBd/Tj3WGwB5UsZp4h+PauOtMq9k8Re+4MW2k7MGYgjl7mLivRszy92fcm8R2VyZ5I538TkKodECvCIYxzbO65mGhn/wF0z0Qq+xgvQX1JL3Y=
X-Received: by 2002:a5b:902:0:b0:de1:1af9:c7ea with SMTP id
 a2-20020a5b0902000000b00de11af9c7eamr3334836ybq.1.1713452220525; Thu, 18 Apr
 2024 07:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403200952.633084-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVN_B3xhNnq1=NOs=LmWw3P=dJGr0MhQMdqsChQ=VXWLA@mail.gmail.com>
In-Reply-To: <CAMuHMdVN_B3xhNnq1=NOs=LmWw3P=dJGr0MhQMdqsChQ=VXWLA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Apr 2024 16:56:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV98b2DR1P380JqAaJ_DhB_ZB=31sVA1pg08biKGHwERw@mail.gmail.com>
Message-ID: <CAMuHMdV98b2DR1P380JqAaJ_DhB_ZB=31sVA1pg08biKGHwERw@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a07g043: Add clock and reset entry for PLIC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Thu, Apr 18, 2024 at 4:53=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Wed, Apr 3, 2024 at 10:11=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add the missing clock and reset entry for PLIC. Also add
> > R9A07G043_NCEPLIC_ACLK to critical clocks list.
> >
> > Fixes: b3e77da00f1b ("riscv: dts: renesas: Add initial devicetree for R=
enesas RZ/Five SoC")

That is not the correct commit, I'll replace it by
Fixes: 95d48d270305ad2c ("clk: renesas: r9a07g043: Add support for RZ/Five =
SoC")
while applying.

> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-clk for v6.10.

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

