Return-Path: <linux-kernel+bounces-83115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EDE868E99
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780B428385E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E924D139592;
	Tue, 27 Feb 2024 11:18:14 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA05137C38;
	Tue, 27 Feb 2024 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032694; cv=none; b=ZOVtq+u/WGf2LkJ0EgmshExEiLVc2am4ir24uayrDdkpKWhmIbSDethQSXfpus3UYvk6FwMxx9lRwHhTqnuWTX/csVzLAW+1c0/e6a6hEI+abefl8k/mLB/Lk+vQ37HVTMHMFiW8nuxxzWkhU0s9P8JWrOfkWL0FnisSDIr8YkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032694; c=relaxed/simple;
	bh=G58AunBYkCt/gms7o+OJA0kSa7jWnIXDwId2W/wpJyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXb4kYlcLK9bQ6mP8nW1J9NN1iIvZCFzAbQJVbWh+8iu6HMd2ONA3XkRfhpJWajmQFA9o3QgiOGI0J/mka772zwR5MbM756VCT0qZGnI9buGEko0RsPoPSCFxap2oTJX/DPeddBmMWoOkNsuL042jsusRN3LB3+cR70eCePDxTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-607e60d01b2so20555167b3.1;
        Tue, 27 Feb 2024 03:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709032691; x=1709637491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjZve7pGUlAuiB1y5Evv/dfTmjlQGRjAirpVZxXZfKE=;
        b=qTeg0+Nvl3RI2ibWi5eDrV+iiVJaB4vT6ZzWQHuSCdWdGo2C8pL7dQ6Z4I4yhJBBUR
         +IrnNSGO5WkK/T4qDyLIPdHlGgkde4TWfzjfTYPU+v0OGFzMC0Tw5GUbT2PE+vPT1DGX
         NNYDnfdP+qRofUx9A7WvGho6Xon9VHEYpZrTGCkm/auVOYrYdK6eH5wnoA5BVk+Nftua
         PrjCNKRQjhk6zhWFRm+R+xcZ3N2qjXQRVaQGmOXnXJSu4oNk36cMnonYVxFaiAj9w7Ki
         Wcwaf9kGAEEUKpqz56H0i9ktAGvqq/UYzd3zoIcn9My3zlRhlV85jcLg6QDAZJWNF83n
         iECw==
X-Forwarded-Encrypted: i=1; AJvYcCV17XSGGYQhkvA14SjIhIC9Ue/OTdjRXcqG5pQykoNYgecVAuK9NGQwVc7mC/pr/uQjHN12N4fo7+ptYv4Dg94VglLr2ljdSva5Do0EJgJls5XVXaqcYzARTcRqn1i2pNtfKnRZuwDJ5zA3
X-Gm-Message-State: AOJu0YyhxC4cTrb1QuaD9ngHzqJfgmzoyKih434YWiwhlOeTm3R8B/OG
	/7KtTvo7MdYRKZg+kKSgGrOOEWqFiGYShMahK/fgy0k7r2J0e6AUXdqevbP0S/E=
X-Google-Smtp-Source: AGHT+IFzG+Tn29xVPiMOUoH/5hkruSItmYuA5oPtOMfe3j2K2LFWINOdZHtc2d97CcEBMje0HflCKA==
X-Received: by 2002:a81:e40d:0:b0:608:718c:c4e7 with SMTP id r13-20020a81e40d000000b00608718cc4e7mr1629852ywl.43.1709032691326;
        Tue, 27 Feb 2024 03:18:11 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id u187-20020a8184c4000000b00608a212f5cesm1717182ywf.86.2024.02.27.03.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 03:18:10 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so3891671276.1;
        Tue, 27 Feb 2024 03:18:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXI5ssxUd6I6uLR4zQ+/OyB9IOzSfPNKhR4gOhj4O8HEngwFssMq69/64iSiGhV/rDX9xU5YjV9iArkQeBi8+0LtVFKfNjRW1llzHeXTaeqBuZq3J/wqfGjNNAMU4R15mNOxyKwG2bSfNA/
X-Received: by 2002:a5b:5d1:0:b0:dbf:487b:1fe7 with SMTP id
 w17-20020a5b05d1000000b00dbf487b1fe7mr1859795ybp.17.1709032690695; Tue, 27
 Feb 2024 03:18:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
In-Reply-To: <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 12:17:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW16fs2rtHkwyGK_+Fhgi5LOFVYb6vPN4mTw3Fhjv1sqg@mail.gmail.com>
Message-ID: <CAMuHMdW16fs2rtHkwyGK_+Fhgi5LOFVYb6vPN4mTw3Fhjv1sqg@mail.gmail.com>
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Guenter Roeck <linux@roeck-us.net>, David Laight <David.Laight@aculab.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Helge Deller <deller@gmx.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Parisc List <linux-parisc@vger.kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Charlie,

Thanks for your patch!

On Fri, Feb 23, 2024 at 11:12=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
> The test cases for ip_fast_csum and csum_ipv6_magic were not properly
> aligning the IP header, which were causing failures on architectures
> that do not support misaligned accesses like some ARM platforms. To
> solve this, align the data along (14 + NET_IP_ALIGN) bytes which is the
> standard alignment of an IP header and must be supported by the
> architecture.
>
> Furthermore, all architectures except the m68k pad "struct
> csum_ipv6_magic_data" to 44 bits. To make compatible with the m68k,
> manually pad this structure to 44 bits.

s/bits/bytes/ everywhere

>
> Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_cs=
um")
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> The ip_fast_csum and csum_ipv6_magic tests did not work on all
> architectures due to differences in misaligned access support.
> Fix those issues by changing endianness of data and aligning the data.
>
> This patch relies upon a patch from Christophe:
>
> [PATCH net] kunit: Fix again checksum tests on big endian CPUs
>
> https://lore.kernel.org/lkml/73df3a9e95c2179119398ad1b4c84cdacbd8dfb6.170=
8684443.git.christophe.leroy@csgroup.eu/t/
> ---
> Changes in v10:
> - Christophe Leroy graciously decided to re-write my patch to fit his
>   style so I have dropped my endianness+sparse changes and have based by
>   alignment fixes on his patch. The link to his patch can be seen above.
> - I dropped Guenter's tested-by but kept his reviewed-by since only the b=
ase
>   was changed.
> - Link to v9: https://lore.kernel.org/r/20240221-fix_sparse_errors_checks=
um_tests-v9-0-bff4d73ab9d1@rivosinc.com

> --- a/lib/checksum_kunit.c
> +++ b/lib/checksum_kunit.c

> @@ -595,28 +473,31 @@ static void test_ip_fast_csum(struct kunit *test)
>  static void test_csum_ipv6_magic(struct kunit *test)
>  {
>  #if defined(CONFIG_NET)
> -       const struct in6_addr *saddr;
> -       const struct in6_addr *daddr;
> +       struct csum_ipv6_magic_data {
> +               const struct in6_addr saddr;
> +               const struct in6_addr daddr;
> +               __le32 len;
> +               __wsum csum;
> +               unsigned char proto;
> +               unsigned char pad[3];
> +       } *data;

If having a size of 44 bytes is critical, you really want to add a
BUILD_BUG_ON() check for that.

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

