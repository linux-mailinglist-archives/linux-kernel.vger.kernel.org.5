Return-Path: <linux-kernel+bounces-91921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA159871878
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB221C221B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A1E4F1EE;
	Tue,  5 Mar 2024 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeBIww6g"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBB24DA18;
	Tue,  5 Mar 2024 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628162; cv=none; b=CJDvhMjtETDp+M8zjzBw3PU/1THOYh2otKxtvCD6elFmzRxb5QYvFXphgZmHfs/YpkiWxxatXkKsX8TE5NuYwTDfNjTS3oqPqTJFOi84XHNBC2z0ier2OeJljKicgpc3+brf/A3D0HFOb2x3Q8JC4dj2ww4QcDP0nMW5/nS0ORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628162; c=relaxed/simple;
	bh=mEeddxrjFkmA6mwZyPNUY/CC4aHVGrqxynRg91/k4TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CE7u48+cSeR5vbFH/ZXJozyg52KXeV+58qussBclYDTPb1+k2MLkkK3kYnGjY4kVn6YnBKHaJtmf4tO26hWySBkdEK+T2Qg5oEtsSyvh2R0Z+6u5OHZM8yHB3hxvgAoGAbqxjxG0UrFdcjhya5eRKBosjPZZXBLPLm+9rXKRinY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeBIww6g; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d09cf00214so67408571fa.0;
        Tue, 05 Mar 2024 00:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709628159; x=1710232959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/6peNBdk69VycNv0NnzT94cpIyuuvaLqCVKnWNPdGI=;
        b=VeBIww6gEng+x0mmI57jIoDwWaO84Ll2SYDjBMNUTpd/z0s6nhf9lwXTLbu5GxBhX6
         luRAAJWYalsNT0H4s+bHC5XOsBc6O+dyquymygfblnN4jU+4uw80MDzXsLqdnoOQ1/wH
         ynZ+BeH3S/zJ2G4GvoZVExMXlIbU6ZTu0hlf9GfOapkiWvGoM2HkgH9Ap6HaNErNNCBW
         S1r7FR8UEmzH6f4qaGtf4rZiJvBtAWPTs+jAlYWmovGOFge/SIQWQ9x3TzZnSi3IajLx
         AZLNbhHbqlIWJfWRMwMrbfYtW/tpx28rDMlLosdIII+z3fFh57wl9vH4R5BlIfbGM0/L
         wroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628159; x=1710232959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/6peNBdk69VycNv0NnzT94cpIyuuvaLqCVKnWNPdGI=;
        b=v8FpbodrJ9W6qsjSXuitaEMvhp6LqWOJpa+2KeDQSPxf5kSc4hD4Un713u0PEHWNdY
         OYgn5xBWYpOKCjXD3nUFKdmvQY4GVSX9uxAzOJcvrol/U8BCjdn2yiLRl/U4hVBMDw2q
         9+tmMfFzM23ykdSxebcmDSjVmoHAyLwicreQp5bmj0j5iOGdwCvccJoRu78RdIKeHYFa
         dzCAWzRpXxya5ZqLncA49WwJWXEI7SZPuKGtW8JJhTN/GccRr2FatKf4p830nJnR+DqV
         axGACyDNc4xa3ffUHki/rWj3/dVYl5JYAJgmLive4nE/cUFv0kPJ5hkCDTEBXkrHgq9M
         ZMew==
X-Forwarded-Encrypted: i=1; AJvYcCXVHMUJQBQTcsJmExou6Tu2QtBznXwb6aXZB5a76EL2Xdx+igoi4ezK8yUdzPTWp0QGmQNptxgtYZx2Sy2J4hPRoLAI29ck/+DXmWXE6E4SZmYDpHAztAruVhncjwMASCZwF/JXNdfBcw==
X-Gm-Message-State: AOJu0YzkugLyqnPAkPHOTfeTS3YiNORPo/X/2iSTBl8QLf2BNc2Vrrpu
	biARXk5wkHop+yuVuzmldDtQmwuFyB2f8dC9FvxLiBLZW77/iJ0yKrSud8LtxBShkBAJONCaBbX
	9beiYYVEi5YwbT8lRahNWJZAJ9Ho=
X-Google-Smtp-Source: AGHT+IHyY77JiYRLDD6eQqOVrpXJRS94mPpqIWxOA1v3+O5DjbZ2B6MqEj48fOLN0m3u1rRN77VrKtOPvZSR6dDTTyc=
X-Received: by 2002:a2e:b0e5:0:b0:2d3:ba52:f878 with SMTP id
 h5-20020a2eb0e5000000b002d3ba52f878mr812382ljl.0.1709628158807; Tue, 05 Mar
 2024 00:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706603678.git.haibo1.xu@intel.com> <a1e20de53156f50385c7609507982f08866e859b.1706603678.git.haibo1.xu@intel.com>
 <ZeailF+UYf/+4NQq@sunil-laptop>
