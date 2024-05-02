Return-Path: <linux-kernel+bounces-166247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B12C8B9803
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B411F24961
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAFB55E48;
	Thu,  2 May 2024 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB/Gdxgy"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353C339AC;
	Thu,  2 May 2024 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643173; cv=none; b=NifZDRxcQKvd8/ZmiDJq6l1ZsxgIBPvnJ/3lHVPAQgWeLvNR06hwcUpWcJTemgmAkMONXFUx5DB7dFjXgI+y3QIXVvm1bw9Ic7pGrKCtYHVIlhJx42+Z98Fh1p64pX8oHK637+nBiwu9MeRxDag7D8E5Hsgi33LyH9FmtFDQRTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643173; c=relaxed/simple;
	bh=HSCsS0VMbbwL27ifhnBpJsIh1itQ1kPGQcaJIdkB6W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9p7Npeo3IiklZ2pph8USTOxyt05bM6L65Wsk0rk7FAM5QbEaH4UaKZn5fvhvQ13akwZ5O23YMsXQ4Kx+d8mZn1Xir75P6HypSqgp+nzg9u1xulCC+jq4aHOvzTsMHDhdDCLWFnixXvU14sNrRAJKUuqWirNSmfpoqjenY8gaBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB/Gdxgy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a58fbbcd77aso531903766b.2;
        Thu, 02 May 2024 02:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714643170; x=1715247970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxlfYdWRqZamGcObQHKAKiiU621r7BisqkBpH82ZMAs=;
        b=iB/Gdxgy0zibCbzPSnoV8hh2bANeeyn01lpCEv008m7vON92yNqhScvbBPbT2cmzwG
         nPPQjuPEWGk7aGE3LSYgJlqC501fK7PCDdXiZOeMez1TdXwNk5bD+6AZLwuu1qjOvg0Q
         Ab4gg89vqydSV9lZwIw5Gw4+Ludl+6NLcS6D1nM39x6etNRQWl50ohHf3J57Sgeo5Eti
         YJNUmCCXuab10SfRKOiHfG5gercRVkzDAPcMuKQegTzImPICDqzeDZUtbhsNnxyimI04
         D8f968YKT3lkkvVBSJtwWA6qLchn75+hKs8T4jUKObC2kIhAkW4k6dPYGZWY/3yCfmfx
         8vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714643170; x=1715247970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxlfYdWRqZamGcObQHKAKiiU621r7BisqkBpH82ZMAs=;
        b=wT57wEpoEa2mzyTfOJgSPDjPEkV1GGChRXZiijVFUmnKO1P/eqalUTj3yO5Quw29Ml
         kZ99Jh+mVt9WjSRXwMas/yMvs/Jd6trNanAFDn6cW+oxXnlORZ6swrQxdOTGpM+KeyBN
         VhHVSLCwL9Cv0VN7Shh1Yew/lE5f+0SbYDGyBp9lmwy4F3uSn5ky5iGiBGxuE6ifm8tr
         KFLVIFS9P2fWHwtzYjxYnUX1lEbjjK/lZ72/LkMSo/1cyRaK7SChSOtKOjTblTyF4XfM
         Mt5dDCoLhxnJMqJqy2qbVZOF60RAcwj2/TOwRQJ3xVQNGwLtChhjNUKt5aJDgb2nAWlf
         0xBA==
X-Forwarded-Encrypted: i=1; AJvYcCUyDqcMm/JgMVITkio7en/xJv8dUm9zHVwFzHHkwxVXhbysJFwhoVOaVJIaANlau5Gc6Es17s3cEozFL2VJewdB3TssAjsKTZtn+6EgUTseFk+P51gvGKrdvnFbwi/nIF2tmDhyMnD3R6h0jCp3
X-Gm-Message-State: AOJu0YyDn7yf/vUrpIjKLaKYJRQbk/dcsJdjTh+fahZNPvc5+ujsaF4y
	SMUKUFBeaDCw7D/NB/Bf9+iYdTUSsRAiScrsEeFfd9pViQF9Pug85ikwPFuIHBs0j2yaEnl7FiQ
	9u3dmYreC0Dc9nvoS1Fn9ICmX7FY=
X-Google-Smtp-Source: AGHT+IELJFFDRHvAdU0T0fBQygM9rhQkwSaaa4pFbVfpv7LeH4ZiYXB1RWIKmphDo6wptfmEjvxjqcxxf2HD57HFikQ=
X-Received: by 2002:a17:906:d105:b0:a46:cef3:4aba with SMTP id
 b5-20020a170906d10500b00a46cef34abamr3315096ejz.75.1714643170161; Thu, 02 May
 2024 02:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501233201.work.732-kees@kernel.org>
In-Reply-To: <20240501233201.work.732-kees@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 2 May 2024 12:45:33 +0300
Message-ID: <CAHp75VetkKYhnOaoM880D+VTR96NscQfBGddgAwKz681Uk5ZJg@mail.gmail.com>
Subject: Re: [PATCH] string: Add additional __realloc_size() annotations for
 "dup" helpers
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 2:32=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> Several other "dup"-style interfaces could use the __realloc_size()
> attribute. (As a reminder to myself and others: "realloc" is used here
> instead of "alloc" because the "alloc_size" attribute implies that the
> memory contents are uninitialized. Since we're copying contents into the
> resulting allocation, it must use "realloc_size" to avoid confusing the
> compiler's optimization passes.)
>
> Add KUnit test coverage where possible. (KUnit still does not have the
> ability to manipulate userspace memory.)

Makes sense to me,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

..

> +               checker(len, kmemdup_array(test_phrases[idx], len, 1,   \
> +                                          gfp), kfree(p));             \

Despite being longer, I would put gfp on the previous line for the
sake of logical split (and additionally to be consistent with the
below).

> +               checker(len, kmemdup(test_phrases[idx], len, gfp),      \
> +                       kfree(p));                                      \

--=20
With Best Regards,
Andy Shevchenko

