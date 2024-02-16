Return-Path: <linux-kernel+bounces-68296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1047857852
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F8528A6DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8022A1B94D;
	Fri, 16 Feb 2024 09:01:24 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BF71B81C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074083; cv=none; b=gwFPcvS+0vTy46YMGnJ39NjRUX25Ex4sTWfk1NKfdVb2hLC41wOBVkteUtOrysiEkFf1RAdDnS077tCyH+VMo9a0OEsg0y20uduBADBIv/q82UlXqlw566UzLCVxF6rHsDtr8CP4szmDbV3om97AOde6nUVQbB6STRE4aRSK8ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074083; c=relaxed/simple;
	bh=B9zeYn0vSNSA1QGN9jiimfT1KpPUVXk7FTAlcoVpw6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B03oCCA3oEyodtTDLrKoUkRYW8HHuNs+FMnopkcGHh/v/taHQLe6IrzryeazvWRT2s79ItJWKyZsCEJgxqvEYqtKi62J/mHU+FuTBRZZqakPNuTUh734K/V+waE5/mvbh3h+yI2eksSmpV3RNTIkQiqIxYo0tYeH4HukGPX0SUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6077444cb51so21007387b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708074079; x=1708678879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uafFwhOF4SdmeZiWT79n+qBV7xcoaBZJpLX6qG+RRKA=;
        b=Y4AbuRhgqnYw0FE57Ou8fIscDCqYgT6TkT88oDYNp06saZiZCUP3IZmj76OA+GVYCA
         peIt/ZniYTgTYrsfNMhrxy6Q1dKEc75qPhOi4jmoGVEv6CmEPTZWUW5Ta2FjVNkbfQO4
         TbPdi+c7MuZRZhVRUfErJIl3DdpYyZd5YArxVK5PEq72CWa4UF0pA2WYV7ixpAfgFjso
         RW+ocE3pnQjPFPfaXrhzzgZd/o349A2UdTKrqfOPYolBBA6PjVEAyZy27UhhtdausOQZ
         Z+qw7lxP6huCM22wEVw8q65rsJiemg6jI/511z1bGc5a9NFvIePhxqWdKwj8eeqpI05h
         2U/A==
X-Forwarded-Encrypted: i=1; AJvYcCW2rz/W8uReIEZj3yktwfzPsUXAtU5yArU9mRU4c8DcS6wg2WG1YIq2a9aFfKrff+mBi5+oHDw5UeVBE75k7RCy1AcTgYnRSAuEgltj
X-Gm-Message-State: AOJu0Yw2YJ/vEkdUBJezE6O+qlQOWQ+j9A84/L9oNlXNb9q72wAFkCAw
	tvAoYW7K5KFYdAOfQN/fPn/WM3IOuF4Oe3HmqcNlyrcTIxfZFlBFkMXrigazFi4RtQ==
X-Google-Smtp-Source: AGHT+IHUb40FdD0QQHi5yfzRKa1NcSxHg64dQT8QF0IBIOzUqvI9D8JI3zvOB74zO2NtdD1NQNbI+Q==
X-Received: by 2002:a81:4f84:0:b0:607:df5f:5e0c with SMTP id d126-20020a814f84000000b00607df5f5e0cmr2598327ywb.3.1708074078892;
        Fri, 16 Feb 2024 01:01:18 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id s5-20020a817705000000b00607bc220c5esm262389ywc.102.2024.02.16.01.01.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 01:01:18 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso1533322276.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:01:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4G+na2J6ci5h8qtAe9U0PkZkIK8vumTLlg9KzA1c/zzwYMAnF3K8v3hWPYzuYsCcwmS0ju8YY78CD4OZ+rwSRM6znnPel5pjYCMwd
