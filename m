Return-Path: <linux-kernel+bounces-34585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7928381C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09F528BC98
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF95524B8;
	Tue, 23 Jan 2024 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODO6Ek93"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698484879F;
	Tue, 23 Jan 2024 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705973078; cv=none; b=sLc0ESrB3hmGErfdIFVVEbZIRnuRgdnQCQz96jsJN3oS4hDc8OiQWDmvW9OAXRcX86ouTfiMwcS/1KeguQQTnJGzes9Gyl6SKn/7v2Fkma0jWaHTdbGKADFE3VUGF8ttWfCpIS3W+oOwPw3hynBZ7MCGlEzX7l8+ToVcDtnvph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705973078; c=relaxed/simple;
	bh=4X+e/5eRr0/1QKFCJvN2/ZWmTmsoQ4uSniacJzukbrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGiPE7Fc9f4j3qjS4Qm6WJGkL/Bud4f1R4cdzsw5nN4QM4cC+TjjVwTqxSLO8gxB6ADLvfEV521QtKX6OtpGeTY0OIvuZMTeY69OS0Miw1IzaWAUm9Lx9EAeIlWnohw8Y+FJf8kPbwnhpGaOVXE1bqRNt6Df4k3p8bKPk+cvpPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODO6Ek93; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e0eb1cf1f5so843519a34.3;
        Mon, 22 Jan 2024 17:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705973076; x=1706577876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2t04bRrjEPqvRZY9vsZb+gHmac8X05fevidcqS/qug=;
        b=ODO6Ek93/eKBHfdR0+8nBKP65Xenlijagga0RSdYPcHM9TdWOcMIk7cq3kQ0cFnI0x
         UpvdpGF0CUEr8DMmoUnGdIbWyD+fftWG8kV3HvztzCfVSOj6HdQkNQjkFEGXqWGNvwS/
         OPjeH+ok79D62Vl+LZTG0fL+uDhw541y4eBp1XANuSSHyA3oFqYbRBMMMXsudia4lpd7
         UKmC+ofKv721aDEv0oTICzpPJ58/56i+ugaqfAD2oyE+/ve/WRj7e27GU7HxUik0rogA
         csbpG8C7tmBu47hv/2tks7sp0Qlb0Bty8JzAgizFFLTplDDrjFkWk3bp2c4SG8LyccN3
         ptBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705973076; x=1706577876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2t04bRrjEPqvRZY9vsZb+gHmac8X05fevidcqS/qug=;
        b=isRWMmoOCY9HGG+j7ZcTDNWoqxDe+sdgghFULy3C6eo2HsDcn3mYz1KoLcbVEh1RR6
         k/gPGbVBJdGuog4DqHyGHrWRDtrSRmFyJFIoubxWonuoC46KIPFmuEn8qV2sAGwMNWy0
         2/4Zj467WqG7MOah8nRbpNeP77oYjxaI9uZPqC2fEqUak4+NJkNpL5ENq3wsYklx5TGS
         a8PL6n5f+y/93BJo+qQtZ4xIiNz4B4iyZulGbVLMelRDJnycZRqScWkxQiuoCadt8/bP
         QVw5ywGnIqvSNAu5gJuEaqvN6XBrGnTDbxyNm7/s+kh01xYjizenKwV+a2gaSaOuF5cd
         sUbQ==
X-Gm-Message-State: AOJu0YxOUm9/oU9ffiQdBPiWkYTmXGn/diHECkEDFm1XuAKmRwHtoqTi
	is2FFfdO9D4vjMdlo8T/c4vcTjwarDD8XG5eoi/71GbO2xuh+KqDk5sAzLhWOzl3M6/Pa2YPoh0
	9e6Eybk2YvvfyVz0hGUco201TDZI=
X-Google-Smtp-Source: AGHT+IHyY3YAlXk1zADzHlDpVnX/XjnGBBzGqQKcyHspAZ/1NjdilCVSUG/kGR3Z1882PQbbKMdzT6m2GOHS5+Vb+Lk=
X-Received: by 2002:a05:6870:d1d5:b0:214:8a13:2025 with SMTP id
 b21-20020a056870d1d500b002148a132025mr29115oac.96.1705973075749; Mon, 22 Jan
 2024 17:24:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122080631.2880-1-qiujingbao.dlmu@gmail.com>
 <20240122080631.2880-2-qiujingbao.dlmu@gmail.com> <CAJM55Z_DFox9c_eDeHtx9H+9e4A6pjkCkt7po94j_mu-tQWywg@mail.gmail.com>
In-Reply-To: <CAJM55Z_DFox9c_eDeHtx9H+9e4A6pjkCkt7po94j_mu-tQWywg@mail.gmail.com>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Tue, 23 Jan 2024 09:24:24 +0800
Message-ID: <CAJRtX8SiVazctKcmbrM3qhooQ9J_yuSAuUAh-nSW+sk8NWKv2g@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] riscv: dts: sophgo: add rtc dt node for CV1800
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 9:25=E2=80=AFPM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> Jingbao Qiu wrote:
> > Add the rtc device tree node to cv1800 SoC.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/=
dts/sophgo/cv1800b.dtsi
> > index df40e87ee063..0cd7eb9a3048 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > @@ -119,5 +119,12 @@ clint: timer@74000000 {
> >                       reg =3D <0x74000000 0x10000>;
> >                       interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_in=
tc 7>;
> >               };
> > +
> > +             rtc: rtc@5025000 {
> > +                     compatible =3D "sophgo,cv1800-rtc";
> > +                     reg =3D <0x5025000 0x2000>;
> > +                     interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks =3D <&osc>;
> > +             };
>
> Before this patch it looks like the nodes are sorted by their address,
> but this would break it.

Thanks, I will fix it.

Best regards,
Jingbao Qiu

