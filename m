Return-Path: <linux-kernel+bounces-5949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D244E8191DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79CAA283077
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042263A1B5;
	Tue, 19 Dec 2023 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bIimDqd1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEBD3D0A5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso1045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703019826; x=1703624626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPrvLQ9nSKbJaWthUQcTRxDkRs0WKc5wjPuSEHtrSQU=;
        b=bIimDqd10RwEYvM9QoCk2rqaL3wQIdapP2ZHHCZE9cyCRns7JkyNRbTDibQMqm+xFj
         z/T/Z1LzfVz3Vfznjn93gWC36dujDyqhyri3yL68eVVYRVt5Iklg+9Xmf4A2az/KMr0Z
         vsL99WFj16MozYaSUAgGHuAV8fomq1tw4KP+M5qfOJJB5ZQOlojimn9xVgsJlzMil2yj
         +8CJ3xNd/Kb1b6cvlq4h0kd/rg2fZutXgQcCUl1x7iTl30FFT51D9GQMGG+UK1ho1bFY
         cwH25KRLEXQljsnzGFlzZcTh7BjyILs3UBI40yP3BdtWoEsf+EbqvI2CfWSKr8MV4ige
         pYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703019826; x=1703624626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPrvLQ9nSKbJaWthUQcTRxDkRs0WKc5wjPuSEHtrSQU=;
        b=xFAXKdMDu5l2MDSXywoMAIORx9Jk6q4qsQ5uBtwkuh7pjwHr5N1zsDnDc3piVZgCI2
         zl/i5WY1VeLY160tXof7aunm4uGEbj8fEw18I/mrP1NwHYQgITh2/gHV8HDFK8xJ5TaQ
         xBDnjRmUKIVcb41Xryaod8XsgopYryGr7aXZofjWs3PEfJuEu2Uhxxat2uPuB8iLz74W
         zvFs6VlOrSNCJ4Oqz6zHVS7vY3bRVLSP8ybwWmJsp/RJoZpto2zmoU/Lq4DwJhMR4O6j
         vZ6mke4CL4Ez9Mck24r0cVnRddMbPX3Aa/EHXtxnplav+9egPAD5SlBf5imriXAVD0B3
         AbBQ==
X-Gm-Message-State: AOJu0Yzsk8uCcmkI2+AEls65yndcdxZMWej6IQ/oQeODQ/2jq3L+mo5K
	SinvRpWFAFcf4l4vR7usWxMLTeMxljDjusyP7YjWhosdeYSs
X-Google-Smtp-Source: AGHT+IHtD2MzC0bAMHU9JfIRyz/yKwwNR6wfMtooBCTEUtmv9pzbQuKVvvdK8AUOCzhz/wGTTVopE1cFAEdvXzDJTJs=
X-Received: by 2002:a7b:c8c6:0:b0:40b:5972:f56b with SMTP id
 f6-20020a7bc8c6000000b0040b5972f56bmr6502wml.3.1703019825979; Tue, 19 Dec
 2023 13:03:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218151729.210027-1-rf@opensource.cirrus.com>
In-Reply-To: <20231218151729.210027-1-rf@opensource.cirrus.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 19 Dec 2023 16:03:34 -0500
Message-ID: <CA+GJov5MrgGO1bo8Zr=_E8h4beB7mkZdpODc=i_m7o5Sff6iLQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix NULL-dereference in kunit_init_suite() if
 suite->log is NULL
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 10:17=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> suite->log must be checked for NULL before passing it to
> string_stream_clear(). This was done in kunit_init_test() but was missing
> from kunit_init_suite().
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: 6d696c4695c5 ("kunit: add ability to run tests after boot using de=
bugfs")

Hello!

This looks good! Thanks! Sorry I did not catch this earlier.

Reviewed-by: Rae Moar <rmoar@google.com>

-Rae

> ---
>  lib/kunit/test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index e803d998e855..ea7f0913e55a 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -658,7 +658,9 @@ static void kunit_init_suite(struct kunit_suite *suit=
e)
>         kunit_debugfs_create_suite(suite);
>         suite->status_comment[0] =3D '\0';
>         suite->suite_init_err =3D 0;
> -       string_stream_clear(suite->log);
> +
> +       if (suite->log)
> +               string_stream_clear(suite->log);
>  }
>
>  bool kunit_enabled(void)
> --
> 2.30.2
>