In-Reply-To: <ZeailF+UYf/+4NQq@sunil-laptop>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 5 Mar 2024 16:42:27 +0800
Message-ID: <CAJve8okkwtvheMMURhsuboLwA+jMtryf-fn0nOvYzTMGX63yvA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ACPI: NUMA: Add handler for SRAT RINTC affinity structure
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Anup Patel <apatel@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Baoquan He <bhe@redhat.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Chen Jiahao <chenjiahao16@huawei.com>, James Morse <james.morse@arm.com>, 
	Evan Green <evan@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Tony Luck <tony.luck@intel.com>, Yuntao Wang <ytcoode@gmail.com>, 
	Alison Schofield <alison.schofield@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 12:42=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Hi Haibo,
>
> On Wed, Jan 31, 2024 at 10:31:59AM +0800, Haibo Xu wrote:
> > Add RINTC affinity structure handler during parsing SRAT table.
> > The ARCH specific implementation will be added in next patch.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  drivers/acpi/numa/srat.c | 32 +++++++++++++++++++++++++++++++-
> >  include/linux/acpi.h     |  3 +++
> >  2 files changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 0214518fc582..503abcf6125d 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -165,6 +165,19 @@ acpi_table_print_srat_entry(struct acpi_subtable_h=
eader *header)
> >               }
> >       }
> >       break;
> > +
> > +     case ACPI_SRAT_TYPE_RINTC_AFFINITY:
> > +             {
> > +                     struct acpi_srat_rintc_affinity *p =3D
> > +                         (struct acpi_srat_rintc_affinity *)header;
> > +                     pr_debug("SRAT Processor (acpi id[0x%04x]) in pro=
ximity domain %d %s\n",
> > +                              p->acpi_processor_uid,
> > +                              p->proximity_domain,
> > +                              (p->flags & ACPI_SRAT_RINTC_ENABLED) ?
> > +                              "enabled" : "disabled");
> > +             }
> > +             break;
> > +
> >       default:
> >               pr_warn("Found unsupported SRAT entry (type =3D 0x%x)\n",
> >                       header->type);
> > @@ -448,6 +461,21 @@ acpi_parse_gi_affinity(union acpi_subtable_headers=
 *header,
> >  }
> >  #endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
> >
> > +static int __init
> > +acpi_parse_rintc_affinity(union acpi_subtable_headers *header,
> > +                      const unsigned long end)
> Alignment doesn't look right. Could you please run checkpatch on all
> the patches?
>

Seems something is wrong with my vim configuration.
Will fix it in v2.

> > +{
> > +     struct acpi_srat_rintc_affinity *rintc_affinity;
> > +
> > +     rintc_affinity =3D (struct acpi_srat_rintc_affinity *)header;
> > +     acpi_table_print_srat_entry(&header->common);
> > +
> > +     /* let architecture-dependent part to do it */
> > +     acpi_numa_rintc_affinity_init(rintc_affinity);
> > +
> Is it required to have this commit first prior to architecture
> functionality? I am wondering whether it is logically better to
> implement the function first and then consume in next commit?
>

No dependency between this commit and the next commit.
Will change the order in v2.

> > +     return 0;
> > +}
> > +
> >  static int __initdata parsed_numa_memblks;
> >
> >  static int __init
> > @@ -501,7 +529,7 @@ int __init acpi_numa_init(void)
> >
> >       /* SRAT: System Resource Affinity Table */
> >       if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
> > -             struct acpi_subtable_proc srat_proc[4];
> > +             struct acpi_subtable_proc srat_proc[5];
> >
> >               memset(srat_proc, 0, sizeof(srat_proc));
> >               srat_proc[0].id =3D ACPI_SRAT_TYPE_CPU_AFFINITY;
> > @@ -512,6 +540,8 @@ int __init acpi_numa_init(void)
> >               srat_proc[2].handler =3D acpi_parse_gicc_affinity;
> >               srat_proc[3].id =3D ACPI_SRAT_TYPE_GENERIC_AFFINITY;
> >               srat_proc[3].handler =3D acpi_parse_gi_affinity;
> > +             srat_proc[4].id =3D ACPI_SRAT_TYPE_RINTC_AFFINITY;
> > +             srat_proc[4].handler =3D acpi_parse_rintc_affinity;
> >
> >               acpi_table_parse_entries_array(ACPI_SIG_SRAT,
> >                                       sizeof(struct acpi_table_srat),
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index b7165e52b3c6..a65273db55c6 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -269,6 +269,9 @@ acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_=
affinity *pa) { }
> >
> >  int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma)=
;
> >
> > +static inline void
> > +acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa) { }
> > +
> I think this can be fit in single like as we can have upto 100
> characters.
>

Sure. will fix it in v2.

Thanks,
Haibo

> >  #ifndef PHYS_CPUID_INVALID
> >  typedef u32 phys_cpuid_t;
> >  #define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
> > --
> > 2.34.1
> >