X-Received: by 2002:a25:ae28:0:b0:dc2:4fff:75ee with SMTP id
 a40-20020a25ae28000000b00dc24fff75eemr3098050ybj.3.1708074078174; Fri, 16 Feb
 2024 01:01:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
 <8dedf370-47e1-405d-85cf-53f3acfa16a0@roeck-us.net> <Zcmr8C1dTuaPvXqJ@ghost> <cbee3cb7-04bc-43bf-95af-774fb72f7905@roeck-us.net>
In-Reply-To: <cbee3cb7-04bc-43bf-95af-774fb72f7905@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 10:01:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWLQbWPVFaVri6PGPybbVZLunQ6kMUUhEW0KCp8oUMJow@mail.gmail.com>
Message-ID: <CAMuHMdWLQbWPVFaVri6PGPybbVZLunQ6kMUUhEW0KCp8oUMJow@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] lib: checksum: Fix issues with checksum tests
To: Guenter Roeck <linux@roeck-us.net>
Cc: Charlie Jenkins <charlie@rivosinc.com>, David Laight <David.Laight@aculab.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi G=C3=BCnter,

On Mon, Feb 12, 2024 at 6:13=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
> On Mon, Feb 12, 2024 at 12:26:08AM -0500, Charlie Jenkins wrote:
> > On Sun, Feb 11, 2024 at 11:18:36AM -0800, Guenter Roeck wrote:
> > > On 2/7/24 16:22, Charlie Jenkins wrote:
> > > > The ip_fast_csum and csum_ipv6_magic tests did not have the data
> > > > types properly casted, and improperly misaligned data.
> > > >
> > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > >
> > > I sorted out most of the problems with this version, but I still get:
> > >
> > >     # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:=
513
> > >     Expected ( u64)csum_result =3D=3D ( u64)expected, but
> > >         ( u64)csum_result =3D=3D 16630 (0x40f6)
> > >         ( u64)expected =3D=3D 65535 (0xffff)
> > >     not ok 5 test_csum_ipv6_magic
> > >
> > > on m68k:q800. This is suspicious because there is no 0xffff in
> > > expected_csum_ipv6_magic[]. With some debugging information:
> > >
> > > ####### num_tests=3D86 i=3D84 expect array size=3D84
> > > ####### MAX_LEN=3D512 WORD_ALIGNMENT=3D4 magic data size=3D42
> > >
> > > That means the loop
> > >
> > >     for (int i =3D 0; i < num_tests; i++) {
> > >             ...
> > >             expected =3D (__force __sum16)expected_csum_ipv6_magic[i]=
;
> > >             ...
> > >     }
> > >
> > > will access data beyond the end of the expected_csum_ipv6_magic[] arr=
ay,
> > > possibly because m68k doesn't pad struct csum_ipv6_magic_data to 44 b=
ytes.
> >
> > Okay I will check that out.
> >
> > >
> > > In this context, is the comment about proto having to be 0 really tru=
e ?
> > > It seems to me that the calculated checksum must be identical on both
> > > little and big endian systems. After all, they need to be able to tal=
k
> > > to each other.
> >
> > I agree, but I couldn't find a solution other than setting it to zero.
> > Maybe I am missing something simple...
> >
>
> Try the patch below on top of yours. It should work on both big and littl=
e
> endian systems.
>
> Key changes:
> - use random_buf directly instead of copying anything
> - no need to convert source / destination addresses
> - csum in the buffer is in network byte order and needs
>   to stay that way
> - len in the buffer is in network byte order and needs to be
>   converted to host byte order since that is expected by
>   csum_ipv6_magic()
> - the expected value is in host byte order and needs to be
>   converted to network byte order for comparison
> - protocol is just fine and converted by csum_ipv6_magic()
>   as needed

Thanks for your patch!

> --- a/lib/checksum_kunit.c
> +++ b/lib/checksum_kunit.c

