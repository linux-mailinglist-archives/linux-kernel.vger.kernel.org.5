Return-Path: <linux-kernel+bounces-1553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BDF814FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F712886B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD2D3FE2C;
	Fri, 15 Dec 2023 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuZdQhH1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A145C4184F;
	Fri, 15 Dec 2023 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-67ac0ef6bb8so6080096d6.1;
        Fri, 15 Dec 2023 11:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702667382; x=1703272182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWbxY3Q+EoYq5mueLiLO42QJaTQBT+r4FmqbmlCjarw=;
        b=AuZdQhH1P5VAEYsXf5q11XaZrV0ndVOspTvuZwGLeFOcJ0YYGqLx2fBV9gn7QcBC8o
         P6UqHzTG32ddJjKMtYqKC7aST+zgop9y2fdQMhSOACQQmy+Lf865ei99Sw+j6+oMqw2A
         Seit9afdoH5M06c2qllY+5Gf1sZ6T6h5S/sz9L3BIKKP4A29VoD3IG92Z4ReFllEwQUF
         +ggIpIZ4DtkuhsF4W0Q7BdPxN9siwg6jlpNqzh7RwgAgWlV74a5cRa8RQDrWKjbeAAWZ
         CB81pugVgj8/M7iOtD6uIPVH3KgBOraJBslIYytEsXhAlkOwByk1X2m01v/Ozz3Uu17s
         ZX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702667382; x=1703272182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWbxY3Q+EoYq5mueLiLO42QJaTQBT+r4FmqbmlCjarw=;
        b=TgiP46+sgvEFao6OYATxQwfA+y4TJlwXXzjShGEgnPlF1Ul+F9rR6zzaegXsdpNNig
         PU3/twK6KTu7L3/7DCqrF81Qc1D1md/D1qvGC0Xfy6q336ZfI4SdHVgGjC3jRP8m/Cg5
         Ys51swEYE/z5uW6OqZk81nLj7W93pUmbm4Y2wpbs95+QPRNhRV9O/QcG5PN6NC1FjGnK
         B4ZkxNzIjyfyEsFQEwwahsHdiiKaV7aPOngAGGttGPndBFmGJ/x0Ot2HHmTDgWvnydV8
         kq46OhsjAF/7lY/tUf3jE+xESRK85QW2lf6k6i6T2gSp6rnC4zVT4tlJVWb1nAsin+4U
         vCjA==
X-Gm-Message-State: AOJu0YxJLOXjGKC+HK9iZ8vMx6g8GMK4cb6RjxVU17ucrntFENEH6gy/
	H5ZpIktrieQvuCPI6f28LnSD2qi6An75NU03C/k=
X-Google-Smtp-Source: AGHT+IGRu4Yn+bj/EYigKT4CfJMHoTJnMispB2cjumjYp7+2ke+qfRMcDdJG/cL79FzU5aowwE2g1m0EgVLQmvaKh6M=
X-Received: by 2002:a05:6214:1023:b0:67a:bce4:e2e3 with SMTP id
 k3-20020a056214102300b0067abce4e2e3mr10532467qvr.5.1702667382352; Fri, 15 Dec
 2023 11:09:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214-libstringheader-v2-0-0f195dcff204@google.com>
 <20231214-libstringheader-v2-1-0f195dcff204@google.com> <ZXx5DyidpHFhRevy@smile.fi.intel.com>
 <CAE-cH4p5VJ_A91BAkURBN67ACA0_u7T8UhApUYLQDWeeRY6FWA@mail.gmail.com>
In-Reply-To: <CAE-cH4p5VJ_A91BAkURBN67ACA0_u7T8UhApUYLQDWeeRY6FWA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 15 Dec 2023 21:09:05 +0200
Message-ID: <CAHp75Vdo=g7ZBAuk79PtLOYs-YHo5sCTp1WVFESHA0xN0zGEmQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sh: Added kernel.h to word-at-a-time
To: Tanzir Hasan <tanzirh@google.com>
Cc: Andy Shevchenko <andy@kernel.org>, Kees Cook <keescook@chromium.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nick DeSaulniers <nnn@google.com>, Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 8:31=E2=80=AFPM Tanzir Hasan <tanzirh@google.com> w=
rote:
> On Fri, Dec 15, 2023 at 8:04=E2=80=AFAM Andy Shevchenko <andy@kernel.org>=
 wrote:
>> On Thu, Dec 14, 2023 at 09:06:12PM +0000, tanzirh@google.com wrote:

...

>> > +#include <linux/kernel.h>
>>
>> I highly discourage from doing that. Instead, split what is needed to
>> the separate (new) header and include that one.
>
>
> I think it would make the most sense to do this in a separate patch.
> What word-at-a-time.h needs from kernel.h is REPEAT_BYTE and to my knowle=
dge,
> almost every other version of word-at-a-time.h includes kernel.h gets thi=
s by
> including kernel.h. A future change could be removing REPEAT_BYTE
> out of kernel.h

Just create a patch that either moves that macro (along with upper_*()
and lower_*() APIs) to a more distinguishable header
(maybe bytes.h or words.h or wordpart.h, etc) and use it in your case
and fix others.

--=20
With Best Regards,
Andy Shevchenko

