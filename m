Return-Path: <linux-kernel+bounces-4105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFA08177FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BC01F22BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690254FF68;
	Mon, 18 Dec 2023 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YqkW/uJa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95742392
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3365e85a4easo1986904f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702918691; x=1703523491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+zh+2q3MwXuVdLRjXTJZI4JkIaqitTixEyhaPMNfTc=;
        b=YqkW/uJaHkOZdMfcdlmgvRNQgzJIKSeZx9AHqDX4tW6XnJxt3fnoJ8pU64DoDFBFun
         1tQZBB2nyFmjQIuAPa4U+O96YTF6F6l9MjVZNDM1xfoOXT2FSLifG8R0dD7b/UtiNmv/
         rTVPjMfpD94H0JfuGXKRY8En08HeheOXVYQaL4NjatcIrwI/MyrwBNObYW/1AvHVvovO
         y4Nu/vxk/ozCDeYaF8owD1NAhljq0P8lSyuY9F+7RTL+ydenHghs11b6FnECURgEYmIa
         9n/ZvBj9pT3g0m0g1SQFNAVmbZQI438uyJ9106BMekE5+ThWlXqd+5bu59wwIcWoWpl5
         m6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702918691; x=1703523491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+zh+2q3MwXuVdLRjXTJZI4JkIaqitTixEyhaPMNfTc=;
        b=ESHSU61R3dBdPxR6Raw7ZarlFV05niIZQaUfTNQclkqCOeumm7A+vMSerQ/de0KjTC
         67BlY94xrhkI+uRAwaX2ttvdbfA/8FdglkmKWtZTO55Q2jfZJSVlPWb30P7tqdLWnPFs
         2yN2f6wbp37LlYRmGvbkGcHET6vCczCgNK7TUYrB/TajQ8HEnQ9an5S/3/P/mR/cTPC+
         w0NiibkGncxn9KkAu3NHk+g2/dWZzD8hMltVU7aGOk9A5FGlu0cuwso73pU0Z5GS4Sr8
         bRAgVR6utU9+pNLGmbLTm7mTp3tU5MXv1JYC+ck6WBVHWqD6ww7RfUWcoIcyv+VhtvPd
         Xs1Q==
X-Gm-Message-State: AOJu0YwwWf5dA4eWbYt6MN9Wrr+aBHVJfPE7tLJh1GL3fZNf1a92TtHC
	JuftTHu6ETcigVyc/dYMzwpX/Pg0/GMZ+m+3n/8fzQ==
X-Google-Smtp-Source: AGHT+IFChuEHlZwlMDTWLGHUh6HXy10BpvXeAadBWV8pWnZyYA1TdhfpH2w2v0z8e/FNeEuXgwglDmYDNbTy1g+Wmz0=
X-Received: by 2002:a05:6000:cd1:b0:332:e2b0:c217 with SMTP id
 dq17-20020a0560000cd100b00332e2b0c217mr8371467wrb.62.1702918691137; Mon, 18
 Dec 2023 08:58:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214-libstringheader-v2-0-0f195dcff204@google.com>
 <20231214-libstringheader-v2-1-0f195dcff204@google.com> <ZXx5DyidpHFhRevy@smile.fi.intel.com>
 <CAE-cH4p5VJ_A91BAkURBN67ACA0_u7T8UhApUYLQDWeeRY6FWA@mail.gmail.com> <CAHp75Vdo=g7ZBAuk79PtLOYs-YHo5sCTp1WVFESHA0xN0zGEmQ@mail.gmail.com>
In-Reply-To: <CAHp75Vdo=g7ZBAuk79PtLOYs-YHo5sCTp1WVFESHA0xN0zGEmQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 18 Dec 2023 08:57:59 -0800
Message-ID: <CAKwvOdmMqJacYRfwohY-DXBbmNmz_M4EKUL1KuTv=tT2dO_p1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sh: Added kernel.h to word-at-a-time
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Tanzir Hasan <tanzirh@google.com>, Andy Shevchenko <andy@kernel.org>, 
	Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 11:09=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Dec 15, 2023 at 8:31=E2=80=AFPM Tanzir Hasan <tanzirh@google.com>=
 wrote:
> > On Fri, Dec 15, 2023 at 8:04=E2=80=AFAM Andy Shevchenko <andy@kernel.or=
g> wrote:
> >> On Thu, Dec 14, 2023 at 09:06:12PM +0000, tanzirh@google.com wrote:
>
> ...
>
> >> > +#include <linux/kernel.h>
> >>
> >> I highly discourage from doing that. Instead, split what is needed to
> >> the separate (new) header and include that one.
> >
> >
> > I think it would make the most sense to do this in a separate patch.
> > What word-at-a-time.h needs from kernel.h is REPEAT_BYTE and to my know=
ledge,
> > almost every other version of word-at-a-time.h includes kernel.h gets t=
his by
> > including kernel.h. A future change could be removing REPEAT_BYTE
> > out of kernel.h
>
> Just create a patch that either moves that macro (along with upper_*()
> and lower_*() APIs) to a more distinguishable header
> (maybe bytes.h or words.h or wordpart.h, etc) and use it in your case
> and fix others.

Andy,
These are good suggestions and we should do them...

...and Tanzir only has 3 weeks left of his internship.  I don't want
him to get bogged down chasing build regressions from modifying the
headers themselves.  I think what's best for him from here through the
remainder of his internship is to stay focused on applying suggestions
from IWYU to just modify the #include list of .c files, and not start
splitting .h files.  Splitting the .h files will be the next step, and
is made easier by having the codebase not have so many indirect
includes (via IWYU), but we need time to soak header changes, and time
Tanzir does not have.  Please can we keep the suggestions focused on
whether the modifications to the header includes (and the tangential
cleanups) are correct?

While REPEAT_BYTE has a manageable number of users, upper_* and
lower_* have significantly more; I worry about moving those causing
regressions.  We can move them, but such changes would need
significantly more soak time than this series IMO.  Tanzir is also
working on statistical analysis; I suspect if he analyzes
include/linux/kernel.h, he can comment on whether the usage of
REPEAT_BYTE is correlated with the usage of upper_* and lower_* in
order to inform whether they should be grouped together or not.
--=20
Thanks,
~Nick Desaulniers