> @@ -465,44 +468,36 @@ static void test_ip_fast_csum(struct kunit *test)
>         }
>  }
>
> +#define IPV6_NUM_TESTS ((MAX_LEN - sizeof(struct in6_addr) * 2 - sizeof(=
int) * 3) / WORD_ALIGNMENT)
> +
>  static void test_csum_ipv6_magic(struct kunit *test)
>  {
>  #if defined(CONFIG_NET)
> +       const struct in6_addr *saddr;
> +       const struct in6_addr *daddr;
> +       unsigned int len;
>         __sum16 csum_result, expected;
> -       struct csum_ipv6_magic_data {
> -               const struct in6_addr saddr;
> -               const struct in6_addr daddr;
> -               unsigned int len;
> -               __wsum csum;
> -               unsigned char proto;
> -       } data, *data_ptr;
> -       int num_tests =3D MAX_LEN / WORD_ALIGNMENT - sizeof(struct csum_i=
pv6_magic_data);
> +       unsigned char proto;
> +       unsigned int csum;
>
> -       for (int i =3D 0; i < num_tests; i++) {
> -               data_ptr =3D (struct csum_ipv6_magic_data *)(random_buf +=
 (i * WORD_ALIGNMENT));
> +       const int daddr_offset =3D sizeof(struct in6_addr);
> +       const int len_offset =3D sizeof(struct in6_addr) + sizeof(struct =
in6_addr);
> +       const int csum_offset =3D sizeof(struct in6_addr) + sizeof(struct=
 in6_addr) +
> +         sizeof(int);
> +       const int proto_offset =3D sizeof(struct in6_addr) + sizeof(struc=
t in6_addr) +
> +         sizeof(int) * 2;

Please no manual offset calculations.
Please fix the csum_ipv6_magic_data structure definition instead.

>
> -               cpu_to_be32_array((__be32 *)&data.saddr, (const u32 *)&da=
ta_ptr->saddr,
> -                                 sizeof_field(struct csum_ipv6_magic_dat=
a, saddr) / 4);
> -               cpu_to_be32_array((__be32 *)&data.daddr, (const u32 *)&da=
ta_ptr->daddr,
> -                                 sizeof_field(struct csum_ipv6_magic_dat=
a, daddr) / 4);
> -               data.len =3D data_ptr->len;
> -               data.csum =3D (__force __wsum)htonl((__force u32)data_ptr=
->csum);
> -               /*
> -                * proto must be zero to be compatible between big-endian=
 and
> -                * little-endian CPUs. On little-endian CPUs, proto is
> -                * converted to a big-endian 32-bit value before the chec=
ksum
> -                * operation. This causes proto to be in the most signifi=
cant
> -                * 8 bits on a little-endian CPU. On big-endian CPUs prot=
o will
> -                * remain in the least significant 8 bits. There does not=
 exist
> -                * a transformation to an arbitrary proto that will allow
> -                * csum_ipv6_magic to return the same value on a big-endi=
an and
> -                * little-endian CPUs.
> -                */
> -               data.proto =3D 0;
> -               csum_result =3D csum_ipv6_magic(&data.saddr, &data.daddr,
> -                                             data.len, data.proto,
> -                                             data.csum);
> -               expected =3D (__force __sum16)expected_csum_ipv6_magic[i]=
;
> +       for (int i =3D 0; i < IPV6_NUM_TESTS; i++) {
> +               int index =3D i * WORD_ALIGNMENT;
> +
> +               saddr =3D (const struct in6_addr *)(random_buf + index);
> +               daddr =3D (const struct in6_addr *)(random_buf + index + =
daddr_offset);
> +               len =3D ntohl(*(unsigned int *)(random_buf + index + len_=
offset));
> +               csum =3D *(unsigned int *)(random_buf + index + csum_offs=
et);
> +               proto =3D *(random_buf + index + proto_offset);
> +
> +               csum_result =3D csum_ipv6_magic(saddr, daddr, len, proto,=
 csum);
> +               expected =3D (__force __sum16)htons(expected_csum_ipv6_ma=
gic[i]);
>                 CHECK_EQ(csum_result, expected);
>         }
>  #endif /* !CONFIG_NET */

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

