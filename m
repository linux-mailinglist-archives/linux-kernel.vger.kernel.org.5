Return-Path: <linux-kernel+bounces-111380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B427C886B83
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68961C2162C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493563EA9C;
	Fri, 22 Mar 2024 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="nt1burzF"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34903F9C0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108215; cv=none; b=YsmV+ETJr1hIzi2dpUYSzEOWvwuD70WGJVkxspBv0gRmjcHruKcgs2jID5pKiA/9rtq3JFPn4mY2snwlUq1GOGWsDzMTnJQlIYBDzzPio9LU3PBw4kTjhAp81Wg3rlJfzbm8yfHIanswJtCY8UwlRFa1FyQBpHakUn8V8Bvk4Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108215; c=relaxed/simple;
	bh=5YnioGWbsAYLJyZb8b9JHmg6YRFPts9BTqRF1ogmYdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWtlqPvADYI+cOjtnoTVREKkX2vHje0DJyOmoUUFSg+9jdsLVJRrOTe7QVyaS/NFNFv/MgYJ3A5wIVA4RxG4Z4sGVhvNoJXiTjQS98NmS2Hq/2Jr3nfkW40JPebqlIjRelsMkSo3IKd+wcdRgKeOGZgcv5NHFnRFAECBsStzf48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=nt1burzF; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3684faf6286so8667155ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1711108212; x=1711713012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAx2I7XvDqzXQw6wtmJmpS8c3rKWDIhE+rLvewBuwrM=;
        b=nt1burzFz5fEafBsl9ivjan1KrJ5xBuM/A98s7EnLTh+jPBZYuwPiUi5DKfGgJA0q8
         gNVZu1Qiw7aA0agLZvm3x+cvun5whqfQWetfd1sJ6OpnKg/FNXttn0pO2wzm9lzqgh8k
         GLYRvRdtg+lU0cxV44E4vnJ37R0A6yS6y5D5c8SIDf3tkAZbCtq5ReAMrBb1K7vSRzqp
         gF44gO58cCxhMjMDUPRtykTSYviG1efpIANp6BSOIlahrHAdDf7veCr3dfcodoWMxd6r
         vgUNeIpLuugp9SI3qFrf2i68f3fmcqDvS40Dry4BsRfqfjakdrN7XoqGLli9E0o8DOrg
         /OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711108212; x=1711713012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAx2I7XvDqzXQw6wtmJmpS8c3rKWDIhE+rLvewBuwrM=;
        b=PSyheH4Faz/otdiNaHkq3CJUNyIMiUwMIFuv4fCCWskU3cMiwLhaBDRNCcmNWVDCqH
         t/icBhOTT/t+dwv639qHp/A0PaHt0+1NH5Kls76hqda39aUhKd3sXjU/0oyHVbYJDMUH
         G8SK5mpgEXznLwlQL9VmCjRlPXKCpDHUObZ9GcV3AaqhozvLU7R0P+5ZVDfVNBWCzcu/
         O2TmfgAahx62BAYhPsFvl68LjBu7dmiFQuDjyO9025x7zF0rX0UYiCxTY5yM5k/LKb4j
         JShO7t3Zztd71VGR+4srmmS4iedyC4kuBb+cLnC/alrRhy1xDj28zIidi3uh8pInhdX1
         9j+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6syZM2NcIpwzwadTTOiNLe2CWYf9wRYiO4qx5BGQJI60lCXpsfpET8iK0JqSEhX8whywYgXqXhiH82nCH/I19wUKwt1l/64IPWhvZ
X-Gm-Message-State: AOJu0YyyU8y1D6aPe964dpCngBK5JXh6TCyrkwg2R1Yf+SEPqDG9oVYb
	guAACvqnfaOLYuGpE3f4ijxDfUh5CEJGebJ4hdcfnLS+GhPRzS5IITnBLIR8kbZz8CYGZn4vpnM
	AvuzNhbfpTyFVAdc3eJLgq1ferSXAJ+J4sowbHA==
X-Google-Smtp-Source: AGHT+IGc1Lk3igmGbpYPTMkvVjrig10NalqBLgFeStlCj29E23ErhBLOEWZu+ODvVKrcfDcGJtCgMDHVzrFWhsAZCSE=
X-Received: by 2002:a05:6e02:1a24:b0:368:4d28:5d0c with SMTP id
 g4-20020a056e021a2400b003684d285d0cmr2444188ile.22.1711108212026; Fri, 22 Mar
 2024 04:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321085041.1955293-1-apatel@ventanamicro.com> <f44de7d9-e03d-483d-96d3-76c63158061d@gmail.com>
In-Reply-To: <f44de7d9-e03d-483d-96d3-76c63158061d@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 22 Mar 2024 17:20:00 +0530
Message-ID: <CAAhSdy1HnzB5T0G3dEfuVX1LHCMy6H4B1paQyCKC-iXTJ_Nf=w@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM RISC-V APLIC fixes
To: Bing Fan <hptsfb@gmail.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 5:05=E2=80=AFPM Bing Fan <hptsfb@gmail.com> wrote:
>
>
> Hi,
>
>
> As you mentioned as below, riscv's aia patch in
> https://github.com/avpatel/linux.git
>
> Why is this series of patches not merged into upstream?

This will be sent as part of Linux-6.9-rcX fixes (after 1-2 weeks).

Regards,
Anup

>
>
> =E5=9C=A8 2024/3/21 16:50, Anup Patel =E5=86=99=E9=81=93:
> > Few fixes for KVM RISC-V in-kernel APLIC emulation which were discovere=
d
> > during Linux AIA driver patch reviews.
> >
> > These patches can also be found in the riscv_kvm_aplic_fixes_v1
> > branch at: https://github.com/avpatel/linux.git
> >
> > Anup Patel (2):
> >    RISC-V: KVM: Fix APLIC setipnum_le/be write emulation
> >    RISC-V: KVM: Fix APLIC in_clrip[x] read emulation
> >
> >   arch/riscv/kvm/aia_aplic.c | 37 +++++++++++++++++++++++++++++++------
> >   1 file changed, 31 insertions(+), 6 deletions(-)
> >

