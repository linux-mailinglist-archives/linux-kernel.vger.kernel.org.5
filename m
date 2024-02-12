Return-Path: <linux-kernel+bounces-61572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4B58513C3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5D01C218DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58893A1AE;
	Mon, 12 Feb 2024 12:46:18 +0000 (UTC)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0076A3A1AB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741978; cv=none; b=p4icHI9cs7plhS7J8cfN7XKoXT3iN8Wt1BO4WS40UOXvmkLpKTb8f8a82LAvHakp44ffHKJAuTaxOVF2V55YPfkaLvNme9m3mBSNlGGiWVIZ+7e5ScWDg5JxUdHToc82njRZlE4aq3bcDkPusalf6RG7lFfGlX/DEgzI6uLNpP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741978; c=relaxed/simple;
	bh=1kqPxjS3pzHssw+PplAlJEerUryoUaQZ2ngJLM8Y6Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbpDxikkl9ev/MiQZIqdnLrZ/W7un3LYPzn17UDBf4d423Kn3B7yuYov6tfOFwyc6zDSqH6DVuzsaDA0IuxoLNCiLKxlBRg32rEYN+v7fWbvdw+jJ7xsOXJDjFHj/ieGlp9/P1BHs5Y0fiRDv8fmQsMEpkt+4eCXMKo5iyhxeq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc74e70508aso3007767276.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 04:46:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707741974; x=1708346774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZES1iA9GlPteDI85FKkAksUubx4iv24005gWev4ZDU=;
        b=plrpLXIkc2CHIvlMtbI8BweGF3X1XZMTFOV8po2w/3PxlIL0WkOmaYtrc1Unr24YQy
         uyS6EtL0NygEDKIoZN62u7olt1P6pcf+MrI+OjnVu4iO6fndGuNSLAy3Al5hb27TP9Pm
         kC5jy1fBURknc6zkg+WhPmugczL7wSX4HoaMtHuld8AnDHzilj055m4WDnvpwKJiwrD+
         CUuPTqim/9fzsAmsRnHN0ViVf8L5zL6XttLL/Nek/ZXc3ye15Hx9b0b6V8i7us2Coo7B
         /4YbyPReY8+VmDG8ZGuhS5W+p2pJ9WbQMnBKknOXVBoNVpKJY69CRHGtnKSulopiM/uT
         HoLQ==
X-Gm-Message-State: AOJu0Yy9UdtEScZ0c2F0T8S5abEB+kaP53wUllqZmaHJ1Wk+CL/hn5Yn
	CutTMXj6bXlZRbpl0Oa5i8KSIlunuqmB8oIIJ35y9Ams88Ng67j2vIJHOuyxz6s=
X-Google-Smtp-Source: AGHT+IEBikJ6bqv0GGdELxxgmAiv+tVe8tLQX8ckzk3Y5bgSLvb3gMV66JN5yizZW7/D5yvNjKqAcw==
X-Received: by 2002:a5b:64b:0:b0:dc6:b121:d00c with SMTP id o11-20020a5b064b000000b00dc6b121d00cmr5152877ybq.16.1707741973992;
        Mon, 12 Feb 2024 04:46:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV686443qryLBWMAajUr/hFEhx1+2OyiJPQ0B+q6U2KfU8DBKcmaQT/xnKCEyNgZ6yYG5HuekT9taHxnpsvGL0mUqRRYXLp3NeSP8SI
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id l12-20020a5b0b8c000000b00dc74ac54f5fsm1153431ybq.63.2024.02.12.04.46.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 04:46:13 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso2809031276.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 04:46:13 -0800 (PST)
X-Received: by 2002:a25:ce42:0:b0:dcb:de9b:175 with SMTP id
 x63-20020a25ce42000000b00dcbde9b0175mr145496ybe.6.1707741973607; Mon, 12 Feb
 2024 04:46:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
 <8dedf370-47e1-405d-85cf-53f3acfa16a0@roeck-us.net>
In-Reply-To: <8dedf370-47e1-405d-85cf-53f3acfa16a0@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 13:46:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVocStpwYKJ4OzgHBWRsDUhAT73JaQ7HgaQbJK_Zo+VvA@mail.gmail.com>
Message-ID: <CAMuHMdVocStpwYKJ4OzgHBWRsDUhAT73JaQ7HgaQbJK_Zo+VvA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] lib: checksum: Fix issues with checksum tests
To: Guenter Roeck <linux@roeck-us.net>
Cc: Charlie Jenkins <charlie@rivosinc.com>, David Laight <David.Laight@aculab.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi G=C3=BCnter,

On Sun, Feb 11, 2024 at 8:18=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
> On 2/7/24 16:22, Charlie Jenkins wrote:
> > The ip_fast_csum and csum_ipv6_magic tests did not have the data
> > types properly casted, and improperly misaligned data.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>
> I sorted out most of the problems with this version, but I still get:
>
>      # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:513
>      Expected ( u64)csum_result =3D=3D ( u64)expected, but
>          ( u64)csum_result =3D=3D 16630 (0x40f6)
>          ( u64)expected =3D=3D 65535 (0xffff)
>      not ok 5 test_csum_ipv6_magic
>
> on m68k:q800. This is suspicious because there is no 0xffff in
> expected_csum_ipv6_magic[]. With some debugging information:
>
> ####### num_tests=3D86 i=3D84 expect array size=3D84
> ####### MAX_LEN=3D512 WORD_ALIGNMENT=3D4 magic data size=3D42
>
> That means the loop
>
>         for (int i =3D 0; i < num_tests; i++) {
>                 ...
>                 expected =3D (__force __sum16)expected_csum_ipv6_magic[i]=
;
>                 ...
>         }
>
> will access data beyond the end of the expected_csum_ipv6_magic[] array,
> possibly because m68k doesn't pad struct csum_ipv6_magic_data to 44 bytes=
.

Exactly, sizeof(struct csum_ipv6_magic_data) =3D 42 on m68k.
Hence struct csum_ipv6_magic_data needs an extra field "unsigned char pad[3=
];"
at the end.

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

