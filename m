Return-Path: <linux-kernel+bounces-70250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314E285953D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A0C1F21AF0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5AEDDB8;
	Sun, 18 Feb 2024 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZzxHJio"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C30538A;
	Sun, 18 Feb 2024 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708240735; cv=none; b=lTBRP+ttjmPvaB4STjWVxuDvf2t9smqRz9cAZG9sZurcedlC3LdHtFJXpmLkRnGMkqWQ9rp2INe4MpQpYC+KMHTneU3MCW0/hWLSG5NRmSQJA6W/1KUtwoekSaecSA09yt47zZdKxrrk7LvWadq2znUqnu8OFXH51pj4ERkX1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708240735; c=relaxed/simple;
	bh=LZqwQjxc3WNdVwQL0IszZ+L7hR2FgLuF54Fz0u8hoCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9Q6nUQ2KyRQExTv4V/5i1JgVRh1sNFecZdwaIq2MQ/17+7eiHZk8kWWr/q+F4vPbbGkgekMHvpS9P5XpZeobiisNlYhjm9Bl/G2tlJh+UAMcwk30oCygBJ+TmI7QPYVT4uqFAbNoIZVLj5LPXuW5WzPo3VNfKzFcSwqtLAnu10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZzxHJio; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso24678291fa.1;
        Sat, 17 Feb 2024 23:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708240732; x=1708845532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoMtWxcRWAYRMgAR64TH67exXWHzzjC76RrscHy/AZU=;
        b=FZzxHJioI1eIltVbo9+0uGw7GA16nlOfOhKqN54WVPzsMW7jhx/2vbTa1ZIbvJo2f9
         JdUQHkXwFbJvEVQvXImEKdm2kLUaTPEjgQGneGLiPRDNLou2efL5Gh1H7P3205Mm4A6a
         zD+TQ35t6ZpEZl+lVW11bLQOWUe8kS2KKERQssyJ4LcMLlyW5pmzu1kAh93aXAXlGZbs
         kFptBd1ZNXKT06r6NnnNu+R2u29YjWhBxocGGsSYamBFMNoM33VbnUWO7nfwcX/WZvkw
         oyio6RmeR+p3JOkEWfvYiGe6ilhRwRIsaa7JSB1PDlAetIQrhPMXwjU7I4ATRplAoVnj
         BeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708240732; x=1708845532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoMtWxcRWAYRMgAR64TH67exXWHzzjC76RrscHy/AZU=;
        b=bCd20QYmpkEpDzHkW9oYWcNNZbGWYYh6PWyTRFYJgyiKvQ0//I5zs0kQUtob9fiTLf
         Mvi/eEecnAcOifu0Gbtc4DpXUpDdqKh7itD7RkGiY28vRTyKEf41flqlC5CTFwg62Lmx
         qpivRzLWNqqtbB1SMCZBU5ldBuMEoHocpN2Na2YWw3Kn3q36hTdux6Z60gAe1UYkBEFX
         iUaAlJxB07pYfyY7bVwHsgsXT6A4Nv4YtCeHlMB3qgxxRfpWpRAa6TrRpoK/fUtNJUiV
         nssi3rn2Rst2Y/pY+BHLJkt6b6y+O1J9D33XkhUgIm+/qrDaFHwc0cdd80FkLzvKCqfi
         x2hw==
X-Forwarded-Encrypted: i=1; AJvYcCVrRKm9HZmfaCdnlHPewC8WlEppN0A0Tw1uENrGzvhZzCcmmc9ObzgkvR0zcFC+wxxsxxTkF2DfnYVTxEX63A2TltH0967MqNCc/5pfdjRmd68F04aCFOAcEdQaNnigCb3sWnIwJCBnJg==
X-Gm-Message-State: AOJu0Yw/nsaF7AI+mtTG8Yvckifh1Stq80vM1ORuNjnhmbwLA2SJ+Z5Q
	v6AT46dNfU0dZyDAdNHZGFwrhQDK4ndIhiwuDizBfKSDYaAfzjSldVrPcVsGePo+odf/e0TXO88
	VRimbGuC6xjyurA6JDnmdSg4He/3Lz5BDg7JavQ==
