Return-Path: <linux-kernel+bounces-153371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6978ACD3B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4408B1C21051
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39D4146011;
	Mon, 22 Apr 2024 12:47:49 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A9147C69;
	Mon, 22 Apr 2024 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790069; cv=none; b=MbvYEAeGCLKkFa3X8/n50Eom3fvQw9/QANrz9YxNHZNjHjHNmora1XSjRtpajfpFBAhJACcPngpO5I4qJHTLzr2rQR4wkS4VfGyDMgson+yPOrfd8aUa5cA03UoRMW626w+QfDh6nYELsFlPPMv5Zl6Yw/rdFgdXrznVej5EL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790069; c=relaxed/simple;
	bh=/GOtHEwRvmHmdn6ZvA+ZYfe6bP5Gtksur+wASo31Ntc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGQ/RcIT6wpng7YL4DE/pXL14TdA6nAYC9sGfKA9OEdX/eY8KgfMb7A6b33VkJvPNQhhyC+V6Lnle4Eq6xcmvTzu69By4fKVjlo6RXV2E8KiWmE1ZsB/ZdGGK0mGQF6yGcxlFDkBQlWoMw4nmbTCqhBeCLKBDIP6ZzfLvEuMuC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-618769020bcso46095097b3.3;
        Mon, 22 Apr 2024 05:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713790067; x=1714394867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nlzycx+VXkP7x8f8C0Pz1YcDNNhu/yf0LhpKIds7DPk=;
        b=Yyk2fqTjsgW52HqrJRhG1/JYtfLXBQ0wad+JFVsu+cMgjc0fq5Iy2WXo1u/kN95yvw
         1b7TQUveQ5/w2qDasSVBNruiDKWEq4TfR07kyZkYYsmM54vY5y8ibhsuHdZ+Hn2tXx5I
         lXplaVpQZIqAMoR+Xx1/urhbB4/qta7X2xjjBzc5VJOrINjexy59RCIdX3EWnbQZdxCY
         vvke4nAmHUrlbCukC6k1G5Tq3PBPthI6Enk6QwNYJx7XRHdfCeC0Z8cWqCJDjT8Jdl2t
         hLXMW4QNLlLM2+P3s7mo5TgL9g4EJ502iSqD8+/0gWOO8H9CqG+4/YsS3cbwQJrU4gIq
         xeUg==
X-Forwarded-Encrypted: i=1; AJvYcCW+lupkQK5t+A7TJfH/uOoqivc48rrWJhFROEqgmqt5ZhymL6ImizSW8rq5g+xwkStqnP0iWG7oVrXfxV86S7PtPoJ7gvs1o+QWCy8RV7gru31DXl9w3tNU/KbErK85IQtBhsAC+JseEg6nKuM=
X-Gm-Message-State: AOJu0Yxv9/SJLoidzy5ps+hJ/ed1qNVZv6i7RFElE6lDk6VDdXXbTeP8
	y8qB/AyVP4SyEJ9kzrUnuh2j44SP9yZuuRVfLXVRJzragG/d22J3VIDETwuy
X-Google-Smtp-Source: AGHT+IHUds8h6/eX+4tePd01oHQLIpNv0clK7+HQXagKE5meyhnqSXWtkFPdn2RVVbvBvkpldxcIeA==
X-Received: by 2002:a05:690c:3501:b0:618:96eb:980d with SMTP id fq1-20020a05690c350100b0061896eb980dmr10791392ywb.1.1713790065964;
        Mon, 22 Apr 2024 05:47:45 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id u73-20020a0deb4c000000b0061b232975aesm1849720ywe.47.2024.04.22.05.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 05:47:45 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-618769020bcso46094707b3.3;
        Mon, 22 Apr 2024 05:47:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWquRO7XqzMhe9WqtvqnjomfhbDd04JRXbM2ygTovkPbSEmwEXGaChGHNdoSMzu92EPn1XNscNbCRA1Xe9GwV3xgTp4i0kK2SOCBwaid9xm5nayaoEMJI7EbcDYLpFqjQbGF+9fkCCVYJuBiUU=
X-Received: by 2002:a25:c70e:0:b0:dcd:98bd:7cc8 with SMTP id
 w14-20020a25c70e000000b00dcd98bd7cc8mr9050028ybe.48.1713790065495; Mon, 22
 Apr 2024 05:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416-bcachefs-fix-format-specifier-validate_bset_keys-v1-1-3ea2cdf28b12@kernel.org>
 <xznpzlnjcf3goexunm6azwercgwz7ikgum3i4gpdyxwykb4e4l@ascd3uztphq3>
In-Reply-To: <xznpzlnjcf3goexunm6azwercgwz7ikgum3i4gpdyxwykb4e4l@ascd3uztphq3>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Apr 2024 14:47:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV9wMO2E=xNezs5FiDK_F3XKaVPaFbhh9+7djd26KkgMA@mail.gmail.com>
Message-ID: <CAMuHMdV9wMO2E=xNezs5FiDK_F3XKaVPaFbhh9+7djd26KkgMA@mail.gmail.com>
Subject: Re: [PATCH] bcachefs: Fix format specifier in validate_bset_keys()
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>, bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kent,

On Wed, Apr 17, 2024 at 12:09=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Tue, Apr 16, 2024 at 08:16:02AM -0700, Nathan Chancellor wrote:
> > When building for 32-bit platforms, for which size_t is 'unsigned int',
> > there is a warning from a format string in validate_bset_keys():
> >
> >   fs/bcachefs/btree_io.c: In function 'validate_bset_keys':
> >   fs/bcachefs/btree_io.c:891:34: error: format '%lu' expects argument o=
f type 'long unsigned int', but argument 12 has type 'unsigned int' [-Werro=
r=3Dformat=3D]
> >     891 |                                  "bad k->u64s %u (min %u max =
%lu)", k->u64s,
> >         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> >   fs/bcachefs/btree_io.c:603:32: note: in definition of macro 'btree_er=
r'
> >     603 |                                msg, ##__VA_ARGS__);          =
           \
> >         |                                ^~~
> >   fs/bcachefs/btree_io.c:887:21: note: in expansion of macro 'btree_err=
_on'
> >     887 |                 if (btree_err_on(!bkeyp_u64s_valid(&b->format=
, k),
> >         |                     ^~~~~~~~~~~~
> >   fs/bcachefs/btree_io.c:891:64: note: format string is defined here
> >     891 |                                  "bad k->u64s %u (min %u max =
%lu)", k->u64s,
> >         |                                                              =
~~^
> >         |                                                              =
  |
> >         |                                                              =
  long unsigned int
> >         |                                                              =
%u
> >   cc1: all warnings being treated as errors
> >
> > BKEY_U64s is size_t so the entire expression is promoted to size_t. Use
> > the '%zu' specifier so that there is no warning regardless of the width
> > of size_t.
> >
> > Fixes: 031ad9e7dbd1 ("bcachefs: Check for packed bkeys that are too big=
")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202404130747.wH6Dd23p-lkp=
@intel.com/
> > Closes: https://lore.kernel.org/oe-kbuild-all/202404131536.HdAMBOVc-lkp=
@intel.com/
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>
> Thanks, applied

This is still not fixed in today's linux-next, while the issue is now
causing breakage on several 32-bit defconfs in v6.9-rc5.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