X-Google-Smtp-Source: AGHT+IHXsKbUAnLaswlubkUVSjxcVITALdr6/5cxflDhuJ4pVB97a4rXUaqRixc+Hik3Kiz0Skp1uw1ULPxi43uK5xw=
X-Received: by 2002:a2e:a686:0:b0:2d0:9324:aab3 with SMTP id
 q6-20020a2ea686000000b002d09324aab3mr5869682lje.30.1708240731756; Sat, 17 Feb
 2024 23:18:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706603678.git.haibo1.xu@intel.com> <6473e0bb42524e4f29112290a92539d1a800eb69.1706603678.git.haibo1.xu@intel.com>
 <CAJZ5v0hC7gxoJK0kszw9GgRjxjrKgh7q0sC1L1FdVfOb-TCSRw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hC7gxoJK0kszw9GgRjxjrKgh7q0sC1L1FdVfOb-TCSRw@mail.gmail.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Sun, 18 Feb 2024 15:18:40 +0800
Message-ID: <CAJve8omH2NvqnTu2a2V=wwrQCiQrP=uzu3ttO1VkjJN0ZyRjMA@mail.gmail.com>
Subject: Re: [PATCH 1/4] ACPICA: SRAT: Add RISC-V RINTC affinity structure
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, sunilvl@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Anup Patel <apatel@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Baoquan He <bhe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Chen Jiahao <chenjiahao16@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	James Morse <james.morse@arm.com>, Evan Green <evan@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 9:31=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Jan 31, 2024 at 3:18=E2=80=AFAM Haibo Xu <haibo1.xu@intel.com> wr=
ote:
> >
> > ACPICA commit 93caddbf2f620769052c59ec471f018281dc3a24
>
> Not really.
>
> > Add definition of RISC-V Interrupt Controller(RINTC)
> > affinity structure which was approved by UEFI forum
> > and will be part of next ACPI spec version(6.6).
> >
> > Link: https://github.com/acpica/acpica/commit/93caddbf
>
> And this doesn't point to an upstream ACPICA PR.
>

Hi Rafael,

This patch was generated by the acpica/generate/linux/gen-patch.sh and
should be merged
through the ACPICA project. To include it in this series is just to
serve as a reference.

BTW, the corresponding ACPICA patch is still under review and please
refer to the following
link for the status.

https://github.com/acpica/acpica/pull/926

Regards,
Haibo

> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  include/acpi/actbl3.h | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> > index c080d579a546..5202e3fc9b41 100644
> > --- a/include/acpi/actbl3.h
> > +++ b/include/acpi/actbl3.h
> > @@ -192,7 +192,8 @@ enum acpi_srat_type {
> >         ACPI_SRAT_TYPE_GIC_ITS_AFFINITY =3D 4,    /* ACPI 6.2 */
> >         ACPI_SRAT_TYPE_GENERIC_AFFINITY =3D 5,    /* ACPI 6.3 */
> >         ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY =3D 6,       /* ACPI 6.4 *=
/
> > -       ACPI_SRAT_TYPE_RESERVED =3D 7     /* 7 and greater are reserved=
 */
> > +       ACPI_SRAT_TYPE_RINTC_AFFINITY =3D 7,      /* ACPI 6.6 */
> > +       ACPI_SRAT_TYPE_RESERVED =3D 8     /* 8 and greater are reserved=
 */
> >  };
> >
> >  /*
> > @@ -296,6 +297,21 @@ struct acpi_srat_generic_affinity {
> >  #define ACPI_SRAT_GENERIC_AFFINITY_ENABLED     (1)     /* 00: Use affi=
nity structure */
> >  #define ACPI_SRAT_ARCHITECTURAL_TRANSACTIONS   (1<<1)  /* ACPI 6.4 */
> >
> > +/* 7: RINTC Affinity (ACPI 6.6) */
> > +
> > +struct acpi_srat_rintc_affinity {
> > +       struct acpi_subtable_header header;
> > +       u16 reserved;           /* Reserved, must be zero */
> > +       u32 proximity_domain;
> > +       u32 acpi_processor_uid;
> > +       u32 flags;
> > +       u32 clock_domain;
> > +};
> > +
> > +/* Flags for struct acpi_srat_rintc_affinity */
> > +
> > +#define ACPI_SRAT_RINTC_ENABLED     (1)        /* 00: Use affinity str=
ucture */
> > +
> >  /*********************************************************************=
**********
> >   *
> >   * STAO - Status Override Table (_STA override) - ACPI 6.0
> > --
> > 2.34.1
> >

